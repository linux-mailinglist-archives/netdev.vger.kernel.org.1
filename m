Return-Path: <netdev+bounces-63145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B2782B56C
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 20:49:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52A4C28A141
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4848F56761;
	Thu, 11 Jan 2024 19:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iqSvzwfu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89D656773
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 19:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbf1c3816a3so3655383276.1
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 11:49:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705002566; x=1705607366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vH+/5llzeEHacT5WAYiKa+NvlnHsf8NqBZXG9MRKbJE=;
        b=iqSvzwfurofNFy91S+L58vKq7UF+egIjKHaf8mtg5YkS26US4NayPQsZnZXdFPNiiZ
         BpYl74hHkJy8Tzw3dKErmaf611P1s6PGGMSh7EVdJdO/6K4KsSyUYQ4Qz7jSCnmU3Hud
         eEbncDGD3rWV5ClCy2lG6P8237axE9Aaahd6tcAjPRoZmXV7bIW/vK0QkkIL99tRl4+n
         jsBen8+ZyZf3H5rNgYls1L8aUBY+Kcb/cNtY63sZBuBjWYTnrwCSMy+S6GfQgC0NG4J9
         AqoX6b49vpXUEBEHFgZ4SEjIl6UxCe7bAhBFyQtFGioScwv8xIO1ADvDZu0O3mpAJYBx
         lOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705002566; x=1705607366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vH+/5llzeEHacT5WAYiKa+NvlnHsf8NqBZXG9MRKbJE=;
        b=wBjeU+4bxOTq8t6ryWNVji8qQoT6ekB7kp5fNQnV6pT14wLh87IJK9fw/V266LA+0F
         vs1useNeeS25BOM13FhC+qtoVG7c2Y3wFkYG2B0GgB8XhiDyNLRDFD1UEEdo8umsoIZP
         LT4YC6mjALAiEZL/sP+XFERxP2eAiqQe3Iz5ud9IWBGWOseaGiUUqTHquRumtgv93FFM
         giXzak3D9P/IchN5QIH/sC0Ze5p/KKMbGnNXH/HRaUOO2VBXHkkW+c1XPIuREKLm97+o
         mRBSqvvbO4mrOFdt/o7nq+Uf+QADm49Cx01/dgSFb1LExsH5AL1mwJqYEPn1/PkdC9QO
         kwaw==
X-Gm-Message-State: AOJu0Yzi+6kIp/bDXXI3ILqCvQXg0cln5hUCYKwhGuJOXsffXHC1sZQU
	2Jzv7U0HEMKfJ84sgU1VQMwsphrH7e9rFejiK2qV
X-Google-Smtp-Source: AGHT+IF6DeXuGXUsJJWIeg+ly/Y8ccZR7JwKZnkc9BBzjyGQJExymeXroGD0NmU5Xyy75FBLhExVLF6Nn5qtvw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a5b:58a:0:b0:dbc:419b:fcb with SMTP id
 l10-20020a5b058a000000b00dbc419b0fcbmr5505ybp.10.1705002565835; Thu, 11 Jan
 2024 11:49:25 -0800 (PST)
Date: Thu, 11 Jan 2024 19:49:16 +0000
In-Reply-To: <20240111194917.4044654-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240111194917.4044654-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111194917.4044654-5-edumazet@google.com>
Subject: [PATCH net 4/5] mptcp: use OPTION_MPTCP_MPJ_SYN in subflow_check_req()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
	Geliang Tang <geliang.tang@linux.dev>, Florian Westphal <fw@strlen.de>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot <syzkaller@googlegroups.com>, Peter Krystad <peter.krystad@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

syzbot reported that subflow_check_req() was using uninitialized data in
subflow_check_req() [1]

This is because mp_opt.token is only set when OPTION_MPTCP_MPJ_SYN is also set.

While we are are it, fix mptcp_subflow_init_cookie_req()
to test for OPTION_MPTCP_MPJ_ACK.

[1]

BUG: KMSAN: uninit-value in subflow_token_join_request net/mptcp/subflow.c:91 [inline]
 BUG: KMSAN: uninit-value in subflow_check_req+0x1028/0x15d0 net/mptcp/subflow.c:209
  subflow_token_join_request net/mptcp/subflow.c:91 [inline]
  subflow_check_req+0x1028/0x15d0 net/mptcp/subflow.c:209
  subflow_v6_route_req+0x269/0x410 net/mptcp/subflow.c:367
  tcp_conn_request+0x153a/0x4240 net/ipv4/tcp_input.c:7164
 subflow_v6_conn_request+0x3ee/0x510
  tcp_rcv_state_process+0x2e1/0x4ac0 net/ipv4/tcp_input.c:6659
  tcp_v6_do_rcv+0x11bf/0x1fe0 net/ipv6/tcp_ipv6.c:1669
  tcp_v6_rcv+0x480b/0x4fb0 net/ipv6/tcp_ipv6.c:1900
  ip6_protocol_deliver_rcu+0xda6/0x2a60 net/ipv6/ip6_input.c:438
  ip6_input_finish net/ipv6/ip6_input.c:483 [inline]
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ip6_input+0x15d/0x430 net/ipv6/ip6_input.c:492
  dst_input include/net/dst.h:461 [inline]
  ip6_rcv_finish+0x5db/0x870 net/ipv6/ip6_input.c:79
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ipv6_rcv+0xda/0x390 net/ipv6/ip6_input.c:310
  __netif_receive_skb_one_core net/core/dev.c:5532 [inline]
  __netif_receive_skb+0x1a6/0x5a0 net/core/dev.c:5646
  netif_receive_skb_internal net/core/dev.c:5732 [inline]
  netif_receive_skb+0x58/0x660 net/core/dev.c:5791
  tun_rx_batched+0x3ee/0x980 drivers/net/tun.c:1555
  tun_get_user+0x53af/0x66d0 drivers/net/tun.c:2002
  tun_chr_write_iter+0x3af/0x5d0 drivers/net/tun.c:2048
  call_write_iter include/linux/fs.h:2020 [inline]
  new_sync_write fs/read_write.c:491 [inline]
  vfs_write+0x8ef/0x1490 fs/read_write.c:584
  ksys_write+0x20f/0x4c0 fs/read_write.c:637
  __do_sys_write fs/read_write.c:649 [inline]
  __se_sys_write fs/read_write.c:646 [inline]
  __x64_sys_write+0x93/0xd0 fs/read_write.c:646
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Local variable mp_opt created at:
  subflow_check_req+0x6d/0x15d0 net/mptcp/subflow.c:145
  subflow_v6_route_req+0x269/0x410 net/mptcp/subflow.c:367

CPU: 1 PID: 5924 Comm: syz-executor.3 Not tainted 6.7.0-rc8-syzkaller-00055-g5eff55d725a4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023

Fixes: f296234c98a8 ("mptcp: Add handling of incoming MP_JOIN requests")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Florian Westphal <fw@strlen.de>
Cc: Peter Krystad <peter.krystad@linux.intel.com>
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang.tang@linux.dev>
---
 net/mptcp/subflow.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 103ff5471993a8490c4e1e77f404ec7df4e2c6e3..13039ac8d1ab641fb9b22b621ac011e6a7bc9e37 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -158,7 +158,7 @@ static int subflow_check_req(struct request_sock *req,
 	mptcp_get_options(skb, &mp_opt);
 
 	opt_mp_capable = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPC);
-	opt_mp_join = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ);
+	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_SYN);
 	if (opt_mp_capable) {
 		SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MPCAPABLEPASSIVE);
 
@@ -255,7 +255,7 @@ int mptcp_subflow_init_cookie_req(struct request_sock *req,
 	mptcp_get_options(skb, &mp_opt);
 
 	opt_mp_capable = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPC);
-	opt_mp_join = !!(mp_opt.suboptions & OPTIONS_MPTCP_MPJ);
+	opt_mp_join = !!(mp_opt.suboptions & OPTION_MPTCP_MPJ_ACK);
 	if (opt_mp_capable && opt_mp_join)
 		return -EINVAL;
 
-- 
2.43.0.275.g3460e3d667-goog


