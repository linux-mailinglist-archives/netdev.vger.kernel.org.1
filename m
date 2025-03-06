Return-Path: <netdev+bounces-172298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAD9A54170
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 04:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2D63ADA4B
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 03:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B4719B5B4;
	Thu,  6 Mar 2025 03:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qiGViF3o"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF021199396
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 03:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741233263; cv=none; b=inV1QJu5hqAuM2U4/QXr7a4lyDyiBSysxkUss0SCZ/iczDExsIEOxrDcIIU3BvU7bSMbhAZfZnjnmfzkcjkldTUhhvA1jTt0mIUjwtMgQMMt/jO25Rd0zSbE20ROx6qK9Ot26rnO/oBVdkBtyX28J5keLiBDUT3WK+YzC55QJSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741233263; c=relaxed/simple;
	bh=M+tdIbH/OOQ9B2+GPQFTqQLawkecNMO/8W+4Ii4xSzk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=gGedF3p9c+LsmiNbk6rOp14Zo8RlXZctjYy5aGJqQr4tBy3myQ6rQQK1NlijUOCpdzFWihnIjqA7gjIxR/najYNCaqC5Mvhsmrqj8mwNcMPmpgpzEmfq+y4s0VIv0hn279xiWxghYwJOzz30UN/YHTWC3oySCxd1TZQmThi/kpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=qiGViF3o; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250306035413epoutp036606f5230dc5607fff468b5da8eed8c1~qGmsQb3td1961719617epoutp030
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 03:54:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250306035413epoutp036606f5230dc5607fff468b5da8eed8c1~qGmsQb3td1961719617epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741233253;
	bh=M+tdIbH/OOQ9B2+GPQFTqQLawkecNMO/8W+4Ii4xSzk=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=qiGViF3ogjRaWBCI9FhNDOUwoNPTblslDHBLmJRk2eCEzYc5qrWj+G1Kyt5zkiB6M
	 Q6MIuwEvv3/Q43eiBy4xeLJOnlUS5yv3DqVtXCHV6DOs3gFCzBPE+D8pKt/Y2Dd1I6
	 8atGyNM9fsTo2sxE94UWczir0VTvjGFF9NFrDOYE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20250306035412epcas5p26ae10de1003a9c71415d135415e756d9~qGmrrFaG00784807848epcas5p26;
	Thu,  6 Mar 2025 03:54:12 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.174]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Z7bBp3xQ6z4x9Pt; Thu,  6 Mar
	2025 03:54:10 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6A.7B.19933.26C19C76; Thu,  6 Mar 2025 12:54:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20250306034103epcas5p2f1f67fe07c770d22c74a5ccabe69430f~qGbNDbm5C2061720617epcas5p2M;
	Thu,  6 Mar 2025 03:41:03 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250306034103epsmtrp10afca51e630cdde56b25613551c21e60~qGbNCJhEJ1649016490epsmtrp1J;
	Thu,  6 Mar 2025 03:41:03 +0000 (GMT)
X-AuditID: b6c32a4a-b87c770000004ddd-8f-67c91c626329
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	98.56.33707.F4919C76; Thu,  6 Mar 2025 12:41:03 +0900 (KST)
Received: from FDSFTE596 (unknown [107.122.82.131]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250306034100epsmtip2475c2bc5a013bdb7f4b299ba32f5c694~qGbKRDM9N0050300503epsmtip26;
	Thu,  6 Mar 2025 03:41:00 +0000 (GMT)
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
In-Reply-To: <89dcfb2a-d093-48f9-b6d7-af99b383a1bc@kernel.org>
Subject: RE: [PATCH v8 1/2] dt-bindings: net: Add FSD EQoS device tree
 bindings
Date: Thu, 6 Mar 2025 09:10:49 +0530
Message-ID: <00e301db8e49$95bfbf90$c13f3eb0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-in
Thread-Index: AQHcwqSBZNYxUrKMqce/4F1P5N/GfgGyT6S5AetEnA8CjXdByrMxtKXg
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkl+LIzCtJLcpLzFFi42LZdlhTSzdJ5mS6wZxJshY/X05jtFj+YAer
	xZq955gs5pxvYbGYf+Qcq8XTY4/YLW4e2Mlk8XLWPTaL8+c3sFtc2NbHarHp8TVWi8u75rBZ
	dF17wmox7+9aVotjC8Qsvp1+w2ixaOsXdouHH/awWxw584LZ4lL/RCaL/3t2sDuIely+dpHZ
	Y8vKm0weT/u3snvsnHWX3WPBplKPTas62Tw2L6n32LnjM5PH+31X2Tz6tqxi9Di4z9Dj8ya5
	AJ6obJuM1MSU1CKF1Lzk/JTMvHRbJe/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoF+V
	FMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQUmBXrFibnFpXnpenmpJVaGBgZGpkCF
	CdkZPUf3sxUcF63YseUBWwPjAqEuRk4OCQETicPXVjCD2EICuxklOncUdzFyAdmfGCUevHnI
	BOe8nbGRDabj78bjUImdjBLL3j9mhHBeMEr0f+hlB6liE9CSWNS3D8wWEdjLJPGsMQCkiFlg
	AZPExuOLmUASnAJ2Eh8e9oLZwgKBEnOO3WEEsVkEVCRuT1sA1swrYCkx884HNghbUOLkzCcs
	IDazgLbEsoWvmSFOUpD4+XQZK0RcXOLozx5miMVuEq+efmYHWSwhsJhT4mDDNqgGF4mZK5ez
	Q9jCEq+Ob4GypSRe9rdB2fESq/uuskDYGRJ3f02E+t9e4sCVOUBxDqBlmhLrd+lDhGUlpp5a
	xwRxA59E7+8nTBBxXokd82BsZYm/r69BjZSU2Lb0PfsERqVZSF6bheS1WUjemYWwbQEjyypG
	ydSC4tz01GLTAqO81HJ4jCfn525iBOcFLa8djA8ffNA7xMjEwXiIUYKDWUmE9/Wp4+lCvCmJ
	lVWpRfnxRaU5qcWHGE2B4T2RWUo0OR+YmfJK4g1NLA1MzMzMTCyNzQyVxHmbd7akCwmkJ5ak
	ZqemFqQWwfQxcXBKNTAFzfz49MH2JzIq3hsE95mz2U2f/Ojx5o3TRe7vrmOZlS+7KMpPLNL8
	mfVM4YwXMuntCTaPrK69Ffv5OIKh0T9tgdc6qYdcX/aZhXnaOf4Jqdu/bXvdfdPJ4m0PUh7+
	PGvEO3133LGNy3LPHBVfOLvEWnOVb7PX+frMJEFfoxbZlaVCbbundl77dfyu3FYF3nV294/b
	5a221JblS7B9mnY6yv68jmfHGUbh43WTfh9yM5AL/sF8RNGBWVney2nu/ae7tvtySn9Yp/I+
	9Pf+t3t7bRfuX5XR/7/7vp/dufv/Kuc/q9yz+USt2vLbe4qv/8tTOVkgE3J8gezFhDfZO2sS
	jztHNFQs9L+SJ3iT8f1FJZbijERDLeai4kQA44zLsZQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWy7bCSvK6/5Ml0g/1/5C1+vpzGaLH8wQ5W
	izV7zzFZzDnfwmIx/8g5Vounxx6xW9w8sJPJ4uWse2wW589vYLe4sK2P1WLT42usFpd3zWGz
	6Lr2hNVi3t+1rBbHFohZfDv9htFi0dYv7BYPP+xhtzhy5gWzxaX+iUwW//fsYHcQ9bh87SKz
	x5aVN5k8nvZvZffYOesuu8eCTaUem1Z1snlsXlLvsXPHZyaP9/uusnn0bVnF6HFwn6HH501y
	ATxRXDYpqTmZZalF+nYJXBndN1axFkwTrXj17BBTA+NLwS5GTg4JAROJvxuPM3UxcnEICWxn
	lPi45TEbREJS4lPzVFYIW1hi5b/n7BBFzxgl9q9qBStiE9CSWNS3DywhInCaSeJH+z8wh1lg
	FZPEtqWnoOa+Z5R4/mMJ2CxOATuJDw97mUBsYQF/iaZ7M5lBbBYBFYnb0xawg9i8ApYSM+98
	YIOwBSVOznzCAmIzC2hL9D5sZYSxly18zQxxn4LEz6fLWCHi4hJHf/aAxUUE3CRePf3MPoFR
	eBaSUbOQjJqFZNQsJO0LGFlWMYqmFhTnpucmFxjqFSfmFpfmpesl5+duYgSnBa2gHYzL1v/V
	O8TIxMF4iFGCg1lJhPf1qePpQrwpiZVVqUX58UWlOanFhxilOViUxHmVczpThATSE0tSs1NT
	C1KLYLJMHJxSDUwWyb90Lb7Iak3+17zBgIdF6PmBQ4+DpkUZRGrzqM5vLXQvuMU4b+8fdvfj
	t0ryulKSXj282FD+ZJn2SaMdYn65099U1y58n/A8s2r1dpnO5A6Fx3HKwU5/Feax56fbsax6
	Mjc+/MaMirfvtr8+fthkGXNZd/SNTGWNfwZGBTKpG3l3ma8NKD61KdZ1r13T6R9uK9226W76
	Y3ciuqCgQeqIT4f35tTH9yL2bfxqFRqUKl0pxSdqvX1lpuPsS9O2aciXsrfeXO9UaDPj6+uE
	W4u22B0+7fElb7GDlPDV/k+bA8KVXjyWdt3VpqLt8ly839XdKGBRgKnK70xfnrRXNZ+/HV7K
	+GLvsumJ/B1WO5RYijMSDbWYi4oTAQNZDc96AwAA
X-CMS-MailID: 20250306034103epcas5p2f1f67fe07c770d22c74a5ccabe69430f
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



> -----Original Message-----
> From: Krzysztof Kozlowski <krzk=40kernel.org>
> Sent: 05 March 2025 21:12
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
> On 05/03/2025 10:12, Swathi K S wrote:
> > Add FSD Ethernet compatible in Synopsys dt-bindings document. Add FSD
> > Ethernet YAML schema to enable the DT validation.
> >
> > Signed-off-by: Pankaj Dubey <pankaj.dubey=40samsung.com>
> > Signed-off-by: Ravi Patel <ravi.patel=40samsung.com>
> > Signed-off-by: Swathi K S <swathi.ks=40samsung.com>
>=20
> <form letter>
> This is a friendly reminder during the review process.
>=20
> It looks like you received a tag and forgot to add it.
>=20
> If you do not know the process, here is a short explanation:
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions of patchset, under or above your Signed-off-by tag, unless patch
> changed significantly (e.g. new properties added to the DT bindings). Tag=
 is
> =22received=22, when provided in a message replied to you on the mailing =
list.
> Tools like b4 can help here. However, there's no need to repost patches
> *only* to add the tags. The upstream maintainer will do that for tags
> received on the version they apply.
>=20
> Please read:
> https://protect2.fireeye.com/v1/url?k=3D19972162-781c345b-1996aa2d-
> 000babffae10-7bd6b1a1d78b210b&q=3D1&e=3D94dcc3a6-5303-441a-8c1e-
> de696b216f86&u=3Dhttps%3A%2F%2Felixir.bootlin.com%2Flinux%2Fv6.12-
> rc3%2Fsource%2FDocumentation%2Fprocess%2Fsubmitting-
> patches.rst%23L577
>=20
> If a tag was not added on purpose, please state why and what changed.

Hi Krzysztof,=20
As per a review comment received from Russell, I had added 2 new properties=
 to the DT - assigned-clocks and assigned-clock-parents properties.=20
The example in the DT binding reflects the same.
I felt it wouldn't be fair to add 'Reviewed-by' tag without you reviewing t=
he updates again.
But I should have mentioned that in cover letter and apologies for missing =
to do that.

- Swathi

> </form letter>
>=20
> Best regards,
> Krzysztof


