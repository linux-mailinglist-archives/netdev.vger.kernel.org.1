Return-Path: <netdev+bounces-117285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B1494D775
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 21:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8431C22619
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 19:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B45216B381;
	Fri,  9 Aug 2024 19:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHiqahge"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E93B1684A7;
	Fri,  9 Aug 2024 19:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723232311; cv=none; b=YpXWkY/CCbKgHhvXXf7vospvaXbZgjb7LPriXqbZTVmBDUFirV6X/ODhmwojl5m/dWZzsoI5zxOwWAhX1EiztlVa6KbjZUWpCi1fNinf8yPbw9pJLpsMXAArefZj0vtxlP8qVCQpicocHHFKeArmNYJbQ6lKKOFZOqPmTQviEp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723232311; c=relaxed/simple;
	bh=/yCAqyA6gVsbQBhTheXOe+tlvtBKX20pI77Jv2ghB4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iz+O36xlTg6ovl6MHDHnsZ0Be4R1FqXeKAE+xvCJVeUyhljH40OQGTJBFn4iBkcd662ILaWsRTr+HNS/FQIHI/0FT3GHid2NS7jCWuVA9ocLgc5fIqUDfZdKmb9jPsQHsbFwhjN/khEKwGkQHQhI3LGFR0bhAnQWeGmv4wpUJvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHiqahge; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f029e9c9cfso37838631fa.2;
        Fri, 09 Aug 2024 12:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723232307; x=1723837107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1AAQSAmvvh8SOlXHbdx42aToLcQkg70Plu4sLk8pUEw=;
        b=PHiqahgeXiuGUwXZ0bdwv/cCYYFKn88IZoiJcZDwS916/5omyem0gcmojgjr2oLzUT
         Cm9O4a+28IDHZrzHWxYuO+Ko3mPXOg8RCYD+1dZYmSsSTfbH9hAiAJzJhy9E0RZWvjAw
         6nQ+fceaQbA2DWsSpQq7IIYmVGEOmxY/SgtwYFcYnwSi50aaS6BIB9z+l8sJJ7T/Pvav
         kTrP8OlIZcilcZRzcnli0/r5wsyclh0uJp93ObSy0J5LXk4vZN3KCRvnjGSJNcWT8uLY
         U7ELwW2ZOAaEQnP9mei5ZzgWHIbrfADY2ty/hwbnUauQKMCS0aSsFHY/USv4/iwcvbT/
         XZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723232307; x=1723837107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1AAQSAmvvh8SOlXHbdx42aToLcQkg70Plu4sLk8pUEw=;
        b=DVQdW6Mu7pDwERgjwA4EFTUZvAUw8Rv6dDfwuD6+x2CMpyvy/xtMq/7wVoUQxwnJUn
         QIHxyX6ORrrkEs3Z2HNSZm1al1o9KhVx6HSe+efWAh6eeIyXAaD8rbcI4bvloE7widHj
         y3hxpNc+FJEMGNWcCUQBGF2RNv3tRI5UmSJfzWFYtu4VeuHgHxRrmsHLd46EpfoNML0A
         w36TjXAXo3oOrdJQSe7CR2T9YL8cZnU3Ba4FBUx28z+Wj3hlc1DVYMOjG5XWlgU5VaOR
         5x3iJZrRuq3+AAfa/iQ6SwDrjn4+EKopHmNhpGoHd28UIpXLU2vfkLudLBwc1mnQwx9U
         vvjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1TNBU0iRNe2kephwx3D3Gh6/ZYTucW3BU3QWNSdAUY+IIbP6bS20FPx36vf7s6o8fUxC43LmL9yWTJ8Dm0dfqAwV9sex5QajqPuE7
X-Gm-Message-State: AOJu0YzGvG+JsLeV0wtuRb44AYXNfmoDTuHjq8wz1+RrrL2M70LDgqGQ
	bFbZIzMSOoJtv1TF85QooG8Od44ZDuqY81qUYOQ6fhZEJcwMCghAJEusZ+Ej
X-Google-Smtp-Source: AGHT+IE9TyV4vS5zhXWSys/IgkKu7uC4MHmmHrsAbsFHe1QK06MeZKtMFH3Ih+EpbgXpZBCJfKNZbQ==
X-Received: by 2002:a2e:bc0a:0:b0:2ef:2f9e:dd19 with SMTP id 38308e7fff4ca-2f1a6c4d2cdmr27630771fa.2.1723232306851;
        Fri, 09 Aug 2024 12:38:26 -0700 (PDT)
Received: from WBEC325.dom.lan ([2001:470:608f:0:8a4a:2fa4:7fd1:3010])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2f291df4987sm451311fa.50.2024.08.09.12.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 12:38:26 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: Pawel Dembicki <paweldembicki@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 3/5] net: dsa: vsc73xx: check busy flag in MDIO operations
Date: Fri,  9 Aug 2024 21:38:04 +0200
Message-Id: <20240809193807.2221897-4-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240809193807.2221897-1-paweldembicki@gmail.com>
References: <20240809193807.2221897-1-paweldembicki@gmail.com>
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

Fixes: 05bd97fc559d ("net: dsa: Add Vitesse VSC73xx DSA router driver")
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>

---
v3:
  - removed blank line and unnecessary variable init
v2:
  - used defines from patch moved to net-next

This patch came from net-next series[0].
Changes since net-next:
  - removed mutex
  - used method poll.h to poll busy value in 'vsc73xx_mdio_busy_check'
  - use 'vsc73xx_mdio_busy_check' for control if mdio is ready

[0] https://patchwork.kernel.org/project/netdevbpf/patch/20240729210615.279952-6-paweldembicki@gmail.com/
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 37 +++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 4b300c293dec..a789b2da9b7d 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -40,6 +40,10 @@
 #define VSC73XX_BLOCK_ARBITER	0x5 /* Only subblock 0 */
 #define VSC73XX_BLOCK_SYSTEM	0x7 /* Only subblock 0 */
 
+/* MII Block subblock */
+#define VSC73XX_BLOCK_MII_INTERNAL	0x0 /* Internal MDIO subblock */
+#define VSC73XX_BLOCK_MII_EXTERNAL	0x1 /* External MDIO subblock */
+
 #define CPU_PORT	6 /* CPU port */
 
 /* MAC Block registers */
@@ -225,6 +229,8 @@
 #define VSC73XX_MII_CMD		0x1
 #define VSC73XX_MII_DATA	0x2
 
+#define VSC73XX_MII_STAT_BUSY	BIT(3)
+
 /* Arbiter block 5 registers */
 #define VSC73XX_ARBEMPTY		0x0c
 #define VSC73XX_ARBDISC			0x0e
@@ -299,6 +305,7 @@
 #define IS_739X(a) (IS_7395(a) || IS_7398(a))
 
 #define VSC73XX_POLL_SLEEP_US		1000
+#define VSC73XX_MDIO_POLL_SLEEP_US	5
 #define VSC73XX_POLL_TIMEOUT_US		10000
 
 struct vsc73xx_counter {
@@ -527,6 +534,22 @@ static int vsc73xx_detect(struct vsc73xx *vsc)
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
@@ -534,12 +557,20 @@ static int vsc73xx_phy_read(struct dsa_switch *ds, int phy, int regnum)
 	u32 val;
 	int ret;
 
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		return ret;
+
 	/* Setting bit 26 means "read" */
 	cmd = BIT(26) | (phy << 21) | (regnum << 16);
 	ret = vsc73xx_write(vsc, VSC73XX_BLOCK_MII, 0, 1, cmd);
 	if (ret)
 		return ret;
-	msleep(2);
+
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		return ret;
+
 	ret = vsc73xx_read(vsc, VSC73XX_BLOCK_MII, 0, 2, &val);
 	if (ret)
 		return ret;
@@ -563,6 +594,10 @@ static int vsc73xx_phy_write(struct dsa_switch *ds, int phy, int regnum,
 	u32 cmd;
 	int ret;
 
+	ret = vsc73xx_mdio_busy_check(vsc);
+	if (ret)
+		return ret;
+
 	/* It was found through tedious experiments that this router
 	 * chip really hates to have it's PHYs reset. They
 	 * never recover if that happens: autonegotiation stops
-- 
2.34.1


