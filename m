Return-Path: <netdev+bounces-230194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85748BE5394
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 21:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10F31898B33
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 19:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD982D97B9;
	Thu, 16 Oct 2025 19:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="1rRVZjcJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE18225415
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 19:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760642616; cv=none; b=Hra0xQLN/UzjnrfSEg/DrWpIRsmVxVFbOwOMfW6q57cdtZhroZo8wZUh38cWo2GopoS3NMQyuR760wZ5SiCOm58ZkqFW/qyfE1OjoVyVEaqJ7N6fuL3BQICYTLToyeOiBSEFOCStnHbsacpxtMavPGoFB5O2CIqqyphDFr4XBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760642616; c=relaxed/simple;
	bh=qPZyqqlDuxupwy3hqSnQfIURpZPS/AwJNmqI4HhPNE0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=LBt6lR3f+ykyKw4isVOT09EIc33ZvYntJFpRDFM4cBsFEmULIHXpY5uSKgj3J1GZsZJptgP0T/IHWO1HLkOfnaOv9liLBU3aPEnArfMLg0nbBRHZufY2bwUX9Jc1wcAJrQOsAzVAjhRVDDz5VgnlWxH88zseJ2Tg6HYMosn7m+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=1rRVZjcJ; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 33255 invoked from network); 16 Oct 2025 21:23:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1760642611; bh=e7IBYjNUi7Lb06DrRP+uQ7pq93oWoPw2ibUwX8GbUDM=;
          h=From:To:Subject;
          b=1rRVZjcJdFsJ3pBmLZjhnq27q7b064x90Oz5jsTAO+6acwCOKkArbV/FwBWE43PhK
           f0MajVzIYuBNFnmbsoAnEt4bQ+tIHhBFRkc06cwYenR6d1t2fKtgCu7dvWEILi/qnh
           shJN3KR796CjlABz+EQTXms/MXlhufeI6CwQUjjygPl/rISE8k8DZ4OKGD1dxhqliA
           MvWN1HSMY7KHLC+CffVKWmIT6GmJ6oQza3SMDiEAgRi9amJ/BYmXjSwOgE4vGyjYCe
           MfBC+qT+RKjLzW39HQ74RHDm98GR2/DX7408Wp/Zp3Z8DF/P42cjExjJo1XltW8k03
           hsGWWKfDRVFGg==
Received: from 83.24.133.17.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.133.17])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 16 Oct 2025 21:23:31 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	michael@fossekall.de,
	daniel@makrotopia.org,
	olek2@wp.pl,
	rmk+kernel@armlinux.org.uk,
	kabel@kernel.org,
	ericwouds@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: phy: realtek: fix rtl8221b-vm-cg name
Date: Thu, 16 Oct 2025 21:22:52 +0200
Message-ID: <20251016192325.2306757-1-olek2@wp.pl>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 0f1545edf1641a304771a642558411d5
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [QXOk]                               

When splitting the RTL8221B-VM-CG into C22 and C45 variants, the name was
accidentally changed to RTL8221B-VN-CG. This patch brings back the previous
part number.

Fixes: ad5ce743a6b0 ("net: phy: realtek: Add driver instances for rtl8221b via Clause 45")
Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/phy/realtek/realtek_main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index a724b21b4fe7..16a347084293 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -154,7 +154,7 @@
 #define RTL_8211FVD_PHYID			0x001cc878
 #define RTL_8221B				0x001cc840
 #define RTL_8221B_VB_CG				0x001cc849
-#define RTL_8221B_VN_CG				0x001cc84a
+#define RTL_8221B_VM_CG				0x001cc84a
 #define RTL_8251B				0x001cc862
 #define RTL_8261C				0x001cc890
 
@@ -1523,16 +1523,16 @@ static int rtl8221b_vb_cg_c45_match_phy_device(struct phy_device *phydev,
 	return rtlgen_is_c45_match(phydev, RTL_8221B_VB_CG, true);
 }
 
-static int rtl8221b_vn_cg_c22_match_phy_device(struct phy_device *phydev,
+static int rtl8221b_vm_cg_c22_match_phy_device(struct phy_device *phydev,
 					       const struct phy_driver *phydrv)
 {
-	return rtlgen_is_c45_match(phydev, RTL_8221B_VN_CG, false);
+	return rtlgen_is_c45_match(phydev, RTL_8221B_VM_CG, false);
 }
 
-static int rtl8221b_vn_cg_c45_match_phy_device(struct phy_device *phydev,
+static int rtl8221b_vm_cg_c45_match_phy_device(struct phy_device *phydev,
 					       const struct phy_driver *phydrv)
 {
-	return rtlgen_is_c45_match(phydev, RTL_8221B_VN_CG, true);
+	return rtlgen_is_c45_match(phydev, RTL_8221B_VM_CG, true);
 }
 
 static int rtl_internal_nbaset_match_phy_device(struct phy_device *phydev,
@@ -1879,7 +1879,7 @@ static struct phy_driver realtek_drvs[] = {
 		.suspend        = genphy_c45_pma_suspend,
 		.resume         = rtlgen_c45_resume,
 	}, {
-		.match_phy_device = rtl8221b_vn_cg_c22_match_phy_device,
+		.match_phy_device = rtl8221b_vm_cg_c22_match_phy_device,
 		.name           = "RTL8221B-VM-CG 2.5Gbps PHY (C22)",
 		.probe		= rtl822x_probe,
 		.get_features   = rtl822x_get_features,
@@ -1892,8 +1892,8 @@ static struct phy_driver realtek_drvs[] = {
 		.read_page      = rtl821x_read_page,
 		.write_page     = rtl821x_write_page,
 	}, {
-		.match_phy_device = rtl8221b_vn_cg_c45_match_phy_device,
-		.name           = "RTL8221B-VN-CG 2.5Gbps PHY (C45)",
+		.match_phy_device = rtl8221b_vm_cg_c45_match_phy_device,
+		.name           = "RTL8221B-VM-CG 2.5Gbps PHY (C45)",
 		.probe		= rtl822x_probe,
 		.config_init    = rtl822xb_config_init,
 		.get_rate_matching = rtl822xb_get_rate_matching,
-- 
2.47.3


