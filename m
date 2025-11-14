Return-Path: <netdev+bounces-238754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30BD6C5F1BD
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 20:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CDC754E2D4F
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 19:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBDC312806;
	Fri, 14 Nov 2025 19:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eoBAzUFA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f99.google.com (mail-ot1-f99.google.com [209.85.210.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F582F6926
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 19:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150036; cv=none; b=OmsZe/dIXlINx10vjpcTlPVir8cB6v8E+OoUby1o9RScNH1azYCp3ybFvdGF6yWgXveNkR3ZEmVWvFhE6Udbc4wTXA6rwia+dV+s9DkRUvOLseRyw0BQ7MbhQdPuQkDB48v+nAj9kw77xAZMBQ0oLadVmkY8DbBXGSKXyEQ8cao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150036; c=relaxed/simple;
	bh=+NBYpsBkLBU1NNfeUcAiFsJdp2pUOrEjUjK/7+vn3MI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fgljxfmrbSNe7+f8tOpg66oyLqsV+Rn3Z4gi2MabmZOUZoo/TrCUGyhym1EPszz+PuAP1NbiFf9nllfbMycnjI66FZ+eMKaJPoZ/w/K2NhEM0+4Xg3YUOdlWT5Tj7AwoKKHIWvSMrktKAhN147UwPPsWE2kMDR5jDo3rwvnTOf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eoBAzUFA; arc=none smtp.client-ip=209.85.210.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f99.google.com with SMTP id 46e09a7af769-7c7060a2a53so629189a34.0
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 11:53:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763150032; x=1763754832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nIFfurL4zljS3SVZmgiahwdQvYjRN7Fcrc5AkZp8CxE=;
        b=GauGMxULVpQ8DLgrFxZVpo37D2yCkzFc8khdEiRzAFK51lSIIxuJoO7/riQSM6r8Jo
         KVUNMWq9EbTut8QhBCWYKr9tKqorUjoUvB4QGpPMT5MGXT/k7jPzBndkBxJAKVihLkww
         IRM9aVUta5VHlN1qIT3itYTDp/7mrAs+hkw+nqXgkGqgFn4sygc+FMF5bSF3MWRAlprd
         V/9b/AOGdG0ILnYxqMY0pPrdR5yj6+w7VvxAHBs2vxKxlWDIAMHDkNB07AjJiSHJEIsA
         xk9rg5cYUZfo/gFBviN/YgFTWNCpD6mPgiz+N1y3DU4i7DAuh4wrNEVzyr0ETXaU4YzA
         gfHA==
X-Gm-Message-State: AOJu0Yy2kLbTjzSBZDPsHLvn8CW01RiR0j8P3L+ZzV+0r+3gselXWF3P
	1c8LLfJ2+6tiFPhLBPEy5qKA7IXnPl34y8RNdBBg2aQDOqnn3ELspHzLXk+YoJ/BOH44V/3vMgM
	rgzi6tt2wHpM9ECz4CQ+d9SkmcSCFgxGo1BMaUN/ajzekEY0xANdFJRBvjAypTyCONOEYV+dv3a
	bCSaHFQ6+J9NLobzO0EjdzhQPUjsSM7HcgSuVSPOQu67ossR0L7S7+OqA0/gu+BK11k347uj918
	PIl642N04sPBFVt7w==
X-Gm-Gg: ASbGnctmIKSJ6s2uMhJm6VOWWhhW7RUl3eOspOJ0cRZnvvfLzEQMI3STywaFoEVEjTf
	Q5keOVrLrAnYRagBsV9jCYHdVCM5lpIiZp+fGeshFAtuU0B/pYshtmhiivQU8PgGQNkbUfX4NGX
	huoVbKrH7vD1re0XLNf/6CzULp+uAtf+fzjokbitQNAynXwOk3vr+K31XbVgavY1gxVEHUiNrAa
	r3NW3//uO5E7hkoiDUvd0KtfIlnzSwhEzDvHjCpfXZhv3arpeSHfJUmtXvfKhSudNfAtEmxZvXn
	PQP1OTX7lEW8kfEpYqrmcTZM5OQVayZEfDdOZ05pfGOFxMB4/mFjI03kcpQmOq46e/IuWoI/+4/
	s6SseP7nLo5LtIJGqBQN6TJDp3npG2k2U3sJ2Lj45iv3Ey6QIwDdE214hsBtFkWwKiAT+9CgxNj
	xE04g/j2+4nzqCFMJNrq8UO+EcjJQJM+2pvAQklIausdE=
X-Google-Smtp-Source: AGHT+IHd3V+dle4ye5yS4uNsiOeguk0F1p/q9mhBHXWSP8k3Ww+B2Z7iWqK7r3vLIqsCfebMx4tqxJr1GiJx
X-Received: by 2002:a05:6830:3155:b0:73e:9b34:9a0f with SMTP id 46e09a7af769-7c744328dd7mr2628994a34.7.1763150032651;
        Fri, 14 Nov 2025 11:53:52 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7c73a3274efsm594334a34.4.2025.11.14.11.53.52
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Nov 2025 11:53:52 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-34566e62f16so450864a91.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 11:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763150030; x=1763754830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIFfurL4zljS3SVZmgiahwdQvYjRN7Fcrc5AkZp8CxE=;
        b=eoBAzUFAc+PJygPuedvv34SF/HZl18sTC1f9ovN+dhG+QCg8wc7T5+Ojxu1W6dSBDA
         j6j8b7hs6DkrQixhFRw9fq2ZdYf0mfon7Y+bRtJE3ut1EKEL6YFlrwNPPcnfDclSnktr
         0dZz/dE2SUz4+FMEqTS7AA773bYNwhdqslHYY=
X-Received: by 2002:a17:90b:164a:b0:340:b501:7b7d with SMTP id 98e67ed59e1d1-343f9e9f39emr4622723a91.14.1763150029891;
        Fri, 14 Nov 2025 11:53:49 -0800 (PST)
X-Received: by 2002:a17:90b:164a:b0:340:b501:7b7d with SMTP id 98e67ed59e1d1-343f9e9f39emr4622684a91.14.1763150029328;
        Fri, 14 Nov 2025 11:53:49 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ea5f9fa4sm3108113a91.0.2025.11.14.11.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:53:48 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v2, net-next 01/12] bng_en: Query PHY and report link status
Date: Sat, 15 Nov 2025 01:22:49 +0530
Message-ID: <20251114195312.22863-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
References: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Query the PHY device and report link status,
speed, flow control, and duplex settings.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnge/Makefile   |   3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  29 ++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 187 +++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |   4 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 471 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    | 185 +++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  22 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   3 +
 8 files changed, 903 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h

diff --git a/drivers/net/ethernet/broadcom/bnge/Makefile b/drivers/net/ethernet/broadcom/bnge/Makefile
index 6142d9c57f4..f30db7e5f48 100644
--- a/drivers/net/ethernet/broadcom/bnge/Makefile
+++ b/drivers/net/ethernet/broadcom/bnge/Makefile
@@ -9,4 +9,5 @@ bng_en-y := bnge_core.o \
 	    bnge_rmem.o \
 	    bnge_resc.o \
 	    bnge_netdev.o \
-	    bnge_ethtool.o
+	    bnge_ethtool.o \
+	    bnge_link.o
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge.h b/drivers/net/ethernet/broadcom/bnge/bnge.h
index 7aed5f81cd5..56cc97ca492 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge.h
@@ -9,8 +9,10 @@
 
 #include <linux/etherdevice.h>
 #include <linux/bnxt/hsi.h>
+#include <linux/ethtool.h>
 #include "bnge_rmem.h"
 #include "bnge_resc.h"
+#include "bnge_link.h"
 
 #define DRV_VER_MAJ	1
 #define DRV_VER_MIN	15
@@ -141,6 +143,17 @@ struct bnge_dev {
 	struct bnge_ctx_mem_info	*ctx;
 
 	u64			flags;
+#define BNGE_PF(bd)		(1)
+#define BNGE_VF(bd)		(0)
+#define BNGE_NPAR(bd)		(0)
+#define BNGE_MH(bd)		(0)
+#define BNGE_SINGLE_PF(bd)	(BNGE_PF(bd) && !BNGE_NPAR(bd) && !BNGE_MH(bn))
+#define BNGE_SH_PORT_CFG_OK(bd)			\
+	(BNGE_PF(bd) && ((bd)->phy_flags & BNGE_PHY_FL_SHARED_PORT_CFG))
+#define BNGE_PHY_CFG_ABLE(bd)			\
+	((BNGE_SINGLE_PF(bd) ||			\
+	  BNGE_SH_PORT_CFG_OK(bd)) &&		\
+	 (bd)->link_info.phy_state == BNGE_PHY_STATE_ENABLED)
 
 	struct bnge_hw_resc	hw_resc;
 
@@ -197,6 +210,22 @@ struct bnge_dev {
 
 	struct bnge_irq		*irq_tbl;
 	u16			irqs_acquired;
+
+	/* To protect link related settings during link changes and
+	 * ethtool settings changes.
+	 */
+	struct mutex		link_lock;
+	struct bnge_link_info	link_info;
+
+	/* copied from flags and flags2 in hwrm_port_phy_qcaps_output */
+	u32			phy_flags;
+#define BNGE_PHY_FL_SHARED_PORT_CFG	\
+	PORT_PHY_QCAPS_RESP_FLAGS_SHARED_PHY_CFG_SUPPORTED
+#define BNGE_PHY_FL_NO_FCS		PORT_PHY_QCAPS_RESP_FLAGS_NO_FCS
+#define BNGE_PHY_FL_SPEEDS2		\
+	(PORT_PHY_QCAPS_RESP_FLAGS2_SPEEDS2_SUPPORTED << 8)
+
+	u32                     msg_enable;
 };
 
 static inline bool bnge_is_roce_en(struct bnge_dev *bd)
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
index 198f49b40db..b0e941ad18b 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.c
@@ -14,6 +14,7 @@
 #include "bnge_hwrm_lib.h"
 #include "bnge_rmem.h"
 #include "bnge_resc.h"
+#include "bnge_link.h"
 
 int bnge_hwrm_ver_get(struct bnge_dev *bd)
 {
@@ -981,6 +982,192 @@ void bnge_hwrm_vnic_ctx_free_one(struct bnge_dev *bd,
 	vnic->fw_rss_cos_lb_ctx[ctx_idx] = INVALID_HW_RING_ID;
 }
 
+int bnge_hwrm_phy_qcaps(struct bnge_dev *bd)
+{
+	struct bnge_link_info *link_info = &bd->link_info;
+	struct hwrm_port_phy_qcaps_output *resp;
+	struct hwrm_port_phy_qcaps_input *req;
+	int rc = 0;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_PORT_PHY_QCAPS);
+	if (rc)
+		return rc;
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (rc)
+		goto hwrm_phy_qcaps_exit;
+
+	bd->phy_flags = resp->flags | (le16_to_cpu(resp->flags2) << 8);
+
+	if (bnge_phy_qcaps_no_speed(resp)) {
+		link_info->phy_state = BNGE_PHY_STATE_DISABLED;
+		netdev_warn(bd->netdev, "Ethernet link disabled\n");
+	} else if (link_info->phy_state == BNGE_PHY_STATE_DISABLED) {
+		link_info->phy_state = BNGE_PHY_STATE_ENABLED;
+		netdev_info(bd->netdev, "Ethernet link enabled\n");
+		/* Phy re-enabled, reprobe the speeds */
+		link_info->support_auto_speeds = 0;
+		link_info->support_pam4_auto_speeds = 0;
+		link_info->support_auto_speeds2 = 0;
+	}
+	if (resp->supported_speeds_auto_mode)
+		link_info->support_auto_speeds =
+			le16_to_cpu(resp->supported_speeds_auto_mode);
+	if (resp->supported_pam4_speeds_auto_mode)
+		link_info->support_pam4_auto_speeds =
+			le16_to_cpu(resp->supported_pam4_speeds_auto_mode);
+	if (resp->supported_speeds2_auto_mode)
+		link_info->support_auto_speeds2 =
+			le16_to_cpu(resp->supported_speeds2_auto_mode);
+
+	bd->port_count = resp->port_cnt;
+
+hwrm_phy_qcaps_exit:
+	bnge_hwrm_req_drop(bd, req);
+	return rc;
+}
+
+int bnge_hwrm_set_link_setting(struct bnge_net *bn, bool set_pause)
+{
+	struct hwrm_port_phy_cfg_input *req;
+	struct bnge_dev *bd = bn->bd;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_PORT_PHY_CFG);
+	if (rc)
+		return rc;
+
+	if (set_pause)
+		bnge_hwrm_set_pause_common(bn, req);
+
+	bnge_hwrm_set_link_common(bn, req);
+
+	return bnge_hwrm_req_send(bd, req);
+}
+
+int bnge_update_link(struct bnge_net *bn, bool chng_link_state)
+{
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_link_info *link_info = &bd->link_info;
+	struct hwrm_port_phy_qcfg_output *resp;
+	u8 link_state = link_info->link_state;
+	struct hwrm_port_phy_qcfg_input *req;
+	bool support_changed;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_PORT_PHY_QCFG);
+	if (rc)
+		return rc;
+
+	resp = bnge_hwrm_req_hold(bd, req);
+	rc = bnge_hwrm_req_send(bd, req);
+	if (rc) {
+		bnge_hwrm_req_drop(bd, req);
+		return rc;
+	}
+
+	memcpy(&link_info->phy_qcfg_resp, resp, sizeof(*resp));
+	link_info->phy_link_status = resp->link;
+	link_info->duplex = resp->duplex_state;
+	link_info->pause = resp->pause;
+	link_info->auto_mode = resp->auto_mode;
+	link_info->auto_pause_setting = resp->auto_pause;
+	link_info->lp_pause = resp->link_partner_adv_pause;
+	link_info->force_pause_setting = resp->force_pause;
+	link_info->duplex_setting = resp->duplex_cfg;
+	if (link_info->phy_link_status == BNGE_LINK_LINK) {
+		link_info->link_speed = le16_to_cpu(resp->link_speed);
+		if (bd->phy_flags & BNGE_PHY_FL_SPEEDS2)
+			link_info->active_lanes = resp->active_lanes;
+	} else {
+		link_info->link_speed = 0;
+		link_info->active_lanes = 0;
+	}
+	link_info->force_link_speed = le16_to_cpu(resp->force_link_speed);
+	link_info->force_pam4_link_speed =
+		le16_to_cpu(resp->force_pam4_link_speed);
+	link_info->force_link_speed2 = le16_to_cpu(resp->force_link_speeds2);
+	link_info->support_speeds = le16_to_cpu(resp->support_speeds);
+	link_info->support_pam4_speeds = le16_to_cpu(resp->support_pam4_speeds);
+	link_info->support_speeds2 = le16_to_cpu(resp->support_speeds2);
+	link_info->auto_link_speeds = le16_to_cpu(resp->auto_link_speed_mask);
+	link_info->auto_pam4_link_speeds =
+		le16_to_cpu(resp->auto_pam4_link_speed_mask);
+	link_info->auto_link_speeds2 = le16_to_cpu(resp->auto_link_speeds2);
+	link_info->lp_auto_link_speeds =
+		le16_to_cpu(resp->link_partner_adv_speeds);
+	link_info->lp_auto_pam4_link_speeds =
+		resp->link_partner_pam4_adv_speeds;
+	link_info->preemphasis = le32_to_cpu(resp->preemphasis);
+	link_info->phy_ver[0] = resp->phy_maj;
+	link_info->phy_ver[1] = resp->phy_min;
+	link_info->phy_ver[2] = resp->phy_bld;
+	link_info->media_type = resp->media_type;
+	link_info->phy_type = resp->phy_type;
+	link_info->transceiver = resp->xcvr_pkg_type;
+	link_info->phy_addr = resp->eee_config_phy_addr &
+			      PORT_PHY_QCFG_RESP_PHY_ADDR_MASK;
+	link_info->module_status = resp->module_status;
+
+	link_info->fec_cfg = PORT_PHY_QCFG_RESP_FEC_CFG_FEC_NONE_SUPPORTED;
+	link_info->fec_cfg = le16_to_cpu(resp->fec_cfg);
+	link_info->active_fec_sig_mode = resp->active_fec_signal_mode;
+	/* TODO: need to add more logic to report VF link */
+	if (chng_link_state) {
+		if (link_info->phy_link_status == BNGE_LINK_LINK)
+			link_info->link_state = BNGE_LINK_STATE_UP;
+		else
+			link_info->link_state = BNGE_LINK_STATE_DOWN;
+		if (link_state != link_info->link_state)
+			bnge_report_link(bd);
+	} else {
+		/* always link down if not require to update link state */
+		link_info->link_state = BNGE_LINK_STATE_DOWN;
+	}
+	bnge_hwrm_req_drop(bd, req);
+
+	if (!BNGE_PHY_CFG_ABLE(bd))
+		return 0;
+
+	support_changed = bnge_support_speed_dropped(bn);
+	if (support_changed && (bn->eth_link_info.autoneg & BNGE_AUTONEG_SPEED))
+		bnge_hwrm_set_link_setting(bn, true);
+	return 0;
+}
+
+int bnge_hwrm_set_pause(struct bnge_net *bn)
+{
+	struct hwrm_port_phy_cfg_input *req;
+	struct bnge_dev *bd = bn->bd;
+	int rc;
+
+	rc = bnge_hwrm_req_init(bd, req, HWRM_PORT_PHY_CFG);
+	if (rc)
+		return rc;
+
+	bnge_hwrm_set_pause_common(bn, req);
+
+	if ((bn->eth_link_info.autoneg & BNGE_AUTONEG_FLOW_CTRL) ||
+	    bn->eth_link_info.force_link_chng)
+		bnge_hwrm_set_link_common(bn, req);
+
+	rc = bnge_hwrm_req_send(bd, req);
+	if (!rc && !(bn->eth_link_info.autoneg & BNGE_AUTONEG_FLOW_CTRL)) {
+		/* since changing of pause setting doesn't trigger any link
+		 * change event, the driver needs to update the current pause
+		 * result upon successfully return of the phy_cfg command
+		 */
+		bd->link_info.force_pause_setting =
+		bd->link_info.pause = bn->eth_link_info.req_flow_ctrl;
+		bd->link_info.auto_pause_setting = 0;
+		if (!bn->eth_link_info.force_link_chng)
+			bnge_report_link(bd);
+	}
+	bn->eth_link_info.force_link_chng = false;
+	return rc;
+}
+
 void bnge_hwrm_stat_ctx_free(struct bnge_net *bn)
 {
 	struct hwrm_stat_ctx_free_input *req;
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
index 042f28e84a0..b063f62ae06 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_hwrm_lib.h
@@ -55,4 +55,8 @@ int hwrm_ring_alloc_send_msg(struct bnge_net *bn,
 			     struct bnge_ring_struct *ring,
 			     u32 ring_type, u32 map_index);
 int bnge_hwrm_set_async_event_cr(struct bnge_dev *bd, int idx);
+int bnge_update_link(struct bnge_net *bn, bool chng_link_state);
+int bnge_hwrm_phy_qcaps(struct bnge_dev *bd);
+int bnge_hwrm_set_link_setting(struct bnge_net *bn, bool set_pause);
+int bnge_hwrm_set_pause(struct bnge_net *bn);
 #endif /* _BNGE_HWRM_LIB_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.c b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
new file mode 100644
index 00000000000..b4a5ed00db2
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.c
@@ -0,0 +1,471 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <linux/linkmode.h>
+
+#include "bnge.h"
+#include "bnge_link.h"
+#include "bnge_hwrm_lib.h"
+
+u32 bnge_fw_to_ethtool_speed(u16 fw_link_speed)
+{
+	switch (fw_link_speed) {
+	case BNGE_LINK_SPEED_50GB:
+	case BNGE_LINK_SPEED_50GB_PAM4:
+		return SPEED_50000;
+	case BNGE_LINK_SPEED_100GB:
+	case BNGE_LINK_SPEED_100GB_PAM4:
+	case BNGE_LINK_SPEED_100GB_PAM4_112:
+		return SPEED_100000;
+	case BNGE_LINK_SPEED_200GB:
+	case BNGE_LINK_SPEED_200GB_PAM4:
+	case BNGE_LINK_SPEED_200GB_PAM4_112:
+		return SPEED_200000;
+	case BNGE_LINK_SPEED_400GB:
+	case BNGE_LINK_SPEED_400GB_PAM4:
+	case BNGE_LINK_SPEED_400GB_PAM4_112:
+		return SPEED_400000;
+	case BNGE_LINK_SPEED_800GB:
+	case BNGE_LINK_SPEED_800GB_PAM4_112:
+		return SPEED_800000;
+	default:
+		return SPEED_UNKNOWN;
+	}
+}
+
+bool bnge_phy_qcaps_no_speed(struct hwrm_port_phy_qcaps_output *resp)
+{
+	if (!resp->supported_speeds_auto_mode &&
+	    !resp->supported_speeds_force_mode &&
+	    !resp->supported_pam4_speeds_auto_mode &&
+	    !resp->supported_pam4_speeds_force_mode &&
+	    !resp->supported_speeds2_auto_mode &&
+	    !resp->supported_speeds2_force_mode)
+		return true;
+	return false;
+}
+
+static void bnge_set_auto_speed(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_link_info *link_info = &bd->link_info;
+
+	if (bd->phy_flags & BNGE_PHY_FL_SPEEDS2) {
+		elink_info->advertising = link_info->auto_link_speeds2;
+		return;
+	}
+	elink_info->advertising = link_info->auto_link_speeds;
+	elink_info->advertising_pam4 = link_info->auto_pam4_link_speeds;
+}
+
+static void bnge_set_force_speed(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_link_info *link_info = &bd->link_info;
+
+	if (bd->phy_flags & BNGE_PHY_FL_SPEEDS2) {
+		elink_info->req_link_speed = link_info->force_link_speed2;
+		elink_info->req_signal_mode = BNGE_SIG_MODE_NRZ;
+		switch (elink_info->req_link_speed) {
+		case BNGE_LINK_SPEED_50GB_PAM4:
+		case BNGE_LINK_SPEED_100GB_PAM4:
+		case BNGE_LINK_SPEED_200GB_PAM4:
+		case BNGE_LINK_SPEED_400GB_PAM4:
+			elink_info->req_signal_mode = BNGE_SIG_MODE_PAM4;
+			break;
+		case BNGE_LINK_SPEED_100GB_PAM4_112:
+		case BNGE_LINK_SPEED_200GB_PAM4_112:
+		case BNGE_LINK_SPEED_400GB_PAM4_112:
+		case BNGE_LINK_SPEED_800GB_PAM4_112:
+			elink_info->req_signal_mode = BNGE_SIG_MODE_PAM4_112;
+			break;
+		default:
+			elink_info->req_signal_mode = BNGE_SIG_MODE_NRZ;
+		}
+		return;
+	}
+	elink_info->req_link_speed = link_info->force_link_speed;
+	elink_info->req_signal_mode = BNGE_SIG_MODE_NRZ;
+	if (link_info->force_pam4_link_speed) {
+		elink_info->req_link_speed = link_info->force_pam4_link_speed;
+		elink_info->req_signal_mode = BNGE_SIG_MODE_PAM4;
+	}
+}
+
+void bnge_init_ethtool_link_settings(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_link_info *link_info = &bd->link_info;
+
+	if (BNGE_AUTO_MODE(link_info->auto_mode)) {
+		elink_info->autoneg = BNGE_AUTONEG_SPEED;
+		if (link_info->auto_pause_setting &
+		    PORT_PHY_CFG_REQ_AUTO_PAUSE_AUTONEG_PAUSE)
+			elink_info->autoneg |= BNGE_AUTONEG_FLOW_CTRL;
+		bnge_set_auto_speed(bn);
+	} else {
+		bnge_set_force_speed(bn);
+		elink_info->req_duplex = link_info->duplex_setting;
+	}
+	if (elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL)
+		elink_info->req_flow_ctrl =
+			link_info->auto_pause_setting & BNGE_LINK_PAUSE_BOTH;
+	else
+		elink_info->req_flow_ctrl = link_info->force_pause_setting;
+}
+
+int bnge_probe_phy(struct bnge_net *bn, bool fw_dflt)
+{
+	struct bnge_dev *bd = bn->bd;
+	int rc = 0;
+
+	bd->phy_flags = 0;
+	rc = bnge_hwrm_phy_qcaps(bd);
+	if (rc) {
+		netdev_err(bd->netdev,
+			   "Probe phy can't get phy qcaps (rc: %d)\n", rc);
+		return rc;
+	}
+	if (bd->phy_flags & BNGE_PHY_FL_NO_FCS)
+		bd->netdev->priv_flags |= IFF_SUPP_NOFCS;
+	else
+		bd->netdev->priv_flags &= ~IFF_SUPP_NOFCS;
+	if (!fw_dflt)
+		return 0;
+
+	mutex_lock(&bd->link_lock);
+	rc = bnge_update_link(bn, false);
+	if (rc) {
+		mutex_unlock(&bd->link_lock);
+		netdev_err(bd->netdev, "Probe phy can't update link (rc: %d)\n",
+			   rc);
+		return rc;
+	}
+
+	bnge_init_ethtool_link_settings(bn);
+	mutex_unlock(&bd->link_lock);
+	return 0;
+}
+
+void bnge_hwrm_set_link_common(struct bnge_net *bn,
+			       struct hwrm_port_phy_cfg_input *req)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_dev *bd = bn->bd;
+
+	if (elink_info->autoneg & BNGE_AUTONEG_SPEED) {
+		req->auto_mode |= PORT_PHY_CFG_REQ_AUTO_MODE_SPEED_MASK;
+		if (bd->phy_flags & BNGE_PHY_FL_SPEEDS2) {
+			req->enables |= cpu_to_le32(BNGE_PHY_AUTO_SPEEDS2_MASK);
+			req->auto_link_speeds2_mask =
+				cpu_to_le16(elink_info->advertising);
+		} else if (elink_info->advertising) {
+			req->enables |= cpu_to_le32(BNGE_PHY_AUTO_SPEED_MASK);
+			req->auto_link_speed_mask =
+				cpu_to_le16(elink_info->advertising);
+		}
+		if (elink_info->advertising_pam4) {
+			req->enables |=
+				cpu_to_le32(BNGE_PHY_AUTO_PAM4_SPEED_MASK);
+			req->auto_link_pam4_speed_mask =
+				cpu_to_le16(elink_info->advertising_pam4);
+		}
+		req->enables |= cpu_to_le32(PORT_PHY_CFG_REQ_ENABLES_AUTO_MODE);
+		req->flags |= cpu_to_le32(BNGE_PHY_FLAGS_RESTART_AUTO);
+	} else {
+		req->flags |= cpu_to_le32(PORT_PHY_CFG_REQ_FLAGS_FORCE);
+		if (bd->phy_flags & BNGE_PHY_FL_SPEEDS2) {
+			req->force_link_speeds2 =
+				cpu_to_le16(elink_info->req_link_speed);
+			req->enables |=
+				cpu_to_le32(BNGE_PHY_FLAGS_ENA_FORCE_SPEEDS2);
+			netif_info(bd, link, bd->netdev,
+				   "Forcing FW speed2: %d\n",
+				   (u32)elink_info->req_link_speed);
+		} else if (elink_info->req_signal_mode == BNGE_SIG_MODE_PAM4) {
+			req->force_pam4_link_speed =
+				cpu_to_le16(elink_info->req_link_speed);
+			req->enables |=
+				cpu_to_le32(BNGE_PHY_FLAGS_ENA_FORCE_PM4_SPEED);
+		} else {
+			req->force_link_speed =
+				cpu_to_le16(elink_info->req_link_speed);
+		}
+	}
+
+	/* tell FW that the setting takes effect immediately */
+	req->flags |= cpu_to_le32(PORT_PHY_CFG_REQ_FLAGS_RESET_PHY);
+}
+
+static bool bnge_auto_speed_updated(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_link_info *link_info = &bd->link_info;
+
+	if (bd->phy_flags & BNGE_PHY_FL_SPEEDS2) {
+		if (elink_info->advertising != link_info->auto_link_speeds2)
+			return true;
+		return false;
+	}
+	if (elink_info->advertising != link_info->auto_link_speeds ||
+	    elink_info->advertising_pam4 != link_info->auto_pam4_link_speeds)
+		return true;
+	return false;
+}
+
+void bnge_hwrm_set_pause_common(struct bnge_net *bn,
+				struct hwrm_port_phy_cfg_input *req)
+{
+	if (bn->eth_link_info.autoneg & BNGE_AUTONEG_FLOW_CTRL) {
+		req->auto_pause = PORT_PHY_CFG_REQ_AUTO_PAUSE_AUTONEG_PAUSE;
+		if (bn->eth_link_info.req_flow_ctrl & BNGE_LINK_PAUSE_RX)
+			req->auto_pause |= PORT_PHY_CFG_REQ_AUTO_PAUSE_RX;
+		if (bn->eth_link_info.req_flow_ctrl & BNGE_LINK_PAUSE_TX)
+			req->auto_pause |= PORT_PHY_CFG_REQ_AUTO_PAUSE_TX;
+		req->enables |=
+			cpu_to_le32(PORT_PHY_CFG_REQ_ENABLES_AUTO_PAUSE);
+	} else {
+		if (bn->eth_link_info.req_flow_ctrl & BNGE_LINK_PAUSE_RX)
+			req->force_pause |= PORT_PHY_CFG_REQ_FORCE_PAUSE_RX;
+		if (bn->eth_link_info.req_flow_ctrl & BNGE_LINK_PAUSE_TX)
+			req->force_pause |= PORT_PHY_CFG_REQ_FORCE_PAUSE_TX;
+		req->enables |=
+			cpu_to_le32(PORT_PHY_CFG_REQ_ENABLES_FORCE_PAUSE);
+		req->auto_pause = req->force_pause;
+		req->enables |=
+			cpu_to_le32(PORT_PHY_CFG_REQ_ENABLES_AUTO_PAUSE);
+	}
+}
+
+static bool bnge_force_speed_updated(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_link_info *link_info = &bd->link_info;
+
+	if (bd->phy_flags & BNGE_PHY_FL_SPEEDS2) {
+		if (elink_info->req_link_speed != link_info->force_link_speed2)
+			return true;
+		return false;
+	}
+	if (elink_info->req_signal_mode == BNGE_SIG_MODE_NRZ &&
+	    elink_info->req_link_speed != link_info->force_link_speed)
+		return true;
+	if (elink_info->req_signal_mode == BNGE_SIG_MODE_PAM4 &&
+	    elink_info->req_link_speed != link_info->force_pam4_link_speed)
+		return true;
+	return false;
+}
+
+int bnge_update_phy_setting(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info;
+	struct bnge_link_info *link_info;
+	struct bnge_dev *bd = bn->bd;
+	bool update_pause = false;
+	bool update_link = false;
+	int rc;
+
+	link_info = &bd->link_info;
+	elink_info = &bn->eth_link_info;
+	rc = bnge_update_link(bn, true);
+	if (rc) {
+		netdev_err(bd->netdev, "failed to update link (rc: %d)\n",
+			   rc);
+		return rc;
+	}
+	if (!BNGE_SINGLE_PF(bd))
+		return 0;
+
+	if ((elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL) &&
+	    (link_info->auto_pause_setting & BNGE_LINK_PAUSE_BOTH) !=
+	    elink_info->req_flow_ctrl)
+		update_pause = true;
+	if (!(elink_info->autoneg & BNGE_AUTONEG_FLOW_CTRL) &&
+	    link_info->force_pause_setting != elink_info->req_flow_ctrl)
+		update_pause = true;
+	if (!(elink_info->autoneg & BNGE_AUTONEG_SPEED)) {
+		if (BNGE_AUTO_MODE(link_info->auto_mode))
+			update_link = true;
+		if (bnge_force_speed_updated(bn))
+			update_link = true;
+		if (elink_info->req_duplex != link_info->duplex_setting)
+			update_link = true;
+	} else {
+		if (link_info->auto_mode == BNGE_LINK_AUTO_NONE)
+			update_link = true;
+		if (bnge_auto_speed_updated(bn))
+			update_link = true;
+	}
+
+	/* The last close may have shutdown the link, so need to call
+	 * PHY_CFG to bring it back up.
+	 */
+	if (!BNGE_LINK_IS_UP(bd))
+		update_link = true;
+
+	if (update_link)
+		rc = bnge_hwrm_set_link_setting(bn, update_pause);
+	else if (update_pause)
+		rc = bnge_hwrm_set_pause(bn);
+	if (rc) {
+		netdev_err(bd->netdev,
+			   "failed to update phy setting (rc: %d)\n", rc);
+		return rc;
+	}
+
+	return rc;
+}
+
+void bnge_get_port_module_status(struct bnge_net *bn)
+{
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_link_info *link_info = &bd->link_info;
+	struct hwrm_port_phy_qcfg_output *resp = &link_info->phy_qcfg_resp;
+	u8 module_status;
+
+	if (bnge_update_link(bn, true))
+		return;
+
+	module_status = link_info->module_status;
+	switch (module_status) {
+	case PORT_PHY_QCFG_RESP_MODULE_STATUS_DISABLETX:
+	case PORT_PHY_QCFG_RESP_MODULE_STATUS_PWRDOWN:
+	case PORT_PHY_QCFG_RESP_MODULE_STATUS_WARNINGMSG:
+		netdev_warn(bd->netdev,
+			    "Unqualified SFP+ module detected on port %d\n",
+			    bd->pf.port_id);
+		netdev_warn(bd->netdev, "Module part number %s\n",
+			    resp->phy_vendor_partnumber);
+		if (module_status == PORT_PHY_QCFG_RESP_MODULE_STATUS_DISABLETX)
+			netdev_warn(bd->netdev, "TX is disabled\n");
+		if (module_status == PORT_PHY_QCFG_RESP_MODULE_STATUS_PWRDOWN)
+			netdev_warn(bd->netdev, "SFP+ module is shutdown\n");
+	}
+}
+
+static bool bnge_support_dropped(u16 advertising, u16 supported)
+{
+	u16 diff = advertising ^ supported;
+
+	return ((supported | diff) != supported);
+}
+
+bool bnge_support_speed_dropped(struct bnge_net *bn)
+{
+	struct bnge_ethtool_link_info *elink_info = &bn->eth_link_info;
+	struct bnge_dev *bd = bn->bd;
+	struct bnge_link_info *link_info = &bd->link_info;
+
+	/* Check if any advertised speeds are no longer supported. The caller
+	 * holds the link_lock mutex, so we can modify link_info settings.
+	 */
+	if (bd->phy_flags & BNGE_PHY_FL_SPEEDS2) {
+		if (bnge_support_dropped(elink_info->advertising,
+					 link_info->support_auto_speeds2)) {
+			elink_info->advertising =
+				link_info->support_auto_speeds2;
+			return true;
+		}
+		return false;
+	}
+	if (bnge_support_dropped(elink_info->advertising,
+				 link_info->support_auto_speeds)) {
+		elink_info->advertising = link_info->support_auto_speeds;
+		return true;
+	}
+	if (bnge_support_dropped(elink_info->advertising_pam4,
+				 link_info->support_pam4_auto_speeds)) {
+		elink_info->advertising_pam4 =
+			link_info->support_pam4_auto_speeds;
+		return true;
+	}
+	return false;
+}
+
+static char *bnge_report_fec(struct bnge_link_info *link_info)
+{
+	u8 active_fec = link_info->active_fec_sig_mode &
+			PORT_PHY_QCFG_RESP_ACTIVE_FEC_MASK;
+
+	switch (active_fec) {
+	default:
+	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_NONE_ACTIVE:
+		return "None";
+	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_CLAUSE74_ACTIVE:
+		return "Clause 74 BaseR";
+	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_CLAUSE91_ACTIVE:
+		return "Clause 91 RS(528,514)";
+	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS544_1XN_ACTIVE:
+		return "Clause 91 RS544_1XN";
+	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS544_IEEE_ACTIVE:
+		return "Clause 91 RS(544,514)";
+	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS272_1XN_ACTIVE:
+		return "Clause 91 RS272_1XN";
+	case PORT_PHY_QCFG_RESP_ACTIVE_FEC_FEC_RS272_IEEE_ACTIVE:
+		return "Clause 91 RS(272,257)";
+	}
+}
+
+void bnge_report_link(struct bnge_dev *bd)
+{
+	if (BNGE_LINK_IS_UP(bd)) {
+		const char *signal = "";
+		const char *flow_ctrl;
+		const char *duplex;
+		u32 speed;
+		u16 fec;
+
+		netif_carrier_on(bd->netdev);
+		speed = bnge_fw_to_ethtool_speed(bd->link_info.link_speed);
+		if (speed == SPEED_UNKNOWN) {
+			netdev_info(bd->netdev,
+				    "NIC Link is Up, speed unknown\n");
+			return;
+		}
+		if (bd->link_info.duplex == BNGE_LINK_DUPLEX_FULL)
+			duplex = "full";
+		else
+			duplex = "half";
+		if (bd->link_info.pause == BNGE_LINK_PAUSE_BOTH)
+			flow_ctrl = "ON - receive & transmit";
+		else if (bd->link_info.pause == BNGE_LINK_PAUSE_TX)
+			flow_ctrl = "ON - transmit";
+		else if (bd->link_info.pause == BNGE_LINK_PAUSE_RX)
+			flow_ctrl = "ON - receive";
+		else
+			flow_ctrl = "none";
+		if (bd->link_info.phy_qcfg_resp.option_flags &
+		    PORT_PHY_QCFG_RESP_OPTION_FLAGS_SIGNAL_MODE_KNOWN) {
+			u8 sig_mode = bd->link_info.active_fec_sig_mode &
+				      PORT_PHY_QCFG_RESP_SIGNAL_MODE_MASK;
+			switch (sig_mode) {
+			case PORT_PHY_QCFG_RESP_SIGNAL_MODE_NRZ:
+				signal = "(NRZ) ";
+				break;
+			case PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4:
+				signal = "(PAM4 56Gbps) ";
+				break;
+			case PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_112:
+				signal = "(PAM4 112Gbps) ";
+				break;
+			default:
+				break;
+			}
+		}
+		netdev_info(bd->netdev, "NIC Link is Up, %u Mbps %s%s duplex, Flow control: %s\n",
+			    speed, signal, duplex, flow_ctrl);
+		fec = bd->link_info.fec_cfg;
+		if (!(fec & PORT_PHY_QCFG_RESP_FEC_CFG_FEC_NONE_SUPPORTED))
+			netdev_info(bd->netdev, "FEC autoneg %s encoding: %s\n",
+				    (fec & BNGE_FEC_AUTONEG) ? "on" : "off",
+				    bnge_report_fec(&bd->link_info));
+	} else {
+		netif_carrier_off(bd->netdev);
+		netdev_err(bd->netdev, "NIC Link is Down\n");
+	}
+}
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_link.h b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
new file mode 100644
index 00000000000..65da27c510b
--- /dev/null
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_link.h
@@ -0,0 +1,185 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2025 Broadcom */
+
+#ifndef _BNGE_LINK_H_
+#define _BNGE_LINK_H_
+
+#define BNGE_PHY_AUTO_SPEEDS2_MASK	\
+	PORT_PHY_CFG_REQ_ENABLES_AUTO_LINK_SPEEDS2_MASK
+#define BNGE_PHY_AUTO_SPEED_MASK	\
+	PORT_PHY_CFG_REQ_ENABLES_AUTO_LINK_SPEED_MASK
+#define BNGE_PHY_AUTO_PAM4_SPEED_MASK	\
+	PORT_PHY_CFG_REQ_ENABLES_AUTO_PAM4_LINK_SPEED_MASK
+#define BNGE_PHY_FLAGS_RESTART_AUTO	\
+	PORT_PHY_CFG_REQ_FLAGS_RESTART_AUTONEG
+#define BNGE_PHY_FLAGS_ENA_FORCE_SPEEDS2	\
+	PORT_PHY_CFG_REQ_ENABLES_FORCE_LINK_SPEEDS2
+#define BNGE_PHY_FLAGS_ENA_FORCE_PM4_SPEED	\
+	PORT_PHY_CFG_REQ_ENABLES_FORCE_PAM4_LINK_SPEED
+
+struct bnge_link_info {
+	u8			phy_type;
+	u8			media_type;
+	u8			transceiver;
+	u8			phy_addr;
+	u8			phy_link_status;
+#define BNGE_LINK_LINK		PORT_PHY_QCFG_RESP_LINK_LINK
+	u8			phy_state;
+#define BNGE_PHY_STATE_ENABLED		0
+#define BNGE_PHY_STATE_DISABLED		1
+
+	u8			link_state;
+#define BNGE_LINK_STATE_UNKNOWN	0
+#define BNGE_LINK_STATE_DOWN	1
+#define BNGE_LINK_STATE_UP	2
+#define BNGE_LINK_IS_UP(bd)		\
+	((bd)->link_info.link_state == BNGE_LINK_STATE_UP)
+	u8			active_lanes;
+	u8			duplex;
+#define BNGE_LINK_DUPLEX_FULL	PORT_PHY_QCFG_RESP_DUPLEX_STATE_FULL
+	u8			pause;
+#define BNGE_LINK_PAUSE_TX	PORT_PHY_QCFG_RESP_PAUSE_TX
+#define BNGE_LINK_PAUSE_RX	PORT_PHY_QCFG_RESP_PAUSE_RX
+#define BNGE_LINK_PAUSE_BOTH	(PORT_PHY_QCFG_RESP_PAUSE_RX | \
+				 PORT_PHY_QCFG_RESP_PAUSE_TX)
+	u8			lp_pause;
+	u8			auto_pause_setting;
+	u8			force_pause_setting;
+	u8			duplex_setting;
+	u8			auto_mode;
+#define BNGE_AUTO_MODE(mode)	((mode) > BNGE_LINK_AUTO_NONE && \
+				 (mode) <= BNGE_LINK_AUTO_MSK)
+#define BNGE_LINK_AUTO_NONE     PORT_PHY_QCFG_RESP_AUTO_MODE_NONE
+#define BNGE_LINK_AUTO_MSK	PORT_PHY_QCFG_RESP_AUTO_MODE_SPEED_MASK
+#define PHY_VER_LEN		3
+	u8			phy_ver[PHY_VER_LEN];
+	u16			link_speed;
+#define BNGE_LINK_SPEED_50GB	PORT_PHY_QCFG_RESP_LINK_SPEED_50GB
+#define BNGE_LINK_SPEED_100GB	PORT_PHY_QCFG_RESP_LINK_SPEED_100GB
+#define BNGE_LINK_SPEED_200GB	PORT_PHY_QCFG_RESP_LINK_SPEED_200GB
+#define BNGE_LINK_SPEED_400GB	PORT_PHY_QCFG_RESP_LINK_SPEED_400GB
+#define BNGE_LINK_SPEED_800GB	PORT_PHY_QCFG_RESP_LINK_SPEED_800GB
+	u16			support_speeds;
+	u16			support_pam4_speeds;
+	u16			support_speeds2;
+
+	u16			auto_link_speeds;	/* fw adv setting */
+#define BNGE_LINK_SPEED_MSK_50GB PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_50GB
+#define BNGE_LINK_SPEED_MSK_100GB PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS_100GB
+	u16			auto_pam4_link_speeds;
+#define BNGE_LINK_PAM4_SPEED_MSK_50GB PORT_PHY_QCFG_RESP_SUPPORT_PAM4_SPEEDS_50G
+#define BNGE_LINK_PAM4_SPEED_MSK_100GB		\
+	PORT_PHY_QCFG_RESP_SUPPORT_PAM4_SPEEDS_100G
+#define BNGE_LINK_PAM4_SPEED_MSK_200GB		\
+	PORT_PHY_QCFG_RESP_SUPPORT_PAM4_SPEEDS_200G
+	u16			auto_link_speeds2;
+#define BNGE_LINK_SPEEDS2_MSK_50GB PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_50GB
+#define BNGE_LINK_SPEEDS2_MSK_100GB PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_100GB
+#define BNGE_LINK_SPEEDS2_MSK_50GB_PAM4	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_50GB_PAM4_56
+#define BNGE_LINK_SPEEDS2_MSK_100GB_PAM4	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_100GB_PAM4_56
+#define BNGE_LINK_SPEEDS2_MSK_200GB_PAM4	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_200GB_PAM4_56
+#define BNGE_LINK_SPEEDS2_MSK_400GB_PAM4	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_400GB_PAM4_56
+#define BNGE_LINK_SPEEDS2_MSK_100GB_PAM4_112	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_100GB_PAM4_112
+#define BNGE_LINK_SPEEDS2_MSK_200GB_PAM4_112	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_200GB_PAM4_112
+#define BNGE_LINK_SPEEDS2_MSK_400GB_PAM4_112	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_400GB_PAM4_112
+#define BNGE_LINK_SPEEDS2_MSK_800GB_PAM4_112	\
+	PORT_PHY_QCFG_RESP_SUPPORT_SPEEDS2_800GB_PAM4_112
+
+	u16			support_auto_speeds;
+	u16			support_pam4_auto_speeds;
+	u16			support_auto_speeds2;
+
+	u16			lp_auto_link_speeds;
+	u16			lp_auto_pam4_link_speeds;
+	u16			force_link_speed;
+	u16			force_pam4_link_speed;
+	u16			force_link_speed2;
+#define BNGE_LINK_SPEED_50GB_PAM4	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_50GB_PAM4_56
+#define BNGE_LINK_SPEED_100GB_PAM4	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_100GB_PAM4_56
+#define BNGE_LINK_SPEED_200GB_PAM4	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_200GB_PAM4_56
+#define BNGE_LINK_SPEED_400GB_PAM4	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_400GB_PAM4_56
+#define BNGE_LINK_SPEED_100GB_PAM4_112	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_100GB_PAM4_112
+#define BNGE_LINK_SPEED_200GB_PAM4_112	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_200GB_PAM4_112
+#define BNGE_LINK_SPEED_400GB_PAM4_112	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_400GB_PAM4_112
+#define BNGE_LINK_SPEED_800GB_PAM4_112	\
+	PORT_PHY_CFG_REQ_FORCE_LINK_SPEEDS2_800GB_PAM4_112
+
+	u32			preemphasis;
+	u8			module_status;
+	u8			active_fec_sig_mode;
+	u16			fec_cfg;
+#define BNGE_FEC_NONE		PORT_PHY_QCFG_RESP_FEC_CFG_FEC_NONE_SUPPORTED
+#define BNGE_FEC_AUTONEG_CAP	PORT_PHY_QCFG_RESP_FEC_CFG_FEC_AUTONEG_SUPPORTED
+#define BNGE_FEC_AUTONEG	PORT_PHY_QCFG_RESP_FEC_CFG_FEC_AUTONEG_ENABLED
+#define BNGE_FEC_ENC_BASE_R_CAP	\
+	PORT_PHY_QCFG_RESP_FEC_CFG_FEC_CLAUSE74_SUPPORTED
+#define BNGE_FEC_ENC_BASE_R	PORT_PHY_QCFG_RESP_FEC_CFG_FEC_CLAUSE74_ENABLED
+#define BNGE_FEC_ENC_RS_CAP	\
+	PORT_PHY_QCFG_RESP_FEC_CFG_FEC_CLAUSE91_SUPPORTED
+#define BNGE_FEC_ENC_LLRS_CAP	\
+	(PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS272_1XN_SUPPORTED |	\
+	 PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS272_IEEE_SUPPORTED)
+#define BNGE_FEC_ENC_RS		\
+	(PORT_PHY_QCFG_RESP_FEC_CFG_FEC_CLAUSE91_ENABLED |	\
+	 PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS544_1XN_ENABLED |	\
+	 PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS544_IEEE_ENABLED)
+#define BNGE_FEC_ENC_LLRS	\
+	(PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS272_1XN_ENABLED |	\
+	 PORT_PHY_QCFG_RESP_FEC_CFG_FEC_RS272_IEEE_ENABLED)
+
+	bool			phy_retry;
+	unsigned long		phy_retry_expires;
+
+	/* a copy of phy_qcfg output used to report link
+	 * info to VF
+	 */
+	struct hwrm_port_phy_qcfg_output phy_qcfg_resp;
+};
+
+struct bnge_ethtool_link_info {
+	/* copy of requested setting from ethtool cmd */
+	u8			autoneg;
+#define BNGE_AUTONEG_SPEED		1
+#define BNGE_AUTONEG_FLOW_CTRL		2
+	u8			req_signal_mode;
+#define BNGE_SIG_MODE_NRZ	PORT_PHY_QCFG_RESP_SIGNAL_MODE_NRZ
+#define BNGE_SIG_MODE_PAM4	PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4
+#define BNGE_SIG_MODE_PAM4_112	PORT_PHY_QCFG_RESP_SIGNAL_MODE_PAM4_112
+#define BNGE_SIG_MODE_MAX	(PORT_PHY_QCFG_RESP_SIGNAL_MODE_LAST + 1)
+	u8			req_duplex;
+	u8			req_flow_ctrl;
+	u16			req_link_speed;
+	u16			advertising;	/* user adv setting */
+	u16			advertising_pam4;
+	bool			force_link_chng;
+};
+
+void bnge_hwrm_set_eee(struct bnge_dev *bd,
+		       struct hwrm_port_phy_cfg_input *req);
+void bnge_hwrm_set_link_common(struct bnge_net *bn,
+			       struct hwrm_port_phy_cfg_input *req);
+void bnge_hwrm_set_pause_common(struct bnge_net *bn,
+				struct hwrm_port_phy_cfg_input *req);
+int bnge_update_phy_setting(struct bnge_net *bn);
+void bnge_get_port_module_status(struct bnge_net *bn);
+void bnge_report_link(struct bnge_dev *bd);
+bool bnge_support_speed_dropped(struct bnge_net *bn);
+void bnge_init_ethtool_link_settings(struct bnge_net *bn);
+u32 bnge_fw_to_ethtool_speed(u16 fw_link_speed);
+int bnge_probe_phy(struct bnge_net *bd, bool fw_dflt);
+bool bnge_phy_qcaps_no_speed(struct hwrm_port_phy_qcaps_output *resp);
+#endif /* _BNGE_LINK_H_ */
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 832eeb960bd..4172278900b 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2192,7 +2192,25 @@ static int bnge_open_core(struct bnge_net *bn)
 		netdev_err(bn->netdev, "bnge_init_nic err: %d\n", rc);
 		goto err_free_irq;
 	}
+
+	mutex_lock(&bd->link_lock);
+	rc = bnge_update_phy_setting(bn);
+	mutex_unlock(&bd->link_lock);
+	if (rc) {
+		netdev_warn(bn->netdev, "failed to update phy settings\n");
+		if (BNGE_SINGLE_PF(bd)) {
+			bd->link_info.phy_retry = true;
+			bd->link_info.phy_retry_expires =
+				jiffies + 5 * HZ;
+		}
+	}
+
 	set_bit(BNGE_STATE_OPEN, &bd->state);
+
+	/* Poll link status and check for SFP+ module status */
+	mutex_lock(&bd->link_lock);
+	bnge_get_port_module_status(bn);
+	mutex_unlock(&bd->link_lock);
 	return 0;
 
 err_free_irq:
@@ -2461,6 +2479,10 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bnge_init_l2_fltr_tbl(bn);
 	bnge_init_mac_addr(bd);
 
+	rc = bnge_probe_phy(bn, true);
+	if (rc)
+		goto err_netdev;
+
 	netdev->request_ops_lock = true;
 	rc = register_netdev(netdev);
 	if (rc) {
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index fb3b961536b..85c4f6f5371 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -8,6 +8,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/refcount.h>
 #include "bnge_db.h"
+#include "bnge_link.h"
 
 struct tx_bd {
 	__le32 tx_bd_len_flags_type;
@@ -231,6 +232,8 @@ struct bnge_net {
 	u8			rss_hash_key_updated:1;
 	int			rsscos_nr_ctxs;
 	u32			stats_coal_ticks;
+
+	struct bnge_ethtool_link_info	eth_link_info;
 };
 
 #define BNGE_DEFAULT_RX_RING_SIZE	511
-- 
2.47.3


