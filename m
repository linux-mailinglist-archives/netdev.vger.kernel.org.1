Return-Path: <netdev+bounces-125491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F21396D5FB
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 12:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B259E1C2308D
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 10:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86216191F7E;
	Thu,  5 Sep 2024 10:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="mn75S0I9"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AC31957F8;
	Thu,  5 Sep 2024 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725531870; cv=none; b=PXSajmroCzNzTM2K6hyDElxeeVkJWUsbjUbzRsfC/k8fl3IITqhD6dGWTgBNf0fVebfIJ40mxXsHKHAlrnGIHLICX0YI6zSY6A336cf9XAMDb+kOPjC1KUjWQOkwVtauwfnTPlZMDv6bIZsas1kLswJia75JQ59WrxCZjEiqasc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725531870; c=relaxed/simple;
	bh=+7HJMbCCHBWzVmcyFpw16KvjPnxdoJCJMBujC/KHQZ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mubPTK1+umJ7SAITM6tVgF7ZP28uNlPqH8LPqAwoW1qvvThEqSj+FacVqt+/yH2pRwr6CFhYKLyJ4hh9+JAdeOQWQN6KId860CZByF/GDRa9sbwZ1oNUjmknvmSJWdK28maBSQscrmknpvSf9l1FzRRFFV1h6pSGTdvgqUWnRTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=mn75S0I9; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39A1CE000C;
	Thu,  5 Sep 2024 10:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725531861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bWDLX217P/riIOCADpLCGPbeQs8iYPQmQhitZ4FZcL0=;
	b=mn75S0I9db2lfQTY8pbBfrOzqRdfZopD3FScAf3T44G2j2jarSiJmPCWFYuRTWpcDsP26A
	t2q28TD7an2J1oH+LEvPEqOUpJnrVVxfUYTepS3xDgoHIz9FdN9cdLVanfXsaoGBlPMCIc
	A1eQD7Y+ZXO+znrbQlivPfi+riBzS2Lhj61ISytwgwkk+HZjHst3Bp1zPQOF1Jv6wmaE+M
	pjAw07mDxJMNv9PSD3EtlcBpJH4Qem3b8bwgkqGN99EtiRLhttRa5cjUItyuXOWs7/U13v
	uLK2M8fEa8PHdFrL4DoHecATcf7Wr5u6ODuFnDqULGmigSmcyOAW6+pvBO7fGw==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Michal Kubecek <mkubecek@suse.cz>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH ethtool-next v3 0/3] Introduce PHY listing and targeting
Date: Thu,  5 Sep 2024 12:24:13 +0200
Message-ID: <20240905102417.232890-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello,

This series adds the ethtool-side support to list PHYs associated to a
netdevice, as well as allowing to target PHYs for some commands :
 - PSE-PD commands
 - Cable testing commands
 - PLCA commands

The V3 addresses Michal's reviews, introducing better error messages,
and documenting in the manpage the possible values for the 0 phy index.

The PHY-targetting commands look like this:

ethtool --phy 1 --cable-test eth0

Note that the --phy parameter gets passed at the beginning of the
command-line. This allows getting a generic command-line parsing code,
easy to write, but at the expense of maybe being a bit counter intuitive.

Another option could be to add a "phy" parameter to all the supported
commands, let me know if you think this looks too bad.

Patch 1 deals with the ability to pass a PHY index to the relevant
commands.

Patch 2 implements the --show-phys command. This command uses a netlink
DUMP request to list the PHYs, and introduces the ability to perform
filtered DUMP request, where the netdev index gets passed in the DUMP
request header.

Thanks,

Maxime

[1]: https://lore.kernel.org/netdev/20240821151009.1681151-1-maxime.chevallier@bootlin.com/

Link to V2:
Link to V1: https://lore.kernel.org/netdev/20240103142950.235888-1-maxime.chevallier@bootlin.com/

Maxime Chevallier (3):
  update UAPI header copies
  ethtool: Allow passing a PHY index for phy-targetting commands
  ethtool: Introduce a command to list PHYs

 Makefile.am                  |   1 +
 ethtool.8.in                 |  57 +++++++++++++++++
 ethtool.c                    |  33 +++++++++-
 internal.h                   |   1 +
 netlink/cable_test.c         |   4 +-
 netlink/extapi.h             |   1 +
 netlink/msgbuff.c            |  52 ++++++++++++----
 netlink/msgbuff.h            |   3 +
 netlink/nlsock.c             |  38 ++++++++++++
 netlink/nlsock.h             |   2 +
 netlink/phy.c                | 116 +++++++++++++++++++++++++++++++++++
 netlink/plca.c               |   4 +-
 netlink/pse-pd.c             |   4 +-
 uapi/linux/ethtool.h         |  16 +++++
 uapi/linux/ethtool_netlink.h |  25 ++++++++
 15 files changed, 338 insertions(+), 19 deletions(-)
 create mode 100644 netlink/phy.c

-- 
2.46.0


