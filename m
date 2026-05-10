Return-Path: <netdev+bounces-286264-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDx8OPZMAGqsGAEAu9opvQ
	(envelope-from <netdev+bounces-286264-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:16:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6A7503492
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 065BE3028B1C
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 09:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFD9636D9EE;
	Sun, 10 May 2026 09:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lypYgKK9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C4336DA0C
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 09:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778404507; cv=none; b=mZfhIBDhzMBCn28ZXcE8zqdx2yxmy5zNbfz8dA/c00ZKOdtWNEjTBHaVotekQ34ITD9RvYi5RYJa3rRypy+NyNtLiwKKz6SeaYj+L55XAqCWjh/wU7wwnxOAoneJdw6wDTggaA9tk/iPjgIPMFXr9nCUCe3OlbPqHKk1ppfbkp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778404507; c=relaxed/simple;
	bh=UU2HXrvgC5AceCyhj4a03i2uwAh6qV2cmT1ppXlXPYU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uCBoO8emoCrP7P/HD8zvVXMsAwaE9vhKtwUdNrXwMVYRKaw47XZ9yYCHAKmZaTHfmvESJg5TUgb25joLsVfBId8+1P0EzICkell7PtNlIec32l8Qk/n/o1oLTMAIdc67+4xxSZQeHSUqf5nK4FsMYnYmHXCsjEl8rQnueC/tKmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lypYgKK9; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-7bf0b47d2f8so14673917b3.2
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 02:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778404504; x=1779009304; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eA2TR7hwcpkNF99BjuRk/EmJ3dZocTX/sC0E95RdJHM=;
        b=lypYgKK921zKexbyVd0lEs54kGc6AQKsB7/8vCiWrCcwXlfYecZavXo0Kz+73SQwhT
         ILP6zrICIT6Q/nnY8ObFioAuITHjs58l4UurSR4p9LHrJXvnAlONphERTBTPUWntaaOa
         TvfdUwzxhc31XYWb26PW6mpUj2gwxfR128WhAygRjlTrf8Zh/NUE2prANh3R/S5cvr0n
         iEPh+Le8yjUJ0c2GG/ii9aoJrEURFQvh1hFUrCo7/KhxyIE/N3zGJrAAqYG75QVIggqq
         8d/4l9fuyuyLJ8dP9lUwJN4Wz3lzAL0V676fz3tztIWfbCFZj0xyLMYVq/CVBDMONMSA
         xOUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778404504; x=1779009304;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eA2TR7hwcpkNF99BjuRk/EmJ3dZocTX/sC0E95RdJHM=;
        b=MeHQ6fUJfkfxNL5wO3mjfbiF8tUaJoze5UtKGHkHu8m5SKI/CMK03LKvSNGDOfwmET
         bqKtbNu+CmQTjjnusVA9NVaTMD2X6xlH+ydhoDM7iKXhl297ep1YxtdFNpmuEjmg53Z5
         qOpMqszIjeBk35R/oPM25Ky1J4YcWPTla2op3JivsnXCaIpk4VRcQMU9x9zfhKzo0fyi
         xJ78hFCafOm8K6ZfYmmjQ3VcVE4I070hdRvtJqkuFJC52Miji1JLoPJYHvOpPi5xZfzB
         hK2W3bSSJ9xseDCOkJRlJb+3V+arFMAa0aSyD/sosbUVuzBX4nAWqgMCmubdWufteReJ
         cBkg==
X-Forwarded-Encrypted: i=1; AFNElJ9CqxaDp61nJCVLk+Zx8frp9SvFbPxpR8V4BHv9cfV0TM4WaZhmIHhkStY1GRcAiESQLxCSUH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvGREoK+wiO8vbyxVVVQsn29g0ZgAOQbwqVN+z+cDH9+xIDewe
	36eRKRfmWjAnuVj5ZGWWgk31nprDj9VF2V6rv1hX1ibOMoymO0V3A9iub6wXzNCqgDLKI+ucqi0
	TaXdfC9EdMC+36w==
X-Received: from ywbiw8.prod.google.com ([2002:a05:690c:6d88:b0:7b1:b8a9:dd95])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:4188:b0:7ba:ee34:6df7 with SMTP id 00721157ae682-7bdf5dece75mr172625167b3.18.1778404504163;
 Sun, 10 May 2026 02:15:04 -0700 (PDT)
Date: Sun, 10 May 2026 09:14:52 +0000
In-Reply-To: <20260510091455.4039245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260510091455.4039245-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260510091455.4039245-6-edumazet@google.com>
Subject: [PATCH v2 net-next 5/8] net/sched: add const qualifiers to gnet_stats helpers
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 4B6A7503492
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286264-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In preparation of lockless qdisc dumps, add const qualifiers to:

- gnet_stats_add_basic()
- gnet_stats_copy_basic()
- gnet_stats_copy_basic_hw()
- gnet_stats_copy_queue()
- gnet_stats_read_basic()
- ___gnet_stats_copy_basic()
- qdisc_qstats_copy()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/gen_stats.h   | 16 ++++++++--------
 include/net/sch_generic.h |  2 +-
 net/core/gen_stats.c      | 31 +++++++++++++++----------------
 3 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/net/gen_stats.h b/include/net/gen_stats.h
index 7aa2b8e1fb298c4f994a745b114fc4da785ddf4b..856b5e90fbdb81416c2297278926660f809a2338 100644
--- a/include/net/gen_stats.h
+++ b/include/net/gen_stats.h
@@ -47,19 +47,19 @@ int gnet_stats_start_copy_compat(struct sk_buff *skb, int type,
 				 int padattr);
 
 int gnet_stats_copy_basic(struct gnet_dump *d,
-			  struct gnet_stats_basic_sync __percpu *cpu,
-			  struct gnet_stats_basic_sync *b, bool running);
+			  const struct gnet_stats_basic_sync __percpu *cpu,
+			  const struct gnet_stats_basic_sync *b, bool running);
 void gnet_stats_add_basic(struct gnet_stats_basic_sync *bstats,
-			  struct gnet_stats_basic_sync __percpu *cpu,
-			  struct gnet_stats_basic_sync *b, bool running);
+			  const struct gnet_stats_basic_sync __percpu *cpu,
+			  const struct gnet_stats_basic_sync *b, bool running);
 int gnet_stats_copy_basic_hw(struct gnet_dump *d,
-			     struct gnet_stats_basic_sync __percpu *cpu,
-			     struct gnet_stats_basic_sync *b, bool running);
+			     const struct gnet_stats_basic_sync __percpu *cpu,
+			     const struct gnet_stats_basic_sync *b, bool running);
 int gnet_stats_copy_rate_est(struct gnet_dump *d,
 			     struct net_rate_estimator __rcu **ptr);
 int gnet_stats_copy_queue(struct gnet_dump *d,
-			  struct gnet_stats_queue __percpu *cpu_q,
-			  struct gnet_stats_queue *q, __u32 qlen);
+			  const struct gnet_stats_queue __percpu *cpu_q,
+			  const struct gnet_stats_queue *q, __u32 qlen);
 void gnet_stats_add_queue(struct gnet_stats_queue *qstats,
 			  const struct gnet_stats_queue __percpu *cpu_q,
 			  const struct gnet_stats_queue *q);
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 0edf05d56862b113a9468ef2175d203123814ec5..2ce84b2c9423ee3b945c0a537620b2568279e1ca 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -1054,7 +1054,7 @@ static inline void qdisc_qstats_overlimit(struct Qdisc *sch)
 	WRITE_ONCE(sch->qstats.overlimits, sch->qstats.overlimits + 1);
 }
 
-static inline int qdisc_qstats_copy(struct gnet_dump *d, struct Qdisc *sch)
+static inline int qdisc_qstats_copy(struct gnet_dump *d, const struct Qdisc *sch)
 {
 	__u32 qlen = qdisc_qlen_sum(sch);
 
diff --git a/net/core/gen_stats.c b/net/core/gen_stats.c
index 1a2380e74272de8eaf3d4ef453e56105a31e9edf..9468bc5ca3f46d09c267514bef62e88851c9040b 100644
--- a/net/core/gen_stats.c
+++ b/net/core/gen_stats.c
@@ -124,13 +124,13 @@ void gnet_stats_basic_sync_init(struct gnet_stats_basic_sync *b)
 EXPORT_SYMBOL(gnet_stats_basic_sync_init);
 
 static void gnet_stats_add_basic_cpu(struct gnet_stats_basic_sync *bstats,
-				     struct gnet_stats_basic_sync __percpu *cpu)
+				     const struct gnet_stats_basic_sync __percpu *cpu)
 {
 	u64 t_bytes = 0, t_packets = 0;
 	int i;
 
 	for_each_possible_cpu(i) {
-		struct gnet_stats_basic_sync *bcpu = per_cpu_ptr(cpu, i);
+		const struct gnet_stats_basic_sync *bcpu = per_cpu_ptr(cpu, i);
 		unsigned int start;
 		u64 bytes, packets;
 
@@ -147,8 +147,8 @@ static void gnet_stats_add_basic_cpu(struct gnet_stats_basic_sync *bstats,
 }
 
 void gnet_stats_add_basic(struct gnet_stats_basic_sync *bstats,
-			  struct gnet_stats_basic_sync __percpu *cpu,
-			  struct gnet_stats_basic_sync *b, bool running)
+			  const struct gnet_stats_basic_sync __percpu *cpu,
+			  const struct gnet_stats_basic_sync *b, bool running)
 {
 	unsigned int start;
 	u64 bytes = 0;
@@ -172,8 +172,8 @@ void gnet_stats_add_basic(struct gnet_stats_basic_sync *bstats,
 EXPORT_SYMBOL(gnet_stats_add_basic);
 
 static void gnet_stats_read_basic(u64 *ret_bytes, u64 *ret_packets,
-				  struct gnet_stats_basic_sync __percpu *cpu,
-				  struct gnet_stats_basic_sync *b, bool running)
+				  const struct gnet_stats_basic_sync __percpu *cpu,
+				  const struct gnet_stats_basic_sync *b, bool running)
 {
 	unsigned int start;
 
@@ -182,8 +182,7 @@ static void gnet_stats_read_basic(u64 *ret_bytes, u64 *ret_packets,
 		int i;
 
 		for_each_possible_cpu(i) {
-			struct gnet_stats_basic_sync *bcpu = per_cpu_ptr(cpu, i);
-			unsigned int start;
+			const struct gnet_stats_basic_sync *bcpu = per_cpu_ptr(cpu, i);
 			u64 bytes, packets;
 
 			do {
@@ -209,8 +208,8 @@ static void gnet_stats_read_basic(u64 *ret_bytes, u64 *ret_packets,
 
 static int
 ___gnet_stats_copy_basic(struct gnet_dump *d,
-			 struct gnet_stats_basic_sync __percpu *cpu,
-			 struct gnet_stats_basic_sync *b,
+			 const struct gnet_stats_basic_sync __percpu *cpu,
+			 const struct gnet_stats_basic_sync *b,
 			 int type, bool running)
 {
 	u64 bstats_bytes, bstats_packets;
@@ -258,8 +257,8 @@ ___gnet_stats_copy_basic(struct gnet_dump *d,
  */
 int
 gnet_stats_copy_basic(struct gnet_dump *d,
-		      struct gnet_stats_basic_sync __percpu *cpu,
-		      struct gnet_stats_basic_sync *b,
+		      const struct gnet_stats_basic_sync __percpu *cpu,
+		      const struct gnet_stats_basic_sync *b,
 		      bool running)
 {
 	return ___gnet_stats_copy_basic(d, cpu, b, TCA_STATS_BASIC, running);
@@ -285,8 +284,8 @@ EXPORT_SYMBOL(gnet_stats_copy_basic);
  */
 int
 gnet_stats_copy_basic_hw(struct gnet_dump *d,
-			 struct gnet_stats_basic_sync __percpu *cpu,
-			 struct gnet_stats_basic_sync *b,
+			 const struct gnet_stats_basic_sync __percpu *cpu,
+			 const struct gnet_stats_basic_sync *b,
 			 bool running)
 {
 	return ___gnet_stats_copy_basic(d, cpu, b, TCA_STATS_BASIC_HW, running);
@@ -385,8 +384,8 @@ EXPORT_SYMBOL(gnet_stats_add_queue);
  */
 int
 gnet_stats_copy_queue(struct gnet_dump *d,
-		      struct gnet_stats_queue __percpu *cpu_q,
-		      struct gnet_stats_queue *q, __u32 qlen)
+		      const struct gnet_stats_queue __percpu *cpu_q,
+		      const struct gnet_stats_queue *q, __u32 qlen)
 {
 	struct gnet_stats_queue qstats = {0};
 
-- 
2.54.0.563.g4f69b47b94-goog


