Return-Path: <netdev+bounces-306857-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id e9c1AtNJUmpLOAMAu9opvQ
	(envelope-from <netdev+bounces-306857-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:49:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58665741B55
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 15:49:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=JvDir8OW;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=KSYAeQE9;
	dmarc=pass (policy=reject) header.from=mailbox.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306857-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306857-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1540230107DF
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 13:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8701DF26E;
	Sat, 11 Jul 2026 13:49:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC3C28F5;
	Sat, 11 Jul 2026 13:49:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783777743; cv=none; b=jtR1m7jYmZaSb5akx+7elP429i1ffqLlNG70n8Y39xzOC3iplqvgK7vUUY9GfFGMW3mURzfkuqmlzfB9S02nlK6k0d7juT8evsVyfq59rrKTj7se3om2unE9ZnNInAFqM85RDuuyPSDmAPdcxZdLIpzYi6ip4Kw50hanxaFQx+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783777743; c=relaxed/simple;
	bh=MotKtUbfKurNBepPQM1L3zQfVATLvjAa+t/D9/N0mHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t+UBueO2jkw0Hu+hIkzQBzIhdSGhFjD21H4nRxoHme1ceWqfgZpFnvLSg3/es3Waovb9ZvF1tNr/xvQ/BlF3bdWm5diGNQavsYGrCBFR/JeMSw7qRmcMDv4wDl7ZRy+fJV4NQd7wetdd/DXcA2AZ0jgL2wQRoPK6GqY4T0BZ70Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=JvDir8OW; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=KSYAeQE9; arc=none smtp.client-ip=80.241.56.151
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA512)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4gy9632ZdFz8tx5;
	Sat, 11 Jul 2026 15:48:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783777739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R/Fp82DdwdsdjuZNuHQ6xGSMhLCpNkimKrPid5jFkVI=;
	b=JvDir8OW7qN7rNtkuZ9AmiD0P1ybb1bGg4XuvQIk/Uw1Yat9jtoGPKda1S80e5oDoCTReB
	f/0PrL4DqtMT3ftXGnU7fbXYrnkSsgg9bnTb1WS5bOGHSOpO9pd0NUQq+CMYMh7oqyukId
	RyLqWMBV1xfT+gCm+Rn+XwDGZM2y6cXldvUlqQPOvds+93WeXAk5EjgUC6dcl+Xm/0DBu9
	4019rW/ZjAKUGA8xAflOs4oQbdBLDe+brlJ6b2tE7rf8/xOvBnVRNyJ7nnjOOltP6MnFOE
	kGXQ5s9TUxDcqbPHfJaDwghnNHpiM9tFeNZcUQFjL+sH8VHOR4Gy9PP1vsfgXg==
From: Manuel Ebner <manuelebner@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1783777738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=R/Fp82DdwdsdjuZNuHQ6xGSMhLCpNkimKrPid5jFkVI=;
	b=KSYAeQE9futuTg1FvFV1gHjII+0df3Uti7JxwICV5HxWu4+F4Fhdhr2ww4bpZZ/x4Juz0u
	5FcAg+yb+4Uhw8jiuGGBKxreOA4HhR1CgA1R+Lqw/d+HZ5tDhdtzTyUTOxNT0iF7isf6BU
	jLA4r/5OH2b+tYaQclHRMqECT99DHH+rk1975tyFsXEj9mQs22E8KSswssky5l8CEf0nNX
	sMAMlv1Ht6L8jw0j5sxvC7dqIeOJJCse8a63zrJdLBkWdtr3inpWxH/7CT9CDN7LiUrSzh
	e5UgUAWqFPy81tmJL6dlrBTgUZ9JHaz1sv2Lijmwmkpp5vm5XTsXxC6K3xc/5Q==
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Manuel Ebner <manuelebner@mailbox.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: net: microchip: fix bracket
Date: Sat, 11 Jul 2026 15:42:09 +0200
Message-ID: <20260711134204.472841-7-manuelebner@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: onhap5gzpm4h3e6w3mdrb36rygxocstr
X-MBO-RS-ID: 2e1503e32c96732c293
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:o.rempel@pengutronix.de,m:manuelebner@mailbox.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-306857-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[manuelebner@mailbox.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manuelebner@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mailbox.org:from_mime,mailbox.org:email,mailbox.org:mid,mailbox.org:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 58665741B55

Remove needless ')'

Signed-off-by: Manuel Ebner <manuelebner@mailbox.org>
---
I send this in a seperate patch, because there's a change the maintainers
wants a bracked added instead of removed.
---
 Documentation/devicetree/bindings/net/microchip,lan95xx.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
index b9c394009040..f4d0929616a5 100644
--- a/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,lan95xx.yaml
@@ -35,7 +35,7 @@ properties:
           - usb424,9906   # SMSC9505A USB Ethernet Device (HAL)
           - usb424,9907   # SMSC9500 USB Ethernet Device (Alternate ID)
           - usb424,9908   # SMSC9500A USB Ethernet Device (Alternate ID)
-          - usb424,9909   # SMSC9512/9514 USB Hub & Ethernet Device  ID)
+          - usb424,9909   # SMSC9512/9514 USB Hub & Ethernet Device ID
           - usb424,9e00   # SMSC9500A USB Ethernet Device
           - usb424,9e01   # SMSC9505A USB Ethernet Device
           - usb424,9e08   # SMSC LAN89530 USB Ethernet Device
-- 
2.54.0


