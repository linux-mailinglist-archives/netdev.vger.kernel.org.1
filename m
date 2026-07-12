Return-Path: <netdev+bounces-306980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LQ+fOKD2U2q5gQMAu9opvQ
	(envelope-from <netdev+bounces-306980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 22:18:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF55745CEA
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 22:18:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b="s/0zVLp0";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306980-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306980-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E4961300951E
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 20:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C29135B62F;
	Sun, 12 Jul 2026 20:18:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D0417C203
	for <netdev@vger.kernel.org>; Sun, 12 Jul 2026 20:18:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783887518; cv=none; b=KQ7TEuo/rJ5ww1ZBPymWTftoGfifXKIBR/hjjsXAG97RfDgNnLB6RQKw1lYQlYY1DFfSJIW0tD9ndbkoiU7VUXXVcy5z+an6Hw5uXHT9jLqdzrVpW4yKf/kMBga6lHy0EvGTKIb0gWZ3M5sLzqB2cK+EgIAlJaODMkDFZMGh6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783887518; c=relaxed/simple;
	bh=1gtzRhwUvVWuacdWiiucyl8zev/El3ZIMBUiSa7eCwo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g5aX9b8wM+NloTd6qZp+S/FSX3XTMKH2N/jWK4gsAxNAuElpQ+UnH1CkZBMLQQudOWPCYpjniU3fXx4QYrC5VBzO22EXBvmsoep8wmyqMyrfWVRtI3p+lxr9dQMZOSBfgqt27GnvFdc9xvAUWXt+sW7wZIPZLqurG0dW2M2CGn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=s/0zVLp0; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 185AFC2C672;
	Sun, 12 Jul 2026 20:18:48 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2A75C60341;
	Sun, 12 Jul 2026 20:18:32 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B77F011BD39DD;
	Sun, 12 Jul 2026 22:18:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783887511; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=1IpWZTScXvL80Z1R0rf5wBdpA1A0kDEuXz6CX3hd7nc=;
	b=s/0zVLp0JW6mXhwW0XMk/kB7wzRqV1iaKVZQ71O/pAKw4eCMEwhDe50WxY5+tAiwHMoC4i
	gruSVrcDzbgdy6tW/gSsZf9zt6asbHHaFjNYZ1aA++JAEthM239wJnr8+R5UHK1StyORZB
	KoDHq52Uqh2zvDKbhZdcq1aDbCf1d9Mdoqqx6YmJAx9l8Zzzplq1CNcJicexUqd2mZIsEO
	/wC+OHfDKgqsIuJYI1dtKlb1EhypUk1DvgEhFs4eSoRBR08CesKQgzTb6oYq214QR7X1Kr
	d/rPTmvhePVAai8S1OVxydX2D9STSo70GmTJR8eykcRRl37nUfNm5FdVl4IkDQ==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com
Subject: [PATCH net-next] net: mdio: Kconfig: Group mdio controller drivers in a submenu
Date: Sun, 12 Jul 2026 22:17:27 +0200
Message-ID: <20260712201739.260742-1-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306980-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,bootlin.com:from_mime,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2FF55745CEA

Currently in menuconfig, all individual drivers for MDIO bus controllers
are directly listed under Device drivers -> Network device support.

Let's group them altogether in a submenu, while keeping the dependency
on PHYLIB.

All options under the new submenu match the drivers and infrastructure
listed under drivers/net/mdio/Kconfig.

No intended functional change besides the menuconfig ordering.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/mdio/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index e57121019153..b85c9fff9345 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -3,7 +3,8 @@
 # MDIO Layer Configuration
 #
 
-if PHYLIB
+menu "MDIO controller drivers"
+	depends on PHYLIB
 
 config FWNODE_MDIO
 	def_tristate (ACPI || OF) || COMPILE_TEST
@@ -289,4 +290,4 @@ config MDIO_BUS_MUX_MMIOREG
 	  Currently, only 8/16/32 bits registers are supported.
 
 
-endif
+endmenu
-- 
2.55.0


