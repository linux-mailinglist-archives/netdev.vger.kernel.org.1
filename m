Return-Path: <netdev+bounces-275388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKiMN+Eo0WkXGAcAu9opvQ
	(envelope-from <netdev+bounces-275388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:06:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4498739B7A0
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BCBC1300EF65
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 15:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB4D2C234A;
	Sat,  4 Apr 2026 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHyply/w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92BF2749ED
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315116; cv=none; b=LhxIsusmpPyqNYcnwMDVQy3PcpuQ59hnBMbwjDXOuo1biW5RWyq4DGuzcOgeFX+CXXiF+dSmB12WA0ffASKmb3dzjSShpGzwluNKIRgUh5Du1gD6aKLHBuLdID+lPss6b7vCAa5ObtjXnKkBJ1wZaQnQt2TmgsUbdD1ktJGMl3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315116; c=relaxed/simple;
	bh=M36wO1iLBeappZvKcrU5VE7BwVOSjSBPOxXAKwOBYy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZhkP6bKKQdvCMe4z2nzyYHPo7MF1oHiiPK7I7lPQwpcVVXUm96CNtex28HhXYGboUKTA6mjzChfIYaN5K/h/Zg9CrrYGU8pUAAzHuN09RYa18tVJkUQCMUzVp+UGG4cXjxW2q/4he8kgL5nyYwvF3hsbADGJOnWueHPto0AaPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHyply/w; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c76e702e01aso63760a12.3
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 08:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775315115; x=1775919915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+SqmaZWSq0c/sFy4TW4UeB/Dws2Pj4gNfU8a5P2DD2w=;
        b=MHyply/wsr39x12rJle6UeJrlFibm7c1vyhFPHLAF8tZbYhntfaDcwF15mbB1e7Ebp
         6EVQtXjW7hK/n4bTIlggfJOfXkgytb5FkF38HA+grjie37Zpnk9VRCMu65rJHs7ZAN2p
         5PRcJUuus0phqiOep0DF/RbBcQBxb2HP6sCKRMlPq5e5WG0tHTNjqq4WRaaCQ6X80oQF
         JyTOHYaQWbduHhqXqaKTQHJcmvqUot1OnpRbQM0vqWg+zEC9UmsXYU0heaLRBqoTgT82
         A4dBy1pUui5DOwMQvrSpKgZ0FVWrUtnYjZKYb2Wj/rbA8D8anXSOXz+0qhrCNN38WMb8
         VcRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775315115; x=1775919915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+SqmaZWSq0c/sFy4TW4UeB/Dws2Pj4gNfU8a5P2DD2w=;
        b=YInF0dMZB3trmIA3Jl/sEDJecH3z3LmhB3tmzBS86QUPVZcAau+qUZXLe5cUr19oJ8
         D+s9p1YGI7tq1YrdXevM95zrqlGvAX+C5k4CiJ+m/ONpYzZmniQ91FwQmPAkWkeprfaD
         o/nsp+SmkM+4wbQHExOekDdOfnjw1JjwxvkcCWBg78ORu8wuMzsm2wJt2DkBmGHHxheH
         lZNOqmBHNUbyMmCzBLc3zrOt5f7p5fR6AlbQ5Ed+kszIhDp8+/XbjfythE4xkrVXvj6A
         TniVlnsgu2Ve7gmneNIDk2mle+52Ml9uYdoxEmHEcOxVaD7j9SVQe9Dr5PTRHyhYty3F
         IpfA==
X-Gm-Message-State: AOJu0YwhtLOtCA+ZIOHdeXBAoc6jx99u+ephjPbCOVQg6skanG76thVj
	Q6bcuI90v+W0pzpMirLlAJByJiL+P1qh2sGz2RD9GmbEZR1LD7UVGuyeEfUnoG9Xq50=
X-Gm-Gg: AeBDieul+FIJiBVafBxitZcydpA7l+Hyc1wh94tFVyKPHWJIvgltCcrbc7ANU5brXbw
	TFshLE7J4dO21mp05rYeP7ihkizyA4ylauUokKvs2HZjAWSN/EzGoenDxK/Clgoy6rFK8EJeaXd
	1HK0whLMwKHpwoi9bV4kDR5LtFPFv35ha3ZDZhgNZ8k7cOWX5dCj4LapKUm2jYDF2K3+ETKRLug
	J6lmdCqPnxTjiP1SSQQ5XrX9YLXp0i0p0GwBoBQ1ZV0Ri7NQWECpU7PkZp73x9upWg0FCgI6WS1
	NCvzMp1YUqkoaAaSQcPFKnDY9pQVuqK/ay33f0QumRBNF285cXEVBV14bCvE6gzwMW9h/uIypUI
	WrITJlCslu0rHJiaS17Yz865ejhBjdZvN2J5hAYU8aoU2Cz15z/ZsJ9rcZdPvbhQqD+4Wi9T6Yr
	+V0oqLWtoDpTss+luid17NBoU+ybPPLuc2CD4019IurAXERwTeYLflD+x4LHg=
X-Received: by 2002:a05:6a20:2448:b0:39f:2c96:e0cf with SMTP id adf61e73a8af0-39f2f0b2d05mr6892022637.18.1775315114591;
        Sat, 04 Apr 2026 08:05:14 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([121.25.96.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65935cbsm8051444a12.26.2026.04.04.08.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:05:13 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	willemb@google.com,
	martin.lau@kernel.org
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>,
	Yushan Zhou <katrinzhou@tencent.com>
Subject: [PATCH net-next v2 3/4] bpf-timestamp: keep track of the skb when wait_for_space occurs
Date: Sat,  4 Apr 2026 23:04:51 +0800
Message-Id: <20260404150452.83904-4-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260404150452.83904-1-kerneljasonxing@gmail.com>
References: <20260404150452.83904-1-kerneljasonxing@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275388-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4498739B7A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

The patch is the 1/2 part of push-level granularity feature.

Tag the skb in tcp_sendmsg_locked() when wait_for_space occurs even
though it might not carry the last byte of the sendmsg.

Prior to the patch, BPF timestamping cannot cover this case:
The following steps reproduce this:
1) skb A is the current last skb before entering wait_for_space process
2) tcp_push() pushes A without any tag
3) A is transmitted from TCP to driver without putting any skb carrying
   timestamps in the error queue, like SCHED, DRV/HARDWARE.
4) sk_stream_wait_memory() sleeps for a while and then returns with an
   error code. Note that the socket lock is released.
5) skb A finally gets acked and removed from the rtx queue.
6) continue with the rest of tcp_sendmsg_locked(): it will jump to(goto)
   'do_error' label and then 'out' label.
7) at this moment, skb A turns out to be the last one in this send
   syscall, and miss the following tcp_bpf_tx_timestamp() opportunity
   before the final tcp_push()
8) BPF script fails to see any timestamps this time

Signed-off-by: Yushan Zhou <katrinzhou@tencent.com>
Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 net/ipv4/tcp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index c603b90057f6..7d030a11d004 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1400,9 +1400,11 @@ int tcp_sendmsg_locked(struct sock *sk, struct msghdr *msg, size_t size)
 wait_for_space:
 		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		tcp_remove_empty_skb(sk);
-		if (copied)
+		if (copied) {
+			tcp_bpf_tx_timestamp(sk);
 			tcp_push(sk, flags & ~MSG_MORE, mss_now,
 				 TCP_NAGLE_PUSH, size_goal);
+		}
 
 		err = sk_stream_wait_memory(sk, &timeo);
 		if (err != 0)
-- 
2.41.3


