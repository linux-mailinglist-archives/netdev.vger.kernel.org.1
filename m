Return-Path: <netdev+bounces-148866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620069E3488
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 08:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5991663F3
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 07:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749821B3928;
	Wed,  4 Dec 2024 07:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KcI+1hsT"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86E61B2193
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733298529; cv=none; b=a4qau0wGM1OPdQe87WBnnUwpgwI9V3s6hTdaPk+HI/tu496LAlnB9/qQB4KrYGCEZW+vwdPvtD2uxx9PvNJzLvPZ/FvcKBI3uauyIt8LQNAlXXz2mutL56KDA/48AWPEoImjxnKfBSn+ecFJbjkvOvFvMFG2EKBhLonF2pGW+5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733298529; c=relaxed/simple;
	bh=9qGDbkyOtwZ1d2Hg7oUG4eLq/pzedIIP3/HwVVA2Jwo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=Bm+yCHZqKjCwEWwuI4Dd1MPg/A3r/0beLyTqgBXRSR/oS/ZTyhtEbKM8C1oC99aePGEhYntuExpc0vzE+o3bwyCj3eSbhKMOlgbsd1ifbKIqYsJkcmJRd876rdmHkzL+dx5OVsRXJKI1Wifj6Lw9sBpMCOugGSZ/7WB7zQvy/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=KcI+1hsT; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241204074844epoutp0368ff9f063e848846b7a956c0747dc0e1~N6dMpYZG20889808898epoutp03o
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 07:48:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241204074844epoutp0368ff9f063e848846b7a956c0747dc0e1~N6dMpYZG20889808898epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733298524;
	bh=9qGDbkyOtwZ1d2Hg7oUG4eLq/pzedIIP3/HwVVA2Jwo=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=KcI+1hsTJSr3R83dsKKqTJtYFMxXNgEFpUCNehJc0FDUnvXhxhmr/G3u0dxAcpUuH
	 j1a765vDuarCxVm+hW+sTjAECZEE/KR5L+OX+UIcIS+O8nY832DNyxKd//FiW3Hg44
	 2ElVeP+yZjiue2TJTC2qDucPd2UhxZrUfiTd9trk=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20241204074844epcas2p3d34f8747cb6534ca666e578c2bf42de1~N6dMOn21U1290012900epcas2p3Z;
	Wed,  4 Dec 2024 07:48:44 +0000 (GMT)
Received: from epsmgec2p1.samsung.com (unknown [182.195.36.69]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y38lv4VR0z4x9Px; Wed,  4 Dec
	2024 07:48:43 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	B7.89.22938.B5900576; Wed,  4 Dec 2024 16:48:43 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20241204074843epcas2p35b4941872b33f126fd98997850acc35f~N6dLFPOLS1290012900epcas2p3W;
	Wed,  4 Dec 2024 07:48:43 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241204074843epsmtrp24f7ab4772ee78b80c81aeda591b02090~N6dLEMRDY0975109751epsmtrp2F;
	Wed,  4 Dec 2024 07:48:43 +0000 (GMT)
X-AuditID: b6c32a43-0b1e27000000599a-b2-6750095bbad1
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	4B.6B.33707.A5900576; Wed,  4 Dec 2024 16:48:42 +0900 (KST)
Received: from KORCO117327 (unknown [10.229.60.106]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241204074842epsmtip2b319ab3f827b6e389200285cb6dc6dc0~N6dK1cYcm1580915809epsmtip2L;
	Wed,  4 Dec 2024 07:48:42 +0000 (GMT)
From: "Dujeong.lee" <dujeong.lee@samsung.com>
To: "'Eric Dumazet'" <edumazet@google.com>, "'Youngmin Nam'"
	<youngmin.nam@samsung.com>
Cc: "'Jakub Kicinski'" <kuba@kernel.org>, "'Neal Cardwell'"
	<ncardwell@google.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <guo88.liu@samsung.com>,
	<yiwang.cai@samsung.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <joonki.min@samsung.com>,
	<hajun.sung@samsung.com>, <d7271.choe@samsung.com>, <sw.ju@samsung.com>
In-Reply-To: <CANn89iKms_9EX+wArf1FK7Cy3-Cr_ryX+MJ2YC8yt1xmvpY=Uw@mail.gmail.com>
Subject: RE: [PATCH] tcp: check socket state before calling WARN_ON
Date: Wed, 4 Dec 2024 16:48:42 +0900
Message-ID: <009e01db4620$f08f42e0$d1adc8a0$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL4yZmsudMRkH1MkhPtbuC345sC9QKRMuYdAUIxOFgBsMn9rAIf5xWWAZwDXWsBNR7tnbBHBNdQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmuW40Z0C6wdJVShbX9k5kt5hzvoXF
	Yt2uViaLp8cesVtMnsJo0bT/ErPFo/4TbBZXd79jtriwrY/V4vKuOWwWHXf2slgcWyBm8e30
	G0aL1sef2S0+Hm9it1h84BO7g4DHlpU3mTwWbCr12LSqk83j/b6rbB59W1YxenzeJBfAFpVt
	k5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0tZJCWWJO
	KVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwLxArzgxt7g0L10vL7XEytDAwMgUqDAhO+Pf
	4jb2gn+2FR9WT2ZvYPxi3cXIySEhYCIxteEfaxcjF4eQwA5GifYjh9ghnE+MEl83X2AFqQJz
	zh2s7GLkAOuY/DsAomYno8Tc/Q1Q3S8ZJTYc3M4I0sAmoCvx99lMdhBbRCBS4uzDB4wgRcwC
	TcwS/96fYQNJcAoESvyauhCsSFjAWWLi3plMIDaLgIrE/EX9bCDbeAUsJZo3u4GEeQUEJU7O
	fMICYjMLaEssW/iaGeIFBYmfT5exQuyKkvjy5jQzRI2IxOzONqiaGxwSd35KQjzgIjHrnTtE
	WFji1fEt7BC2lMTnd3vZIOxiie/Xj4CdLCHQwCjx4dFrqISxRPOyBywgc5gFNCXW79KHGKks
	ceQW1GV8Eh2H/7JDhHklOtqEIBpVJbYu+Ak1RFpi74/XrBMYlWYh+WsWkr9mIbl/FsKuBYws
	qxjFUguKc9NTk40KDOExnZyfu4kRnJq1nHcwXpn/T+8QIxMH4yFGCQ5mJRHewCX+6UK8KYmV
	ValF+fFFpTmpxYcYTYEBPZFZSjQ5H5gd8kriDU0sDUzMzAzNjUwNzJXEee+1zk0REkhPLEnN
	Tk0tSC2C6WPi4JRqYNrZ18YROW+d+a8bFdVLrDgucTMtZ79zujP8dvXyKRvetUY/Xt8q9I3V
	N+31QoegF4uqKk9viOhmFOx5pGG/UzLylLSlpXwh9yvjN2JXvpjO5fqnvnf2U/s9pZtsb5T9
	fhXQ0v5T69k788US3jH+LBYBh+Z0fN4WLaT7wmaHSq80U8fntRsSYmWF7/nKvjU/0zPpz63N
	e5wnl97fyVTCnif9Z9bjytI7gv1G7xYcWjJh7qf7G/fa2v2c1m5x6t3tD/Jxvy0rYoVPvFlw
	t6e941nBo1AB6zoetbsvA6I9/D68Nz/7X+DQ8rrKcx7p8fdfGz3OmblUlkmThUO+5OHrupen
	D/clc6r+/p8cqaF6e60SS3FGoqEWc1FxIgDDyqkbVgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSvG4UZ0C6weU+K4treyeyW8w538Ji
	sW5XK5PF02OP2C0mT2G0aNp/idniUf8JNouru98xW1zY1sdqcXnXHDaLjjt7WSyOLRCz+Hb6
	DaNF6+PP7BYfjzexWyw+8IndQcBjy8qbTB4LNpV6bFrVyebxft9VNo++LasYPT5vkgtgi+Ky
	SUnNySxLLdK3S+DK2NhtULBRt2JOWw9TA+NK1S5GDg4JAROJyb8Duhi5OIQEtjNKnJr5irmL
	kRMoLi2x9sIbdghbWOJ+yxFWEFtI4DmjRNNRKRCbTUBX4u+zmWA1IgKREteWnWIBGcQsMIlZ
	YsK5Y4wQU+cyS3xfsg+silMgUOLX1IVgtrCAs8TEvTOZQGwWARWJ+Yv62UAu4hWwlGje7AYS
	5hUQlDg58wkLiM0soC3R+7CVEcZetvA11KEKEj+fLmOFOCJK4sub08wQNSISszvbmCcwCs9C
	MmoWklGzkIyahaRlASPLKkbR1ILi3PTc5AJDveLE3OLSvHS95PzcTYzgCNUK2sG4bP1fvUOM
	TByMhxglOJiVRHgDl/inC/GmJFZWpRblxxeV5qQWH2KU5mBREudVzulMERJITyxJzU5NLUgt
	gskycXBKNTC5flis80xl0a/iX/evd7ou/hko8WHn7H8Xd+htkf/+3d1mre7V1+KrDx5azcQv
	fOWzb7Z1d/KDVQoihz88DGvcqTxHZJdyaf0s55T1CSnSIdGZzQG++w6+PC+svCAm+KKw5PVP
	0foRUj8zmlY7KldYSO4zWOz85HD02gVpr33lnmrsn740Ku5RtZ//xfmqORMFfD9kmlTf/OzU
	Vz7Vc5tEnEr3pohys8jLM/Zb5+7csGP/vODK8HvPePTYLiS+/2Y36anwuaX1mczl2kWnnE4t
	XONS0fHy2v2SarPJ+0RnZbIEHHdr6eaaPC/ylf5GzQvRzPZLg/pCwys9thz6ZlMupvXC7OXN
	tdy6Z1T769qVWIozEg21mIuKEwGj1NgDPwMAAA==
X-CMS-MailID: 20241204074843epcas2p35b4941872b33f126fd98997850acc35f
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

On Wed, Dec 4, 2024 at 4:14 PM Eric Dumazet wrote:
> To: Youngmin Nam <youngmin.nam=40samsung.com>
> Cc: Jakub Kicinski <kuba=40kernel.org>; Neal Cardwell <ncardwell=40google=
.com>;
> davem=40davemloft.net; dsahern=40kernel.org; pabeni=40redhat.com;
> horms=40kernel.org; dujeong.lee=40samsung.com; guo88.liu=40samsung.com;
> yiwang.cai=40samsung.com; netdev=40vger.kernel.org; linux-
> kernel=40vger.kernel.org; joonki.min=40samsung.com; hajun.sung=40samsung.=
com;
> d7271.choe=40samsung.com; sw.ju=40samsung.com
> Subject: Re: =5BPATCH=5D tcp: check socket state before calling WARN_ON
>=20
> On Wed, Dec 4, 2024 at 4:35=E2=80=AFAM=20Youngmin=20Nam=20<youngmin.nam=
=40samsung.com>=0D=0A>=20wrote:=0D=0A>=20>=0D=0A>=20>=20On=20Tue,=20Dec=200=
3,=202024=20at=2006:18:39PM=20-0800,=20Jakub=20Kicinski=20wrote:=0D=0A>=20>=
=20>=20On=20Tue,=203=20Dec=202024=2010:34:46=20-0500=20Neal=20Cardwell=20wr=
ote:=0D=0A>=20>=20>=20>=20>=20I=20have=20not=20seen=20these=20warnings=20fi=
ring.=20Neal,=20have=20you=20seen=20this=20in=0D=0A>=20the=20past=20?=0D=0A=
>=20>=20>=20>=0D=0A>=20>=20>=20>=20I=20can't=20recall=20seeing=20these=20wa=
rnings=20over=20the=20past=205=20years=20or=20so,=0D=0A>=20>=20>=20>=20and=
=20(from=20checking=20our=20monitoring)=20they=20don't=20seem=20to=20be=20f=
iring=20in=0D=0A>=20>=20>=20>=20our=20fleet=20recently.=0D=0A>=20>=20>=0D=
=0A>=20>=20>=20FWIW=20I=20see=20this=20at=20Meta=20on=205.12=20kernels,=20b=
ut=20nothing=20since.=0D=0A>=20>=20>=20Could=20be=20that=20one=20of=20our=
=20workloads=20is=20pinned=20to=205.12.=0D=0A>=20>=20>=20Youngmin,=20what's=
=20the=20newest=20kernel=20you=20can=20repro=20this=20on?=0D=0A>=20>=20>=0D=
=0A>=20>=20Hi=20Jakub.=0D=0A>=20>=20Thank=20you=20for=20taking=20an=20inter=
est=20in=20this=20issue.=0D=0A>=20>=0D=0A>=20>=20We've=20seen=20this=20issu=
e=20since=205.15=20kernel.=0D=0A>=20>=20Now,=20we=20can=20see=20this=20on=
=206.6=20kernel=20which=20is=20the=20newest=20kernel=20we=20are=0D=0A>=20ru=
nning.=0D=0A>=20=0D=0A>=20The=20fact=20that=20we=20are=20processing=20ACK=
=20packets=20after=20the=20write=20queue=20has=20been=0D=0A>=20purged=20wou=
ld=20be=20a=20serious=20bug.=0D=0A>=20=0D=0A>=20Thus=20the=20WARN()=20makes=
=20sense=20to=20us.=0D=0A>=20=0D=0A>=20It=20would=20be=20easy=20to=20build=
=20a=20packetdrill=20test.=20Please=20do=20so,=20then=20we=20can=0D=0A>=20f=
ix=20the=20root=20cause.=0D=0A>=20=0D=0A>=20Thank=20you=20=21=0D=0A=0D=0A=
=0D=0APlease=20let=20me=20share=20some=20more=20details=20and=20clarificati=
ons=20on=20the=20issue=20from=20ramdump=20snapshot=20locally=20secured.=0D=
=0A=0D=0A1)=20This=20issue=20has=20been=20reported=20from=20Android-T=20lin=
ux=20kernel=20when=20we=20enabled=20panic_on_warn=20for=20the=20first=20tim=
e.=0D=0AReproduction=20rate=20is=20not=20high=20and=20can=20be=20seen=20in=
=20any=20test=20cases=20with=20public=20internet=20connection.=0D=0A=0D=0A2=
)=20Analysis=20from=20ramdump=20(which=20is=20not=20available=20at=20the=20=
moment).=0D=0A2-A)=20From=20ramdump,=20I=20was=20able=20to=20find=20below=
=20values.=0D=0Atp->packets_out=20=3D=200=0D=0Atp->retrans_out=20=3D=201=0D=
=0Atp->max_packets_out=20=3D=201=0D=0Atp->max_packets_Seq=20=3D=20157583035=
8=0D=0Atp->snd_ssthresh=20=3D=205=0D=0Atp->snd_cwnd=20=3D=201=0D=0Atp->prio=
r_cwnd=20=3D=2010=0D=0Atp->wite_seq=20=3D=201575830359=0D=0Atp->pushed_seq=
=20=3D=201575830358=0D=0Atp->lost_out=20=3D=201=0D=0Atp->sacked_out=20=3D=
=200=0D=0A=0D=0A2-B)=20The=20last=20Tx=20packet=20from=20the=20device=20is=
=20(Time:=2017371.562934)=0D=0AHex:=0D=0A4500005b95a3400040063e34c0a848188e=
facf0a888a01bb5ded432f5ad8ab29801800495b5800000101080a3a52197fef299d9017030=
30022f3589123b0523bdd07be137a98ca9b5d3475332d4382c7b420571e6d437a07ba7787=
=0D=0A=0D=0AInternet=20Protocol=20Version=204=0D=0A0100=20....=20=3D=20Vers=
ion:=204=0D=0A....=200101=20=3D=20Header=20Length:=2020=20bytes=20(5)=0D=0A=
Differentiated=20Services=20Field:=200x00=20(DSCP:=20CS0,=20ECN:=20Not-ECT)=
=0D=0ATotal=20Length:=2091=0D=0AIdentification:=200x95a3=20(38307)=0D=0A010=
.=20....=20=3D=20Flags:=200x2,=20Don't=20fragment=0D=0A...0=200000=200000=
=200000=20=3D=20Fragment=20Offset:=200=0D=0ATime=20to=20Live:=2064=0D=0APro=
tocol:=20TCP=20(6)=0D=0AHeader=20Checksum:=200x3e34=0D=0AHeader=20checksum=
=20status:=20Unverified=0D=0ASource=20Address:=20192.168.72.24=0D=0ADestina=
tion=20Address:=20142.250.207.10=0D=0AStream=20index:=200=0D=0A=0D=0ATransm=
ission=20Control=20Protocol=0D=0ASource=20Port:=2034954=0D=0ADestination=20=
Port:=20443=0D=0AStream=20index:=200=0D=0AConversation=20completeness:=20In=
complete=20(0)=0D=0ATCP=20Segment=20Len:=2039=0D=0ASequence=20Number:=200x5=
ded432f=0D=0ASequence=20Number=20(raw):=201575830319=0D=0ANext=20Sequence=
=20Number:=2040=0D=0AAcknowledgment=20Number:=200x5ad8ab29=0D=0AAcknowledgm=
ent=20number=20(raw):=201524149033=0D=0A1000=20....=20=3D=20Header=20Length=
:=2032=20bytes=20(8)=0D=0AFlags:=200x018=20(PSH,=20ACK)=0D=0AWindow:=2073=
=0D=0ACalculated=20window=20size:=2073=0D=0AWindow=20size=20scaling=20facto=
r:=20-1=20(unknown)=0D=0AChecksum:=200x5b58=0D=0AChecksum=20Status:=20Unver=
ified=0D=0AUrgent=20Pointer:=200=0D=0AOptions:=20(12=20bytes),=20No-Operati=
on=20(NOP),=20No-Operation=20(NOP),=20Timestamps=0D=0ATimestamps=0D=0ASEQ/A=
CK=20analysis=0D=0ATCP=20payload=20(39=20bytes)=0D=0ATransport=20Layer=20Se=
curity=0D=0ATLSv1.2=20Record=20Layer:=20Application=20Data=20Protocol:=20Hy=
pertext=20Transfer=20Protocol=0D=0A=0D=0A2-C)=20When=20warn=20hit,=20DUT=20=
was=20processing=20(Time:=2017399.502603,=2028=20seconds=20later=20since=20=
last=20Tx)=0D=0AHex:=0D=0A456000405FA20000720681F08EFACF0AC0A8481801BB888A5=
AD8AB295DED4356B010010D93D800000101080AEF299EF43A52089F0101050A5DED432F5DED=
4356=0D=0A=0D=0AInternet=20Protocol=20Version=204=0D=0A0100=20....=20=3D=20=
Version:=204=0D=0A....=200101=20=3D=20Header=20Length:=2020=20bytes=20(5)=
=0D=0ADifferentiated=20Services=20Field:=200x60=20(DSCP:=20CS3,=20ECN:=20No=
t-ECT)=0D=0ATotal=20Length:=2064=0D=0AIdentification:=200x5fa2=20(24482)=0D=
=0A000.=20....=20=3D=20Flags:=200x0=0D=0A...0=200000=200000=200000=20=3D=20=
Fragment=20Offset:=200=0D=0ATime=20to=20Live:=20114=0D=0AProtocol:=20TCP=20=
(6)=0D=0AHeader=20Checksum:=200x81f0=0D=0AHeader=20checksum=20status:=20Unv=
erified=0D=0ASource=20Address:=20142.250.207.10=0D=0ADestination=20Address:=
=20192.168.72.24=0D=0AStream=20index:=200=0D=0A=0D=0ATransmission=20Control=
=20Protocol=0D=0ASource=20Port:=20443=0D=0ADestination=20Port:=2034954=0D=
=0AStream=20index:=200=0D=0AConversation=20completeness:=20Incomplete=20(0)=
=0D=0ATCP=20Segment=20Len:=200=0D=0ASequence=20Number:=200x5ad8ab29=0D=0ASe=
quence=20Number=20(raw):=201524149033=0D=0ANext=20Sequence=20Number:=201=0D=
=0AAcknowledgment=20Number:=200x5ded4356=0D=0AAcknowledgment=20number=20(ra=
w):=201575830358=0D=0A1011=20....=20=3D=20Header=20Length:=2044=20bytes=20(=
11)=0D=0AFlags:=200x010=20(ACK)=0D=0AWindow:=20269=0D=0ACalculated=20window=
=20size:=20269=0D=0AWindow=20size=20scaling=20factor:=20-1=20(unknown)=0D=
=0AChecksum:=200x93d8=0D=0AChecksum=20Status:=20Unverified=0D=0AUrgent=20Po=
inter:=200=0D=0AOptions:=20(24=20bytes),=20No-Operation=20(NOP),=20No-Opera=
tion=20(NOP),=20Timestamps,=20No-Operation=20(NOP),=20No-Operation=20(NOP),=
=20SACK=0D=0ATimestamps=0D=0A=0D=0A2-D)=20The=20DUT=20received=20ack=20afte=
r=2028=20seconds=20from=20Access=20Point.=0D=0A=0D=0A3)Clarification=20on=
=20=22tcp_write_queue_purge=22=20claim=0D=0AThis=20is=20just=20my=20conject=
ure=20based=20on=20ramdump=20snapshot=20and=20it=20is=20not=20shown=20in=20=
calltrace.=0D=0ABased=20on=20tcp=20status=20in=20snapshot=20I=20thought=20t=
cp_write_queue_purge=20was=20called=20and=20packets_out=20was=20cleared.=0D=
=0A=0D=0A4)=20In=20our=20kernel=20=22/proc/sys/net/ipv4/tcp_mtu_probing=22=
=20is=20set=20to=200.=0D=0A=0D=0A

