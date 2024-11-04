Return-Path: <netdev+bounces-141666-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 745A19BBF0E
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE8331F22695
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 20:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050E11F7085;
	Mon,  4 Nov 2024 20:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVlmrOTS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D6D1E3DCF;
	Mon,  4 Nov 2024 20:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730753602; cv=none; b=XiLQbLMlu8DS5ctfoGFi17qYRAreHyStyA542zVy6qO26cGR8OiUQhiIg1CR2JxjGkB4rRt1xWQIWVZW4QwXlVhCRZ3/JLxoxXUAVVbP9i9bEpAIQy8P6tT77LF5RmPMb02UfhjpIYD3uR53kw9T8Kjgio6EL5lMoCC5l0CGuTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730753602; c=relaxed/simple;
	bh=eV0X4Tt6AKNda/iAKasRq3UUgcy3r/nShRj6WUYB9bM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FDB9t54Ocdn/zoF6PFVrZ0XB+XRLHTwgr3lXlYzCSUpqXSKuaCzQ1Ss+sIwjUc6KDleSg4YE+PKTN3e9t7L6F+bl/AvmiYAFhajLFBQ6JA0yCcHfDpCtCy299jF8tP7soRS51Gfjhbrj1c562Ntb9EO7POgqHZCS7iQk3cuTuXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVlmrOTS; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-20caea61132so40922465ad.2;
        Mon, 04 Nov 2024 12:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730753600; x=1731358400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u3NxqzpwLMc803llN89ot2PHdhz8B1weA8PxgfsBwJQ=;
        b=JVlmrOTSoeNxljjPBXvfd2sflBZT8XnHn0XiUV3QgIZNjJCo2CI9ZxYj+OMI5AcVcv
         ZNkRbAhthgVZ5E+Uoc1jVfiPlYPREAh64SPbqCJt7KNk+4S56GZp8JwvT3baZe6x+t0P
         VqEzAeGqmYil1ahG7hZsFvVPxwQhJ/m1H0zDP42TjMqbjluAw1Qu50KdPmt9sILmT6Ux
         EkHDqK+MZWU6txiXUHXuclhbpLGjgLNwFTdltd/MRTLTaHYm0kDtLDPEWF71psOHnYxI
         g8pL8ZpwwORYBOHwEMC/ByjAK1+TybZI/f7Ny2iAW1EzdnmmnldnUDwnw21m04sul+zf
         ac+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730753600; x=1731358400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3NxqzpwLMc803llN89ot2PHdhz8B1weA8PxgfsBwJQ=;
        b=xKAwzI/vbYWIoj/httPyMSb/JhG5bcImqQuG8QD2DFhp8QRZ1ivJ4TbusijtNftLVn
         CF2ITJLgXk2ZSdO0duYluvOiolEEovGdRUsfCQxwe9wMyO+NCBWdZMajc0fAvHWEarKg
         Hfl1u+MnZr+T0EsWuWexeKAmEl2/5I54cSp3IG5hGIMSIRb1gfLokRt6ZFWKgGnKHmeo
         Oppcy+xufeUChRZdawgH9TgIHLYfx2Sf0pj9gtCABC9loWdmIBLyRvQH4AiYCutlsl0e
         vCkRBbK1BNrTPilSMjVEYHfODDDwFlT3ZStBvQi5G439Dz3fWSGii6w7BbCOsHFbaWk+
         w49g==
X-Forwarded-Encrypted: i=1; AJvYcCVof54Tsg/+M+IXeR2aAMolm90hNP+oIcuhi+Kj3wFqbUZTmMtbr6EjQj5Rbbl5/REQUMqKDQDg8rovBOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzefbaKr8THPL4dq1cu2OjjZ1oaoKJTFOA1oVdqX6ac7E5uxh2p
	44sdhFzHMuH9xStmcaQncqafCT0sZ9845NmE9DyHOYoE9H0PPNWWllpHX/Xu
X-Google-Smtp-Source: AGHT+IEXPyYWKuMG5H+vjZPl6opjMmw0LSdJAGqKWx12+QbVDfsCEH+pLQ3NdeYWY98/19J/C7WQpw==
X-Received: by 2002:a17:902:e847:b0:20c:a498:1e4d with SMTP id d9443c01a7336-2111afa9461mr178049245ad.60.1730753599871;
        Mon, 04 Nov 2024 12:53:19 -0800 (PST)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21105707059sm66189675ad.81.2024.11.04.12.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 12:53:19 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Justin Chen <justin.chen@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Doug Berger <opendmb@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next] net: broadcom: use ethtool string helpers
Date: Mon,  4 Nov 2024 12:53:17 -0800
Message-ID: <20241104205317.306140-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The latter is the preferred way to copy ethtool strings.

Avoids manually incrementing the pointer. Cleans up the code quite well.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: split off bnx2x changes.
 .../ethernet/broadcom/asp2/bcmasp_ethtool.c   |  6 +++---
 drivers/net/ethernet/broadcom/bcm63xx_enet.c  | 12 +++++------
 drivers/net/ethernet/broadcom/bcmsysport.c    | 20 +++++--------------
 drivers/net/ethernet/broadcom/bgmac.c         |  3 +--
 .../net/ethernet/broadcom/genet/bcmgenet.c    |  6 +++---
 drivers/net/phy/bcm-phy-lib.c                 |  3 +--
 6 files changed, 19 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
index 67928b5d8a26..9da5ae29a105 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c
@@ -101,14 +101,14 @@ static int bcmasp_get_sset_count(struct net_device *dev, int string_set)
 static void bcmasp_get_strings(struct net_device *dev, u32 stringset,
 			       u8 *data)
 {
+	const char *str;
 	unsigned int i;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < BCMASP_STATS_LEN; i++) {
-			memcpy(data + i * ETH_GSTRING_LEN,
-			       bcmasp_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
+			str = bcmasp_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
 		break;
 	default:
diff --git a/drivers/net/ethernet/broadcom/bcm63xx_enet.c b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
index e5e03aaa49f9..65e3a0656a4c 100644
--- a/drivers/net/ethernet/broadcom/bcm63xx_enet.c
+++ b/drivers/net/ethernet/broadcom/bcm63xx_enet.c
@@ -1339,14 +1339,14 @@ static int bcm_enet_get_sset_count(struct net_device *netdev,
 static void bcm_enet_get_strings(struct net_device *netdev,
 				 u32 stringset, u8 *data)
 {
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < BCM_ENET_STATS_LEN; i++) {
-			memcpy(data + i * ETH_GSTRING_LEN,
-			       bcm_enet_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
+			str = bcm_enet_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
 		break;
 	}
@@ -2503,14 +2503,14 @@ static const struct bcm_enet_stats bcm_enetsw_gstrings_stats[] = {
 static void bcm_enetsw_get_strings(struct net_device *netdev,
 				   u32 stringset, u8 *data)
 {
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < BCM_ENETSW_STATS_LEN; i++) {
-			memcpy(data + i * ETH_GSTRING_LEN,
-			       bcm_enetsw_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
+			str = bcm_enetsw_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
 		break;
 	}
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index 031e9e0cca53..42672c63f108 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -346,32 +346,22 @@ static void bcm_sysport_get_strings(struct net_device *dev,
 {
 	struct bcm_sysport_priv *priv = netdev_priv(dev);
 	const struct bcm_sysport_stats *s;
-	char buf[128];
-	int i, j;
+	int i;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
-		for (i = 0, j = 0; i < BCM_SYSPORT_STATS_LEN; i++) {
+		for (i = 0; i < BCM_SYSPORT_STATS_LEN; i++) {
 			s = &bcm_sysport_gstrings_stats[i];
 			if (priv->is_lite &&
 			    !bcm_sysport_lite_stat_valid(s->type))
 				continue;
 
-			memcpy(data + j * ETH_GSTRING_LEN, s->stat_string,
-			       ETH_GSTRING_LEN);
-			j++;
+			ethtool_puts(&data, s->stat_string);
 		}
 
 		for (i = 0; i < dev->num_tx_queues; i++) {
-			snprintf(buf, sizeof(buf), "txq%d_packets", i);
-			memcpy(data + j * ETH_GSTRING_LEN, buf,
-			       ETH_GSTRING_LEN);
-			j++;
-
-			snprintf(buf, sizeof(buf), "txq%d_bytes", i);
-			memcpy(data + j * ETH_GSTRING_LEN, buf,
-			       ETH_GSTRING_LEN);
-			j++;
+			ethtool_sprintf(&data, "txq%d_packets", i);
+			ethtool_sprintf(&data, "txq%d_bytes", i);
 		}
 		break;
 	default:
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 2599ffe46e27..18badb51a2f8 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1367,8 +1367,7 @@ static void bgmac_get_strings(struct net_device *dev, u32 stringset,
 		return;
 
 	for (i = 0; i < BGMAC_STATS_LEN; i++)
-		strscpy(data + i * ETH_GSTRING_LEN,
-			bgmac_get_strings_stats[i].name, ETH_GSTRING_LEN);
+		ethtool_puts(&data, bgmac_get_strings_stats[i].name);
 }
 
 static void bgmac_get_ethtool_stats(struct net_device *dev,
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 53a949eb9180..3e93f957430b 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1144,14 +1144,14 @@ static int bcmgenet_get_sset_count(struct net_device *dev, int string_set)
 static void bcmgenet_get_strings(struct net_device *dev, u32 stringset,
 				 u8 *data)
 {
+	const char *str;
 	int i;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < BCMGENET_STATS_LEN; i++) {
-			memcpy(data + i * ETH_GSTRING_LEN,
-			       bcmgenet_gstrings_stats[i].stat_string,
-			       ETH_GSTRING_LEN);
+			str = bcmgenet_gstrings_stats[i].stat_string;
+			ethtool_puts(&data, str);
 		}
 		break;
 	}
diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index 6c52f7dda514..59c2c6acc134 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -523,8 +523,7 @@ void bcm_phy_get_strings(struct phy_device *phydev, u8 *data)
 	unsigned int i;
 
 	for (i = 0; i < ARRAY_SIZE(bcm_phy_hw_stats); i++)
-		strscpy(data + i * ETH_GSTRING_LEN,
-			bcm_phy_hw_stats[i].string, ETH_GSTRING_LEN);
+		ethtool_puts(&data, bcm_phy_hw_stats[i].string);
 }
 EXPORT_SYMBOL_GPL(bcm_phy_get_strings);
 
-- 
2.47.0


