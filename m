Return-Path: <netdev+bounces-127088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B02C49740FA
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 19:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0D8282C4F
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 17:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D53819E7E0;
	Tue, 10 Sep 2024 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GRdtsHyj"
X-Original-To: netdev@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9715517A584;
	Tue, 10 Sep 2024 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725990406; cv=none; b=PSMI3Hf0lUgK/sTykrU4FheVLiLvTmL6MJO+Ttv0f+Fn8Gdd+FPUdPSFU8nMQ2eRJ7YypNmVuyGihcLRE2LRGG+Sdpe0LI1qQX2n4LB3Awr3+TRWY3FKcRWlM2ItJFDoWAJl+qPV7NDydnWOuR4Fms8xPgrXr2NdQKimVr1wcQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725990406; c=relaxed/simple;
	bh=5L170aaHaiQNUXme2FCcDwY0Y4/sk8V/9v31nUfkAig=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iuLrk6G9/7rU+8ItAk0zHZ9YkKCVOOt/JmtbLjO7kEKs7+PyQukdKq+yX5PloMOvBr0JQX89uDHr9rIrDaeU6s6out5wWyiNtYHUB8JsNv9tFJ2Q2U7ZQYqmXILB5cCvzsMZw3N8pu7djKFGDnE/AtuXN8rPhRhH6eLdvKKRU2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GRdtsHyj; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1C636240002;
	Tue, 10 Sep 2024 17:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725990401;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8sAeKFMvf+x+ARyRCKEDkQ7ZaGz+Oq5cUgRnc95/j5A=;
	b=GRdtsHyjEH3bI0d3aPr59ZEiQiSxkTJYM+0ImIKIB/7ijfXJ3B8SP6dhQOIV/iup1+oIPO
	zsomKahS3syUfvJC9/X+zWIct9rItKyTddzT2qm59GRselbaRRJBQyI1xQVl48fMYTWurQ
	CmpgTqrbagiPakeFD0shlymmJOOW3hAydAbIYaVIhVnPAVem3C//+02x5apohDUA88lJFb
	qifDxM6JDf+uMBnmqrSZ2uf+Zu47BpUDWkd2qThAPo9bv1DIprGlupq7YbrQtdTOMPp7d8
	DetljiY/dm8BlHTdyx0qYAOaPgUIrQ6IF7m3XRjWRVHxuEqdVU3706qQPblc4Q==
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
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next] net: ethtool: phy: Check the req_info.pdn field for GET commands
Date: Tue, 10 Sep 2024 19:46:35 +0200
Message-ID: <20240910174636.857352-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

When processing the netlink GET requests to get PHY info, the req_info.pdn
pointer is NULL when no PHY matches the requested parameters, such as when
the phy_index is invalid, or there's simply no PHY attached to the
interface.

Therefore, check the req_info.pdn pointer for NULL instead of
dereferencing it.

Suggested-by: Eric Dumazet <edumazet@google.com>
Reported-by: Eric Dumazet <edumazet@google.com>
Closes: https://lore.kernel.org/netdev/CANn89iKRW0WpGAh1tKqY345D8WkYCPm3Y9ym--Si42JZrQAu1g@mail.gmail.com/T/#mfced87d607d18ea32b3b4934dfa18d7b36669285
Fixes: 17194be4c8e1 ("net: ethtool: Introduce a command to list PHYs on an interface")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
Hi,

I'm targetting net-next as the commit this patch fixes is still in
net-next.

 net/ethtool/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index 560dd039c662..4ef7c6e32d10 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -164,7 +164,7 @@ int ethnl_phy_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_rtnl;
 
 	/* No PHY, return early */
-	if (!req_info.pdn->phy)
+	if (!req_info.pdn)
 		goto err_unlock_rtnl;
 
 	ret = ethnl_phy_reply_size(&req_info.base, info->extack);
-- 
2.46.0


