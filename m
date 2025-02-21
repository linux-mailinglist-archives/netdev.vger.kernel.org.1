Return-Path: <netdev+bounces-168756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C93A407AF
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 11:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B6407A36E0
	for <lists+netdev@lfdr.de>; Sat, 22 Feb 2025 10:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF22C209684;
	Sat, 22 Feb 2025 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ty+KarZK"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEB62080E8
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 10:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740221843; cv=none; b=IE/uVTFdCMuZ2uyDv948ZGiLuNjgy32cr9F5sGE+lf3foXbp0Y+edE62Ke5//HI675AG1IMd6dSJlewi+Y/tUAoNl9yIxBYhxX0oap+W8RCm1Vij4w8luzi2gWhdDGlC33tAUUFLgrewZeDOAbBhWycoUOSvvgGnmTGS9eJ+FGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740221843; c=relaxed/simple;
	bh=OJnn5cS0MRDvMVptc0oW4WIGYXfLMxTM9P15OxLT2iU=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=oJWmtDc3TEGrh++/I0y8XPGMofvbDJ6Ei+pKhJBEJxrSH6rsBCUEtb864P5qfxoVcaBIvsrKliJL0x1LsBuvjgpA4FhYk2m2iibGKEc+kZA8+9t2/ZkBsx1X9NAb9ugy29zfGI1VkGbdSiNWo4hNPTg6eQpkfcAqA6Va8+RQjQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ty+KarZK; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250222105713epoutp0413dd518188eaf1dc845be85da6dce52a~mgol7TmNX1535215352epoutp04Z
	for <netdev@vger.kernel.org>; Sat, 22 Feb 2025 10:57:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250222105713epoutp0413dd518188eaf1dc845be85da6dce52a~mgol7TmNX1535215352epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1740221833;
	bh=i5aDg870JR0h8YgZiOQ6UQwWW+YSdG8hHILX/AshJZA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Ty+KarZK02xDe4cZptje/kYFBVRZGjrOhB8j7R3k2lmHLhfozUvKafJpaCICLZjdo
	 sILI7vCx5EAcuaspR1bETe6GOSqvo0jJar/SrOrhcQKHpp8MgaHUhtaB6J163BDnA9
	 Keqo7q46Rmou476SIiKHhrHR+yUjiSZCyHQrJD50=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250222105711epcas5p41d3105a43475cede325a637eb79eebae~mgokhlM4v2991529915epcas5p48;
	Sat, 22 Feb 2025 10:57:11 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z0P8P3VGCz4x9Pt; Sat, 22 Feb
	2025 10:57:09 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	23.6C.19956.58DA9B76; Sat, 22 Feb 2025 19:57:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250221125625epcas5p4afd134f2b673c6d4fc837bae639a7272~mOnZBkIaO1178211782epcas5p4O;
	Fri, 21 Feb 2025 12:56:25 +0000 (GMT)
Received: from epsmgmc1p1new.samsung.com (unknown [182.195.42.40]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250221125625epsmtrp1642093dff4eb31cf9ab88e24b1e666ad~mOnZAezKy1665716657epsmtrp1e;
	Fri, 21 Feb 2025 12:56:25 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-04-67b9ad85e2ee
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmc1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	97.C5.23488.9F778B76; Fri, 21 Feb 2025 21:56:25 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250221125622epsmtip1a5aa8f5bee732437a75f9687a24a5609~mOnWNEp4Z1852718527epsmtip1H;
	Fri, 21 Feb 2025 12:56:22 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <krzk+dt@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh@kernel.org>, <conor+dt@kernel.org>, <richardcochran@gmail.com>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>, <gost.dev@samsung.com>
In-Reply-To: <Z7hoWHfMCMEABJlp@shell.armlinux.org.uk>
Subject: RE: [PATCH v7 2/2] net: stmmac: dwc-qos: Add FSD EQoS support
Date: Fri, 21 Feb 2025 18:26:15 +0530
Message-ID: <02bb01db8460$03c4d640$0b4e82c0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGZEuZRAcWsCKSMCeR5cs/NRCOZvwH8VK0qAZITr+wCOUn/kgE3KFRrAhKCh/Ozjg7NAA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA01Tf1CTZRz32bt3G+a61zHiASN3r6ceFLjlGM/KaV3IvSeZeF2WWY7JXjdk
	bLv90NkPI0M6OYFA8XQtJDAJEKTJjw2EkJDCuEGBFF0qCuP4eWAaHSDSxkbx3+f5fj+f5/P9
	PM99ORjvMSuUk6w10QatQkOyVjJrfwgPjzxR4VQJv8sJQTMjZwEq6Xfg6HKji4FsnelMdKHV
	hSN323026mt2MtCI9Q4LddVm48g+0Iuj7nobC2X2DuKoJb8RoIL5Chy1FT6Dpn8eB6io5hEb
	3Zu6xkatHcMYWrjmYL/Cp7p7f8Go6tI+BuXOqWFTTuttNlVoN1P2spMs6urFTyin4yGDmmy6
	xaKyq8sAdb1JRD20P5ew6t2ULWpaoaQNAlqbpFMma1UyMv5N+WvyaIlQFCmSohhSoFWk0jIy
	9vWEyLhkjScmKTis0Jg9pQSF0Uhu2rrFoDObaIFaZzTJSFqv1OjF+iijItVo1qqitLTpJZFQ
	+GK0h5iYor4yOcXS5260dFVa8TQwsDYTBHAgIYbnWutAJljJ4RENAGbOu3Df4S8Aj19t93em
	AXTPPWAuSRZ+L2X5Go0Aljxw+yXDAGZ0jWFeFouIgEXZTWwv5hMxMP9k6yIJI/KY8FzNEMPb
	CCCi4Vj5JPDiQCIO9g51LAqYxHqYN1HhuYjD4RJS2DDyrLfMJVbD9vODi1NgxFpYN2HDfBMJ
	4Iz7Eu7z2gNr0s/gPk4wvDFzCvP6QqIkAFaN3/ULYmHP3QmWDwfC0R+r2T4cCkdyMvxYDsuz
	b/kjq+Ht2Vw/fxts7rExvbNhRDi8Ur/JVw6D+TcrGT7fp2HW3CDDV+dCR8ESXgfnx3r9V4bA
	2m8m2V8A0rosmnVZNOuyCNb/3QoBswyE0Hpjqoo2Rus3a+kj//14ki7VDhbXICLeAe73T0W1
	AAYHtADIwUg+N9LkUPG4SsXRD2iDTm4wa2hjC4j2PHcuFhqUpPPskdYkF4mlQrFEIhFLN0tE
	ZDD3M2e6ikeoFCY6hab1tGFJx+AEhKYx3Ks3Ftie//TLt10sbs0A7mwoO1Bxw7AqQ/xncrNT
	oz6G0nZNjHbu3/EPt2hPg31t8T5ZgtJiUbSc6tvQvffbfdptZ6oWGt9Atbsf59Z3WHa889bf
	74c8FYvzy8M2zJrDL/Kk77VVHv9Jvv5Qe/fwzkMMFdI7SMnBC2GzUT1rrgdmFY/s4v9xYLRr
	vHjn9rmh2d028rROaTWXff59UOGx0rzfXj5/NmavckWGtPwoMfPoa1w2wytdl3Vnxel7/TK8
	sjNlv/hI0K/2m3Rd3CXiq9gqQbqw1SVMjNvqLrz8RPRqVXDxC2MzHfFw0tkVyTvxsSURC7An
	uA6Dgza+Zc2T6Q8/QiTTqFaIIjCDUfEvWuA4Ko8EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHec9l52gbnXTpq4bawBLJ6eziG0R2ATmBlGDJKMNGnabkZZ05
	bwlZWamYXY0aq8yk0ryuZjOd5DKhDLMs07KwvCW6tFbS7GJsK/Lbn//lx/PhoXG3D4Q3nZiS
	xvEpiiSJwJVoeCDxDbZlGJWhunYvZBs7D9CNASOJqkydGNI9zSPQlbZOEg23f6BQ3/1GDI1p
	3wlQV0MxifSDPSTqvqcToMKeIRKZS0wAXf5VTaL2Ug803TEBUJnhK4XeTzVTqO3JRxzNNhup
	dWK2u+cZzt6p6MPY4ZMGim3UvqXYUr2G1VcWCNjb5QfZRqMVYydbXgrY4juVgG1tkbFWvW+0
	cLvrmj1cUmI6x4es3eWaUDs5JVCdXprZVaMlc8GgXyFwoSGzAs72VggKgSvtxjQBWPVyGnMG
	XvDLkRLSqd1hxe9RylkaAXDgViewBwImCJYVt1B2LWbCYUlBG2kv4cxNAva29BN/sRgcrNI5
	UC7MSjh+a9KxdmciYc/IE8eaYALgGUs1XghoWsSshk1ji+y2iFkAH10cIuw2zkjhsXrHEmf8
	4F2LDnce5w9tw9dJ5w2x0JB3jnR2POFDWxF+Crhr55C0/0naOSTtnEUpICqBF6dSJyuTd8tU
	shQuQ6pWJKs1KUrp7tRkPXC8QVCgEXyaPhxiBhgNzADSuEQsCk4zKt1EexRZ2RyfGs9rkji1
	GfjQhMRTVCGTK90YpSKN28dxKo7/l2K0i3cuxu8P44cuTVANldKa3G3h1KWsTX4dVbO6qMBP
	+QWa2TcvtvO1PzWPg9/4bIn4IlwScLrI0j3Wvzbp6MwPy+VVHqbNQfXvJ1SdmfG340LuNyUw
	kctsseLy9PzIvMR6orzJNlXvYZspw4Wbs02Wa40lGR0Bh/Oihd8Dy8W5OTty4r3OpZuPt3p/
	GzVX81MXzq9+GD4g32B+Pj/06oT/vMX+36N8PIV35R8PxawfGV/Sdq8s6mqoNCIiNmLTxuaw
	Gnp0Ya96eeYB+UycKNqgOOM9Tpn6fT/vrct6tcXqtyzsinRrnzX8wrTV9LpVju00NmvqhnfO
	5ITFdMX4n6g1pHZnB5+VEOoEhSwI59WKP1u39r11AwAA
X-CMS-MailID: 20250221125625epcas5p4afd134f2b673c6d4fc837bae639a7272
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220044132epcas5p305e4ed7ed1c84f9800299c2091ea0790
References: <20250220043712.31966-1-swathi.ks@samsung.com>
	<CGME20250220044132epcas5p305e4ed7ed1c84f9800299c2091ea0790@epcas5p3.samsung.com>
	<20250220043712.31966-3-swathi.ks@samsung.com>
	<Z7cimPBdZ3W9GKmI@shell.armlinux.org.uk>
	<02b701db844c$36b7aeb0$a4270c10$@samsung.com>
	<Z7hoWHfMCMEABJlp@shell.armlinux.org.uk>



> -----Original Message-----
> From: Russell King (Oracle) <linux@armlinux.org.uk>
> Sent: 21 February 2025 17:20
> To: Swathi K S <swathi.ks@samsung.com>
> Cc: krzk+dt@kernel.org; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> robh@kernel.org; conor+dt@kernel.org; richardcochran@gmail.com;
> mcoquelin.stm32@gmail.com; alexandre.torgue@foss.st.com;
> netdev@vger.kernel.org; devicetree@vger.kernel.org; linux-stm32@st-md-
> mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; pankaj.dubey@samsung.com;
> ravi.patel@samsung.com; gost.dev@samsung.com
> Subject: Re: [PATCH v7 2/2] net: stmmac: dwc-qos: Add FSD EQoS support
> 
> On Fri, Feb 21, 2025 at 04:04:25PM +0530, Swathi K S wrote:
> >
> >
> > > -----Original Message-----
> > > From: Russell King (Oracle) <linux@armlinux.org.uk>
> > > Sent: 20 February 2025 18:10
> > > To: Swathi K S <swathi.ks@samsung.com>
> > > Cc: krzk+dt@kernel.org; andrew+netdev@lunn.ch;
> davem@davemloft.net;
> > > edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> > > robh@kernel.org; conor+dt@kernel.org; richardcochran@gmail.com;
> > > mcoquelin.stm32@gmail.com; alexandre.torgue@foss.st.com;
> > > netdev@vger.kernel.org; devicetree@vger.kernel.org;
> > > linux-stm32@st-md- mailman.stormreply.com;
> > > linux-arm-kernel@lists.infradead.org; linux- kernel@vger.kernel.org;
> > > pankaj.dubey@samsung.com; ravi.patel@samsung.com;
> > > gost.dev@samsung.com
> > > Subject: Re: [PATCH v7 2/2] net: stmmac: dwc-qos: Add FSD EQoS
> > > support
> > >
> > > On Thu, Feb 20, 2025 at 10:07:12AM +0530, Swathi K S wrote:
> > > > +static int fsd_eqos_probe(struct platform_device *pdev,
> > > > +			  struct plat_stmmacenet_data *data,
> > > > +			  struct stmmac_resources *res) {
> > > > +	struct clk *clk_rx1 = NULL;
> > > > +	struct clk *clk_rx2 = NULL;
> > > > +
> > > > +	for (int i = 0; i < data->num_clks; i++) {
> > > > +		if (strcmp(data->clks[i].id, "slave_bus") == 0)
> > > > +			data->stmmac_clk = data->clks[i].clk;
> > > > +		else if (strcmp(data->clks[i].id, "eqos_rxclk_mux")
== 0)
> > > > +			clk_rx1 = data->clks[i].clk;
> > > > +		else if (strcmp(data->clks[i].id, "eqos_phyrxclk")
== 0)
> > > > +			clk_rx2 = data->clks[i].clk;
> > > > +	}
> > > > +
> > > > +	/* Eth0 RX clock doesn't support MUX */
> > > > +	if (clk_rx1)
> > > > +		clk_set_parent(clk_rx1, clk_rx2);
> > >
> > > Isn't there support in DT for automatically setting the clock tree?
> > > See
> > > https://protect2.fireeye.com/v1/url?k=f0089f78-90ea0225-f0091437-
> > > 000babd9f1ba-cf835b8b94ccd94a&q=1&e=4ae794ec-f443-4d77-aee4-
> > > 449f53a3a1a4&u=https%3A%2F%2Fgithub.com%2Fdevicetree-org%2Fdt-
> > >
> schema%2Fblob%2Fmain%2Fdtschema%2Fschemas%2Fclock%2Fclock.yaml
> > > %23L24
> > >
> > > Also, I think a cleanup like the below (sorry, it's on top of other
> > patches I'm
> > > working on at the moment but could be rebased) would make sense.
> > >
> > > With both of these, this should mean that your changes amount to:
> > >
> > > 1. making data->probe optional
> > > 2. providing a dwc_eth_dwmac_data structure that has
> .stmmac_clk_name
> > >    filled in
> > > 3. adding your compatible to the match data with a pointer to the
> > >    above structure.
> >
> > Hi Russell,
> > Thanks for your input.
> > Will implement this in v8.
> > But I could not find your patch 'net: stmmac: clean up clock
initialisation'
> > in mailing list
> > Could you point me to that?
> > Or do you want me to integrate the below changes into my patch series
> > and post?
> >
> > Please let me know
> 
> Please have patience - I'm a volunteer here, and I included the patch in
the
> email for you. You're not the only one whom I'm addressing issues in the
> stmmac driver for. Since Sunday, I have a total of 16 new stmmac patches
> plus been debugging a regression someone has reported.

I understand your concern and thanks for improving the code.

> 
> Coincidentally, I just sent out the patch as a stand-alone patch, it
should be
> quicker to get it into net-next rather than trying to get all the other
patches
> I'd *already* had queued up in first.
> 
> https://lore.kernel.org/r/E1tlRMP-004Vt5-W1@rmk-PC.armlinux.org.uk

Will test your patch on FSD platform.

- Swathi

> 
> However, I'm expecting someone to say that dwc_eth_find_clk() should be
> moved into the stmmac platform code, and the other platforms need to be
> converted to use it... so it may be some time before we're at a stage
where
> you can proceed.
> 
> Please be patient.
> 
> --
> RMK's Patch system: https://protect2.fireeye.com/v1/url?k=9539722c-
> f442d8a5-9538f963-74fe48600034-5bc44de329219ee1&q=1&e=0bc950e5-
> 2fde-481e-bce0-
> 534d0f94352b&u=https%3A%2F%2Fwww.armlinux.org.uk%2Fdeveloper%2F
> patches%2F
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


