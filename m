Return-Path: <netdev+bounces-137973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 368789AB50C
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 19:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B128A1F211B4
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 17:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290711BD01D;
	Tue, 22 Oct 2024 17:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFArfh+l"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05351A4F01;
	Tue, 22 Oct 2024 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729618095; cv=none; b=uvZIgiEA7KfUN3MYnvBZZEBTCgqidW3pv7QaYrIQzShpDWet7KA3ylWRvDOuwp15KD6uTTGVF5vm+rsHQ46QkmhYwhHqQ1LjkqanffPXwdr2DgYMSBCd3mtnePZvl8eb0MdYYE6LNf1MoqmcJ0ki4ppEt1A5JP2ZTRId7xvrQKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729618095; c=relaxed/simple;
	bh=Xh0Dg7YzHWWSX+FIkTVR8WeZ65RIdshONwrzkKLVIGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=spS8xRLPPhyV0YYiUseP9DlKV+MFIo4FqK7uXJ7J2lI8VutBGz35G2kdIXtKbaWPDtiPRaOqU0p59XSxfl8hyUfbx/2HjEqVc28gA4oCFHp7mg5piVPqyBNTDN31iRUHray++GXaCOx/2m2qqzc5BbLQSF1ht2ANDpxsI31j75o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFArfh+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09D1C4CEC3;
	Tue, 22 Oct 2024 17:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729618093;
	bh=Xh0Dg7YzHWWSX+FIkTVR8WeZ65RIdshONwrzkKLVIGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFArfh+ljJoq9u/Aw17WBReW1fNR5Efru55WhTA7qiDbSHlKhBw4OLKU9YdWShIF1
	 5ZUQFwoW2r6fQcM0r44gqy2wU3Yz6HbiMDaPucYcZrpK4RWtNL5f1JGXP+MUqUYM/y
	 PRUtgcNNcc1DS5gInVNc4bvOp2x0vZC/om7OqIDSVjpaVpyF0p5WCrEcx0iVtjlG83
	 r1G4hf9eOZTZcAeY5puk7U+DzQuJNrjlHSENbx7Dh3MP43FMerNTfOHbeeqqn7IW3x
	 UO3UTJRuEaWuGHMLSCNibWbVnnhTYNdmTqvh8s/Z60aeiofQVbnCSt4sSzgik+LfFT
	 t3xgiz77DurEg==
Date: Tue, 22 Oct 2024 18:28:06 +0100
From: Conor Dooley <conor@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Inochi Amaoto <inochiama@outlook.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Yixun Lan <dlan@gentoo.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/4] dt-bindings: net: Add support for Sophgo SG2044 dwmac
Message-ID: <20241022-crisply-brute-45f98632ef78@spud>
References: <20241021103617.653386-1-inochiama@gmail.com>
 <20241021103617.653386-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6+sVcBOZQT1jcJu5"
Content-Disposition: inline
In-Reply-To: <20241021103617.653386-3-inochiama@gmail.com>


--6+sVcBOZQT1jcJu5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 06:36:15PM +0800, Inochi Amaoto wrote:
> The GMAC IP on SG2044 is almost a standard Synopsys DesignWare MAC
> with some extra clock.
>=20
> Add necessary compatible string for this device.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
> ---
>  .../devicetree/bindings/net/snps,dwmac.yaml   |   1 +
>  .../bindings/net/sophgo,sg2044-dwmac.yaml     | 145 ++++++++++++++++++
>  2 files changed, 146 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/sophgo,sg2044-d=
wmac.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Docu=
mentation/devicetree/bindings/net/snps,dwmac.yaml
> index 3c4007cb65f8..69f6bb36970b 100644
> --- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> +++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
> @@ -99,6 +99,7 @@ properties:
>          - snps,dwmac-5.30a
>          - snps,dwxgmac
>          - snps,dwxgmac-2.10
> +        - sophgo,sg2044-dwmac
>          - starfive,jh7100-dwmac
>          - starfive,jh7110-dwmac
> =20
> diff --git a/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.ya=
ml b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> new file mode 100644
> index 000000000000..93c41550b0b6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/sophgo,sg2044-dwmac.yaml
> @@ -0,0 +1,145 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/sophgo,sg2044-dwmac.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH7110 DWMAC glue layer
> +
> +maintainers:
> +  - Inochi Amaoto <inochiama@gmail.com>
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        enum:
> +          - sophgo,sg2044-dwmac
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: sophgo,sg2044-dwmac
> +      - const: snps,dwmac-5.30a
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: GMAC main clock
> +      - description: PTP clock
> +      - description: TX clock
> +
> +  clock-names:
> +    items:
> +      - const: stmmaceth
> +      - const: ptp_ref
> +      - const: tx
> +
> +  sophgo,syscon:

How many dwmac instances does the sg2044 have?

> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to syscon that configures phy
> +          - description: offset of phy mode register
> +          - description: length of the phy mode register
> +    description:
> +      A phandle to syscon with two arguments that configure phy mode.
> +      The argument one is the offset of phy mode register, the
> +      argument two is the length of phy mode register.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +  - interrupt-names
> +  - resets
> +  - reset-names
> +
> +allOf:
> +  - $ref: snps,dwmac.yaml#
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: sophgo,sg2044-dwmac

Why does this have to be applied conditionally? There's only one
compatible in the binding, can't you apply these unconditionally?


Cheers,
Conor.

> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 1
> +          maxItems: 1
> +
> +        interrupt-names:
> +          minItems: 1
> +          maxItems: 1
> +
> +        resets:
> +          maxItems: 1
> +
> +        reset-names:
> +          const: stmmaceth
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    ethernet@30006000 {
> +      compatible =3D "sophgo,sg2044-dwmac", "snps,dwmac-5.30a";
> +      reg =3D <0x30006000 0x4000>;
> +      clocks =3D <&clk 151>, <&clk 152>, <&clk 154>;
> +      clock-names =3D "stmmaceth", "ptp_ref", "tx";
> +      interrupt-parent =3D <&intc>;
> +      interrupts =3D <296 IRQ_TYPE_LEVEL_HIGH>;
> +      interrupt-names =3D "macirq";
> +      resets =3D <&rst 30>;
> +      reset-names =3D "stmmaceth";
> +      snps,multicast-filter-bins =3D <0>;
> +      snps,perfect-filter-entries =3D <1>;
> +      snps,aal;
> +      snps,tso;
> +      snps,txpbl =3D <32>;
> +      snps,rxpbl =3D <32>;
> +      snps,mtl-rx-config =3D <&gmac0_mtl_rx_setup>;
> +      snps,mtl-tx-config =3D <&gmac0_mtl_tx_setup>;
> +      snps,axi-config =3D <&gmac0_stmmac_axi_setup>;
> +      status =3D "disabled";
> +
> +      gmac0_mtl_rx_setup: rx-queues-config {
> +        snps,rx-queues-to-use =3D <8>;
> +        snps,rx-sched-wsp;
> +        queue0 {};
> +        queue1 {};
> +        queue2 {};
> +        queue3 {};
> +        queue4 {};
> +        queue5 {};
> +        queue6 {};
> +        queue7 {};
> +      };
> +
> +      gmac0_mtl_tx_setup: tx-queues-config {
> +        snps,tx-queues-to-use =3D <8>;
> +        queue0 {};
> +        queue1 {};
> +        queue2 {};
> +        queue3 {};
> +        queue4 {};
> +        queue5 {};
> +        queue6 {};
> +        queue7 {};
> +      };
> +
> +      gmac0_stmmac_axi_setup: stmmac-axi-config {
> +        snps,blen =3D <16 8 4 0 0 0 0>;
> +        snps,wr_osr_lmt =3D <1>;
> +        snps,rd_osr_lmt =3D <2>;
> +      };
> +    };
> --=20
> 2.47.0
>=20

--6+sVcBOZQT1jcJu5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZxfgpgAKCRB4tDGHoIJi
0nAWAQDfeza6aA91cekxwcjXjesZrc3MIthUXQr3N1UZWnsSuQEAqCqjg9I1vB8t
/o5NgrwsAo5vJH/ZFQPuCuEIDd5xYQU=
=rpEJ
-----END PGP SIGNATURE-----

--6+sVcBOZQT1jcJu5--

