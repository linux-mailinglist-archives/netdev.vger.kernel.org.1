Return-Path: <netdev+bounces-114799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B798C944226
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 06:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F0F028209C
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C570613D891;
	Thu,  1 Aug 2024 04:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K7OFvuV/"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1872A132107
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 04:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722485629; cv=none; b=FGTBkmb92yIntaeu77bPOTOZwWOXZvdwyVW7uBhrNSq1SJY5DiCTnLgmgcZxOhKN7TEv5IO5FhhjDil2agfCVMhEOyaPzMmDYSbBjxk7hqJsnQe9k/yDCnO5BUp2LOTwLoK4liHd/qsjHzIRYsf3rWKp90UpoHZjNHGJX5tytP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722485629; c=relaxed/simple;
	bh=+cfTOUzv+LVlulSr6iUU5MPVrfyWiiftyxhDQGOkhNo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=k6sKFMZrJegn0xI4tOsFTR5ac+6YwskaE6PK9UlfzSR3h15R6hL45kK668AlDzjH+oidmydDc3MwLOa1h4m7se3sYt7/8BOHip+Ubz3ozTM3IMgaWjbhtao7RQJbM5WGPWFl5iqIT4FbGEp4WAYlQ8wJBgGYM/gVq3IDnTlyH5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=K7OFvuV/; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240801041345epoutp02e150fd250fdea470b8e99a5349472a63~nf4zFwNOD0858608586epoutp02R
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 04:13:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240801041345epoutp02e150fd250fdea470b8e99a5349472a63~nf4zFwNOD0858608586epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722485625;
	bh=XItVE+m8CpCnLpz6ExorA5UqxCTZmmA9PM7LAoUbK9U=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=K7OFvuV/ozhaglGkV6LhmcQdNZQdR+mDI9eOY4sLd2u3g1XamAAw+69Hin67NyHEe
	 nIMxoSMpVvaBPCzCPUXiCSOy4Dz559EPeASfYUf8EtggRQXcLDhwFiEs4Xjgt+hw06
	 BeS8j+lroKX8LOwZsrvw4zt6ewKziqvDKY/v0b00=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240801041344epcas5p39c078d961cf831b00de9830ef9c5f8c0~nf4ycwOnY2705327053epcas5p3h;
	Thu,  1 Aug 2024 04:13:44 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WZFvV51dlz4x9Q1; Thu,  1 Aug
	2024 04:13:42 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6D.F9.19863.67B0BA66; Thu,  1 Aug 2024 13:13:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240801032241epcas5p3c284ec65cdd5d6eb770b1af06747f508~nfMN_cvjA2606026060epcas5p3A;
	Thu,  1 Aug 2024 03:22:41 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240801032241epsmtrp1bc470cec1a28796352af628a1753fa65~nfMN8CFo12653726537epsmtrp1J;
	Thu,  1 Aug 2024 03:22:41 +0000 (GMT)
X-AuditID: b6c32a50-c73ff70000004d97-ed-66ab0b7642c2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	36.26.07567.18FFAA66; Thu,  1 Aug 2024 12:22:41 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240801032237epsmtip26e9eb8be422daf7609918d629cb7a981~nfMKSjxO00572505725epsmtip2-;
	Thu,  1 Aug 2024 03:22:37 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <krzk@kernel.org>, <robh@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<conor+dt@kernel.org>, <richardcochran@gmail.com>,
	<mcoquelin.stm32@gmail.com>, <alim.akhtar@samsung.com>,
	<linux-fsd@tesla.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-samsung-soc@vger.kernel.org>,
	<alexandre.torgue@foss.st.com>, <peppe.cavallaro@st.com>,
	<joabreu@synopsys.com>, <rcsekar@samsung.com>, <ssiddha@tesla.com>,
	<jayati.sahu@samsung.com>, <pankaj.dubey@samsung.com>,
	<ravi.patel@samsung.com>, <gost.dev@samsung.com>
In-Reply-To: <62872c29-0032-4ad8-b771-d57469950c75@lunn.ch>
Subject: RE: [PATCH v4 3/4] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Date: Thu, 1 Aug 2024 08:52:35 +0530
Message-ID: <011701dae3c2$10c864e0$32592ea0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQD2Gw94KDf30OIcDBeWExyH9iGvOgKN91N8AfSZAbcBCoUV+wG7NgImAhEbw32zkIHVgA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfVTTZRTHe357pzMbsPRhGeHQg5DgFgMeDIoTHPl1slpxzPCP5ho/XgK2
	tRcSzkFMEQ9LxstJwx1GRGAB5stkNAiQ9xwII0VOWCAIO/ISziNFoAFtbBT/fe597r3fe+9z
	Lp3kUUPj0FOkKkIhFadxqW7khk5//8CMZ+sSebZCX7Q8cw6g8fIGKrKMdpDQxZYBDJVZcsno
	664BCrL23KehkbZGDHX1VmForPIhBVksV2hosEFLQYbJYQqamD2EbjeVUVGppRVDmuEpCipf
	+YGCeiq2osW+PwCqNP5JQ2tzRoAmHjXTkG7QREFdN6dJaK3ZREOV4xWUqBfw+poRDLcWGml4
	o26UhlcY1LihNp+KX6vKwRtNCxhua71DxbX1tQBvb+Xj1qUWEl5/fQHgqyf0NHzB4C3ccjg1
	IpkQJxAKH0IqkSWkSJMiuW/FiaJFIaE8fiA/HIVxfaTidCKSG3NAGLg/Jc2+Eq5PhjhNbXcJ
	xUold+9rEQqZWkX4JMuUqkguIU9IkwvkQUpxulItTQqSEqp9fB7vlRB74JHU5MnlPor8qefR
	/kd67DgocdcABh2yBPDWTz1AA9zoHqxmAFtNZS7jMYDGx0UuYxHAq0OzlI2Us213XQ8tAJ7+
	Vu8ypgFc0tauR1FZAbBS20pzMJu1E5brv8QcTGINUOAXgywHM1ivwvNGM9nBnqyPYEHbGHAw
	2R7/y1f31nOZrHCoKV1zsTs0n58iO+u8BH+cLyM5O/KBy9YLFKfWB3DlYqNLaxvsXj5DcjQH
	WbMMuNbZ4hohBj7RjpCd7Alnf66nOZkDZwrzXCyCddo7rphkOPqkmOrk12HbUJndT7cL+MPL
	TXud7hfh2d5LLt0tsODpFOb0M6GpfIN94crcsKukF2yottGKAFe3aTTdptF0m0bQ/a9WAci1
	gEPIlelJhCREzg+UEp/99+USWboBrN9MgNAE6q6sBHUAjA46AKSTuGymh7km0YOZIM7MIhQy
	kUKdRig7QIh94cUkzvMSmf3opCoRXxDOE4SGhgrCg0P53G3MuVP6BA9WklhFpBKEnFBs5GF0
	Buc4pnojXxYdlWRTNn+S++nJ2KJoTXVJbCwRLTvCElK35wuu9QN9e0m/33PeV3cIw3b2nx64
	UcD23iPQRV7eZZaPn2gM+D7+nazves59/H5mRL5lXFQs6GXe9ksPTnwo2OclcMvNsWrmV+9D
	P338amLTEo9NOpYdFz964WjEwdU4dbehPe/6vG1m+45jp/ofPJgY2O85lvN3ffM37GcylGFn
	tmaRPxwTHf5L6v5y+ep0za57FZ6li7vD1qBYcVLyXp5RZPpdfcAvxnzoYHAV4+2xeV929t1S
	idXc55X5uXGwu7PvtyAGzBb9OmkbnLj0T+6NPblR1fNzt242DcE33+1J5ewO8+eSlclifgBJ
	oRT/CynIYzS8BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZdlhJXrfx/6o0gydnhC1+vpzGaPFg3jY2
	i/N3DzFbrNl7jslizvkWFov5R86xWjw99ojd4uaBnUwWR04tYbK4t+gdq8X58xvYLS5s62O1
	2PT4GqvFw1fhFpd3zWGzmHF+H5NF17UnrBbz/q5ltTi2QMzi2+k3jBaLtn5ht/j/eiujxcMP
	e9gtZl3YwWpx5MwLZov/e3awWyx6sIDVQdpjy8qbTB5P+7eye+ycdZfdY8GmUo9NqzrZPDYv
	qffYueMzk8f7fVfZPPq2rGL0OLjP0OPpj73MHlv2f2b0+Nc0l93j8ya5AL4oLpuU1JzMstQi
	fbsErozHP0+zFvwWrjj7YS5TA+MkwS5GTg4JAROJqQduMXYxcnEICexmlLh1/TgrREJS4lPz
	VChbWGLlv+fsEEXPGCV+ndvDBpJgE9CSWNS3jx3EFhFQkZg3dwoTSBGzwCtWiQenp7BAdBxn
	kpg9YS4TSBWngLXEzK0nWUBsYYEYiRkrWsHiLEDdF6ffB5vEK2Ap0TXjP5QtKHFy5hOgeg6g
	qXoSbRsZQcLMAvIS29/OYYa4TkHi59NlrBBHhEn8XbOTCaJGXOLozx7mCYzCs5BMmoUwaRaS
	SbOQdCxgZFnFKJlaUJybnptsWGCYl1quV5yYW1yal66XnJ+7iRGcZrQ0djDem/9P7xAjEwfj
	IUYJDmYlEV6hkyvThHhTEiurUovy44tKc1KLDzFKc7AoifMazpidIiSQnliSmp2aWpBaBJNl
	4uCUamByXLJgETcD14Grj5dNn5Stf64noZFtmrJ/p/CSSefe/88zXbhl+6qw87Gv3p0I+mP8
	NMFkZc6dHRKTJ3//b2X2Zs6MPVvtS28Zchzp26SSLWWpep2viTGtMqftAY/yc7//rxy4QnQ+
	HNk7c+H0hSfXCOcx/2/0m3b2aZOjnarz/5pUeTUuho1XauY8OqQio2A7X4Cb+8e0Sy2BR19u
	rxK7n3nNcEXyzObXBUHee5Jr5Mru7q2ayZOUKdS43fUjj4ZjWIPgnysKLbfeb5/n/3rRnlBe
	3U+7FxwMLlxRrXr8eoPnhh+qEpOeJT0Q1jLfu2lp/bL+LcfvWX/+kr9VtsTRY7KyoVii5DUH
	k7ct52Y3KLEUZyQaajEXFScCAHVCPkaiAwAA
X-CMS-MailID: 20240801032241epcas5p3c284ec65cdd5d6eb770b1af06747f508
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240730092907epcas5p1b81eaf13a57535e32e11709602aeee06
References: <20240730091648.72322-1-swathi.ks@samsung.com>
	<CGME20240730092907epcas5p1b81eaf13a57535e32e11709602aeee06@epcas5p1.samsung.com>
	<20240730091648.72322-4-swathi.ks@samsung.com>
	<1090d2c2-196f-4635-90a0-c73ded00cead@lunn.ch>
	<00b301dae303$d065caf0$713160d0$@samsung.com>
	<62872c29-0032-4ad8-b771-d57469950c75@lunn.ch>



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: 01 August 2024 05:48
> To: Swathi K S <swathi.ks@samsung.com>
> Cc: krzk@kernel.org; robh@kernel.org; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> conor+dt@kernel.org; richardcochran@gmail.com;
> mcoquelin.stm32@gmail.com; alim.akhtar@samsung.com; linux-
> fsd@tesla.com; netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com; linux-
> arm-kernel@lists.infradead.org; linux-samsung-soc@vger.kernel.org;
> alexandre.torgue@foss.st.com; peppe.cavallaro@st.com;
> joabreu@synopsys.com; rcsekar@samsung.com; ssiddha@tesla.com;
> jayati.sahu@samsung.com; pankaj.dubey@samsung.com;
> ravi.patel@samsung.com; gost.dev@samsung.com
> Subject: Re: [PATCH v4 3/4] arm64: dts: fsd: Add Ethernet support for
FSYS0
> Block of FSD SoC
> 
> > > What is the interface connected to? A switch?
> >
> > Hi Andrew,
> > Thanks for the quick review. AFAIK, this has been discussed earlier. I
> > am providing the links to the same here for quick reference.
> >
> > [1]
> > https://protect2.fireeye.com/v1/url?k=137f9a1c-72027264-137e1153-74fe4
> > 85fffb1-6e7bf5aa53b8cc75&q=1&e=46ff39bb-87c6-4b24-9cee-
> a6ed900a5b7f&u=
> > https%3A%2F%2Flkml.org%2Flkml%2F2024%2F7%2F29%2F419
> > [2]
> > https://protect2.fireeye.com/v1/url?k=dca2820d-bddf6a75-dca30942-74fe4
> > 85fffb1-9b7f4695da0bf0b8&q=1&e=46ff39bb-87c6-4b24-9cee-
> a6ed900a5b7f&u=
> > https%3A%2F%2Flkml.org%2Flkml%2F2024%2F6%2F6%2F817
> > [3]
> > https://protect2.fireeye.com/v1/url?k=552d5dcd-3450b5b5-552cd682-74fe4
> > 85fffb1-3bb7c6c469af30f5&q=1&e=46ff39bb-87c6-4b24-9cee-
> a6ed900a5b7f&u=
> > https%3A%2F%2Flkml.org%2Flkml%2F2024%2F6%2F6%2F507
> > [4]
> > https://protect2.fireeye.com/v1/url?k=c613c4f6-a76e2c8e-c6124fb9-74fe4
> > 85fffb1-469219b2dcdd3e0e&q=1&e=46ff39bb-87c6-4b24-9cee-
> a6ed900a5b7f&u=
> > https%3A%2F%2Flkml.org%2Flkml%2F2023%2F8%2F14%2F1341
> >
> > Please let us know if you have any further queries on this.
> 
> Ah, O.K.
> 
> It would make sense to add to the commit message something like:
> 
> The Ethernet interface is connected to a switch, which Linux is not
managing.

Thanks for the suggestion and it makes sense.  Will update the commit
message this way in the next version.

> 
> Part of the purpose of the commit message is to answer questions reviewers
> might have. This is one such question.
> 
> 	  Andrew

Regards, 
Swathi


