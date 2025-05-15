Return-Path: <netdev+bounces-190764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5C9AB8A4B
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 17:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5701BC6AB1
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 15:07:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1627A1EFF93;
	Thu, 15 May 2025 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R+er7hAM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757141A5BAB
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 15:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747321650; cv=none; b=LBPUsfHRoHB4MSH5F8FkhgO4KjNb3C4hwx+X9soijK9aR8Uvt06xNR/9LBKjs41KXFH5UtODC65OQzKD8Fmz5nFE8y0gRVfgFZwz+8B/KQ3nOrG+fkqOr+FqHE8g7aJSEdii6FGcVFtG3WZDKPPXGvG2HBueN5UlyH1qECjM6Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747321650; c=relaxed/simple;
	bh=VuhbrxSp5v76jr74DWunte8ghzvyMeliSb4lJxWxJCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6duqg4bZa7w2McO5YoM4Lx3F+WdHVO0OHxrmwRotLpTMkze8I6d37yKGnHQ4rL6cxrErIP6+HtU+lECuNXgDtQo6W7+8RCFXrAhuLaE2G60wlzpdIsLFJLnqQQYQd/SnB15BFyz420AnUZW0UcdGgsDuUPAwNUJueEANFHxW+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R+er7hAM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22e7e5bce38so10351455ad.1
        for <netdev@vger.kernel.org>; Thu, 15 May 2025 08:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747321648; x=1747926448; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=x6oj7ezt9jvUhQfFHhzb0gtCHdhneDXF80OZSJ7C2Sg=;
        b=R+er7hAML/4eKTIJBYXBWoCPno0Fu/dQ+dEp9KnI6rGRxvmFKemkSIIz2jMT204m7r
         6cATl2/bDzu6r5PH55zUicIR7wuuzWjc+nW074lMBlyIwEukFT6XfCs23cn8UCkVMb+S
         +PGFVT/eQICwuCkvVMKG0W5cEI0EQ4Lkk3yesVYDUW6KoZCuAXSM0by+iCMlrmrNIi5/
         DXNrJcZmZ0uMe6SIro8rHPMQ9ts9m0WgY66OJk900YgcUl7eLjKDER/v+Q/ypJoqbAmp
         W0Rc7JWMZqmeUDBBT2j5rmINlopZt6YRcQ5ruJcdwm+Os8GT5N1kk3i6ZdI9stjzYD2B
         tZ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747321648; x=1747926448;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6oj7ezt9jvUhQfFHhzb0gtCHdhneDXF80OZSJ7C2Sg=;
        b=ibWVqA5/XfFEVYPb0pOLfrkbK2GebJ+gqVrrRFj1nYUB0FuvPb9Sl8DQbH4Hbh9O30
         4Kh49EFEx2sDGl4XZNGIIe6FXyzbxuo8lLk70v/bh337NY6cK+31KNN81owcgAbZU9dP
         b/q8v4IWjX24ELY+6rDskA+54NTASbwubJuZGvMSZjW4XrX1RlJLmcSlUYQ7lFEcoPU+
         MDXo7Sy69IBsMSD6eyd5dCPNHc2gVJqPjsla+HdHm+QBihMAEXmOFzn4rWsn88vNgkYj
         vpVvkUaHiLgEB8ifUFnEfzl2Epb4m3FeOO33zGoWEQGTNewoQcAdDOYLostBKfToohWB
         lAJg==
X-Forwarded-Encrypted: i=1; AJvYcCXcqvmR0d77wchAVaKZStBVqLS4yvm7tclvY/Pq/jIm5WAhaj7IM1MuPp4xLYwLTfJABDooMGs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywxw2dKEkw5Kmvxydwsf4GHHbZmSYekdhLpyHBR09kFgq7tdLRS
	89zDSSF7XtzKWSpxhlsfIBbgZM6YbirjrqaqP4iOGNqf/cnNhx5pT4CYYSY=
X-Gm-Gg: ASbGncvXAyGc5fyr/lRYxTYU43Rn2X/kb4V43mHF4MgMwrpcZbczsj5u11Hdufhmwad
	rUYQn83HHVdNkyRjZEh/FPxlUL9j6OlBWtjzQECCd6ccSVoQ6AZYLeGcKAIPkXz4ZrjP0LPRtMY
	cmQ5ojzN0DTxww5VPOt+K3jVjnSUqxb84XIfzQTlBDmLgZcJNQllPuPYGj5uWuEUh5oshYAjGIl
	bFCyrGcLLfT/Cgyb0+AZv0N78wo9LahcMfXdWmJX9OwyQDyJUF43nSJAnjOpJK9A+fMxNP6Pnx2
	hpW0MaPbVuuwTz1iKnj7Wi5yjlqZaeiKgn5OT+ZLGhP8+0MYwbNUgcCN8MN3DGemk2fy+Vsest9
	psgFtFqxrJ61y
X-Google-Smtp-Source: AGHT+IH32SZXJ7ZEk0pqmNo2w6JoH4A2+nJtX1zU1VhJ2RozLTdl3eFYPcBS2j9SzBVVxbnirm2W0Q==
X-Received: by 2002:a17:902:c952:b0:224:c76:5e57 with SMTP id d9443c01a7336-2319813e3f1mr112719915ad.39.1747321647595;
        Thu, 15 May 2025 08:07:27 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc8271ea0sm117455265ad.124.2025.05.15.08.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 May 2025 08:07:27 -0700 (PDT)
Date: Thu, 15 May 2025 08:07:25 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, almasrymina@google.com,
	sdf@fomichev.me, netdev@vger.kernel.org, asml.silence@gmail.com,
	dw@davidwei.uk, skhawaja@google.com, kaiyuanz@google.com,
	jdamato@fastly.com
Subject: Re: [PATCH net v5] net: devmem: fix kernel panic when netlink socket
 close after module unload
Message-ID: <aCYDLZ_C46pLRacy@mini-arch>
References: <20250514154028.1062909-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250514154028.1062909-1-ap420073@gmail.com>

On 05/14, Taehee Yoo wrote:
> Kernel panic occurs when a devmem TCP socket is closed after NIC module
> is unloaded.
> 
> This is Devmem TCP unregistration scenarios. number is an order.
> (a)netlink socket close    (b)pp destroy    (c)uninstall    result
> 1                          2                3               OK
> 1                          3                2               (d)Impossible
> 2                          1                3               OK
> 3                          1                2               (e)Kernel panic
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
>     pid=$!
>     sleep 10
>     kill $pid
>     ip link set $interface down
>     modprobe -rv $module
> 
> Scenario B:
>     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
>         -v 7 -t 1 -q 1 &
>     pid=$!
>     sleep 10
>     ip link set $interface down
>     kill $pid
>     modprobe -rv $module
> 
> Scenario C:
>     ./ncdevmem -s 192.168.1.4 -c 192.168.1.2 -f $interface -l -p 8000 \
>         -v 7 -t 1 -q 1 &
>     pid=$!
>     sleep 10
>     modprobe -rv $module
>     sleep 5
>     kill $pid
> 
> Splat looks like:
> Oops: general protection fault, probably for non-canonical address 0xdffffc001fffa9f7: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
> KASAN: probably user-memory-access in range [0x00000000fffd4fb8-0x00000000fffd4fbf]
> CPU: 0 UID: 0 PID: 2041 Comm: ncdevmem Tainted: G    B   W           6.15.0-rc1+ #2 PREEMPT(undef)  0947ec89efa0fd68838b78e36aa1617e97ff5d7f
> Tainted: [B]=BAD_PAGE, [W]=WARN
> RIP: 0010:__mutex_lock (./include/linux/sched.h:2244 kernel/locking/mutex.c:400 kernel/locking/mutex.c:443 kernel/locking/mutex.c:605 kernel/locking/mutex.c:746)
> Code: ea 03 80 3c 02 00 0f 85 4f 13 00 00 49 8b 1e 48 83 e3 f8 74 6a 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 34 48 89 fa 48 c1 ea 03 <0f> b6 f
> RSP: 0018:ffff88826f7ef730 EFLAGS: 00010203
> RAX: dffffc0000000000 RBX: 00000000fffd4f88 RCX: ffffffffaa9bc811
> RDX: 000000001fffa9f7 RSI: 0000000000000008 RDI: 00000000fffd4fbc
> RBP: ffff88826f7ef8b0 R08: 0000000000000000 R09: ffffed103e6aa1a4
> R10: 0000000000000007 R11: ffff88826f7ef442 R12: fffffbfff669f65e
> R13: ffff88812a830040 R14: ffff8881f3550d20 R15: 00000000fffd4f88
> FS:  0000000000000000(0000) GS:ffff888866c05000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000563bed0cb288 CR3: 00000001a7c98000 CR4: 00000000007506f0
> PKRU: 55555554
> Call Trace:
> <TASK>
>  ...
>  netdev_nl_sock_priv_destroy (net/core/netdev-genl.c:953 (discriminator 3))
>  genl_release (net/netlink/genetlink.c:653 net/netlink/genetlink.c:694 net/netlink/genetlink.c:705)
>  ...
>  netlink_release (net/netlink/af_netlink.c:737)
>  ...
>  __sock_release (net/socket.c:647)
>  sock_close (net/socket.c:1393)
> 
> Fixes: 1d22d3060b9b ("net: drop rtnl_lock for queue_mgmt operations")
> Signed-off-by: Taehee Yoo <ap420073@gmail.com>
> ---
> 
> v5:
>  - Remove cleanup changes.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

(looks mostly the same as v4, so should have been ok to carry over)

