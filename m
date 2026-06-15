Return-Path: <netdev+bounces-299625-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tHe9LeBuMGoMTAUAu9opvQ
	(envelope-from <netdev+bounces-299625-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:30:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A7068A2D0
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:30:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TMm63yBa;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299625-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299625-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DD2CB3007B3E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86083B42F7;
	Mon, 15 Jun 2026 21:30:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55FA3AC0F5;
	Mon, 15 Jun 2026 21:30:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781559003; cv=none; b=gBdHPniWpoUCCXJ2CUVWUAxy/qz0rciCnu1QepM2XdJrTY2rAFRna/hUvGotfSseoHwWv4Xxnv1mIdkJ276Tr5CQOoXqQbWnbmNGW6ebKftqhZbYZzTOI76x0BZjMgMbIDfLQolBKIEIktqu8M7Qp2t0JRkzcsJqkL+ONVja3+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781559003; c=relaxed/simple;
	bh=EiCRVr3M2DH5FTdWqgsW9cs459pou3hbEG9/3uKIxY4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MRgfq7snh4u2F/3JWGS0sYsX41J0CgEXbOTsIsK4bwXBeur/EsB+/3kEQsq48N0VPKhBGjwC4N6F8kvheN5lJpBhnNiswujzMds82Myf0n/Ubh9Y0ZH9ckZml5lHGiYyDDyzuwi23thtZJMI7+Evuk/VH4YRL+KTsXwPwT5nZbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMm63yBa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F781F000E9;
	Mon, 15 Jun 2026 21:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781559002;
	bh=ZI35XYbRRsKxxlPoMzHSPqP4Q2mjdXi4PErk6iLoVFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=TMm63yBaS3eG79YXvRdE4XCn6Zk3hK6QaHwNTzfSM3uqL2uIZ+CVLIYWZbgIJ5oMb
	 mwBrc1PnF8gJrHkEUW9l1IUmEYXDgcHRFYsMfvqySzLQksjONSweijZiSabu5xa0CA
	 6dGhsvJ5em4UUSYBxruJVFCNsIK9E4FwdGuuWMCmW3aCmWFpCDTr7++PYHseH4GF4z
	 MAE7KCznUkCV0FxteOlrBd2IkWEMVKdU1r3VQOcv4jBANpzh5hE9OcU4445ZxNPxFM
	 60k8XEenbJ3J5oeX6Ao/htoyQDLxtoAf9zdWZk3WILGP8XdimFqlWyd1n6mJFO2exl
	 kZdYHXVgY8llQ==
Date: Mon, 15 Jun 2026 16:29:59 -0500
From: Rob Herring <robh@kernel.org>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v2 1/2] dt-bindings: net: pse-pd: add bindings
 for Realtek/Broadcom PSE MCU
Message-ID: <20260615212959.GA1679454-robh@kernel.org>
References: <20260612132944.460646-1-jelonek.jonas@gmail.com>
 <20260612132944.460646-2-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260612132944.460646-2-jelonek.jonas@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299625-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jelonek.jonas@gmail.com,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonekjonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B5A7068A2D0

On Fri, Jun 12, 2026 at 01:29:41PM +0000, Jonas Jelonek wrote:
> Add a binding for the microcontroller (MCU) that fronts the PSE silicon
> on a range of managed switches. The host talks only to the MCU, over
> I2C/SMBus or UART, using a fixed message-based protocol; the PSE chips
> behind it never appear on the bus.
> 
> The compatible identifies the PSE-MCU protocol dialect
> (realtek,pse-mcu-rtk or realtek,pse-mcu-bcm), not a specific part: the
> node describes the MCU - whose silicon is a general-purpose
> microcontroller that varies across boards - and the 'realtek' vendor
> prefix reflects the platform these MCUs are found on (Realtek-based PoE
> switches), following the google,cros-ec-* pattern rather than naming the
> MCU silicon. The '-rtk'/'-bcm' suffix selects the Realtek or Broadcom
> dialect within that one family. The specific PSE chip is detected at
> runtime and is not described here.
> 
> A single compatible per dialect covers both the I2C/SMBus and UART
> attachments: the wire protocol is identical across them and the transport
> is expressed by the node's parent bus, so it is not encoded in the
> compatible.
> 
> Both dialects share one protocol family and one device tree contract, so
> they are documented in a single binding under one vendor prefix. The
> 'realtek' prefix is used because this MCU front-end is found almost
> exclusively on Realtek-based switches; the Broadcom dialect is expressed
> as the realtek,pse-mcu-bcm compatible within the same family.
> 
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> ---
>  .../bindings/net/pse-pd/realtek,pse-mcu.yaml  | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
> new file mode 100644
> index 000000000000..2fb729dcb41f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/pse-pd/realtek,pse-mcu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek/Broadcom PSE MCU
> +
> +maintainers:
> +  - Jonas Jelonek <jelonek.jonas@gmail.com>
> +
> +description: |
> +  Microcontroller (MCU) that fronts the PSE hardware on switches using
> +  Realtek (RTL8238B, RTL8239, RTL8239C) or Broadcom (BCM59111, BCM59121)
> +  PSE chips. The MCU exposes a small message-based protocol over either
> +  I2C/SMBus or UART; the actual PSE silicon is not accessed directly. The
> +  Realtek and Broadcom variants share this device tree contract but use
> +  different protocol opcodes, selected by the compatible.
> +
> +  The compatible identifies the PSE-MCU protocol dialect, not a specific
> +  part. The device described here is the MCU, whose own silicon varies
> +  across boards and is incidental to the protocol. The MCU is not
> +  made by Realtek or Broadcom; the 'realtek' vendor prefix reflects the
> +  platform these MCUs are found on (Realtek-based PoE switches) and the
> +  '-rtk'/'-bcm' suffix selects the Realtek or Broadcom protocol dialect.
> +  The specific PSE chip behind the MCU is not described in the device
> +  tree either; it is detected at runtime by querying the MCU.
> +
> +  A single compatible per dialect covers both the I2C/SMBus and UART
> +  attachments: the wire protocol is identical across them and the
> +  transport is already expressed by the node's parent bus, so it is not
> +  encoded in the compatible. Transport-specific properties differ
> +  accordingly - the I2C attachment carries 'reg' (and, for Realtek,
> +  'realtek,i2c-protocol'), while the UART attachment carries the serial
> +  peripheral properties such as 'current-speed'.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - realtek,pse-mcu-rtk

The "rtk" feels redundant.

> +      - realtek,pse-mcu-bcm

"brcm" is the standard vendor prefix, so use that instead of "bcm". 
Though who defined the protocol in this case? Realtek or Broadcom? In 
the latter case, I'd argue that "brcm" should be the vendor prefix.

> +
> +  reg:
> +    maxItems: 1
> +
> +  power-supply:
> +    description: Regulator supplying the PoE power rail.
> +
> +  enable-gpios:
> +    maxItems: 1
> +
> +  realtek,i2c-protocol:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [ i2c, smbus ]
> +    description: |
> +      Wire framing the MCU firmware expects on the I2C bus. "smbus" means
> +      reads carry a leading command byte (0x00) and a repeated start; "i2c"
> +      means bare 12-byte writes and reads with no command prefix. Only
> +      applies to the Realtek I2C attachment.

I tend to think this should be distinguished by the compatible string. 
That would simplify the schema given it only applies to one of the 
compatible strings.

Rob

