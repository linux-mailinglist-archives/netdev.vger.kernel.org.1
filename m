Return-Path: <netdev+bounces-285530-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA19MTQQ/WmwXAAAu9opvQ
	(envelope-from <netdev+bounces-285530-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:20:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EFF4EFBA8
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 00:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC24D304D255
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 22:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E061B38A734;
	Thu,  7 May 2026 22:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjRJ5AZM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643B5383C6F
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 22:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778192402; cv=none; b=lVDfSSKL5qUA9YmWFeUWclYS/42heemuvPcakvP4lYsjWkZwnreFPP6eNN+5zqV4w1eHIITNRALamDPnveV+Vd+zmoJBrykAWRxXRAUyeFZwxreU79zEn05SszB24zsznkDLHgLymYp7CWxbbD5CEb4tSVzenDQZXIBTb1Y9uPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778192402; c=relaxed/simple;
	bh=7akVCFfm7hP5ANb0zAUaTqJzoipacPHPEgP/Q/cIGuI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cDSZAlZ8XaHaOKBOxEcuw+bgk0bouPQNQY7qoDpq7yIutswIrfl2tSRTU45Rwl+h/blfP4M5h7DgB5nIo68gjCP23lCMt9a+1nDzGpBDC+hol3O0KUSKThyvPvUf5tvB+f/CTo4cKF2GjSQ7cs0HbIK0p1Ia/rSNMVMG2ysOKvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjRJ5AZM; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8b3fe2f190bso1035166d6.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 15:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778192397; x=1778797197; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gozDpH/w9OywWeRscbxiMu2pOyoySG7vjvGdT55Wnug=;
        b=sjRJ5AZMNp79O+3lcXadQDSLgSeE56l4RjcUrKSYWb/I3aIRpjLK5YuymNFtb+4rrA
         oopGZHKFnkE/Wc0rQlw2tRdF2+SMPMjzuzGyugUOV3ax7dK14feqSnDsNIHuGYNYk9vZ
         f5QoiaPTaYj1BqSGOqmhx+3D4D7LkvhREkaFVlD/EXfiEklyEsfquViP3BPGHRj48HKy
         YhfpGPLd9SsQC3wIsffdvakZJtrRGROsLLIXuodfVIZ4cM4x2u6uUoMMZQXjLlgg0eec
         7V3iGp2wOlevhw1o+uGBstNvsauxlnm2r1V2FPazeBC3nPX6BhD0HjVIgvLtg0CwOuaJ
         ZHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778192397; x=1778797197;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gozDpH/w9OywWeRscbxiMu2pOyoySG7vjvGdT55Wnug=;
        b=m5xdMm95c3ZKpkrXEJhSuR5MDYcORphRobmbR+VKxxtZXaiR1Piwe8iyiSVTJtVwmI
         bfp2UYp3T8NTUPMFNjp9K9EhPQ5Lv1pPYkxpEsB6sw/OVoOImU0bLWUvpYpkBjV9j3Tl
         W7azeyAvWie8w6sjBrD+rU1OKSDxSKnhA6mA8WdcUGh9UGjhyuMCdQtydGOb+0Fc8YVS
         AD1ndTm+Gq1k3BLf/O0TN8ammW4QcmNQBjMVbMn0J+RPyvK0kBT+QiAYsV6siIP0Ab3Q
         23vdTjhRGuWRy6zYmsdxrjY13BeqGMN19SONud+URicKuZVpi0tqjvWf4xZ9sypaeEZv
         oQ/w==
X-Forwarded-Encrypted: i=1; AFNElJ+qgsVhfg+nkZmNCjgKGCmzhfB1l8Wlrrmfkt2q5l4d9WMLHK/IaBBwtA61oUwOtT5uR5q4kuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoUQifzgGo1wUCifY7o3249sn/rR2a02yeNfq6X5oDVCSjuHs8
	pZeK0dYrRB9UJelj2G7nJTetim0XNJfDOpve0CNLN4kj4sYcNoOpBkuyuuFEPjjZ+y4YZQj9rhp
	lSq6TGUDdIDbYtA==
X-Received: from qvbgc1.prod.google.com ([2002:a05:6214:2301:b0:8ae:1b92:a1a3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:3c8c:b0:8ac:bb05:ddce with SMTP id 6a1803df08f44-8bc44f86075mr150935026d6.32.1778192397386;
 Thu, 07 May 2026 15:19:57 -0700 (PDT)
Date: Thu,  7 May 2026 22:19:45 +0000
In-Reply-To: <20260507221948.335726-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260507221948.335726-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260507221948.335726-6-edumazet@google.com>
Subject: [PATCH net-next 5/8] net/sched: add const qualifiers to gnet_stats helpers
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 65EFF4EFBA8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-285530-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

In preparation of lockless qdisc dumps, add const qualifiers to:

- gnet_stats_add_basic()
- gnet_stats_copy_basic()
- gnet_stats_copy_queue()
- gnet_stats_read_basic()
- ___gnet_stats_copy_basic()

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/gen_stats.h | 12 ++++++------
 net/core/gen_stats.c    | 24 ++++++++++++------------
 2 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/include/net/gen_stats.h b/include/net/gen_stats.h
index 7aa2b8e1fb298c4f994a745b114fc4da785ddf4b..6e661b743bc35743de9c211bdf5c24d69be5c0f1 100644
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
 			     struct gnet_stats_basic_sync __percpu *cpu,
 			     struct gnet_stats_basic_sync *b, bool running);
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
diff --git a/net/core/gen_stats.c b/net/core/gen_stats.c
index 1a2380e74272de8eaf3d4ef453e56105a31e9edf..3b2f9ea2eb072dde792aad5b60cf00dcc2efa76d 100644
--- a/net/core/gen_stats.c
+++ b/net/core/gen_stats.c
@@ -124,7 +124,7 @@ void gnet_stats_basic_sync_init(struct gnet_stats_basic_sync *b)
 EXPORT_SYMBOL(gnet_stats_basic_sync_init);
 
 static void gnet_stats_add_basic_cpu(struct gnet_stats_basic_sync *bstats,
-				     struct gnet_stats_basic_sync __percpu *cpu)
+				     const struct gnet_stats_basic_sync __percpu *cpu)
 {
 	u64 t_bytes = 0, t_packets = 0;
 	int i;
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
 
@@ -182,7 +182,7 @@ static void gnet_stats_read_basic(u64 *ret_bytes, u64 *ret_packets,
 		int i;
 
 		for_each_possible_cpu(i) {
-			struct gnet_stats_basic_sync *bcpu = per_cpu_ptr(cpu, i);
+			const struct gnet_stats_basic_sync *bcpu = per_cpu_ptr(cpu, i);
 			unsigned int start;
 			u64 bytes, packets;
 
@@ -209,8 +209,8 @@ static void gnet_stats_read_basic(u64 *ret_bytes, u64 *ret_packets,
 
 static int
 ___gnet_stats_copy_basic(struct gnet_dump *d,
-			 struct gnet_stats_basic_sync __percpu *cpu,
-			 struct gnet_stats_basic_sync *b,
+			 const struct gnet_stats_basic_sync __percpu *cpu,
+			 const struct gnet_stats_basic_sync *b,
 			 int type, bool running)
 {
 	u64 bstats_bytes, bstats_packets;
@@ -258,8 +258,8 @@ ___gnet_stats_copy_basic(struct gnet_dump *d,
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
@@ -385,8 +385,8 @@ EXPORT_SYMBOL(gnet_stats_add_queue);
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


