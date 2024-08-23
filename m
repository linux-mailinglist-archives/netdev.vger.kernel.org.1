Return-Path: <netdev+bounces-121491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E87E95D64A
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 21:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93C971C212D2
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 19:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CF6192B89;
	Fri, 23 Aug 2024 19:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="G2Hi1yOJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C3D192D70
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443071; cv=none; b=o9mmhJMRbUnJR5KEQk7Nst+6lseiu+uCWB1vqpplZ7r5RE0GhO+AQEk+Ha/c3WdaPQ+4+kjeOYx8NHXrh6ev0sTAmZdAlwK0sNIe1TnCt90Evvy0r5cXycFRBZZhFdkqRIRS0M4lNkwEJX/g1h7rmyeEyfh+UqSHFhfFgoxk9DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443071; c=relaxed/simple;
	bh=Rp1+8VlUlh/Lb16JEZft1iICqKNnRsNpqTLjxywUjGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/Z9GJBn+qATA5q7g5WgDmYT+MLy8SzegEskrM2PeiNS9Zhruce9+bwjWXvw37VgCIral5wbE/tHUI/e/mNuJdC5hB3LN8WZqJ3t+0XyOEY+he+6CgklRIP8He+BcB8ZtmX+WrYWCDFddCM9LUQ3dn/6jD8Td6SnY+7CB5E5xVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=G2Hi1yOJ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7c6b4222fe3so1555508a12.3
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 12:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1724443069; x=1725047869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=epLaBEyvQjUoXaa0Uj7itTI7QXW9p1kALohHY6dbCjo=;
        b=G2Hi1yOJr3busp127EPrxpy1yNZwqHuq7eXTxECkj93hZ2BYpiiXPanriJm7km3EDl
         el/MQOM28MWq4RDtl+Ggn51Qdc/48X5fsvFqI+7n4r2ZdFqzoa0oRbkRNpmbmioNvG+F
         zycmBqAbinthPSwy1wKS1bOS85/tAjj2Pgxz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724443069; x=1725047869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=epLaBEyvQjUoXaa0Uj7itTI7QXW9p1kALohHY6dbCjo=;
        b=I50G2veHBPQzXlirvKgvTCIkLYVaLpcEt5/J/rVfoUnydzZyM12Y7ltEqFEAmPE+s1
         YKqe75RkIHOO6t88vMv/B3UV7WKIAvYNfVZiYjP2I70682nwnpDCIc7Xv72uelBgfqSe
         7yEVGuyzj/jdV8XnNHBzqXUdctViPVPlrYdu/+birYN7GOgCdepS9ogQcqB9Lnd4CvQJ
         Bu1/RMM6Dp4HibWm297HXtTCu2aL0s9H+CM9NA4BSzLjekZ54Ju1StgItwJg453elnFY
         xR6TixAArkq04C5ON5uKygIIVjD1Q6uwc8pjQoseHepMFSO9/gn+jCsITcZUamaSYroP
         8qzQ==
X-Gm-Message-State: AOJu0YwgddRk5bf8FD/hU4iPpNrO7bNdUcAWk1hpcxF8Ul4Xlucy4yGL
	Unym9FWNjamaKvqqN3SlqN87k0fGBl9UsiQmI9f7rYT2AXsIlUGeP1mNpAfZ7A==
X-Google-Smtp-Source: AGHT+IHtmuc2O2wKKbCmf/YnKHOupolqd5Ux6gAarLYlVu4h1TuIZmI/hyhU7x0flK6G/MxkINgquQ==
X-Received: by 2002:a05:6a21:9786:b0:1ca:cd6c:2ab3 with SMTP id adf61e73a8af0-1cc89d1998bmr4516256637.10.1724443069298;
        Fri, 23 Aug 2024 12:57:49 -0700 (PDT)
Received: from lvnvda5233.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71434253dbesm3417424b3a.76.2024.08.23.12.57.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Aug 2024 12:57:48 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/9] bnxt_en: Support QOS and TPID settings for the SRIOV VLAN
Date: Fri, 23 Aug 2024 12:56:51 -0700
Message-ID: <20240823195657.31588-4-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20240823195657.31588-1-michael.chan@broadcom.com>
References: <20240823195657.31588-1-michael.chan@broadcom.com>
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


