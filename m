Return-Path: <netdev+bounces-148463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED3E9E1C70
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 13:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8EEA284A25
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D8A1EBA04;
	Tue,  3 Dec 2024 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="AIvjtNo2"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7EA1EB9E3;
	Tue,  3 Dec 2024 12:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229811; cv=none; b=Ov2aXNmUdha599/lv/Mo/ep9swKB+1Bxpl00tg/wBHuvzcAFw1UGnqlMXbe2fh9LvQ4WSWi7sZJftzt2vZLDvA5+rJZ4cqgO2vdTEQUzN74dEKzxbfk1YWqFgj/VNen+7TgO46nhYAC61QVYDfHsmGn0G81UiVZK0Ou4s/p0vKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229811; c=relaxed/simple;
	bh=0seOP6w/OIGFoNMs8f5tPporlNfTBPv3+vPmcEPW914=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=erNo64fa8bru65gKyDeKqPJAhgpVh9VmguY1soEOW1nKrP0IElLaF6TgMgIMcrMYOsZbfFE/NCUcvElTHl0InS2cldnQbdOFoHrb+9/ldICMMWSCAL9+mjarYQ/ADT/g+R6uTrsmQvJt5LBhPnxcK2/GvchIAI9PvToFwns2Cro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=AIvjtNo2; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2787FE0004;
	Tue,  3 Dec 2024 12:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733229806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=W+I+80WOeNGElVcMFVionKAL8OOUIM1EboCBXK2lIoY=;
	b=AIvjtNo2jOC+jd9gWK7fjVM6bQPL7bWgHmfn54Gx0ewm6x5dsqLrAK08xmE99z1v26+u4c
	19SRqSQW4a9QcVK5geiqgO6TKPWkeR0xUKS9Yt5OmNpeaPKfyGVGfo29kQXHcvnkEmuVGi
	mm1COr1V0zI1XQ99MWVZfrwY6hwU1CDZCaKr/nGSgSHW5ghzMJePJLy7Mf/dqZKDdDjfS6
	o0Lj38zBIGDhnz9oJGoUcM+P8pg6q5piJoBl6EfDgVTIKkCm579xigWuJp4C+2QBf9V1i/
	vv4mp1BW5BhKCfEDqvYL/ewQL1sTmB64kt9H/sq4bnkOMes/TutoOG4sFlvh5w==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v3 00/10] net: freescale: ucc_geth: Phylink conversion
Date: Tue,  3 Dec 2024 13:43:11 +0100
Message-ID: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello everyone,

This is V3 of the phylink conversion for ucc_geth.

The main changes in this V3 are related to error handling in the patches
1 and 10 to report an error when the deprecated "interface" property is
found in DT. Doing so, I found and addressed some issues with the jump
labels in the error paths, impacting patches 1 and 10.

The rest of the changes are just a rebase on net-next.

Some of the V2 changes haven't been reviewed, so I stress out that I'm
still uncertain about the way WoL is handled is patches 4 and 10.

Thanks,

Maxime

Link to V1: https://lore.kernel.org/netdev/20241107170255.1058124-1-maxime.chevallier@bootlin.com/
Link to V2: https://lore.kernel.org/netdev/20241114153603.307872-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (10):
  net: freescale: ucc_geth: Drop support for the "interface" DT property
  net: freescale: ucc_geth: split adjust_link for phylink conversion
  net: freescale: ucc_geth: Use netdev->phydev to access the PHY
  net: freescale: ucc_geth: Fix WOL configuration
  net: freescale: ucc_geth: Use the correct type to store WoL opts
  net: freescale: ucc_geth: Simplify frame length check
  net: freescale: ucc_geth: Hardcode the preamble length to 7 bytes
  net: freescale: ucc_geth: Move the serdes configuration around
  net: freescale: ucc_geth: Introduce a helper to check Reduced modes
  net: freescale: ucc_geth: phylink conversion

 drivers/net/ethernet/freescale/Kconfig        |   3 +-
 drivers/net/ethernet/freescale/ucc_geth.c     | 602 +++++++-----------
 drivers/net/ethernet/freescale/ucc_geth.h     |  22 +-
 .../net/ethernet/freescale/ucc_geth_ethtool.c |  74 +--
 4 files changed, 266 insertions(+), 435 deletions(-)

-- 
2.47.0


