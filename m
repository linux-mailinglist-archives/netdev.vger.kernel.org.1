Return-Path: <netdev+bounces-172342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35068A5446C
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 09:15:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1C043AC423
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 08:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1A3B205AD0;
	Thu,  6 Mar 2025 08:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HF0rffSX"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE064202C4D
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 08:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741248852; cv=none; b=rRUqUdjHJgI/wjSmeNuNlbNvUiA0950g/pW75tHRnsGaLSXu+ru518eNuqT3iFyHq4LNwFIQSICLVxb415mAHewD3E3As9QDTfQtYE6mpSq3IqHe97Go1cySF2/mvQSDB2+BKuju+dde6VaVMyGFyCKtsdwQmWZzEfr/SVqJjr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741248852; c=relaxed/simple;
	bh=k6mnkPFomq2MGfRQMtgnPUDBce80u9EQGOgXgPA1+xs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=QOrMmO+Zww4uCI8703Jz36HsTjXP/C8vsevJOx/vCf97USJZCaXcUMTsl0P8s1WZesjFQ3lIpquObqoPNAqGQYThV+rwn1ytvp0MQxx78WZFNRHXROSUDg1b/4Cg78MWEe5bpJ31ivTpecE7GWjXu0iWHqG/67ibwHm8ClVxCB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=HF0rffSX; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20250306081408epoutp01913435cf3cef696de6e0d8a66e328e7c~qKJo7QZMs0304003040epoutp01d
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 08:14:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20250306081408epoutp01913435cf3cef696de6e0d8a66e328e7c~qKJo7QZMs0304003040epoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741248848;
	bh=k6mnkPFomq2MGfRQMtgnPUDBce80u9EQGOgXgPA1+xs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=HF0rffSXDqhsnmM54aUq5+ZRyqRdGkmV1MvgSSslW7Rh3O0cwX548zh/Y6/nACohJ
	 Qe0idONuj5mZcuhCKJ2z2CQGKJURQhIAm1fOsvSPhk2Jmh9o6G3BjQg3DHFiItcGBz
	 WbyRNkdAkdgu8dXGyNoEJLPC1eTfTqbGutSS5LOk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250306081408epcas5p2cc5cdb6d66503223b5cebc08e06df4f9~qKJoSUYnV1774417744epcas5p2J;
	Thu,  6 Mar 2025 08:14:08 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Z7hyk0Pxzz4x9QK; Thu,  6 Mar
	2025 08:14:06 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	10.85.19710.D4959C76; Thu,  6 Mar 2025 17:14:05 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250306074847epcas5p286f512436a15d1b62ee1e5cc65b8a291~qJzgaAEVu2622726227epcas5p2O;
	Thu,  6 Mar 2025 07:48:47 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250306074847epsmtrp2908ed13f055262cc6cec405330b5e0af~qJzgY7Ck91823218232epsmtrp2N;
	Thu,  6 Mar 2025 07:48:47 +0000 (GMT)
X-AuditID: b6c32a44-36bdd70000004cfe-14-67c9594d1953
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	92.FE.18729.F5359C76; Thu,  6 Mar 2025 16:48:47 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250306074844epsmtip29eefffb54bed9090fc6baa6289c5ff5b~qJzdkUr7x2203522035epsmtip2g;
	Thu,  6 Mar 2025 07:48:44 +0000 (GMT)
From: "Swathi K S" <swathi.ks@samsung.com>
To: "'Krzysztof Kozlowski'" <krzk@kernel.org>, <krzk+dt@kernel.org>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <robh@kernel.org>,
	<conor+dt@kernel.org>, <richardcochran@gmail.com>,
	<mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>
Cc: <rmk+kernel@armlinux.org.uk>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<pankaj.dubey@samsung.com>, <ravi.patel@samsung.com>, <gost.dev@samsung.com>
In-Reply-To: <a9ddeccf-8fc6-453c-af62-55e895888a77@kernel.org>
Subject: RE: [PATCH v8 1/2] dt-bindings: net: Add FSD EQoS device tree
 bindings
Date: Thu, 6 Mar 2025 13:18:37 +0530
Message-ID: <012901db8e6c$3179a730$946cf590$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQHcwqSBZNYxUrKMqce/4F1P5N/GfgGyT6S5AetEnA8CjXdBygKIabXqAWIbQ0mzEqYV4A==
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzOubftLQpyByJH9khTTQhslFZKdzCUmY3NuxdjD93GNuECdy0C
	bdPHcGbO6tA4Bi3ofDWVl1NcGbh1QAoKImgZolRkFInrFAcISkTGQgIbspYLG/995/u+3/n9
	vnPy4+NBRiKMn6XSM1oVnSPkreA0tEeER735YadCXNQdj2bGjgBUdcfBRT80d2PI6srnoLJL
	3Vw07LxLoIHWRgyNWX7nIZfrRwJdbzBxkf0PNxf1Nll5qMA9xEWlczVc5Cxfg6a7xgGqrP+L
	QIOPzhPo0tVRHN0wl2Bo/ryD2BRC9bp7cKru+wGMGjbXE1SjxUNQ5XYDZbd9zaN+/m431eiY
	wqiJlj4eZaqzAepii4Sasj+T7J+SHa9k6ExGK2BUGerMLJVCLnz93dSXUmNlYkmUJA49LxSo
	6FxGLkx8Iznqlawcb1ah4DM6x+ClkmmdThidEK9VG/SMQKnW6eVCRpOZo5FqRDo6V2dQKUQq
	Rr9RIhZviPUa07KVta3tQLNfsKNjupAwgn1PFgA/PiSlcOToCaIArOAHkecALNp/iOMTgsg/
	AWyaTGKFaQBHHx8mlipuTY7xWKEZwPbifi57GAXwjG2a53PxyEhYaWpZqFhNNmNwZE+yz4ST
	5Rj8qeMk5hP8yATYO9KL+3Aw+Ta0On8DPswh18PxvdULngAyDt4/MgtY/ATsPD60MB9OPgtP
	VzzA2ZEEcGb4NJflQ+HlmUIvz/c23gq/tW319YVklR+c6rvGYf2JsPHQUm0wvN9RtxgtDE49
	bOaxOBVWm/oW/UromS1Z5F+Arb9aOb77cTICnm2KZumn4eErtRg7wipY9PcQxvIB0FG6hNfB
	uQfuxSvXwoZTE0QxEFqWJbMsS2ZZlsbyf7dywLGBtYxGl6tgMmI1EhWT99+HZ6hz7WBhFSIT
	HeBm2WNRG8D4oA1APi5cHdCT1KkICsikP9/JaNWpWkMOo2sDsd7nLsHDQjLU3l1S6VMl0jix
	VCaTSeNiZBJhaMBXjfmKIFJB65lshtEw2qU6jO8XZsQEB4j019zUGm3FUMW8w9/UVdv/xcUt
	mz0t4Rd0Edcdw+mhN17eIG/xp9/PxNJGRQ/Xmdy7inecdLuDtZXDc8pvnNXiLdVv3Qu8reko
	KufXEJtcbkPxwWbzreK6Vo05haRWlealVHyaf7B9m3bCEwI+PofjxsmNr2ZHZ/Vw9jzXYzx7
	Jt4ym7TdVW/cvWtbv7z6l0+eMp+wfymirC/Gm+94yMs9hpu30zgrXahbdKzwwF7rsZWB3Pds
	0ojCWPlVxRXncee9wXx6e0Zv1QdlDfYLkcmSa55HmwvJ/sEaevKjBHGMLB3mdVFxdeED7wSe
	coz7tcpy5+/G/LOvLC+qyb5TyNEpaUkkrtXR/wJmf8iikwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7bCSvG588Ml0gwNrNS1+vpzGaLH8wQ5W
	izV7zzFZzDnfwmIx/8g5Vounxx6xW9w8sJPJ4uWse2wW589vYLe4sK2P1WLT42usFpd3zWGz
	6Lr2hNVi3t+1rBbHFohZfDv9htFi0dYv7BYPP+xhtzhy5gWzxaX+iUwW//fsYHcQ9bh87SKz
	x5aVN5k8nvZvZffYOesuu8eCTaUem1Z1snlsXlLvsXPHZyaP9/uusnn0bVnF6HFwn6HH501y
	ATxRXDYpqTmZZalF+nYJXBmPZq5mK5gjX3FpWkUD42ypLkZODgkBE4nbH1+ydTFycQgJ7GaU
	uHH+IDtEQlLiU/NUVghbWGLlv+fsEEXPGCV+9/awgCTYBLQkFvXtA0uICJxmkvjR/g/MYRZY
	xSSxbekpJoiW80wSN+Y8YgNp4RSwk7j87DIziC0s4C/RdG8mmM0ioCLxpmk1E4jNK2Ap8Wra
	L0YIW1Di5MwnYOuYBbQleh+2MsLYyxa+Zoa4T0Hi59NlrBBxcYmjP3uA4hxAJ4VJTFkVNoFR
	eBaSSbOQTJqFZNIsJN0LGFlWMUqmFhTnpucWGxYY5qWW6xUn5haX5qXrJefnbmIEpwYtzR2M
	21d90DvEyMTBeIhRgoNZSYT3ot/JdCHelMTKqtSi/Pii0pzU4kOM0hwsSuK84i96U4QE0hNL
	UrNTUwtSi2CyTBycUg1MPUI/s/Tl+z92JAp5H98/Le33Kd3lQcdzHd0nbbHhP8DzOoSpd5re
	/4O6HJOOeDSbPFSYtUYyySFpYySThYWthFfI7pKvprbXp/kuTtyb8X6egK/Q1Zp9H8O9ZOzO
	NMiacTgcUMqYLm736EbE2TUPHqz9ujM+e8sUfqbwXdqfG/o3P75stys3OKBQrDIzWfWRttdq
	bT7LyQkcvZ/apKyvmq3zm+4vOulentPispXRFjrvLn1YnnhUvOQIf5Rm08yZF79o/VESiztR
	55xmdzRMpSFLofj4lq2/PJuilrOXtAlJ+sYlbjcTYtXU6svad6bu/8kySb2nd/mbHT5PebSl
	VIr1k8C7hEVGB2M8PJVYijMSDbWYi4oTATPsM7d8AwAA
X-CMS-MailID: 20250306074847epcas5p286f512436a15d1b62ee1e5cc65b8a291
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250305091852epcas5p18a0853e85a5ed3d36d5d42ef89735ca6
References: <20250305091246.106626-1-swathi.ks@samsung.com>
	<CGME20250305091852epcas5p18a0853e85a5ed3d36d5d42ef89735ca6@epcas5p1.samsung.com>
	<20250305091246.106626-2-swathi.ks@samsung.com>
	<89dcfb2a-d093-48f9-b6d7-af99b383a1bc@kernel.org>
	<00e301db8e49$95bfbf90$c13f3eb0$@samsung.com>
	<a9ddeccf-8fc6-453c-af62-55e895888a77@kernel.org>



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 06 March 2025 12:35
> To: Swathi K S <swathi.ks=40samsung.com>; krzk+dt=40kernel.org;
> andrew+netdev=40lunn.ch; davem=40davemloft.net; edumazet=40google.com;
> kuba=40kernel.org; pabeni=40redhat.com; robh=40kernel.org;
> conor+dt=40kernel.org; richardcochran=40gmail.com;
> mcoquelin.stm32=40gmail.com; alexandre.torgue=40foss.st.com
> Cc: rmk+kernel=40armlinux.org.uk; netdev=40vger.kernel.org;
> devicetree=40vger.kernel.org; linux-stm32=40st-md-mailman.stormreply.com;
> linux-arm-kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org;
> pankaj.dubey=40samsung.com; ravi.patel=40samsung.com;
> gost.dev=40samsung.com
> Subject: Re: =5BPATCH v8 1/2=5D dt-bindings: net: Add FSD EQoS device tre=
e
> bindings
>=20
> On 06/03/2025 04:40, Swathi K S wrote:
> >
> >
> >> -----Original Message-----
> >> From: Krzysztof Kozlowski <krzk=40kernel.org>
> >> Sent: 05 March 2025 21:12
> >> To: Swathi K S <swathi.ks=40samsung.com>; krzk+dt=40kernel.org;
> >> andrew+netdev=40lunn.ch; davem=40davemloft.net;
> edumazet=40google.com;
> >> kuba=40kernel.org; pabeni=40redhat.com; robh=40kernel.org;
> >> conor+dt=40kernel.org; richardcochran=40gmail.com;
> >> mcoquelin.stm32=40gmail.com; alexandre.torgue=40foss.st.com
> >> Cc: rmk+kernel=40armlinux.org.uk; netdev=40vger.kernel.org;
> >> devicetree=40vger.kernel.org; linux-stm32=40st-md-
> mailman.stormreply.com;
> >> linux-arm-kernel=40lists.infradead.org; linux-kernel=40vger.kernel.org=
;
> >> pankaj.dubey=40samsung.com; ravi.patel=40samsung.com;
> >> gost.dev=40samsung.com
> >> Subject: Re: =5BPATCH v8 1/2=5D dt-bindings: net: Add FSD EQoS device
> >> tree bindings
> >>
> >> On 05/03/2025 10:12, Swathi K S wrote:
> >>> Add FSD Ethernet compatible in Synopsys dt-bindings document. Add
> >>> FSD Ethernet YAML schema to enable the DT validation.
> >>>
> >>> Signed-off-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> >>> Signed-off-by: Ravi Patel <ravi.patel=40samsung.com>
> >>> Signed-off-by: Swathi K S <swathi.ks=40samsung.com>
> >>
> >> <form letter>
> >> This is a friendly reminder during the review process.
> >>
> >> It looks like you received a tag and forgot to add it.
> >>
> >> If you do not know the process, here is a short explanation:
> >> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> >> versions of patchset, under or above your Signed-off-by tag, unless
> >> patch changed significantly (e.g. new properties added to the DT
> >> bindings). Tag is =22received=22, when provided in a message replied t=
o you
> on the mailing list.
> >> Tools like b4 can help here. However, there's no need to repost
> >> patches
> >> *only* to add the tags. The upstream maintainer will do that for tags
> >> received on the version they apply.
> >>
> >> Please read:
> >> https://protect2.fireeye.com/v1/url?k=3D19972162-781c345b-1996aa2d-
> >> 000babffae10-7bd6b1a1d78b210b&q=3D1&e=3D94dcc3a6-5303-441a-8c1e-
> >> de696b216f86&u=3Dhttps%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv6.12-
> >> rc3%2Fsource%2FDocumentation%2Fprocess%2Fsubmitting-
> >> patches.rst%23L577
> >>
> >> If a tag was not added on purpose, please state why and what changed.
> >
> > Hi Krzysztof,
> > As per a review comment received from Russell, I had added 2 new
> properties to the DT - assigned-clocks and assigned-clock-parents propert=
ies.
> > The example in the DT binding reflects the same.
> > I felt it wouldn't be fair to add 'Reviewed-by' tag without you reviewi=
ng the
> updates again.
> > But I should have mentioned that in cover letter and apologies for miss=
ing
> to do that.
> Nothing in changelog explained new properties. Nothing mentioned

Had mentioned under 'changes since v7' in the cover letter patch where I ha=
d mentioned about addressing Russell's comment and corresponding DT binding=
 example changes of setting clock tree in DT.

- Swathi=20

> dropping tag, which you always must explicitly say.
>=20
> Best regards,
> Krzysztof


