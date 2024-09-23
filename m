Return-Path: <netdev+bounces-129368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F3497F0D6
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 20:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 634671C20C4D
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 18:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E62D1862F;
	Mon, 23 Sep 2024 18:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EP0qpPWE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A53A15E88
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 18:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117221; cv=none; b=mRAsM0iRCrP1TecPPt86oEEw9/c+VY2DJJ3Hv3PNrh87lopEIW8thcCfBiKWUZzBUQgUngPWlUfB9p6ZcxtJ4gQuPLHRWGxxL/J41jTL2s0WuhduweaOCOhlfZ1cG41RFuiqyONRSfj7+zW94oqRN0SkLeaQ+PCOavKtjunbWp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117221; c=relaxed/simple;
	bh=DtQ+HnhI8KP8gv+zLVSZ4exfL0ZJE1UvPYQYsjLzcMI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SBb9WJVa3wXxyu1BM65gG//UzS08Bjx3j6iXOvluROx2OajMuT03POSX7FF3/gLywCVzjZH3rg3iLOVri7DTfFy1EBfNg4QAZXtD2oVf8rdS+46qrm1SyLvUWpG9yyI88G+BbS0B4tx2PyoLWTjCIvtWRM2/Qrq/IQF/70sPNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EP0qpPWE; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5365b71a6bdso5259349e87.2
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 11:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727117217; x=1727722017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o9SxBKtVnKUNRcU2l8i9+tr7LGseNTvA1HmjIgiJZ6c=;
        b=EP0qpPWE3N8IbfBZZl0xdJMm3jeG6lrEsGpjWgr+dLSY+HGnDHEzxDj0T5LmJNnENi
         WNeZf9TXc6uU+P8fm18eHjPyrIi3oMVXd0Mu+tTSAPIA4XCOXiMGhTrRArUOWEIG6BNM
         x6mw1SBweKtBWw6Uo9OPRTi+X/vM+/XicdrBiKzvKro/ECKg8cdj3wyoWbmmxFWEWYUp
         jNRAOc7FBnTHyiEuH4crztb/9HsW5c/1JOdCeIpd0YFrJXqBRisAH5LB4Y7oVBBqAMIt
         hL3yw1/QjVfDyjkujp0vxw4RTbDrrblw9hOE7Zv+/nm8wWPCHgORBp60Hs5lQfuJwfuR
         LI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727117217; x=1727722017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o9SxBKtVnKUNRcU2l8i9+tr7LGseNTvA1HmjIgiJZ6c=;
        b=av4mPrRFkeTI3DQ5lQYBScli7T743RAwVKXn2PyheX7x6Dhe49qBfIpWxh3QygFHTt
         z3dpbDge7Wj50eTUpvVv2UbNSrwduRmZ5LEjidHQ/EmdGDLDK+EHC8aWTZNx8QQF/LtB
         KQ3d4jLbeXLhcs/e63yt8Ghf/rg8v5PLfVyU+NBLlov5IMxSICOhBebJvoUPAsvsoc9y
         Om+SulSVszfcu94dJ8PuyPLSwCboo/yX9/kQeB9x0IqCecXuUwK5KhEccrkWKPAf8PeF
         hgL2EDxoWIIk0dxof0DnfVbLxLmBMytZY3/U3iWeG4Aw4DgcTrZhGg39WXenHpBJf+LB
         48LQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtuO5Qaq4TEk5/uUoYpRv+y2l/M3UgQhtXpkfm9b4IqK3RpIQ56yhjyGb6jDvIaly3ijjDaOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuSfd+QFaZUtaWxGj0NgckMCaXgUGzChWzzuo6awtRwdTHglMB
	VwMdVGvspunCV+Dxv1tfqz2miepGC4tEDOXDGwFS+U97Pm24B3Hho/6okb2rq1FsOVLOQGBIy7l
	xR3guxnhzZ5R72rSuFec24AyuqF5GyHkLEA9O
X-Google-Smtp-Source: AGHT+IEdUO93R9RfshiaEfkPtfC8Xl5uT3xw9/r+1yE0jsL1ViaO/11BK3hy0Now0uX6vpEhuQza2skF49C4GNi/gfc=
X-Received: by 2002:a05:6512:1293:b0:535:82eb:21d1 with SMTP id
 2adb3069b0e04-536ac34094fmr5590163e87.57.1727117217312; Mon, 23 Sep 2024
 11:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALrw=nGoSW=M-SApcvkP4cfYwWRj=z7WonKi6fEksWjMZTs81A@mail.gmail.com>
In-Reply-To: <CALrw=nGoSW=M-SApcvkP4cfYwWRj=z7WonKi6fEksWjMZTs81A@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Sep 2024 20:46:44 +0200
Message-ID: <CANn89iJRoJQ5XXZxbC4mA=-N2sHyY8QNG-ftyQZT7w3RUw-g6w@mail.gmail.com>
Subject: Re: wireguard/napi stuck in napi_disable
To: Ignat Korchagin <ignat@cloudflare.com>
Cc: Jason@zx2c4.com, "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, wireguard@lists.zx2c4.com, 
	netdev <netdev@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, jiri@resnulli.us, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 8:23=E2=80=AFPM Ignat Korchagin <ignat@cloudflare.c=
om> wrote:
>
> Hello,
>
> We run calico on our Kubernetes cluster, which uses Wireguard to
> encrypt in-cluster traffic [1]. Recently we tried to improve the
> throughput of the cluster and eliminate some packet drops we=E2=80=99re s=
eeing
> by switching on threaded NAPI [2] on these managed Wireguard
> interfaces. However, our Kubernetes hosts started to lock up once in a
> while.
>
> Analyzing one stuck host with drgn we were able to confirm that the
> code is just waiting in this loop [3] for the NAPI_STATE_SCHED bit to
> be cleared for the Wireguard peer napi instance, but that never
> happens for some reason. For context the full state of the stuck napi
> instance is 0b100110111. What makes things worse - this happens when
> calico removes a Wireguard peer, which happens while holding the
> global rtnl_mutex, so all the other tasks requiring that mutex get
> stuck as well.
>
> Full stacktrace of the =E2=80=9Clooping=E2=80=9D task:
>
> #0  context_switch (linux/kernel/sched/core.c:5380:2)
> #1  __schedule (linux/kernel/sched/core.c:6698:8)
> #2  schedule (linux/kernel/sched/core.c:6772:3)
> #3  schedule_hrtimeout_range_clock (linux/kernel/time/hrtimer.c:2311:3)
> #4  usleep_range_state (linux/kernel/time/timer.c:2363:8)
> #5  usleep_range (linux/include/linux/delay.h:68:2)
> #6  napi_disable (linux/net/core/dev.c:6477:4)
> #7  peer_remove_after_dead (linux/drivers/net/wireguard/peer.c:120:2)
> #8  set_peer (linux/drivers/net/wireguard/netlink.c:425:3)
> #9  wg_set_device (linux/drivers/net/wireguard/netlink.c:592:10)
> #10 genl_family_rcv_msg_doit (linux/net/netlink/genetlink.c:971:8)
> #11 genl_family_rcv_msg (linux/net/netlink/genetlink.c:1051:10)
> #12 genl_rcv_msg (linux/net/netlink/genetlink.c:1066:8)
> #13 netlink_rcv_skb (linux/net/netlink/af_netlink.c:2545:9)
> #14 genl_rcv (linux/net/netlink/genetlink.c:1075:2)
> #15 netlink_unicast_kernel (linux/net/netlink/af_netlink.c:1342:3)
> #16 netlink_unicast (linux/net/netlink/af_netlink.c:1368:10)
> #17 netlink_sendmsg (linux/net/netlink/af_netlink.c:1910:8)
> #18 sock_sendmsg_nosec (linux/net/socket.c:730:12)
> #19 __sock_sendmsg (linux/net/socket.c:745:16)
> #20 ____sys_sendmsg (linux/net/socket.c:2560:8)
> #21 ___sys_sendmsg (linux/net/socket.c:2614:8)
> #22 __sys_sendmsg (linux/net/socket.c:2643:8)
> #23 do_syscall_x64 (linux/arch/x86/entry/common.c:51:14)
> #24 do_syscall_64 (linux/arch/x86/entry/common.c:81:7)
> #25 entry_SYSCALL_64+0x9c/0x184 (linux/arch/x86/entry/entry_64.S:121)
>
> We have also noticed that a similar issue is observed, when we switch
> Wireguard threaded NAPI back to off: removing a Wireguard peer task
> may still spend a considerable amount of time in the above loop (and
> hold rtnl_mutex), however the host eventually recovers from this
> state.
>
> So the questions are:
> 1. Any ideas why NAPI_STATE_SCHED bit never gets cleared for the
> threaded NAPI case in Wireguard?
> 2. Is it generally a good idea for Wireguard to loop for an
> indeterminate amount of time, while holding the rtnl_mutex? Or can it
> be refactored?
>
> We have observed the problem on Linux 6.6.47 and 6.6.48. We did try to
> downgrade the kernel a couple of patch revisions, but it did not help
> and our logs indicate that at least the non-threaded prolonged holding
> of the rtnl_mutex is happening for a while now.
>
> [1]: https://docs.tigera.io/calico/latest/network-policy/encrypt-cluster-=
pod-traffic
> [2]: https://docs.kernel.org/networking/napi.html#threaded
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tre=
e/net/core/dev.c?h=3Dv6.6.48#n6476

Somehow wireguard continuously feeds packets without checking it
should not (IFF_UP or some other bit)

napi_schedule() detects NAPIF_STATE_DISABLE, and
napi_disable_pending() is also used
from __napi_poll() to avoid adding back the napi if the whole budget
was consumed.

Not sure, more debugging might be needed.

