Return-Path: <netdev+bounces-41473-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1931D7CB129
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 452991C209A0
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4A63158E;
	Mon, 16 Oct 2023 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxScW9HN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8130FB9
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 17:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68538C433C7;
	Mon, 16 Oct 2023 17:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697476603;
	bh=TfOMJ0jH4DqBU466LQXH2UItdLQlTXzJ4UQB8WKWRr8=;
	h=From:To:Cc:Subject:Date:From;
	b=HxScW9HNp1WD7tZJcpIH4d6NJtr4qQ63KApDYCCBXfxkzszt7MkFY0bEJ4pRB94OS
	 EVOWbHRb/DmijmZGi80oSGntx6nSVcnrn5km11dVimiPIjbGiznvAT35DOsk4pwl4M
	 Mc+EJ+dtV/i7VsNjnwJvpG7yfmkeLorX+jkpfkwaSvh3U3PPWnCEIVg3BoQqVWPnav
	 X3T4eJ+QN10vbS2RxB1dGAmRfHlQW+mobmEahVPbmJ3DP8aj5uO3O+myjwj63GvDoU
	 mN692Fix4UR+ufcBgYFnhvnqVB4b1F1G+gE0F2LT/CEoROlwPmxYvyfkC6QRgQ5AFq
	 C+0H240ZTmUog==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	michael.chan@broadcom.com
Subject: [PATCH net-next v2] eth: bnxt: fix backward compatibility with older devices
Date: Mon, 16 Oct 2023 10:16:40 -0700
Message-ID: <20231016171640.1481493-1-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent FW interface update bumped the size of struct hwrm_func_cfg_input
above 128B which is the max some devices support.

Probe on Stratus (BCM957452) with FW 20.8.3.11 fails with:

   bnxt_en ...: Unable to reserve tx rings
   bnxt_en ...: 2nd rings reservation failed.
   bnxt_en ...: Not enough rings available.

Once probe is fixed other errors pop up:

   bnxt_en ...: Failed to set async event completion ring.

This is because __hwrm_send() rejects requests larger than
bp->hwrm_max_ext_req_len with -E2BIG. Since the driver doesn't
actually access any of the new fields, yet, trim the length.
It should be safe.

Similar workaround exists for backing_store_cfg_input.
Although that one mins() to a constant of 256, not 128
we'll effectively use here. Michael explains: "the backing
store cfg command is supported by relatively newer firmware
that will accept 256 bytes at least."

To make debugging easier in the future add a warning
for oversized requests.

Fixes: 754fbf604ff6 ("bnxt_en: Update firmware interface to 1.10.2.171")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fix the request in all driver files
v1: https://lore.kernel.org/all/20231012224101.950208-1-kuba@kernel.org/
CC: michael.chan@broadcom.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  8 ++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c    |  2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h    | 14 ++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c   | 14 +++++++-------
 5 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index b0ca3b319e4f..16eb7a7af970 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5861,7 +5861,7 @@ static int bnxt_hwrm_set_async_event_cr(struct bnxt *bp, int idx)
 	if (BNXT_PF(bp)) {
 		struct hwrm_func_cfg_input *req;
 
-		rc = hwrm_req_init(bp, req, HWRM_FUNC_CFG);
+		rc = bnxt_hwrm_func_cfg_short_req_init(bp, &req);
 		if (rc)
 			return rc;
 
@@ -6272,7 +6272,7 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 	struct hwrm_func_cfg_input *req;
 	u32 enables = 0;
 
-	if (hwrm_req_init(bp, req, HWRM_FUNC_CFG))
+	if (bnxt_hwrm_func_cfg_short_req_init(bp, &req))
 		return NULL;
 
 	req->fid = cpu_to_le16(0xffff);
@@ -8617,7 +8617,7 @@ static int bnxt_hwrm_set_br_mode(struct bnxt *bp, u16 br_mode)
 	else
 		return -EINVAL;
 
-	rc = hwrm_req_init(bp, req, HWRM_FUNC_CFG);
+	rc = bnxt_hwrm_func_cfg_short_req_init(bp, &req);
 	if (rc)
 		return rc;
 
@@ -8635,7 +8635,7 @@ static int bnxt_hwrm_set_cache_line_size(struct bnxt *bp, int size)
 	if (BNXT_VF(bp) || bp->hwrm_spec_code < 0x10803)
 		return 0;
 
-	rc = hwrm_req_init(bp, req, HWRM_FUNC_CFG);
+	rc = bnxt_hwrm_func_cfg_short_req_init(bp, &req);
 	if (rc)
 		return rc;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
index 8b3e7697390f..c3beadc1205b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_devlink.c
@@ -62,7 +62,7 @@ static int bnxt_hwrm_remote_dev_reset_set(struct bnxt *bp, bool remote_reset)
 	if (~bp->fw_cap & BNXT_FW_CAP_HOT_RESET_IF)
 		return -EOPNOTSUPP;
 
-	rc = hwrm_req_init(bp, req, HWRM_FUNC_CFG);
+	rc = bnxt_hwrm_func_cfg_short_req_init(bp, &req);
 	if (rc)
 		return rc;
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
index 132442f16fe6..1df3d56cc4b5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.c
@@ -485,6 +485,8 @@ static int __hwrm_send(struct bnxt *bp, struct bnxt_hwrm_ctx *ctx)
 
 	if (msg_len > BNXT_HWRM_MAX_REQ_LEN &&
 	    msg_len > bp->hwrm_max_ext_req_len) {
+		netdev_warn(bp->dev, "oversized hwrm request, req_type 0x%x",
+			    req_type);
 		rc = -E2BIG;
 		goto exit;
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h
index c98032e38188..15ca51b5d204 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_hwrm.h
@@ -137,4 +137,18 @@ int hwrm_req_send_silent(struct bnxt *bp, void *req);
 int hwrm_req_replace(struct bnxt *bp, void *req, void *new_req, u32 len);
 void hwrm_req_alloc_flags(struct bnxt *bp, void *req, gfp_t flags);
 void *hwrm_req_dma_slice(struct bnxt *bp, void *req, u32 size, dma_addr_t *dma);
+
+/* Older devices can only support req length of 128.
+ * HWRM_FUNC_CFG requests which don't need fields starting at
+ * num_quic_tx_key_ctxs can use this helper to avoid getting -E2BIG.
+ */
+static inline int
+bnxt_hwrm_func_cfg_short_req_init(struct bnxt *bp,
+				  struct hwrm_func_cfg_input **req)
+{
+	u32 req_len;
+
+	req_len = min_t(u32, sizeof(**req), bp->hwrm_max_ext_req_len);
+	return __hwrm_req_init(bp, (void **)req, HWRM_FUNC_CFG, req_len);
+}
 #endif
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 1f925d247244..c722b3b41730 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -95,7 +95,7 @@ int bnxt_set_vf_spoofchk(struct net_device *dev, int vf_id, bool setting)
 	/*TODO: if the driver supports VLAN filter on guest VLAN,
 	 * the spoof check should also include vlan anti-spoofing
 	 */
-	rc = hwrm_req_init(bp, req, HWRM_FUNC_CFG);
+	rc = bnxt_hwrm_func_cfg_short_req_init(bp, &req);
 	if (!rc) {
 		req->fid = cpu_to_le16(vf->fw_fid);
 		req->flags = cpu_to_le32(func_flags);
@@ -146,7 +146,7 @@ static int bnxt_hwrm_set_trusted_vf(struct bnxt *bp, struct bnxt_vf_info *vf)
 	if (!(bp->fw_cap & BNXT_FW_CAP_TRUSTED_VF))
 		return 0;
 
-	rc = hwrm_req_init(bp, req, HWRM_FUNC_CFG);
+	rc = bnxt_hwrm_func_cfg_short_req_init(bp, &req);
 	if (rc)
 		return rc;
 
@@ -232,7 +232,7 @@ int bnxt_set_vf_mac(struct net_device *dev, int vf_id, u8 *mac)
 	}
 	vf = &bp->pf.vf[vf_id];
 
-	rc = hwrm_req_init(bp, req, HWRM_FUNC_CFG);
+	rc = bnxt_hwrm_func_cfg_short_req_init(bp, &req);
 	if (rc)
 		return rc;
 
@@ -274,7 +274,7 @@ int bnxt_set_vf_vlan(struct net_device *dev, int vf_id, u16 vlan_id, u8 qos,
 	if (vlan_tag == vf->vlan)
 		return 0;
 
-	rc = hwrm_req_init(bp, req, HWRM_FUNC_CFG);
+	rc = bnxt_hwrm_func_cfg_short_req_init(bp, &req);
 	if (!rc) {
 		req->fid = cpu_to_le16(vf->fw_fid);
 		req->dflt_vlan = cpu_to_le16(vlan_tag);
@@ -314,7 +314,7 @@ int bnxt_set_vf_bw(struct net_device *dev, int vf_id, int min_tx_rate,
 	}
 	if (min_tx_rate == vf->min_tx_rate && max_tx_rate == vf->max_tx_rate)
 		return 0;
-	rc = hwrm_req_init(bp, req, HWRM_FUNC_CFG);
+	rc = bnxt_hwrm_func_cfg_short_req_init(bp, &req);
 	if (!rc) {
 		req->fid = cpu_to_le16(vf->fw_fid);
 		req->enables = cpu_to_le32(FUNC_CFG_REQ_ENABLES_MAX_BW |
@@ -491,7 +491,7 @@ static int __bnxt_set_vf_params(struct bnxt *bp, int vf_id)
 	struct bnxt_vf_info *vf;
 	int rc;
 
-	rc = hwrm_req_init(bp, req, HWRM_FUNC_CFG);
+	rc = bnxt_hwrm_func_cfg_short_req_init(bp, &req);
 	if (rc)
 		return rc;
 
@@ -653,7 +653,7 @@ static int bnxt_hwrm_func_cfg(struct bnxt *bp, int num_vfs)
 	u32 mtu, i;
 	int rc;
 
-	rc = hwrm_req_init(bp, req, HWRM_FUNC_CFG);
+	rc = bnxt_hwrm_func_cfg_short_req_init(bp, &req);
 	if (rc)
 		return rc;
 
-- 
2.41.0


