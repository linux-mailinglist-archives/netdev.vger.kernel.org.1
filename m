Return-Path: <netdev+bounces-125990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638E796F790
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:57:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 210C72868C7
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F6981D1F7B;
	Fri,  6 Sep 2024 14:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QUC4rWI3"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D144F1D174E;
	Fri,  6 Sep 2024 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725634654; cv=none; b=QLaivHAIhMFXaz2zfmkCBOW7RnenNswEPC5/B6q+MsPRaX7C08reYxa/Fe1OG6AjDGTSvfpmMGXqX/HCAxBDJz3svSrdTv/ZDG3N314i8n0AS5rzbbAPsZC09DteKcjVUVygQx0itBE/iiazOKcdVV9qxmxOBrfYn1er6nRxfsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725634654; c=relaxed/simple;
	bh=kTgAedHNs1oih+vvHh5KCniIKGXoiJKU+FPxE6rWh7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HoN25/I1hy960BKwF5o2OUy2o6pvL5q1UqURRH0fXD71fUSOxJro/2P1QOcKMXLwavejpU45eax20D/Qm+kTlpfykW8R0jNZ5jMMCm5kxQ2L+xYb4yfXuFkcsq4xQGiQs5F2nYfANmdmvUI1rLYlUpQ+m4yeCOxN629Ha2wvGlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QUC4rWI3; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E36B61C0006;
	Fri,  6 Sep 2024 14:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725634644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HqIaZxKsvttMCBe6f0QrqZ3K6B34eTYmXhXUU65DcoA=;
	b=QUC4rWI3zq4Rh5sy2VejxkT47UVm6PzEQxsXi3xF+JxfeJHWd5cprYpbz1GNiuGtZBUkmJ
	44xZy6zcYarcpTJzs8D9UsJlTB8WTA1an8sZkeaBeLF6Puhrm8d327Zn1vTXEnrfmhGOGr
	xT2TYeFrTsY+rXUUqf2aBlHUuto3XAIo17IjMw+489d/9+5Bh7HkrP7RGuAh7/jwfIGQRk
	Q5KBeD2vb0C5NWBX4qsH7f5fj8R34Cp2nqwmpF3OsjNV7DwTm/s6/lk03K/f8DCA+/Pj58
	JntqH6+aBhqxNWmfZSp6GWFCNjejx4KwjOthj5eVDvGOBJPxADKSXI8BcsK1mA==
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
Subject: [PATCH ethtool-next v4 0/3] Introduce PHY listing and targeting
Date: Fri,  6 Sep 2024 16:57:15 +0200
Message-ID: <20240906145719.387824-1-maxime.chevallier@bootlin.com>
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

The V4 addresses all of Michal's reviews this time, introducing better error
messages, documenting in the manpage the possible values for the 0 phy index,
and making sure ethtool can still build without libmnl.

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

Link to V3: https://lore.kernel.org/netdev/20240905102417.232890-1-maxime.chevallier@bootlin.com/
Link to V2: https://lore.kernel.org/netdev/20240828152511.194453-1-maxime.chevallier@bootlin.com/
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
 netlink/extapi.h             |   2 +
 netlink/msgbuff.c            |  52 ++++++++++++----
 netlink/msgbuff.h            |   3 +
 netlink/nlsock.c             |  38 ++++++++++++
 netlink/nlsock.h             |   2 +
 netlink/phy.c                | 116 +++++++++++++++++++++++++++++++++++
 netlink/plca.c               |   4 +-
 netlink/pse-pd.c             |   4 +-
 uapi/linux/ethtool.h         |  16 +++++
 uapi/linux/ethtool_netlink.h |  25 ++++++++
 15 files changed, 339 insertions(+), 19 deletions(-)
 create mode 100644 netlink/phy.c

-- 
2.46.0


