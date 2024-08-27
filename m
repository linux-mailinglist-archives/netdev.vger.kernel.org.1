Return-Path: <netdev+bounces-122199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7D396057A
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCB1E281C2E
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 001F9196D98;
	Tue, 27 Aug 2024 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Vi6ThM1A"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81A64CB4E;
	Tue, 27 Aug 2024 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724750629; cv=none; b=JwyXa11fpjihFpTQP/b/vfU72kHqPb0pkPJ8DStvIR2DrY0d1Al1SkHm9zogqbQkFAf5aREXTid1pT3QcsMf5ZXMY/gIOw8spMu6VK8pN1HMoPmKRWya/ljF2VpPzP2y7XiVq77ixcKmyv2cmuFceKzGLJr7j6sFGEsGzoAOtDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724750629; c=relaxed/simple;
	bh=GnMxMbFa21i0AjWzZFRF1SIltwll+X0Z5w/p5GblnfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UmnyZkrmU7Lnh4oOb9wuxB9WRh997Qdc25k6Hh9qqEBp5z86HTCjpAzjcOoEr4eu+WgS/+bVNwL26f9Nf3NeAiTl+EctDi3xAPKsX2P0PUVMwSIulSCQW8J9LKHcTpxEEqY6aJu9lUmmYIHqiWNTnHi5iX3OVAwneFiFaueBeQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Vi6ThM1A; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7EB816000A;
	Tue, 27 Aug 2024 09:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724750626;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EHF2UpaLmFcwYZpC/94ZF9mKVK86yonSt/DhjZuU2JQ=;
	b=Vi6ThM1AO3DVyxMxMOWvGTs3YdAnf8u9t4GDt9ZvsEzab7u3FCOt46obxFaYDWCDYyMRmE
	RIgkUDLNm/8P2KR7dcrZulffCsSqJ1S+oXKQKQ7gaPHU0azChok23yIkjgAVxhs5P6HzIu
	XbqRj3EGbt46lg0wJmCOutZwSUXZTwAuDFjU2AgVbjUwz2n/7f/P5wfFoO+Vi11CudmbIo
	8QtIxgT0vyPhT8xXnzGqUBpCt+LLDcMjQ/vxzcaibhcvMWFj/WothN4qyEndXRbikwuF01
	Pwm154aHzlz26t2fox963UIR3U0xadPheQVFziJ4TX0XA8pTmLUw6xxAJcRKDg==
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
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: [PATCH net-next] net: ethtool: cable-test: Release RTNL when the PHY isn't found
Date: Tue, 27 Aug 2024 11:23:13 +0200
Message-ID: <20240827092314.2500284-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Use the correct logic to check for the presence of a PHY device, and
jump to a label that correctly releases RTNL in case of an error, as we
are holding RTNL at that point.

Fixes: 3688ff3077d3 ("net: ethtool: cable-test: Target the command to the requested PHY")
Closes: https://lore.kernel.org/netdev/20240827104825.5cbe0602@fedora-3.home/T/#m6bc49cdcc5cfab0d162516b92916b944a01c833f
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
---

I'm targetting this patch to net-next as this is where the commit it fixes lives.

 net/ethtool/cabletest.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ethtool/cabletest.c b/net/ethtool/cabletest.c
index ff2fe3566ace..371bdc1598ce 100644
--- a/net/ethtool/cabletest.c
+++ b/net/ethtool/cabletest.c
@@ -343,9 +343,9 @@ int ethnl_act_cable_test_tdr(struct sk_buff *skb, struct genl_info *info)
 	phydev = ethnl_req_get_phydev(&req_info,
 				      tb[ETHTOOL_A_CABLE_TEST_TDR_HEADER],
 				      info->extack);
-	if (!IS_ERR_OR_NULL(phydev)) {
+	if (IS_ERR_OR_NULL(phydev)) {
 		ret = -EOPNOTSUPP;
-		goto out_dev_put;
+		goto out_rtnl;
 	}
 
 	ops = ethtool_phy_ops;
-- 
2.45.2


