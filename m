Return-Path: <netdev+bounces-286481-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NOnHeWDAWoFcAEAu9opvQ
	(envelope-from <netdev+bounces-286481-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:23:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 463E7509113
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C5E4300145D
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481F237C939;
	Mon, 11 May 2026 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHipONY6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC6B3112BD
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484196; cv=none; b=QcL6hULn1UjmJQxymSPPkOAz2KygzpCMfuUKWOwucAfsTPwmzP7UDxtdDP5M4J7mhwXPX7dL79hk+XZ19k4WInAXbv+LWwY6pJE1zdzTy1Wf9AWXA9k6V4jf5vc5dV7hhBL6KRPHn/OYMTrGNXmvhzD5JWF9o7zI4f1qb+Lru4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484196; c=relaxed/simple;
	bh=Rm6RZcqHKcLTttSJ4v0mPEkNwgXbeDarcF6QkEpXYwA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OqLfEWKnDglKS9PLuoxODl3P6ccikN58sfWBe10Esfv+EfDJYbJtR8OkPWK2ESzSA+McsYY8OvCazqrzu6rLocorQKCic0nh1dTs7XuaipGw7P3kdT1wjhL5rEb8pMzWjbEEje2Fwu2ZqukjNdqFylxXESIwHjFI+iFkfJGWH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sHipONY6; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8b3fe2f190bso101531666d6.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 00:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778484194; x=1779088994; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=8gYaEYW/hA88xTrfwSY+r0JDbsFOmlIuXc+t9YihHbA=;
        b=sHipONY6zf5Wrax000LbjCYNPER8dXWkbZlei5xsVRzEi8nMmRHXzcUiZQ13Oe0yZm
         Zj02aRG8O9efx6NScvEvgWnYq0R2z3ZxOBeySwHiGluS6YhYx891SHkPXlChx1ugGOXH
         kPYEmJAZDCaJ7FqU0fE92S3s79yOKL+M1X3FCvCL/+qUJAWnur7ChTb/gu2/492ZQ9XC
         JYSBTrKeasS0Mt5L8ysyhzA8cdaEVO5avZmvsvhQmcoKtCAkEB6fOBQv2eP+zuDWuSuH
         ZJE7D8b8U/o6IG5MsNGMDPtsKURGAXF4dKIOXLvSCrOB4tUBchsx5A73fRUpZvbAAoUz
         lbZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778484194; x=1779088994;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8gYaEYW/hA88xTrfwSY+r0JDbsFOmlIuXc+t9YihHbA=;
        b=e7UmYiZtCNvCdyrOGkCHwdEdLvtsLWWdscMy77Mv93IJAOiFGvz701mxT/5qQMp/VA
         YdT/uYoDsGtvVNRiRUCm0vz7IewGRzKg8aa+uYEbdBhg+VnUcE36A72yqgnhKlZLUvcG
         5EOcvLgD48l00zaoUz7neoqvZBiYGHdciUvc2+z+pk87+ygvxsFAr93F9tbbDwW/QD0Z
         XT7ZJPK804gyDCp1eaxD/XAelvmFMDYxJFS7Kns7BYyfcW6HcWw7Q3XcF5eUzd7pu4xv
         HJu0qGrjha+0qM0hCI6/08rBZ7TXphlN4SkK1TNdxbC2uD9qdCWcm91P6st99SjjqOTe
         ivDw==
X-Forwarded-Encrypted: i=1; AFNElJ9U42CEbv637fx2iQIN8/Bd2v6E3yEp/rI8dSABZ5l3U6H/rxo+V1LK0Kx+YgStIkfWda0LrjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YySgp0vYgC4+QgH7IRzrq7FbGC/N5YjencbFapRKwb01Kx9YCR5
	Xg01jQvaRv7kBbSEdGRZQ01eVS1f1a+tf21g08fK187lD8zgvWuwJlmvsCKCzawj8StShRlh+R1
	Q7Hx0v7nXyy86EA==
X-Received: from qtri20.prod.google.com ([2002:ac8:7654:0:b0:50b:4726:f15a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1b1a:b0:50d:8c8f:f94d with SMTP id d75a77b69052e-514621eef47mr344430681cf.52.1778484193677;
 Mon, 11 May 2026 00:23:13 -0700 (PDT)
Date: Mon, 11 May 2026 07:23:08 +0000
In-Reply-To: <20260511072310.1094859-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511072310.1094859-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511072310.1094859-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/3] net: constify sk_skb_reason_drop() sock parameter
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 463E7509113
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286481-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

sk_skb_reason_drop() does not change sock parameter, make it
const so that we can call it from TCP stack without a cast
on a (const) listener socket.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: includes changes to net/core/drop_monitor.c

 include/linux/skbuff.h     | 3 ++-
 include/trace/events/skb.h | 4 ++--
 net/core/drop_monitor.c    | 6 +++---
 net/core/skbuff.c          | 5 +++--
 4 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 2bcf78a4de7b9edb0d1342319d4340c0a9997eeb..746e741a8ef99b3052ad581650e5d0db2a95dbb3 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1313,7 +1313,8 @@ static inline bool skb_data_unref(const struct sk_buff *skb,
 	return true;
 }
 
-void __fix_address sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb,
+void __fix_address sk_skb_reason_drop(const struct sock *sk,
+				      struct sk_buff *skb,
 				      enum skb_drop_reason reason);
 
 static inline void
diff --git a/include/trace/events/skb.h b/include/trace/events/skb.h
index b877133cd93a80f6b130fab64f334ecdeab8c8fd..2945aa7fe9a7ded5bdec5be3a67382de95239517 100644
--- a/include/trace/events/skb.h
+++ b/include/trace/events/skb.h
@@ -24,14 +24,14 @@ DEFINE_DROP_REASON(FN, FN)
 TRACE_EVENT(kfree_skb,
 
 	TP_PROTO(struct sk_buff *skb, void *location,
-		 enum skb_drop_reason reason, struct sock *rx_sk),
+		 enum skb_drop_reason reason, const struct sock *rx_sk),
 
 	TP_ARGS(skb, location, reason, rx_sk),
 
 	TP_STRUCT__entry(
 		__field(void *,		skbaddr)
 		__field(void *,		location)
-		__field(void *,		rx_sk)
+		__field(const void *,	rx_sk)
 		__field(unsigned short,	protocol)
 		__field(enum skb_drop_reason,	reason)
 	),
diff --git a/net/core/drop_monitor.c b/net/core/drop_monitor.c
index f23cea9e1aafb1e98a17f75e6b9c10ce3e2b9d45..2bf3cab5e557a15dd3fa7197098d6b0abcc01fab 100644
--- a/net/core/drop_monitor.c
+++ b/net/core/drop_monitor.c
@@ -110,7 +110,7 @@ struct net_dm_alert_ops {
 	void (*kfree_skb_probe)(void *ignore, struct sk_buff *skb,
 				void *location,
 				enum skb_drop_reason reason,
-				struct sock *rx_sk);
+				const struct sock *rx_sk);
 	void (*napi_poll_probe)(void *ignore, struct napi_struct *napi,
 				int work, int budget);
 	void (*work_item_func)(struct work_struct *work);
@@ -266,7 +266,7 @@ static void trace_drop_common(struct sk_buff *skb, void *location)
 static void trace_kfree_skb_hit(void *ignore, struct sk_buff *skb,
 				void *location,
 				enum skb_drop_reason reason,
-				struct sock *rx_sk)
+				const struct sock *rx_sk)
 {
 	trace_drop_common(skb, location);
 }
@@ -493,7 +493,7 @@ static void net_dm_packet_trace_kfree_skb_hit(void *ignore,
 					      struct sk_buff *skb,
 					      void *location,
 					      enum skb_drop_reason reason,
-					      struct sock *rx_sk)
+					      const struct sock *rx_sk)
 {
 	ktime_t tstamp = ktime_get_real();
 	struct per_cpu_dm_data *data;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7dad68e3b5186cf622a3ed5a6e87c09d46bc3fd6..acca1365672c4f98b004c2548133d70c9cf5ddc1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -1206,7 +1206,7 @@ void __kfree_skb(struct sk_buff *skb)
 EXPORT_SYMBOL(__kfree_skb);
 
 static __always_inline
-bool __sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb,
+bool __sk_skb_reason_drop(const struct sock *sk, struct sk_buff *skb,
 			  enum skb_drop_reason reason)
 {
 	if (unlikely(!skb_unref(skb)))
@@ -1235,7 +1235,8 @@ bool __sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb,
  *	'kfree_skb' tracepoint.
  */
 void __fix_address
-sk_skb_reason_drop(struct sock *sk, struct sk_buff *skb, enum skb_drop_reason reason)
+sk_skb_reason_drop(const struct sock *sk, struct sk_buff *skb,
+		   enum skb_drop_reason reason)
 {
 	if (__sk_skb_reason_drop(sk, skb, reason))
 		__kfree_skb(skb);
-- 
2.54.0.563.g4f69b47b94-goog


