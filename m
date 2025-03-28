Return-Path: <netdev+bounces-178077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3730CA74657
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 10:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 133EF1B60D9D
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 09:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF0C2139B6;
	Fri, 28 Mar 2025 09:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Uz31NG4/"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA9F213236
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 09:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743154045; cv=none; b=r7WFHIlQX2R9jUXQRLIdfq6LSpSbp6oxsr8sQMmqDBOZvorVSsOmn7lPuemuw9+I2py2WPdd43FWo7+XRhLouc8vmkJy8cuUvCFOwe5edUx1zcfbC9tb+ewKYC8Hm62SKRZn5pXEXdBOY6C/q8Zn5opPBMbA1Wxbp+RL38Pb7A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743154045; c=relaxed/simple;
	bh=LUCMEUaiv8EVes6GPoXY7f00RtKchx+3B2MYCViqRi8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=OgBAxCN39e4B25SakchCUx0UuTrUcBW6/HCN+MsCH8Aue5NiNxVYdgGE+Xbem9QqnGKGLwdymY676VqiLjMFzNV097KIuT7Xe0hXubWTXx9CYySQyb48MOnvIgEJCvItXNh9hCR38LecKDjtagXFsgu93tsnbBcZzWRu1oCDSkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Uz31NG4/; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250328092721epoutp01646de2667d214fc4c8d7257330a42cf7~w7V1wvC3S2281522815epoutp01g
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 09:27:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250328092721epoutp01646de2667d214fc4c8d7257330a42cf7~w7V1wvC3S2281522815epoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1743154041;
	bh=S8yd+wAwjVEhTV+B7KiIbkLoLVffKXf5OlRZi1/WxgI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=Uz31NG4/vo82VL3A/+yDK5+Bb0pShD5RAlQjBYx7G8NDa5+91pksdXykcEAUq9CI1
	 u756p/eJgP+f6X426wOOg5VZ6/KL07QuXgi3Cgoiw+KWGO4KY13VJrHFG5fK2WwVm9
	 aVwi3AnRxOeR4anpWZBMsqt7Uf414/UB9plgq5AU=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250328092720epcas5p3ab2130f751f48e1a781f43532728a412~w7V03ySlA0978509785epcas5p3E;
	Fri, 28 Mar 2025 09:27:20 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
	epsnrtp01.localdomain (Postfix) with ESMTP id 4ZPFY174tRz6B9m6; Fri, 28 Mar
	2025 09:27:17 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	71.53.09853.57B66E76; Fri, 28 Mar 2025 18:27:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20250328083631epcas5p4aa338b11f5ee2603ed45db587400f2bf~w6pdwDqOG1980019800epcas5p4r;
	Fri, 28 Mar 2025 08:36:31 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250328083631epsmtrp19f58038bc815182691ba2acecd411457~w6pdvDVNM0925109251epsmtrp1F;
	Fri, 28 Mar 2025 08:36:31 +0000 (GMT)
X-AuditID: b6c32a4a-03cdf7000000267d-fa-67e66b75b094
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	F3.A8.19478.F8F56E76; Fri, 28 Mar 2025 17:36:31 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250328083629epsmtip2d4eaa182ed4aff098c8b3afb6b78fc40~w6pbuARHM2407524075epsmtip2j;
	Fri, 28 Mar 2025 08:36:29 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: <krzk+dt@kernel.org>, <linux-fsd@tesla.com>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <richardcochran@gmail.com>, <alim.akhtar@samsung.com>
Cc: <jayati.sahu@samsung.com>, <linux-arm-kernel@lists.infradead.org>,
	<linux-samsung-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>, <gost.dev@samsung.com>
In-Reply-To: 
Subject: RE: [PATCH v8 0/2] arm64: dts: fsd: Add Ethernet support for FSD
 SoC
Date: Fri, 28 Mar 2025 14:06:11 +0530
Message-ID: <017801db9fbc$81bfa490$853eedb0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJibHmgcfwlBy49J8TQvpLbjGcZ7QJasif0slg38iCAD5HOoA==
Content-Language: en-in
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCJsWRmVeSWpSXmKPExsWy7bCmpm5p9rN0g/uvLSwezNvGZrFm7zkm
	i/lHzrFa3Dywk8niyKklTBYvZ91js9j0+BqrxcNX4RaXd81hs5hxfh+TxbEFYhaLtn5ht3j4
	YQ+7xZEzL5gt/u/Zwe7A77Fz1l12j02rOtk8Ni+p9+jbsorR41/TXHaPz5vkAtiism0yUhNT
	UosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgA5WUihLzCkFCgUk
	Fhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRn9Cxbzlyw
	WK7i3ONpjA2M8yW7GDk5JARMJNb/amTqYuTiEBLYzSgxf+1UZgjnE6PEvUevWeGcz7d/AWU4
	wFpWndaBiO9klHi26hZUxwtGiX2zZrOAzGUT0JJY1LePHSQhIjCJUeLF+QtgDrPANCaJIzNf
	M4GM4hTglZjwzxrEFBbwl9hxrRrEZBFQlXj2yQBkDK+ApcSRK1OYIWxBiZMzn4CNZxbQlli2
	8DUzxAsKEj+fLmMFsUUEnCR+TnvEBlEjLnH0Zw/YbRICFzgklk1/yQ7R4CKx8PFtVghbWOLV
	8S1QcSmJl/1tULaHxMz1vVA1KRKvV51jgbDtJQ5cmcMCciezgKbE+l36EGFZiamn1jFB7OWT
	6P39hAkiziuxYx6MrSzx9/U1qDGSEtuWvmefwKg0C8lrs5C8NgvJC7MQti1gZFnFKJlaUJyb
	nlpsWmCUl1oOj+/k/NxNjODkrOW1g/Hhgw96hxiZOBgPMUpwMCuJ8EpeeZIuxJuSWFmVWpQf
	X1Sak1p8iNEUGNwTmaVEk/OB+SGvJN7QxNLAxMzMzMTS2MxQSZy3eWdLupBAemJJanZqakFq
	EUwfEwenVAPTqmP7ns9fyXIu9vZVhculX3nmnNS8Pflp09HC24azn566M61tfsD2U06806ZN
	/fbi5k7lQpV5rd/YLX+ZXLZ1U5u+4Hfn75OpHj5/X/CumnWkizFnyga/igSnXzMPT79+lWPp
	y6WsPU4i/O37NENsTJ7eZt0guOaF4f6sHXeVJMq8AurS5hjIX/rCExp8tc5bXc6KgTOg8Nzr
	ALaaOfKFs1YnOle/+Sn1OiRxhayEgdH003MdVQ4apQvHHd084VfLrw7/Rb8ETnJsvG29R59l
	4k5xKe6u3psZDh4PeaM9EpYYxz9ivf9MbUVu2DqNdg3Wv/srnp+w1W7uqr/K/qtgf9QSP7+L
	t+6l/YxV08tOUWIpzkg01GIuKk4EAHoMX05XBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrJIsWRmVeSWpSXmKPExsWy7bCSvG5//LN0g52vjS0ezNvGZrFm7zkm
	i/lHzrFa3Dywk8niyKklTBYvZ91js9j0+BqrxcNX4RaXd81hs5hxfh+TxbEFYhaLtn5ht3j4
	YQ+7xZEzL5gt/u/Zwe7A77Fz1l12j02rOtk8Ni+p9+jbsorR41/TXHaPz5vkAtiiuGxSUnMy
	y1KL9O0SuDLOfzzMVLBPtmLiofVMDYxbJLoYOTgkBEwkVp3W6WLk4hAS2M4osWHPH+YuRk6g
	uKTEp+aprBC2sMTKf8/ZIYqeMUr8eHUYLMEmoCWxqG8fWEJEYBajxJGfU1hAHGaBBUwSH3r/
	skG09DJKzN7xnxVkH6cAr8SEf9Yg3cICvhKvF/5jAgmzCKhKPPtkABLmFbCUOHJlCjOELShx
	cuYTFhCbWUBbovdhKyOMvWzha6hLFSR+Pl0GdpCIgJPEz2mP2CBqxCWO/uxhnsAoPAvJqFlI
	Rs1CMmoWkpYFjCyrGEVTC4pz03OTCwz1ihNzi0vz0vWS83M3MYJjUytoB+Oy9X/1DjEycTAe
	YpTgYFYS4ZW88iRdiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9yTmeKkEB6YklqdmpqQWoRTJaJ
	g1OqgUnkhMIBmy3TjMvnXH2+QiDuqXVYI9fRdMaSMuO5rExpjbKd+8yDRJizmp5fc0tV6jtv
	416rwexkdtmk9LbmfrHkuuPCW47PzDQ0PmYmMS3OJmluRadJxDGPjEQbHseohac4Fy78t+zp
	vc/3XQVni0Vr25699JSp8F3Fx5tvk0P+7Hz4+XyfRoEuk3DbecOZO18/POgsZtm2hGlXVdzu
	LA+ZdvO7nldWxGU5Kk35W8/1irPTu4lPOTWjOzJs5Xy/0KkPn5YoGaksnxmd77jwpvCEyss7
	Ks0TvYwk/E9s+NCfsn+pxbvP26ylra9eO7X0UO8nbW1X3gtyWVt+iUs3b+RdlDl7X/LPeYc4
	wxv/KbEUZyQaajEXFScCAC3VKoQ8AwAA
X-CMS-MailID: 20250328083631epcas5p4aa338b11f5ee2603ed45db587400f2bf
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
> Sent: 18 March 2025 16:22
> To: 'krzk+dt=40kernel.org' <krzk+dt=40kernel.org>; 'linux-fsd=40tesla.com=
'
> <linux-fsd=40tesla.com>; 'robh=40kernel.org' <robh=40kernel.org>;
> 'conor+dt=40kernel.org' <conor+dt=40kernel.org>; 'richardcochran=40gmail.=
com'
> <richardcochran=40gmail.com>; 'alim.akhtar=40samsung.com'
> <alim.akhtar=40samsung.com>
> Cc: 'jayati.sahu=40samsung.com' <jayati.sahu=40samsung.com>; 'linux-arm-
> kernel=40lists.infradead.org' <linux-arm-kernel=40lists.infradead.org>; '=
linux-
> samsung-soc=40vger.kernel.org' <linux-samsung-soc=40vger.kernel.org>;
> 'devicetree=40vger.kernel.org' <devicetree=40vger.kernel.org>; 'linux-
> kernel=40vger.kernel.org' <linux-kernel=40vger.kernel.org>;
> 'netdev=40vger.kernel.org' <netdev=40vger.kernel.org>;
> 'pankaj.dubey=40samsung.com' <pankaj.dubey=40samsung.com>;
> 'ravi.patel=40samsung.com' <ravi.patel=40samsung.com>;
> 'gost.dev=40samsung.com' <gost.dev=40samsung.com>
> Subject: RE: =5BPATCH v8 0/2=5D arm64: dts: fsd: Add Ethernet support for=
 FSD
> SoC
>=20
>=20
>=20
> > -----Original Message-----
> > From: Swathi K S <swathi.ks=40samsung.com>
> > Sent: 07 March 2025 10:19
> > To: krzk+dt=40kernel.org; linux-fsd=40tesla.com; robh=40kernel.org;
> > conor+dt=40kernel.org; richardcochran=40gmail.com;
> > alim.akhtar=40samsung.com
> > Cc: jayati.sahu=40samsung.com; swathi.ks=40samsung.com; linux-arm-
> > kernel=40lists.infradead.org; linux-samsung-soc=40vger.kernel.org;
> > devicetree=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> > netdev=40vger.kernel.org; pankaj.dubey=40samsung.com;
> > ravi.patel=40samsung.com; gost.dev=40samsung.com
> > Subject: =5BPATCH v8 0/2=5D arm64: dts: fsd: Add Ethernet support for F=
SD
> > SoC
> >
> > FSD platform has two instances of EQoS IP, one is in FSYS0 block and
> > another one is in PERIC block. This patch series add required DT file
> > modifications for the same.
> >
> > Changes since v1:
> > 1. Addressed the format related corrections.
> > 2. Addressed the MAC address correction.
> >
> > Changes since v2:
> > 1. Corrected intendation issues.
> >
> > Changes since v3:
> > 1. Removed alias names of ethernet nodes
> >
> > Changes since v4:
> > 1. Added more details to the commit message as per review comment.
> >
> > Changes since v5:
> > 1. Avoided inserting node in the end and inserted it in between as per
> > address.
> > 2. Changed the node label.
> > 3. Separating DT patches from net patches and posting in different
> branches.
> >
> > Changes since v6:
> > 1. Addressed Andrew's review comment and removed phy-mode from
> .dtsi
> > to .dts
> >
> > Changes since v7:
> > 1. Addressed Russell's review comment-Implemented clock tree setup in
> > DT
> >
>=20
> Hi,
> The DT binding and driver patches corresponding to this patch is now
> reflecting in linux-next
> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-
> next.git/diff/Documentation/devicetree/bindings/net/tesla,fsd-
> ethqos.yaml?id=3Df654ead4682a1d351d4d780b1b59ab02477b1185
>=20

Hi reviewers,=20
Could you please confirm whether this set of patches can be considered for =
review or should I resend them?

- Swathi

> Could you consider these DT file patches for review/merge or do I need to
> resend these?
>=20
> -Swathi
>=20
> > Swathi K S (2):
> >   arm64: dts: fsd: Add Ethernet support for FSYS0 Block of FSD SoC
> >   arm64: dts: fsd: Add Ethernet support for PERIC Block of FSD SoC
> >
> >  arch/arm64/boot/dts/tesla/fsd-evb.dts      =7C  20 ++++
> >  arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi =7C 112
> +++++++++++++++++++++
> >  arch/arm64/boot/dts/tesla/fsd.dtsi         =7C  50 +++++++++
> >  3 files changed, 182 insertions(+)
> >
> > --
> > 2.17.1



