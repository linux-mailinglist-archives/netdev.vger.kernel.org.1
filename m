Return-Path: <netdev+bounces-305178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U1onI0b+S2oceQEAu9opvQ
	(envelope-from <netdev+bounces-305178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:13:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E2DE714D83
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 21:13:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XsVpgY3Q;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305178-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305178-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23BAE311F601
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BF73AF678;
	Mon,  6 Jul 2026 17:36:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADAB3ACA65;
	Mon,  6 Jul 2026 17:35:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783359360; cv=none; b=MxlFKzSwbaZzuyrtWP9286aqy08O+v5T66gjxmdITWWa4W+WrA2DH080Zft4LYuaKDkMJcD2+fVECCyFkVJCsrRmga7O0sjTneKUrsIljPKNrQmBpMfivJfAivQ/OL19qNuZPVmEMCVB8VTljxd8NW6JOW59WYW28787o/gd40Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783359360; c=relaxed/simple;
	bh=uf9k0lwi4OR9Ahwj7N6pv5lJVtG1ItErD4ZRXKHHX5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kiPjLponld6Gh6AfOiukw90rQxcjPAzdkaJfM5jdehZFAV0vQaWb+UXrrIa3+HjOEDfOlIJTLsXWW2YRO1yGuCLlT1MwuKuW7/FAQMd0iQpSOJvM/4IV5S6wcYxlJ+zT8hVSEohXB7xKP/RwcVtzA+fbgkwXG9b8Eop75+oEd8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XsVpgY3Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119A51F00A3A;
	Mon,  6 Jul 2026 17:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783359359;
	bh=zRpw/4G81Ngpv3cHDhu/5hiK4+GxmEEf2lmP3foOJQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XsVpgY3QEgW+wkQpXnwd+tM6hqF6fjg5KUIt4Y3YdhcUFSrokZCiHKA60irFAIGIp
	 AoOvfRk4TNLzVeLY0cS/8/IRJMVFuDmeP49iroeQMfp2U+YnpC/NwWGPBngvB+moyZ
	 b1k5nvQk2oCWgzcgiUGI8MMFK0vBt+X3RM4ADBKO2i1IfZJxv94Wc+M2L2mgaavDjz
	 uZ/bad/hGjuuTDgfdpape4KOhvDzAaUEPU+GCoRbKA0gnLy9VRzvbzreaQoHp/yRuU
	 Ebsc3ZnquCRvdjHKZRzEkfksjKnOYXwaQqrsEe3LgsaEgeJBli9ut/exKStF8/aU0D
	 ND1gi46rVlfhA==
Date: Mon, 6 Jul 2026 18:35:53 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Subject: Re: [PATCH net-next v5 1/4] dt-bindings: net: pse-pd: add bindings
 for Realtek/Broadcom PSE MCU
Message-ID: <20260706-player-handwash-0a3fe95cf5ec@spud>
References: <20260706112425.3149226-1-jelonek.jonas@gmail.com>
 <20260706112425.3149226-2-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1GUQUF22i6sgqNzV"
Content-Disposition: inline
In-Reply-To: <20260706112425.3149226-2-jelonek.jonas@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.26 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jelonek.jonas@gmail.com,m:o.rempel@pengutronix.de,m:kory.maincent@bootlin.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:netdev@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:daniel@makrotopia.org,m:bjorn@mork.no,m:jelonekjonas@gmail.com,m:andrew@lunn.ch,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[conor@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305178-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spud:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E2DE714D83

--1GUQUF22i6sgqNzV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 06, 2026 at 11:24:21AM +0000, Jonas Jelonek wrote:
> Add a binding for the microcontroller (MCU) that fronts the PSE silicon
> on a range of managed switches. The host talks only to the MCU, over
> I2C/SMBus or UART, using a fixed message-based protocol; the PSE chips
> behind it never appear on the bus.
>=20
> The compatible names the MCU front-end, not a specific part. These
> boards front the PSE silicon with an MCU that presents a stable
> message protocol Realtek documents. The PSE chip behind it varies
> - Broadcom on older boards, Realtek on newer - and is detected at
> runtime; the arrangement appears to be a Realtek MCU-based PoE design
> carried across those PSE-chip generations. So the 'realtek' prefix
> names that front-end (Realtek's protocol and firmware), not the
> general-purpose MCU silicon or the PSE chip - the google,cros-ec-*
> model. The '-rtk'/'-brcm' suffix selects the Realtek or Broadcom dialect.
>=20
> A single compatible per dialect covers both the I2C/SMBus and UART
> attachments: the wire protocol is identical across them and the transport
> is expressed by the node's parent bus, so it is not encoded in the
> compatible.
>=20
> Both dialects share one protocol family and one device tree contract, so
> they are documented in a single binding under the one 'realtek' prefix,
> with the '-rtk'/'-brcm' suffix distinguishing the dialect.
>=20
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
> ---
>  .../bindings/net/pse-pd/realtek,pse-mcu.yaml  | 154 ++++++++++++++++++
>  1 file changed, 154 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/pse-pd/realtek,=
pse-mcu.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu=
=2Eyaml b/Documentation/devicetree/bindings/net/pse-pd/realtek,pse-mcu.yaml
> new file mode 100644
> index 000000000000..d0dfae220dc1
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
> +  part. The device here is the MCU: it presents a stable message protocol
> +  documented by Realtek, with the PSE silicon behind it - Broadcom on
> +  older boards, Realtek on newer - detected at runtime and not described
> +  here. The MCU's own silicon is general-purpose and varies across
> +  boards, so the 'realtek' vendor prefix names the protocol front-end
> +  (following the google,cros-ec pattern); the '-rtk'/'-brcm' suffix
> +  selects the Realtek or Broadcom dialect.
> +
> +  A single compatible per dialect covers both the I2C/SMBus and UART
> +  attachments: the wire protocol is identical across them and the
> +  transport is already expressed by the node's parent bus, so it is not
> +  encoded in the compatible. Transport-specific properties differ
> +  accordingly - the I2C attachment carries 'reg' (and, for Realtek,
> +  'realtek,i2c-protocol'), while the UART attachment carries the serial
> +  peripheral properties such as 'current-speed'.

I'm not really convinced by the arguments here.

If the switch vendors are running different software on their MCUs to
the point that they behave differently, then yes it makes sense to have
different compatibles.

The first thing I don't understand is why realtek is considered the
main vendor here? Is it their MCU that broadcom are re-using with some
protocol tweaks?
If it is, then having the vendor as a suffix like wheel reinvention to
me, and if the MCU and/or protocol aren't something that broadcom
borrowed from realtek then having a realtek vendor prefix is strange
altogether. The mention of old boards being broadcom while the protocol
is documented by realtek is confusing me.

Either way, encoding the vendor without using the vendor prefix seems
very odd me to.

Secondly, the compatibles you do provide seem too generic. Is it really
possible for a given board to use smbus AND i2c, or do specific boards
only ever use i2c OR smbus (or uart for that matter).
I find it more believable that a board would support i2c and uart than
supporting both i2c and smbus fwiw.

Can you provide a link to the actual devices somewhere? It is
completely non-obvious to me what the binding actually represents.

Cheers,
Conor.


> +
> +properties:
> +  compatible:
> +    enum:
> +      - realtek,pse-mcu-rtk
> +      - realtek,pse-mcu-brcm
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
> +      reads carry a leading command byte (0x00) and a repeated start; "i=
2c"
> +      means bare 12-byte writes and reads with no command prefix. Only
> +      applies to the Realtek I2C attachment.
> +
> +required:
> +  - compatible
> +
> +allOf:
> +  - $ref: pse-controller.yaml#
> +  - $ref: /schemas/serial/serial-peripheral-props.yaml#
> +  # The I2C attachment (identified by 'reg') cannot carry serial bus pro=
ps.
> +  - if:
> +      required: [reg]
> +    then:
> +      properties:
> +        current-speed: false
> +        max-speed: false
> +  # 'realtek,i2c-protocol' is meaningful only for the Realtek I2C attach=
ment;
> +  # the Broadcom variant and any UART attachment must not carry it.
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: realtek,pse-mcu-rtk
> +      required: [reg]
> +    then:
> +      required:
> +        - realtek,i2c-protocol
> +    else:
> +      properties:
> +        "realtek,i2c-protocol": false
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  # Realtek PSE chip, I2C attachment (SMBus framing).
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        ethernet-pse@20 {
> +            compatible =3D "realtek,pse-mcu-rtk";
> +            reg =3D <0x20>;
> +            realtek,i2c-protocol =3D "smbus";
> +
> +            pse-pis {
> +                #address-cells =3D <1>;
> +                #size-cells =3D <0>;
> +
> +                pse-pi@0 {
> +                    reg =3D <0>;
> +                    #pse-cells =3D <0>;
> +                };
> +            };
> +        };
> +    };
> +
> +  # Broadcom PSE chip, I2C attachment.
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        ethernet-pse@20 {
> +            compatible =3D "realtek,pse-mcu-brcm";
> +            reg =3D <0x20>;
> +
> +            pse-pis {
> +                #address-cells =3D <1>;
> +                #size-cells =3D <0>;
> +
> +                pse-pi@0 {
> +                    reg =3D <0>;
> +                    #pse-cells =3D <0>;
> +                };
> +            };
> +        };
> +    };
> +
> +  # Realtek PSE chip, UART attachment.
> +  - |
> +    serial {
> +        ethernet-pse {
> +            compatible =3D "realtek,pse-mcu-rtk";
> +            current-speed =3D <115200>;
> +
> +            pse-pis {
> +                #address-cells =3D <1>;
> +                #size-cells =3D <0>;
> +
> +                pse-pi@0 {
> +                    reg =3D <0>;
> +                    #pse-cells =3D <0>;
> +                };
> +            };
> +        };
> +    };
> --=20
> 2.51.0
>=20

--1GUQUF22i6sgqNzV
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCakvneQAKCRB4tDGHoIJi
0v68AQCZWdQajqx/aJaQN57kMtKybmti7bHapdjulp0RucHc/gD+OnJj3pQDIoMU
hUU3VqfbSdYUCcM+N6ctaZPht90THwQ=
=if7B
-----END PGP SIGNATURE-----

--1GUQUF22i6sgqNzV--

