Return-Path: <netdev+bounces-170389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8797CA487BE
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 19:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEE0116C067
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382AD1F5842;
	Thu, 27 Feb 2025 18:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cguhkLkE"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20F1B424D;
	Thu, 27 Feb 2025 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740680702; cv=none; b=ZtEYoVWwcBLuauXD1wtV9eogV4Kde25rBQqX9nyn8PD3uJrIhFew4L0LSEBl5Ve2T4pOxO/mn1N7oODy3PiD2uMOmg3VVhQ166GkhjJLlXcsec/VF32ON8fDj4FtX1OZaNvznGfj1Ed1lhhff7KqFd/LMCRtX2FFHrVMmNw9TeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740680702; c=relaxed/simple;
	bh=Lvek3m5sSarVBt1mZvYo0h0/03pAyz6Vhrw0tSenfog=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oAruJIxoo7W6c8Fbvoof27WkOK74P4HcJ2CHklkB+MOWCmxd3W8mB6amH1oXZugLd2ZZSyrwCvV/qoTYTLZhbHvFW6nUtA915Br55V7oSjOhIJaW1ty3zqCJFCQHbySGzWazjMwJIiwMtbDvYr3zxhJLfNJbRwlsSML+ehJmSmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cguhkLkE; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2139C44264;
	Thu, 27 Feb 2025 18:24:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1740680697;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=mvmJs37OPUgPlZajW2Yxe5MxDWODiGxLsnHmAoScS7E=;
	b=cguhkLkEpqUFw+CYfIqWVqxKb8bqrtFmGcsGFUHkWFPZXroBBJ6BOEJTnmfx+rpusXkH08
	ExOB4W0ztXqw/YLSqBANb3g3BTu1PYZz1W3ilR/XyqLT6rmOmbsAD7KiAp07kxyZkzuxqG
	m8q9PX9kKYyB0k/CY0UXU1SgNZsNhm2yKhTc2glzCUqqkGrpa9dA5OP5f/MbWgKpz5FYw8
	URsPFrxrU8JleSQz73V08igUul72wBaz8c6ZmZDV6+wf+oncsAPPRQoNZznfmgWTRT5o9L
	cXs/yi397mPLOFcJbINaNJSfaBpSIrEfnWdwOg9KlCOriPCqy33kchVXpaJ/dw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: [PATCH net 0/2] net: ethtool: netlink: Fix notifications for
Date: Thu, 27 Feb 2025 19:24:50 +0100
Message-ID: <20250227182454.1998236-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdekkedujecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepofgrgihimhgvucevhhgvvhgrlhhlihgvrhcuoehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeehtdehueefuedtkeduleefvdefgfeiudevteevuefhgfffkeekheeuffeuhefhueenucfkphepvdgrtddumegtsgduleemkegugegtmeelfhdttdemsggtvddumeekkeelleemheegtdgtmegvheelvgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegtgemlehftddtmegstgdvudemkeekleelmeehgedttgemvgehlegvpdhhvghlohepfhgvughorhgrrdhhohhmvgdpmhgrihhlfhhrohhmpehmrgigihhmvgdrtghhvghvrghllhhivghrsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopedvuddprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegvughumhgriigvt
 hesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopehhkhgrlhhlfigvihhtudesghhmrghilhdrtghomhdprhgtphhtthhopehprghrthhhihgsrghnrdhvvggvrhgrshhoohhrrghnsehmihgtrhhotghhihhprdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomh
X-GND-Sasl: maxime.chevallier@bootlin.com

It has been found (thanks to Parthiban) that the PLCA ethtool commands
were failing since 6.12, due to the phy_link_topology work. This was
traced back to the ethnl notifications mechanism, in which calls to
ethnl_req_get_phydev() crashed in the notification path following a
->set request.

The typical callsite for ethnl_req_get_phydev() looks like :

    phydev = ethnl_req_get_phydev(req_base, tb[ETHTOOL_A_XXX_HEADER],
				  info->extack);

as 'tb' is NULL in the notification path for the ->prepare_data ethnl
ops, this causes crashes. The solution for that is to change the
prototype of ethnl_req_get_phydev() to perform checks inside the helper
(patch 1).

While investigating that, I realised that the notification path for PHYs
is not correct anyways. As we don't have a netlink request to parse, we
can't know for sure which PHY the notification event targets in the case
of a notification following a ->set request.

Patch 2 introduces a context structure that is used between ->set
requests and the followup notification, to keep track of the PHY that
the original request targeted for the notification.

Thanks Parthiban for the report (not on netdev@ though).

Maxime

Maxime Chevallier (2):
  net: ethtool: netlink: Allow NULL nlattrs when getting a phy_device
  net: ethtool: netlink: Pass a context for default ethnl notifications

 net/ethtool/cabletest.c |  8 ++++----
 net/ethtool/linkstate.c |  2 +-
 net/ethtool/netlink.c   | 21 +++++++++++++++++----
 net/ethtool/netlink.h   |  5 +++--
 net/ethtool/phy.c       |  2 +-
 net/ethtool/plca.c      |  6 +++---
 net/ethtool/pse-pd.c    |  4 ++--
 net/ethtool/stats.c     |  2 +-
 net/ethtool/strset.c    |  2 +-
 9 files changed, 33 insertions(+), 19 deletions(-)

-- 
2.48.1


