Return-Path: <netdev+bounces-182970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6D3A8A75B
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 20:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53C477A42FA
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 18:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D1123535B;
	Tue, 15 Apr 2025 18:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P8TLLvAI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8076B235348
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744743584; cv=none; b=NT2Chczeg9p2kLtRGXJbuuxmW+BiMQ7tnXNpyDkvjNMqlkDKbzvL3m+kGVAguIPhbDTgpah36PEfljbaQD7uIfy7T8XKIujs69iWztABTOCcJf5+7jm4sGPCEXwJYOArXca20lZ91NoY8+AR1vvS99rp0P7M6zXOv3napfKOjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744743584; c=relaxed/simple;
	bh=LViciyvOp4geuiDewDE8+XtOvlKmyZPVLRpoMWHTnpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faFrKsb1M5Fabd6oJAIUvaMk0D98eQ7fB4tSNKoSRwhIGpDRdEgCkHSW/lvyJ5DBpz1DaRTYYPAVKdefZf3t2eeqw0j2GP4Ka2tBHWvaMJGrmRS0HHTRmQAjWAL1gnaoFbc1GVbsXnBen17vopuBEQeRzvwQJZFfPtVU34veVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P8TLLvAI; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2279915e06eso64040485ad.1
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 11:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744743582; x=1745348382; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rYPIWNnQ47VdwUIgphoRIocPhIQF2vXGe+HYwcjcoGQ=;
        b=P8TLLvAIND52fZ8RKoal0XDneE7JbRA5kL5YedygqaVJUkr13ldoAmxWSLhZPdI5kB
         u3q8TUKohanHy7SE0gitMgbgT9g+VvP0zs6wlyena0o6L2dDKquxKCeijDFN1Ukn9I7Y
         Sku/GgtPWnHtFtcfzip/wSTIWsujNazljKhYMdWk/oLB1CX6FQl8ATj8a2SLq3XTG9ir
         9JUsA/Gc5P+AViITMAjDnKcXzFhHOg2uv63oFPUcWX1Q3HjuAs+QHvQIXvCSg/r7fcEz
         kxX6erRSzk3pXgdQixWPZweh5+YdWrzfGAJF2i4zjymmSzuqoItfbwNh8dD/IBjETx4l
         7MsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744743582; x=1745348382;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYPIWNnQ47VdwUIgphoRIocPhIQF2vXGe+HYwcjcoGQ=;
        b=Zz12oPjfg1lYOM3i4pL3BkMN6X9+6MerD8JEEWLsOeorauU6z8+ERBZfhfeUcoOR6M
         7NtUqyQbfSNtBqhjiGo6FZs6w7GaDsqTX+QfuQ+AyXG9eWFlZc+40zZyyoHipYS65+Q3
         NtpuJq7q9bYuKKimNUM37WdMDhMrTvktNVuMKq0OJ86MX01QzUa+JYuOYRZIP8T9fQDJ
         C3/GEk3aeTCr+Z0JNgP/eA1x/UE9NTIXzzlyKYTwlgmlSCQrJ1IXA5tyWe1eLa4MIHtf
         cRsZFjLHh+zSAKVTkEenAMf1W8AZ3YxCxspVjtAk/h92+zehEZ61LbW2t1nia4cAW4HJ
         DwLg==
X-Forwarded-Encrypted: i=1; AJvYcCXpv3Om9isz7cwQlQBWm4H3UwauwlLt7b4P82mGBFwTl/mkKJNVda6jHqqFaOb3MZ6mrz80V1g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBhlkw0VukltAYdXYdlJfvZqYiU9eplzCMOOb4rF78GCp8bGtB
	y9E/0M0v37UHprITUaOdj9xUqFFOTkq0/ekdEfqCk9u3H/gOhwU=
X-Gm-Gg: ASbGncs3ZaYd/8+r7eaxZXLMwu82v4NOByEvIJ800O4kbt3gka2wfnVhYXWviRem8t6
	axmmNbHFiX3DymPSAEn3X8BAMB7KoWDhI1mcFhswlS9R/VYv9aB0n7ZaBxBjZgQsxP0Whp9oOJr
	Pr9GBKy7cFS8QFoD+PgKOcHFmqAQhySpAAqBuIDTjjAcrhrrX+Rc0hSpF/tZzRbhxQiicdZ8xoQ
	W9DqXDMMRKssWr1PXhsYMlU02Wq2b/VZR7dooAeR3RF36Q+YJbRtJyHkMSrW8PBNJC7R6UJWvKz
	dgTypqIBE11jerplDjnDcfgh9MqbL6/pcw3w5Tu/yod81EQyzzA=
X-Google-Smtp-Source: AGHT+IHp7ohCyMtWWO4d0a44TooY1lpAjxvyFUjYHpI+w5Cfc0uXhyat0iSVP575D0MQ/jaGrFCL4g==
X-Received: by 2002:a17:902:e54b:b0:21f:85d0:828 with SMTP id d9443c01a7336-22c31abc38bmr3404185ad.41.1744743581717;
        Tue, 15 Apr 2025 11:59:41 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22ac7b8c62dsm121343225ad.95.2025.04.15.11.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 11:59:41 -0700 (PDT)
Date: Tue, 15 Apr 2025 11:59:40 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Taehee Yoo <ap420073@gmail.com>, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
	horms@kernel.org, asml.silence@gmail.com, dw@davidwei.uk,
	sdf@fomichev.me, skhawaja@google.com, simona.vetter@ffwll.ch,
	kaiyuanz@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: devmem: fix kernel panic when socket close
 after module unload
Message-ID: <Z_6snPXxWLmsNHL5@mini-arch>
References: <20250415092417.1437488-1-ap420073@gmail.com>
 <CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMrN4+UuoRy3zUS0-2KJGfUhRVxyeJHEn81VX=9TdjKcg@mail.gmail.com>

On 04/15, Mina Almasry wrote:
> On Tue, Apr 15, 2025 at 2:24 AM Taehee Yoo <ap420073@gmail.com> wrote:
> >
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
> > (e) netdev_nl_sock_priv_destroy() accesses struct net_device.
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
> > In order to fix this problem, it makes netdev_nl_sock_priv_destroy() do
> > nothing if a module is already removed.
> > The mp_ops->uninstall() handles these instead.
> >
> > The netdev_nl_sock_priv_destroy() iterates binding->list and releases
> > them all with net_devmem_unbind_dmabuf().
> > The net_devmem_unbind_dmabuf() has the below steps.
> > 1. Delete binding from a list.
> > 2. Call _net_mp_close_rxq() for all rxq's bound to a binding.
> > 3. Call net_devmem_dmabuf_binding_put() to release resources.
> >
> > The mp_ops->uninstall() doesn't need to call _net_mp_close_rxq() because
> > resources are already released properly when an interface is being down.
> >
> > From now on netdev_nl_sock_priv_destroy() will do nothing if a module
> > has been removed because all bindings are removed from a list by
> > mp_ops->uninstall().
> >
> > netdev_nl_sock_priv_destroy() internally sets mp_ops to NULL.
> > So mp_ops->uninstall has not been called if devmem TCP socket was
> > already closed.
> >
> > Tests:
> > Scenario A:
> >     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
> >         -v 7 -t 1 -q 1 &
> >     pid=$!
> >     sleep 10
> >     ip link set $interface down
> >     kill $pid
> >     modprobe -rv $module
> >
> > Scenario B:
> >     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
> >         -v 7 -t 1 -q 1 &
> >     pid=$!
> >     sleep 10
> >     ip link set $interface down
> >     kill $pid
> >     modprobe -rv $module
> >
> 
> Scenario A & B are exactly the same steps?
> 
> > Scenario C:
> >     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
> >         -v 7 -t 1 -q 1 &
> >     pid=$!
> >     sleep 10
> >     modprobe -rv $module
> >     sleep 5
> >     kill $pid
> >
> > Splat looks like:
> > Oops: general protection fault, probably for non-canonical address 0xdffffc001fffa9f7: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> > KASAN: probably user-memory-access in range [0x00000000fffd4fb8-0x00000000fffd4fbf]
> > CPU: 0 UID: 0 PID: 2041 Comm: ncdevmem Tainted: G    B   W           6.15.0-rc1+ #2 PREEMPT(undef)  0947ec89efa0fd68838b78e36aa1617e97ff5d7f
> > Tainted: [B]=BAD_PAGE, [W]=WARN
> > RIP: 0010:__mutex_lock (./include/linux/sched.h:2244 kernel/locking/mutex.c:400 kernel/locking/mutex.c:443 kernel/locking/mutex.c:605 kernel/locking/mutex.c:746)
> > Code: ea 03 80 3c 02 00 0f 85 4f 13 00 00 49 8b 1e 48 83 e3 f8 74 6a 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 34 48 89 fa 48 c1 ea 03 <0f> b6 f
> > RSP: 0018:ffff88826f7ef730 EFLAGS: 00010203
> > RAX: dffffc0000000000 RBX: 00000000fffd4f88 RCX: ffffffffaa9bc811
> > RDX: 000000001fffa9f7 RSI: 0000000000000008 RDI: 00000000fffd4fbc
> > RBP: ffff88826f7ef8b0 R08: 0000000000000000 R09: ffffed103e6aa1a4
> > R10: 0000000000000007 R11: ffff88826f7ef442 R12: fffffbfff669f65e
> > R13: ffff88812a830040 R14: ffff8881f3550d20 R15: 00000000fffd4f88
> > FS:  0000000000000000(0000) GS:ffff888866c05000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000563bed0cb288 CR3: 00000001a7c98000 CR4: 00000000007506f0
> > PKRU: 55555554
> > Call Trace:
> > <TASK>
> >  ...
> >  netdev_nl_sock_priv_destroy (net/core/netdev-genl.c:953 (discriminator 3))
> 
> Line 953 is:
> 
> netdev_lock(dev);
> 
> Which was introduced by:
> 
> commit 42f342387841 ("net: fix use-after-free in the
> netdev_nl_sock_priv_destroy()") and rolling back a few fixes, it's
> really introduced by commit 1d22d3060b9b ("net: drop rtnl_lock for
> queue_mgmt operations").
> 
> My first question, does this issue still reproduce if you remove the
> per netdev locking and go back to relying on rtnl_locking? Or do we
> crash somewhere else in net_devmem_unbind_dmabuf? If so, where?
> Looking through the rest of the unbinding code, it's not clear to me
> any of it actually uses dev, so it may just be the locking...
 
A proper fix, most likely, will involve resetting binding->dev to NULL
when the device is going away. Replacing rtnl with dev lock exposes the
fact that we can't assume that the binding->dev is still valid by
the time we do unbind.

