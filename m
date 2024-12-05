Return-Path: <netdev+bounces-149211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB789E4C65
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 03:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75A59282E56
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 02:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED45B187FE0;
	Thu,  5 Dec 2024 02:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="vcFczelp"
X-Original-To: netdev@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ADA154C00
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 02:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733366558; cv=none; b=DRGNN+LXoh27WKEkqpEQgchALi/NYr/ZYUawXPUdA+6EtpTqo6dKyZs1q8CwnRhOldVkyHERvNGqrcQlECNS0bPt0W1nURbs/e3W6lXfHJJb4vyW8qui+N9H2wcsfzjMSXl0VBrlxzwk7wbmdf65HrxvHj8xC0LN9x8Jr3Kpsjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733366558; c=relaxed/simple;
	bh=dreOJNR8itflAyHwVlyZeNR4yJcuLnZFOvi4hOnwKLE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=tpXrCAHxyIG8L7ljfJ4M3f9YzkLCjmjkkz81Z2u0WkKBdk1GlwObnFOYh3tHYFmKVE+ejBuguby58TOrG6U3YovF3mxaw9i1J9WioJMbt1y2cuhG1Xwt2P1YONgibD5hoB7fhI1XKoyPh4q6JmIpggTY6k8Dg4ffd9cOdVKfwwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=vcFczelp; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20241205024233epoutp045f0958bfd4b62f7cbc5ed272ded30b32~OJ7JiyxxR2558125581epoutp046
	for <netdev@vger.kernel.org>; Thu,  5 Dec 2024 02:42:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20241205024233epoutp045f0958bfd4b62f7cbc5ed272ded30b32~OJ7JiyxxR2558125581epoutp046
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733366553;
	bh=NJ2ty+sbZclvvkWHbOnkWIjWnBi/QQOuxsUnfC6ddmw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vcFczelpYPhAjvK0Ejf1j7wB4IaaiXzjSJClxUO1r9aOYxDKO2Y7iyZs4Yz+BVrMd
	 wet0p1Iwfc1z2OfU1ZybYdfzgqgqLLvgOc2lckCCUXSkAPAc4z1XlHd8zqwx+qcD/m
	 kG4+gt68bYZz55MNYTpmxRgQbEt1N3QSu+c/DPUg=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p4.samsung.com (KnoxPortal) with ESMTP id
	20241205024232epcas2p483a396a92ff02a26839902fe4958e1fb~OJ7Ix5Ve11023110231epcas2p4B;
	Thu,  5 Dec 2024 02:42:32 +0000 (GMT)
Received: from epsmgec2p1-new.samsung.com (unknown [182.195.36.70]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4Y3dw8219Wz4x9Q8; Thu,  5 Dec
	2024 02:42:32 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmgec2p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	04.D8.32010.81311576; Thu,  5 Dec 2024 11:42:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTPA id
	20241205024231epcas2p295384a6a1a775e1f20bb58287e38607c~OJ7H0xWET1591615916epcas2p2N;
	Thu,  5 Dec 2024 02:42:31 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20241205024231epsmtrp13932c4f7ea61cdab324366a5f38cf509~OJ7HziySd2588125881epsmtrp16;
	Thu,  5 Dec 2024 02:42:31 +0000 (GMT)
X-AuditID: b6c32a4d-abdff70000007d0a-64-67511318cfea
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	5D.71.18729.71311576; Thu,  5 Dec 2024 11:42:31 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241205024231epsmtip1c9e2eee6746d66e3f148c6db149d8722~OJ7Hhxhsi3192931929epsmtip1j;
	Thu,  5 Dec 2024 02:42:31 +0000 (GMT)
Date: Thu, 5 Dec 2024 11:45:54 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Youngmin Nam <youngmin.nam@samsung.com>, Neal Cardwell
	<ncardwell@google.com>, davem@davemloft.net, dsahern@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	dujeong.lee@samsung.com, guo88.liu@samsung.com, yiwang.cai@samsung.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	joonki.min@samsung.com, hajun.sung@samsung.com, d7271.choe@samsung.com,
	sw.ju@samsung.com
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
Message-ID: <Z1ET4kItaz80rwEQ@perf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CANn89iLSMKNsmtvD=d+_3CNBbDhBQ+41R_tesVUYO50S72-YWg@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDJsWRmVeSWpSXmKPExsWy7bCmua6EcGC6wa5PPBbX9k5kt5hzvoXF
	Yt2uViaLZwtmsFg8PfaI3WLyFEaLpv2XmC0e9Z9gs7i6+x2zxYVtfawWl3fNYbPouLOXxeLY
	AjGLb6ffMFq0Pv7MbvHxeBO7xeIDn9gdBD22rLzJ5LFgU6nHplWdbB7v911l8+jbsorR4/Mm
	uQC2qGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfMHKDT
	lRTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkF5gV6xYm5xaV56Xp5qSVWhgYGRqZA
	hQnZGQ/vPWIrOFNVcX7hL6YGxoaMLkZODgkBE4mjbx4xg9hCAnsYJeaf5Oli5AKyPzFKHP/S
	xgjhfGOUuN71hr2LkQOs42C7P0R8L6PE3mc7mCCch4wSi5ZPYwQZxSKgIvH8xkuwsWwCuhLb
	TvxjBGkWEVCT+NrgB1LPLDCVWWL9hPssIHFhAWeJv3dsQUxeAWWJdpAoJ5ApKHFy5hMwm1Mg
	UOLfybtg90gInOGQaNnXyQzxgYvEgZ9/oWxhiVfHt7BD2FISL/vboOxiiYb7t5ghmlsYJU5d
	fwHVYCwx61k72M3MAhkSTYcXskE8qSxx5BYLRJhPouPwX6jfeSU62oQgOtUkfk3ZwAhhy0js
	XrwCaqKHxK3jJ9ghQbKbSWLz1xmMExjlZiH5ZxaSbbOAxjILaEqs36UPEZaXaN46mxkiLC2x
	/B8HkooFjGyrGKVSC4pz01OTjQoMdfNSy+GxnZyfu4kRnKy1fHcwvl7/V+8QIxMH4yFGCQ5m
	JRHeIO2AdCHelMTKqtSi/Pii0pzU4kOMpsCYmsgsJZqcD8wXeSXxhiaWBiZmZobmRqYG5kri
	vPda56YICaQnlqRmp6YWpBbB9DFxcEo1MM04eSX7UNyXbEN5Lf0ohhMac22cJf3m2634OT/5
	vo54Frfpqw9l76z7TzdYN08PyyxOW/bJdun+2e4bD5n6bdF71xTW6GN/6LIIm+jTT8tFl5u4
	LE9967iOQ31p2Irpae9Ubqhum39c80f5paCjf9zmbVo6rf/voelt7PWBkkfiNN/07E/Sj75x
	T12oY3/X5sVCOnfkr0TsO3Xld3Nw6CfBq8kKFzcmnoprMzW71X5w/7v9wUoL52xtunPqUv+f
	qX03+Tbt384q2yBzJLOT96FI9T11fYb0R79cnjzMeH5f6ZnOA7ZzF61Ev2cK2TtYGtQWHmV3
	XjSTU6+p7nC9eI/u6e8zppY8KdrXlb/s/i4lluKMREMt5qLiRAAUUXhbXwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsWy7bCSnK64cGC6QeNSTYtreyeyW8w538Ji
	sW5XK5PFswUzWCyeHnvEbjF5CqNF0/5LzBaP+k+wWVzd/Y7Z4sK2PlaLy7vmsFl03NnLYnFs
	gZjFt9NvGC1aH39mt/h4vIndYvGBT+wOgh5bVt5k8liwqdRj06pONo/3+66yefRtWcXo8XmT
	XABbFJdNSmpOZllqkb5dAlfGpAfv2AvelVe8adzA3MC4L7WLkYNDQsBE4mC7fxcjF4eQwG5G
	ifY9K1m6GDmB4jISt1deZoWwhSXutxxhhSi6zygx58hTsASLgIrE8xsvmUFsNgFdiW0n/jGC
	DBURUJP42uAHUs8sMJVZYuX6z+wgcWEBZ4m/d2xBTF4BZYn2+yxQe5kk1l7qYQcZwysgKHFy
	5hOwG5gF1CX+zLvEDFLPLCAtsfwfB0RYXqJ562ywrZwCgRL/Tt5lnMAoOAtJ9ywk3bMQumch
	6V7AyLKKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4/rQ0dzBuX/VB7xAjEwfjIUYJ
	DmYlEd4g7YB0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rziL3pThATSE0tSs1NTC1KLYLJMHJxS
	DUyTfvp5x2spTLna4lpSNOMfm4Lk11lWqgGv1hx8sdvbU+vs8rOX+V70VuUWX/hyPP5O7nG+
	zoLw0HTPhG1plfLKPHyRjbnSd/WWSEwQUctifaLtWLPIbZqIYZ2o7N9TW1l/HLr7pqvMsUFM
	i6XL8vTZ5urrHiq1qy7OunQxPM7m+v0ryzUTPqv/FBGVYk0XfNIWWHEykd8xuUL9ngcv+z2F
	X2b3q3KmF19Orr0aldC13d/Y/r1E+F0HKZ9PUotXL8/dUNmntGrZFlW9JUEX37hpGvCKmT9k
	spT/sXbr74q5WW0bqi9l54RxsmoYvxEzulJ9++/Fo4cYtLdOedi86K2d+1qHU/O+RZr8eCZ4
	RYmlOCPRUIu5qDgRAOhy3+kuAwAA
X-CMS-MailID: 20241205024231epcas2p295384a6a1a775e1f20bb58287e38607c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----_tVqzgGyW6tMiW3Z4snM0QQCkibZmALk2DMBUp8NwEyQzDMD=_d9514_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
	<20241203081247.1533534-1-youngmin.nam@samsung.com>
	<CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
	<Z0/HyztKs8UFBOa0@perf>
	<CANn89iLSMKNsmtvD=d+_3CNBbDhBQ+41R_tesVUYO50S72-YWg@mail.gmail.com>

------_tVqzgGyW6tMiW3Z4snM0QQCkibZmALk2DMBUp8NwEyQzDMD=_d9514_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Wed, Dec 04, 2024 at 10:03:14AM +0100, Eric Dumazet wrote:
> On Wed, Dec 4, 2024 at 4:05 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> >
> > Hi Eric.
> > Thanks for looking at this issue.
> >
> > On Tue, Dec 03, 2024 at 12:07:05PM +0100, Eric Dumazet wrote:
> > > On Tue, Dec 3, 2024 at 9:10 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> > > >
> > > > We encountered the following WARNINGs
> > > > in tcp_sacktag_write_queue()/tcp_fastretrans_alert()
> > > > which triggered a kernel panic due to panic_on_warn.
> > > >
> > > > case 1.
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 4 PID: 453 at net/ipv4/tcp_input.c:2026
> > > > Call trace:
> > > >  tcp_sacktag_write_queue+0xae8/0xb60
> > > >  tcp_ack+0x4ec/0x12b8
> > > >  tcp_rcv_state_process+0x22c/0xd38
> > > >  tcp_v4_do_rcv+0x220/0x300
> > > >  tcp_v4_rcv+0xa5c/0xbb4
> > > >  ip_protocol_deliver_rcu+0x198/0x34c
> > > >  ip_local_deliver_finish+0x94/0xc4
> > > >  ip_local_deliver+0x74/0x10c
> > > >  ip_rcv+0xa0/0x13c
> > > > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > > >
> > > > case 2.
> > > > ------------[ cut here ]------------
> > > > WARNING: CPU: 0 PID: 648 at net/ipv4/tcp_input.c:3004
> > > > Call trace:
> > > >  tcp_fastretrans_alert+0x8ac/0xa74
> > > >  tcp_ack+0x904/0x12b8
> > > >  tcp_rcv_state_process+0x22c/0xd38
> > > >  tcp_v4_do_rcv+0x220/0x300
> > > >  tcp_v4_rcv+0xa5c/0xbb4
> > > >  ip_protocol_deliver_rcu+0x198/0x34c
> > > >  ip_local_deliver_finish+0x94/0xc4
> > > >  ip_local_deliver+0x74/0x10c
> > > >  ip_rcv+0xa0/0x13c
> > > > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > > >
> > >
> > > I have not seen these warnings firing. Neal, have you seen this in the past ?
> > >
> > > Please provide the kernel version (this must be a pristine LTS one).
> > We are running Android kernel for Android mobile device which is based on LTS kernel 6.6-30.
> > But we've seen this issue since kernel 5.15 LTS.
> >
> > > and symbolized stack traces using scripts/decode_stacktrace.sh
> > Unfortunately, we don't have the matched vmlinux right now. So we need to rebuild and reproduce.
> > >
> > > If this warning was easy to trigger, please provide a packetdrill test ?
> > I'm not sure if we can run packetdrill test on Android device. Anyway let me check.
> >
> > FYI, Here are more detailed logs.
> >
> > Case 1.
> > [26496.422651]I[4:  napi/wlan0-33:  467] ------------[ cut here ]------------
> > [26496.422665]I[4:  napi/wlan0-33:  467] WARNING: CPU: 4 PID: 467 at net/ipv4/tcp_input.c:2026 tcp_sacktag_write_queue+0xae8/0xb60
> > [26496.423420]I[4:  napi/wlan0-33:  467] CPU: 4 PID: 467 Comm: napi/wlan0-33 Tainted: G S         OE      6.6.30-android15-8-geeceb2c9cdf1-ab20240930.125201-4k #1 a1c80b36942fa6e9575b2544032a7536ed502804
> > [26496.423427]I[4:  napi/wlan0-33:  467] Hardware name: Samsung ERD9955 board based on S5E9955 (DT)
> > [26496.423432]I[4:  napi/wlan0-33:  467] pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> > [26496.423438]I[4:  napi/wlan0-33:  467] pc : tcp_sacktag_write_queue+0xae8/0xb60
> > [26496.423446]I[4:  napi/wlan0-33:  467] lr : tcp_ack+0x4ec/0x12b8
> > [26496.423455]I[4:  napi/wlan0-33:  467] sp : ffffffc096b8b690
> > [26496.423458]I[4:  napi/wlan0-33:  467] x29: ffffffc096b8b710 x28: 0000000000008001 x27: 000000005526d635
> > [26496.423469]I[4:  napi/wlan0-33:  467] x26: ffffff8a19079684 x25: 000000005526dbfd x24: 0000000000000001
> > [26496.423480]I[4:  napi/wlan0-33:  467] x23: 000000000000000a x22: ffffff88e5f5b680 x21: 000000005526dbc9
> > [26496.423489]I[4:  napi/wlan0-33:  467] x20: ffffff8a19078d80 x19: ffffff88e9f4193e x18: ffffffd083114c80
> > [26496.423499]I[4:  napi/wlan0-33:  467] x17: 00000000529c6ef0 x16: 000000000000ff8b x15: 0000000000000000
> > [26496.423508]I[4:  napi/wlan0-33:  467] x14: 0000000000000001 x13: 0000000000000001 x12: 0000000000000000
> > [26496.423517]I[4:  napi/wlan0-33:  467] x11: 0000000000000000 x10: 0000000000000001 x9 : 00000000fffffffd
> > [26496.423526]I[4:  napi/wlan0-33:  467] x8 : 0000000000000001 x7 : 0000000000000000 x6 : ffffffd081ec0bc4
> > [26496.423536]I[4:  napi/wlan0-33:  467] x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffffffc096b8b818
> > [26496.423545]I[4:  napi/wlan0-33:  467] x2 : 000000005526d635 x1 : ffffff88e5f5b680 x0 : ffffff8a19078d80
> > [26496.423555]I[4:  napi/wlan0-33:  467] Call trace:
> > [26496.423558]I[4:  napi/wlan0-33:  467]  tcp_sacktag_write_queue+0xae8/0xb60
> > [26496.423566]I[4:  napi/wlan0-33:  467]  tcp_ack+0x4ec/0x12b8
> > [26496.423573]I[4:  napi/wlan0-33:  467]  tcp_rcv_state_process+0x22c/0xd38
> > [26496.423580]I[4:  napi/wlan0-33:  467]  tcp_v4_do_rcv+0x220/0x300
> > [26496.423590]I[4:  napi/wlan0-33:  467]  tcp_v4_rcv+0xa5c/0xbb4
> > [26496.423596]I[4:  napi/wlan0-33:  467]  ip_protocol_deliver_rcu+0x198/0x34c
> > [26496.423607]I[4:  napi/wlan0-33:  467]  ip_local_deliver_finish+0x94/0xc4
> > [26496.423614]I[4:  napi/wlan0-33:  467]  ip_local_deliver+0x74/0x10c
> > [26496.423620]I[4:  napi/wlan0-33:  467]  ip_rcv+0xa0/0x13c
> > [26496.423625]I[4:  napi/wlan0-33:  467]  __netif_receive_skb_core+0xe14/0x1104
> > [26496.423642]I[4:  napi/wlan0-33:  467]  __netif_receive_skb_list_core+0xb8/0x2dc
> > [26496.423649]I[4:  napi/wlan0-33:  467]  netif_receive_skb_list_internal+0x234/0x320
> > [26496.423655]I[4:  napi/wlan0-33:  467]  napi_complete_done+0xb4/0x1a0
> > [26496.423660]I[4:  napi/wlan0-33:  467]  slsi_rx_netif_napi_poll+0x22c/0x258 [scsc_wlan 16ac2100e65b7c78ce863cecc238b39b162dbe82]
> > [26496.423822]I[4:  napi/wlan0-33:  467]  __napi_poll+0x5c/0x238
> > [26496.423829]I[4:  napi/wlan0-33:  467]  napi_threaded_poll+0x110/0x204
> > [26496.423836]I[4:  napi/wlan0-33:  467]  kthread+0x114/0x138
> > [26496.423845]I[4:  napi/wlan0-33:  467]  ret_from_fork+0x10/0x20
> > [26496.423856]I[4:  napi/wlan0-33:  467] Kernel panic - not syncing: kernel: panic_on_warn set ..
> >
> > Case 2.
> > [ 1843.463330]I[0: surfaceflinger:  648] ------------[ cut here ]------------
> > [ 1843.463355]I[0: surfaceflinger:  648] WARNING: CPU: 0 PID: 648 at net/ipv4/tcp_input.c:3004 tcp_fastretrans_alert+0x8ac/0xa74
> > [ 1843.464508]I[0: surfaceflinger:  648] CPU: 0 PID: 648 Comm: surfaceflinger Tainted: G S         OE      6.6.30-android15-8-geeceb2c9cdf1-ab20241017.075836-4k #1 de751202c2c5ab3ec352a00ae470fc5e907bdcfe
> > [ 1843.464520]I[0: surfaceflinger:  648] Hardware name: Samsung ERD8855 board based on S5E8855 (DT)
> > [ 1843.464527]I[0: surfaceflinger:  648] pstate: 23400005 (nzCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
> > [ 1843.464535]I[0: surfaceflinger:  648] pc : tcp_fastretrans_alert+0x8ac/0xa74
> > [ 1843.464548]I[0: surfaceflinger:  648] lr : tcp_ack+0x904/0x12b8
> > [ 1843.464556]I[0: surfaceflinger:  648] sp : ffffffc0800036e0
> > [ 1843.464561]I[0: surfaceflinger:  648] x29: ffffffc0800036e0 x28: 0000000000008005 x27: 000000001bc05562
> > [ 1843.464579]I[0: surfaceflinger:  648] x26: ffffff890418a3c4 x25: 0000000000000000 x24: 000000000000cd02
> > [ 1843.464595]I[0: surfaceflinger:  648] x23: 000000001bc05562 x22: 0000000000000000 x21: ffffffc080003800
> > [ 1843.464611]I[0: surfaceflinger:  648] x20: ffffffc08000378c x19: ffffff8904189ac0 x18: 0000000000000000
> > [ 1843.464627]I[0: surfaceflinger:  648] x17: 00000000529c6ef0 x16: 000000000000ff8b x15: 0000000000000001
> > [ 1843.464642]I[0: surfaceflinger:  648] x14: 0000000000000001 x13: 0000000000000001 x12: 0000000000000000
> > [ 1843.464658]I[0: surfaceflinger:  648] x11: ffffff883e9c9540 x10: 0000000000000001 x9 : 0000000000000001
> > [ 1843.464673]I[0: surfaceflinger:  648] x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffffffd081ec0bc4
> > [ 1843.464689]I[0: surfaceflinger:  648] x5 : 0000000000000000 x4 : ffffffc08000378c x3 : ffffffc080003800
> > [ 1843.464704]I[0: surfaceflinger:  648] x2 : 0000000000000000 x1 : 000000001bc05562 x0 : ffffff8904189ac0
> > [ 1843.464720]I[0: surfaceflinger:  648] Call trace:
> > [ 1843.464725]I[0: surfaceflinger:  648]  tcp_fastretrans_alert+0x8ac/0xa74
> > [ 1843.464735]I[0: surfaceflinger:  648]  tcp_ack+0x904/0x12b8
> > [ 1843.464743]I[0: surfaceflinger:  648]  tcp_rcv_state_process+0x22c/0xd38
> > [ 1843.464751]I[0: surfaceflinger:  648]  tcp_v4_do_rcv+0x220/0x300
> > [ 1843.464760]I[0: surfaceflinger:  648]  tcp_v4_rcv+0xa5c/0xbb4
> > [ 1843.464767]I[0: surfaceflinger:  648]  ip_protocol_deliver_rcu+0x198/0x34c
> > [ 1843.464776]I[0: surfaceflinger:  648]  ip_local_deliver_finish+0x94/0xc4
> > [ 1843.464784]I[0: surfaceflinger:  648]  ip_local_deliver+0x74/0x10c
> > [ 1843.464791]I[0: surfaceflinger:  648]  ip_rcv+0xa0/0x13c
> > [ 1843.464799]I[0: surfaceflinger:  648]  __netif_receive_skb_core+0xe14/0x1104
> > [ 1843.464810]I[0: surfaceflinger:  648]  __netif_receive_skb+0x40/0x124
> > [ 1843.464818]I[0: surfaceflinger:  648]  netif_receive_skb+0x7c/0x234
> > [ 1843.464825]I[0: surfaceflinger:  648]  slsi_rx_data_deliver_skb+0x1e0/0xdbc [scsc_wlan 12b378a8d5cf5e6cd833136fc49079d43751bd28]
> > [ 1843.465025]I[0: surfaceflinger:  648]  slsi_ba_process_complete+0x70/0xa4 [scsc_wlan 12b378a8d5cf5e6cd833136fc49079d43751bd28]
> > [ 1843.465219]I[0: surfaceflinger:  648]  slsi_ba_aging_timeout_handler+0x324/0x354 [scsc_wlan 12b378a8d5cf5e6cd833136fc49079d43751bd28]
> > [ 1843.465410]I[0: surfaceflinger:  648]  call_timer_fn+0xd0/0x360
> > [ 1843.465423]I[0: surfaceflinger:  648]  __run_timers+0x1b4/0x268
> > [ 1843.465432]I[0: surfaceflinger:  648]  run_timer_softirq+0x24/0x4c
> > [ 1843.465440]I[0: surfaceflinger:  648]  __do_softirq+0x158/0x45c
> > [ 1843.465448]I[0: surfaceflinger:  648]  ____do_softirq+0x10/0x20
> > [ 1843.465455]I[0: surfaceflinger:  648]  call_on_irq_stack+0x3c/0x74
> > [ 1843.465463]I[0: surfaceflinger:  648]  do_softirq_own_stack+0x1c/0x2c
> > [ 1843.465470]I[0: surfaceflinger:  648]  __irq_exit_rcu+0x54/0xb4
> > [ 1843.465480]I[0: surfaceflinger:  648]  irq_exit_rcu+0x10/0x1c
> > [ 1843.465489]I[0: surfaceflinger:  648]  el0_interrupt+0x54/0xe0
> > [ 1843.465499]I[0: surfaceflinger:  648]  __el0_irq_handler_common+0x18/0x28
> > [ 1843.465508]I[0: surfaceflinger:  648]  el0t_64_irq_handler+0x10/0x1c
> > [ 1843.465516]I[0: surfaceflinger:  648]  el0t_64_irq+0x1a8/0x1ac
> > [ 1843.465525]I[0: surfaceflinger:  648] Kernel panic - not syncing: kernel: panic_on_warn set ...
> >
> > > > When we check the socket state value at the time of the issue,
> > > > it was 0x4.
> > > >
> > > > skc_state = 0x4,
> > > >
> > > > This is "TCP_FIN_WAIT1" and which means the device closed its socket.
> > > >
> > > > enum {
> > > >         TCP_ESTABLISHED = 1,
> > > >         TCP_SYN_SENT,
> > > >         TCP_SYN_RECV,
> > > >         TCP_FIN_WAIT1,
> > > >
> > > > And also this means tp->packets_out was initialized as 0
> > > > by tcp_write_queue_purge().
> > >
> > > What stack trace leads to this tcp_write_queue_purge() exactly ?
> > I couldn't find the exact call stack to this.
> > But I just thought that the function would be called based on ramdump snapshot.
> >
> > (*(struct tcp_sock *)(0xFFFFFF800467AB00)).packets_out = 0
> > (*(struct inet_connection_sock *)0xFFFFFF800467AB00).icsk_backoff = 0
> 
> TCP_FIN_WAIT1 is set whenever the application does a shutdown(fd, SHUT_WR);
> 
> This means that all bytes in the send queue and retransmit queue
> should be kept, and will eventually be sent.
> 
>  tcp_write_queue_purge() must not be called until we receive some
> valid RST packet or fatal timeout.
> 
> 6.6.30 is old, LTS 6.6.63 has some TCP changes that might br related.
> 
> $ git log --oneline v6.6.30..v6.6.63 -- net/ipv4/tcp*c
> 229dfdc36f31a8d47433438bc0e6e1662c4ab404 tcp: fix mptcp DSS corruption
> due to large pmtu xmit
> 2daffbd861de532172079dceef5c0f36a26eee14 tcp: fix TFO SYN_RECV to not
> zero retrans_stamp with retransmits out
> 718c49f840ef4e451bf44a8a62aae89ebdd5a687 tcp: new TCP_INFO stats for RTO events
> 04dce9a120502aea4ca66eebf501f404a22cd493 tcp: fix tcp_enter_recovery()
> to zero retrans_stamp when it's safe
> e676ca60ad2a6fdeb718b5e7a337a8fb1591d45f tcp: fix to allow timestamp
> undo if no retransmits were sent
> 5cce1c07bf8972d3ab94c25aa9fb6170f99082e0 tcp: avoid reusing FIN_WAIT2
> when trying to find port in connect() process
> 4fe707a2978929b498d3730d77a6ab103881420d tcp: process the 3rd ACK with
> sk_socket for TFO/MPTCP
> 9fd29738377c10749cb292510ebc202988ea0a31 tcp: Don't drop SYN+ACK for
> simultaneous connect().
> c8219a27fa43a2cbf99f5176f6dddfe73e7a24ae tcp_bpf: fix return value of
> tcp_bpf_sendmsg()
> 69f397e60c3be615c32142682d62fc0b6d5d5d67 net: remove NULL-pointer net
> parameter in ip_metrics_convert
> f0974e6bc385f0e53034af17abbb86ac0246ef1c tcp: do not export tcp_twsk_purge()
> 99580ae890ec8bd98b21a2a9c6668f8f1555b62e tcp: prevent concurrent
> execution of tcp_sk_exit_batch
> 7348061662c7149b81e38e545d5dd6bd427bec81 tcp/dccp: do not care about
> families in inet_twsk_purge()
> 227355ad4e4a6da5435451b3cc7f3ed9091288fa tcp: Update window clamping condition
> 77100f2e8412dbb84b3e7f1b947c9531cb509492 tcp_metrics: optimize
> tcp_metrics_flush_all()
> 6772c4868a8e7ad5305957cdb834ce881793acb7 net: drop bad gso csum_start
> and offset in virtio_net_hdr
> 1cfdc250b3d210acd5a4a47337b654e04693cf7f tcp: Adjust clamping window
> for applications specifying SO_RCVBUF
> f9fef23a81db9adc1773979fabf921eba679d5e7 tcp: annotate data-races
> around tp->window_clamp
> 44aa1e461ccd1c2e49cffad5e75e1b944ec590ef tcp: fix races in tcp_v[46]_err()
> bc4f9c2ccd68afec3a8395d08fd329af2022c7e8 tcp: fix race in tcp_write_err()
> ecc6836d63513fb4857a7525608d7fdd0c837cb3 tcp: add tcp_done_with_error() helper
> dfcdd7f89e401d2c6616be90c76c2fac3fa98fde tcp: avoid too many retransmit packets
> b75f281bddebdcf363884f0d53c562366e9ead99 tcp: use signed arithmetic in
> tcp_rtx_probe0_timed_out()
> 124886cf20599024eb33608a2c3608b7abf3839b tcp: fix incorrect undo
> caused by DSACK of TLP retransmit
> 8c2debdd170e395934ac0e039748576dfde14e99 tcp_metrics: validate source
> addr length
> 8a7fc2362d6d234befde681ea4fb6c45c1789ed5 UPSTREAM: tcp: fix DSACK undo
> in fast recovery to call tcp_try_to_open()
> b4b26d23a1e2bc188cec8592e111d68d83b9031f tcp: fix
> tcp_rcv_fastopen_synack() to enter TCP_CA_Loss for failed TFO
> fdae4d139f4778b20a40c60705c53f5f146459b5 Fix race for duplicate reqsk
> on identical SYN
> 250fad18b0c959b137ad745428fb411f1ac1bbc6 tcp: clear tp->retrans_stamp
> in tcp_rcv_fastopen_synack()
> acdf17546ef8ee73c94e442e3f4b933e42c3dfac tcp: count CLOSE-WAIT sockets
> for TCP_MIB_CURRESTAB
> 50569d12945f86fa4b321c4b1c3005874dbaa0f1 net: tls: fix marking packets
> as decrypted
> 02261d3f9dc7d1d7be7d778f839e3404ab99034c tcp: Fix shift-out-of-bounds
> in dctcp_update_alpha().
> 00bb933578acd88395bf6e770cacdbe2d6a0be86 tcp: avoid premature drops in
> tcp_add_backlog()
> 6e48faad92be13166184d21506e4e54c79c13adc tcp: Use
> refcount_inc_not_zero() in tcp_twsk_unique().
> f47d0d32fa94e815fdd78b8b88684873e67939f4 tcp: defer
> shutdown(SEND_SHUTDOWN) for TCP_SYN_RECV sockets
> 
Thanks for your information.
Let me try with our newest Android kernel which is 6.6.50

------_tVqzgGyW6tMiW3Z4snM0QQCkibZmALk2DMBUp8NwEyQzDMD=_d9514_
Content-Type: text/plain; charset="utf-8"


------_tVqzgGyW6tMiW3Z4snM0QQCkibZmALk2DMBUp8NwEyQzDMD=_d9514_--

