Return-Path: <netdev+bounces-156565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677F6A07021
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 09:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6237A195B
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 08:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75B9214218;
	Thu,  9 Jan 2025 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ag+LV3Z4"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76081FDA
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736411607; cv=none; b=cQIbt+cBRu7KJpUnV/QdJhevpFGEDcRBiL5wpfh8J7hMCwv7IuW0DbNoUVnODZapSK0qmvRltZ7o6RzHs50yt66AkAitCJJGL6pHgbZt0BBgLfLNtF2WbD9NDjz55uCDtpUd5PnCiWHv4ITv0gaW0po3jouRoUPZNoOaRGsXS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736411607; c=relaxed/simple;
	bh=gNHm1ZRWd6QZ3EhHhcH7DAjavJAkn9sWeqtF5IZenuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NXPMVRvgh8VTKpnm+juUlDCM58UZ73JEsRn66yiX/Ggu4et4WBU84c0e4ruspuPwYItWdroqmk5gjPFJEYfel8tCYY9aVoxrtM7mKcLb6NkCAP+6TFS2LDX7xm9eJPnHU9+uzq4QQ3R78yrPUHoZPGNJs4T8x5IQsIKbeMZAUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ag+LV3Z4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736411604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uqRP5f1dFunit71HPNsUwkwx3/dTBxrPG9UiLsklLDM=;
	b=Ag+LV3Z4XvTqxdr/ll5Mlg7+mduAwho2uEdHr60Mjo9Q9YX0cAvVrpgb4jns/sifBeKJe4
	cE8y1AhwBUVsWZzMcMq/ap62zPNRVNTM3m3vWIerAdxK5SQTImwmMNHFkqrJgoTh2wADnq
	QPFhJInm4DQFO+5VwQx6CvNiQwUbWpM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-18-XHzw3ZmyPOWTLEMwuUiS-w-1; Thu, 09 Jan 2025 03:33:23 -0500
X-MC-Unique: XHzw3ZmyPOWTLEMwuUiS-w-1
X-Mimecast-MFC-AGG-ID: XHzw3ZmyPOWTLEMwuUiS-w
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4359206e1e4so5265775e9.2
        for <netdev@vger.kernel.org>; Thu, 09 Jan 2025 00:33:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736411602; x=1737016402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uqRP5f1dFunit71HPNsUwkwx3/dTBxrPG9UiLsklLDM=;
        b=mvI5CvSKplSVmP2sSHsGZKdDC/Vl/ptI58BW5Ug1614N2Us+1StjZsHHf+urZBadF6
         n/fC939oZt23JEvRObN3qfGesIfSGcaKMYa77aKKqTvIbs4tjFwmxeGlh1ygDpAMDruQ
         93BXrdzRP15R0MCwG43xvPdXZjRZqR7nuiMrHWuyvKcfTe19GgEpr012UvHrjPmljtlq
         44DWgF5AQdQnvjXDDN4B+GYoLebBO3Fssv/N8wjfcvOQlMrnVIUc8B3FS8REcFVatv7Z
         DjMI4IAkPL81ZQ1DRrKvwfKVVuoilRZj4g3phuOolAhU1+Ryp/egM9Is7nUDRgbjkd7L
         SyFg==
X-Forwarded-Encrypted: i=1; AJvYcCVNgkEPP666PnWjAQlrhmF4wa3++x4hamTo30sAxrkHgpR7m/kzUASsUt29kDh2klwp58sEVow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZAqijsxPuIvkpAU6Vo09xTROmJ5ZY6BKNI+NRrZR/qcmwlm+I
	lc5VtM4qJx0tZ+dn+OMcINv1AQdalHBa0hLyCpehOlDBLT27eG2ACFLwsI5v0nWGBnMqHwY5XIf
	S3BbAuWaVGuwSreY1clbU+oT3Uo8upxogeLIgg7UQmyEB06oZgVt1Vw==
X-Gm-Gg: ASbGncsjoH9w9r1VinQxaExi6y4DKNZ9kJB4aTCyaHlTZyGkdcZCT5E1i8gy8pJBB4I
	CiWQvTkmcJX9k59r692V8ziNV0FTySyaJt8aduLH5BGj+le7pZRVh6ZdUdb+uf3f28XlbwzJmEN
	eCfzvCWvwILRsdMV4DYyjlHvi5AlAoMMQWU2krYeJSTFf8dHTMlLI/R5MK8TJ046ZpFLuxSZjtE
	ZsObTy0USnFNXUYxGI4hSMkQRuyqhhYcs5AOtI0S6On5+96ndPFUbodXt4=
X-Received: by 2002:a5d:6d02:0:b0:38a:50f7:24fa with SMTP id ffacd0b85a97d-38a87357a07mr5310618f8f.54.1736411602086;
        Thu, 09 Jan 2025 00:33:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk1MDrg8tu6jB97ExyCN1fqiiCxS8wPYxwQC29oBrKPhm516/evymAwLslSjLurHxQbye5HA==
X-Received: by 2002:a5d:6d02:0:b0:38a:50f7:24fa with SMTP id ffacd0b85a97d-38a87357a07mr5310558f8f.54.1736411601434;
        Thu, 09 Jan 2025 00:33:21 -0800 (PST)
Received: from sgarzare-redhat ([5.77.115.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38332asm1136441f8f.23.2025.01.09.00.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 00:33:20 -0800 (PST)
Date: Thu, 9 Jan 2025 09:33:14 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: syzbot <syzbot+3affdbfc986ecd9200fd@syzkaller.appspotmail.com>
Cc: cong.wang@bytedance.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, mst@redhat.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	virtualization@lists.linux.dev
Subject: Re: [syzbot] [virt?] [net?] general protection fault in
 vsock_connectible_has_data
Message-ID: <a4n77w3u22efhdnyz5xn5gjvsfq7xncy3lyn32xqobnuw6gb27@kxubdyn4hr2q>
References: <677f84a8.050a0220.25a300.01b3.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <677f84a8.050a0220.25a300.01b3.GAE@google.com>

On Thu, Jan 09, 2025 at 12:11:20AM -0800, syzbot wrote:
>Hello,
>
>syzbot found the following issue on:
>
>HEAD commit:    8ce4f287524c net: libwx: fix firmware mailbox abnormal ret..
>git tree:       net
>console+strace: https://syzkaller.appspot.com/x/log.txt?x=13f06edf980000
>kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
>dashboard link: https://syzkaller.appspot.com/bug?extid=3affdbfc986ecd9200fd
>compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15695418580000
>C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124c56f8580000
>
>Downloadable assets:
>disk image: https://storage.googleapis.com/syzbot-assets/e09bf4b8939b/disk-8ce4f287.raw.xz
>vmlinux: https://storage.googleapis.com/syzbot-assets/f7f7846f83db/vmlinux-8ce4f287.xz
>kernel image: https://storage.googleapis.com/syzbot-assets/44540dea47ac/bzImage-8ce4f287.xz
>
>The issue was bisected to:
>
>commit 69139d2919dd4aa9a553c8245e7c63e82613e3fc
>Author: Cong Wang <cong.wang@bytedance.com>
>Date:   Mon Aug 12 02:21:53 2024 +0000
>
>    vsock: fix recursive ->recvmsg calls
>
>bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=116bc4b0580000
>final oops:     https://syzkaller.appspot.com/x/report.txt?x=136bc4b0580000
>console output: https://syzkaller.appspot.com/x/log.txt?x=156bc4b0580000
>
>IMPORTANT: if you fix the issue, please add the following tag to the commit:
>Reported-by: syzbot+3affdbfc986ecd9200fd@syzkaller.appspotmail.com
>Fixes: 69139d2919dd ("vsock: fix recursive ->recvmsg calls")
>
>Oops: general protection fault, probably for non-canonical address 0xdffffc0000000014: 0000 [#1] PREEMPT SMP KASAN PTI
>KASAN: null-ptr-deref in range [0x00000000000000a0-0x00000000000000a7]
>CPU: 1 UID: 0 PID: 5828 Comm: syz-executor976 Not tainted 6.13.0-rc5-syzkaller-00142-g8ce4f287524c #0
>Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
>RIP: 0010:vsock_connectible_has_data+0x85/0x100 net/vmw_vsock/af_vsock.c:882
>Code: 80 3c 38 00 74 08 48 89 df e8 e7 e0 5f f6 48 8b 1b 66 83 fd 05 75 3a e8 d9 78 f9 f5 48 81 c3 a0 00 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 bc e0 5f f6 4c 8b 1b 4c 89 f7 41
>RSP: 0018:ffffc900015976f8 EFLAGS: 00010206
>RAX: 0000000000000014 RBX: 00000000000000a0 RCX: ffff888033e09e00
>RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000005
>RBP: 0000000000000005 R08: ffffffff8ba5fadc R09: 1ffffffff285492b
>R10: dffffc0000000000 R11: fffffbfff285492c R12: 0000000000002000
>R13: dffffc0000000000 R14: ffff888033e18000 R15: dffffc0000000000
>FS:  00005555565ca380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 00000000200061c8 CR3: 0000000074f74000 CR4: 00000000003526f0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>Call Trace:
> <TASK>
> vsock_has_data net/vmw_vsock/vsock_bpf.c:30 [inline]
> vsock_bpf_recvmsg+0x4b5/0x10a0 net/vmw_vsock/vsock_bpf.c:87
> sock_recvmsg_nosec net/socket.c:1033 [inline]
> sock_recvmsg+0x22f/0x280 net/socket.c:1055
> ____sys_recvmsg+0x1c6/0x480 net/socket.c:2803
> ___sys_recvmsg net/socket.c:2845 [inline]
> do_recvmmsg+0x426/0xab0 net/socket.c:2940
> __sys_recvmmsg net/socket.c:3014 [inline]
> __do_sys_recvmmsg net/socket.c:3037 [inline]
> __se_sys_recvmmsg net/socket.c:3030 [inline]
> __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3030
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x77/0x7f
>RIP: 0033:0x7fb38b2465e9
>Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
>RSP: 002b:00007fffd43f6938 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
>RAX: ffffffffffffffda RBX: 00007fffd43f6b08 RCX: 00007fb38b2465e9
>RDX: 0000000000000001 RSI: 00000000200061c0 RDI: 0000000000000003
>RBP: 00007fb38b2b9610 R08: 0000000000000000 R09: 00007fffd43f6b08
>R10: 0000000000002000 R11: 0000000000000246 R12: 0000000000000001
>R13: 00007fffd43f6af8 R14: 0000000000000001 R15: 0000000000000001
> </TASK>
>Modules linked in:
>---[ end trace 0000000000000000 ]---
>RIP: 0010:vsock_connectible_has_data+0x85/0x100 net/vmw_vsock/af_vsock.c:882
>Code: 80 3c 38 00 74 08 48 89 df e8 e7 e0 5f f6 48 8b 1b 66 83 fd 05 75 3a e8 d9 78 f9 f5 48 81 c3 a0 00 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 38 00 74 08 48 89 df e8 bc e0 5f f6 4c 8b 1b 4c 89 f7 41
>RSP: 0018:ffffc900015976f8 EFLAGS: 00010206
>RAX: 0000000000000014 RBX: 00000000000000a0 RCX: ffff888033e09e00
>RDX: 0000000000000000 RSI: 0000000000000005 RDI: 0000000000000005
>RBP: 0000000000000005 R08: ffffffff8ba5fadc R09: 1ffffffff285492b
>R10: dffffc0000000000 R11: fffffbfff285492c R12: 0000000000002000
>R13: dffffc0000000000 R14: ffff888033e18000 R15: dffffc0000000000
>FS:  00005555565ca380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
>CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>CR2: 000000000066c7e0 CR3: 0000000074f74000 CR4: 00000000003526f0
>DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>----------------
>Code disassembly (best guess):
>   0:	80 3c 38 00          	cmpb   $0x0,(%rax,%rdi,1)
>   4:	74 08                	je     0xe
>   6:	48 89 df             	mov    %rbx,%rdi
>   9:	e8 e7 e0 5f f6       	call   0xf65fe0f5
>   e:	48 8b 1b             	mov    (%rbx),%rbx
>  11:	66 83 fd 05          	cmp    $0x5,%bp
>  15:	75 3a                	jne    0x51
>  17:	e8 d9 78 f9 f5       	call   0xf5f978f5
>  1c:	48 81 c3 a0 00 00 00 	add    $0xa0,%rbx
>  23:	48 89 d8             	mov    %rbx,%rax
>  26:	48 c1 e8 03          	shr    $0x3,%rax
>* 2a:	42 80 3c 38 00       	cmpb   $0x0,(%rax,%r15,1) <-- trapping instruction
>  2f:	74 08                	je     0x39
>  31:	48 89 df             	mov    %rbx,%rdi
>  34:	e8 bc e0 5f f6       	call   0xf65fe0f5
>  39:	4c 8b 1b             	mov    (%rbx),%r11
>  3c:	4c 89 f7             	mov    %r14,%rdi
>  3f:	41                   	rex.B
>
>

This looks related to the same issue fixed by the patch I sent
yesterday: https://lore.kernel.org/netdev/20250108180617.154053-3-sgarzare@redhat.com/

I just pushed them on my fix-vsock-null-transport brach:

#syz test: https://github.com/stefano-garzarella/linux.git fix-vsock-null-transport


