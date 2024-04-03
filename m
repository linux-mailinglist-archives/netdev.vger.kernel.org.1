Return-Path: <netdev+bounces-84457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD385896F60
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 14:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C0F3B22DCB
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 12:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854A81494AB;
	Wed,  3 Apr 2024 12:50:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74371419BA
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712148655; cv=none; b=kb9zBB2ZUMoUTYvIKSPQSlJc2XDs2plW/SL3bF2+Pj2X0NpaZkYG/742gS8ot4Z9jk3pcOzcQWL9lF2036ySdDgAQ1daKG8jmX/UCZcJFn81y3dqWkLpA3TsTTVr473X6AzvD5jR6b2FK/fdMlZ8mvV/XcYNcObyQ+hBNi8EBx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712148655; c=relaxed/simple;
	bh=3pOSvRWjNGrU7zGlmdspwG6HwoTcqniBT6UA174UJIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tBUarDEXyqIwGua87tfLSqbcFM8dipRXqpDpveHr4nwQbfdQzs5uH+K+xQEzIpizNvxuw79IXLvHGLeShwSAjNlI3JZsqFaImIXMz3xlgRKNB4z4tA1TBZO6ZnA7NkjjAKbsxKFZ1njCJlxrgx++WBtNPHdwNLD1+6VgDnEOgh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04h-0005uK-0Z; Wed, 03 Apr 2024 14:50:43 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04e-00ABEQ-PO; Wed, 03 Apr 2024 14:50:40 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rs04e-00EKV4-1n;
	Wed, 03 Apr 2024 14:50:40 +0200
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
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v2 0/8] net: dsa: microchip: ksz8: refactor FDB dump path 
Date: Wed,  3 Apr 2024 14:50:31 +0200
Message-Id: <20240403125039.3414824-1-o.rempel@pengutronix.de>
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

Refactor FDB dump code path for Microchip KSZ8xxx series. This series
mostly makes some cosmetic reworks and allows to forward errors detected
by the regmap.

Change logs are part of patch commit messages.

Oleksij Rempel (8):
  net: dsa: microchip: Remove unused FDB timestamp support in
    ksz8_r_dyn_mac_table()
  net: dsa: microchip: Make ksz8_r_dyn_mac_table() static
  net: dsa: microchip: ksz8: Refactor ksz8_fdb_dump()
  net: dsa: microchip: ksz8: Refactor ksz8_r_dyn_mac_table() for
    readability
  net: dsa: microchip: ksz8: Unify variable naming in
    ksz8_r_dyn_mac_table()
  net: dsa: microchip: ksz8_r_dyn_mac_table(): ksz: do not return EAGAIN
    on timeout
  net: dsa: microchip: ksz8_r_dyn_mac_table(): return read/write error
    if we got any
  net: dsa: microchip: ksz8_r_dyn_mac_table(): use entries variable to
    signal 0 entries

 drivers/net/dsa/microchip/ksz8.h        |   2 -
 drivers/net/dsa/microchip/ksz8795.c     | 135 ++++++++++++------------
 drivers/net/dsa/microchip/ksz8795_reg.h |   1 +
 3 files changed, 69 insertions(+), 69 deletions(-)

-- 
2.39.2


