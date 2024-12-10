Return-Path: <netdev+bounces-150491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E4989EA6BF
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 04:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C59167C76
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 03:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70D91C5CBA;
	Tue, 10 Dec 2024 03:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QPAMQiVi"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45914168BE
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733801929; cv=none; b=O/qPoFYk1l3T5kd92fRPY9fMPMp5y7Bblxcq4EAKjBPilP+1RwKMlGsRgYdKTqcng//iFE5fIJDphZHinontzcHKoqagwVsAo93Gv50c1nQhJqsgaMkzkcr4vPxB9Uc12v5rYO/vuFfhGbb2z0O8/g0SAPv4Yl5Qt5BxHMZ7Vt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733801929; c=relaxed/simple;
	bh=k8iiTfyZsl7yu5gMBaEH9nDR/daQQVMVybHOyreuNBs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:Message-ID:MIME-Version:
	 Content-Type:References; b=t5K99/ljdFqKjUwWnCrk0dVkdWV6Av97CSuAfIZUrEvMz4++neXMM0abFocHql3D64L3vCV47DZhdhBqBkrNx92PbIbu1z+3YpN6ngTMKqLfwCo5pXYKokIB/qrqpQmRHcwTgRQ6UiT93+awkOk+nbQqga3cOsLqN4leQ5QywV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=QPAMQiVi; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20241210033845epoutp02ff3ad48bf443b0e09d510ba1d64a2417~Ps6oyhfAF3171331713epoutp02v
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 03:38:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20241210033845epoutp02ff3ad48bf443b0e09d510ba1d64a2417~Ps6oyhfAF3171331713epoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733801925;
	bh=k8iiTfyZsl7yu5gMBaEH9nDR/daQQVMVybHOyreuNBs=;
	h=From:To:Cc:In-Reply-To:Subject:Date:References:From;
	b=QPAMQiViQkabzLdD5J3OwfKLbZGI3iQMSjOFnRBTtPgWobOopNybKOf0qiVOWAUUl
	 dQBrIQdMal+iPjEdv1JGAfbStOk8f5GBh0KDxB9shKTJ0F4W40xg2YCUOXMYa//KC6
	 7T+Ai1O+ISWXHkEhtBC2ZIt0SfC2Sj8y3ai2BmI4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20241210033844epcas2p209168d4f0f5ed4d0e7aca6e6cfab90a4~Ps6n7UgAt3062330623epcas2p2F;
	Tue, 10 Dec 2024 03:38:44 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.69]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y6kwg4bL4z4x9Pw; Tue, 10 Dec
	2024 03:38:43 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	96.90.23368.3C7B7576; Tue, 10 Dec 2024 12:38:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20241210033843epcas2p2a8f74693d7da6517fe903f0475714449~Ps6m4mwvs2190021900epcas2p2Y;
	Tue, 10 Dec 2024 03:38:43 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241210033843epsmtrp155ca51ae857b1b4db1b389250f7559cf~Ps6m3hA7x2096320963epsmtrp1J;
	Tue, 10 Dec 2024 03:38:43 +0000 (GMT)
X-AuditID: b6c32a45-db1ed70000005b48-b6-6757b7c378e5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5B.01.18949.2C7B7576; Tue, 10 Dec 2024 12:38:42 +0900 (KST)
Received: from KORCO117327 (unknown [10.229.60.106]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241210033842epsmtip1ab8f9370aeaac06c7ccd8ee19a615565~Ps6mjtKKC2133721337epsmtip1N;
	Tue, 10 Dec 2024 03:38:42 +0000 (GMT)
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
In-Reply-To: <CANn89iLz=U2RW8S+Yy1WpFYb+dyyPR8TwbMpUUEeUpV9X2hYoA@mail.gmail.com>
Subject: RE: [PATCH] tcp: check socket state before calling WARN_ON
Date: Tue, 10 Dec 2024 12:38:42 +0900
Message-ID: <000001db4ab5$026b8b20$0742a160$@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQL4yZmsudMRkH1MkhPtbuC345sC9QKRMuYdAUIxOFgBsMn9rAIf5xWWAZwDXWsBNR7tnQJ0dudGAPMj/mwCPP60LAEh3GCHAj4uPtAC9F+sfK/wY3uQ
Content-Language: ko
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbVRjO6b29LSydd6XikUUDl6AOU2gZ0IOjRD42O2cYhhCS6YINvWmR
	0pbesuFiAuOzZQkMYUorZswZLBhhaaCsmG4IOBCFuWFlEPYhbDi+EQyDGRZbLip/Tp73fZ/n
	vOd5zzl8TDhNBPFzdCbaqFNqKcIfd/YdiBX3dWWqJWVlIWjBgaHf3LU81HizDEdt3eUc9OjG
	FA/V1QNUcv02hnrqrVw0VTNIIOdiHwetTSxhyPOdd/nFWc1FtffrCTTa3Ugg86QbRzeaAtH6
	TwsAbZXc4aHy6TUe+nOghIcu96zy3gxUdLSMcxRNjgKFo9VCKJaveQhFdUcrUKw5Xk4jTuTG
	a2ilijYG07psvSpHp5ZTx9KzkrNiYiVSsTQOyahgnTKPllMp76SJj+RovZao4FNKbYE3laZk
	GCoyId6oLzDRwRo9Y5JTtEGlNcgMEYwyjynQqSN0tOkNqUQSFeMlfpCrcZ+9hxl+EBWOfi0v
	BssBVcCPD8loWP10FasC/nwheRXAgVvlOBusAljaUkmwwTqAw65lL42/LZlx5PvUQtIN4GCv
	lOXMejkrP3N9BYIUw60ZK8+HRWQ4HB60cX0kjPTg8MJWKeEr+JHvws2q6m0cQCbDWreV48M4
	GQbvN4xgPiwg4+BF+5eAxfvgj9aHuA9j5Ouw+dI8xnoIhpuPmrcbiMgSANvulhEsSQQ/t1Rs
	m4NkpR/87BMPYBUpsKHOuaMOgHMDHTwWB8HZmoodzMAnY/2AFRcDuDI1T7CFg7C0+QHumwVG
	HoDt3ZHsWEJh/8TO4fZCc98Wj00LoLlCyArDYGfT5s4m+6F7Y557HlC2XdZsu6zZdjmw/d+r
	CeCtIJA2MHlqmokySP+77Gx9ngNsv/bww1dB3eJKRC/g8EEvgHyMEgn4xzLUQoFK+dEZ2qjP
	MhZoaaYXxHiHXYsFPZ+t934XnSlLGh0niY6NlcqiYiQy6gXBvfIvVEJSrTTRuTRtoI3/6jh8
	v6BijvVZxvXT9j8CTaknLef2UAdHXG+LuvcoNrYuvjZd1J1wiWeXJbqS+C+aBMLc4XiT6LFn
	rP3adFHhwnH7t6nqVJWleWJq/fh4Q+eHnMmxsHaPsyv0yOErk+700AFhoj2/6C3x6NLlK39t
	tJ85H9mQCY6aMzfMYmAo7D9RdXL/+8mUPOGVua/c0b+mNQVeuJtxu2bInlyU5LhJOBc7UsuW
	zZ7SQdkMPrL04HRi4+q4/o6t7VaPXd3ycef6qX35c9zK+CGX5Tk5R3to/rG7MXXvIe1E0Oyn
	40nNXS89/V4a8t43pckPz50FGTWuzN8tSc+GQp6kaHKnG1+1zvzdIk53phz1p3BGo5SGY0ZG
	+Q93k5O1dgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7bCSnO6h7eHpBnt+WVi82cRscW3vRHaL
	OedbWCzW7Wplsnh67BG7xeQpjBZN+y8xWxyYMpPV4lH/CTaLbW8PM1l8vvWO2eLqbiBxYVsf
	q8XE+1PYLC7vmsNm0XFnL4vFsQViFt9Ov2G0+Nt0g92i9fFndouPx5vYLRYf+MTuIOaxZeVN
	Jo8Fm0o9Nq3qZPN4v+8qm0ffllWMHp83yQWwRXHZpKTmZJalFunbJXBlLP32n7FgF1/FhJ19
	TA2Mu7m7GDk4JARMJJ5tKuxi5OIQEtjNKDH50FL2LkZOoLi0xNoLb6BsYYn7LUdYIYqeM0p8
	XHaOESTBJqAr8ffZTLAiEQEtibMnZoEVMQu8ZZHYtWs5E0THKVaJ33Pvs4BUcQoESvzs6mMD
	sYUFnCUm7p3JBGKzCKhK3J9xjhnE5hWwlJi/YhEjhC0ocXLmE7BeZgFtiac3n8LZyxa+ZoY4
	T0Hi59NlYJtFBJoYJdbdbWGDKBKRmN3ZxjyBUXgWklmzkMyahWTWLCQtCxhZVjFKphYU56bn
	FhsWGOWllusVJ+YWl+al6yXn525iBMe6ltYOxj2rPugdYmTiYDzEKMHBrCTCy+Edmi7Em5JY
	WZValB9fVJqTWnyIUZqDRUmc99vr3hQhgfTEktTs1NSC1CKYLBMHp1QDU/PffM0DqU8n5NVm
	mmm9UvWsK7rybBnT/726nFfmxVbzNjlP9b5sUPiF+ZgKY+3DULWDNTKN014ZGgjpG09Y/5Dx
	JxvP4i9nLj8z1FzTx7RC4u6bcqcpnd4ujH7l57Ntz2hkvwngvfRYz/I6+8pHv83cntg8Nnjx
	LN3Tb+qBv2+3bSg7deYNByfrjq0/X3drrmqYMT/yR3WR2ZHUg2lRba+9ZfZ3/+VZKBb904PX
	v9U1yIRzXdP7aX5F4gek9KME3b9fVj7uqnakd+ff9HV/zesurXq/b/LX/VNvSx6qCt9/6OuS
	vnaOojvej4t+vTphy6pW9uHHn23BpQYR7TMEdVkTjf5MmRS0U+7IWpcNi5VYijMSDbWYi4oT
	Ab+BCMtkAwAA
X-CMS-MailID: 20241210033843epcas2p2a8f74693d7da6517fe903f0475714449
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

On Mon, Dec 9, 2024 at 7:21 PM Eric Dumazet <edumazet=40google.com> wrote:
> On Mon, Dec 9, 2024 at 11:16=E2=80=AFAM=20Dujeong.lee=20<dujeong.lee=40sa=
msung.com>=0D=0A>=20wrote:=0D=0A>=20>=0D=0A>=20=0D=0A>=20>=20Thanks=20for=
=20all=20the=20details=20on=20packetdrill=20and=20we=20are=20also=20explori=
ng=0D=0A>=20USENIX=202013=20material.=0D=0A>=20>=20I=20have=20one=20questio=
n.=20The=20issue=20happens=20when=20DUT=20receives=20TCP=20ack=20with=0D=0A=
>=20large=20delay=20from=20network,=20e.g.,=2028seconds=20since=20last=20Tx=
.=20Is=20packetdrill=0D=0A>=20able=20to=20emulate=20this=20network=20delay=
=20(or=20congestion)=20in=20script=20level?=0D=0A>=20=0D=0A>=20Yes,=20the=
=20packetdrill=20scripts=20can=20wait=20an=20arbitrary=20amount=20of=20time=
=20between=0D=0A>=20each=20event=0D=0A>=20=0D=0A>=20+28=20<next=20event>=0D=
=0A>=20=0D=0A>=2028=20seconds=20seems=20okay.=20If=20the=20issue=20was=20tr=
iggered=20after=204=20days,=0D=0A>=20packetdrill=20would=20be=20impractical=
=20;)=0D=0A=0D=0AHi=20all,=0D=0A=0D=0AWe=20secured=20new=20ramdump.=0D=0APl=
ease=20find=20the=20below=20values=20with=20TCP=20header=20details.=0D=0A=
=0D=0Atp->packets_out=20=3D=200=0D=0Atp->sacked_out=20=3D=200=0D=0Atp->lost=
_out=20=3D=201=0D=0Atp->retrans_out=20=3D=201=0D=0Atp->rx_opt.sack_ok=20=3D=
=205=20(tcp_is_sack(tp))=0D=0Atp->mss_cache=20=3D=201400=0D=0A((struct=20in=
et_connection_sock=20*)sk)->icsk_ca_state=20=3D=204=0D=0A((struct=20inet_co=
nnection_sock=20*)sk)->icsk_pmtu_cookie=20=3D=201500=0D=0A=0D=0AHex=20from=
=20ip=20header:=0D=0A45=2000=2000=2040=2075=2040=2000=2000=2039=2006=2091=
=2013=208E=20FB=202A=20CA=20C0=20A8=2000=20F7=2001=20BB=20A7=20CC=2051=20F8=
=2063=20CC=2052=2059=206D=20A6=20B0=2010=2004=2004=2077=2076=2000=2000=2001=
=2001=2008=200A=2089=2072=20C8=2042=2062=20F5=20F5=20D1=2001=2001=2005=200A=
=2052=2059=206D=20A5=2052=2059=206D=20A6=0D=0A=0D=0ATransmission=20Control=
=20Protocol=0D=0ASource=20Port:=20443=0D=0ADestination=20Port:=2042956=0D=
=0ATCP=20Segment=20Len:=200=0D=0ASequence=20Number=20(raw):=201375232972=0D=
=0AAcknowledgment=20number=20(raw):=201381592486=0D=0A1011=20....=20=3D=20H=
eader=20Length:=2044=20bytes=20(11)=0D=0AFlags:=200x010=20(ACK)=0D=0AWindow=
:=201028=0D=0ACalculated=20window=20size:=201028=0D=0AUrgent=20Pointer:=200=
=0D=0AOptions:=20(24=20bytes),=20No-Operation=20(NOP),=20No-Operation=20(NO=
P),=20Timestamps,=20No-Operation=20(NOP),=20No-Operation=20(NOP),=20SACK=0D=
=0A=0D=0AIf=20anyone=20wants=20to=20check=20other=20values,=20please=20feel=
=20free=20to=20ask=20me=0D=0A=0D=0AThanks,=0D=0ADujeong.=0D=0A=0D=0A

