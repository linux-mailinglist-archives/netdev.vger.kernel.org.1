Return-Path: <netdev+bounces-275385-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDadAKMo0WkXGAcAu9opvQ
	(envelope-from <netdev+bounces-275385-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:05:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7C539B76D
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 17:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D80D0300D33E
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 15:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BBEF2749ED;
	Sat,  4 Apr 2026 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ad7qqnA6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB8123D7CE
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775315104; cv=none; b=l3xY3qJOZfc55qMrzGrJxR1Yr5iHrjoy9n3BOHuD3Iwm+wGmFhWRo/SMX4LAr2C3B2v5ywOzJS0IzzMIvB34euHx3CUq2NZj/ncBYHv10I2XZ12cd3XQbK94qwgTSWnPdYbaWb1axtjmOzkKIpAXu6V7xSIRhoFrMnzrahmjLQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775315104; c=relaxed/simple;
	bh=wdmLZ4KEEkAnWdNrQzn00WcMrp08o/hgaa6m0lD7sMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UXdoL67sbct/94vZO/BWhK5N7azU7DC/yfxXmBasNRqAGmpHpPfRUowz7tTi9XEubg42NEhtt+tG8qmU/qdQsnxyNDWAdb2M2BDhHZTXBUp543e5MMi3AzTVebd+87rcT6jEW0purtSL0gsookuHSepjnndT3fyBLdg8Wk5daoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ad7qqnA6; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so1799760a12.3
        for <netdev@vger.kernel.org>; Sat, 04 Apr 2026 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775315102; x=1775919902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sltJ+jDdJqb4WY51NvTn4z5+M71KgXkyQpBGmt2DunM=;
        b=Ad7qqnA6VWIi/TmNJMw2XuPKevL279XEslX3R0EfGNBBfG20xnQB0CWMNIz7xE9YtJ
         SQe19PhkSl1c/fjTioNpD7BOB62HUIXJZgAu/CPnSOEGAc75vGHfRZT361UnH22K6wRg
         SXyaXU3M3lb/wqspWkcRI4MYHMQ9hzf0BiT2S0XCWXSqiNciaYqAQ2islrU1EksZHcEb
         vZHO7Ft5wpgTgw36rtQUre1rmPzuQz42xSFp7qqcvLr+WX6RdKUeempVosOBVquiFlxV
         TSTLPKo0veRiYq2iBMv0EqmnAIQefdC5wMW6LZnt87WC+Jsu9m6LcK+CZtIhm6wnLhgj
         XSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775315102; x=1775919902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sltJ+jDdJqb4WY51NvTn4z5+M71KgXkyQpBGmt2DunM=;
        b=IKE5bawxXRTkBIumMCxuZY7ro/Mwb6bT3xpfaBkBaFzHTo6NRw7xdDJ34XPP2bqADm
         i5yI7KAl7UCW7/yUjgtw7jOD6/Za3nbi4/t2z11/XifhbbnE1Eqvvyz3m1JzcC91q6WD
         DQBB+5oWFefe5XOt8m8pJvGRmegFEcb15JjIjOuLA5M241p8g606Y4JdEpR9Sr6mgR/4
         8r8ikAFJdvMi/amlYFumiE9Tz3BGLX2MBnnVFrdnG/z8sxxU3pR6rjeYMFES6zNdyuLn
         +ySaV/1LLMEn3D8cD1nArdBxwpBgnzfP5wcfBlqO4V/8LT9tmDkSn80b65D/YwCoxv5T
         fgpA==
X-Gm-Message-State: AOJu0YxYnKb+gW9FlK0xLHrG6F1rURm8MWK2c3jSqLX2ozFMAmUIAJPx
	svmMbDMex9w//VOqPApH9xUjZdPr+yyQXaRelBl91YN4Tafp46hW4Q/h
X-Gm-Gg: AeBDieuNUK9eTMKTKCYyTDJb6b5cpYJE8vRwyOdr0B7xMHpBH8Yf5maKXh3iuHBLGuH
	y4aIpGZMzCVZGTzDM178ISv+BtCsjcJ+R5xvLUwOu3RrWet8D9XO1rmJxjZPZMzaodIbt0ayvfL
	PDVgm7pNJ7EykRmhdr8J5B+tW0cJOGQTE7LASZb2Ruy8Cvkv77y5dblmPy+PrmwKQ2Dgm2nkrp2
	gKnJt8KT0/xf2u4WmVkewXjTBY1IgXbzsyWKGA4gZGvaJb7agxN8q6mgg2uD/rDNwcrjfPkMPls
	wL7SrbbHLfgOu7KW3w+2txoBXNOIA5ujLBUU931CGptI8cKh+yOah3aS+Iq9+9lNpHpvWnEeVyz
	dhnadyTPI3lGj5YU+2apB6+OPqb6o73uDywg0FurH8k5V5yfl0D3BYRvAIgKk5hbVNphTpLGw9A
	MNMfHTf08fKrbA6wizU3SE1Rm0m5/eg+Dpg38xdiu1hgNDoNqtx74+yplNos4=
X-Received: by 2002:a05:6a21:99a3:b0:398:ac0d:9a0b with SMTP id adf61e73a8af0-39f2f100b43mr6626038637.50.1775315101644;
        Sat, 04 Apr 2026 08:05:01 -0700 (PDT)
Received: from KERNELXING-MC1.tencent.com ([121.25.96.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c65935cbsm8051444a12.26.2026.04.04.08.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 08:05:00 -0700 (PDT)
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
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next v2 0/4] bpf-timestamp: convert to push-level granularity
Date: Sat,  4 Apr 2026 23:04:48 +0800
Message-Id: <20260404150452.83904-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
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
	TAGGED_FROM(0.00)[bounces-275385-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netdevconf.info:url]
X-Rspamd-Queue-Id: 4E7C539B76D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jason Xing <kernelxing@tencent.com>

1. Design of send-level granularity
Originally, socket timestamping was designed to support tracing each
sendmsg instead of per packet because application needs to issue
multiple extra recvmsg() calls to get the skbs carrying the timestamp
one by one if application chooses tag with different tags(SCHED/DRV/ACK).
It's an obvious huge burden if the application expects to see a finer
grained behavior.
Another point I mentioned a bit in Netdev 0x19[1], supposing the amount of
data that application tries to transfer at one time is split into 100
smaller packets, recording the last skb's timestamps (SCHED/DRV/HARDWARE)
is no longer meaningful because at the moment timestamping only records
1/100 packets. In this case, only the delta between when to send and when
to ack matters.

2. Known missing tag issues in TCP
A critically important thing is that we can miss tagging the last packet
in a few conditions as the patch 3/4 explains. That means we lose track
of the send syscall. Digging into more into how tcp_sendmsg_locked works,
I found it's not feasible to successfully identify the last skb before
push functions get called. With that said, if we want to make the feature
better to cover all of these cases, we inevitably needs to place
tcp_bpf_tx_timestamp() function before each push function.

3. Practice at Tencent
In production, we have a version that applies the packet basis policy to
do the exhaustive profiling of each flow for months in order to:
1) 100% make sure to capture the jitter event. No sampling.
2) observe the performance, find the bottleneck and improve it.
We're still collecting data and investigating how it helps us in all the
potential aspects before upstreaming. My personal perspective on this is
to replace tcpdump eventually. It's worth mentioning tcpdump no longer
satisfies our micro observation in modern data center.

4. The tendency toward finer-grained observability
As we're aware that there are already many various bpf scripts trying to
implement the fine grained monitor of the packets, it's an unstoppable
tendency for the future observability. We're faced with so many latency
reports (like jitter, perf degradation) on a daily basis. Getting the
root cause of each report is exactly what we pursue.
After we know which request causes the problem, if it belongs to kernel,
we will dig into the packet behavior with more useful information
included. This is the process of tracing down the jitter problem.
Likewise, in BPF timestamping that mitigates the impact of calling extra
syscalls, breaking the coarse granularity into smaller ones is a first
good way to go. It shouldn't be the burden like before especially it's
independent of application.

5. Details of the series
Now it's time to convert BPF timestamping feature into push-level
granularity by only recording the last skb in each push function, which
is quite similar to how we previously treat each send syscall.
Regarding each push function as a whole, we only care about
the last skb from each push since the skb can be chunked into different
smaller packets. BPF scripts like progs/net_timestamping.c has the
ability to trace each tagged skb and calculate the latency:
1) delta between send and each tagged skb in tcp_sendmsg_locked()
2) delta between SCHED/DRV/ACK. Three timestamps are also correlated
   with the sendmsg time.

In conclusion, push-level is more of a compromise approach which covers
those corner cases and further enhances the capabilities (like a finer
grained observation of jitter and performance issues).

[1]: Page 29 of the slides demonstrates the picture of skb-level granularity
https://netdevconf.info/0x19/sessions/talk/the-future-of-so_timestamping.html

---
V2
Link: https://lore.kernel.org/all/20260402085831.36983-1-kerneljasonxing@gmail.com/
1. only handle BPF timestamping feature to cover those issues (Eric, Willem)
2. keep timestamping functions inline in send process (Eric)


Jason Xing (4):
  tcp: separate BPF timestamping from tcp_tx_timestamp
  tcp: advance the tsflags check to save cycles
  bpf-timestamp: keep track of the skb when wait_for_space occurs
  bpf-timestamp: complete tracing the skb from each push in sendmsg

 include/net/tcp.h | 20 ++++++++++++++++++++
 net/ipv4/tcp.c    | 23 +++++++++++++----------
 2 files changed, 33 insertions(+), 10 deletions(-)

-- 
2.41.3


