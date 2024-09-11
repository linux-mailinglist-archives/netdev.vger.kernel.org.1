Return-Path: <netdev+bounces-127410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAEF97546C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E597288885
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9FB1A2C3C;
	Wed, 11 Sep 2024 13:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="pRqGDVCC"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7083E1A2644;
	Wed, 11 Sep 2024 13:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062398; cv=none; b=KFEfL1JAZZl/qnoSTmujFENPzJTJPZI40jDqoayFDnSSBezcObgxt3HU9e3kpKzUb7ehim6Q1bx4zt1OXgqumo7opGDZdqFOihU9jUPqSlAtrqH3SZathUQZ/EMC2x7c9BHfpJggfb1HGhsRsszn1GX04fpo2HDXEHjCWSjjrvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062398; c=relaxed/simple;
	bh=zQmbZKg3+vNuAPvSUPF3vnq7Kcui4CbKT25w+X4Es0U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j+kc1G3Zc+UTvURpai/C5ANEha6fmWFmoVyYsO36OELM9q5LXcAzzWQQKPmp1keTy0vKfq+YKwXLrDe1f/CQlMh69JitIFs5E5vbrS0o6K7ZkeQJlIbnpXFDdlzvjPfoFN6XST9vVCMa6h9d5bRIWXZV+isgknHVQK1uLiPWNbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=pRqGDVCC; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BD583E000F;
	Wed, 11 Sep 2024 13:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726062388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=n23LjBJEpWfCJ+ZxF/dGp1fjzZeTLOwCdh892p3XNbw=;
	b=pRqGDVCCBpD3EjD2DQcSvoUP39gd3hMsePX4B4dOblNuSkMYeWHKtCmj+mFNetkskrgpHo
	QNwEkf1JoCLaoOpzxWHl/pwzQUp8VSnAK0m5l1qP/7yTiF+n7fI6zfx0jfOzHXLqO5yY36
	jP0bidcJ21tRvHi4u62uX0FqVnA5L7gulFKm3uslDHCu6EUz5QQOUPcVjtNiWPrWwD7RGm
	yrnUP4/xse0sRzWgKEMTgJJ3+T+JVTSD9hDBqdjHDkZGxFnM+jJsu0hyKxCdNE6u3STK8g
	BI+WPsRlbHmmXmMjBvD5ABzN3b0W47fBuPVIuwAxps0QrM/1+LpRqxtKDuWmRg==
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
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
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
Subject: [PATCH net-next] net: ethtool: phy: Clear the netdev context pointer for DUMP requests
Date: Wed, 11 Sep 2024 15:46:21 +0200
Message-ID: <20240911134623.1739633-1-maxime.chevallier@bootlin.com>
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
netlink buffer. When performing unfiltered dump request, clear the dev
pointer in the context at the end of the dump, avoiding the release of
the netdevice. In the case of a filtered DUMP, the refcount for the
netdev was held when parsing the header, and is released in the .done()
callback.

Reported-by: syzbot+e9ed4e4368d450c8f9db@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/000000000000d3bf150621d361a7@google.com/
Fixes: 17194be4c8e1 ("net: ethtool: Introduce a command to list PHYs on an interface")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 net/ethtool/phy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index 560dd039c662..99d2a8b6144c 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -301,6 +301,11 @@ int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
 
 			ctx->phy_index = 0;
 		}
+
+		/* Clear the context netdev pointer so avoid a netdev_put from
+		 * the .done() callback
+		 */
+		ctx->phy_req_info->base.dev = NULL;
 	}
 	rtnl_unlock();
 
-- 
2.46.0


