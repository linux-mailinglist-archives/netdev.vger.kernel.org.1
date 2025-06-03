Return-Path: <netdev+bounces-194801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16864ACCA45
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 17:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2C9C3A1BB0
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 15:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C16D223C50D;
	Tue,  3 Jun 2025 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JDXuhQ+l"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE51D23C4E6
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 15:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748964979; cv=none; b=VDs6K+FAgAweZZ9hXtZ69uf72HljOltX2Zz0xFfxnHPQSz9BPL8cuWrOEctf6N5Bkg7LnHrBQsjgcBins7scGiNXGSsZf+dZeBGB3/214j1dOW1HTpIgOXWZt1MvCiPd15jINarM62hkMF3htnSPT+PVcTviqMED9NK986qe2zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748964979; c=relaxed/simple;
	bh=so5Cd5VO/ohDqiSM1PiA8yaYZigYUNqPmXEXIixW9MQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WvqRSP6BtMCbMoXrdOybsnGuOyHbRfS2BfSiob9krrQaVVw4FaLADwbPyV2KKDoHf+EBrCcdz3MkUxr3bhFUqN5VJ/2BUS0v8PGGl1+FgMQJvyXYyxHvNa3yI9r2ShKZ0Fzz3gzzNL2KaC+oajG9SWCGJ1h9mTnABcRSfSjT+MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JDXuhQ+l; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748964976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/LvaDhDxbF96xKIaUKjht39c2AE1OP7X/UE1kJNGLGU=;
	b=JDXuhQ+lRB8SCGPuxzTFMqguyn6PwLcgegOEoeYo+3NM/83uCj8ridM5itACfmfktx24Nd
	CODmVtXbr0wY+yQ0eRdqgJgpeSiVrylpEQhKOgaBmD6/QjukwWp8Mb3RZ0irpSRYBQqlGS
	0HZidPqXBBLInNgpzoco8OvMLspMt1M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-13-11szy76QMqa6Usfo8bq_Sw-1; Tue, 03 Jun 2025 11:36:15 -0400
X-MC-Unique: 11szy76QMqa6Usfo8bq_Sw-1
X-Mimecast-MFC-AGG-ID: 11szy76QMqa6Usfo8bq_Sw_1748964974
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4f6e0c285so2783192f8f.0
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 08:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748964974; x=1749569774;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/LvaDhDxbF96xKIaUKjht39c2AE1OP7X/UE1kJNGLGU=;
        b=IBRDFAnLlWU2ALXV1QwbkgPCk1Cch0kLCzmSP23PAKWA+qvmCDpdXXA5mOgc83L2wG
         8EbVkOojmJlLWtTvJUgzCmjEHFVS+fpQCid1BqJmQLAsVY0qaYb/JVwqGdNEkSOx0a8x
         tmkc70X+92S9i3GjIlgLF2v18lS4iIhnyj29yI/V+p40x+TzuZMjnRak5hF+WlKf0W8X
         tIScc0N+ElL8hKu+2Lx8vygIyYdgiyVSSg9PYqKw4v5tDR5IWHFNx95/5sj+Ytnu6ANY
         cr6V2pzrxZ8UWss0YddxK9rKD7ReJDxspXya7hTJ8jJtsXtOqCnS3uWsuvOMrmWRq2mG
         T3Tw==
X-Forwarded-Encrypted: i=1; AJvYcCUDcGSNjq+kMzC929j7wfdNuuFjsJMNjfavb+AmbaPkOV+bVwoco43yuZztfgYm8eZxTmCHKr8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjqE6PNzoB2l5hZ+rBBTm7kW0NnlcxnFG8m4Ud+Z+EFASuLnO+
	CAxklQ84vZGamZPmKvKwIHUkRjf6pxTxa8M79pyNOGeEgmyc39i0yaHH+sCDf+iFGGeUMyYeC6A
	JDEqBnL82vjhJq+Mtx5Y5NoE+jBuRWJhRSksMBlC9mRH0Jb6DR0h2CQgLtQ==
X-Gm-Gg: ASbGnctC6pDYfCSquUjQ7pchxJ7M+87WQ3zmKZ88Bemi4b3eYl4PucTIF0nowVO9vMc
	fq77MSBxuoTsc4aLV5971QhGgjoNnyrY/CgNbFhWDJmL3HmV4p6+Tki42Cq3tZs6T4XxW/G2CzR
	1TH4M34CffgUfdfhJXS9ZBPt+IwVP0aTEyYwfmlKXfrldGF5UCnBR+/T86hrmAjXdFBoyV3nfXF
	FBPLdj3QJAZHQDq+y0MWJ5QO0Z8W7L3k+04uC8dNkZj9sNdNCTK6x+rUfDBi3Tp12QVBX539VV2
	KmO3gq8Gb27x7A1OWMo=
X-Received: by 2002:a05:6000:2c0f:b0:3a4:e6e7:3acd with SMTP id ffacd0b85a97d-3a4fe16a68cmr10464440f8f.18.1748964974415;
        Tue, 03 Jun 2025 08:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IElEymzG/EMNgRgbugoUUsqwa+rCR/+NQMtZ2sPmIuqTSEPZMFYrzKmWz2URs19s4oUNJJ5cQ==
X-Received: by 2002:a05:6000:2c0f:b0:3a4:e6e7:3acd with SMTP id ffacd0b85a97d-3a4fe16a68cmr10464410f8f.18.1748964973922;
        Tue, 03 Jun 2025 08:36:13 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cc2d:3210::f39? ([2a0d:3341:cc2d:3210::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c842sm18390715f8f.29.2025.06.03.08.36.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 08:36:13 -0700 (PDT)
Message-ID: <c5bc7d2e-6a2e-4d33-a5bc-14bd61be3a0c@redhat.com>
Date: Tue, 3 Jun 2025 17:36:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [net?] WARNING in ipmr_rules_exit (2)
To: syzbot <syzbot+a25af2d6c990a65eca95@syzkaller.appspotmail.com>,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <683f1551.050a0220.55ceb.0016.GAE@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <683f1551.050a0220.55ceb.0016.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/3/25 5:31 PM, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    342e4955a1f1 usb: usbtmc: Fix timeout value in get_stb
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=135a19f4580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=cc73a376913a3005
> dashboard link: https://syzkaller.appspot.com/bug?extid=a25af2d6c990a65eca95
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/3d4486b9330e/disk-342e4955.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/b0b416348409/vmlinux-342e4955.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/053a330bcf59/bzImage-342e4955.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a25af2d6c990a65eca95@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 13600 at net/ipv4/ipmr.c:440 ipmr_free_table net/ipv4/ipmr.c:440 [inline]
> WARNING: CPU: 0 PID: 13600 at net/ipv4/ipmr.c:440 ipmr_rules_exit+0x13a/0x1c0 net/ipv4/ipmr.c:361
> Modules linked in:
> 
> CPU: 0 UID: 0 PID: 13600 Comm: syz-executor Not tainted 6.15.0-rc6-syzkaller-00166-g342e4955a1f1 #0 PREEMPT(voluntary) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
> RIP: 0010:ipmr_free_table net/ipv4/ipmr.c:440 [inline]
> RIP: 0010:ipmr_rules_exit+0x13a/0x1c0 net/ipv4/ipmr.c:361
> Code: ff df 48 c1 ea 03 80 3c 02 00 75 7c 48 c7 85 58 09 00 00 00 00 00 00 5b 5d 41 5c 41 5d 41 5e c3 cc cc cc cc e8 d7 79 16 fb 90 <0f> 0b 90 eb 93 e8 cc 79 16 fb 0f b6 1d 73 37 05 04 31 ff 89 de e8
> RSP: 0018:ffffc90014e2fc10 EFLAGS: 00010293
> 
> RAX: 0000000000000000 RBX: ffff88812c1dc000 RCX: ffffffff8665f0fd
> RDX: ffff8881222c9d40 RSI: ffffffff8665f169 RDI: 0000000000000005
> RBP: ffff88812ea70000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000001
> R13: ffff88812ea70958 R14: ffff88812ea70000 R15: fffffbfff148e04c
> FS:  000055558afcb500(0000) GS:ffff8882691c2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fc07c1d33d0 CR3: 000000014620e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ipmr_net_exit_batch+0x53/0xa0 net/ipv4/ipmr.c:3160
>  ops_exit_list+0x128/0x180 net/core/net_namespace.c:177
>  setup_net+0x4e8/0x850 net/core/net_namespace.c:396
>  copy_net_ns+0x2a6/0x5f0 net/core/net_namespace.c:518
>  create_new_namespaces+0x3ea/0xad0 kernel/nsproxy.c:110
>  unshare_nsproxy_namespaces+0xc0/0x1f0 kernel/nsproxy.c:228
>  ksys_unshare+0x45b/0xa40 kernel/fork.c:3375
>  __do_sys_unshare kernel/fork.c:3446 [inline]
>  __se_sys_unshare kernel/fork.c:3444 [inline]
>  __x64_sys_unshare+0x31/0x40 kernel/fork.c:3444
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f31d7a50167
> Code: 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 10 01 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe9bbc8f18 EFLAGS: 00000206
>  ORIG_RAX: 0000000000000110
> RAX: ffffffffffffffda RBX: 00007f31d7c75f40 RCX: 00007f31d7a50167
> RDX: 0000000000000005 RSI: 00007ffe9bbc8de0 RDI: 0000000040000000
> RBP: 00007f31d7c76738 R08: 00007f31d87a7d60 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000008
> R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
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
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup

#syz fix: mr: consolidate the ipmr_can_free_table() checks.


