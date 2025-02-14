Return-Path: <netdev+bounces-166362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B09E1A35AB6
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 10:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6634B16AADA
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB07D22D7A3;
	Fri, 14 Feb 2025 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EM4HbyTQ"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645BA1FFC47
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739526474; cv=none; b=Zv89q6wkZQeangFnU/H9vREfylrMabAnqFXfc50YyPkLZlrLT4zpEDkV1l3JU/nhDtRuvUTaJ2XHPEoqu07bXkF0Qv8u3rYE+b7iBc0JJ9cChzRB3+WXFGezfWf5q9CAWU930St3umroTy9UU7DsyDPjCbemfAcROza8sDEdWQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739526474; c=relaxed/simple;
	bh=B204w+oW1OvxJVTTwQwlv3Wo/ImEDCQ4Ci69l8gqu4Y=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=c7FSaA6QdX2oECKMz07H1mmgnIXbRIyhxxTNfZPIGUvw365ov+oxtwXNdD+TTVPT0iKHTfdmIMzeYv3u8gxhBX6gh6gTHpGza/RzObjNHeeqea7Kn/RlAhwSIizx0ZdYubgU6b5+RaiHMJMvjclXs1T3Tsc9K2N2bpjscJpU2pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EM4HbyTQ; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250214094750epoutp04d67566f2b9f711a132ea35dbd75b9b17~kChvClw290250402504epoutp04N
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 09:47:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250214094750epoutp04d67566f2b9f711a132ea35dbd75b9b17~kChvClw290250402504epoutp04N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739526470;
	bh=1KPxF4Nw7vEPDGlJw17L3iwsGbaEnoaLPgVLab6d4Tw=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=EM4HbyTQebG6jPrmcAxo8EXhbjBA8XaOkwYHOTkghe082cT8j6FUTj2wlAWHiHW1i
	 wHtNW69MKl6/skZ4wB7EU2oekaVELPL7G7iaaKe3yxci663nrraWy0zd2AVYd/mS9f
	 V3i/4bWGHgxu8j6vnmxkTuJzuVi0cc+EiqW4CH9g=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250214094749epcas5p443bd5f798d0035f7f20f05e525014acf~kChugsb2n3165931659epcas5p4l;
	Fri, 14 Feb 2025 09:47:49 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YvS036CqHz4x9Px; Fri, 14 Feb
	2025 09:47:47 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	ED.0E.19956.3411FA76; Fri, 14 Feb 2025 18:47:47 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250214093326epcas5p4f53cf59ec2592203d8465e04fa9b6c76~kCVKt75SB2301023010epcas5p4D;
	Fri, 14 Feb 2025 09:33:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250214093326epsmtrp2761241611125c39e6b2e61523e974e61~kCVKs60lp2248822488epsmtrp2W;
	Fri, 14 Feb 2025 09:33:26 +0000 (GMT)
X-AuditID: b6c32a4b-8408b24000004df4-12-67af1143d138
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7A.19.18949.6ED0FA76; Fri, 14 Feb 2025 18:33:26 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250214093324epsmtip17a62cf7e37c2409e00b59e359fb6b124~kCVIKWFhd2759327593epsmtip1T;
	Fri, 14 Feb 2025 09:33:23 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc: <krzk+dt@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh@kernel.org>, <conor+dt@kernel.org>, <richardcochran@gmail.com>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
	<rmk+kernel@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"'Pankaj Dubey'" <pankaj.dubey@samsung.com>
In-Reply-To: <7d50f55d-d0cd-4741-ab55-2f54dc45d6ab@kernel.org>
Subject: RE: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device tree
 bindings
Date: Fri, 14 Feb 2025 15:03:15 +0530
Message-ID: <00ce01db7ec3$7f9ab750$7ed025f0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFMfZy5LnHh86L+CikZ+hKlrx3PbgHP/Q5uAh59lGQBgzSo3AGBIR3uAawmoOABkF4oKQJdFV+JtAAkiQA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xbZRjO6Tk9bYfg4TL4YNmsZzoFgbVSutMFmLvEncgSu7Co0R/sSI8t
	Am3tab2ghombhstgLGNIV0vBAgHGIB1gy1Y27hsjdBepbBm7QBEQgQnKBEO0pUX597yX533e
	5/vycuGgp2gEN12ppTVKKhNHNyFt3ZEvxewPbJILhlYExPL0WYiofWRlE+ftQyzC4DiOEBU9
	Q2xiom+MQ0zrH6CEw9HMIW62FbEJy7iTTdxpN6BEvtPFJoyrjWyizxRKLN34DSKqWv/gED2D
	UzBxu7iERfxz2cp5LZi847wFky11d1nkRHErh7TpRzmkyaIjLfV5KHnRnEParIsscr5jGCWL
	WuohsrNDSC5atkmfeTcjQUFTMlrDp5VpKlm6Up6IJ6ek7k+NFwuEMUIJsQvnK6ksOhE/cEga
	83p6ptshzv+YytS5U1KKYfCdSQkalU5L8xUqRpuI02pZplqkjmWoLEanlMcqae1uoUDwary7
	8WiGouf3e4h65eVPyytz4WPQBD8f4nEBJgIF9ztY+dAmbhB2CQKXy1wcb7AAAetTJ9sbLEHA
	fNLMWacYq2Z8BTsEWmvv+yhTEHCVmdieLhSLAlVFHWuMECwGXBypXWuCsWIE/DJ1AvUUeFgS
	aLllcmMuNxg7DL7pDfCkEexFMN2aC3uwPyYBpgsLqBcHguvlLsSDYewVUFM5A3s34oPliRq2
	V+t98NdAPeTtCQO9y4WwRxdg53jg3lc/s72EA6DR7nHtwcHg1/4Wn7UIsDhnR704FTQUDSNe
	rACjKyW+/B5w9ScD4tkZxiJBU/tOb3orKB24wPLqBoCTf7t84/2B1biOt4PVGadvZDhoq57n
	nIJw/QZr+g3W9Bss6P9XM0FIPRROq5ksOc3Eq+OU9Cf//XiaKssCrV1AVLIVGnv0JLYLYnGh
	LghwYTzEH5w9Lw/yl1GfZdMaVapGl0kzXVC8+71L4IjNaSr3CSm1qUKRRCASi8UiSZxYiIf5
	f207Lg/C5JSWzqBpNa1Z57G4vIhjrIa7l75/tiln5s3VJqhz8ofJ6oQjZXXvOTHDeKPNdlig
	MIZcCez7InSvfTEgbPBahXjxgzMFBTtOxwVHN8tz81wL0bndGWk1IuHtI1+aHUzFsmXWsDmv
	c370x2wir7RaGNc8Uji8VHiUuTYpReNlS7xIB/HGw849/CV6Tir9lsUbmTVHnppP2qF8sNXY
	HT09+NwV+fho6OPndQfBR9ld0X7tOY3a634NWE3dd09uyPbGHZwtuhowYp47h+3uTx89HRZU
	F5D8wpnPK/tTZrYYwrdtf4eq+/DExEPrYz94S+lbb48F8mzRrt6kmypJ9ord4NhXLykfTomo
	GPiz95BxEInZhSOMghJGwRqG+hem42BbigQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWy7bCSnO4z3vXpBp8+q1v8fDmN0WL5gx2s
	Fmv2nmOymHO+hcVi/pFzrBZPjz1it3g56x6bxfnzG9gtLmzrY7XY9Pgaq8XlXXPYLLquPWG1
	mPd3LavFsQViFt9Ov2G0WLT1C7vFkTMvmC0u9U9ksvi/Zwe7g7DH5WsXmT22rLzJ5PG0fyu7
	x85Zd9k9Fmwq9di0qpPNY/OSeo+dOz4zebzfd5XNo2/LKkaPg/sMPT5vkgvgieKySUnNySxL
	LdK3S+DKWNB/kLWgSaOibU9qA+NL+S5GTg4JAROJeYtes3YxcnEICexmlLjX8ooRIiEp8al5
	KiuELSyx8t9zdoiiZ4wS09p2gBWxCWhJLOrbxw5iiwjoSmy+sRysiFlgMYvE1EOdTBAda5kl
	3r5fCjaKU8BOYsvFBWwgtrCAv8T73pNg3SwCqhIvtzYxg9i8ApYSC9Z9YoOwBSVOznzCAmIz
	C2hLPL35FM5etvA1M8R5ChI/ny5jhbgiSeLHqVWMEDXiEkd/9jBPYBSehWTULCSjZiEZNQtJ
	ywJGllWMkqkFxbnpucWGBUZ5qeV6xYm5xaV56XrJ+bmbGMFpQEtrB+OeVR/0DjEycTAeYpTg
	YFYS4ZWYtiZdiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+3170pQgLpiSWp2ampBalFMFkmDk6p
	BqaQG7MqSmuPzRTymaTWeH6Lw8zgy1qW9XHNqbsOBu6YsunysURrK9/NAge8Q9IE9RclH/hr
	X/BXgXtCzp8sT5ckrTOnr9hE//z1IIa//SSr6J0umesafjw7Szh0vwqaPb4keX3T7AoR7wgO
	dllntUTJtytemVnJHg5IvP0iJ+PQ06Mc/02u39gjmPy3PULIwehgmOrPu+Iva89Ov7lluZbK
	m66pAis3/ToUYV//dmeuucOr00kpe+zmP9CQjL3aMntmxerKe46rJ5i81Ln491H8N1aVvfLe
	k/7bZO7k7OJZZevmfumw9v58rf75rbVeH/qYavcZmTCes9t/8z9fQatb0TXJY4ffCqleuCL9
	PUuJpTgj0VCLuag4EQCpME5UcgMAAA==
X-CMS-MailID: 20250214093326epcas5p4f53cf59ec2592203d8465e04fa9b6c76
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
	<009a01db7e07$132feb60$398fc220$@samsung.com>
	<27b0f5c5-ae51-4192-8847-20e471c55be7@kernel.org>
	<00ad01db7e9c$76c288a0$644799e0$@samsung.com>
	<7d50f55d-d0cd-4741-ab55-2f54dc45d6ab@kernel.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 14 February 2025 13:02
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
> On 14/02/2025 05:53, Swathi K S wrote:
> >
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski <krzk=40kernel.org>
> >> Sent: 13 February 2025 17:31
> >> To: Swathi K S <swathi.ks=40samsung.com>
> >> Cc: krzk+dt=40kernel.org; andrew+netdev=40lunn.ch;
> davem=40davemloft.net;
> >> edumazet=40google.com; kuba=40kernel.org; pabeni=40redhat.com;
> >> robh=40kernel.org; conor+dt=40kernel.org; richardcochran=40gmail.com;
> >> mcoquelin.stm32=40gmail.com; alexandre.torgue=40foss.st.com;
> >> rmk+kernel=40armlinux.org.uk; netdev=40vger.kernel.org;
> >> devicetree=40vger.kernel.org; linux-stm32=40st-md-
> mailman.stormreply.com;
> >> linux-arm-kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org
> >> Subject: Re: =5BPATCH v6 1/2=5D dt-bindings: net: Add FSD EQoS device
> >> tree bindings
> >>
> >> On 13/02/2025 12:04, Swathi K S wrote:
> >>>
> >>>
> >>>> -----Original Message-----
> >>>> From: Krzysztof Kozlowski <krzk=40kernel.org>
> >>>> Sent: 13 February 2025 13:24
> >>>> To: Swathi K S <swathi.ks=40samsung.com>
> >>>> Cc: krzk+dt=40kernel.org; andrew+netdev=40lunn.ch;
> >> davem=40davemloft.net;
> >>>> edumazet=40google.com; kuba=40kernel.org; pabeni=40redhat.com;
> >>>> robh=40kernel.org; conor+dt=40kernel.org; richardcochran=40gmail.com=
;
> >>>> mcoquelin.stm32=40gmail.com; alexandre.torgue=40foss.st.com;
> >>>> rmk+kernel=40armlinux.org.uk; netdev=40vger.kernel.org;
> >>>> devicetree=40vger.kernel.org; linux-stm32=40st-md-
> >> mailman.stormreply.com;
> >>>> linux-arm-kernel=40lists.infradead.org; linux-kernel=40vger.kernel.o=
rg
> >>>> Subject: Re: =5BPATCH v6 1/2=5D dt-bindings: net: Add FSD EQoS devic=
e
> >>>> tree bindings
> >>>>
> >>>> On Thu, Feb 13, 2025 at 10:16:23AM +0530, Swathi K S wrote:
> >>>>> +  clock-names:
> >>>>> +    minItems: 5
> >>>>> +    maxItems: 10
> >>>>> +    contains:
> >>>>> +      enum:
> >>>>> +        - ptp_ref
> >>>>> +        - master_bus
> >>>>> +        - slave_bus
> >>>>> +        - tx
> >>>>> +        - rx
> >>>>> +        - master2_bus
> >>>>> +        - slave2_bus
> >>>>> +        - eqos_rxclk_mux
> >>>>> +        - eqos_phyrxclk
> >>>>> +        - dout_peric_rgmii_clk
> >>>>
> >>>> This does not match the previous entry. It should be strictly
> >>>> ordered with
> >>>> minItems: 5.
> >>>
> >>> Hi Krzysztof,
> >>> Thanks for reviewing.
> >>> In FSD SoC, we have 2 instances of ethernet in two blocks.
> >>> One instance needs 5 clocks and the other needs 10 clocks.
> >>
> >> I understand and I do not think this is contradictory to what I asked.
> >> If it is, then why/how?
> >>
> >>>
> >>> I tried to understand this by looking at some other dt-binding files
> >>> as given below, but looks like they follow similar approach
> >>> Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> >>> Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> >>>
> >>> Could you please guide me on how to implement this?
> >>> Also, please help me understand what is meant by 'strictly ordered'
> >>
> >> Every other 99% of bindings. Just like your clocks property.
> >
> > Hi Krzysztof,
> > Thanks for your feedback.
> > I want to make sure I fully understand your comment.
> > I can see we have added clocks and clock names in the same order.
>=20
> No, you did not. You can see syntax is very different - one uses items, o=
ther
> uses contains-enum. And now test it, change the order in DTS and see if y=
ou
> see any warning.
>=20
> > Could you please help in detail what specifically needs to be modified
> regarding the ordering and minItems/maxItems usage?
> You did not try hard enough.
>=20
> Open other bindings and look how they list clocks. For example any Samsun=
g
> clock controller bindings. Or any qcom bindings.

Thanks for your insight. I tried understanding the dt-binding implementatio=
ns from Samsung/ qcom as you suggested.
I am thinking of making the following modification in clock-names:

clock-names:
     minItems: 5
     items:
         - const: ptp_ref
         - const: master_bus
         - const: slave_bus
         - const: tx
         - const: rx
         - const: master2_bus
         - const: slave2_bus
         - const: eqos_rxclk_mux
         - const: eqos_phyrxclk
         - const: dout_peric_rgmii_clk
		=20
Does this align with your feedback or do you suggest any further changes?

-Swathi

>=20
> Best regards,
> Krzysztof


