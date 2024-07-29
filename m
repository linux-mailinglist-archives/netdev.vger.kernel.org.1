Return-Path: <netdev+bounces-113556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A70A093F068
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 10:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C581C21E89
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF49213DDCC;
	Mon, 29 Jul 2024 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pstNJFHe"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4ABD13D61D
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243424; cv=none; b=oLquXtXWUnOGIL2DIzdS9/zyiC1ILuLmovWQdU8MzepatC0If2Wzh+pTYSSGp2z8E5OIO7XDggZ/+NVyfk1W31vnPC9uzeCZj/yAi2LsQ8wF2IER9wPer5EowX8hRO59Y3LCbkhdeHDujvdWazl9XZgfwWZ/JiQzjat5ViTLmMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243424; c=relaxed/simple;
	bh=MHUJy2iDGn0IiMg9T12Ezc7sB0tyL4nah/BfA0+ZEOE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=PoP9K9VH/WA8/f96ZC2WIX0OD5nZdL1odxsQY3yVMueO2g9C1BALDAM0HY06TIVT0tI53beeymhiqII7CRoYIsA9r/niKRJtT5yBwsbHA/VDq3HS4woq1D4LtRckiDDJKUNscfJvRpY9Gkd1qs7b7xPrNH10DZ1Yyw1UWlL4zGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=pstNJFHe; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240729085700epoutp04e8ccbbdb9326124f2e0205e551f484ff~mo0QR6TFO2350723507epoutp046
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 08:57:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240729085700epoutp04e8ccbbdb9326124f2e0205e551f484ff~mo0QR6TFO2350723507epoutp046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722243420;
	bh=VC6IROFUphtKIM6XYQMIGHmaE7H45qK14RvAur7APrg=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=pstNJFHeD3tykh+nc1R8cw66koM/rjWHczvm12T6VNoe3ELWH+CHslzzkv7GbEkKB
	 CdwOW3BBS7SQnT0qLkgj9319Ecmi6IMAbVEUUYPAv/Slf2+Y0H2ZX6wjk+rBEKTQU5
	 BybWZIkGDAbr6a0kfUNnWxR6ChPAlh3CYioa3YD4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240729085659epcas5p1be156ab32a8be212f76776b114ed91f2~mo0Ppgem93011830118epcas5p13;
	Mon, 29 Jul 2024 08:56:59 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4WXXKj6ZNWz4x9Pw; Mon, 29 Jul
	2024 08:56:57 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3C.A6.09743.95957A66; Mon, 29 Jul 2024 17:56:57 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20240729084934epcas5p4482029bc4c5e04d2c8fc452bc7df7cff~motw1zbYm1996719967epcas5p4j;
	Mon, 29 Jul 2024 08:49:34 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240729084934epsmtrp1573e0111a3ab1a129d915904a2debc96~motw00QNJ2502525025epsmtrp1S;
	Mon, 29 Jul 2024 08:49:34 +0000 (GMT)
X-AuditID: b6c32a4a-3b1fa7000000260f-3e-66a759590530
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	3C.D7.07567.D9757A66; Mon, 29 Jul 2024 17:49:33 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240729084930epsmtip1a0d9761abb59a6b887e0f9b9e3b0bb02~motttV1PD1109011090epsmtip1P;
	Mon, 29 Jul 2024 08:49:30 +0000 (GMT)
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
	<linux-arm-kernel@lists.infradead.org>, "'Jayati Sahu'"
	<jayati.sahu@samsung.com>, "'Siddharth Vadapalli'" <s-vadapalli@ti.com>
In-Reply-To: <14887409-4c5e-4589-b188-564df42924c8@lunn.ch>
Subject: RE: [PATCH v3 3/4] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Date: Mon, 29 Jul 2024 14:19:29 +0530
Message-ID: <003101dae194$3bd4c460$b37e4d20$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG0kE2cByMDcfrFjxkR49X5VWx9JAKuNFnTAVxbNBUCeh7WUwI1H5iOAkPhIz+yAhoacA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1ATVxh1d7ObwDTOGki5QB9xkU7BARMMuKFQW6HtTuUHM2Id7WBMyZpQ
	QpLJBuuDjhS1FdEoVShGCEhRWqwFA4Q3pZFH8UG0Cm0dYHgOLy0gLVMEpIkJLf/O933nfOee
	e+dyEN4Ftg8nUa2ndWqZisDcWZabAQFBu3eX7BdWVAWR8+M5ENlvsmCkrdeKkD80dsJknu04
	iyxo6UTJkbZBNtlyqxgm+4r+REnD2ABC3rMYUNI81I2SAxO7yAd1eRiZa2uCSdPSdZRsK3yZ
	nLv9GCKLqv5ikwPTDXb5nTGEPNHYwiYbspuRd7yoyu//gKmRs1VsqtbYy6YKzSmUuTQDo3q6
	GzCqovgoVVszC1NTTV0YZagshajKn2Yh6nl6Pptq/70apmbNr8Wu3ZMUoaRlclonoNUJGnmi
	WhFJbN8hjZKGhglFQSIJuYUQqGXJdCQRHRMb9H6iyp6fEByQqVLsrVgZwxCb3o7QaVL0tECp
	YfSRBK2Vq7RibTAjS2ZS1IpgNa0PFwmFIaF24r4k5XJGBabNxA+2D8+gadDfL52C3DgAF4Ov
	xo6jpyB3Dg+vh8DMF12u4ikEsiy1rmIOAj1fd2ArkuVyE+YcNELA0HvDVYxBYLlvjuVgYXgg
	KDI0sR3YE98ATPkXYAcJwbNRkLlQiToGbvhboGmix67mcDzwveCqKcbRZuH+oOWmBXJgLi4B
	RRlnUCdeBzouDr/Yj+Cvg+oneYjzRAIwP3IVdXp9BIbTb8NOjhdonT+NOHwB3ukGvhs9xnZ4
	ATwaPH9GOrUeYKK9ku3EPmD87JcuLAXXDF0sJ1aC3mdZrvRbQfPDPJZjDYIHgLK6Tc72qyD7
	1o8u27XgzMIw7OxzQY1pBfuBpclu10pvYLkyxT4HEcZVyYyrkhlXJTD+71YIsUohb1rLJCto
	JlQboqY/++/BEzTJZujF9wj8sAYa6J8OtkIwB7JCgIMQnlzpwyv7eVy57NBhWqeR6lJUNGOF
	Qu3XnYX48BM09v+l1ktFYolQHBYWJpZsDhMRXtzJE/lyHq6Q6ekkmtbSuhUdzHHzSYPDh/p2
	KaFt5fLJ6SXeeVXBu3Wjfr6tHVFwzOHytG/fsEbnPOEFB3wAeH384aHrccSC1VbmXbKvdHAn
	YVT36RPT7ls+vpHq93Ovx8UNn3rV7l1XH/+JXH+ee/LS5o0LniVMdalp8YBYnKN4rzWvatnG
	+BbcL/88aOrxuV9Kgu+m7nxUJ/KNSzn95ty9rU1HitPj0xf0cglfKPDPvlNUmPvPA7SstsUX
	PbqGlXnZ8Otix92ojYfi+uu31PXHHjw5NCVZz1+Et11WuHOZkPDfxNuXR2uwbwzYjoKZdkn0
	Hn+3XHV8quHao+7sS2v44m1HBrnV+W2GV2Kemo91jZsiLM18WwPBYpQyUSCiY2T/AgbAdUin
	BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7bCSnO688OVpBgdMLH6+nMZo8WDeNjaL
	83cPMVus2XuOyWLO+RYWi/lHzrFaPD32iN3iyKklTBb3Fr1jteh78ZDZ4sK2PlaLTY+vsVo8
	fBVucXnXHDaLGef3MVnM+7uW1eLYAjGLb6ffMFos2vqF3eLhhz1A7WdeMFu07j3CbrFn6gFm
	B3GPLStvMnk87d/K7rFz1l12jwWbSj02repk87hzbQ+bx+Yl9R47d3xm8ni/7yqbR9+WVYwe
	W/Z/ZvT41zSX3eP4je1MHp83yQXwRXHZpKTmZJalFunbJXBl/O/czFbQLVBx/MlH1gbGrzxd
	jJwcEgImEv83zGPrYuTiEBLYzSjx7GUvC0RCUuJT81RWCFtYYuW/5+wQRc8YJR53rWUESbAJ
	aEks6tvHDmKLCKhIzJs7hQmkiFlgNavEhv8rmCA6zjJJ/Hq8hhmkilPAWmLfqztsILawQIxE
	z/8msEksAqoSRw5vA7N5BSwlFnX2skLYghInZz4BOokDaKqeRNtGsBJmAXmJ7W/nMENcpyDx
	8+kyVogjwiSeNJ1mgqgRlzj6s4d5AqPwLCSTZiFMmoVk0iwkHQsYWVYxSqYWFOem5yYbFhjm
	pZbrFSfmFpfmpesl5+duYgSnDy2NHYz35v/TO8TIxMF4iFGCg1lJhDf+ytI0Id6UxMqq1KL8
	+KLSnNTiQ4zSHCxK4ryGM2anCAmkJ5akZqemFqQWwWSZODilGpie7WzK2WJpsrw29PyWPO8r
	ET8X77kdf7LjdtaspfXf57ZJfNTw2HprmbpvvrNd9Kxj864tjO2NK3IR445TkYg+Mu8Il8m/
	MIdJ60/LT1G1O5PIs1lUeHedNWfG2k9KTB/ddbRVT/f9WlYt/NZD4uAvM//js/2/ycxNu9F8
	xbtiYUZ+1+MPFo7KxyVfWEs83Gd2IsNmS5bb8l+vdgskljp6ezRdWe1Y+uW6a+T8L8+qw87u
	fVJ+W7DYdgH/Te77kY/WG1elHH/3sPIkT0fNDb2XZ25v79ircpojStLlnaxZavKM07EaqyME
	jVQaNnYs0PzD+u9eeZmo1lbjIw+E26784WaZGabgv1WjZL72ufdKLMUZiYZazEXFiQDsU9va
	jgMAAA==
X-CMS-MailID: 20240729084934epcas5p4482029bc4c5e04d2c8fc452bc7df7cff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230814112617epcas5p1bc094e9cf29da5dd7d1706e3f509ac28
References: <20230814112539.70453-1-sriranjani.p@samsung.com>
	<CGME20230814112617epcas5p1bc094e9cf29da5dd7d1706e3f509ac28@epcas5p1.samsung.com>
	<20230814112539.70453-4-sriranjani.p@samsung.com>
	<323e6d03-f205-4078-a722-dd67c66e7805@lunn.ch>
	<000001dab7f2$18a499a0$49edcce0$@samsung.com>
	<14887409-4c5e-4589-b188-564df42924c8@lunn.ch>



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: 06 June 2024 18:53
> To: Swathi K S <swathi.ks@samsung.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; richardcochran@gmail.com;
> alexandre.torgue@foss.st.com; joabreu@synopsys.com;
> mcoquelin.stm32@gmail.com; alim.akhtar@samsung.com; linux-
> fsd@tesla.com; pankaj.dubey@samsung.com; ravi.patel@samsung.com;
> netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org; 'Jayati Sahu' <jayati.sahu@samsung.com>;
Siddharth
> Vadapalli <s-vadapalli@ti.com>
> Subject: Re: [PATCH v3 3/4] arm64: dts: fsd: Add Ethernet support for
FSYS0
> Block of FSD SoC
> 
> > > > +&ethernet_0 {
> > > > +	status = "okay";
> > > > +
> > > > +	fixed-link {
> > > > +		speed = <1000>;
> > > > +		full-duplex;
> > > > +	};
> > > > +};
> > >
> > > A fixed link on its own is pretty unusual. Normally it is combined
> > > with an Ethernet switch. What is the link peer here?
> >
> > It is a direct connection to the Ethernet switch managed by an
> > external management unit.
> 
> Ah, interesting. This is the third example of this in about a month. Take
a look at
> the Realtek and TI work in this area.
> 
> So, i will ask the same questions i put to Realtek and TI. Does Linux know
about
> the switch in any way? Can it manage the switch, other than SNMP, HTTP
from
> user space? Does it know about the state of the ports, etc?
> 
> If you say this is just a colocated management switch, which Linux is not
> managing in any way, that is O.K. If you have Linux involved in some way,
please
> join the discussion with TI about adding a new model for semi-autonomous
> switches.

Thanks for letting us know about the ongoing discussion.
But in this case, the switch is not managed by Linux.

> 
>    Andrew

Thanks,
Swathi


