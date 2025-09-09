Return-Path: <netdev+bounces-221401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A20B50719
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 22:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0BEC563961
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 20:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A90C36934C;
	Tue,  9 Sep 2025 20:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HTV/zbIq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175973629BB;
	Tue,  9 Sep 2025 20:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757449727; cv=none; b=EDHkZ+nA2Xex+Sb+/Mhzi1K0obLBQr4f7+oE7QLcgMYJMqWl+oF5or7emEdq6cJDp0C1qNhZdR7+o5NPQTEHdfX/QtiTkm8P9cIkUEysm4GAnKwJcicnGYKDKJMFQCBNEXzRODAqRj9bw6ENNoiRwcswseZVMDC4ssBByGR1t5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757449727; c=relaxed/simple;
	bh=xqzmN+hcDWdjI1wp5mt6YJAO8CEiKaGFkdm+SMNCRwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ImXknx5F0eA1r3cwIYuDzFim5RmPd06LyPXS+f6kN9VAqOoMHdg/GNJ9hr0j211cMmrjW5JkTRF5ssWbQc0DUv0mjrW8s22OY3g39Nr3ieua/ijPt0YZWEnLEpXjCIH+E3v2a42PMEJHNx3qOpp3U1UvzGZhpfjVmUYc0EqVI3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HTV/zbIq; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3e537dc30f7so2194851f8f.2;
        Tue, 09 Sep 2025 13:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757449723; x=1758054523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3MGEC/XQYb3lOYrR+g0YIhzentny2ld0sqpXIBxTIo=;
        b=HTV/zbIqnNbswZ4zOsnTstW/T9RpbFDYuC5Mmvn+AJL62sn6upGwsmJvK5e8eJ/Z7s
         /JG5Qaw4O2rRrsvPyq4TowU4VS6HLQmjmq5yjFrxmzH93I6LEQEzvg4vyyPvyfc87SdI
         aPagbsiutOtbihNeZ0OgXJvbr0YVY0jc11qn2iz9d6OlcmSh5SpmvrW77vQmI7qPQD7J
         DghzAdW4h+Pr8wC9q1FtRqvN76uafu32cFknfcYb9tgEewog++dO+LbovBJN2L36DeXQ
         HsiAH5i792Ckxsc6cX5RS+F0OJTAGwmc5nAKdE8o5K/RD5oiPwd5SazWzGFFHRPo9YhN
         1MBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757449723; x=1758054523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S3MGEC/XQYb3lOYrR+g0YIhzentny2ld0sqpXIBxTIo=;
        b=dUZ1l4J0nhz6Za4Rjwx2v20w3rbCv2gH0ZES+W4IWdOKWjcH+SIAXhrtiSWe9ihbiR
         vAjvLvCrBnuIcwJAsdBOi0otyW46K4qC7Zl1HvErL9udbWMGvgaDq2qfcURK0V5t+0Vw
         aY4xYMPphMMyxKEkBJcpWLpnCxWePPQuh0Du3Cbmx/nEjY2l49rHdgKjt1BOiadwq16Y
         h8spBQdWzu8TQUeJIotXNkURjXpndg3UO35EAunw+CWmNl0z1pKpoEv35l1P6fLdbNsW
         wJ/3oUJXw5wab/Jrb1j6DXre+gUUemEaTmvT25JSsqRxZyUV0jogfeqLOyJwjQPo2dmk
         02Ig==
X-Forwarded-Encrypted: i=1; AJvYcCU+cOCQlaKLl/u35GN/XdowckC04w2oRWwMnOkp+TqRgMP67009fUmZ1eJfRxpz2JfsJJS12SOa@vger.kernel.org, AJvYcCV7F6I6X+qdG0BlrlPolh8xEJHaW95o6k8NDu9iObY6krf+CqCp339QlkBxscnlflMAWJH9S9ko9ImJkrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlcF53Yk2jE6KDk78HKwHzu9vHn7UzsgrEPwBTURQF/JCyPpmm
	+eTAVSHVrTUVwCnpO8hEPW2c8Unsu+O/iRDQiAokrZ0aL7qnSSqzRX8d
X-Gm-Gg: ASbGncuLfnPx5z4GbQ0kAL2KZD5xMUacYaVQ4PdYIZcUfNyg+wW7St+U4jSvKQOsBdw
	uyhwYXmaT5L0QD14af8AQAHGOIeCf1WOesBNz9hHVxszMJBeZBMrcTtO9I30n2kNQHHofvJFHJ1
	fvgponVaELGyKb3j26Wvqk5cnJyqgaVQWuDhYxONynUztYDiU6Ys/XfSFLYTD+q0Wvj2njORWw/
	BTWt0bXyiilXfbDZrPnde7nJJRP2GHcBOJeajwXwXAMTGQD1nDHGt6WQn7CnhvU5rjprLqT5HR7
	bY6nlnz9ie3GT4BtNmrd2sWGrg1YiLa0gEk4w2DWsLNj2JU+v6Q2jdZxZ+BXowCVSgiKT0ed5Dz
	+sofsAr14Jke0GFzNCqEqpCTeD9zb1RpqfhyHgIyXbf2BJ9MAIfThW6nrWN1y51I15j+P31r1VD
	vwwCO+vw==
X-Google-Smtp-Source: AGHT+IE9eFrvQruA5iRd3VaBIRjX7yz/NCXLLNl9ae8b1S8rHl1x2ZwsC5vQVoj29Tk0u7IbdI/CkA==
X-Received: by 2002:a5d:5f48:0:b0:3d1:9202:9e with SMTP id ffacd0b85a97d-3e64392bb4emr12873571f8f.36.1757449723079;
        Tue, 09 Sep 2025 13:28:43 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3e7521be57esm3895842f8f.2.2025.09.09.13.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 13:28:42 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>
Subject: [net-next PATCH 3/3] net: phy: broadcom: Convert to PHY_ID_MATCH_MODEL macro
Date: Tue,  9 Sep 2025 22:28:12 +0200
Message-ID: <20250909202818.26479-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250909202818.26479-1-ansuelsmth@gmail.com>
References: <20250909202818.26479-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the pattern phy_id phy_id_mask to the generic PHY_ID_MATCH_MODEL
macro to drop hardcoding magic mask.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/broadcom.c | 105 +++++++++++++++----------------------
 1 file changed, 42 insertions(+), 63 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 46ca739dcd4a..3459a0e9d8b9 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -1436,8 +1436,7 @@ static int bcm54811_read_status(struct phy_device *phydev)
 
 static struct phy_driver broadcom_drivers[] = {
 {
-	.phy_id		= PHY_ID_BCM5411,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5411),
 	.name		= "Broadcom BCM5411",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1449,8 +1448,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.link_change_notify	= bcm54xx_link_change_notify,
 }, {
-	.phy_id		= PHY_ID_BCM5421,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5421),
 	.name		= "Broadcom BCM5421",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1462,8 +1460,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.handle_interrupt = bcm_phy_handle_interrupt,
 	.link_change_notify	= bcm54xx_link_change_notify,
 }, {
-	.phy_id		= PHY_ID_BCM54210E,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM54210E),
 	.name		= "Broadcom BCM54210E",
 	/* PHY_GBIT_FEATURES */
 	.flags		= PHY_ALWAYS_CALL_SUSPEND,
@@ -1481,8 +1478,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.set_wol	= bcm54xx_phy_set_wol,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM5461,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5461),
 	.name		= "Broadcom BCM5461",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1495,8 +1491,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM54612E,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM54612E),
 	.name		= "Broadcom BCM54612E",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1511,8 +1506,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.suspend	= bcm54xx_suspend,
 	.resume		= bcm54xx_resume,
 }, {
-	.phy_id		= PHY_ID_BCM54616S,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM54616S),
 	.name		= "Broadcom BCM54616S",
 	/* PHY_GBIT_FEATURES */
 	.soft_reset     = genphy_soft_reset,
@@ -1525,8 +1519,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM5464,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5464),
 	.name		= "Broadcom BCM5464",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1541,8 +1534,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM5481,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5481),
 	.name		= "Broadcom BCM5481",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1556,8 +1548,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id         = PHY_ID_BCM54810,
-	.phy_id_mask    = 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM54810),
 	.name           = "Broadcom BCM54810",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1575,8 +1566,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id         = PHY_ID_BCM54811,
-	.phy_id_mask    = 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM54811),
 	.name           = "Broadcom BCM54811",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1594,8 +1584,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM5482,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5482),
 	.name		= "Broadcom BCM5482",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1608,8 +1597,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM50610,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM50610),
 	.name		= "Broadcom BCM50610",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1624,8 +1612,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.resume		= bcm54xx_resume,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM50610M,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM50610M),
 	.name		= "Broadcom BCM50610M",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1640,8 +1627,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.resume		= bcm54xx_resume,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM57780,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM57780),
 	.name		= "Broadcom BCM57780",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1654,8 +1640,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCMAC131,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCMAC131),
 	.name		= "Broadcom BCMAC131",
 	/* PHY_BASIC_FEATURES */
 	.config_init	= brcm_fet_config_init,
@@ -1664,8 +1649,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.suspend	= brcm_fet_suspend,
 	.resume		= brcm_fet_config_init,
 }, {
-	.phy_id		= PHY_ID_BCM5241,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5241),
 	.name		= "Broadcom BCM5241",
 	/* PHY_BASIC_FEATURES */
 	.config_init	= brcm_fet_config_init,
@@ -1674,8 +1658,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.suspend	= brcm_fet_suspend,
 	.resume		= brcm_fet_config_init,
 }, {
-	.phy_id		= PHY_ID_BCM5221,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5221),
 	.name		= "Broadcom BCM5221",
 	/* PHY_BASIC_FEATURES */
 	.config_init	= brcm_fet_config_init,
@@ -1686,8 +1669,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.config_aneg	= bcm5221_config_aneg,
 	.read_status	= bcm5221_read_status,
 }, {
-	.phy_id		= PHY_ID_BCM5395,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM5395),
 	.name		= "Broadcom BCM5395",
 	.flags		= PHY_IS_INTERNAL,
 	/* PHY_GBIT_FEATURES */
@@ -1698,8 +1680,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM53125,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM53125),
 	.name		= "Broadcom BCM53125",
 	.flags		= PHY_IS_INTERNAL,
 	/* PHY_GBIT_FEATURES */
@@ -1713,8 +1694,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id		= PHY_ID_BCM53128,
-	.phy_id_mask	= 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM53128),
 	.name		= "Broadcom BCM53128",
 	.flags		= PHY_IS_INTERNAL,
 	/* PHY_GBIT_FEATURES */
@@ -1728,8 +1708,7 @@ static struct phy_driver broadcom_drivers[] = {
 	.link_change_notify	= bcm54xx_link_change_notify,
 	.led_brightness_set	= bcm_phy_led_brightness_set,
 }, {
-	.phy_id         = PHY_ID_BCM89610,
-	.phy_id_mask    = 0xfffffff0,
+	PHY_ID_MATCH_MODEL(PHY_ID_BCM89610),
 	.name           = "Broadcom BCM89610",
 	/* PHY_GBIT_FEATURES */
 	.get_sset_count	= bcm_phy_get_sset_count,
@@ -1745,27 +1724,27 @@ static struct phy_driver broadcom_drivers[] = {
 module_phy_driver(broadcom_drivers);
 
 static const struct mdio_device_id __maybe_unused broadcom_tbl[] = {
-	{ PHY_ID_BCM5411, 0xfffffff0 },
-	{ PHY_ID_BCM5421, 0xfffffff0 },
-	{ PHY_ID_BCM54210E, 0xfffffff0 },
-	{ PHY_ID_BCM5461, 0xfffffff0 },
-	{ PHY_ID_BCM54612E, 0xfffffff0 },
-	{ PHY_ID_BCM54616S, 0xfffffff0 },
-	{ PHY_ID_BCM5464, 0xfffffff0 },
-	{ PHY_ID_BCM5481, 0xfffffff0 },
-	{ PHY_ID_BCM54810, 0xfffffff0 },
-	{ PHY_ID_BCM54811, 0xfffffff0 },
-	{ PHY_ID_BCM5482, 0xfffffff0 },
-	{ PHY_ID_BCM50610, 0xfffffff0 },
-	{ PHY_ID_BCM50610M, 0xfffffff0 },
-	{ PHY_ID_BCM57780, 0xfffffff0 },
-	{ PHY_ID_BCMAC131, 0xfffffff0 },
-	{ PHY_ID_BCM5221, 0xfffffff0 },
-	{ PHY_ID_BCM5241, 0xfffffff0 },
-	{ PHY_ID_BCM5395, 0xfffffff0 },
-	{ PHY_ID_BCM53125, 0xfffffff0 },
-	{ PHY_ID_BCM53128, 0xfffffff0 },
-	{ PHY_ID_BCM89610, 0xfffffff0 },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5411) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5421) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM54210E) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5461) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM54612E) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM54616S) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5464) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5481) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM54810) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM54811) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5482) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM50610) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM50610M) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM57780) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCMAC131) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5221) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5241) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM5395) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM53125) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM53128) },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_BCM89610) },
 	{ }
 };
 
-- 
2.51.0


