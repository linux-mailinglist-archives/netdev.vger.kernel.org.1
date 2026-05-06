Return-Path: <netdev+bounces-285004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UJKIA9yR+2lJcwMAu9opvQ
	(envelope-from <netdev+bounces-285004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:09:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB0E4DF9AF
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 21:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CE32301B912
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 19:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C27430FF08;
	Wed,  6 May 2026 19:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G904GJ1n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6582E1722
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778094550; cv=none; b=HMX2z0Tyn0locKZgk1Jyx6EcQNZzl6cCXryUeqAYAg6XCnj6FOxuhrv8lX644ncrZcsrBbxyy3DGtuo4cQIqS+s2/KZWjtzqNDsuMjLLlmwkK0ogMS8rfYYT2eWWpcCpOOmXQYwcZppfitr0EznGcKig+/1dYeRmFmKGXCIAsV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778094550; c=relaxed/simple;
	bh=u0gO9itySAgqinXb+Yu2ZMW7pogwME51DV+OiYaa03E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qnt0lvI+EJ4njpcGlvb0dbpbjwwAAcNRwOah1c2iqsnR02rV+OirjSNLMwjkt8vbu/26/HOSEtzA0ANgfOAC2VXPOioy2p1YeA9PwUs8HH+XivMZRO01SruhiUBJyoJ9+ndZTUo0LFDX1b6n8/Pesw7e2hZVdLW3vkeXol8wmzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G904GJ1n; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-512f750d4b2so33932061cf.1
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778094548; x=1778699348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rr1dQq7NCJJ5aSAMedCihgXSO/FjJKmjQPu+yzQ2vbA=;
        b=G904GJ1nWTxUVrWMzsDd0GlDHM+4MG8ibaI/LeKNACM004oAdwRtlyDu3A6k+jQAdQ
         /xmqeUnkJe2Pq3NBN68um5p/sx+q8e+mixVrFCVsCQqBC1NtWFCqIGvcUbDOC3cBxKYI
         qJkzSNwdp6xkF9QkJkpXg4+BLQO6ZNSX1OHmpoEptXVAllkFQMG3qwESVNXVdCvj1Vgq
         kIWE+n4dtnjAeXrgkxxWB6a9/uacyFbrNv7nJxp7aatHRZWyAxLNcEt/R3WycWzAHt3L
         KXEnXaT8MEf4NpgqYuFRt3u0lNS24eUAOkWmiXqYeekZB80XP0wzh1ctNomZ9Sw0txCn
         XbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778094548; x=1778699348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rr1dQq7NCJJ5aSAMedCihgXSO/FjJKmjQPu+yzQ2vbA=;
        b=CIC5kgNN2bdC7Lv69GerqFcrn3y+nZFqDLBWryC/nAEvxegC+dja1KcYnP7YFZkmB9
         RhV47D8P/2hr5YolalClUW+YaVkU1rBXQIaCXpJDRIwBm6CZ8yGk24ky6Asn67vlcj+P
         /ot2Yil2Hj3FQz+SYmoOz4zjS7egXRvIyKNRbCSuYL9DpdZzPCTVkDGEtMFo9C9Q6HKv
         5sVq54vzUgK7d3alvtfaF+ipgP2YV6JgObrAT2IJxVIKbWqhvUbmRU/eZa0FTGTXNNPQ
         0uE8DvzeWxUaVu/oB8ueLOptsM7CDEj3yFCOmrVCHwHPyijBsWEc1uu5/Cme+aIMoW6e
         quAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/rMidAxC9ak2XE710nzd6kcA06MsTgTuqXNO1qVLTPmHCuUX8WXFOlCRD7eGZckmsiSY00NJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4y+kDUhM1TmRuSlKwFMT7Btd0SE7qiCfpixHKdbGkbDYsXId7
	iWBdZ2CA6lEN0hHoLl+Zf3qHL55oZXtCGEax6Nly8u1XvClqimyfxV+n
X-Gm-Gg: AeBDiesKea7ZAc9u1htW530BvjiV7niiWY9dQBLp5/yqk/QYl/MAwZqiJGGYNH4PLkv
	w914CTloxut4Y9LcJ1VU5R5A6kTAGHNih4q86m585QmbaN8LAJdHTpdRcyvD9jPwoWFVLYP+6qq
	Bmxeqq1OxLHAK/272BoeP6MXbDh7Ert7agv1mhxIHJ9dY/CT5MYajprsFWP1XbYZD9iXHm6nr8E
	O3xnL8bn7AHTMIhKNxHOnU2HpkG2IBpCLU5573ppr7lEYgn1V2aQBFxriUn0mh3XTcc55navBQW
	xzVmjmP/QbJAsZcfJd+n+RibRp0dprZ918WUbpH9nO+zlrNYLTADCR2rgwaCvPJpE0Am356qmQH
	GDAtLyGZ5G2EtuuPiw2R+jJqO57tL0QCfRARwyruEQvfbQXpLhItUHkBEtcIyi4XEKBPe5P3gsU
	H9vuh2TpQsnF7fTt/wd9CLufINjFtI/rJO2Iz+4u/xRWCQHE8DocDfsuIzk7c8w+TVWJc=
X-Received: by 2002:ac8:5a54:0:b0:50e:60d7:b286 with SMTP id d75a77b69052e-51461be059dmr66271391cf.1.1778094547763;
        Wed, 06 May 2026 12:09:07 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5104090bb03sm157489421cf.10.2026.05.06.12.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 12:09:07 -0700 (PDT)
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
Subject: [PATCH net-next 1/2] net: pcs: xpcs: Add hooks for xpcs configuration of rsfec
Date: Wed,  6 May 2026 15:09:03 -0400
Message-ID: <20260506190904.4029-2-mike.marciniszyn@gmail.com>
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
X-Rspamd-Queue-Id: 7DB0E4DF9AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285004-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,fb.com];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fb.com:email]

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

The DW PCS IP data sheet calls out the need to populate
these vendor registers when operating at speeds above 10Gbps.
This change enables the correct FEC settings to enable RS-FEC
encoding on the link which is the standard used for most links
at these higher speeds.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c | 82 ++++++++++++++++++++++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.h |  6 +++
 include/uapi/linux/mdio.h  |  3 ++
 3 files changed, 91 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e69fa2f0a0e8..0987621632a7 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -219,6 +219,12 @@ int xpcs_write(struct dw_xpcs *xpcs, int dev, u32 reg, u16 val)
 	return mdiodev_c45_write(xpcs->mdiodev, dev, reg, val);
 }
 
+static int
+xpcs_bus_write(struct dw_xpcs *xpcs, int prtad, int dev, u32 reg, u16 val)
+{
+	return mdiobus_c45_write(xpcs->mdiodev->bus, prtad, dev, reg, val);
+}
+
 int xpcs_modify(struct dw_xpcs *xpcs, int dev, u32 reg, u16 mask, u16 set)
 {
 	return mdiodev_c45_modify(xpcs->mdiodev, dev, reg, mask, set);
@@ -1402,6 +1408,78 @@ static int xpcs_read_ids(struct dw_xpcs *xpcs)
 	return 0;
 }
 
+static int xpcs_get_pma_mmd(struct dw_xpcs *xpcs)
+{
+	int devs1, b;
+
+	devs1 = xpcs_read(xpcs, MDIO_MMD_PMAPMD, MDIO_DEVS1);
+	if (devs1 < 0)
+		return devs1;
+
+	/* Locate the PMA closest to the PCS as this should be the one provided
+	 * with the DW IP. This is identified by being the PMA with the
+	 * highest MMD device address.
+	 */
+	devs1 &= MDIO_DEVS_SEP_PMA1 | MDIO_DEVS_SEP_PMA2 | MDIO_DEVS_SEP_PMA3 |
+		 MDIO_DEVS_SEP_PMA4 | MDIO_DEVS_PMAPMD;
+	b = fls(devs1);
+	if (b)
+		return b - 1;
+
+	return -ENODEV;
+}
+
+struct pma_pcs_values {
+	int lanes;
+	u16 rsfec_ctrl;
+};
+
+static int
+xpcs_config_rsfec_pma(struct dw_xpcs *xpcs, const struct pma_pcs_values *v)
+{
+	int ret = 0, i, pma_mmd;
+
+	pma_mmd = xpcs_get_pma_mmd(xpcs);
+	if (pma_mmd < 1)
+		return pma_mmd;
+
+	for (i = 0; ret >= 0 && i < v->lanes; i++) {
+		ret = xpcs_bus_write(xpcs, i, pma_mmd, MDIO_PMA_RSFEC_CTRL,
+				     v->rsfec_ctrl);
+	}
+	return ret;
+}
+
+static int xpcs_25gbaser_pma_config(struct dw_xpcs *xpcs)
+{
+	const struct pma_pcs_values v = {
+		.rsfec_ctrl = 0,
+		.lanes = 1,
+	};
+
+	return xpcs_config_rsfec_pma(xpcs, &v);
+}
+
+static int xpcs_50gbaser_pma_config(struct dw_xpcs *xpcs)
+{
+	const struct pma_pcs_values v = {
+		.rsfec_ctrl = DW_VR_RSFEC_CTRL_TC_PAD_ALTER,
+		.lanes = 2,
+	};
+
+	return xpcs_config_rsfec_pma(xpcs, &v);
+}
+
+static int xpcs_100gbasep_pma_config(struct dw_xpcs *xpcs)
+{
+	const struct pma_pcs_values v = {
+		.rsfec_ctrl = MDIO_PMA_RSFEC_CTRL_4LANE_PMD,
+		.lanes = 2,
+	};
+
+	return xpcs_config_rsfec_pma(xpcs, &v);
+}
+
 static const struct dw_xpcs_compat synopsys_xpcs_compat[] = {
 	{
 		.interface = PHY_INTERFACE_MODE_USXGMII,
@@ -1415,6 +1493,7 @@ static const struct dw_xpcs_compat synopsys_xpcs_compat[] = {
 		.interface = PHY_INTERFACE_MODE_25GBASER,
 		.supported = xpcs_25gbaser_features,
 		.an_mode = DW_AN_C73,
+		.pma_config = xpcs_25gbaser_pma_config,
 	}, {
 		.interface = PHY_INTERFACE_MODE_XLGMII,
 		.supported = xpcs_xlgmii_features,
@@ -1423,14 +1502,17 @@ static const struct dw_xpcs_compat synopsys_xpcs_compat[] = {
 		.interface = PHY_INTERFACE_MODE_50GBASER,
 		.supported = xpcs_50gbaser_features,
 		.an_mode = DW_AN_C73,
+		.pma_config = xpcs_50gbaser_pma_config,
 	}, {
 		.interface = PHY_INTERFACE_MODE_LAUI,
 		.supported = xpcs_50gbaser2_features,
 		.an_mode = DW_AN_C73,
+		.pma_config = xpcs_50gbaser_pma_config,
 	}, {
 		.interface = PHY_INTERFACE_MODE_100GBASEP,
 		.supported = xpcs_100gbasep_features,
 		.an_mode = DW_AN_C73,
+		.pma_config = xpcs_100gbasep_pma_config,
 	}, {
 		.interface = PHY_INTERFACE_MODE_10GBASER,
 		.supported = xpcs_10gbaser_features,
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 929fa238445e..187cdec30e70 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -94,6 +94,12 @@
 #define DW_VR_MII_DIG_CTRL2_TX_POL_INV		BIT(4)
 #define DW_VR_MII_DIG_CTRL2_RX_POL_INV		BIT(0)
 
+/* Clause 133 defines */
+/* RSFEC transcode pad alter
+ * DW vendor extension in RS-FEC control
+ */
+#define DW_VR_RSFEC_CTRL_TC_PAD_ALTER	BIT(10)
+
 #define DW_XPCS_INFO_DECLARE(_name, _pcs, _pma)				\
 	static const struct dw_xpcs_info _name = { .pcs = _pcs, .pma = _pma }
 
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index b2541c948fc1..5219c877b2cf 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -317,6 +317,9 @@
 #define MDIO_PMA_10GBR_FECABLE_ABLE	0x0001	/* FEC ability */
 #define MDIO_PMA_10GBR_FECABLE_ERRABLE	0x0002	/* FEC error indic. ability */
 
+/* RSFEC PMA Control register */
+#define MDIO_PMA_RSFEC_CTRL_4LANE_PMD	BIT(3)
+
 /* PMA 10GBASE-R Fast Retrain status and control register. */
 #define MDIO_PMA_10GBR_FSRT_ENABLE	0x0001	/* Fast retrain enable */
 
-- 
2.43.0


