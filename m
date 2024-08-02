Return-Path: <netdev+bounces-115246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FBB94597D
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 10:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3555288D5D
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 08:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C79A1C3F15;
	Fri,  2 Aug 2024 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ud29TvO8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217871C37B4;
	Fri,  2 Aug 2024 08:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722585874; cv=none; b=rgsiM9rDBemjIR9E9BG3nq4t+0moMvq8XZW4VTQEwjUvf0WkFCozU8WwT8S7YPQV+m1/MBJ8eaKOEWViUlv5lkWmy3TjU/bht+ZfrN4K+TAxMz1aTJl37hVyo/XtzNr640fesvjzBHrOHG/Ft10JIBnbdHmIZeGLQ4CtFY3OLMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722585874; c=relaxed/simple;
	bh=BAzeDWyhdsYxUDrMCciH1jpEOvGSYySqbFk6VBRmeao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3DBZqynC3LtrFS2QCgm63eG2vSqscI4yTDlc24O8GOHgnnzrxtvGO015M7iA3A2tEDS3G9RXDLkn940JI7IXVtQRaGIPKAX3pjftbu9YT4YBT8DPdEWkbcTBogpB5c7ooAxmyRsfd63R78XpgcBSlvqGo7Whcpn3nAqoWgLfk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ud29TvO8; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52efd08e6d9so11452337e87.1;
        Fri, 02 Aug 2024 01:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722585869; x=1723190669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yCs6h2UDX9N9y5d2OaQjEXDExrqKnK+N7jPDf8gyKrQ=;
        b=Ud29TvO8MufODFWvOQvrSUhVwmlqegaHbJwx/qvrHBVOeErO3jyp0wDfSIsdQjBr3x
         SJfu+zETRwgEZfg0pRTbNsOLpWXbJVxdRozNFpSheo4tgE8RDcRXFzbC9/7OC4BL89lO
         yn2nV/azM1T/56HTYPDW4YcZhT9cjRcLhkE5+vX+f26jD2CuyAroRNxdnq34Ztasvk+i
         fTFt84FsH5Ka5YOn0WpklDsEoBZOA+8lRfenU1BoGC9kMKBqXRlAQYHFZAUPeu1BM27y
         uoCxWdpgU2hs0WrrHP3noI8XhTpo8cKAtMkV+nx3Y+L3oKJeZeqFaME8dtuteULMuOZw
         5P+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722585869; x=1723190669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yCs6h2UDX9N9y5d2OaQjEXDExrqKnK+N7jPDf8gyKrQ=;
        b=m4xMwsjmdJ32G6nlKApYl4oKqvO4fztAcQW8uINpx3JIk+leCfFDc8LXY805jN3NVZ
         kx8GoOc/MwATJk6+sMB/jmANnNbhod9NI1abCbG3d40njKTZ69TzhWoDzoW96fI3SYIh
         sNwixGlLK2bo9R7QLP1hw8GIEclL2v5u0veMEsPcX5296EJ5AfhXj5Zehq9lo1zm9Pls
         cF2qgcLp7Z0Z/nnU/zAsLid2ndkmy8E/H/OeWQUjXp10Iw0shOvq/ITLvsgWdIypNGVA
         5beRJ4XqbxEwohg0kb+i6V5djmCHx3UHstWbbTnX+DOBcXanxrE8SbQGNcbRcolAP2ww
         UQKg==
X-Forwarded-Encrypted: i=1; AJvYcCXC4hCoiUvQpRSVx+7tBcx4cIUzRpMmPY5Kbr9Y+cjIudI6dwRENjdVr7jg22JJPDT7IojxjiBek1ROChuj5Xr+EClnZEQf8r5wFcUq
X-Gm-Message-State: AOJu0YyYRc2qhldgujCVESh0rZ5RHIOf66iuXUWD0ExQIsLLu5EVeSP7
	+8M8aMhmWLTTJaTQSTpuCICIZqa+RL7eiqtao5cNgXWkXHKC7H+u0OIFjYnx
X-Google-Smtp-Source: AGHT+IEKYC0SM3l4rjTZmoq/qNzRKfcs5ffYJ7UJacCjBqAIRiPXmN8aOWhLM0SmHt2cxPVwRe1kdw==
X-Received: by 2002:a05:6512:2808:b0:52e:be30:7e7 with SMTP id 2adb3069b0e04-530bb39297dmr1503511e87.1.1722585868589;
        Fri, 02 Aug 2024 01:04:28 -0700 (PDT)
Received: from WBEC325.dom.lan ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-530bba07e46sm163281e87.32.2024.08.02.01.04.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 01:04:28 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 4/6] net: dsa: vsc73xx: check busy flag in MDIO operations
Date: Fri,  2 Aug 2024 10:04:01 +0200
Message-Id: <20240802080403.739509-5-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240802080403.739509-1-paweldembicki@gmail.com>
References: <20240802080403.739509-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VSC73xx has a busy flag used during MDIO operations. It is raised
when MDIO read/write operations are in progress. Without it, PHYs are
misconfigured and bus operations do not work as expected.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

---
This patch came from net-next series[0].
Changes since net-next:
  - removed mutex
  - used method poll.h to poll busy value in 'vsc73xx_mdio_busy_check'
  - use 'vsc73xx_mdio_busy_check' for control if mdio is ready

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-6-paweldembicki@gmail.com/
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 33 ++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index b6c46a3da9a5..42b4f312c418 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -317,6 +317,7 @@
 #define IS_739X(a) (IS_7395(a) || IS_7398(a))
 
 #define VSC73XX_POLL_SLEEP_US		1000
+#define VSC73XX_MDIO_POLL_SLEEP_US	5
 #define VSC73XX_POLL_TIMEOUT_US		10000
 
 struct vsc73xx_counter {
@@ -545,6 +546,22 @@ static int vsc73xx_detect(struct vsc73xx *vsc)
 	return 0;
 }
 
+static int vsc73xx_mdio_busy_check(struct vsc73xx *vsc)
+{
+	int ret, err;
+	u32 val;
+
+	ret = read_poll_timeout(vsc73xx_read, err,
+				err < 0 || !(val & VSC73XX_MII_STAT_BUSY),
+				VSC73XX_MDIO_POLL_SLEEP_US,
+				VSC73XX_POLL_TIMEOUT_US, false, vsc,
+				VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
+				VSC73XX_MII_STAT, &val);
+	if (ret)
+		return ret;
+	return err;
+}
+
 static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
 {
 	struct vsc73xx *vsc = ds->priv;
@@ -552,6 +569,10 @@ static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
 	u32 val;
 	int ret;
 
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		return ret;
+
 	/* Setting bit 26 means "read" */
 	cmd = VSC73XX_MII_CMD_OPERATION |
 	      FIELD_PREP(VSC73XX_MII_CMD_PHY_ADDR, phy) |
@@ -560,7 +581,11 @@ static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
 			    VSC73XX_MII_CMD, cmd);
 	if (ret)
 		return ret;
-	msleep(2);
+
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		return ret;
+
 	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_MII, VSC73XX_BLOCK_MII_INTERNAL,
 			   VSC73XX_MII_DATA, &val);
 	if (ret)
@@ -583,7 +608,11 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 {
 	struct vsc73xx *vsc = ds->priv;
 	u32 cmd;
-	int ret;
+	int ret = 0;
+
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		return ret;
 
 	/* It was found through tedious experiments that this router
 	 * chip really hates to have it's PHYs reset. They
-- 
2.34.1


