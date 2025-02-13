Return-Path: <netdev+bounces-165993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E023A33DD9
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2AEE47A4E70
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5F342135AA;
	Thu, 13 Feb 2025 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qj29tY/i"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B142E20AF98
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 11:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739445716; cv=none; b=mkP8Rk1chWZatgT/pkDZy0l2tT+GVbwDo6Oc576mGvPZsbj+VjmIDp9cqKxl6GMQyvQCgmMRC1ZCKnzx+HjpgfEZb9lMynti4nqP+/hAD+6eQRFwPZ0dLFyPymHo4VVJL2C0TkBf2lgP1yD4gWZyrlBgEJfSgcHtNqb8Rli0Bck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739445716; c=relaxed/simple;
	bh=Pi4eMn80Vkv3stDJ2Ryeq1gBOrxrcjdgjXuoH7Kh8vw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=hGvw2a5FuxjSt6yiVRkISBTDwIBEUj9LzLjFbmb6P93iGxcW1E8jC2RYAfaURyFvxD6POY7NFJMewx1SmMSxaEn+hKuUOfNu7dGjLwo6BUdhvIzrVrryIV7Pw24xh5xrmZbolXsoleivx76Pv5uSyR35Gllw2bZ3vZK/le9Nu28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qj29tY/i; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250213112151epoutp046da4d44b55edc5ad455c78d06d57129c~jwKikNIMN0871908719epoutp04h
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 11:21:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250213112151epoutp046da4d44b55edc5ad455c78d06d57129c~jwKikNIMN0871908719epoutp04h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739445711;
	bh=FYeA0egZv4FF41HWS+5lY5RJ3ar8Pphs0FsmtbhyRSE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=qj29tY/iSIOX/IKeNwEWLUhYSOojk/p0yq39MyLUD5o9EhMrlTrfigvInh/f3eecq
	 84a7nGp1x9AltRNUKXaTRFq1GhRgM7M05Jp+LqCej7VEd5vtVEEIO+C/IeAU42+Yjt
	 9eaRUYaXidA013VMkA3nAAG5lk5HvpMbpBwigtMw=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250213112150epcas5p432ded18de14682cc3b9c16d15c3a6f1b~jwKh9cVoO2775827758epcas5p4Q;
	Thu, 13 Feb 2025 11:21:50 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Ytt710fwvz4x9Pr; Thu, 13 Feb
	2025 11:21:49 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AF.8A.19710.CC5DDA76; Thu, 13 Feb 2025 20:21:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250213110439epcas5p4363f12d24845f86de9f5e0d1c15bcaf9~jv7hQbNb63061630616epcas5p4_;
	Thu, 13 Feb 2025 11:04:39 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250213110439epsmtrp1713a253bece086c0e65de979af9e8830~jv7hPeule2200722007epsmtrp1E;
	Thu, 13 Feb 2025 11:04:39 +0000 (GMT)
X-AuditID: b6c32a44-363dc70000004cfe-d8-67add5cc2674
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CF.18.23488.7C1DDA76; Thu, 13 Feb 2025 20:04:39 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250213110436epsmtip2c8a8209a8c3b9ff20b96d86af3fac0e3~jv7ezI9zW2340823408epsmtip2R;
	Thu, 13 Feb 2025 11:04:36 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc: <krzk+dt@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh@kernel.org>, <conor+dt@kernel.org>, <richardcochran@gmail.com>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
	<rmk+kernel@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <20250213-adorable-arboreal-degu-6bdcb8@krzk-bin>
Subject: RE: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device tree
 bindings
Date: Thu, 13 Feb 2025 16:34:29 +0530
Message-ID: <009a01db7e07$132feb60$398fc220$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFMfZy5LnHh86L+CikZ+hKlrx3PbgHP/Q5uAh59lGQBgzSo3LQ3hOaA
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1BUZRjuO2cvB2mZ44LywUSuJ7twWdjFZT3bLFhKzhZWFD9yGJWOcGYX
	2dvsLlJNTRZGiALSJLELrgsjFw1IF12X6wQhjkKAFzYoKBJIbjOMohgY0C4Hin/P9z7P+z3v
	810wlD/NCcRStSbaoKXUBGcDy/FT8CvCrr4apWjotpycnygEZOWwk01WN3cjZEnPMRZ5tr2b
	TY513OOSE5bfOWRPz0Uu2evIY5P2ERebvNNQwiFzXKNs0rpYwyY7bJvJuc5pQLZ3jaPk7fwC
	hFxucnJf4yvuuG6hisvnBxDFWP4VrqLeMsRV2OzpCvuF4xxF3bnPFfXOWUQx09LHUbS2iBWz
	9ufjvRPT5CqaSqENAlqbrEtJ1SqjibiEpN1JUVKRWCiWkTsIgZbS0NFE7N544Z5UtTsXIThC
	qdPdpXjKaCQiYuQGXbqJFqh0RlM0QetT1HqJPtxIaYzpWmW4lja9KhaJIqPcwg/TVHXmZkTf
	L/joQeEQ6yho9M8BXhjEJXDw7/sgB2zA+HgjgOaqRZaH4OMPAcy5F8YQcwDen/6StdZR9bAI
	YYhmAK2OBpRZjAP4XfYj4FFx8BBYltfC9WA/XAjr+iu5HhGKD6PwZFHJylZeeAzMnc10Exjm
	i78Hs675eMos/EVYUDLH8WAeLoNtrTdZDN4Ib5hHVzCKh8KK0imUmUgA58cq2IzXHvi0eAkw
	Gn94bf7kynAQP+EFKx1ONtMQCwfrMjkM9oWT1y9zGRwIJ/KzVnES/D6vbzWyCg4tFKzqd8If
	73rmx9wGwfCHhgimHARP36xFGF8fmPt0FGHqPOi0ruEX4OKUa3XLAOgon+GeAoRlXTTLumiW
	dREs/7vZAOsCCKD1Ro2STo7Si7V0xn8XnqzT2MHKsw+JdYL+s0vhbQDBQBuAGEr48WBhtZLP
	S6E+/oQ26JIM6Wra2Aai3OddgAZuSta5/43WlCSWyEQSqVQqkW2Xigl/Xmb9MSUfV1ImOo2m
	9bRhrQ/BvAKPIgc6R20J2dih0IMR7KyNGO9464I690zYvi/eBI7HTwJcj4sOTVyJ9HZs23vu
	ZdOmxbjSwb4y76L9w16/1XduaSWoLuuutPlk+tKIf6LQ/M6ULYgM3Uw0Fl/tiKm6WP3rQfR9
	LeIzvlQxkLaj3CqMvH7a71NNwfmF7N3tQfWnmpb/GbYkbGFDyaQm8sHXR3wzUrfJ5Rr71pqr
	5jFZ8K7Kv575Y1jfe2BfapP88I0Pen+Je/Qz/nbG5FuijlvWmbvdxW9cop6bebf3z5eeTYzM
	bnrdpAz7Ft0pFwwcXlbXfmOuLaXPTA9FDQpkrv6ZphNSqq56ZHvtmKUs74ntM5+Y8v21X6ki
	CJZRRYlDUIOR+hfqY4fEfwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGIsWRmVeSWpSXmKPExsWy7bCSvO7xi2vTDTY+EbD4+XIao8XyBztY
	LdbsPcdkMed8C4vF/CPnWC2eHnvEbvFy1j02i/PnN7BbXNjWx2qx6fE1VovLu+awWXRde8Jq
	Me/vWlaLYwvELL6dfsNoceTMC2aLS/0TmSz+79nB7iDkcfnaRWaPLStvMnk87d/K7rFz1l12
	jwWbSj02repk89i8pN5j547PTB7v911l8zi4z9Dj8ya5AO4oLpuU1JzMstQifbsErowFGyaw
	FjyXr9jY3svcwHhCrIuRk0NCwERixacZTF2MXBxCArsZJWadX84MkZCU+NQ8lRXCFpZY+e85
	O0TRM0aJvnUbGEESbAJaEov69rGD2CICuhKbbywHK2IW+MIsMfv+ZKixbxklrjYdYAGp4hSw
	k+j93AzWISzgL/G+9ySYzSKgKjFxzjc2EJtXwFLi0MFTLBC2oMTJmU/AbGYBbYmnN5/C2csW
	voY6VUHi59NlrBBXuEn8nv2PEaJGXOLozx7mCYzCs5CMmoVk1Cwko2YhaVnAyLKKUTK1oDg3
	PTfZsMAwL7Vcrzgxt7g0L10vOT93EyM46rU0djC++9akf4iRiYPxEKMEB7OSCK/EtDXpQrwp
	iZVVqUX58UWlOanFhxilOViUxHlXGkakCwmkJ5akZqemFqQWwWSZODilGpi6QvQf7P8iaav1
	4mzOiq3nQy7PXRN8est2l/dRqXdY64ofqt09IMTynvtnrWVB0NezPutdg3yCGjhmeX06veyJ
	mPB2izvXC/zU0vPPBuYdCJZJiBD1TEvhWnKrn4275uh649r6jXwL/GWz/M9+/uP2oNm//yfr
	7xOvJ5eu8IrUd8zhV6n4/nTXuzuxFv95hZ6xG01qcFPiCTh5polz6oZ4Sx7Zd/mzN93f2Fcr
	pl/w9u2cubtnyGiesm9R/Nebe/lY5nTBmqcPZvned5C0/6gmK1sWzrAs19Rk2tGGDcGzJOS2
	dZX3TpvcO+POet7aXA6vFwGPUueLrJvacYm7b2NiNkuc7ZZNVlJThGt+7FBiKc5INNRiLipO
	BACb1ffZaQMAAA==
X-CMS-MailID: 20250213110439epcas5p4363f12d24845f86de9f5e0d1c15bcaf9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250213044955epcas5p110d1e582c8ee02579ead73f9686819ff
References: <20250213044624.37334-1-swathi.ks@samsung.com>
	<CGME20250213044955epcas5p110d1e582c8ee02579ead73f9686819ff@epcas5p1.samsung.com>
	<20250213044624.37334-2-swathi.ks@samsung.com>
	<20250213-adorable-arboreal-degu-6bdcb8@krzk-bin>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 13 February 2025 13:24
> To: Swathi K S <swathi.ks=40samsung.com>
> Cc: krzk+dt=40kernel.org; andrew+netdev=40lunn.ch; davem=40davemloft.net;
> edumazet=40google.com; kuba=40kernel.org; pabeni=40redhat.com;
> robh=40kernel.org; conor+dt=40kernel.org; richardcochran=40gmail.com;
> mcoquelin.stm32=40gmail.com; alexandre.torgue=40foss.st.com;
> rmk+kernel=40armlinux.org.uk; netdev=40vger.kernel.org;
> devicetree=40vger.kernel.org; linux-stm32=40st-md-mailman.stormreply.com;
> linux-arm-kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
> Subject: Re: =5BPATCH v6 1/2=5D dt-bindings: net: Add FSD EQoS device tre=
e
> bindings
>=20
> On Thu, Feb 13, 2025 at 10:16:23AM +0530, Swathi K S wrote:
> > +  clock-names:
> > +    minItems: 5
> > +    maxItems: 10
> > +    contains:
> > +      enum:
> > +        - ptp_ref
> > +        - master_bus
> > +        - slave_bus
> > +        - tx
> > +        - rx
> > +        - master2_bus
> > +        - slave2_bus
> > +        - eqos_rxclk_mux
> > +        - eqos_phyrxclk
> > +        - dout_peric_rgmii_clk
>=20
> This does not match the previous entry. It should be strictly ordered wit=
h
> minItems: 5.

Hi Krzysztof,
Thanks for reviewing.
In FSD SoC, we have 2 instances of ethernet in two blocks.
One instance needs 5 clocks and the other needs 10 clocks.

I tried to understand this by looking at some other dt-binding files as giv=
en below, but looks like they follow similar approach
Documentation/devicetree/bindings/net/stm32-dwmac.yaml
Documentation/devicetree/bindings/net/rockchip-dwmac.yaml

Could you please guide me on how to implement this?
Also, please help me understand what is meant by 'strictly ordered'

>=20
>=20
> > +
> > +  iommus:
> > +    maxItems: 1
> > +
> > +  phy-mode:
> > +    enum:
> > +      - rgmii-id
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - interrupts
> > +  - clocks
> > +  - clock-names
> > +  - iommus
> > +  - phy-mode
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - =7C
> > +    =23include <dt-bindings/clock/fsd-clk.h>
> > +    =23include <dt-bindings/interrupt-controller/arm-gic.h>
> > +    soc =7B
> > +        =23address-cells =3D <2>;
> > +        =23size-cells =3D <2>;
> > +        ethernet1: ethernet=4014300000 =7B
> > +            compatible =3D =22tesla,fsd-ethqos=22;
> > +            reg =3D <0x0 0x14300000 0x0 0x10000>;
> > +            interrupts =3D <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> > +            interrupt-names =3D =22macirq=22;
> > +            clocks =3D <&clock_peric
> PERIC_EQOS_TOP_IPCLKPORT_CLK_PTP_REF_I>,
> > +                     <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_ACLK_I>,
> > +                     <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_HCLK_I>,
> > +                     <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_RGMII_CLK_=
I>,
> > +                     <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_CLK_RX_I>,
> > +                     <&clock_peric PERIC_BUS_D_PERIC_IPCLKPORT_EQOSCLK=
>,
> > +                     <&clock_peric PERIC_BUS_P_PERIC_IPCLKPORT_EQOSCLK=
>,
> > +                     <&clock_peric PERIC_EQOS_PHYRXCLK_MUX>,
> > +                     <&clock_peric PERIC_EQOS_PHYRXCLK>,
> > +                     <&clock_peric PERIC_DOUT_RGMII_CLK>;
> > +            clock-names =3D =22ptp_ref=22, =22master_bus=22, =22slave_=
bus=22,=22tx=22,
> > +                          =22rx=22, =22master2_bus=22, =22slave2_bus=
=22, =22eqos_rxclk_mux=22,
> > +                          =22eqos_phyrxclk=22,=22dout_peric_rgmii_clk=
=22;
> > +            pinctrl-names =3D =22default=22;
> > +            pinctrl-0 =3D <&eth1_tx_clk>, <&eth1_tx_data>, <&eth1_tx_c=
trl>,
> > +                        <&eth1_phy_intr>, <&eth1_rx_clk>, <&eth1_rx_da=
ta>,
> > +                        <&eth1_rx_ctrl>, <&eth1_mdio>;
> > +            iommus =3D <&smmu_peric 0x0 0x1>;
> > +            phy-mode =3D =22rgmii-id=22;
> > +       =7D;
>=20
> Misaligned/misindented.

Ack

>=20
> Best regards,
> Krzysztof



