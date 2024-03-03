Return-Path: <netdev+bounces-76890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2FC86F466
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 11:29:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B401F21399
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 10:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE3FD510;
	Sun,  3 Mar 2024 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9zARTJB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B0DB66C
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709461742; cv=none; b=rEvwMvPzMJOm6bzckp2plEQ3gouYzyjn2Lha/23CsjsMPVrhJPi0f1iSIQz60J/CG9dHgRto1vw3rqpdb2plELIp276dM5OThgryUnY9HgQh9KqstvCcJyr6m3utUjK7vZX3yYwWbdYFs1K7WQRwbyDmUYh1wCR6YDCSspRsB9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709461742; c=relaxed/simple;
	bh=a4ZFbAOK6KcgjI4gVOxddhu8QsHxjlTcUWdShOm8HNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tn2d6Dnl53Xjx9W1uXUQjbhix8plELRelkDQETsY0SQ/aZpR6VsGxBBfRLbOJN9X4tvKpOGYSgwz9kdc/utoZ/m0/xCt3nU9Sq1OfLwwi8CZ39ja0Uq7eucpPBY8dpd7BdmlxmmIUw0GEjJqc3p5PiYvGpEYF26PXJ4BlsfLoV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9zARTJB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a26fa294e56so627811866b.0
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 02:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709461739; x=1710066539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b6y1SeziApkZ0eKGMbxVte2CRcBvMUSFBLqp0S0zlk0=;
        b=R9zARTJBZ3KMODTIz0qUBzYfWDl3K1zh58X0QFf7h6vW/9kYVJfe0MRGbCDVgQM18m
         d3pAMB8ehbnwWhKl+9hYaEQSTvG+LaoZGvi5ZEYWbyRFZ+p1sk2HcdJ2zeYzw9yNLKeK
         9uAm/jJ3/zQnXpcUZ+s3nIKstn5Rhq4U+yJSa22RNVbM6KlejWKLWqvWp1co1L+tv0wP
         gQzqdjJsiEAIbmA3O9uRTBpBjv0gLBPGYEyORXSY4zMsSS8e+EeQr6EZUgGgqgSV4Y0k
         PQwaV4UGH9mpTfmQCPF958koKF69wk0r2LEI8M9acqSXCCeBbwHablBH8N4XMOXRs1Tn
         XSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709461739; x=1710066539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b6y1SeziApkZ0eKGMbxVte2CRcBvMUSFBLqp0S0zlk0=;
        b=PqGxOBA7lpWQewkMybjHRWbym2xtF6lchWCMnAAeOtkxlQTt6kGju2ViA/KZjhBGgV
         8GsLu3jUCe3yq8MSQKOJC8e3pVchkik3c3W4I0kgoKNRaAx44JhiLEzwK85SPKWaM0bP
         5CwZEbjntJpjFKuVNjCYMHLf6LcVP1ha9w9bm/w5UqmN0fx2aHyaegst34tzQKRM1hOj
         NWaOeQvT9kFOL8teRw3gxCOfOvKBsKZICmIRh9fZ6Tx/WEt/U5w/oRLEyHlYfc2za3Wm
         vLrXt0NGzcxGxlWz9xng1KFokaH4Yg/fbehpxbQq6HNPbuO/taHn8rMm1Z25EoM5Oxhc
         5SBQ==
X-Gm-Message-State: AOJu0YxKkPmFhqfqvqpzc6/olCwm1eql2hDqUmEs+MiIY6DuCluxHPBY
	6jJF40GURi1IbeGYJk5wndUjXt8Mg/3x/nWOJ5rGyPpNogMbbm7t
X-Google-Smtp-Source: AGHT+IGoeupRz9reqTYsmlq+UYKH44GVhN5VQo/NnIFTcISCBe4wexZln1H9kw0j7m2iDDCc2a4Jpg==
X-Received: by 2002:a17:906:55a:b0:a44:cf37:1908 with SMTP id k26-20020a170906055a00b00a44cf371908mr2407042eja.1.1709461739346;
        Sun, 03 Mar 2024 02:28:59 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm1530759ejb.97.2024.03.03.02.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 02:28:59 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v2 net-next 5/7] net: phy: realtek: add rtl822x_c45_get_features() to set supported ports
Date: Sun,  3 Mar 2024 11:28:46 +0100
Message-ID: <20240303102848.164108-6-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240303102848.164108-1-ericwouds@gmail.com>
References: <20240303102848.164108-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sets ETHTOOL_LINK_MODE_TP_BIT and ETHTOOL_LINK_MODE_MII_BIT in
phydev->supported.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/realtek.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 6449d8e0842c..3dc27a4f2c88 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -836,6 +836,16 @@ static int rtl822x_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl822x_c45_get_features(struct phy_device *phydev)
+{
+	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT,
+			 phydev->supported);
+	linkmode_set_bit(ETHTOOL_LINK_MODE_MII_BIT,
+			 phydev->supported);
+
+	return genphy_c45_pma_read_abilities(phydev);
+}
+
 static int rtl822x_c45_config_aneg(struct phy_device *phydev)
 {
 	bool changed = false;
@@ -1267,6 +1277,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY (C45)",
 		.config_init    = rtl822x_config_init,
 		.get_rate_matching = rtl822x_get_rate_matching,
+		.get_features   = rtl822x_c45_get_features,
 		.config_aneg    = rtl822x_c45_config_aneg,
 		.read_status    = rtl822x_c45_read_status,
 		.suspend        = genphy_c45_pma_suspend,
@@ -1288,6 +1299,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8221B-VN-CG 2.5Gbps PHY (C45)",
 		.config_init    = rtl822x_config_init,
 		.get_rate_matching = rtl822x_get_rate_matching,
+		.get_features   = rtl822x_c45_get_features,
 		.config_aneg    = rtl822x_c45_config_aneg,
 		.read_status    = rtl822x_c45_read_status,
 		.suspend        = genphy_c45_pma_suspend,
@@ -1309,6 +1321,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8251B 5Gbps PHY (C45)",
 		.config_init    = rtl822x_config_init,
 		.get_rate_matching = rtl822x_get_rate_matching,
+		.get_features   = rtl822x_c45_get_features,
 		.config_aneg    = rtl822x_c45_config_aneg,
 		.read_status    = rtl822x_c45_read_status,
 		.suspend        = genphy_c45_pma_suspend,
-- 
2.42.1


