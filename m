Return-Path: <netdev+bounces-94798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74ED8C0AF4
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 07:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 043E81C218EF
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 05:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF2171494B8;
	Thu,  9 May 2024 05:33:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624A51494AD
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 05:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715232823; cv=none; b=AQIGCPg1pchHw3+9JwqjkfM/5qII67RO1RUXsLPl8+AFOeWSmlo4pq0tTKujRTF8Sn2AjNZ+67JoMAdqpU2eRgkI5jWpYpfDHTTJAeL6z9PZkQfaCCbexPR9kK0gXNRqB8hSoNz0QZjjeh+B2zsgPef3EYxHcRN0VqprLHBJ5+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715232823; c=relaxed/simple;
	bh=GSpMQSri9vV2W/mPCjfVGmKY0KvOr6Roho9vskVmg4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z8k0YdZpNXAfoSv0k/SfC6k795iKvdtLFDyPY54j5MnfvtgoGUFzsETCObSXemhif7tzY4hUYfaQwmnJ6iJG33ssjwsJNRLHWR9MUvHfqF6A0+7L+XglNBT99PXZQMr81cf6HMbbQwQKpsn72M5hK7TH3QJhC0Y7qwR5NCyQV78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s4wPR-0006kK-82; Thu, 09 May 2024 07:33:37 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s4wPP-000P8y-SQ; Thu, 09 May 2024 07:33:35 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s4wPP-000XZ5-2c;
	Thu, 09 May 2024 07:33:35 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v2 0/3] net: dsa: microchip: DCB fixes 
Date: Thu,  9 May 2024 07:33:32 +0200
Message-Id: <20240509053335.129002-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

This patch series address recommendation to rename IPV to IPM to avoid
confusion with IPV name used in 802.1Qci PSFP. And restores default "PCP
only" configuration as source of priorities to avoid possible
regressions. 

change logs are in separate patches.

Oleksij Rempel (3):
  net: dsa: microchip: dcb: rename IPV to IPM
  net: dsa: microchip: dcb: add comments for DSCP related functions
  net: dsa: microchip: dcb: set default apptrust to PCP only

 drivers/net/dsa/microchip/ksz_common.c |  46 +++++------
 drivers/net/dsa/microchip/ksz_common.h |   2 +-
 drivers/net/dsa/microchip/ksz_dcb.c    | 106 ++++++++++++++-----------
 3 files changed, 85 insertions(+), 69 deletions(-)

-- 
2.39.2


