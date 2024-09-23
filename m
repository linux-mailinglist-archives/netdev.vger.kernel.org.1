Return-Path: <netdev+bounces-129360-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D1F97F097
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 20:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 020AF1C215FA
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 18:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5401A08CB;
	Mon, 23 Sep 2024 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="JyKCEN0M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91419F41C
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727115808; cv=none; b=qA1VGzToVWmWX/K2uCN4btwQ/TKc68f6KazLrv85DXrEeRUtgMT1Kfne6XsVJUXsKNLjn1h8lPCwIk5HNA4Y9x0nE6m7Qa+x77zvQHP0QSRW+LXnY1nhYWGQAoMm4Uvg94ws/zfmnJzbR37ByNA4eS+BildHquYf0ALHIZCJFK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727115808; c=relaxed/simple;
	bh=K66lgzb39/tsC44JMa8QeVze8KWrr6euBEKK0+0Htj4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=cNrBEN1dT38VHO8dxRGO76jvLF+TF6eeoHZhK1vkLmY5Bpl0RA8jdhpcfk3gpMqwojk9gV0JJ9T7HtANQUa6/uy5iIcmWQhIhwSK2QAliwB8YJ8Xok4zru2/leeEi8jQYh7sTxKPMLScFVxSuuQwosbydWW8ZfIwbyEzddW2JRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=JyKCEN0M; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-71923d87be4so3412213b3a.0
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1727115806; x=1727720606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zA6f+caa340QDccXGTS1GWN1iuzfH3l7a+cwfvycMmk=;
        b=JyKCEN0M/XgoHCY9wpehcGFUAIDHYJsbw90z7hK5xNvLMVdwwN+TMkKx7aEkfTiOLQ
         c12xPjh396DIJwK1+c1pVlAEh7ogO/gETDIWWbjn0wa39zijbf69BYABtNiRh8FFMc7A
         7c2ZNrjU6JfqsPSGEnSGl+emDCFd7VSmXUtGF2ZdR6LNG1TWhCBHmvdm2f8MKvlIxsvh
         G1E32T/z3mTFDovojKKSAVYmTdFdYOLzNIAW0bggXznvVQe2Cb4boiwRs84prViOUVN3
         498UBZd9riQluqYS6eLm+cdb9lrUzBdyFPU68JshiqRtngwnZvb1s1DYuFMCgbf/MlSK
         QQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727115806; x=1727720606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zA6f+caa340QDccXGTS1GWN1iuzfH3l7a+cwfvycMmk=;
        b=joIS3Nbf7iiQLK2dnzNUg9KWvfTUaWNi3IBuwfKtr5ixuZmwr/NskyDKvFpRGDeuOD
         PbOjMeF70sgjQty7iZHsph9cK6Ev1vdYtsMDzNyN1hXvOYWZ/9xKeAvcIMc2dhtpjYk3
         kGVhDIOMHOUHPD9B5R04aqy9ZvHKBVpCi3FeLYZ9ssAj4X/w5daUD+8bbPe4nM2wRCia
         1bphKfCqSAoPsrAiAVzVendcJvLGCiX5S6M5Vi3TlJWjSSLCFxcw3A2B7Na0Mu48Jy6d
         r37tl0/RqoC8pHFPk/M+AY0zD43PeuzUsUpCohHtQGR3PnsYHZs7CpSaLWZ9ihz3Ru9X
         ek+g==
X-Forwarded-Encrypted: i=1; AJvYcCW9Hj1QNMshcOJnJxsasw4kXFYr0eZ04wx/uTZFMMcjBp0WyOf/NOBPxBXL9YUWpIV+t/P7h0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwO9ANmqIHjByz6yUWYV+tUdSWwx7mWOKn3YhDhnLfHmL08rmoM
	QFzQ1W4m9qXomYjB0wWqElHxgGvomTbgEDLLN0ILImzH2rr+IR2vy1snIbW48BuU6/7hrCBeuJR
	da6y+xIedx0WU/dQixRBF8vDkp3VOl/tU0MCK6g==
X-Google-Smtp-Source: AGHT+IH3bigHzH2R776hscI3skYNxcIcWD21EWCuNBmJKsmsmHU4RJMBTlK7knv154edWRFX7jq5IIAUWbOvQoML+QM=
X-Received: by 2002:a05:6a00:4612:b0:706:b10c:548a with SMTP id
 d2e1a72fcca58-7199c9f0bc4mr17606705b3a.22.1727115805726; Mon, 23 Sep 2024
 11:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Mon, 23 Sep 2024 19:23:14 +0100
Message-ID: <CALrw=nGoSW=M-SApcvkP4cfYwWRj=z7WonKi6fEksWjMZTs81A@mail.gmail.com>
Subject: wireguard/napi stuck in napi_disable
To: Jason@zx2c4.com, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	wireguard@lists.zx2c4.com, netdev <netdev@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, jiri@resnulli.us, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: kernel-team <kernel-team@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

We run calico on our Kubernetes cluster, which uses Wireguard to
encrypt in-cluster traffic [1]. Recently we tried to improve the
throughput of the cluster and eliminate some packet drops we=E2=80=99re see=
ing
by switching on threaded NAPI [2] on these managed Wireguard
interfaces. However, our Kubernetes hosts started to lock up once in a
while.

Analyzing one stuck host with drgn we were able to confirm that the
code is just waiting in this loop [3] for the NAPI_STATE_SCHED bit to
be cleared for the Wireguard peer napi instance, but that never
happens for some reason. For context the full state of the stuck napi
instance is 0b100110111. What makes things worse - this happens when
calico removes a Wireguard peer, which happens while holding the
global rtnl_mutex, so all the other tasks requiring that mutex get
stuck as well.

Full stacktrace of the =E2=80=9Clooping=E2=80=9D task:

#0  context_switch (linux/kernel/sched/core.c:5380:2)
#1  __schedule (linux/kernel/sched/core.c:6698:8)
#2  schedule (linux/kernel/sched/core.c:6772:3)
#3  schedule_hrtimeout_range_clock (linux/kernel/time/hrtimer.c:2311:3)
#4  usleep_range_state (linux/kernel/time/timer.c:2363:8)
#5  usleep_range (linux/include/linux/delay.h:68:2)
#6  napi_disable (linux/net/core/dev.c:6477:4)
#7  peer_remove_after_dead (linux/drivers/net/wireguard/peer.c:120:2)
#8  set_peer (linux/drivers/net/wireguard/netlink.c:425:3)
#9  wg_set_device (linux/drivers/net/wireguard/netlink.c:592:10)
#10 genl_family_rcv_msg_doit (linux/net/netlink/genetlink.c:971:8)
#11 genl_family_rcv_msg (linux/net/netlink/genetlink.c:1051:10)
#12 genl_rcv_msg (linux/net/netlink/genetlink.c:1066:8)
#13 netlink_rcv_skb (linux/net/netlink/af_netlink.c:2545:9)
#14 genl_rcv (linux/net/netlink/genetlink.c:1075:2)
#15 netlink_unicast_kernel (linux/net/netlink/af_netlink.c:1342:3)
#16 netlink_unicast (linux/net/netlink/af_netlink.c:1368:10)
#17 netlink_sendmsg (linux/net/netlink/af_netlink.c:1910:8)
#18 sock_sendmsg_nosec (linux/net/socket.c:730:12)
#19 __sock_sendmsg (linux/net/socket.c:745:16)
#20 ____sys_sendmsg (linux/net/socket.c:2560:8)
#21 ___sys_sendmsg (linux/net/socket.c:2614:8)
#22 __sys_sendmsg (linux/net/socket.c:2643:8)
#23 do_syscall_x64 (linux/arch/x86/entry/common.c:51:14)
#24 do_syscall_64 (linux/arch/x86/entry/common.c:81:7)
#25 entry_SYSCALL_64+0x9c/0x184 (linux/arch/x86/entry/entry_64.S:121)

We have also noticed that a similar issue is observed, when we switch
Wireguard threaded NAPI back to off: removing a Wireguard peer task
may still spend a considerable amount of time in the above loop (and
hold rtnl_mutex), however the host eventually recovers from this
state.

So the questions are:
1. Any ideas why NAPI_STATE_SCHED bit never gets cleared for the
threaded NAPI case in Wireguard?
2. Is it generally a good idea for Wireguard to loop for an
indeterminate amount of time, while holding the rtnl_mutex? Or can it
be refactored?

We have observed the problem on Linux 6.6.47 and 6.6.48. We did try to
downgrade the kernel a couple of patch revisions, but it did not help
and our logs indicate that at least the non-threaded prolonged holding
of the rtnl_mutex is happening for a while now.

[1]: https://docs.tigera.io/calico/latest/network-policy/encrypt-cluster-po=
d-traffic
[2]: https://docs.kernel.org/networking/napi.html#threaded
[3]: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/=
net/core/dev.c?h=3Dv6.6.48#n6476

