Return-Path: <netdev+bounces-203058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FD5AF06F5
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D8961C04E23
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 23:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A68306DBB;
	Tue,  1 Jul 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GM1gciJ0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A53302CDB
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 23:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751412604; cv=none; b=WeYbjhHM7i1gR9KWNt2eeU65OklhFlkFZofiC9FxwNIPUo3FBs+7i4lA1YYnEvWQAycS2DT7V4P7E26x9/IyVC8dd6RdrGznUJOtbPWurbvpz+6is89vaX0WTY75NhBYAlrtd7iTjL9QcKEZod0f9dseK2kIpJxWOQqTaMPsNXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751412604; c=relaxed/simple;
	bh=V4JguZ8/LiPrIHpAMBY+K655RrtnCf680rXos7AIsxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ju/NCTKC+Bi3Tj6/qYj+lX8ysUeK+TVrs5adxxpHQz6s2uMsT7c4CWpVYbOB0njR2TBEVI8MiE3s3LPG/ALxiLPlchgxOJLP/3+bVoMNs5loYh9FWSxLNK/aXlG0iLfiJkQJbFyJ7ooapkutnU9Yi94A7EkeaKAqho1IzUpki4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GM1gciJ0; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-747fc77bb2aso3681632b3a.3
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 16:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751412602; x=1752017402; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayrLKVD7xFlobqHVGOfoFSIfqMc6ornm6olxMqq9LWk=;
        b=GM1gciJ0WttsLPNAYOTrgjUTZco4wk7+TUGbTCVT9hRXiLw1VFgr+llUYi91ys1XF9
         RRCYP2FiGFpZ/9+PfIqWGMyn03XgNtdSdUe6BsY5M0Mv648RwWXnqAPJDzI21t9E3xiL
         9uGZrdVKE0PqhF1mcgy2RsPG3mgJ+1E9sBQvg5ikcTfrGl2gLd/ElXahX3DzGOaZCSuU
         BevDKIsVQzhug0LRTJdEgI8iEygW0uc+LgmmzMju0+7/Mhrt8SjD2SIGnrjCm8Q3X1zg
         FWy+/RGrvAYN729yvfDJkLXEXucvZbIoYSsSRerTNrtBQso/9mFpGT4n8EkIJN6oZklJ
         CjDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751412602; x=1752017402;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ayrLKVD7xFlobqHVGOfoFSIfqMc6ornm6olxMqq9LWk=;
        b=oXlbpmFelwPuSTNjmP6+q1ZoKc5zIJD/8l12BKhrnwpSYVAWyWycLMssWYSZ4QvoKH
         28puEc03oAII4UnBWuygo+sq169IKS29dk2hU1AR/G0CIQA/paBhKBsyzPyLMaW9HNbZ
         wJCnlonQ4FJ1L2ZU4IlySmWaUU7vHSuEj0POJqxAqHKFTEf5Qt42EIaEtgCTIieNBh3X
         5phxve0yBP8D6sr6eqYHcFDgKVFQtDlxbMJO3PYfVZA1ICZoNNDZQtRmdEcj5mWKJ0XZ
         t32zudpmrewAEs5NGuW9NfcZSlJbl9Zfz0LYE9jRoIZdIS/4YHYGPYuZboDvFNxbLib7
         YM5g==
X-Gm-Message-State: AOJu0YzUyhhxNDNvLz2J5aYOSlcdGFaxaxhS0a0iOzvERBAJzdYb0wLk
	hZNghNyIUBB6f7SgJFITdK/kVyR+kBxKOHcpM7lFAH3eZHhuFp9ul7aPg+X/xg==
X-Gm-Gg: ASbGncsL0TIMUfM72XfA165M0qRen9nP1o0VmP9tJrhT1YO5LLQoIsOGR281LT1J2/0
	vts65nfHT2SBeAexGPZTXE8lqxibYwsTQWOKg8mzWJ1xnIvHx/mJlatRSWbOh/uucz/+xyChGN3
	ylMpn0rn1hnmMUh/k2hbun7Vc35XoqGQyQ+1ObShFb8gFx18m/AChoh8hoLcC3gfKj5Wgn7yjsq
	ifI4sMvzgIhwvTp5Rv/PT5B0r46tCM3Z2r2JmL29RVIPJI65Lc/9CrKLK21Adt0DrQuBzV8EDjq
	Ov4BYR5GoEknq04/sibR9NfJY2MQLQDfaVf/WpQ3fDG2Q1HM+ydjPwNln7aG3Aobs6+4oWz1
X-Google-Smtp-Source: AGHT+IHxn5icQKfXcppKN89B25zl858rNLqgliLFZBqsfF9UtT/NklmEkwHV0QbQkbthnrlwWUFVaw==
X-Received: by 2002:a05:6a20:d80a:b0:215:f656:6632 with SMTP id adf61e73a8af0-222d7ef95d5mr1525365637.29.1751412601994;
        Tue, 01 Jul 2025 16:30:01 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af54098a3sm12909269b3a.16.2025.07.01.16.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 16:30:01 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	mincho@theori.io,
	victor@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [RFC Patch net-next 2/2] net_sched: Propagate per-qdisc max_segment_size for GSO segmentation
Date: Tue,  1 Jul 2025 16:29:15 -0700
Message-Id: <20250701232915.377351-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701232915.377351-1-xiyou.wangcong@gmail.com>
References: <20250701232915.377351-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a max_segment_size field in struct Qdisc and a get_max_size()
callback in struct Qdisc_ops to support per-qdisc maximum segment size
constraints. When a qdisc (such as TBF or TAPRIO) requires a specific
maximum packet size, it implements get_max_size() to return the appropriate
limit. This value is then propagated up the qdisc tree, and the root qdisc
tracks the minimum max_segment_size required by any child.

During GSO segmentation at the root, the strictest max_segment_size is used
to ensure that all resulting segments comply with downstream qdisc
requirements. If no max_segment_size is set, segmentation falls back to the
device MTU. This guarantees that oversized segments are never enqueued into
child qdiscs, preventing unnecessary drops and maintaining atomicity.

This change enables robust, hierarchical enforcement of per-qdisc size
limits, improves correctness for advanced qdiscs like TBF and TAPRIO, and
lays the groundwork for further per-class or per-priority segmentation
policies in the future.

Reported-by: Mingi Cho <mincho@theori.io>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 include/net/sch_generic.h |  3 ++-
 net/core/dev.c            | 16 +++++++++++-----
 net/sched/sch_api.c       | 13 ++++++++++---
 net/sched/sch_taprio.c    | 23 ++++++++++++++++-------
 net/sched/sch_tbf.c       |  8 ++++++++
 5 files changed, 47 insertions(+), 16 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 9c4082ccefb5..d740b803c921 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -108,7 +108,7 @@ struct Qdisc {
 	struct net_rate_estimator __rcu *rate_est;
 	struct gnet_stats_basic_sync __percpu *cpu_bstats;
 	struct gnet_stats_queue	__percpu *cpu_qstats;
-	int			pad;
+	unsigned int max_segment_size; /* minimum max_size of all children, 0 = use device MTU */
 	refcount_t		refcnt;
 
 	/*
@@ -319,6 +319,7 @@ struct Qdisc_ops {
 						    u32 block_index);
 	u32			(*ingress_block_get)(struct Qdisc *sch);
 	u32			(*egress_block_get)(struct Qdisc *sch);
+	unsigned int (*get_max_size)(struct Qdisc *sch, struct sk_buff *skb);
 
 	struct module		*owner;
 };
diff --git a/net/core/dev.c b/net/core/dev.c
index 95627552488e..ba136d53f0f1 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4059,11 +4059,17 @@ static void qdisc_pkt_len_init(struct sk_buff *skb)
 
 static int dev_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *q,
 			     struct sk_buff **to_free,
-			     struct netdev_queue *txq)
+			     struct netdev_queue *txq, unsigned int mtu)
 {
+	unsigned int seg_limit = mtu;
 	int rc = NET_XMIT_SUCCESS;
 
-	if ((q->flags & TCQ_F_NEED_SEGMENT) && skb_is_gso(skb)) {
+	if (q->max_segment_size)
+		seg_limit = q->max_segment_size;
+
+	if ((q->flags & TCQ_F_NEED_SEGMENT) &&
+	    qdisc_pkt_len(skb) > seg_limit &&
+	    skb_is_gso(skb)) {
 		netdev_features_t features = netif_skb_features(skb);
 		struct sk_buff *segs, *nskb, *next;
 		struct sk_buff *fail_list = NULL;
@@ -4125,7 +4131,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 			 * of q->seqlock to protect from racing with requeuing.
 			 */
 			if (unlikely(!nolock_qdisc_is_empty(q))) {
-				rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
+				rc = dev_qdisc_enqueue(skb, q, &to_free, txq, dev->mtu);
 				__qdisc_run(q);
 				qdisc_run_end(q);
 
@@ -4141,7 +4147,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 			return NET_XMIT_SUCCESS;
 		}
 
-		rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
+		rc = dev_qdisc_enqueue(skb, q, &to_free, txq, dev->mtu);
 		qdisc_run(q);
 
 no_lock_out:
@@ -4195,7 +4201,7 @@ static inline int __dev_xmit_skb(struct sk_buff *skb, struct Qdisc *q,
 		rc = NET_XMIT_SUCCESS;
 	} else {
 		WRITE_ONCE(q->owner, smp_processor_id());
-		rc = dev_qdisc_enqueue(skb, q, &to_free, txq);
+		rc = dev_qdisc_enqueue(skb, q, &to_free, txq, dev->mtu);
 		WRITE_ONCE(q->owner, -1);
 		if (qdisc_run_begin(q)) {
 			if (unlikely(contended)) {
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 8a83e55ebc0d..357488b8f055 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1210,12 +1210,19 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 		err = cops->graft(parent, cl, new, &old, extack);
 		if (err)
 			return err;
-		/* Propagate TCQ_F_NEED_SEGMENT to root Qdisc if needed */
+		/* Propagate TCQ_F_NEED_SEGMENT and max_segment_size to root Qdisc if needed */
 		if (new && (new->flags & TCQ_F_NEED_SEGMENT)) {
 			struct Qdisc *root = qdisc_root(parent);
-
-			if (root)
+			unsigned int child_max = 0;
+
+			if (new->ops->get_max_size)
+				child_max = new->ops->get_max_size(new, NULL);
+			if (root) {
+				if (!root->max_segment_size ||
+				    (child_max && child_max < root->max_segment_size))
+					root->max_segment_size = child_max;
 				root->flags |= TCQ_F_NEED_SEGMENT;
+			}
 		}
 		notify_and_destroy(net, skb, n, classid, old, new, extack);
 	}
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 6b02a6697378..4644781d3465 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -531,26 +531,34 @@ static long get_packet_txtime(struct sk_buff *skb, struct Qdisc *sch)
 	return txtime;
 }
 
-/* Devices with full offload are expected to honor this in hardware */
-static bool taprio_skb_exceeds_queue_max_sdu(struct Qdisc *sch,
-					     struct sk_buff *skb)
+static unsigned int taprio_get_max_size(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct taprio_sched *q = qdisc_priv(sch);
 	struct net_device *dev = qdisc_dev(sch);
 	struct sched_gate_list *sched;
 	int prio = skb->priority;
-	bool exceeds = false;
+	unsigned int ret = 0;
 	u8 tc;
 
 	tc = netdev_get_prio_tc_map(dev, prio);
 
 	rcu_read_lock();
 	sched = rcu_dereference(q->oper_sched);
-	if (sched && skb->len > sched->max_frm_len[tc])
-		exceeds = true;
+	if (sched)
+		ret = sched->max_frm_len[tc];
 	rcu_read_unlock();
+	return ret;
+}
+
+/* Devices with full offload are expected to honor this in hardware */
+static bool taprio_skb_exceeds_queue_max_sdu(struct Qdisc *sch,
+					     struct sk_buff *skb)
+{
+	unsigned int size = taprio_get_max_size(sch, skb);
 
-	return exceeds;
+	if (size)
+		return skb->len > size;
+	return false;
 }
 
 static int taprio_enqueue_one(struct sk_buff *skb, struct Qdisc *sch,
@@ -2481,6 +2489,7 @@ static struct Qdisc_ops taprio_qdisc_ops __read_mostly = {
 	.enqueue	= taprio_enqueue,
 	.dump		= taprio_dump,
 	.dump_stats	= taprio_dump_stats,
+	.get_max_size	= taprio_get_max_size,
 	.owner		= THIS_MODULE,
 };
 MODULE_ALIAS_NET_SCH("taprio");
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index 6200a6e70113..7b1abc465f4f 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -552,12 +552,20 @@ static const struct Qdisc_class_ops tbf_class_ops = {
 	.dump		=	tbf_dump_class,
 };
 
+static unsigned int tbf_get_max_size(struct Qdisc *sch, struct sk_buff *skb)
+{
+	struct tbf_sched_data *q = qdisc_priv(sch);
+
+	return q->max_size;
+}
+
 static struct Qdisc_ops tbf_qdisc_ops __read_mostly = {
 	.next		=	NULL,
 	.cl_ops		=	&tbf_class_ops,
 	.id		=	"tbf",
 	.priv_size	=	sizeof(struct tbf_sched_data),
 	.enqueue	=	tbf_enqueue,
+	.get_max_size	=	tbf_get_max_size,
 	.dequeue	=	tbf_dequeue,
 	.peek		=	qdisc_peek_dequeued,
 	.init		=	tbf_init,
-- 
2.34.1


