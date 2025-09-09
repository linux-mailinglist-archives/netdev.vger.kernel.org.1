Return-Path: <netdev+bounces-221085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C88B4A364
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 09:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 716631B24C1D
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 07:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DF62FF64E;
	Tue,  9 Sep 2025 07:22:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8C81F30A4
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757402570; cv=none; b=CbJDuSEIqLQv/SaAWenMAaf+a0/jatlDlALWlQoWLnNecabkojZd1pFSBIscMbxfPgPUH4vf4BYIZrCzXc40kIw/P9gwBaxrEo81VsdJyiRHTnpTS9yKF+FDNYumiSXdYgBNrkf37rD8XEev3O65pOBrmqtyWlfARjAmxB0zwbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757402570; c=relaxed/simple;
	bh=8dqVeC+0KU/iCrJiDx0y6p8to4eCO2CEoshNzvpNOkE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ldt9A0313YalZt1Z6i+HjNXXBaSShnh0AnjCiLj2L3c9MCAXby5FxzW0E1qhPyZM+n7jRugFqcCW0XjZRcLQGecbERCZdspmVFnm7La8vJ+3HvvA7CUMZ+iWwd+8ipjXiNHQADgv/rzLsdCrhsSoPDkldhTfsjdcmX/dQ33EsJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsgF-0004go-KN; Tue, 09 Sep 2025 09:22:19 +0200
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsg9-000NlP-34;
	Tue, 09 Sep 2025 09:22:13 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1uvsg9-0000000FZFO-3WmC;
	Tue, 09 Sep 2025 09:22:13 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Lukasz Majewski <lukma@denx.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Divya.Koppera@microchip.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v4 0/3] Documentation and ynl: add flow control
Date: Tue,  9 Sep 2025 09:22:09 +0200
Message-ID: <20250909072212.3710365-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
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

This series improves kernel documentation around Ethernet flow control
and enhances the ynl tooling to generate kernel-doc comments for
attribute enums.

Patch 1 extends the ynl generator to emit kdoc for enums based on YAML
attribute documentation.
Patch 2 regenerates all affected UAPI headers (dpll, ethtool, team,
net_shaper, netdev, ovpn) so that attribute enums now carry kernel-doc.
Patch 3 adds a new flow_control.rst document and annotates the ethtool
pause/pause-stat YAML definitions, relying on the kdoc generation
support from the earlier patches.


Oleksij Rempel (3):
  tools: ynl-gen: generate kdoc for attribute enums
  net: ynl: add generated kdoc to UAPI headers
  Documentation: net: add flow control guide and document ethtool API

 Documentation/netlink/specs/ethtool.yaml      |  27 ++
 Documentation/networking/flow_control.rst     | 373 ++++++++++++++++++
 Documentation/networking/index.rst            |   1 +
 Documentation/networking/phy.rst              |  12 +-
 include/linux/ethtool.h                       |  45 ++-
 include/uapi/linux/dpll.h                     |  30 ++
 .../uapi/linux/ethtool_netlink_generated.h    |  57 ++-
 include/uapi/linux/if_team.h                  |  11 +
 include/uapi/linux/net_shaper.h               |  50 +++
 include/uapi/linux/netdev.h                   | 165 ++++++++
 include/uapi/linux/ovpn.h                     |  62 +++
 net/dcb/dcbnl.c                               |   2 +
 net/ethtool/pause.c                           |   4 +
 tools/include/uapi/linux/netdev.h             | 165 ++++++++
 tools/net/ynl/pyynl/ynl_gen_c.py              |  23 ++
 15 files changed, 1012 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/networking/flow_control.rst

--
2.47.3


