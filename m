Return-Path: <netdev+bounces-259478-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LzKCzMdl2ktuwIAu9opvQ
	(envelope-from <netdev+bounces-259478-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:24:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6CDC15F744
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 15:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B72B7301BF5E
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC3C33E358;
	Thu, 19 Feb 2026 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glH1ee8R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8F233DED9
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 14:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771511067; cv=none; b=cGuZOicjlYXao95IPC4W5wZHumpRu5av8RctcTV96op/BVdFOdkj1NiY36Ppi3XPkqohQSW541UbaGnJcaVZCbtRI5DiJFsuyZxfuYBotns7bMvYCqZs74nLpCkfHffNtp6IbQQwLgwqCZ2kK/YYrUJvr9fti+pUDcDw6NFIs3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771511067; c=relaxed/simple;
	bh=7oPBKguAKyH7WnMj3zdgXhOmQH1jfpd6i6zeMQM7eGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vARjYQFNJuZ9sCrM1WSjR69LIqmAQet5cu8BwNtYHeZQCta6BjYMV0g0lkuPJBzuYp3+115lVM18lOdQs8juLcqEHZ5zmfrXNi+pEtTQsEX+0qAi0I0qGbDD0EnaXMTy6KLXx8ek1qnikBwHuk/+cqMThookby/3VNYk8fmGIzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glH1ee8R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122A5C4CEF7;
	Thu, 19 Feb 2026 14:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771511066;
	bh=7oPBKguAKyH7WnMj3zdgXhOmQH1jfpd6i6zeMQM7eGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=glH1ee8RqzXB1DQJh32KiJyLc+s26IdbZverfg8BW7s+K1NoXVOAqa4G9oSrlQ9lG
	 7NMpowVpSd6nb+Cdnf1p04eJ3SCu2Y8eNSrULezXdvgChdgeUEVI1mR0Qr1l+PDDJg
	 2WzSpid1p8Hh9zUe8Fo++t+gI6huGAAzMuHTQHMHSWZmD8O8r8lJ96TumrcMClpU8x
	 daf+80Go2dCZwq+aTEaVRSz774Pk7X0vcpxpRCMO8FuswHnJsTXFPcT6Bl1Vmzp5cW
	 JPPSMwLgK/kQyX2x/nUmtAJ8QUOJGRerueG2otWOXOJJztOcwSSDhe7lz1nS7KFk6n
	 1tcsw2AMR3yrw==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 19 Feb 2026 15:24:18 +0100
Subject: [PATCH net v3 2/5] net: dsa: microchip: Add fallback Micrel
 compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-ks8995-fixups-v3-2-a7fc63fe1916@kernel.org>
References: <20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org>
In-Reply-To: <20260219-ks8995-fixups-v3-0-a7fc63fe1916@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259478-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,microchip.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A6CDC15F744
X-Rspamd-Action: no action

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


