Return-Path: <netdev+bounces-180371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB98A811C0
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 18:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1369A1BC63FB
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704C9236433;
	Tue,  8 Apr 2025 16:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DDVsac3m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBCD22CBFD;
	Tue,  8 Apr 2025 16:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744128323; cv=none; b=h11vJfqh2AzgCvMIO7N2jlOvS+Fn4ZY4ScezyogCya9xXelUkRQxjTODI3ahK3GvJkLXjaUo62kQFuv9kBe5Wifmlc+vWWpsO2izDlzUeb6F6H6UtgwUV1JcIZaoxQJJ+lBBpexuMDFn7k7M2OmoH4f1/rTc9FaxP/cbArHigzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744128323; c=relaxed/simple;
	bh=AO9nAWE532Yx1kWGt8QujcweMSmDhbuSqwtnffsns9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dP+7Hp4jc4cR25NQjnMXoAX29A6fajrVzoYWf7V4meGG55xA8lj4g30vDEWE2QWatllrVq8fmtljLc9YRKZc6D38EVMbF3iv6ACm2+azxiL+ETDc/WzZ6pWBWgZZCADDDlM2/9B2vjHYqeUDMn6Ju6peCV0rTAaMnGr5uL1f7cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DDVsac3m; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-730517040a9so6931314b3a.0;
        Tue, 08 Apr 2025 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744128321; x=1744733121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vnqlANBxICA4CPhpsBvu01xn2mgvSh4OZNjEHi+9+E0=;
        b=DDVsac3myaEpQ/uq5XYK/h5Jp1lIGQmtSDb5vyLeFkBXgnDVw0lyGD9tZVys9EiByY
         0PBkl/kTXcTaVFiS/aceQPxeZOzGXp8MZ7kMdT9kvCEyo2RiqbaMOCI+/SBdzZx0YMjJ
         FaQRusNbcVUZ5+hFMfAFk72kAU9yM8XODFlZrRS7kZn7+zGhlzmymwlgKXS9NVtGt0O4
         Bb2y1ru/NhtKP7LIFucE5b+xsHHaYofeNuxSoCal/N81b5WXOTJv4wqfKXiZNhP3PMk+
         w9Zd/g7a4Ol8XLQcDYgUIL3nzeTVKErXRLO4CYcHu2z6BpGWskMJsMWh97Y5BYfsd8rZ
         LLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744128321; x=1744733121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnqlANBxICA4CPhpsBvu01xn2mgvSh4OZNjEHi+9+E0=;
        b=Z+Q/dBX9QiktbWXIx8/bv7RUwJPBGgoUGDEtugn5ofPEIBKCqCbCMrDDvg/7NTOuP/
         pN+HvCMaPQJUkbYkBAtRolMgf97zcmKs1P4eC415XzQ1RXsnZAUR5RkJACLi6uW4MOTQ
         tXzcZfHGhiM3FeYUy/J5BtHzayXYJk8hpH58kJrmJ0eqRvJqCfGpkHkFu/Pqx2xGYgbf
         lxdJDUErG6IAX0o0UUfRN5GdPhqlZF7z2maVqJlhVv6opCTd29FXBz/FWS3eY3nmlYUY
         i7ruG+YOPuOCOdKRzW6zzjnhV+9Gamt8IF0gPao/0g//wmFuwLofJejQHl+0cOLvk8Zc
         0YfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOe5bdeyGennZWVzW1b1Q5nUDLH5ANKgiNSDzu5nTFHHWM1lHmwY0gUcXVz3Umx4ixO4VE8FBg+gmUfSs=@vger.kernel.org, AJvYcCXVpAMIFfXh5yJFzlxXXClHihJg0cpu3Qb0VLtFnQgNw3q0W9Oz+gZgcGP520QcYvl5mJ8YUSAx@vger.kernel.org
X-Gm-Message-State: AOJu0YxhfYF5aM13ujmYkW5VIrCEf5LeB2djSgPhtwVaSxDtGdVecaa2
	sOyE4bTaRDupAL801CzHbLkqzAlbUKykmY9/Z4kmefsjdsezE6w=
X-Gm-Gg: ASbGncvmfx7R/ntH1GijO3hEM6GcwdCvJJrfgYvSRp8fI6KJ1Axr0UhL/qBlj6R7cIL
	OvvjhRL59o3FyUw51SVLHuJNYBUJZ+h7mnMVroi1ebJzRm1qxEZ86yKxf8MVWJAr2AwXPphHwYF
	LWImURA8uVTw0IyyVBNA2ARPZshh6E97J4DxZkK3SfnXKWFIH7SZarmItsgChGUgbPQcwKDyrl3
	nSEuuIG9fX4lwC+vGdf7DCyNLEzuVLMxbfkBOukG6dAcWuk+F1Anyl5D3NHLhd0IxSANlEuFC9y
	ENoTNb4DpSStK0PLAzeOvzlttDWJn123pqLF7rvrnBLC
X-Google-Smtp-Source: AGHT+IFHde0R6IjgXUxrcn+fQrx9ZpOmkb1PXOoeKYkibomgI6obp/DrxZEUxZLej5G0vYJeB/o8Eg==
X-Received: by 2002:a05:6a21:6d92:b0:1f5:8d3b:e294 with SMTP id adf61e73a8af0-2010458c774mr24329427637.16.1744128320745;
        Tue, 08 Apr 2025 09:05:20 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-739d97f3719sm10749912b3a.71.2025.04.08.09.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Apr 2025 09:05:20 -0700 (PDT)
Date: Tue, 8 Apr 2025 09:05:19 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: syzbot <syzbot+3ab016dc5f28b32452c1@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] WARNING in ipv6_add_dev
Message-ID: <Z_VJP8bbKRyOAeyQ@mini-arch>
References: <67f5351f.050a0220.12542b.0001.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <67f5351f.050a0220.12542b.0001.GAE@google.com>

On 04/08, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0af2f6be1b42 Linux 6.15-rc1
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=166dffb0580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=66996a2350ef05e0
> dashboard link: https://syzkaller.appspot.com/bug?extid=3ab016dc5f28b32452c1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> userspace arch: i386
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2bd38b4e51ec/disk-0af2f6be.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/928b4d433463/vmlinux-0af2f6be.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9c0fa5febc31/bzImage-0af2f6be.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+3ab016dc5f28b32452c1@syzkaller.appspotmail.com
> 
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 813 at ./include/net/netdev_lock.h:54 netdev_ops_assert_locked include/net/netdev_lock.h:54 [inline]
> WARNING: CPU: 1 PID: 813 at ./include/net/netdev_lock.h:54 ipv6_add_dev+0x104c/0x1430 net/ipv6/addrconf.c:381
> Modules linked in:
> CPU: 1 UID: 0 PID: 813 Comm: kworker/u8:1 Not tainted 6.15.0-rc1-syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
> Workqueue: events_unbound linkwatch_event
> RIP: 0010:netdev_ops_assert_locked include/net/netdev_lock.h:54 [inline]
> RIP: 0010:ipv6_add_dev+0x104c/0x1430 net/ipv6/addrconf.c:381
> Code: ff ff e8 67 5d fe f6 48 bd 00 00 00 00 00 fc ff df 48 8b 3c 24 4c 8b 6c 24 18 4c 8b 64 24 28 e9 7f fc ff ff e8 45 5d fe f6 90 <0f> 0b 90 e9 64 f1 ff ff e8 37 5d fe f6 c6 05 16 e3 84 05 01 90 48
> RSP: 0018:ffffc9001cbbf3d8 EFLAGS: 00010293
> RAX: ffffffff8ac4f7db RBX: 0000000000000000 RCX: ffff88807a275a00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff8ac4e8fb R09: 1ffffffff201fa64
> R10: dffffc0000000000 R11: fffffbfff201fa65 R12: ffff88805d942000
> R13: ffff88805d942000 R14: dffffc0000000000 R15: ffff88805d942000
> FS:  0000000000000000(0000) GS:ffff888125096000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00000000f5045ffc CR3: 0000000032240000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ipv6_find_idev+0xc2/0x1e0 net/ipv6/addrconf.c:496
>  addrconf_add_dev+0xbe/0x530 net/ipv6/addrconf.c:2560
>  addrconf_dev_config net/ipv6/addrconf.c:3479 [inline]
>  addrconf_init_auto_addrs+0x8f1/0xfe0 net/ipv6/addrconf.c:3567
>  addrconf_notify+0xaff/0x1020 net/ipv6/addrconf.c:3740
>  notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
>  netdev_state_change+0x123/0x1a0 net/core/dev.c:1536

Still has netdev_state_change

#syz fix: "net: hold instance lock during NETDEV_CHANGE"

