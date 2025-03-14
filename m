Return-Path: <netdev+bounces-174837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F51A60E7C
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 11:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47C901B60AB6
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 10:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33941F12E7;
	Fri, 14 Mar 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hui0RsCL"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5025726AFC
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741947209; cv=none; b=F50BXtA36UVmlXTiQ7znQDSIGtU2nKKX2Ov45wnbXKWwgCFKARqR8o+CTnVy1LYIBHVu5CDa7nQAIdUNKsFs/NiMmgArUX2iXkGPhX/MrX9t1LEy6DC3fujEF/dRxdV07pNN+6RVBPucjUncYHYSU2hxyJw8XWjK5yB7vFZGr7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741947209; c=relaxed/simple;
	bh=3fLWeHLKHrb18Uy/MS3QJBRi1rm/wOaI7DMw2a8UkqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=px9xPCma2LRLz05Zsj1E7fJWdrMGV7+Fs8hBLsNbQed+ZRmGuUpd4e74NCtGlvBwUqGi3fmJQQC7QH2Ln7iG0HCZ0MVdrNoV2IjLA58mYyexYMSZziVLM6iF4MbtCfWKejyZoQ77M/mtzj4TeaRV/5BO4juV4FjSXzQAJiy0MAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hui0RsCL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741947207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SPd+EnkY0Li2mTO/GP70bxnkH1XCMqHnQAmmracRGtI=;
	b=hui0RsCLXrGu0G7zqLYhtgvrcDYAesZiooZ6iceleb/RzBG+99WWziCuOHcKEKPyXLPZZC
	6v5KL5+nu2v8R52fCT1IecOjA8ZRlsSoAk7qBVcfvFFckebY1V6YsFS26HNuUXPpKbjYqE
	sSEAI9qoXXN2SDFCWgUW05calS+4KBk=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-ORIaH1zoPSydUGwtXsdQVg-1; Fri, 14 Mar 2025 06:13:26 -0400
X-MC-Unique: ORIaH1zoPSydUGwtXsdQVg-1
X-Mimecast-MFC-AGG-ID: ORIaH1zoPSydUGwtXsdQVg_1741947205
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ac27d8ac365so156519366b.2
        for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 03:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741947205; x=1742552005;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SPd+EnkY0Li2mTO/GP70bxnkH1XCMqHnQAmmracRGtI=;
        b=HcS6LUE1AG9OnAOKVzHiLF9Om1OnFYdI6wXAPm6A6qoCoOJqHZBXE2nhb2f3fOPmgC
         uJYm/otwuOeFXRQ+xZBeNssiCr9pDjVvLFmRkgs3ywURLBhk75HxilaxaXfZIRLz/WrJ
         24q4ixYqpr3ga1nXn41lJMlYTE4Fj0mlJ8D4A6uidzPnLoXhGMZQkyNSi7BjaEtOodWl
         x+/ENhCoUCIh6pfFmdRR9Bfh/m3QPxutgPEVsFL+zJFqkuBu/eeGBhAINs3yb844ITjC
         shcNw8igBcNNAzEKxGMUpFrlP5dWB94hKhg4EVHFh4hO17w/FCxIBU5iADiKS/NWb+4Z
         jpWg==
X-Forwarded-Encrypted: i=1; AJvYcCUbl7tzG+lEVg32dibRsASFKlyBa+5n1tNwbSfFVak7A8BsVsAaE/IwA+74/tWO9zGjAwlYSzE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxChHLhVBiGGsnPrMMCZbIZ/kSukZ726RMPzeY3xFoUyM6CmA2
	TCLwizBv23vhwT+XVsAO37t7dFmcNmEqfq+wisk5lGhYwDbnWXT7Gtv/RsWvCU6FL+/HSgefc4p
	E0Gt0AsFj/LYf3S0hMWlsi7tFGX556c+Ncg6PI65mK3xfYifhMDHKqA==
X-Gm-Gg: ASbGnctl3CIuVTK0zqUyPP5b3qrVOMM2vG1tf/YXGH5nAe6PwhFUQXl+0qUYdtiw3pF
	iF6VzB4wGU7l4uKo8U4H40pzKilu6u8bSWSOUjuQ8yPohot5SDflkDBVj3bWn7vNblKV3n7w0KX
	R0RKeUf+X73VKck9Xw55TreocWxX8eeNDrz/MkkXCqb3iT5dpTZzKJRSiNmOpcPlU3WOwU1ZqLL
	mXlRW8s8b/1LfbaMms7W0QSdfPf64wY1MBbB+WbN5E2cCfyPboWsUuhhunANJbfSN8sAQFX1AQi
	f+PJRAgmt0Tr
X-Received: by 2002:a17:907:7d87:b0:ac3:26fb:f420 with SMTP id a640c23a62f3a-ac3303715c9mr200509266b.42.1741947204949;
        Fri, 14 Mar 2025 03:13:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFSV3Kxn90NGxgDHQH3cs1oxAKHVeo2b8VKgG0w+cX9fVNQ1pDU9yg6oVegNwiT56KvNkO8iQ==
X-Received: by 2002:a17:907:7d87:b0:ac3:26fb:f420 with SMTP id a640c23a62f3a-ac3303715c9mr200503466b.42.1741947204252;
        Fri, 14 Mar 2025 03:13:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3146aeb5asm204715966b.36.2025.03.14.03.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Mar 2025 03:13:23 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 27E5218FA934; Fri, 14 Mar 2025 11:13:15 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Wang Liang <wangliang74@huawei.com>, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, joamaki@gmail.com
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 wangliang74@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] bonding: check xdp prog when set bond mode
In-Reply-To: <20250314073549.1030998-1-wangliang74@huawei.com>
References: <20250314073549.1030998-1-wangliang74@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 14 Mar 2025 11:13:15 +0100
Message-ID: <87y0x7rkck.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Wang Liang <wangliang74@huawei.com> writes:

> Following operations can trigger a warning[1]:
>
>     ip netns add ns1
>     ip netns exec ns1 ip link add bond0 type bond mode balance-rr
>     ip netns exec ns1 ip link set dev bond0 xdp obj af_xdp_kern.o sec xdp
>     ip netns exec ns1 ip link set bond0 type bond mode broadcast
>     ip netns del ns1
>
> When delete the namespace, dev_xdp_uninstall() is called to remove xdp
> program on bond dev, and bond_xdp_set() will check the bond mode. If bond
> mode is changed after attaching xdp program, the warning may occur.
>
> Some bond modes (broadcast, etc.) do not support native xdp. Set bond mode
> with xdp program attached is not good. Add check for xdp program when set
> bond mode.
>
>     [1]
>     ------------[ cut here ]------------
>     WARNING: CPU: 0 PID: 11 at net/core/dev.c:9912 unregister_netdevice_many_notify+0x8d9/0x930
>     Modules linked in:
>     CPU: 0 UID: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.14.0-rc4 #107
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>     Workqueue: netns cleanup_net
>     RIP: 0010:unregister_netdevice_many_notify+0x8d9/0x930
>     Code: 00 00 48 c7 c6 6f e3 a2 82 48 c7 c7 d0 b3 96 82 e8 9c 10 3e ...
>     RSP: 0018:ffffc90000063d80 EFLAGS: 00000282
>     RAX: 00000000ffffffa1 RBX: ffff888004959000 RCX: 00000000ffffdfff
>     RDX: 0000000000000000 RSI: 00000000ffffffea RDI: ffffc90000063b48
>     RBP: ffffc90000063e28 R08: ffffffff82d39b28 R09: 0000000000009ffb
>     R10: 0000000000000175 R11: ffffffff82d09b40 R12: ffff8880049598e8
>     R13: 0000000000000001 R14: dead000000000100 R15: ffffc90000045000
>     FS:  0000000000000000(0000) GS:ffff888007a00000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 000000000d406b60 CR3: 000000000483e000 CR4: 00000000000006f0
>     Call Trace:
>      <TASK>
>      ? __warn+0x83/0x130
>      ? unregister_netdevice_many_notify+0x8d9/0x930
>      ? report_bug+0x18e/0x1a0
>      ? handle_bug+0x54/0x90
>      ? exc_invalid_op+0x18/0x70
>      ? asm_exc_invalid_op+0x1a/0x20
>      ? unregister_netdevice_many_notify+0x8d9/0x930
>      ? bond_net_exit_batch_rtnl+0x5c/0x90
>      cleanup_net+0x237/0x3d0
>      process_one_work+0x163/0x390
>      worker_thread+0x293/0x3b0
>      ? __pfx_worker_thread+0x10/0x10
>      kthread+0xec/0x1e0
>      ? __pfx_kthread+0x10/0x10
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork+0x2f/0x50
>      ? __pfx_kthread+0x10/0x10
>      ret_from_fork_asm+0x1a/0x30
>      </TASK>
>     ---[ end trace 0000000000000000 ]---
>
> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  drivers/net/bonding/bond_options.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/bonding/bond_options.c b/drivers/net/bonding/bond_options.c
> index 327b6ecdc77e..127181866829 100644
> --- a/drivers/net/bonding/bond_options.c
> +++ b/drivers/net/bonding/bond_options.c
> @@ -868,6 +868,9 @@ static bool bond_set_xfrm_features(struct bonding *bond)
>  static int bond_option_mode_set(struct bonding *bond,
>  				const struct bond_opt_value *newval)
>  {
> +	if (bond->xdp_prog)
> +		return -EOPNOTSUPP;
> +

Should we allow changing as long as the new mode also supports XDP?

-Toke


