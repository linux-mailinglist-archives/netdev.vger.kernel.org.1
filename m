Return-Path: <netdev+bounces-166296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 098D9A35634
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 06:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B77C3AE24F
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 05:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36875186E26;
	Fri, 14 Feb 2025 05:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="irqqnmAS"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F5217BEC5
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 05:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739510609; cv=none; b=slULvmLBzGN4ahTaCneEiwOkULgUu5oun46BAE9uYgz2vfR9Azv8cnnnaIOYxbLYnBs0zitRXsFoMzY99Gf99JQJrHc5QuldwYFQFgHUi/kog+xpyg/8I8olhSghMOzrcOk5pCgIUj9D2nk1IpUotWP8V+iJuOh2qiEfNpUoQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739510609; c=relaxed/simple;
	bh=ZRHlKFMW5Hqw4wlGDKNEDDlBg4jUn7qjkA1PV1UpY3k=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=d9P9KP4wRu70j2VUqRrTLmHC79ct28x5+OTVaN+VUGkkmEb2T95pZhxOCW5+X7let2TxUygexke73t32IUBX9fMm1EE0eQWGdqd4AmvRdpeOmX6/6UBH5KJ5VzzljoFv6dzrzxUv2ZYg8R7yu+Dlp6HUH3r7vdktDFqHSFHPD5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=irqqnmAS; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250214052324epoutp04172e7840eb8fc28606aadee3da7d21e0~j_629PaZ63060930609epoutp04V
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 05:23:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250214052324epoutp04172e7840eb8fc28606aadee3da7d21e0~j_629PaZ63060930609epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1739510604;
	bh=fjzZ8g1rId+ba7sBsfiAyhOJa4sqp8a1IhoPL8J8YzQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=irqqnmASkQa7cNtEGnYM4PV9/8czDACH+/ZI5FXUk2TQtMEAdh4bqGZNlHDVgHiDV
	 SUpK+peH3ql2DAfrza3cRo1mhmWfpQSCaDBaVJHfYakptthXVrGm8XrwxelZIwuJec
	 fkmOW1FW11DVpyIGJ5Yo2bfe2u51VPSCW4OWimyE=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250214052324epcas5p28619e8fcb61431668ad2fe26a2df304e~j_62Ut5Xr1362413624epcas5p2A;
	Fri, 14 Feb 2025 05:23:24 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YvL6y2Y81z4x9Py; Fri, 14 Feb
	2025 05:23:22 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	A7.13.19956.A43DEA76; Fri, 14 Feb 2025 14:23:22 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250214051751epcas5p13fec2d1ca9c6505cab1d4c1476346ed6~j_2ANQKv51034810348epcas5p1F;
	Fri, 14 Feb 2025 05:17:51 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250214051751epsmtrp1f0278ea4befacc1dbd7830b91405ea38~j_2AL8CY71384613846epsmtrp1f;
	Fri, 14 Feb 2025 05:17:51 +0000 (GMT)
X-AuditID: b6c32a4b-fe9f470000004df4-34-67aed34a1690
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.22.18729.EF1DEA76; Fri, 14 Feb 2025 14:17:50 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250214051748epsmtip2eee9fbb4db52194ff8db30436d46d2f9~j_19qkrIS0466404664epsmtip2G;
	Fri, 14 Feb 2025 05:17:48 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Andrew Lunn'" <andrew@lunn.ch>
Cc: <krzk+dt@kernel.org>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<robh@kernel.org>, <conor+dt@kernel.org>, <richardcochran@gmail.com>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
	<rmk+kernel@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	"'Pankaj Dubey'" <pankaj.dubey@samsung.com>
In-Reply-To: <85e0dec0-5b40-427a-9417-cae0ed2aa484@lunn.ch>
Subject: RE: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device tree
 bindings
Date: Fri, 14 Feb 2025 10:47:39 +0530
Message-ID: <00b001db7e9f$ca7cfbd0$5f76f370$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQFMfZy5LnHh86L+CikZ+hKlrx3PbgHP/Q5uAh59lGQCP3Rr5rQy085A
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMJsWRmVeSWpSXmKPExsWy7bCmhq7X5XXpBjP381n8fDmN0WL5gx2s
	FufvHmK2WLP3HJPFnPMtLBbzj5xjtXh67BG7xctZ99gsLmzrY7XY9Pgaq8XlXXPYLLquPWG1
	mPd3LavFsQViFt9Ov2G0WLT1C7vFkTMvmC0u9U9ksvi/Zwe7g7DH5WsXmT22rLzJ5PG0fyu7
	x85Zd9k9Fmwq9di0qpPNY/OSeo+dOz4zebzfd5XNo2/LKkaPg/sMPT5vkgvgicq2yUhNTEkt
	UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAH6UEmhLDGnFCgUkFhc
	rKRvZ1OUX1qSqpCRX1xiq5RakJJTYFKgV5yYW1yal66Xl1piZWhgYGQKVJiQnXFxaz9TQSN3
	xfYDFg2Mkzm7GDk4JARMJB5uY+ti5OIQEtjNKHHw23emLkZOIOcTo8SNM9IQiW+MEm8XLAJL
	gDQsnjqPHSKxl1Hi2ZSJjBAdLxglvq8DK2IT0JJY1LePHcQWEVCRmDd3ChNIA7NAP4vEsxet
	bCAJTgFriTunH7KDnCEsECjRdpQPJMwioCpxZOt2sDm8ApYSK24uYoWwBSVOznzCAmIzC8hL
	bH87hxniIAWJn0+XsULscpNYs/4PO0SNuMTRnz3MIHslBOZzSlxZcQ3qAxeJyZemskDYwhKv
	jm9hh7ClJF72t0HZ8RKr+65C1WRI3P01kQ3Ctpc4cGUOC8jNzAKaEut36UOEZSWmnoL4nVmA
	T6L39xOoVbwSO+bB2MoSf19fgxopKbFt6Xv2CYxKs5C8NgvJa7OQvDALYdsCRpZVjJKpBcW5
	6anFpgXGeanl8NhOzs/dxAhO/VreOxgfPfigd4iRiYPxEKMEB7OSCK/EtDXpQrwpiZVVqUX5
	8UWlOanFhxhNgeE9kVlKNDkfmH3ySuINTSwNTMzMzEwsjc0MlcR5m3e2pAsJpCeWpGanphak
	FsH0MXFwSjUwiX3NKLzUl2LJb/t2mf3jnqxNLfdNQpc0vM6YkfRVMuRtknmUbOt+zq7Um9N3
	6Ii7vmaP5jHmnrnkabH6GwmWPfxTQ+al/VG48zje7d3nuE3XFZtMg3bv7Zuc9IalxsG80X3x
	h//u04u5pAuN6w25BY5vELofcqD9xoQEn1iH9sbq2Z5Vt/2cTp/iTVzglj1JbtHma18fB07V
	VSlTffB2pqdtzymnVQem6Acda059KrfNPzM+fMH08rbLiQKXiphMt1x4qvR35ZudqiYt+xfd
	VhcPU3b9cOhBRcHOifa+EvvUU5fasJz8JMhmdmZlWP5qIxXnxr9s269MeRKooK+y0fLm/Wkc
	Tw6xVzVHuB5XYinOSDTUYi4qTgQA2fa+FIYEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRzGec9lO8eyTi7yzaJsWZC12UDqlcSkwE4klH7IqA+23GmZTuem
	ZhdLy5JMt26THMtkk9KlmbM1Vym1LAxL87ayWnTx3sWwm5bd3Ir89oPneX78P/wp3MdF+FHx
	SamcKkmaKOR5EVdvC+eKfrZeki+tqQlBowOFAF14UUuiFpcDRxV1zRgytOQQ6FxDM4l67r7i
	owH9cx56eFVDIstrJ4narxl4KM/ZTaLiH5UkulsyA31peguQ0fqJjxru9+OoTXsCQ79u1PLD
	BWy7sxVnr5R3YWyP1spn7XoXny2xpLEW81EeW1N6gLXXfsTYofpOHqu5YgbsrXoJ+9EyZ8Pk
	zV6hMi4xPp1TBYVt9drRatViyuxJGbabKAucovMATUEmGJp0xfw84EX5MNcB7Ous4nmCmXD4
	kI70sACW/+z7W+oFUHusmz8e8JhAaNTUu3k6EwCLz57Gxks4YyKgznEU8ywGAbQf6QDjLZpZ
	AZ81vXQvBMx6OFRwz80EswA2WG3YOHszIbCsy0h6eBq8V9RN5AHqj1UMj1S7NTgzF9reGXDP
	df5wtOc86TkiAlZUjfE9HV94ZzQfPw4E+gkm/X+TfoJJP2FRAggzmMkp1Qq5Qi1RSpK4XWK1
	VKFOS5KL45IVFuD+gMBFtcBm/iB2AIwCDgApXDjdGxZWyH28ZdLdezhVcqwqLZFTO8AsihD6
	evv2F8h8GLk0lUvgOCWn+pdiFO2Xha2sW4iFdVUtj6gM7J0S9NlfWC3aVKbCFJOoJQlyV9RB
	mVLGiAYGr7WVLbG/GT6RTose5/Qv+wwkvJ3fhPrGJrMmouN728uHoQVbCEnk8MbnUfbcmrey
	+ZExdOPh+NKEVU5tmkZdlD+qygw3mbL9q/Nj96wyCqw5RbqKEcXXmLCMbY/j6uYVGHVcPqJT
	cwvHst9UUll9D4RzEsWuJ61DUSGX38c1jw0P/ohzOk0Bot7r6Sen0pvqE/bHltOCNfdTw8sf
	GTKTj4eevpjSaPsWGb3dBHYvXR2zOHOv4eYyeiRlLTn16ew7++LbXbkX1+EjGUUh2y6cGYv2
	C/bVNuwihIR6h1QSiKvU0t+jXAZjcAMAAA==
X-CMS-MailID: 20250214051751epcas5p13fec2d1ca9c6505cab1d4c1476346ed6
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



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: 14 February 2025 05:50
> To: Swathi K S <swathi.ks@samsung.com>
> Cc: krzk+dt@kernel.org; andrew+netdev@lunn.ch; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> robh@kernel.org; conor+dt@kernel.org; richardcochran@gmail.com;
> mcoquelin.stm32@gmail.com; alexandre.torgue@foss.st.com;
> rmk+kernel@armlinux.org.uk; netdev@vger.kernel.org;
> devicetree@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH v6 1/2] dt-bindings: net: Add FSD EQoS device tree
> bindings
> 
> > +  phy-mode:
> > +    enum:
> > +      - rgmii-id
> 
> phy-mode is normally a board property, in the .dts file, since the board
might
> decide to have extra long clock lines and so want 'rgmii'.
> 
> The only reason i can think of putting rgmii-id here is if the MAC only
> supports 'rgmii-id', it is impossible to make it not add delays.
> If that is true, a comment would be good.


Hi Andrew,
Thanks for reviewing.
I think we already discussed this part some time back here [1]
[1] :
https://patchwork.kernel.org/project/linux-arm-kernel/patch/20230814112539.7
0453-2-sriranjani.p@samsung.com/#25879995
Please do let me know if there is any other concern on this.

-Swathi

> 
> 	Andrew


