Return-Path: <netdev+bounces-190338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDAB8AB64D6
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72538861A7F
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 07:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E9C213235;
	Wed, 14 May 2025 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="b8fcLF1S"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE365202C48;
	Wed, 14 May 2025 07:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747209015; cv=none; b=D/bQe1O8ZdwNCVE3RuPMmOA0lpWViPnRCirzkFje484pwF9X1fZKDqNrSxBWQfDl9XPsY6vzfvDg2XO6w6wjTMKdo3ETokcENVRK6Ecbi4YwYHVA/BWjBMmhSp1Hn3j9c5UcPh9dRY6F6TZrO1p6EUJKHcnIYR8pnz15BSprK9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747209015; c=relaxed/simple;
	bh=lIkGmGfIjrAZfk2fQgWKZHCVN5DsE3M5QQ3MEXXkqns=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rsVKEHIF+XjP6frdt8VPBd6hKxvarJqHB0Lyw2OPqbf5yIUfxp0kjJQf55ifRt3Vgy0R98dD8ZdprBbQDXWpwhvst2iiZowaKCnZ8XP2o5FMgkzFmp/hrO3CYAAfHHG9ObKgf7nTEarawkNJp73hahhF7EJ63RhQlyBmskXu/0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=b8fcLF1S; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 34873439D4;
	Wed, 14 May 2025 07:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747209010;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HlHHz1L74kiM44iWfYp2Zig9MiHaBt/b0ww3GfKC6fg=;
	b=b8fcLF1SIPHCc/xreQGBhj1uCKc3B6khD/8Q9r3piIhYX5FM1Kiyc5TwrbAHGt4GqxSiyW
	7S3sm7KES4rutCBFcRAlmlWX3yKUGkT8HIGFlcTnxdAY5dkT0jWF0jZXYd0udDy+JpgVAr
	Tlbfyw5TIaHpee1W5nGEhg+hvV0jIfeOUunCzg6qNwcK7+KrsMD8Sfcvx79X6EUh2rG5X0
	pEQt5hfOzUfgiCNSHy50IMZEG4TB/1jJiNtckJwgHcqrc08Q3cHGE6xHzcyXCfa2robjt1
	M5pKsPQVNtjEPlW+dDHwhvzXtTSaeuiBJhWwGQ3VXNeInnmw7vi0AtVM8pxTZw==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Wed, 14 May 2025 09:49:57 +0200
Subject: [PATCH net-next 1/3] net: phy: dp83869: Restart PHY when
 configuring mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250514-dp83869-1000basex-v1-1-1bdb3c9c3d63@bootlin.com>
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

According to the DP83869 PHY datasheet, a software restart is required at
the end of every operational mode configuration. This resets all of the
PHY's circuits except the registers in the register file.

The DP83869 driver currently does not perform this restart operation, which
could theoretically cause issues if the PHY is in an intermediary state
when the operational mode is changed.

Add this software restart operation to dp83869_configure_mode().

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/dp83869.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index a62cd838a9eacc9edb0f472470a63079b6b72207..010434c94e01f44ac3c0b7e147468f4f7dca33f4 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -798,6 +798,10 @@ static int dp83869_configure_mode(struct phy_device *phydev,
 		return -EINVAL;
 	}
 
+	ret = phy_write(phydev, DP83869_CTRL, DP83869_SW_RESTART);
+
+	usleep_range(10, 20);
+
 	return ret;
 }
 

-- 
2.49.0


