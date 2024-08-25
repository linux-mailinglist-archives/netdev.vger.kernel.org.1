Return-Path: <netdev+bounces-121748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B8195E5AB
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 01:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25F681C20294
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 23:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B830E56B72;
	Sun, 25 Aug 2024 23:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="kevLrHxw";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="f2WWBpTU"
X-Original-To: netdev@vger.kernel.org
Received: from mx6.ucr.edu (mx.ucr.edu [138.23.62.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF60433A2
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 23:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=138.23.62.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724628058; cv=none; b=DMYFz2CAjn0gbLkJFYuy1EcfdAVWysr5BnCDpzhVixia5gZSWgLaxXDkqQRkCoijRy0hu3WnXH0Y517HPJkVrukcst4VuyjdqWv8MVaBzPQJg+TcdqJRbOi3YU9JqpoLzN2ZDAXSIm2OZ7u4IeUeJZqRoDnW+e/MEk3Y48ISf5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724628058; c=relaxed/simple;
	bh=1VNAGTm6fbQNSCUOnwTE8QIc4ewRNI0DFeqM4Uk4wpU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=pFK0UEetyvalmu58a3WTzOM8RoW/C3LW4LYH2OzZVbsDaWFNNxuc51nq24mVqxL5SrNvyLP9vxosFbI1e1cO7+vY750vfJW7TdfuGWzHEj5t/xc03pjtGIViOHnMgn4bZ+5I4o/s+lr/UGuCiVIVhwZPS78q3vuT5oRVA6QVrEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=kevLrHxw; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=f2WWBpTU; arc=none smtp.client-ip=138.23.62.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=email.ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724628057; x=1756164057;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:from:date:message-id:
   subject:to:content-type:x-cse-connectionguid:
   x-cse-msgguid;
  bh=1VNAGTm6fbQNSCUOnwTE8QIc4ewRNI0DFeqM4Uk4wpU=;
  b=kevLrHxwczpI8MP8JckVfU+oOrbT6hTsbX/L/Ahy5OEFFo7RrsmdgBvB
   dBwUoA7996XfxSEPNMB110qDb/tw0sLaMl9Ur7N4YO6ccJhwA8nrFLj9G
   grUuBoS86e8zR4LRsKiAuOA9z8BEbeaicJwwuAOZQSo3cNNOiUt0r8/Ax
   fYO6EwYv82g351Lgti95ykshFusBuMhzcTMIY6H5RxNTOP28/ZshU0GJO
   s0F7XCBJI6a1ARqiJrJW40djaAYkUjCF8/PxzS8wxMsFmFou8Gzl+b4lp
   i5LA4bda4NRcqfcQevzsMuYQPZ6eWJH3ketPB4DVV2uzNn8zPmLt8heQd
   A==;
X-CSE-ConnectionGUID: 3C6uefIrTTuqw+L2HYStJg==
X-CSE-MsgGUID: BJfDKjZlQT2jxen+BT1QpA==
Received: from mail-io1-f69.google.com ([209.85.166.69])
  by smtpmx6.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 25 Aug 2024 16:20:56 -0700
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-822372161efso261092239f.0
        for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 16:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724628055; x=1725232855; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QPUvazXE2fywtWRlxIfFoyunQ8Q7NR8HXFyklc0KAbY=;
        b=f2WWBpTUg5GTnR6yULir5Co6u9WKfTPigKKOLyJD3FGx02uw/oMOq+eQdGfymX2bq2
         AUXeEhuw9NmYoo0t0M6G7RVWbu6LfqY6votu2fklLFPAI694dsTahpBc9Z5IdEd+MbLF
         k4R+ltTkhnphSWvqehbUVkFB8UvbLoEUii/Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724628055; x=1725232855;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPUvazXE2fywtWRlxIfFoyunQ8Q7NR8HXFyklc0KAbY=;
        b=CDF5ipPug/5jhko3jw3V6fMJMRIUHJQ5TUj84jo7oaZ29erwM+zx0qRaZDc9+hvi0s
         JrOiqyDRC929l+5VRjqr9rOK5xTDMvlvhoX9p6+RaQHTE/U/rS2YaWlTvdLBnFUysm4a
         nRMBz+SVDPE5JWLCuqXxPvcvAAKnJPbyTQkcwUrR1gV518Cy4WcQUWOKMRwnYFZDjT/3
         3CHN+cM4Hq3KrynALE2QB9SVUN3Yy4lE51Udbhtb94aLCeoOIAEv2Tl8qLPTkVgZ9XHV
         XMKjSP9+HSQhe62NguISPhJ/hsh1CNbkFLbrncu0kQayC/jk/46rQMoe6qrI9RW9m9hu
         xx7g==
X-Forwarded-Encrypted: i=1; AJvYcCWRLYilUXHCpWcfCtE9Xt9Kb4y9rN6BZOzGSPJhdTlijkpEoT2EZAyr7rtqZ4AHVEj51JeKhbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxDrTbYKMHwF91FJq4SP0hzSkhMjtNOUOoVvx6QDssqbZvgz22
	T3YYklo+Ul6qInNmbtKjCxkPC+NCO8jhW41qFxnwdyJrWjNwecekM8Vq79wNZgs/Fc2LrdZvZM2
	83ftpMN4jD6OvWoUL91m11zZd672vc5cJzzijYDSh9yFbrIhlk+nFK1WY26TAv66EmHZ9sSWXDv
	iqPbQwvvyYtlHngOF7I/iaBKelB6y/3dybPIrblxnIfBM=
X-Received: by 2002:a05:6602:27ce:b0:7fa:a253:a1cc with SMTP id ca18e2360f4ac-827880fd100mr1195403439f.3.1724628055176;
        Sun, 25 Aug 2024 16:20:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7VPvLD8KeXlnIkq/E2sTFVUSlSL9FTZF3bm3dmH4+DOTxM8fY8LJvaLcTQabvFe2U49BHULnxJ/erq29g6Aw=
X-Received: by 2002:a05:6602:27ce:b0:7fa:a253:a1cc with SMTP id
 ca18e2360f4ac-827880fd100mr1195401339f.3.1724628054796; Sun, 25 Aug 2024
 16:20:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juefei Pu <juefei.pu@email.ucr.edu>
Date: Sun, 25 Aug 2024 16:20:43 -0700
Message-ID: <CANikGpcbOMa9mGroj2jK0s9Rk0zThyaixf3wQa0ZR-7oh-50Rg@mail.gmail.com>
Subject: BUG: WARNING: ODEBUG bug in sk_stop_timer
To: jmaloy@redhat.com, ying.xue@windriver.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,
We found the following issue using syzkaller on Linux v6.10.
In `tipc_release`, an ODEBUG warning was triggered when executing
`sk_stop_timer(sk, &sk->sk_timer);`. It seems that the function was called
without checking whether `sk->sk_timer` is initialized.

Unfortunately, the syzkaller failed to generate a reproducer.
But at least we have the report:

------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object:
ffff8880254e10a0 object type: timer_list hint:
tipc_sk_timeout+0x0/0xab0
WARNING: CPU: 0 PID: 11 at lib/debugobjects.c:517
debug_print_object+0x176/0x1e0 lib/debugobjects.c:514
Modules linked in:
CPU: 0 PID: 11 Comm: kworker/u4:0 Not tainted 6.10.0 #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:debug_print_object+0x176/0x1e0 lib/debugobjects.c:514
Code: df e8 6e e9 95 fd 4c 8b 0b 48 c7 c7 a0 61 a9 8b 48 8b 74 24 08
48 89 ea 44 89 e1 4d 89 f8 ff 34 24 e8 de 2c f7 fc 48 83 c4 08 <0f> 0b
ff 05 42 1e c6 0a 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f 5d
RSP: 0018:ffffc900000df6f8 EFLAGS: 00010282
RAX: 2f987b8e4002d300 RBX: ffffffff8b4ee740 RCX: ffff8880156dbc00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffffff8ba96360 R08: ffffffff8155a25a R09: 1ffff9200001be7c
R10: dffffc0000000000 R11: fffff5200001be7d R12: 0000000000000000
R13: ffffffff8ba96248 R14: dffffc0000000000 R15: ffff8880254e10a0
FS:  0000000000000000(0000) GS:ffff888063a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc21fbbff8 CR3: 000000003a1e4000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_object_assert_init+0x35f/0x420 lib/debugobjects.c:910
 debug_timer_assert_init kernel/time/timer.c:846 [inline]
 debug_assert_init kernel/time/timer.c:891 [inline]
 __timer_delete kernel/time/timer.c:1413 [inline]
 timer_delete+0x98/0x150 kernel/time/timer.c:1453
 del_timer include/linux/timer.h:202 [inline]
 sk_stop_timer+0x18/0x90 net/core/sock.c:3426
 tipc_release+0x75f/0x1610 net/tipc/socket.c:645
 __sock_release net/socket.c:659 [inline]
 sock_release+0x80/0x140 net/socket.c:687
 tipc_topsrv_stop net/tipc/topsrv.c:718 [inline]
 tipc_topsrv_exit_net+0x2b4/0x2f0 net/tipc/topsrv.c:730
 ops_exit_list net/core/net_namespace.c:173 [inline]
 cleanup_net+0x810/0xcd0 net/core/net_namespace.c:640
 process_one_work kernel/workqueue.c:3248 [inline]
 process_scheduled_works+0x977/0x1410 kernel/workqueue.c:3329
 worker_thread+0xaa0/0x1020 kernel/workqueue.c:3409
 kthread+0x2eb/0x380 kernel/kthread.c:389
 ret_from_fork+0x49/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:244
 </TASK>

