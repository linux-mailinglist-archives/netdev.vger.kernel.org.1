Return-Path: <netdev+bounces-201922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CB9AEB702
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2931C60BB9
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83232BEFEB;
	Fri, 27 Jun 2025 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s/l8iHrq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201E4299A96
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751025505; cv=none; b=ED9pTkeGOw4c3RnmlQ7hn49FdJJlSFon6CjVY3nfgixsj5Dj9UJSOJWl+S1cauirlHVEX6yP4ujv7AHKCxgNWbLXoAYyFzPlS+l8HJzS0o0ElfYfuk/yvgv/gGhvLdI6pRwQdJhGFCLKNBCp5f6b3SU9ZkTRYIm7rTnhP3onj70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751025505; c=relaxed/simple;
	bh=uUPeH6/dtbgrUb6I0olQU5QVVqBJa+u2YBUxUAiaXVU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=o1VP+3tKF3OUMrFv+pTreZNGcSEOoEwQOMp1uM2Q/3K1DzsIn2fj9eggYd8mo+PKLX9UTqjCY0+Oa/ZoWuo/MH/tLFU8Htf9UNZvjorAVQaCGJYg12orTojxFFSMtu7SlJ1aXvKwbYhi245wc+5RA8Lwf1rMsStHbJq4x5nQy9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s/l8iHrq; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a6f64eebecso41166541cf.2
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751025503; x=1751630303; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RewHcqdeeb3MeIGzjlrsx4aixYhpJyLkLulKp4uJYrM=;
        b=s/l8iHrqA8BkPrABqJQFfEq9jO/vgpEG/eNE3+GG/P/dSm12yKzAtJlR+GrWirQKed
         LnKEYFRg5nrXujtdTy04bgqdh3pR+nQsY3AnRuaNONc/5MVY4B4mSBjXFAdjv7PqTDhe
         gkv7uAX7k4Y+PBSU8LOkRL7PDcoIxIU3TITYunSp6sVOKXrZR0fgOCr6Hf4TSke4F6io
         5A0q3a/4UIS9mbZuWfYUDpHhtNNmfBJt0Nwrm5AYfwg9e6nRm6nyiXlBObPxS2D6RVWH
         QCgzY/GBtoNyCZJh8KoUs1T4Eyl1J0PFGafZYuIUdwp1IJKGzIqR4TUxkd+sJwm71kqq
         uDNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751025503; x=1751630303;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RewHcqdeeb3MeIGzjlrsx4aixYhpJyLkLulKp4uJYrM=;
        b=I/PHC5+kBh3H49feh0DmQBEafVtUOHcSiN3XMi6u/77QCuisqlw9urCByKFjxylik6
         S5xIBiyybtiR+x2bDbcIc+vVYidRFK1UMq5snCIUcVn2P/AgZD82LMyGzlKbS2CAW4dz
         jnvlcc16H745S8aUbn++WEfU46fMAUkEUKwa9gyJs1vxUXzAbWOxQiFSMC4cumHV7ocE
         /lHoBY+Cvy4jMq9gtwQ/21KGa4U8xwlVbI7QQ45efy1kEOqa/25zWH2PPl79yZs7s10Z
         3OkwZRxZXcVjdTAKuRILwFLYbBuopTGk+FUKLJ+BuInbMLW+k00ik67+XBQhDsdqt/fZ
         1WOw==
X-Forwarded-Encrypted: i=1; AJvYcCUtQmIlO0ytQxLSMLFbxDjAXxKFgdtZKLc5/Q/LpJOWjxHeHoYaWH+j6pETtk1dfOZtVXlVs1I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHttmeOd2/nJNJ4co1nT2lwFDB02u97ZEZ8Iub9fCboys3ztAv
	GP79jiT4jhqdOsSjxwfO+h/2zfShlZfjepC2L1D7xOjwpxMs8t7f1jAItczTDmNWUl2924niS71
	dknF5vyYglO4KPg==
X-Google-Smtp-Source: AGHT+IG2FD4420PknwJalJ41SdUDRQfNkCEHmlFNGKbVvY4IMYPhOkZ9rPWoX3GsVFgTYvdZ7R9Xhzy0Fw49kg==
X-Received: from qtbfd3.prod.google.com ([2002:a05:622a:4d03:b0:4a3:ebb6:6a67])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1a8c:b0:4a7:5c3f:7db3 with SMTP id d75a77b69052e-4a7fca98b58mr57029361cf.2.1751025503049;
 Fri, 27 Jun 2025 04:58:23 -0700 (PDT)
Date: Fri, 27 Jun 2025 11:58:21 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627115822.3741390-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: guard ip6_mr_output() with rcu
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+0141c834e47059395621@syzkaller.appspotmail.com, 
	Petr Machata <petrm@nvidia.com>, Roopa Prabhu <roopa@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Benjamin Poirier <bpoirier@nvidia.com>, 
	Ido Schimmel <idosch@nvidia.com>
Content-Type: text/plain; charset="UTF-8"

syzbot found at least one path leads to an ip_mr_output()
without RCU being held.

Add guard(rcu)() to fix this in a concise way.

WARNING: net/ipv6/ip6mr.c:2376 at ip6_mr_output+0xe0b/0x1040 net/ipv6/ip6mr.c:2376, CPU#1: kworker/1:2/121
Call Trace:
 <TASK>
  ip6tunnel_xmit include/net/ip6_tunnel.h:162 [inline]
  udp_tunnel6_xmit_skb+0x640/0xad0 net/ipv6/ip6_udp_tunnel.c:112
  send6+0x5ac/0x8d0 drivers/net/wireguard/socket.c:152
  wg_socket_send_skb_to_peer+0x111/0x1d0 drivers/net/wireguard/socket.c:178
  wg_packet_create_data_done drivers/net/wireguard/send.c:251 [inline]
  wg_packet_tx_worker+0x1c8/0x7c0 drivers/net/wireguard/send.c:276
  process_one_work kernel/workqueue.c:3239 [inline]
  process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3322
  worker_thread+0x8a0/0xda0 kernel/workqueue.c:3403
  kthread+0x70e/0x8a0 kernel/kthread.c:464
  ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Fixes: 96e8f5a9fe2d ("net: ipv6: Add ip6_mr_output()")
Reported-by: syzbot+0141c834e47059395621@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/685e86b3.a00a0220.129264.0003.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Petr Machata <petrm@nvidia.com>
Cc: Roopa Prabhu <roopa@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Benjamin Poirier <bpoirier@nvidia.com>
Cc: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/ip6mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index a35f4f1c658960e4b087848461f3ea7af653d070..eb6a00262510f1cd6a9d48fab80bdd0d496bb7ee 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2373,7 +2373,7 @@ int ip6_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	int err;
 	int vif;
 
-	WARN_ON_ONCE(!rcu_read_lock_held());
+	guard(rcu)();
 
 	if (IP6CB(skb)->flags & IP6SKB_FORWARDED)
 		goto ip6_output;
-- 
2.50.0.727.gbf7dc18ff4-goog


