Return-Path: <netdev+bounces-190339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13344AB64D8
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DAA4A2707
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 07:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE46A21770D;
	Wed, 14 May 2025 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="W1hid06S"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78F920468E;
	Wed, 14 May 2025 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747209015; cv=none; b=Tr/7Kd1y/Niy6jUlgZyPwxYKl6MmercxCJ2fpNfnQL49mHvtr4BKse9Nqvldctr4vqh7Qqiy0YLOuAEyBUbVzHVFvln2SPne5nhO0PDoF9WvFLOOh51GCtsbl2vVpBQrAQXjIsF4HrwJpjKUUrQlPLU33UEjBdQ/L5vtqhlOTO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747209015; c=relaxed/simple;
	bh=rFXq9Eh4AfZtVhcgXPLBBYOO/gxaXC4NwRmGogrHZ+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=foxOZOAkQwJIuPBn11OqoZ0CQYTtZocNeyeX3/bjtJZlyezbkkgRghy0N/Aoyy22N4NHQ4P4/9RKuSPza88hUP74ragiV4TbvvuGvvpza2tdVd+I3jlTWdWT5P/1JUJNd1mK8D8kP+kOWsskAHy6DEOOxApV1mVKXuZNaGH9E0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=W1hid06S; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C6632439D7;
	Wed, 14 May 2025 07:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747209011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lgogWU9QuINysVd/nX037PQoL4m2+xZnuMeWzDoH6L0=;
	b=W1hid06S0RWutZ6Xq3dM3WZ2OEkF0EsrG0rni5lRV4lJMvE2jjkXhYZBJ2P/xa4ZYA3c4K
	o3We9QWYMqO3oFe/T4Ni61p/gPBy8P/HhCHNVKR3ikVky9YrvppRgmuVzFDVdFipbvxe2O
	pQHn5SFTFDtkfzO8zsZyrGmcjCJ2ab2l5hLrmldeL2/b7s0bNyjgPclt5DK2pQL1Ncsota
	k7SSfTCiOtpj0K1IQPQ6otPrkAZ+ONfLYgz1JwpkYgz3t0/6gcEHrLTxEbh2dco2CGXH55
	9CWTB7nijqLpCiIRSeHHUxS8ODs413NTStKH2LLkd0flnQ1dUXYHu+lLdlXgig==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Wed, 14 May 2025 09:49:58 +0200
Subject: [PATCH net-next 2/3] net: phy: dp83869: ensure FORCE_LINK_GOOD is
 cleared
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-dp83869-1000basex-v1-2-1bdb3c9c3d63@bootlin.com>
References: <20250514-dp83869-1000basex-v1-0-1bdb3c9c3d63@bootlin.com>
In-Reply-To: <20250514-dp83869-1000basex-v1-0-1bdb3c9c3d63@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.2
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeftdeigeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheptfhomhgrihhnucfirghnthhoihhsuceorhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeekleeifeetleffueehvedtteekhfffhfetffekgfethfekveduuedtuefgffehgeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplgduledvrdduieekrddtrddufegnpdhmrghilhhfrhhomheprhhomhgrihhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhomhgri
 hhnrdhgrghnthhoihhssegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhm
X-GND-Sasl: romain.gantois@bootlin.com

The FORCE_LINK_GOOD bit in the PHY_CONTROL register forces the reported
link status to 1 if the selected speed is 1Gbps.

According to the DP83869 PHY datasheet, this bit should default to 0 after
a hardware reset. However, the opposite has been observed on some DP83869
components.

As a consequence, a valid link will be reported in 1000Base-X operational
modes, even if the autonegotiation process failed.

Make sure that the FORCE_LINK_GOOD bit is cleared during initial
configuration.

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/dp83869.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index 010434c94e01f44ac3c0b7e147468f4f7dca33f4..000660aae16ed46166774e7235cd8a6df94be047 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -89,6 +89,7 @@
 #define DP83869_STRAP_MIRROR_ENABLED           BIT(12)
 
 /* PHYCTRL bits */
+#define DP83869_FORCE_LINK_GOOD	BIT(10)
 #define DP83869_RX_FIFO_SHIFT	12
 #define DP83869_TX_FIFO_SHIFT	14
 
@@ -810,6 +811,15 @@ static int dp83869_config_init(struct phy_device *phydev)
 	struct dp83869_private *dp83869 = phydev->priv;
 	int ret, val;
 
+	/* The FORCE_LINK_GOOD bit in the PHYCTRL register should be
+	 * unset after a hardware reset but it is not. make sure it is
+	 * cleared so that the PHY can function properly.
+	 */
+	ret = phy_clear_bits(phydev, MII_DP83869_PHYCTRL,
+			     DP83869_FORCE_LINK_GOOD);
+	if (ret)
+		return ret;
+
 	/* Force speed optimization for the PHY even if it strapped */
 	ret = phy_modify(phydev, DP83869_CFG2, DP83869_DOWNSHIFT_EN,
 			 DP83869_DOWNSHIFT_EN);

-- 
2.49.0


