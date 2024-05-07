Return-Path: <netdev+bounces-94173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D05FC8BE891
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 18:18:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450051F27944
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 16:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2102D168AFD;
	Tue,  7 May 2024 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVA9xhyb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95701156F57
	for <netdev@vger.kernel.org>; Tue,  7 May 2024 16:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715098727; cv=none; b=QR2ttyZ0FxkNEA6X90xncNeuwNWe+XjZ435DaOXAlZEgnkRB8zBXt+FMTlNkulRVmEkfi6Nn/47hJpVrsiVnEM5ZYdR9LKOCrFeflQNhWht1XEq4nPhON7z268cM1mFH1QVzVaMMZHgAVcpiwf7Mcksf0pG8nEzM9XrECUFcgZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715098727; c=relaxed/simple;
	bh=6Q2n79LDESI6i50jya043KMGWqYlSeunvJeO52hlaVs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HUmF/jVPyZVjCggj/tTlmPZlDRjiEG8sf2kDWCwf4hhI1wMlxZj0SHOLLeRevVzg5kIRfPf8pM6j5EtfTEb+4dGHXDNUiMSN8xF/sAosrnuU2MPjULlrCkcONWBokFb4PLQsPY8iSdxuR7w4MSvhmxXdllilN6/m1SO+iuj/zys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVA9xhyb; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-deb45f85880so5780068276.2
        for <netdev@vger.kernel.org>; Tue, 07 May 2024 09:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715098724; x=1715703524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VFlao/MnSxk7bNXmWRbxJxCzyyIwCv2wGgQAPF8miwQ=;
        b=wVA9xhyb2Fj5LCSRXz2M6KfMxAr2SEZICIvVYhZwoGmJGNT2TtmCzt230Nua56/xn6
         rObrI7j07wVxGR2YTMBvr4tIw/qfVzeAGW76p/YM6W13sOhIo5ZvS6Rbc4lt3rC8d+Cw
         MZXB15Fo6+QrzGpr8inmt7h6EZ0/4mBzcMCnHv44j3o7Fy/jr/BQpDTDKM5BZcum3UB8
         +FkFfnyTvXGoTLrQK0OlziTlriv2a24z9N9R2Gau/F8k1udKFGFysGu4PnOnHsz7eARN
         tfsyw9bg67TgLRhJzjQ3uuVixp4dOPS9teeuF5/9HOH/eeafE7W/w7tX1QsUQxeJXXqr
         mJdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715098724; x=1715703524;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VFlao/MnSxk7bNXmWRbxJxCzyyIwCv2wGgQAPF8miwQ=;
        b=UhJMeXQtWdsHqlIccGj3DVpALuy7rGe+XgBquvjbqvo9+TBBfMk5o6b2cT6LrhjgTh
         Z0gDUC5hfqM/AWorl3N9/NtPVfwOXrEKePgutRHB7+DbxXEn6wc3x46M4jKMgmDXlqQo
         zU4OEkjXf1pl0VQLv6x97ybmqaId4rPlZ7WTyt6IwVB3k+2lKmt8J6Cwp0lvcbvflMQh
         GAfYmcEn/gecZcWLYXTJaWYUKtHW52jOOTlRaZXE5Lr84IywSmHbehWD4biIykjg24sr
         NpD6eYVtZXU1FJKO+g5rgOiwTKX+mm6I7ajAbS/Sj7oPE1TCubTGaX7WxMXTR4uvpaqc
         sKUQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQ7D1megbZijGadHzeMLfAKp/qi3UosDqKClTdN3yShm7gjH3t7kusWoltfW4ZUv0JxkpNQ45u8aLG5ns3drfY4ILz4PI8
X-Gm-Message-State: AOJu0YzR7xAzbuHeu0dDbUOUB4waGRIa/V1y28qo8Zt8jZzPFuUGsXXX
	fBUNloA1b3faKSxZ/l65/edBvjBUvSGfCfj8B8DSGaSGap+0i0nDEOyCph413e6JMOlD8iubuIn
	pdel3JGWOgg==
X-Google-Smtp-Source: AGHT+IGscY0ckkMQW61yww8hFWgaHCMkxnMbys0mLFPWDpN/qan9h2112RZUqlKXMHpQbup813KFsJy9V4S3ZA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1509:b0:de5:78:34d2 with SMTP id
 3f1490d57ef6-debb9d0ac78mr7151276.6.1715098724654; Tue, 07 May 2024 09:18:44
 -0700 (PDT)
Date: Tue,  7 May 2024 16:18:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Message-ID: <20240507161842.773961-1-edumazet@google.com>
Subject: [PATCH net] ipv6: prevent NULL dereference in ip6_output()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

According to syzbot, there is a chance that ip6_dst_idev()
returns NULL in ip6_output(). Most places in IPv6 stack
deal with a NULL idev just fine, but not here.

syzbot reported:

general protection fault, probably for non-canonical address 0xdffffc00000000bc: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000005e0-0x00000000000005e7]
CPU: 0 PID: 9775 Comm: syz-executor.4 Not tainted 6.9.0-rc5-syzkaller-00157-g6a30653b604a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
 RIP: 0010:ip6_output+0x231/0x3f0 net/ipv6/ip6_output.c:237
Code: 3c 1e 00 49 89 df 74 08 4c 89 ef e8 19 58 db f7 48 8b 44 24 20 49 89 45 00 49 89 c5 48 8d 9d e0 05 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 4c 8b 74 24 28 0f 85 61 01 00 00 8b 1b 31 ff
RSP: 0018:ffffc9000927f0d8 EFLAGS: 00010202
RAX: 00000000000000bc RBX: 00000000000005e0 RCX: 0000000000040000
RDX: ffffc900131f9000 RSI: 0000000000004f47 RDI: 0000000000004f48
RBP: 0000000000000000 R08: ffffffff8a1f0b9a R09: 1ffffffff1f51fad
R10: dffffc0000000000 R11: fffffbfff1f51fae R12: ffff8880293ec8c0
R13: ffff88805d7fc000 R14: 1ffff1100527d91a R15: dffffc0000000000
FS:  00007f135c6856c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 0000000064096000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
  NF_HOOK include/linux/netfilter.h:314 [inline]
  ip6_xmit+0xefe/0x17f0 net/ipv6/ip6_output.c:358
  sctp_v6_xmit+0x9f2/0x13f0 net/sctp/ipv6.c:248
  sctp_packet_transmit+0x26ad/0x2ca0 net/sctp/output.c:653
  sctp_packet_singleton+0x22c/0x320 net/sctp/outqueue.c:783
  sctp_outq_flush_ctrl net/sctp/outqueue.c:914 [inline]
  sctp_outq_flush+0x6d5/0x3e20 net/sctp/outqueue.c:1212
  sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
  sctp_do_sm+0x59cc/0x60c0 net/sctp/sm_sideeffect.c:1169
  sctp_primitive_ASSOCIATE+0x95/0xc0 net/sctp/primitive.c:73
  __sctp_connect+0x9cd/0xe30 net/sctp/socket.c:1234
  sctp_connect net/sctp/socket.c:4819 [inline]
  sctp_inet_connect+0x149/0x1f0 net/sctp/socket.c:4834
  __sys_connect_file net/socket.c:2048 [inline]
  __sys_connect+0x2df/0x310 net/socket.c:2065
  __do_sys_connect net/socket.c:2075 [inline]
  __se_sys_connect net/socket.c:2072 [inline]
  __x64_sys_connect+0x7a/0x90 net/socket.c:2072
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 778d80be5269 ("ipv6: Add disable_ipv6 sysctl to disable IPv6 operaion on specific interface.")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/ip6_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index b9dd3a66e4236fbf67af75c5f98c921b38c18bf6..8f67a43843bbf856ac706fc7cbb28cc08ea0e6d0 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -234,7 +234,7 @@ int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
 
-	if (unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
+	if (unlikely(!idev || READ_ONCE(idev->cnf.disable_ipv6))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 		kfree_skb_reason(skb, SKB_DROP_REASON_IPV6DISABLED);
 		return 0;
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog


