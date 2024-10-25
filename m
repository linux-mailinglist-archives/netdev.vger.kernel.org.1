Return-Path: <netdev+bounces-139013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A62A9AFCE5
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 10:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03710B214C8
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 08:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA76156F30;
	Fri, 25 Oct 2024 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XiO26t2i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511901AAE27
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 08:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729845918; cv=none; b=PK2VPtzLBG9GdH1Z3ZmhGk08VIH65N9YDgCcS1Bwtint5FvVmsmzKvriX4kplDHSesmWhP2VVPGBTdd5nvshXK48b3+Yst3Fi3PeM3neccjlOqRdZeLCG+/nVPe6dm1FCKUbj9DNuOszUEGJbcdTyhseMAisOa9NHgh/FZVRHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729845918; c=relaxed/simple;
	bh=XuBQGjZ5JOG6MI6CUFZOHw9E0PSTps7gQhy9H7RNdBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tL3EBTyFGSphANPRT4C8fy1FtyySQT563ftafQHFeIm9c1mBiF6kfYXMXl6GZE5kIwKXRgPbXkI2wL8mfqrHBWrTaLUUw5ZgnH005DFEFYduucCoHTRxx2rWE8rkklkRDVprqC209iGi+PXB8JeNxg0ZrcmMSUqJWU8CXFTyfew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XiO26t2i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729845915;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mhj6VqPM2VjHYMoW6p/lBQKC9GMLxj15xt9OEYJsl9I=;
	b=XiO26t2iN2L+Yfx9omtce20OApT/+dFxPpav03frAEfAtTLaC4KzW6u4yYzGqOSVNgW721
	y7AV9FCTdDs4gKlb/GJJH/fk4xEAvngX+9p0S1MFSOPgypIZgFVuVMd37FR2E4FzlcMeS2
	J6c3psqHJyvqaKkTQINdeP0NzTSWwc4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-kxMXtWuYMMKz3C91HNp9-g-1; Fri, 25 Oct 2024 04:45:13 -0400
X-MC-Unique: kxMXtWuYMMKz3C91HNp9-g-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7b144a054baso618062485a.0
        for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 01:45:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729845913; x=1730450713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhj6VqPM2VjHYMoW6p/lBQKC9GMLxj15xt9OEYJsl9I=;
        b=a2tDU2dwclL/OaPKQiaZlPh2xKn0lSdouhLBzL1vbXn1+mnB5UKXYOZqVVIRME7Mn3
         jHtswY8AX4o76ZLIJhjBhAWBVttTWCbOrCxQKlRgxFJwoUM+NyDHz26vdMLa/Tk7yKiZ
         pHwqopZP2hbORiMryWUXY8aCiFxSjc6wKEhThpvId27+dSaeeODsiN9ZQLuOoSBedBSd
         /4Omk+6gtdnsb2VpfGj1QXCGB9SaKxE48qmIAaDt8JkP+cYDEVMzVidXq6VEjFYaaSyv
         VLtVNo7P4r04E9la6kA0s4+41ryX3hzih58ToLlT18kW3CkXF/DO9mNqjwOHHWI1WeZk
         GgjA==
X-Forwarded-Encrypted: i=1; AJvYcCUXgNBkGOrbf4YihQTtwV1MSPQdIH8/FuuB4JJQuOtXAx+dO5+Ksm3KJrJ1ah6BwJcfC0r30gg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1MO8z0F3OgxCdnW0i6E8dbL4+aRQwCiwEWEfZ0SB/xprZrU0L
	Fbn3Uaju1Qg+Yx/cvLSmlgXLuuxCHtckt8ZduZjqNPX0mbRQfLrDhP6VdFMIKX6X5OO8VPiMzgh
	TNhs5kvtV9nMZoofls4kTLLK+7rk0AtZsrXwwa2Q37DLqLxFWF0yJAA==
X-Received: by 2002:a05:620a:198a:b0:7b1:4783:aa2 with SMTP id af79cd13be357-7b1865c79bemr699920485a.7.1729845913024;
        Fri, 25 Oct 2024 01:45:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa+1dfhcJC1eGAt2GZOLgNSzedWqpxn8NM3WyYhqUZ/YN5IhzfELtJw11IJr9h/YP3u/5+aw==
X-Received: by 2002:a05:620a:198a:b0:7b1:4783:aa2 with SMTP id af79cd13be357-7b1865c79bemr699917685a.7.1729845912633;
        Fri, 25 Oct 2024 01:45:12 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-231.retail.telecomitalia.it. [79.46.200.231])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d27a895sm35160185a.19.2024.10.25.01.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 01:45:12 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:45:06 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, syzbot <syzkaller@googlegroups.com>, 
	Ignat Korchagin <ignat@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH net-next] vsock: do not leave dangling sk pointer in
 vsock_create()
Message-ID: <ftgql72hggzafexvpfqxfkimf22joj2inlywipbajv6t3ekly4@yxotdtqqpdyv>
References: <20241022134819.1085254-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241022134819.1085254-1-edumazet@google.com>

On Tue, Oct 22, 2024 at 01:48:19PM +0000, Eric Dumazet wrote:
>syzbot was able to trigger the following warning after recent
>core network cleanup.
>
>On error vsock_create() frees the allocated sk object, but sock_init_data()
>has already attached it to the provided sock object.
>
>We must clear sock->sk to avoid possible use-after-free later.
>
>WARNING: CPU: 0 PID: 5282 at net/socket.c:1581 __sock_create+0x897/0x950 net/socket.c:1581
>Modules linked in:
>CPU: 0 UID: 0 PID: 5282 Comm: syz.2.43 Not tainted 6.12.0-rc2-syzkaller-00667-g53bac8330865 #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> RIP: 0010:__sock_create+0x897/0x950 net/socket.c:1581
>Code: 7f 06 01 65 48 8b 34 25 00 d8 03 00 48 81 c6 b0 08 00 00 48 c7 c7 60 0b 0d 8d e8 d4 9a 3c 02 e9 11 f8 ff ff e8 0a ab 0d f8 90 <0f> 0b 90 e9 82 fd ff ff 89 e9 80 e1 07 fe c1 38 c1 0f 8c c7 f8 ff
>RSP: 0018:ffffc9000394fda8 EFLAGS: 00010293
>RAX: ffffffff89873c46 RBX: ffff888079f3c818 RCX: ffff8880314b9e00
>RDX: 0000000000000000 RSI: 00000000ffffffed RDI: 0000000000000000
>RBP: ffffffff8d3337f0 R08: ffffffff8987384e R09: ffffffff8989473a
>R10: dffffc0000000000 R11: fffffbfff203a276 R12: 00000000ffffffed
>R13: ffff888079f3c8c0 R14: ffffffff898736e7 R15: dffffc0000000000
>FS:  00005555680ab500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 00007f22b11196d0 CR3: 00000000308c0000 CR4: 00000000003526f0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>Call Trace:
> <TASK>
>  sock_create net/socket.c:1632 [inline]
>  __sys_socket_create net/socket.c:1669 [inline]
>  __sys_socket+0x150/0x3c0 net/socket.c:1716
>  __do_sys_socket net/socket.c:1730 [inline]
>  __se_sys_socket net/socket.c:1728 [inline]
>  __x64_sys_socket+0x7a/0x90 net/socket.c:1728
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>RIP: 0033:0x7f22b117dff9
>Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
>RSP: 002b:00007fff56aec0e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000029
>RAX: ffffffffffffffda RBX: 00007f22b1335f80 RCX: 00007f22b117dff9
>RDX: 0000000000000000 RSI: 0000000000000002 RDI: 0000000000000028
>RBP: 00007f22b11f0296 R08: 0000000000000000 R09: 0000000000000000
>R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
>R13: 00007f22b1335f80 R14: 00007f22b1335f80 R15: 00000000000012dd
>
>Fixes: 48156296a08c ("net: warn, if pf->create does not clear sock->sk on error")
>Reported-by: syzbot <syzkaller@googlegroups.com>
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Ignat Korchagin <ignat@cloudflare.com>
>Cc: Kuniyuki Iwashima <kuniyu@amazon.com>
>---
> net/vmw_vsock/af_vsock.c | 1 +
> 1 file changed, 1 insertion(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 35681adedd9aaec3565495158f5342b8aa76c9bc..109b7a0bd0714c9a2d5c9dd58421e7e9344a8474 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2417,6 +2417,7 @@ static int vsock_create(struct net *net, struct socket *sock,
> 	if (sock->type == SOCK_DGRAM) {
> 		ret = vsock_assign_transport(vsk, NULL);
> 		if (ret < 0) {
>+			sock->sk = NULL;
> 			sock_put(sk);
> 			return ret;
> 		}
>-- 
>2.47.0.105.g07ac214952-goog
>
>


