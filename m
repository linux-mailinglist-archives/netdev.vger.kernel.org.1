Return-Path: <netdev+bounces-286167-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lo7MJiYn/2mv2wAAu9opvQ
	(envelope-from <netdev+bounces-286167-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 14:23:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 253F64FF935
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 14:23:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 305B13006450
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 12:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44EA349B15;
	Sat,  9 May 2026 12:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcEsN2qs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490E91F4C96
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 12:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778329377; cv=none; b=UZblUL07EhDRzmLZ+xI/aW4nursz36iHIk+Bgn7YepkM+IDffSUe7TVcM4gcPtiJKnYog8i/1TgvcFxE91DDDEqrOGNBxmXw0EnWECIQvkFLQexwR/nKsDTUVg8+rk5rSVK6D6ZRhDjZ9mqAKSwNMS+5+0+XjZWYLwp76GXgc+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778329377; c=relaxed/simple;
	bh=XFGQUIZfB0bIJGSfXEiP8ijv5n73dwvfaUxJ0KC5YRE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g5ltZVNNwlg4tr3cfJEbhEj4R1WKHz4N9rc2Ku44pGjATCKo68E2atQAqICIKyjTq3fs6uMSb0TbqeL6c88DSqCI6SpP6vyDruyd0zXFMxc36yFkI/RbtDxw/D0Ue8oiaikQQQ/+lxKZiaDlfgaw4zLNKwXPPlN1xPjbL9jZX40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcEsN2qs; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-838d0b7c950so1900208b3a.3
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 05:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778329374; x=1778934174; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkquJi3+Xf+JNUw0wuTV+QwMPsoEyBgf0EYoEwB10Yw=;
        b=QcEsN2qsD1UMpe55FGhIDvtevfk6akGGto1AMB22uNT7AQ7K6o/3CbbCChaqsHGf1A
         rAiuQuqNIlwi3BTs7wnxYZqR2ry/NNblJk9UJ5UAPqYuckCOn4HLVjen2uz7en9yl95N
         LZfpQwn863iXKEuWjynvhs82HVH8DGQQ/dgIBYOn5KCamZQNvMtF7BK91JRIe5vxxOJ3
         YPLML1pQj2mjh4+HCaOb+jKXOq7v/pHFbRwxUCOvSaFQTHSCweGZO2cMS6+Q5etq1plK
         2tvinw89Mjd3Bbjh/MbLZkAVgKWVoypASwsneVOFYFiPbu7SgEYJPhEOodDFpKYPNOiq
         L2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778329374; x=1778934174;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkquJi3+Xf+JNUw0wuTV+QwMPsoEyBgf0EYoEwB10Yw=;
        b=VBnrO6ejM442EtmITpu2qTgZmvvhLKC0qiAS2fkQwPrWs/jSDsPkriMH0vCPYW5xXh
         RWSqds4gnV6GHDAkDFbR91M/ybHFV8t0WJLsLrCXLXy2x7pKme+VnFyAZGqJDK6ksS4g
         dj6oz4/r6PEIpe6pyQ73O/+PBYueV/uRNBOEntIuAFYBkPfrz51EGt/9k8sVO7Rx+b3M
         D6X3+QW7qs0M78gyTYUVO073KiSbakF84jFQjRzMIX1bSl86uum3q/fKnrQMvU3kBn7k
         1+YC1+cZbQ5q8qXx9akrms2iFURnXWqp7P3+DMw8DEzUlBX23G+P337rvvNAAFvECg6G
         mQUQ==
X-Gm-Message-State: AOJu0Yx6IKadCyEVvdBzTEGaXE5KWwu7d5hDcsBxTbQnhsFnUxFkpqaA
	oGiCorE98ovwhImi1UKg8/v3MQygPWHsnkJ825iGZR9v+E3oDMGWWlde22KV3/DY
X-Gm-Gg: Acq92OG8heaz9YLSiaeQ1p5cfGiTHWFactGXAnEmFxa7t9Q/D5sueh6QeqwM0QAVZyq
	bjW1Lg48LDua6PWyZpuGWjN1LeKK4nFd8NPd/z0216bst611jSy0NZNavp/C0IFtKMAVnJ+WD10
	rOYqZj8+xyt6R0njbEHOZLsF/dtrOxUPp+MMahO1vF+Ec8FYxnbnYEE229D3CxRJbYqKh/57p8n
	bmAm/G2f9cIMxHylZb/vBtewe62/Ey5HhvU9xkOyaeCrRSQxRQ8xgJ2cHIoShOtiZ9b5G4Kj4YH
	UIr+VMvwHU3g4a2jN2gBch96W56iq5Gp1LBVYVpM/HXy7E8OaEGOSe0eWAVNexksrA3g5xa5qwa
	OmL+qfQHmb5erzMKNwg/vAGqLcjhahu4FeXK50W0izOo/CR8eq+xxHCx2WJMgDIjDkxeauHWsp3
	7bjZy2hgHovvrdZzrjHg+9pjalnSycpENUPmPRTaiHNwNG4waoTnqNwd1EPzGUaBXwS/NwEqls
X-Received: by 2002:a05:6a00:2e87:b0:82f:5034:77a4 with SMTP id d2e1a72fcca58-83a5c4be2eemr16624590b3a.21.1778329374311;
        Sat, 09 May 2026 05:22:54 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([104.28.215.164])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83965946543sm19457560b3a.16.2026.05.09.05.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 05:22:53 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net/sched: introduce TCQ_F_IN_HW to track successful qdisc offload
Date: Sat,  9 May 2026 20:22:33 +0800
Message-ID: <20260509122238.2792915-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 253F64FF935
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286167-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

qdisc_offload_dump_helper(), introduced for RED in commit 602f3baf2218
("net_sch: red: Add offload ability to RED qdisc"), re-evaluates offload
liveness on every dump because a parent qdisc change can alter the
offload state without any qdisc-specific callback being invoked.  In
this path -EOPNOTSUPP means "I do not offload this qdisc currently",
not "I do not support statistics at all".

Only mlxsw and nfp handle this correctly by maintaining internal qdisc
tracking (they need it for RED offload).  Every other qdisc type that
supports offload (ETS, PRIO, TBF, FIFO, MQ) calls TC_*_DESTROY
unconditionally in its destroy path regardless of whether a previous
TC_*_REPLACE succeeded.  Moreover, without a flag recording whether
REPLACE was accepted, a simple driver that queries hardware directly
rather than maintaining a software shadow has no way to answer STATS
correctly: it must either always return -EOPNOTSUPP (hiding real
offloads from stats) or always return 0 (false positive, claiming a
qdisc is offloaded when it never was).

Gating TC_*_STATS or TC_*_DESTROY on prior TC_*_REPLACE / TC_*_GRAFT
success is not an option: sch_gred relies on receiving STATS even after
offload ends in order to adjust backlog counters, and silently skipping
DESTROY for a qdisc that was previously offloaded would leak hardware
state.

Introduce TCQ_F_IN_HW to indicate that a qdisc has been successfully
loaded to hardware via TC_*_REPLACE.  The flag is set by the new
qdisc_offload_change_helper() on success and consumed by the new
qdisc_offload_destroy_helper() which skips the driver call entirely
when it is clear.  This is orthogonal to TCQ_F_OFFLOADED, which remains
the liveness indicator re-evaluated on every dump.

With this a simple driver can be stateless: on STATS it queries
hardware by handle and returns -EOPNOTSUPP when the entry is absent (the
core will clear TCQ_F_OFFLOADED but TCQ_F_IN_HW remains, so a subsequent
destroy still cleans up); on DESTROY it need not defend against "was
this ever offloaded?" because the core already verified TCQ_F_IN_HW.
The driver no longer needs to maintain its own registry of offloaded
qdisc handles.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 include/net/sch_generic.h | 26 +++++++++++++++++++++++---
 net/sched/sch_api.c       | 38 ++++++++++++++++++++++++++++++++++++++
 net/sched/sch_ets.c       |  9 +++------
 net/sched/sch_fifo.c      | 14 ++++----------
 net/sched/sch_gred.c      |  5 +++--
 net/sched/sch_mq.c        |  8 ++++----
 net/sched/sch_prio.c      |  7 ++++---
 net/sched/sch_red.c       |  7 ++++---
 net/sched/sch_tbf.c       | 13 +++----------
 9 files changed, 86 insertions(+), 41 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index ccfabfac674e..e69a0d29fd01 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -92,6 +92,7 @@ struct Qdisc {
 #define TCQ_F_NOLOCK		0x100 /* qdisc does not require locking */
 #define TCQ_F_OFFLOADED		0x200 /* qdisc is offloaded to HW */
 #define TCQ_F_DEQUEUE_DROPS	0x400 /* ->dequeue() can drop packets in q->to_free */
+#define TCQ_F_IN_HW		0x800 /* qdisc offloading has been accepted by HW */
 
 	u32			limit;
 	const struct Qdisc_ops	*ops;
@@ -748,18 +749,37 @@ static inline void dev_reset_queue(struct net_device *dev,
 }
 
 #ifdef CONFIG_NET_SCHED
-int qdisc_offload_dump_helper(struct Qdisc *q, enum tc_setup_type type,
+void qdisc_offload_destroy_helper(struct Qdisc *sch, enum tc_setup_type type,
+				  void *type_data);
+int qdisc_offload_change_helper(struct Qdisc *sch, enum tc_setup_type type,
+				void *type_data);
+int qdisc_offload_dump_helper(struct Qdisc *sch, enum tc_setup_type type,
 			      void *type_data);
 void qdisc_offload_graft_helper(struct net_device *dev, struct Qdisc *sch,
 				struct Qdisc *new, struct Qdisc *old,
 				enum tc_setup_type type, void *type_data,
 				struct netlink_ext_ack *extack);
 #else
+static inline void
+qdisc_offload_destroy_helper(struct Qdisc *sch, enum tc_setup_type type,
+			     void *type_data)
+{
+	sch->flags &= ~TCQ_F_IN_HW;
+}
+
+static inline int
+qdisc_offload_change_helper(struct Qdisc *sch, enum tc_setup_type type,
+			     void *type_data)
+{
+	sch->flags &= ~TCQ_F_IN_HW;
+	return -EOPNOTSUPP;
+}
+
 static inline int
-qdisc_offload_dump_helper(struct Qdisc *q, enum tc_setup_type type,
+qdisc_offload_dump_helper(struct Qdisc *sch, enum tc_setup_type type,
 			  void *type_data)
 {
-	q->flags &= ~TCQ_F_OFFLOADED;
+	sch->flags &= ~TCQ_F_OFFLOADED;
 	return 0;
 }
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 6f7847c5536f..05c8b2097cb7 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -813,6 +813,44 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 }
 EXPORT_SYMBOL(qdisc_tree_reduce_backlog);
 
+void qdisc_offload_destroy_helper(struct Qdisc *sch, enum tc_setup_type type,
+				  void *type_data)
+{
+	struct net_device *dev = qdisc_dev(sch);
+	int err;
+
+	if (!(sch->flags & TCQ_F_IN_HW))
+		return;
+
+	sch->flags &= ~TCQ_F_IN_HW;
+	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
+		return;
+
+	err = dev->netdev_ops->ndo_setup_tc(dev, type, type_data);
+	if (err)
+		netdev_warn(dev, "Error when destroying offloaded qdisc: %d",
+			    err);
+}
+EXPORT_SYMBOL(qdisc_offload_destroy_helper);
+
+int qdisc_offload_change_helper(struct Qdisc *sch, enum tc_setup_type type,
+				void *type_data)
+{
+	struct net_device *dev = qdisc_dev(sch);
+	int err;
+
+	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
+		return -EOPNOTSUPP;
+
+	err = dev->netdev_ops->ndo_setup_tc(dev, type, type_data);
+
+	if (!err)
+		sch->flags |= TCQ_F_IN_HW;
+
+	return err;
+}
+EXPORT_SYMBOL(qdisc_offload_change_helper);
+
 int qdisc_offload_dump_helper(struct Qdisc *sch, enum tc_setup_type type,
 			      void *type_data)
 {
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index a4b07b661b77..848fdc8608ac 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -151,21 +151,18 @@ static void ets_offload_change(struct Qdisc *sch)
 		qopt.replace_params.weights[i] = weight;
 	}
 
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_ETS, &qopt);
+	qdisc_offload_change_helper(sch, TC_SETUP_QDISC_ETS, &qopt);
 }
 
 static void ets_offload_destroy(struct Qdisc *sch)
 {
-	struct net_device *dev = qdisc_dev(sch);
 	struct tc_ets_qopt_offload qopt;
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return;
-
 	qopt.command = TC_ETS_DESTROY;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_ETS, &qopt);
+
+	qdisc_offload_destroy_helper(sch, TC_SETUP_QDISC_ETS, &qopt);
 }
 
 static void ets_offload_graft(struct Qdisc *sch, struct Qdisc *new,
diff --git a/net/sched/sch_fifo.c b/net/sched/sch_fifo.c
index e6bfd39ff339..c6435df37c31 100644
--- a/net/sched/sch_fifo.c
+++ b/net/sched/sch_fifo.c
@@ -58,30 +58,24 @@ static int pfifo_tail_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 static void fifo_offload_init(struct Qdisc *sch)
 {
-	struct net_device *dev = qdisc_dev(sch);
 	struct tc_fifo_qopt_offload qopt;
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return;
-
 	qopt.command = TC_FIFO_REPLACE;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_FIFO, &qopt);
+
+	qdisc_offload_change_helper(sch, TC_SETUP_QDISC_FIFO, &qopt);
 }
 
 static void fifo_offload_destroy(struct Qdisc *sch)
 {
-	struct net_device *dev = qdisc_dev(sch);
 	struct tc_fifo_qopt_offload qopt;
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return;
-
 	qopt.command = TC_FIFO_DESTROY;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_FIFO, &qopt);
+
+	qdisc_offload_destroy_helper(sch, TC_SETUP_QDISC_FIFO, &qopt);
 }
 
 static int fifo_offload_dump(struct Qdisc *sch)
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index 8ae65572162c..65688dc49f42 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -346,9 +346,10 @@ static void gred_offload(struct Qdisc *sch, enum tc_gred_command command)
 			opt->set.tab[i].backlog = &q->backlog;
 		}
 		opt->set.qstats = &sch->qstats;
+		qdisc_offload_change_helper(sch, TC_SETUP_QDISC_GRED, opt);
+	} else {
+		qdisc_offload_destroy_helper(sch, TC_SETUP_QDISC_GRED, opt);
 	}
-
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_GRED, opt);
 }
 
 static int gred_offload_dump_stats(struct Qdisc *sch)
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index a0133a7b9d3b..7fedb562f734 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -19,16 +19,16 @@
 
 static int mq_offload(struct Qdisc *sch, enum tc_mq_command cmd)
 {
-	struct net_device *dev = qdisc_dev(sch);
 	struct tc_mq_qopt_offload opt = {
 		.command = cmd,
 		.handle = sch->handle,
 	};
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return -EOPNOTSUPP;
+	if (cmd == TC_MQ_CREATE)
+		return qdisc_offload_change_helper(sch, TC_SETUP_QDISC_MQ, &opt);
 
-	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQ, &opt);
+	qdisc_offload_destroy_helper(sch, TC_SETUP_QDISC_MQ, &opt);
+	return 0;
 }
 
 static int mq_offload_stats(struct Qdisc *sch)
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index 9e2b9a490db2..470a4d9c0ac5 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -154,11 +154,12 @@ static int prio_offload(struct Qdisc *sch, struct tc_prio_qopt *qopt)
 		memcpy(&opt.replace_params.priomap, qopt->priomap,
 		       TC_PRIO_MAX + 1);
 		opt.replace_params.qstats = &sch->qstats;
-	} else {
-		opt.command = TC_PRIO_DESTROY;
+		return qdisc_offload_change_helper(sch, TC_SETUP_QDISC_PRIO, &opt);
 	}
 
-	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_PRIO, &opt);
+	opt.command = TC_PRIO_DESTROY;
+	qdisc_offload_destroy_helper(sch, TC_SETUP_QDISC_PRIO, &opt);
+	return 0;
 }
 
 static void
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 4d0e44a2e7c6..e64a29c27ca0 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -212,11 +212,12 @@ static int red_offload(struct Qdisc *sch, bool enable)
 		opt.set.is_harddrop = red_use_harddrop(q);
 		opt.set.is_nodrop = red_use_nodrop(q);
 		opt.set.qstats = &sch->qstats;
-	} else {
-		opt.command = TC_RED_DESTROY;
+		return qdisc_offload_change_helper(sch, TC_SETUP_QDISC_RED, &opt);
 	}
 
-	return dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_RED, &opt);
+	opt.command = TC_RED_DESTROY;
+	qdisc_offload_destroy_helper(sch, TC_SETUP_QDISC_RED, &opt);
+	return 0;
 }
 
 static void red_destroy(struct Qdisc *sch)
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index f2340164f579..c8f315e03e3e 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -142,12 +142,8 @@ static u64 psched_ns_t2l(const struct psched_ratecfg *r,
 static void tbf_offload_change(struct Qdisc *sch)
 {
 	struct tbf_sched_data *q = qdisc_priv(sch);
-	struct net_device *dev = qdisc_dev(sch);
 	struct tc_tbf_qopt_offload qopt;
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return;
-
 	qopt.command = TC_TBF_REPLACE;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
@@ -155,21 +151,18 @@ static void tbf_offload_change(struct Qdisc *sch)
 	qopt.replace_params.max_size = q->max_size;
 	qopt.replace_params.qstats = &sch->qstats;
 
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
+	qdisc_offload_change_helper(sch, TC_SETUP_QDISC_TBF, &qopt);
 }
 
 static void tbf_offload_destroy(struct Qdisc *sch)
 {
-	struct net_device *dev = qdisc_dev(sch);
 	struct tc_tbf_qopt_offload qopt;
 
-	if (!tc_can_offload(dev) || !dev->netdev_ops->ndo_setup_tc)
-		return;
-
 	qopt.command = TC_TBF_DESTROY;
 	qopt.handle = sch->handle;
 	qopt.parent = sch->parent;
-	dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_TBF, &qopt);
+
+	qdisc_offload_destroy_helper(sch, TC_SETUP_QDISC_TBF, &qopt);
 }
 
 static int tbf_offload_dump(struct Qdisc *sch)
-- 
2.53.0


