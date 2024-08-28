Return-Path: <netdev+bounces-122889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF92B963010
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 20:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C95E91C2139D
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 18:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAC31A76C7;
	Wed, 28 Aug 2024 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="emTqnI6c"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CE31AAE27
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 18:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724869985; cv=none; b=lQXnOagp+mwiZjKwg+B1Z8AfCsH3Dby8Mt1I/NNmkMliWtLHATFrS2xbdjdllR65xd8GevfBh7mSoeonHH3GsOe6nDPuZ/PBJaSQdujjsZx27Lm8X1U15hbc3CTwovoPIBVm1oY/5CPlZ+Lm1iP8cCImbbQd5FBlBLT0XA8SaMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724869985; c=relaxed/simple;
	bh=Rp1+8VlUlh/Lb16JEZft1iICqKNnRsNpqTLjxywUjGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDcC7nPd5NIXvaBxQCmG++dmxCkGThvDrVUaC6vbIwdCRBphnaUAsrQfNIWp+oM+A2bxN5VS2/niO4ibJy1AOWNjlBxGp6KBQ3/B0So1YeQlMSMrYBuLntptEqiKV9SGhvvIfGFYb5FVb41CX4iR/6qGNDN2LewY1fug8+G+uvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=emTqnI6c; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6bf7ec5c837so35806466d6.1
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 11:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724869982; x=1725474782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epLaBEyvQjUoXaa0Uj7itTI7QXW9p1kALohHY6dbCjo=;
        b=emTqnI6csFCjdp78CoGXmFHa8w02eYrZhfTon/5lYT1jhIF6kMgE+YU2ywslt+mICZ
         z1whKZ7IVcGEy9GCj3A1o8WyGLVEYREowbGYVK53SqSozG4+nroELUgKonY9KUdWkACV
         1uL8bgn4ByiYWUzztiPstX5APJOYr7NKHP+ZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724869982; x=1725474782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epLaBEyvQjUoXaa0Uj7itTI7QXW9p1kALohHY6dbCjo=;
        b=ZkZaPb8nVrl14dDo7tslUm6uFHNq7DFw4TS8hKxmNGzQm3zWs6IN1qdKZctFth99FT
         qWPlyWVvPtfvs1yLbp7aWufZmcMZ+vB4HjVD3qiMdtdCYTXrvRNxHhpRDjhuZE8VUGJ7
         NQWqdE5ul031mlD1LKGNi30QaO9V87UtbZxA1iDHuVYfHbGLnkX2J9RWF3l2U97/S3Cl
         UE8l5jaalsVX7qW1fvCamBs6g8O6cRKXA3fsDIgalSLVfVxPfxEMa3Ug5mIYFnXO60Af
         rWeqKwWwABxFVKdfaeNE6wkk+y/ktRYHnmQUBb+C6zyeRtSLty+KAHWdsuzuY4JbhPOD
         kwyA==
X-Gm-Message-State: AOJu0YzIOjAmnoP0A/wghqaiaQStjxVC6QGdCL8FEW7EhVddrG6hyK27
	+MdLPxb+YBcZ6E6S1QBQJOHMY+wxOmIjzPdBbuiPa8m+eH6wS+vkdBelrkGq/Q==
X-Google-Smtp-Source: AGHT+IHA7yXDzbozez07F6A9DbBfPmfcIZTYCfMgJQjX0GvO/68BBnp0M1xyARoaQQQStyAiaMohaQ==
X-Received: by 2002:a0c:f413:0:b0:6c1:75de:b9bd with SMTP id 6a1803df08f44-6c33e6a73dbmr4393646d6.54.1724869982216;
        Wed, 28 Aug 2024 11:33:02 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c162d4c36esm68126866d6.43.2024.08.28.11.33.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Aug 2024 11:33:01 -0700 (PDT)
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
	przemyslaw.kitszel@intel.com,
	Sreekanth Reddy <sreekanth.reddy@broadcom.com>
Subject: [PATCH net-next v4 3/9] bnxt_en: Support QOS and TPID settings for the SRIOV VLAN
Date: Wed, 28 Aug 2024 11:32:29 -0700
Message-ID: <20240828183235.128948-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240828183235.128948-1-michael.chan@broadcom.com>
References: <20240828183235.128948-1-michael.chan@broadcom.com>
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
index 671dc598324a..b236a76c0188 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -9196,6 +9196,8 @@ static int __bnxt_hwrm_func_qcaps(struct bnxt *bp)
 		bp->fw_cap |= BNXT_FW_CAP_HOT_RESET_IF;
 	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_FW_LIVEPATCH_SUPPORTED))
 		bp->fw_cap |= BNXT_FW_CAP_LIVEPATCH;
+	if (BNXT_PF(bp) && (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_DFLT_VLAN_TPID_PCP_SUPPORTED))
+		bp->fw_cap |= BNXT_FW_CAP_DFLT_VLAN_TPID_PCP;
 	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_BS_V2_SUPPORTED)
 		bp->fw_cap |= BNXT_FW_CAP_BACKING_STORE_V2;
 	if (flags_ext & FUNC_QCAPS_RESP_FLAGS_EXT_TX_COAL_CMPL_CAP)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index e7dcb59c3cdd..da6fad403f52 100644
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


