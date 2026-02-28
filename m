Return-Path: <netdev+bounces-262079-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOyjDlNuomkn3AQAu9opvQ
	(envelope-from <netdev+bounces-262079-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:25:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A872A1C041B
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C303A307D4C4
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01472D8DDF;
	Sat, 28 Feb 2026 04:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h3v9VKpu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291E92EFD9B
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 04:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772252712; cv=none; b=PcmzaXBk8Hb9ofnDZFmyDNjCbJyAz/ToJ291cwNdMle6u1cki04yMNNmMKYWzb62EjX+k6UXzGPmytxHPXDrC2N4dBmxFo5hI1rq5QXlPFdmhZl7yFwrwAAypbirvMn2dxN/u1IL1QQqaB8g/g76RpbuQ8P34mMhZTfMqUnyecU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772252712; c=relaxed/simple;
	bh=FTqfmAfmz2flYGu2GVFL2RyXUoPMI7ccQQ18mpfk1hQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u38zX4DhvjrtairmUZK9S9O0Hojk5B0XwFX9HIbr5IES9fsLeRq439N6pCujsxD5pLm0j6P7t1pTT+nL4B24c/Cpw2TEGu04M8Kk9CpasFR7DNvQxiHQl6+zuaS3LEiYgdKfth/TR0oplTp9oA9c8ybTG8/m/HILSFstDE77myU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h3v9VKpu; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cb3ad1b81aso3321005185a.2
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 20:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772252710; x=1772857510; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PwbymdKA877TLKChqF70RPy17EvfPfxviSBrvMSpvlE=;
        b=h3v9VKpuTLFtUEdXKqVfi39e5Gj9j8erRaBU5GH2enegGZKyZLqLMKnA7E+juEtf1l
         cxzEGCeaF2SQyqVGRtMtWx49DVCKPK4LxZs3ZsDoUkNKDrdQCTA1flTkWL5NHywF5kqN
         6mjTP6AWRSonF+7TFmPya2xAZFqRLWmx3R1QyJir1ixm+cnfQiYuVvr14CgILvN5cZFk
         q0BZTGvmHMA/v4gSOJioEXFnu0wCqbIdnEc7hEWrhfl4e6//usAxAtfX45AhkHL6KyzX
         MSyHdcS02pTPEzWp2TdvMOrJ6QTWdFL2OaJxajAdQQHX/FifeQQ+aVEJSHm8xghRLSe7
         kNsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772252710; x=1772857510;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PwbymdKA877TLKChqF70RPy17EvfPfxviSBrvMSpvlE=;
        b=eWAdz2MZ1RPcCN8/V0XfwS579OFNdRukUDINcuTmNl8hwDYn9ZWje3OPTZzdIRuX0Z
         ePBy/30aFTLCnXR/dvs5kM72NaEcHkY6Iscz0RUn5PDqfBKE6YCyzan1n3GL9uVtFJnR
         auSPoka85CKAfiVIFMan0EKkrHKeK4FbFYAf/Jb0tRk/aH9v94nal0b5AHvF7ac8F+1S
         VESBPPYIHSIxUIVxdcLuej/WcfnCTvD4eNo5jR5n7exfQ/kgC3uEiiSERCifoGbVMwm0
         IEcmLtl0gxukZIhW0+irfnSupdPafQINZAx4x0hYQJgPJ3EaOhf9/bdlzxW0mDS4JxMs
         ZePw==
X-Forwarded-Encrypted: i=1; AJvYcCVRNcDqnumaEq9ljdsq+bzXz2Gu71Jk/TpRBtJ3/rGZIBZVjvGtfu1Cy2xY2oUcZRWZC++MwNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXVYBcNmLDbJzn2gzDArQ+yJ0b3UF0ngBHlMUdTX1pxxqDGWEe
	62dIf84A24Qy2Cma3PqhUluS3OUyJA7nn2HD/1i6Psx68I8ULt3Au/qGH6KdFL/lad5mLCcipA6
	6U6OQ3uM9TE3HKw==
X-Received: from qkog15.prod.google.com ([2002:a05:620a:40cf:b0:8c7:995:507f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:28c6:b0:8ca:2bab:a0f9 with SMTP id af79cd13be357-8cbc8dc4990mr715680085a.1.1772252709917;
 Fri, 27 Feb 2026 20:25:09 -0800 (PST)
Date: Sat, 28 Feb 2026 04:24:59 +0000
In-Reply-To: <20260228042503.3726451-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228042503.3726451-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228042503.3726451-4-edumazet@google.com>
Subject: [PATCH net-next 3/7] net-sysfs: add rps_sock_flow_table_mask() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262079-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A872A1C041B
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
index c1a9f7fdcffa9b493d44e5b39f447f685dacd991..be0a4769aebdbf1d25ff54a640f3c9e77b5eb2a7 100644
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


