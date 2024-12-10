Return-Path: <netdev+bounces-150537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2F89EA94C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 08:10:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8A511889156
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 07:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31C22B5B9;
	Tue, 10 Dec 2024 07:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eG/tWMbA"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394352248A1
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 07:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733814611; cv=none; b=IHAMscH0qdp9HsPlFPr1dcSrm00PMpMzicX4B6ovNAdP8Zn8pSK738yjR0NMFaKeXDWUfS9C7JHrHiQqEcpNDomV3jQ+Uqjf91TxbAyddwlvLk8JryRinrmvIeBEWvei+bJEElCOgdNziR7C//CkzWD3A3iFQfXBzAWowwBoaKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733814611; c=relaxed/simple;
	bh=aEuFdcXMdWm2mShtBnt2DaJyFcqkrlmW6s+tjqD5Y6A=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=L6NZDQA9LfQxzkt1iQDJ/P8Xijgxj0R6t1k4krZUXFhw59VYCfpkcvFDWDQJJTQBPoPoofVVJNvOJHEnpFDpkieJ0K/1dfUSF8dP5UVqQGp85PsXwUz74fctYklL9/rZ/fAevS6CBh+vpeCtiWzf8k5bF1kjCe0nCFSUnR07VgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=eG/tWMbA; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241210071007epoutp03f1c622e4c033586135ec5b1566a302d4~PvzL6wt0w1417214172epoutp03j
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 07:10:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241210071007epoutp03f1c622e4c033586135ec5b1566a302d4~PvzL6wt0w1417214172epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733814607;
	bh=aEuFdcXMdWm2mShtBnt2DaJyFcqkrlmW6s+tjqD5Y6A=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=eG/tWMbAlB6G4rkKJK4A66DnD1S0JnNby020cNcC8Qw+2a6pp76U9VzQOudGC4GeA
	 9GpeMzF+eo70Bx6cvz22fE6Lx0UD9d8eo0uGZGNYmxBJ1buZ0bl0vrEdMk18z9aX9G
	 qLp8Vy1Ieq3uLm4Na6GFC3jrRN3lFoZhrLHB5WTw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20241210071006epcas2p2d8ce8d6df2fda03e9daa72d1926ebe39~PvzLJ4xBj1500115001epcas2p2q;
	Tue, 10 Dec 2024 07:10:06 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.101]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y6qcY5Gbpz4x9Py; Tue, 10 Dec
	2024 07:10:05 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	00.AE.22938.D49E7576; Tue, 10 Dec 2024 16:10:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20241210071005epcas2p4672406af2c1857c40047500d7a882b7f~PvzKGi4TP1257412574epcas2p47;
	Tue, 10 Dec 2024 07:10:05 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241210071005epsmtrp1b9bb4876e2ffce7b76ba6024ad7281c8~PvzKFVMds1673616736epsmtrp1T;
	Tue, 10 Dec 2024 07:10:05 +0000 (GMT)
X-AuditID: b6c32a43-0b1e27000000599a-c7-6757e94dfa98
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7B.32.18729.D49E7576; Tue, 10 Dec 2024 16:10:05 +0900 (KST)
Received: from KORCO117327 (unknown [10.229.60.106]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241210071005epsmtip24481a41ed8f85bd0a913dd9722e585c0~PvzJ2X9X70855008550epsmtip2e;
	Tue, 10 Dec 2024 07:10:05 +0000 (GMT)
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
In-Reply-To: 
Subject: RE: [PATCH] tcp: check socket state before calling WARN_ON
Date: Tue, 10 Dec 2024 16:10:04 +0900
Message-ID: <000001db4ad2$899e6b90$9cdb42b0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL4yZmsudMRkH1MkhPtbuC345sC9QKRMuYdAUIxOFgBsMn9rAIf5xWWAZwDXWsBNR7tnQJ0dudGAPMj/mwCPP60LAEh3GCHAj4uPtAC9F+sfK/wY3uQgAAiJJA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbVRzHPfeWey8kdXcF4QjTdFcwwgK0jMeBgZlhYg2aNNnMiCYrHVwL
	Am3tY2Ez0wYsAWKADrZIRS1TicMJs4XKY4VRkEcI4eHYYA5UGG4dMAU2BstKbLlM98/J5/x+
	v+/vnO95ULjgFhFM5Sp1rEYpz2cIP569Nzwu8m3XUYXocWs4WrLi6JrDRKK60U95qKnDiKGF
	/jkSVdcAVNQ9gaMrNbU+aK5ykED25V4Mrd24h6PJTs8wZq/wQabfawj0a0cdgUpvOnio3xKI
	1oeXAHIXTZHIOL9GopWBIhJ9c2WVPBgoabkwjUksVr3E2lhGSP7umiQkFS2NQLJmfVFKvJuX
	nMPKs1mNkFVmqbJzlYoUJv2wLFUWFy8SR4oTUQIjVMoL2BTm0FvSyLTcfI8lRnhCnq/3hKRy
	rZaJfjVZo9LrWGGOSqtLYVh1dr46QR2llRdo9UpFlJLVJYlFopg4T2FmXo698j6mdu4pXGy+
	iBuAM6Qc+FKQjoXVpg2yHPhRAroNwJHbdTg3WQWw+ucigpusA1g13eXzRPLZ4yEfLuEAcKD3
	Ee5NCGgXgOdtGV4m6Ejo/quW9HIAHQFHBs3bApye5MGz7mJPW4rypfmwauuAt8afToUmRy3m
	ZR4dBu8MjQMv8+lEWP/wKsbxbjhUe4vnZZzeBxvqF3FuQ0K4udCw3T+ALgfwUv0Y4IoC4Bdl
	Jdt+IF3sC5e/N5Cc4hBsdpXuqP3h3YGWnXgwdFWW7LAWPrzeBzixAcB/5hYJLrEfFjf8wfM6
	wOlw2NwR7UVIvwT7buxs7llY2usmuTAflpYIOGEYbLVs7jQJgY6NRZ8qwJifsmZ+ypr5KQfm
	/9eyAF4jCGTV2gIFmxWjFv9321mqAivYfu4RqW3g6tdbUU6AUcAJIIUzAXwq/R2FgJ8tP3mK
	1ahkGn0+q3WCOM9hm/Dg57JUnv+i1MnEsYmi2Ph4cUJMnCiBCeLPGr/MFtAKuY7NY1k1q3mi
	wyjfYAMWHGN/bffHp8HG1sHDqsyhvpOXim3q9pe/k5z6anjm7kj3884cQ+eMbfbBulsa7Rre
	JYmf+2Vw4s6eFfO37Ud+arOd6Vxq3P9MWWFTw5nLLhM5T15elb0xjxWSpteNaf6uoEd+54J6
	jl/cOlt+4pXqjJv2FWrqmtFtfC/K2R197Nze02uRzuTxmfO3w/LePzB1tNe22XFvNly3cr/n
	A2dant4iNs8vp4dk7ft8V+jE9Hxmuy33t9BPWg2wtD7xuuDHJdkPf2Y4phebej6ypIypekp0
	yfrQhc0ZWcixB0n6khe0AxFH9mKxUqG1S3qcGPpwVFh5IWF81FbRn7wy9WbNYFKYjuFpc+Ti
	CFyjlf8LtRwiq3cEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7bCSvK7vy/B0gx/LeCzebGK2uLZ3IrvF
	nPMtLBbrdrUyWTw99ojdYvIURoum/ZeYLQ5Mmclq8aj/BJvFtreHmSw+33rHbHF1N5C4sK2P
	1WLi/SlsFpd3zWGz6Lizl8Xi2AIxi2+n3zBa/G26wW7R+vgzu8XH403sFosPfGJ3EPPYsvIm
	k8eCTaUem1Z1snm833eVzaNvyypGj8+b5ALYorhsUlJzMstSi/TtErgyjmy8ylTwXrji+OSf
	jA2MZ/i7GDk5JARMJHr+nGTtYuTiEBLYzSjx9lsTM0RCWmLthTfsELawxP2WI1BFzxklHt0/
	xwKSYBPQlfj7bCZYkYiAlsTZE7PAipgF3rJI7Nq1nAmi4zSrxNbV/UAZDg5OAV6JCf+sQRqE
	BZwlJu6dyQRiswioSrw4eZERxOYVsJRY+P0KE4QtKHFy5hOwZcwC2hJPbz6Fs5ctfA11qYLE
	z6fLwBaLCHQxSmxYeIERokhEYnZnG/MERuFZSGbNQjJrFpJZs5C0LGBkWcUomVpQnJueW2xY
	YJiXWq5XnJhbXJqXrpecn7uJERzrWpo7GLev+qB3iJGJg/EQowQHs5IIL4d3aLoQb0piZVVq
	UX58UWlOavEhRmkOFiVxXvEXvSlCAumJJanZqakFqUUwWSYOTqkGpsaMZR+mvfQ2ck+s0lr+
	Lb3B+c6ewEz+Er61qqKJ15p272883sB9QKrDZ3KCVd3ci/N0LTVs/wWm1bm+b7c48cTBZrpG
	gunzKyty8wV45i0sKji5/vw0rfwDFSz2c18mT1x2T8Dny7HT7wQKVU7fXVhmlvJv1SPBvjyB
	RxelvFa8Uf2rU/BT48Kp2JKNmTrLWLY9LbhXsvm4uWTM9ly1yCUORYU+aYt01dZLmDuEvd3r
	phom8N3Fz0rh0+LfT4o/zCtz2P7lQceBN+ecKq/Ki6TPO/n0/q3WzkX6en8PaxrOnHv93gLB
	lHjfL3l56dq/cx2uKXWp566qMcr6+eDjtpmqfZv2PS6wY+jcpc/2VYmlOCPRUIu5qDgRAL7Q
	L8dkAwAA
X-CMS-MailID: 20241210071005epcas2p4672406af2c1857c40047500d7a882b7f
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

On Tue, Dec 10, 2024 at 12:39 PM Dujeong Lee wrote:
> On Mon, Dec 9, 2024 at 7:21 PM Eric Dumazet <edumazet=40google.com> wrote=
:
> > On Mon, Dec 9, 2024 at 11:16=E2=80=AFAM=20Dujeong.lee=20<dujeong.lee=40=
samsung.com>=0D=0A>=20>=20wrote:=0D=0A>=20>=20>=0D=0A>=20>=0D=0A>=20>=20>=
=20Thanks=20for=20all=20the=20details=20on=20packetdrill=20and=20we=20are=
=20also=20exploring=0D=0A>=20>=20USENIX=202013=20material.=0D=0A>=20>=20>=
=20I=20have=20one=20question.=20The=20issue=20happens=20when=20DUT=20receiv=
es=20TCP=20ack=0D=0A>=20>=20>=20with=0D=0A>=20>=20large=20delay=20from=20ne=
twork,=20e.g.,=2028seconds=20since=20last=20Tx.=20Is=0D=0A>=20>=20packetdri=
ll=20able=20to=20emulate=20this=20network=20delay=20(or=20congestion)=20in=
=20script=0D=0A>=20level?=0D=0A>=20>=0D=0A>=20>=20Yes,=20the=20packetdrill=
=20scripts=20can=20wait=20an=20arbitrary=20amount=20of=20time=0D=0A>=20>=20=
between=20each=20event=0D=0A>=20>=0D=0A>=20>=20+28=20<next=20event>=0D=0A>=
=20>=0D=0A>=20>=2028=20seconds=20seems=20okay.=20If=20the=20issue=20was=20t=
riggered=20after=204=20days,=0D=0A>=20>=20packetdrill=20would=20be=20imprac=
tical=20;)=0D=0A>=20=0D=0A>=20Hi=20all,=0D=0A>=20=0D=0A>=20We=20secured=20n=
ew=20ramdump.=0D=0A>=20Please=20find=20the=20below=20values=20with=20TCP=20=
header=20details.=0D=0A>=20=0D=0A>=20tp->packets_out=20=3D=200=0D=0A>=20tp-=
>sacked_out=20=3D=200=0D=0A>=20tp->lost_out=20=3D=201=0D=0A>=20tp->retrans_=
out=20=3D=201=0D=0A>=20tp->rx_opt.sack_ok=20=3D=205=20(tcp_is_sack(tp))=20m=
ss_cache=20=3D=201400=0D=0A>=20((struct=20inet_connection_sock=20*)sk)->ics=
k_ca_state=20=3D=204=20((struct=0D=0A>=20inet_connection_sock=20*)sk)->icsk=
_pmtu_cookie=20=3D=201500=0D=0A>=20=0D=0A>=20Hex=20from=20ip=20header:=0D=
=0A>=2045=2000=2000=2040=2075=2040=2000=2000=2039=2006=2091=2013=208E=20FB=
=202A=20CA=20C0=20A8=2000=20F7=2001=20BB=20A7=20CC=2051=0D=0A>=20F8=2063=20=
CC=2052=2059=206D=20A6=20B0=2010=2004=2004=2077=2076=2000=2000=2001=2001=20=
08=200A=2089=2072=20C8=2042=2062=20F5=0D=0A>=20F5=20D1=2001=2001=2005=200A=
=2052=2059=206D=20A5=2052=2059=206D=20A6=0D=0A>=20=0D=0A>=20Transmission=20=
Control=20Protocol=0D=0A>=20Source=20Port:=20443=0D=0A>=20Destination=20Por=
t:=2042956=0D=0A>=20TCP=20Segment=20Len:=200=0D=0A>=20Sequence=20Number=20(=
raw):=201375232972=0D=0A>=20Acknowledgment=20number=20(raw):=201381592486=
=0D=0A>=201011=20....=20=3D=20Header=20Length:=2044=20bytes=20(11)=0D=0A>=
=20Flags:=200x010=20(ACK)=0D=0A>=20Window:=201028=0D=0A>=20Calculated=20win=
dow=20size:=201028=0D=0A>=20Urgent=20Pointer:=200=0D=0A>=20Options:=20(24=
=20bytes),=20No-Operation=20(NOP),=20No-Operation=20(NOP),=20Timestamps,=0D=
=0A>=20No-Operation=20(NOP),=20No-Operation=20(NOP),=20SACK=0D=0A>=20=0D=0A=
>=20If=20anyone=20wants=20to=20check=20other=20values,=20please=20feel=20fr=
ee=20to=20ask=20me=0D=0A>=20=0D=0A>=20Thanks,=0D=0A>=20Dujeong.=0D=0A=0D=0A=
I=20have=20a=20question.=0D=0A=0D=0AFrom=20the=20latest=20ramdump=20I=20cou=
ld=20see=20that=0D=0A1)=20tcp_sk(sk)->packets_out=20=3D=200=0D=0A2)=20inet_=
csk(sk)->icsk_backoff=20=3D=200=0D=0A3)=20sk_write_queue.len=20=3D=200=0D=
=0Awhich=20suggests=20that=20tcp_write_queue_purge=20was=20indeed=20called.=
=0D=0A=0D=0ANoting=20that:=0D=0A1)=20tcp_write_queue_purge=20reset=20packet=
s_out=20to=200=0D=0Aand=0D=0A2)=20in_flight=20should=20be=20non-negative=20=
where=20in_flight=20=3D=20packets_out=20-=20left_out=20+=20retrans_out,=0D=
=0Awhat=20if=20we=20reset=20left_out=20and=20retrans_out=20as=20well=20in=
=20tcp_write_queue_purge?=0D=0A=0D=0ADo=20we=20see=20any=20potential=20issu=
e=20with=20this?=0D=0A=0D=0A

