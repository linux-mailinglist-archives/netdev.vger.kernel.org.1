Return-Path: <netdev+bounces-290842-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFURHAlfEGobWwYAu9opvQ
	(envelope-from <netdev+bounces-290842-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:50:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A45E5B57E6
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E238300DA61
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 13:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AAF3ADBA7;
	Fri, 22 May 2026 13:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lPibPSNZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B898B3A1A5B;
	Fri, 22 May 2026 13:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779456107; cv=none; b=BVbley3FVm3v2B4ZKoJHpfsh1Lh1lOGf94dsK4TUzra+2kYLj7O6+XmauRzwSepA31Lwqs/H6IOrC8+zJjPQiEGL82DQytxM9lSRTDIZZjbMkq3bbZ2f/Io+Dl2rTioQKIGJYsy3VQXyGa4SG/+3XWqGooAuzyFRFmC832vhaXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779456107; c=relaxed/simple;
	bh=dMAo8n12J6zxPdQ6Fv0iYDtgAn2+XSPFj5fenNanL/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VWfSS/s3OoYipfPfnb10N4ksW1ydchsmxA6iUafgBMbFvnKkJy5i3JouW9xabE5Ebne+diZoTDEudE/jRiAmClhQFeE341XtKjIe2loIUsY4GLvuvHOww6/f/cUIZBez9VRQugqLgpri2ul6Y/zJ/CuZFyvF3BknxRgU9AQgzA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lPibPSNZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9387D1F00A3D;
	Fri, 22 May 2026 13:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779456102;
	bh=wNGIcC1rJgKhYJQVVISna0zCmvUlnf/I1XscOZvJOzw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=lPibPSNZbXAtUO+YRGQ9XhwcnX57xuWOE8Pi0SgvyH2SyK8LHX4xbdRgHoVb5hb2b
	 TONjkqc2/nVNYEYc6MGvdFIi+bIlw7dfSxyDGtuF72vHrmu//ATRH1/gH0Q2x9bR0r
	 gTDzDY9ooI4DQ2kMVbW/EVDsNZ+aOduCqKcXixnGXaBqqWMndy8BngVCaRkTuN9I2l
	 3qstWi8i1NPG5lFOm1Ux/gkdhNQO9MjV+4d1JQRiGHncHzdiuPY95BqdoONcPvzkTP
	 puwe7a5ZObAV1awJubiwdcrNyWcHKxnYw762cYMBE5Uyd7oHwTw4ZF9s/aXgGf0Wja
	 51NX3yAZRtxUg==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 22 May 2026 15:21:23 +0200
Subject: [PATCH net-next v2 1/5] net: dsa: microchip: Add fallback Micrel
 compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260522-ks8995-to-ksz8-v2-1-5712c0dc9e75@kernel.org>
References: <20260522-ks8995-to-ksz8-v2-0-5712c0dc9e75@kernel.org>
In-Reply-To: <20260522-ks8995-to-ksz8-v2-0-5712c0dc9e75@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290842-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,denx.de,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linusw@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2A45E5B57E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Because of forking paths when Micrel was acquired by Microchip,
two devices also exist with the micrel,* prefix bindings.
Add these to the KSZ SPI driver so users can use the more capable
driver.

Make the KS8995 driver mutually exclusive with this driver
to avoid probe races.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/Kconfig             |  1 +
 drivers/net/dsa/microchip/ksz_spi.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 39fb8ead16b5..b91b9766ebc2 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -98,6 +98,7 @@ config NET_DSA_RZN1_A5PSW
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


