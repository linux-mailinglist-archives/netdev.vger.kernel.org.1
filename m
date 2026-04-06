Return-Path: <netdev+bounces-275530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEk6IY1d02nihgcAu9opvQ
	(envelope-from <netdev+bounces-275530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 09:15:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BEF3A1F24
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 09:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D993D300EFA4
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 07:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC61361DA5;
	Mon,  6 Apr 2026 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="Qc/1q+Ft"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A6A18AE2;
	Mon,  6 Apr 2026 07:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775459712; cv=none; b=r4ZzraKky/aFwEZmC3azYittMcvHqgEHlIyiAfwjPoltrDH530FDtGEDoyeDJgjTClGaTC2DMnOt5b05kg8+v8E7t5ogYAMCHySgkbZ5qI0UmlzJ7DfB/7doQVNtohBb3Y9vMyKcpWM++tv80H1BlKt5PhSaMLq2/e9Cq8Rv7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775459712; c=relaxed/simple;
	bh=ezMz/dhC28UkpE5JbBKeowc64fgw+jiag70Hh6+8DEI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HH4lUpicPnRw2J0dt44QpA1XM09JV84aKScj0sQP1Zt9sDCBHFcR07we/80dvs6lo5TxePcPUkSKPEtnHELgcSSrHUlwC0TLNA09arXERglK5xNpXHazAC+UNuMxWFdTQUxs1Qs+b2wTwt0v5QyYn00kCmhPA6f4fTuFQoFHaew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=Qc/1q+Ft; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC0B9A588B;
	Mon,  6 Apr 2026 09:14:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775459700; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=nRBOU1Az/d59wWkjo01psCMyPJXWn0hh6v5YDMNmjAo=;
	b=Qc/1q+FtWZXteB7D4JsH5HZheIjCk7n5EZ+Ps0SbXZjioFvTJ2A0WuPppBV8bO/x7si9t6
	MMX0iUOd0FbfcXaCRy/Lz0mwe0dHJt7yec6V07EDL2k2QWuRQg2RVSDSL1xQ5oPVegnRs6
	VCvsLGdDy9xiJXKP0IA2L5Mxc/mIb53rp3VaSmKhvJDq21yicxxhSLMGogDVK0ZajZvhDM
	n4IyHFGxDz9ybpB6S1Y7OVVpcbaBoJHKC1kx9xA5EKq6FzDzxGdOsXttU6whdky7HqZfL4
	iW675cFOXa4RBFUAM86xMdt9z0k2T8qBCpPKxTFUfD8sJB+SFvE3heikYqTXCQ==
From: Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net-next 0/3] net: phy: add support for disabling
 autonomous EEE
Date: Mon, 06 Apr 2026 09:13:06 +0200
Message-Id: <20260406-devel-autonomous-eee-v1-0-b335e7143711@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAJd02kC/x3MQQqDMBBG4avIrDuQDkXQq0gXsfnTDuikJFEE8
 e4NXX6L904qyIpCY3dSxq5FkzXcbx29Pt7eYA3NJE5693A9B+xY2G81WVrTVhgAhxi9DIJhnoV
 a+s2Ievy3ExkqG45Kz+v6AcCfA9pwAAAA
X-Change-ID: 20260406-devel-autonomous-eee-dffa292e9bb2
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,broadcom.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275530-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DMARC_DNSFAIL(0.00)[tipi-net.de : query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tipi-net.de:dkim,tipi-net.de:email,tipi-net.de:mid]
X-Rspamd-Queue-Id: E4BEF3A1F24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some PHYs implement autonomous EEE where the PHY manages EEE
independently, preventing the MAC from controlling LPI signaling.
This conflicts with MACs that implement their own LPI control.

This series adds a .disable_autonomous_eee callback to struct phy_driver
and calls it from phy_support_eee(). When a MAC indicates it supports
EEE, the PHY's autonomous EEE is automatically disabled. The setting is
persisted across suspend/resume by re-applying it in phy_init_hw() after
soft reset, following the same pattern suggested by Russell King for PHY
tunables [1].

Patch 1 adds the phylib infrastructure.
Patch 2 implements it for Broadcom BCM54xx (AutogrEEEn).
Patch 3 converts the Realtek RTL8211F, which previously unconditionally
  disabled PHY-mode EEE in config_init.

This came up while adding EEE support to the Cadence macb driver (used
on Raspberry Pi 5 with a BCM54210PE PHY). The PHY's AutogrEEEn mode
prevented the MAC from tracking LPI state. The Realtek RTL8211F has
the same pattern, unconditionally disabling PHY-mode EEE with the
comment "Disable PHY-mode EEE so LPI is passed to the MAC".

Other BCM54xx PHYs likely have the same AutogrEEEn register layout,
but I only have access to the BCM54210PE/BCM54213PE datasheets. It
would be appreciated if Florian or others could confirm which other
BCM54xx variants share this register so we can wire them up too.

Tested on Raspberry Pi CM4 (bcmgenet + BCM54210PE),
Raspberry Pi CM5 (Cadence GEM + BCM54210PE) and
Raspberry Pi 5 (Cadence GEM + BCM54213PE).

[1] https://lore.kernel.org/netdev/acuwvoydmJusuj9x@shell.armlinux.org.uk/

Previous versions:
  RFC: https://lore.kernel.org/netdev/20260403090656.733985-1-nb@tipi-net.de/
  Discussion: https://lore.kernel.org/netdev/d86c53213a6328b701b8aabbde5d1c83@tipi-net.de/

Changes since RFC:
  - Simplify kdoc and commit messages, remove references to specific
    callers (Andrew Lunn)

---
Nicolai Buchwitz (3):
      net: phy: add support for disabling PHY-autonomous EEE
      net: phy: broadcom: implement .disable_autonomous_eee for BCM54xx
      net: phy: realtek: convert RTL8211F to .disable_autonomous_eee

 drivers/net/phy/broadcom.c             |  7 +++++++
 drivers/net/phy/phy_device.c           | 22 ++++++++++++++++++++++
 drivers/net/phy/realtek/realtek_main.c |  7 ++++---
 include/linux/brcmphy.h                |  3 +++
 include/linux/phy.h                    | 14 ++++++++++++++
 5 files changed, 50 insertions(+), 3 deletions(-)
---
base-commit: 3741f8fa004bf598cd5032b0ff240984332d6f05
change-id: 20260406-devel-autonomous-eee-dffa292e9bb2

Best regards,
-- 
Nicolai Buchwitz <nb@tipi-net.de>


