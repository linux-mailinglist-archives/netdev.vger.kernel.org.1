Return-Path: <netdev+bounces-176105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B81DAA68CE0
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 13:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF700188EF17
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 12:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1412566FB;
	Wed, 19 Mar 2025 12:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BXX1ARS5"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503DB2561CF
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 12:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742387427; cv=none; b=V8tFwdc/O2ynY6RZemw9wFXamds4Qh5HO0tYhtSQEc52ZMFcQG05b7+KPBIL7l9Sz04K/ItEBBZRlPIzk4m1WCOJMArFqjiId0Zh5+bk3OqwLXzgHUtu07Us99328SVqJDSsGvLIuNPpeAv2kyVfaqcCFMb6TqaIMQ9cw190Z0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742387427; c=relaxed/simple;
	bh=lJ9C72km+zAZC98wH4+CqxmYmtUNyd7G86XboGlc/Og=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=MtdmkSZKRElLldNwGF21S4zXUPL8T8eQawzniN0bNe2YxxyJzjP5KF9sBnlnQ5xmjvDHdD1JSk+jYY2ar80Vjdbvj2JvdTa+K5aKS98gcYRpd7Kxw0oc5o6GVzu3xoFjY62nfSKv1uKtE9HWxmWlbIzr0puOK52stHO/NdV7qdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=BXX1ARS5; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250319123017epoutp04ec7c9ffcf4fa3410b267e9f514968c57~uNB-6U8Kz3147031470epoutp04L
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 12:30:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250319123017epoutp04ec7c9ffcf4fa3410b267e9f514968c57~uNB-6U8Kz3147031470epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1742387417;
	bh=X/6rPjwLul3osgT7ZsXp5aROIwC4aSL55c8eg4WdFWQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=BXX1ARS5Fjfmtd3WKIIHdMqHGGf8s9wqpN7y6SKD0yrcj2Ldnjr+PMJlNeKPana2K
	 yhPro+nty3yrHaTSPMDPi++4IkBUahr8VzPnapLTRIJYhj3g4sX02axrmbxITe7jou
	 yRm0WTk9zfKb7YUDwFH0bolPas6WVpATMSZ3I58A=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20250319123016epcas5p40ea580df37bea28cc4bdc2dba8697ff5~uNB-GZeWk0870008700epcas5p4Q;
	Wed, 19 Mar 2025 12:30:16 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4ZHp2H0Q00z4x9Pt; Wed, 19 Mar
	2025 12:30:15 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5A.12.20052.6D8BAD76; Wed, 19 Mar 2025 21:30:14 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250318105219epcas5p2658d27215c21f741a2ee59f52b178ecf~t4DLb_2VX2675626756epcas5p2F;
	Tue, 18 Mar 2025 10:52:19 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250318105219epsmtrp1a6c0a52e389d36a36798596aa88752ed~t4DLbLLZc1465214652epsmtrp1S;
	Tue, 18 Mar 2025 10:52:19 +0000 (GMT)
X-AuditID: b6c32a49-3fffd70000004e54-ef-67dab8d650a4
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	D6.77.33707.36059D76; Tue, 18 Mar 2025 19:52:19 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250318105217epsmtip1e43ebe3edacda18457e4be315d4f00ea~t4DJU4dHv1181911819epsmtip1R;
	Tue, 18 Mar 2025 10:52:17 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: <krzk+dt@kernel.org>, <linux-fsd@tesla.com>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <richardcochran@gmail.com>, <alim.akhtar@samsung.com>
Cc: <jayati.sahu@samsung.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>, <gost.dev@samsung.com>
In-Reply-To: <20250307044904.59077-1-swathi.ks@samsung.com>
Subject: RE: [PATCH v8 0/2] arm64: dts: fsd: Add Ethernet support for FSD
 SoC
Date: Tue, 18 Mar 2025 16:22:09 +0530
Message-ID: <000401db97f3$d20f5970$762e0c50$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJibHmgcfwlBy49J8TQvpLbjGcZ7QJasif0slg38iA=
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKJsWRmVeSWpSXmKPExsWy7bCmuu61HbfSDRZusbZ4MG8bm8WaveeY
	LOYfOcdqcfPATiaLI6eWMFm8nHWPzWLT42usFg9fhVtc3jWHzWLG+X1MFscWiFks2vqF3eLh
	hz3sFkfOvGC2+L9nB7sDv8fOWXfZPTat6mTz2Lyk3qNvyypGj39Nc9k9Pm+SC2CLyrbJSE1M
	SS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQwV1LIS8xNtVVy8QnQdcvMATpYSaEsMacUKBSQ
	WFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBXnJhbXJqXrpeXWmJlaGBgZApUmJCdse/sUZaC
	tcIVK/ZOZ2tg/M/fxcjJISFgIvFt6hy2LkYuDiGB3YwSi6eeYIRwPjFK/GtoY4dz9q+9xg7T
	0tkxhRkisZNR4vythywQzgtGidf37rOCVLEJaEks6tsH1i4iMIlR4sX5C2AOs8A0JokjM18z
	gVRxClhLnNt3FyjBwSEs4C+x41o1iMkioCrxerk/SAWvgKXEk/8dTBC2oMTJmU9YQGxmAW2J
	ZQtfM0NcpCDx8+kyVpBWEQEriTk/VCBKxCWO/uwBO1RC4AqHxLePp1kh6l0krl77AmULS7w6
	vgXqMymJl/1tULaHxMz1vVA1KRKvV51jgbDtJQ5cmcMCsotZQFNi/S59iLCsxNRT65gg9vJJ
	9P5+wgQR55XYMQ/GVpb4+/oa1BhJiW1L37NPYFSaheSzWUg+m4XkhVkI2xYwsqxilEwtKM5N
	Ty02LTDMSy2HR3hyfu4mRnB61vLcwXj3wQe9Q4xMHIyHGCU4mJVEeN2fXE8X4k1JrKxKLcqP
	LyrNSS0+xGgKDO2JzFKiyfnADJFXEm9oYmlgYmZmZmJpbGaoJM7bvLMlXUggPbEkNTs1tSC1
	CKaPiYNTqoFp5hfxD9FXU6rjy+cfsj5QmSAVtTiQacYWI2nGlEenpmcHfemZe6apYEXmtt0W
	HulPL+azrr+8lOHq0p1NotYTrP7w8wtcq3+ZsOxA0dcfOy59VZy4J5f15YLYpx/m9+WcvvMo
	5Mhuo4Tusude13z+fv7y+tCKBF6jbzf7f9/ep3exQvJTxvKc+YzOXwTkZmubnDnrFcXax3Xy
	Gm9Lleweu/NWTryz7f5x9k64G/JAb99KtrbTFd07xSbqL1yVsaaka5+eJus1z7PNDrzrLy/e
	xni47BaLq4pbloh6TrnqLdVL3I9UDKR4Dd83rNjx+pmK43FF40ubnPa92Kr5q+n8me2fV2/I
	jH5j+uf3GYXFt5VYijMSDbWYi4oTASQT4B5YBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsWy7bCSnG5ywM10g4WTdC0ezNvGZrFm7zkm
	i/lHzrFa3Dywk8niyKklTBYvZ91js9j0+BqrxcNX4RaXd81hs5hxfh+TxbEFYhaLtn5ht3j4
	YQ+7xZEzL5gt/u/Zwe7A77Fz1l12j02rOtk8Ni+p9+jbsorR41/TXHaPz5vkAtiiuGxSUnMy
	y1KL9O0SuDIeLHzIWNAuXHGl7wRbA+NV/i5GTg4JAROJzo4pzF2MXBxCAtsZJba1vGaBSEhK
	fGqeygphC0us/PecHaLoGaPErZ697CAJNgEtiUV9+8ASIgKzGCWO/JzCAuIwCyxgkvjQ+5cN
	oqWHUWLmrMNgszgFrCXO7bsL1i4s4CvxeuE/pi5GDg4WAVWJ18v9QcK8ApYST/53MEHYghIn
	Zz4BO4lZQFui92ErI4y9bOFrZojzFCR+Pl3GCjJGRMBKYs4PFYgScYmjP3uYJzAKz0IyaRaS
	SbOQTJqFpGUBI8sqRtHUguLc9NzkAkO94sTc4tK8dL3k/NxNjODo1Arawbhs/V+9Q4xMHIyH
	GCU4mJVEeN2fXE8X4k1JrKxKLcqPLyrNSS0+xCjNwaIkzquc05kiJJCeWJKanZpakFoEk2Xi
	4JRqYLLiywj9uuZXc86pMJ4kD+WOyO8ZyQwBag1bJVY3aIrH8bYqTC2T8Z7cM+2/xVRZ/TP7
	i6eYth9mnZH7wfzlpt86y+oVj4h7r8tmz7tYYfpl2sHntn/VJ0r3bz187tdHmSf2R/NVdL9e
	eJo+O/79gchthd8SpH3M9q2tW7zR8N36yvJ939iXn/i784X+iS+8+xbeza6v9LfNCisVXVj8
	Uu1iksykOVz9J9/2V+1RiRFONYlf5KfFdvktw6dasZLj3zt+s3h1MN+ZpvqT+4rhxav73TIn
	7/b5n3Uh7M7v0g9vwo/KS+gnKnAK/mG4mPNmhp1+n/1aicVzb81l7Xt8J+atUslxsZ83ape3
	ahxZaqfEUpyRaKjFXFScCAC2KsLaPQMAAA==
X-CMS-MailID: 20250318105219epcas5p2658d27215c21f741a2ee59f52b178ecf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250307045516epcas5p3b4006a5e2005beda04170179dc92ad16
References: <CGME20250307045516epcas5p3b4006a5e2005beda04170179dc92ad16@epcas5p3.samsung.com>
	<20250307044904.59077-1-swathi.ks@samsung.com>



> -----Original Message-----
> From: Swathi K S <swathi.ks=40samsung.com>
> Sent: 07 March 2025 10:19
> To: krzk+dt=40kernel.org; linux-fsd=40tesla.com; robh=40kernel.org;
> conor+dt=40kernel.org; richardcochran=40gmail.com;
> alim.akhtar=40samsung.com
> Cc: jayati.sahu=40samsung.com; swathi.ks=40samsung.com; linux-arm-
> kernel=40lists.infradead.org; linux-samsung-soc=40vger.kernel.org;
> devicetree=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> netdev=40vger.kernel.org; pankaj.dubey=40samsung.com;
> ravi.patel=40samsung.com; gost.dev=40samsung.com
> Subject: =5BPATCH v8 0/2=5D arm64: dts: fsd: Add Ethernet support for FSD=
 SoC
>=20
> FSD platform has two instances of EQoS IP, one is in FSYS0 block and anot=
her
> one is in PERIC block. This patch series add required DT file modificatio=
ns for
> the same.
>=20
> Changes since v1:
> 1. Addressed the format related corrections.
> 2. Addressed the MAC address correction.
>=20
> Changes since v2:
> 1. Corrected intendation issues.
>=20
> Changes since v3:
> 1. Removed alias names of ethernet nodes
>=20
> Changes since v4:
> 1. Added more details to the commit message as per review comment.
>=20
> Changes since v5:
> 1. Avoided inserting node in the end and inserted it in between as per
> address.
> 2. Changed the node label.
> 3. Separating DT patches from net patches and posting in different branch=
es.
>=20
> Changes since v6:
> 1. Addressed Andrew's review comment and removed phy-mode from .dtsi
> to .dts
>=20
> Changes since v7:
> 1. Addressed Russell's review comment-Implemented clock tree setup in DT
>=20

Hi,=20
The DT binding and driver patches corresponding to this patch is now reflec=
ting in linux-next
https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/dif=
f/Documentation/devicetree/bindings/net/tesla,fsd-ethqos.yaml?id=3Df654ead4=
682a1d351d4d780b1b59ab02477b1185

Could you consider these DT file patches for review/merge or do I need to r=
esend these?

-Swathi

> Swathi K S (2):
>   arm64: dts: fsd: Add Ethernet support for FSYS0 Block of FSD SoC
>   arm64: dts: fsd: Add Ethernet support for PERIC Block of FSD SoC
>=20
>  arch/arm64/boot/dts/tesla/fsd-evb.dts      =7C  20 ++++
>  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi =7C 112 +++++++++++++++++++++
>  arch/arm64/boot/dts/tesla/fsd.dtsi         =7C  50 +++++++++
>  3 files changed, 182 insertions(+)
>=20
> --
> 2.17.1



