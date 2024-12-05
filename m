Return-Path: <netdev+bounces-149380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED99A9E558B
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A92618817ED
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 12:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8319214A60;
	Thu,  5 Dec 2024 12:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mO05xHKe"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759951F03E7
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 12:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401878; cv=none; b=OhMgfvoQrXYKhpX5RzHBZWTmPq0BAWapXVXNmeigymF3FrLe9sUmDU+IMOui0opRLe5cXF0SGQUSUwD+HWxqGqxzZ+y8SQfK1A3K6mmAkzOAIyXxPf1RC5sV7yBReZrpNJ2ayG8kaA865J7svn+Bf2gqPqZp+4sNyJJ9GFz3Ujk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401878; c=relaxed/simple;
	bh=CmY1JFuhXZ2tCEaUQUh8wKv8A9K0V6GjX06prjM7ZY8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=XJb+4CEJh5VEtP9/78gh4yHee1OwGGbQ/8WrGfUeHq34DpsI4Esxwr70TqudNstsQPSfUFCHaceEV33LL/lT1unDeOdhY0LDZM7hAwyyCpmHh4Opn4WmCN7XGCF6uo8+lYa+bdqzY7MGm/IcmICW96q2f5XHVSrpXB2TOQCMvLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=mO05xHKe; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241205123113epoutp035a466742040f3161984b42c92b26eaaf~OR9HfL_Xb2719627196epoutp03U
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 12:31:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241205123113epoutp035a466742040f3161984b42c92b26eaaf~OR9HfL_Xb2719627196epoutp03U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733401873;
	bh=CmY1JFuhXZ2tCEaUQUh8wKv8A9K0V6GjX06prjM7ZY8=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=mO05xHKewyPcp29KWXALhSheT0rOSfIjO4qzSSyrMzPZOa5QKmgYIocCXZHfuDeKN
	 2xQy1lCU2WO6L/mq/4NSZgAvyZ20nu1S3A7kjMFBz7kY0I4v0TDknMdhz5XX51k3eq
	 /PDAZNx+HLcsku8h/UIqDMI2NCquCstmsS0kwqhA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20241205123112epcas2p3933fe5b47eb4634e14bdd36a4d9d3d70~OR9G5k0ef2248922489epcas2p3l;
	Thu,  5 Dec 2024 12:31:12 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.88]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4Y3tzN0MWRz4x9Pq; Thu,  5 Dec
	2024 12:31:12 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	EE.31.23368.F0D91576; Thu,  5 Dec 2024 21:31:11 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20241205123111epcas2p1c0206b659c8532af1ee44a8f4a2e69d6~OR9FkW6Ql0940709407epcas2p13;
	Thu,  5 Dec 2024 12:31:11 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241205123111epsmtrp23bf03357cf5604077d550016260f9db4~OR9FjYsn51570215702epsmtrp2-;
	Thu,  5 Dec 2024 12:31:11 +0000 (GMT)
X-AuditID: b6c32a45-db1ed70000005b48-aa-67519d0f85f2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	89.32.18729.F0D91576; Thu,  5 Dec 2024 21:31:11 +0900 (KST)
Received: from KORCO117327 (unknown [10.229.60.106]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241205123110epsmtip28970e441a60c97c6d8db819e87249889~OR9FRcMBz2026820268epsmtip21;
	Thu,  5 Dec 2024 12:31:10 +0000 (GMT)
From: "Dujeong.lee" <dujeong.lee@samsung.com>
To: "'Neal Cardwell'" <ncardwell@google.com>
Cc: "'Eric Dumazet'" <edumazet@google.com>, "'Youngmin Nam'"
	<youngmin.nam@samsung.com>, "'Jakub Kicinski'" <kuba@kernel.org>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <pabeni@redhat.com>,
	<horms@kernel.org>, <guo88.liu@samsung.com>, <yiwang.cai@samsung.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<joonki.min@samsung.com>, <hajun.sung@samsung.com>,
	<d7271.choe@samsung.com>, <sw.ju@samsung.com>, <iamyunsu.kim@samsung.com>,
	<kw0619.kim@samsung.com>, <hsl.lim@samsung.com>, <hanbum22.lee@samsung.com>,
	<chaemoo.lim@samsung.com>, <seungjin1.yu@samsung.com>
In-Reply-To: <CADVnQykPo35mQ1y16WD3zppENCeOi+2Ea_2m-AjUQVPc9SXm4g@mail.gmail.com>
Subject: RE: [PATCH] tcp: check socket state before calling WARN_ON
Date: Thu, 5 Dec 2024 21:31:10 +0900
Message-ID: <069d01db4711$90da3fc0$b28ebf40$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL4yZmsudMRkH1MkhPtbuC345sC9QKRMuYdAUIxOFgBsMn9rAIf5xWWAZwDXWsBNR7tnQHZPzuyAOwqR8+wMrkQ4A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEJsWRmVeSWpSXmKPExsWy7bCmmS7/3MB0g/1nLS3ebGK2uLZ3IrvF
	nPMtLBbrdrUyWTw99ojdYvIURoum/ZeYLQ5Mmclq8aj/BJvFtreHmSw+33rHbHF1N5C4sK2P
	1WLi/SlsFpd3zWGz6Lizl8Xi2AIxi2+n3zBa/G26wW7R+vgzu8XH403sFosPfGJ3EPPYsvIm
	k8eCTaUem1Z1snm833eVzaNvyypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403N
	DAx1DS0tzJUU8hJzU22VXHwCdN0yc4BeUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUW
	pOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ2yeWlcwTaPi65Yn7A2Mf9S6GDk5JARMJLZt
	Wc/cxcjFISSwg1Hi7fcpUM4nRokPK06wQDjfGCVaP/YCORxgLSte60PE9zJKHFk1nQ3Cecko
	0bD+GivIXDYBXYm/z2ayg9giAjoSV6d0gxUxC1xmkdg09w0ryCROgUCJmR1pIDXCAs4SE/fO
	ZAKxWQRUJPbN3MsIYvMKWErsubqBDcIWlDg58wkLiM0soC2xbOFrZogfFCR+Pl3GCrErS+L2
	921sEDUiErM728DekRBo55TYeeYTE0SDi8SryzugbGGJV8e3sEPYUhKf3+1lg7CLJb5fP8II
	0dwADItHr6ESxhLNyx6Ag4JZQFNi/S59SKgoSxy5BXUbn0TH4b/sEGFeiY42IYhGVYmtC35C
	DZGW2PvjNesERqVZSD6bheSzWUg+mIWwawEjyypGsdSC4tz01GKjAkN4XCfn525iBCd2Ldcd
	jJPfftA7xMjEwXiIUYKDWUmEtzIsMF2INyWxsiq1KD++qDQntfgQoykwrCcyS4km5wNzS15J
	vKGJpYGJmZmhuZGpgbmSOO+91rkpQgLpiSWp2ampBalFMH1MHJxSDUzKiQ27H8cbbr+0pe14
	kdoa+Tssffv8fsucO+Rx/P7kR1Lzy+eueh3SrmQ474w3z97kymtNjtySV2teqa3Z9nChzEuz
	k+tidE8m+O5QiJTNXOToH2d33W61XNLpn09yT0hc0vj2vqH5YtyVjXv2hu0ONonoqm1qV1lx
	yP/rd907V+94d7e12Yppu4mftl+oqLzlwRGucL9DjbPMzz95ynv751wz7gQ2KTtBRbHGvB16
	FR1uf/mD/atOhmekuy/Q6DNav+kZu9HToxcTxUST7X/Mk5TtVoh5yL9i92/DNos1IYndKQzu
	PyUeP21JqNd5fvR0jebcZvawNY7no1evzpdZbBr9wIFbdc/a96KnnimxFGckGmoxFxUnAgAX
	ZQxPdQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7bCSvC7/3MB0g44drBZvNjFbXNs7kd1i
	zvkWFot1u1qZLJ4ee8RuMXkKo0XT/kvMFgemzGS1eNR/gs1i29vDTBafb71jtri6G0hc2NbH
	ajHx/hQ2i8u75rBZdNzZy2JxbIGYxbfTbxgt/jbdYLdoffyZ3eLj8SZ2i8UHPrE7iHlsWXmT
	yWPBplKPTas62Tze77vK5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZPxq3sBT8lKq4dfsX
	UwPjT5EuRg4OCQETiRWv9bsYuTiEBHYzSrS/vczcxcgJFJeWWHvhDTuELSxxv+UIK0TRc0aJ
	qTPmMIEk2AR0Jf4+mwlWJCKgI3F1SjcbSBGzwGsWiTW7Z7BBdExgkZj3cgMjyDpOgUCJmR1p
	IA3CAs4SE/fOBBvEIqAisW/mXkYQm1fAUmLP1Q1sELagxMmZT1hAbGYBbYneh62MMPayha+h
	LlWQ+Pl0GSvEEVkSt79vY4OoEZGY3dnGPIFReBaSUbOQjJqFZNQsJC0LGFlWMUqmFhTnpucW
	GxYY5qWW6xUn5haX5qXrJefnbmIEx7mW5g7G7as+6B1iZOJgPMQowcGsJMJbGRaYLsSbklhZ
	lVqUH19UmpNafIhRmoNFSZxX/EVvipBAemJJanZqakFqEUyWiYNTqoFJOU2oyuvuM9Odgs89
	Wb26um3yVVPrYj0XXbKpXTnr9t6jvz7WvBCYZmN2vVul/q2l4NL5B2221GnNZJpief95+0++
	3XaXHl4N1Djx4ZRJ7jEv5vBjfA7/CrZkv+TZmnu/Zruh2eK/5r/3Vijum3dg2eKTz+Rcez9l
	H3b1/+ESvTfzwXtfHf2LrM0z+P847PWQ2fUsb9b0VesZub2f5IuVX3jSu/FGqkB6SvKtBM5Z
	fbd939np5V8y9DNbFCkYsOqQ3UOnNdX2d1LdLQ+6Cf/X9rvyapXiTUtPfZ2Em2LLPPOvf9R9
	6Gb8O2HGdFNFjkqhszev8DhHOH6V8b64I/tjoKbRrgPXPkkH3RMqzFmqxFKckWioxVxUnAgA
	KGjV52IDAAA=
X-CMS-MailID: 20241205123111epcas2p1c0206b659c8532af1ee44a8f4a2e69d6
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
	<009e01db4620$f08f42e0$d1adc8a0$@samsung.com>
	<CADVnQykPo35mQ1y16WD3zppENCeOi+2Ea_2m-AjUQVPc9SXm4g@mail.gmail.com>

On Wed, Dec 4, 2024 at 11:22 PM Neal Cardwell <ncardwell=40google.com> wrot=
e:
> On Wed, Dec 4, 2024 at 2:48=E2=80=AFAM=20Dujeong.lee=20<dujeong.lee=40sam=
sung.com>=20wrote:=0D=0A>=20>=20On=20Wed,=20Dec=204,=202024=20at=204:14=20P=
M=20Eric=20Dumazet=20wrote:=0D=0A>=20>=20>=20To:=20Youngmin=20Nam=20<youngm=
in.nam=40samsung.com>=0D=0A>=20>=20>=20Cc:=20Jakub=20Kicinski=20<kuba=40ker=
nel.org>;=20Neal=20Cardwell=0D=0A>=20>=20>=20<ncardwell=40google.com>;=20da=
vem=40davemloft.net;=20dsahern=40kernel.org;=0D=0A>=20>=20>=20pabeni=40redh=
at.com;=20horms=40kernel.org;=20dujeong.lee=40samsung.com;=0D=0A>=20>=20>=
=20guo88.liu=40samsung.com;=20yiwang.cai=40samsung.com;=0D=0A>=20>=20>=20ne=
tdev=40vger.kernel.org;=20linux-=20kernel=40vger.kernel.org;=0D=0A>=20>=20>=
=20joonki.min=40samsung.com;=20hajun.sung=40samsung.com;=0D=0A>=20>=20>=20d=
7271.choe=40samsung.com;=20sw.ju=40samsung.com=0D=0A>=20>=20>=20Subject:=20=
Re:=20=5BPATCH=5D=20tcp:=20check=20socket=20state=20before=20calling=20WARN=
_ON=0D=0A>=20>=20>=0D=0A>=20>=20>=20On=20Wed,=20Dec=204,=202024=20at=204:35=
=E2=80=AFAM=20Youngmin=20Nam=0D=0A>=20>=20>=20<youngmin.nam=40samsung.com>=
=0D=0A>=20>=20>=20wrote:=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20On=20Tue,=
=20Dec=2003,=202024=20at=2006:18:39PM=20-0800,=20Jakub=20Kicinski=20wrote:=
=0D=0A>=20>=20>=20>=20>=20On=20Tue,=203=20Dec=202024=2010:34:46=20-0500=20N=
eal=20Cardwell=20wrote:=0D=0A>=20>=20>=20>=20>=20>=20>=20I=20have=20not=20s=
een=20these=20warnings=20firing.=20Neal,=20have=20you=20seen=0D=0A>=20>=20>=
=20>=20>=20>=20>=20this=20in=0D=0A>=20>=20>=20the=20past=20?=0D=0A>=20>=20>=
=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20I=20can't=20recall=20seeing=20the=
se=20warnings=20over=20the=20past=205=20years=20or=0D=0A>=20>=20>=20>=20>=
=20>=20so,=20and=20(from=20checking=20our=20monitoring)=20they=20don't=20se=
em=20to=20be=0D=0A>=20>=20>=20>=20>=20>=20firing=20in=20our=20fleet=20recen=
tly.=0D=0A>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20FWIW=20I=20see=20this=
=20at=20Meta=20on=205.12=20kernels,=20but=20nothing=20since.=0D=0A>=20>=20>=
=20>=20>=20Could=20be=20that=20one=20of=20our=20workloads=20is=20pinned=20t=
o=205.12.=0D=0A>=20>=20>=20>=20>=20Youngmin,=20what's=20the=20newest=20kern=
el=20you=20can=20repro=20this=20on?=0D=0A>=20>=20>=20>=20>=0D=0A>=20>=20>=
=20>=20Hi=20Jakub.=0D=0A>=20>=20>=20>=20Thank=20you=20for=20taking=20an=20i=
nterest=20in=20this=20issue.=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20We've=
=20seen=20this=20issue=20since=205.15=20kernel.=0D=0A>=20>=20>=20>=20Now,=
=20we=20can=20see=20this=20on=206.6=20kernel=20which=20is=20the=20newest=20=
kernel=20we=0D=0A>=20>=20>=20>=20are=0D=0A>=20>=20>=20running.=0D=0A>=20>=
=20>=0D=0A>=20>=20>=20The=20fact=20that=20we=20are=20processing=20ACK=20pac=
kets=20after=20the=20write=20queue=0D=0A>=20>=20>=20has=20been=20purged=20w=
ould=20be=20a=20serious=20bug.=0D=0A>=20>=20>=0D=0A>=20>=20>=20Thus=20the=
=20WARN()=20makes=20sense=20to=20us.=0D=0A>=20>=20>=0D=0A>=20>=20>=20It=20w=
ould=20be=20easy=20to=20build=20a=20packetdrill=20test.=20Please=20do=20so,=
=20then=20we=0D=0A>=20>=20>=20can=20fix=20the=20root=20cause.=0D=0A>=20>=20=
>=0D=0A>=20>=20>=20Thank=20you=20=21=0D=0A>=20>=0D=0A>=20>=0D=0A>=20>=20Ple=
ase=20let=20me=20share=20some=20more=20details=20and=20clarifications=20on=
=20the=20issue=0D=0A>=20from=20ramdump=20snapshot=20locally=20secured.=0D=
=0A>=20>=0D=0A>=20>=201)=20This=20issue=20has=20been=20reported=20from=20An=
droid-T=20linux=20kernel=20when=20we=0D=0A>=20enabled=20panic_on_warn=20for=
=20the=20first=20time.=0D=0A>=20>=20Reproduction=20rate=20is=20not=20high=
=20and=20can=20be=20seen=20in=20any=20test=20cases=20with=0D=0A>=20public=
=20internet=20connection.=0D=0A>=20>=0D=0A>=20>=202)=20Analysis=20from=20ra=
mdump=20(which=20is=20not=20available=20at=20the=20moment).=0D=0A>=20>=202-=
A)=20From=20ramdump,=20I=20was=20able=20to=20find=20below=20values.=0D=0A>=
=20>=20tp->packets_out=20=3D=200=0D=0A>=20>=20tp->retrans_out=20=3D=201=0D=
=0A>=20>=20tp->max_packets_out=20=3D=201=0D=0A>=20>=20tp->max_packets_Seq=
=20=3D=201575830358=0D=0A>=20>=20tp->snd_ssthresh=20=3D=205=0D=0A>=20>=20tp=
->snd_cwnd=20=3D=201=0D=0A>=20>=20tp->prior_cwnd=20=3D=2010=0D=0A>=20>=20tp=
->wite_seq=20=3D=201575830359=0D=0A>=20>=20tp->pushed_seq=20=3D=20157583035=
8=0D=0A>=20>=20tp->lost_out=20=3D=201=0D=0A>=20>=20tp->sacked_out=20=3D=200=
=0D=0A>=20=0D=0A>=20Thanks=20for=20all=20the=20details=21=20If=20the=20ramd=
ump=20becomes=20available=20again=20at=20some=0D=0A>=20point,=20would=20it=
=20be=20possible=20to=20pull=20out=20the=20following=20values=20as=0D=0A>=
=20well:=0D=0A>=20=0D=0A>=20tp->mss_cache=0D=0A>=20inet_csk(sk)->icsk_pmtu_=
cookie=0D=0A>=20inet_csk(sk)->icsk_ca_state=0D=0A>=20=0D=0A>=20Thanks,=0D=
=0A>=20neal=0D=0A=0D=0AOkay=20I=20will=20check=20the=20below=20values=20onc=
e=20ramdump=20is=20secured.=0D=0A-=20tp->mss_cache=0D=0A-=20inet_csk(sk)->i=
csk_pmtu_cookie=0D=0A-=20inet_csk(sk)->icsk_ca_state=0D=0A=0D=0ANow=20we=20=
are=20running=20test=20with=20the=20latest=20kernel.=0D=0A=0D=0AThanks=0D=
=0ADujeong.=0D=0A=0D=0A

