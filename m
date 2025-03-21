Return-Path: <netdev+bounces-176707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF380A6B8A7
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 11:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62FC5176F22
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 10:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3111F891F;
	Fri, 21 Mar 2025 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DC2/hy3+"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03491F3B8F
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742552411; cv=none; b=grbH098aYAvdjqasyPKDKfY1pbKeTF3TUtKohN3MdHDFUYnXLIAAvlTSNRPFyRsqYhyMqwvgUHhX2YLMy7IeMohYOh5u+l+34pzHF61xnASygSweZ9tgRWePGe3LdXF79dFrh9ZzZ3ewV2HcKlbavkHzVBnv32tkvUfvHAUgHak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742552411; c=relaxed/simple;
	bh=Suk0xQQ6qUfn6EWLHmfFDq7yYLJzPObHnBiaNlBJKM8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fafO4NKbIebYVjv2kLeW8/XZX/cGppt5ILUNfAzA791nqAMTAqpM9b6q1Mv4AioYjLBbcMW7VAi0XxoGMe15frjd7ABIsuJe8LFy639ipnQg50dRswfP+IDecBxN1XV3cPIQrNSVuqBqzBofKzxYNkVL5WEy1pYEQh2gRWjpHX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DC2/hy3+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742552408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7veLovhLal0NkTM3AjRtUJ/dyI3RmOm6dSAIJoOWgjw=;
	b=DC2/hy3+Cg4SIIKk8icoo5giy+8PH8QY/1pyEgB9kKhvA3SA/kI70uCRBZbJReIX4qvxJA
	ol9w26astOvrfW2BNrtx64lYaWTy7vmaKQr7E384CmEHqTgDWYYOxHEXCq+lUqXxXfQzzg
	ZhTKilkY3aGNIRJzK1psvr1i9VpWPFE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-yOQYpYpxPYONxw2swuuwng-1; Fri, 21 Mar 2025 06:20:07 -0400
X-MC-Unique: yOQYpYpxPYONxw2swuuwng-1
X-Mimecast-MFC-AGG-ID: yOQYpYpxPYONxw2swuuwng_1742552406
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-543bb2be3dcso909507e87.2
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 03:20:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742552405; x=1743157205;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7veLovhLal0NkTM3AjRtUJ/dyI3RmOm6dSAIJoOWgjw=;
        b=bK3Kp2LzExa/cROeeCJW4PxRrjY3j3Vu4/pBl25vG5zlu4sW7tJzey7rjRz6lXEK+H
         bkzxyKL0GMFNgojGG5q9chdgul59HdSnzQ1U5hyiyALlRF+ZlOcMsWTS/ZWl29hQ237Q
         1OlNOLygbDKtnXzMnZCFgOjnuoh2LpmN3imsnJdg3j3D/g2Ki/sQmyiu9T3W/Lekrkj9
         jD6zs37w/jSRIzE9ZQnYKD5SGAYyNS+kH4uz7HhOB0zbMGxsVKTcuNm8h85aQuTyQeYn
         E+sPBJI+TIjBGuVqRWlShsC3a3zzdZvY4pbogCwYmBMHl9hyQIR0uM80IJGmUEGPgRaw
         oS2g==
X-Forwarded-Encrypted: i=1; AJvYcCX2QI1doDkV6Fh/KCow9db7tLMLpqgLjVMUxicZ0Ca17J8tU3F7NoMCG4+iX6fpCjIpC55AG+0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyc4AfkCwLzFvnZW+unmQ1IzRcZunlZAi07JhckIv6+st9w67NE
	9jsYIbIcdox79BJ/+YwOIUAS9or0isGdb4tHqOT/h2YbzxF/CiS8kFJTX0Rr5bMdcZTnz53Ortp
	gL6aOnw9L5gYcJq8yTgAfpD5SfNPfx1cvtZVmy4zOS7ZLoCFONooO1A==
X-Gm-Gg: ASbGnctpW1HSG8VQn4s1fbZ7LUYccVgyUIsseMQMMbP8MEP1uAEk+LUHQQNL7MKJluG
	AaHeCktCLwkP0YoR5wI7rC5bgWnRc9323yMwvO7WDp7ouDgcs9ZDPk/SVx6cJpjd0SDVr3jAXfq
	l2EnS8Rpp/k73/enRU4qzIkJXWIHTn1KUIIs4AfeYVrKJNj7hFMeFzcuVekcRu60cwguBm3zOMV
	QX8eXB9QVr1PrIH5hY9V+pNjrYB3jNs7++uaFdYod0bm8NLo03KSgoHo3Rqo0kP6VvR7JL/Ct13
	LRvR6Z/YgTyT
X-Received: by 2002:a05:6512:3ca8:b0:549:4ac4:a453 with SMTP id 2adb3069b0e04-54ad649aa74mr889728e87.21.1742552405451;
        Fri, 21 Mar 2025 03:20:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvHhPccNe0c6J/mZFH5uVmTCME8gO38sU17cMCB7lJEF+xy0NAMXBJEw/T9kJQe9rCVUj9+A==
X-Received: by 2002:a05:6512:3ca8:b0:549:4ac4:a453 with SMTP id 2adb3069b0e04-54ad649aa74mr889702e87.21.1742552404976;
        Fri, 21 Mar 2025 03:20:04 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54ad64fbe5esm146601e87.157.2025.03.21.03.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 03:20:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4AEFC18FC4FA; Fri, 21 Mar 2025 11:20:01 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Wang Liang <wangliang74@huawei.com>, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 joamaki@gmail.com
Cc: yuehaibing@huawei.com, zhangchangzhong@huawei.com,
 wangliang74@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v2] bonding: check xdp prog when set bond mode
In-Reply-To: <20250321044852.1086551-1-wangliang74@huawei.com>
References: <20250321044852.1086551-1-wangliang74@huawei.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 21 Mar 2025 11:20:01 +0100
Message-ID: <87iko2it2m.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

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
>     WARNING: CPU: 0 PID: 11 at net/core/dev.c:9912 unregister_netdevice_m=
any_notify+0x8d9/0x930
>     Modules linked in:
>     CPU: 0 UID: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.14.0-rc4 #107
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.15.=
0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
>     Workqueue: netns cleanup_net
>     RIP: 0010:unregister_netdevice_many_notify+0x8d9/0x930
>     Code: 00 00 48 c7 c6 6f e3 a2 82 48 c7 c7 d0 b3 96 82 e8 9c 10 3e ...
>     RSP: 0018:ffffc90000063d80 EFLAGS: 00000282
>     RAX: 00000000ffffffa1 RBX: ffff888004959000 RCX: 00000000ffffdfff
>     RDX: 0000000000000000 RSI: 00000000ffffffea RDI: ffffc90000063b48
>     RBP: ffffc90000063e28 R08: ffffffff82d39b28 R09: 0000000000009ffb
>     R10: 0000000000000175 R11: ffffffff82d09b40 R12: ffff8880049598e8
>     R13: 0000000000000001 R14: dead000000000100 R15: ffffc90000045000
>     FS:  0000000000000000(0000) GS:ffff888007a00000(0000) knlGS:000000000=
0000000
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
> Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver=
")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


