Return-Path: <netdev+bounces-114397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB283942585
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 06:41:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEC801C20A88
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 04:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160991BDC8;
	Wed, 31 Jul 2024 04:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="upIUvmPK"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEF92905
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 04:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722400864; cv=none; b=sznjCA0yG5XQofCVYX70aHwkUFeJl3Wa6q49zO++OHcZkrVGtWgqjE5jbO5nMWRsLRXUtuZeKAFy1T3aVlbIuwpN7xgO0uNI8aWj8d+OrNP14snIM2FBH4Ykro9cMFmNk87IwUzXK2bKlZDkI0Defk+bKqv4lQGSYUyYV/pKsQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722400864; c=relaxed/simple;
	bh=zsHKKCvI3vbY/OZw3s6miDFxzIOliWYQC0nNKGvCyw8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=ISnEh92ZD4R4sonVlvt/CkLj+K+kDLYbQvkbTnexVMCoyrxydsheWDMzCVbH4C0Pbl21OoqXFizJcwcvX3D3Q2MVXpFk4C57FZf56rXpMJZzDNkYh5Hsjx+1mIASrAIpB2Xa71pFxIAmH9ko7SyQJ9mLmfH+yXlcNtNrP9iUYj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=upIUvmPK; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240731044100epoutp029bb6ee8d1374ac271fffafa24d259aaa~nMnT5VgwN2965729657epoutp02O
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 04:41:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240731044100epoutp029bb6ee8d1374ac271fffafa24d259aaa~nMnT5VgwN2965729657epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1722400860;
	bh=xsNWFr8kV3xs1EkHFyhGWB6KglLADpNSgzeXkX6WF/8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=upIUvmPKEAAdCYnBzBjFrXpTbqgwutzokSVnOtZ38V2JExBMncZKLR8VBFGOX/UUu
	 sSqT2zwuoNp2/J4S1St4BD7PDQwFXOyG5LkMp7VaPF7y6D8I94TmaG1DEW6CcM6PBR
	 grf0pMWxPvLJbP6MYlmBFv72QHY2mjU9VWTqgPoc=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240731044059epcas5p30032b30b155676921cb07339fef9d1a8~nMnTL_oYl2956429564epcas5p3P;
	Wed, 31 Jul 2024 04:40:59 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4WYfYP5dCjz4x9Q0; Wed, 31 Jul
	2024 04:40:57 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	40.AC.19863.950C9A66; Wed, 31 Jul 2024 13:40:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240731044048epcas5p16c8d21d75a3fbceb121a5b1971c88d61~nMnI9Bgod2320023200epcas5p1_;
	Wed, 31 Jul 2024 04:40:48 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20240731044048epsmtrp2561370da01d1894867fb7317e1826b92~nMnI8A2m20138801388epsmtrp2t;
	Wed, 31 Jul 2024 04:40:48 +0000 (GMT)
X-AuditID: b6c32a50-ef5fe70000004d97-ee-66a9c059aea7
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B1.C8.08456.050C9A66; Wed, 31 Jul 2024 13:40:48 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20240731044044epsmtip166638025d041fa102bcd8a6fa4a09c37~nMnFVedAk0349203492epsmtip1W;
	Wed, 31 Jul 2024 04:40:44 +0000 (GMT)
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
In-Reply-To: <1090d2c2-196f-4635-90a0-c73ded00cead@lunn.ch>
Subject: RE: [PATCH v4 3/4] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Date: Wed, 31 Jul 2024 10:10:43 +0530
Message-ID: <00b301dae303$d065caf0$713160d0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQD2Gw94KDf30OIcDBeWExyH9iGvOgKN91N8AfSZAbcBCoUV+7OtaInw
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA02Tf1CTdRzHe7Y9ewYG9zA0vqDhblAoHLDFgO9K1A7Oey6rg7ATzGvt4IEt
	xra2YdDlIQgekkwpENrBnBPqnEg2BgIHtBbKAcrQBA7vMDDgkNkAVyQY0sZG+d/r8/l+fr0/
	3/swqMzvsSCGWKoiFVKhhE33prX9sjssMt18OYtz17YLrjw6j8BJbRsdWicsVNjUPUSBddYS
	GrzQO4TCmZsPMThu7qDA3oEGCnygt6PQar2GweE2NQqNv4+icGr+MPy1s44Oa609FFg+Oo1C
	7dpVFN7UvQKXBx8jUN/6JwbXba0InFrswqBmuB2FvbfmqHC9qx2D+kkdun87Ybo8TiFmzrZi
	RIdmAiN0xjzCaDhNJ1oaComOdgeFWOgZoRNqkwEhfu7hEjNPu6mE6ScHQjwvrscIhzE42fdI
	zh4RKcwkFSxSmiHLFEuzE9gHUwWJgtg4DjeSy4fxbJZUmEsmsJPeTY48IJY4V8JmHRNK8pyu
	ZKFSyY7eu0chy1ORLJFMqUpgk/JMiZwnj1IKc5V50uwoKal6k8vhvBHrDPwkR1Q+VInI17fk
	X+orw04gau9yxIsBcB6omTSiLmbiXQjQ1Lxejng7+QkCev++T3EbywioqrbQNzNWTs2i7odu
	BAyNaeluYw4Bi0VNG7XoeDjQq3swF2/FQ4G2voriYio+hIKvhnEXe+FvgZLlGsTF/vjHoML8
	YINp+GtgbOHkBvvgfFDU/A/dzX6g/9tpmrvOTnD9jzqqeyIWWJn5ztmX4ex1AMyNHHGHBIAb
	K2eortkAPu8FRoqLae74JDAx0OzJ9QfzfSbMzUHAYe/2qBSAK+oRT7wITKxWevz7gPleHc3V
	i4rvBj90Rrvdr4LqgWaPRF9Q8Wya4vb7gHbtJoeANduop2QgaGtcwM4hbM0LyjQvKNO8IEHz
	fzcdQjMgQaRcmZtNZsTKuZFS8vP/PjxDlmtENi4mPLkduXJtLcqCUBiIBQEMKnurj+BeYxbT
	J1NY8AWpkAkUeRJSaUFinfuupAZty5A5T06qEnB5fA4vLi6Ox4+J47IDfGyl9ZlMPFuoInNI
	Uk4qNvMoDK+gE5TUnMKj/sHSkpSYjkRjeVN1SPVt6N/gl2KweT8KFJTVLr7HVzMr64oOGfaV
	rvQXGD4KIbzK+qPkMflLs6aWqay19DtJ9sHnjeJBe29B2nxEc23fy6LV7ZbOpzlE2uyXXN07
	uyIO8QK2mcwNnNRb9pdSIsRLh0cnu/CZHz+9ePY0/c5v9y+V+Play9NSjqHWQjCeeibQXvD+
	Q+6H/nOsD04Vhq7GNy190/GkhlPRMJa/pexiZUu64bEj2ME+uaPv+tXJ2L902on9cnGi5O3+
	8zEjxxOqzolaTDbz9Ge5Efl3x/fqs1NAaCIa5tvUsyNsZzRTz49/dvRG9MHQ28YLpbyvj7Np
	SpGQG05VKIX/AtLOUgO6BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZdlhJTjfgwMo0g47/ihY/X05jtHgwbxub
	xfm7h5gt1uw9x2Qx53wLi8X8I+dYLZ4ee8RucfPATiaLI6eWMFncW/SO1eL8+Q3sFhe29bFa
	bHp8jdXi4atwi8u75rBZzDi/j8mi69oTVot5f9eyWhxbIGbx7fQbRotFW7+wW/x/vZXR4uGH
	PewWsy7sYLU4cuYFs8X/PTvYLRY9WMDqIO2xZeVNJo+n/VvZPXbOusvusWBTqcemVZ1sHpuX
	1Hvs3PGZyeP9vqtsHn1bVjF6HNxn6PH0x15mjy37PzN6/Guay+7xeZNcAF8Ul01Kak5mWWqR
	vl0CV0bXuYmMBf+5KxYf72BvYOzj6mLk5JAQMJH42faMtYuRi0NIYDejRHvPDXaIhKTEp+ap
	rBC2sMTKf8/ZIYqeMUr0Pe4EK2IT0JJY1LcPzBYRUJGYN3cKE0gRs8ArVokHp6ewQHS8YpSY
	uv0W2ChOAWuJlm/TGUFsYYEYiRkrWplAbBYBVYnr75vB4rwClhKN6/6wQdiCEidnPgEaxAE0
	VU+ibSNYCbOAvMT2t3OYIa5TkPj5dBkrSImIgJvEi6tRECXiEkd/9jBPYBSehWTQLIRBs5AM
	moWkYwEjyypGydSC4tz03GLDAqO81HK94sTc4tK8dL3k/NxNjOAko6W1g3HPqg96hxiZOBgP
	MUpwMCuJ8MZfWZomxJuSWFmVWpQfX1Sak1p8iFGag0VJnPfb694UIYH0xJLU7NTUgtQimCwT
	B6dUA1NTTXD1Nr3kuHDdPapuqte0qqtymQ45tdqt2j3D4u00kxubmdzvHWxPvxaw7/cK3o8H
	4vQstOIq8q3OT57zVLTnfkLpZP0jd8SPzkx7npCgc06x4d2F0CsyU8sm7m725D7YPX/itxct
	6sInLM21D998n/pPs8TVfPGxmPRb3+3U/xyxmCip5vrtZmTAigAhg6CAxxtfbOW2erJhT+AP
	0ZhbB/wVbU/HV505qHxqbejJ5+e05LVmTnI9o/Kw6J/6pWuOpS7dnMfM7uZZtspV17udvLtb
	NLduYm5NaMD0b0sVUjffdg5tmXSB78mS53lPnqywP8v4yNr+y/RDK7OFlj9yrvoVdCJo6yoZ
	xzOlRbOUWIozEg21mIuKEwGUnJ4LoQMAAA==
X-CMS-MailID: 20240731044048epcas5p16c8d21d75a3fbceb121a5b1971c88d61
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



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: 31 July 2024 01:46
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
> > +&ethernet_0 {
> > +	status = "okay";
> > +
> > +	fixed-link {
> > +		speed = <1000>;
> > +		full-duplex;
> > +	};
> > +};
> > +
> 
> What is the interface connected to? A switch?

Hi Andrew, 
Thanks for the quick review. AFAIK, this has been discussed earlier. I am
providing the links to the same here for quick reference. 

[1] https://lkml.org/lkml/2024/7/29/419
[2] https://lkml.org/lkml/2024/6/6/817
[3] https://lkml.org/lkml/2024/6/6/507
[4] https://lkml.org/lkml/2023/8/14/1341

Please let us know if you have any further queries on this.

> 
> 	Andrew

Regards,
Swathi


