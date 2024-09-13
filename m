Return-Path: <netdev+bounces-128072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBAD977CE0
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7911E1C2475B
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 10:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26C21D7E55;
	Fri, 13 Sep 2024 10:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fRqlPiDN"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31331BF80A;
	Fri, 13 Sep 2024 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221922; cv=none; b=HjazE0zYUqpjF+fKxeJVVzEpupk/tQ6eB3udlL0hNB6ZQ+R+kOWx/UEkWqghG0xb7ZKG+Rnf/fKFgu32N7yssYHJ+LIiDxwsGpY7TFKkQS9sZ7W0+95dixdnUllok6Qkrz/KTkItqQI08sXsVmzWK4s4aSv5BTEYRXj3kMKTiGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221922; c=relaxed/simple;
	bh=bh/PlsZrGxdwL3qvcu5bFhI/khkna86n9sWvpxziZH8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=llXXQGJJXDazRqLeyRxOFyInqoixobQ+24es97or9z/PQlCxquIOTuGUnq/mYA2WdoOk/4JqT2CVkKNakGwKw8P2F+i1QjshCAINBGZN6avTxBUyYl5paEkvdJqfyHp1fBKezmECdl14MxW4LyTQVl+EuOd3LG2pnYC71qziF1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fRqlPiDN; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D9C8A1C0009;
	Fri, 13 Sep 2024 10:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726221918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sb8OmTvdd+dIsC9dyf2pocv8PVncITqBRJUMunpw6gw=;
	b=fRqlPiDNyGAeKYA0J99L2csaRyTf9rsykL2gUTFW3WA7eGha7aGdXfTFQ9Drlg4p+4LB+7
	YVF9w2pXzk1i1RlAdH566a3RQmcXsH51k/Nh0F3L5DJS/PPEWzln+tamotbPCrO9VgqNsO
	FQraR/7rSsCXteVM6AntmjxZWXsmQUv5310EFBwOh4+mhS9dAwNP9Xjd8AyiNVn5T9+Chg
	Wt0hW8q/0XKh+bUUXd/f3jD5dIw3qMM2wla2P7OqwWy57WmQWsy05fByUkPM8/OdulTiTG
	EDeZFXcasB4slkj8CFPZhL0DWAyDdwhqBOQcu8ta7twYg0tSTymJ3kEpL16VLQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com
Subject: [PATCH net-next] net: ethtool: phy: Don't set the context dev pointer for unfiltered DUMP
Date: Fri, 13 Sep 2024 12:05:14 +0200
Message-ID: <20240913100515.167341-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The context info allows continuing DUMP requests, shall they fill the
netlink buffer.

In the case of filtered DUMP requests, a reference on the netdev is
grabbed in the .start() callback and release in .done().

Unfiltered DUMP request don't need the dev pointer to be set in the context
info, doing so will trigger an unwanted netdev_put() in .done().

Reported-by: syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/000000000000d3bf150621d361a7@google.com/
Fixes: 17194be4c8e1 ("net: ethtool: Introduce a command to list PHYs on an interface")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
This patch fixes a commit that still lives in net-next.

 net/ethtool/phy.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index 4ef7c6e32d10..ed8f690f6bac 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -251,8 +251,6 @@ static int ethnl_phy_dump_one_dev(struct sk_buff *skb, struct net_device *dev,
 	int ret = 0;
 	void *ehdr;
 
-	pri->base.dev = dev;
-
 	if (!dev->link_topo)
 		return 0;
 
-- 
2.46.0


