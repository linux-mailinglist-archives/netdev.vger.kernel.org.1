Return-Path: <netdev+bounces-94496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27C08BFB21
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 12:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 893331C21232
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 10:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F0A824AC;
	Wed,  8 May 2024 10:39:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C788B81727
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 10:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715164755; cv=none; b=o0hmQV9hquycnXffpQmk+gq6xtNdKf5SwcKWjpAsZhI2prxA9ft2G/nORJUc/hAA3CsW+opb4RacLOy+sEOWilXZtdyeuzTe+OWcdPSiEoMkPL5UEfv2f89WRc5Sj9I5Vltil+OHX/KNyvgbsQl2FtXUfXWWcL52QLkE+VI5ryU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715164755; c=relaxed/simple;
	bh=shiwGSUaYs6M/v6Nfu5vlAB62BF0UdPHl54Nvv1gzsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d+N4i8Wm85gUWkyYrM+IVWqp8atCY1M/As3tcQfVzG3NyoUM4HwdDzJpfdQjjWnc9oIU0bClavgC92MfjYWifxxXzIanc1z5/8ZCNHAO2c+eI7nGmWlMHq51feT5GtU4Mow4LKXwupQjlE5Yh74zCM2ZsorigApndYry7MrbcUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s4ehV-0004BH-8n; Wed, 08 May 2024 12:39:05 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s4ehT-000G0F-GF; Wed, 08 May 2024 12:39:03 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s4ehT-00HLTP-1M;
	Wed, 08 May 2024 12:39:03 +0200
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
Subject: [PATCH net-next v1 0/3] net: dsa: microchip: DCB fixes 
Date: Wed,  8 May 2024 12:38:59 +0200
Message-Id: <20240508103902.4134098-1-o.rempel@pengutronix.de>
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

Oleksij Rempel (3):
  net: dsa: microchip: dcb: add comments for DSCP related functions
  net: dsa: microchip: dcb: rename IPV to IPM
  net: dsa: microchip: dcb: set default apptrust to PCP only

 drivers/net/dsa/microchip/ksz_common.c |  46 +++++------
 drivers/net/dsa/microchip/ksz_common.h |   2 +-
 drivers/net/dsa/microchip/ksz_dcb.c    | 106 ++++++++++++++-----------
 3 files changed, 85 insertions(+), 69 deletions(-)

-- 
2.39.2


