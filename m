Return-Path: <netdev+bounces-288509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IGrVNmSpB2pSBQMAu9opvQ
	(envelope-from <netdev+bounces-288509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:16:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9600755949F
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9EE9B30104BA
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428983F65EB;
	Fri, 15 May 2026 23:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on9AFBSS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD636DA0B;
	Fri, 15 May 2026 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887001; cv=none; b=XpoOxucJlbmQ7fcCy5//3O6PsIBBC00/U+/n2ONaYlgR7zzZ3TOEtlUo8J0SepVjK6QfD8I/U4JxjJKaYZM9Y7qRdit+Gzz7FHsDch6q7bvKxDac0ovJi31Ke1rHkrj64p+LesYCQc08rfdVxkuijFcv7EIkkDn1lFhsTPWE8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887001; c=relaxed/simple;
	bh=6sZq2IJKNUrXM4hv2VWy7/L4s6ZDgiOimXZMV4PL8Bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J7da5ArdB104jOrURrIAlXU+JqcaPGPFMVGV3qGG98itsesbyiasImLdX0FaBxdWSi8Yc/dc+ApLHTzOUpg5s4kA0/tyFpHIhu0Af26Y53Exak419dqRWegC4VFwEjoE7WbETJbJEZwZ6LlHAg1h9feqggACY9yBeQH8toObqnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on9AFBSS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBA3C2BCB0;
	Fri, 15 May 2026 23:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778887001;
	bh=6sZq2IJKNUrXM4hv2VWy7/L4s6ZDgiOimXZMV4PL8Bo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=on9AFBSSGXMy+LiIzx47iZwQfpdFF5qzUR23Hn3cRZP2ZWrqo3774SqL6ZUSnjOfv
	 dvTGSX3TLwuPhbf6IkKHCEIv6UUTbbERMc8xlFXTRA405UDZJcpwafpLX+PQ7xLZSv
	 UzsTkyYlNoTJ9CMcQzJsNNY6/jWT5P95pS/jq9W42ewIV+1vlfZM6u823WxVOK1VmN
	 QrGWcN/ckvgaRbdQc46Xe2lLG4BYYBjxAKzBW2Jy/hwQ1sJyFev7D6p8eijKlz3ucq
	 duHjQV/aWnxRSzt8uuvmcKGiWb99hOgl5hJVLjGuIU7yfdtQ6uYCPCAxF0/NGE2xQ2
	 W0LyTmHe+MtfA==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 16 May 2026 01:16:13 +0200
Subject: [PATCH 1/5] net: dsa: microchip: Add fallback Micrel compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-ks8995-to-ksz8-v1-1-70d0ef4aa5f4@kernel.org>
References: <20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org>
In-Reply-To: <20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 9600755949F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288509-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Because of forking paths when Micrel was acquired by Microchip,
two devices also exist with the micrel,* prefix bindings.
Add these to the KSZ SPI driver so users can use the more capable
driver.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/microchip/ksz_spi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index d8001734b057..c38eda65aaf2 100644
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


