Return-Path: <netdev+bounces-286787-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDGTB3UgAmocoAEAu9opvQ
	(envelope-from <netdev+bounces-286787-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:31:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6EB5147C6
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 20:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87E9830F3834
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 18:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37BF47D951;
	Mon, 11 May 2026 18:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtyScQAV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4387747CC7E
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 18:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523970; cv=none; b=uQn997oJotLkBtV2qg/H5uRW9ASTZdWX3kuhcVN0oCr+BwqorfhmPssCa+l+cwFcY7Zddm6b9n4yv+PJ6Yw1T5uUP1siC6QauDnRVXufejaHo89yNZ23gMtx8LKDxrkmTsTnoPT1KU0NTBao0PWBPVwpbCZjfpQd3rTwnKztXIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523970; c=relaxed/simple;
	bh=w41p+XuSWxGXnKnkYfxFdCURnDMoorLE5URRZqMD+dA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qeb1uJnj/rq6EyrnvBZtu2Q0GrHduNLPUbI55KPEttfHfUTxT64/lPxBSSAQeyZBgE4zxa2kDoxiIetsPZg0+/HqR+gIw7eOGEm0o6LeUKQ+AEaJork0qMU5S2MGb4mHKq1NoFW3fmeIErH4ZYDm2e7AvDOVJ33LBtbSArXOifk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtyScQAV; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8f0a87e23daso489495885a.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778523968; x=1779128768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qGg607mDB+aA+0BtLq6p1jTSY7WNpk5M8K/OgQPTtdk=;
        b=YtyScQAVT8ZIi/dS3Ya1eLa1bHFmEWpTBLzdi1YCKSAwwcjbx+1c4tC1pYyr9E7bsN
         AHrjKaVII18Vgs35fj0G3vwd3KrBqsE0qPFoQ+iTJHFtwkBJZzjQHIlOyHkvh/weKb9N
         B9MXMmxhFOD0ad95ugtf6Tj85ewBNw3esiMruA3JGGfsYeISueAtmjHmrqNoSMRf5lNM
         JwZDQ3RvPaRP+nuLFpdNUpH14V+9H5pXhFJicZa/wAQLcLngL2WM0u5tGTUdUzQlti6X
         6Kqw9va/3bh4v/juABLbu+N7sUqsJtuj9J1GHBsDwPQV/vkPVjJGAv4H3O26c8SkpVor
         Lv0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778523968; x=1779128768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qGg607mDB+aA+0BtLq6p1jTSY7WNpk5M8K/OgQPTtdk=;
        b=jP6+pdq7dr8gZMJ25JU9i95tisQt/YzpGJ4Y3Q14udZGcCSRuWoiBvyZvHDrRh4+rL
         EELKGYEtKPj4IFpkJGSZJ8xG+Nm+5NK/QxueFsgj2nwQGvZYC6HMHsqQ2MbIUOPnrMgA
         TKKDE+L9Pocv80f4NeplToimgFlgsAZd/DugxxjWFAthliEkZndkLPZddKj6R+Ku9rLM
         RmWicOs7PPujTtFTPgrQImJZs0rNlB+d9pU41+iAy9IE3tTnvuliCD9BYB3iOUn79bdA
         /GncjAXSd8DslwIERZfGf8kAslpJ0cxlOa+cs5IfdQNf6mU0yU4v9OSFND6IKnRJAnsw
         JKSA==
X-Forwarded-Encrypted: i=1; AFNElJ8B3tZcjwaMk5Svwk+GW6ZHFoRXJsxzQLhcHMxotxksAaRnWPNYjFKXg4WvoEGS3CAjIh6OmWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/44RWxIkGAvTcXZDyARidfJANLSgbh3hZ9GiMcsWge3/yIC5O
	2eT6Q+sMuC0b4ZBm3pfuPMyxIRg7Jswy8H6ilQlI3CREJRkFbC3lJP0R
X-Gm-Gg: Acq92OEv+6BlP5QLecmeD7rClIagjGAyVJtCn6CBefsTUZc7MqaICeRt20sjzCZ8Woq
	ZCV94B9gpfZc8EgVBJIlMQdAApLoGlMYAYxlC/0iphIAwkLdb8aH2tnGZWlYMzcoYMkEJU3ts9z
	mQ1lFjtlMEt/lBXU1FECCgO8oTmnNvXaB3T3PL9VkFUKv9nbsiMoJDQIK+CZrLKZxJ7VhChDzYL
	0napDVuBWEM6NtrD0z331pLp3iyUbyjhFDdXoN14/OEPUWM1F0iyxSKGEF6Z0U1TprKspjFMwb7
	Am5O1HFcZlIawgQLNsH2LkYKc1dCZa9zguoTQ5a8QU6tAVBRqPGX/KJw7kHXaQaIhuJlEf+IRca
	uHilMGqEJ2ceDdfLV1osTqA96tRcNWSJcFkQdLys/pJC43X0PwV+KDM7S8kgf4rmiy7BFh5Ixhv
	CCbWHTU6ZIkiV3/6K38yUm20MgCE9RBcVCR1GR7obCw+eX9AdOHQRLnfLeK2qzTCPZikWwP9GfS
	FmXDg==
X-Received: by 2002:a05:620a:40d1:b0:8ea:f0e0:26dc with SMTP id af79cd13be357-904d4d54625mr4121831885a.24.1778523968159;
        Mon, 11 May 2026 11:26:08 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.1])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-907b8d9ea06sm1111346885a.20.2026.05.11.11.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 11:26:07 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/2] net: pcs: xpcs: Add hooks for xpcs configuration of rsfec
Date: Mon, 11 May 2026 14:26:03 -0400
Message-ID: <20260511182604.1338-2-mike.marciniszyn@gmail.com>
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
X-Rspamd-Queue-Id: 8E6EB5147C6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286787-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[fb.com,kernel.org,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,armlinux.org.uk];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.936];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Action: no action

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

The DW PCS IP data sheet calls out the need to populate
these vendor registers when operating at speeds above 10Gbps.
This change enables the correct FEC settings to enable RS-FEC
encoding on the link which is the standard used for most links
at these higher speeds.

Note that the overwriting of the MDIO_PMA_RSFEC_CTRL register
is intentional and consistent DW PCS IP requirements.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v2:
  - Allow mdiobus probing for addr 0 and addr 1
  - Add xpcs_find* helpers based on phy_find* to avoid hardcoded addresses
  - Remove xpcs_bus write and use mdiodev_c45_write instead
  - Address comment on use of MDIO_PMA_RSFEC_CTRL
v1: https://lore.kernel.org/all/20260506190904.4029-2-mike.marciniszyn@gmail.com/

 drivers/net/ethernet/meta/fbnic/fbnmdiodev_c45_writeic_mdio.c |   3 +-
 drivers/net/pcs/pcs-xpcs.c                   | 105 +++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.h                   |   6 ++
 include/uapi/linux/mdio.h                    |   3 +
 4 files changed, 115 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
index fe3a4ce88413..e29534dd1e0c 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mdio.c
@@ -263,8 +263,7 @@ int fbnic_mdiobus_create(struct fbnic_dev *fbd)
 	bus->read_c45 = &fbnic_mdio_read_c45;
 	bus->write_c45 = &fbnic_mdio_write_c45;
 
-	/* Disable PHY auto probing. We will add PCS manually */
-	bus->phy_mask = ~0;
+	bus->phy_mask = GENMASK(31, 2);
 
 	bus->parent = fbd->dev;
 	bus->priv = fbd;
diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e69fa2f0a0e8..14f89e56958c 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1402,6 +1402,107 @@ static int xpcs_read_ids(struct dw_xpcs *xpcs)
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
+static struct mdio_device *xpcs_find_first_mdev(struct dw_xpcs *xpcs)
+{
+	struct phy_device *p = phy_find_first(xpcs->mdiodev->bus);
+
+	if (!p)
+		return NULL;
+	return &p->mdio;
+}
+
+static struct mdio_device *
+xpcs_find_next_mdev(struct dw_xpcs *xpcs, struct mdio_device *mdev)
+{
+	struct phy_device *p = container_of(mdev, struct phy_device, mdio), *n;
+
+	n = phy_find_next(xpcs->mdiodev->bus, p);
+	if (!n)
+		return NULL;
+	return &n->mdio;
+}
+
+static int
+xpcs_config_rsfec_pma(struct dw_xpcs *xpcs, const struct pma_pcs_values *v)
+{
+	struct mdio_device *mdev;
+	int ret = 0, i, pma_mmd;
+
+	pma_mmd = xpcs_get_pma_mmd(xpcs);
+	if (pma_mmd < 1)
+		return pma_mmd;
+
+	mdev = xpcs_find_first_mdev(xpcs);
+	if (!mdev)
+		return -ENODEV;
+
+	for (i = 0; mdev && ret >= 0 && i < v->lanes;
+	     i++, mdev = xpcs_find_next_mdev(xpcs, mdev)) {
+		ret = mdiodev_c45_write(mdev, pma_mmd, MDIO_PMA_RSFEC_CTRL,
+					v->rsfec_ctrl);
+	}
+	if (!ret && i < v->lanes)
+		return -ENODEV;
+
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
@@ -1415,6 +1516,7 @@ static const struct dw_xpcs_compat synopsys_xpcs_compat[] = {
 		.interface = PHY_INTERFACE_MODE_25GBASER,
 		.supported = xpcs_25gbaser_features,
 		.an_mode = DW_AN_C73,
+		.pma_config = xpcs_25gbaser_pma_config,
 	}, {
 		.interface = PHY_INTERFACE_MODE_XLGMII,
 		.supported = xpcs_xlgmii_features,
@@ -1423,14 +1525,17 @@ static const struct dw_xpcs_compat synopsys_xpcs_compat[] = {
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


