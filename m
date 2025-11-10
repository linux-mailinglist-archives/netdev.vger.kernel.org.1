Return-Path: <netdev+bounces-237113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E307FC4566C
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 75FCD3431C1
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 08:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505172FD693;
	Mon, 10 Nov 2025 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D/Hth5+r";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WnG9aMCB"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2BB2FB978
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762764124; cv=none; b=rRPplZY30nryIPNe5tuAV8uJGkhg8Wip9cRXPPsSHGozMJM6QKzOMazra65BYpHiCPMM5BSZOL7RfRLkGdI+qAQ2SG9m02ZpQKD1HgObWv1Wx4Q9fsXybRmJAZkQaecJCa9bTXAVhFZ6R2pwFZIU1t3RB37yqpa73IS2hLEALG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762764124; c=relaxed/simple;
	bh=8t7E7C7X6/uPzLWrcNTAevURsvI8Omeu5uFxAu0WoZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JaEpQSPmlr0hUe/6csOPplkxM/xHb/K9AyeVft7CpNn5MvMC3Qn+/cSbfMHInsbGoNpO2M8J8KesOFQ+sc5hsqfZVWQxEbBseJ67wXJ6VErCu9expSwRKT+vbWJF2hTXYcmfFt9XktNRpPNbqMr/a05/eZtYKDGPa2n2/xP9qtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D/Hth5+r; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WnG9aMCB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762764119;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fZIPr6og7VmnwsjsLuonEjEHRjxzMYgAiThp8TNrGcg=;
	b=D/Hth5+r1HiI9k68u+CYfidHeY+OO9rBgLWLDADCfwWklq1jJo5Srk2yvRrucawDvoywTQ
	aKVytp97NF916iKr2S55xzcHDxPQqHdvI6mTOj5LIVHMbEJh3aBp+BFi1jLYOFD3h67wHQ
	P8QcK3JNMc8wYmqrKxE9jiJUWekphRY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-LAE_ZcAOOWqntWqr2h5Fqg-1; Mon, 10 Nov 2025 03:41:58 -0500
X-MC-Unique: LAE_ZcAOOWqntWqr2h5Fqg-1
X-Mimecast-MFC-AGG-ID: LAE_ZcAOOWqntWqr2h5Fqg_1762764117
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47775585257so11272345e9.1
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 00:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762764117; x=1763368917; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fZIPr6og7VmnwsjsLuonEjEHRjxzMYgAiThp8TNrGcg=;
        b=WnG9aMCBhi6x6eULSC+pTlXY9YSBmbo991Gs9fkqLVFeaalEdHxc82JWqph4CYWMhr
         o+vVEkez/c2cRlcUY8zO4GWZP/Tn6V6zt10eZagJ3NGHAwtAGF3hW9hepE2smm9rWktU
         009WRT92I6l4lH+Yjmj1fQFeqNhqetreZx3p4jvTlQGpcy0mtyil6fjv+NZkxFoATEhi
         O6+TulPtTy3v++Lg/T4nNlgVtuM971wAiW11hnFz0Vs7/7UWTI/rq8MYCS8rRxjNAXlu
         ahxSg8uBKjqCER0Bs3sSoj3nGoj1EkjHsWhK31EeLAXMRhqdHweLl7isd3ZMWg77qO5F
         avfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762764117; x=1763368917;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fZIPr6og7VmnwsjsLuonEjEHRjxzMYgAiThp8TNrGcg=;
        b=av9qYoG/AiXGZQVxYeyfRaN1Us34ZYgcYEvj3avubtOCwktTQNPPzr6RWPzdP6Gp2L
         743/+D+umRkHnbQL6ulDwa2WX0lNqJpyOan7S+0IZDCZsuH2IfrnK9N+D29VWjratfm4
         rkfEwoV9SrF7OA5pbvIU0zyHMuw5feW0JcPKTOhrgwJA4NT81HRo3knn6iZ6dbSjD89X
         HdDXYbGkMHXiiA34dfJVxHQxWmQsahUS18SOR8D33tJa6SOnTUC51A4ihUzAGN4gtx/e
         3o/6+lS6E+4ELJ0f39U8iFeoNDm1ca1fCSalT0SgqKP5xkOp2BuEIaIoBong1NzEL3fs
         RmNw==
X-Forwarded-Encrypted: i=1; AJvYcCXH7dRd78WdpRK1iEHOVEDQhAR0gPNiH9kJTykKsOW7L6fHindJd+8NNJ/nWJlKjN+mkxj94Yg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMtWrwNXwkEnDShTOzfo9/KicVM0KHdu3keWCF0STSoauhPTiU
	8qYcyuOXZX/FhQwtTUHV+Q9TerglyZqE6j1BeVFLqh4Lx2x1Gr+p/RVCNbe06uSAITQf/Aqart1
	nt+DPE6Bo5OyMNRnF6mC9v0Ab7J76kq2/auQ735en91TZo9Om1L2dlFX6KQ==
X-Gm-Gg: ASbGncv3o9NsveEw9U9pHjXY4w6y5FtcUV15uBSUieFbH6g1/JFOE60Nxknot7hYXOD
	sRWwSC0Z0ZLWR0CtSm1B5c3p3Bo5KTvGb5xN5zn8gDUqXPSxl+9VEs65Cp7K98ryLnFyomHsGcq
	TlYYvscDUPyPiTH3mLB4pyq9HYB367YWUCG0PA7s3nu8OXNiCvEIX48Jkc0rBw8ZSmwl9MHK5vR
	chTLKgaWh2a9kpdYdBPhbKdcbS4Ogs6Zwn+jtOGyhhRkiycXP3/6SwqXLeIyt6wubVfh3C4O9RB
	Pe+OIjGMwuppAwQymLFT+Gmf4mFq7Rh70BMT0izKoZ36lw16EJyf90GW6WbA0IuIm6XXIdaTnXF
	vhA==
X-Received: by 2002:a05:600c:3b0a:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-4777322e253mr50320635e9.1.1762764117074;
        Mon, 10 Nov 2025 00:41:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJ0QrL3QV6Tjx6kZdnYroTPWXPiZ7ScepK7UVrsUPooHuy6CFFJT9ogZ9eDw/FTVHRPvtGnA==
X-Received: by 2002:a05:600c:3b0a:b0:45d:d353:a491 with SMTP id 5b1f17b1804b1-4777322e253mr50320405e9.1.1762764116566;
        Mon, 10 Nov 2025 00:41:56 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.55])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4777bba9b4esm22548985e9.8.2025.11.10.00.41.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Nov 2025 00:41:56 -0800 (PST)
Message-ID: <327bfa84-c39c-4f6c-aaed-d9054f5d9ae6@redhat.com>
Date: Mon, 10 Nov 2025 09:41:54 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mptcp?] possible deadlock in mptcp_subflow_shutdown (2)
To: syzbot <syzbot+7902f127c28c701e913f@syzkaller.appspotmail.com>,
 davem@davemloft.net, edumazet@google.com, geliang@kernel.org,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 martineau@kernel.org, matttbe@kernel.org, mptcp@lists.linux.dev,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <69113ffc.a70a0220.22f260.00cd.GAE@google.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <69113ffc.a70a0220.22f260.00cd.GAE@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/10/25 2:29 AM, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    dc77806cf3b4 Merge tag 'rust-fixes-6.18' of git://git.kern..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17dd9bcd980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=19d831c6d0386a9c
> dashboard link: https://syzkaller.appspot.com/bug?extid=7902f127c28c701e913f
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/a1c9259ca92c/disk-dc77806c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/98d084f2ad8b/vmlinux-dc77806c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/c25e628e3491/bzImage-dc77806c.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+7902f127c28c701e913f@syzkaller.appspotmail.com
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> syzkaller #0 Not tainted
> ------------------------------------------------------
> syz.7.3695/23717 is trying to acquire lock:
> ffff888087316860 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
> ffff888087316860 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_subflow_shutdown+0x24/0x380 net/mptcp/protocol.c:2918
> 
> but task is already holding lock:
> ffff888026899a60 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1679 [inline]
> ffff888026899a60 (sk_lock-AF_INET){+.+.}-{0:0}, at: mptcp_close+0x1d/0xe0 net/mptcp/protocol.c:3168
> 
> which lock already depends on the new lock.
> 
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #7 (sk_lock-AF_INET){+.+.}-{0:0}:
>        lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
>        lock_sock include/net/sock.h:1679 [inline]
>        inet_shutdown+0x67/0x440 net/ipv4/af_inet.c:907
>        nbd_mark_nsock_dead+0xae/0x5d0 drivers/block/nbd.c:319
>        recv_work+0x671/0xa80 drivers/block/nbd.c:1024
>        process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
>        process_scheduled_works kernel/workqueue.c:3346 [inline]
>        worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
>        kthread+0x3c5/0x780 kernel/kthread.c:463
>        ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #6 (&nsock->tx_lock){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
>        nbd_handle_cmd drivers/block/nbd.c:1146 [inline]
>        nbd_queue_rq+0x423/0x12d0 drivers/block/nbd.c:1210
>        blk_mq_dispatch_rq_list+0x416/0x1e20 block/blk-mq.c:2129
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xcb7/0x15f0 block/blk-mq-sched.c:307
>        blk_mq_sched_dispatch_requests+0xd8/0x1b0 block/blk-mq-sched.c:329
>        blk_mq_run_hw_queue+0x239/0x670 block/blk-mq.c:2367
>        blk_mq_dispatch_list+0x514/0x1310 block/blk-mq.c:2928
>        blk_mq_flush_plug_list block/blk-mq.c:2976 [inline]
>        blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2948
>        __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1225
>        blk_finish_plug block/blk-core.c:1252 [inline]
>        blk_finish_plug block/blk-core.c:1249 [inline]
>        __submit_bio+0x545/0x690 block/blk-core.c:651
>        __submit_bio_noacct_mq block/blk-core.c:724 [inline]
>        submit_bio_noacct_nocheck+0x53d/0xc10 block/blk-core.c:755
>        submit_bio_noacct+0x5bd/0x1f60 block/blk-core.c:879
>        submit_bh fs/buffer.c:2829 [inline]
>        block_read_full_folio+0x4db/0x850 fs/buffer.c:2461
>        filemap_read_folio+0xc8/0x2a0 mm/filemap.c:2444
>        do_read_cache_folio+0x263/0x5c0 mm/filemap.c:4024
>        read_mapping_folio include/linux/pagemap.h:999 [inline]
>        read_part_sector+0xd4/0x370 block/partitions/core.c:722
>        adfspart_check_ICS+0x93/0x940 block/partitions/acorn.c:360
>        check_partition block/partitions/core.c:141 [inline]
>        blk_add_partitions block/partitions/core.c:589 [inline]
>        bdev_disk_changed+0x723/0x1520 block/partitions/core.c:693
>        blkdev_get_whole+0x187/0x290 block/bdev.c:748
>        bdev_open+0x2c7/0xe40 block/bdev.c:957
>        blkdev_open+0x34e/0x4f0 block/fops.c:701
>        do_dentry_open+0x982/0x1530 fs/open.c:965
>        vfs_open+0x82/0x3f0 fs/open.c:1097
>        do_open fs/namei.c:3975 [inline]
>        path_openat+0x1de4/0x2cb0 fs/namei.c:4134
>        do_filp_open+0x20b/0x470 fs/namei.c:4161
>        do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
>        do_sys_open fs/open.c:1452 [inline]
>        __do_sys_openat fs/open.c:1468 [inline]
>        __se_sys_openat fs/open.c:1463 [inline]
>        __x64_sys_openat+0x174/0x210 fs/open.c:1463
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #5 (&cmd->lock){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
>        nbd_queue_rq+0xbd/0x12d0 drivers/block/nbd.c:1202
>        blk_mq_dispatch_rq_list+0x416/0x1e20 block/blk-mq.c:2129
>        __blk_mq_do_dispatch_sched block/blk-mq-sched.c:168 [inline]
>        blk_mq_do_dispatch_sched block/blk-mq-sched.c:182 [inline]
>        __blk_mq_sched_dispatch_requests+0xcb7/0x15f0 block/blk-mq-sched.c:307
>        blk_mq_sched_dispatch_requests+0xd8/0x1b0 block/blk-mq-sched.c:329
>        blk_mq_run_hw_queue+0x239/0x670 block/blk-mq.c:2367
>        blk_mq_dispatch_list+0x514/0x1310 block/blk-mq.c:2928
>        blk_mq_flush_plug_list block/blk-mq.c:2976 [inline]
>        blk_mq_flush_plug_list+0x130/0x600 block/blk-mq.c:2948
>        __blk_flush_plug+0x2c4/0x4b0 block/blk-core.c:1225
>        blk_finish_plug block/blk-core.c:1252 [inline]
>        blk_finish_plug block/blk-core.c:1249 [inline]
>        __submit_bio+0x545/0x690 block/blk-core.c:651
>        __submit_bio_noacct_mq block/blk-core.c:724 [inline]
>        submit_bio_noacct_nocheck+0x53d/0xc10 block/blk-core.c:755
>        submit_bio_noacct+0x5bd/0x1f60 block/blk-core.c:879
>        submit_bh fs/buffer.c:2829 [inline]
>        block_read_full_folio+0x4db/0x850 fs/buffer.c:2461
>        filemap_read_folio+0xc8/0x2a0 mm/filemap.c:2444
>        do_read_cache_folio+0x263/0x5c0 mm/filemap.c:4024
>        read_mapping_folio include/linux/pagemap.h:999 [inline]
>        read_part_sector+0xd4/0x370 block/partitions/core.c:722
>        adfspart_check_ICS+0x93/0x940 block/partitions/acorn.c:360
>        check_partition block/partitions/core.c:141 [inline]
>        blk_add_partitions block/partitions/core.c:589 [inline]
>        bdev_disk_changed+0x723/0x1520 block/partitions/core.c:693
>        blkdev_get_whole+0x187/0x290 block/bdev.c:748
>        bdev_open+0x2c7/0xe40 block/bdev.c:957
>        blkdev_open+0x34e/0x4f0 block/fops.c:701
>        do_dentry_open+0x982/0x1530 fs/open.c:965
>        vfs_open+0x82/0x3f0 fs/open.c:1097
>        do_open fs/namei.c:3975 [inline]
>        path_openat+0x1de4/0x2cb0 fs/namei.c:4134
>        do_filp_open+0x20b/0x470 fs/namei.c:4161
>        do_sys_openat2+0x11b/0x1d0 fs/open.c:1437
>        do_sys_open fs/open.c:1452 [inline]
>        __do_sys_openat fs/open.c:1468 [inline]
>        __se_sys_openat fs/open.c:1463 [inline]
>        __x64_sys_openat+0x174/0x210 fs/open.c:1463
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #4 (set->srcu){.+.+}-{0:0}:
>        srcu_lock_sync include/linux/srcu.h:173 [inline]
>        __synchronize_srcu+0xa1/0x290 kernel/rcu/srcutree.c:1439
>        blk_mq_wait_quiesce_done block/blk-mq.c:283 [inline]
>        blk_mq_wait_quiesce_done block/blk-mq.c:280 [inline]
>        blk_mq_quiesce_queue block/blk-mq.c:303 [inline]
>        blk_mq_quiesce_queue+0x149/0x1b0 block/blk-mq.c:298
>        elevator_switch+0x17d/0x810 block/elevator.c:588
>        elevator_change+0x391/0x5d0 block/elevator.c:691
>        elevator_set_default+0x2e9/0x380 block/elevator.c:767
>        blk_register_queue+0x384/0x4e0 block/blk-sysfs.c:942
>        __add_disk+0x74a/0xf00 block/genhd.c:528
>        add_disk_fwnode+0x13f/0x5d0 block/genhd.c:597
>        add_disk include/linux/blkdev.h:775 [inline]
>        nbd_dev_add+0x783/0xbb0 drivers/block/nbd.c:1987
>        nbd_init+0x1a2/0x3c0 drivers/block/nbd.c:2702
>        do_one_initcall+0x123/0x6e0 init/main.c:1283
>        do_initcall_level init/main.c:1345 [inline]
>        do_initcalls init/main.c:1361 [inline]
>        do_basic_setup init/main.c:1380 [inline]
>        kernel_init_freeable+0x5c8/0x920 init/main.c:1593
>        kernel_init+0x1c/0x2b0 init/main.c:1483
>        ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #3 (&q->elevator_lock){+.+.}-{4:4}:
>        __mutex_lock_common kernel/locking/mutex.c:598 [inline]
>        __mutex_lock+0x193/0x1060 kernel/locking/mutex.c:760
>        queue_requests_store+0x3a7/0x670 block/blk-sysfs.c:117
>        queue_attr_store+0x26b/0x310 block/blk-sysfs.c:869
>        sysfs_kf_write+0xf2/0x150 fs/sysfs/file.c:142
>        kernfs_fop_write_iter+0x3af/0x570 fs/kernfs/file.c:352
>        new_sync_write fs/read_write.c:593 [inline]
>        vfs_write+0x7d3/0x11d0 fs/read_write.c:686
>        ksys_write+0x12a/0x250 fs/read_write.c:738
>        do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>        do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #2 (&q->q_usage_counter(io)#52){++++}-{0:0}:
>        blk_alloc_queue+0x619/0x760 block/blk-core.c:461
>        blk_mq_alloc_queue+0x172/0x280 block/blk-mq.c:4399
>        __blk_mq_alloc_disk+0x29/0x120 block/blk-mq.c:4446
>        nbd_dev_add+0x492/0xbb0 drivers/block/nbd.c:1957
>        nbd_init+0x1a2/0x3c0 drivers/block/nbd.c:2702
>        do_one_initcall+0x123/0x6e0 init/main.c:1283
>        do_initcall_level init/main.c:1345 [inline]
>        do_initcalls init/main.c:1361 [inline]
>        do_basic_setup init/main.c:1380 [inline]
>        kernel_init_freeable+0x5c8/0x920 init/main.c:1593
>        kernel_init+0x1c/0x2b0 init/main.c:1483
>        ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #1 (fs_reclaim){+.+.}-{0:0}:
>        __fs_reclaim_acquire mm/page_alloc.c:4269 [inline]
>        fs_reclaim_acquire+0x102/0x150 mm/page_alloc.c:4283
>        might_alloc include/linux/sched/mm.h:318 [inline]
>        slab_pre_alloc_hook mm/slub.c:4921 [inline]
>        slab_alloc_node mm/slub.c:5256 [inline]
>        __kmalloc_cache_noprof+0x58/0x780 mm/slub.c:5758
>        kmalloc_noprof include/linux/slab.h:957 [inline]
>        kzalloc_noprof include/linux/slab.h:1094 [inline]
>        ref_tracker_alloc+0x18e/0x5b0 lib/ref_tracker.c:271
>        __netns_tracker_alloc include/net/net_namespace.h:362 [inline]
>        netns_tracker_alloc include/net/net_namespace.h:371 [inline]
>        get_net_track include/net/net_namespace.h:388 [inline]
>        sk_net_refcnt_upgrade+0x141/0x1e0 net/core/sock.c:2384
>        rds_tcp_tune+0x23d/0x530 net/rds/tcp.c:507
>        rds_tcp_conn_path_connect+0x305/0x7f0 net/rds/tcp_connect.c:127
>        rds_connect_worker+0x1af/0x2c0 net/rds/threads.c:176
>        process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3263
>        process_scheduled_works kernel/workqueue.c:3346 [inline]
>        worker_thread+0x6c8/0xf10 kernel/workqueue.c:3427
>        kthread+0x3c5/0x780 kernel/kthread.c:463
>        ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> 
> -> #0 (k-sk_lock-AF_INET){+.+.}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3165 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3284 [inline]
>        validate_chain kernel/locking/lockdep.c:3908 [inline]
>        __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5237
>        lock_acquire kernel/locking/lockdep.c:5868 [inline]
>        lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5825
>        lock_sock_nested+0x41/0xf0 net/core/sock.c:3720
>        lock_sock include/net/sock.h:1679 [inline]
>        mptcp_subflow_shutdown+0x24/0x380 net/mptcp/protocol.c:2918
>        mptcp_check_send_data_fin+0x248/0x440 net/mptcp/protocol.c:3022
>        __mptcp_close+0x90e/0xbe0 net/mptcp/protocol.c:3116
>        mptcp_close+0x28/0xe0 net/mptcp/protocol.c:3170
>        inet_release+0xed/0x200 net/ipv4/af_inet.c:437
>        __sock_release+0xb3/0x270 net/socket.c:662
>        sock_close+0x1c/0x30 net/socket.c:1455
>        __fput+0x402/0xb70 fs/file_table.c:468
>        task_work_run+0x150/0x240 kernel/task_work.c:227
>        resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
>        exit_to_user_mode_loop+0xec/0x130 kernel/entry/common.c:43
>        exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
>        syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
>        syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
>        do_syscall_64+0x426/0xfa0 arch/x86/entry/syscall_64.c:100
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   k-sk_lock-AF_INET --> &nsock->tx_lock --> sk_lock-AF_INET

It looks like a false positive due to mptcp subflows and nbd connection
sockets getting the lockdep annotation. We should possibly/likely use a
specific lockdep key for mptcp subflows.

/P


