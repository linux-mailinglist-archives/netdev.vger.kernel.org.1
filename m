Return-Path: <netdev+bounces-307701-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Bx0XDnNDV2o2IQEAu9opvQ
	(envelope-from <netdev+bounces-307701-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:23:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC1775BD3C
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 10:23:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=NvM3t5gr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307701-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-307701-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FF2D301AEE9
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 08:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2EB3CD8BF;
	Wed, 15 Jul 2026 08:22:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0343644A4
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 08:22:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784103761; cv=none; b=hWRL7u4pddp2Y0lJMsQxLNcwXQ6tmjeuBvBkl/jbqTnlE+nw177Xy5NeIYMCd0cFmAZ49eKVrkOy+f+QN0G83iuMfqvAP8nc1NNu+vB1wHiQk/LdO59LvajzTxUaESbtezmLFzhVn19suyDZBWUDRtB2f2tRf+5UGmAgp4h0QI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784103761; c=relaxed/simple;
	bh=9YK74OMuQiXNj33zdk7QfZsvxeMUHOPJx7WC/OWjphg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bkv/TIleONBufrub+0pfcxvsm4hlH9h3xUSD8HZn0Cx3lZnqdr9ocs0hyYXRfS7pLliyfUWwln83B6dAvQan9FnHXFUgCSo/j0ALQTUg+kyg32GFRIpvzSCt/tE9j/GOBuYeWsRQ9kd0Y+/cWIF+ohC+TpfH/N4qxnu5uCDl4uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NvM3t5gr; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1DBB04E40DC8;
	Wed, 15 Jul 2026 08:22:37 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E6CA66035C;
	Wed, 15 Jul 2026 08:22:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA34B11BD3B92;
	Wed, 15 Jul 2026 10:22:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784103756; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=aKJHnvHKwGCjOMlr7Xx+YG00VQLcEkHWleH86LDTmu0=;
	b=NvM3t5griK3ozXCxJdU42MGYXwMereDOPvBMg1h+KUkZ2vjhG4di137sONpw/6OlaB5yt6
	GI50w3nmSuuPdzkO6p+A0aWm1FrzgqBfdj/LHl/Zx4aRp+8IVEuHYxYkSpDEQf9Nu9ww9d
	REZGJX9FIV/MXG1fPv0VnNgMTm1+j2Ty27fmT8qMO6hF/8a7xXaKX6y7qAsUvVN1wo73dF
	HpjrdGur6cD+9uP1ldeO7XcvcmZbRMx2EMNu3jZlITKSzNjhs6c5SojzHnM6xZBGJOk4b9
	9asgIdkGmna539iyGZ3QZQ6jh9viyzEtYjj/Ei18Dzu4iv6/8V22hbdURYtfjw==
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
Subject: [PATCH net-next v2 1/2] net: mdio: Kconfig: Group mdio controller drivers in a submenu
Date: Wed, 15 Jul 2026 10:22:24 +0200
Message-ID: <20260715082226.51481-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260715082226.51481-1-maxime.chevallier@bootlin.com>
References: <20260715082226.51481-1-maxime.chevallier@bootlin.com>
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
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307701-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:hkallweit1@gmail.com,m:maxime.chevallier@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:thomas.petazzoni@bootlin.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,gmail.com];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,bootlin.com:from_mime,bootlin.com:mid,bootlin.com:email,bootlin.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EC1775BD3C

Currently, all inidivual drivers for MDIO bus controllers are directly
listed under Device drivers -> Network device support. Let's group them
altogether in a submenu, while keeping the dependency on PHYLIB.

No intended functional change besides the menuconfig ordering.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/mdio/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index e57121019153..b845f1c17843 100644
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
@@ -288,5 +289,4 @@ config MDIO_BUS_MUX_MMIOREG
 
 	  Currently, only 8/16/32 bits registers are supported.
 
-
-endif
+endmenu
-- 
2.55.0


