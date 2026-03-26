Return-Path: <netdev+bounces-271958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKGqIxMKxWma5wQAu9opvQ
	(envelope-from <netdev+bounces-271958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:27:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED2823334F6
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 11:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2007B31A021A
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 10:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600683D301B;
	Thu, 26 Mar 2026 09:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQ+zf+vG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A063CF690
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519061; cv=none; b=LiAyWL5R3T3IHgyQCAJSdIlHVopAx1XAfSETQ2FasiPzORw3iX6Ixy5t8u08Hcrx3ypwmM5TB28GpbusOvV9dI0FlXfrleo+pkHsir5DYsccg+JbaKVsFf1oSgaB7a9x+6mZQ1MOJ0TFNIT/0Nn9/Sr93qxTvXbqudUEH5fVEBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519061; c=relaxed/simple;
	bh=7oPBKguAKyH7WnMj3zdgXhOmQH1jfpd6i6zeMQM7eGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pzht1LAa3zRCu0t+R68dE09F9IEhgWOxI3oajgJ7vdXKzj8cqEHxsoJLFdZTtPyJEjWOr+FoRFMVQhHncdl1ScWx1MYtKeLngtfBz0uS7FI7cV7MvaFgAwV2YCh21KFaruV1LNNDCZXYDX9t8nSYVkPp5U6escT+uR5JdwAmVcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQ+zf+vG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FA3C2BC87;
	Thu, 26 Mar 2026 09:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774519061;
	bh=7oPBKguAKyH7WnMj3zdgXhOmQH1jfpd6i6zeMQM7eGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sQ+zf+vGSNbsdnG9JiZB6mzO1J5lHY8IilTS177wLcn5dTz6TxFiEdujSPC5f8ItB
	 kzY/l194rO5g9yhUZjH5rMc7wxk2Y0UnB7rGqIHujsYMAhGK40AwbFFzTsCIRk9nDU
	 rOBj5/040blZG50CK8JoIIOWi9xLhWHRYDxa97GrIQVAmp2/ApKOpFVnvuLgMa0pzH
	 LIw549tdqr/Ygw6rDGTdTcPlpN8WsN/jdFqpkXmSNk4Ryd7bPWZlfa0d4v637VNtll
	 A6XE+Jhufy+7Fs4jVPQ9FjLhPRJlgySaQUbjtjDKmxz4BLf73HUA+WG07GcrQUv5mY
	 aUJORSGJmV9FQ==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Mar 2026 10:57:33 +0100
Subject: [PATCH net v4 2/4] net: dsa: microchip: Add fallback Micrel
 compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-ks8995-fixups-v4-2-989abba8f077@kernel.org>
References: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
In-Reply-To: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-271958-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,microchip.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ED2823334F6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Because of forking paths when Micrel was acquire by Microchip,
two devices also exist with the micrel,* prefix bindings.
Ass these to the KSZ SPI driver so users can use the more capable
driver.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/microchip/ksz_spi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index d8001734b057..e3bb1ccf2331 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -312,6 +312,21 @@ static const struct of_device_id ksz_dt_ids[] = {
 		.compatible = "microchip,lan9646",
 		.data = &ksz_switch_chips[LAN9646]
 	},
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
 	{},
 };
 MODULE_DEVICE_TABLE(of, ksz_dt_ids);

-- 
2.53.0


