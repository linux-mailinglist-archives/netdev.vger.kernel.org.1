Return-Path: <netdev+bounces-254833-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCmXHgx8e2kQFAIAu9opvQ
	(envelope-from <netdev+bounces-254833-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:26:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3326B16B5
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AAE14300CC38
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0FD2C159A;
	Thu, 29 Jan 2026 15:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M1xhXkHn"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015D1279DCD
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 15:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700321; cv=none; b=F1MsMxccCYSpxh7ane1uwBqsU2G5VRv5yZ55sz7JpLkXNRUhPFuZhKb841yL3o76V07rFXJogFcMW7VOhcmXRAY0iTpj6glrbh7gPtFkbXeRnbvNmwtJB7ATTStQNRdb7xQfCOqwqbl8ZXntGK9VuDN3lNmvfKC7BOZmMDpsz1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700321; c=relaxed/simple;
	bh=yXwOQNSKQi1HIRb3VPnfl2hh4kD4Y2qAMS04wTmDn74=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X255R5yV+wWF8ZJTgh0Xm3oT+yG+CWjCwLJQYkmlMWPmSxbFoytLhbA0KXcjVUlhT2QP/zFY+YAI7P/z33qurqwvOAErBm7ZcOQWOWYeYfvb85e7HQF2+ehYeN/MEsIkNnnvtnVYmx6EnbbEjWwZqmZXsVrN/AK03ik+kI5VcfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M1xhXkHn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769700318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=I6bWQAN1rIj0xbb2CSVI3kq+wfrJAUDt2IKFNSNtP6E=;
	b=M1xhXkHnwEF7ba/o1s3oD4kowpca/7xat63Htsgq1U/dp3EG/WiJjziHpZ49dc+J2CvZcp
	z3Y3jQQOnm845JLmIY2uaHUspFW9paGm+27lUVgobPngZo2Axdx4Vn/Ly1CF5h9dfoOC7d
	Xp+2m2LPMdMJA8PuFyrA5jXwoKlMjf8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-151-xDnfBf4_OUyoWujsIn3SPg-1; Thu,
 29 Jan 2026 10:25:08 -0500
X-MC-Unique: xDnfBf4_OUyoWujsIn3SPg-1
X-Mimecast-MFC-AGG-ID: xDnfBf4_OUyoWujsIn3SPg_1769700307
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7E86019560A6;
	Thu, 29 Jan 2026 15:25:06 +0000 (UTC)
Received: from dcaratti.users.ipa.redhat.com (unknown [10.44.33.192])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22F3918004D8;
	Thu, 29 Jan 2026 15:25:02 +0000 (UTC)
From: Davide Caratti <dcaratti@redhat.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Subject: [PATCH net-next] net/sched: don't use dynamic lockdep keys with clsact/ingress/noqueue
Date: Thu, 29 Jan 2026 16:24:35 +0100
Message-ID: <68f55cee98e5402af2509f1d3873fbc7a27f67e9.1769699825.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-254833-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dcaratti@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3326B16B5
X-Rspamd-Action: no action

Currently we are registering one dynamic lockdep key for each allocated
qdisc, to avoid false deadlock reports when mirred (or TC eBPF) redirects
packets to another device while the root lock is acquired [1].
Since dynamic keys are a limited resource, we can save them at least for
qdiscs that are not meant to acquire the root lock in the traffic path, or
to carry traffic at all. A good (initial) example is:

 - clsact
 - ingress
 - noqueue

Don't register dynamic keys for the above schedulers, so that we hit
MAX_LOCKDEP_KEYS later in our tests.

[1] https://github.com/multipath-tcp/mptcp_net-next/issues/451

Signed-off-by: Davide Caratti <dcaratti@redhat.com>
---
 include/net/pkt_sched.h | 22 ++++++++++++++++++++++
 net/sched/sch_api.c     |  2 +-
 net/sched/sch_generic.c |  8 +++-----
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/net/pkt_sched.h b/include/net/pkt_sched.h
index e703c507d0da..e68a7bbb84b4 100644
--- a/include/net/pkt_sched.h
+++ b/include/net/pkt_sched.h
@@ -308,4 +308,26 @@ static inline unsigned int qdisc_peek_len(struct Qdisc *sch)
 	return len;
 }
 
+static inline void qdisc_lock_init(struct Qdisc *sch, const struct Qdisc_ops *ops)
+{
+	bool skip_dynamic_key = (ops->static_flags & TCQ_F_INGRESS) ||
+				(ops == &noqueue_qdisc_ops);
+
+	if (!skip_dynamic_key)
+		lockdep_register_key(&sch->root_lock_key);
+
+	spin_lock_init(&sch->q.lock);
+	if (!skip_dynamic_key)
+		lockdep_set_class(&sch->q.lock, &sch->root_lock_key);
+}
+
+static inline void qdisc_lock_uninit(struct Qdisc *sch, const struct Qdisc_ops *ops)
+{
+	bool skip_dynamic_key = (ops->static_flags & TCQ_F_INGRESS) ||
+				(ops == &noqueue_qdisc_ops);
+
+	if (!skip_dynamic_key)
+		lockdep_unregister_key(&sch->root_lock_key);
+}
+
 #endif
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index f56b18c8aebf..443c116e8663 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1353,7 +1353,7 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
 		ops->destroy(sch);
 	qdisc_put_stab(rtnl_dereference(sch->stab));
 err_out3:
-	lockdep_unregister_key(&sch->root_lock_key);
+	qdisc_lock_uninit(sch, ops);
 	netdev_put(dev, &sch->dev_tracker);
 	qdisc_free(sch);
 err_out2:
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 852e603c1755..98ffe64de51f 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -955,9 +955,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 	__skb_queue_head_init(&sch->gso_skb);
 	__skb_queue_head_init(&sch->skb_bad_txq);
 	gnet_stats_basic_sync_init(&sch->bstats);
-	lockdep_register_key(&sch->root_lock_key);
-	spin_lock_init(&sch->q.lock);
-	lockdep_set_class(&sch->q.lock, &sch->root_lock_key);
+	qdisc_lock_init(sch, ops);
 
 	if (ops->static_flags & TCQ_F_CPUSTATS) {
 		sch->cpu_bstats =
@@ -987,7 +985,7 @@ struct Qdisc *qdisc_alloc(struct netdev_queue *dev_queue,
 
 	return sch;
 errout1:
-	lockdep_unregister_key(&sch->root_lock_key);
+	qdisc_lock_uninit(sch, ops);
 	kfree(sch);
 errout:
 	return ERR_PTR(err);
@@ -1076,7 +1074,7 @@ static void __qdisc_destroy(struct Qdisc *qdisc)
 	if (ops->destroy)
 		ops->destroy(qdisc);
 
-	lockdep_unregister_key(&qdisc->root_lock_key);
+	qdisc_lock_uninit(qdisc, ops);
 	bpf_module_put(ops, ops->owner);
 	netdev_put(dev, &qdisc->dev_tracker);
 
-- 
2.52.0


