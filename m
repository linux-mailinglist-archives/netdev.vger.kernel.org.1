Return-Path: <netdev+bounces-272685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kMhtNEzsxmkIQQUAu9opvQ
	(envelope-from <netdev+bounces-272685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:45:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E84C34B3BD
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D25FE304CF53
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7E13939B4;
	Fri, 27 Mar 2026 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZUBGCo3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA03392C34
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774644288; cv=none; b=ie8vjju5AzfcIuRrihurqS2HHhBi79f/ISSAq0JrmlYDGkJ8pJMfbcp18/eDvbulw67ZAeaTVpFVlLackAAbCE2TQFF15agl0ka8waw9/pe/8Cb6i5FSHFp9n2PcUk86eYSfUAGNkISKejqILulObbNnSgm8W6XKOhtfHLvzUpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774644288; c=relaxed/simple;
	bh=5BuGymhJ2SueICkDMHULqDUp+FweVGD5zC7CgfMl/TA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q2kMYHYyaDf/Ul2+6eoX5o5aOnaUc8MW4qX/llQuud0Kg0wdt0sYO8bCW4FtL5FKd3Y6faV695YPRJpkHvI4tjGJBWa0PxSFWwAMdY7+9N2NhFu0P9F5Cu+HYKm1K13YpV3ObjaqJJvCB/W61Yc+39WLK1tH8YawvRqjP69Xrxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZUBGCo3; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-82a7ebc729dso1177485b3a.3
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774644286; x=1775249086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u1RGoVUYCYgEkpIIr1krzGHx69IUyqzZSta5UxOBMJk=;
        b=DZUBGCo3nwV/ghqalbjXDs25eQlD2iInVIyxC/v43Ie0iWCus57Lm/Mvr0sxtnAaRK
         1aUWwMt/uYfU7PWlygIQRu+DR9pyoMnrGz2ai7M3i+wJArd0W/vqPZruoltWrgHTn9ci
         9l7b0XY6mjxjS1ulOT87aEcHTgZdCAiQU2c87vHFjeHG1QoslKkn6u4SOYyeA70tsL2g
         F7IPh+Gci+9GKSlMvuhiqSIeGzNS2IjZ7abyd39lpEG63Py3chyPR1fCzo1S883TdQnJ
         z49F3sBzdiZf8QnqPh8Pub81RfLe9Da6x1BuuZqdiL8fe/Dfd2rYMKae7/eKUb9ar7nn
         jtBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774644286; x=1775249086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u1RGoVUYCYgEkpIIr1krzGHx69IUyqzZSta5UxOBMJk=;
        b=kyL8P0xZn6wuVDDuJmn7GDdCdlxjZE3W3h1X5kYnmMJdhKnCM0sw0wMrKHyhkM2Uny
         pNOW0eig0cBGvMEcaxD9JLdcWREXDXEbUJyf3hQBJPw9LOrVVz20LpR4H0qZU7ZzPpfL
         izVpCokmRT/X7CuwUPOsicmyRL5VWzDqh49Nmk/UA0VFKR3fZJ/uNMu0z/WjRCThOzP5
         ilIP9nbbakQ0vhB65eN+1gw5L9QebleVsycZ9KFXcnDxA848KAFaoVd17D2l3Zt6XuLg
         JmHLdA3PBug06SUqEiC39BZ0L1xN4e1qAjFbr3tMB5ISEkwvKVSF7U/Ksf5Zfc9EO2g/
         dTow==
X-Forwarded-Encrypted: i=1; AJvYcCVNZ2S6nFAYRSB+rS1yS6Zl2Oe7AG9OgUNpC5yBxhFTdMCe87EHULiu/uEGTo67mH3TB6Z2LHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHBfPJ0DGBjDtZt1gGFc2P+EzjvoMG/mNOKObUxiM7u/gvFoFp
	szONaP128H6RFyskMrw9pTBwBLrFLD5HIobStcRmDKntoMJPH1x1WTjL
X-Gm-Gg: ATEYQzzv3m3tKQ9C377PU5hss1555kA0+o1v4V5AnKINZjdG9YQXdpfI9kEOclnIkyz
	CFfS9milP9V0VyrpRGm0QYK1qFnoFjlDWLl8blSEgw1hLccWiD+9159TMRUVhjxazyOG3Dg5aKr
	Ik3DbHdPMN9tK6mJsPcc1fpg5gm68n8Ihz7YEHZlrDehOmWO7Mh5wDQLh9CGK/TZHN1RzLMsEjp
	On744OHFKeamEIU8WUrhLC1RHr7B5IZk36gCDT1FQOi8IKR3BP9cGRzkTyXxa3F13wMdI0ioGs1
	l8DBAm1IB52Jq+xLerBOB9dk1RZVGF+sgkgThlcdshadL/bB53YMkYEFv2d8d+kR/9ZO1+w29nB
	XHFZW5R0rXGRkLAj1Y+j+eWq1zRMHVSHbxkkJwbeWLOQPvvbh4o2+fctL1jwKa2zjTSWh4NKGBm
	6ZN4bZGCUu2+l69A5qeZ6g0ldgqZOIDHDjid34Wy4=
X-Received: by 2002:a05:6a00:138e:b0:82c:213b:123f with SMTP id d2e1a72fcca58-82c95ee5fc2mr3952515b3a.31.1774644286307;
        Fri, 27 Mar 2026 13:44:46 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85d019dsm110819b3a.29.2026.03.27.13.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:44:45 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Lee Trager <lee@trager.us>,
	Mike Marciniszyn <mike.marciniszyn@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] fbnic: Set Relaxed Ordering PCIe TLP attributes for DMA engines
Date: Fri, 27 Mar 2026 13:44:45 -0700
Message-ID: <20260327204445.3074446-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-272685-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[fb.com,kernel.org,meta.com,lunn.ch,google.com,redhat.com,intel.com,gmail.com,trager.us,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fb.com:email,meta.com:email]
X-Rspamd-Queue-Id: 7E84C34B3BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alexander Duyck <alexanderduyck@fb.com>

Add ATTR CSR bit field definitions for the DMA engine TLP header
configuration registers:
  AW_CFG: RDE_ATTR[17:15], RQM_ATTR[14:12], TQM_ATTR[11:9]
  AR_CFG: TDE_ATTR[17:15], RQM_ATTR[14:12], TQM_ATTR[11:9]

These fields control the PCIe TLP attribute bits for outbound
transactions from the TQM, RQM, RDE (write path), and TDE (read path)
DMA engines. An enum is added with standard PCIe TLP attribute values:
NS (No Snoop), RO (Relaxed Ordering), and IDO (ID-based Ordering).

Read the PCIe Relaxed Ordering capability at probe time and store it in
fbnic_dev. Configure Relaxed Ordering on the PCIe TLP attributes in
fbnic_mbx_init_desc_ring when the capability is enabled. For the write
path (AW_CFG), set RO on RDE and TQM attributes. For the read path
(AR_CFG), set RO on all three attributes (TDE, RQM, TQM). This allows
the PCIe fabric to reorder these transactions for improved throughput.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic.h         |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h     | 12 ++++++++++++
 drivers/net/ethernet/meta/fbnic/fbnic_devlink.c |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c      | 15 +++++++++++++--
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
index f7df5302e91a..d0715695c43e 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
@@ -57,6 +57,7 @@ struct fbnic_dev {
 	u64 dsn;
 	u32 mps;
 	u32 readrq;
+	u8 relaxed_ord;
 
 	/* Local copy of the devices TCAM */
 	struct fbnic_act_tcam act_tcam[FBNIC_RPC_TCAM_ACT_NUM_ENTRIES];
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 43de522af172..81794bd326e1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -975,9 +975,21 @@ enum {
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG	0x3103d		/* 0xc40f4 */
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH	CSR_BIT(19)
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME		CSR_BIT(18)
+#define FBNIC_PUL_OB_TLP_HDR_AW_CFG_RDE_ATTR	CSR_GENMASK(17, 15)
+#define FBNIC_PUL_OB_TLP_HDR_AW_CFG_RQM_ATTR	CSR_GENMASK(14, 12)
+#define FBNIC_PUL_OB_TLP_HDR_AW_CFG_TQM_ATTR	CSR_GENMASK(11, 9)
+enum {
+	FBNIC_TLP_ATTR_NS	= 1,
+	FBNIC_TLP_ATTR_RO	= 2,
+	FBNIC_TLP_ATTR_IDO	= 4,
+};
+
 #define FBNIC_PUL_OB_TLP_HDR_AR_CFG	0x3103e		/* 0xc40f8 */
 #define FBNIC_PUL_OB_TLP_HDR_AR_CFG_FLUSH	CSR_BIT(19)
 #define FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME		CSR_BIT(18)
+#define FBNIC_PUL_OB_TLP_HDR_AR_CFG_TDE_ATTR	CSR_GENMASK(17, 15)
+#define FBNIC_PUL_OB_TLP_HDR_AR_CFG_RQM_ATTR	CSR_GENMASK(14, 12)
+#define FBNIC_PUL_OB_TLP_HDR_AR_CFG_TQM_ATTR	CSR_GENMASK(11, 9)
 #define FBNIC_PUL_USER_OB_RD_TLP_CNT_31_0 \
 					0x3106e		/* 0xc41b8 */
 #define FBNIC_PUL_USER_OB_RD_DWORD_CNT_31_0 \
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
index f1c992f5fe94..546e1c12d287 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_devlink.c
@@ -647,6 +647,7 @@ struct fbnic_dev *fbnic_devlink_alloc(struct pci_dev *pdev)
 	fbd->dsn = pci_get_dsn(pdev);
 	fbd->mps = pcie_get_mps(pdev);
 	fbd->readrq = pcie_get_readrq(pdev);
+	fbd->relaxed_ord = pcie_relaxed_ordering_enabled(pdev);
 
 	fbd->mac_addr_boundary = FBNIC_RPC_TCAM_MACDA_DEFAULT_BOUNDARY;
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index c2bad51bdde6..0c6812fcf185 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -448,6 +448,7 @@ static int fbnic_fw_xmit_simple_msg(struct fbnic_dev *fbd, u32 msg_type)
 
 static int fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 {
+	u8 tlp_attr = fbd->relaxed_ord ? FBNIC_TLP_ATTR_RO : 0;
 	struct fbnic_fw_mbx *mbx = &fbd->mbx[mbx_idx];
 
 	mbx->ready = true;
@@ -456,14 +457,24 @@ static int fbnic_mbx_init_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 	case FBNIC_IPC_MBX_RX_IDX:
 		/* Enable DMA writes from the device */
 		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AW_CFG,
-		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME);
+		     FBNIC_PUL_OB_TLP_HDR_AW_CFG_BME |
+		     FIELD_PREP(FBNIC_PUL_OB_TLP_HDR_AW_CFG_RDE_ATTR,
+				tlp_attr) |
+		     FIELD_PREP(FBNIC_PUL_OB_TLP_HDR_AW_CFG_TQM_ATTR,
+				tlp_attr));
 
 		/* Make sure we have a page for the FW to write to */
 		return fbnic_mbx_alloc_rx_msgs(fbd);
 	case FBNIC_IPC_MBX_TX_IDX:
 		/* Enable DMA reads from the device */
 		wr32(fbd, FBNIC_PUL_OB_TLP_HDR_AR_CFG,
-		     FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME);
+		     FBNIC_PUL_OB_TLP_HDR_AR_CFG_BME |
+		     FIELD_PREP(FBNIC_PUL_OB_TLP_HDR_AR_CFG_TDE_ATTR,
+				tlp_attr) |
+		     FIELD_PREP(FBNIC_PUL_OB_TLP_HDR_AR_CFG_RQM_ATTR,
+				tlp_attr) |
+		     FIELD_PREP(FBNIC_PUL_OB_TLP_HDR_AR_CFG_TQM_ATTR,
+				tlp_attr));
 		break;
 	}
 
-- 
2.52.0


