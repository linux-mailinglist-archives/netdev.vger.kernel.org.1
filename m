Return-Path: <netdev+bounces-292005-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO/vOpw2FmrrjAcAu9opvQ
	(envelope-from <netdev+bounces-292005-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:11:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 571315DDE0C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7263304A852
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A8A1F63D9;
	Wed, 27 May 2026 00:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tOEP4GS/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A5D285CBC
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779840620; cv=none; b=Ih8/3HEAWSio4CgS7Z+xVHlCPCbvrotDHlOwmwFx6w05MlyHY7nAhEyol/Y++MdTS7XgzHLM33bKrIke2rruNORrz5Wehau/DwcMw9rLdEOAuKRjc+KmnXls6IMcnkorNZw5NWh4UcoMN8ekWOKRM23BPYFwlKYvWVPwLF56sWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779840620; c=relaxed/simple;
	bh=0Tm9nwTHeYfugRY9tSjf3VPE4aKFSFYgNEZnx+24jds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YO2tvK7S09GHR6W/i1HvX6mr0r/6g/o/IvA0Li+Ur5HYkJdpsJjeKL5muHp40q/SAPWZu701pDFWFyjf2+ahsdBjCKkDSFQwVioB+covxagar69A4Q5/GERpfRrZUfdv1KMSFAkyDJXLICsvg0wh4EiwFfPYXiqoH0jRFnR2nUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tOEP4GS/; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8cc0ef7c306so84759476d6.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779840606; x=1780445406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JVqIvn7ZAeRsjfqe7C4mbzp1Skqc1oHz8BCR/Ka9cF4=;
        b=tOEP4GS/P4k4DKncu2Tok1jMMMjWqI6gFDPAvTHQkLRKUPnLAiMdmZcVnydssiSI4J
         15NndPrE3abN1ptOsArH9FRvm59Ro89T3d5/5ztHyyRJzC0NLX8k6ktdIPKhtblPIfVP
         6l9XyVvX/VSQj/5n6IJdP4A7MdyGYx8HwMIWIzaip3XGTRCFevLDY/1iw5wBfYMdcSF6
         6/NETvSuXx1HK/tHXf757iLCxDDYOz7XQrUfKVPgYgRWv2FelSrDHHmnTAb8mrnDj/Lr
         5zFJfoCmeNh+4FAdQxi4jvsX2dOol16SBU4WfcMh83Vg0VqgRmfFVnW9GihjtuYbydNc
         Tl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779840606; x=1780445406;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JVqIvn7ZAeRsjfqe7C4mbzp1Skqc1oHz8BCR/Ka9cF4=;
        b=rgM2QTjPWn94FNURM5kaxN3eINkLg6jGQmNA4qU4YcqnTQ0ZA2rErTWR1tqI5epKyo
         5dpYc4vfrFnLl94wLB7edHSymM38f1aAMf3885EEGBuv/341k5G3J7UqE7xVC5IOrE7P
         hHUda/nhD/izKoJjew0OICWDa46BlYoccnnbpI4qnWFz86GUPZlIdXQ4KJ3T9niB9ZxO
         b0UnRq2p6YPMmEGFAZGsr+ZBnY5OgwnzBSmQaQVpmLJBMksBUXpEhRoTg27HgTNNNlke
         43o1sy/CetblTDrGB1JbYtjqP2JOmP3/UC96slhz4HrY89kaZt/PB0WpsH8D5mQZSVqT
         Euvg==
X-Forwarded-Encrypted: i=1; AFNElJ+yya00eo5BSCGyyr7kg6O3a30YcpqLkCf2LvBsl74y7a5HL+n5EvY7AItaQVbTrJ7R3aSNpyc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/Yjas1PrFf0TLUegpcn5Ho+Zc5nEtYw72+3tQ4LdS9wRK5EtA
	kDc7N8/O/6e28317HuQJ8iUs2LuJrrbrgPkgCciu7L5gBw92rLQPHuzs
X-Gm-Gg: Acq92OEffgSntmsdyF1sBX8nGZcLLUnklvpq0TSm5ak8AmihWnETubf+cLwH9HCR806
	TVleuG+zQFtti4Z3/OtI60edYihKd6zDA0m7CN8y7DjGVFUt+iZhPVUMVN/n0t7ZUfPOhRwx1pG
	aFd/pBKdUhaBrcIzP1aqeDGNileqON0qTPWr0URRv8h4Oe1WWsHh7Pw9hcEAeffnEfjjB29j3co
	xy1agL468wfCCqt2wTkzFhdIJv3TtdVqwZntg0erUS35s5cXUXIXGgLKEe+m4YcnUtUXx9CY2zg
	DFTXeec8GUpMQEcsZBiO0abRIioNQIPJBL+FtqdCRZ3ft6K9eCbVa9Ee5wm+uDjWgO6zDi1JEMC
	y8QwkVyRaxTDp32hVzovESxBR7xozt+gi+FLxlL0vPLeb7NDxraeoi/WhJ552MM/91yfsSsBKUI
	5mtkaOGWy5+z30WVO7F+zhrji48tYJVXSemYakrLozSAI6BoOWMQuggzPk19uuJtgb8nYNeF3B3
	V6KFA==
X-Received: by 2002:a05:620a:4414:b0:911:e1ab:a3c0 with SMTP id af79cd13be357-914b49de06dmr2870546585a.60.1779840605986;
        Tue, 26 May 2026 17:10:05 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87fc449sm363803585a.35.2026.05.26.17.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 17:10:04 -0700 (PDT)
From: mike.marciniszyn@gmail.com
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Kees Cook <kees@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>
Cc: mike.marciniszyn@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 4/4] net: pcs: xpcs: Add handling for 4 channel rsfec device
Date: Tue, 26 May 2026 20:09:58 -0400
Message-ID: <20260527000958.81108-5-mike.marciniszyn@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527000958.81108-1-mike.marciniszyn@gmail.com>
References: <20260527000958.81108-1-mike.marciniszyn@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292005-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,trustnetic.com,net-swift.com,gmail.com,armlinux.org.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: 571315DDE0C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

This patch introduces the configuration of vendor specific
registers for alignment encoding, PCS Mode, and VL_INTVL
over the one or two instances as required.

The DW PCS IP specification calls out the need to configure both
lanes identically when using 2 lane modes such as 50-R2 and 100-R2, so
the programming is repeated for each channel.

The encoding tables are derived from the IEEE 8023-2022 spec sections
82.2.7 and tables 82-2 and 82-3 for the alignment markers and their
insertion.

Note that there is a conflict between VRs DW_VR_XS_PCS_DIG_STS
and the DW_PCS_IP DW_VR_MII_PCS_PCS_MODE.  The bit mask for
DW_VR_XS_PCS_DIG_STS/RX_FIFO_ERR fits within the reserved bits for
the DW PCS IP DW_VR_MII_PCS_PCS_MODE register so there is no issue.

There is also a conflict between DW_VR_MII_PCS_VL_INTVL and
DW_VR_MII_AN_INTR_STS but an_mode differs, so again there is no issue.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v3:
  - rename xpcs_config_vl_markers() to xpcs_config_ch_vl_markers()
  - add xpcs_write_pcs_ch()
  - lanes -> channels
v2: https://lore.kernel.org/all/20260511182604.1338-3-mike.marciniszyn@gmail.com/
  - Replace xpcs_write_pcs_prtad() wiht xpcs_write_pcs_mdev() to
    avoid hardcoded prtaddr value
v1: https://lore.kernel.org/all/20260506190904.4029-3-mike.marciniszyn@gmail.com/

 drivers/net/pcs/pcs-xpcs.c | 95 +++++++++++++++++++++++++++++++++++++-
 drivers/net/pcs/pcs-xpcs.h | 25 ++++++++++
 2 files changed, 119 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 342d1cc2adbc..515c0615f382 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1430,21 +1430,95 @@ static int xpcs_get_pma_mmd(struct dw_xpcs *xpcs)
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
 	int channels;
 	u16 rsfec_ctrl;
+	u16 pcs_mode;
+	u16 vl_intvl;
 };
 
+#define XPCS_VL_TO_REG(vl, lh) \
+	(((vl) * 2) + DW_VR_MII_PCS_VL0_##lh)
+
+static int
+xpcs_write_pcs_ch(struct dw_xpcs *xpcs, int ch, int reg, u16 val)
+{
+	return xpcs_mdev_write_ch(xpcs, ch, MDIO_MMD_PCS, reg, val);
+}
+
+static int xpcs_config_ch_vl_markers(struct dw_xpcs *xpcs, int ch, int vl,
+				     const struct lane_markers *m)
+{
+	int ret;
+
+	/* m0, m1, m2 written to _L and _H registers
+	 *
+	 * _L = (m1 << 8) | m0
+	 * _H = m2
+	 */
+	ret = xpcs_write_pcs_ch(xpcs, ch, XPCS_VL_TO_REG(vl, L),
+				((u16)m->m1 << 8) | m->m0);
+	if (ret < 0)
+		return ret;
+	return xpcs_write_pcs_ch(xpcs, ch, XPCS_VL_TO_REG(vl, H), m->m2);
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
 
 	for (i = 0; ret >= 0 && i < v->channels; i++) {
+		/* code word markings */
+		for (vl = 0; ret >= 0 && vl < 4; vl++)
+			ret = xpcs_config_ch_vl_markers(xpcs, i,
+							vl, !vl ?
+							&v->vl0_markers[0] :
+							&v->vl123_markers[vl - 1]);
+		if (ret < 0)
+			break;
+		/* vendor registers */
+		ret = xpcs_write_pcs_ch(xpcs, i,
+					DW_VR_MII_PCS_VL_INTVL, v->vl_intvl);
+		if (ret < 0)
+			break;
+		ret = xpcs_write_pcs_ch(xpcs, i,
+					DW_VR_MII_PCS_PCS_MODE, v->pcs_mode);
+		if (ret < 0)
+			break;
+		/* rsfec register */
 		ret = xpcs_mdev_write_ch(xpcs, i, pma_mmd,
 					 MDIO_PMA_RSFEC_CTRL, v->rsfec_ctrl);
 	}
@@ -1457,6 +1531,13 @@ static int xpcs_25gbaser_pma_config(struct dw_xpcs *xpcs)
 	const struct pma_pcs_values v = {
 		.rsfec_ctrl = 0,
 		.channels = 1,
+		/* 25g markers from 100g and 50g tables per 802.3-2022
+		 * 108.5.2.4
+		 */
+		.vl0_markers = &xpcs_100gbaser_markers[0],
+		.vl123_markers = &xpcs_50gbaser_markers[1],
+		.vl_intvl = 20479,
+		.pcs_mode = DW_VR_MII_PCS_MODE_CLAUSE107,
 	};
 
 	return xpcs_config_rsfec_pma(xpcs, &v);
@@ -1467,6 +1548,10 @@ static int xpcs_50gbaser_pma_config(struct dw_xpcs *xpcs)
 	const struct pma_pcs_values v = {
 		.rsfec_ctrl = DW_VR_RSFEC_CTRL_TC_PAD_ALTER,
 		.channels = 1,
+		.vl0_markers = &xpcs_50gbaser_markers[0],
+		.vl123_markers = &xpcs_50gbaser_markers[1],
+		.pcs_mode = 0,
+		.vl_intvl = 20479,
 	};
 
 	return xpcs_config_rsfec_pma(xpcs, &v);
@@ -1477,6 +1562,10 @@ static int xpcs_50gbaser2_pma_config(struct dw_xpcs *xpcs)
 	const struct pma_pcs_values v = {
 		.rsfec_ctrl = DW_VR_RSFEC_CTRL_TC_PAD_ALTER,
 		.channels = 2,
+		.vl0_markers = &xpcs_50gbaser_markers[0],
+		.vl123_markers = &xpcs_50gbaser_markers[1],
+		.pcs_mode = 0,
+		.vl_intvl = 20479,
 	};
 
 	return xpcs_config_rsfec_pma(xpcs, &v);
@@ -1487,6 +1576,10 @@ static int xpcs_100gbasep_pma_config(struct dw_xpcs *xpcs)
 	const struct pma_pcs_values v = {
 		.rsfec_ctrl = MDIO_PMA_RSFEC_CTRL_4LANE_PMD,
 		.channels = 2,
+		.vl0_markers = &xpcs_100gbaser_markers[0],
+		.vl123_markers = &xpcs_100gbaser_markers[1],
+		.pcs_mode = DW_VR_MII_PCS_MODE_DISABLE_MLD,
+		.vl_intvl = 16383,
 	};
 
 	return xpcs_config_rsfec_pma(xpcs, &v);
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index ab47d6dd050c..adb7b1c13c2d 100644
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


