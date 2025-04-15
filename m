Return-Path: <netdev+bounces-182950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BCAA8A6B7
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F0A43B8E38
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF97230BCD;
	Tue, 15 Apr 2025 18:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tDPqLTVN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0459B22A801
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 18:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744741380; cv=none; b=CzFAU9eDINAWa4ubh39rUI452eV4jneD2ZL/Dlo1sFsIdxwj+6qG4sZbX1gdUQ8sLmyPUXdgxv4Rxsvjjx6bvhx+rFyDp/ZHkuQxC+q49lTbu5GLXDM4mxridItlwvGqomv8QNd+TZUasRc77JYzWvgbNHM4+5sFj9ZzKkzpnz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744741380; c=relaxed/simple;
	bh=qNyFfs2OYG5xR6Ysxpfdn6xDa+6lhTwuFxnQPtbWfiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXdcgKx2DDeED6OuS9gSUaVZrR0fUEDhvkDk3n0//EEEXLoFz65H0cLCypnhdTY5dtRZqv4jPjdtAN320QzIlBFtLXwaT4JZmJjlECCJzWVhx0YT3qHp+9E/YDQ7NY1cOfgVgBCCX7+hWtTPk18pwS1yZFvCORwjiEWM8UjhdSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tDPqLTVN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2240aad70f2so36305ad.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 11:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744741378; x=1745346178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Rp2bM0lCV+0saQhPpGO1GkAmoe1yzVmRRm/huD8plM=;
        b=tDPqLTVNOG4gRLkTtUdghljwazzNGvPdC/e19aR9VaesgZELJAwoIRnEIU8/GhY5/C
         8XnAiMJpZl6xZcA7Vg7KWWUNMz6mlf+dM3DShuUH5+rhNmJIKEpyZNvnXI85QQ4r/b6B
         ZkDLABrXSmhh39r1DWtJBAvwmJUokOXj+q693e156P1EwHZWhxPzV5FIYl+OVeGYVAlQ
         HDrZEtn993REMUPZrorxyrqYzs2CLYvlpYIABDaPivcoI8aCel+dOVPu1Ylc95bHsuRy
         0qpCweA1x0sxfwY/Gfjf/A7GkSsuaC+NK9BT9slnU+352tY1ACVDwVvsQlaQcJOlphXS
         WoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744741378; x=1745346178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0Rp2bM0lCV+0saQhPpGO1GkAmoe1yzVmRRm/huD8plM=;
        b=ZQHdBZBqtWsAyOPEeGLM9gHB4kcaJfjLg/NYOXg3rerUof1iYhNnNddBJzIZ4XYkNw
         XEgFUQYmp1VsX96wcWgWUGbAARj043BWiyXoyaJNHIvXqi3WZ+aI7P/wRP9aldBH84/E
         P8PdyLbHgThhUnrrMquFXESne6FOb/1ns/NOIyPttEUZtu8lvv5Oc75E/6l+r1nG89jY
         FWfycHib/ScMfBvD4HcTvduCB5D69oXpQH+winPUDC4w8lIQXRnKpVr9AHjz6cy/JTmg
         RTDjFKmFWQUDLJCvfgLE8B7qyhlWmdSQNphCDTnICN6wOFOYyi6NBKIQnVArJpM4pHFJ
         Hctg==
X-Forwarded-Encrypted: i=1; AJvYcCUaVdzv3vi85eYm8m9vjZDBIJCN0rEe3b98la7mnrlNczkhNPojOWLmoWq42ZPebHDZydq2sP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6wAJgFf588D7/NKYVYX+Da/C5B4XGL+AHkb4li0me5ltDEBI4
	aW4cNHFH6KthuyOVvCnX1I+RCMdlgO6hrnJibUs+9r0qY7K46gUhIzlPcpDzmekwoaTyCJWijZm
	UNEhafSQtppnnMbZoGotWFa0Nc20DSXWgNzxB
X-Gm-Gg: ASbGncv2IJbXSyC/M1ASb66Cfgw6shSMc7FhGbJ/oqcYGMC6Kl/nAl3MB5B+Kv2uhaS
	GfjesAYCh1F7djZnfyviSH5M6Xyur/jkPQFDiSCeRXM/Q+nx0HNce80UIYOIttcvr9ax9+W2uD5
	ltv2O6hVs/Y5VEbF+Zd8vfCIQTF1x0FYcrhsk5VbJJF8y3ja2xb+3x
X-Google-Smtp-Source: AGHT+IGgbHvWj6x0RWopDUiso8S40hDo1ytuiCqq5dkOQIm1utjnWHDi5RYsNqCcDwWb8Mmboey50j6a1Na6VHsDybo=
X-Received: by 2002:a17:902:f649:b0:216:48d4:b3a8 with SMTP id
 d9443c01a7336-22c3173ecafmr214185ad.16.1744741377898; Tue, 15 Apr 2025
 11:22:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250415092417.1437488-1-ap420073@gmail.com>
In-Reply-To: <20250415092417.1437488-1-ap420073@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 15 Apr 2025 11:22:44 -0700
X-Gm-Features: ATxdqUGjCDohiB9LNJaQUl4nQsnaV8Jx7JYyms2Ii5s2hv7V6sZVmmV3Xl67wSU
Message-ID: <CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close after
 module unload
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	asml.silence@gmail.com, dw@davidwei.uk, sdf@fomichev.me, skhawaja@google.com, 
	simona.vetter@ffwll.ch, kaiyuanz@google.com, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 15, 2025 at 2:24=E2=80=AFAM Taehee Yoo <ap420073@gmail.com> wro=
te:
>
> Kernel panic occurs when a devmem TCP socket is closed after NIC module
> is unloaded.
>
> This is Devmem TCP unregistration scenarios. number is an order.
> (a)socket close    (b)pp destroy    (c)uninstall    result
> 1                  2                3               OK
> 1                  3                2               (d)Impossible
> 2                  1                3               OK
> 3                  1                2               (e)Kernel panic
> 2                  3                1               (d)Impossible
> 3                  2                1               (d)Impossible
>
> (a) netdev_nl_sock_priv_destroy() is called when devmem TCP socket is
>     closed.
> (b) page_pool_destroy() is called when the interface is down.
> (c) mp_ops->uninstall() is called when an interface is unregistered.
> (d) There is no scenario in mp_ops->uninstall() is called before
>     page_pool_destroy().
>     Because unregister_netdevice_many_notify() closes interfaces first
>     and then calls mp_ops->uninstall().
> (e) netdev_nl_sock_priv_destroy() accesses struct net_device.
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
> In order to fix this problem, it makes netdev_nl_sock_priv_destroy() do
> nothing if a module is already removed.
> The mp_ops->uninstall() handles these instead.
>
> The netdev_nl_sock_priv_destroy() iterates binding->list and releases
> them all with net_devmem_unbind_dmabuf().
> The net_devmem_unbind_dmabuf() has the below steps.
> 1. Delete binding from a list.
> 2. Call _net_mp_close_rxq() for all rxq's bound to a binding.
> 3. Call net_devmem_dmabuf_binding_put() to release resources.
>
> The mp_ops->uninstall() doesn't need to call _net_mp_close_rxq() because
> resources are already released properly when an interface is being down.
>
> From now on netdev_nl_sock_priv_destroy() will do nothing if a module
> has been removed because all bindings are removed from a list by
> mp_ops->uninstall().
>
> netdev_nl_sock_priv_destroy() internally sets mp_ops to NULL.
> So mp_ops->uninstall has not been called if devmem TCP socket was
> already closed.
>
> Tests:
> Scenario A:
>     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
>         -v 7 -t 1 -q 1 &
>     pid=3D$!
>     sleep 10
>     ip link set $interface down
>     kill $pid
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

Scenario A & B are exactly the same steps?

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

Line 953 is:

netdev_lock(dev);

Which was introduced by:

commit 42f342387841 ("net: fix use-after-free in the
netdev_nl_sock_priv_destroy()") and rolling back a few fixes, it's
really introduced by commit 1d22d3060b9b ("net: drop rtnl_lock for
queue_mgmt operations").

My first question, does this issue still reproduce if you remove the
per netdev locking and go back to relying on rtnl_locking? Or do we
crash somewhere else in net_devmem_unbind_dmabuf? If so, where?
Looking through the rest of the unbinding code, it's not clear to me
any of it actually uses dev, so it may just be the locking...

>  genl_release (net/netlink/genetlink.c:653 net/netlink/genetlink.c:694 ne=
t/netlink/genetlink.c:705)
>  ...
>  netlink_release (net/netlink/af_netlink.c:737)
>  ...
>  __sock_release (net/socket.c:647)
>  sock_close (net/socket.c:1393)
>
> Fixes: 170aafe35cb9 ("netdev: support binding dma-buf to netdevice")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
>
> In order to test this patch, driver side implementation of devmem TCP[1]
> is needed to be applied.
>
> [1] https://lore.kernel.org/netdev/20250415052458.1260575-1-ap420073@gmai=
l.com/T/#u
>
>  net/core/devmem.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 6e27a47d0493..8948796b0af5 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -379,6 +379,11 @@ static void mp_dmabuf_devmem_uninstall(void *mp_priv=
,
>         xa_for_each(&binding->bound_rxqs, xa_idx, bound_rxq) {
>                 if (bound_rxq =3D=3D rxq) {
>                         xa_erase(&binding->bound_rxqs, xa_idx);
> +
> +                       if (xa_empty(&binding->bound_rxqs)) {
> +                               list_del(&binding->list);
> +                               net_devmem_dmabuf_binding_put(binding);

On the surface, this fix looks completely unreviewable to be honest.
refcounting must be balanced. i.e. every put has a corresponding get,
otherwise there is a double free. I'm not sure which get you're
dropping here. I think this will cause a double put when the netlink
socket is closed?

--
Thanks,
Mina

