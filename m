Return-Path: <netdev+bounces-84348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FBF896A88
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 11:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1F981C24E99
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3FB134CDC;
	Wed,  3 Apr 2024 09:29:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B0C134400
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136557; cv=none; b=W2L+6JGrKZYEAKGokncJRZCEzs8nKJ6PPvhqrjfTG4nHmu+8kiLFiKiqmLirnNp7Ch5GrR282vuJaU9cVtkhjRlakFdLqPuFNnfjZFKw4etrXNIbK5nqiolRGiz5vv5rQT6Dpxl7H2yCNlqKjrcNRCORESTgMpaKl2PhQWChwdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136557; c=relaxed/simple;
	bh=5dxcCc86+SrpxEM8DzCZ3xB36nURKqO1p/wf4H48/JQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tPQ+BfJWzvNUh6cIh6mPhRKXy0Dv+9tsyX7pzaV1KsoX9byRMBLUTVCIkXXG/o8DludFY5N7sjk0s73cNq6ez4Usg7CMZ1ksY6Qae6PFmgTkyXou5RAQl5EMHq9f/oeqA3gX/k8HcS0cgAVO5ZyC7naXYrvsk5WyzDlwI81UrUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rrwvc-0005BE-Nl; Wed, 03 Apr 2024 11:29:08 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rrwva-00A9Hj-6X; Wed, 03 Apr 2024 11:29:06 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rrwva-008qGt-0P;
	Wed, 03 Apr 2024 11:29:06 +0200
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
Subject: [PATCH net-next v2 0/9] Enhanced DCB and DSCP Support for KSZ Switches
Date: Wed,  3 Apr 2024 11:28:56 +0200
Message-Id: <20240403092905.2107522-1-o.rempel@pengutronix.de>
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

This patch series is aimed at improving support for DCB (Data Center
Bridging) and DSCP (Differentiated Services Code Point) on KSZ switches.

The main goal is to introduce global DSCP and PCP (Priority Code Point)
mapping support, addressing the limitation of KSZ switches not having
per-port DSCP priority mapping. This involves extending the DSA
framework with new callbacks for managing trust settings for global DSCP
and PCP maps. Additionally, we introduce IEEE 802.1q helpers for default
configurations, benefiting other drivers too.

Change logs are in separate patches.

Oleksij Rempel (9):
  net: dsa: add support for DCB get/set apptrust configuration
  net: dsa: microchip: add IPV information support
  net: add IEEE 802.1q specific helpers
  net: dsa: microchip: add multi queue support for KSZ88X3 variants
  net: dsa: microchip: add support for different DCB app configurations
  net: dsa: microchip: dcb: add special handling for KSZ88X3 family
  net: dsa: microchip: enable ETS support for KSZ989X variants
  net: dsa: microchip: init predictable IPV to queue mapping for all non
    KSZ8xxx variants
  net: dsa: microchip: let DCB code do PCP and DSCP policy configuration

 drivers/net/dsa/microchip/Kconfig       |   2 +
 drivers/net/dsa/microchip/Makefile      |   2 +-
 drivers/net/dsa/microchip/ksz8.h        |   1 +
 drivers/net/dsa/microchip/ksz8795.c     | 106 ++--
 drivers/net/dsa/microchip/ksz8795_reg.h |   9 +-
 drivers/net/dsa/microchip/ksz9477.c     |   6 -
 drivers/net/dsa/microchip/ksz_common.c  |  98 +++-
 drivers/net/dsa/microchip/ksz_common.h  |   7 +-
 drivers/net/dsa/microchip/ksz_dcb.c     | 727 ++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_dcb.h     |  21 +
 include/net/dsa.h                       |   4 +
 include/net/dscp.h                      |  76 +++
 include/net/ieee8021q.h                 |  49 ++
 net/Kconfig                             |   4 +
 net/core/Makefile                       |   1 +
 net/core/ieee8021q_helpers.c            | 167 ++++++
 net/dsa/user.c                          |  28 +
 17 files changed, 1234 insertions(+), 74 deletions(-)
 create mode 100644 drivers/net/dsa/microchip/ksz_dcb.c
 create mode 100644 drivers/net/dsa/microchip/ksz_dcb.h
 create mode 100644 include/net/dscp.h
 create mode 100644 include/net/ieee8021q.h
 create mode 100644 net/core/ieee8021q_helpers.c

-- 
2.39.2


