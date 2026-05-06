Return-Path: <netdev+bounces-285005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKODEuSR+2lJcwMAu9opvQ
	(envelope-from <netdev+bounces-285005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:09:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 355444DF9BD
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 797E63007A6A
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 19:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FB4313558;
	Wed,  6 May 2026 19:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZOg9p9O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4B330DEBA
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778094551; cv=none; b=Fs+1neX27fcQ5NwBDPesZomCnhHgUJ1lRZGnWHZKdyFznSBCPZcS0SHTQVpxtVWpAXEEK2LCrgA7drft2FvgGVakHafkTPmeTe5yxxTAFnHPw3/iLMVtQfwv3s4cM42qm2U9UOJ8DD45MyUQrDniupJ5Zq4Af32WZ2Ydeg+4Td4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778094551; c=relaxed/simple;
	bh=Wqj6Yz67iE9Ok+wJC8tz2MHMdpWmQX+GsmU1u2KkQkk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgmBffelOba66NYO78DzXrgE4W7CycMdf1SCyik9SDT4iQNbxYI+1JFjdijAovvZcLXUK6kW3VcjdgM055LAbe/UcGsYGJZkfKBydPQ+J4rX6Vjyk+Bw6QGDI9YZhS/PqpME0JFbfKLSAcH6hRGyFwBv+ZDM6okT77im81jhnEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZOg9p9O; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-50d6ab4476eso67486421cf.2
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 12:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778094549; x=1778699349; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=miWAgzkhPxRPUhdzmqfb98aKwIPZoZcraPxTFPB+VJc=;
        b=gZOg9p9O4ej6QQp2Ovb0xWMo9VxanAR5lMOkURGSCb4ehVvK0Dq0TJQ4kebY3e9CW1
         epBBGd9v6XR0Gjmq8b2mTi5six+jbYOKYEbsdVg0gmvY7IPC6UsqzBCZy3eI3plinTfm
         UflgChPYMJ4iaJ/0yfVEHSx915yNuKagqbD2n96Au+0eVc/qmzfn2Y8FI4jHV+OYMZJG
         g7qs3BRaw7M3NCM/ALiaDYe+/5kf2KdCQVd8rc3Wi+XCjIN2uzQopju3t6bTx2xZOE4k
         CcrUZNeVWaYrSn2+WtFmfHIzMN6z3kq8o1F988e/Lhji6kZqSRHG6GdPz+/bgnWFtRtM
         yGGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778094549; x=1778699349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=miWAgzkhPxRPUhdzmqfb98aKwIPZoZcraPxTFPB+VJc=;
        b=AHhWOV7MGUk2WWhMToi4ijdNpLjfXB6atoCuDgb7nAQdULfIs8Rc9383xurQn6v9aM
         lrbGQzByuG6sQHm746QikX7T0qiz+oA36LikYRdxiyrwOkD7J3aYX6NmlDCANWKmuiQi
         3VjmAwJJaaxoDusPJRSYRnaeRp7UoRgjXucEXi/V/TfYYR29Gs8flPCzS0VUSgkwNnP4
         vUmkWp9YrSrF9m6R9L0EB6lLzllmu2XGoJluaI5CEeHBwF4P9T48weLuV2gYTo2IxDOM
         pWBCDgUVxB93UJYRhu7oibEgqDIPaTV6sn+L1isrNbs0aC5CV/+mfcF3rC4CbzW4BAHG
         BJmQ==
X-Forwarded-Encrypted: i=1; AFNElJ/KpuzTlP6Rr1mYh4r0t0WjtZNlwCowQ41iErMpe/MFi4t7Kipu32pXhM6rQ+YRRCpeix8oRjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0V4sK3M3xjGZanjy/ksvYE5FY/wzF8tPQ+/9kZ6gQH4loCQN5
	aexErtq6EVmnryXuxuo26SlJAYg7hQ6OtezrccDpsBYKqXtPMEOJXdXT
X-Gm-Gg: AeBDietLMzB/WQO8x0/Hfk0pewVHC4PWAC02/XrQXNuXHE4GWtV3rEz3o1eWbB1j75w
	/zEOYMU7YYmVo44imjmNmCB9EkPXxl8HL4skmFxJSkl7d/kCjtovESHiH5gepZg2/qGwTeOE8BX
	4eAHYSaSCxjLdMkeUySAbX/mte2knP654DDN0Ms24vridgVairwCn4Fuyg8QSFr7Dfj7zbA9zOQ
	I55y6HzuQPHolC5XPYCrTBWidK/3Pr54pD869XzB/dyVXOkRM3xn13lNxhEnsfgYngbBc9Yu1VB
	2J2C7lh5YtUgzJMWQTc1RrxdTLWpus/gSz89qtoiHW05wWBll+BiI1zSz/aVwJGO0xwYvNPgbj4
	x26DAf8OIiO7tVoS+B4ZBgBKSFp/aF7P7xfweHmMcL+z93e/YsiwrzrQ6BzTTzLvw0EzfI+mDZJ
	ooDchTLmhmNTfkYQvM2+g4G5ynPHzMCXGCDCg5pNDJSyX06xB8gcYJ08E8q8Ue2ZYgKUw=
X-Received: by 2002:a05:622a:4ac7:b0:50b:4e4e:1a20 with SMTP id d75a77b69052e-514621c747cmr69868341cf.59.1778094548753;
        Wed, 06 May 2026 12:09:08 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5104090bb03sm157489421cf.10.2026.05.06.12.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:09:08 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Kees Cook <kees@kernel.org>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: pcs: xpcs: Add handling for 4 channel rsfec device
Date: Wed,  6 May 2026 15:09:04 -0400
Message-ID: <20260506190904.4029-3-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506190904.4029-1-mike.marciniszyn@gmail.com>
References: <20260506190904.4029-1-mike.marciniszyn@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 355444DF9BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285005-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,fb.com];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fb.com:email]

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
 drivers/net/pcs/pcs-xpcs.c | 90 +++++++++++++++++++++++++++++++++++++-
 drivers/net/pcs/pcs-xpcs.h | 25 +++++++++++
 2 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 0987621632a7..c42eacafad91 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1429,21 +1429,94 @@ static int xpcs_get_pma_mmd(struct dw_xpcs *xpcs)
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
 
+#define XPCS_VL_TO_REG(vl, lh) \
+	(((vl) * 2) + DW_VR_MII_PCS_VL0_##lh)
+
+static int xpcs_write_pcs_prtad(struct dw_xpcs *xpcs, int prtad, int reg,
+				u16 val)
+{
+	return xpcs_bus_write(xpcs, prtad, MDIO_MMD_PCS, reg, val);
+}
+
+static int xpcs_config_vl_markers(struct dw_xpcs *xpcs, int vl, int addr,
+				  const struct lane_markers *m)
+{
+	int ret;
+
+	/* m0, m1, m2 written to _L and _H registers
+	 *
+	 * _L = (m1 << 8) | m0
+	 * _H = m2
+	 */
+	ret = xpcs_write_pcs_prtad(xpcs, addr, XPCS_VL_TO_REG(vl, L),
+				   ((u16)m->m1 << 8) | m->m0);
+	if (ret < 0)
+		return ret;
+	return xpcs_write_pcs_prtad(xpcs, addr, XPCS_VL_TO_REG(vl, H), m->m2);
+}
+
 static int
 xpcs_config_rsfec_pma(struct dw_xpcs *xpcs, const struct pma_pcs_values *v)
 {
-	int ret = 0, i, pma_mmd;
+	int ret = 0, i, vl, pma_mmd;
 
 	pma_mmd = xpcs_get_pma_mmd(xpcs);
 	if (pma_mmd < 1)
 		return pma_mmd;
 
 	for (i = 0; ret >= 0 && i < v->lanes; i++) {
+		/* code word markings */
+		for (vl = 0; ret >= 0 && vl < 4; vl++)
+			ret = xpcs_config_vl_markers(xpcs, vl, i,
+						     !vl ? &v->vl0_markers[0] :
+						     &v->vl123_markers[vl - 1]);
+		if (ret < 0)
+			break;
+		/* vendor registers */
+		ret = xpcs_write_pcs_prtad(xpcs, i, DW_VR_MII_PCS_VL_INTVL,
+					   v->vl_intvl);
+		if (ret < 0)
+			break;
+		ret = xpcs_write_pcs_prtad(xpcs, i, DW_VR_MII_PCS_PCS_MODE,
+					   v->pcs_mode);
+		if (ret < 0)
+			break;
+		/* rsfec register */
 		ret = xpcs_bus_write(xpcs, i, pma_mmd, MDIO_PMA_RSFEC_CTRL,
 				     v->rsfec_ctrl);
 	}
@@ -1455,6 +1528,13 @@ static int xpcs_25gbaser_pma_config(struct dw_xpcs *xpcs)
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
@@ -1465,6 +1545,10 @@ static int xpcs_50gbaser_pma_config(struct dw_xpcs *xpcs)
 	const struct pma_pcs_values v = {
 		.rsfec_ctrl = DW_VR_RSFEC_CTRL_TC_PAD_ALTER,
 		.lanes = 2,
+		.vl0_markers = &xpcs_50gbaser_markers[0],
+		.vl123_markers = &xpcs_50gbaser_markers[1],
+		.pcs_mode = 0,
+		.vl_intvl = 20479,
 	};
 
 	return xpcs_config_rsfec_pma(xpcs, &v);
@@ -1475,6 +1559,10 @@ static int xpcs_100gbasep_pma_config(struct dw_xpcs *xpcs)
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


