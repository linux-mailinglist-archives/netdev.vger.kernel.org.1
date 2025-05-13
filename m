Return-Path: <netdev+bounces-189914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29720AB4819
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769773BFB35
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 00:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F1518D;
	Tue, 13 May 2025 00:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dIuZSVdk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97CBA50
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 00:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747094591; cv=none; b=IGa/QbnPIEysKjZBuea1tRytheTSEFrH78LLz65uQqnlfazhsrsrnQ2ynvIW+AJnmdRWzTK+IiM4ae+72fdj5bIDx/a/BnM3U22KKv55yLVm337afs5ImXkZTU9vgxfcH0KQFnYXeiFZeByLzYdRAEOLroU7Eiw9TJKjhgn4v80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747094591; c=relaxed/simple;
	bh=UEcV3ny/LLLcfEq+rtX2d/kLpTN0vQyp5MubamPRriY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pDlR7jw0KntPudgc27/7t+Iy9e8i8MAubGpclDYV6NzYomxpz+xyKMXTIP3fanjvsYbU5Iac9emlX60sjVWig4mAh3vQfFWw9dmj2j/ihstt/bg2EFQs10BX4Th21cTO3p8dJUY87a3AHT2R1pn1En8/zwoVRG3gqXXG8dB0fi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dIuZSVdk; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-22e39fbad5fso48855ad.1
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 17:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747094589; x=1747699389; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hxrCjaGUD3r5k3kK66meWCgUCgXIciyDBKuxrmRW22k=;
        b=dIuZSVdkIf+WtNBcISE38dmMqyV+z9dxB4/Tx5AWVvcU0BVfnBUQxnarN+ourhjxyr
         2LDmKEeMqIGo/A8hxdncU/sgunL0TRyZqCZiwzMcpt2bkEjsCf6/8Db+G7FIAmodsOAq
         xxF2NaBFbDH8U2+1A6RiI6QJgLtzhENVXHWvc+pH3Lre55D9VhK9PXXf2HReGlb7kqUd
         ujqjh8d/AfAtQUib1BuXyPbLXZfyweCoJo0gotN5ARzKyndib6U6OIFK3NT4f82R8rmm
         04EuqSOaoK8W48fFdJwUz+T06pNiRHiYzuhfGPJrJDOxY2MPiy0EhSI5GCrsOTtz6psX
         Vj2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747094589; x=1747699389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hxrCjaGUD3r5k3kK66meWCgUCgXIciyDBKuxrmRW22k=;
        b=OtaefiW2cxtP2LGK6L8RZhuk+PWVoq2pOMbdKtBy38CN6nl+w/ZoKc6jZ1eXm7tGHC
         5By+1KgKy6GiXIq1OfBo/v6p9weCePeXR46IGuta+durFyzJIg77p5bqncdhMv6MdTvd
         Nq0L3VSDl+r3bKZGo3V29oz/Q0tSfc7DjvEpvEj3gCfxV8NGhAIk394SdHuSLhkxn/Su
         qvt+FX3Xp6977SDHZWsvCUln63Y4HPJEjYd0fVi0CUT8MOkmjh5YV78KzNnQrakqHciU
         zfq9wGx6N29rN1bsnRJGdTAwXYyh0UT21lMsGs4y57RYfp0WCGOL4UbEQvXE10uEeqKU
         ZoQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcMuLfZl9CZuZp2g9539PND5LyflBHtoepyREJd0Y0d5kNgS5sTp5gBsQcGtwcviuT3jBUTWc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKSQqhoRJazc923W4E/GSD08Iy4h9EgoCZFUDVcRs824rKiY+6
	jO/wv3qNJI9f/WsKWq1cbZAT2D0IaGt3S9hQCjYJ8yXS2rGrlG3sZSVPm89B0M8dscH5qV3qbjL
	u65RCNbk2NnxW38yVfybZ4XKQa7KUyAaUQxPq45LI
X-Gm-Gg: ASbGncvFcRaSouePIuCTNBZUnmb46s10JgOpcjuqdhD7m1rjzGxUwOsK8zJMiUqRDxj
	bPu3PYxUHPyyi57sWusiu8xP2GO6j+JonNg7C0F4A5Jn1s+ZnYjakhJqgY0Ndd23P0NtJO5yE1C
	gMoGTtZ4iakkKK+2Q0sPbb5n4k6CVy/8F+NBHWPAGbc3jcwWmbjK2+yXhMuphuFO4=
X-Google-Smtp-Source: AGHT+IF7OA0Hss9q0EXyEf8yxuzN/6zw8N5Iad+oSD/SpPfTdJfxgNZBuIBO0rlNJKHyQUVpUvoTgm7Dsr/1fqa3ssE=
X-Received: by 2002:a17:902:c944:b0:224:1fb:7b65 with SMTP id
 d9443c01a7336-2317d7dcc48mr1254075ad.22.1747094588659; Mon, 12 May 2025
 17:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512084059.711037-1-ap420073@gmail.com>
In-Reply-To: <20250512084059.711037-1-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 12 May 2025 17:02:55 -0700
X-Gm-Features: AX0GCFv3HqWrqvK9hQXPMGc4mGne98JqnVo-OGpldUYye6UZX2CmqxfuRUkxPOY
Message-ID: <CAHS8izM5jsbKCMb9FEmnWDuvWUpo8CkQFytnzack4LBByzeV0w@mail.gmail.com>
Subject: Re: [PATCH net v4] net: devmem: fix kernel panic when netlink socket
 close after module unload
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, horms@kernel.org, sdf@fomichev.me, 
	netdev@vger.kernel.org, asml.silence@gmail.com, dw@davidwei.uk, 
	skhawaja@google.com, kaiyuanz@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 1:41=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> Kernel panic occurs when a devmem TCP socket is closed after NIC module
> is unloaded.
>
> This is Devmem TCP unregistration scenarios. number is an order.
> (a)netlink socket close    (b)pp destroy    (c)uninstall    result
> 1                          2                3               OK
> 1                          3                2               (d)Impossible
> 2                          1                3               OK
> 3                          1                2               (e)Kernel pan=
ic
> 2                          3                1               (d)Impossible
> 3                          2                1               (d)Impossible
>
> (a) netdev_nl_sock_priv_destroy() is called when devmem TCP socket is
>     closed.
> (b) page_pool_destroy() is called when the interface is down.
> (c) mp_ops->uninstall() is called when an interface is unregistered.
> (d) There is no scenario in mp_ops->uninstall() is called before
>     page_pool_destroy().
>     Because unregister_netdevice_many_notify() closes interfaces first
>     and then calls mp_ops->uninstall().
> (e) netdev_nl_sock_priv_destroy() accesses struct net_device to acquire
>     netdev_lock().
>     But if the interface module has already been removed, net_device
>     pointer is invalid, so it causes kernel panic.
>
> In summary, there are only 3 possible scenarios.
>  A. sk close -> pp destroy -> uninstall.
>  B. pp destroy -> sk close -> uninstall.
>  C. pp destroy -> uninstall -> sk close.
>
> Case C is a kernel panic scenario.
>
> In order to fix this problem, It makes mp_dmabuf_devmem_uninstall() set
> binding->dev to NULL.
> It indicates an bound net_device was unregistered.
>
> It makes netdev_nl_sock_priv_destroy() do not acquire netdev_lock()
> if binding->dev is NULL.
>
> A new binding->lock is added to protect a dev of a binding.
> So, lock ordering is like below.
>  priv->lock
>  netdev_lock(dev)
>  binding->lock
>
> Tests:
> Scenario A:
>     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
>         -v 7 -t 1 -q 1 &
>     pid=3D$!
>     sleep 10
>     kill $pid
>     ip link set $interface down
>     modprobe -rv $module
>
> Scenario B:
>     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
>         -v 7 -t 1 -q 1 &
>     pid=3D$!
>     sleep 10
>     ip link set $interface down
>     kill $pid
>     modprobe -rv $module
>
> Scenario C:
>     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
>         -v 7 -t 1 -q 1 &
>     pid=3D$!
>     sleep 10
>     modprobe -rv $module
>     sleep 5
>     kill $pid
>
> Splat looks like:
> Oops: general protection fault, probably for non-canonical address 0xdfff=
fc001fffa9f7: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> KASAN: probably user-memory-access in range [0x00000000fffd4fb8-0x0000000=
0fffd4fbf]
> CPU: 0 UID: 0 PID: 2041 Comm: ncdevmem Tainted: G    B   W           6.15=
.0-rc1+ #2 PREEMPT(undef)  0947ec89efa0fd68838b78e36aa1617e97ff5d7f
> Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
> RIP: 0010:__mutex_lock (./include/linux/sched.h:2244 kernel/locking/mutex=
.c:400 kernel/locking/mutex.c:443 kernel/locking/mutex.c:605 kernel/locking=
/mutex.c:746)
> Code: ea 03 80 3c 02 00 0f 85 4f 13 00 00 49 8b 1e 48 83 e3 f8 74 6a 48 b=
8 00 00 00 00 00 fc ff df 48 8d 7b 34 48 89 fa 48 c1 ea 03 <0f> b6 f
> RSP: 0018:ffff88826f7ef730 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: 00000000fffd4f88 RCX: ffffffffaa9bc811
> RDX: 000000001fffa9f7 RSI: 0000000000000008 RDI: 00000000fffd4fbc
> RBP: ffff88826f7ef8b0 R08: 0000000000000000 R09: ffffed103e6aa1a4
> R10: 0000000000000007 R11: ffff88826f7ef442 R12: fffffbfff669f65e
> R13: ffff88812a830040 R14: ffff8881f3550d20 R15: 00000000fffd4f88
> FS:  0000000000000000(0000) GS:ffff888866c05000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000563bed0cb288 CR3: 00000001a7c98000 CR4: 00000000007506f0
> PKRU: 55555554
> Call Trace:
> <TASK>
>  ...
>  netdev_nl_sock_priv_destroy (net/core/netdev-genl.c:953 (discriminator 3=
))
>  genl_release (net/netlink/genetlink.c:653 net/netlink/genetlink.c:694 ne=
t/netlink/genetlink.c:705)
>  ...
>  netlink_release (net/netlink/af_netlink.c:737)
>  ...
>  __sock_release (net/socket.c:647)
>  sock_close (net/socket.c:1393)
>
> Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>

Thank you for the fix, and working through the review comments.

Reviewed-by: Mina Almasry <almasrymina@google.com>

--=20
Thanks,
Mina

