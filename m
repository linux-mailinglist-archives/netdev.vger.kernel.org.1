Return-Path: <netdev+bounces-101344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6921C8FE310
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE7B2872ED
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 09:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CEF0153BC3;
	Thu,  6 Jun 2024 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HISvKxRV"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF39153815
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 09:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717666632; cv=none; b=M5z085XCdvjJXMb6WpB58FZaWRUnC0N1Zy0jGElhXhJD7EQQLPpv2m/flv4bsTEvbULxrQYDhKp2ysF3BB1/BopZFB6OE46lLxfKWq1NmyZ4IwCfH6+HM0ejsNgHioEYmd8i85o+nV5jDeum4ambS+4baPfcTAzIXzbw8pckHkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717666632; c=relaxed/simple;
	bh=O+MUiyvfqMXUGXpBDLTC8mSwkPGD/NkJ96zc03qdd9Q=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Y68v+0YjPtb/DfobUrVVUAkIwgKhY16PumHAUxJgooloT+yZmy6c0w0P5QsRknDWUAZcCrca3Cp5sA7VGC4UJBL1BjmcpXpbUN1ZlDS5DUnwYCVinBqPh8ya60iiTdkl8tRs3HUWKEPfiNP460sBNQm0qhzZVCuL/35GcTlNq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HISvKxRV; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240606093709epoutp04ed9f5e3508bd16f5765820ce8703fc14~WYLLo0Yd_1938819388epoutp04x
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 09:37:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240606093709epoutp04ed9f5e3508bd16f5765820ce8703fc14~WYLLo0Yd_1938819388epoutp04x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717666629;
	bh=C66y7d74sMqvnozxYZ7PT5HVuq1VfwWGrWNNfLSuA+M=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=HISvKxRVOlpREA5tEOXtABGnjIkAk3xAj/Gve+sdSnGn2SAsINnapS0thKBRf1iXs
	 b+Jg9gNzj95LX/tF6nbQG2ki+sifhn7Vktws95xh0R9mIF55eStNlmkfZIHaNU1uu3
	 Xx+9zL4eiq84iAQHdcgf60PmA8dX5ystCoQrGqwk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240606093708epcas5p21b7ba74b9537b678efc255f9649a73c1~WYLK5xYG90718407184epcas5p2Q;
	Thu,  6 Jun 2024 09:37:08 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4VvzkV6ZVCz4x9Pw; Thu,  6 Jun
	2024 09:37:06 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	CC.19.19174.24381666; Thu,  6 Jun 2024 18:37:06 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240606091545epcas5p46508ba6154a77d44f87baaa106280bf2~WX4f8ykLa1383013830epcas5p40;
	Thu,  6 Jun 2024 09:15:45 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240606091545epsmtrp13cf47fc681eebdd5d6d2b0f1fb0a6d40~WX4f7yxsW2451024510epsmtrp1c;
	Thu,  6 Jun 2024 09:15:45 +0000 (GMT)
X-AuditID: b6c32a50-b33ff70000004ae6-13-66618342fa6c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	91.24.07412.14E71666; Thu,  6 Jun 2024 18:15:45 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240606091542epsmtip2660d3b9418a991229ba78a231cab2fcf~WX4dBfkW52150221502epsmtip2f;
	Thu,  6 Jun 2024 09:15:42 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>,
	<alim.akhtar@samsung.com>, <linux-fsd@tesla.com>,
	<pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
In-Reply-To: <4e745c2a-57bd-45da-8bd2-ee1cb2bab84f@lunn.ch>
Subject: RE: [PATCH v3 1/4] dt-bindings: net: Add FSD EQoS device tree
 bindings
Date: Thu, 6 Jun 2024 14:44:40 +0530
Message-ID: <000201dab7f2$1c8d4580$55a7d080$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG0kE2cByMDcfrFjxkR49X5VWx9JAKGcKNgAXd78/0C+uayQ7HDw7+g
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHd3rb3kJSc+UxzropeCFzsBXaCezUiSPIyE3Ygw3FjT/s7uiF
	IqUtfcjQRJHxntZ12RgQKMh0CyBgylNeG5VHlJc6YHERNyoQEFQYmxkj6Eovbvz3+f3O9/v7
	5XtOjgBzy8NFgmS1gdGpaRXJd+W2XPXfLY74nE6UDLZK0Op8EUC/W1r4aHTShqFLXSMcVDaa
	zUUVvSM8NNNvx9Hdqoc8ZJqbwtCNFhMPWe9N8NDU/cPo5/YyPioe7eYgy3odD/VXPo8eDy4C
	VNX8J46mljpx1Ds0h6Gcrl483JNqqr7NoWbONePUldJJnKq0GilrTQGfujPRyacaL5yirrSt
	cKhH3eN8ytRUA6imH1cA9SSrHKdWrDtjhPEp+5QMrWB0Pow6QaNIVieFkdGx8gPykFCJVCyV
	oTdIHzWdyoSRke/EiKOSVY7ApM8xWmV0tGJovZ4M2r9PpzEaGB+lRm8IIxmtQqUN1gbq6VS9
	UZ0UqGYMe6USyeshDuEnKcrW3FGg7drxWdHfF/FM8JVHIXARQCIYXugY5xYCV4Eb0QlgvX0A
	sMUfAC6vlGBs8RhAe90vDpnAafnijCvb7wJw0VyNs8UcgPkLP2Abc/lEAKwydeMb7EH4QUv5
	15wNEUa0c+FQnpm7ceBCvAk76rucInfiA2iZLeZvMNdhuH7T6hwkJGRwuHOcz/J2eK1k2unF
	CG/Y+qAMY0P4wNWZ73nssijYZ8vhsBov2Ld6xhkBEq0u8OmDpk1DJKxpGOSw7A7vDzThLIvg
	/LncTZbDWtM4l2UlnPzHzGf5LfjTWJnzKjDCHza0B7HtHfCb6/Wbe7fBs2vTm+OFsM3yjH3h
	+sLE5sgXYMvFR/iXgCzdEq10S7TSLRFK/99WCbg1QMRo9alJTEKIVipWM+n/PXmCJtUKnD8i
	IKYN1F5eD7QBjgDYABRgpIfwPb080U2ooDOOMzqNXGdUMXobCHFcuBkTeSZoHF9KbZBLg2WS
	4NDQ0GDZnlAp6SVcyClXuBFJtIFJYRgto3vm4whcRJmc4rh562m/PuNwASfdHNtGDsRZ1MMB
	q/EFFjo3NCMfnYo431Bhk6QXHQwvilsLH6P2N94y1d1czOAujU15KpS2nuwXOypm3/542Piu
	+27V2odHjibtFL30V7UhK3HZ62XCfGgkJ2r0lRMVyiF1/5rt4G0yaOnuSf/mmZhLkcf8Cu/V
	1fN6VlIHTHsyZw89Hc6/vPeOPfqoSFwenUiZfGVLAwmwPs36aaMmtofUPDdN5GnKZKKsXduX
	FSfe946wx1X/WjBeVCs8f+u1qx5HNIefKBuvneSdVWi9ydMRad8tlxjqspX2bWnoQLLf8cDf
	8r+NEt94Na2lLfZh/K64AtlHvkaSq1fS0gBMp6f/BXe7PgGaBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUzMcRzHfX/PHTc/V/SVp9w4LRxnxvdWzMPip0TGaNhy6ee0nq47UW24
	PEQPzsNk3fV08lhhnDqlOuskJF2GzBAnKaGaPGUc7m6m/177fF6f995/fBhc9J7wYaLjt/Hq
	eEWsmBIQ5pviCdMX7lJsmZn9C6KBdycAelVoppDthRVHF2qbMZRv20egovpmEnU0vKZRW3EP
	iXRddhy1mHUkMrW3ksjevQ49vJ5PoVybBUOFvy6SqME4Cn299wGg4orPNLL31dCovqkLR/tr
	6+kFI7nykqcY13G4guaqDC9ozmhK4kylGRT3vLWG4q6e3s1VVfZjXK/lMcXpyksBV36jH3CO
	PQU0128aHyZcLwiM4mOjt/PqGfM3CbZeS7cBVe245BPfz9BacMwrEzAMZGfDrGxBJhAwIrYa
	wNNlD4hM4PF3Php+2ptDutkTljg6abf0FsCuugaXRLH+sFhnoZ3sxU6ChQXHMaeEs80E1N0+
	CJwLEdsH4PE6l+TBBsDqS7Uu9mRXwkuVOZSTib/HjQ9MuJOFrBzer3lMuXkEvKt/Qzib4qwU
	pl9xReLsBHjtYz7uLucLBzrOku4OS+At637M7XjDWwPZ+BHgaRiUZPifZBiUZBh0YQREKRjN
	qzRxyrjNMpUsnt8h1SjiNEnxSunmhDgTcP2Dv18laCtySK0AY4AVQAYXewlXaCK2iIRRipRU
	Xp0QoU6K5TVWMIYhxN5CWW5elIhVKrbxMTyv4tX/thjj4aPFqivw0J19drndHBS8b4xfyqyA
	Ozn+4S3CibuSZu4USbqWmdMK6spUIZ1pU+4F/yi6rDZu+JK2vDdZFJh7PuJ9zNRHkqwhC/X2
	o3NODZWM7UR63SmfwOGjiMvnLSGTUiLXlLz7mhcW+kyfXr1io2qpXBpEhvVgh24om3ir8dy8
	/srEUO0SgePODLHv7/DJoOl2/jim7KQ61XJwvO2lMnZRxjTvTYsvtCyI9HL4rv6k/ZIi/bYs
	MDGNDBobNkve3m78qZdkFXOp99eXD4sp8ntoqaiXzaW0c45K2no/n22dJu8OiK5q+tHTmNHw
	QU8mRyYow/PWJlZZDwgan7R2C1fFtK0SE5qtCpk/rtYo/gBAgSl8fgMAAA==
X-CMS-MailID: 20240606091545epcas5p46508ba6154a77d44f87baaa106280bf2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814112605epcas5p31aca7b23e70e8d93df11414291f7ce66
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
	<CGME20230814112605epcas5p31aca7b23e70e8d93df11414291f7ce66@epcas5p3.samsung.com>
	<20230814112539.70453-2-sriranjani.p@samsung.com>
	<4e745c2a-57bd-45da-8bd2-ee1cb2bab84f@lunn.ch>

Hi Andrew, 

Sorry for the delay in response.
Starting now, I will be taking over this task.
I have gone through your comments and feedback and will be implementing them
in v4 of this patch.

> -----Original Message-----
> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: 15 August 2023 02:10
> To: Sriranjani P <sriranjani.p@samsung.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
> richardcochran@gmail.com; alexandre.torgue@foss.st.com;
> joabreu@synopsys.com; mcoquelin.stm32@gmail.com;
> alim.akhtar@samsung.com; linux-fsd@tesla.com;
> pankaj.dubey@samsung.com; swathi.ks@samsung.com;
> ravi.patel@samsung.com; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-samsung-
> soc@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v3 1/4] dt-bindings: net: Add FSD EQoS device tree
> bindings
> 
> > +  fsd-rx-clock-skew:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    items:
> > +      - items:
> > +          - description: phandle to the syscon node
> > +          - description: offset of the control register
> > +    description:
> > +      Should be phandle/offset pair. The phandle to the syscon node.
> 
> What clock are you skew-ing here? And why?

As per customer's requirement, we need 2ns delay in fsys block both in TX
and RX path.

> 
> > +    ethernet_1: ethernet@14300000 {
> > +              compatible = "tesla,dwc-qos-ethernet-4.21";
> > +              reg = <0x0 0x14300000 0x0 0x10000>;
> > +              interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>;
> > +              clocks = <&clock_peric
> PERIC_EQOS_TOP_IPCLKPORT_CLK_PTP_REF_I>,
> > +                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_ACLK_I>,
> > +                       <&clock_peric PERIC_EQOS_TOP_IPCLKPORT_HCLK_I>,
> > +                       <&clock_peric
PERIC_EQOS_TOP_IPCLKPORT_RGMII_CLK_I>,
> > +                       <&clock_peric
PERIC_EQOS_TOP_IPCLKPORT_CLK_RX_I>,
> > +                       <&clock_peric
PERIC_BUS_D_PERIC_IPCLKPORT_EQOSCLK>,
> > +                       <&clock_peric
PERIC_BUS_P_PERIC_IPCLKPORT_EQOSCLK>,
> > +                       <&clock_peric PERIC_EQOS_PHYRXCLK_MUX>,
> > +                       <&clock_peric PERIC_EQOS_PHYRXCLK>,
> > +                       <&clock_peric PERIC_DOUT_RGMII_CLK>;
> > +              clock-names = "ptp_ref",
> > +                            "master_bus",
> > +                            "slave_bus",
> > +                            "tx",
> > +                            "rx",
> > +                            "master2_bus",
> > +                            "slave2_bus",
> > +                            "eqos_rxclk_mux",
> > +                            "eqos_phyrxclk",
> > +                            "dout_peric_rgmii_clk";
> > +              pinctrl-names = "default";
> > +              pinctrl-0 = <&eth1_tx_clk>, <&eth1_tx_data>,
<&eth1_tx_ctrl>,
> > +                          <&eth1_phy_intr>, <&eth1_rx_clk>,
<&eth1_rx_data>,
> > +                          <&eth1_rx_ctrl>, <&eth1_mdio>;
> > +              fsd-rx-clock-skew = <&sysreg_peric 0x10>;
> > +              iommus = <&smmu_peric 0x0 0x1>;
> > +              phy-mode = "rgmii";
> 
> I know it is just an example, but "rgmii" is generally wrong. "rgmii-id"
is
> generally what you need. And when i do see "rgmii", it starts ringing
alarm
> bells for me, it could mean your RGMII delays are being handled wrongly.

Thanks for bringing this to our notice. Will correct this in v4 as rgmii-id.

> 
>        Andrew

Regards,
Swathi


