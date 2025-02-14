Return-Path: <netdev+bounces-166292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78748A355F9
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 05:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65A1E18927F3
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 04:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FCD18B48B;
	Fri, 14 Feb 2025 04:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OCSJZ3NG"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537B4178CC8
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 04:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739508883; cv=none; b=Ma1NivULX5FE3EEUDy2SeRax1mUuHUAeAKynCFn2XEe2QnOAQx8uqc35HfXVhRQa3rfii9vBOdKOeGQaMqU4RNlYvNLg+k9Ae9NDZ0roVWflt0QeeFifH36hp8dsmNjJcfJKcy8BsmmnIk847WrpkTybUelbh5Rl5unccxox3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739508883; c=relaxed/simple;
	bh=uPPLgQvQK/TdggX1MdEKB3Bu/5qR/0/dajFZVSJMm8U=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=CsTOib4pZXGLA4hGh1imM/GJ75Jy11yH57G75dKY+bQzdcpHLb0UYru7KNe+KoE/Cg4kk43twck9Q7Ng2cv68a7K9tgkN5MHUVtoNJdjkO1zk5wTgU0K/WxoKzYnf+XaXTRnoQ0Jk7JDXfMf7GMq7VFloFBB6wRB92rLzDrQXbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OCSJZ3NG; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250214045438epoutp04280c5d7ac9ac42beba13b1f26b38c5c1~j_hvjb5V-0111801118epoutp04-
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 04:54:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250214045438epoutp04280c5d7ac9ac42beba13b1f26b38c5c1~j_hvjb5V-0111801118epoutp04-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739508878;
	bh=GFJe4qALkeQEhys3xW/L0dietQst9PmodQmHtovFhEA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=OCSJZ3NGxdDlcKb32darMlmiZ9woTMMT0+iKvYj9+6VOgcr23M/cPHMpDXwV7R90r
	 Hj0yIWN7mJrwtZb2aCdAFsucsVLf0WfdJUylOlj7nLVHW6RE8pIIglbtzrZM9f9VOn
	 yYh275MWgLFb8JTa9dkuTKY34fit/TYk7wIISdww=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250214045438epcas5p40ed000ae5a1d8c794f122852605f60e7~j_hu587St1722717227epcas5p4t;
	Fri, 14 Feb 2025 04:54:38 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YvKTm1MtZz4x9Px; Fri, 14 Feb
	2025 04:54:36 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	43.3F.19710.C8CCEA76; Fri, 14 Feb 2025 13:54:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250214045402epcas5p3396c5963c8764122bd0ea8e6def478bd~j_hNb8N6R1547315473epcas5p3p;
	Fri, 14 Feb 2025 04:54:02 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250214045402epsmtrp17cf0464ecfc999f324a0bf7b16616463~j_hNaQEVX3205132051epsmtrp1b;
	Fri, 14 Feb 2025 04:54:02 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-19-67aecc8cc583
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2F.57.18949.96CCEA76; Fri, 14 Feb 2025 13:54:02 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250214045359epsmtip1b27101d3b6fca803c4f2c4f69c76a4e4~j_hK_pWn-1563615636epsmtip1K;
	Fri, 14 Feb 2025 04:53:59 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>
Cc: <krzk+dt@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh@kernel.org>, <conor+dt@kernel.org>, <richardcochran@gmail.com>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
	<rmk+kernel@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
In-Reply-To: <27b0f5c5-ae51-4192-8847-20e471c55be7@kernel.org>
Subject: RE: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device tree
 bindings
Date: Fri, 14 Feb 2025 10:23:49 +0530
Message-ID: <00ad01db7e9c$76c288a0$644799e0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFMfZy5LnHh86L+CikZ+hKlrx3PbgHP/Q5uAh59lGQBgzSo3AGBIR3uAawmoOC0H0U3EA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNJsWRmVeSWpSXmKPExsWy7bCmlm7PmXXpBjtOslv8fDmN0WL5gx2s
	Fmv2nmOymHO+hcVi/pFzrBZPjz1it3g56x6bxfnzG9gtLmzrY7XY9Pgaq8XlXXPYLLquPWG1
	mPd3LavFsQViFt9Ov2G0OHLmBbPFpf6JTBb/9+xgdxDyuHztIrPHlpU3mTye9m9l99g56y67
	x4JNpR6bVnWyeWxeUu+xc8dnJo/3+66yeRzcZ+jxeZNcAHdUtk1GamJKapFCal5yfkpmXrqt
	kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0F9KCmWJOaVAoYDE4mIlfTubovzSklSF
	jPziElul1IKUnAKTAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMN18+MhaclKzY0v+brYHxmkgX
	IyeHhICJxJ6Dt9lAbCGB3YwS/58ldTFyAdmfGCVmHzjLBuF8Y5RY/vgjO0xH44puZojEXkaJ
	e73voKpeMEqsOLoPbBabgJbEor59YB0iAroSm28sZwcpYhZ4wCzRM2MOC0iCU8BOYseW10Cj
	ODiEBQIl2o7ygYRZBFQlJiw+CFbCK2Apcf3JVShbUOLkzCdgNrOAtsSyhSCtIBcpSPx8uowV
	ZIyIQJjE9n86ECXiEkd/9oAdKiHQzSlxb+EjqA9cJNbMn8gGYQtLvDq+BSouJfGyvw3KjpdY
	3QexV0IgQ+LuL5h6e4kDV0DO5wBaoCmxfpc+RFhWYuqpdUwQe/kken8/YYKI80rsmAdjK0v8
	fX0NaqSkxLal79knMCrNQvLZLCSfzULywiyEbQsYWVYxSqYWFOempyabFhjmpZbD4zs5P3cT
	IzjVa7nsYLwx/5/eIUYmDsZDjBIczEoivBLT1qQL8aYkVlalFuXHF5XmpBYfYjQFBvdEZinR
	5HxgtskriTc0sTQwMTMzM7E0NjNUEudt3tmSLiSQnliSmp2aWpBaBNPHxMEp1cAU/uZfacRa
	9WT51PXLp52tv2pn5cncUau27/4kOamlve8KNfNvyl9o8dzeGNs+2+vUlHPaDtcFszuj1nwN
	YvNPPpp3P4PN4L7L6tWa753uCpQIuhUneJ+/FXno7Yzqn5P9bJa0qDYZBy14I1nkrS7XxbVa
	Y7Olwa13a99yXKw/v9y2X5A9dM+S1swqMe22yNm+P5x/tLXqtovNqA3bLVF1tyUwKFtNclnz
	ze9xrKK63hO+LJuyrdUi6si7I3ucb58LvnEtiy3xndht7YyD0tcVJa99dF8d2ad3xNBYj+Pf
	jYvNvWfnreW+rzRBper/qph3kdMT3l+ZsmJR5ovzB8JfX1c7evRLnd+FIw/4+ISVWIozEg21
	mIuKEwGklvbGfgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCIsWRmVeSWpSXmKPExsWy7bCSnG7WmXXpBl1nGS1+vpzGaLH8wQ5W
	izV7zzFZzDnfwmIx/8g5Vounxx6xW7ycdY/N4vz5DewWF7b1sVpsenyN1eLyrjlsFl3XnrBa
	zPu7ltXi2AIxi2+n3zBaHDnzgtniUv9EJov/e3awOwh5XL52kdljy8qbTB5P+7eye+ycdZfd
	Y8GmUo9NqzrZPDYvqffYueMzk8f7fVfZPA7uM/T4vEkugDuKyyYlNSezLLVI3y6BK+PplVbm
	gq8SFSe2b2ZrYGwS6WLk5JAQMJFoXNHNDGILCexmlJj4SxciLinxqXkqK4QtLLHy33P2LkYu
	oJpnjBIr359iAUmwCWhJLOrbxw5iiwjoSmy+sRysiFngC7PE7PuTmSA6zjJJLG1bxQRSxSlg
	J7Fjy2uwdcIC/hLve0+CdbMIqEpMWHwQbCqvgKXE9SdXoWxBiZMzn4DZzALaEk9vPoWzly2E
	mCMhoCDx8+kyoFM5gK4Ik9j+TweiRFzi6M8e5gmMwrOQTJqFZNIsJJNmIWlZwMiyilEytaA4
	Nz232LDAKC+1XK84Mbe4NC9dLzk/dxMjOOK1tHYw7ln1Qe8QIxMH4yFGCQ5mJRFeiWlr0oV4
	UxIrq1KL8uOLSnNSiw8xSnOwKInzfnvdmyIkkJ5YkpqdmlqQWgSTZeLglGpg0jHubrzP6WGy
	ntHTZ8qKp/c2TjFfxTVtSqJcbfiJhWqrvxzpel/Q4NJwcU149AT188EGjxbGvPqQGfcrYfrS
	wsXef5vTGhamsgiZnmKos/7kw9qTWGdZcEbq8t4lWms/zbzVrXB9YvNFw2nJUy8lVlaycO99
	f0T94intueIXNrjOlfFkO1Ll8kB16o21i96eZz3dXXYg9taMsnQ1kz4NmTjjlD8cPA/sw/i1
	uq8GGAqEH3x468JCn6vG7EYxXe3nvkuuXvTvknyZ/rSu53cmMMg7Bp+VlIpNaou97l3A1td2
	/e7OItfYrPYrfjYvbObH8a7N/up4yWy5/uTD/ku/T3x9qEmh8s7x7++TzOetUWIpzkg01GIu
	Kk4EABZLXqpnAwAA
X-CMS-MailID: 20250214045402epcas5p3396c5963c8764122bd0ea8e6def478bd
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



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 13 February 2025 17:31
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
> On 13/02/2025 12:04, Swathi K S wrote:
> >
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski <krzk=40kernel.org>
> >> Sent: 13 February 2025 13:24
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
> >> On Thu, Feb 13, 2025 at 10:16:23AM +0530, Swathi K S wrote:
> >>> +  clock-names:
> >>> +    minItems: 5
> >>> +    maxItems: 10
> >>> +    contains:
> >>> +      enum:
> >>> +        - ptp_ref
> >>> +        - master_bus
> >>> +        - slave_bus
> >>> +        - tx
> >>> +        - rx
> >>> +        - master2_bus
> >>> +        - slave2_bus
> >>> +        - eqos_rxclk_mux
> >>> +        - eqos_phyrxclk
> >>> +        - dout_peric_rgmii_clk
> >>
> >> This does not match the previous entry. It should be strictly ordered
> >> with
> >> minItems: 5.
> >
> > Hi Krzysztof,
> > Thanks for reviewing.
> > In FSD SoC, we have 2 instances of ethernet in two blocks.
> > One instance needs 5 clocks and the other needs 10 clocks.
>=20
> I understand and I do not think this is contradictory to what I asked.
> If it is, then why/how?
>=20
> >
> > I tried to understand this by looking at some other dt-binding files
> > as given below, but looks like they follow similar approach
> > Documentation/devicetree/bindings/net/stm32-dwmac.yaml
> > Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
> >
> > Could you please guide me on how to implement this?
> > Also, please help me understand what is meant by 'strictly ordered'
>=20
> Every other 99% of bindings. Just like your clocks property.

Hi Krzysztof,
Thanks for your feedback.
I want to make sure I fully understand your comment.=20
I can see we have added clocks and clock names in the same order.
Could you please help in detail what specifically needs to be modified rega=
rding the ordering and minItems/maxItems usage?

-Swathi

>=20
> Best regards,
> Krzysztof


