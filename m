Return-Path: <netdev+bounces-162447-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99393A26EFD
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 11:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A6897A2544
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:03:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FEA20967F;
	Tue,  4 Feb 2025 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M9FquosY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A582080E5
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 10:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738663463; cv=none; b=MooPqPqPeupU3/rN0/VoV3UepbjYIUTnrncRpSUF3GsD58kxW2kyIStWsgvfGs53qvRW605MGz41H2LwV3t0TqYDlug6PSlWjWyZFcOy+MX9Bo5ePWPLC7TynZxHaXuDe1drlFRp9AvVnesLted+o31uJmHGirmKG7CkMWmknhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738663463; c=relaxed/simple;
	bh=mUDPToLx4m1t4OQh7RaNx1yOyqPbXSxV/uwU5GCkTBY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MdjmT6kEyG664Q+/urFUY0WNTIti2YXtVuVN0VxR9hUoAN0x17ClPOJl8MUcrHWsuKv7rkvcOLY+srz/rrfxuf6+FSGOopJ2hsgu8SoKLxJdNGgV5cJPVnBQTyP/IUJQ1xDVvnj8OjGVrqQ1jpOWP1tEIiofnTGi9CGOD7ZD/VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M9FquosY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738663460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r7QifqPZ9eDjVzOXnGpRwU072WD973YhoUOHzvFP/XY=;
	b=M9FquosYi9QQY/jH06O6IG/48gOVXq2nk3kv4o9RyHWAG6tNYoqynjiuEDCnnLf4hfqB4i
	mIvixgvDJKd2rqAWHxmAZpc2uI+J1vcLTnzH9mbaC1BVt4AiUcQ+5tx7n4fI0UD9Fcj/vl
	w/tsn3W3R3/pGmbPTGWt/Uw1dd39pps=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-bbG-TiCUMPCR5MR3vPLxHw-1; Tue, 04 Feb 2025 05:04:19 -0500
X-MC-Unique: bbG-TiCUMPCR5MR3vPLxHw-1
X-Mimecast-MFC-AGG-ID: bbG-TiCUMPCR5MR3vPLxHw
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-6f6f2db824bso50151887b3.3
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 02:04:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738663457; x=1739268257;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7QifqPZ9eDjVzOXnGpRwU072WD973YhoUOHzvFP/XY=;
        b=jcJRx0xPjzXcEHnPYKfmTgOXuSSU+0fi8pTHMsuxCBbb6WK2qnyR0TJ/NjDaVhwwqL
         +yAg/RyJDRYdg4OEAzDFaM44Y52DmMxlWqdU4huu+fxTr8jK0DSCEJ4zm5QjY7Q0V0zs
         F+Bcafc97HbSAzJ6gbltuVibRyRfSt9WZsHBkZADeS+Eh2HCX3ivR6kCU8G5eBKAzPd+
         wEEXlu/aBRcKAso+2EYDgTGLDBdwJsEVfnQ7FNfd2DsS0drg5wpI0cTJKMIp7vonXHT/
         anmRPbwgJ7SJQgLCXw3WCR1c9a7ZG4xE0vu1AMBudW1SnJF/d/EdNo96fFb3dH1hzyMr
         KUMw==
X-Forwarded-Encrypted: i=1; AJvYcCWzv1cCJY2wA24bgVREBEsSxUHCGWEzXOWOxrn3y2PatOHYLcuXlYeHhSIomvCXpsv+R24HQnk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYwq6IPW5l4Z6yhXwT6B0brcLf27OU1j6Jmb8m1PLkLOE2gbtl
	49NIpblQbMqWNTrQJj/vaVBMpKSeOFppFE6Tk6o7thbbqHdFDdQag2xJX1gY2lE7GruZr2skE3p
	YYsdWlbvunYMrwac8bW0T3PjHjqBwdG6i8jSivKjIPOVVkhfxbSntVLaq6cQm+J2bHC7WsUTWxU
	eTf9ynpmzwhgUiExYAz5QOmOVjVW7v
X-Gm-Gg: ASbGncvUw+1k6aKgDc25m2B3myIX3oerLjtrDsC9IzjI6zdejQiINubVBbtoQg6/6SR
	TIn4phIJMKNmpG477Gibpuq13nQcCXm/O5R9N61jb/zcXwyEE+HzHrw4TXtM8JZM=
X-Received: by 2002:a05:690c:c99:b0:6f6:7ef2:fe74 with SMTP id 00721157ae682-6f7a8426a5dmr187992807b3.32.1738663457127;
        Tue, 04 Feb 2025 02:04:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGObxnJlWUNYcPLXX3gTTHlz8ygcPRSBCSw4ZNWGPq56uQbjLmdeK3NSXxsGvATRJ7AZmu/F90tI28ywSsg0b4=
X-Received: by 2002:a05:690c:c99:b0:6f6:7ef2:fe74 with SMTP id
 00721157ae682-6f7a8426a5dmr187992617b3.32.1738663456785; Tue, 04 Feb 2025
 02:04:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67a09300.050a0220.d7c5a.008b.GAE@google.com> <2483d8c1-961e-4a7f-9ce7-ffd21a380c70@rbox.co>
 <6fonjxxkozzmv7huzavck5nsfivx3nsyyicthulg5aiyrmjpql@o7pexllumdxt>
In-Reply-To: <6fonjxxkozzmv7huzavck5nsfivx3nsyyicthulg5aiyrmjpql@o7pexllumdxt>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Tue, 4 Feb 2025 11:04:04 +0100
X-Gm-Features: AWEUYZkRpQsQ3lL4HaavFbVzIcqyxyzO3RF8AiDQcOZb6x_hIpX856jwrL1eacs
Message-ID: <CAGxU2F7CgVHUuPPATBzXw20fR1Z+MVpsJvgRO=kMFV1nis49SQ@mail.gmail.com>
Subject: Re: [syzbot] [net?] general protection fault in add_wait_queue
To: Michal Luczaj <mhal@rbox.co>
Cc: syzbot <syzbot+9d55b199192a4be7d02c@syzkaller.appspotmail.com>, 
	davem@davemloft.net, edumazet@google.com, eperezma@redhat.com, 
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefanha@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 4 Feb 2025 at 10:59, Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Tue, Feb 04, 2025 at 01:38:50AM +0100, Michal Luczaj wrote:
> >On 2/3/25 10:57, syzbot wrote:
> >> Hello,
> >>
> >> syzbot found the following issue on:
> >>
> >> HEAD commit:    c2933b2befe2 Merge tag 'net-6.14-rc1' of git://git.kernel...
> >> git tree:       net-next
> >> console output: https://syzkaller.appspot.com/x/log.txt?x=16f676b0580000
> >> kernel config:  https://syzkaller.appspot.com/x/.config?x=d033b14aeef39158
> >> dashboard link: https://syzkaller.appspot.com/bug?extid=9d55b199192a4be7d02c
> >> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> >> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13300b24580000
> >> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12418518580000
> >>
> >> Downloadable assets:
> >> disk image: https://storage.googleapis.com/syzbot-assets/c7667ae12603/disk-c2933b2b.raw.xz
> >> vmlinux: https://storage.googleapis.com/syzbot-assets/944ca63002c1/vmlinux-c2933b2b.xz
> >> kernel image: https://storage.googleapis.com/syzbot-assets/30748115bf0b/bzImage-c2933b2b.xz
> >>
> >> The issue was bisected to:
> >>
> >> commit fcdd2242c0231032fc84e1404315c245ae56322a
> >> Author: Michal Luczaj <mhal@rbox.co>
> >> Date:   Tue Jan 28 13:15:27 2025 +0000
> >>
> >>     vsock: Keep the binding until socket destruction
> >
> >syzbot is correct (thanks), bisected commit introduced a regression.
> >
> >sock_orphan(sk) is being called without taking into consideration that it
> >does `sk->sk_wq = NULL`. Later, if SO_LINGER is set, sk->sk_wq gets
> >dereferenced in virtio_transport_wait_close().
> >
> >Repro, as shown by syzbot, is simply
> >from socket import *
> >lis = socket(AF_VSOCK, SOCK_STREAM)
> >lis.bind((1, 1234)) # VMADDR_CID_LOCAL
> >lis.listen()
> >s = socket(AF_VSOCK, SOCK_STREAM)
> >s.setsockopt(SOL_SOCKET, SO_LINGER, (1<<32) | 1)
> >s.connect(lis.getsockname())
> >s.close()
> >
> >A way of fixing this is to put sock_orphan(sk) back where it was before the
> >breaking patch and instead explicitly flip just the SOCK_DEAD bit, i.e.
> >
> >diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> >index 075695173648..06250bb9afe2 100644
> >--- a/net/vmw_vsock/af_vsock.c
> >+++ b/net/vmw_vsock/af_vsock.c
> >@@ -824,13 +824,14 @@ static void __vsock_release(struct sock *sk, int level)
> >        */
> >       lock_sock_nested(sk, level);
> >
> >-      sock_orphan(sk);
> >+      sock_set_flag(sk, SOCK_DEAD);
> >
> >       if (vsk->transport)
> >               vsk->transport->release(vsk);
> >       else if (sock_type_connectible(sk->sk_type))
> >               vsock_remove_sock(vsk);
> >
> >+      sock_orphan(sk);
> >       sk->sk_shutdown = SHUTDOWN_MASK;
> >
> >       skb_queue_purge(&sk->sk_receive_queue);
> >
> >I'm not sure this is the most elegant code (sock_orphan(sk) sets SOCK_DEAD
> >on a socket that is already SOCK_DEAD), but here it goes:
> >https://lore.kernel.org/netdev/20250204-vsock-linger-nullderef-v1-0-6eb1760fa93e@rbox.co/
>
> What about the fix proposed here:
> https://lore.kernel.org/lkml/20250203124959.114591-1-aha310510@gmail.com/

mmm, nope, that one will completely bypass the lingering, right?

Stefano

>
> >
> >One more note: man socket(7) says lingering also happens on shutdown().
> >Should vsock follow that?
>
> Good point, I think so.
> IMHO we should handle both of them in af_vsock.c if it's possible, but
> maybe we need a bit of refactoring.
>
> Anyway, net-next material, right?
>
> Stefano


