Return-Path: <netdev+bounces-196691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90831AD5F1E
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 21:36:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12305189C230
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 19:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12FB81E51EC;
	Wed, 11 Jun 2025 19:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGnj6afH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B3D6FBF
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 19:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670573; cv=none; b=u/EbQqx3lw1IH8b0Am8c6byKpGCT21FcHHHopi1ZCdNP1AcBCErxuq8P4sRgCBL0V8D+dkzSjqQrj4OeOGv5PlGl9rPk+LathbK+FugnZfsHSS6KTS1SQDfmIY7dW9LwqOum3VCRJse3tm14DVUF877fnMwAn6DuimZqi1AUAk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670573; c=relaxed/simple;
	bh=e0iQWon3hUAvs+dVw2ZKpB9f9QogKdimqcMYBrb4Bc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LHdWtFjr9hL9/76WbhaMQEbZVSHJByib2KLHow5IL4+Op7gaoCV+AZotzfKXGvwPJpVsEl2XKB6g5NZ0uGznFz1fV8ef6vLP9g0xOCBdPk7+tWB2tR9jse+TOulBckOm27fRIQ23nrGMwMaHhR/cctsoHnHxBr8T/JAIsKkWFEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGnj6afH; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-311c95ddfb5so226444a91.2
        for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 12:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749670569; x=1750275369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YxwcOoAM/IWwo+7BwP0yfNVorCb2pj0/2GdVHZFvVXg=;
        b=RGnj6afHWRoBO1Uju9qlGpeN+QNBptXnWNAJ0ZhnNmFHSpCj6PI8ht9Qc7GYmouvEi
         +yzWGRmyMoyWnTAU6U8AUoQuvZKp2hhkFveqGMFuEnX5mukYfYVVQNlEvW/g4nfBhtxY
         jQDfkP2WQSJaz9BppnAmA+kmDh6Mv1pwymYY5T2LNsknHx2+w/t/vZN8XMWNaLdG1V/8
         uF9OOLe0jcn0YFPtFHWX5OxX2joN6QoB/HalI5SkCQZcbITm52EbglLdx8vBMBZg+5OK
         HvxKy7/56WW49SYZy6wreOQADEaJG9jtZvR6/TRk8GZprpFjJr6WZLMKR3BhdDWPVI77
         SH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749670569; x=1750275369;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxwcOoAM/IWwo+7BwP0yfNVorCb2pj0/2GdVHZFvVXg=;
        b=BCbERYawQITKP7pRXIU6YJVjLF5rryiL7s8ltcQOPetIL+i2s1pcHPHuO09ZZmU927
         CL2yX5l+utm/1VgPabz8h0guyS/d6qhOLQHxgvnijQeFG3wBcfRsnPq097kcgL4DLnyy
         qf5aG0KaPyer8eDyrL86QColqrH6FY1Yi2X+DY1Q8wNxummznssmXcj0t8cLUS57zdfJ
         dKVtT/XQYbuuKHD7dgjyjhwiGigVy0YIuwsWp31DEcxpBrML787+a0VGrddTDbaNQE51
         miSw8f0TtRKjlC8LpN8LTIB0r8u6CJ4yLFfw4PXbSgV1WtJZDAgEgmon7wkMChbZwWCd
         0T0A==
X-Forwarded-Encrypted: i=1; AJvYcCVLcfTYkCWK47a7fJOd4LGMPqEna9XB7AmZ9h1zUqc39bXJFMj7p0UPdPRiSastyDpWir/+WQs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwK1eV6abLKQEb7cZI9EIAveBqrTw4G0uh/Bif7mpv2vl8Vh3Ju
	EPsc9Du0QHkYNR3AaAt6nEUS7BXWAuaQ8HX1BsKhUW/C4T/YEkdo7Gc=
X-Gm-Gg: ASbGncsPQnEztwJgG2mxXP3wZBCmIUjKg3P4Mq51g7FwszhFjUEE1R0XhXthEr+8Smf
	5vfy80VO/WW4ieMCSTDueWW3SmMLehUwAjaF510RWFKyYJcA/5U4bkvfOfIYVOwqnoxxQThPSHO
	MwnHxcq0KDfOIncKX8Pt/R4TrQTm4qV8vcX4QHAUOLzQRK/Z73YrImRa0qnkm4kI0O+QPjVj6hP
	1fOIVqT+qAQTfzaRC4jTdGatnjzWkfGQWR58COPc3Bw6npQDKo5TrvAkRYa4EVYoMseEVVXaGdv
	uqq3OiZ2p6FqDsvGGSkAuIl3PmeW9iRPrtpXg9LFUAmouUA3RQ==
X-Google-Smtp-Source: AGHT+IHjeHsYZR422ksFbPkEIVqQbQ314QRg2Wj+t3KcJJQMaP6rwYUKfIjJM6r3j1ygtRHAIHu7nQ==
X-Received: by 2002:a17:90b:574d:b0:312:1b53:5e98 with SMTP id 98e67ed59e1d1-313bfbe8a42mr926256a91.34.1749670568961;
        Wed, 11 Jun 2025 12:36:08 -0700 (PDT)
Received: from fedora.. ([2601:647:6700:3390::c8d1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c12c1616sm30869a91.49.2025.06.11.12.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 12:36:08 -0700 (PDT)
From: Kuniyuki Iwashima <kuni1840@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>,
	netdev@vger.kernel.org,
	syzbot+4c2358694722d304c44e@syzkaller.appspotmail.com
Subject: [PATCH v1 net] ipv6: Move fib6_config_validate() to ip6_route_add().
Date: Wed, 11 Jun 2025 12:35:02 -0700
Message-ID: <20250611193551.2999991-1-kuni1840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

syzkaller created an IPv6 route from a malformed packet, which has
a prefix len > 128, triggering the splat below. [0]

This is a similar issue fixed by commit 586ceac9acb7 ("ipv6: Restore
fib6_config validation for SIOCADDRT.").

The cited commit removed fib6_config validation from some callers
of ip6_add_route().

Let's move the validation back to ip6_route_add() and
ip6_route_multipath_add().

[0]:
UBSAN: array-index-out-of-bounds in ./include/net/ipv6.h:616:34
index 20 is out of range for type '__u8 [16]'
CPU: 1 UID: 0 PID: 7444 Comm: syz.0.708 Not tainted 6.16.0-rc1-syzkaller-g19272b37aa4f #0 PREEMPT
Hardware name: riscv-virtio,qemu (DT)
Call Trace:
[<ffffffff80078a80>] dump_backtrace+0x2e/0x3c arch/riscv/kernel/stacktrace.c:132
[<ffffffff8000327a>] show_stack+0x30/0x3c arch/riscv/kernel/stacktrace.c:138
[<ffffffff80061012>] __dump_stack lib/dump_stack.c:94 [inline]
[<ffffffff80061012>] dump_stack_lvl+0x12e/0x1a6 lib/dump_stack.c:120
[<ffffffff800610a6>] dump_stack+0x1c/0x24 lib/dump_stack.c:129
[<ffffffff8001c0ea>] ubsan_epilogue+0x14/0x46 lib/ubsan.c:233
[<ffffffff819ba290>] __ubsan_handle_out_of_bounds+0xf6/0xf8 lib/ubsan.c:455
[<ffffffff85b363a4>] ipv6_addr_prefix include/net/ipv6.h:616 [inline]
[<ffffffff85b363a4>] ip6_route_info_create+0x8f8/0x96e net/ipv6/route.c:3793
[<ffffffff85b635da>] ip6_route_add+0x2a/0x1aa net/ipv6/route.c:3889
[<ffffffff85b02e08>] addrconf_prefix_route+0x2c4/0x4e8 net/ipv6/addrconf.c:2487
[<ffffffff85b23bb2>] addrconf_prefix_rcv+0x1720/0x1e62 net/ipv6/addrconf.c:2878
[<ffffffff85b92664>] ndisc_router_discovery+0x1a06/0x3504 net/ipv6/ndisc.c:1570
[<ffffffff85b99038>] ndisc_rcv+0x500/0x600 net/ipv6/ndisc.c:1874
[<ffffffff85bc2c18>] icmpv6_rcv+0x145e/0x1e0a net/ipv6/icmp.c:988
[<ffffffff85af6798>] ip6_protocol_deliver_rcu+0x18a/0x1976 net/ipv6/ip6_input.c:436
[<ffffffff85af8078>] ip6_input_finish+0xf4/0x174 net/ipv6/ip6_input.c:480
[<ffffffff85af8262>] NF_HOOK include/linux/netfilter.h:317 [inline]
[<ffffffff85af8262>] NF_HOOK include/linux/netfilter.h:311 [inline]
[<ffffffff85af8262>] ip6_input+0x16a/0x70c net/ipv6/ip6_input.c:491
[<ffffffff85af8dcc>] ip6_mc_input+0x5c8/0x1268 net/ipv6/ip6_input.c:588
[<ffffffff85af6112>] dst_input include/net/dst.h:469 [inline]
[<ffffffff85af6112>] ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
[<ffffffff85af6112>] NF_HOOK include/linux/netfilter.h:317 [inline]
[<ffffffff85af6112>] NF_HOOK include/linux/netfilter.h:311 [inline]
[<ffffffff85af6112>] ipv6_rcv+0x5ae/0x6e0 net/ipv6/ip6_input.c:309
[<ffffffff85087e84>] __netif_receive_skb_one_core+0x106/0x16e net/core/dev.c:5977
[<ffffffff85088104>] __netif_receive_skb+0x2c/0x144 net/core/dev.c:6090
[<ffffffff850883c6>] netif_receive_skb_internal net/core/dev.c:6176 [inline]
[<ffffffff850883c6>] netif_receive_skb+0x1aa/0xbf2 net/core/dev.c:6235
[<ffffffff8328656e>] tun_rx_batched.isra.0+0x430/0x686 drivers/net/tun.c:1485
[<ffffffff8329ed3a>] tun_get_user+0x2952/0x3d6c drivers/net/tun.c:1938
[<ffffffff832a21e0>] tun_chr_write_iter+0xc4/0x21c drivers/net/tun.c:1984
[<ffffffff80b9b9ae>] new_sync_write fs/read_write.c:593 [inline]
[<ffffffff80b9b9ae>] vfs_write+0x56c/0xa9a fs/read_write.c:686
[<ffffffff80b9c2be>] ksys_write+0x126/0x228 fs/read_write.c:738
[<ffffffff80b9c42e>] __do_sys_write fs/read_write.c:749 [inline]
[<ffffffff80b9c42e>] __se_sys_write fs/read_write.c:746 [inline]
[<ffffffff80b9c42e>] __riscv_sys_write+0x6e/0x94 fs/read_write.c:746
[<ffffffff80076912>] syscall_handler+0x94/0x118 arch/riscv/include/asm/syscall.h:112
[<ffffffff8637e31e>] do_trap_ecall_u+0x396/0x530 arch/riscv/kernel/traps.c:341
[<ffffffff863a69e2>] handle_exception+0x146/0x152 arch/riscv/kernel/entry.S:197

Fixes: fa76c1674f2e ("ipv6: Move some validation from ip6_route_info_create() to rtm_to_fib6_config().")
Reported-by: syzbot+4c2358694722d304c44e@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6849b8c3.a00a0220.1eb5f5.00f0.GAE@google.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/route.c | 110 +++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 55 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 0143262094b0..79c8f1acf8a3 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3737,6 +3737,53 @@ void fib6_nh_release_dsts(struct fib6_nh *fib6_nh)
 	}
 }
 
+static int fib6_config_validate(struct fib6_config *cfg,
+				struct netlink_ext_ack *extack)
+{
+	/* RTF_PCPU is an internal flag; can not be set by userspace */
+	if (cfg->fc_flags & RTF_PCPU) {
+		NL_SET_ERR_MSG(extack, "Userspace can not set RTF_PCPU");
+		goto errout;
+	}
+
+	/* RTF_CACHE is an internal flag; can not be set by userspace */
+	if (cfg->fc_flags & RTF_CACHE) {
+		NL_SET_ERR_MSG(extack, "Userspace can not set RTF_CACHE");
+		goto errout;
+	}
+
+	if (cfg->fc_type > RTN_MAX) {
+		NL_SET_ERR_MSG(extack, "Invalid route type");
+		goto errout;
+	}
+
+	if (cfg->fc_dst_len > 128) {
+		NL_SET_ERR_MSG(extack, "Invalid prefix length");
+		goto errout;
+	}
+
+#ifdef CONFIG_IPV6_SUBTREES
+	if (cfg->fc_src_len > 128) {
+		NL_SET_ERR_MSG(extack, "Invalid source address length");
+		goto errout;
+	}
+
+	if (cfg->fc_nh_id && cfg->fc_src_len) {
+		NL_SET_ERR_MSG(extack, "Nexthops can not be used with source routing");
+		goto errout;
+	}
+#else
+	if (cfg->fc_src_len) {
+		NL_SET_ERR_MSG(extack,
+			       "Specifying source address requires IPV6_SUBTREES to be enabled");
+		goto errout;
+	}
+#endif
+	return 0;
+errout:
+	return -EINVAL;
+}
+
 static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 					       gfp_t gfp_flags,
 					       struct netlink_ext_ack *extack)
@@ -3886,6 +3933,10 @@ int ip6_route_add(struct fib6_config *cfg, gfp_t gfp_flags,
 	struct fib6_info *rt;
 	int err;
 
+	err = fib6_config_validate(cfg, extack);
+	if (err)
+		return err;
+
 	rt = ip6_route_info_create(cfg, gfp_flags, extack);
 	if (IS_ERR(rt))
 		return PTR_ERR(rt);
@@ -4479,53 +4530,6 @@ void rt6_purge_dflt_routers(struct net *net)
 	rcu_read_unlock();
 }
 
-static int fib6_config_validate(struct fib6_config *cfg,
-				struct netlink_ext_ack *extack)
-{
-	/* RTF_PCPU is an internal flag; can not be set by userspace */
-	if (cfg->fc_flags & RTF_PCPU) {
-		NL_SET_ERR_MSG(extack, "Userspace can not set RTF_PCPU");
-		goto errout;
-	}
-
-	/* RTF_CACHE is an internal flag; can not be set by userspace */
-	if (cfg->fc_flags & RTF_CACHE) {
-		NL_SET_ERR_MSG(extack, "Userspace can not set RTF_CACHE");
-		goto errout;
-	}
-
-	if (cfg->fc_type > RTN_MAX) {
-		NL_SET_ERR_MSG(extack, "Invalid route type");
-		goto errout;
-	}
-
-	if (cfg->fc_dst_len > 128) {
-		NL_SET_ERR_MSG(extack, "Invalid prefix length");
-		goto errout;
-	}
-
-#ifdef CONFIG_IPV6_SUBTREES
-	if (cfg->fc_src_len > 128) {
-		NL_SET_ERR_MSG(extack, "Invalid source address length");
-		goto errout;
-	}
-
-	if (cfg->fc_nh_id && cfg->fc_src_len) {
-		NL_SET_ERR_MSG(extack, "Nexthops can not be used with source routing");
-		goto errout;
-	}
-#else
-	if (cfg->fc_src_len) {
-		NL_SET_ERR_MSG(extack,
-			       "Specifying source address requires IPV6_SUBTREES to be enabled");
-		goto errout;
-	}
-#endif
-	return 0;
-errout:
-	return -EINVAL;
-}
-
 static void rtmsg_to_fib6_config(struct net *net,
 				 struct in6_rtmsg *rtmsg,
 				 struct fib6_config *cfg)
@@ -4563,10 +4567,6 @@ int ipv6_route_ioctl(struct net *net, unsigned int cmd, struct in6_rtmsg *rtmsg)
 
 	switch (cmd) {
 	case SIOCADDRT:
-		err = fib6_config_validate(&cfg, NULL);
-		if (err)
-			break;
-
 		/* Only do the default setting of fc_metric in route adding */
 		if (cfg.fc_metric == 0)
 			cfg.fc_metric = IP6_RT_PRIO_USER;
@@ -5402,6 +5402,10 @@ static int ip6_route_multipath_add(struct fib6_config *cfg,
 	int nhn = 0;
 	int err;
 
+	err = fib6_config_validate(cfg, extack);
+	if (err)
+		return err;
+
 	replace = (cfg->fc_nlinfo.nlh &&
 		   (cfg->fc_nlinfo.nlh->nlmsg_flags & NLM_F_REPLACE));
 
@@ -5636,10 +5640,6 @@ static int inet6_rtm_newroute(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	err = fib6_config_validate(&cfg, extack);
-	if (err)
-		return err;
-
 	if (cfg.fc_metric == 0)
 		cfg.fc_metric = IP6_RT_PRIO_USER;
 
-- 
2.49.0


