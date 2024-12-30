Return-Path: <netdev+bounces-154485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBA79FE182
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 01:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256B21880673
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 00:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BC18F6C;
	Mon, 30 Dec 2024 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="j8qzXDZJ"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6172904
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735518609; cv=none; b=D9grg+AcinXkU964W6RvP7LjlaDBrmGCEnLRHnTggBvO6KLr6GdpNOzt/vBdptgv/bhLBAfJDuPRHMCa0Ls1tm8T6c+d6t8BVXbff6Jesmop+/o/0IenitkDASgwpWMtxRKtwF7I6OJwKE3PLfv9QTCtf6P5PY1TL6KePWaIX6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735518609; c=relaxed/simple;
	bh=0OrwvGrMMWRsjQ7fJ7s/fxetnUC2YMhJjAVXNHDqxAA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=S/0wCDmIwyYsnUKGB51rdB6fhQpUP8QknlKVaZM5r2oQWtfS1Us8n8yli8PnuUjXm4se7ZcBp16PI1TejBkE3LjW2LdX9HV3MyuPtIUYLkWhuRLyxmff1kO8xPq0e6kUg/ki5IH+u1BHcW68Icel/iwY45YSnUIylsNiBSmNx6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=j8qzXDZJ; arc=none smtp.client-ip=203.254.224.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout1.samsung.com (KnoxPortal) with ESMTP id 20241230002403epoutp01b667f12c6338ca0ad99629fe8e020872~VzKXMyq7V2364623646epoutp010
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 00:24:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20241230002403epoutp01b667f12c6338ca0ad99629fe8e020872~VzKXMyq7V2364623646epoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1735518243;
	bh=0OrwvGrMMWRsjQ7fJ7s/fxetnUC2YMhJjAVXNHDqxAA=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=j8qzXDZJOzHCmm+90svWWxqvotGhYh/P0cXDOZWmRLBXmBgMrzjBZe4yeittGthiE
	 /+xaa7BPVXZAys4CSgJFph/kOBgJdj0w0De/ka9uPrklOoFhTgCXM4m/vCcFKLA8+o
	 7+qrumKfJx6WaqcSNORxqpFbfmQlZy67Iyv5VY6U=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20241230002402epcas2p19a8f12aacdd93d6f620b78d1f97cc897~VzKVw8Un21601516015epcas2p1G;
	Mon, 30 Dec 2024 00:24:02 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.92]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4YLxfn5MrYz4x9Pr; Mon, 30 Dec
	2024 00:24:01 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.0E.23368.128E1776; Mon, 30 Dec 2024 09:24:01 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20241230002401epcas2p23cc628f42ba3c0e433f6fe40df9ba80b~VzKUk5NXl1106911069epcas2p26;
	Mon, 30 Dec 2024 00:24:01 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241230002401epsmtrp211883c2e1eff6ba5f67609d1b7a9c637~VzKUizCDa1193011930epsmtrp2G;
	Mon, 30 Dec 2024 00:24:01 +0000 (GMT)
X-AuditID: b6c32a45-db1ed70000005b48-e7-6771e8211c7e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	33.5B.33707.028E1776; Mon, 30 Dec 2024 09:24:00 +0900 (KST)
Received: from KORCO117327 (unknown [10.229.60.106]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241230002400epsmtip28c0285b3150cb3807090857739a13694~VzKUQYkww0091800918epsmtip2x;
	Mon, 30 Dec 2024 00:24:00 +0000 (GMT)
From: "Dujeong.lee" <dujeong.lee@samsung.com>
To: "'Eric Dumazet'" <edumazet@google.com>
Cc: "'Youngmin Nam'" <youngmin.nam@samsung.com>, "'Jakub Kicinski'"
	<kuba@kernel.org>, "'Neal Cardwell'" <ncardwell@google.com>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <guo88.liu@samsung.com>, <yiwang.cai@samsung.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<joonki.min@samsung.com>, <hajun.sung@samsung.com>,
	<d7271.choe@samsung.com>, <sw.ju@samsung.com>, <iamyunsu.kim@samsung.com>,
	<kw0619.kim@samsung.com>, <hsl.lim@samsung.com>, <hanbum22.lee@samsung.com>,
	<chaemoo.lim@samsung.com>, <seungjin1.yu@samsung.com>
In-Reply-To: <CANn89iK8Kdpe_uZ2Q8z3k2=d=jUVCV5Z3hZa4jFedUgKm9hesQ@mail.gmail.com>
Subject: RE: [PATCH] tcp: check socket state before calling WARN_ON
Date: Mon, 30 Dec 2024 09:23:55 +0900
Message-ID: <04f401db5a51$1f860810$5e921830$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL4yZmsudMRkH1MkhPtbuC345sC9QKRMuYdAUIxOFgBsMn9rAIf5xWWAZwDXWsBNR7tnQJ0dudGAPMj/mwCPP60LAEh3GCHAj4uPtAC9F+sfAGm2IYkAiMYjOmv8Uri0A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKJsWRmVeSWpSXmKPExsWy7bCmha7ii8J0g7b9qhZvNjFbXNs7kd1i
	zvkWFot1u1qZLJ4ee8RuMXkKo0XT/kvMFgemzGS1eNR/gs1i29vDTBafb71jtri6G0hc2NbH
	ajHx/hQ2i8u75rBZdNzZy2JxbIGYxbfTbxgt/jbdYLdoffyZ3eLj8SZ2i8UHPrE7iHlsWXmT
	yWPBplKPTas62Tze77vK5tG3ZRWjx+dNcgFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
	Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUAvKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
	UnIKzAv0ihNzi0vz0vXyUkusDA0MjEyBChOyM6a8uMFW8Nm34szj7+wNjPe8uxg5OSQETCQ2
	/exm6WLk4hAS2MEocXfDIiYI5xOjxLbXLxnhnMNvG5lhWl49OskOkdjJKPFs410o5yWjxPVZ
	F8Cq2AR0Jf4+m8kOYosIaEmcPTGLFaSIWeAqi8TUv81sIAlOgUCJR0e3sILYwgLOEhP3zgRa
	zsHBIqAqMf13OUiYV8BSon/rfGYIW1Di5MwnLCA2s4C2xLKFr6EuUpD4+XQZ2HwRgUmMEn1X
	GtkgikQkZne2MYMkJAT+c0hM2NEO1eEi8XziGlYIW1ji1fEt7BC2lMTnd3vZIOxiie/XjzBC
	NDcwSnx49BoqYSzRvOwBC8ilzAKaEut36YOYEgLKEkduQR3HJ9Fx+C87RJhXoqNNCKJRVWLr
	gp9QQ6Ql9v54zTqBUWkWktdmIXltFpIPZiHsWsDIsopRLLWgODc9tdiowBAe3cn5uZsYweld
	y3UH4+S3H/QOMTJxMB5ilOBgVhLhPZdUkC7Em5JYWZValB9fVJqTWnyI0RQY1hOZpUST84EZ
	Jq8k3tDE0sDEzMzQ3MjUwFxJnPde69wUIYH0xJLU7NTUgtQimD4mDk6pBqYLxnnlVpXmNzta
	rj+e7r/z3c/jD5x1pfoOmPDMtJv6WGPa7PsuE5oOXV9k+yKi8fOboLtzruZbnxR9c+tJ9fG1
	mRWfZj7P8eo4sva3922Pp3EF5fKTGXiMUvrZ+Zn/xIfP9YxfKrfriOnK96/+H/9TtD1c7GPz
	S+Ob67r8Tx/O32XDve1s5zazVzNCXfOSm6Qzq0Q2LT7le2BRbqFWre4i69lHjZmE/jr9L30t
	uKFNKlJsla3bv3vGLBPUFX+4buybmt/csmxfSFNQ3H0zyQs3Vv7qOPB69Z39fx4fM5/w22Oj
	i/kFYd2a05NmT5tuo5Jxes+0D1ZvrUtub/37033lhZ2TfmVMXrx/qeiRjRzqc5RYijMSDbWY
	i4oTAcDV9TN4BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCSvK7Ci8J0g9YmK4s3m5gtru2dyG4x
	53wLi8W6Xa1MFk+PPWK3mDyF0aJp/yVmiwNTZrJaPOo/wWax7e1hJovPt94xW1zdDSQubOtj
	tZh4fwqbxeVdc9gsOu7sZbE4tkDM4tvpN4wWf5tusFu0Pv7MbvHxeBO7xeIDn9gdxDy2rLzJ
	5LFgU6nHplWdbB7v911l8+jbsorR4/MmuQC2KC6blNSczLLUIn27BK6Muzvnshdc0Ku4976k
	gfGqfBcjJ4eEgInEq0cn2UFsIYHtjBLnpxpDxKUl1l54ww5hC0vcbznC2sXIBVTznFFi09p7
	LCAJNgFdib/PZoIViQhoSZw9MQusiFngLYvErl3LmSA69rJJ3D9+CqyDUyBQ4tHRLawgtrCA
	s8TEvTOBijg4WARUJab/LgcJ8wpYSvRvnc8MYQtKnJz5BKyVWUBbovdhKyOMvWzha2aI6xQk
	fj5dBrZYRGASo0TflUY2iCIRidmdbcwTGIVnIZk1C8msWUhmzULSsoCRZRWjaGpBcW56bnKB
	oV5xYm5xaV66XnJ+7iZGcHxrBe1gXLb+r94hRiYOxkOMEhzMSiK855IK0oV4UxIrq1KL8uOL
	SnNSiw8xSnOwKInzKud0pggJpCeWpGanphakFsFkmTg4pRqY1qczL/iw5aX5+z7PWr9Mk+Mn
	Cx1rZn1gvPHYcelFr4edd/gLD2z40bxf/VvHTHlDRYH02AKpyOZWiwPh6rkbc854Pqs7Zcrp
	qXpSaM1JeTv7kwbxa8oFl0rut5uzdOYtuWmXgg//6Dx4WXzZav9OBZOkKX7LI0L2mst5cZvJ
	Wgns71nyIHqaZeWB/zxXeV4u4Ap6fG1T9dxVa7NLMoPD/JadMcm77/nbe1Xjr1WT5+14vCn1
	Z1jGEzYz1dkPax2sS85f5jROaw5Zu0AgMVesIUNqyyH2A2ZOWQY66j9fFE1n2qnMYOot/+vN
	cn0T33WHuDt2GN+9nXbPyOiD5NXHls3eAhMP5lfzKNbcux+rxFKckWioxVxUnAgANPCE7V4D
	AAA=
X-CMS-MailID: 20241230002401epcas2p23cc628f42ba3c0e433f6fe40df9ba80b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
	<20241203081247.1533534-1-youngmin.nam@samsung.com>
	<CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
	<CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
	<20241203181839.7d0ed41c@kernel.org> <Z0/O1ivIwiVVNRf0@perf>
	<CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
	<Z1KRaD78T3FMffuX@perf>
	<CANn89iKOC9busc9G_akT=H45FvfVjWm97gmCyj=s7_zYJ43T3w@mail.gmail.com>
	<Z1K9WVykZbo6u7uG@perf>
	<CANn89i+BuU+1__zSWgjshFzfxFUttDEpn90V+p8+mVGCHidYAA@mail.gmail.com>
	<000001db4a23$746be360$5d43aa20$@samsung.com>
	<CANn89iLz=U2RW8S+Yy1WpFYb+dyyPR8TwbMpUUEeUpV9X2hYoA@mail.gmail.com>
	<000001db5136$336b1060$9a413120$@samsung.com>
	<CANn89iK8Kdpe_uZ2Q8z3k2=d=jUVCV5Z3hZa4jFedUgKm9hesQ@mail.gmail.com>

On Wed, Dec 18, 2024 7:28 PM Eric Dumazet <edumazet=40google.com> wrote:

> On Wed, Dec 18, 2024 at 11:18=E2=80=AFAM=20Dujeong.lee=20<dujeong.lee=40s=
amsung.com>=0D=0A>=20wrote:=0D=0A>=20>=0D=0A>=20>=20Tue,=20December=2010,=
=202024=20at=204:10=20PM=20Dujeong=20Lee=20wrote:=0D=0A>=20>=20>=20On=20Tue=
,=20Dec=2010,=202024=20at=2012:39=20PM=20Dujeong=20Lee=20wrote:=0D=0A>=20>=
=20>=20>=20On=20Mon,=20Dec=209,=202024=20at=207:21=20PM=20Eric=20Dumazet=20=
<edumazet=40google.com>=0D=0A>=20wrote:=0D=0A>=20>=20>=20>=20>=20On=20Mon,=
=20Dec=209,=202024=20at=2011:16=E2=80=AFAM=20Dujeong.lee=0D=0A>=20>=20>=20>=
=20>=20<dujeong.lee=40samsung.com>=0D=0A>=20>=20>=20>=20>=20wrote:=0D=0A>=
=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20Th=
anks=20for=20all=20the=20details=20on=20packetdrill=20and=20we=20are=20also=
=0D=0A>=20>=20>=20>=20>=20>=20exploring=0D=0A>=20>=20>=20>=20>=20USENIX=202=
013=20material.=0D=0A>=20>=20>=20>=20>=20>=20I=20have=20one=20question.=20T=
he=20issue=20happens=20when=20DUT=20receives=20TCP=0D=0A>=20>=20>=20>=20>=
=20>=20ack=20with=0D=0A>=20>=20>=20>=20>=20large=20delay=20from=20network,=
=20e.g.,=2028seconds=20since=20last=20Tx.=20Is=0D=0A>=20>=20>=20>=20>=20pac=
ketdrill=20able=20to=20emulate=20this=20network=20delay=20(or=20congestion)=
=0D=0A>=20>=20>=20>=20>=20in=20script=0D=0A>=20>=20>=20>=20level?=0D=0A>=20=
>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20Yes,=20the=20packetdrill=20scripts=
=20can=20wait=20an=20arbitrary=20amount=20of=0D=0A>=20>=20>=20>=20>=20time=
=20between=20each=20event=0D=0A>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20+=
28=20<next=20event>=0D=0A>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=2028=20se=
conds=20seems=20okay.=20If=20the=20issue=20was=20triggered=20after=204=20da=
ys,=0D=0A>=20>=20>=20>=20>=20packetdrill=20would=20be=20impractical=20;)=0D=
=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20Hi=20all,=0D=0A>=20>=20>=20>=0D=0A>=
=20>=20>=20>=20We=20secured=20new=20ramdump.=0D=0A>=20>=20>=20>=20Please=20=
find=20the=20below=20values=20with=20TCP=20header=20details.=0D=0A>=20>=20>=
=20>=0D=0A>=20>=20>=20>=20tp->packets_out=20=3D=200=0D=0A>=20>=20>=20>=20tp=
->sacked_out=20=3D=200=0D=0A>=20>=20>=20>=20tp->lost_out=20=3D=201=0D=0A>=
=20>=20>=20>=20tp->retrans_out=20=3D=201=0D=0A>=20>=20>=20>=20tp->rx_opt.sa=
ck_ok=20=3D=205=20(tcp_is_sack(tp))=20mss_cache=20=3D=201400=0D=0A>=20>=20>=
=20>=20((struct=20inet_connection_sock=20*)sk)->icsk_ca_state=20=3D=204=20(=
(struct=0D=0A>=20>=20>=20>=20inet_connection_sock=20*)sk)->icsk_pmtu_cookie=
=20=3D=201500=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20Hex=20from=20ip=20hea=
der:=0D=0A>=20>=20>=20>=2045=2000=2000=2040=2075=2040=2000=2000=2039=2006=
=2091=2013=208E=20FB=202A=20CA=20C0=20A8=2000=20F7=2001=20BB=0D=0A>=20>=20>=
=20>=20A7=20CC=2051=0D=0A>=20>=20>=20>=20F8=2063=20CC=2052=2059=206D=20A6=
=20B0=2010=2004=2004=2077=2076=2000=2000=2001=2001=2008=200A=2089=2072=20C8=
=0D=0A>=20>=20>=20>=2042=0D=0A>=20>=20>=20>=2062=20F5=0D=0A>=20>=20>=20>=20=
F5=20D1=2001=2001=2005=200A=2052=2059=206D=20A5=2052=2059=206D=20A6=0D=0A>=
=20>=20>=20>=0D=0A>=20>=20>=20>=20Transmission=20Control=20Protocol=0D=0A>=
=20>=20>=20>=20Source=20Port:=20443=0D=0A>=20>=20>=20>=20Destination=20Port=
:=2042956=0D=0A>=20>=20>=20>=20TCP=20Segment=20Len:=200=0D=0A>=20>=20>=20>=
=20Sequence=20Number=20(raw):=201375232972=0D=0A>=20>=20>=20>=20Acknowledgm=
ent=20number=20(raw):=201381592486=0D=0A>=20>=20>=20>=201011=20....=20=3D=
=20Header=20Length:=2044=20bytes=20(11)=0D=0A>=20>=20>=20>=20Flags:=200x010=
=20(ACK)=0D=0A>=20>=20>=20>=20Window:=201028=0D=0A>=20>=20>=20>=20Calculate=
d=20window=20size:=201028=0D=0A>=20>=20>=20>=20Urgent=20Pointer:=200=0D=0A>=
=20>=20>=20>=20Options:=20(24=20bytes),=20No-Operation=20(NOP),=20No-Operat=
ion=20(NOP),=0D=0A>=20>=20>=20>=20Timestamps,=20No-Operation=20(NOP),=20No-=
Operation=20(NOP),=20SACK=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20If=20anyo=
ne=20wants=20to=20check=20other=20values,=20please=20feel=20free=20to=20ask=
=20me=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20Thanks,=0D=0A>=20>=20>=20>=20=
Dujeong.=0D=0A>=20>=20>=0D=0A>=20>=20>=20I=20have=20a=20question.=0D=0A>=20=
>=20>=0D=0A>=20>=20>=20From=20the=20latest=20ramdump=20I=20could=20see=20th=
at=0D=0A>=20>=20>=201)=20tcp_sk(sk)->packets_out=20=3D=200=0D=0A>=20>=20>=
=202)=20inet_csk(sk)->icsk_backoff=20=3D=200=0D=0A>=20>=20>=203)=20sk_write=
_queue.len=20=3D=200=0D=0A>=20>=20>=20which=20suggests=20that=20tcp_write_q=
ueue_purge=20was=20indeed=20called.=0D=0A>=20>=20>=0D=0A>=20>=20>=20Noting=
=20that:=0D=0A>=20>=20>=201)=20tcp_write_queue_purge=20reset=20packets_out=
=20to=200=20and=0D=0A>=20>=20>=202)=20in_flight=20should=20be=20non-negativ=
e=20where=20in_flight=20=3D=20packets_out=20-=0D=0A>=20>=20>=20left_out=20+=
=20retrans_out,=20what=20if=20we=20reset=20left_out=20and=20retrans_out=20a=
s=0D=0A>=20>=20>=20well=20in=20tcp_write_queue_purge?=0D=0A>=20>=20>=0D=0A>=
=20>=20>=20Do=20we=20see=20any=20potential=20issue=20with=20this?=0D=0A>=20=
>=0D=0A>=20>=20Hello=20Eric=20and=20Neal.=0D=0A>=20>=0D=0A>=20>=20It=20is=
=20a=20gentle=20reminder.=0D=0A>=20>=20Could=20you=20please=20review=20the=
=20latest=20ramdump=20values=20and=20and=20question?=0D=0A>=20=0D=0A>=20It=
=20will=20have=20to=20wait=20next=20year,=20Neal=20is=20OOO.=0D=0A>=20=0D=
=0A>=20I=20asked=20a=20packetdrill=20reproducer,=20I=20can=20not=20spend=20=
days=20working=20on=20an=20issue=0D=0A>=20that=20does=20not=20trigger=20in=
=20our=20production=20hosts.=0D=0A>=20=0D=0A>=20Something=20could=20be=20wr=
ong=20in=20your=20trees,=20or=20perhaps=20some=20eBPF=20program=0D=0A>=20ch=
anging=20the=20state=20of=20the=20socket...=0D=0A=0D=0AHi=20Eric=0D=0A=0D=
=0AI=20tried=20to=20make=20packetdrill=20script=20for=20local=20mode,=20whi=
ch=20injects=20delayed=20acks=20for=20data=20and=20FIN=20after=20close.=0D=
=0A=0D=0A//=20Test=20basic=20connection=20teardown=20where=20local=20proces=
s=20closes=20first:=0D=0A//=20the=20local=20process=20calls=20close()=20fir=
st,=20so=20we=20send=20a=20FIN.=0D=0A//=20Then=20we=20receive=20an=20delaye=
d=20ACK=20for=20data=20and=20FIN.=0D=0A//=20Then=20we=20receive=20a=20FIN=
=20and=20ACK=20it.=0D=0A=0D=0A=60../common/defaults.sh=60=0D=0A=20=20=20=20=
0=20socket(...,=20SOCK_STREAM,=20IPPROTO_TCP)=20=3D=203=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
//=20Create=20socket=0D=0A=20=20=20+.01...0.011=20connect(3,=20...,=20...)=
=20=3D=200=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Initiate=20connecti=
on=0D=0A=20=20=20+0=20>=20=20S=200:0(0)=20<...>=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Send=20=
SYN=0D=0A=20=20=20+0=20<=20S.=200:0(0)=20ack=201=20win=2032768=20<mss=20100=
0,nop,wscale=206,nop,nop,sackOK>=20=20=20=20=20=20//=20Receive=20SYN-ACK=20=
with=20TCP=20options=0D=0A=20=20=20+0=20>=20=20.=201:1(0)=20ack=201=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20//=20Send=20ACK=0D=0A=0D=0A=20=20=20+0=20write(3,=20...,=201000)=
=20=3D=201000=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20//=20Write=201000=20bytes=0D=0A=20=20=20+0=20>=20=20P.=201:1001(1000)=20=
ack=201=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20//=20Send=20data=20with=20PSH=20flag=0D=0A=0D=0A=20=20=20+0=20close(3)=
=20=3D=200=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Local=20side=20initiates=20c=
lose=0D=0A=20=20=20+0=20>=20=20F.=201001:1001(0)=20ack=201=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Send=20FIN=0D=0A=
=20=20=20+1=20<=20.=201:1(0)=20ack=201001=20win=20257=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Receive=20ACK=20for=20data=
=0D=0A=20=20=20+0=20<=20.=201:1(0)=20ack=201002=20win=20257=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Receive=20ACK=20for=20FIN=
=0D=0A=0D=0A=20=20=20+0=20<=20F.=201:1(0)=20ack=201002=20win=20257=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Receive=20FIN=20from=
=20remote=0D=0A=20=20=20+0=20>=20=20.=201002:1002(0)=20ack=202=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Send=20ACK=
=20for=20FIN=0D=0A=0D=0A=0D=0ABut=20got=20below=20error=20when=20I=20run=20=
the=20script.=0D=0A=0D=0A=24=20sudo=20./packetdrill=20../tcp/close/close-ha=
lf-delayed-ack.pkt=0D=0A../tcp/close/close-half-delayed-ack.pkt:22:=20error=
=20handling=20packet:=20live=20packet=20field=20tcp_fin:=20expected:=200=20=
(0x0)=20vs=20actual:=201=20(0x1)=0D=0Ascript=20packet:=20=201.010997=20.=20=
1002:1002(0)=20ack=202=0D=0Aactual=20packet:=20=200.014840=20F.=201001:1001=
(0)=20ack=201=20win=20256=0D=0A=0D=0AFrom=20the=20log,=20looks=20like=20the=
re=20is=20difference=20between=20script=20and=20actual=20results.=0D=0ACoul=
d=20you=20help=20(provide=20any=20guide)=20to=20check=20why=20this=20error=
=20happens?=0D=0A=0D=0AThanks,=0D=0ADujeong.=0D=0A=0D=0A

