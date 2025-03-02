Return-Path: <netdev+bounces-171028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD8AA4B311
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 17:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F1D3B118F
	for <lists+netdev@lfdr.de>; Sun,  2 Mar 2025 16:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBBA1E9B18;
	Sun,  2 Mar 2025 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FlX0gW69"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D744F6DCE1;
	Sun,  2 Mar 2025 16:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740932512; cv=none; b=EYaNHwWOTlbxNxKvw2wwTkitAN772IfdIijJIC5O5qKFREDAartxEBZ8WkCX6WtU8NDTJDdTnW3JfA4H3MYqCGo5RCouZoWnmfaoplmxwwvzdWBxUEBQREQ9UqKCxsyfRCakjL5bTgGD0RYpg8MuJkCduuLYkMvSyxFAfbcXwuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740932512; c=relaxed/simple;
	bh=52pDudCLy5AhZ4j0hH7KhcrSAihM60axh6yD50qOTO4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gt8YIJHky6ELyVgLeW6LiNJR/QQSuLI/idP7q1bHursVw4MzThsbINZOj4jD+VkbNuiTY8mEcv+TTUkDJp2nsqu3rj8Z83aYbYR4wrPOLyjCJbmjZTVglCFxScVnY4oHGSThovESBv8xlZi+fSnDAroaWoCUYhnUFUzk4hWM5SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FlX0gW69; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EF1E144336;
	Sun,  2 Mar 2025 16:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740932502;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6KTI0fexig/v/YZZ5okK/ZmxEJpGbbOd4uN7XeT0n0A=;
	b=FlX0gW69pr0SQ0QmBZ03K24X6i254aSpwzlDunm1meTY2K0r/sshpkW/fqhKZydE/rjvby
	k/X4dl82LwvEkWsii4x329avVPk+h9kbh+m+D8f0b07biLOAk3sZtD9dAvA6yKb6L+zso8
	4oRm2Z66hiaivrG0M35VrWDyK1yYPK9UQskrXB4Fi81xxwqBxJj2GA+k9rLRy46AV5qUCl
	Vizwo1tniq5wtaJRl+acO7XVYtoWBxaH1N7yOMKjU9QeDHBXy3VbamhwSBqMRNQ1D+Br1t
	KSTguT1tTMtOZVBl/TSg3F9r7fYYO6wwTilO76OWC4pvQ3Nd7ULNslI4DB99aA==
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
Subject: [PATCH net] net: ethtool: Set the req_info->dev on DUMP requests for each dev
Date: Sun,  2 Mar 2025 17:21:36 +0100
Message-ID: <20250302162137.698092-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdelieeijecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehtdehueefuedtkeduleefvdefgfeiudevteevuefhgfffkeekheeuffeuhefhueenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvt
 hesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
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

Fixes: c15e065b46dc ("net: ethtool: Allow passing a phy index for some commands")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---

Fixes tag targets the phy-index commit, as it introduced a change in
behaviour for PLCA. From what I can tell, coalesce never correctly
detected irq_moder in DUMP requests.

We could also consider fixing all individual commands that use
req_info->dev, however I'm not actually sure it's incorrect to do so,
feel free to correct me though.

Maxime

 net/ethtool/netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ethtool/netlink.c b/net/ethtool/netlink.c
index b4c45207fa32..de967961d8fe 100644
--- a/net/ethtool/netlink.c
+++ b/net/ethtool/netlink.c
@@ -582,6 +582,7 @@ static int ethnl_default_dumpit(struct sk_buff *skb,
 		dev_hold(dev);
 		rcu_read_unlock();
 
+		ctx->req_info->dev = dev;
 		ret = ethnl_default_dump_one(skb, dev, ctx, genl_info_dump(cb));
 
 		rcu_read_lock();
-- 
2.48.1


