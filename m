Return-Path: <netdev+bounces-212828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A74F5B22331
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 11:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A58423520
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 09:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE472E92AC;
	Tue, 12 Aug 2025 09:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XEl1EThw"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833D02E8DE7
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754990840; cv=none; b=bYJbjR/ggsbsZeouqxBZnlAadm3FRaH1r7sAOnN2M3NDi50cuyi5EUvOPfZo3hmmrk7xzlStAQf884QG49kaq3rcE8+cdRPxu15vw7fbhAXFNWcAHsm6oxUQJk+YDOsWF0ka6BrH8hL6sO50MskZHZXeHLJ5l6dSK8+BRG5EXyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754990840; c=relaxed/simple;
	bh=Hun7Pj2QeIThbWWcEnI4efZAqJOfJrOaDsvmrUO0zJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/GNCcYtFvEtkX0IZwtwWRcHb3xhrcnNKGzmIndNnCe1xR2boIpMFSEaT+8zr7UaUVT54EL4joO0TMEBs4a+bWCqSMznseXLabWyXGJ1Et1Fv3RjwvZKL1Pe/4Mo14e6WiOOVdKZ6GZVHc94LePQRz32ZYY16OHHFA3xu22Oqlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XEl1EThw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754990837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WGp9+izCkrlBj+bCsKQsfK68CmTdIqz5MvXVpGGtKI8=;
	b=XEl1EThw6sbEQeHZcfewwYxnaktxCxWmrWKCqBfeiMgg1jMzu74gTrhKYxN6tjhwkvrwtl
	Dsa+lz1CGwG8rATHL22RYRDrxD4gjZgT9mf9ufp8Jsx8WVLSCgyoTr1+K7wRd1xPExHHnk
	MGSRTroBJMraoW3pA2humMlHEVrUzhE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685--b3vxRgPOGS3Pj9KEPP7Jg-1; Tue, 12 Aug 2025 05:27:16 -0400
X-MC-Unique: -b3vxRgPOGS3Pj9KEPP7Jg-1
X-Mimecast-MFC-AGG-ID: -b3vxRgPOGS3Pj9KEPP7Jg_1754990835
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3b785aee904so2458928f8f.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 02:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754990834; x=1755595634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGp9+izCkrlBj+bCsKQsfK68CmTdIqz5MvXVpGGtKI8=;
        b=OAN04XGSY+Kk4bD3Dy4FE07W0KAC6832/mSh02JZl+4kV3tH2YpvV5jCh9DjcKBULZ
         g6XU3MryhyWOd8Yu+L4rGAvfW+bNkfvHTEY5vUA5SMC1oI7cPDZUcvgn9eIzyZOoeeJJ
         B3WL2JtH8M2LCUGwruKU2bHQlfRMAKysjVA5Mkt+bl0cpL8v7t73vER/tOQc4WXVo7t6
         TJqhDzH2rQKyG4ZPE15G13whh5N8t2c0hZ0i1DgsSnzGDIQRrNuGFMMues6C3Zpgs/vd
         XZ8a1Ps3vdLUXLus+ggu0r2OMLWt9OQx8t9snzJzxWKbR4xxnGGQWk4LZxBes0HifIs0
         Y4QA==
X-Forwarded-Encrypted: i=1; AJvYcCWi0jEbIHdcz/h++otgJURQWZgRgMdy/xjF1t2kb0jVolJOR4TzFjYEpFDUv216mMxhUgOegSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfPbvgBVMKXAaCo/RqTU/Vp0Tgxa0J3DKrYAfnm/Vd2V6u+rk6
	dTbWVjx9aUsf3JX0jzO+ggHg9F97tody77vDL3O6G+YkZICAOnQ/2oljwUkewUEhtnLLgQ7gtuO
	Y/SK993oTQZkjMPk+bCtbo7SQKFyMfxaOdynlFcOmkWfA9Z1T9coDoplI8A==
X-Gm-Gg: ASbGncuHFmIkrugbyC/x2tkhNPtVGOQXwrZtHTLuwBik3MAzeP6QcPjz3mkLioDq+KY
	C1TljdzmKszIbfNx1okxQcgjQzIQZkePEK+waJHUQljTTSwoLcG4iS47VqCghbZNubwcLR4HOKD
	Xs18B6Ne3QchhxkIpYUYgDi+298ynPXM7p3Tlsvd7Jol4TaAQBw3Ntv9gziVu/u2ymnynESex2k
	jPF1NoYNgSI1Q6pkX+ngthrnvtBXWL5MiH41h8Js2lAvkpesjscm9BQb4jWmwQ3xiugwQF/lvgA
	cLkidEROiQleWzhaThfsXfwn4/iYkmqD
X-Received: by 2002:a5d:64cd:0:b0:3a4:f70e:abda with SMTP id ffacd0b85a97d-3b910fce9a8mr2143729f8f.10.1754990833558;
        Tue, 12 Aug 2025 02:27:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFkY9FzWL94KYJ81gviv0bWbapS/YWsGTjYnmEpZTu+fpeDhGDEmVz6ELyY1r99MnE6tNX6Q==
X-Received: by 2002:a5d:64cd:0:b0:3a4:f70e:abda with SMTP id ffacd0b85a97d-3b910fce9a8mr2143685f8f.10.1754990832925;
        Tue, 12 Aug 2025 02:27:12 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1515:7300:62e6:253a:2a96:5e3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3c4d02sm42398517f8f.33.2025.08.12.02.27.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 02:27:12 -0700 (PDT)
Date: Tue, 12 Aug 2025 05:27:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: syzbot <syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, edumazet@google.com, eperezma@redhat.com,
	horms@kernel.org, jasowang@redhat.com, kuba@kernel.org,
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, sgarzare@redhat.com,
	stefanha@redhat.com, syzkaller-bugs@googlegroups.com,
	virtualization@lists.linux.dev, xuanzhuo@linux.alibaba.com
Subject: Re: [syzbot] [kvm?] [net?] [virt?] WARNING in
 virtio_transport_send_pkt_info
Message-ID: <20250812052645-mutt-send-email-mst@kernel.org>
References: <689a3d92.050a0220.7f033.00ff.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <689a3d92.050a0220.7f033.00ff.GAE@google.com>

On Mon, Aug 11, 2025 at 11:59:30AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    37816488247d Merge tag 'net-6.17-rc1' of git://git.kernel...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=10b3b2f0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e143c1cd9dadd720
> dashboard link: https://syzkaller.appspot.com/bug?extid=b4d960daf7a3c7c2b7b1
> compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f0f042580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14855434580000
> 
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-37816488.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/74b3ac8946d4/vmlinux-37816488.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/a2b391aacaec/bzImage-37816488.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b4d960daf7a3c7c2b7b1@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> 'send_pkt()' returns 0, but 65536 expected
> WARNING: CPU: 0 PID: 5503 at net/vmw_vsock/virtio_transport_common.c:428 virtio_transport_send_pkt_info+0xd11/0xf00 net/vmw_vsock/virtio_transport_common.c:426
> Modules linked in:
> CPU: 0 UID: 0 PID: 5503 Comm: syz.0.17 Not tainted 6.16.0-syzkaller-12063-g37816488247d #0 PREEMPT(full) 
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> RIP: 0010:virtio_transport_send_pkt_info+0xd11/0xf00 net/vmw_vsock/virtio_transport_common.c:426
> Code: 0f 0b 90 bd f2 ff ff ff eb bc e8 8a 20 65 f6 c6 05 94 cf 32 04 01 90 48 c7 c7 00 c3 b8 8c 44 89 f6 4c 89 ea e8 40 af 28 f6 90 <0f> 0b 90 90 e9 e1 fe ff ff e8 61 20 65 f6 90 0f 0b 90 e9 c5 f7 ff
> RSP: 0018:ffffc900027ff530 EFLAGS: 00010246
> RAX: d7fcdfc663889c00 RBX: 0000000000010000 RCX: ffff888000e1a440
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000002
> RBP: ffffffff8f8764d0 R08: ffff88801fc24253 R09: 1ffff11003f8484a
> R10: dffffc0000000000 R11: ffffed1003f8484b R12: dffffc0000000000
> R13: 0000000000010000 R14: 0000000000000000 R15: ffff888058b48024
> FS:  000055556bda1500(0000) GS:ffff88808d218000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000020000003f000 CR3: 000000003f6db000 CR4: 0000000000352ef0
> Call Trace:
>  <TASK>
>  virtio_transport_stream_enqueue net/vmw_vsock/virtio_transport_common.c:1111 [inline]
>  virtio_transport_seqpacket_enqueue+0x143/0x1c0 net/vmw_vsock/virtio_transport_common.c:839
>  vsock_connectible_sendmsg+0xac7/0x1050 net/vmw_vsock/af_vsock.c:2140
>  sock_sendmsg_nosec net/socket.c:714 [inline]
>  __sock_sendmsg+0x21c/0x270 net/socket.c:729
>  ____sys_sendmsg+0x52d/0x830 net/socket.c:2614
>  ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
>  __sys_sendmmsg+0x227/0x430 net/socket.c:2757
>  __do_sys_sendmmsg net/socket.c:2784 [inline]
>  __se_sys_sendmmsg net/socket.c:2781 [inline]
>  __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2781
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fddc238ebe9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd48081028 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
> RAX: ffffffffffffffda RBX: 00007fddc25b5fa0 RCX: 00007fddc238ebe9
> RDX: 0000000000000001 RSI: 0000200000000100 RDI: 0000000000000004
> RBP: 00007fddc2411e19 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000024008094 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fddc25b5fa0 R14: 00007fddc25b5fa0 R15: 0000000000000004
>  </TASK>
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.


#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 6693731487a8145a9b039bc983d77edc47693855


> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


