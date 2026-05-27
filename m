Return-Path: <netdev+bounces-292004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJSED/Q2FmrrjAcAu9opvQ
	(envelope-from <netdev+bounces-292004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:12:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B08655DDE51
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 02:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0F54306197A
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 00:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F47A271A71;
	Wed, 27 May 2026 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JRSOg6Jv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92E12BCF45
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779840616; cv=none; b=N9l4ptlzX94BuTdSzLKzCdxMwJOZAtjjJ9nzTPJi+QeVYQe4WZ62TfQT8RJd3Yt3tx8vfn1DB1MwgQOGRT3gjtQopwR2y/7e+EBAUXbo9gO6/SU4iek9CJ2y5xORYt+FrBCh4G/VGzfk1Qt0g3AYizMyzFWQuUQG2VYLyx0riGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779840616; c=relaxed/simple;
	bh=OHjY6IJMkBTBx1a6cUhijjtCHTmYFGDLUGk/LCnMowE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=macLwyHN5KCIQc86D6mhRogAbqm2XELnZE/UjQEqgBDMWgBJF51TPSOeiSsmRTNumF8VAIRUGcu5QzoZx8pJoxihptr+bBLG8pMKt+MmE1vtHBz6JZxoTnvDtIIsY9unTp6LO5iq9+P8uLImn//Aqh8ymSCzPfX2H3jMahqGoYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JRSOg6Jv; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-914beab9a08so333104385a.3
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779840604; x=1780445404; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Z0yd66ZMiBeZhMfIx+Z804H0QcrMevImtwN2M1WuAI=;
        b=JRSOg6JvAaYMF6wweTQu4TFrRma38i5Yt4OPHXg7Bp+6es+i0JigdSpas/mn+JftNC
         YQADm6HNgd4CUrtAo8qT1TJmBdIEKc1+YFg/ALrAqcKRJag6uIR4wgH19+VA+/9/dghw
         ahdmmsirkYghkLgKaSbXhecvvx88S3cct0pu/RVAQExjrg3nYpsebS9U/2r7eZbKk36e
         hRSILB3Io0SpVl8kelAGqSydpj/GJchujDRM43kffS3w50ysPCHwLzmSs1sO5u8e2h+1
         dix08za8gUEjikoqXryU1DGWB2PpuOpY179NSgCX7yMS8LYpMHzsHmndAcBQjyXwe2Iv
         K9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779840604; x=1780445404;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Z0yd66ZMiBeZhMfIx+Z804H0QcrMevImtwN2M1WuAI=;
        b=EdjtspeSc42pCVJ2JeOoU71BTgbnx5W1/3Ty7mtJ1GqP0acHhsKbi0aKaGlZBURIMb
         R8v5ClNGRJ3Do/0A30/6auA+f92jXb3KRZ01wDyco0J8n3+kYp86RDaXnWkD4ve+7LLr
         zrzd0Bj+jgIzq0vwpv3Wz4O0/oN283VOG/Fw6ZuF53xBNmduF5tE2SCRenzsA+noGHsL
         doJylMeXnWyPxw7AepbSUmkfdouOGJXt65Trlw3z5rhtnToCMJ50p4sCCI6tojXILnSq
         v8W3S/GjlpsRkfXLGZecAfQEUxwxkZRrpPtKr2W1dGMaaKMmekvXYdeKd12/b/srSK8Q
         w+/A==
X-Forwarded-Encrypted: i=1; AFNElJ9SA59+nNy9GBdtHodfC1EIc9djRH1QehN7AwJYXGXG3FzBSrfC35ODZyhHMOb+bm577riWGik=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTgJ3CKizV7LGxtQpyMzvYFRAJPzTClKohwZOGLDQIsGb9ZnHD
	CF7IuLqxQSspkrpn/tt7dmgeE26zFyQ/EtYoxClb8L9IjRzR2WEMsSfw
X-Gm-Gg: Acq92OEbx5cwIfB7LR1tITm8y+VErdhfx3IPsnuh8LM/djIxru3qohUHup5fZMN0Uva
	vYL7nSI+w4dI39h2dQkB7wQnzCCFoDBQ97OWGXIo+NRm6qiDV5NfX3LxMth7/avb+q4J9yFJhn6
	zKbzrmdkJazCveDjqsBOUtqounxMp2sOQUlJYifgjV8BAH7csg75N29JnhJ0orX+Gv2AJBe6HRF
	JPWpYRJAeuOZJBCe9eag33soEpnpTuwMpjyb88gbap+6zq74eYuAJvSVrcHAskKnIr75RUIJReT
	ELQHfHIcGVXr302c4YKMDjFPR46jbYr2zrw64h4pjVdT+7Jp+a19F2WAUx763/15MWf8EcwaIJw
	HZJX7uZ6dIQiwy3yJCueLE82Lx2lsl637irQEC8VuJ6WN1hiip5e7otmfVADxQE6fKB5oD/Nl5E
	18rgNs70I5oSjuQWdk+G2Laj9kEQJ4aCbFXx/eTLMEN5Tp4qKO9omdT8aU
X-Received: by 2002:a05:620a:1b81:b0:914:aa0d:aa87 with SMTP id af79cd13be357-914b49347edmr3214660185a.23.1779840604173;
        Tue, 26 May 2026 17:10:04 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-914f87fc449sm363803585a.35.2026.05.26.17.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 17:10:03 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/4] net: pcs: xpcs: Add hooks for xpcs configuration of rsfec
Date: Tue, 26 May 2026 20:09:57 -0400
Message-ID: <20260527000958.81108-4-mike.marciniszyn@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292004-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org]
X-Rspamd-Queue-Id: B08655DDE51
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>

The DW PCS IP data sheet calls out the need to populate
these vendor registers when operating at speeds above 10Gbps.
This change enables the correct FEC settings to enable RS-FEC
encoding on the link which is the standard used for most links
at these higher speeds.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
---
v3:
  - lanes -> channels
  - Added 50gbaser2 that was missing
  - remove auto probe for addr 0/1
  - call xpcs_mdev_write_ch()
  - reformat building devs1 mask in xpcs_get_pma_mmd()
v2: https://lore.kernel.org/netdev/20260511182604.1338-2-mike.marciniszyn@gmail.com/
  - Allow mdiobus probing for addr 0 and addr 1
  - Add xpcs_find* helpers based on phy_find* to avoid hardcoded addresses
  - Remove xpcs_bus write and use mdiodev_c45_write instead
  - Address comment on use of MDIO_PMA_RSFEC_CTRL
v1: https://lore.kernel.org/all/20260506190904.4029-2-mike.marciniszyn@gmail.com/

 drivers/net/pcs/pcs-xpcs.c | 88 ++++++++++++++++++++++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.h |  6 +++
 include/uapi/linux/mdio.h  |  3 ++
 3 files changed, 97 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index d59ba99c3764..342d1cc2adbc 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1408,6 +1408,90 @@ static int xpcs_read_ids(struct dw_xpcs *xpcs)
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
+	devs1 &= MDIO_DEVS_SEP_PMA1 | MDIO_DEVS_SEP_PMA2 |
+		 MDIO_DEVS_SEP_PMA3 | MDIO_DEVS_SEP_PMA4 |
+		 MDIO_DEVS_PMAPMD;
+	b = fls(devs1);
+	if (b)
+		return b - 1;
+
+	return -ENODEV;
+}
+
+struct pma_pcs_values {
+	int channels;
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
+	for (i = 0; ret >= 0 && i < v->channels; i++) {
+		ret = xpcs_mdev_write_ch(xpcs, i, pma_mmd,
+					 MDIO_PMA_RSFEC_CTRL, v->rsfec_ctrl);
+	}
+
+	return ret;
+}
+
+static int xpcs_25gbaser_pma_config(struct dw_xpcs *xpcs)
+{
+	const struct pma_pcs_values v = {
+		.rsfec_ctrl = 0,
+		.channels = 1,
+	};
+
+	return xpcs_config_rsfec_pma(xpcs, &v);
+}
+
+static int xpcs_50gbaser_pma_config(struct dw_xpcs *xpcs)
+{
+	const struct pma_pcs_values v = {
+		.rsfec_ctrl = DW_VR_RSFEC_CTRL_TC_PAD_ALTER,
+		.channels = 1,
+	};
+
+	return xpcs_config_rsfec_pma(xpcs, &v);
+}
+
+static int xpcs_50gbaser2_pma_config(struct dw_xpcs *xpcs)
+{
+	const struct pma_pcs_values v = {
+		.rsfec_ctrl = DW_VR_RSFEC_CTRL_TC_PAD_ALTER,
+		.channels = 2,
+	};
+
+	return xpcs_config_rsfec_pma(xpcs, &v);
+}
+
+static int xpcs_100gbasep_pma_config(struct dw_xpcs *xpcs)
+{
+	const struct pma_pcs_values v = {
+		.rsfec_ctrl = MDIO_PMA_RSFEC_CTRL_4LANE_PMD,
+		.channels = 2,
+	};
+
+	return xpcs_config_rsfec_pma(xpcs, &v);
+}
+
 static const struct dw_xpcs_compat synopsys_xpcs_compat[] = {
 	{
 		.interface = PHY_INTERFACE_MODE_USXGMII,
@@ -1421,6 +1505,7 @@ static const struct dw_xpcs_compat synopsys_xpcs_compat[] = {
 		.interface = PHY_INTERFACE_MODE_25GBASER,
 		.supported = xpcs_25gbaser_features,
 		.an_mode = DW_AN_C73,
+		.pma_config = xpcs_25gbaser_pma_config,
 	}, {
 		.interface = PHY_INTERFACE_MODE_XLGMII,
 		.supported = xpcs_xlgmii_features,
@@ -1429,14 +1514,17 @@ static const struct dw_xpcs_compat synopsys_xpcs_compat[] = {
 		.interface = PHY_INTERFACE_MODE_50GBASER,
 		.supported = xpcs_50gbaser_features,
 		.an_mode = DW_AN_C73,
+		.pma_config = xpcs_50gbaser_pma_config,
 	}, {
 		.interface = PHY_INTERFACE_MODE_LAUI,
 		.supported = xpcs_50gbaser2_features,
 		.an_mode = DW_AN_C73,
+		.pma_config = xpcs_50gbaser2_pma_config,
 	}, {
 		.interface = PHY_INTERFACE_MODE_100GBASEP,
 		.supported = xpcs_100gbasep_features,
 		.an_mode = DW_AN_C73,
+		.pma_config = xpcs_100gbasep_pma_config,
 	}, {
 		.interface = PHY_INTERFACE_MODE_10GBASER,
 		.supported = xpcs_10gbaser_features,
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 36f4906e689a..ab47d6dd050c 100644
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


