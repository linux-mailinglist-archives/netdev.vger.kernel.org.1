Return-Path: <netdev+bounces-119321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA7D95525D
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 23:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FD601C23648
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 21:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F21B1C68AB;
	Fri, 16 Aug 2024 21:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="AJkTP7yp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6F41C4635
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723843757; cv=none; b=VhXHnzXBPoQ0MsA+l5wS9V0GgU+gx+SwVXaflXl9LvrdbS4ltaP/gZEdEsZqz/EQ1h7SaDoHg3lH/dvzlGnLbFaUWEb4oBXLkK/2uQcockYrecWC235QvGxZ5EOhWl4P+DJtZ3dbsGZwA5J7BlOHbn74HE8zsTnsOc09fGW2P48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723843757; c=relaxed/simple;
	bh=7JU+C2nHXIPqBUyDit0UAkvIFFzzRONrcFntu+mQWZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rSpz1zNx3mInRB8+jhmKBGfgrFTrTrnoDC9p9Weph5onNq8BIQJM45GnyWlOUeIl4qQg1bZuDZKcc/f+baPes3IggARjoDEyl9bEUtsAzDCBqCYDRNN809QgbrbH0/hDLOS/ezCbn9AxkycZwpVLwJFdMYwkwbVDIw5+sqZrKtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=AJkTP7yp; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7093abb12edso1741934a34.3
        for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 14:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1723843752; x=1724448552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aK2V/GEhL2UJaDYEeRsE1/r/nEBhY5fhK5WxIZZVrqw=;
        b=AJkTP7ypSpgQiZHqjaYX1HUP4S5Bf3F2cF5WSJCVoYRZ9cPz0UWSiNKR+F5kUg8zpL
         2dxXV5+x5YX3PEGvAUnOFJVzV5L2a4gomhj0b/wFVZ418zOgOFywVqiWXDi8Lti3hnRw
         zM4V26tiSx8MIEI/YtYoM4BtomCN65YfJvV9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723843752; x=1724448552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aK2V/GEhL2UJaDYEeRsE1/r/nEBhY5fhK5WxIZZVrqw=;
        b=HIRH9L0SfEZWouTpNEBQKkqZmeDBwWgvtLbOueUf8CYp0kdaULQJf2gn+RtKAp+ygA
         zZM3BGAqJzDGxXjJSSg5cxI/c9WGtdgWgt4667+X+YZd5tD8ik17kwbxTR4CuQNw6tpI
         Fn6jjRDIhAcQdrnSWBiRA3FFQA1M0tNoJrT9mhjRoQCTiD2gp+elkM1FaJLinHmDQuZR
         gDi9udOus9nIv8usc/pY2++Ctpx1EQx03402kz33FsB9Cgvgu83w3T8hs7VzEhk1hx9f
         2/AfsEsEXWL0WO4BYo4MZnnRyoXiWyscLIsw8mOuPxTwJ14eKgNxxsBA86M5273cxbfi
         utMg==
X-Gm-Message-State: AOJu0YxoN2j9+y/5ymNrf6X/SZv/3vb3cH3nqvVRrDJXfnDWYdb1zbtM
	MN5Jx/RgpnMvMxu3u5eh0jjFOjMYtX1OK+427ElwC/jA2NRWx1tTVukQPmf4Gw==
X-Google-Smtp-Source: AGHT+IGrS233rAo/tjkWxvzAX09WSwojWRuvfdZlWeaeSoXIZYU84KFGOnc3WhbZBTgaL1arvQNc2g==
X-Received: by 2002:a05:6830:6e85:b0:703:5ccb:85f3 with SMTP id 46e09a7af769-70cac8b1dadmr4461170a34.22.1723843751630;
        Fri, 16 Aug 2024 14:29:11 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-45369fd72aasm20752221cf.9.2024.08.16.14.29.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Aug 2024 14:29:11 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	horms@kernel.org,
	helgaas@kernel.org,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: [PATCH net-next v2 3/9] bnxt_en: Support QOS and TPID settings for the SRIOV VLAN
Date: Fri, 16 Aug 2024 14:28:26 -0700
Message-ID: <20240816212832.185379-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240816212832.185379-1-michael.chan@broadcom.com>
References: <20240816212832.185379-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sreekanth Reddy <sreekanth.reddy@broadcom.com>

With recent changes in the .ndo_set_vf_*() guidelines, resubmitting
this patch that was reverted eariler in 2023:

c27153682eac ("Revert "bnxt_en: Support QOS and TPID settings for the SRIOV VLAN")

Add these missing settings in the .ndo_set_vf_vlan() method.
Older firmware does not support the TPID setting so check for
proper support.

Remove the unused BNXT_VF_QOS flag.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 -
 .../net/ethernet/broadcom/bnxt/bnxt_sriov.c   | 24 ++++++++++---------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 017eefd78ba4..149ec5bda477 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9198,6 +9198,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_HOT_RESET_IF;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_FW_LIVEPATCH_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_LIVEPATCH;
+	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_DFLT_VLAN_TPID_PCP_SUPPORTED))
+		bp->fw_cap |= BNXT_FW_CAP_DFLT_VLAN_TPID_PCP;
 	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_BS_V2_SUPPORTED)
 		bp->fw_cap |= BNXT_FW_CAP_BACKING_STORE_V2;
 	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_TX_COAL_CMPL_CAP)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 2fa6572b6b1d..aa2eb78a8763 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -1356,7 +1356,6 @@ struct bnxt_vf_info {
 	u16	vlan;
 	u16	func_qcfg_flags;
 	u32	flags;
-#define BNXT_VF_QOS		0x1
 #define BNXT_VF_SPOOFCHK	0x2
 #define BNXT_VF_LINK_FORCED	0x4
 #define BNXT_VF_LINK_UP		0x8
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
index 22898d3d088b..58bd84b59f0e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_sriov.c
@@ -15,6 +15,7 @@
 #include <linux/if_vlan.h>
 #include <linux/interrupt.h>
 #include <linux/etherdevice.h>
+#include <net/dcbnl.h>
 #include "bnxt_hsi.h"
 #include "bnxt.h"
 #include "bnxt_hwrm.h"
@@ -196,11 +197,8 @@ int bnxt_get_vf_config(struct net_device *dev, int vf_id,
 		memcpy(&ivi->mac, vf->vf_mac_addr, ETH_ALEN);
 	ivi->max_tx_rate = vf->max_tx_rate;
 	ivi->min_tx_rate = vf->min_tx_rate;
-	ivi->vlan = vf->vlan;
-	if (vf->flags & BNXT_VF_QOS)
-		ivi->qos = vf->vlan >> VLAN_PRIO_SHIFT;
-	else
-		ivi->qos = 0;
+	ivi->vlan = vf->vlan & VLAN_VID_MASK;
+	ivi->qos = vf->vlan >> VLAN_PRIO_SHIFT;
 	ivi->spoofchk = !!(vf->flags & BNXT_VF_SPOOFCHK);
 	ivi->trusted = bnxt_is_trusted_vf(bp, vf);
 	if (!(vf->flags & BNXT_VF_LINK_FORCED))
@@ -256,21 +254,21 @@ int bnxt_set_vf_vlan(struct net_device *dev, int vf_id, u16 vlan_id, u8 qos,
 	if (bp->hwrm_spec_code < 0x10201)
 		return -ENOTSUPP;
 
-	if (vlan_proto != htons(ETH_P_8021Q))
+	if (vlan_proto != htons(ETH_P_8021Q) &&
+	    (vlan_proto != htons(ETH_P_8021AD) ||
+	     !(bp->fw_cap & BNXT_FW_CAP_DFLT_VLAN_TPID_PCP)))
 		return -EPROTONOSUPPORT;
 
 	rc = bnxt_vf_ndo_prep(bp, vf_id);
 	if (rc)
 		return rc;
 
-	/* TODO: needed to implement proper handling of user priority,
-	 * currently fail the command if there is valid priority
-	 */
-	if (vlan_id > 4095 || qos)
+	if (vlan_id >= VLAN_N_VID || qos >= IEEE_8021Q_MAX_PRIORITIES ||
+	    (!vlan_id && qos))
 		return -EINVAL;
 
 	vf = &bp->pf.vf[vf_id];
-	vlan_tag = vlan_id;
+	vlan_tag = vlan_id | (u16)qos << VLAN_PRIO_SHIFT;
 	if (vlan_tag == vf->vlan)
 		return 0;
 
@@ -279,6 +277,10 @@ int bnxt_set_vf_vlan(struct net_device *dev, int vf_id, u16 vlan_id, u8 qos,
 		req->fid = cpu_to_le16(vf->fw_fid);
 		req->dflt_vlan = cpu_to_le16(vlan_tag);
 		req->enables = cpu_to_le32(FUNC_CFG_REQ_ENABLES_DFLT_VLAN);
+		if (bp->fw_cap & BNXT_FW_CAP_DFLT_VLAN_TPID_PCP) {
+			req->enables |= cpu_to_le32(FUNC_CFG_REQ_ENABLES_TPID);
+			req->tpid = vlan_proto;
+		}
 		rc = hwrm_req_send(bp, req);
 		if (!rc)
 			vf->vlan = vlan_tag;
-- 
2.30.1


