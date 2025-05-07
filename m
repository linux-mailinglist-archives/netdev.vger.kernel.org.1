Return-Path: <netdev+bounces-188544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F06B0AAD464
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 06:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F0F4E72BB
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 04:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868101D63F5;
	Wed,  7 May 2025 04:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E17nBu63"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974201D61BC
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 04:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746591910; cv=none; b=PhvoAqOAyykj7c7pXZzKslWmMnKVmGfqZlDxEm6PmO/xM3FnVnK8DajRT63KRF06hSmVPc8rYpocS9zN49UTYyFc8Mk0RCbKawlrLz+Xnjr0J62BVq3Hr6ANiz6idQsOLcUbtkUTCRQQ8vhU3wDVg8kL3xS7hIzvgq6b/qXVwvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746591910; c=relaxed/simple;
	bh=mb2cmlbZCfBAqDPCZeIDiTAPBOGgt8/cnAWz231nv28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMozC4cE2EOiX/Pcpkn1Om+ptkIxrj6M94H4QTBUEu+GN+Mc/h1riGbzkxPEI4ujm/nZb4GJ0SRMKv2KNDstDTZPhlorPX189pvF1ZgtoRx02UfCHX/0qtVtBESwpSqscZpg7ptzyr6jz/8a9wKp6HkfFC/sxrh8OL8NmnXSPmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E17nBu63; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5f6222c6c4cso9527872a12.1
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 21:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746591907; x=1747196707; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6lWzG8dKexFpdnpq0HLuxvcCjazh84YNAGZlNzsjcnc=;
        b=E17nBu63xDdCr5wjJWxvL5sTOR597VF/UNlUvf9g8SDdGClp5JPMFh1B+rQY3vC9Rg
         LiMA6gW2a1B/+fhg2pIMkthKMRHZkpX/JjtDJmDSv6dxMCJubdAHqTwH6nuof1AVsVxt
         tlsdgDZ71tn2a1b8BFvsZUvZ/Nwn3FPqWgq8ZSwpuursaJC3JBid7Sng1WtuHCK1JOCb
         APAZnifcMJ8rJifGinHdKRnBVPE0HejrgiM63XVZhLDNn26eVAsPEcnXiWACT3MdXdf0
         9cYDRDvJBabquh8poMT7ijYhLm559hbUKwp5A+u5mPeCzk5NDKGV/aLSvz9xwB2PwGxI
         UmcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746591907; x=1747196707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6lWzG8dKexFpdnpq0HLuxvcCjazh84YNAGZlNzsjcnc=;
        b=WToHAVLV5M4ZDbHy+g1EI+4AZSR7CDgmklMkbM33Vs5+gPVJvVgRBAHRJ7kJUfLtv+
         pvaG57cddbAF/EIHmz1NFrSled7eUNILPIO12Hzj+kCyuRhsIAVZxt5+XMzwzc0ikU75
         oQifNcb8L8u3AfZMdFwdToJDTGY79cbPEu9CgYknaWOFUQ1QVfYQwpsKjy1I6vVnnq7a
         /SNTf8SPRhveIofWOX2YBYY643F0g38qxzV1jjUKDt+U+FQzad/mAIuO+IehtKsm3Zl/
         k3roJowvKf4UOFulcX1iPjP8YZWnNFUrDaOT4so9QYXou5Zfy3m+9fPocDpkH/tv1aBo
         WbyQ==
X-Forwarded-Encrypted: i=1; AJvYcCW3DxpjRcg2Hzds0Z3MjdUELUDHtH4HBOgE2q7CcH0R0lt6xBZEpSXc89QjR6hskUh1ltuUKuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXf/iQ3RvnV43WtHs91gjUCV9RdIrB5TsNNroKUlFI+vJd45f1
	Naj9nywO0KC8oWbK43yX1VDe9GC+/Bdw+dRWDqQl44au8fVJerc/SVzKeJ5GXKRiS1QGEumQ6IW
	6RQecMOIrfaA7zWwhP845N5nHTH0=
X-Gm-Gg: ASbGnctBeESKAlcP2Rueq6jmFIbpTltL2e2l+otiUd65hhVJufVH7Ji2l+UPlZXwwx3
	PN9Wliz2EwODsdlpyDO3o1dlfQswSlqYDb/ocjc8Wa2aMpm3Ow1kGeaZbCovsOz3PNhDUSRuow6
	Q1lpeN57Q+PMTEn/5U1Xz3Q4U=
X-Google-Smtp-Source: AGHT+IFXnOtbpWox/WU1+ZnC25Uim9oYjKL3qMvGxofeNE8XkNYAF1DAEzVVSXUybuqPKvSBT8wvwsBd9i9PglffrW4=
X-Received: by 2002:a05:6402:2548:b0:5f8:77e2:b819 with SMTP id
 4fb4d7f45d1cf-5fbe9f46cbdmr1476168a12.23.1746591906602; Tue, 06 May 2025
 21:25:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506140858.2660441-1-ap420073@gmail.com> <20250506150730.4ea4d66c@kernel.org>
In-Reply-To: <20250506150730.4ea4d66c@kernel.org>
From: Taehee Yoo <ap420073@gmail.com>
Date: Wed, 7 May 2025 13:24:55 +0900
X-Gm-Features: ATxdqUGjrcC0iHzlJzlA1sbjSiMijDGRT7Q5ULhe5pLDfC9_py6QXDtdAb-usyA
Message-ID: <CAMArcTV3xfOJ1-GoJriUyTAniPkAeSYYRTd85gxJc+nfiBce7w@mail.gmail.com>
Subject: Re: [PATCH net v2] net: devmem: fix kernel panic when socket close
 after module unload
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, 
	andrew+netdev@lunn.ch, horms@kernel.org, almasrymina@google.com, 
	sdf@fomichev.me, netdev@vger.kernel.org, asml.silence@gmail.com, 
	dw@davidwei.uk, skhawaja@google.com, willemb@google.com, jdamato@fastly.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 7:07=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wro=
te:
>

Hi Jakub,
Thanks a lot for the review!

> On Tue,  6 May 2025 14:08:58 +0000 Taehee Yoo wrote:
> > Kernel panic occurs when a devmem TCP socket is closed after NIC module
> > is unloaded.
> >
> > This is Devmem TCP unregistration scenarios. number is an order.
> > (a)socket close    (b)pp destroy    (c)uninstall    result
> > 1                  2                3               OK
> > 1                  3                2               (d)Impossible
> > 2                  1                3               OK
> > 3                  1                2               (e)Kernel panic
> > 2                  3                1               (d)Impossible
> > 3                  2                1               (d)Impossible
> >
> > (a) netdev_nl_sock_priv_destroy() is called when devmem TCP socket is
> >     closed.
> > (b) page_pool_destroy() is called when the interface is down.
> > (c) mp_ops->uninstall() is called when an interface is unregistered.
> > (d) There is no scenario in mp_ops->uninstall() is called before
> >     page_pool_destroy().
> >     Because unregister_netdevice_many_notify() closes interfaces first
> >     and then calls mp_ops->uninstall().
> > (e) netdev_nl_sock_priv_destroy() accesses struct net_device to acquire
> >     netdev_lock().
> >     But if the interface module has already been removed, net_device
> >     pointer is invalid, so it causes kernel panic.
> >
> > In summary, there are only 3 possible scenarios.
> >  A. sk close -> pp destroy -> uninstall.
> >  B. pp destroy -> sk close -> uninstall.
> >  C. pp destroy -> uninstall -> sk close.
> >
> > Case C is a kernel panic scenario.
> >
> > In order to fix this problem, It makes mp_dmabuf_devmem_uninstall() set
> > binding->dev to NULL.
> > It indicates an bound net_device was unregistered.
> >
> > It makes netdev_nl_sock_priv_destroy() do not acquire netdev_lock()
> > if binding->dev is NULL.
> >
> > It inverts socket/netdev lock order like below:
> >     netdev_lock();
> >     mutex_lock(&priv->lock);
> >     mutex_unlock(&priv->lock);
> >     netdev_unlock();
> >
> > Because of inversion of locking ordering, mp_dmabuf_devmem_uninstall()
> > acquires socket lock from now on.
> >
> > Tests:
> > Scenario A:
> >     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
> >         -v 7 -t 1 -q 1 &
> >     pid=3D$!
> >     sleep 10
> >     kill $pid
> >     ip link set $interface down
> >     modprobe -rv $module
> >
> > Scenario B:
> >     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
> >         -v 7 -t 1 -q 1 &
> >     pid=3D$!
> >     sleep 10
> >     ip link set $interface down
> >     kill $pid
> >     modprobe -rv $module
> >
> > Scenario C:
> >     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
> >         -v 7 -t 1 -q 1 &
> >     pid=3D$!
> >     sleep 10
> >     modprobe -rv $module
> >     sleep 5
> >     kill $pid
> >
> > Splat looks like:
> > Oops: general protection fault, probably for non-canonical address 0xdf=
fffc001fffa9f7: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> > KASAN: probably user-memory-access in range [0x00000000fffd4fb8-0x00000=
000fffd4fbf]
> > CPU: 0 UID: 0 PID: 2041 Comm: ncdevmem Tainted: G    B   W           6.=
15.0-rc1+ #2 PREEMPT(undef)  0947ec89efa0fd68838b78e36aa1617e97ff5d7f
> > Tainted: [B]=3DBAD_PAGE, [W]=3DWARN
> > RIP: 0010:__mutex_lock (./include/linux/sched.h:2244 kernel/locking/mut=
ex.c:400 kernel/locking/mutex.c:443 kernel/locking/mutex.c:605 kernel/locki=
ng/mutex.c:746)
> > Code: ea 03 80 3c 02 00 0f 85 4f 13 00 00 49 8b 1e 48 83 e3 f8 74 6a 48=
 b8 00 00 00 00 00 fc ff df 48 8d 7b 34 48 89 fa 48 c1 ea 03 <0f> b6 f
> > RSP: 0018:ffff88826f7ef730 EFLAGS: 00010203
> > RAX: dffffc0000000000 RBX: 00000000fffd4f88 RCX: ffffffffaa9bc811
> > RDX: 000000001fffa9f7 RSI: 0000000000000008 RDI: 00000000fffd4fbc
> > RBP: ffff88826f7ef8b0 R08: 0000000000000000 R09: ffffed103e6aa1a4
> > R10: 0000000000000007 R11: ffff88826f7ef442 R12: fffffbfff669f65e
> > R13: ffff88812a830040 R14: ffff8881f3550d20 R15: 00000000fffd4f88
> > FS:  0000000000000000(0000) GS:ffff888866c05000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000563bed0cb288 CR3: 00000001a7c98000 CR4: 00000000007506f0
> > PKRU: 55555554
> > Call Trace:
> > <TASK>
> >  ...
> >  netdev_nl_sock_priv_destroy (net/core/netdev-genl.c:953 (discriminator=
 3))
> >  genl_release (net/netlink/genetlink.c:653 net/netlink/genetlink.c:694 =
net/netlink/genetlink.c:705)
> >  ...
> >  netlink_release (net/netlink/af_netlink.c:737)
> >  ...
> >  __sock_release (net/socket.c:647)
> >  sock_close (net/socket.c:1393)
>
> I'll look at the code later today, but it will need a respin for sure:
>
> net/core/netdev-genl.c: In function =E2=80=98netdev_nl_bind_rx_doit=E2=80=
=99:
> net/core/netdev-genl.c:878:61: error: passing argument 3 of =E2=80=98net_=
devmem_bind_dmabuf=E2=80=99 from incompatible pointer type [-Werror=3Dincom=
patible-pointer-types]
>   878 |         binding =3D net_devmem_bind_dmabuf(netdev, dmabuf_fd, pri=
v, info->extack);
>       |                                                             ^~~~
>       |                                                             |
>       |                                                             struc=
t netdev_nl_sock *
> In file included from ../net/core/netdev-genl.c:16:
> net/core/devmem.h:133:48: note: expected =E2=80=98struct netlink_ext_ack =
*=E2=80=99 but argument is of type =E2=80=98struct netdev_nl_sock *=E2=80=
=99
>   133 |                        struct netlink_ext_ack *extack)
>       |                        ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
> net/core/netdev-genl.c:878:19: error: too many arguments to function =E2=
=80=98net_devmem_bind_dmabuf=E2=80=99
>   878 |         binding =3D net_devmem_bind_dmabuf(netdev, dmabuf_fd, pri=
v, info->extack);
>       |                   ^~~~~~~~~~~~~~~~~~~~~~
> In file included from ../net/core/netdev-genl.c:16:
> net/core/devmem.h:132:1: note: declared here
>   132 | net_devmem_bind_dmabuf(struct net_device *dev, unsigned int dmabu=
f_fd,
>       | ^~~~~~~~~~~~~~~~~~~~~~
>
> This is on the kunit build so guessing some compat was missed.

Ah, yes, I missed updating a prototype for the netmem disabled case
in the devmem.h
I will fix it in the next version!

Thanks a lot!
Taehee Yoo

