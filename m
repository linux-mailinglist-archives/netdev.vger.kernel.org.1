Return-Path: <netdev+bounces-163353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0375CA29FAA
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 05:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3533A3450
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 04:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D69FA19047F;
	Thu,  6 Feb 2025 04:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2yUmz0Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8EA18D64B;
	Thu,  6 Feb 2025 04:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738816298; cv=none; b=RmFe/yH/DWgFIEbDS37D9kH4wClPH8HLj+95vx7cFbSK+r7h/TzNpM4R0vuQuOEJNBgnF+78pf17apdXsqocAwLU+hUcqSQi87QJJ6afebMgm7yeucI9805OYh6cK28/+ZocRqjrSL5ksUfqiLsZEBP3q+YkaydUj0ap4RSXGKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738816298; c=relaxed/simple;
	bh=rj4KTu+ajX31NqJii1zEbjLyc6O2Tmwr2E2PL4eQIOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zb4nI1hizMQ49XDYXC2NTxCNjuEfiaHsUilyP0D0JucoYNlRlP+ORsJ6qOhSIxBUURZRT/UJ2ca8OJvUjcZgW9ej84PkN3ng0rSp2tsQocbK++qpw4UUzW65PXfDhiUZn5NVRCLukLfh8SS4livyQ/PHdyvS/thc3G9J5Mj9f8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y2yUmz0Q; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21c2f1b610dso12827525ad.0;
        Wed, 05 Feb 2025 20:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738816297; x=1739421097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8acatil421MCBC0+THYc5jeXrL2jSB73N/GynhEtSU=;
        b=Y2yUmz0Qk2U7hh/PR9/fJHZ48Ag0KLSs0axXBkVSy7NoNkgKRMtJdWhuyCb9sUTRuk
         gFNGoDot8sMuiM5uSa2iWtdrj2MeCYfjHSF7wFf6qfjZESvw3AW5FusDQA6527py+0sP
         v42s22ZQKlOp4I0tPRH0YscFgzCOJ+dPwENunW7p1/ESGqilWDlaE+Z48vIBt16XXgSU
         g9ZNKEslN20N0ZeP6w4kbrqZFk2assfaRsJiLA/E8UTllCQ1CoDzavJMs9SfcogYdhbJ
         lPOQ86u64WWXGFi4ichfUPnezehS8+j6HpLVFBUNOvJPwrTqJEIEkeX7MkEvEP7pfc/M
         6Z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738816297; x=1739421097;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8acatil421MCBC0+THYc5jeXrL2jSB73N/GynhEtSU=;
        b=sjSkzVQaKjMojCccLCcqQ3W3+4I0mJmXtI8BRMJC4nxbn7o5OEE9LTG/gzKO2QHdnD
         f17qn8Su5A1YuZFynZnWLZLrY53Nw4UF7ti1dJVs/wVHTkulF+GOnP/ks9q33RED1kWJ
         0w6VwvYFvyJRG3ZvSuDAPKxfv9N/CGG6iul6D/7PIIbLM8RwHj5pwkIaU+BNlfQi23jj
         yT7c6yZfiaY7z+p+IKVUxEaH7p+1LyApIWbOi5W1ka2qIOBXzNb2ZrawSXW/JcFfa+tz
         S2e14D45mYzQvLS7u1/lsXleRRlUKZ0MdIdw5AtnjRmdcmihQYGpdymkz+2H6hYvL0HG
         0JjQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6M0582jpSGCeSWZ1VI0BhgbVdt+l6drjeBDE1z5aib40g7Y8ap6s9wkog6mxrBRV3IwgaE37J@vger.kernel.org, AJvYcCVkJ1WKgEEb53ju/11ACOgawuQfvG1kqWA/KoxK1QiWVCQ1KK129tx1rx0rCiNGXv8dZofgmQU25Fa6iD8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX5V8ELFeOMHBrbZLgxHB3yfAernDwRc70b9V2TRAYQf+5Fz+h
	OxUeLUifbC43IRjVuenha0sdGP+2hbSvEAhTNQ0/zNguLaCqDzFx
X-Gm-Gg: ASbGncvrozjfKj10nKkfflycoAC1JIzKdflI2a+uJVF9f4uZFdA6XyO8gFpMdKD5sXc
	mbK/u6Ml0HxoBw9DZktUDPIQSV5wBX1vC5sI3ub31IpXQZEMsJmo+tMKEmlM97Mcf1C6fQYBysq
	GJtZ6VW4UfiCUhALAPwa17Hv8ZE8T+DwIWYBg+XjHdNkIAPU0oTX4qu+g14lY6gFIGowGRQ+SuQ
	qTyC+3bzhyyHheR7weZf1PouS+qM7ApSkxvp5skSwSee7iV3fRu0yF6DhrfbrFXGRu03q/mZ0Jm
	pMVAuURuKWtvyOobLJBuo4Z77rBFMQmqkcY=
X-Google-Smtp-Source: AGHT+IFsQCx7hTEyC1asY8FfHU2EeavKDY8jVYJWsImpFHBJCSDZLokex67ydvog+IZqnQ5VouNCtg==
X-Received: by 2002:a05:6a20:c909:b0:1e0:c1d5:f3ac with SMTP id adf61e73a8af0-1ede88a6a01mr11293939637.32.1738816296656;
        Wed, 05 Feb 2025 20:31:36 -0800 (PST)
Received: from localhost.localdomain ([205.250.172.175])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73048c162f6sm305013b3a.143.2025.02.05.20.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 20:31:36 -0800 (PST)
From: Kyle Hendry <kylehendrydev@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Kyle Hendry <kylehendrydev@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] net: dsa: b53: mmap: Implement phy_enable for BCM63268 gphy
Date: Wed,  5 Feb 2025 20:30:48 -0800
Message-ID: <20250206043055.177004-5-kylehendrydev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250206043055.177004-1-kylehendrydev@gmail.com>
References: <20250206043055.177004-1-kylehendrydev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add register defines for gphy control register. When gphy is
enabled, disable low power mode.

Signed-off-by: Kyle Hendry <kylehendrydev@gmail.com>
---
 drivers/net/dsa/b53/b53_mmap.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/net/dsa/b53/b53_regs.h |  7 +++++++
 2 files changed, 41 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_mmap.c b/drivers/net/dsa/b53/b53_mmap.c
index 8157f9871133..ac0b8fc7eb4e 100644
--- a/drivers/net/dsa/b53/b53_mmap.c
+++ b/drivers/net/dsa/b53/b53_mmap.c
@@ -230,6 +230,38 @@ static int b53_mmap_phy_write16(struct b53_device *dev, int addr, int reg,
 	return -EIO;
 }
 
+static void bcm63268_gphy_set(struct b53_device *dev, bool enable)
+{
+	struct b53_mmap_priv *priv = dev->priv;
+	void __iomem *gphy_ctrl = priv->gphy_ctrl;
+	u32 val;
+
+	val = ioread32be(gphy_ctrl);
+
+	if (enable)
+		val &= ~(GPHY_CTRL_IDDQ_BIAS | GPHY_CTRL_LOW_PWR);
+	else
+		val |= GPHY_CTRL_IDDQ_BIAS | GPHY_CTRL_LOW_PWR;
+
+	iowrite32be(val, gphy_ctrl);
+}
+
+static void b53_mmap_phy_enable(struct b53_device *dev, int port)
+{
+	struct b53_mmap_priv *priv = dev->priv;
+
+	if ((dev->internal_gphy_mask & BIT(port)) && priv->gphy_ctrl)
+		bcm63268_gphy_set(dev, true);
+}
+
+static void b53_mmap_phy_disable(struct b53_device *dev, int port)
+{
+	struct b53_mmap_priv *priv = dev->priv;
+
+	if ((dev->internal_gphy_mask & BIT(port)) && priv->gphy_ctrl)
+		bcm63268_gphy_set(dev, false);
+}
+
 static const struct b53_io_ops b53_mmap_ops = {
 	.read8 = b53_mmap_read8,
 	.read16 = b53_mmap_read16,
@@ -243,6 +275,8 @@ static const struct b53_io_ops b53_mmap_ops = {
 	.write64 = b53_mmap_write64,
 	.phy_read16 = b53_mmap_phy_read16,
 	.phy_write16 = b53_mmap_phy_write16,
+	.phy_enable = b53_mmap_phy_enable,
+	.phy_disable = b53_mmap_phy_disable,
 };
 
 static int b53_mmap_probe_of(struct platform_device *pdev,
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index bfbcb66bef66..9607b28bbb86 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -525,4 +525,11 @@
 /* CFP Control Register with ports map (8 bit) */
 #define B53_CFP_CTRL			0x00
 
+/*************************************************************************
+ * Gigabit PHY Control Register
+ *************************************************************************/
+
+#define GPHY_CTRL_IDDQ_BIAS		BIT(0)
+#define GPHY_CTRL_LOW_PWR		BIT(3)
+
 #endif /* !__B53_REGS_H */
-- 
2.43.0


