Return-Path: <netdev+bounces-150121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 463349E8FF7
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 11:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84EC6161A6C
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 10:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD68D217640;
	Mon,  9 Dec 2024 10:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lR5IZAZF"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0315F216E0B
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 10:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733739416; cv=none; b=p5sRrkktZ/WvzsqtFpnG2JFOeLl1sd83E3CqYs4qPHdhjIBPJloNO+dUaAYHaqIhX0L6Nuv1YopPHvZwEGj5hrYvIenPyJcmqNeZQ28hrxJ0pKv5+/U9ohg/UhbTpCLd8UnzYJaHz4UD4vpX2qk8M2461OIACXtAgma5J3ix8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733739416; c=relaxed/simple;
	bh=3xDLo+Uid066Uk2VMV1thFfKN8zf5rYOeZFKla1seBY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=OjCQani3PevC0AFguFZ486uXku2CmZGTKF1Mf1eGz6Np1Tw6TY8Xt+QKIOsly7zpmt9rCuJlZhr3UXnrgB+crw31jsdNryozoMZZt9SyhdhL7bYCFbZGOyjS//Q9+NvEo5XrNfwMI7IRFjZsuJfKCGG/vqNzp94wuse+kH1fa3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=lR5IZAZF; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241209101650epoutp026d93334ee19868331e987c066af992d6~Pes71sfLh2397523975epoutp02N
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 10:16:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241209101650epoutp026d93334ee19868331e987c066af992d6~Pes71sfLh2397523975epoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733739410;
	bh=3xDLo+Uid066Uk2VMV1thFfKN8zf5rYOeZFKla1seBY=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=lR5IZAZFr/sGQXr4Y5o+zdgvZGlzkv+9YJ5l59puDQAe5hjI1m32kI+1U3SByiWi6
	 1oy375L+tgv/aBRkHgrKCv33a99XRDCmA+c1LUdfx0Fec8+cWQ2ypJbfSEmwRXYPkq
	 apVng8vKF68/gILHPqvm4/HKmPes2RBspsLp6QFg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTP id
	20241209101649epcas2p1c14796b1fb529a032eadf95353713c6f~Pes6YdPhR1991919919epcas2p1M;
	Mon,  9 Dec 2024 10:16:49 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.97]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4Y6HpS4mBHz4x9Pt; Mon,  9 Dec
	2024 10:16:48 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	0C.3D.23368.093C6576; Mon,  9 Dec 2024 19:16:48 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
	20241209101647epcas2p42a0f4062f072d4939b5585f6e1b287d4~Pes5KtH970234002340epcas2p4n;
	Mon,  9 Dec 2024 10:16:47 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241209101647epsmtrp1937bfb59a3115fd7df549d1d496e690f~Pes5J0u1V2694726947epsmtrp1L;
	Mon,  9 Dec 2024 10:16:47 +0000 (GMT)
X-AuditID: b6c32a45-db1ed70000005b48-9d-6756c390bf67
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	E8.6E.33707.F83C6576; Mon,  9 Dec 2024 19:16:47 +0900 (KST)
Received: from KORCO117327 (unknown [10.229.60.106]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241209101647epsmtip1b38007eedc5642adc4842acc46c53fa9~Pes44sYPt0637406374epsmtip1O;
	Mon,  9 Dec 2024 10:16:47 +0000 (GMT)
From: "Dujeong.lee" <dujeong.lee@samsung.com>
To: "'Eric Dumazet'" <edumazet@google.com>, "'Youngmin Nam'"
	<youngmin.nam@samsung.com>
Cc: "'Jakub Kicinski'" <kuba@kernel.org>, "'Neal Cardwell'"
	<ncardwell@google.com>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <guo88.liu@samsung.com>,
	<yiwang.cai@samsung.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <joonki.min@samsung.com>,
	<hajun.sung@samsung.com>, <d7271.choe@samsung.com>, <sw.ju@samsung.com>,
	<iamyunsu.kim@samsung.com>, <kw0619.kim@samsung.com>, <hsl.lim@samsung.com>,
	<hanbum22.lee@samsung.com>, <chaemoo.lim@samsung.com>,
	<seungjin1.yu@samsung.com>
In-Reply-To: <CANn89i+BuU+1__zSWgjshFzfxFUttDEpn90V+p8+mVGCHidYAA@mail.gmail.com>
Subject: RE: [PATCH] tcp: check socket state before calling WARN_ON
Date: Mon, 9 Dec 2024 19:16:47 +0900
Message-ID: <000001db4a23$746be360$5d43aa20$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL4yZmsudMRkH1MkhPtbuC345sC9QKRMuYdAUIxOFgBsMn9rAIf5xWWAZwDXWsBNR7tnQJ0dudGAPMj/mwCPP60LAEh3GCHsBjSvFA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCJsWRmVeSWpSXmKPExsWy7bCmqe6Ew2HpBo2PlCzebGK2uLZ3IrvF
	nPMtLBbrdrUyWTw99ojdYvIURoum/ZeYLQ5Mmclq8aj/BJvFtreHmSw+33rHbHF1N5C4sK2P
	1WLi/SlsFpd3zWGz6Lizl8Xi2AIxi2+n3zBa/G26wW7R+vgzu8XH403sFosPfGJ3EPPYsvIm
	k8eCTaUem1Z1snm833eVzaNvyypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403N
	DAx1DS0tzJUU8hJzU22VXHwCdN0yc4BeUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUW
	pOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ3y9spyloMG74kBvJ0sD43ePLkZODgkBE4mm
	My/Yuxi5OIQEdjBK7GuZyQjhfGKUeNS4kRnOaZ7yjwWm5e6mxywQiZ2MEv0rJjJBOC8ZJc42
	LWcDqWIT0JX4+2wmO4gtIhApcfbhA7C5zAIrWCQe3DgNluAUCJS4vGwLK4gtLOAsMXHvTCYQ
	m0VARWLr24fMIDavgKXEsZWrWSBsQYmTM5+A2cwC2hLLFr5mhjhJQeLn02WsEMvKJE7/vsUG
	USMiMbuzDarmB4fE1W1qELaLxIT3E5kgbGGJV8e3sEPYUhIv+9ug7GKJ79ePgB0tIdDAKPHh
	0Ws2iISxRPOyB0BHcAAt0JRYv0sfxJQQUJY4cgvqND6JjsN/2SHCvBIdbUIQjaoSWxf8hBoi
	LbH3x2vWCYxKs5A8NgvJY7OQPDALYdcCRpZVjGKpBcW56anFRgWG8NhOzs/dxAhO7lquOxgn
	v/2gd4iRiYPxEKMEB7OSCC+Hd2i6EG9KYmVValF+fFFpTmrxIUZTYFBPZJYSTc4H5pe8knhD
	E0sDEzMzQ3MjUwNzJXHee61zU4QE0hNLUrNTUwtSi2D6mDg4pRqY2txvfdjxMlpqpf8FTSmZ
	8q1nzcI+sQscYLeJjZ1447AFt2ll0QvlDZNfhFk7lQbtr2zsWSOa+yp83XEXvT9n/h/y/VOz
	dqEwS4fZqt+ZKrPz7+wQYVSbnpWnuPpOZOu+g2ycXjeK+A02Oq2VnHL8vGKYxtScn+ePf7h4
	85nnFOMehUPqeyfLn+DcnrhY9GXyxYiWW1MMXN5OfqPvsjHt58HVuwpbG3N/z1l+77/8Cs6d
	vmwC9oWrgx8JFctvq9ZONuN6Yp7kXNGTUpl89vGj+o9W/259rko/KdI17ZXKFJvWGQt/1bx2
	+7clwXNq4BaDCczL3S9fduHbFKHe5X7G/sa/NSFFDMzF7eV/+peKK7EUZyQaajEXFScCAPVr
	9Ed3BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWy7bCSnG7/4bB0g/OXzSzebGK2uLZ3IrvF
	nPMtLBbrdrUyWTw99ojdYvIURoum/ZeYLQ5Mmclq8aj/BJvFtreHmSw+33rHbHF1N5C4sK2P
	1WLi/SlsFpd3zWGz6Lizl8Xi2AIxi2+n3zBa/G26wW7R+vgzu8XH403sFosPfGJ3EPPYsvIm
	k8eCTaUem1Z1snm833eVzaNvyypGj8+b5ALYorhsUlJzMstSi/TtErgyPl8/yVLwwayi530H
	WwPjM50uRk4OCQETibubHrN0MXJxCAlsZ5Ro3T2FHSIhLbH2whsoW1jifssRVoii54wSTTev
	sYIk2AR0Jf4+mwlWJCIQKXFt2SmwScwC+1gkJs3azgbRcZ1FYvKnJ2BVnAKBEpeXbQHrFhZw
	lpi4dyYTiM0ioCKx9e1DZhCbV8BS4tjK1SwQtqDEyZlPwGxmAW2JpzefwtnLFr5mhjhPQeLn
	02WsEFeUSZz+fYsNokZEYnZnG/MERuFZSEbNQjJqFpJRs5C0LGBkWcUomlpQnJuem1xgqFec
	mFtcmpeul5yfu4kRHONaQTsYl63/q3eIkYmD8RCjBAezkggvh3douhBvSmJlVWpRfnxRaU5q
	8SFGaQ4WJXFe5ZzOFCGB9MSS1OzU1ILUIpgsEwenVAPTlktVSv6b3aqzz2j4Wa1tWH0vXm/B
	bN6Neid2TN0w91+PMX+Que1b4wuLF2r4ORzYVH70eL9kl03kUpe8uYrtFifYj6v0fPFbah4X
	0C3wts9zz6uns5w4bIRNnrtJ/Fxm+0Q8V/zg+6AI9sy6F2rLHD64CjLm1KnZfanaHfuRp8HG
	5IXO9iN75+/Y+sZwaULZUa21shU/7rAbJ36bmnj079U9b9oEjaJUbNe/e2zfFp6+S6++sf75
	ox9ci7fNuLpKkrWmNL7bY3uC89Eck+q1HzP2HWecXCRx/O1ksfiuKd4TFx2RXX/x8y8/Abbr
	qzetqAvqu9nIl6ihGrll5c97fq1RMSyBm7dOyglsmfpViaU4I9FQi7moOBEAX0pl62ADAAA=
X-CMS-MailID: 20241209101647epcas2p42a0f4062f072d4939b5585f6e1b287d4
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

On Fri, Dec 06, 2024 at 10:08:17AM +0100, Eric Dumazet wrote:
> On Fri, Dec 6, 2024 at 9:58=E2=80=AFAM=20Youngmin=20Nam=20<youngmin.nam=
=40samsung.com>=0D=0A>=20wrote:=0D=0A>=20>=0D=0A>=20>=20On=20Fri,=20Dec=200=
6,=202024=20at=2009:35:32AM=20+0100,=20Eric=20Dumazet=20wrote:=0D=0A>=20>=
=20>=20On=20Fri,=20Dec=206,=202024=20at=206:50=E2=80=AFAM=20Youngmin=20Nam=
=20<youngmin.nam=40samsung.com>=0D=0A>=20wrote:=0D=0A>=20>=20>=20>=0D=0A>=
=20>=20>=20>=20On=20Wed,=20Dec=2004,=202024=20at=2008:13:33AM=20+0100,=20Er=
ic=20Dumazet=20wrote:=0D=0A>=20>=20>=20>=20>=20On=20Wed,=20Dec=204,=202024=
=20at=204:35=E2=80=AFAM=20Youngmin=20Nam=0D=0A>=20<youngmin.nam=40samsung.c=
om>=20wrote:=0D=0A>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20On=20T=
ue,=20Dec=2003,=202024=20at=2006:18:39PM=20-0800,=20Jakub=20Kicinski=20wrot=
e:=0D=0A>=20>=20>=20>=20>=20>=20>=20On=20Tue,=203=20Dec=202024=2010:34:46=
=20-0500=20Neal=20Cardwell=20wrote:=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20>=
=20I=20have=20not=20seen=20these=20warnings=20firing.=20Neal,=20have=20you=
=20seen=0D=0A>=20this=20in=20the=20past=20?=0D=0A>=20>=20>=20>=20>=20>=20>=
=20>=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20I=20can't=20recall=20seeing=20the=
se=20warnings=20over=20the=20past=205=20years=0D=0A>=20>=20>=20>=20>=20>=20=
>=20>=20or=20so,=20and=20(from=20checking=20our=20monitoring)=20they=20don'=
t=20seem=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20to=20be=20firing=20in=20our=
=20fleet=20recently.=0D=0A>=20>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=
=20>=20>=20FWIW=20I=20see=20this=20at=20Meta=20on=205.12=20kernels,=20but=
=20nothing=20since.=0D=0A>=20>=20>=20>=20>=20>=20>=20Could=20be=20that=20on=
e=20of=20our=20workloads=20is=20pinned=20to=205.12.=0D=0A>=20>=20>=20>=20>=
=20>=20>=20Youngmin,=20what's=20the=20newest=20kernel=20you=20can=20repro=
=20this=20on?=0D=0A>=20>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20H=
i=20Jakub.=0D=0A>=20>=20>=20>=20>=20>=20Thank=20you=20for=20taking=20an=20i=
nterest=20in=20this=20issue.=0D=0A>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=
=20>=20>=20We've=20seen=20this=20issue=20since=205.15=20kernel.=0D=0A>=20>=
=20>=20>=20>=20>=20Now,=20we=20can=20see=20this=20on=206.6=20kernel=20which=
=20is=20the=20newest=20kernel=20we=0D=0A>=20are=20running.=0D=0A>=20>=20>=
=20>=20>=0D=0A>=20>=20>=20>=20>=20The=20fact=20that=20we=20are=20processing=
=20ACK=20packets=20after=20the=20write=0D=0A>=20>=20>=20>=20>=20queue=20has=
=20been=20purged=20would=20be=20a=20serious=20bug.=0D=0A>=20>=20>=20>=20>=
=0D=0A>=20>=20>=20>=20>=20Thus=20the=20WARN()=20makes=20sense=20to=20us.=0D=
=0A>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20It=20would=20be=20easy=20to=
=20build=20a=20packetdrill=20test.=20Please=20do=20so,=20then=0D=0A>=20>=20=
>=20>=20>=20we=20can=20fix=20the=20root=20cause.=0D=0A>=20>=20>=20>=20>=0D=
=0A>=20>=20>=20>=20>=20Thank=20you=20=21=0D=0A>=20>=20>=20>=20>=0D=0A>=20>=
=20>=20>=0D=0A>=20>=20>=20>=20Hi=20Eric.=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=
=20>=20Unfortunately,=20we=20are=20not=20familiar=20with=20the=20Packetdril=
l=20test.=0D=0A>=20>=20>=20>=20Refering=20to=20the=20official=20website=20o=
n=20Github,=20I=20tried=20to=20install=20it=20on=0D=0A>=20my=20device.=0D=
=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20Here=20is=20what=20I=20did=20on=20my=
=20local=20machine.=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20=24=20mkdir=20p=
acketdrill=0D=0A>=20>=20>=20>=20=24=20cd=20packetdrill=0D=0A>=20>=20>=20>=
=20=24=20git=20clone=20https://protect2.fireeye.com/v1/url?k=3D746d28f3-15e=
63dd6-=0D=0A>=20746ca3bc-74fe485cbff6-e405b48a4881ecfc&q=3D1&e=3Dca164227-d=
8ec-4d3c-bd27-=0D=0A>=20af2d38964105&u=3Dhttps%3A%2F%2Fgithub.com%2Fgoogle%=
2Fpacketdrill.git=20.=0D=0A>=20>=20>=20>=20=24=20cd=20gtests/net/packetdril=
l/=0D=0A>=20>=20>=20>=20=24./configure=0D=0A>=20>=20>=20>=20=24=20make=0D=
=0A>=20>=20>=20>=20CC=3D/home/youngmin/Downloads/arm-gnu-toolchain-13.3.rel=
1-x86_64-aar=0D=0A>=20>=20>=20>=20ch64-none-linux-gnu/bin/aarch64-none-linu=
x-gnu-gcc=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20=24=20adb=20root=0D=0A>=
=20>=20>=20>=20=24=20adb=20push=20packetdrill=20/data/=0D=0A>=20>=20>=20>=
=20=24=20adb=20shell=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20And=20here=20i=
s=20what=20I=20did=20on=20my=20device=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=
=20erd9955:/data/packetdrill/gtests/net=20=23=20./packetdrill/run_all.py=20=
-S=0D=0A>=20>=20>=20>=20-v=20-L=20-l=20tcp/=0D=0A>=20>=20>=20>=20/system/bi=
n/sh:=20./packetdrill/run_all.py:=20No=20such=20file=20or=0D=0A>=20>=20>=20=
>=20directory=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20I'm=20not=20sure=20if=
=20this=20procedure=20is=20correct.=0D=0A>=20>=20>=20>=20Could=20you=20help=
=20us=20run=20the=20Packetdrill=20on=20an=20Android=20device=20?=0D=0A>=20>=
=20>=0D=0A>=20>=20>=20packetdrill=20can=20run=20anywhere,=20for=20instance=
=20on=20your=20laptop,=20no=20need=0D=0A>=20>=20>=20to=20compile=20/=20inst=
all=20it=20on=20Android=0D=0A>=20>=20>=0D=0A>=20>=20>=20Then=20you=20can=20=
run=20single=20test=20like=0D=0A>=20>=20>=0D=0A>=20>=20>=20=23=20packetdril=
l=20gtests/net/tcp/sack/sack-route-refresh-ip-tos.pkt=0D=0A>=20>=20>=0D=0A>=
=20>=0D=0A>=20>=20You=20mean..=20To=20test=20an=20Android=20device,=20we=20=
need=20to=20run=20packetdrill=20on=0D=0A>=20laptop,=20right=20?=0D=0A>=20>=
=0D=0A>=20>=20Laptop(run=20packetdrill=20script)=20<-----------------------=
--->=20Android=0D=0A>=20>=20device=0D=0A>=20>=0D=0A>=20>=20By=20the=20way,=
=20how=20can=20we=20test=20the=20Android=20device=20(DUT)=20from=20packetdr=
ill=0D=0A>=20which=20is=20running=20on=20Laptop?=0D=0A>=20>=20I=20hope=20yo=
u=20understand=20that=20I=20am=20aksing=20this=20question=20because=20we=20=
are=20not=0D=0A>=20familiar=20with=20the=20packetdrill.=0D=0A>=20>=20Thanks=
.=0D=0A>=20=0D=0A>=20packetdrill=20does=20not=20need=20to=20run=20on=20a=20=
physical=20DUT,=20it=20uses=20a=20software=0D=0A>=20stack=20:=20TCP=20and=
=20tun=20device.=0D=0A>=20=0D=0A>=20You=20have=20a=20kernel=20tree,=20compi=
le=20it=20and=20run=20a=20VM,=20like=20virtme-ng=0D=0A>=20=0D=0A>=20vng=20-=
bv=0D=0A>=20=0D=0A>=20We=20use=20this=20to=20run=20kernel=20selftests=20in=
=20which=20we=20started=20adding=20packetdrill=0D=0A>=20tests=20(in=20recen=
t=20kernel=20tree)=0D=0A>=20=0D=0A>=20./tools/testing/selftests/net/packetd=
rill/tcp_slow_start_slow-start-ack-=0D=0A>=20per-4pkt.pkt=0D=0A>=20./tools/=
testing/selftests/net/packetdrill/tcp_zerocopy_client.pkt=0D=0A>=20./tools/=
testing/selftests/net/packetdrill/tcp_zerocopy_batch.pkt=0D=0A>=20./tools/t=
esting/selftests/net/packetdrill/tcp_slow_start_slow-start-after-=0D=0A>=20=
win-update.pkt=0D=0A>=20./tools/testing/selftests/net/packetdrill/tcp_slow_=
start_slow-start-fq-=0D=0A>=20ack-per-2pkt.pkt=0D=0A>=20./tools/testing/sel=
ftests/net/packetdrill/tcp_zerocopy_maxfrags.pkt=0D=0A>=20./tools/testing/s=
elftests/net/packetdrill/tcp_inq_server.pkt=0D=0A>=20./tools/testing/selfte=
sts/net/packetdrill/tcp_zerocopy_epoll_exclusive.pkt=0D=0A>=20./tools/testi=
ng/selftests/net/packetdrill/tcp_zerocopy_basic.pkt=0D=0A>=20./tools/testin=
g/selftests/net/packetdrill/tcp_zerocopy_small.pkt=0D=0A>=20./tools/testing=
/selftests/net/packetdrill/tcp_slow_start_slow-start-app-=0D=0A>=20limited-=
9-packets-out.pkt=0D=0A>=20./tools/testing/selftests/net/packetdrill/tcp_sl=
ow_start_slow-start-ack-=0D=0A>=20per-2pkt.pkt=0D=0A>=20./tools/testing/sel=
ftests/net/packetdrill/tcp_zerocopy_epoll_oneshot.pkt=0D=0A>=20./tools/test=
ing/selftests/net/packetdrill/tcp_zerocopy_fastopen-server.pkt=0D=0A>=20./t=
ools/testing/selftests/net/packetdrill/tcp_inq_client.pkt=0D=0A>=20./tools/=
testing/selftests/net/packetdrill/tcp_zerocopy_epoll_edge.pkt=0D=0A>=20./to=
ols/testing/selftests/net/packetdrill/tcp_slow_start_slow-start-app-=0D=0A>=
=20limited.pkt=0D=0A>=20./tools/testing/selftests/net/packetdrill/tcp_zeroc=
opy_fastopen-client.pkt=0D=0A>=20./tools/testing/selftests/net/packetdrill/=
tcp_zerocopy_closed.pkt=0D=0A>=20./tools/testing/selftests/net/packetdrill/=
tcp_slow_start_slow-start-ack-=0D=0A>=20per-1pkt.pkt=0D=0A>=20./tools/testi=
ng/selftests/net/packetdrill/tcp_slow_start_slow-start-after-=0D=0A>=20idle=
.pkt=0D=0A>=20./tools/testing/selftests/net/packetdrill/tcp_slow_start_slow=
-start-ack-=0D=0A>=20per-2pkt-send-5pkt.pkt=0D=0A>=20./tools/testing/selfte=
sts/net/packetdrill/tcp_slow_start_slow-start-ack-=0D=0A>=20per-2pkt-send-6=
pkt.pkt=0D=0A>=20./tools/testing/selftests/net/packetdrill/tcp_md5_md5-only=
-on-client-=0D=0A>=20ack.pkt=0D=0A>=20./tools/testing/selftests/net/netfilt=
er/packetdrill/conntrack_synack_old.p=0D=0A>=20kt=0D=0A>=20./tools/testing/=
selftests/net/netfilter/packetdrill/conntrack_syn_challeng=0D=0A>=20e_ack.p=
kt=0D=0A>=20./tools/testing/selftests/net/netfilter/packetdrill/conntrack_i=
nexact_rst.=0D=0A>=20pkt=0D=0A>=20./tools/testing/selftests/net/netfilter/p=
acketdrill/conntrack_synack_reuse=0D=0A>=20.pkt=0D=0A>=20./tools/testing/se=
lftests/net/netfilter/packetdrill/conntrack_rst_invalid.=0D=0A>=20pkt=0D=0A=
>=20./tools/testing/selftests/net/netfilter/packetdrill/conntrack_ack_loss_=
sta=0D=0A>=20ll.pkt=0D=0A=0D=0AThanks=20for=20all=20the=20details=20on=20pa=
cketdrill=20and=20we=20are=20also=20exploring=20USENIX=202013=20material.=
=0D=0AI=20have=20one=20question.=20The=20issue=20happens=20when=20DUT=20rec=
eives=20TCP=20ack=20with=20large=20delay=20from=20network,=20e.g.,=2028seco=
nds=20since=20last=20Tx.=20Is=20packetdrill=20able=20to=20emulate=20this=20=
network=20delay=20(or=20congestion)=20in=20script=20level?=0D=0A=0D=0A

