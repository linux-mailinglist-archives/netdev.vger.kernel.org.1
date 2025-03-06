Return-Path: <netdev+bounces-172341-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 536EDA5446B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A403AE88F
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0CB4203709;
	Thu,  6 Mar 2025 08:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="h+bG3DNl"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C551FF7CC
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 08:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248847; cv=none; b=KL7GuVL/XVv9ct1N6lz9SiU1AETo8K2vmYEFJZe2xHcf0D3+3VuPXYyXrnzN2FDNHhWJw22GM2K85nnDQOgxeN7sVAnG8rH9YVL6wMD5vpZOe8r6uToMBzpykOJZftiNHE9zfhI5PsnaNuqYuPcpBvyv3fn4N5VcAsDHLVsU7aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248847; c=relaxed/simple;
	bh=PJnzse8o4iybC7oAf5fv9vExf7AyhrbOZkSMnILPM2M=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=KM8ndrb1Z40U46W+cFSKpuFgCbu3MkAd3M/Pd+01yuIKY36XyQR53dadyNf8ec5WxgCA/Wr4Hjev+mUCl737uIiFWb2sj/lf910sKScLYXLjvEykBGnjvX9e5uekbAPFq2sSwpuDrwKALNOnxH08NCf3qB0Ko+n5tn0AN6u1YwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=h+bG3DNl; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250306081404epoutp02044d258149e287c9aa90221252e06789~qKJkg7NdC2553425534epoutp02b
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 08:14:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250306081404epoutp02044d258149e287c9aa90221252e06789~qKJkg7NdC2553425534epoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741248844;
	bh=KECuehhvu0FH3iTK1TaavUX6adMlIsZ1ueFUr/zvens=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=h+bG3DNluo93Sxva40Zkvug64EFuFBRp/Mr4o3Jd4rQ4S+G8b2PrwKYYWLf2D2Ec4
	 BvIi74ocgo/lXWjvwFOVfijXlR2/BTpMyMfNxHiGrlD3P+H1fgdQdKfrytMYHpNMO9
	 FLNUB4ftT9AwnfHpOCYCSxhI8+3YO4D9GxpA5sAU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250306081403epcas5p4bd3f9c079f1ca24762c19728e468c6d5~qKJjwUkQi2477724777epcas5p4R;
	Thu,  6 Mar 2025 08:14:03 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z7hyc6Jcgz4x9Px; Thu,  6 Mar
	2025 08:14:00 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	12.51.20052.84959C76; Thu,  6 Mar 2025 17:14:00 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250306074556epcas5p1f4f9128afb3d2d912d3679dde2a4ae21~qJxBHOgwj2664726647epcas5p1K;
	Thu,  6 Mar 2025 07:45:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250306074556epsmtrp1301b03234c11231d681ef785ab7d7ad2~qJxBGEdEd3125731257epsmtrp1F;
	Thu,  6 Mar 2025 07:45:56 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-c2-67c95948db40
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	4A.51.18949.4B259C76; Thu,  6 Mar 2025 16:45:56 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250306074553epsmtip2fcf11e3f790316369b21a1e5eb8c2f52~qJw_JvO7Q2300823008epsmtip2M;
	Thu,  6 Mar 2025 07:45:53 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <krzk+dt@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <richardcochran@gmail.com>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
Cc: <rmk+kernel@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>,
	<gost.dev@samsung.com>, <tools@linux.kernel.org>
In-Reply-To: <041d55fd-99f0-4b55-92e5-fa46f37096c1@kernel.org>
Subject: RE: [PATCH v8 0/2] net: stmmac: dwc-qos: Add FSD EQoS support
Date: Thu, 6 Mar 2025 13:15:45 +0530
Message-ID: <012801db8e6b$cb835bb0$628a1310$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQMyDtpN5Ye5e5YD1uDKr3q9BdsruAHcwqSBAgrqhY6wmXxL0A==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxj2O+f0nLZadixMPpqo7LgQIQNaLfVAABdFc3QXcQubbj9KQ09a
	Qmm7XvCyLNPodOu4DBNcbCoysgEiyB1abjLGIDhWRCiRLYAb4IBhRJ3lYpBRDm78e773e973
	eZ7vy8tHxRcJCT9Vb2FNepWOwoVY/U+hO8OZ490a6ReXZPTC1GVAF9938uiyFjdCO3rPY/S1
	DjePnuj8k6CH2lwIPWUfwene3kqCvlOfzaOrxwZ5dH+jA6dtg+M8On+pnEd3Fmyhvb/MALqw
	7h+C/mO2maA7eiZR+m5OLkIvNzsJ+lv3GO/NLUz/YB/K1F4fQpiJnDqCcdmHCaag2spUl36F
	M50DX+JMzfefMy7nU4R51OrBmezaUsD82CpjnlZvSxR9lBarZVVq1hTM6lMM6lS9Jo56633l
	fmWUQioLl0XTe6hgvSqdjaMS3k4MP5iqW0lNBWeodNaVUqLKbKYi42NNBquFDdYazJY4ijWq
	dUa5McKsSjdb9ZoIPWuJkUmlu6JWiMlp2tahMdxY5XeyruvUGWDbZAMCPiTlsN9+FbEBIV9M
	NgH4rHYE5Q5PAMyZLkJ8LDHpBXAgK/Blx+NMF8HVWwCc9BzlGiYB7OrIQ30XOBkGC7NbV0kB
	ZAsCH5xN9GGUbEagbVHmwwIyHi433lnl+JMHoed6D24DfD5Gvg5HnKtaIjIaTvY9BhzeDLuv
	jGPcmO2w4aED5fwEw4WJIh5XD4Q/L2SinOw+eG/eg/m8QbJJAOf6+hCuIQHOXS7COewPp7tq
	CQ5L4FTOhTWshDeyPRiHtXB4MXeNvxe2DTgwn0+UDIUVjZFceSvMu30T4Tz4wazn42tSIujM
	f4l3wKW/B9dGBsH6Hx4R3wDKvi6afV00+7o49v/VCgBWCoJYozldw5qjjDI9e+K/304xpFeD
	1Y0IO+QEw/dnI9oBwgftAPJRKkDU9263RixSq06dZk0GpcmqY83tIGrluXNRyasphpWV0luU
	Mnm0VK5QKOTRuxUyKlB0znVeIyY1KgubxrJG1vSyD+ELJGeQq8qEm08c88ujLzDtbYlGoQX2
	JOvMph3e03suhP9W4u+uvPGJKXlj4CsDwjFYZdwQdqjsg9GkisOx3md+Z0VbR8u3ZQgYxdyH
	ez/2u9sUK1gOL294bZ+QHP0rCSvpVWaPTF+xH9ssK8KPnBQJS5rFOSGGB5OpFfMAqB+WxOw8
	kGj0Kyv0D5HzZg1pv4cUJ6Qc+HT7sY06NlKIq3vieSZtWPdSxpH9AyHjzVWdU4MbMnc7kMZk
	qZu4JsoK8D938Q3d8Xz583n7SF4DP+idEzOLn7nhuNZrLvDcijr8XqjE+92vSOjR1MoXu75u
	u3VPhS835lvyrTUxWK+hpjjDVZdLYWatShaGmsyqfwEg8MdImgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWy7bCSvO6WoJPpBvPmq1r8fDmN0WL5gx2s
	Fmv2nmOymHO+hcVi/pFzrBZPjz1it7h5YCeTxctZ99gszp/fwG5xYVsfq8Wmx9dYLS7vmsNm
	0XXtCavFvL9rWS2OLRCz+Hb6DaPFoq1f2C0eftjDbnHkzAtmi0v9E5ks/u/ZwW4x/dxjVgcx
	j8vXLjJ7bFl5k8njaf9Wdo+ds+6yeyzYVOqxaVUnm8exKx1sHpuX1Hvs3PGZyeP9vqtsHn1b
	VjF6HNxn6PF5k1wAbxSXTUpqTmZZapG+XQJXxr6bj9kKNvJVbD1e2cDYxdPFyMkhIWAi8bFn
	JzuILSSwm1Hi9ilbiLikxKfmqawQtrDEyn/PgWq4gGqeMUpc236GGSTBJqAlsahvH1hCROA0
	k8SP9n9gk5gFjjFJ7DvPCdGxn1Hi3aeNTCAJTgE7if+7LoAVCQu4SVxdeYati5GDg0VAReLe
	DnGQMK+ApcSLix8ZIWxBiZMzn7BAzNSW6H3Yyghhy0tsfzuHGeI6BYmfT5exQsTFJY7+7AGL
	iwg4Sdz4cZVlAqPwLCSjZiEZNQvJqFlI2hcwsqxilEwtKM5Nzy02LDDKSy3XK07MLS7NS9dL
	zs/dxAhOFVpaOxj3rPqgd4iRiYPxEKMEB7OSCO9Fv5PpQrwpiZVVqUX58UWlOanFhxilOViU
	xHm/ve5NERJITyxJzU5NLUgtgskycXBKNTBVWAp3GQcffyCWIxyxc8ext5ISD2xz5e8tyoj7
	fW7C686G2TdLH2+2mvaOSZY5uFc4srFm80Ir35m/q+xmZi/h0hV946HdeS/Yt3zCbJXAnruL
	5M4+7JlZ3lyya297pcrdFd8bu1b+EUsrnscyi5fJkbvL/3XwnCPym25duMSzVVnptuJf/gkx
	F9dIbHuxsHJq1+5rX+pYEjKz3qf2fjZ9nOL4cgnb1r0zih95r9Ta+LJY209FxXl9vsSBFd92
	6j+yPn6oYfFdvqun/H9q2XDWn9C+qvNs74cPlx9wVPDu2P1GQ9H9YOkKg7xM8doTi5WCThVt
	mfm6+VvXUg0NDhPfMishKf7616JzFjs2vIhVYinOSDTUYi4qTgQAfyO6KoQDAAA=
X-CMS-MailID: 20250306074556epcas5p1f4f9128afb3d2d912d3679dde2a4ae21
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250305091845epcas5p1689eda3ba03572377997897271636cfd
References: <CGME20250305091845epcas5p1689eda3ba03572377997897271636cfd@epcas5p1.samsung.com>
	<20250305091246.106626-1-swathi.ks@samsung.com>
	<041d55fd-99f0-4b55-92e5-fa46f37096c1@kernel.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk@kernel.org>
> Sent: 06 March 2025 12:40
> To: Swathi K S <swathi.ks@samsung.com>; krzk+dt@kernel.org;
> andrew+netdev@lunn.ch; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; robh@kernel.org;
> conor+dt@kernel.org; richardcochran@gmail.com;
> mcoquelin.stm32@gmail.com; alexandre.torgue@foss.st.com
> Cc: rmk+kernel@armlinux.org.uk; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> pankaj.dubey@samsung.com; ravi.patel@samsung.com;
> gost.dev@samsung.com; tools@linux.kernel.org
> Subject: Re: [PATCH v8 0/2] net: stmmac: dwc-qos: Add FSD EQoS support
> 
> On 05/03/2025 10:12, Swathi K S wrote:
> > FSD platform has two instances of EQoS IP, one is in FSYS0 block and
> > another one is in PERIC block. This patch series add required DT
> > binding and platform driver specific changes for the same.
> >
> > Changes since v1:
> > 1. Updated dwc_eqos_setup_rxclock() function as per the review
> > comments given by Andrew.
> >
> Please stop referencing some other threads in your email headers via
> "References". This is neither necessary nor helping our tools. I can never
> compare your patches because this makes b4 busy 100%:

Will take care in future

- Swathi

> 
> b4 diff -C '<20250305091246.106626-2-swathi.ks@samsung.com>'
> Grabbing thread from
> lore.kernel.org/all/20250305091246.106626-2-
> swathi.ks@samsung.com/t.mbox.gz
> Checking for older revisions
>   Added from v7: 3 patches
> ---
> Analyzing 86 messages in the thread
> Preparing fake-am for v7: dt-bindings: net: Add FSD EQoS device tree
> bindings <never ends, 100% CPU>
> 
> Best regards,
> Krzysztof


