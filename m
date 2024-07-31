Return-Path: <netdev+bounces-114396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9957C942581
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 06:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B8C1F24578
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 04:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127C11B964;
	Wed, 31 Jul 2024 04:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="bN49G+0h"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A777B28684
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 04:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722400794; cv=none; b=iagyxJO1tkxfSwDfKBZ91XdsaVs1oZZvTaJCM1vgEo9IjpUc6MM+itUcXmrqRNCWkJNecDcygTiy6Dak7pENeoxy2JahHCzNsqebAXsM5sBC3nd344RkQYqLZ97kUrt4QLe6wjwdxObGlMOaz6XGWyJtAVfSoawNQw2STRxox/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722400794; c=relaxed/simple;
	bh=wHXCNxI+V7NgDGFkyjWw8SXWPpL63vx1+pbow9CEAM8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=luoiM+e61ehC+HnquRfD18siICvVFOY96kYbCRVd8SULwiSYWldvVVOKB9H57dHvjdG95Oe0ML0JT4eKSg4ZLI2KvJc5RaQq+iYw6t63wlsw3To7UmdO93+m6uY+umE6IblymdI2+7Ol1dpoM/y3b9rCFFl/IcleCs2qMzlohow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=bN49G+0h; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20240731043949epoutp018e5362bd92146f1b2b14e59aa8e026a2~nMmR_D90G0805308053epoutp01b
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 04:39:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20240731043949epoutp018e5362bd92146f1b2b14e59aa8e026a2~nMmR_D90G0805308053epoutp01b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722400789;
	bh=Dd63mNaPxtLMVJfZDMDWX7UkNnRiEbWaN0qFM5W5oFA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=bN49G+0hekrZKkMnJT1IU8xNYIB912YcGoagZAYhVIraQ0vwOPYSm9Kbwu8fRoRQD
	 k4shhq1m3npZ+Uv51xsUgkuSJoHXTTHn10gLub717goKCowP6eE0Iz+aR3F3oCp4fR
	 X+7AEIOA80dRdbeG/mEsMvMNZ4KjBhvRrIOdtCXs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20240731043949epcas5p1faccfabe036719ee6bb761783f735d66~nMmRVo8aW0659306593epcas5p1I;
	Wed, 31 Jul 2024 04:39:49 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4WYfX30Wg1z4x9Pw; Wed, 31 Jul
	2024 04:39:47 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EE.BF.09642.210C9A66; Wed, 31 Jul 2024 13:39:46 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20240731043843epcas5p3b75f1cc1f217b45a1a657c6297c70444~nMlUqtsdB1519615196epcas5p3z;
	Wed, 31 Jul 2024 04:38:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240731043843epsmtrp2cd1be8f43e24b6306309646378c586f0~nMlUpZgJ-3231332313epsmtrp2R;
	Wed, 31 Jul 2024 04:38:43 +0000 (GMT)
X-AuditID: b6c32a4b-613ff700000025aa-24-66a9c012f875
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	19.68.08456.3DFB9A66; Wed, 31 Jul 2024 13:38:43 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240731043840epsmtip16061e61716d660e324581f85ce744dab~nMlREnb7C0070600706epsmtip1j;
	Wed, 31 Jul 2024 04:38:39 +0000 (GMT)
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
In-Reply-To: <18b83c34-c0e4-466c-aaa1-fff38c507e9a@lunn.ch>
Subject: RE: [PATCH v4 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
Date: Wed, 31 Jul 2024 10:08:38 +0530
Message-ID: <00b201dae303$85f58c80$91e0a580$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQD2Gw94KDf30OIcDBeWExyH9iGvOgIzKibnAjAKSeACgQQzirOirpLQ
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHPX3dgnZeCpMDhtlcMAwyHh2PnfKYcy7sIpIwzWLEP0pHL49B
	H+lDJ8E4p4DCBAm4QQWsyHBUXquUNwUq6zYglGUDQxwbY5BtvCNIYIQh5TLlv8/55vt7nvy4
	TP4vmDs3Va6hVHJJOsFxZDX/4ePtx++pSQocaxSh9aeXAJqoaOYg27iFiWq7hhiozPY1C/3U
	N8RG09ZJDI31tDFQX38VA92vXGAjm60RQ8PN+WxkfDTKRg9nPkR32ss4qMRmZqDc0Sk2qtis
	YyOr/jW0OjAHUKVpBUNbsyaAHi51Ykg33MpGfYNPmGirsxVDlRN69rHXyaaaMQY5XWDCyDbd
	OEbqjVrSaPiWQ/5e9QXZ1rrMIBfNIxwyv8kAyF6zkJxe62KSTd3LgHx+oRwjl40H4vbFp0Wk
	UBIppRJQ8kSFNFWeHEnEfCB+RxwSGij0E4rQEUIgl8ioSOLEe3F+Uanp2yshBJ9I0rXbUpxE
	rSYCjkaoFFoNJUhRqDWRBKWUpiuDlf5qiUytlSf7yylNmDAw8HDItjEhLUU/sokpx189p79R
	yDgPcnm5wIEL8WBoy7nNsDMf7wCwYfAAzX8DWFLzEc2rAK78KssF3B3/zyPRucBxW+4CsKiw
	jkM/ngBY++Ma0x7AwX1hZb4Zs7ML7gUryot3CjDxITbMG8btiRzwcJhVEmCXnfEoaGqu37Gw
	8DfhA+Mo2848XASf/fMlRrMTvFU6xaLTvAFb5suYdP8CuD5dzaZLRcFrbZsY7XGF19cvMu29
	QXzGAV7emGDRASfgowILoNkZztxowmh2h8sLXRyaxfC3/JFdfwocf1a4q78Fe+6Wsez9M3Ef
	2NAeQMse8If++t0R98HvNqYYtM6DrRUv2BNuzo7upnSDzVcWse8Bodszmm7PaLo9I+j+r6YH
	LANwo5RqWTKlDlEGyalP//vsRIXMCHauxTemFUxOLPlbAIMLLABymYQLT3z3ShKfJ5V8lkGp
	FGKVNp1SW0DI9r4Lme77ExXb5ybXiIXBosDg0NDQYFFQqJBw5c1mlUv5eLJEQ6VRlJJSvYhj
	cB3czzMO3smyEgWPIdmnKvIvvYof7DBYPXm9T22SAZ8lR+9jAsKlqrt4ZXiq+lD46MuZVH/l
	aXNpjaUK9bRr82Dt3Jm/tB3gOntecen4PeKUKVYRK41atQy2vM97XCQcOb46JJ49CRY6o87E
	ul1LqvMMCuOcatsfPbb1/OOWgRwBS3TTIxrGhN3O+2o2s89QHbdRvBZ0cbrSVf5KMStNdShp
	OXTuZu2Dc2etMg9iRqo77eU0J3t3yTzfrQmybv45fDSMH/HN5fD4W0cMI6miCbOp3jsp820v
	IiXj8+yGBK6vwSnSOnlf8dLVjPicC2ep3sZsJ+XJw8X3ErTZiwlrzt2rfIKlTpEIfZkqteRf
	mJyrCbYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfVCMeRz3e172eVq3PLZGPxqLvYyxzZWcZn5ozMXIwzA690emOWXVo5q2
	l9ltJeNOXF5aRCTZqbVtueyel6xau9fWUtkotQzlYmKjULIiGp3ZsO0Y/feZ7+f1jy+NC4+Q
	M+nktExOniaViXl8wtQoFv10z6bftrDZsACN9hcB5NSYeMjR3YCj83XtGCpx5BLoTFM7ifrs
	TynUdc2CoaaWCgw91rlI5HBUUeiOKZ9ExmedJOoZiEb3/i3hoWJHPYZUnb0k0rgvkMiunY5G
	WgcB0tW8p9DnVzUA9QxZKaS+YyZR0+2XOPpsNVNI59SSvwSw1foujO07WkOxFnU3xWqNStZo
	yOOxVyp2sxbzMMa+qe/gsfnVBsBerw9l+z7W4Wy1bRiwY3tLKXbYKIqaEsMPT+Bkyds5ecjy
	LfwkbYebyuieukPbXIDlAJVABWgaMothWccaFeDTQqYWwMMPrgMV8Pl6nwHf/XWS9GJfqB97
	QXlFzwF8dL8f8xA8RgJ1+fWUB/sxgVBTWoh5RDgzQEJnayHhdQwAaDcP8Dx1PswyuK84xGPw
	ZSJhjenieBDBzINPjJ3jbQJmCfz/wx7Ki6fBW6d7CY8VZ4Lh/svj43BmNrz6ugT3jpsDR/v+
	Jr0bIuFli5vyavzhjdHD+DHgq56QpP6epJ6QpJ7g0ALCAGZwGYrUxFRFaMaiNC4rWCFNVSjT
	EoPj01ONYPxjJBIzsBqGghsARoMGAGlc7CeIu392m1CQIM3eycnT4+RKGadoAAE0IfYXjLw6
	kiBkEqWZXArHZXDybyxG+8zMwZInleX93FJ7bF/4SAVb4Kp++DbsfLFonu9dZWlUheuJ0NY2
	FiZpxUMO3pxlOx6/xmlfqa39QSrLDKoqvC0e8q/skgy2feCeNcZFpETaRaaNsS/XYa7VfOm1
	nHPpsbvObC6vzDyJ5q4tYKZtOKCx5PYooxe/ieGI1+9vXpz+36nwKlHViuZZQfarzoXDc5c1
	GiImL7VufhFU+eMccXSziPzHNXXr4KYTPS1HC3qTUooOfcqJ0UWsny/bYrDu+jVWT30Ua9y2
	P4UGfO/8P8gHgW2X/EqZ6AS0akpT3aZAd3ZeVtLvgY+EYab0mPbc/nL9b7vzYgNUZQ9JdOFc
	/JK6LHdRtphQJElDJbhcIf0C6Y5GCqADAAA=
X-CMS-MailID: 20240731043843epcas5p3b75f1cc1f217b45a1a657c6297c70444
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240730092902epcas5p1520f9cac624dad29f74a92ed4c559b25
References: <20240730091648.72322-1-swathi.ks@samsung.com>
	<CGME20240730092902epcas5p1520f9cac624dad29f74a92ed4c559b25@epcas5p1.samsung.com>
	<20240730091648.72322-3-swathi.ks@samsung.com>
	<18b83c34-c0e4-466c-aaa1-fff38c507e9a@lunn.ch>



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: 31 July 2024 01:44
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
> Subject: Re: [PATCH v4 2/4] net: stmmac: dwc-qos: Add FSD EQoS support
> 
> > +static int dwc_eqos_rxmux_setup(void *priv, bool external) {
> > +	int i = 0;
> > +	struct fsd_eqos_plat_data *plat = priv;
> > +	struct clk *rx1 = NULL;
> > +	struct clk *rx2 = NULL;
> > +	struct clk *rx3 = NULL;
> 
> Reverse Christmas tree please.

Thanks for review.
We will take care in next patch version after waiting for other review
comments.

> 
> > @@ -264,6 +264,7 @@ struct plat_stmmacenet_data {
> >  	void (*ptp_clk_freq_config)(struct stmmac_priv *priv);
> >  	int (*init)(struct platform_device *pdev, void *priv);
> >  	void (*exit)(struct platform_device *pdev, void *priv);
> > +	int (*rxmux_setup)(void *priv, bool external);
> >  	struct mac_device_info *(*setup)(void *priv);
> >  	int (*clks_config)(void *priv, bool enabled);
> >  	int (*crosststamp)(ktime_t *device, struct system_counterval_t
> > *system,
> 
> It would be good if one of the stmmas Maintainers looked at this. There
are
> already a lot of function pointers here, we should not be added another
one if
> one of the exiting ones could be used.
> 
>     Andrew
> 
> ---
> pw-bot: cr



