Return-Path: <netdev+bounces-148788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1510C9E322D
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D54AF16175F
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4D215442D;
	Wed,  4 Dec 2024 03:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ruAjGe+r"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDB714885E
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733283346; cv=none; b=U9caP11Ey+fjRouzzy28ppbsbHlBPHUhevfMmt6MdTxZW3PYy1q4u/GLZ4S0SoLOBZsehP1eTxWuFHLLlnk/HL0/Cg6F9d8uXoqm+Vj+rG5hrY0RjiylGfwzR0hRvWHMgcabfiaCBmDMdkl24CiiHnEajdw+hO0kwCPokQ7KOPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733283346; c=relaxed/simple;
	bh=N3UB73B5hwzywpcfn0m0JN8yCvjZWiLC2JdITHDn5pw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=cBIJ2FVRim/JdyT5u+875utqd/9As4HxuBHsV/rv7j/+czH9M8aagNyAW9RwgIp0xyZF7wxZSN5zbQl+lAkfOJ7k7Vz0kj0rZ9elHTUCw0SVYKJIY7m+12r781y8wX0Nj04mngn60zOaGKQ2Xo6LY/Z4q5CpGmmgkK3IYwTJEmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ruAjGe+r; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241204033542epoutp0198eaddebd4efe6af12fbbc06cb2d0f04~N3AQ91rYb1805818058epoutp01E
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:35:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241204033542epoutp0198eaddebd4efe6af12fbbc06cb2d0f04~N3AQ91rYb1805818058epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733283342;
	bh=ZdBlXz+mTi1vQtAY5m0U7kJKzNTRPe00atFhsYfnhNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ruAjGe+r3huKv1jnxgtPanMULZAMAn3WjBBuoTqAbzdVJ7eXcNlufkW+NFq+ZA/3G
	 o5l1mD2sOPpFWbyC8fqtBbhi5Jct05IBJDLoCT7I6ux/uhQTO+6/6hCzLQGE0PTElZ
	 uxGQ0VII9E8Vrar4ivDev7r8B0gNbvCqEFNH5B8Y=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20241204033541epcas2p18840209eb1af6fa5fa3e3c8e162f84f0~N3AQbxxmA1941519415epcas2p1g;
	Wed,  4 Dec 2024 03:35:41 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.69]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Y337x1fzpz4x9Q9; Wed,  4 Dec
	2024 03:35:41 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	E9.2C.22094.D0ECF476; Wed,  4 Dec 2024 12:35:41 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20241204033540epcas2p342331feb6ad751fb637e4e796d64e9bb~N3APPttte3065730657epcas2p3e;
	Wed,  4 Dec 2024 03:35:40 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241204033540epsmtrp257da0ac4247c114670c69ef52cf11758~N3APOrEH02297622976epsmtrp2t;
	Wed,  4 Dec 2024 03:35:40 +0000 (GMT)
X-AuditID: b6c32a46-48c3a7000000564e-9c-674fce0d428e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	A6.81.33707.C0ECF476; Wed,  4 Dec 2024 12:35:40 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241204033540epsmtip2d038162427bf242e9039f6148073e9f3~N3APB3wwB2174821748epsmtip2B;
	Wed,  4 Dec 2024 03:35:40 +0000 (GMT)
Date: Wed, 4 Dec 2024 12:39:02 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Neal Cardwell <ncardwell@google.com>, Eric Dumazet
	<edumazet@google.com>, davem@davemloft.net, dsahern@kernel.org,
	pabeni@redhat.com, horms@kernel.org, dujeong.lee@samsung.com,
	guo88.liu@samsung.com, yiwang.cai@samsung.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, joonki.min@samsung.com,
	hajun.sung@samsung.com, d7271.choe@samsung.com, sw.ju@samsung.com, Youngmin
	Nam <youngmin.nam@samsung.com>
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
Message-ID: <Z0/O1ivIwiVVNRf0@perf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241203181839.7d0ed41c@kernel.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHJsWRmVeSWpSXmKPExsWy7bCmhS7vOf90g++POCyu7Z3IbjHnfAuL
	xbpdrUwWzxbMYLF4euwRu8XkKYwWTfsvMVs86j/BZnF19ztmiwvb+lgtLu+aw2bRcWcvi8Wx
	BWIW306/YbRoffyZ3eLj8SZ2i8UHPrE7CHpsWXmTyWPBplKPTas62Tze77vK5tG3ZRWjx+dN
	cgFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCn
	KymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyB
	ChOyM67/es9WsIWj4sGPq+wNjO/Zuhg5OSQETCQ+n1kKZHNxCAnsYJS4d+kLC4TziVHiwqvX
	7HBO8/R97DAth8+sYIRI7GSUmPVrIQtIQkjgIaPE6muaIDaLgIrEl2/HmUFsNgFdiW0n/jGC
	2CJA8ZbNM8FWMAusYJaY9/MvaxcjB4ewgLPE3zu2IDW8AsoSzzafY4KwBSVOznwCNp9TwFDi
	0MeHUEfs4ZD41SsEYbtInNrRxAJhC0u8Or4FqkZK4vO7vVB/Fks03L/FDLJXQqCFUeLU9RfM
	EAljiVnP2sGOYxbIkJje/YAR5B4JoCOO3GKBCPNJdBz+yw4R5pXoaINaqybxa8oGRghbRmL3
	4hVQEz0kbh0/wQ4JkhNMEptvVkxglJuF5JtZSJZB2DoSC3Z/YpsFtIFZQFpi+T8OCFNTYv0u
	/QWMrKsYxVILinPTU4uNCozg8Zucn7uJEZyQtdx2ME55+0HvECMTB+MhRgkOZiUR3sAl/ulC
	vCmJlVWpRfnxRaU5qcWHGE2BUTORWUo0OR+YE/JK4g1NLA1MzMwMzY1MDcyVxHnvtc5NERJI
	TyxJzU5NLUgtgulj4uCUamAyn2At3DTj6Wv/bTqrGx8ecZN7x/zUquj73JsvTP6sePm6+eTS
	B00Nbcsqz3yWipxQuJj5zf673fJP9z3Tlt3L8vXe59m7mN72PDH1dnvZp9vjdJ7Ty37/3qJO
	edfS/IUPa5r23PS9Wtjy2+e0XqPdevtVkqvWXA6ruWL1ZL7T5lTfyhl8xzaXP+KUEv7y5NRH
	udRNZjL+54sXbUz7sVhswpNVE7Yz6S0v2RDW3pCWkZbTu1bAfQljw8XSXYrsKYXn9+R/WOUy
	i/9V8KH+26bCxRKmv6vD1FttYjO0X/ws32CwYPpLm0f7u0o9/zDOCtm9Lvyg55PK6Vuco7e+
	vuf3SfoPa1dT8LIOm99M7C+6lFiKMxINtZiLihMBOmMqE1EEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpikeLIzCtJLcpLzFFi42LZdlhJXpfnnH+6wZmZ0hbX9k5kt5hzvoXF
	Yt2uViaLZwtmsFg8PfaI3WLyFEaLpv2XmC0e9Z9gs7i6+x2zxYVtfawWl3fNYbPouLOXxeLY
	AjGLb6ffMFq0Pv7MbvHxeBO7xeIDn9gdBD22rLzJ5LFgU6nHplWdbB7v911l8+jbsorR4/Mm
	uQC2KC6blNSczLLUIn27BK6MT5f2sxR8Ya2YeHU3cwPjCZYuRk4OCQETicNnVjB2MXJxCAls
	Z5T43POIGSIhI3F75WVWCFtY4n7LEVaIovuMEsue9rODJFgEVCS+fDsO1sAmoCux7cQ/RhBb
	BCjesnkmC0gDs8AqZokva48CORwcwgLOEn/v2ILU8AooSzzbfI4JYugJJomte7awQCQEJU7O
	fAJmMwtoSdz495IJpJdZQFpi+T8OkDCngKHEoY8P2ScwCsxC0jELSccshI4FjMyrGEVTC4pz
	03OTCwz1ihNzi0vz0vWS83M3MYKjSStoB+Oy9X/1DjEycTAeYpTgYFYS4Q1c4p8uxJuSWFmV
	WpQfX1Sak1p8iFGag0VJnFc5pzNFSCA9sSQ1OzW1ILUIJsvEwSnVwGTdzNgpa8iV4H7je3DN
	xian776//3VqbyvjWLDv5iIN+foGvb9SmsxXHNNeNp14ntG1K3mrkPz/d1kbf6zi2bT5aPu6
	GK+DphYrwt9+WeXh+vGbefrk2KYbzlP21PzaVNSXsE2Dp6pSN49nbnf8lN8bjXTcDLn1wmSm
	Tp//4HPx+h+cCknvZj/+f6xpiXXayYntx4IeuLN/VxLIkZ1x6lnc7rNLpz9aZXKg+4VBcPH7
	qUuFT3+TM1X8/DbV8EWS5em2TxLnX+e5fD237pPT46Wmsldfys8Uvl1e0CEjLRu5dW20xK9F
	V/9wHftr6RWyfb/ECbc3V6P9j4ifqCisvc5gsvHJsYRVxRlR9ZeXZWQpsRRnJBpqMRcVJwIA
	MXtG2xUDAAA=
X-CMS-MailID: 20241204033540epcas2p342331feb6ad751fb637e4e796d64e9bb
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----E.S4k9jnDbDNDtdsn6uvGjyrm0uEuz07ASbU.whEIUpklEOI=_cdd6b_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
	<20241203081247.1533534-1-youngmin.nam@samsung.com>
	<CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
	<CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
	<20241203181839.7d0ed41c@kernel.org>

------E.S4k9jnDbDNDtdsn6uvGjyrm0uEuz07ASbU.whEIUpklEOI=_cdd6b_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Dec 03, 2024 at 06:18:39PM -0800, Jakub Kicinski wrote:
> On Tue, 3 Dec 2024 10:34:46 -0500 Neal Cardwell wrote:
> > > I have not seen these warnings firing. Neal, have you seen this in the past ?  
> > 
> > I can't recall seeing these warnings over the past 5 years or so, and
> > (from checking our monitoring) they don't seem to be firing in our
> > fleet recently.
> 
> FWIW I see this at Meta on 5.12 kernels, but nothing since.
> Could be that one of our workloads is pinned to 5.12.
> Youngmin, what's the newest kernel you can repro this on?
> 
Hi Jakub.
Thank you for taking an interest in this issue.

We've seen this issue since 5.15 kernel.
Now, we can see this on 6.6 kernel which is the newest kernel we are running.

------E.S4k9jnDbDNDtdsn6uvGjyrm0uEuz07ASbU.whEIUpklEOI=_cdd6b_
Content-Type: text/plain; charset="utf-8"


------E.S4k9jnDbDNDtdsn6uvGjyrm0uEuz07ASbU.whEIUpklEOI=_cdd6b_--

