Return-Path: <netdev+bounces-154886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AC8A00365
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 05:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DC2E1883D43
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 04:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F351B21AC;
	Fri,  3 Jan 2025 04:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fw9I1KnK"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C39E1957FF
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 04:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735877776; cv=none; b=GTu/2PFOjEo1Q9DpdYHNdoTL00RRw4rEFrefJSjK4EuC4u4fCRaORVOCXnDR13CKLkTNI0eIZ5HQGEK76yqa1ATk4T5Bhn6B4vgGUqP4fHRKOZR1DJyl0paCPWO8Khq1UzrYSJTEbq6YXtgDor0XNzPZJ6LCX5GydDXk2dneCr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735877776; c=relaxed/simple;
	bh=gDezkncLjLirQKAHgq1mHzE47qgUoUDBJJac2OXCYHQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=FxWHOJzTXVUT33njuSAoxhc8TtFPod4VyRXoekYoJ5LQAHXlxo9qNrPqs5/2xHJIyyXunRoxjcjm8zhQge4eBy+XJ87M6DCZXSM9f0yicgYtcOzfP3PdPMyTz9EfAR7RT6URbZBvyUTpD6bVMCWsX2tKgdu7REdaxv8M+Cc97kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fw9I1KnK; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20250103041605epoutp034ad28d9ef35838bcbf4da807e05d7de5~XE6Fmwwb41881218812epoutp03N
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 04:16:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20250103041605epoutp034ad28d9ef35838bcbf4da807e05d7de5~XE6Fmwwb41881218812epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1735877765;
	bh=gDezkncLjLirQKAHgq1mHzE47qgUoUDBJJac2OXCYHQ=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=fw9I1KnKBV1BaYC2V1EYQBnhAQT4rvJPK8IqaN7gFHhx3UimiLisqJidVi7cHpWSK
	 0vage1D3Uhd3JJhCLWsSRfHIJribckUqIoFxrqLTcX19RHgPkK//9FXLzKSFkYHKZz
	 NKnRXx7mQ0Yg0iP5CYQysD55pAAQtJdv/EIA/R2s=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20250103041604epcas2p2d36bd607a5b02d3685e10319808e5663~XE6E4CE6V2886828868epcas2p2m;
	Fri,  3 Jan 2025 04:16:04 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.91]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YPVcg5m7Wz4x9Q0; Fri,  3 Jan
	2025 04:16:03 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B8.03.32010.38467776; Fri,  3 Jan 2025 13:16:03 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20250103041603epcas2p12b2c25f178fa11b66966f3e318075a83~XE6DdSZz70149301493epcas2p1n;
	Fri,  3 Jan 2025 04:16:03 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250103041602epsmtrp1943dda41e54fd96dafac832aca146968~XE6Db9AYQ3233232332epsmtrp12;
	Fri,  3 Jan 2025 04:16:02 +0000 (GMT)
X-AuditID: b6c32a4d-abdff70000007d0a-eb-677764836b01
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	6E.3B.33707.28467776; Fri,  3 Jan 2025 13:16:02 +0900 (KST)
Received: from KORCO117327 (unknown [10.229.60.106]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20250103041602epsmtip11eda1a254729271f7d9b1175112205f4~XE6DL_BCB3194131941epsmtip1I;
	Fri,  3 Jan 2025 04:16:02 +0000 (GMT)
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
In-Reply-To: <CANn89iJCYaLuHHt4umWzUHCXHLHtdwThz3uuQ9vFbG9_=eibdg@mail.gmail.com>
Subject: RE: [PATCH] tcp: check socket state before calling WARN_ON
Date: Fri, 3 Jan 2025 13:16:02 +0900
Message-ID: <047c01db5d96$335493a0$99fdbae0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL4yZmsudMRkH1MkhPtbuC345sC9QKRMuYdAUIxOFgBsMn9rAIf5xWWAZwDXWsBNR7tnQJ0dudGAPMj/mwCPP60LAEh3GCHAj4uPtAC9F+sfAGm2IYkAiMYjOkCB8c0QwF3zP4UAZijTW0Bo3uaJq/B9omg
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFJsWRmVeSWpSXmKPExsWy7bCmmW5zSnm6wdyPahZvNjFbXNs7kd1i
	zvkWFot1u1qZLJ4ee8RuMXkKo0XT/kvMFgemzGS1eNR/gs1i29vDTBafb71jtri6G0hc2NbH
	ajHx/hQ2i8u75rBZdNzZy2JxbIGYxbfTbxgt/jbdYLdoffyZ3eLj8SZ2i8UHPrE7iHlsWXmT
	yWPBplKPTas62Tze77vK5tG3ZRWjx+dNcgFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZm
	Boa6hpYW5koKeYm5qbZKLj4Bum6ZOUAvKSmUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVIL
	UnIKzAv0ihNzi0vz0vXyUkusDA0MjEyBChOyMx7fnchUMPkZY0XfrboGxvP3GbsYOTgkBEwk
	dn9l6WLk4hAS2MMocej4N3YI5xOjxOGJcxGcvVeagco4wTq2bdzJBpHYySjx5/dSqP6XjBJf
	9jWwg1SxCehK/H02E8wWEdCSOHtiFitIEbPAVRaJqX+b2UASnAKBEp9XvGMCsYUFnCUm7p0J
	ZrMIqEic+b6FEcTmFbCUuLzwJxOELShxcuYTsDOYBbQlli18zQxxkoLEz6fLwBaICKxilJjb
	tZIdokhEYnZnGzNIQkKgmVNiz4enbBAdLhI3zvZA2cISr45vYYewpSRe9rdB2cUS368fYYRo
	bmCU+PDoNVSDsUTzsgcsoPBjFtCUWL9LHxKUyhJHbkEdxyfRcfgvO0SYV6KjTQiiUVVi64Kf
	UEOkJfb+eM06gVFpFpLXZiF5bRaSD2Yh7FrAyLKKUSq1oDg3PTXZqMBQNy+1HB7nyfm5mxjB
	iV7Ldwfj6/V/9Q4xMnEwHmKU4GBWEuGNCC9JF+JNSaysSi3Kjy8qzUktPsRoCgzwicxSosn5
	wFyTVxJvaGJpYGJmZmhuZGpgriTOe691boqQQHpiSWp2ampBahFMHxMHp1QDE1+ibeX/XbVL
	2iwW/Upkqd/uc9U4J1Lr09kpXQwtt5jiWnsPCl56e+TlOU33wxcizrV2zF3567T+wTOV2vUX
	Lv/aqVSeevMF0zr21inBL6rNHsx5fLZru7Od6tIJZXsufuCK9FiUVGL4J9Di17xyuRfu3n83
	Z7ZbvGlYyV57Wy+cnUXDa2/I/QvJenPVXkrOkGhfox8lcUhx1ZVpv8rfb59n+nazfb4il/C+
	RivfH/L7q5f6Za08susTT8XjL9wMjctt0rMiz6qd+LHstf2kI74u75fnvirxEzZ59mrJBJe8
	tNzm11rTakRLVyo7Ltnb2cRxXSqMcbvy7VMrIi8tj2xfnrH7yJxFPun2ul3P7JRYijMSDbWY
	i4oTAXL26LZ9BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7bCSnG5TSnm6waGXZhZvNjFbXNs7kd1i
	zvkWFot1u1qZLJ4ee8RuMXkKo0XT/kvMFgemzGS1eNR/gs1i29vDTBafb71jtri6G0hc2NbH
	ajHx/hQ2i8u75rBZdNzZy2JxbIGYxbfTbxgt/jbdYLdoffyZ3eLj8SZ2i8UHPrE7iHlsWXmT
	yWPBplKPTas62Tze77vK5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZG9qnsRX0NDNWfHq2
	gq2B8XpwFyMnh4SAicS2jTvZuhi5OIQEtjNKHJx8lBUiIS2x9sIbdghbWOJ+yxFWiKLnjBJn
	Jt5lBEmwCehK/H02E6xIREBL4uyJWWBFzAJvWSR27VrOBNGxkkPi5rt9zCBVnAKBEp9XvGMC
	sYUFnCUm7p0JZrMIqEic+b4FbCqvgKXE5YU/mSBsQYmTM5+wgNjMAtoSvQ9bGWHsZQtfM0Oc
	pyDx8+kysM0iAqsYJeZ2rWSHKBKRmN3ZxjyBUXgWklmzkMyahWTWLCQtCxhZVjGKphYU56bn
	JhcY6hUn5haX5qXrJefnbmIEx7lW0A7GZev/6h1iZOJgPMQowcGsJMIbEV6SLsSbklhZlVqU
	H19UmpNafIhRmoNFSZxXOaczRUggPbEkNTs1tSC1CCbLxMEp1cBknsYn0Zw2Mex3fuiZxqWl
	0/v4rB2XL57L1/yPrS18w8a1tnNSHs7y3dL0Usg75JgGQ8yEupAZF0O+LJU5/LdixtVLXNZm
	TSIrEq//lzQ6Nq30w6FNEQteZ1ew8LhV5zROr/nwmr1/U4tK/ruv7cul1mXIb9DQ3HjtpdQZ
	lxDN7K0u+9o/phlXTWf3mK2xfCV/4PlJGlk7585tZexd+yxuQodC2gGbA3qL8l2el9zM0oj1
	ilvOlyrm76x87Z/DhzLh16VvtaJfNU7qf8xWfr922aJ70+wN1zxy+6BrqVmTs0Wsc0ffqvrD
	u39cfiGvqhmc45Ns9uKxQ3Tv7DuXDUpW2jDZ68f1Lpw0oeqzf7wSS3FGoqEWc1FxIgCPMoXq
	YgMAAA==
X-CMS-MailID: 20250103041603epcas2p12b2c25f178fa11b66966f3e318075a83
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
	<04f401db5a51$1f860810$5e921830$@samsung.com>
	<CANn89iK0g7uqduiAMZ0jax4_Y+P=0pJUArsd=LAhAHa2j+gRAg@mail.gmail.com>
	<088701db5cac$71301b30$53905190$@samsung.com> <CANn89 iJCYaLuHHt4umW
	zUHCXHLHtdwThz3uuQ9vFbG9_=eibdg@mail.gmail.com>

On Thu, Jan 2, 2025 at 5:17 PM Eric Dumazet <edumazet=40google.com>
wrote:

> To: Dujeong.lee <dujeong.lee=40samsung.com>
> Cc: Youngmin Nam <youngmin.nam=40samsung.com>; Jakub Kicinski
> <kuba=40kernel.org>; Neal Cardwell <ncardwell=40google.com>;
> davem=40davemloft.net; dsahern=40kernel.org; pabeni=40redhat.com;
> horms=40kernel.org; guo88.liu=40samsung.com; yiwang.cai=40samsung.com;
> netdev=40vger.kernel.org; linux-kernel=40vger.kernel.org;
> joonki.min=40samsung.com; hajun.sung=40samsung.com; d7271.choe=40samsung.=
com;
> sw.ju=40samsung.com; iamyunsu.kim=40samsung.com; kw0619.kim=40samsung.com=
;
> hsl.lim=40samsung.com; hanbum22.lee=40samsung.com; chaemoo.lim=40samsung.=
com;
> seungjin1.yu=40samsung.com
> Subject: Re: =5BPATCH=5D tcp: check socket state before calling WARN_ON
>=20
> On Thu, Jan 2, 2025 at 1:22=E2=80=AFAM=20Dujeong.lee=20<dujeong.lee=40sam=
sung.com>=20wrote:=0D=0A>=20>=0D=0A>=20>=20On=20Mon,=20Dec=2030,=202024=20a=
t=206:34=20PM=20Eric=20Dumazet=20<edumazet=40google.com>=0D=0A>=20>=20wrote=
:=0D=0A>=20>=20>=0D=0A>=20>=20>=20On=20Mon,=20Dec=2030,=202024=20at=201:24=
=E2=80=AFAM=20Dujeong.lee=0D=0A>=20>=20>=20<dujeong.lee=40samsung.com>=0D=
=0A>=20>=20>=20wrote:=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20On=20Wed,=20D=
ec=2018,=202024=207:28=20PM=20Eric=20Dumazet=20<edumazet=40google.com>=0D=
=0A>=20wrote:=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20On=20Wed,=20Dec=
=2018,=202024=20at=2011:18=E2=80=AFAM=20Dujeong.lee=0D=0A>=20>=20>=20>=20>=
=20<dujeong.lee=40samsung.com>=0D=0A>=20>=20>=20>=20>=20wrote:=0D=0A>=20>=
=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20Tue,=20December=2010,=202024=
=20at=204:10=20PM=20Dujeong=20Lee=20wrote:=0D=0A>=20>=20>=20>=20>=20>=20>=
=20On=20Tue,=20Dec=2010,=202024=20at=2012:39=20PM=20Dujeong=20Lee=20wrote:=
=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20On=20Mon,=20Dec=209,=202024=20at=207:=
21=20PM=20Eric=20Dumazet=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20<edumazet=40g=
oogle.com>=0D=0A>=20>=20>=20>=20>=20wrote:=0D=0A>=20>=20>=20>=20>=20>=20>=
=20>=20>=20On=20Mon,=20Dec=209,=202024=20at=2011:16=E2=80=AFAM=20Dujeong.le=
e=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20>=20<dujeong.lee=40samsung.com>=0D=
=0A>=20>=20>=20>=20>=20>=20>=20>=20>=20wrote:=0D=0A>=20>=20>=20>=20>=20>=20=
>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=
=20>=20>=20>=20>=20>=20Thanks=20for=20all=20the=20details=20on=20packetdril=
l=20and=20we=20are=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20>=20>=20also=20expl=
oring=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20>=20USENIX=202013=20material.=0D=
=0A>=20>=20>=20>=20>=20>=20>=20>=20>=20>=20I=20have=20one=20question.=20The=
=20issue=20happens=20when=20DUT=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20>=20>=
=20receives=20TCP=20ack=20with=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20>=20lar=
ge=20delay=20from=20network,=20e.g.,=2028seconds=20since=20last=20Tx.=0D=0A=
>=20>=20>=20>=20>=20>=20>=20>=20>=20Is=20packetdrill=20able=20to=20emulate=
=20this=20network=20delay=20(or=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20>=20co=
ngestion)=20in=20script=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20level?=0D=0A>=
=20>=20>=20>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20>=20Y=
es,=20the=20packetdrill=20scripts=20can=20wait=20an=20arbitrary=0D=0A>=20>=
=20>=20>=20>=20>=20>=20>=20>=20amount=20of=20time=20between=20each=20event=
=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20>=20>=
=20>=20+28=20<next=20event>=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20>=0D=0A>=
=20>=20>=20>=20>=20>=20>=20>=20>=2028=20seconds=20seems=20okay.=20If=20the=
=20issue=20was=20triggered=20after=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20>=
=204=20days,=20packetdrill=20would=20be=20impractical=20;)=0D=0A>=20>=20>=
=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20Hi=20all,=0D=0A>=
=20>=20>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20We=20secu=
red=20new=20ramdump.=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20Please=20find=20t=
he=20below=20values=20with=20TCP=20header=20details.=0D=0A>=20>=20>=20>=20>=
=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20tp->packets_out=20=3D=200=
=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20tp->sacked_out=20=3D=200=0D=0A>=20>=
=20>=20>=20>=20>=20>=20>=20tp->lost_out=20=3D=201=0D=0A>=20>=20>=20>=20>=20=
>=20>=20>=20tp->retrans_out=20=3D=201=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20=
tp->rx_opt.sack_ok=20=3D=205=20(tcp_is_sack(tp))=20mss_cache=20=3D=201400=
=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20((struct=20inet_connection_sock=20*)s=
k)->icsk_ca_state=20=3D=204=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20((struct=
=20inet_connection_sock=20*)sk)->icsk_pmtu_cookie=20=3D=0D=0A>=20>=20>=20>=
=20>=20>=20>=20>=201500=0D=0A>=20>=20>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=
=20>=20>=20>=20>=20>=20Hex=20from=20ip=20header:=0D=0A>=20>=20>=20>=20>=20>=
=20>=20>=2045=2000=2000=2040=2075=2040=2000=2000=2039=2006=2091=2013=208E=
=20FB=202A=20CA=20C0=20A8=2000=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20F7=2001=
=20BB=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20A7=20CC=2051=0D=0A>=20>=20>=20>=
=20>=20>=20>=20>=20F8=2063=20CC=2052=2059=206D=20A6=20B0=2010=2004=2004=207=
7=2076=2000=2000=2001=2001=2008=200A=0D=0A>=20>=20>=20>=20>=20>=20>=20>=208=
9=2072=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20C8=0D=0A>=20>=20>=20>=20>=20>=
=20>=20>=2042=0D=0A>=20>=20>=20>=20>=20>=20>=20>=2062=20F5=0D=0A>=20>=20>=
=20>=20>=20>=20>=20>=20F5=20D1=2001=2001=2005=200A=2052=2059=206D=20A5=2052=
=2059=206D=20A6=0D=0A>=20>=20>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=
=20>=20>=20>=20Transmission=20Control=20Protocol=20Source=20Port:=20443=20D=
estination=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20Port:=2042956=20TCP=20Segme=
nt=20Len:=200=20Sequence=20Number=20(raw):=0D=0A>=20>=20>=20>=20>=20>=20>=
=20>=201375232972=20Acknowledgment=20number=20(raw):=0D=0A>=20>=20>=20>=20>=
=20>=20>=20>=201381592486=0D=0A>=20>=20>=20>=20>=20>=20>=20>=201011=20....=
=20=3D=20Header=20Length:=2044=20bytes=20(11)=0D=0A>=20>=20>=20>=20>=20>=20=
>=20>=20Flags:=200x010=20(ACK)=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20Window:=
=201028=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20Calculated=20window=20size:=20=
1028=20Urgent=20Pointer:=200=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20Options:=
=20(24=20bytes),=20No-Operation=20(NOP),=20No-Operation=0D=0A>=20>=20>=20>=
=20>=20>=20>=20>=20(NOP),=20Timestamps,=20No-Operation=20(NOP),=20No-Operat=
ion=20(NOP),=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20SACK=0D=0A>=20>=20>=20>=
=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20If=20anyone=20wants=
=20to=20check=20other=20values,=20please=20feel=20free=20to=0D=0A>=20>=20>=
=20>=20>=20>=20>=20>=20ask=20me=0D=0A>=20>=20>=20>=20>=20>=20>=20>=0D=0A>=
=20>=20>=20>=20>=20>=20>=20>=20Thanks,=0D=0A>=20>=20>=20>=20>=20>=20>=20>=
=20Dujeong.=0D=0A>=20>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20>=
=20I=20have=20a=20question.=0D=0A>=20>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=
=20>=20>=20>=20>=20From=20the=20latest=20ramdump=20I=20could=20see=20that=
=0D=0A>=20>=20>=20>=20>=20>=20>=201)=20tcp_sk(sk)->packets_out=20=3D=200=0D=
=0A>=20>=20>=20>=20>=20>=20>=202)=20inet_csk(sk)->icsk_backoff=20=3D=200=0D=
=0A>=20>=20>=20>=20>=20>=20>=203)=20sk_write_queue.len=20=3D=200=0D=0A>=20>=
=20>=20>=20>=20>=20>=20which=20suggests=20that=20tcp_write_queue_purge=20wa=
s=20indeed=20called.=0D=0A>=20>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=
=20>=20>=20Noting=20that:=0D=0A>=20>=20>=20>=20>=20>=20>=201)=20tcp_write_q=
ueue_purge=20reset=20packets_out=20to=200=20and=0D=0A>=20>=20>=20>=20>=20>=
=20>=202)=20in_flight=20should=20be=20non-negative=20where=20in_flight=20=
=3D=0D=0A>=20>=20>=20>=20>=20>=20>=20packets_out=20-=20left_out=20+=20retra=
ns_out,=20what=20if=20we=20reset=0D=0A>=20>=20>=20>=20>=20>=20>=20left_out=
=20and=20retrans_out=20as=20well=20in=20tcp_write_queue_purge?=0D=0A>=20>=
=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20>=20Do=20we=20see=20any=
=20potential=20issue=20with=20this?=0D=0A>=20>=20>=20>=20>=20>=0D=0A>=20>=
=20>=20>=20>=20>=20Hello=20Eric=20and=20Neal.=0D=0A>=20>=20>=20>=20>=20>=0D=
=0A>=20>=20>=20>=20>=20>=20It=20is=20a=20gentle=20reminder.=0D=0A>=20>=20>=
=20>=20>=20>=20Could=20you=20please=20review=20the=20latest=20ramdump=20val=
ues=20and=20and=0D=0A>=20question?=0D=0A>=20>=20>=20>=20>=0D=0A>=20>=20>=20=
>=20>=20It=20will=20have=20to=20wait=20next=20year,=20Neal=20is=20OOO.=0D=
=0A>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20I=20asked=20a=20packetdrill=
=20reproducer,=20I=20can=20not=20spend=20days=20working=0D=0A>=20>=20>=20>=
=20>=20on=20an=20issue=20that=20does=20not=20trigger=20in=20our=20productio=
n=20hosts.=0D=0A>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20Something=20coul=
d=20be=20wrong=20in=20your=20trees,=20or=20perhaps=20some=20eBPF=0D=0A>=20>=
=20>=20>=20>=20program=20changing=20the=20state=20of=20the=20socket...=0D=
=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20Hi=20Eric=0D=0A>=20>=20>=20>=0D=0A>=
=20>=20>=20>=20I=20tried=20to=20make=20packetdrill=20script=20for=20local=
=20mode,=20which=20injects=0D=0A>=20>=20>=20>=20delayed=0D=0A>=20>=20>=20ac=
ks=20for=20data=20and=20FIN=20after=20close.=0D=0A>=20>=20>=20>=0D=0A>=20>=
=20>=20>=20//=20Test=20basic=20connection=20teardown=20where=20local=20proc=
ess=20closes=20first:=0D=0A>=20>=20>=20>=20//=20the=20local=20process=20cal=
ls=20close()=20first,=20so=20we=20send=20a=20FIN.=0D=0A>=20>=20>=20>=20//=
=20Then=20we=20receive=20an=20delayed=20ACK=20for=20data=20and=20FIN.=0D=0A=
>=20>=20>=20>=20//=20Then=20we=20receive=20a=20FIN=20and=20ACK=20it.=0D=0A>=
=20>=20>=20>=0D=0A>=20>=20>=20>=20=60../common/defaults.sh=60=0D=0A>=20>=20=
>=20>=20=20=20=20=200=20socket(...,=20SOCK_STREAM,=20IPPROTO_TCP)=20=3D=203=
=0D=0A>=20//=0D=0A>=20>=20>=20Create=20socket=0D=0A>=20>=20>=20>=20=20=20=
=20+.01...0.011=20connect(3,=20...,=20...)=20=3D=200=0D=0A>=20//=0D=0A>=20>=
=20>=20Initiate=20connection=0D=0A>=20>=20>=20>=20=20=20=20+0=20>=20=20S=20=
0:0(0)=20<...>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20//=0D=0A>=20Send=0D=0A>=20>=20>=20SYN=0D=0A>=
=20>=20>=20>=20=20=20=20+0=20<=20S.=200:0(0)=20ack=201=20win=2032768=20<mss=
=201000,nop,wscale=0D=0A>=20>=20>=20>=206,nop,nop,sackOK>=0D=0A>=20>=20>=20=
//=20Receive=20SYN-ACK=20with=20TCP=20options=0D=0A>=20>=20>=20>=20=20=20=
=20+0=20>=20=20.=201:1(0)=20ack=201=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=0D=0A>=20Send=0D=0A>=
=20>=20>=20ACK=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20=20=20=20+0=20write(=
3,=20...,=201000)=20=3D=201000=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20//=0D=0A>=20>=20>=20Write=201000=20bytes=0D=0A>=20>=20>=
=20>=20=20=20=20+0=20>=20=20P.=201:1001(1000)=20ack=201=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=0D=0A>=20Send=0D=0A>=
=20>=20>=20data=20with=20PSH=20flag=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=
=20=20=20=20+0=20close(3)=20=3D=200=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=0D=0A>=
=20Local=0D=0A>=20>=20>=20side=20initiates=20close=0D=0A>=20>=20>=20>=20=20=
=20=20+0=20>=20=20F.=201001:1001(0)=20ack=201=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20//=0D=0A>=20Send=0D=0A>=20>=20>=20FI=
N=0D=0A>=20>=20>=20>=20=20=20=20+1=20<=20.=201:1(0)=20ack=201001=20win=2025=
7=0D=0A>=20//=0D=0A>=20>=20>=20Receive=20ACK=20for=20data=0D=0A>=20>=20>=20=
>=20=20=20=20+0=20<=20.=201:1(0)=20ack=201002=20win=20257=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=0D=0A>=20>=20>=20Receive=20ACK=
=20for=20FIN=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20=20=20=20+0=20<=20F.=
=201:1(0)=20ack=201002=20win=20257=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20//=0D=0A>=20>=20>=20Receive=20FIN=20from=20remote=0D=0A>=
=20>=20>=20>=20=20=20=20+0=20>=20=20.=201002:1002(0)=20ack=202=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=0D=0A>=20Sen=
d=0D=0A>=20>=20>=20ACK=20for=20FIN=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=0D=
=0A>=20>=20>=20>=20But=20got=20below=20error=20when=20I=20run=20the=20scrip=
t.=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20=24=20sudo=20./packetdrill=20../=
tcp/close/close-half-delayed-ack.pkt=0D=0A>=20>=20>=20>=20../tcp/close/clos=
e-half-delayed-ack.pkt:22:=20error=20handling=20packet:=0D=0A>=20>=20>=20>=
=20live=20packet=20field=20tcp_fin:=20expected:=200=20(0x0)=20vs=20actual:=
=201=20(0x1)=0D=0A>=20>=20>=20>=20script=0D=0A>=20>=20>=20>=20packet:=20=20=
1.010997=20.=201002:1002(0)=20ack=202=20actual=20packet:=20=200.014840=20F.=
=0D=0A>=20>=20>=20>=201001:1001(0)=20ack=201=20win=20256=0D=0A>=20>=20>=0D=
=0A>=20>=20>=20This=20means=20the=20FIN=20was=20retransmited=20earlier.=0D=
=0A>=20>=20>=20Then=20the=20data=20segment=20was=20probably=20also=20retran=
smit.=0D=0A>=20>=20>=0D=0A>=20>=20>=20You=20can=20use=20=22tcpdump=20-i=20a=
ny=20&=22=20while=20developing=20your=20script.=0D=0A>=20>=20>=0D=0A>=20>=
=20>=20=20=20=20=200=20socket(...,=20SOCK_STREAM,=20IPPROTO_TCP)=20=3D=203=
=0D=0A>=20>=20>=20=20=20=20=20=20=20=20//=20Create=20socket=0D=0A>=20>=20>=
=20=20=20=20+.01...0.111=20connect(3,=20...,=20...)=20=3D=200=0D=0A>=20>=20=
>=20=20=20=20=20=20=20=20//=20Initiate=20connection=0D=0A>=20>=20>=20=20=20=
=20+0=20>=20=20S=200:0(0)=20<...>=0D=0A>=20>=20>=20=20=20=20=20=20=20=20//=
=20Send=20SYN=0D=0A>=20>=20>=20=20=20+.1=20<=20S.=200:0(0)=20ack=201=20win=
=2032768=20<mss=201000,nop,wscale=0D=0A>=20>=20>=206,nop,nop,sackOK>=20=20=
=20=20=20=20//=20Receive=20SYN-ACK=20with=20TCP=20options=0D=0A>=20>=20>=20=
=20=20=20+0=20>=20=20.=201:1(0)=20ack=201=0D=0A>=20>=20>=20=20=20=20=20=20=
=20=20//=20Send=20ACK=0D=0A>=20>=20>=0D=0A>=20>=20>=20=20=20=20+0=20write(3=
,=20...,=201000)=20=3D=201000=0D=0A>=20>=20>=20=20=20=20=20=20=20=20//=20Wr=
ite=201000=20bytes=0D=0A>=20>=20>=20=20=20=20+0=20>=20=20P.=201:1001(1000)=
=20ack=201=0D=0A>=20>=20>=20=20=20=20=20=20=20=20//=20Send=20data=20with=20=
PSH=20flag=0D=0A>=20>=20>=0D=0A>=20>=20>=20=20=20=20+0=20close(3)=20=3D=200=
=0D=0A>=20>=20>=20=20=20=20=20=20=20=20//=20Local=20side=20initiates=20clos=
e=0D=0A>=20>=20>=20=20=20=20+0=20>=20=20F.=201001:1001(0)=20ack=201=0D=0A>=
=20>=20>=20=20=20=20=20=20=20=20//=20Send=20FIN=0D=0A>=20>=20>=20=20=20+.2=
=20>=20=20F.=201001:1001(0)=20ack=201=20=20=20=20//=20FIN=20retransmit=0D=
=0A>=20>=20>=20+.2=7E+.4=20>=20=20P.=201:1001(1000)=20ack=201=20//=20RTX=0D=
=0A>=20>=20>=0D=0A>=20>=20>=20=20=20=20+0=20<=20.=201:1(0)=20ack=201001=20w=
in=20257=0D=0A>=20>=20>=20=20=20=20=20=20=20=20=20//=20Receive=20ACK=20for=
=20data=0D=0A>=20>=20>=20=20=20=20+0=20>=20F.=201001:1001(0)=20ack=201=20//=
=20FIN=20retransmit=0D=0A>=20>=20>=20=20=20=20+0=20<=20.=201:1(0)=20ack=201=
002=20win=20257=0D=0A>=20>=20>=20=20=20=20=20=20=20=20//=20Receive=20ACK=20=
for=20FIN=0D=0A>=20>=20>=0D=0A>=20>=20>=20=20=20=20+0=20<=20F.=201:1(0)=20a=
ck=201002=20win=20257=0D=0A>=20>=20>=20=20=20=20=20=20=20=20//=20Receive=20=
FIN=20from=20remote=0D=0A>=20>=20>=20=20=20=20+0=20>=20=20.=201002:1002(0)=
=20ack=202=0D=0A>=20>=20>=20=20=20=20=20=20=20=20//=20Send=20ACK=20for=20FI=
N=0D=0A>=20>=0D=0A>=20>=20Hi=20Eric,=0D=0A>=20>=0D=0A>=20>=20I=20modified=
=20the=20script=20and=20inlined=20tcpdump=20capture=0D=0A>=20>=0D=0A>=20>=
=20=60../common/defaults.sh=60=0D=0A>=20>=20=20=20=20=200=20socket(...,=20S=
OCK_STREAM,=20IPPROTO_TCP)=20=3D=203=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=0D=0A>=20Create=20=
socket=0D=0A>=20>=20=20=20=20+.01...0.011=20connect(3,=20...,=20...)=20=3D=
=200=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=0D=0A>=20Initiate=20connect=
ion=0D=0A>=20>=20=20=20=20+0=20>=20=20S=200:0(0)=20<...>=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=
=20Send=0D=0A>=20SYN=0D=0A>=20>=201=200.000000=20192.168.114.235=20192.0.2.=
1=20TCP=2080=2040784=20=E2=86=92=208080=20=5BSYN=5D=20Seq=3D0=0D=0A>=20>=20=
Win=3D65535=20Len=3D0=20MSS=3D1460=20SACK_PERM=20TSval=3D2913446377=20TSecr=
=3D0=20WS=3D256=0D=0A>=20>=0D=0A>=20>=20=20=20=20+0=20<=20S.=200:0(0)=20ack=
=201=20win=2032768=20<mss=201000,nop,wscale=206,nop,nop,sackOK>=0D=0A>=20//=
=20Receive=20SYN-ACK=20with=20TCP=20options=0D=0A>=20>=202=200.000209=20192=
.0.2.1=20192.168.114.235=20TCP=2072=208080=20=E2=86=92=2040784=20=5BSYN,=20=
ACK=5D=0D=0A>=20>=20Seq=3D0=20Ack=3D1=20Win=3D32768=20Len=3D0=20MSS=3D1000=
=20WS=3D64=20SACK_PERM=0D=0A>=20>=0D=0A>=20>=20=20=20=20+0=20>=20=20.=201:1=
(0)=20ack=201=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20//=20Send=0D=0A>=20ACK=0D=0A>=20>=203=200.000=
260=20192.168.114.235=20192.0.2.1=20TCP=2060=2040784=20=E2=86=92=208080=20=
=5BACK=5D=20Seq=3D1=0D=0A>=20>=20Ack=3D1=20Win=3D65536=20Len=3D0=0D=0A>=20>=
=0D=0A>=20>=20=20=20=20+0=20write(3,=20...,=201000)=20=3D=201000=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=0D=0A>=20Write=201=
000=20bytes=0D=0A>=20>=20=20=20=20+0=20>=20=20P.=201:1001(1000)=20ack=201=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20S=
end=0D=0A>=20data=20with=20PSH=20flag=0D=0A>=20>=204=200.000344=20192.168.1=
14.235=20192.0.2.1=20TCP=201060=2040784=20=E2=86=92=208080=20=5BPSH,=20ACK=
=5D=0D=0A>=20>=20Seq=3D1=20Ack=3D1=20Win=3D65536=20Len=3D1000=0D=0A>=20>=0D=
=0A>=20>=20=20=20=20+0=20close(3)=20=3D=200=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
//=20Local=0D=0A>=20side=20initiates=20close=0D=0A>=20>=20=20=20=20+0=20>=
=20=20F.=201001:1001(0)=20ack=201=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20//=20Send=0D=0A>=20FIN=0D=0A>=20>=205=200.000381=
=20192.168.114.235=20192.0.2.1=20TCP=2060=2040784=20=E2=86=92=208080=20=5BF=
IN,=20ACK=5D=0D=0A>=20>=20Seq=3D1001=20Ack=3D1=20Win=3D65536=20Len=3D0=0D=
=0A>=20>=0D=0A>=20>=20=20=20=20+.2=20>=20=20F.=201001:1001(0)=20ack=201=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20FIN=0D=
=0A>=20retransmit=0D=0A>=20>=206=200.004545=20192.168.114.235=20192.0.2.1=
=20TCP=2060=20=5BTCP=20Retransmission=5D=2040784=0D=0A>=20>=20=E2=86=92=208=
080=20=5BFIN,=20ACK=5D=20Seq=3D1001=20Ack=3D1=20Win=3D65536=20Len=3D0=0D=0A=
>=20>=0D=0A>=20>=20=20=20=20+.2=7E+.4=20>=20=20P.=201:1001(1000)=20ack=201=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20RTX=0D=0A>=20>=
=20=20=20=20+0=20<=20.=201:1(0)=20ack=201001=20win=20257=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=0D=0A>=20Receive=20ACK=20for=
=20data=0D=0A>=20>=20=20=20=20+0=20<=20.=201:1(0)=20ack=201002=20win=20257=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=0D=0A>=20Rec=
eive=20ACK=20for=20FIN=0D=0A>=20>=0D=0A>=20>=20=20=20=20+0=20<=20F.=201:1(0=
)=20ack=201002=20win=20257=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20//=0D=0A>=20Receive=20FIN=20from=20remote=0D=0A>=20>=20=20=20=20+0=
=20>=20=20.=201002:1002(0)=20ack=202=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20//=20Send=0D=0A>=20ACK=20for=20FIN=0D=0A>=
=20>=0D=0A>=20>=0D=0A>=20>=20And=20hit=20below=20error.=0D=0A>=20>=20../tcp=
/close/close-half-delayed-ack.pkt:18:=20error=20handling=20packet:=0D=0A>=
=20>=20timing=20error:=20expected=20outbound=20packet=20at=200.210706=20sec=
=20but=20happened=20at=0D=0A>=20>=200.014838=20sec;=20tolerance=200.025002=
=20sec=20script=20packet:=20=200.210706=20F.=0D=0A>=20>=201001:1001(0)=20ac=
k=201=20actual=20packet:=20=200.014838=20F.=201001:1001(0)=20ack=201=20win=
=0D=0A>=20>=20256=0D=0A>=20>=0D=0A>=20>=20For=20me,=20it=20looks=20like=20d=
elay=20in=20below=20line=20does=20not=20take=20effect=20by=0D=0A>=20packetd=
rill.=0D=0A>=20>=20+.2=20>=20=20F.=201001:1001(0)=20ack=201=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20FIN=0D=0A>=20retran=
smit=0D=0A>=20=0D=0A>=20I=20think=20you=20misunderstood=20how=20packetdrill=
=20works.=0D=0A>=20=0D=0A>=20In=20packetdrill,=20you=20can=20specify=20dela=
ys=20for=20incoming=20packets=20(to=20account=0D=0A>=20for=20network=20dela=
ys,=20or=20remote=20TCP=20stack=20bugs/behavior)=0D=0A>=20=0D=0A>=20But=20o=
utgoing=20packets=20are=20generated=20by=20the=20kernel=20TCP=20stack.=0D=
=0A>=20Packetdrill=20checks=20that=20these=20packets=20have=20the=20expecte=
d=20layouts=20and=20sent=0D=0A>=20at=20the=20expected=20time.=0D=0A=0D=0A=
=0D=0AHi=20Eric=20and=20Neal=0D=0A=0D=0AThanks=20for=20explanation.=0D=0ANo=
w=20I=20updated=20script=20based=20on=20local=20packet=20Tx=20pattern=20bas=
ed=20on=20tcpdump=0D=0Aand=20injected=20delay=20for=20remote=20packet.=20No=
w=20it=20works=20without=20any=20issue.=0D=0A//=20Test=20basic=20connection=
=20teardown=20where=20local=20process=20closes=20first:=0D=0A//=20the=20loc=
al=20process=20calls=20close()=20first,=20so=20we=20send=20a=20FIN.=0D=0A//=
=20Then=20we=20receive=20an=20delayed=20ACK=20for=20data=20and=20FIN.=0D=0A=
//=20Then=20we=20receive=20a=20FIN=20and=20ACK=20it.=0D=0A=0D=0A=60../commo=
n/defaults.sh=60=0D=0A=20=20=20=200=20socket(...,=20SOCK_STREAM,=20IPPROTO_=
TCP)=20=3D=203=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20//=20Create=20socket=0D=0A=20=20=20+.01...=
0.011=20connect(3,=20...,=20...)=20=3D=200=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20//=20Initiate=20connection=0D=0A=20=20=20+0=20>=20=20S=200:0(0)=20<..=
.>=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20//=20Send=20SYN=0D=0A=20=20=20+0=20<=20S.=200:0(0)=20ack=
=201=20win=2032768=20<mss=201000,nop,wscale=206,nop,nop,sackOK>=20=20=20=20=
=20=20//=20Receive=20SYN-ACK=20with=20TCP=20options=0D=0A=20=20=20+0=20>=20=
=20.=201:1(0)=20ack=201=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Send=20ACK=0D=0A=0D=0A=20=20=20=
+0=20write(3,=20...,=201000)=20=3D=201000=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20//=20Write=201000=20bytes=0D=0A=0D=0A=20=20=
=20+0=20>=20=20P.=201:1001(1000)=20ack=201=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20//=20Send=20data=20with=20PSH=20flag=0D=
=0A=0D=0A=20=20=20+0=20close(3)=20=3D=200=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=
=20Local=20side=20initiates=20close=0D=0A=0D=0A=20=20=20+0=20>=20=20F.=2010=
01:1001(0)=20ack=201=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20//=20Send=20FIN=0D=0A=0D=0A=20=20=20+0=20>=20=20F.=201001:10=
01(0)=20ack=201=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20//=20FIN=20retransmit=0D=0A=0D=0A=20=20=20+.2=20=20>=20=20P.=201:1=
001(1000)=20ack=201=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20//=20RTX=0D=0A=20=20=20+.4=20=20>=20=20P.=201:1001(1000)=20ack=201=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20RTX=0D=
=0A=20=20=20+.8=20=20>=20=20P.=201:1001(1000)=20ack=201=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20RTX=0D=0A=20=20=20+1.6=20=
>=20=20P.=201:1001(1000)=20ack=201=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20//=20RTX=0D=0A=20=20=20+3.2=20>=20=20P.=201:1001(10=
00)=20ack=201=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20//=20RTX=0D=0A=20=20=20+6.4=20>=20=20P.=201:1001(1000)=20ack=201=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20RTX=0D=0A=20=
=20=20+13=20=20>=20=20P.=201:1001(1000)=20ack=201=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20//=20RTX=0D=0A=20=20=20+26=20=20>=20=
=20P.=201:1001(1000)=20ack=201=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20//=20RTX=0D=0A=0D=0A=20=20=20+1=20<=20.=201:1(0)=20ack=20=
1002=20win=20257=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
//=20Receive=20ACK=20for=20FIN=0D=0A=0D=0A=20=20=20+1=20<=20.=201:1(0)=20ac=
k=201001=20win=20257=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20//=20Receive=20ACK=20for=20data=0D=0A=0D=0A=20=20=20+0=20<=20F.=201:1(0)=
=20ack=201002=20win=20257=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20//=20Receive=20FIN=20from=20remote=0D=0A=0D=0AWe=20will=20develop=
=20the=20script=20to=20reliably=20reproduce=20the=20case.=0D=0AMaybe=20we=
=20need=20to=20get=20good=20tcpdump=20trace=20when=20issue=20happens.=20But=
=20it=20would=20take=20sometime.=0D=0A=0D=0AIn=20the=20meantime,=20since=20=
we=20have=20complete=20set=20of=20ramdump=20snapshot,=20it=20would=20be=20a=
ppreciated=20if=20Neal=20could=20find=20anything=20from=20the=20values=20I=
=20provided=20earlier.=0D=0A=0D=0Atp->packets_out=20=3D=200=0D=0Atp->sacked=
_out=20=3D=200=0D=0Atp->lost_out=20=3D=201=0D=0Atp->retrans_out=20=3D=201=
=0D=0Atp->rx_opt.sack_ok=20=3D=205=20(tcp_is_sack(tp))=20mss_cache=20=3D=20=
1400=0D=0A((struct=20inet_connection_sock=20*)sk)->icsk_ca_state=20=3D=204=
=20=0D=0A((struct=20inet_connection_sock=20*)sk)->icsk_pmtu_cookie=20=3D=20=
1500=0D=0AHex=20from=20ip=20header:=0D=0A45=2000=2000=2040=2075=2040=2000=
=2000=2039=2006=2091=2013=208E=20FB=202A=20CA=20C0=20A8=2000=20F7=2001=20BB=
=20A7=20=0D=0ACC=2051=0D=0AF8=2063=20CC=2052=2059=206D=20A6=20B0=2010=2004=
=2004=2077=2076=2000=2000=2001=2001=2008=200A=2089=2072=20C8=2042=0D=0A62=
=20F5=0D=0AF5=20D1=2001=2001=2005=200A=2052=2059=206D=20A5=2052=2059=206D=
=20A6=0D=0ATransmission=20Control=20Protocol=0D=0ASource=20Port:=20443=0D=
=0ADestination=20Port:=2042956=0D=0ATCP=20Segment=20Len:=200=0D=0ASequence=
=20Number=20(raw):=201375232972=0D=0AAcknowledgment=20number=20(raw):=20138=
1592486=0D=0A1011=20....=20=3D=20Header=20Length:=2044=20bytes=20(11)=0D=0A=
Flags:=200x010=20(ACK)=0D=0AWindow:=201028=0D=0ACalculated=20window=20size:=
=201028=0D=0AUrgent=20Pointer:=200=0D=0AOptions:=20(24=20bytes),=20No-Opera=
tion=20(NOP),=20No-Operation=20(NOP),=20=0D=0ATimestamps,=20No-Operation=20=
(NOP),=20No-Operation=20(NOP),=20SACK=0D=0A=0D=0AThanks,=0D=0ADujeong.=0D=
=0A=0D=0A

