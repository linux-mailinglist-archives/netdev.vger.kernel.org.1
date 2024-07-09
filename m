Return-Path: <netdev+bounces-110209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47ABE92B507
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 12:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAA742845F5
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F75156C74;
	Tue,  9 Jul 2024 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GFbjvMbn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222AF156674
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 10:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720520400; cv=none; b=kQC0rc3zeGeT7nqY3SFjQTiw0CPmaTA4FirDMN+tlYeoEoFGV8lBXmVnVg4XCtfMPDsL0eVXJS2zwRMg0UlGafNUis5dtlH4DPaLeI3I6MxXu45XrMNEKT0+T/Uavo4r3EDmAWuKsloB6dmpdJlSuB9NokEIVU3OFoAxBayPeNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720520400; c=relaxed/simple;
	bh=1hlpKuB9Bhnf6iyh2qDuWQVcWhNS4D+IdvrMXKwBarM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=EVa+Hbn8nso5WmB2U+RbXdOh+H6wTNiaQ2Bof2SK+Cwlsg24hVDhC7X6pnGVU+F8qeT6R/4CKNd0ypwHxd45vCR0ZGybHjwuRks7F5AC6g44pwOwPQr4bKYl/yNBSrPqCEulm5w1W2/avt73dCGs5zdpTE8GZkA4Lv+8OyaMWiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GFbjvMbn; arc=none smtp.client-ip=209.85.166.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-7f3c5af0a04so250570139f.0
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 03:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1720520398; x=1721125198; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6eo/T2MDeFuTGwCTeEol3bq4AUNqiYv36Kk27s7zY+0=;
        b=GFbjvMbnTq2ORe9ArcUxZDk/q5SZQW9UQ9994rZwsHsa4wY/hYsvtRSXGvMlH7iI89
         jycGwD+H3Ve/SXFbbAhjMHOLifaZRBQQXY8eAvgigRS884FmHNTbv7rrZAVCm/zfhP/q
         DwlG4Iu9XhVBaF/0llnjqyWp/e79sSR0ud5bA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720520398; x=1721125198;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6eo/T2MDeFuTGwCTeEol3bq4AUNqiYv36Kk27s7zY+0=;
        b=PuM3ui6r7Xcs9vIFeWrfAT5aHTnClN4fJzH4Hlikx/OHHx71KNP9uS1H3SZVTHKE7w
         TmGcPGZiNh1iOYGq/M+LUSjsYQZ9MH8QQy1+L1XtgZzgePfe/1nK/GWypxCTg2CUWdwD
         i5qZOevpO5WOppRNanYDDwHrXIjueCOGQ8Qpee2s9/9iTbMjapNTNpCO7rIOoLRNChhk
         Ske6uxAjrH5reYvtsu2aKJm4DB7avZZcJQZWuFQJyhsHdcTYN2zWPoc8tw7ZUQ+ShGSD
         ThcmL+FLfIHxYqFVVuhQXjA9Mt+mL6cKfuumzR2yHBmL6bOZL1ZhcFbfHZaTnMAXfHrZ
         Pxbw==
X-Forwarded-Encrypted: i=1; AJvYcCUETDjyHoVn5hRvJVcoFajik2y0NsI7XMkLF2xVWi8RMkVKsgpUmB88AItopDnbDv4gIWshPEZRrqAXVGcvg3J94UtTKqf8
X-Gm-Message-State: AOJu0YyyWgUzMPenkRL6Rq4IBA6KHU6Za2qPzLcYXJMoBfheyNgHxnYl
	mXhlpSfKdbQSlz2nRQCQ37H2cl2FHoQi3J48YxFUVuO35+fz0aSfIs4uu3g/fg==
X-Google-Smtp-Source: AGHT+IGVeRx4E+l9eXcBpFewtCojZ3GAL+3nL22Gtq5ScRBbs8/g0Vz6xgC5/Q/KF+PA5BI7nJl6eQ==
X-Received: by 2002:a05:6602:164b:b0:7f3:cd10:40b3 with SMTP id ca18e2360f4ac-7ffffe21e74mr312552739f.1.1720520398192;
        Tue, 09 Jul 2024 03:19:58 -0700 (PDT)
Received: from kashwindayan-virtual-machine.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43967345sm1426016b3a.112.2024.07.09.03.19.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2024 03:19:58 -0700 (PDT)
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
Subject: [PATCH v5.15 2/2] net/ipv6: prevent NULL dereference in ip6_output()
Date: Tue,  9 Jul 2024 15:49:44 +0530
Message-Id: <1720520384-9690-3-git-send-email-ashwin.kamat@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1720520384-9690-1-git-send-email-ashwin.kamat@broadcom.com>
References: <1720520384-9690-1-git-send-email-ashwin.kamat@broadcom.com>
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
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
Link: https://lore.kernel.org/r/20240507161842.773961-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[Ashwin: Regenerated the Patch for v5.15]
Signed-off-by: Ashwin Dayanand Kamat <ashwin.kamat@broadcom.com>
---
 net/ipv6/ip6_output.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 770ee7ffb0d5..ce37c8345579 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -221,7 +221,7 @@ int ip6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IPV6);
 	skb->dev = dev;
 
-	if (unlikely(READ_ONCE(idev->cnf.disable_ipv6))) {
+	if (unlikely(!idev || READ_ONCE(idev->cnf.disable_ipv6))) {
 		IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTDISCARDS);
 		kfree_skb(skb);
 		return 0;
-- 
2.45.1


