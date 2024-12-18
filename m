Return-Path: <netdev+bounces-152877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1ED9F6297
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:19:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67A35170C59
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B0E619AD93;
	Wed, 18 Dec 2024 10:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YzqWish1"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1C035963
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517128; cv=none; b=IOe3GtBzPeEb27wTkFgUOUZVLKQm50sCXZ5viWOqlgv81lrN/k5uLc7IS+Rz65ez/66R7gEhVKoTSNTvxQj39VfPnHLJOM7IOtHG5p1IWcEKXb3o/ajKm+NXgIPF2I4+nmDaKs8bkO92uR8rKl0+mRTUJI9BfbSACIw5OEDYAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517128; c=relaxed/simple;
	bh=S+leEoMUKmB++YJLLF0FbcKWCmYED5dYeLb4exwsl3k=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=SQ/5BJmM572EqLwcbGGyicqLCbggifyel4h2d0CGpTzO9d1Qfza58nTBWVjIY/44fQPY5htjbYccNPYXq5K0LxeiS35EBhFIWCovcEgszxsZH5aNcnFjUgFANj00IRYZlQZmtpn7eIHbxZmowrELDKI+IkZlY8SVPfynJ+MbKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=YzqWish1; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241218101839epoutp04dcce84a8f8447bce3fad654a2abcfca5~SPiFPXvKD3206232062epoutp04P
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:18:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241218101839epoutp04dcce84a8f8447bce3fad654a2abcfca5~SPiFPXvKD3206232062epoutp04P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734517119;
	bh=S+leEoMUKmB++YJLLF0FbcKWCmYED5dYeLb4exwsl3k=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=YzqWish1gyN7CQtGzCMgrdY3LCTvNzMco/KSyI7TxcfpfJyWHwDnqQGU+gJNA5gs9
	 U8KYsMp7Hb0snVRX579IeZYHG7IcGintFlTrkL6vIGJoG5wDNNQP9dhjzHJJN2Cvc8
	 6OsOCSL5a5H9w5+uo6oD6W70JnLpP6L/E2Ce1rTc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20241218101838epcas2p22cd94e455794098c70f5a1b0e6d27682~SPiEm9FFn2310423104epcas2p2Y;
	Wed, 18 Dec 2024 10:18:38 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.69]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4YCqQQ02cRz4x9Pv; Wed, 18 Dec
	2024 10:18:38 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	57.80.22105.D71A2676; Wed, 18 Dec 2024 19:18:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20241218101837epcas2p2ccbf77d8339b03821896785002aadc07~SPiDl0u6t2068120681epcas2p2v;
	Wed, 18 Dec 2024 10:18:37 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241218101837epsmtrp1988cde02c3a65ed70ec346bf0e34721c~SPiDjr2tR2239222392epsmtrp1t;
	Wed, 18 Dec 2024 10:18:37 +0000 (GMT)
X-AuditID: b6c32a47-fd1c970000005659-32-6762a17dee00
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	AF.90.18949.D71A2676; Wed, 18 Dec 2024 19:18:37 +0900 (KST)
Received: from KORCO117327 (unknown [10.229.60.106]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241218101837epsmtip18d3a47fa3a1432c48524cd0d733d7ebf~SPiDSbEC40769107691epsmtip1j;
	Wed, 18 Dec 2024 10:18:37 +0000 (GMT)
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
Date: Wed, 18 Dec 2024 19:18:36 +0900
Message-ID: <000001db5136$336b1060$9a413120$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL4yZmsudMRkH1MkhPtbuC345sC9QKRMuYdAUIxOFgBsMn9rAIf5xWWAZwDXWsBNR7tnQJ0dudGAPMj/mwCPP60LAEh3GCHAj4uPtAC9F+sfK/wY3uQgAAiJJCADOBe8A==
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTVxzHc3ov9xZD3bV07Fgy15WRBUyh5dWDyLZYxCbiJDP8I2zdhd61
	hNLW3rLMRQxDYMAYiLwEVGDEjpVFHUN0YJUUIjJwPgbIiFPksemA8RyMZN3WB278c/L5nfP9
	/k6+58HF+E8IITddb2ZMelonJrbgHT1Bckl2U6pGmnc3HM22YWjEVk6iM3fycHShM5+Dpm9O
	kKiiEqDcG/cx1F1Z64Umym4RqGOuh4OWx37H0HCXc7jbUeqFyh9XEujHzjMEKnxow9HNRj+0
	OjALkCN3lET5k8skWuzLJVFz9xL5lp+y/aufOMrGtixlm7WIUM5fHyaUpe1WoFxu25FIHM7Y
	rWVoNWMSMfo0gzpdr4kV7z+kUqgio6QyiSwaycUiPZ3JxIrjEhIl8ek6ZySx6ENal+WcSqRZ
	Vhz6xm6TIcvMiLQG1hwrZoxqnVFuDGHpTDZLrwnRM+ZdMqk0LNIpfD9DW7K+1fjNqx+VNNzD
	c0CVqBhwuZCKgGVrnGKwhcunrgJ4ZfITzFMsAThYcJ0sBt7OYhXAL0pVzw2DF456NDYALQsW
	wlM8A3B+rcptICgJdPxS62YBFQxv36rzcokwahiHVY4ThKuTN8WDJ/+OcWl8KQUst9VyXIxT
	gdDe/8Dt5VHRcG34V46Ht8H+2incxRi1E1qaZjAXQ0oE16ct7v4C6hSAy9+e2xAJYH1RgTsO
	pD71hmWLzcDjiINDzYsb7At/62snPSyEz8oKNpiFaw96gcecA+DCxAzhWQiHJyzjuCsBRgXB
	i52hnmMJgL1jG/tuhYU9DtIzzYOFBXyPMRBeblzfaOIPbX/OeJ0E4rpN0eo2RavblKDu/70a
	AW4FfoyRzdQwbJgx/L+rTjNktgH3Ww/edxWcnlsIsQMOF9gB5GJiAS8+iNbweWr66MeMyaAy
	ZekY1g4inYddjglfTDM4P4verJJFREsjoqJk8rBIqVz8Eu9R/lk1n9LQZiaDYYyM6bmPw/UW
	5nCSK0CnYjFipfPawMqBsWvfJztoKjtlJPt45WrS6qV7b+b2vrb9UnXyexeLXvj652SNgCwa
	+EDX8uXl6n+efr4jNe6K44hPyXbvodutAlX3XE09+O6IXPLEp6L1Kbc/IkW47rPfOrrLdyrh
	xt4R9MPjv4Inp4RvgztnfV4/NHcedO2JH1WMH4udmm75I+YzhUJaON/QAs87DvLT7EnS1vHi
	lxtqzJqaGJwUHQs4rJVbhgLYnX37amz+ftyU7HfoUgVnQavOaxpcOhB1v3oI6304ddy+cjp2
	cFlyLv3Uo8DZrkCf+lBlkDWwqWRP2LvBe/XpCdgr8dYkSmaNPpiKZfq35IlxVkvLgjETS/8L
	sspcfXQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7bCSnG7twqR0g2s94hZvNjFbXNs7kd1i
	zvkWFot1u1qZLJ4ee8RuMXkKo0XT/kvMFgemzGS1eNR/gs1i29vDTBafb71jtri6G0hc2NbH
	ajHx/hQ2i8u75rBZdNzZy2JxbIGYxbfTbxgt/jbdYLdoffyZ3eLj8SZ2i8UHPrE7iHlsWXmT
	yWPBplKPTas62Tze77vK5tG3ZRWjx+dNcgFsUVw2Kak5mWWpRfp2CVwZJz7fYC04JlbxfoVd
	A+MawS5GDg4JAROJM+squxi5OIQEdjNKzFjwlrGLkRMoLi2x9sIbdghbWOJ+yxFWiKLnjBJb
	vk5mA0mwCehK/H02E6xIREBL4uyJWWBFzAJvWSR27VrOBNFxhlXi75t97CDrOAV4JSb8swZp
	EBZwlpi4dyYTiM0ioCpx6OR1sEG8ApYS368+Z4KwBSVOznzCAmIzC2hLPL35FM5etvA1M8R1
	ChI/ny4DWywiMIlR4vPmeVBFIhKzO9uYJzAKz0IyaxaSWbOQzJqFpGUBI8sqRsnUguLc9Nxi
	wwKjvNRyveLE3OLSvHS95PzcTYzgONfS2sG4Z9UHvUOMTByMhxglOJiVRHjdNBPThXhTEiur
	Uovy44tKc1KLDzFKc7AoifN+e92bIiSQnliSmp2aWpBaBJNl4uCUamDKXnyxY8Whde+/mp72
	E/7H5/Z7Q1dm5qugLQtnx1RoaU14JO/O+Nwkc+LnW0KbxI5XH/35snTu8ppYKZGz1kc/ZDF9
	fe+6f/fThWVP531b5d7t55OY3a6QVCX5plYigc/a2kqKw7nAdtdrf845wsttrdw/vd5rfUSg
	ymCHlLzqpUNNt6Zs4T75i+VFwMN1s+aki903sZ6vcKP80K64XZ8PS6oJNXLbRsx1dWN9/7ml
	7VnconXzlVzXqqXOPOKuX35d60LfJ3MBn96onEWJiU849lbWFebemTfPSqX7Y+vSqbP/Ctx+
	7T0l9UjDmp2JrMKsMTLuU77uOp279ELWdeZMtYqvL0LUK5gn/FVdIuWoxFKckWioxVxUnAgA
	gq3ZCmIDAAA=
X-CMS-MailID: 20241218101837epcas2p2ccbf77d8339b03821896785002aadc07
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

Tue, December 10, 2024 at 4:10 PM Dujeong Lee wrote:
> On Tue, Dec 10, 2024 at 12:39 PM Dujeong Lee wrote:
> > On Mon, Dec 9, 2024 at 7:21 PM Eric Dumazet <edumazet=40google.com> wro=
te:
> > > On Mon, Dec 9, 2024 at 11:16=E2=80=AFAM=20Dujeong.lee=0D=0A>=20>=20>=
=20<dujeong.lee=40samsung.com>=0D=0A>=20>=20>=20wrote:=0D=0A>=20>=20>=20>=
=0D=0A>=20>=20>=0D=0A>=20>=20>=20>=20Thanks=20for=20all=20the=20details=20o=
n=20packetdrill=20and=20we=20are=20also=0D=0A>=20>=20>=20>=20exploring=0D=
=0A>=20>=20>=20USENIX=202013=20material.=0D=0A>=20>=20>=20>=20I=20have=20on=
e=20question.=20The=20issue=20happens=20when=20DUT=20receives=20TCP=20ack=
=0D=0A>=20>=20>=20>=20with=0D=0A>=20>=20>=20large=20delay=20from=20network,=
=20e.g.,=2028seconds=20since=20last=20Tx.=20Is=0D=0A>=20>=20>=20packetdrill=
=20able=20to=20emulate=20this=20network=20delay=20(or=20congestion)=20in=0D=
=0A>=20>=20>=20script=0D=0A>=20>=20level?=0D=0A>=20>=20>=0D=0A>=20>=20>=20Y=
es,=20the=20packetdrill=20scripts=20can=20wait=20an=20arbitrary=20amount=20=
of=20time=0D=0A>=20>=20>=20between=20each=20event=0D=0A>=20>=20>=0D=0A>=20>=
=20>=20+28=20<next=20event>=0D=0A>=20>=20>=0D=0A>=20>=20>=2028=20seconds=20=
seems=20okay.=20If=20the=20issue=20was=20triggered=20after=204=20days,=0D=
=0A>=20>=20>=20packetdrill=20would=20be=20impractical=20;)=0D=0A>=20>=0D=0A=
>=20>=20Hi=20all,=0D=0A>=20>=0D=0A>=20>=20We=20secured=20new=20ramdump.=0D=
=0A>=20>=20Please=20find=20the=20below=20values=20with=20TCP=20header=20det=
ails.=0D=0A>=20>=0D=0A>=20>=20tp->packets_out=20=3D=200=0D=0A>=20>=20tp->sa=
cked_out=20=3D=200=0D=0A>=20>=20tp->lost_out=20=3D=201=0D=0A>=20>=20tp->ret=
rans_out=20=3D=201=0D=0A>=20>=20tp->rx_opt.sack_ok=20=3D=205=20(tcp_is_sack=
(tp))=20mss_cache=20=3D=201400=0D=0A>=20>=20((struct=20inet_connection_sock=
=20*)sk)->icsk_ca_state=20=3D=204=20((struct=0D=0A>=20>=20inet_connection_s=
ock=20*)sk)->icsk_pmtu_cookie=20=3D=201500=0D=0A>=20>=0D=0A>=20>=20Hex=20fr=
om=20ip=20header:=0D=0A>=20>=2045=2000=2000=2040=2075=2040=2000=2000=2039=
=2006=2091=2013=208E=20FB=202A=20CA=20C0=20A8=2000=20F7=2001=20BB=20A7=0D=
=0A>=20>=20CC=2051=0D=0A>=20>=20F8=2063=20CC=2052=2059=206D=20A6=20B0=2010=
=2004=2004=2077=2076=2000=2000=2001=2001=2008=200A=2089=2072=20C8=2042=0D=
=0A>=20>=2062=20F5=0D=0A>=20>=20F5=20D1=2001=2001=2005=200A=2052=2059=206D=
=20A5=2052=2059=206D=20A6=0D=0A>=20>=0D=0A>=20>=20Transmission=20Control=20=
Protocol=0D=0A>=20>=20Source=20Port:=20443=0D=0A>=20>=20Destination=20Port:=
=2042956=0D=0A>=20>=20TCP=20Segment=20Len:=200=0D=0A>=20>=20Sequence=20Numb=
er=20(raw):=201375232972=0D=0A>=20>=20Acknowledgment=20number=20(raw):=2013=
81592486=0D=0A>=20>=201011=20....=20=3D=20Header=20Length:=2044=20bytes=20(=
11)=0D=0A>=20>=20Flags:=200x010=20(ACK)=0D=0A>=20>=20Window:=201028=0D=0A>=
=20>=20Calculated=20window=20size:=201028=0D=0A>=20>=20Urgent=20Pointer:=20=
0=0D=0A>=20>=20Options:=20(24=20bytes),=20No-Operation=20(NOP),=20No-Operat=
ion=20(NOP),=0D=0A>=20>=20Timestamps,=20No-Operation=20(NOP),=20No-Operatio=
n=20(NOP),=20SACK=0D=0A>=20>=0D=0A>=20>=20If=20anyone=20wants=20to=20check=
=20other=20values,=20please=20feel=20free=20to=20ask=20me=0D=0A>=20>=0D=0A>=
=20>=20Thanks,=0D=0A>=20>=20Dujeong.=0D=0A>=20=0D=0A>=20I=20have=20a=20ques=
tion.=0D=0A>=20=0D=0A>=20From=20the=20latest=20ramdump=20I=20could=20see=20=
that=0D=0A>=201)=20tcp_sk(sk)->packets_out=20=3D=200=0D=0A>=202)=20inet_csk=
(sk)->icsk_backoff=20=3D=200=0D=0A>=203)=20sk_write_queue.len=20=3D=200=0D=
=0A>=20which=20suggests=20that=20tcp_write_queue_purge=20was=20indeed=20cal=
led.=0D=0A>=20=0D=0A>=20Noting=20that:=0D=0A>=201)=20tcp_write_queue_purge=
=20reset=20packets_out=20to=200=20and=0D=0A>=202)=20in_flight=20should=20be=
=20non-negative=20where=20in_flight=20=3D=20packets_out=20-=0D=0A>=20left_o=
ut=20+=20retrans_out,=20what=20if=20we=20reset=20left_out=20and=20retrans_o=
ut=20as=20well=0D=0A>=20in=20tcp_write_queue_purge?=0D=0A>=20=0D=0A>=20Do=
=20we=20see=20any=20potential=20issue=20with=20this?=0D=0A=0D=0AHello=20Eri=
c=20and=20Neal.=0D=0A=0D=0AIt=20is=20a=20gentle=20reminder.=0D=0ACould=20yo=
u=20please=20review=20the=20latest=20ramdump=20values=20and=20and=20questio=
n?=0D=0A=0D=0AThanks,=0D=0ADujeong.=0D=0A=0D=0A

