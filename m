Return-Path: <netdev+bounces-95316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A39768C1DC7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 07:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36904B221F7
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 05:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3181168AE2;
	Fri, 10 May 2024 05:38:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40E815E5C9
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 05:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715319521; cv=none; b=h8umkH+XoyrQ//XoW1yluKNN6jlvONMTjOHtFyDIk3IOD8rEe8VuRubl+pmdWDXvYtQCSPAWf0nS2zVYEFQ+MHuQ81sV+9MF1MyMQzhoUR+81DFDiBjLhu/CN+80b260OOV0C9MpvVwqB00RuyPTGkonslaf/xQnZmRQIcAUiEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715319521; c=relaxed/simple;
	bh=GSpMQSri9vV2W/mPCjfVGmKY0KvOr6Roho9vskVmg4I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BKVpsAgdOMjjvxguboRsjmvQfCOMlOgDX2okyhyunDnICaFWyQeLOVYzhE95WV07xhbbmNqLO7aTuuiOAKOnKP9gs4QLHMusVDpJ1duZRUUO/jkP19faCS39QHQFcr7KYFlryPoAi4kLzvEd6oxqN5/dEDQMJFfObUezCPt6XHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1s5Ixk-0006RX-4d; Fri, 10 May 2024 07:38:32 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1s5Ixh-000a4C-D4; Fri, 10 May 2024 07:38:29 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1s5Ixh-00A7bx-15;
	Fri, 10 May 2024 07:38:29 +0200
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
Subject: [PATCH net-next v3 0/3] net: dsa: microchip: DCB fixes 
Date: Fri, 10 May 2024 07:38:25 +0200
Message-Id: <20240510053828.2412516-1-o.rempel@pengutronix.de>
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


