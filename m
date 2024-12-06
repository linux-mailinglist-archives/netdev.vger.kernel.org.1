Return-Path: <netdev+bounces-149678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A67E9E6CAD
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 12:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF1631881E15
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 11:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597CC1DA0ED;
	Fri,  6 Dec 2024 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ymH9pUSO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498461B6D04
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 11:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733482840; cv=none; b=m3OYYBWECVnkJv7gWtXC5ntWYdz8zZbYOyInqvfoA3HwQozNrF7/Tp061EnVVKr/Oo2RpGSyBiFfVKVuQk49ZdYKX2P4hYbJ6tUiDmF7D2jiI+1JT8UPS2tzfRxSPH8+inA5fiRjH74nDk8P1pzjo7mC87mMU9us4iP60uT8lsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733482840; c=relaxed/simple;
	bh=fILebswRuBjzAFBt7EyyNVbd3mykTD/tPYTbgQMUytU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEh8PgRRP4lqLFIqR+oEM0Xwhi2GDDrpGC4bi4ERjn6jJetMWT5nRvIyd7SILx4C2hU0JfP/IrQwQGmSY3ENO+vhbEeCIeg5UsExr7uiPVxAEiB4T7fXlodReHNE2B+HHhMunYtJlpClO5aK/W7iGzhhzx8G/M4ONOV/++iCBtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ymH9pUSO; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a1833367so11610295e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Dec 2024 03:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733482836; x=1734087636; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=URV1abg/pKOKHA56G/7eLaj5dIvsartX/LuYS39ddnE=;
        b=ymH9pUSOIipjnutz5SJGdo57Fdb+WiQQf3sNHnT1ixwApGZcAD+Clzpt/8a953sM6b
         fwmnWB7KWTc/cAy5pe9FYB4djLy8Qdu2QhVpK0O/+joj0LGqmD1sByRASJAxkICjBEAR
         PDOp239wooj47fT/4lte1XI78BBjNjcrAQbB2JQA8JFY195TuvQdzacXnDKqJpcFj47i
         PIUXMSIv+oHYXCO1n9XqRbyE9X60K+5Rm9tLh7a34PIF1D+qxp5Q/FjzbT8xLhUiR4NO
         1MV4CVrfIBy3NMgIkMlQpaYnV5r1jPd9ovPAVn/mT7WSHdd+3OG3tdKCQ2zDHAGaLiIe
         EjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733482836; x=1734087636;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=URV1abg/pKOKHA56G/7eLaj5dIvsartX/LuYS39ddnE=;
        b=UpluEApUuFOrIiC1srprDA/nEmn9jHPqixqrplUTphVFZXtKUC1rtfge8C5bmyjC0X
         fNRuF2GR2wC9cJdXR5XIyqu8wAzj45zzVnjDa7Jd2RrQji6/WZ1yAXxXCbqRjB20FdHL
         WKC+Qn0yQn5LsEta1Ui58q2z56qJtVpEtdCZQ+XiL3bGP1OraBCeKCBSUAgE4WLsLm0n
         xytLLuTARyEGQK32hCTQe2AdLtJDeOu7rCGnJJQH9F+Yj4PuPDyLJiQteb+VaZ/dHUVp
         vzPvcZ3rq6ZqM+8v4scr6NBbSTbTppG2AoG1wZr6WLsMRxrcV+VEo3npnHifQ/xxYtM+
         lYwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVZZGI8CgaRUxiQl24B7CloGmBqU5kw90xh6BwUioL8QTLthhzw5HZTeTaN0kfpZmkyB1rVfI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPDloBonFx4DVmnz4h5KzpxhWvmfutN3+cmqU/K2/O8mAqt/wM
	mwfoBLKHeQFnyIDeS/rtYjDfqmnfZCWsmrkPNVIb8y63GKS/x5uWuO0guIt4AZU=
X-Gm-Gg: ASbGncsOnjwiHpGqV+zw8PaexSzdq8njAVNrmKXqlTZVqmPA9QN+t2d00Br9eR6M3XQ
	sLKM4tEBNv1ffFTj+d8UjJZZc9s+zkuN9WcYlioolKz8lw2zz44FLlsT874mhcgHXQh4TwPfFPl
	vxJWdSwEj14obwJcUezUar8t/nrkZZyFonhyJZ0CBjsE47AMWYxcMXoilVgeAxMycnkH9r9YkvI
	mDy/G1/qyUiqbXGwo2J6nkNXbLucxXJJdMrYHmMOJ/wjnMEld/l2og=
X-Google-Smtp-Source: AGHT+IE/nUZ2DipqFz1uNzl+W3q8YX63AQJSDmnFNWzLnhIxYN3zCq0GYQXNP8iTD79eKMhjdVdKfw==
X-Received: by 2002:a05:600c:4f4a:b0:431:55f3:d34e with SMTP id 5b1f17b1804b1-434ddee9547mr20413085e9.15.1733482836396;
        Fri, 06 Dec 2024 03:00:36 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434d526b131sm92439255e9.7.2024.12.06.03.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 03:00:35 -0800 (PST)
Date: Fri, 6 Dec 2024 14:00:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	syzkaller <syzkaller@googlegroups.com>
Subject: Re: [PATCH v2 net] tipc: Fix use-after-free of kernel socket in
 cleanup_bearer().
Message-ID: <baca7f28-22c2-4d11-9894-ed97c8da7e23@stanley.mountain>
References: <20241127050512.28438-1-kuniyu@amazon.com>
 <CANn89iJ-GfHU=sLWJiuqNcoH+AnBtj9dSxpXHjqbAS_VZ8fzAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJ-GfHU=sLWJiuqNcoH+AnBtj9dSxpXHjqbAS_VZ8fzAw@mail.gmail.com>

On Wed, Dec 04, 2024 at 04:01:10PM +0100, Eric Dumazet wrote:
> On Wed, Nov 27, 2024 at 6:05 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > syzkaller reported a use-after-free of UDP kernel socket
> > in cleanup_bearer() without repro. [0][1]
> >
> > When bearer_disable() calls tipc_udp_disable(), cleanup
> > of the UDP kernel socket is deferred by work calling
> > cleanup_bearer().
> >
> > tipc_net_stop() waits for such works to finish by checking
> > tipc_net(net)->wq_count.  However, the work decrements the
> > count too early before releasing the kernel socket,
> > unblocking cleanup_net() and resulting in use-after-free.
> >
> > Let's move the decrement after releasing the socket in
> > cleanup_bearer().
> >
> > [0]:
> > ref_tracker: net notrefcnt@000000009b3d1faf has 1/1 users at
> >      sk_alloc+0x438/0x608
> >      inet_create+0x4c8/0xcb0
> >      __sock_create+0x350/0x6b8
> >      sock_create_kern+0x58/0x78
> >      udp_sock_create4+0x68/0x398
> >      udp_sock_create+0x88/0xc8
> >      tipc_udp_enable+0x5e8/0x848
> >      __tipc_nl_bearer_enable+0x84c/0xed8
> >      tipc_nl_bearer_enable+0x38/0x60
> >      genl_family_rcv_msg_doit+0x170/0x248
> >      genl_rcv_msg+0x400/0x5b0
> >      netlink_rcv_skb+0x1dc/0x398
> >      genl_rcv+0x44/0x68
> >      netlink_unicast+0x678/0x8b0
> >      netlink_sendmsg+0x5e4/0x898
> >      ____sys_sendmsg+0x500/0x830
> >
> > [1]:
> > BUG: KMSAN: use-after-free in udp_hashslot include/net/udp.h:85 [inline]
> > BUG: KMSAN: use-after-free in udp_lib_unhash+0x3b8/0x930 net/ipv4/udp.c:1979
> >  udp_hashslot include/net/udp.h:85 [inline]
> >  udp_lib_unhash+0x3b8/0x930 net/ipv4/udp.c:1979
> >  sk_common_release+0xaf/0x3f0 net/core/sock.c:3820
> >  inet_release+0x1e0/0x260 net/ipv4/af_inet.c:437
> >  inet6_release+0x6f/0xd0 net/ipv6/af_inet6.c:489
> >  __sock_release net/socket.c:658 [inline]
> >  sock_release+0xa0/0x210 net/socket.c:686
> >  cleanup_bearer+0x42d/0x4c0 net/tipc/udp_media.c:819
> >  process_one_work kernel/workqueue.c:3229 [inline]
> >  process_scheduled_works+0xcaf/0x1c90 kernel/workqueue.c:3310
> >  worker_thread+0xf6c/0x1510 kernel/workqueue.c:3391
> >  kthread+0x531/0x6b0 kernel/kthread.c:389
> >  ret_from_fork+0x60/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
> >
> > Uninit was created at:
> >  slab_free_hook mm/slub.c:2269 [inline]
> >  slab_free mm/slub.c:4580 [inline]
> >  kmem_cache_free+0x207/0xc40 mm/slub.c:4682
> >  net_free net/core/net_namespace.c:454 [inline]
> >  cleanup_net+0x16f2/0x19d0 net/core/net_namespace.c:647
> >  process_one_work kernel/workqueue.c:3229 [inline]
> >  process_scheduled_works+0xcaf/0x1c90 kernel/workqueue.c:3310
> >  worker_thread+0xf6c/0x1510 kernel/workqueue.c:3391
> >  kthread+0x531/0x6b0 kernel/kthread.c:389
> >  ret_from_fork+0x60/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
> >
> > CPU: 0 UID: 0 PID: 54 Comm: kworker/0:2 Not tainted 6.12.0-rc1-00131-gf66ebf37d69c #7 91723d6f74857f70725e1583cba3cf4adc716cfa
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > Workqueue: events cleanup_bearer
> >
> > Fixes: 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns of kernel sockets.")
> > Reported-by: syzkaller <syzkaller@googlegroups.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > ---
> > v2:
> >   * Keep kernel socket with no net refcnt.
> >
> > v1: https://lore.kernel.org/netdev/20241126061446.64052-1-kuniyu@amazon.com/
> > ---
> >  net/tipc/udp_media.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
> > index 439f75539977..b7e25e7e9933 100644
> > --- a/net/tipc/udp_media.c
> > +++ b/net/tipc/udp_media.c
> > @@ -814,10 +814,10 @@ static void cleanup_bearer(struct work_struct *work)
> >                 kfree_rcu(rcast, rcu);
> >         }
> >
> > -       atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
> >         dst_cache_destroy(&ub->rcast.dst_cache);
> >         udp_tunnel_sock_release(ub->ubsock);
> >         synchronize_net();
> > +       atomic_dec(&tipc_net(sock_net(ub->ubsock->sk))->wq_count);
> 
> Note that ub->ubsock->sk is NULL at this point.
> 

Also udp_tunnel_sock_release() releases ub->ubsock so Smatch complains if
you have the cross function database.

regards,
dan carpenter


