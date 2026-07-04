Return-Path: <netdev+bounces-304721-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YGZdC45hSWrN0wAAu9opvQ
	(envelope-from <netdev+bounces-304721-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:39:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9408F70844A
	for <lists+netdev@lfdr.de>; Sat, 04 Jul 2026 21:39:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XYwQTQc1;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304721-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304721-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC887301A535
	for <lists+netdev@lfdr.de>; Sat,  4 Jul 2026 19:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9A752EA468;
	Sat,  4 Jul 2026 19:39:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 924BE2C15A5;
	Sat,  4 Jul 2026 19:39:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783193987; cv=none; b=PhvHgRmIMAU2/fyMJ+bjPJg+UyLQKhpnXXcNp/zemsFpQ2h/HvEI5ggaq60wOKvBBpdKLktzZ+vPKAqApC1+lASIAKk+m6Jss0xAxxih57az1+sQDuh8+lQ2tO7QpImlF6It/QyKpardj2GPxoXaJpKSsGzHsDspYhnJDqMN1Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783193987; c=relaxed/simple;
	bh=BifGpaOg5XZrQzvVB2o5ei3lOIDNjG9z9BVx4H29PYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoA/d9jTkMXOdvQlamygjs02dgIi8kV8fdl6rQuctxxbcH9XRABwS6YolQM9XGR03Ic8R4qQ3jSE9rPiXzT+516jH62z67dxsbDHBQVE7VCPdNzQLXaw5DUNUKl2lHrSHrnAT453UW5bC1lRnHd3fsOrdha+VuCOWUMAkRX4OzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XYwQTQc1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327451F00A3A;
	Sat,  4 Jul 2026 19:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783193986;
	bh=05ZbWYYW4RjjQ6p3V7sBtDHHa/eUPxq6EJ99nZ/1k5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=XYwQTQc1aYUdPMbj1B+gfxLSf/6OLfPAgXOm965um2ZUZUsUoJjUndd8rhYGowkFV
	 j37La0VlUYtXstcVrAImG8egh2pSgmez416NRVuxS0FRT64iefJrDw4lnmJdgJVYYW
	 1zN1hsyjMq5Gv3po1ERbAO+sxIDTIlh/y9p0qG1ayRuZ8rm4gqEbQvvpUHGWVLbWnk
	 U55A8UI8AAMHHdgXidQTQ+u7fmFneREAaqlYIpTEq4J2XJ6hQov93FWKx2WkLZ1zvZ
	 XVY8+euqP6ioPWKm6D8/9iWLT5Klo0ZKimPbEOm+GTqdr6/yJ3Nv1jNXqAHLl00mvb
	 pmZrBE1CU2ZGA==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 04 Jul 2026 21:39:33 +0200
Subject: [PATCH net-next v7 1/5] net: dsa: microchip: Add fallback Micrel
 compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260704-ks8995-to-ksz8-v7-1-2af0eaa545a8@kernel.org>
References: <20260704-ks8995-to-ksz8-v7-0-2af0eaa545a8@kernel.org>
In-Reply-To: <20260704-ks8995-to-ksz8-v7-0-2af0eaa545a8@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:marex@denx.de,m:horms@kernel.org,m:linux@armlinux.org.uk,m:netdev@vger.kernel.org,m:Woojung.Huh@microchip.com,m:devicetree@vger.kernel.org,m:linusw@kernel.org,m:nb@tipi-net.de,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304721-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9408F70844A

Because of forking paths when Micrel was acquired by Microchip,
two devices also exist with the micrel,* prefix bindings.
Add these to the KSZ SPI driver so users can use the more capable
driver.

Make the KS8995 driver mutually exclusive with this driver
to avoid probe races.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/Kconfig             |  1 +
 drivers/net/dsa/microchip/ksz_spi.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 4ab567c5bbaf..e704ab702c18 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -100,6 +100,7 @@ config NET_DSA_RZN1_A5PSW
 config NET_DSA_KS8995
 	tristate "Micrel KS8995 family 5-ports 10/100 Ethernet switches"
 	depends on SPI
+	depends on !NET_DSA_MICROCHIP_KSZ_SPI
 	select NET_DSA_TAG_NONE
 	help
 	  This driver supports the Micrel KS8995 family of 10/100 Mbit ethernet
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index 373e9054947c..77aecac32466 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -224,6 +224,21 @@ static void ksz_spi_shutdown(struct spi_device *spi)
 }
 
 static const struct of_device_id ksz_dt_ids[] = {
+	/*
+	 * Legacy Micrel bindings. In 2015 Microchip acquired
+	 * Micrel which is the originator of the KSZ series, and
+	 * devices branded for Micrel already existed, as well as
+	 * some device tree bindings. These two products are identical
+	 * to the same Microchip products.
+	 */
+	{
+		.compatible = "micrel,ksz8864",
+		.data = &ksz_switch_chips[KSZ8864]
+	},
+	{
+		.compatible = "micrel,ksz8795",
+		.data = &ksz_switch_chips[KSZ8795]
+	},
 	{
 		.compatible = "microchip,ksz8463",
 		.data = &ksz_switch_chips[KSZ8463]

-- 
2.54.0


