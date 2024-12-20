Return-Path: <netdev+bounces-153787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9F249F9AF3
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6322188BCEB
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 20:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5229322579F;
	Fri, 20 Dec 2024 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VKpNX6Oy"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984BE259494;
	Fri, 20 Dec 2024 20:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734725721; cv=none; b=XuTvJa7l9SiaukEvRtAPNc4txXsCLamqKAr0coB+SD8v/Hw7neRa/iURk0NV8cBvzj21OXpD2vVKLuc18nSGpTYeWp9tQRbWqtAyHe2I3/KOaWLuoDHgk8c6mADN9+2mfrLqCPxVUFbAkVfGQi9LSTOxfEgDwDMWqaDf9BfMiP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734725721; c=relaxed/simple;
	bh=/fjvabV5V+EH0xyoFzYx9T3h1I3YNcOS2AATOFweRDA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GyF+sN49FLyNqZf8EXLNBy+IJwtlk7asHscmTT45y70GlcgKREAr4y+p3u4TZlKhDPqFwdxb+v/N47mXK30l78+Zo8lArOjnFNrHs52B2jsLQ5PqtjgwS97j18nL9elkqUm23qpcIyqXxnVVCylD5KmZh4XQjHskELyf9K45yUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VKpNX6Oy; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3005BE0002;
	Fri, 20 Dec 2024 20:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1734725711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0VEJe+1swjZgkADNkawN3wsqrsvKx3yd9+z0b1zAaso=;
	b=VKpNX6OyJU7dGG5vvrytkpBk2GMh0p1cQblILZsQ9pyj2Otzg029rX/FPyAdiaa88MtCqS
	DLE3ejbHCgCO7ujEqKqlURuk3JXlckE+ipfcK5w5AEFDvSicwGYpj+gfuu08ucLTrS0BSs
	WuVUYbuOfmjPyAruxokqErDE68HHGYfKaMXSDzlP2OInFDRweD5JXUbklw9aIyXp9IVcaI
	nIn5oPNnHnmXP+J4wIz6DcaqmIdETVAaGgQNO23SrYIFX76gY7Ji6PT5xrJOsUUXAuly5r
	PDPj9+DV8LWpwJdoWl3N49IIWhSV+FV+vOdILDutzWF3LJn9FipCpZsqWaGHEw==
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
	=?UTF-8?q?Nicol=C3=B2=20Veronese?= <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>,
	mwojtas@chromium.org,
	Antoine Tenart <atenart@kernel.org>
Subject: [PATCH net-next RFC 1/5] net: ethtool: common: Make BaseT a 4-lanes mode
Date: Fri, 20 Dec 2024 21:15:00 +0100
Message-ID: <20241220201506.2791940-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
References: <20241220201506.2791940-1-maxime.chevallier@bootlin.com>
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
 net/ethtool/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 02f941f667dd..5a9c09ce57d5 100644
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
2.47.1


