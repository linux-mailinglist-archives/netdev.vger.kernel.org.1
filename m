Return-Path: <netdev+bounces-283004-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKhoGNDL82mL7AEAu9opvQ
	(envelope-from <netdev+bounces-283004-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:38:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9724A84A4
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 23:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 629A63015E09
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 21:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F28D38F643;
	Thu, 30 Apr 2026 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="gY6nMyBy"
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E512D0617
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777584885; cv=none; b=ZQsGtYJV6FpcgLsuOjWKTUvY2tYjj90d1iWUmJlcNWZ9hN9pWgCkQNuy/nNH4I2jB++TeYNHEDg/x/13zEfdhePpwr7KcoljvnoPoC/engpjsZb3kX9CnfGA/PhhAU8c0qYzyC2y8Yokz/fjD8mSHzH8RiUGcX6uGDb4FiKEzZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777584885; c=relaxed/simple;
	bh=FDX4lEd6jhJ5khd+SbAHvHCyvm8Jz9Gum+WIoJqM/D0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RBqE/0pG9CpOuMbw9gMP61J+RxKhV+Ud71FaJAqE3zHAjDeQijSMj9cW5ybwMDnqGvTeLaRJATZQLcdIpBHT1iFVYPW2soHS3Si21btvejZBL5FBRFZFmbZVfg1v75HPlTtRmKCdDBwjn0nGqC8HRr8kiIr9iMxIGlHLpuTpTZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=gY6nMyBy; arc=none smtp.client-ip=212.77.101.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 20061 invoked from network); 30 Apr 2026 23:34:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1777584880; bh=KOlCJwPpuqnNC5OKwD++DIMZZIis5KRKRMlUvG+zZ1M=;
          h=From:To:Cc:Subject;
          b=gY6nMyBypIayXBT7ryfc2auwkxqpyHA2a5h0y93Tw86hRNFaNEyzju78pwWb2s54J
           ehIBIfC2RnIIqiFm8OWMrtfBeZRV7QPF70tlVIAukmgfo7K7O7k9yq7SJ5ZQe8qFWy
           d1sAtpfr1W9KKacT/qzjMVSfdVa6zinckFacOTlsw8UGgn5sLzMmqCGOdrFDO7qPyG
           +YBfpbw3R81RAROilQH8fBuVml0r5LI0Y8R3PtVbswCGDn3E/mNjVKXKGaSIkhyHKJ
           KlsJb0s4TIdn1tw0JJhQUEdXEKJks3mcXd1UjpGO4wSMjtDDR8MJsICQFL0QR97NQQ
           5lBJo/lvckViA==
Received: from 83.24.138.167.ipv4.supernova.orange.pl (HELO abajkowski.lan) (olek2@wp.pl@[83.24.138.167])
          (envelope-sender <olek2@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <andrew+netdev@lunn.ch>; 30 Apr 2026 23:34:40 +0200
From: Aleksander Jan Bajkowski <olek2@wp.pl>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hayeswang@realtek.com,
	hsu.chih.kai@realtek.com,
	kees@kernel.org,
	mail@birger-koblitz.de,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next] net: usb: r8152: add TRENDnet TUC-ET2G v2.0
Date: Thu, 30 Apr 2026 23:34:33 +0200
Message-ID: <20260430213435.21821-1-olek2@wp.pl>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-WP-MailID: 14b2f4eff858d4c91fa7923b8791bc5b
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0100001 [saKd]                               
X-Rspamd-Queue-Id: BA9724A84A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283004-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[wp.pl];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[wp.pl:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[olek2@wp.pl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl,lunn.ch];
	NEURAL_HAM(-0.00)[-0.986];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wp.pl:email,wp.pl:dkim,wp.pl:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:email]

The TRENDnet TUC-ET2G V2.0 is an RTL8156B based 2.5G Ethernet controller.

Add the vendor and product ID values to the driver. This makes Ethernet
work with the adapter.

Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/usb/r8152.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 7337bf1b7d6a..1ace1d2398c9 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -10138,6 +10138,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{ USB_DEVICE(VENDOR_ID_DELL,    0xb097) },
 	{ USB_DEVICE(VENDOR_ID_ASUS,    0x1976) },
 	{ USB_DEVICE(VENDOR_ID_TRENDNET, 0xe02b) },
+	{ USB_DEVICE(VENDOR_ID_TRENDNET, 0xe02c) },
 	{}
 };
 
-- 
2.53.0


