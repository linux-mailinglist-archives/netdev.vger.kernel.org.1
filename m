Return-Path: <netdev+bounces-40543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD677C79E5
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 00:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7541C20F88
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 22:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF413D00E;
	Thu, 12 Oct 2023 22:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8roKIEN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC8A2B5CB
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 22:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF50C433C8;
	Thu, 12 Oct 2023 22:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697150466;
	bh=mN3asuT65EQd37dkUgtbb8Qjwn9fhm/yCXEtI4+HlUo=;
	h=From:To:Cc:Subject:Date:From;
	b=S8roKIENEbqxGr6RIK+wPlobuhY7qq2NyclslLIacbNYoQp8s2DRCi9Q0h3EqTgzy
	 3Gx79jU5GVFbZTyt2ijn1MBoZUnlO/Ykb+cMFfom4o9tsWC6dEZPMpsYfC5j4kg5Dh
	 qEOOfx+UFQHg/n1MVOXPYR+Wc+wVG8wirhuQmafKprPHH7MyRVlMHM2uY/SRhL+KL0
	 4h6eEzMDTXRt00MtmQm1n9TS1gVtI2iOuFYOt3fkdjH/BJmMrc4NezPW/eRRWMUB+K
	 bE9Tb1Y2/HRFrz2qNwPu2nPtZaKhlBmK3kmqzUcMUVUZHF7+askyCvgIWoQSUEEuGq
	 X7cTsrdPetv9A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	michael.chan@broadcom.com
Subject: [PATCH net-next] eth: bnxt: fix backward compatibility with older devices
Date: Thu, 12 Oct 2023 15:41:01 -0700
Message-ID: <20231012224101.950208-1-kuba@kernel.org>
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

Once probe is fixed other error pop up:

   bnxt_en ...: Failed to set async event completion ring.

This is because __hwrm_send() rejects requests larger than
bp->hwrm_max_ext_req_len with -E2BIG. Since the driver doesn't
actually access any of the new fields, yet, trim the length.
It should be safe.

Similar workaround exists for backing_store_cfg_input,
although that one mins() to a constant of 256?!

To make debugging easier in the future add a warning
for oversized requests.

Fixes: 754fbf604ff6 ("bnxt_en: Update firmware interface to 1.10.2.171")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: michael.chan@broadcom.com
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 21 +++++++++++++++----
 .../net/ethernet/broadcom/bnxt/bnxt_hwrm.c    |  2 ++
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 5c2afcd5ce80..10dc680f022e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5855,6 +5855,19 @@ static int hwrm_ring_alloc_send_msg(struct bnxt *bp,
 	return rc;
 }
 
+/* Older devices can only support req length of 128.
+ * Requests which don't need fields starting at num_quic_tx_key_ctxs
+ * can use this helper to avoid getting -E2BIG.
+ */
+static int bnxt_hwrm_func_cfg_short_req_init(struct bnxt *bp,
+					     struct hwrm_func_cfg_input **req)
+{
+	u32 req_len;
+
+	req_len = min_t(u32, sizeof(**req), bp->hwrm_max_ext_req_len);
+	return __hwrm_req_init(bp, (void **)req, HWRM_FUNC_CFG, req_len);
+}
+
 static int bnxt_hwrm_set_async_event_cr(struct bnxt *bp, int idx)
 {
 	int rc;
@@ -5862,7 +5875,7 @@ static int bnxt_hwrm_set_async_event_cr(struct bnxt *bp, int idx)
 	if (BNXT_PF(bp)) {
 		struct hwrm_func_cfg_input *req;
 
-		rc = hwrm_req_init(bp, req, HWRM_FUNC_CFG);
+		rc = bnxt_hwrm_func_cfg_short_req_init(bp, &req);
 		if (rc)
 			return rc;
 
@@ -6273,7 +6286,7 @@ __bnxt_hwrm_reserve_pf_rings(struct bnxt *bp, int tx_rings, int rx_rings,
 	struct hwrm_func_cfg_input *req;
 	u32 enables = 0;
 
-	if (hwrm_req_init(bp, req, HWRM_FUNC_CFG))
+	if (bnxt_hwrm_func_cfg_short_req_init(bp, &req))
 		return NULL;
 
 	req->fid = cpu_to_le16(0xffff);
@@ -8618,7 +8631,7 @@ static int bnxt_hwrm_set_br_mode(struct bnxt *bp, u16 br_mode)
 	else
 		return -EINVAL;
 
-	rc = hwrm_req_init(bp, req, HWRM_FUNC_CFG);
+	rc = bnxt_hwrm_func_cfg_short_req_init(bp, &req);
 	if (rc)
 		return rc;
 
@@ -8636,7 +8649,7 @@ static int bnxt_hwrm_set_cache_line_size(struct bnxt *bp, int size)
 	if (BNXT_VF(bp) || bp->hwrm_spec_code < 0x10803)
 		return 0;
 
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
-- 
2.41.0


