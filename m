Return-Path: <netdev+bounces-286788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGzRGJofAmrAoAEAu9opvQ
	(envelope-from <netdev+bounces-286788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:27:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFCF514696
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D13D33019886
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD8447ECFD;
	Mon, 11 May 2026 18:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MESTEDx9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633C047DD72
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523973; cv=none; b=grkaaq0WHDX+aO5VEcLL8jWQmvcOuPG/u93WOe7erhSOjHgcCls7B7uTOII/xpDO9zOqiCTUTZkmj6XvKmXLR5v3InMnEdCydW4pHZiFzWNEz1kU5t0bOOUr4kYuBR3a/ON6hAHm/uBYDTqpUSfkLBSOl+c0iAuC4lZFK1wx5HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523973; c=relaxed/simple;
	bh=xoHMDWCFTSWyp3aBg4y+YZIB2hZX8iQkmdTvgMWUAZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zq58L1X/0K9DrrDAMH+P6RO0PfLatofZRrHa/4TWdflW0ug2k+fa/c7SPhDfGygta7F7gsOVQ9uh6IOQm1LByZ+drZ+L7Y5OSmDsjWFSG1fzFLcrh3KPP6EUAGCtAhEz4UkGm46dKZ3lKmB7TL0Ank+f2O47ErzGTYZ8tZeEnco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MESTEDx9; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-900fa9f178dso502324485a.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 11:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523970; x=1779128770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlZDG9AXqyTKh8LYQTP8pOzQ0gI9zF6LBr6ESWvufs4=;
        b=MESTEDx9ITox0/NVJbsjWUN23veTlCoh7nyRKqd8MKqK6/m6WR5KBSHi6elaAUIbeC
         E84Vd8IbwRjfs7JP9cfK7g29SZgc2w6q4S/5sNjlh3dwJnJIb+Yx5C1B9eZlVW+V55jT
         YZ25cJTWq9MPSzI+VZTU0mItCYVJGF+nH8yBztK8yHScUIaL5lP1Yg+yOepR9YN0RbaF
         1KQ/9NdWSO4Zaycx6J3o3JtXfhEMlGY4ekl20PlNc9i4YW4nOqDOibyk67j6GvqVIpoF
         HwGA9q95R73+JnL8faPVlzfjlvMmghBJpQkRi/ipnCDqxAojXMo+5Wml/a0q9FBxuV3I
         zS0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523970; x=1779128770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jlZDG9AXqyTKh8LYQTP8pOzQ0gI9zF6LBr6ESWvufs4=;
        b=dMekJkYY8CYUvq+eUJu43ZNGlHAvv2HEXR6uee2Q6buGPcY3G6h7ZX0h2ltLNkNz7x
         ugx0nq9YQzPTScTvNJp6tyIlsHAC104Aw6v2VJGcH4A61tEQnkeQy8R0oj0XmAoyb1HC
         kvqBPGvoiu0acCkPY7OEDYybJcvpcpEX/5E16o717ME9j0kbo/hz3rpWUtIRKFwijGFn
         vlXQxCs+ObQI12R5ytnabtsWyUxm3yb3qkkiftvG61huA3x9ARl/smitegWuoto1wbe/
         bAnsqy0Swq1anq7fSBGJwyPSW3uPyFV79+f7d26sjGwvNsdetT1zRqnsvBM0iIDz5U3D
         pD6A==
X-Forwarded-Encrypted: i=1; AFNElJ+Hi/cZMghD5WpEOXDWzHH8NTKuCcG6aAOjoPvXncoOTZKpAVpz+SZ6ffvK5NG4bZCmyD1bx1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoSm0jp31VNXjBWVs5ZzwrkJa3Si9BZUBRDsPgF88AffplWm0K
	k5Ft/BCuAABKuTA7ojVPDZPjqCxlx7Oqr2M8qUPiU8YQ07figFgHWzP6
X-Gm-Gg: Acq92OHqf1mEzBQK/4MhJihLowkqEe3C4f9FU9XzpL1V0wiqZfHNzGJ5WOHGp1MoGOv
	iYDCdgXDPvns5X8MHL5SKIrw46DQrZdDMdyfyFzxQwyb2R6uLkCqOFSJjZbF18miYJ4pR4J//Br
	oDarLL8RuilgTU7VGokXV3l42bLIeeuT8R5NFEJvWftNczd85Ywb3CKwIWXd86fL++tMqksrJ4C
	G19ArvrA0IgN2Qn9Uk6OFcog4BO6iD/kd4SiSrFX59NsgdlBVo1yapOHNeyBl7Dd7uNPgbeXBCm
	z41/GrHFgCUs+KQYEv2D2oRlJ0+2XvSAzWYloDyArTpj3E/vc5sgMNx2P1n40Qu8fAxhnNziKPE
	ADHQeEbLjQ6b5dWqErtBTGeaIOQtfY3JkEQHbhJCdufFCcA+oKJq22bw9OW4XTezb0Q7aaODKg1
	1a5dYMc1Es5eF9jMaMhM6/DGCRQ8jfkMKHuAexH24nKB0MvDSC0GgCVH8v
X-Received: by 2002:a05:620a:2949:b0:908:a0e2:289f with SMTP id af79cd13be357-9090ebc2bd7mr1568419085a.18.1778523970057;
        Mon, 11 May 2026 11:26:10 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8d9ea06sm1111346885a.20.2026.05.11.11.26.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:26:08 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Kees Cook <kees@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] net: pcs: xpcs: Add handling for 4 channel rsfec device
Date: Mon, 11 May 2026 14:26:04 -0400
Message-ID: <20260511182604.1338-3-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260511182604.1338-1-mike.marciniszyn@gmail.com>
References: <20260511182604.1338-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1CFCF514696
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286788-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.939];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

This patch introduces the configuration of vendor specific
registers for alignment encoding, PCS Mode, and VL_INTVL
over the one or two instances as required.

The DW_PCS IP specification calls out the need to configure both
lanes identically when using 2 lane modes such as 50-R2 and 100-R2, so
the programming is repeated for each lane.

The encoding tables are derived from the IEEE 8023-2022 spec sections
82.2.7 and tables 82-2 and 82-3 for the alignment markers and their
insertion.

Note that there is a conflict between VRs DW_VR_XS_PCS_DIG_STS and
and the DW_PCS_IP DW_VR_MII_PCS_PCS_MODE.  The bit mask for
DW_VR_XS_PCS_DIG_STS/RX_FIFO_ERR fits within the reserved bits for
the DW_PCS IP the DW_VR_MII_PCS_PCS_MODE register so there is no issue.

There is also a confict between DW_VR_MII_PCS_VL_INTVL and
DW_VR_MII_AN_INTR_STS but an_mode differs, so again there is no issue.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v2:
  - Replace xpcs_write_pcs_prtad() wiht xpcs_write_pcs_mdev() to
    avoid hardcoded prtaddr value
v1: https://lore.kernel.org/all/20260506190904.4029-3-mike.marciniszyn@gmail.com/

 drivers/net/pcs/pcs-xpcs.c | 91 +++++++++++++++++++++++++++++++++++++-
 drivers/net/pcs/pcs-xpcs.h | 25 +++++++++++
 2 files changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 14f89e56958c..42d64f7ebf34 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1423,9 +1423,39 @@ static int xpcs_get_pma_mmd(struct dw_xpcs *xpcs)
 	return -ENODEV;
 }
 
+/* m0 - m2 from Table 82-2/82-3
+ * m4 - m6 are skipped since they are inversions of m0 - m2.
+ * Inverted parity fields (IEEE 82.2.8) bip3 and bip7 are omitted.
+ */
+struct lane_markers {
+	u8 m0, m1, m2;
+};
+
+/* Alignment marker encodings, see table 82-2 in IEEE 802.3-2022 */
+static const struct lane_markers xpcs_100gbaser_markers[] = {
+	{0xc1, 0x68, 0x21},
+	{0x9d, 0x71, 0x8e},
+	{0x59, 0x4b, 0xe8},
+	{0x4d, 0x95, 0x7b},
+};
+
+/* Alignment marker encodings, see table 82-3 in IEEE 802.3-2022
+ * The content of the 50G markers is identical to 40G values (IEEE 133.2.2).
+ */
+static const struct lane_markers xpcs_50gbaser_markers[] = {
+	{0x90, 0x76, 0x47},
+	{0xf0, 0xc4, 0xe6},
+	{0xc5, 0x65, 0x9b},
+	{0xa2, 0x79, 0x3d},
+};
+
 struct pma_pcs_values {
+	const struct lane_markers *vl0_markers;
+	const struct lane_markers *vl123_markers;
 	int lanes;
 	u16 rsfec_ctrl;
+	u16 pcs_mode;
+	u16 vl_intvl;
 };
 
 static struct mdio_device *xpcs_find_first_mdev(struct dw_xpcs *xpcs)
@@ -1448,11 +1478,38 @@ xpcs_find_next_mdev(struct dw_xpcs *xpcs, struct mdio_device *mdev)
 	return &n->mdio;
 }
 
+#define XPCS_VL_TO_REG(vl, lh) \
+	(((vl) * 2) + DW_VR_MII_PCS_VL0_##lh)
+
+static int
+xpcs_write_pcs_mdev(struct mdio_device *mdev, int reg, u16 val)
+{
+	return mdiodev_c45_write(mdev, MDIO_MMD_PCS, reg, val);
+}
+
+static int
+xpcs_config_vl_markers(struct dw_xpcs *xpcs, int vl, struct mdio_device *mdev,
+		       const struct lane_markers *m)
+{
+	int ret;
+
+	/* m0, m1, m2 written to _L and _H registers
+	 *
+	 * _L = (m1 << 8) | m0
+	 * _H = m2
+	 */
+	ret = xpcs_write_pcs_mdev(mdev, XPCS_VL_TO_REG(vl, L),
+				  ((u16)m->m1 << 8) | m->m0);
+	if (ret < 0)
+		return ret;
+	return xpcs_write_pcs_mdev(mdev, XPCS_VL_TO_REG(vl, H), m->m2);
+}
+
 static int
 xpcs_config_rsfec_pma(struct dw_xpcs *xpcs, const struct pma_pcs_values *v)
 {
+	int ret = 0, i, vl, pma_mmd;
 	struct mdio_device *mdev;
-	int ret = 0, i, pma_mmd;
 
 	pma_mmd = xpcs_get_pma_mmd(xpcs);
 	if (pma_mmd < 1)
@@ -1464,6 +1521,23 @@ xpcs_config_rsfec_pma(struct dw_xpcs *xpcs, const struct pma_pcs_values *v)
 
 	for (i = 0; mdev && ret >= 0 && i < v->lanes;
 	     i++, mdev = xpcs_find_next_mdev(xpcs, mdev)) {
+		/* code word markings */
+		for (vl = 0; mdev && ret >= 0 && vl < 4; vl++)
+			ret = xpcs_config_vl_markers(xpcs, vl, mdev,
+						     !vl ? &v->vl0_markers[0] :
+						     &v->vl123_markers[vl - 1]);
+		if (ret < 0)
+			break;
+		/* vendor registers */
+		ret = xpcs_write_pcs_mdev(mdev, DW_VR_MII_PCS_VL_INTVL,
+					  v->vl_intvl);
+		if (ret < 0)
+			break;
+		ret = xpcs_write_pcs_mdev(mdev, DW_VR_MII_PCS_PCS_MODE,
+					  v->pcs_mode);
+		if (ret < 0)
+			break;
+		/* rsfec register */
 		ret = mdiodev_c45_write(mdev, pma_mmd, MDIO_PMA_RSFEC_CTRL,
 					v->rsfec_ctrl);
 	}
@@ -1478,6 +1552,13 @@ static int xpcs_25gbaser_pma_config(struct dw_xpcs *xpcs)
 	const struct pma_pcs_values v = {
 		.rsfec_ctrl = 0,
 		.lanes = 1,
+		/* 25g markers from 100g and 50g tables per 802.3-2022
+		 * 108.5.2.4
+		 */
+		.vl0_markers = &xpcs_100gbaser_markers[0],
+		.vl123_markers = &xpcs_50gbaser_markers[1],
+		.vl_intvl = 20479,
+		.pcs_mode = DW_VR_MII_PCS_MODE_CLAUSE107,
 	};
 
 	return xpcs_config_rsfec_pma(xpcs, &v);
@@ -1488,6 +1569,10 @@ static int xpcs_50gbaser_pma_config(struct dw_xpcs *xpcs)
 	const struct pma_pcs_values v = {
 		.rsfec_ctrl = DW_VR_RSFEC_CTRL_TC_PAD_ALTER,
 		.lanes = 2,
+		.vl0_markers = &xpcs_50gbaser_markers[0],
+		.vl123_markers = &xpcs_50gbaser_markers[1],
+		.pcs_mode = 0,
+		.vl_intvl = 20479,
 	};
 
 	return xpcs_config_rsfec_pma(xpcs, &v);
@@ -1498,6 +1583,10 @@ static int xpcs_100gbasep_pma_config(struct dw_xpcs *xpcs)
 	const struct pma_pcs_values v = {
 		.rsfec_ctrl = MDIO_PMA_RSFEC_CTRL_4LANE_PMD,
 		.lanes = 2,
+		.vl0_markers = &xpcs_100gbaser_markers[0],
+		.vl123_markers = &xpcs_100gbaser_markers[1],
+		.pcs_mode = DW_VR_MII_PCS_MODE_DISABLE_MLD,
+		.vl_intvl = 16383,
 	};
 
 	return xpcs_config_rsfec_pma(xpcs, &v);
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 187cdec30e70..8161d75370e6 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -100,6 +100,31 @@
  */
 #define DW_VR_RSFEC_CTRL_TC_PAD_ALTER	BIT(10)
 
+/* Vendor specific 4 channel PCS registers */
+
+/* DW_VR_MII_PCS_VL_INTVL and DW_VR_MII_AN_INTR_STS conflict
+ * but code paths are different
+ */
+#define DW_VR_MII_PCS_VL_INTVL		0x8002
+/* 0x8008 - 0x800f */
+#define DW_VR_MII_PCS_VL0_L		0x8008
+#define DW_VR_MII_PCS_VL0_H		0x8009
+#define DW_VR_MII_PCS_PCS_MODE		0x8010
+
+/* DW_VR_MII_PCS_PCS_MODE bits */
+#define DW_VR_MII_PCS_MODE_HI_BER25		BIT(2)
+#define DW_VR_MII_PCS_MODE_DISABLE_MLD		BIT(1)
+#define DW_VR_MII_PCS_MODE_CLAUSE49		BIT(0)
+
+/* 25G requires these two bits are set.
+ *
+ * The CLAUSE49 bit changes the interface with the MAC
+ * to 64 bit and the BER25 bit changes the measurement
+ * interval to 2ms.
+ */
+#define DW_VR_MII_PCS_MODE_CLAUSE107 \
+	(DW_VR_MII_PCS_MODE_HI_BER25 | DW_VR_MII_PCS_MODE_CLAUSE49)
+
 #define DW_XPCS_INFO_DECLARE(_name, _pcs, _pma)				\
 	static const struct dw_xpcs_info _name = { .pcs = _pcs, .pma = _pma }
 
-- 
2.43.0


