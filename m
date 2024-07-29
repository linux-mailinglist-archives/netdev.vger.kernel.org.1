Return-Path: <netdev+bounces-113555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC8F93F065
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 10:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B1521C2195D
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 08:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D8DC13D8B8;
	Mon, 29 Jul 2024 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JRxF2Ww1"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F7B13CA95
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722243424; cv=none; b=Q8VM43752WyMapwKNlQk5dUbq8AfxXOej5zYaQEmMU1gJPU7+EqF0VEDkaRetwGoMaluEXrZa7kJrwJKNnDtyUZ3HMxeM+iuUiyUjiNs9ePiCb5M9PhDnFv0g7t8vJAk7dZ5wP/txGUtMmFwEnfwC4znPm0OQwEC5bzS2JhgJNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722243424; c=relaxed/simple;
	bh=KeM4c07VojYtCdZczysyYfuZpF3y8mYfOdd+YnFoDww=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Cat3jWmEpPqKzThxJBxf1iq0HzqWHqPQf5ML+3xKFowpV27AuPb5lYq7nIZm5yh1z1g/4tM9CeKHxiRq2Zl+MepmBfqPwCA5iILs4KAcgLbFI+Ncx2STmkSlFETVaCK8pgq178D1wFTJjdFaPewS2GlxeeDNBIA3lYx2Omjow1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=JRxF2Ww1; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240729085657epoutp018185daa4d24029006352d3abc7954548~mo0NnyzTo1135611356epoutp01c
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 08:56:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240729085657epoutp018185daa4d24029006352d3abc7954548~mo0NnyzTo1135611356epoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722243417;
	bh=zwhFL/gFFCFxNmLG6KqLHIpMvmHthZPS+iq4mspQerE=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=JRxF2Ww1ruIj0eDPVvkIIOWAFi2qunK+kkjnzw+SwywFQ7o64KahYjfG9nERI6y3v
	 ahWMVV/wuckQ8owT1b3U9iXXhxCQxxJ14+XfH5VZAlonLSe9I95npTWWmeJWlUgu+X
	 Zkv+XmuqEWrMScb/3TsfaBnmCJ2yS8QkB3bKU5rY=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240729085656epcas5p261330f99ada0d207dc2881afc16858ab~mo0M_C3m51791617916epcas5p2U;
	Mon, 29 Jul 2024 08:56:56 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4WXXKf2cZ7z4x9Q1; Mon, 29 Jul
	2024 08:56:54 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	19.DC.09640.65957A66; Mon, 29 Jul 2024 17:56:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240729084804epcas5p2c93a488d15753f398057711aedf40494~mosc4uBNA0809708097epcas5p2e;
	Mon, 29 Jul 2024 08:48:04 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240729084804epsmtrp2436317382069a6653acd163ab60b2192~mosc2fhqL2719827198epsmtrp2I;
	Mon, 29 Jul 2024 08:48:04 +0000 (GMT)
X-AuditID: b6c32a49-a57ff700000025a8-f6-66a759564d7d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	65.97.07567.34757A66; Mon, 29 Jul 2024 17:48:03 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20240729084800epsmtip29b1ee1110bd8de8987e49c08d4a39727~mosaBiuzY2816328163epsmtip2i;
	Mon, 29 Jul 2024 08:48:00 +0000 (GMT)
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
In-Reply-To: <22eae086-0f77-4df7-9d70-e7249d67b106@lunn.ch>
Subject: RE: [PATCH v3 1/4] dt-bindings: net: Add FSD EQoS device tree
 bindings
Date: Mon, 29 Jul 2024 14:17:59 +0530
Message-ID: <003001dae194$06218380$12648a80$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG0kE2cByMDcfrFjxkR49X5VWx9JAKGcKNgAXd78/0C+uayQwF2+vVQAedCxeOyB05I0A==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTHd3vb3sJSc4egP7roSDcmZeFRHvUWBF+M3G3GoUs084+VO3qh
	DPpYbwvTxc0tIPKwSngMutIRIkMQBCpvLErL1AmBJhYygyWCMHlYcOBMGMOt7YWN/z7ne873
	d3LOL4cD++QgPE66QkOqFUQmn+3N7LAKgkJOfFqXGt5yDcVW58oh7LGxg42NOCww1mgeZmCG
	kRwm9tPAMAubuTOFYBM1iyxMNzsJY7YOHQszPRljYZPzJ7EHPQY2VjHSx8CM600s7E71Duzl
	4DMIq2l/gWCTz28i2MDQLIzlmgeQA354W/1DBj5zqR3Bu/UOBK82aXFTQz4bfzR2k43fuPIt
	3t21wsCX+kbZuK6tAcLbbq1A+KvvqxB8xbQ7iXsqY5+MJKSkOoBUpCil6Yq0OP5Hn0gOS6JF
	4cIQoRjbyw9QEHIyjp9wJCkkMT3TNTA/IIvI1LqkJIKi+GHx+9RKrYYMkCkpTRyfVEkzVVGq
	UIqQU1pFWqiC1MQIw8Mjol2FyRkyXUkZQ9XB/WrQucw8Bz3yLoA4HIBGgdp+cQHkzfFBeyFQ
	v3wJKYC8XMEyBFYtyXTiJQTqRq8yNw3lpQdo3QwBs82J0MEsBDob/2S73Ww0GNTo+jwv+aLv
	AGNVKcNdBKM9TDCUV8x0J7zQWNBS0e7h7egxYPy9wmNmooFAX74AuZmLioGjwcqk+Q3wa+W0
	h2H0LdDpNMBuBmgAWJ35mUU3OwGeOg0sumYn+GW1CHY3BmivF3DaLRBtSACNNbYN3g7m77Yh
	NPPAyqKZTbMEXNONMmmWAcdfxRv6fnDbbvCsAkYFoLknjJZ3gbL71xl0323g4to0g9a5oMu4
	yW+D9YWxjSf9QUftEnIZ4uu3jKbfMpp+ywj6/7tVQ8wGyJ9UUfI0kopWCRVk9n//naKUmyDP
	OQR/0AU5Hj8PtUAMDmSBAAfm+3Il9tpUH66UOH2GVCslam0mSVmgaNe+i2GeX4rSdU8KjUQY
	JQ6PEolEUeJIkZC/k7uQWyX1QdMIDZlBkipSveljcLx45xjNewbTj74/0R32Y1ApqzhVULbr
	lZwaj7w7Z7xwMnl/rBZnvm5qnU0saoomI7EH+f/kLNk+thcW6hopQdC7g3vYiP9929EB05mJ
	w/eeVCfGnp8usTb734sfX9MHcr7cMVwo91tPePpDXfnnlVMp1+UR9VeOp0f0Zh06+E3810VD
	aU19gcP2D79b/Kw/NV5BHtqdrcrONj/b+/Dvlj8iwbpPTHn8IpXMmOuxtqrycu1vGo9cTHGK
	DmatCa+yMlpvVFsl0uNrt3jwBcyxkC/mcaZfIyoLl/tjfnvvi/GakpHTztvrgsUl8flteW3W
	rmOtZ09NBRKyeZPvC7lBsGI72y7shPlMSkYIg2E1RfwLgDzTdZcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsWy7bCSvK5z+PI0g0e7zS1+vpzGaPFg3jY2
	i/N3DzFbrNl7jslizvkWFov5R86xWjw99ojd4t6id6wWfS8eMltc2NbHarHp8TVWi4evwi0u
	75rDZjHj/D4mi3l/17JaHFsgZvHt9BtGi0Vbv7BbPPywh93iyJkXzBate4+wO4h6bFl5k8nj
	af9Wdo+ds+6yeyzYVOqxaVUnm8eda3vYPDYvqffYueMzk8f7fVfZPPq2rGL02LL/M6PHv6a5
	7B6fN8kF8EZx2aSk5mSWpRbp2yVwZfRNnspUsI234vTbTywNjHe4uhg5OCQETCSmTXHoYuTi
	EBLYzShxpKWJqYuREyguKfGpeSorhC0ssfLfc3aIomeMEs9aTzODJNgEtCQW9e1jB7FFBFQk
	5s2dwgRSxCxwjkWi73gHI0THWSaJxyuWgI3lFLCW2DBjKwuILSzgL7Fux1Q2EJtFQFVi1rTX
	jCA2r4ClxN1Vh1kgbEGJkzOfsICcyiygJ9G2EayEWUBeYvvbOcwQ1ylI/Hy6jBXiiDCJ52/n
	sELUiEsc/dnDPIFReBaSSbMQJs1CMmkWko4FjCyrGCVTC4pz03OTDQsM81LL9YoTc4tL89L1
	kvNzNzGCE4SWxg7Ge/P/6R1iZOJgPMQowcGsJMIbf2VpmhBvSmJlVWpRfnxRaU5q8SFGaQ4W
	JXFewxmzU4QE0hNLUrNTUwtSi2CyTBycUg1M63IPzFuj8nni9ah70hGsEknb77BNMpx3Yvun
	sAtO/y3K7/ZXh51e++KWjPCviXs3np9z74b4RlelgCMKdTuPB7s8PO5nw/QmV1xnVaX9Ucuz
	/y/zBIdZSKdlXc384dHuuuvSf+8VmmLXfd+VF21UKOc8ork+oN/c8bOR+LFVxmG8bssLp32Y
	yK08pYxpud8By5SFpSdaLjyTqVz03ivj4GPGBydfmXilWvz4NEWu8/EGsw/P1vXGrEwQf8dV
	ed6tuy9hRq7Sn+r9bM8zeK08pxxTdlWfUd/MmVgoF6ompcL96ceNd1yntgpaXexbZxYclZEY
	+Pdp7ePEttPLjrya2bZ3RWO1cvWZmJ3qUptilFiKMxINtZiLihMBQNjKBn8DAAA=
X-CMS-MailID: 20240729084804epcas5p2c93a488d15753f398057711aedf40494
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
	<000201dab7f2$1c8d4580$55a7d080$@samsung.com>
	<22eae086-0f77-4df7-9d70-e7249d67b106@lunn.ch>



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: 06 June 2024 18:56
> To: Swathi K S <swathi.ks@samsung.com>
> Cc: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org;
> conor+dt@kernel.org; richardcochran@gmail.com;
> alexandre.torgue@foss.st.com; joabreu@synopsys.com;
> mcoquelin.stm32@gmail.com; alim.akhtar@samsung.com; linux-
> fsd@tesla.com; pankaj.dubey@samsung.com; ravi.patel@samsung.com;
> netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-
> kernel@vger.kernel.org; linux-samsung-soc@vger.kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v3 1/4] dt-bindings: net: Add FSD EQoS device tree
bindings
> 
> > > > +  fsd-rx-clock-skew:
> > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > +    items:
> > > > +      - items:
> > > > +          - description: phandle to the syscon node
> > > > +          - description: offset of the control register
> > > > +    description:
> > > > +      Should be phandle/offset pair. The phandle to the syscon
node.
> > >
> > > What clock are you skew-ing here? And why?
> >
> > As per customer's requirement, we need 2ns delay in fsys block both in
> > TX and RX path.
> 
> Lots of people get RGMII delays wrong. Please look back at the mailing
list
> where there is plenty of discussion about this. I don't want to have to
repeat
> myself yet again...

Sorry for the delay.
We took time to confirm with the board designer regarding this delay.
This is not a mandatory one to have and hence we are dropping clock-skewing
here.

> 
>      Andrew

Thanks,
Swathi


