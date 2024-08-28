Return-Path: <netdev+bounces-122987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAEB963645
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 01:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 971951F226E9
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224FE1B14FD;
	Wed, 28 Aug 2024 23:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="fdsPHIDr";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="GmfZt/FE"
X-Original-To: netdev@vger.kernel.org
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE91AED25
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 23:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724888266; cv=none; b=YqFRnLKLq9kyzXRzr9CuMXP4psKCuv1neVR/jJnhk+ewpOR6Nnxgzm0C8Yw+N8PclYP7+4EeDAfw94LMOwoYdVndphuXh9gfbvib903+MMjJRyRHI8Bne7Ta+DWZTf+ZFjnjASapT4ArplrpnWYGPklgJV83a0/4kWzZCQAVStc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724888266; c=relaxed/simple;
	bh=GJdzld4jTWn6nYzAphdnp/WoAIQWPqdoYf2djtGyPmI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nD35hqGHeKTvLRvCUgqB/wguFXh51nFreWHAEPJ2N0Z6P51BC29pY5MBLyaH/+bUuA67x3o1FbD//5GOqgdI6qLSgOO+KcqeVGSLa5LUPN9vbiRIuQyuMtCjG+zTSVCYy0oPD93ngpzGJ1tJFI0h6RUx5Ee4DEmYMH/7ZYNBnOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=fdsPHIDr; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=GmfZt/FE; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724888264; x=1756424264;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:cc:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=GJdzld4jTWn6nYzAphdnp/WoAIQWPqdoYf2djtGyPmI=;
  b=fdsPHIDrzCnNERXEMXzuneuoGJwgvjP8SEbH+jO7wQRbL08iPCSsPLSi
   2R1GlBHj8lStq9QcLDQ5jOkarYSTJKCiasBRxy/S8Tu11Mf7aEXk1pZvw
   pt7eqXQThpRAmqGrDZGx4SE6niQ4JIZbwwXV60LwxRN3M/FndfYFQQbpo
   zwXarKsk9fSdZziLP7elK28O2pQb5uTHIxwhBnDUDx1UJYyBUm05t62N9
   dS18yxdC3aCE/tWgxtUVDjw/pL5RYPImE3DJHmEsb0+D/tYKAwmitUrsA
   krIfI7AWOoyxzPkosoj6gVUZ5seFzi0Llpv2cpiNQc2pHw96Ays+Iy5RC
   Q==;
X-CSE-ConnectionGUID: mTlSBrQfTnKQoyiWmtazmA==
X-CSE-MsgGUID: I8kVVmFUTd2ouXayT4gTRw==
Received: from mail-io1-f69.google.com ([209.85.166.69])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 16:37:42 -0700
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-827878b991aso12668239f.1
        for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 16:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724888261; x=1725493061; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XtfXfaV+fxB/nHNeqMTTgAG3FKhTYBPjiNWqzba34qU=;
        b=GmfZt/FEwNYHjjOpuH9YTigvuUC37LeB28N6RfZxKGYR0PKL7lRLnyMU4cS1lUUo3/
         XjdA357yRICIw1ms0GaLzp+fzqFzfJ2soxUds1LSBswDOrf+J9ZLRfbWVzQ52+oRGtlY
         7Z2+Uqon47IFoXhf7L5W10KIlbgt5MkmJUl+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724888261; x=1725493061;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XtfXfaV+fxB/nHNeqMTTgAG3FKhTYBPjiNWqzba34qU=;
        b=H8HekEWVSNhSlj1R4dXn3ii1iZCj4nzY2kPDBzfInElBPXXKHbjD51O75xKY5C7iiw
         N9euEV5kcnS//cxSQ0WoxsD8mL9/j2IfYJHqYUaOePN5Tth9s/6xqDcIq4keuu+IN25g
         kH9xktNFNuRg+NxaMiDB+EKjDb9qvlTrvTJE6E1CguK2G+62nZwCXgNASh5PZtcBx23U
         xclCDaj5TvFURclNsNVpLMYy2+Bv5mU8EgRsSHuQr38aiCEVDczA9hkW/fc81h/QlXe8
         U3qw59YF96UQaXd0PtpVG34OvuAkHmvuRELveobESxCNM8VbYs5VhS30EmEshatbHrhL
         YeFg==
X-Forwarded-Encrypted: i=1; AJvYcCVAz5PXAtt7b4ECndKMStXQvuez1r0NElgtPfKYURweHKSAvk+fqKU26sBfLuzQjGhZHyYlQBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzT9T+i1BfNGDUrERnI2TUzKAYMhwmGXTY+4LYDWfaOQUYZTqpW
	sG8hq03IKZysIOYTgF9hgLvpCRNGUiQxPMTSs/KLT9P24mOw2Z5baXiUOAJ1YY0+jNeZvu7h5dr
	Cy3Zw6vIVnBNug7tTG7nbeMA57j8KJDyv7k46lEeewPhvcVz5ioYlxtamConSYqPg1kr3m0akBO
	EtNHJuNzKEJDuRThX9F+JaJL0S1GIITQ==
X-Received: by 2002:a05:6e02:156c:b0:39b:33b5:5cc1 with SMTP id e9e14a558f8ab-39f37874675mr16269015ab.24.1724888261115;
        Wed, 28 Aug 2024 16:37:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGxx1C0b3tOQfi3mchQ5k2jKuhuU0IWdL/9I8h3CXCgYCKjdAAvBght4r9+WFieJ5xDcRCFZ70dSaWPj3L+thA=
X-Received: by 2002:a05:6e02:156c:b0:39b:33b5:5cc1 with SMTP id
 e9e14a558f8ab-39f37874675mr16268875ab.24.1724888260815; Wed, 28 Aug 2024
 16:37:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 16:37:30 -0700
Message-ID: <CALAgD-7DfifSgrCTLnp0Td0wCBFQ4DxHzfzXf_3oZ6OmQRQtcw@mail.gmail.com>
Subject: BUG: corrupted list in rxrpc_discard_prealloc
To: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	linux-afs@lists.infradead.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Yu Hao <yhao016@ucr.edu>
Content-Type: text/plain; charset="UTF-8"

Hi,

We found a bug in Linux 6.10 using syzkaller. It is possibly a
corrupted list bug.
The bug report is as follows, but unfortunately there is no generated
syzkaller reproducer.

Bug report:

bond0 (unregistering): Released all slaves
list_del corruption. next->prev should be ffff88801ef15218, but was
0000000000000000. (next=ffff88802ed18218)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:67!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 2790 Comm: kworker/u4:9 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:__list_del_entry_valid_or_report+0x11e/0x120 lib/list_debug.c:65
Code: 96 06 0f 0b 48 c7 c7 e0 5b a9 8b 4c 89 fe 48 89 d9 e8 96 ff 96
06 0f 0b 48 c7 c7 60 5c a9 8b 4c 89 fe 4c 89 f1 e8 82 ff 96 06 <0f> 0b
80 3d bd 35 c6 0a 00 74 01 c3 31 d2 eb 02 66 90 55 41 57 41
RSP: 0018:ffffc900097ef8e8 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff88802ed18220 RCX: 12f0e8d01e569d00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888041824064 R08: ffffffff8172e30c R09: 1ffff920012fdebc
R10: dffffc0000000000 R11: fffff520012fdebd R12: dffffc0000000000
R13: ffff88801ef15000 R14: ffff88802ed18218 R15: ffff88801ef15218
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005605ff865d58 CR3: 0000000040bd2000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 rxrpc_discard_prealloc+0x27e/0x800 net/rxrpc/call_accept.c:208
 rxrpc_listen+0x280/0x3a0 net/rxrpc/af_rxrpc.c:246
 afs_close_socket+0xa4/0x310 fs/afs/rxrpc.c:112
 afs_net_exit+0x5b/0xf0 fs/afs/main.c:155
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x810/0xcd0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x11e/0x120 lib/list_debug.c:65
Code: 96 06 0f 0b 48 c7 c7 e0 5b a9 8b 4c 89 fe 48 89 d9 e8 96 ff 96
06 0f 0b 48 c7 c7 60 5c a9 8b 4c 89 fe 4c 89 f1 e8 82 ff 96 06 <0f> 0b
80 3d bd 35 c6 0a 00 74 01 c3 31 d2 eb 02 66 90 55 41 57 41
RSP: 0018:ffffc900097ef8e8 EFLAGS: 00010246
RAX: 000000000000006d RBX: ffff88802ed18220 RCX: 12f0e8d01e569d00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff888041824064 R08: ffffffff8172e30c R09: 1ffff920012fdebc
R10: dffffc0000000000 R11: fffff520012fdebd R12: dffffc0000000000
R13: ffff88801ef15000 R14: ffff88802ed18218 R15: ffff88801ef15218
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005605ff865d58 CR3: 0000000040bd2000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


-- 
Yours sincerely,
Xingyu

