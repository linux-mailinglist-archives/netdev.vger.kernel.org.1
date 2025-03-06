Return-Path: <netdev+bounces-172297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F85A5416E
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 04:54:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F4A3169277
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 03:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935DE19A298;
	Thu,  6 Mar 2025 03:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="EeOmRY61"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20D81990CE
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 03:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741233262; cv=none; b=as6DAAsjj6BYlYpL51s0CECMkxTATZNQRRq5i/WYjxqLmu9SqQkZfPVFqTxtlSAmkuRpVForMaP6tLIHyWG8SjaHCUAy2GbYnHTsK4OcUb72wXBSq5aBl3V7qbyYqyAC31o6db2aIu1q59EbrvMhVyXIB0Jxchvj4/uU2HZyQfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741233262; c=relaxed/simple;
	bh=v7LFaMMQT5qrY+eFMcg0qAr81bixG1aaagmkYP4Xk5w=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=NWX9q01X+K7iktqT0y/1touR31WX3lPk4KXjYpMm6mS0R5PGK+k+nQgHWxGlFByuDNN/4KNGjoFT2AFAu2KP5Mia20eTArZt0PG95qbZ1NdlLTvopaMifsCayGmMXN+MP2XOHFMI3hqlGV3GtM1DVE+rc+X0cRCjvj5wKJxsdjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=EeOmRY61; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250306035417epoutp0470010c6e9556324c4205afdedad37201~qGmwm-0O40345903459epoutp04K
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 03:54:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250306035417epoutp0470010c6e9556324c4205afdedad37201~qGmwm-0O40345903459epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741233257;
	bh=DXfDqyB+rOhMKjLXfrimA7pgRFXTlWdnO4cbB4v1SdY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=EeOmRY61sEKDO0l7sOdjyCn+ZPZV4UGF0WLSmIOgmlbgPD2ZR+Usrbcbd0FBNfRnc
	 pyPCHa/Nu+ecaiyboYVpMv6oCWjcc6kAGhp21Ymlcx+rkM5aCX877alVyS1VFxJ0cl
	 j4ybLqSQPs3P3bOlngGINXC2gaSIXtliv4z+KNRQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTP id
	20250306035417epcas5p1558e19e920f71ce54e9b929f23ebb9fb~qGmv9b5UE2592825928epcas5p1j;
	Thu,  6 Mar 2025 03:54:17 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z7bBt6v0cz4x9Q1; Thu,  6 Mar
	2025 03:54:14 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7E.76.20052.66C19C76; Thu,  6 Mar 2025 12:54:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250306034910epcas5p3e2ae456558f38e44a3fb55bf878d4abc~qGiSLgvFs1755017550epcas5p3R;
	Thu,  6 Mar 2025 03:49:10 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250306034910epsmtrp296caea2bdd3a7a864c9828418b7d2075~qGiSKVou30610606106epsmtrp2g;
	Thu,  6 Mar 2025 03:49:10 +0000 (GMT)
X-AuditID: b6c32a49-3d20270000004e54-9b-67c91c66a7c6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	17.E6.33707.63B19C76; Thu,  6 Mar 2025 12:49:10 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250306034907epsmtip2ecdb5a27d89d31aa4ee2d2e8068aff98~qGiP9j43W0601306013epsmtip26;
	Thu,  6 Mar 2025 03:49:07 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <krzk+dt@kernel.org>,
	<linux-fsd@tesla.com>, <robh@kernel.org>, <conor+dt@kernel.org>,
	<richardcochran@gmail.com>, <alim.akhtar@samsung.com>
Cc: <jayati.sahu@samsung.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>, <gost.dev@samsung.com>
In-Reply-To: <7328e538-31cf-4674-83d2-943f1a2d1455@kernel.org>
Subject: RE: [PATCH v7 1/2] arm64: dts: fsd: Add Ethernet support for FSYS0
 Block of FSD SoC
Date: Thu, 6 Mar 2025 09:18:34 +0530
Message-ID: <00e801db8e4a$b7c2e990$2748bcb0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQHnZW/QZNZXP7mFyf6Or/FDfq+edAEP4FfLAl/FyHABH54M5LMpTuNQ
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNJsWRmVeSWpSXmKPExsWy7bCmlm6azMl0g7vLzC0ezNvGZrFm7zkm
	i/lHzrFa3Dywk8niyKklTBYvZ91jszh/fgO7xabH11gtHr4Kt7i8aw6bxYzz+5gsji0Qs1i0
	9Qu7xcMPe9gtjpx5wWzxf88OdgcBj52z7rJ7bFrVyeaxeUm9R9+WVYwe/5rmsnt83iQXwBaV
	bZORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdLWSQlli
	TilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8CkQK84Mbe4NC9dLy+1xMrQwMDIFKgwITtj
	78pdLAVbeCtO7NjP1MC4iLuLkZNDQsBE4vCPI4xdjFwcQgK7GSW+7O1khnA+MUpcOfmTEc65
	NfEoO0zL5neP2CASOxklPh/9DVX1glHi7/M1YFVsAloSi/r2sYMkRAT2M0qcnvABzGEWmMYk
	cWTmayaQKk4BO4lVr0+wgdjCAnESfVffAcU5OFgEVCQ6NnKAhHkFLCWeHfrFBmELSpyc+YQF
	xGYW0JZYtvA1M8RJChI/ny5jhYiLSxz92QMWFxFwk2h58oIJouYOh8TVOWYQtovE3tszoOLC
	Eq+Ob4F6TUri87u9bBB2vMTqvqssEHaGxN1fE6Hi9hIHrsxhATmTWUBTYv0ufYiwrMTUU+uY
	IE7gk+j9/QRqPK/EjnkwtrLE39fXoEZKSmxb+p59AqPSLCSfzULy2Swk38xC2LaAkWUVo2Rq
	QXFuemqxaYFhXmo5PMaT83M3MYJTtZbnDsa7Dz7oHWJk4mA8xCjBwawkwvv61PF0Id6UxMqq
	1KL8+KLSnNTiQ4ymwNCeyCwlmpwPzBZ5JfGGJpYGJmZmZiaWxmaGSuK8zTtb0oUE0hNLUrNT
	UwtSi2D6mDg4pRqYYu+bvUl8aV/hnGqefOnHoyXHc75+sZEUe8zdLe7yd2X9dbbKNdkW0aWC
	FwrmzT/Ju8Npg22qV562/uPqSyWG8439tmy/+2yzw9rllgZOb3xdNE8frd/90ehuZe1aeTd9
	Mdeu8ier0/Ys2f4maJ6ixr9Fdd3WyWejN6x5qOM3azNfpr7HoSkNcWotR7N+N7R+n8g0xSSh
	9VajhvQirQ9Mqn3qm6eELLr5J/rin+yS71VVEx737tldle5Yse5fz5w97oyaZ869VX8mIBP8
	deeDObkS91nD765e79kVk1BjscK8dts59if7boWFJKZrcZbH3I8qnptXciDVge0kq8IS20/F
	D4pPTnFTXL/58tIyJZbijERDLeai4kQAuMf5RV4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCSvK6Z9Ml0g1PXWCwezNvGZrFm7zkm
	i/lHzrFa3Dywk8niyKklTBYvZ91jszh/fgO7xabH11gtHr4Kt7i8aw6bxYzz+5gsji0Qs1i0
	9Qu7xcMPe9gtjpx5wWzxf88OdgcBj52z7rJ7bFrVyeaxeUm9R9+WVYwe/5rmsnt83iQXwBbF
	ZZOSmpNZllqkb5fAlbFq2mzGgu88FTcmvWFvYHzM1cXIySEhYCKx+d0jti5GLg4hge2MEqvO
	H2CCSEhKfGqeygphC0us/PecHaLoGaPEwkdHwIrYBLQkFvXtA0uICBxnlJj+cAkziMMssIBJ
	4kPvXzaQKiGBt4wSW9/ZgdicAnYSq16fAIsLC8RIPDnyiLGLkYODRUBFomMjB0iYV8BS4tmh
	X2wQtqDEyZlPWEBsZgFtid6HrYww9rKFr5khrlOQ+Pl0GStEXFzi6M8esLiIgJtEy5MXTBMY
	hWchGTULyahZSEbNQtK+gJFlFaNoakFxbnpucoGhXnFibnFpXrpecn7uJkZwnGoF7WBctv6v
	3iFGJg7GQ4wSHMxKIryvTx1PF+JNSaysSi3Kjy8qzUktPsQozcGiJM6rnNOZIiSQnliSmp2a
	WpBaBJNl4uCUamAqUHrF7rwsfQZz8ueWp+c9zlXucth1arFMqqDzjAlqD1w27G660Kh1W2zC
	+VDJZzeNckT2RTH+NTHear1mTug8d84/myN1eL2OuX1icGpkt5jL+29WTwCHqp3wlqnf5a7/
	iWd7tGsqi+pHO9FjXWWiz9Y0vys8LTBr06sqXe7qVU0hu1jvcrXWG6dESZlaVV9LfvU1cm9P
	ykMd9VPdqp+aXT4FmSSqJ6+Xmc6fLBLwZbvbJTOj938bU1k6UhdtfvdZJW/i7f+NH/9z9VTM
	X5t6nqGl+O77dR42c2/uyNqUe9XC8a/hbtmK494vz/GFfDz2/v/lJ4dS7h1yNK1ril25pfr8
	78Y4mZUfhc8YPHyjxFKckWioxVxUnAgAFoU4UkIDAAA=
X-CMS-MailID: 20250306034910epcas5p3e2ae456558f38e44a3fb55bf878d4abc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250220073944epcas5p495ee305ca577a7e1be51ff916f20fc53
References: <20250220073527.22233-1-swathi.ks@samsung.com>
	<CGME20250220073944epcas5p495ee305ca577a7e1be51ff916f20fc53@epcas5p4.samsung.com>
	<20250220073527.22233-2-swathi.ks@samsung.com>
	<7328e538-31cf-4674-83d2-943f1a2d1455@kernel.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 01 March 2025 19:29
> To: Swathi K S <swathi.ks=40samsung.com>; krzk+dt=40kernel.org; linux-
> fsd=40tesla.com; robh=40kernel.org; conor+dt=40kernel.org;
> richardcochran=40gmail.com; alim.akhtar=40samsung.com
> Cc: jayati.sahu=40samsung.com; linux-arm-kernel=40lists.infradead.org; li=
nux-
> samsung-soc=40vger.kernel.org; devicetree=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; netdev=40vger.kernel.org;
> pankaj.dubey=40samsung.com; ravi.patel=40samsung.com;
> gost.dev=40samsung.com
> Subject: Re: =5BPATCH v7 1/2=5D arm64: dts: fsd: Add Ethernet support for=
 FSYS0
> Block of FSD SoC
>=20
> On 20/02/2025 08:35, Swathi K S wrote:
> >  &pinctrl_peric =7B
> > diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi
> > b/arch/arm64/boot/dts/tesla/fsd.dtsi
> > index 690b4ed9c29b..01850fbf761f 100644
> > --- a/arch/arm64/boot/dts/tesla/fsd.dtsi
> > +++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
> > =40=40 -1007,6 +1007,26 =40=40
> >  			clocks =3D <&clock_fsys0
> UFS0_MPHY_REFCLK_IXTAL26>;
> >  			clock-names =3D =22ref_clk=22;
> >  		=7D;
> > +
> > +		ethernet0: ethernet=4015300000 =7B
> > +			compatible =3D =22tesla,fsd-ethqos=22;
>=20
> I don't see bindings in the linux-next, so I am dropping this patch from =
my
> queue. Please resend when the bindings hit the linux-next.

Thanks for informing me.
I have posted v8 of DT bindings: https://lore.kernel.org/netdev/89dcfb2a-d0=
93-48f9-b6d7-af99b383a1bc=40kernel.org/
Will wait for some time for the DT binding to reflect on linux-next before =
posting v8 patches of DT files.

- Swathi

>=20
> Best regards,
> Krzysztof


