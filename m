Return-Path: <netdev+bounces-303045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VJzpDOuKQ2qAawoAu9opvQ
	(envelope-from <netdev+bounces-303045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:22:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 294176E2172
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 11:22:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=szelinsky.de header.s=mail header.b=SlFE1YsX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303045-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303045-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=szelinsky.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C549F300E312
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 09:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250613E9C26;
	Tue, 30 Jun 2026 09:11:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szelinsky.de (szelinsky.de [85.214.127.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F3A3403F7;
	Tue, 30 Jun 2026 09:11:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782810706; cv=none; b=A4FmvpkfQKgssYLR7E9xXFZR3udSganybs2TmaEadHQs2TpFyjY9mK85weAaTMbxBFiIcxZtRJBiw6FWcAOu/7415kdzOISx2GMYUzNSzGuPvpPqol8Zdlx1063BBM6H14hOhNm+JNyr5UlvUXg4zZ+QCEPTqNrdPJ+FF3FC8P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782810706; c=relaxed/simple;
	bh=m2I3ui9jl+h7T+ME2SuFRMWmxKXznnAzoSXKovEI4mI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mq8LGOiw/zUoIJth+b5GPY3qVXYSiEbEGh3+nSoBsmPmebRPcFgcNYTNBJzXHG+k8mvy7eHyRFWnKLFXBAvZuReJpbZ7Ohwx/EHP+ZGpdIKtJWmzru/vFTpVcgxrJxfI51rIZT+c9Ci+qmNfpqY7PJCXR77wO+oOPmNN8wENK7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szelinsky.de; spf=pass smtp.mailfrom=szelinsky.de; dkim=temperror (0-bit key) header.d=szelinsky.de header.i=@szelinsky.de header.b=SlFE1YsX; arc=none smtp.client-ip=85.214.127.56
Received: from localhost (localhost [127.0.0.1])
	by szelinsky.de (Postfix) with ESMTP id 392A2E838DD;
	Tue, 30 Jun 2026 11:11:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=szelinsky.de;
	s=mail; t=1782810696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YYj3pWWnYbewokT99bSe2eqc2JhkrYcI7d3TPbYWIAE=;
	b=SlFE1YsXgntIBJu8j106o2Zig9FL1ns67KXHoSqX20fNqYdtAtpBzmE0f64mLEIaf5pwrp
	Zp3Sj9tF4lNuZQPg1Em/JZjWVLVcQoMgl8yUtwyo+DwrFRxtKCFcMVI1LGYWkwYZ0moSW/
	HazeBHddJdYIPGsUW7Xjz/vhD7KJh6LWVlylshBIdJ3xvjD914b5jWbQKGcrG/fw4WFDOl
	93KKY1QAXSzeY/bFZDc5GkAb4FaFFDeGES3G+IBNWG1UNtQNl0tqxHw9jU+TQklNHT/8MG
	T35IMfAE8fgKZokmlFwsl0XEDpXh6kftgJsIw4XRZbUEHHMp/MVH52A1P/ZBAw==
X-Virus-Scanned: Debian amavis at szelinsky.de
Received: from szelinsky.de ([127.0.0.1])
 by localhost (szelinsky.de [127.0.0.1]) (amavis, port 10025) with ESMTP
 id QaUZ56U31s8T; Tue, 30 Jun 2026 11:11:36 +0200 (CEST)
Received: from p14sgen5.. (unknown [91.25.97.186])
	by szelinsky.de (Postfix) with ESMTPSA;
	Tue, 30 Jun 2026 11:11:35 +0200 (CEST)
From: Carlo Szelinsky <github@szelinsky.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Corey Leavitt <corey@leavitt.info>,
	Jonas Jelonek <jelonek.jonas@gmail.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Carlo Szelinsky <github@szelinsky.de>
Subject: [PATCH net-next v4 0/3] net: pse-pd: decouple controller lookup from MDIO probe
Date: Tue, 30 Jun 2026 11:11:22 +0200
Message-ID: <20260630091125.3162481-1-github@szelinsky.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[szelinsky.de,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[szelinsky.de:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303045-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:corey@leavitt.info,m:jelonek.jonas@gmail.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:github@szelinsky.de,m:andrew@lunn.ch,m:jelonekjonas@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[pengutronix.de,bootlin.com,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[leavitt.info,gmail.com,kernel.org,vger.kernel.org,szelinsky.de];
	DKIM_TRACE(0.00)[szelinsky.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[github@szelinsky.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,szelinsky.de:dkim,szelinsky.de:email,szelinsky.de:mid,szelinsky.de:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 294176E2172

This is v4 of Corey's series [1]. It takes the PSE controller lookup out
of the MDIO probe path, so a modular PSE driver no longer makes the
PHY/DSA probe spin on -EPROBE_DEFER until the PSE module loads.

The old patch 1 (a regulator handle fix) went to net on its own [2], so
this series is just the three notifier patches for net-next.

v3 [4] was posted during the merge window and deferred; net-next has
reopened, so here it is again, now with Jonas's Tested-by.

How it works: pse_core gets a notifier chain (REGISTERED / UNREGISTERED).
The phy layer subscribes, owns phydev->psec, and attaches the PSE handle
when the controller shows up instead of during probe. fwnode_mdio loses
its PSE awareness, so no -EPROBE_DEFER leaves it and the probe-retry loop
is gone.

Tested on a Realtek rtl93xx PoE switch with two HS104 PSE controllers on
i2c:

 - clean boot, no probe-retry loop, no watchdog reset
 - 10G SFP+ port: module hotplug works, no deadlock
 - ethtool --set-pse enable/disable cuts and restores power to a PD
 - i2c unbind -> rmmod -> modprobe: PSE detaches on unbind and re-attaches
   on reload with power restored, no reboot. No lockdep splats.

Jonas confirmed the RTL8214FC deadlock he reported is gone.

Tested-by: Carlo Szelinsky <github@szelinsky.de>

Changes in v4:
 - Add Tested-by from Jonas Jelonek. No code changes.
 - Repost now that net-next has reopened (v3 was deferred during the
   merge window).

Changes in v3:
 - Drop patch 1 (regulator handle fix); it goes to net separately [2].
 - Rebase on net-next. No code changes to the three patches.

v1 was an RFC by Corey [3].

[1] https://lore.kernel.org/netdev/20260620112440.1734404-1-github@szelinsky.de/
[2] https://lore.kernel.org/netdev/20260624204017.2752934-1-github@szelinsky.de/
[3] https://lore.kernel.org/netdev/20260423-pse-notifier-decouple-v1-0-86ed750a9d62@leavitt.info/
[4] https://lore.kernel.org/netdev/20260626165929.2908782-1-github@szelinsky.de/

Corey Leavitt (3):
  net: pse-pd: add notifier chain for controller lifecycle events
  net: pse-pd: fire lifecycle events on controller register/unregister
  net: phy: own phydev->psec via PSE notifier and remove fwnode_mdio
    hook

 drivers/net/mdio/fwnode_mdio.c |  34 -------
 drivers/net/phy/phy_device.c   | 168 +++++++++++++++++++++++++++++++--
 drivers/net/phy/sfp.c          |   2 +-
 drivers/net/pse-pd/pse_core.c  |  54 +++++++++++
 include/linux/phy.h            |   2 +
 include/linux/pse-pd/pse.h     |  41 ++++++++
 6 files changed, 258 insertions(+), 43 deletions(-)


base-commit: cef9d6804030793cf8b8796fd6936197d065dd3e
-- 
2.43.0


