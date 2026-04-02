Return-Path: <netdev+bounces-274571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEZ0N4N6zmmMnwYAu9opvQ
	(envelope-from <netdev+bounces-274571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:17:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD838A59E
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 16:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D39333094859
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 14:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F913E51F4;
	Thu,  2 Apr 2026 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T0FR67E9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5671F2F1FC3;
	Thu,  2 Apr 2026 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139053; cv=none; b=nB55WAtmXEJ5IF5/o+k0SpCW3s6G7FHuQvVXYSEG6EU4a4/bqClZEa8Lqjf5YRB1uIhqsR9qTvKONqerkXi63lZ5q26CN+JpNyLJ5WGuJcgOdVdb80jrz9TjJSXKtKpS8dnNRjrNOgti0FxhiKpGbP6/ymhRtFCcwYKAXX9eCGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139053; c=relaxed/simple;
	bh=qnPV9EsI0Q6O7EcPxidXe8J3lHGr+k/ipigwkSCRjoo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mLD12ewQ8DruGaHjK4rFuT6k7eDWbEMzYEnLAkJCk82YWSeoPW8/Va86NnPT5fOhDlG1BbHrGCs2FnqKt8Wa/m9jjworcIVmRJXewgnEMLTLDx1Dy4/Z/xUC2W+xFBlr7Hhof4J32WeNPxzEwgM1+ChaYE0PqhSG4SVoBnivcEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T0FR67E9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27D0C116C6;
	Thu,  2 Apr 2026 14:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775139052;
	bh=qnPV9EsI0Q6O7EcPxidXe8J3lHGr+k/ipigwkSCRjoo=;
	h=From:To:Cc:Subject:Date:From;
	b=T0FR67E94IZyuyyuJnFmTYSn7UiGc0DLrJ8KRviRsZKG5uW0X/Lcd1FOJPhb+hAbo
	 ekZPfFEP5ATVYHk3QvDXougZLRBIAWNbqY4Yj4RB+a4tKNIuorsK6Dq98apBkVNWg7
	 xbRknFcoy1hJ0Z0rSEaPNz3nLBQ7GcPuvwWQgTxSC357CABJOc6CLbv0fJJb8fw7hD
	 l/FaOEHeHkHEcHYJdeZOHoCvjUhXd6AoSd6EhUgsFBhxKUa5hF/PgdT/pbfo8tEP02
	 sKSfUYDCWNm8ehGCexjqI1h6r6AMuAFoIoihkODVf3WaxuRrChIsQXVUnPfsPDjV8t
	 EScKZZobxQMUw==
From: Arnd Bergmann <arnd@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: fec: make FIXED_PHY dependency unconditional
Date: Thu,  2 Apr 2026 16:10:40 +0200
Message-Id: <20260402141048.2713445-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274571-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3FBD838A59E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Arnd Bergmann <arnd@arndb.de>

When CONFIG_FIXED_PHY is in a loadable module, the fec driver cannot be
built-in any more:

x86_64-linux-ld: vmlinux.o: in function `fec_enet_mii_probe':
fec_main.c:(.text+0xc4f367): undefined reference to `fixed_phy_unregister'
x86_64-linux-ld: vmlinux.o: in function `fec_enet_close':
fec_main.c:(.text+0xc59591): undefined reference to `fixed_phy_unregister'
x86_64-linux-ld: vmlinux.o: in function `fec_enet_mii_probe.cold':

Select the fixed phy support on all targets to make this build
correctly, not just on coldfire.

Notat that Essentially the stub helpers in include/linux/phy_fixed.h
cannot be used correctly because of this build time dependency,
and we could just remove them to hit the build failure more often
when a driver uses them without the 'select FIXED_PHY'.

Fixes: dc86b621e1b4 ("net: fec: register a fixed phy using fixed_phy_register_100fd if needed")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
I sent the same fix for B44 earlier, see commit 3f0f591b44b0 ("net: b44:
always select CONFIG_FIXED_PHY"). I checked that there are no other
conditional users of FIXED_PHY this time.
---
 drivers/net/ethernet/freescale/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
index e2a591cf9601..11edbb46a118 100644
--- a/drivers/net/ethernet/freescale/Kconfig
+++ b/drivers/net/ethernet/freescale/Kconfig
@@ -28,7 +28,7 @@ config FEC
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select CRC32
 	select PHYLIB
-	select FIXED_PHY if M5272
+	select FIXED_PHY
 	select PAGE_POOL
 	imply PAGE_POOL_STATS
 	imply NET_SELFTESTS
-- 
2.39.5


