Return-Path: <netdev+bounces-135424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABFE99DDA5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 07:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59C21F215E6
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 05:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB5C2167296;
	Tue, 15 Oct 2024 05:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NgyKi6i8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9E733F9
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 05:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728971242; cv=none; b=Wo5V83FtqRQZs8KVeYL7valr+Qc2oAh1rT7PXVXHcBhn8a72cRMOFq0f+i3Si24FGTQuSLT2a45b91VqxT2wHF+/BY7KbFt2qLT7drq/8jtKODpiUqIpLTsCWVUzQM10NNmgud4RcwgpwG+WWWI5j3Yuy3er+I8WB5whFbT+c50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728971242; c=relaxed/simple;
	bh=HVgpjUSB7t0rot20NrZXPV2RbpDXJBnkh9KrYsnYICY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=Y7gybHZ1iEd/G0oaI5571Ydq6qaKw8QFquZCx9qsBy/UG8RJGnHjWTxuPXW3I+ycpFt0wSvr0a7ioxszWwuaQWuqLz4TlXqj56veFyPQL9oDeVrJZwRxhUGlBnev71xSnCdLDEpSn1R7ic/qxHS/bJVOnlduociHRLpJHFRacdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NgyKi6i8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so47852205e9.1
        for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 22:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728971238; x=1729576038; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GB08+bZjwtvGU3PV2Kyw6rs/EbzEepZD29srDnzoHoM=;
        b=NgyKi6i8t8Kl77kX8rYmzWZIIkKxOo0LbgTT7gzZDO3RB4D1OAwJdJKukOGyfzKLc0
         1dkP4ROsPSBQAJOzwtNrYVdXTaWLoBlgFakGxoEijeqyWgxUnEU0csPHo/E3k7wW5VEi
         QCe7o9OBAiPSc2zFv8nfWFRrhjV6Tp97vA3n2JAefXxQSB5Wbl35JTCeAgpU0ct7OMn1
         fV7nKD/RfoJsiRyrfwRmSEhNOdR06QvvPV35qBfweuMaHZt16RDpBNDoxq43ss90SQwU
         yhcsv51olVdaE7D8Ykby1qX+5KbBsLIH8dZlEwoSd1LVXdjl0tSuP4mvAtc+YqlDATQS
         9adw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728971238; x=1729576038;
        h=content-transfer-encoding:autocrypt:content-language:cc:to:subject
         :from:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GB08+bZjwtvGU3PV2Kyw6rs/EbzEepZD29srDnzoHoM=;
        b=SDHyM9Oh+YOB+HtZGv51qHPgthACTAbzrE465j5i8aaXixEnLQrxInSemmWQW6dS0G
         LyW0bPEzPbUqmMVootc5l4KggakGg3VtLbP8GrycbBIgx5zX+5mXfDM+p2HNq02V1zpv
         6wmn02BEWQGPG/DPvIagKiYSOYRhownCIB0GmBra+ckjsUSEzPrBWaGJWHnNfca/sy6L
         tP7fStFSpuSQWwJWIuZyg3FrBlT7Ln+2ptVmc73GSPXE2Ikk29/qGxX4bJwZ13cd4HgM
         DqrZlBgLEipyvxvgAE+XImOlJpRkb5SDBL4hwvzR9uZGk4oIgjGNZe6txBumxsHo4Foc
         MtmA==
X-Gm-Message-State: AOJu0YzQzIPCPR8wtgDpJo+UM70P9lBqfu8YlvksrBzsNMwhE+n6pr+v
	bpzctysTaqA2v7ieo3FHwhUqx+gKyNjsxerT5v944CmCoy5oGKy7UI6RYA==
X-Google-Smtp-Source: AGHT+IGqvT0+Zsz9RM5faG8z6gIxxpRm451vcENYTy/QucurNa4Cj2jEJu/wBZsdlDgiu8gk1Gxvzg==
X-Received: by 2002:adf:f1d2:0:b0:374:c847:852 with SMTP id ffacd0b85a97d-37d551f18e2mr8968122f8f.29.1728971237997;
        Mon, 14 Oct 2024 22:47:17 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9c13:8200:9c9c:f106:963e:7a47? (dynamic-2a02-3100-9c13-8200-9c9c-f106-963e-7a47.310.pool.telefonica.de. [2a02:3100:9c13:8200:9c9c:f106:963e:7a47])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37d7fc45577sm616330f8f.116.2024.10.14.22.47.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2024 22:47:16 -0700 (PDT)
Message-ID: <c57081a6-811f-4571-ab35-34f4ca6de9af@gmail.com>
Date: Tue, 15 Oct 2024 07:47:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net-next] net: phy: realtek: merge the drivers for internal
 NBase-T PHY's
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Language: en-US
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The Realtek RTL8125/RTL8126 NBase-T MAC/PHY chips have internal PHY's
which are register-compatible, at least for the registers we use here.
So let's use just one PHY driver to support all of them.
These internal PHY's exist also as external C45 PHY's, but on the
internal PHY's no access to MMD registers is possible. This can be
used to differentiate between the internal and external version.

As a side effect the drivers for two now external-only drivers don't
require read_mmd/write_mmd hooks any longer.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/realtek.c | 53 +++++++++++++++++++++++++++++++--------
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 166f6a728..830a0d337 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -92,6 +92,7 @@
 
 #define RTL_GENERIC_PHYID			0x001cc800
 #define RTL_8211FVD_PHYID			0x001cc878
+#define RTL_8221B				0x001cc840
 #define RTL_8221B_VB_CG				0x001cc849
 #define RTL_8221B_VN_CG				0x001cc84a
 #define RTL_8251B				0x001cc862
@@ -1040,6 +1041,23 @@ static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 	return val >= 0 && val & MDIO_PMA_SPEED_2_5G;
 }
 
+/* On internal PHY's MMD reads over C22 always return 0.
+ * Check a MMD register which is known to be non-zero.
+ */
+static bool rtlgen_supports_mmd(struct phy_device *phydev)
+{
+	int val;
+
+	phy_lock_mdio_bus(phydev);
+	__phy_write(phydev, MII_MMD_CTRL, MDIO_MMD_PCS);
+	__phy_write(phydev, MII_MMD_DATA, MDIO_PCS_EEE_ABLE);
+	__phy_write(phydev, MII_MMD_CTRL, MDIO_MMD_PCS | MII_MMD_CTRL_NOINCR);
+	val = __phy_read(phydev, MII_MMD_DATA);
+	phy_unlock_mdio_bus(phydev);
+
+	return val > 0;
+}
+
 static int rtlgen_match_phy_device(struct phy_device *phydev)
 {
 	return phydev->phy_id == RTL_GENERIC_PHYID &&
@@ -1049,7 +1067,8 @@ static int rtlgen_match_phy_device(struct phy_device *phydev)
 static int rtl8226_match_phy_device(struct phy_device *phydev)
 {
 	return phydev->phy_id == RTL_GENERIC_PHYID &&
-	       rtlgen_supports_2_5gbps(phydev);
+	       rtlgen_supports_2_5gbps(phydev) &&
+	       rtlgen_supports_mmd(phydev);
 }
 
 static int rtlgen_is_c45_match(struct phy_device *phydev, unsigned int id,
@@ -1061,6 +1080,11 @@ static int rtlgen_is_c45_match(struct phy_device *phydev, unsigned int id,
 		return !is_c45 && (id == phydev->phy_id);
 }
 
+static int rtl8221b_match_phy_device(struct phy_device *phydev)
+{
+	return phydev->phy_id == RTL_8221B && rtlgen_supports_mmd(phydev);
+}
+
 static int rtl8221b_vb_cg_c22_match_phy_device(struct phy_device *phydev)
 {
 	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, false);
@@ -1081,9 +1105,21 @@ static int rtl8221b_vn_cg_c45_match_phy_device(struct phy_device *phydev)
 	return rtlgen_is_c45_match(phydev, RTL_8221B_VN_CG, true);
 }
 
-static int rtl8251b_c22_match_phy_device(struct phy_device *phydev)
+static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev)
 {
-	return rtlgen_is_c45_match(phydev, RTL_8251B, false);
+	if (phydev->is_c45)
+		return false;
+
+	switch (phydev->phy_id) {
+	case RTL_GENERIC_PHYID:
+	case RTL_8221B:
+	case RTL_8251B:
+		break;
+	default:
+		return false;
+	}
+
+	return rtlgen_supports_2_5gbps(phydev) && !rtlgen_supports_mmd(phydev);
 }
 
 static int rtl8251b_c45_match_phy_device(struct phy_device *phydev)
@@ -1345,10 +1381,8 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtlgen_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
-		.read_mmd	= rtl822x_read_mmd,
-		.write_mmd	= rtl822x_write_mmd,
 	}, {
-		PHY_ID_MATCH_EXACT(0x001cc840),
+		.match_phy_device = rtl8221b_match_phy_device,
 		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
@@ -1359,8 +1393,6 @@ static struct phy_driver realtek_drvs[] = {
 		.resume		= rtlgen_resume,
 		.read_page	= rtl821x_read_page,
 		.write_page	= rtl821x_write_page,
-		.read_mmd	= rtl822x_read_mmd,
-		.write_mmd	= rtl822x_write_mmd,
 	}, {
 		PHY_ID_MATCH_EXACT(0x001cc838),
 		.name           = "RTL8226-CG 2.5Gbps PHY",
@@ -1438,8 +1470,9 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 	}, {
-		.match_phy_device = rtl8251b_c22_match_phy_device,
-		.name           = "RTL8126A-internal 5Gbps PHY",
+		.match_phy_device = rtl_internal_nbaset_match_phy_device,
+		.name           = "Realtek Internal NBASE-T PHY",
+		.flags		= PHY_IS_INTERNAL,
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
-- 
2.47.0



