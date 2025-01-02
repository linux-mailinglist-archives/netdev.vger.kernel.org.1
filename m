Return-Path: <netdev+bounces-154664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 398099FF546
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 01:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED8A21881E40
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 00:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED57510F1;
	Thu,  2 Jan 2025 00:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="rvD2hOY6"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3F6137E
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 00:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735777377; cv=none; b=FotYC1qRscwBj3n520YqjyaVTkRzkVLEwTdbQakiFyat/VwshLPQO9446EA6JsVxGAeyXlDlaslJiUhhBUO7ub+AStakeAVDo3D7OrBQm+7fSHvbPlauVCbsZ2wQ6F7t49n00fUZtQOXOCZiZpU2m1J6SIDtTg8M3YggftBiJpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735777377; c=relaxed/simple;
	bh=Gv8f02+xHhfCQxWh6cGevOqa9ia9gHzPGUmGt/PGUlI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=mtTiq5mFw2p+F7Bg2AMk81lBfKcysK1O8ATpXFckR3l1umvWPSPWTSP793oTDYGA4E76maQj1ayFLfgs2VgwksQBUcmmquYaKDb749tfpthDnQCvJFPmDrMUD39j41ql9AHJPN+zerkU13smne03mMH/tzT17Bqp2MHafXn6bRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=rvD2hOY6; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250102002246epoutp04af5ebacdda4a47ef70664271e24d4b0f~WuFGDVni_0447004470epoutp04L
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 00:22:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250102002246epoutp04af5ebacdda4a47ef70664271e24d4b0f~WuFGDVni_0447004470epoutp04L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1735777366;
	bh=Gv8f02+xHhfCQxWh6cGevOqa9ia9gHzPGUmGt/PGUlI=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=rvD2hOY6ws42dL8/yUzBCzeeJYiy9y4yKthEBPDOZYwlnQ67gH57X2e8Y37Kez3PU
	 jjxJEU+6YVdxdGwpIJr1tYsR+TtCXUVGTFyzjlyufV+bz5v2LsMcoTG1jTKCmjuHDA
	 77FMIxCaDz/910271NugGPo2nQDsz5IfGqcO1IEs=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20250102002245epcas2p2899539014dba12e5d3e17cd50f336b85~WuFFa1K2n3121431214epcas2p20;
	Thu,  2 Jan 2025 00:22:45 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.97]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4YNnTx2SMcz4x9Pw; Thu,  2 Jan
	2025 00:22:45 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	A0.95.22105.55CD5776; Thu,  2 Jan 2025 09:22:45 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20250102002244epcas2p245bdbc26e90b863ebbb83cef5a035290~WuFENIGq62925829258epcas2p2G;
	Thu,  2 Jan 2025 00:22:44 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250102002244epsmtrp1b132579545308e03dd5a9364d0833ef5~WuFEL2eFJ2375123751epsmtrp1I;
	Thu,  2 Jan 2025 00:22:44 +0000 (GMT)
X-AuditID: b6c32a47-fd1c970000005659-1c-6775dc55e4e4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	14.24.18949.45CD5776; Thu,  2 Jan 2025 09:22:44 +0900 (KST)
Received: from KORCO117327 (unknown [10.229.60.106]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20250102002244epsmtip2cf1f88c388f195191f64d24b0559e82b~WuFD4zf0Z1256912569epsmtip2S;
	Thu,  2 Jan 2025 00:22:44 +0000 (GMT)
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
In-Reply-To: <CANn89iK0g7uqduiAMZ0jax4_Y+P=0pJUArsd=LAhAHa2j+gRAg@mail.gmail.com>
Subject: RE: [PATCH] tcp: check socket state before calling WARN_ON
Date: Thu, 2 Jan 2025 09:22:33 +0900
Message-ID: <088701db5cac$71301b30$53905190$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL4yZmsudMRkH1MkhPtbuC345sC9QKRMuYdAUIxOFgBsMn9rAIf5xWWAZwDXWsBNR7tnQJ0dudGAPMj/mwCPP60LAEh3GCHAj4uPtAC9F+sfAGm2IYkAiMYjOkCB8c0QwF3zP4Ur9oFrQA=
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOJsWRmVeSWpSXmKPExsWy7bCmmW7ondJ0g80nuSzebGK2uLZ3IrvF
	nPMtLBbrdrUyWTw99ojdYvIURoum/ZeYLQ5Mmclq8aj/BJvFtreHmSw+33rHbHF1N5C4sK2P
	1WLi/SlsFpd3zWGz6Lizl8Xi2AIxi2+n3zBa/G26wW7R+vgzu8XH403sFosPfGJ3EPPYsvIm
	k8eCTaUem1Z1snm833eVzaNvyypGj8+b5ALYorJtMlITU1KLFFLzkvNTMvPSbZW8g+Od403N
	DAx1DS0tzJUU8hJzU22VXHwCdN0yc4BeUlIoS8wpBQoFJBYXK+nb2RTll5akKmTkF5fYKqUW
	pOQUmBfoFSfmFpfmpevlpZZYGRoYGJkCFSZkZ3z5GVRwdDJjxcYVe1kaGE/0M3YxcnJICJhI
	PD51g7mLkYtDSGAHo8S0wwdZIZxPjBJPTi9ig3C+MUqs27eTFableO9VFojEXkaJTVMaoVpe
	MkpsOT+DCaSKTUBX4u+zmewgtoiAlsTZE7PAipgFrrJITP3bzAaS4BQIlHjzbA5Yg7CAs8TE
	vTPBbBYBFYkVe3tYQGxeAUuJSzf+MUHYghInZz4BizMLaEssW/iaGeIkBYmfT5eBLRARmMco
	8frJdXaIIhGJ2Z1tYO9JCPznkOhf9B3qCReJvU+/MkHYwhKvjm9hh7ClJF72t0HZxRLfrx9h
	hGhuYJT48Og1G0TCWKJ52QOgMziANmhKrN+lD2JKCChLHLkFdRyfRMfhv+wQYV6JjjYhiEZV
	ia0LfkINkZbY++M16wRGpVlIXpuF5LVZSD6YhbBrASPLKkax1ILi3PTUYqMCY3iEJ+fnbmIE
	p3gt9x2MM95+0DvEyMTBeIhRgoNZSYQ3IrwkXYg3JbGyKrUoP76oNCe1+BCjKTCwJzJLiSbn
	A7NMXkm8oYmlgYmZmaG5kamBuZI4773WuSlCAumJJanZqakFqUUwfUwcnFINTHGnMz8lXNje
	GKdix69dnHpuq0BuaMKzX8eL1md/0ryz4vKSo/lx71zeLbPZITDp2XfNb1578lgaDlk9+PXi
	FOcLpo0N/W+ffXk//alB5O+vrRWcNg9S05WWZC9cGvxFrl1H45zRmic3dZ632Ao7GBsqPzng
	Y/wodurl64z1sgk9V/nXHPrdNGuh5sdZ2dZzH8kXFLV8O+2xW1SK4bB/hMnEltk3Wa03m9fc
	Xnc59Nn1Gb6nQjMvrLuduCNos3Qf/+niica22zcu4zArSTvb6OMfzq2zZkrPIuWpL15G/Lgt
	qf5+tvznD3wWgsDM8z76V3e5/Z6I5QuZxF8bliis2r/Cz/pkR9KZKdUHuQXP7lJiKc5INNRi
	LipOBAAV5D+KegQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7bCSvG7IndJ0g9b58hZvNjFbXNs7kd1i
	zvkWFot1u1qZLJ4ee8RuMXkKo0XT/kvMFgemzGS1eNR/gs1i29vDTBafb71jtri6G0hc2NbH
	ajHx/hQ2i8u75rBZdNzZy2JxbIGYxbfTbxgt/jbdYLdoffyZ3eLj8SZ2i8UHPrE7iHlsWXmT
	yWPBplKPTas62Tze77vK5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZ3U+MCu6GVCzoe8Xe
	wHjdrIuRk0NCwETieO9Vli5GLg4hgd2MEtd+7GWHSEhLrL3wBsoWlrjfcoQVoug5o8TMI3dY
	QRJsAroSf5/NBCsSEdCSOHtiFlgRs8BbFoldu5YzQXRsYJd4tOMGM0gVp0CgxJtnc5hAbGEB
	Z4mJe2eC2SwCKhIr9vawgNi8ApYSl278Y4KwBSVOznwCFmcW0JbofdjKCGMvW/iaGeI8BYmf
	T5eBbRYRmMco8frJdXaIIhGJ2Z1tzBMYhWchmTULyaxZSGbNQtKygJFlFaNkakFxbnpusWGB
	UV5quV5xYm5xaV66XnJ+7iZGcKxrae1g3LPqg94hRiYOxkOMEhzMSiK8EeEl6UK8KYmVValF
	+fFFpTmpxYcYpTlYlMR5v73uTRESSE8sSc1OTS1ILYLJMnFwSjUw7T665ET7PNsv+/+3r/6a
	6393gfcD9ay399kZq280BU3O4vnA+bK42Vp5os3xF5Yr03Yk6X2z1+pwqWn5b+bCnJ/x72Fi
	2U39L3/luO8KzdgupTT/CuOFRN1fkycGi84TyrDJ3xlxM8JL4E/AQpfThxY0m/IKLb5yR/wJ
	98KQILXbhTUzTIOk861UhWM5RRwimhtF2++dnBZfrRNfN/VwBZvvxj0cbtUcoiv1/V8zhTl9
	2en3TfRl4d2Ek2d4P/wyi36oknJ5Sek/8fx2DxX3FULqttlXJGd1dx1doVorkCx3fpXK7Zym
	c9ft+ALLepK3R+vEOifyLOetS++YdF+bafba7ja5Iskzl2xSG5RYijMSDbWYi4oTAR5be/pk
	AwAA
X-CMS-MailID: 20250102002244epcas2p245bdbc26e90b863ebbb83cef5a035290
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

On Mon, Dec 30, 2024 at 6:34 PM Eric Dumazet <edumazet=40google.com>
wrote:
>
> On Mon, Dec 30, 2024 at 1:24=E2=80=AFAM=20Dujeong.lee=20<dujeong.lee=40sa=
msung.com>=0D=0A>=20wrote:=0D=0A>=20>=0D=0A>=20>=20On=20Wed,=20Dec=2018,=20=
2024=207:28=20PM=20Eric=20Dumazet=20<edumazet=40google.com>=20wrote:=0D=0A>=
=20>=0D=0A>=20>=20>=20On=20Wed,=20Dec=2018,=202024=20at=2011:18=E2=80=AFAM=
=20Dujeong.lee=0D=0A>=20>=20>=20<dujeong.lee=40samsung.com>=0D=0A>=20>=20>=
=20wrote:=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20Tue,=20December=2010,=202=
024=20at=204:10=20PM=20Dujeong=20Lee=20wrote:=0D=0A>=20>=20>=20>=20>=20On=
=20Tue,=20Dec=2010,=202024=20at=2012:39=20PM=20Dujeong=20Lee=20wrote:=0D=0A=
>=20>=20>=20>=20>=20>=20On=20Mon,=20Dec=209,=202024=20at=207:21=20PM=20Eric=
=20Dumazet=0D=0A>=20>=20>=20>=20>=20>=20<edumazet=40google.com>=0D=0A>=20>=
=20>=20wrote:=0D=0A>=20>=20>=20>=20>=20>=20>=20On=20Mon,=20Dec=209,=202024=
=20at=2011:16=E2=80=AFAM=20Dujeong.lee=0D=0A>=20>=20>=20>=20>=20>=20>=20<du=
jeong.lee=40samsung.com>=0D=0A>=20>=20>=20>=20>=20>=20>=20wrote:=0D=0A>=20>=
=20>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=
=20>=20>=20>=20>=20Thanks=20for=20all=20the=20details=20on=20packetdrill=20=
and=20we=20are=20also=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20exploring=0D=0A>=
=20>=20>=20>=20>=20>=20>=20USENIX=202013=20material.=0D=0A>=20>=20>=20>=20>=
=20>=20>=20>=20I=20have=20one=20question.=20The=20issue=20happens=20when=20=
DUT=20receives=0D=0A>=20>=20>=20>=20>=20>=20>=20>=20TCP=20ack=20with=0D=0A>=
=20>=20>=20>=20>=20>=20>=20large=20delay=20from=20network,=20e.g.,=2028seco=
nds=20since=20last=20Tx.=20Is=0D=0A>=20>=20>=20>=20>=20>=20>=20packetdrill=
=20able=20to=20emulate=20this=20network=20delay=20(or=0D=0A>=20>=20>=20>=20=
>=20>=20>=20congestion)=20in=20script=0D=0A>=20>=20>=20>=20>=20>=20level?=
=0D=0A>=20>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20>=20Yes,=20the=
=20packetdrill=20scripts=20can=20wait=20an=20arbitrary=20amount=20of=0D=0A>=
=20>=20>=20>=20>=20>=20>=20time=20between=20each=20event=0D=0A>=20>=20>=20>=
=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20>=20+28=20<next=20event>=0D=0A>=
=20>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20>=2028=20seconds=20se=
ems=20okay.=20If=20the=20issue=20was=20triggered=20after=204=0D=0A>=20>=20>=
=20>=20>=20>=20>=20days,=20packetdrill=20would=20be=20impractical=20;)=0D=
=0A>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20Hi=20all,=0D=0A>=20>=
=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20We=20secured=20new=20ramdump.=
=0D=0A>=20>=20>=20>=20>=20>=20Please=20find=20the=20below=20values=20with=
=20TCP=20header=20details.=0D=0A>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20=
>=20>=20tp->packets_out=20=3D=200=0D=0A>=20>=20>=20>=20>=20>=20tp->sacked_o=
ut=20=3D=200=0D=0A>=20>=20>=20>=20>=20>=20tp->lost_out=20=3D=201=0D=0A>=20>=
=20>=20>=20>=20>=20tp->retrans_out=20=3D=201=0D=0A>=20>=20>=20>=20>=20>=20t=
p->rx_opt.sack_ok=20=3D=205=20(tcp_is_sack(tp))=20mss_cache=20=3D=201400=0D=
=0A>=20>=20>=20>=20>=20>=20((struct=20inet_connection_sock=20*)sk)->icsk_ca=
_state=20=3D=204=0D=0A>=20>=20>=20>=20>=20>=20((struct=20inet_connection_so=
ck=20*)sk)->icsk_pmtu_cookie=20=3D=201500=0D=0A>=20>=20>=20>=20>=20>=0D=0A>=
=20>=20>=20>=20>=20>=20Hex=20from=20ip=20header:=0D=0A>=20>=20>=20>=20>=20>=
=2045=2000=2000=2040=2075=2040=2000=2000=2039=2006=2091=2013=208E=20FB=202A=
=20CA=20C0=20A8=2000=20F7=2001=0D=0A>=20>=20>=20>=20>=20>=20BB=0D=0A>=20>=
=20>=20>=20>=20>=20A7=20CC=2051=0D=0A>=20>=20>=20>=20>=20>=20F8=2063=20CC=
=2052=2059=206D=20A6=20B0=2010=2004=2004=2077=2076=2000=2000=2001=2001=2008=
=200A=2089=2072=0D=0A>=20>=20>=20>=20>=20>=20C8=0D=0A>=20>=20>=20>=20>=20>=
=2042=0D=0A>=20>=20>=20>=20>=20>=2062=20F5=0D=0A>=20>=20>=20>=20>=20>=20F5=
=20D1=2001=2001=2005=200A=2052=2059=206D=20A5=2052=2059=206D=20A6=0D=0A>=20=
>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20Transmission=20Control=20Pro=
tocol=0D=0A>=20>=20>=20>=20>=20>=20Source=20Port:=20443=0D=0A>=20>=20>=20>=
=20>=20>=20Destination=20Port:=2042956=0D=0A>=20>=20>=20>=20>=20>=20TCP=20S=
egment=20Len:=200=0D=0A>=20>=20>=20>=20>=20>=20Sequence=20Number=20(raw):=
=201375232972=20Acknowledgment=20number=20(raw):=0D=0A>=20>=20>=20>=20>=20>=
=201381592486=0D=0A>=20>=20>=20>=20>=20>=201011=20....=20=3D=20Header=20Len=
gth:=2044=20bytes=20(11)=0D=0A>=20>=20>=20>=20>=20>=20Flags:=200x010=20(ACK=
)=0D=0A>=20>=20>=20>=20>=20>=20Window:=201028=0D=0A>=20>=20>=20>=20>=20>=20=
Calculated=20window=20size:=201028=0D=0A>=20>=20>=20>=20>=20>=20Urgent=20Po=
inter:=200=0D=0A>=20>=20>=20>=20>=20>=20Options:=20(24=20bytes),=20No-Opera=
tion=20(NOP),=20No-Operation=20(NOP),=0D=0A>=20>=20>=20>=20>=20>=20Timestam=
ps,=20No-Operation=20(NOP),=20No-Operation=20(NOP),=20SACK=0D=0A>=20>=20>=
=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20If=20anyone=20wants=20to=20check=
=20other=20values,=20please=20feel=20free=20to=20ask=0D=0A>=20>=20>=20>=20>=
=20>=20me=0D=0A>=20>=20>=20>=20>=20>=0D=0A>=20>=20>=20>=20>=20>=20Thanks,=
=0D=0A>=20>=20>=20>=20>=20>=20Dujeong.=0D=0A>=20>=20>=20>=20>=0D=0A>=20>=20=
>=20>=20>=20I=20have=20a=20question.=0D=0A>=20>=20>=20>=20>=0D=0A>=20>=20>=
=20>=20>=20From=20the=20latest=20ramdump=20I=20could=20see=20that=0D=0A>=20=
>=20>=20>=20>=201)=20tcp_sk(sk)->packets_out=20=3D=200=0D=0A>=20>=20>=20>=
=20>=202)=20inet_csk(sk)->icsk_backoff=20=3D=200=0D=0A>=20>=20>=20>=20>=203=
)=20sk_write_queue.len=20=3D=200=0D=0A>=20>=20>=20>=20>=20which=20suggests=
=20that=20tcp_write_queue_purge=20was=20indeed=20called.=0D=0A>=20>=20>=20>=
=20>=0D=0A>=20>=20>=20>=20>=20Noting=20that:=0D=0A>=20>=20>=20>=20>=201)=20=
tcp_write_queue_purge=20reset=20packets_out=20to=200=20and=0D=0A>=20>=20>=
=20>=20>=202)=20in_flight=20should=20be=20non-negative=20where=20in_flight=
=20=3D=0D=0A>=20>=20>=20>=20>=20packets_out=20-=20left_out=20+=20retrans_ou=
t,=20what=20if=20we=20reset=20left_out=0D=0A>=20>=20>=20>=20>=20and=20retra=
ns_out=20as=20well=20in=20tcp_write_queue_purge?=0D=0A>=20>=20>=20>=20>=0D=
=0A>=20>=20>=20>=20>=20Do=20we=20see=20any=20potential=20issue=20with=20thi=
s?=0D=0A>=20>=20>=20>=0D=0A>=20>=20>=20>=20Hello=20Eric=20and=20Neal.=0D=0A=
>=20>=20>=20>=0D=0A>=20>=20>=20>=20It=20is=20a=20gentle=20reminder.=0D=0A>=
=20>=20>=20>=20Could=20you=20please=20review=20the=20latest=20ramdump=20val=
ues=20and=20and=20question?=0D=0A>=20>=20>=0D=0A>=20>=20>=20It=20will=20hav=
e=20to=20wait=20next=20year,=20Neal=20is=20OOO.=0D=0A>=20>=20>=0D=0A>=20>=
=20>=20I=20asked=20a=20packetdrill=20reproducer,=20I=20can=20not=20spend=20=
days=20working=20on=20an=0D=0A>=20>=20>=20issue=20that=20does=20not=20trigg=
er=20in=20our=20production=20hosts.=0D=0A>=20>=20>=0D=0A>=20>=20>=20Somethi=
ng=20could=20be=20wrong=20in=20your=20trees,=20or=20perhaps=20some=20eBPF=
=20program=0D=0A>=20>=20>=20changing=20the=20state=20of=20the=20socket...=
=0D=0A>=20>=0D=0A>=20>=20Hi=20Eric=0D=0A>=20>=0D=0A>=20>=20I=20tried=20to=
=20make=20packetdrill=20script=20for=20local=20mode,=20which=20injects=20de=
layed=0D=0A>=20acks=20for=20data=20and=20FIN=20after=20close.=0D=0A>=20>=0D=
=0A>=20>=20//=20Test=20basic=20connection=20teardown=20where=20local=20proc=
ess=20closes=20first:=0D=0A>=20>=20//=20the=20local=20process=20calls=20clo=
se()=20first,=20so=20we=20send=20a=20FIN.=0D=0A>=20>=20//=20Then=20we=20rec=
eive=20an=20delayed=20ACK=20for=20data=20and=20FIN.=0D=0A>=20>=20//=20Then=
=20we=20receive=20a=20FIN=20and=20ACK=20it.=0D=0A>=20>=0D=0A>=20>=20=60../c=
ommon/defaults.sh=60=0D=0A>=20>=20=20=20=20=200=20socket(...,=20SOCK_STREAM=
,=20IPPROTO_TCP)=20=3D=203=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=0D=0A>=20Create=20socket=0D=
=0A>=20>=20=20=20=20+.01...0.011=20connect(3,=20...,=20...)=20=3D=200=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20//=0D=0A>=20Initiate=20connection=0D=0A>=
=20>=20=20=20=20+0=20>=20=20S=200:0(0)=20<...>=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Send=0D=
=0A>=20SYN=0D=0A>=20>=20=20=20=20+0=20<=20S.=200:0(0)=20ack=201=20win=20327=
68=20<mss=201000,nop,wscale=206,nop,nop,sackOK>=0D=0A>=20//=20Receive=20SYN=
-ACK=20with=20TCP=20options=0D=0A>=20>=20=20=20=20+0=20>=20=20.=201:1(0)=20=
ack=201=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20//=20Send=0D=0A>=20ACK=0D=0A>=20>=0D=0A>=20>=20=20=
=20=20+0=20write(3,=20...,=201000)=20=3D=201000=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20//=0D=0A>=20Write=201000=20bytes=0D=0A>=
=20>=20=20=20=20+0=20>=20=20P.=201:1001(1000)=20ack=201=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Send=0D=0A>=20data=
=20with=20PSH=20flag=0D=0A>=20>=0D=0A>=20>=20=20=20=20+0=20close(3)=20=3D=
=200=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20//=20Local=0D=0A>=20side=20initiates=20=
close=0D=0A>=20>=20=20=20=20+0=20>=20=20F.=201001:1001(0)=20ack=201=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Send=0D=
=0A>=20FIN=0D=0A>=20>=20=20=20=20+1=20<=20.=201:1(0)=20ack=201001=20win=202=
57=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=0D=0A>=
=20Receive=20ACK=20for=20data=0D=0A>=20>=20=20=20=20+0=20<=20.=201:1(0)=20a=
ck=201002=20win=20257=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20//=0D=0A>=20Receive=20ACK=20for=20FIN=0D=0A>=20>=0D=0A>=20>=20=20=20=
=20+0=20<=20F.=201:1(0)=20ack=201002=20win=20257=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20//=0D=0A>=20Receive=20FIN=20from=20remote=0D=
=0A>=20>=20=20=20=20+0=20>=20=20.=201002:1002(0)=20ack=202=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Send=0D=0A>=
=20ACK=20for=20FIN=0D=0A>=20>=0D=0A>=20>=0D=0A>=20>=20But=20got=20below=20e=
rror=20when=20I=20run=20the=20script.=0D=0A>=20>=0D=0A>=20>=20=24=20sudo=20=
./packetdrill=20../tcp/close/close-half-delayed-ack.pkt=0D=0A>=20>=20../tcp=
/close/close-half-delayed-ack.pkt:22:=20error=20handling=20packet:=0D=0A>=
=20>=20live=20packet=20field=20tcp_fin:=20expected:=200=20(0x0)=20vs=20actu=
al:=201=20(0x1)=20script=0D=0A>=20>=20packet:=20=201.010997=20.=201002:1002=
(0)=20ack=202=20actual=20packet:=20=200.014840=20F.=0D=0A>=20>=201001:1001(=
0)=20ack=201=20win=20256=0D=0A>=20=0D=0A>=20This=20means=20the=20FIN=20was=
=20retransmited=20earlier.=0D=0A>=20Then=20the=20data=20segment=20was=20pro=
bably=20also=20retransmit.=0D=0A>=20=0D=0A>=20You=20can=20use=20=22tcpdump=
=20-i=20any=20&=22=20while=20developing=20your=20script.=0D=0A>=20=0D=0A>=
=20=20=20=20=200=20socket(...,=20SOCK_STREAM,=20IPPROTO_TCP)=20=3D=203=0D=
=0A>=20=20=20=20=20=20=20=20//=20Create=20socket=0D=0A>=20=20=20=20+.01...0=
.111=20connect(3,=20...,=20...)=20=3D=200=0D=0A>=20=20=20=20=20=20=20=20//=
=20Initiate=20connection=0D=0A>=20=20=20=20+0=20>=20=20S=200:0(0)=20<...>=
=0D=0A>=20=20=20=20=20=20=20=20//=20Send=20SYN=0D=0A>=20=20=20+.1=20<=20S.=
=200:0(0)=20ack=201=20win=2032768=20<mss=201000,nop,wscale=0D=0A>=206,nop,n=
op,sackOK>=20=20=20=20=20=20//=20Receive=20SYN-ACK=20with=20TCP=20options=
=0D=0A>=20=20=20=20+0=20>=20=20.=201:1(0)=20ack=201=0D=0A>=20=20=20=20=20=
=20=20=20//=20Send=20ACK=0D=0A>=20=0D=0A>=20=20=20=20+0=20write(3,=20...,=
=201000)=20=3D=201000=0D=0A>=20=20=20=20=20=20=20=20//=20Write=201000=20byt=
es=0D=0A>=20=20=20=20+0=20>=20=20P.=201:1001(1000)=20ack=201=0D=0A>=20=20=
=20=20=20=20=20=20//=20Send=20data=20with=20PSH=20flag=0D=0A>=20=0D=0A>=20=
=20=20=20+0=20close(3)=20=3D=200=0D=0A>=20=20=20=20=20=20=20=20//=20Local=
=20side=20initiates=20close=0D=0A>=20=20=20=20+0=20>=20=20F.=201001:1001(0)=
=20ack=201=0D=0A>=20=20=20=20=20=20=20=20//=20Send=20FIN=0D=0A>=20=20=20+.2=
=20>=20=20F.=201001:1001(0)=20ack=201=20=20=20=20//=20FIN=20retransmit=0D=
=0A>=20+.2=7E+.4=20>=20=20P.=201:1001(1000)=20ack=201=20//=20RTX=0D=0A>=20=
=0D=0A>=20=20=20=20+0=20<=20.=201:1(0)=20ack=201001=20win=20257=0D=0A>=20=
=20=20=20=20=20=20=20=20//=20Receive=20ACK=20for=20data=0D=0A>=20=20=20=20+=
0=20>=20F.=201001:1001(0)=20ack=201=20//=20FIN=20retransmit=0D=0A>=20=20=20=
=20+0=20<=20.=201:1(0)=20ack=201002=20win=20257=0D=0A>=20=20=20=20=20=20=20=
=20//=20Receive=20ACK=20for=20FIN=0D=0A>=20=0D=0A>=20=20=20=20+0=20<=20F.=
=201:1(0)=20ack=201002=20win=20257=0D=0A>=20=20=20=20=20=20=20=20//=20Recei=
ve=20FIN=20from=20remote=0D=0A>=20=20=20=20+0=20>=20=20.=201002:1002(0)=20a=
ck=202=0D=0A>=20=20=20=20=20=20=20=20//=20Send=20ACK=20for=20FIN=0D=0A=0D=
=0AHi=20Eric,=0D=0A=0D=0AI=20modified=20the=20script=20and=20inlined=20tcpd=
ump=20capture=0D=0A=0D=0A=60../common/defaults.sh=60=0D=0A=20=20=20=200=20s=
ocket(...,=20SOCK_STREAM,=20IPPROTO_TCP)=20=3D=203=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20C=
reate=20socket=0D=0A=20=20=20+.01...0.011=20connect(3,=20...,=20...)=20=3D=
=200=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Initiate=20connection=0D=
=0A=20=20=20+0=20>=20=20S=200:0(0)=20<...>=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Send=20SYN=0D=
=0A1=200.000000=20192.168.114.235=20192.0.2.1=20TCP=2080=2040784=20=E2=86=
=92=208080=20=5BSYN=5D=20Seq=3D0=20Win=3D65535=20Len=3D0=20MSS=3D1460=20SAC=
K_PERM=20TSval=3D2913446377=20TSecr=3D0=20WS=3D256=0D=0A=0D=0A=20=20=20+0=
=20<=20S.=200:0(0)=20ack=201=20win=2032768=20<mss=201000,nop,wscale=206,nop=
,nop,sackOK>=20=20=20=20=20=20//=20Receive=20SYN-ACK=20with=20TCP=20options=
=0D=0A2=200.000209=20192.0.2.1=20192.168.114.235=20TCP=2072=208080=20=E2=86=
=92=2040784=20=5BSYN,=20ACK=5D=20Seq=3D0=20Ack=3D1=20Win=3D32768=20Len=3D0=
=20MSS=3D1000=20WS=3D64=20SACK_PERM=0D=0A=0D=0A=20=20=20+0=20>=20=20.=201:1=
(0)=20ack=201=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20//=20Send=20ACK=0D=0A3=200.000260=20192.168.1=
14.235=20192.0.2.1=20TCP=2060=2040784=20=E2=86=92=208080=20=5BACK=5D=20Seq=
=3D1=20Ack=3D1=20Win=3D65536=20Len=3D0=0D=0A=0D=0A=20=20=20+0=20write(3,=20=
...,=201000)=20=3D=201000=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20//=20Write=201000=20bytes=0D=0A=20=20=20+0=20>=20=20P.=201:1=
001(1000)=20ack=201=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20//=20Send=20data=20with=20PSH=20flag=0D=0A4=200.000344=20192=
.168.114.235=20192.0.2.1=20TCP=201060=2040784=20=E2=86=92=208080=20=5BPSH,=
=20ACK=5D=20Seq=3D1=20Ack=3D1=20Win=3D65536=20Len=3D1000=0D=0A=0D=0A=20=20=
=20+0=20close(3)=20=3D=200=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Local=20side=
=20initiates=20close=0D=0A=20=20=20+0=20>=20=20F.=201001:1001(0)=20ack=201=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20S=
end=20FIN=0D=0A5=200.000381=20192.168.114.235=20192.0.2.1=20TCP=2060=204078=
4=20=E2=86=92=208080=20=5BFIN,=20ACK=5D=20Seq=3D1001=20Ack=3D1=20Win=3D6553=
6=20Len=3D0=0D=0A=0D=0A=20=20=20+.2=20>=20=20F.=201001:1001(0)=20ack=201=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20FIN=20r=
etransmit=0D=0A6=200.004545=20192.168.114.235=20192.0.2.1=20TCP=2060=20=5BT=
CP=20Retransmission=5D=2040784=20=E2=86=92=208080=20=5BFIN,=20ACK=5D=20Seq=
=3D1001=20Ack=3D1=20Win=3D65536=20Len=3D0=0D=0A=0D=0A=20=20=20+.2=7E+.4=20>=
=20=20P.=201:1001(1000)=20ack=201=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20//=20RTX=0D=0A=20=20=20+0=20<=20.=201:1(0)=20ack=201001=20win=
=20257=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Rece=
ive=20ACK=20for=20data=0D=0A=20=20=20+0=20<=20.=201:1(0)=20ack=201002=20win=
=20257=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20Rece=
ive=20ACK=20for=20FIN=0D=0A=0D=0A=20=20=20+0=20<=20F.=201:1(0)=20ack=201002=
=20win=20257=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=20R=
eceive=20FIN=20from=20remote=0D=0A=20=20=20+0=20>=20=20.=201002:1002(0)=20a=
ck=202=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20//=20Send=20ACK=20for=20FIN=0D=0A=0D=0A=0D=0AAnd=20hit=20below=20error.=
=0D=0A../tcp/close/close-half-delayed-ack.pkt:18:=20error=20handling=20pack=
et:=20timing=20error:=20expected=20outbound=20packet=20at=200.210706=20sec=
=20but=20happened=20at=200.014838=20sec;=20tolerance=200.025002=20sec=0D=0A=
script=20packet:=20=200.210706=20F.=201001:1001(0)=20ack=201=0D=0Aactual=20=
packet:=20=200.014838=20F.=201001:1001(0)=20ack=201=20win=20256=0D=0A=0D=0A=
For=20me,=20it=20looks=20like=20delay=20in=20below=20line=20does=20not=20ta=
ke=20effect=20by=20packetdrill.=0D=0A+.2=20>=20=20F.=201001:1001(0)=20ack=
=201=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20//=
=20FIN=20retransmit=0D=0A=0D=0AThanks,=0D=0ADujeong.=0D=0A=0D=0A

