Return-Path: <netdev+bounces-177051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECA2A6D871
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 11:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE1F1892C61
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E8525E45B;
	Mon, 24 Mar 2025 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NyEkAL62"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77D825DCE4;
	Mon, 24 Mar 2025 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742812826; cv=none; b=gvz+tLsXEuNoevybsek7+pJx72v0TlIx2EBZISv98odAI66E6zbSB8B9Vk3kFcrQDgFKgYzab4NfkGG8DAjmKQMZORFkKAkMS9cfdZ372Q01N2Dc65pfM/DefyJOiFfpVZy2fKjS2OxHfPbPbaglTAvmVTddDY4tPGl1Ycu6Ehw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742812826; c=relaxed/simple;
	bh=gEeBITY1+ClamoASn7i0bzK3nI4YwjgxU2IQDf3aaiI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5ff94bJPPMfgcjhWSpe3JJeJsgl8zTFRGQNeHJc4X9smv8Jwfw+7s6iqXroWP+KCmUEmRUUGcaY6zUrID3e6rs1adTP6XYtiyRL1h75kzD7NQwxaQpdG2lKW7igDuWxqULl6BfXiT5rK0J6YVgg3XBAz5Rrbq1ZgmJgipbpxt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NyEkAL62; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3FE4442EF2;
	Mon, 24 Mar 2025 10:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742812817;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AJY5QtUZ+l2cU5lE2ea9Uk5hUsgrVL+Y7Y03zrA9ueA=;
	b=NyEkAL62b/yB+iGr7Fo1IVLInyf/nO7bw2lc8JsZPxUCCfG8KP9pcnKLE2aPPxDeLblb+f
	I7fvBwXd6zvCmVLRj7HmodZ8kP6cQ9FIk+XCP+sMtRcLc10YuCcha0jj6Bw+hGPlsnOhie
	JTEA56wL5BUKZd2+ZKKqGj8VEd3PrAo+DJ0sR1MWQxfTOHBMVeBFExpGCPcFnwb+ju5pcw
	fqJJgQ0R7czGf4aheXVJERQtJezY760nvxThNrydz0JUjcZSbrWygwwtoNrF9sR0vl4geH
	HZiHBPUR/5ej57fBNRB+kp8RChjRCusbpfrJ0MIUDQlHC74PYb0Ifb7NCdvf0Q==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: [PATCH net-next v4 1/8] net: ethtool: Set the req_info->dev on DUMP requests for each dev
Date: Mon, 24 Mar 2025 11:40:03 +0100
Message-ID: <20250324104012.367366-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
References: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepveegtdffleffleevueellefgjeefvedvjefhheegfefgffdvfeetgeevudetffdtnecukfhppedvrgdtudemtggsudelmeekugegheemgeeltddtmeehvdgrfeemjegsledumeduhegtleemtgeltdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddumegtsgduleemkegugeehmeegledttdemhedvrgefmeejsgeludemudehtgelmegtledtiedphhgvlhhopeguvghvihgtvgdqvdegrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvu
 ghumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: maxime.chevallier@bootlin.com

There are a few netlink commands that rely on the req_info->dev field
being populated by ethnl in their ->prepare_data() and ->fill_reply().

For a regular GET request, this will be set by ethnl_default_parse(),
which calls ethnl_parse_header_dev_get().

In the case of a DUMP request, the ->prepare_data() and ->fill_reply()
callbacks will be called with the req_info->dev being NULL, which can
cause discrepancies in the behaviour between GET and DUMP results.

The main impact is that ethnl_req_get_phydev() will not find any
phy_device, impacting :
 - plca
 - pse-pd
 - stats

Some other commands rely on req_info->dev, namely :
 - coalesce in ->fill_reply to look for an irq_moder

Although cable_test and tunnels also rely on req_info->dev being set,
that's not a problem for these commands as :
 - cable_test doesn't support DUMP
 - tunnels rolls its own ->dumpit (and sets dev in the req_info).
 - phy also has its own ->dumpit

All other commands use reply_data->dev (probably the correct way of
doing things) and aren't facing this issue.

Simply set the dev in the req_info context when iterating to dump each
dev.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V4 : New patch (was sent separaltely once)

 net/ethtool/netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index a163d40c6431..6b1725795435 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -591,6 +591,7 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 		dev_hold(dev);
 		rcu_read_unlock();
 
+		ctx->req_info->dev = dev;
 		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
 
 		rcu_read_lock();
-- 
2.48.1


