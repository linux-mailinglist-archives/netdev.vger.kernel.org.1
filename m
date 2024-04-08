Return-Path: <netdev+bounces-85823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 993E089C718
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 16:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC041C214F2
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 14:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A4113AA2F;
	Mon,  8 Apr 2024 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/uh/God"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C959113A88F
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 14:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712586637; cv=none; b=oLGE1JgVztVJ8779TBtAERBLa2BDOqplILAOIvOfNHpsMEk1HRGPP3vS9s63n2wvzQG4CVasKGXDZQKfe60wr93IrhSypD1qqT5G0WjgFHjvkkFsNhDO7jmDvCP8xLdCErwXQKO2zD8EvFE5QHoFwhzHlMiJ3SgGckkOYcUf5jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712586637; c=relaxed/simple;
	bh=i3wVPq/okvZKe4TLKciZd2mNy7T03SQLeDj2YrV/oKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TqUkF+o2qq44jgskTUkbwEOoWALSGP2w8PyVJQQ3JlSPxVO0mu8R6F0yt/0StFZxoGPgHaqkRJDz2CxeYW+byQ/e2Rh76GZ4SEggqf5QJSU9ilGnaR54X3+SgMVCOo/ETzD2kyj+BHG99bg6TbxS96nfq3Sc+2pF5mWi779wnlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/uh/God; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecf3943040so2901776b3a.0
        for <netdev@vger.kernel.org>; Mon, 08 Apr 2024 07:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712586635; x=1713191435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8AcUrNvrb32RarCBtKAeZWfNW5SMRCxW49oTbi4dw1Y=;
        b=W/uh/Godc4ksDVfhAN8xdTdZz0RZTxC8oAN3sYDkvstuaJybajaZ/nCAekmO2ZVolt
         7t1X19jo6kLEBSa07dV9ahNwdfNlJ3rkOGofoQcoVgMpM/iPDSNFhYsRy3JLnsppO7dy
         bk0xOqH1+RtcdFV6RVF3DSyaW0Lfm9m0wqIenseIInyDCfFrXWsQJLiP9nczkeuuhvSI
         LCH/PG1sf14rfSurRP2mZwSXEonYPwHVT7aOWN1ks89IyI6eQADwSkGv4Cyf1u+VTXZt
         wEC/77+r/KSZwRkUj/P1O5U03q/PzLw4oT3G+G8NdROLqkI5tBrH9ewh9Sh5yCh+cEzH
         DaRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712586635; x=1713191435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8AcUrNvrb32RarCBtKAeZWfNW5SMRCxW49oTbi4dw1Y=;
        b=Isf+j2f7mataC/KTOl3/woZu/kN6Vbx6yAOSqt7WxEArpls56uuXZJkcix5N+ZnIGZ
         cYm0MRTb1fduK8Uj2LgT4h9mhZR82s5PjH6a5iI3Yns5ovimmND8s72884srqv29X9RR
         l/XcYM/4hg/ufXogT3eSkgbb3h8ZNih3Ns/A4xN2+LW4X7vl8rqZyjnjBhHc4oRt+Uqo
         jJlZ4mV6KTZh6jckArKAMR/rhvifmGl6pbqjdkgCt/dKfw6mXWtlFp8fR4E+4nyIxT3y
         n67s8oYrATRUIEv7ycUOH7tnrL1po0p1hz84JgfNA0VA7qXKe21McFRAeCN56U7LCHTk
         Qldw==
X-Forwarded-Encrypted: i=1; AJvYcCVwsRQ9syy1mmsfHhtI9mXtznyTav5Gr2CybKN8n/739Vm7Eb6WV47lEnyoynxm06EggySmzgA6dq+G2pbM5P4MceImmbmc
X-Gm-Message-State: AOJu0YwbWroPb0AEYIFRnMClt37QzQ7DQQGP9Ea6DeTD+YQ/uG4NWwXT
	Q7RFBKFSA4n/SxdsGMbgYekMFEaeF4sV/rtP2VimsJxNJglH1KoN
X-Google-Smtp-Source: AGHT+IEdRtAUNbZg/lhbZzplvfzLcocb0X4sF3uAXVnVy2V8sSQu5t+RttLSdMUWtwJjE0aK+/eCQw==
X-Received: by 2002:a05:6a20:7484:b0:1a7:9b42:cd62 with SMTP id p4-20020a056a20748400b001a79b42cd62mr331985pzd.5.1712586634696;
        Mon, 08 Apr 2024 07:30:34 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id u12-20020aa7848c000000b006e554afa254sm6617788pfn.38.2024.04.08.07.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 07:30:34 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: edumazet@google.com
Cc: daan.j.demeyer@gmail.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	eric.dumazet@gmail.com,
	kuba@kernel.org,
	kuniyu@amazon.com,
	martin.lau@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com
Subject: Re: [PATCH net] net: implement lockless setsockopt(SO_PEEK_OFF)
Date: Mon,  8 Apr 2024 23:30:29 +0900
Message-Id: <20240408143029.157864-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219141220.908047-1-edumazet@google.com>
References: <20240219141220.908047-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Eric Dumazet wrote:
> syzbot reported a lockdep violation [1] involving af_unix
> support of SO_PEEK_OFF.
>
> Since SO_PEEK_OFF is inherently not thread safe (it uses a per-socket
> sk_peek_off field), there is really no point to enforce a pointless
> thread safety in the kernel.
>
> After this patch :
>
> - setsockopt(SO_PEEK_OFF) no longer acquires the socket lock.
>
> - skb_consume_udp() no longer has to acquire the socket lock.
>
> - af_unix no longer needs a special version of sk_set_peek_off(),
>   because it does not lock u->iolock anymore.

The method employed in this patch, which avoids locking u->iolock in
SO_PEEK_OFF, appears to have effectively remedied the immediate vulnerability,
and the patch itself seems robust.

However, if a future scenario arises where mutex_lock(&u->iolock) is required
after sk_setsockopt(sk), this patch would become ineffective.

In practical testing within my environment, I observed that reintroducing
mutex_lock(&u->iolock) within sk_setsockopt() triggered the vulnerability once again.

Therefore, I believe it's crucial to address the fundamental cause triggering this vulnerability
alongside the current patch.

[   30.537400] ======================================================
[   30.537765] WARNING: possible circular locking dependency detected
[   30.538237] 6.9.0-rc1-00058-g4076fa161217-dirty #8 Not tainted
[   30.538541] ------------------------------------------------------
[   30.538791] poc/209 is trying to acquire lock:
[   30.539008] ffff888007a8cd58 (sk_lock-AF_UNIX){+.+.}-{0:0}, at: __unix_dgram_recvmsg+0x37e/0x550
[   30.540060] 
[   30.540060] but task is already holding lock:
[   30.540482] ffff888007a8d070 (&u->iolock){+.+.}-{3:3}, at: __unix_dgram_recvmsg+0xec/0x550
[   30.540871] 
[   30.540871] which lock already depends on the new lock.
[   30.540871] 
[   30.541341] 
[   30.541341] the existing dependency chain (in reverse order) is:
[   30.541816] 
[   30.541816] -> #1 (&u->iolock){+.+.}-{3:3}:
[   30.542411]        lock_acquire+0xc0/0x2e0
[   30.542650]        __mutex_lock+0x91/0x4b0
[   30.542830]        sk_setsockopt+0xae2/0x1510
[   30.543009]        do_sock_setsockopt+0x14e/0x180
[   30.543443]        __sys_setsockopt+0x73/0xc0
[   30.543635]        __x64_sys_setsockopt+0x1a/0x30
[   30.543859]        do_syscall_64+0xc9/0x1e0
[   30.544057]        entry_SYSCALL_64_after_hwframe+0x6d/0x75
[   30.544652] 
[   30.544652] -> #0 (sk_lock-AF_UNIX){+.+.}-{0:0}:
[   30.544987]        check_prev_add+0xeb/0xa20
[   30.545174]        __lock_acquire+0x12fb/0x1740
[   30.545516]        lock_acquire+0xc0/0x2e0
[   30.545692]        lock_sock_nested+0x2d/0x80
[   30.545871]        __unix_dgram_recvmsg+0x37e/0x550
[   30.546066]        sock_recvmsg+0xbf/0xd0
[   30.546419]        ____sys_recvmsg+0x85/0x1d0
[   30.546653]        ___sys_recvmsg+0x77/0xc0
[   30.546971]        __sys_recvmsg+0x55/0xa0
[   30.547149]        do_syscall_64+0xc9/0x1e0
[   30.547428]        entry_SYSCALL_64_after_hwframe+0x6d/0x75
[   30.547740] 
[   30.547740] other info that might help us debug this:
[   30.547740] 
[   30.548217]  Possible unsafe locking scenario:
[   30.548217] 
[   30.548502]        CPU0                    CPU1
[   30.548713]        ----                    ----
[   30.548926]   lock(&u->iolock);
[   30.549234]                                lock(sk_lock-AF_UNIX);
[   30.549535]                                lock(&u->iolock);
[   30.549798]   lock(sk_lock-AF_UNIX);
[   30.549970] 
[   30.549970]  *** DEADLOCK ***
[   30.549970] 
[   30.550504] 1 lock held by poc/209:
[   30.550681]  #0: ffff888007a8d070 (&u->iolock){+.+.}-{3:3}, at: __unix_dgram_recvmsg+0xec/0x550
[   30.551100] 
[   30.551100] stack backtrace:
[   30.551532] CPU: 1 PID: 209 Comm: poc Not tainted 6.9.0-rc1-00058-g4076fa161217-dirty #8
[   30.551910] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[   30.552539] Call Trace:
[   30.552788]  <TASK>
[   30.552987]  dump_stack_lvl+0x68/0xa0
[   30.553429]  check_noncircular+0x135/0x150
[   30.553626]  check_prev_add+0xeb/0xa20
[   30.553811]  __lock_acquire+0x12fb/0x1740
[   30.553993]  lock_acquire+0xc0/0x2e0
[   30.554234]  ? __unix_dgram_recvmsg+0x37e/0x550
[   30.554543]  ? __skb_try_recv_datagram+0xb2/0x190
[   30.554752]  lock_sock_nested+0x2d/0x80
[   30.554912]  ? __unix_dgram_recvmsg+0x37e/0x550
[   30.555097]  __unix_dgram_recvmsg+0x37e/0x550
[   30.555498]  sock_recvmsg+0xbf/0xd0
[   30.555661]  ____sys_recvmsg+0x85/0x1d0
[   30.555826]  ? __import_iovec+0x177/0x1d0
[   30.555998]  ? import_iovec+0x1a/0x20
[   30.556401]  ? copy_msghdr_from_user+0x68/0xa0
[   30.556676]  ___sys_recvmsg+0x77/0xc0
[   30.556856]  ? __fget_files+0xc8/0x1a0
[   30.557612]  ? lock_release+0xbd/0x290
[   30.557799]  ? __fget_files+0xcd/0x1a0
[   30.557969]  __sys_recvmsg+0x55/0xa0
[   30.558284]  do_syscall_64+0xc9/0x1e0
[   30.558455]  entry_SYSCALL_64_after_hwframe+0x6d/0x75
[   30.558740] RIP: 0033:0x7f3c14632dad
[   30.559329] Code: 28 89 54 24 1c 48 89 74 24 10 89 7c 24 08 e8 6a ef ff ff 8b 54 24 1c 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 2f 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 44 24 08 e8 9e ef f8
[   30.560156] RSP: 002b:00007f3c12c43e60 EFLAGS: 00000293 ORIG_RAX: 000000000000002f
[   30.560582] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3c14632dad
[   30.560933] RDX: 0000000000000000 RSI: 00007f3c12c44eb0 RDI: 0000000000000005
[   30.562935] RBP: 00007f3c12c44ef0 R08: 0000000000000000 R09: 00007f3c12c45700
[   30.565833] R10: fffffffffffff648 R11: 0000000000000293 R12: 00007ffe93a2bfde
[   30.566161] R13: 00007ffe93a2bfdf R14: 00007f3c12c44fc0 R15: 0000000000802000
[   30.569456]  </TASK>




What are your thoughts on this?






