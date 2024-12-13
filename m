Return-Path: <netdev+bounces-151628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B649F0541
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 08:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60390188A240
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 07:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0622E18DF7C;
	Fri, 13 Dec 2024 07:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="M9VfmW2d"
X-Original-To: netdev@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3C017B500
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 07:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734073897; cv=none; b=n4WJqCuV4ycQRwPSCUy+xSTG4oNhE3eAe1Fsx3EVNo01OeMaxSA05xRs36skQamtIW8kJ/Ty/yfquyTsm+m07135ppEPoJsIR89FwQz3ZPn4A6v9r/J7jD/ZOtYWaaK1jNULCB+96rRtEjmnKKfrFw36O18xoDQ9pduJXpZjLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734073897; c=relaxed/simple;
	bh=ZdeNNrsmmfU/ZyfY1BXgxZOgx63IrmEqfTclQ4b4A0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=riRGhZrPHCWqS3Yj3lVSRfezkxkUeJMnzmwGH7veOoLwdeB5ueT8Nu5xmcI5dADgzZc/K/YtLQETc5BOYfJ+GvWHiGLwe0H/Lg0YlOOZATg/0ksWijl0vFoy1NDEgocJNQoPhGOYfR2nMs6dMoSf/GaM7JAuXz819RAG9Gmwces=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=M9VfmW2d; arc=none smtp.client-ip=203.254.224.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20241213071133epoutp035cc406e8b6b017cb37f41c5653f09fd2~QqwS-IjCL0136701367epoutp03D
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 07:11:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20241213071133epoutp035cc406e8b6b017cb37f41c5653f09fd2~QqwS-IjCL0136701367epoutp03D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1734073893;
	bh=TMHNQbm7RkuDsktVojR2FrYDrTz7a7G/8RyYrZBGY34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M9VfmW2dQpPXmPdwiz8BklGQmPjxil2NsryhdZH/56awZpNFtQeXE+ZSbbi/OJVML
	 FyMvj+Xw5vuLJijImRy84Xs4tf6fnydmd+MaIHxqVjQgt0dmc5VcD1Iky4JM6V2Wt9
	 MYEdOLyU+n6cq8cvBUZWkAoebQqTphWODX3QR3gA=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20241213071132epcas2p2b17408a70ea7a5b81c97f2026f7c43b9~QqwSTnUww1977019770epcas2p2B;
	Fri, 13 Dec 2024 07:11:32 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.68]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4Y8gVr0TWcz4x9Pv; Fri, 13 Dec
	2024 07:11:32 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
	epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
	40.11.23368.32EDB576; Fri, 13 Dec 2024 16:11:31 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
	20241213071131epcas2p38be59ecaedd3a7ac72f8c06012ce865d~QqwROEtUH2589425894epcas2p34;
	Fri, 13 Dec 2024 07:11:31 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241213071131epsmtrp2a192c6e0b6384f29e5a1303b565e70e7~QqwRNI8g32725127251epsmtrp2O;
	Fri, 13 Dec 2024 07:11:31 +0000 (GMT)
X-AuditID: b6c32a45-db1ed70000005b48-a2-675bde234938
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	C6.70.33707.32EDB576; Fri, 13 Dec 2024 16:11:31 +0900 (KST)
Received: from perf (unknown [10.229.95.91]) by epsmtip2.samsung.com
	(KnoxPortal) with ESMTPA id
	20241213071131epsmtip25ea816d39c3b51d4969c802fcc7f8164~QqwRAKgUq0819208192epsmtip2Y;
	Fri, 13 Dec 2024 07:11:31 +0000 (GMT)
Date: Fri, 13 Dec 2024 16:14:56 +0900
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
Message-ID: <Z1ve5Mvzv4+Qyn+H@perf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <Z0/HyztKs8UFBOa0@perf>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJsWRmVeSWpSXmKPExsWy7bCmma7yveh0g6cTzC2u7Z3IbjHnfAuL
	xbpdrUwWzxbMYLF4euwRu8XkKYwWTfsvMVs86j/BZnF19ztmiwvb+lgtLu+aw2bRcWcvi8Wx
	BWIW306/YbRoffyZ3eLj8SZ2i8UHPrE7CHpsWXmTyWPBplKPTas62Tze77vK5tG3ZRWjx+dN
	cgFsUdk2GamJKalFCql5yfkpmXnptkrewfHO8aZmBoa6hpYW5koKeYm5qbZKLj4Bum6ZOUCn
	KymUJeaUAoUCEouLlfTtbIryS0tSFTLyi0tslVILUnIKzAv0ihNzi0vz0vXyUkusDA0MjEyB
	ChOyM9Z3NTIVvHSqaP55mq2BcaVpFyMnh4SAicTitR1MXYxcHEICOxglFh+9zAbhfGKUmLlz
	JRtIFZjTsT0epuPT/4WsEEU7GSWO/doM1fGQUWLex7eMIFUsAqoSx5samEFsNgFdiW0n/gHF
	OThEBNQkvjb4gdQzC0xlllg/4T4LSFxYwFni7x1bkHJeAWWJH2uvMUPYghInZz4BK+EUUJF4
	OcUTpFVC4AyHxI7PE1ghDnKR2P9vNjOELSzx6vgWdghbSuLzu71sEHaxRMP9W8wQzS2MEqeu
	v4BqMJaY9awd7GZmgUyJxZs2soMskwA64sgtFogwn0TH4b9QYV6JjjYhiE41iV9TNjBC2DIS
	uxevgJroIXHr+Al2SJB8YZQ4sXYp0wRGuVlI3pmFZNssoLHMApoS63fpQ4TlJZq3zmaGCEtL
	LP/HgaRiASPbKkax1ILi3PTUYqMCQ3hUJ+fnbmIEp2kt1x2Mk99+0DvEyMTBeIhRgoNZSYT3
	hn1kuhBvSmJlVWpRfnxRaU5q8SFGU2AsTWSWEk3OB2aKvJJ4QxNLAxMzM0NzI1MDcyVx3nut
	c1OEBNITS1KzU1MLUotg+pg4OKUamIxDMlN9TH7bvp/8YiEXS1TKzbmZB+d6t+zWu3LIVN2l
	rbm9LddkvVnzY+G7ntfP+q98+K//YE+hvn/6c+Of1qXlS27tuLzwkB/nGZN16Xee2LgsnrXp
	3KI4kTV7lR79cRXYazQ5creVrFr/w5fM8WyX2R882XhMtFf8ye4tTl98RVapsh27FDVzeoKd
	ZtzD+ff0v/XqBk4/7sP0MPyHePd7T4FFT746qDyQDGPjSG7OV/vGn7uCn7nhSPCKRknHhWuS
	z22y2Z3v+TFv74zke3/Cvv7VOvK6gve+m9r5eTb3lUutsk//3nflsM4f5ci44AkuLOkqcyyk
	fj543z1z3x7L4zybrkxzzC+ca5sZVaHEUpyRaKjFXFScCACVdW4QXAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBIsWRmVeSWpSXmKPExsWy7bCSvK7yveh0gwmvJC2u7Z3IbjHnfAuL
	xbpdrUwWzxbMYLF4euwRu8XkKYwWTfsvMVs86j/BZnF19ztmiwvb+lgtLu+aw2bRcWcvi8Wx
	BWIW306/YbRoffyZ3eLj8SZ2i8UHPrE7CHpsWXmTyWPBplKPTas62Tze77vK5tG3ZRWjx+dN
	cgFsUVw2Kak5mWWpRfp2CVwZS/d9YSzocKiYueQIcwPjE6MuRk4OCQETiU//F7J2MXJxCAls
	Z5Ro+v6RHSIhI3F75WVWCFtY4n7LEaii+4wS/0/0MIEkWARUJY43NTCD2GwCuhLbTvxj7GLk
	4BARUJP42uAHUs8sMJVZYuX6z+wgcWEBZ4m/d2xBynkFlCV+rL3GDDHzC6PE7V3b2SASghIn
	Zz5hAbGZBdQl/sy7xAzSyywgLbH8HwdEWF6ieetssDCngIrEyymeExgFZyFpnoWkeRZC8ywk
	zQsYWVYxiqYWFOem5yYXGOoVJ+YWl+al6yXn525iBEeeVtAOxmXr/+odYmTiYDzEKMHBrCTC
	e8M+Ml2INyWxsiq1KD++qDQntfgQozQHi5I4r3JOZ4qQQHpiSWp2ampBahFMlomDU6qBKUNo
	CUtOl7sHx/SL36esPHM9xODUi90tD5yXVSb/F5w8d8mEruaDZd4nry3trHhqNn16aLvRd+f0
	BRc3b9t5/v7BnCVB64RzAt93CpYIF7gcSZy8qqr0na79R+k5QXHsq9gr2BzsTVc4dKcdP7mg
	zeqbIfeEcN4vfz9s07+2qfvTrIKC8OUqyZuKzRSU7vVFz/tjf9ZClf/sk1Wvf7O//+F1TNd4
	wtWtN86nHdAWEsleovf/4PSf331TX5+8fHy32+dewafGJ1+Zxe5+w59nu/0M57m1HnnBzyKe
	v+Z9tLhiw1qdrzPbQn02RrHOWiDnsuPEY6tsowNvnSWD+xKnmxhL2NqxJO98kMfiL7cqb74S
	S3FGoqEWc1FxIgBNGXnmKwMAAA==
X-CMS-MailID: 20241213071131epcas2p38be59ecaedd3a7ac72f8c06012ce865d
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----uRLjcQzjz6V5OP_3gESdNsGQj04rNmJgdrBpg7IReAZ1oX4H=_1303b0_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295
References: <CGME20241203081005epcas2p247b3d05bc767b1a50ba85c4433657295@epcas2p2.samsung.com>
	<20241203081247.1533534-1-youngmin.nam@samsung.com>
	<CANn89iK+7CKO31=3EvNo6-raUzyibwRRN8HkNXeqzuP9q8k_tA@mail.gmail.com>
	<Z0/HyztKs8UFBOa0@perf>

------uRLjcQzjz6V5OP_3gESdNsGQj04rNmJgdrBpg7IReAZ1oX4H=_1303b0_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Wed, Dec 04, 2024 at 12:08:59PM +0900, Youngmin Nam wrote:
> Hi Eric.
> Thanks for looking at this issue.
> 
> On Tue, Dec 03, 2024 at 12:07:05PM +0100, Eric Dumazet wrote:
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
> > 
> > Please provide the kernel version (this must be a pristine LTS one).
> We are running Android kernel for Android mobile device which is based on LTS kernel 6.6-30.
> But we've seen this issue since kernel 5.15 LTS.
> 
> > and symbolized stack traces using scripts/decode_stacktrace.sh
> Unfortunately, we don't have the matched vmlinux right now. So we need to rebuild and reproduce.

Hi Eric.

We successfully reproduced this issue.
Here is the symbolized stack trace.

* Case 1
WARNING: CPU: 2 PID: 509 at net/ipv4/tcp_input.c:2026 tcp_sacktag_write_queue+0xae8/0xb60

panic+0x180                        mov w0, wzr (kernel/panic.c:369)
__warn+0x1d4                       adrp x0, #0xffffffd08256b000 <f_midi_longname+48857> (kernel/panic.c:240)
report_bug+0x174                   mov w19, #1 (lib/bug.c:201)
bug_handler+0x24                   cmp w0, #1 (arch/arm64/kernel/traps.c:1032)
brk_handler+0x94                   cbz w0, #0xffffffd081015eac <brk_handler+220> (arch/arm64/kernel/debug-monitors.c:330)
do_debug_exception+0xa4            cbz w0, #0xffffffd08103afe8 <do_debug_exception+200> (arch/arm64/mm/fault.c:965)
el1_dbg+0x58                       bl #0xffffffd08203994c <arm64_exit_el1_dbg> (arch/arm64/kernel/entry-common.c:443)
el1h_64_sync_handler+0x3c          b #0xffffffd082038884 <el1h_64_sync_handler+120> (arch/arm64/kernel/entry-common.c:482)
el1h_64_sync+0x68                  b #0xffffffd081012150 <ret_to_kernel> (arch/arm64/kernel/entry.S:594)
tcp_sacktag_write_queue+0xae8      brk #0x800 (net/ipv4/tcp_input.c:2029)
tcp_ack+0x494                      orr w21, w0, w21 (net/ipv4/tcp_input.c:3914)
tcp_rcv_state_process+0x224        ldrb w8, [x19, #0x12] (net/ipv4/tcp_input.c:6635)
tcp_v4_do_rcv+0x1ec                cbz w0, #0xffffffd081eb0628 <tcp_v4_do_rcv+520> (net/ipv4/tcp_ipv4.c:1757)
tcp_v4_rcv+0x984                   mov x0, x20 (include/linux/spinlock.h:391)
ip_protocol_deliver_rcu+0x194      tbz w0, #0x1f, #0xffffffd081e7cd00 <ip_protocol_deliver_rcu+496> (net/ipv4/ip_input.c:207)
ip_local_deliver+0xe4              bl #0xffffffd081166910 <__rcu_read_unlock> (include/linux/rcupdate.h:818)
ip_rcv+0x90                        mov w21, w0 (include/net/dst.h:468)
__netif_receive_skb_core+0xdc4     mov x23, x27 (net/core/dev.c:2241)
__netif_receive_skb_list_core+0xb8  ldr x26, [sp, #8] (net/core/dev.c:5648)
netif_receive_skb_list_inter..+0x228  tbz w21, #0, #0xffffffd081d819dc <netif_receive_skb_list_internal+576> (net/core/dev.c:5716)
napi_complete_done+0xb4            str x22, [x19, #0x108] (include/linux/list.h:37)
slsi_rx_netif_napi_poll+0x22c      mov w0, w20 (../exynos/soc-series/s-android15/drivers/net/wireless/pcie_scsc/netif.c:1722)
__napi_poll+0x5c                   mov w19, w0 (net/core/dev.c:6575)
napi_threaded_poll+0x110           strb wzr, [x28, #0x39] (net/core/dev.c:6721)
kthread+0x114                      sxtw x0, w0 (kernel/kthread.c:390)
ret_from_fork+0x10                 mrs x28, sp_el0 (arch/arm64/kernel/entry.S:862)

* Case 2
WARNING: CPU: 7 PID: 2099 at net/ipv4/tcp_input.c:3030 tcp_fastretrans_alert+0x860/0x910

panic+0x180                        mov w0, wzr (kernel/panic.c:369)
__warn+0x1d4                       adrp x0, #0xffffffd08256b000 <f_midi_longname+48857> (kernel/panic.c:240)
report_bug+0x174                   mov w19, #1 (lib/bug.c:201)
bug_handler+0x24                   cmp w0, #1 (arch/arm64/kernel/traps.c:1032)
brk_handler+0x94                   cbz w0, #0xffffffd081015eac <brk_handler+220> (arch/arm64/kernel/debug-monitors.c:330)
do_debug_exception+0xa4            cbz w0, #0xffffffd08103afe8 <do_debug_exception+200> (arch/arm64/mm/fault.c:965)
el1_dbg+0x58                       bl #0xffffffd08203994c <arm64_exit_el1_dbg> (arch/arm64/kernel/entry-common.c:443)
el1h_64_sync_handler+0x3c          b #0xffffffd082038884 <el1h_64_sync_handler+120> (arch/arm64/kernel/entry-common.c:482)
el1h_64_sync+0x68                  b #0xffffffd081012150 <ret_to_kernel> (arch/arm64/kernel/entry.S:594)
tcp_fastretrans_alert+0x860        brk #0x800 (net/ipv4/tcp_input.c:2723)
tcp_ack+0x8a4                      ldur w21, [x29, #-0x20] (net/ipv4/tcp_input.c:3991)
tcp_rcv_state_process+0x224        ldrb w8, [x19, #0x12] (net/ipv4/tcp_input.c:6635)
tcp_v4_do_rcv+0x1ec                cbz w0, #0xffffffd081eb0628 <tcp_v4_do_rcv+520> (net/ipv4/tcp_ipv4.c:1757)
tcp_v4_rcv+0x984                   mov x0, x20 (include/linux/spinlock.h:391)
ip_protocol_deliver_rcu+0x194      tbz w0, #0x1f, #0xffffffd081e7cd00 <ip_protocol_deliver_rcu+496> (net/ipv4/ip_input.c:207)
ip_local_deliver+0xe4              bl #0xffffffd081166910 <__rcu_read_unlock> (include/linux/rcupdate.h:818)
ip_rcv+0x90                        mov w21, w0 (include/net/dst.h:468)
__netif_receive_skb_core+0xdc4     mov x23, x27 (net/core/dev.c:2241)
__netif_receive_skb+0x40           ldr x2, [sp, #8] (net/core/dev.c:5570)
netif_receive_skb+0x3c             mov w19, w0 (net/core/dev.c:5771)
slsi_rx_data_deliver_skb+0xbe0     cmp w0, #1 (../exynos/soc-series/s-android15/drivers/net/wireless/pcie_scsc/sap_ma.c:1104)
slsi_ba_process_complete+0x70      mov x0, x21 (include/linux/spinlock.h:356)
slsi_ba_aging_timeout_handler+0x324  mov x0, x21 (include/linux/spinlock.h:396)
call_timer_fn+0x4c                 nop (arch/arm64/include/asm/jump_label.h:22)
__run_timers+0x1c4                 mov x0, x19 (kernel/time/timer.c:1755)
run_timer_softirq+0x24             mov w9, #0x1280 (kernel/time/timer.c:2038)
handle_softirqs+0x124              nop (arch/arm64/include/asm/jump_label.h:22)
__do_softirq+0x14                  ldp x29, x30, [sp], #0x10 (kernel/softirq.c:634)
____do_softirq+0x10                ldp x29, x30, [sp], #0x10 (arch/arm64/kernel/irq.c:82)
call_on_irq_stack+0x3c             mov sp, x29 (arch/arm64/kernel/entry.S:896)
do_softirq_own_stack+0x1c          ldp x29, x30, [sp], #0x10 (arch/arm64/kernel/irq.c:87)
__irq_exit_rcu+0x54                adrp x9, #0xffffffd083064000 <this_cpu_vector> (kernel/softirq.c:662)
irq_exit_rcu+0x10                  ldp x29, x30, [sp], #0x10 (kernel/softirq.c:697)
el0_interrupt+0x54                 bl #0xffffffd0810197b4 <local_daif_mask> (arch/arm64/kernel/entry-common.c:136)
__el0_irq_handler_common+0x18      ldp x29, x30, [sp], #0x10 (arch/arm64/kernel/entry-common.c:774)
el0t_64_irq_handler+0x10           ldp x29, x30, [sp], #0x10 (arch/arm64/kernel/entry-common.c:779)
el0t_64_irq+0x1a8                  b #0xffffffd0810121b8 <ret_to_user> (arch/arm64/kernel/entry.S:600)

------uRLjcQzjz6V5OP_3gESdNsGQj04rNmJgdrBpg7IReAZ1oX4H=_1303b0_
Content-Type: text/plain; charset="utf-8"


------uRLjcQzjz6V5OP_3gESdNsGQj04rNmJgdrBpg7IReAZ1oX4H=_1303b0_--

