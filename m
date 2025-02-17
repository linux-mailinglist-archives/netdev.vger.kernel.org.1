Return-Path: <netdev+bounces-166875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51709A37AE3
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 06:27:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8BC3AD83F
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 05:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A12C183CBB;
	Mon, 17 Feb 2025 05:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CJjNIpFv"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B654214D433
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 05:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739770046; cv=none; b=jRwvXpQjXTQDwM+LjE/k1yqMr5qV6F4JlG7M813//ZMAGEIjnUKuooJMr5oPPnfV2oaikZ6PAkMgadaZnuzEnbYlzX2ay/Oik9urWlwXIpYhV4A1oCc17hTfVbzwjg8Xv9jdQCXeLkCx/+ZuI8l21JG2HfDKEzTSyfwV6mwofxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739770046; c=relaxed/simple;
	bh=YeqkrMMQC4ncoWuidGRbfrElZo/R1lzcKvBDW0F7HU8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=fLhytulWp/knRNM7GDjmeH7yhMhv+noeML9rxZwFyLdP/1wTHaChylzrQsZS8BECcLsDWgUQ/VU2b5hOdWDyZJv2dvDR86luoD+p4c/ttURBvqUEWf9nwcQ4V2NbGbq0GidSX9AT8wW9rjXyCrScPHdhc16VWqYiK+J6DjmNZME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=CJjNIpFv; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250217052716epoutp0371cb41cb86ba6fd662eb3b641bb043b6~k56FYX7jt0378103781epoutp03i
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 05:27:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250217052716epoutp0371cb41cb86ba6fd662eb3b641bb043b6~k56FYX7jt0378103781epoutp03i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739770036;
	bh=LE2NSYeZH23QXmbZS7l6O7jVWaH+Ew774CmFY8TBAv8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=CJjNIpFvP72/VqgPhxiourXjZqQltm1v38xLH2P2KaTSUrZEwyVJ7jWhleq2n/XMH
	 8mwWCTk+U/X9wIxWsaAyE955P4M8bTI84GVFNwg8WdHrOVPtvHIeSFpCZYvUqtfwwH
	 Dfyrtll03dtB1bLufZP0AMzB05qlBcOYd6sFba4k=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250217052715epcas5p15a501bbab9db0d35ea37d2646ad893fa~k56EvVsFS3093030930epcas5p1x;
	Mon, 17 Feb 2025 05:27:15 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YxB400YlCz4x9Q7; Mon, 17 Feb
	2025 05:27:12 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	90.5B.19956.FA8C2B76; Mon, 17 Feb 2025 14:27:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250217051946epcas5p2d1d096036a9f58c168b2e1405e57a0a0~k5ziON6ug1152811528epcas5p20;
	Mon, 17 Feb 2025 05:19:46 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250217051946epsmtrp2f359fc620ddf55575bd11eba5ca3889a~k5ziNP4St2094520945epsmtrp29;
	Mon, 17 Feb 2025 05:19:46 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-b4-67b2c8af79e0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	58.89.23488.1F6C2B76; Mon, 17 Feb 2025 14:19:45 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250217051943epsmtip1901341b4e923142fd69315dee582f4ba~k5zfgAmch0905409054epsmtip1f;
	Mon, 17 Feb 2025 05:19:43 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <krzk+dt@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh@kernel.org>, <conor+dt@kernel.org>, <richardcochran@gmail.com>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
	<rmk+kernel@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"'Pankaj	Dubey'" <pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>
In-Reply-To: <ffb13051-ab93-4729-8b98-20e278552673@lunn.ch>
Subject: RE: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device tree
 bindings
Date: Mon, 17 Feb 2025 10:49:33 +0530
Message-ID: <011901db80fb$8e968f60$abc3ae20$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFMfZy5LnHh86L+CikZ+hKlrx3PbgHP/Q5uAh59lGQCP3Rr5gHaDzZ5Aa7CoQO0G0SW4A==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzeubePixnmUnEcGmRNdYmyga0WvJXHWCTmKkvEuRFn5uAO7gqh
	tKW3nZubwQAyRwQhgGh56qoT5KEdYFseGwVhguEhwqIZBXkYUCcISETDXMuFjf++853vO9/v
	OycHQwUveUIsXqWjtSpKKeat49S3btvqW/OHSSExXQkiFqfOAeKXETOX6BmyoURlUzdCFPWk
	cYjStm4uMdE+yiemDHYe0VufxSVMY4Ncot9axCMyBse5RMlSFZdoL3uHWOh6CohLdfN84uFM
	I59ouzOJEnfP5iDEm0YzP9Sd7B/sQ8na8vsIOXG2jk9aDEN8ssykJ00VP/HIX43JpMU8h5DT
	zQM8Mqu2ApAtzVJyzuQd8faRhKA4moqltSJaFaOOjVcpgsXhh6L2RPkHSKS+UjmxSyxSUYl0
	sDjs4wjfvfFKR02x6BtKqXdQERTDiLeHBGnVeh0tilMzumAxrYlVamQaP4ZKZPQqhZ+K1u2W
	SiQ7/B3C6IS4G+V7NS1e3z5qEJ4ERo8M4IJBXAbNY6PcDLAOE+ANABa+TAXsYhbAgXQj4lQJ
	8AUAF1J2rTrmpwYRVtQEYOeLFj4rmgTQkkk5MQ/3gZeympd5d3wLLCnOWzageDkH9v9ZznVu
	uOCBsOqy3SHCsA34QZh+a72T5uDvwZzGIY4Tu+Jy2NY3h7LYDd6+ML7Mo/i78ObfRSg7kAgu
	TlzhslmR0DiTi7AaD3hr8QzqzIX4zy6wr/faiiEMzrz+kcPiDfBxRy2fxUI496yJx+IoeC1r
	YEUTB4de5azwH8Lf7xVxnDOj+DZYY93O0ptgfmf1Su56mPl6HGF5V2guWcWb4dKTwZUjPWH9
	5Wl+NhAb1lQzrKlmWFPB8H9aGeBUAE9awyQqaMZfs1NFH/vvtWPUiSaw/AV8ws1gdGTGzwYQ
	DNgAxFCxu6st47pC4BpLfXec1qqjtHolzdiAv+O+c1Dhxhi14w+pdFFSmVwiCwgIkMl3BkjF
	Hq6pljSFAFdQOjqBpjW0dtWHYC7CkwhlqU95ejubOb10czQ085OWXAOvN6O3bkKC7tu66cEz
	rC48XXfUQLa3HlzYk5R/7vrkKX3jo/jCLzqD7SnDP1QJ99GmYK+kY3l/HaAL7hnzv2e85d4f
	HXpYGhkYXSCvjHzOKf4t/O4OI/X1Z+HwsOLG2HD7dMfjjs/PuHlfTFV05Y7ubrR9uWT/qsEQ
	km3LeZ52XxiGFM4PX/zUnDxrtb7fZVMqko8UlMpnr4ae8CwNHN/sY35xwP1whbWi2n4VjHyQ
	GZKCydwz83SnHliOh3V4dfcIT1sr4/E3rV4bC9z233mypB87r/nn1YliZt7mLZp4a4/taPV5
	e1K0QHshJqymbb+Yw8RRUh9Uy1D/AtMvEoiLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrIIsWRmVeSWpSXmKPExsWy7bCSnO7HY5vSDa5ut7H4+XIao8XyBztY
	Lc7fPcRssWbvOSaLOedbWCzmHznHavH02CN2i5ez7rFZXNjWx2qx6fE1VovLu+awWXRde8Jq
	Me/vWlaLYwvELL6dfsNosWjrF3aLhx/2sFscOfOC2eJS/0Qmi/97drA7iHhcvnaR2WPLyptM
	Hk/7t7J77Jx1l91jwaZSj02rOtk8Ni+p99i54zOTx/t9V9k8+rasYvQ4uM/Q4/MmuQCeKC6b
	lNSczLLUIn27BK6MjSvdCg7KVDzbLdXAuES8i5GTQ0LAROLLy2tMXYxcHEICuxklfh5dyQKR
	kJT41DyVFcIWllj57zk7RNEzRomNu66CJdgEtCQW9e1jB7FFBFQk5s2dAjaJWWA/i8SUWbNZ
	IDqOM0nMvf6PEaSKU8BaYu3Se2AdwgL+Eu97T4LZLAKqEhP33AVbzStgKXHk4mdmCFtQ4uTM
	J0BxDqCpehJtG8HGMAvIS2x/O4cZ4joFiZ9Pl7FCHBEmseTDZCaIGnGJoz97mCcwCs9CMmkW
	wqRZSCbNQtKxgJFlFaNkakFxbnpusmGBYV5quV5xYm5xaV66XnJ+7iZGcCrQ0tjB+O5bk/4h
	RiYOxkOMEhzMSiK8h7o2pAvxpiRWVqUW5ccXleakFh9ilOZgURLnXWkYkS4kkJ5YkpqdmlqQ
	WgSTZeLglGpgsigsTo4J9vlom7p4JfOtmZvV73rOZ1n/m59TISOp0ee0a+jXY8lZCb7GGTe/
	FBjnuHJcm/jx35Tiiw5PZCu5f7Dkpi+tc4yrifqr+H8T76X3+87NtL425cfSgPRI1vfrv8bU
	9Z46vNndNpzP9O+P+H83T+nV9CWuvLuEJXzexxsd9rO7ip7F/zntWO4ZEWglUHdg3bG8jWcF
	3s/i6Qo257Rnd370aUOne9GFppMawnnizr3/Pm5m+HzuSEfLatnJ8xnd19+f8GmL1ZEnup0/
	Nt04fkDi5oNUK+s3nLcEWb4uLOJvqEvz2tw9fdXheu3EinnSai1Nusorsl9WTvut3J6Qs76x
	dKbJS79XJfcclFiKMxINtZiLihMB0XcB03QDAAA=
X-CMS-MailID: 20250217051946epcas5p2d1d096036a9f58c168b2e1405e57a0a0
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
	<85e0dec0-5b40-427a-9417-cae0ed2aa484@lunn.ch>
	<00b001db7e9f$ca7cfbd0$5f76f370$@samsung.com>
	<ffb13051-ab93-4729-8b98-20e278552673@lunn.ch>



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: 14 February 2025 18:40
> To: Swathi K S <swathi.ks@samsung.com>
> Cc: krzk+dt@kernel.org; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> robh@kernel.org; conor+dt@kernel.org; richardcochran@gmail.com;
> mcoquelin.stm32@gmail.com; alexandre.torgue@foss.st.com;
> rmk+kernel@armlinux.org.uk; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
'Pankaj
> Dubey' <pankaj.dubey@samsung.com>
> Subject: Re: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device tree
> bindings
> 
> On Fri, Feb 14, 2025 at 10:47:39AM +0530, Swathi K S wrote:
> >
> >
> > > -----Original Message-----
> > > From: Andrew Lunn <andrew@lunn.ch>
> > > Sent: 14 February 2025 05:50
> > > To: Swathi K S <swathi.ks@samsung.com>
> > > Cc: krzk+dt@kernel.org; andrew+netdev@lunn.ch;
> davem@davemloft.net;
> > > edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> > > robh@kernel.org; conor+dt@kernel.org; richardcochran@gmail.com;
> > > mcoquelin.stm32@gmail.com; alexandre.torgue@foss.st.com;
> > > rmk+kernel@armlinux.org.uk; netdev@vger.kernel.org;
> > > devicetree@vger.kernel.org;
> > > linux-stm32@st-md-mailman.stormreply.com;
> > > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> > > Subject: Re: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device
> > > tree bindings
> > >
> > > > +  phy-mode:
> > > > +    enum:
> > > > +      - rgmii-id
> > >
> > > phy-mode is normally a board property, in the .dts file, since the
> > > board
> > might
> > > decide to have extra long clock lines and so want 'rgmii'.
> > >
> > > The only reason i can think of putting rgmii-id here is if the MAC
> > > only supports 'rgmii-id', it is impossible to make it not add delays.
> > > If that is true, a comment would be good.
> >
> >
> > Hi Andrew,
> > Thanks for reviewing.
> > I think we already discussed this part some time back here [1] [1] :
> > https://patchwork.kernel.org/project/linux-arm-kernel/patch/2023081411
> > 2539.7
> > 0453-2-sriranjani.p@samsung.com/#25879995
> > Please do let me know if there is any other concern on this.
> 
> We partially discussed this in this thread.
> 
> As i said, what value you need here depends on the board design. The PCB
> could provide the 2ns delay, in which case, 'rgmii' would be the correct
value
> to have in the board .dts file. Hence the binding should not restrict the
value
> of phy-mode to just rgmii-id. All 4 rmgii values should be accepted.
> 
> The only reason you would force only rgmii-id is if the MAC/PHY pair
cannot
> do anything else. If that really is true, i would expect a comment in the
> binding, and the MAC driver to return -EINVAL for anything but rgmii-id.

Hi Andrew, 
What you said is right. Generally, PCB provides internal delay.
But in this case, due to customer request, the delay was added into SoC.

The following doc on rgmii says that "Devices which implement internal delay
shall be referred to as RGMII-ID. 
Devices may offer an option to operate with/without internal delay and still
remain compliant with this spec"
https://community.nxp.com/pwmxy87654/attachments/pwmxy87654/imx-processors/2
0655/1/RGMIIv2_0_final_hp.pdf

Also, the driver is in such a way that it handles all four rgmii in the same
way. 

Considering this, could you let us know what will be the right approach to
take in this case?

-Swathi

> 
> 	Andrew


