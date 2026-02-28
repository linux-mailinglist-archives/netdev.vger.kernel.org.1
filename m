Return-Path: <netdev+bounces-262082-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE6zJXluomkn3AQAu9opvQ
	(envelope-from <netdev+bounces-262082-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:26:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEB31C0431
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:26:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22B0930A5403
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00510244684;
	Sat, 28 Feb 2026 04:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cC2U1Siw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12942EFD9B
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 04:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772252716; cv=none; b=ameg2g5cma/Ssfi1UH+DFt8Jrz4BYsvzHiafbISsGuQ6n5dwtbfY5pwfhZzFWN26hNLMDDukFI81cBvpX34QuVWS/3R6G79GMoYomlk4o5dhYIUeBfhZ8gzTByHxJbThk+73sTsJGRX4O6GES3T/pZmKUz5cxf0TmaXkYellne0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772252716; c=relaxed/simple;
	bh=DTXcw5uRU4+3vU4QOduT5oVH+bLt4o+ueIKL1AIvfrs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LayQjakQwB43HX7oirB2U6Aqku8VbUF565BuU2uE4aLmcq/tAc03rnFmFOrR3vdraK9Lhc4RYj8eEhJwv7fbefbucuUAzUV6S5vC6dnc3CZH3SBrrYrhzaRqCGD+6BkSyxLErAw01DF6ViBz37fArdCB1B3Bq2g5JcvriP8gUy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cC2U1Siw; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7986c067508so42164967b3.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 20:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772252715; x=1772857515; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rhtBVSo7ifZ0us2wYLpi1g7WYF3aWJIezYYs5dSsYTw=;
        b=cC2U1SiwF7wkmhiYrKjFXS6srKZcdcm+heUGRb+qSLN5t/m61Jr7RFcEkyDwpvcDSB
         cR8swExlMsbe71lZ6w9XZI/5fNWnpJvQen7QZarGNhMYvmVGEJtYXpgCULogUVvVSEJo
         gmbSQ3HntB6robHbJDCcbDZaj0+tWW75x4LocLsD2NkTE8Jx4mfgIJUQPGwgPpfHeRkr
         wFepAJ7gqpmrcmHMGE2nsceFsuF3EW0qdf82etBrjvL/qZiCA8aG1k3b/OWL9byjqiYZ
         VNGbVH5pe8BXiqY5D2U8wr/oUReozsFGwDiTGodBBTebsrdYVCyJeKQjKYg7CyNEqEEr
         01dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772252715; x=1772857515;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rhtBVSo7ifZ0us2wYLpi1g7WYF3aWJIezYYs5dSsYTw=;
        b=QlnJHKDci+A1fYaX6ojWDuUPTPzS0Vvwzgh+g4m+tiWIfsNlZD98eEjxoR6gxS7cO9
         UIVI5PQff5y4US2fECxhcd1MdJKiUQPWlv9+KJy2jR5jcBHlHBLjjxzuzfvIwS2TtPyR
         4LUOGJzlZ1hZ1+JHrlPLDCnmblAiJ3OB9EWw2+p4dvFRl7X51ri2RnwjkI9vNQ3HgMaz
         hpx19FRcFJXrUF56X7IFhAPwvVaogVjZgodIqffH0bNix1smxPaCuV7ZyID06Cexi2rA
         iPGrMY5WRLZVZqemwx5XY0aaiJNcktmSuCKkjuD0nj4yfZ3R5nJqjz4SaPPRNwuczU1W
         HiyA==
X-Forwarded-Encrypted: i=1; AJvYcCV+ONqI8eValHCE257l5JNSI3SrWtENORaLV+w8RHEbY2U3+RGi4Ki8yzMIftclKLKq0zbOULY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDiIIGCgSStiC2P/mJlnlCQUXT3WK3J+fApLwNqGEMq9/6KNx2
	qJB+eYR1gteDK4MxEZFEpmvGzxmmi+QMmFM9n5oq+I8j2TVHvUZuN5ZEqOeyeqo0bwt9kQsLRrZ
	IsdMd4LGR4s81Dg==
X-Received: from ywblk6.prod.google.com ([2002:a05:690c:5706:b0:794:f8dd:1266])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:112:b0:798:5333:ce1c with SMTP id 00721157ae682-798855090aemr50585897b3.23.1772252714577;
 Fri, 27 Feb 2026 20:25:14 -0800 (PST)
Date: Sat, 28 Feb 2026 04:25:02 +0000
In-Reply-To: <20260228042503.3726451-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228042503.3726451-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228042503.3726451-7-edumazet@google.com>
Subject: [PATCH net-next 6/7] net-sysfs: remove rcu field from 'struct rps_dev_flow_table'
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262082-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ECEB31C0431
X-Rspamd-Action: no action

Remove rps_dev_flow_table_release() in favor of kvfree_rcu_mightsleep().

In the following pach, we will remove "u8 @log" field
and 'struct rps_dev_flow_table' size will be a power-of-two.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/rps.h    |  1 -
 net/core/net-sysfs.c | 11 ++---------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index 0d9ee2a055e9423f23c677fb3b28b5cfe05eb49f..98f96d6c606e63f5ac31a9cf98ce8a0fb6486ba9 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -44,7 +44,6 @@ struct rps_dev_flow {
  */
 struct rps_dev_flow_table {
 	u8			log;
-	struct rcu_head		rcu;
 	struct rps_dev_flow	flows[];
 };
 #define RPS_DEV_FLOW_TABLE_SIZE(_num) (sizeof(struct rps_dev_flow_table) + \
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 52fcf7fa58a808e79c1a17c8719830bcfb7c1674..fd6f81930bc6437957f32206c84db87ee242fede 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1072,13 +1072,6 @@ static ssize_t show_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 	return sysfs_emit(buf, "%lu\n", val);
 }
 
-static void rps_dev_flow_table_release(struct rcu_head *rcu)
-{
-	struct rps_dev_flow_table *table = container_of(rcu,
-	    struct rps_dev_flow_table, rcu);
-	vfree(table);
-}
-
 static ssize_t store_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 					    const char *buf, size_t len)
 {
@@ -1131,7 +1124,7 @@ static ssize_t store_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 				       RCU_INITIALIZER(table)));
 
 	if (old_table)
-		call_rcu(&old_table->rcu, rps_dev_flow_table_release);
+		kvfree_rcu_mightsleep(old_table);
 
 	return len;
 }
@@ -1168,7 +1161,7 @@ static void rx_queue_release(struct kobject *kobj)
 
 	old_table = unrcu_pointer(xchg(&queue->rps_flow_table, NULL));
 	if (old_table)
-		call_rcu(&old_table->rcu, rps_dev_flow_table_release);
+		kvfree_rcu_mightsleep(old_table);
 #endif
 
 	memset(kobj, 0, sizeof(*kobj));
-- 
2.53.0.473.g4a7958ca14-goog


