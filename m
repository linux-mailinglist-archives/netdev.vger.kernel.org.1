Return-Path: <netdev+bounces-148787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 400D19E320B
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 04:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C612166FFF
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 03:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3139213C9A3;
	Wed,  4 Dec 2024 03:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Ss9QreUY"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80F5130A54
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733282586; cv=none; b=D/KELaBz/8rvfqLYKrkPxmZS0DMF585SVVMXLB3BELKZlrp2iREflvomOzTmuTsMmwObpQCdSTFMOPvPFQZnVcwkWNMoLYZAkZcALDHhKwu2lOyHZcZgUguulk3a0wibj19SRRaYtN2909CYZPRzvBq1dCjGVAciBjv2DPfumUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733282586; c=relaxed/simple;
	bh=/x87zGqFlYW6FOa7WxLzFnS8i2jC1Co1eFatKFG84+g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=sMNoBHgHluJmg18ZZQJIDErxUCsDuHIOPeP978zVvuUMNyZxW9kkrLWkGQv5BfmKdP8idNTwLF/vk9owcRBsDP1VW1xRg7uQMKZDy3xJFypuVNqmvtbu951WgMEI4SHBFKydXf9ZEgyaKqMsaTBI8EFtJIqrBimfynG1/Xnyi+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Ss9QreUY; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241204032255epoutp034aa7c2a80cbda8cb0c56e821e31eb476~N21GzF8n70366403664epoutp035
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 03:22:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241204032255epoutp034aa7c2a80cbda8cb0c56e821e31eb476~N21GzF8n70366403664epoutp035
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1733282575;
	bh=Ydhw1LSmSJ9spvNZRfN6ZlVoFUHHEfXL806Y9X19014=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ss9QreUYSo6lN5WevNqo/5QRYZ0Oag0b81l8Y1JL+8HiPKbm++xVx9Rh+5oPl4CS1
	 SWr4f3dTZB3YVOTRoOFp6jrZDG3BsM2RWE9MQiBf1NQq7Oo4O/FU0eoAa5I/REC6ui
	 9id1Q8WDbpTTjBIwyDuGTVY1oQHH+vMXzvYeRpEw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20241204032254epcas2p3a513227c336e23119d5c9fad7d9041a3~N21GDxUz30889308893epcas2p3Z;
	Wed,  4 Dec 2024 03:22:54 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.89]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y32sB1Ncpz4x9Pt; Wed,  4 Dec
	2024 03:22:54 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
	83.39.22105.E0BCF476; Wed,  4 Dec 2024 12:22:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
	20241204032253epcas2p1d973d0a4992989ba03c5ab73cbb6696a~N21FJR65m1427114271epcas2p1L;
	Wed,  4 Dec 2024 03:22:53 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241204032253epsmtrp249837e3b9fea563214cb1dcd9a4da891~N21FIPsNJ1447114471epsmtrp24;
	Wed,  4 Dec 2024 03:22:53 +0000 (GMT)
X-AuditID: b6c32a47-fd1c970000005659-4e-674fcb0eb518
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	93.20.33707.D0BCF476; Wed,  4 Dec 2024 12:22:53 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20241204032253epsmtip1ee7d9ee643204be4e67cfeb73c95dcb3~N21E24wCR2668026680epsmtip1l;
	Wed,  4 Dec 2024 03:22:53 +0000 (GMT)
Date: Wed, 4 Dec 2024 12:26:18 +0900
From: Youngmin Nam <youngmin.nam@samsung.com>
To: Neal Cardwell <ncardwell@google.com>, Eric Dumazet <edumazet@google.com>
Cc: Youngmin Nam <youngmin.nam@samsung.com>, davem@davemloft.net,
	dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	dujeong.lee@samsung.com, guo88.liu@samsung.com, yiwang.cai@samsung.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	joonki.min@samsung.com, hajun.sung@samsung.com, d7271.choe@samsung.com,
	sw.ju@samsung.com
Subject: Re: [PATCH] tcp: check socket state before calling WARN_ON
Message-ID: <Z0/L2gDjvXVfj1ho@perf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmmS7faf90g63X2Cyu7Z3IbjHnfAuL
	xbpdrUwWzxbMYLF4euwRu8XkKYwWTfsvMVs86j/BZnF19ztmiwvb+lgtLu+aw2bRcWcvi8Wx
	BWIW306/YbRoffyZ3eLj8SZ2i8UHPrE7CHpsWXmTyWPBplKPTas62Tze77vK5tG3ZRWjx+dN
	cgFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCn
	KymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyB
	ChOyM16evMJY0C9T8XtqdgPjY7EuRk4OCQETiTtPD7N1MXJxCAnsYJRYsf8yK4TziVFi3orf
	CM6yAytYYFqedy5ghkjsZJR4MmkyE0hCSOAho8TMPfogNouAisSH+xOYQWw2AV2JbSf+MYLY
	IgI+ElcftDCBNDMLvGWSWPLqBdAKDg5hAWeJv3dsQWp4BZQlLrd2sUDYghInZz5hASnhFAiU
	ePmoAKRVQuAEh0Tvt2WMEAe5SPSdu8kOYQtLvDq+BcqWkvj8bi8bhF0s0XD/FjNEcwujxKnr
	L5ghEsYSs561gw1iFsiQeLZmCTPIMgmgI47cYoEI80l0HP7LDhHmlehoE4LoVJP4NWUD1Aky
	ErsXr4Ca6CFx6/gJdkj4LGSSePHmCfMERrlZSN6ZhWTbLKCxzAKaEut36UOE5SWat86GCktL
	LP/HgaRiASPbKkax1ILi3PTUYqMCY3hUJ+fnbmIEp2kt9x2MM95+0DvEyMTBeIhRgoNZSYQ3
	cIl/uhBvSmJlVWpRfnxRaU5q8SFGU2A0TWSWEk3OB2aKvJJ4QxNLAxMzM0NzI1MDcyVx3nut
	c1OEBNITS1KzU1MLUotg+pg4OKUamMTmGqnL9jm9mzuvbnFU86oPEtc689kF1lxPur7xSu+0
	G/8d1y+t7CjYxn+3TDXRsHT3p0useXvb1e55HPKMslkeILmb+2+67JWZqtOr9db17WQ+w7+q
	aWevQZLqvDpe9bN2ro1pqp9XxZ689+vYlyUPcw5niB+VvVbqata9VUrdaO27yMWJCRoHVU+F
	yjyPcA9ueSlndu5IG1P6pznnAtifevSuXL3WOlP9ZNpTXpaAdseGsCPVAfdPp6jYJq3dkNtS
	/0lxEYfX/o5/WjzG0kdXMpc+tPs0T1kyp9Zlc9srP+/nfy5NV9DYafd2xQ6WBi/Fdexub5+o
	pLSdavl/+O7dqScmX3/M2ZzhedP+mRJLcUaioRZzUXEiAGQdXpdcBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSnC7vaf90g/8fVCyu7Z3IbjHnfAuL
	xbpdrUwWzxbMYLF4euwRu8XkKYwWTfsvMVs86j/BZnF19ztmiwvb+lgtLu+aw2bRcWcvi8Wx
	BWIW306/YbRoffyZ3eLj8SZ2i8UHPrE7CHpsWXmTyWPBplKPTas62Tze77vK5tG3ZRWjx+dN
	cgFsUVw2Kak5mWWpRfp2CVwZmxt+MBdslKw4+3QCcwPjQpEuRk4OCQETieedC5i7GLk4hAS2
	M0ps/36HBSIhI3F75WVWCFtY4n7LEVaIovuMEk/OnGMGSbAIqEh8uD8BzGYT0JXYduIfI4gt
	IuAnsXzKS0aQBmaBt0wSf3YcYu9i5OAQFnCW+HvHFqSGV0BZ4nJrF9gyIYGFTBKPpitBxAUl
	Ts58AhZnFlCX+DPvEjNIK7OAtMTyfxwQYXmJ5q2zwcKcAoESLx8VTGAUnIWkeRaS5lkIzbOQ
	NC9gZFnFKJpaUJybnptcYKhXnJhbXJqXrpecn7uJERx5WkE7GJet/6t3iJGJg/EQowQHs5II
	b+AS/3Qh3pTEyqrUovz4otKc1OJDjNIcLErivMo5nSlCAumJJanZqakFqUUwWSYOTqkGpg2i
	CR0lrv+m3rp45bSwdl0x983CMwG1LI9Wxv27s6Xj0tZMVoPIXKEts3uW3XweYsm3wPHtup1X
	upm7Dh7Vum9ScsXyEJdzd3fKnRkztBlvhkl5PpqyT7DOYvbfpTqhgVXO7KxOuz7eebzZaKLN
	HgbBOY02XzeuS9QunJjReUlXPuKDAWsgZyIP49kDD5IWJXHtveGwMvGzmEXM2eIdG3lefFJW
	Xr608slCy/Oztjx/zDFF3M/OcvfNWe2tmaVCDx7YLG9RkUudvkJm1o7K67eYEzXkDELib+ef
	mvXkVGAjR7vmZbeleZaqM0tld85zfaJc8tv+2L/12h0OSwSCbdOWLtzQc85M/yzDw73lakos
	xRmJhlrMRcWJABmmdrYrAwAA
X-CMS-MailID: 20241204032253epcas2p1d973d0a4992989ba03c5ab73cbb6696a
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----6TxoHKXr_qkwT5q0XKHb2K6SEyMzWlX0etqXdnnbNHHFM6GI=_cd804_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
	<20241203081247.1533534-1-youngmin.nam@samsung.com>
	<CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
	<CADVnQynUspJL4e3UnZTKps9WmgnE-0ngQnQmn=8gjSmyg4fQ5A@mail.gmail.com>

------6TxoHKXr_qkwT5q0XKHb2K6SEyMzWlX0etqXdnnbNHHFM6GI=_cd804_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Tue, Dec 03, 2024 at 10:34:46AM -0500, Neal Cardwell wrote:
> On Tue, Dec 3, 2024 at 6:07 AM Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Tue, Dec 3, 2024 at 9:10 AM Youngmin Nam <youngmin.nam@samsung.com> wrote:
> > >
> > > We encountered the following WARNINGs
> > > in tcp_sacktag_write_queue()/tcp_fastretrans_alert()
> > > which triggered a kernel panic due to panic_on_warn.
> > >
> > > case 1.
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 4 PID: 453 at net/ipv4/tcp_input.c:2026
> > > Call trace:
> > >  tcp_sacktag_write_queue+0xae8/0xb60
> > >  tcp_ack+0x4ec/0x12b8
> > >  tcp_rcv_state_process+0x22c/0xd38
> > >  tcp_v4_do_rcv+0x220/0x300
> > >  tcp_v4_rcv+0xa5c/0xbb4
> > >  ip_protocol_deliver_rcu+0x198/0x34c
> > >  ip_local_deliver_finish+0x94/0xc4
> > >  ip_local_deliver+0x74/0x10c
> > >  ip_rcv+0xa0/0x13c
> > > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > >
> > > case 2.
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 0 PID: 648 at net/ipv4/tcp_input.c:3004
> > > Call trace:
> > >  tcp_fastretrans_alert+0x8ac/0xa74
> > >  tcp_ack+0x904/0x12b8
> > >  tcp_rcv_state_process+0x22c/0xd38
> > >  tcp_v4_do_rcv+0x220/0x300
> > >  tcp_v4_rcv+0xa5c/0xbb4
> > >  ip_protocol_deliver_rcu+0x198/0x34c
> > >  ip_local_deliver_finish+0x94/0xc4
> > >  ip_local_deliver+0x74/0x10c
> > >  ip_rcv+0xa0/0x13c
> > > Kernel panic - not syncing: kernel: panic_on_warn set ...
> > >
> >
> > I have not seen these warnings firing. Neal, have you seen this in the past ?
> 
> I can't recall seeing these warnings over the past 5 years or so, and
> (from checking our monitoring) they don't seem to be firing in our
> fleet recently.
> 
> > In any case this test on sk_state is too specific.
> 
> I agree with Eric. IMHO TCP_FIN_WAIT1 deserves all the same warnings
> as ESTABLISHED, since in this state the connection may still have a
> big queue of data it is trying to reliably send to the other side,
> with full loss recovery and congestion control logic.
Yes I agree with Eric as well.

> 
> I would suggest that instead of running with panic_on_warn it would
> make more sense to not panic on warning, and instead add more detail
> to these warning messages in your kernels during your testing, to help
> debug what is going wrong. I would suggest adding to the warning
> message:
> 
> tp->packets_out
> tp->sacked_out
> tp->lost_out
> tp->retrans_out
> tcp_is_sack(tp)
> tp->mss_cache
> inet_csk(sk)->icsk_ca_state
> inet_csk(sk)->icsk_pmtu_cookie

Hi Neal.
Thanks for your opinion.

By the way, we enable panic_on_warn by default for stability.
As you know, panic_on_warn is not applied to a specific subsystem but to the entire kernel.
We just want to avoid the kernel panic.

So when I see below lwn article, I think we might use pr_warn() instaed of WARN_ON().
https://lwn.net/Articles/969923/

How do you think of it ?
> 
> A hunch would be that this is either firing for (a) non-SACK
> connections, or (b) after an MTU reduction.
> 
> In particular, you might try `echo 0 >
> /proc/sys/net/ipv4/tcp_mtu_probing` and see if that makes the warnings
> go away.
> 
> cheers,
> neal
> 

------6TxoHKXr_qkwT5q0XKHb2K6SEyMzWlX0etqXdnnbNHHFM6GI=_cd804_
Content-Type: text/plain; charset="utf-8"


------6TxoHKXr_qkwT5q0XKHb2K6SEyMzWlX0etqXdnnbNHHFM6GI=_cd804_--

