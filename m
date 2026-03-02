Return-Path: <netdev+bounces-262778-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MKiHbDTpWmvHAAAu9opvQ
	(envelope-from <netdev+bounces-262778-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 19:15:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9AA1DE4E9
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 19:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09401306C7E0
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 18:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DE1337688;
	Mon,  2 Mar 2026 18:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DxapjsqD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C8433509B
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772475281; cv=none; b=gZptX4bFB0qj+fiMUMjVfGHXaysjGBuooRqxdEMNtSUaMl1Gvw/SW42+mqluqzWGgk0jeHJGogV3iYYCQm2dzdYw9ZxThawqS4BjG09l+G4bar8O5xyrixQP3B0HT40N0aJ8HR4wWBktHy5kd6gq3do43tTkqoy4uzQiTAOX4WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772475281; c=relaxed/simple;
	bh=iU3WgB9TfYg5oln8O95a6S2lJrSn/4FJgGa3Rxckq5c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NUO+vCAxC+NSsK8ow7aqj67RYzhWozfpuN/8s6t9hHghmVuhbhIqjkT1lbRG1NIqRUI9WEh31bktUZpf9ax3D5NBbvf7b35ptGDE+Rob2HgfqgdTqmz49WiyMN22HZJLW6gjiG8abHNLZb1+L5n7xrGaP7Qwd4XoRGSALMnzLPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DxapjsqD; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-79885818011so58530997b3.1
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 10:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772475279; x=1773080079; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+Vdu+g2GqsnsYTmLo76h5EA2LDUPAs4qbtyG6tsMmM=;
        b=DxapjsqDj8pVP4OErtGbTWiM1OLNIaKV5GgNORZueYaRfVXA2Wl4ooLG102sLt3A83
         5dY9s8YBqIKudPMCGwiRPDO7w7aFroPTs3QKXkY5B2bHLphVc1cr07fr8vrdZ8mlUZ2m
         SkoLQFWIAWaWfqwIZZgjM2L7f5fiMjIRwuAV1pJz8mBo1BYnyRzm1AN6bdeCKsDAyvi8
         9imttWwSuaRrm2I5XBiRhPfYsA/Wrb39c94S+RbbV6DYGEk6JKx5lIG+AWhyirxVU9xx
         HxmxUfd8w7fg01/nHvV/SFecZIjU3IC1MQ6/1eXY5MLCkecBPlN6f1mEqDM1eAcKBmbz
         kaKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772475279; x=1773080079;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+Vdu+g2GqsnsYTmLo76h5EA2LDUPAs4qbtyG6tsMmM=;
        b=HHM+clHptRXFSZWYE7DLR/yWbOWBuEvCd2/FvIY/r/cLsEmEej8pc7CSlTc7HDGWh2
         LuTNxcwy0JoiRXi9gHsE+XKOPc8AauOSZiQRldT8AlMk8038+c4oScxTHfpZExv8/YK0
         9O+5MJAtwCJF/LwXG3oWp6kiRbYzkCboJoYP0kp65eatDhBl84pqQKV7X1PDCJaSBZzF
         j00g4I1viWrnSXD6oT3eGPByLE1xiq6LVKkw73MDF5ee6C5KDywdQ7bPUqC7lpRanF4H
         8zqxkGsMSS/uBeAHoFmks0Hrqo6WnhZZxctbMvk9mbDgz3kY0gLth24CY6aSlp+1+UfA
         pPCg==
X-Forwarded-Encrypted: i=1; AJvYcCXvA4Jch5Q4P1AMSJFyYt/wu+6BKvy9ot7djMX08jFKlpzgjmMXQx00UMJxBtJRB2BxvHCboII=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUmgheUT++0IQ9INOWGBhWbHUYns++vmq5USkkVwKjKH4XiMvA
	GlvNXKxyf6OP07bDTGLMl/eoszL53LG4Lr0tDSEqOQntARZYgSmjUkKL6c4lEouxr9CnQ+qEkgf
	hYFAH/cEwq/nE+g==
X-Received: from yxq3.prod.google.com ([2002:a05:690e:d43:b0:64a:cdec:9d95])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:1a98:b0:64c:b242:496e with SMTP id 956f58d0204a3-64cc201e04emr8814788d50.17.1772475279285;
 Mon, 02 Mar 2026 10:14:39 -0800 (PST)
Date: Mon,  2 Mar 2026 18:14:28 +0000
In-Reply-To: <20260302181432.1836150-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260302181432.1836150-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260302181432.1836150-4-edumazet@google.com>
Subject: [PATCH v3 net-next 3/7] net-sysfs: add rps_sock_flow_table_mask() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: EF9AA1DE4E9
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
	TAGGED_FROM(0.00)[bounces-262778-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

In preparation of the following patch, abstract access
to the @mask field in 'struct rps_sock_flow_table'.

Also cleanup rps_sock_flow_sysctl() a bit :

- Rename orig_sock_table to o_sock_table.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/rps.h          | 11 ++++++++---
 net/core/dev.c             |  4 +++-
 net/core/sysctl_net_core.c | 19 ++++++++++---------
 3 files changed, 21 insertions(+), 13 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index 32cfa250d9f931b8ab1c94e0410d0820bb9c999f..82cdffdf3e6b0035e7ceeb130b5b4ac19772e46c 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -60,18 +60,23 @@ struct rps_dev_flow_table {
  * meaning we use 32-6=26 bits for the hash.
  */
 struct rps_sock_flow_table {
-	u32		mask;
+	u32		_mask;
 
 	u32		ents[] ____cacheline_aligned_in_smp;
 };
 #define	RPS_SOCK_FLOW_TABLE_SIZE(_num) (offsetof(struct rps_sock_flow_table, ents[_num]))
 
+static inline u32 rps_sock_flow_table_mask(const struct rps_sock_flow_table *table)
+{
+	return table->_mask;
+}
+
 #define RPS_NO_CPU 0xffff
 
 static inline void rps_record_sock_flow(struct rps_sock_flow_table *table,
 					u32 hash)
 {
-	unsigned int index = hash & table->mask;
+	unsigned int index = hash & rps_sock_flow_table_mask(table);
 	u32 val = hash & ~net_hotdata.rps_cpu_mask;
 
 	/* We only give a hint, preemption can change CPU under us */
@@ -129,7 +134,7 @@ static inline void _sock_rps_delete_flow(const struct sock *sk)
 	rcu_read_lock();
 	table = rcu_dereference(net_hotdata.rps_sock_flow_table);
 	if (table) {
-		index = hash & table->mask;
+		index = hash & rps_sock_flow_table_mask(table);
 		if (READ_ONCE(table->ents[index]) != RPS_NO_CPU)
 			WRITE_ONCE(table->ents[index], RPS_NO_CPU);
 	}
diff --git a/net/core/dev.c b/net/core/dev.c
index 1cf3ad840697ed93a6c4cc5163aae514fda90eff..de70ef784d6363b3af4f9279e107647c90f5af19 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5112,12 +5112,14 @@ static int get_rps_cpu(struct net_device *dev, struct sk_buff *skb,
 	if (flow_table && sock_flow_table) {
 		struct rps_dev_flow *rflow;
 		u32 next_cpu;
+		u32 flow_id;
 		u32 ident;
 
 		/* First check into global flow table if there is a match.
 		 * This READ_ONCE() pairs with WRITE_ONCE() from rps_record_sock_flow().
 		 */
-		ident = READ_ONCE(sock_flow_table->ents[hash & sock_flow_table->mask]);
+		flow_id = hash & rps_sock_flow_table_mask(sock_flow_table);
+		ident = READ_ONCE(sock_flow_table->ents[flow_id]);
 		if ((ident ^ hash) & ~net_hotdata.rps_cpu_mask)
 			goto try_rps;
 
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 0b659c932cffef45e05207890b8187d64ae3c85a..cfbe798493b5789dc8baedf9dcbe9c20918e2ba6 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -145,16 +145,17 @@ static int rps_sock_flow_sysctl(const struct ctl_table *table, int write,
 		.maxlen = sizeof(size),
 		.mode = table->mode
 	};
-	struct rps_sock_flow_table *orig_sock_table, *sock_table;
+	struct rps_sock_flow_table *o_sock_table, *sock_table;
 	static DEFINE_MUTEX(sock_flow_mutex);
 	void *tofree = NULL;
 
 	mutex_lock(&sock_flow_mutex);
 
-	orig_sock_table = rcu_dereference_protected(
+	o_sock_table = rcu_dereference_protected(
 					net_hotdata.rps_sock_flow_table,
 					lockdep_is_held(&sock_flow_mutex));
-	size = orig_size = orig_sock_table ? orig_sock_table->mask + 1 : 0;
+	size = o_sock_table ? rps_sock_flow_table_mask(o_sock_table) + 1 : 0;
+	orig_size = size;
 
 	ret = proc_dointvec(&tmp, write, buffer, lenp, ppos);
 
@@ -165,6 +166,7 @@ static int rps_sock_flow_sysctl(const struct ctl_table *table, int write,
 				mutex_unlock(&sock_flow_mutex);
 				return -EINVAL;
 			}
+			sock_table = o_sock_table;
 			size = roundup_pow_of_two(size);
 			if (size != orig_size) {
 				sock_table =
@@ -175,26 +177,25 @@ static int rps_sock_flow_sysctl(const struct ctl_table *table, int write,
 				}
 				net_hotdata.rps_cpu_mask =
 					roundup_pow_of_two(nr_cpu_ids) - 1;
-				sock_table->mask = size - 1;
-			} else
-				sock_table = orig_sock_table;
+				sock_table->_mask = size - 1;
+			}
 
 			for (i = 0; i < size; i++)
 				sock_table->ents[i] = RPS_NO_CPU;
 		} else
 			sock_table = NULL;
 
-		if (sock_table != orig_sock_table) {
+		if (sock_table != o_sock_table) {
 			rcu_assign_pointer(net_hotdata.rps_sock_flow_table,
 					   sock_table);
 			if (sock_table) {
 				static_branch_inc(&rps_needed);
 				static_branch_inc(&rfs_needed);
 			}
-			if (orig_sock_table) {
+			if (o_sock_table) {
 				static_branch_dec(&rps_needed);
 				static_branch_dec(&rfs_needed);
-				tofree = orig_sock_table;
+				tofree = o_sock_table;
 			}
 		}
 	}
-- 
2.53.0.473.g4a7958ca14-goog


