Return-Path: <netdev+bounces-159482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42489A15988
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 23:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E3AA169326
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 22:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24581ACDE7;
	Fri, 17 Jan 2025 22:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="GD3VJmjL"
X-Original-To: netdev@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E821A8412
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 22:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737153069; cv=none; b=XyX3dgVFEhHwMl2yct2J/89759EhNMs8Kuo9do+DbmyAOJuKvp8jFx7YyIpeF3jUugfZkvpqyeaLR+ih1byTKJzg8Al0Ejn/Mj+JUxlBbKwuZJZ9PT0MrGuhxyFmKyXGaruJ1luNiK5CwdcmW1QDCUd8kfuUNPyYTB6NFuZH27o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737153069; c=relaxed/simple;
	bh=4Xg301BOw5IhDYCBHM1XrUWwybBAhWz8NEmK4U1SHVs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zbk9juZVDZXqEt8IUEL+FI+CJ52uFnERGTU7WipjHSQYntPkHxFRhHyeZ4urp+ylIuEYg0d9CEqNwstP/q96AZLgCL/IRd5Zq3BbIbZBCduSdNy+f2CLwWqHT8AB5QG2pxdPOtKvHLYy9vq6VNnhT5TgUGlgYNHMgkIVMSgDBnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=GD3VJmjL; arc=none smtp.client-ip=212.77.101.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 29152 invoked from network); 17 Jan 2025 23:24:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1737152663; bh=0GjytuyPEi25u7jlt3k9gL72XmPAz6CLG4hQuJbuXdA=;
          h=From:To:Cc:Subject;
          b=GD3VJmjLHqq/vW1ZA4l+iMJxyyPIeFNxY99CQduX3Db46OIMtiG3yt1C8sOsD5spa
           /Zsk9hUcxPh435jRo4CP0PG5kO7XNFK+J+x13zw137PvvWpkx0xssL5+ODlAXWuChO
           bgUqweU8/Ksof5tN1Kgkwdb+hWsixHJTMMH35FZJDZVnrZIERWTMJwj2Y6PBcnq8q/
           5MU11HKuulVdrnWcQ7XBBfwpUVyIcCmf+KIqh/67w2A7X+aH+EcCqS61D0snZ+MWKq
           DLvklzSIcE370gKDwhTqbpVrULYxgLB6KKSchZX0HlbkfsKUNh8TMt7h+4PUC7dZZ5
           APZN5dW2cwCDQ==
Received: from 83.24.126.149.ipv4.supernova.orange.pl (HELO laptop-olek.lan) (olek2@wp.pl@[83.24.126.149])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <andrew@lunn.ch>; 17 Jan 2025 23:24:23 +0100
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	ericwouds@gmail.com,
	kabel@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>
Subject: [PATCH net-next] net: phy: realtek: HWMON support for standalone versions of RTL8221B and RTL8251
Date: Fri, 17 Jan 2025 23:24:21 +0100
Message-Id: <20250117222421.3673-1-olek2@wp.pl>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-DKIM-Status: good (id: wp.pl)                                                      
X-WP-MailID: 4a2b373fcd1cacef38e745008cb86924
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [cVNk]                               

HWMON support has been added for the RTL8221/8251 PHYs integrated together
with the MAC inside the RTL8125/8126 chips. This patch extends temperature
reading support for standalone variants of the mentioned PHYs.

I don't know whether the earlier revisions of the RTL8226 also have a
built-in temperature sensor, so they have been skipped for now.

Tested on RTL8221B-VB-CG.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
---
 drivers/net/phy/realtek/realtek_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 38149958d95b..11ff44c3be5b 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -1475,6 +1475,7 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		.match_phy_device = rtl8221b_vb_cg_c22_match_phy_device,
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY (C22)",
+		.probe		= rtl822x_probe,
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822xb_config_init,
@@ -1487,6 +1488,7 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		.match_phy_device = rtl8221b_vb_cg_c45_match_phy_device,
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY (C45)",
+		.probe		= rtl822x_probe,
 		.config_init    = rtl822xb_config_init,
 		.get_rate_matching = rtl822xb_get_rate_matching,
 		.get_features   = rtl822x_c45_get_features,
@@ -1497,6 +1499,7 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		.match_phy_device = rtl8221b_vn_cg_c22_match_phy_device,
 		.name           = "RTL8221B-VM-CG 2.5Gbps PHY (C22)",
+		.probe		= rtl822x_probe,
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl822xb_config_init,
@@ -1509,6 +1512,7 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		.match_phy_device = rtl8221b_vn_cg_c45_match_phy_device,
 		.name           = "RTL8221B-VN-CG 2.5Gbps PHY (C45)",
+		.probe		= rtl822x_probe,
 		.config_init    = rtl822xb_config_init,
 		.get_rate_matching = rtl822xb_get_rate_matching,
 		.get_features   = rtl822x_c45_get_features,
@@ -1519,6 +1523,7 @@ static struct phy_driver realtek_drvs[] = {
 	}, {
 		.match_phy_device = rtl8251b_c45_match_phy_device,
 		.name           = "RTL8251B 5Gbps PHY",
+		.probe		= rtl822x_probe,
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.read_status    = rtl822x_read_status,
-- 
2.39.5


