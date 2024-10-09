Return-Path: <netdev+bounces-133879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB34599752F
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F0331F248FB
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657DD1A255A;
	Wed,  9 Oct 2024 18:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RLrJTNyK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DC6EDE
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 18:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500289; cv=none; b=NvrfAgEMS38bFsGoeaVpEAIC2R963mWu/O8JVeUFqV4M/LzzkqaqhvwM4CAIGzKzxDDk8hEnOrp1AXq3O0In3mtow0dUpdg60E7eU+Fzu8lDmXc2EPgiUS8rZRv5NbeUf5d+6nJVyoenbaBfb+JSqx+COLpgLDIHXFIKROj9O9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500289; c=relaxed/simple;
	bh=2dNfI7ohoEm2l4pzidddX4PqbCejCiK8fpWSOObpnJQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BQiPeTEHAfAMvRin7nNcm4zdWcZAlFXogNJi2as4uloixRdxeHV/bLqrbXFe0XDSMkdzLxyPFlzGZoIyC4PvaFIS6nVOBQH0nfD5dBPz11GOm1ued0Pg3F2dXrxbbQI8Gq+1M1sz9cWrnZCRP3opwTshlHGpokGCMNK1jWhdaGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RLrJTNyK; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e20e22243dso5146817b3.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728500287; x=1729105087; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=39OoYBv4TyCG/D6QGBULIPLdhsNaCPjHK43vqbbdJEM=;
        b=RLrJTNyKX+MExRCO1xiLY8Uwu6VNg7k3xiDF5PzlFLMfYC85QjYQqZBeWke9X4DpD5
         baP+F+HHTTgPoKENks29b9qPoxGjX5BHUDRzGQGK72y/hL45q+oGqA3d9QlCg4Uv4Yy/
         c51i78WphNV4wysojbfKf0akg1CCD9KimiiQRW/FYjYXK0Hre7QO9nVCx7/AUAfvV4xz
         Om44SXb+TMjBOq2pP9LNSkOFACDG9QyKIOv6hFyjsMdpLk5hb9sirBuKi3oPzpdRvysW
         JLOgXti419w51g8vbS0IBuBhqbBRjTjtkYjOpJPpsqCqVVx2Y3OihyuDqJsUcOlUEq09
         2vtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728500287; x=1729105087;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=39OoYBv4TyCG/D6QGBULIPLdhsNaCPjHK43vqbbdJEM=;
        b=V+RmRIHJuqnAy7IU+6/C8teR+3eZkCh2ltZOfZpc8Df7yJF07DC+OKVUoDGvKcRZ2w
         8A+s/kIjjffM6oY35wvprJPyRZ2oy+vZ4N57MGv4Wks/rfJrnF9jFdJD4kgP6CCewMrO
         hG/0XevG7V8HY2wGBqtn1e34MJnWZ7pjVGTlpmG0YMb1AOFu/rUl0njT79uCMG8/mhi7
         6BhoUkif5hYRNM1CvYG/AfiSVlgpJmqBHG+35Wfn0nZB5dD17LjiDw2boScvC5YH5FET
         M0jp6GiJqUYkNW7mcySBUnumrK7udMuSQ9NCjiUAadu3iZYvp9ke+WLxGgsckZTT8hq2
         QNLg==
X-Gm-Message-State: AOJu0YxeotFien33U/2epJ6DhbN+oFpxlsEBxOqkonFz60micKmJqpjQ
	m91HJ5MWLTBFjFRiECSjZOFkRxN/gk9ZqrS/6O8nF52N8SOy0acLHoG4Lg4giMButZrw4kd671h
	tKuAQ5ZhNQQ==
X-Google-Smtp-Source: AGHT+IHQ7pkLC3hnHyAF0sSMJoj3CAbNdpbo0qsLUogfpyUsKhWgzVrv4WSgJW1VzFdZDbfj0X7XN08uj2fPww==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a25:f20e:0:b0:e11:5e87:aa9 with SMTP id
 3f1490d57ef6-e28fe421dd3mr3039276.8.1728500286677; Wed, 09 Oct 2024 11:58:06
 -0700 (PDT)
Date: Wed,  9 Oct 2024 18:58:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009185802.3763282-1-edumazet@google.com>
Subject: [PATCH net] ppp: fix ppp_async_encode() illegal access
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+1d121645899e7692f92a@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported an issue in ppp_async_encode() [1]

In this case, pppoe_sendmsg() is called with a zero size.
Then ppp_async_encode() is called with an empty skb.

BUG: KMSAN: uninit-value in ppp_async_encode drivers/net/ppp/ppp_async.c:545 [inline]
 BUG: KMSAN: uninit-value in ppp_async_push+0xb4f/0x2660 drivers/net/ppp/ppp_async.c:675
  ppp_async_encode drivers/net/ppp/ppp_async.c:545 [inline]
  ppp_async_push+0xb4f/0x2660 drivers/net/ppp/ppp_async.c:675
  ppp_async_send+0x130/0x1b0 drivers/net/ppp/ppp_async.c:634
  ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2280 [inline]
  ppp_input+0x1f1/0xe60 drivers/net/ppp/ppp_generic.c:2304
  pppoe_rcv_core+0x1d3/0x720 drivers/net/ppp/pppoe.c:379
  sk_backlog_rcv+0x13b/0x420 include/net/sock.h:1113
  __release_sock+0x1da/0x330 net/core/sock.c:3072
  release_sock+0x6b/0x250 net/core/sock.c:3626
  pppoe_sendmsg+0x2b8/0xb90 drivers/net/ppp/pppoe.c:903
  sock_sendmsg_nosec net/socket.c:729 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:744
  ____sys_sendmsg+0x903/0xb60 net/socket.c:2602
  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2656
  __sys_sendmmsg+0x3c1/0x960 net/socket.c:2742
  __do_sys_sendmmsg net/socket.c:2771 [inline]
  __se_sys_sendmmsg net/socket.c:2768 [inline]
  __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2768
  x64_sys_call+0xb6e/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:308
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
  slab_post_alloc_hook mm/slub.c:4092 [inline]
  slab_alloc_node mm/slub.c:4135 [inline]
  kmem_cache_alloc_node_noprof+0x6bf/0xb80 mm/slub.c:4187
  kmalloc_reserve+0x13d/0x4a0 net/core/skbuff.c:587
  __alloc_skb+0x363/0x7b0 net/core/skbuff.c:678
  alloc_skb include/linux/skbuff.h:1322 [inline]
  sock_wmalloc+0xfe/0x1a0 net/core/sock.c:2732
  pppoe_sendmsg+0x3a7/0xb90 drivers/net/ppp/pppoe.c:867
  sock_sendmsg_nosec net/socket.c:729 [inline]
  __sock_sendmsg+0x30f/0x380 net/socket.c:744
  ____sys_sendmsg+0x903/0xb60 net/socket.c:2602
  ___sys_sendmsg+0x28d/0x3c0 net/socket.c:2656
  __sys_sendmmsg+0x3c1/0x960 net/socket.c:2742
  __do_sys_sendmmsg net/socket.c:2771 [inline]
  __se_sys_sendmmsg net/socket.c:2768 [inline]
  __x64_sys_sendmmsg+0xbc/0x120 net/socket.c:2768
  x64_sys_call+0xb6e/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:308
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5411 Comm: syz.1.14 Not tainted 6.12.0-rc1-syzkaller-00165-g360c1f1f24c6 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+1d121645899e7692f92a@syzkaller.appspotmail.com
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/ppp/ppp_async.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
index a940b9a67107a9f1523ecaae5d49448d977cfe00..c97406c6004d421623c1a3b0b8e30e9237c1dfeb 100644
--- a/drivers/net/ppp/ppp_async.c
+++ b/drivers/net/ppp/ppp_async.c
@@ -542,7 +542,7 @@ ppp_async_encode(struct asyncppp *ap)
 	 * and 7 (code-reject) must be sent as though no options
 	 * had been negotiated.
 	 */
-	islcp = proto == PPP_LCP && 1 <= data[2] && data[2] <= 7;
+	islcp = proto == PPP_LCP && count >= 3 && 1 <= data[2] && data[2] <= 7;
 
 	if (i == 0) {
 		if (islcp)
-- 
2.47.0.rc0.187.ge670bccf7e-goog


