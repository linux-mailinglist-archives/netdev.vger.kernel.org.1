Return-Path: <netdev+bounces-110213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F65892B523
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5BFA1F22F2A
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14524156F40;
	Tue,  9 Jul 2024 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IdPRZXHo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D75F15698B
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520584; cv=none; b=HVGrCfxWxBaLGiSTo/TDTU5OyadqSNZjPFKFqeco4nVRZpAfnNjKx51Pouap4e+i8pDk+ZO8gW+MVorSmtwHbyKJjbmVeOqGs37rhPY8ZXYRWzU+p+05bZuusOSuuetzQ9UUzwwtU5wdrNu2VpcH692P8jYNMEj0E86dkUaFHtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520584; c=relaxed/simple;
	bh=shZBn9O6tDZqsTAj9UATwUocjlYxEwemiZOAFeghCdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=tmFZyVLZw/7KHUlr6eCDcfjYVi04tDPWV4SfHbVl+2y7IXisUIZIDhDVTxBVQVzL5cYQi/4cCZUho6s/l3IUWelfE3pB3ksq5hN57Q2KMpQ/LBRldYevpD/0WQBCoAmawxDqLsC1CTi4v/t/VYlNzOXBxqQ9h2QfQAo6OQn+bQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=IdPRZXHo; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-1fb3b7d0d3aso26790055ad.2
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 03:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720520582; x=1721125382; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TjUlVhcBSrZG9pW+ab6mrCPR/9xRt4gi/qaCx2Wysw8=;
        b=IdPRZXHo0HryBOkipJ8My5DrG7sYuMS/KnPFkCQckWQrh2ljnCG3JP+tWZeq0pt5Wl
         cjuNPPhrIKc3cpI5sFBW771MSmB0J++RjKEoCmdHHEn8EkYrqSAmbdwV8/9qRPSs5Cd6
         yKjlRZhFgYk74h6b2iVVCgZkRTWO8/jZIXFnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520582; x=1721125382;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TjUlVhcBSrZG9pW+ab6mrCPR/9xRt4gi/qaCx2Wysw8=;
        b=bPhBA9Koa22NTX+bTUze3h+Sri16ZHxzP6Yb/g2xKLEKokWZE8nTwyqw+1dhSNmD0I
         UA7ajNM1mutnu0HfHkqTWNJ5Qm4K9xM61VOIsn2Hc089xeeinkBMx4vT8Rm3t44N9vud
         /1B+LFujJ8Dxt7sCB9B6McVroA2WLqeR12IyiW0W7CTGNpgk63x3ZgM6dq3ophBaWBlK
         IjJh1ZGuGidLqQDrE2NfkvLCdMEJS3mvjHbKFdUHnKS386Kw6y4d/g2S1EwRnNr5Msgb
         F9iZ+ZtshVbuC3hXeti5i14wDaUMUnWNybxq5fDcbj8YCjCbO8cmDvRMjKxGmnGMcEY8
         hDAA==
X-Forwarded-Encrypted: i=1; AJvYcCWuCOfGwJNZnryHXPOjiVTJMflmOI0g406LMFNXSnInpTQg2ASrFXzxqXD3FZIVl9eIIlBrvChI+ov+y4ixJjo4gv1ZvM1P
X-Gm-Message-State: AOJu0Yz5Hfrv1F7ejAcU7i3nKwrRbsdWIpLQ9XoW9yguapvndUzv2v4E
	+pF+ssb4ZRJGbfFy3nFPduFW/7q8spnXdLQ/975iL70d+pfy2bzDcs9WIKxcCQ==
X-Google-Smtp-Source: AGHT+IHHhfYP/usTymLr9Nc0xnCzRg4Vr9DrYxFrPK0z+o/YRUvUx7r46S2Nxb/v+kszqDPCfjsdjw==
X-Received: by 2002:a17:903:984:b0:1fb:72ea:376 with SMTP id d9443c01a7336-1fbb6e87fc5mr17619895ad.65.1720520581773;
        Tue, 09 Jul 2024 03:23:01 -0700 (PDT)
Received: from kashwindayan-virtual-machine.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6a11757sm12832525ad.35.2024.07.09.03.23.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2024 03:23:01 -0700 (PDT)
From: Ashwin Kamat <ashwin.kamat@broadcom.com>
To: linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	davem@davemloft.net,
	yoshfuji@linux-ipv6.org,
	dsahern@kernel.org,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	florian.fainelli@broadcom.com,
	ajay.kaher@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	tapas.kundu@broadcom.com,
	ashwin.kamat@broadcom.com,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH v5.10 2/2] net/ipv6: prevent NULL dereference in ip6_output()
Date: Tue,  9 Jul 2024 15:52:50 +0530
Message-Id: <1720520570-9904-3-git-send-email-ashwin.kamat@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1720520570-9904-1-git-send-email-ashwin.kamat@broadcom.com>
References: <1720520570-9904-1-git-send-email-ashwin.kamat@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

From: Eric Dumazet <edumazet@google.com>

[Upstream commit 4db783d68b9b39a411a96096c10828ff5dfada7a]

According to syzbot, there is a chance that ip6_dst_idev()
returns NULL in ip6_output(). Most places in IPv6 stack
deal with a NULL idev just fine, but not here.

syzbot reported:

general protection fault, probably for non-canonical address 0xdffffc00000000bc: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000005e0-0x00000000000005e7]
CPU: 0 PID: 9775 Comm: syz-executor.4 Not tainted 6.9.0-rc5-syzkaller-00157-g6a30653b604a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
 RIP: 0010:ip6_output+0x231/0x3f0 net/ipv6/ip6_output.c:237
Code: 3c 1e 00 49 89 df 74 08 4c 89 ef e8 19 58 db f7 48 8b 44 24 20 49 89 45 00 49 89 c5 48 8d 9d e0 05 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 4c 8b 74 24 28 0f 85 61 01 00 00 8b 1b 31 ff                                              RSP: 0018:ffffc9000927f0d8 EFLAGS: 00010202
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
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Link: https://lore.kernel.org/r/20240507161842.773961-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Ashwin: Regenerated the Patch for v5.10]
Signed-off-by: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
---
 net/ipv6/ip6_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 2b55bf0d3..32512b8ca 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -240,7 +240,7 @@ int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
 
-	if (unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
+	if (unlikely(!idev || READ_ONCE(idev->cnf.disable_ipv6))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 		kfree_skb(skb);
 		return 0;
-- 
2.45.1


