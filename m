Return-Path: <netdev+bounces-167020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB69A38515
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:48:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29FB57A42E8
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D343A29D05;
	Mon, 17 Feb 2025 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AMvYTjNw"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0A748F;
	Mon, 17 Feb 2025 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739800108; cv=none; b=M8VCuu0Z/GziVgkc4e9IByMgXLId22+PTWDgVl87Ff5xKStwb+J/DOEKLEYiTe+aTI/y1FhUMu0BAfdgGB/Tplf7rQIC9xrThWj595anNkHCP6dv2BmIB2myZVTpZ6kAVMJKYJShFJkQQ5BscDMF+enmrNseM5qVnn0goPc02T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739800108; c=relaxed/simple;
	bh=QT9wgBW9Yu+jHnvM0+mY6bn230FRmCK2bCA1BlAfwDA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Jc4ju6wc3FtM8m14vny7ZEKEhzA2psFQJj5wXcl+eRuVxmD7Elb9YOe76YcGW0ZeCXxQPrZ7zzZm1PrOLUEywdeS6nzet3LttUrm416/kw/msZ+4jvyZnOaAHKcIqCcrMGCIAjKunSR0OcUjKLSHS2T7pTVWwX1R3ZekJu0ZxOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AMvYTjNw; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F0E82443F7;
	Mon, 17 Feb 2025 13:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739800104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DZNFSzJF17STaw7FqO1S5Zitm8jZzZb7Hu9FHODJy34=;
	b=AMvYTjNwYFwLL5LsITJSr8ewL04ehCufHI00J6MAmkTSYPi0rolBM5/o9qJvUYgkgSVInk
	Kitw9HPA05lCbh+6aNcPa4gFNTPFCOTzh48Eql2f/epgj19mI1iIrQBf/oPFVe3YUMpfiK
	bs+fhZuTgeLhOx3k7CHUeJyIMkpXArE3+RacxzsZz7LUgV+MZUUerlsZBO61g+aqhEUy6Q
	PuGvNjq8jmhjgpAU5whguTIC+0H2pMw/KpLS3xz3Q/SbsRNouK/nE/02QX0F+nJgWIw8Qi
	UF286bry9KngVsk4GvUHJw8+at1W75bXXD5LEg2odg3WKxEjnODUhagzr3BN2g==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	"Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: pse-pd: pd692x0: Fix power limit retrieval
Date: Mon, 17 Feb 2025 14:48:11 +0100
Message-Id: <20250217134812.1925345-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeehiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepmfhorhihucforghinhgtvghnthcuoehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeegudegvdeklefhheefueeiieegteegteeuudegteduvdevffeikefgjeekgfdukeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghlohepkhhmrghinhgtvghnthdqigfrufdqudefqdejfeeltddrrddpmhgrihhlfhhrohhmpehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedutddprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohdrrhgvmhhpvghlsehpvghnghhuthhrohhnihigrdguvgdprhgtphhtthhopehkohhrhidrmhgrihhntggvnhhtsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvg
 hgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhhohhmrghsrdhpvghtrgiiiihonhhisegsohhothhlihhnrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvght
X-GND-Sasl: kory.maincent@bootlin.com

Fix incorrect data offset read in the pd692x0_pi_get_pw_limit callback.
The issue was previously unnoticed as it was only used by the regulator
API and not thoroughly tested, since the PSE is mainly controlled via
ethtool.

The function became actively used by ethtool after commit 3e9dbfec4998
("net: pse-pd: Split ethtool_get_status into multiple callbacks"),
which led to the discovery of this issue.

Fix it by using the correct data offset.

Fixes: a87e699c9d33 ("net: pse-pd: pd692x0: Enhance with new current limit and voltage read callbacks")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pd692x0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index fc9e23927b3b..7d60a714ca53 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -1047,7 +1047,7 @@ static int pd692x0_pi_get_pw_limit(struct pse_controller_dev *pcdev,
 	if (ret < 0)
 		return ret;
 
-	return pd692x0_pi_get_pw_from_table(buf.data[2], buf.data[3]);
+	return pd692x0_pi_get_pw_from_table(buf.data[0], buf.data[1]);
 }
 
 static int pd692x0_pi_set_pw_limit(struct pse_controller_dev *pcdev,
-- 
2.34.1


