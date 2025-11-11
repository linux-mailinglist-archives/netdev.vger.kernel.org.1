Return-Path: <netdev+bounces-237519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 73267C4CB5F
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 10:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1BA0D4E93DF
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 09:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A9B2F6176;
	Tue, 11 Nov 2025 09:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P7b0hqie"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DC12F533B
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762853547; cv=none; b=uC5c6ZVxjD7AoTvpOQCiw9k7bNlbIfD675J2+A92Sh2rtawRY4EtO2zkAhEwACRqhfEm8db4tMMsdmiVtx8DidhPn3Upz5UW2BRQLNcsQC1Vd6XhvnPeXy97xpjI3BeUaUnFapUR59EjEm9ClWN8onWX5fM9bZQdy+qtP3zCBfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762853547; c=relaxed/simple;
	bh=yR81gyULtkcu27TkxTWZ7ZEYTG/tQbTffiusBemLzyk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u2QLIFaOCqf8tJi0S72GVOLouMhQbSxGLs2Csb87Dv3koK3GApewCCCAohCkchEt7rw9wmRdK3hBU749PDZ9MX5fj1b/zkKmc9QkNONDyn4lLY0AMQ+W9bSeLoUCL1mmHwinBO06ASlbjjjHh1z+swcRDZlqCSJ+86ILUIbjtKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P7b0hqie; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-88239fa9ec9so86579816d6.2
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 01:32:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762853545; x=1763458345; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vEUtbNGyuzZqZea8yFI2eDDeDi6HhIleZ4tBOlmO3Dg=;
        b=P7b0hqie8pAfgiABPZBIixSrSEIQaR583z/O1DPRpdIU7DpqJ5nRAUIvGUTHmnInVV
         DfqFOOa5DFt5ErGHoRGk7ESDEyCuVpFZUEQoVEmucm9IvUVg0oKRsRy/lLMQ5ZqTuQ57
         Zq/FTr9RsXQXOJPTIeaZQmmvyqrZfzCb7wWG16AKkqcazPZH19KG3SAa8jZHHMlHFl3f
         TuW0O6Fr4+mGY3/AK+v0+4iC75CmvYbnP9EWzG84avCoGMFPaDqtDTS1e3yEmAvaok8w
         EbFQ5JyXUB93+cdg5U4Mb0cIQQKFvPppPksx3SJPhXxrZw0tWvPpWiEYF/c7etSwcKns
         Dvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762853545; x=1763458345;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vEUtbNGyuzZqZea8yFI2eDDeDi6HhIleZ4tBOlmO3Dg=;
        b=lbfGabFNjrjkP2g1pQhfxP3RrZp28lfpoZMpCqoLOi3a9rQYau1pV7eSeY7OhZxNYg
         SC4XmRNQ37JOOeeLRLzesR5J8fYE9uWnpHyBVqszHrAjPT19p6hODcibVGD+bgH0HgqR
         yne+J+oUYtK+OGw0SYxlyfRFTdWqYMNQawjMOfHEpoE+wLgd+ST1JlbGFwHS0M0VIZmq
         eoy7YVjBE7zdEAGKSE5itfTxL/LCoD92fJqf8ToiqQZX6Anz7GVGdfjSIGDxafU1epBK
         S5fuyiwxKq9xSMjQY15R1B+DCD0kYWX2kAD/5m08qevBkPFBMTjltA0p87/JGf+7C6Wm
         YpDQ==
X-Forwarded-Encrypted: i=1; AJvYcCUamXCTF7hQ83QIZCwdyLtovvLcv+cjwDIyhNH8ClG6nzyVrrh46GNh/nlBGxD+jE3C8gsYkHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6BiGen/Kyca90KVGQolcTEipYc0XkjqbFu9qBMxQxPNYfu/ba
	4EqI6nd9BRh2vQ+oNQYE+3LhYai0Y46cl+uEvCk4mM9G0N0g5P6+RXVfTO72KyCBx5yq6Ad8Hkb
	qF1IMXdhA6XfHKQ==
X-Google-Smtp-Source: AGHT+IFIo3/kgd1WpJMlbmbvuOux1VBd7efknzOvova8YZZ4pg50UD3qFgTW1yjLgd3CWDX4UtBCG0BuqAavXw==
X-Received: from qvbqm15.prod.google.com ([2002:a05:6214:568f:b0:882:4b5f:f8d3])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5c8d:0:b0:882:4a63:63a0 with SMTP id 6a1803df08f44-8824a6366f3mr108348286d6.58.1762853544702;
 Tue, 11 Nov 2025 01:32:24 -0800 (PST)
Date: Tue, 11 Nov 2025 09:32:02 +0000
In-Reply-To: <20251111093204.1432437-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251111093204.1432437-1-edumazet@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251111093204.1432437-14-edumazet@google.com>
Subject: [PATCH v2 net-next 13/14] net_sched: add qdisc_dequeue_drop() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Some qdisc like cake, codel, fq_codel might drop packets
in their dequeue() method.

This is currently problematic because dequeue() runs with
the qdisc spinlock held. Freeing skbs can be extremely expensive.

Add qdisc_dequeue_drop() method and a new TCQ_F_DEQUEUE_DROPS
so that these qdiscs can opt-in to defer the skb frees
after the socket spinlock is released.

TCQ_F_DEQUEUE_DROPS is an attempt to not penalize other qdiscs
with an extra cache line miss.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/pkt_sched.h   |  5 +++--
 include/net/sch_generic.h | 30 +++++++++++++++++++++++++++---
 net/core/dev.c            | 22 +++++++++++++---------
 3 files changed, 43 insertions(+), 14 deletions(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index 4678db45832a1e3bf7b8a07756fb89ab868bd5d2..e703c507d0daa97ae7c3bf131e322b1eafcc5664 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -114,12 +114,13 @@ bool sch_direct_xmit(struct sk_buff *skb, struct Qdisc *q,
 
 void __qdisc_run(struct Qdisc *q);
 
-static inline void qdisc_run(struct Qdisc *q)
+static inline struct sk_buff *qdisc_run(struct Qdisc *q)
 {
 	if (qdisc_run_begin(q)) {
 		__qdisc_run(q);
-		qdisc_run_end(q);
+		return qdisc_run_end(q);
 	}
+	return NULL;
 }
 
 extern const struct nla_policy rtm_tca_policy[TCA_MAX + 1];
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index b8092d0378a0cafa290123d17c1b0ba787cd0680..c3a7268b567e0abf3f38290cd4e3fa7cd0601e36 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -88,6 +88,8 @@ struct Qdisc {
 #define TCQ_F_INVISIBLE		0x80 /* invisible by default in dump */
 #define TCQ_F_NOLOCK		0x100 /* qdisc does not require locking */
 #define TCQ_F_OFFLOADED		0x200 /* qdisc is offloaded to HW */
+#define TCQ_F_DEQUEUE_DROPS	0x400 /* ->dequeue() can drop packets in q->to_free */
+
 	u32			limit;
 	const struct Qdisc_ops	*ops;
 	struct qdisc_size_table	__rcu *stab;
@@ -119,6 +121,8 @@ struct Qdisc {
 
 		/* Note : we only change qstats.backlog in fast path. */
 		struct gnet_stats_queue	qstats;
+
+		struct sk_buff		*to_free;
 	__cacheline_group_end(Qdisc_write);
 
 
@@ -218,8 +222,10 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 	return true;
 }
 
-static inline void qdisc_run_end(struct Qdisc *qdisc)
+static inline struct sk_buff *qdisc_run_end(struct Qdisc *qdisc)
 {
+	struct sk_buff *to_free = NULL;
+
 	if (qdisc->flags & TCQ_F_NOLOCK) {
 		spin_unlock(&qdisc->seqlock);
 
@@ -232,9 +238,16 @@ static inline void qdisc_run_end(struct Qdisc *qdisc)
 		if (unlikely(test_bit(__QDISC_STATE_MISSED,
 				      &qdisc->state)))
 			__netif_schedule(qdisc);
-	} else {
-		WRITE_ONCE(qdisc->running, false);
+		return NULL;
+	}
+
+	if (qdisc->flags & TCQ_F_DEQUEUE_DROPS) {
+		to_free = qdisc->to_free;
+		if (to_free)
+			qdisc->to_free = NULL;
 	}
+	WRITE_ONCE(qdisc->running, false);
+	return to_free;
 }
 
 static inline bool qdisc_may_bulk(const struct Qdisc *qdisc)
@@ -1116,6 +1129,17 @@ static inline void tcf_kfree_skb_list(struct sk_buff *skb)
 	}
 }
 
+static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff *skb,
+				      enum skb_drop_reason reason)
+{
+	DEBUG_NET_WARN_ON_ONCE(!(q->flags & TCQ_F_DEQUEUE_DROPS));
+	DEBUG_NET_WARN_ON_ONCE(q->flags & TCQ_F_NOLOCK);
+
+	tcf_set_drop_reason(skb, reason);
+	skb->next = q->to_free;
+	q->to_free = skb;
+}
+
 /* Instead of calling kfree_skb() while root qdisc lock is held,
  * queue the skb for future freeing at end of __dev_xmit_skb()
  */
diff --git a/net/core/dev.c b/net/core/dev.c
index e865cdb9b6966225072dc44a86610b9c7828bd8c..9094c0fb8c689cd5252274d839638839bfb7642e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4141,7 +4141,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 				 struct net_device *dev,
 				 struct netdev_queue *txq)
 {
-	struct sk_buff *next, *to_free = NULL;
+	struct sk_buff *next, *to_free = NULL, *to_free2 = NULL;
 	spinlock_t *root_lock = qdisc_lock(q);
 	struct llist_node *ll_list, *first_n;
 	unsigned long defer_count = 0;
@@ -4160,7 +4160,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 			if (unlikely(!nolock_qdisc_is_empty(q))) {
 				rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
 				__qdisc_run(q);
-				qdisc_run_end(q);
+				to_free2 = qdisc_run_end(q);
 
 				goto free_skbs;
 			}
@@ -4170,12 +4170,13 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 			    !nolock_qdisc_is_empty(q))
 				__qdisc_run(q);
 
-			qdisc_run_end(q);
-			return NET_XMIT_SUCCESS;
+			to_free2 = qdisc_run_end(q);
+			rc = NET_XMIT_SUCCESS;
+			goto free_skbs;
 		}
 
 		rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
-		qdisc_run(q);
+		to_free2 = qdisc_run(q);
 		goto free_skbs;
 	}
 
@@ -4234,7 +4235,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 		qdisc_bstats_update(q, skb);
 		if (sch_direct_xmit(skb, q, dev, txq, root_lock, true))
 			__qdisc_run(q);
-		qdisc_run_end(q);
+		to_free2 = qdisc_run_end(q);
 		rc = NET_XMIT_SUCCESS;
 	} else {
 		int count = 0;
@@ -4246,7 +4247,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 			rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
 			count++;
 		}
-		qdisc_run(q);
+		to_free2 = qdisc_run(q);
 		if (count != 1)
 			rc = NET_XMIT_SUCCESS;
 	}
@@ -4255,6 +4256,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 
 free_skbs:
 	tcf_kfree_skb_list(to_free);
+	tcf_kfree_skb_list(to_free2);
 	return rc;
 }
 
@@ -5747,8 +5749,9 @@ static __latent_entropy void net_tx_action(void)
 		rcu_read_lock();
 
 		while (head) {
-			struct Qdisc *q = head;
 			spinlock_t *root_lock = NULL;
+			struct sk_buff *to_free;
+			struct Qdisc *q = head;
 
 			head = head->next_sched;
 
@@ -5775,9 +5778,10 @@ static __latent_entropy void net_tx_action(void)
 			}
 
 			clear_bit(__QDISC_STATE_SCHED, &q->state);
-			qdisc_run(q);
+			to_free = qdisc_run(q);
 			if (root_lock)
 				spin_unlock(root_lock);
+			tcf_kfree_skb_list(to_free);
 		}
 
 		rcu_read_unlock();
-- 
2.52.0.rc1.455.g30608eb744-goog


