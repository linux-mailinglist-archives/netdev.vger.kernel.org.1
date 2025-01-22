Return-Path: <netdev+bounces-160384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D6AA197C9
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 18:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B153A3689
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 17:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305A52153E4;
	Wed, 22 Jan 2025 17:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DZKgEsHO"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DE22144C3;
	Wed, 22 Jan 2025 17:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737567782; cv=none; b=jHo8QDCbscMbGy9Y1G4YkHtfp6sXC9WIyoadJIbGwmQAUHnXdKLB2JY1qQmMGhTMKGHjj9u2XWaSmSH1r2RsijxOKH0xl/xLvF7GfOPeZJPx/2FPtEjzVZYZaQJetFBDJKS2MT4TYcHcskoxDUYIQddLyqATLwnL2mrSlEFE9rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737567782; c=relaxed/simple;
	bh=DY1/k0eBlVapADi//qnq2XNXV3ROZemPRISpI5Bg+MY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yjb1b0qCE1ey8ksDN6/ReFgVipnPXUTbYdEVNoWY0MYnFExiD/0PwmMFkwRU1tvnfScrgY4ZbgObA6oo9WlJ18KAam9a2SqnKAP/1hAiF0uceXqq5qbqORjUnMC190ILEDytPxbtp7xe9e6DQJJ0o1JjvkL4LI7FvyN+Vo2tLnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DZKgEsHO; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 497721BF20A;
	Wed, 22 Jan 2025 17:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1737567777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R21uchUxZH3kd/+XEJyhxXfsQTWgj4LtDLMoHBD/ylY=;
	b=DZKgEsHO8ziv7KeVihZaDAIEhCh1W2pzfR6LOfaQptA4ggQY9zz5aqwCUiGElzu9cgUiSK
	KXD02YlVDWPSvzI5vzFGkleXUpEAhD1085GJr8YK6bOmOMyOgow14YSPtJy6jzEEB4ndt0
	Bzdw9LBNUuAK1lF7ZoNE6ytPzi7IL3C7D6Rk9CH9vVUxtMOxZLzeqE9Uz9vvYa4DC1cIa4
	TuWUOO8gtiKYUP34kMqG1cvw+jyDAPWcR7KPQvJazDfxKG2jejQ87bCGF0YU4J6TLi0eJd
	29mkCrWTfMZkoIgjPEvDN7WOJW9s0vDmb0EEc4EiJG11LqSiJHOcg52CcSCLqQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
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
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: [PATCH net-next RFC v2 1/6] net: ethtool: common: Make BaseT a 4-lanes mode
Date: Wed, 22 Jan 2025 18:42:46 +0100
Message-ID: <20250122174252.82730-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250122174252.82730-1-maxime.chevallier@bootlin.com>
References: <20250122174252.82730-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

When referring to BaseT ethernet, we are most of the time thinking of
BaseT4 ethernet on Cat5/6/7 cables. This is therefore BaseT4, although
BaseT4 is also possible for 100BaseTX. This is even more true now that
we have a special __LINK_MODE_LANES_T1 mode especially for Single Pair
ethernet.

Mark BaseT as being a 4-lanes mode.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
RFC V2: No changes

 net/ethtool/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 2bd77c94f9f1..8452d3216bce 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -244,7 +244,7 @@ static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 #define __LINK_MODE_LANES_LR8_ER8_FR8	8
 #define __LINK_MODE_LANES_LRM		1
 #define __LINK_MODE_LANES_MLD2		2
-#define __LINK_MODE_LANES_T		1
+#define __LINK_MODE_LANES_T		4
 #define __LINK_MODE_LANES_T1		1
 #define __LINK_MODE_LANES_X		1
 #define __LINK_MODE_LANES_FX		1
-- 
2.48.1


