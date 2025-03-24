Return-Path: <netdev+bounces-177050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EE5A6D86C
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 11:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECD13A84D6
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 10:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F036A25DCF8;
	Mon, 24 Mar 2025 10:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N3k8NpCC"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E66425DCE0;
	Mon, 24 Mar 2025 10:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742812825; cv=none; b=hCPv8kGLrGAsHV41AYgZMt3hKuhcz34cIft+iJBwLOzhHOAeHYLAiFg3fXrKjEM3VUjAN/I3tzUiJEHuR2mTN+fBdyC8LZ+ptPL2dg8P7Ie/E/yhR9N7B/T78lSlgIxt6ePu2tJNtXH5Xn8Zi8WCrUDPsqMRAAfkjk6d+JQla4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742812825; c=relaxed/simple;
	bh=b/pAV4sv6SN8xVStCQxYfZPdG8p/Www/E1RDHmtoa1M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jzg5sgWLbJcVaAyiJ39/jep75qQ0diW9nekO+I6XaZb0PS11f11pzLmVOQ3fd7NBM6Vm02QKqooD6WwBLABo8cxUncEXTMkM9vo2WIZDZD6zkbuRE970YvWi1+tSwmvhoxb49hdq5tmGQ9lh5gPLg2nlna/1+12lGV1nqyW3020=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N3k8NpCC; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BA273442E9;
	Mon, 24 Mar 2025 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742812816;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=s6FNrudKISRIlY4MPIqsl0wZh+w9Rep6xe74cx2bQaA=;
	b=N3k8NpCCYvy54uKjQxxYIkffHYjtGmcYnfYzzSXPmySJM8Gz4DASxBqL7WVdgxcfWUwECJ
	Qi143hgbsDMmWE4Pmg0PK8vQbga3TNfhXl206Vpaex9jxobzc66tbmjjPtHXU8uPDJd0WN
	YN6fznn6DITXvbHxx6JRRC/A7WoTU0tkvkpvPpqzFUi2BFCYb7RaAOnIKC3El2u6hGvanA
	1ihV7ubzQjGi54kpnnqa4DBcOfpSf5ZnZ65o2A+voyVtmQun81GDLf/lIEM7KcqxaIPExQ
	+6+ZciZ9qQm6rUvu1uYczBWQpUwbjwrBmdPwOZAHGwpTa59Aoq7i7PI9pexe8g==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>
Subject: [PATCH net-next v4 0/8] net: ethtool: Introduce ethnl dump helpers
Date: Mon, 24 Mar 2025 11:40:02 +0100
Message-ID: <20250324104012.367366-1-maxime.chevallier@bootlin.com>
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
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheelheehucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeforgigihhmvgcuvehhvghvrghllhhivghruceomhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepjefhleeihefgffeiffdtffeivdehfeetheekudekgfetffetveffueeujeeitdevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegtsgduleemkegugeehmeegledttdemhedvrgefmeejsgeludemudehtgelmegtledtieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemtggsudelmeekugegheemgeeltddtmeehvdgrfeemjegsledumeduhegtleemtgeltdeipdhhvghlohepuggvvhhitggvqddvgedrhhhomhgvpdhmrghilhhfrhhomhepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepvddupdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehkuhgsrgeskhgvr
 hhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohephhhkrghllhifvghithdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrgihimhgvrdgthhgvvhgrlhhlihgvrhessghoohhtlhhinhdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: maxime.chevallier@bootlin.com

Hi everyone,

This is V4 for the ethnl dump support, allowing better handling of
per-phy dump but also any other dump operation that needs to dump more
than one message per netdev.

Changes in V4:
 - Don't grab rcu_read_lock when we already have a refcounter netdev on
   the filtered dump path (Paolo)
 - Move the dump_all stuff in a dedicated helper (Paolo)
 - Added patch 1 to set the dev in ctx->req_info

Changes in V3:
 - Fixed some typos and xmas tree issues
 - Added a missing check for EOPNOTSUPP in patch 1
 - Added missing kdoc
 - Added missing comments in phy_reply_size

Changes in V2:
 - Rebased on the netdev_lock work by Stanislav and the fixes from Eric
 - Fixed a bissectability issue
 - Fixed kdoc for the new ethnl ops and fields

V1: https://lore.kernel.org/netdev/20250305141938.319282-1-maxime.chevallier@bootlin.com/
V2: https://lore.kernel.org/netdev/20250308155440.267782-1-maxime.chevallier@bootlin.com/
V3: https://lore.kernel.org/netdev/20250313182647.250007-1-maxime.chevallier@bootlin.com/

As of today when using ethnl's default ops, the DUMP requests will
simply perform a GET for each netdev.

That hits limitations for commands that may return multiple messages for
a single netdev, such as :

 - RSS (listing contexts)
 - All PHY-specific commands (PLCA, PSE-PD, phy)
 - tsinfo (one item for the netdev +  one per phy)

 Commands that need a non-default DUMP support have to re-implement
 ->dumpit() themselves, which prevents using most of ethnl's internal
 circuitry.

This series therefore introduces a better support for dump operations in
ethnl.

The patches 1 and 2 introduce the support for filtered DUMPs, where an
ifindex/ifname can be passed in the request header for the DUMP
operation. This is for when we want to dump everything a netdev
supports, but without doing so for every single netdev. ethtool's
"--show-phys ethX" option for example performs a filtered dump.

Patch 3 introduces 3 new ethnl ops : 
 ->dump_start() to initialize a dump context
 ->dump_one_dev(), that can be implemented per-command to dump
 everything on a given netdev
 ->dump_done() to release the context

The default behaviour for dumps remains the same, calling the whole
->doit() path for each netdev.

Patch 4 introduces a set of ->dump_start(), ->dump_one_dev() and
->dump_done() callback implementations that can simply be plugged into
the existing commands that list objects per-phy, making the 
phy-targeting command behaviour more coherent.

Patch 5 uses that new set of helpers to rewrite the phy.c support, which
now uses the regulat ethnl_ops instead of fully custom genl ops. This
one is the hardest to review, sorry about that, I couldn't really manage
to incrementally rework that file :(

Patches 6 and 7 are where the new dump infra shines, adding per-netdev
per-phy dump support for PLCA and PSE-PD.

We could also consider converting tsinfo/tsconfig, rss and tunnels to
these new ->dump_***() operations as well, but that's out of this
series' scope.

Thanks,

Maxime



Maxime Chevallier (8):
  net: ethtool: Set the req_info->dev on DUMP requests for each dev
  net: ethtool: netlink: Allow per-netdevice DUMP operations
  net: ethtool: netlink: Rename ethnl_default_dump_one
  net: ethtool: netlink: Introduce command-specific dump_one_dev
  net: ethtool: netlink: Introduce per-phy DUMP helpers
  net: ethtool: phy: Convert the PHY_GET command to generic phy dump
  net: ethtool: plca: Use per-PHY DUMP operations
  net: ethtool: pse-pd: Use per-PHY DUMP operations

 net/ethtool/netlink.c | 185 ++++++++++++++++++-----
 net/ethtool/netlink.h |  47 +++++-
 net/ethtool/phy.c     | 344 ++++++++++++------------------------------
 net/ethtool/plca.c    |  12 ++
 net/ethtool/pse-pd.c  |   6 +
 5 files changed, 310 insertions(+), 284 deletions(-)

-- 
2.48.1


