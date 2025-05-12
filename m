Return-Path: <netdev+bounces-189910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B42F2AB4806
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 01:46:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D1371889608
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 23:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9006B2580DE;
	Mon, 12 May 2025 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WagK8K2G"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11F518DB2B
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 23:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747093606; cv=none; b=SlGMsDFvZ5Kta0fyyD1l04Vf4MINJDcgeKWVmJM6o6HwfZbfgDNu8jeqckw2gRze3SRPiEYb7/mejbRAYYnObox/q9rtF8S01QGUucSoJR6NAcuJN5RUeVF//9iHxHALXc1bp7hjXev9ZaeJ7yraSC1YlZDlQdFnMYj/mkC04sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747093606; c=relaxed/simple;
	bh=u+oAn2wzOvucslHSkzxHsoXqE0H6tcbkVPupnVZOK0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqUBJi9WC5qzicbe7ZRajLdz+juV/+Pg45fqPxV/gShQ3pB9iCRdXxVQKg6g23HoQQbWfrvk8RcdNbzWh4sYy48co+kWLBlq04ynyYs0JRv9nhpxN8uuA2Lv7zAfYhjUn+9zSqIauYhKqeTk+kz2hsE2PNDtQYrMAmQim0VPXeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WagK8K2G; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b03bc416962so3355287a12.0
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 16:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747093602; x=1747698402; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWf8frRqdlYzizlxRfvmRFmPk7K3INqJWq83RSx2n1I=;
        b=WagK8K2GYP5t5aKoKgixaupf3jxcFFbvlZTOmjiLKrcE7GByq6s2wwaQOZBBWz456b
         3/0eQuLrxAAqGLuTT/QzVqEPetPiKsVNVCedzJnEAAqY3Je3KWo9KAVthnfe8hvPhush
         mcc6Awb62KWKh0Cd0qI8tJG2AFRW3ERgeNWekcEnHBF7QGE3B6/LNpERdicl72RfVBZ9
         v7NbW5PgYf984RkX+JodcKaNzwX9maY6Hc1h9EjjdY2JfwK5Y/M5IBCUhSiXcD4y0Kgz
         TwsYyGyrK4ZwVewyjcjFWfIodU7p8gP5D+6IKXrydcEGMdR3AUCHcVr275eALMCyxHnN
         WhuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747093602; x=1747698402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWf8frRqdlYzizlxRfvmRFmPk7K3INqJWq83RSx2n1I=;
        b=kFzPO30q8zqbna38ucxNdsXDKAdeKmj/dI9J6KjLZfp/PwVooHC6uJaP1kSGgbh9C/
         jzsyvbwCtu/F+X4wnvIcxmtXNcxi9faihFqVMhcQboL269Nbge9jHX2XSD/EPYG84hSw
         oO/7pnRF70bM25FbLEhnzW6t20CILziHQBZ8ptkPQIwVCuTUY2mL0ebVRrysXbMO1bwT
         2hwHJKWdYOWNwBX/fD05bEGuba7kKfJnTlRHyjU6ohizgxNqjTEHbV2ia6b3EFhcDigo
         vwAW6m71w8z3rs7JftXxLtGSLsacp+HRMcqJD4GSkVMtsHH1XOgEuQTDovAxFzECCIff
         TVhA==
X-Forwarded-Encrypted: i=1; AJvYcCXf+F/abYavfwU8dO6LNPcmVPDmNWm7Nj2Bk3ChFx9Dz9ZWstT5z3B4iQqN5obGZKYYi6e4d4M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywu9GvuQFmB5dVwEQQ7lDWojp7mlpcHehjAmoNVMI9enKnvP5Ec
	QdS047S3ocaQGyV2cJugX5MAA9NxtvlTjTp3LSkLAD1L35egpVc=
X-Gm-Gg: ASbGncvePiBF9DrPsKrVv3LLKBNOY1D6GzbZyx/JziZHkntYGzPkbFQD0YIp7JR9CTG
	q+uvK0l7ugnVlxTFSw2KJVEFJy3/8AMAuTk2v83xv7kVgm9aD0i1feGmN8z47COhemjwWEuegMS
	CDq3KehkI98SQeoWmjCi8mSslT4TWXG+mWF/QUtTvlJhlYhkeQ3J6L02pK1qzber1QuRmc/mSJk
	HPJCRxAy+t4qTsHKwZj8+BvFx4uhl5WE1Jf9ghxyqPxQgCdUHozcWCNf9pcRluBk5P4chXiXaoD
	+Gdi+6/5qwbqCMgzJ/5jVsE7EPsUMbU9fYrKDeTD2HBj5xWrkdX3CFNItmtKmEcINZ2z5RQJPVh
	XW/p1b5u0DOoE
X-Google-Smtp-Source: AGHT+IFT3HwUFTB6bGMje+Db0H6NaE5cAuoNO8oiO832VKhIya0gm7UyTXPUu3Bj2UWvW+BB7MIqrw==
X-Received: by 2002:a17:902:dacd:b0:22e:421b:49a9 with SMTP id d9443c01a7336-22fc8aff0ddmr189910175ad.2.1747093602116;
        Mon, 12 May 2025 16:46:42 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc75494ddsm68870085ad.25.2025.05.12.16.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 16:46:41 -0700 (PDT)
Date: Mon, 12 May 2025 16:46:40 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, almasrymina@google.com,
	sdf@fomichev.me, netdev@vger.kernel.org, asml.silence@gmail.com,
	dw@davidwei.uk, skhawaja@google.com, kaiyuanz@google.com,
	jdamato@fastly.com
Subject: Re: [PATCH net v4] net: devmem: fix kernel panic when netlink socket
 close after module unload
Message-ID: <aCKIYDwZlD1BD5KY@mini-arch>
References: <20250512084059.711037-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250512084059.711037-1-ap420073@gmail.com>

On 05/12, Taehee Yoo wrote:
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

Acked-by: Stanislav Fomichev <sdf@fomichev.me>

