Return-Path: <netdev+bounces-107090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1971919BE6
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 02:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68CC1C21C15
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 00:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6726617FE;
	Thu, 27 Jun 2024 00:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3IboVkk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C348FC18;
	Thu, 27 Jun 2024 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719448925; cv=none; b=s3qSLHnuqdZHEvLVBbM9pK4r8uD21YIDrJDoqAnz4BnWfsjoNLbOlFmyq+W3aEwa+bdRN+dkZCgOe3GMAPqSHgT9ohR2vD4Gq3VNORoeSUz6BNPK/eCFAhVlk/j8MXaUzAAuw40ApWorcZ2nCE0Dd1qxMBeHrSu+LetmLXaPjcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719448925; c=relaxed/simple;
	bh=942HWtrrwMZHj8NhKUHjxOd6FxhubpGj857au8oAFIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vDaV7auNKN2SK1c5/lzeaetwW2JoL3It5T5acuSeEmV4zkjt2TnHjLFkd263DRTLziaT+Ci38pui0SL2sB1/bp9s7keTBumPHZKaqCI3TkzCnvw5VPMrtLpqJcK4NCE1+qh+L9fvWpB/Ympsjso5URbhdGQM+OdeFL2rLHsm8XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3IboVkk; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ec3f875e68so81365821fa.0;
        Wed, 26 Jun 2024 17:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719448922; x=1720053722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l1aUmiEcMZ+VAXZ9+5FXW90knS868BRwEpAdgXfPTGM=;
        b=J3IboVkkI/2VG4XVxOuW/+IuR0oi43g7Jxy1M4zyV2mdCgkj0xn0uT9giS5FpV9+Oe
         Q1pBfp5/rtm6xu34NizI285K4kgm0m9uNRlyYiUwnqaRirO/CPrIL1TJn/uNQk3FzMQg
         5OwPRwLEAaepk5l7Iy8SGZAYU5f4D1N0Lg9Sy59+nZm4KtctCgNXqAospquzvPxkcPig
         KMs2F+KEWysl0QqFbdworViIc4Ecvc3rC8F1NfFiOVIdc9yIhJ9PT4QLh8lC+R6W5t6Y
         LWbmRJzaQw44imZ7JvfEFITvihlefPFnCuPsuoOS3PoACmOKhjw2cihXmok37EWJ0tvv
         4DQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719448922; x=1720053722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1aUmiEcMZ+VAXZ9+5FXW90knS868BRwEpAdgXfPTGM=;
        b=hpwkW2NRH8WC64ts+E3KmW9INWRElEyH+fNMW1HDPKnpJa7xeD0VG14Ln6Es8mgBQ8
         nzoGTDp7CkLp4LuAaiynzut0AaXNznUaayKgNSDSRL1tJy3wsyXTCok3SUfQ88eUMy+g
         yRBzi9JLGcQZorre2M8c9DOLgM0Z17jxK7zDsh+UIRYDff18CeF6i0D68NZzfLR1R7c3
         imoeuEyqDJb/S5SfCE9IU6df8SAC8cUI7I094vF+StwCrf2zIVbjbZkbe3pNAzZNfNHF
         PqrK3helBWXILMUCs00mt0+byzYkwFHpaMeuqRC1H0UEDu2t0mdKw3QRJfhsXs5oUmw6
         ew0w==
X-Forwarded-Encrypted: i=1; AJvYcCXZWAEsz5E7PgmcxymLmoVcPdb3ZtantYVHMGiRoYYiKPYM7E4m4FkYXRwBWu1/0QgncExz9+HBlwqxfA+PCXHnXbOy97bATPfjpv4LVPSnVIq5nOSiZrhrcRnon4uPi7LSBVRkhi6AByTLxPvLRer5nviaSbH71ms9qNv/ODqgFw==
X-Gm-Message-State: AOJu0Yw0xc/GRLq8zezw1PJD10ZKtrOvL0qDQTcJ3UUFocbNY38ALdMe
	stkZzgqm3AUZ1pe4oLOxR4ngN9gieMdiwNz/Y3voYxFkEaQ+oI1j
X-Google-Smtp-Source: AGHT+IFmjRGW10WUGPT7cZAYEVgU7kOFgeFWXkk/1Ljf051iR+iI2oXN70rlPpaeq6HVJuBIApnqgA==
X-Received: by 2002:a05:651c:220e:b0:2ec:5e2e:39a8 with SMTP id 38308e7fff4ca-2ec5e2e3aaamr82947591fa.3.1719448921454;
        Wed, 26 Jun 2024 17:42:01 -0700 (PDT)
Received: from localhost ([89.113.147.248])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ee4a4a8ecasm474761fa.88.2024.06.26.17.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 17:42:01 -0700 (PDT)
From: Serge Semin <fancer.lancer@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 03/10] net: pcs: xpcs: Convert xpcs_id to dw_xpcs_desc
Date: Thu, 27 Jun 2024 03:41:23 +0300
Message-ID: <20240627004142.8106-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240627004142.8106-1-fancer.lancer@gmail.com>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A structure with the PCS/PMA MMD IDs data is being introduced in one of
the next commits. In order to prevent the names ambiguity let's convert
the xpcs_id structure name to dw_xpcs_desc. The later version is more
suitable since the structure content is indeed the device descriptor
containing the data and callbacks required for the driver to correctly set
the device up.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

---

Changelog v2:
- This is a new patch introduced on v2 stage of the review.
---
 drivers/net/pcs/pcs-xpcs.c   | 30 +++++++++++++++---------------
 include/linux/pcs/pcs-xpcs.h |  4 ++--
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 2dcfd0ff069a..48c61975db22 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -151,19 +151,19 @@ struct xpcs_compat {
 	int (*pma_config)(struct dw_xpcs *xpcs);
 };
 
-struct xpcs_id {
+struct dw_xpcs_desc {
 	u32 id;
 	u32 mask;
 	const struct xpcs_compat *compat;
 };
 
-static const struct xpcs_compat *xpcs_find_compat(const struct xpcs_id *id,
-						  phy_interface_t interface)
+static const struct xpcs_compat *
+xpcs_find_compat(const struct dw_xpcs_desc *desc, phy_interface_t interface)
 {
 	int i, j;
 
 	for (i = 0; i < DW_XPCS_INTERFACE_MAX; i++) {
-		const struct xpcs_compat *compat = &id->compat[i];
+		const struct xpcs_compat *compat = &desc->compat[i];
 
 		for (j = 0; j < compat->num_interfaces; j++)
 			if (compat->interface[j] == interface)
@@ -177,7 +177,7 @@ int xpcs_get_an_mode(struct dw_xpcs *xpcs, phy_interface_t interface)
 {
 	const struct xpcs_compat *compat;
 
-	compat = xpcs_find_compat(xpcs->id, interface);
+	compat = xpcs_find_compat(xpcs->desc, interface);
 	if (!compat)
 		return -ENODEV;
 
@@ -612,7 +612,7 @@ static int xpcs_validate(struct phylink_pcs *pcs, unsigned long *supported,
 	int i;
 
 	xpcs = phylink_pcs_to_xpcs(pcs);
-	compat = xpcs_find_compat(xpcs->id, state->interface);
+	compat = xpcs_find_compat(xpcs->desc, state->interface);
 	if (!compat)
 		return -EINVAL;
 
@@ -633,7 +633,7 @@ void xpcs_get_interfaces(struct dw_xpcs *xpcs, unsigned long *interfaces)
 	int i, j;
 
 	for (i = 0; i < DW_XPCS_INTERFACE_MAX; i++) {
-		const struct xpcs_compat *compat = &xpcs->id->compat[i];
+		const struct xpcs_compat *compat = &xpcs->desc->compat[i];
 
 		for (j = 0; j < compat->num_interfaces; j++)
 			__set_bit(compat->interface[j], interfaces);
@@ -853,7 +853,7 @@ int xpcs_do_config(struct dw_xpcs *xpcs, phy_interface_t interface,
 	const struct xpcs_compat *compat;
 	int ret;
 
-	compat = xpcs_find_compat(xpcs->id, interface);
+	compat = xpcs_find_compat(xpcs->desc, interface);
 	if (!compat)
 		return -ENODEV;
 
@@ -1118,7 +1118,7 @@ static void xpcs_get_state(struct phylink_pcs *pcs,
 	const struct xpcs_compat *compat;
 	int ret;
 
-	compat = xpcs_find_compat(xpcs->id, state->interface);
+	compat = xpcs_find_compat(xpcs->desc, state->interface);
 	if (!compat)
 		return;
 
@@ -1341,7 +1341,7 @@ static const struct xpcs_compat nxp_sja1110_xpcs_compat[DW_XPCS_INTERFACE_MAX] =
 	},
 };
 
-static const struct xpcs_id xpcs_id_list[] = {
+static const struct dw_xpcs_desc xpcs_desc_list[] = {
 	{
 		.id = DW_XPCS_ID,
 		.mask = DW_XPCS_ID_MASK,
@@ -1395,18 +1395,18 @@ static int xpcs_init_id(struct dw_xpcs *xpcs)
 
 	xpcs_id = xpcs_get_id(xpcs);
 
-	for (i = 0; i < ARRAY_SIZE(xpcs_id_list); i++) {
-		const struct xpcs_id *entry = &xpcs_id_list[i];
+	for (i = 0; i < ARRAY_SIZE(xpcs_desc_list); i++) {
+		const struct dw_xpcs_desc *entry = &xpcs_desc_list[i];
 
 		if ((xpcs_id & entry->mask) != entry->id)
 			continue;
 
-		xpcs->id = entry;
+		xpcs->desc = entry;
 
 		break;
 	}
 
-	if (!xpcs->id)
+	if (!xpcs->desc)
 		return -ENODEV;
 
 	ret = xpcs_dev_flag(xpcs);
@@ -1420,7 +1420,7 @@ static int xpcs_init_iface(struct dw_xpcs *xpcs, phy_interface_t interface)
 {
 	const struct xpcs_compat *compat;
 
-	compat = xpcs_find_compat(xpcs->id, interface);
+	compat = xpcs_find_compat(xpcs->desc, interface);
 	if (!compat)
 		return -EINVAL;
 
diff --git a/include/linux/pcs/pcs-xpcs.h b/include/linux/pcs/pcs-xpcs.h
index 8dfe90295f12..e706bd16b986 100644
--- a/include/linux/pcs/pcs-xpcs.h
+++ b/include/linux/pcs/pcs-xpcs.h
@@ -28,11 +28,11 @@
 /* dev_flag */
 #define DW_DEV_TXGBE			BIT(0)
 
-struct xpcs_id;
+struct dw_xpcs_desc;
 
 struct dw_xpcs {
+	const struct dw_xpcs_desc *desc;
 	struct mdio_device *mdiodev;
-	const struct xpcs_id *id;
 	struct phylink_pcs pcs;
 	phy_interface_t interface;
 	int dev_flag;
-- 
2.43.0


