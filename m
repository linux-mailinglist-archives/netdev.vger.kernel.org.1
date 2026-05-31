Return-Path: <netdev+bounces-293409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF09C/YvHGqDLQkAu9opvQ
	(envelope-from <netdev+bounces-293409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 14:56:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C70796162EF
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 14:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98CF33029766
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 12:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AC6366067;
	Sun, 31 May 2026 12:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdAroEUE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705E3215075
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 12:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780232099; cv=none; b=e9VQrw+LcDMSKXG/uIudjCRYCWryCxrEIa9WYmglnORWI3qB1LOWMlu1WOfqvOF+6ThRgbktYpwoDlFzimC22z4yBF2vp3UelF33fxpAteQW9IuqBEGjYcGGLF0dOjt9PAwM0BHlYka13cuMae9mnAJjRucFsdekjInKOxC3XTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780232099; c=relaxed/simple;
	bh=5u2KQOnVNqKU1wLF24UtPobTeUEHvbN0LEXNqkKlJZ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R65mclYx3SIyeZUILqJgbvziVmfUsJmMPbTl281sJ5KGrYYEAdfmnMygeOowQYYpV6Z5LmJqnoX0IbwgZ2sthbKj9bBdIVacRMnA3xL03Q87ROwcD/rvw3/r7X4qCpALnvS2U52wyFmcOrrPmGd/mMyTLdgNzIF8pUTpvdWAnW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdAroEUE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36bcf3d2565so962223a91.3
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 05:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780232098; x=1780836898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MXAHqU9DQEEVu5mSHXQiOzAqz+bMJsahwn6RWh9p8Ic=;
        b=KdAroEUEpZ7GiqR9XFJhZVFX6zAgbU083pbVmzz1Mmou+9XeAZJziqL7aFQgAXH6gw
         d57gsCddxGYLzD0oNaOH5mD+RU4MIexLYMNTgTD7TLD27lmBw9s88htGSAEUc7vlK9P7
         wbBg1jFvyuLDCAN19ayCB9mQ4l91k0O4JxVkVhxpb/H5iHs3tA3YWh+8a6QgwTdO5HaT
         ijSexjF5KYhmPMVSNUQo82+2IGmDMc/hOJ1BQLtrT2zFUlTWTi9byEb2jPgP10ARxxXf
         i2cGOydictIEF6Zp2sUzAb4/tfXcMFzitAuTUVtxK4/juxgnQRbKiTVbTJCxuErUSseG
         JW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780232098; x=1780836898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MXAHqU9DQEEVu5mSHXQiOzAqz+bMJsahwn6RWh9p8Ic=;
        b=UdR1y1CdlIIW/FSe7qyLm6lG4oRKXat0NyDlptNCuT4WvVZNNhpS39/bzsgpChsJ0a
         mY0jIE+HXekR8lwRm+QxtJPKfTcmZ4XW8ZpqH/7EqwfQ3jWoawrkGYVegT+WB1HlqDA+
         UEzcrqWU8MldG83xUFm3Wwt5zWXgDSTDu8lf4Hg1OLFOZIfsiRJWNJNUTJjLtIpnmd+2
         B3nHQWOmB01V8+ZqXOh0ZkLeb3/hOVKUZD6RPsD7WKEbHZx7UPgxkUE14llCtfQnGLJt
         JpSk+g5E/vbhDPTa3/kDba3VPq83o09KRBHZDsnbI+XiIHdA1AvJRgqTz1kr02Jxz80n
         ghZg==
X-Gm-Message-State: AOJu0YyosXemot5rozDnfgfU5dYen39DwNTTniUQUuaYA4cTmefCbObc
	YOoZmFOSgRJUmiwQsSiW7VXmWh6sDaBiypBM42UKBhqknsOO7BILQR8Sp1X6hHetZcw=
X-Gm-Gg: Acq92OFZck2WxQvgml0sr8jvsCyNlQC6EBLIVbLg1UITGUbjbTKI4ZwcJAw5TkO6Ltg
	nkYXYcN3QDJt7mQHlBchycv/c5/xMFgerNSdRc++k4sKagqBounFeV5UkmiXLHIZWeTT3WIGvGq
	w12BIHRHXh35ufzNzL30IrioMjPfw+qWq6EAxrxApT5qWtkxmwgrAu5SASDOD/PdJjOlbNdimWG
	KyMuL+1bh7+02MtpGQWQckzw802+/N3z9Oic7ZWsTptNDEhXkKsKyruD+9l/s+FPA2zhWBlFBA6
	u/FW10omLT+gKqN/K8icWOZ39mYgKQ7BrNnxL+Gcp9cfS+IV0yGDCL0ZBTiIyMK7rGu60sQzmEA
	yLEKp/DetPHaolJ1YUgz9VlsSXML7dgpP/U3w2wPpUmwn6L2R0IcE8Qgcp0prmZ3A6QbwWLgHXQ
	MBN5S2SKbBthjnVbxyfHRZW5fQnc66rnhKVzhCvWtxomCiq56VDA==
X-Received: by 2002:a17:90b:1a91:b0:368:f179:ba07 with SMTP id 98e67ed59e1d1-36c4ff708d8mr6836628a91.9.1780232097721;
        Sun, 31 May 2026 05:54:57 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:7f12:602a:a4c6:2b38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bbfec391bsm7766670a91.2.2026.05.31.05.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 05:54:57 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH net-next 1/2] net/sched: sch_fq_pie: add per-flow statistics via class ops
Date: Sun, 31 May 2026 18:23:13 +0530
Message-Id: <20260531125314.22492-2-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260531125314.22492-1-hemendranaik@gmail.com>
References: <20260531125314.22492-1-hemendranaik@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,mojatatu.com,vger.kernel.org,gmail.com,nitk.edu.in];
	TAGGED_FROM(0.00)[bounces-293409-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hemendranaik@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nitk.edu.in:email]
X-Rspamd-Queue-Id: C70796162EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

FQ-PIE schedules independent PIE controllers per flow but exposes no
per-flow AQM state. Without class-level statistics there is no way to
observe the per-flow drop probability, queue delay, deficit or 
dequeue rate from userspace.

Extend tc_fq_pie_xstats with a discriminated union, following the
same pattern established by FQ-CoDel (TCA_FQ_CODEL_XSTATS_CLASS):

  - Rename the existing flat struct to tc_fq_pie_qd_stats.
  - Add tc_fq_pie_cl_stats with per-flow prob, delay, deficit,
    avg_dq_rate, and dq_rate_estimating fields.
  - Wrap both in tc_fq_pie_xstats with a type discriminator
    (TCA_FQ_PIE_XSTATS_QDISC / TCA_FQ_PIE_XSTATS_CLASS).

Wire up fq_pie_class_ops (.walk, .dump, .dump_stats) so that
'tc -s class show' against an fq_pie qdisc reports per-flow state:

  prob               per-flow PIE drop probability
  delay              per-flow queue sojourn time (microseconds)
  deficit            remaining DRR byte credits (signed integer)
  avg_dq_rate        dequeue rate estimate in bytes/second
                     (dq_rate_estimator mode only)
  dq_rate_estimating flag indicating active delay estimation mode

Note: this changes the on-wire layout of tc_fq_pie_xstats. The type
field now occupies the first four bytes, displacing the former
packets_in field. Userspace must be updated concurrently; the
companion iproute2 patch handles this.

Fix the 'delay' field comment in struct tc_pie_xstats from "in ms" to
"in microseconds" to match the kernel's
PSCHED_TICKS2NS / NSEC_PER_USEC conversion.

Also correct the avg_dq_rate comment in tc_pie_xstats from
"bits/pie_time" to "bytes/second" to match the actual kernel
conversion (avg_dq_rate * PSCHED_TICKS_PER_SEC >> PIE_SCALE).

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
 include/uapi/linux/pkt_sched.h       |  29 +++++-
 net/sched/sch_fq_pie.c               | 131 ++++++++++++++++++++++++---
 tools/include/uapi/linux/pkt_sched.h |   4 +-
 3 files changed, 146 insertions(+), 18 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index 66e8072f44df..0ad895edcb07 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -910,9 +910,9 @@ enum {
 
 struct tc_pie_xstats {
 	__u64 prob;			/* current probability */
-	__u32 delay;			/* current delay in ms */
+	__u32 delay;			/* current delay in microseconds */
 	__u32 avg_dq_rate;		/* current average dq_rate in
-					 * bits/pie_time
+					 * bytes/second
 					 */
 	__u32 dq_rate_estimating;	/* is avg_dq_rate being calculated? */
 	__u32 packets_in;		/* total number of packets enqueued */
@@ -943,7 +943,12 @@ enum {
 };
 #define TCA_FQ_PIE_MAX   (__TCA_FQ_PIE_MAX - 1)
 
-struct tc_fq_pie_xstats {
+enum {
+	TCA_FQ_PIE_XSTATS_QDISC,
+	TCA_FQ_PIE_XSTATS_CLASS,
+};
+
+struct tc_fq_pie_qd_stats {
 	__u32 packets_in;	/* total number of packets enqueued */
 	__u32 dropped;		/* packets dropped due to fq_pie_action */
 	__u32 overlimit;	/* dropped due to lack of space in queue */
@@ -955,6 +960,24 @@ struct tc_fq_pie_xstats {
 	__u32 memory_usage;	/* total memory across all queues */
 };
 
+struct tc_fq_pie_cl_stats {
+	__u64 prob;			/* current probability */
+	__u32 delay;			/* current delay in microseconds */
+	__s32 deficit;		/* number of remaining byte credits */
+	__u32 avg_dq_rate;		/* current average dq_rate in
+					 * bytes/second
+					 */
+	__u32 dq_rate_estimating;	/* is avg_dq_rate being calculated? */
+};
+
+struct tc_fq_pie_xstats {
+	__u32	type;
+	union {
+		struct tc_fq_pie_qd_stats qdisc_stats;
+		struct tc_fq_pie_cl_stats class_stats;
+	};
+};
+
 /* CBS */
 struct tc_cbs_qopt {
 	__u8 offload;
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 7becbf5362b3..d22c4e02d2d9 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -330,7 +330,7 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 	/* tupdate is in jiffies */
 	if (tb[TCA_FQ_PIE_TUPDATE])
 		WRITE_ONCE(q->p_params.tupdate,
-			usecs_to_jiffies(nla_get_u32(tb[TCA_FQ_PIE_TUPDATE])));
+			   usecs_to_jiffies(nla_get_u32(tb[TCA_FQ_PIE_TUPDATE])));
 
 	if (tb[TCA_FQ_PIE_ALPHA])
 		WRITE_ONCE(q->p_params.alpha,
@@ -509,24 +509,25 @@ static int fq_pie_dump(struct Qdisc *sch, struct sk_buff *skb)
 static int fq_pie_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct fq_pie_sched_data *q = qdisc_priv(sch);
-	struct tc_fq_pie_xstats st = { 0 };
+	struct tc_fq_pie_xstats st = {
+		.type	= TCA_FQ_PIE_XSTATS_QDISC,
+	};
 	struct list_head *pos;
 
-	sch_tree_lock(sch);
-
-	st.packets_in	= q->stats.packets_in;
-	st.overlimit	= q->stats.overlimit;
-	st.overmemory	= q->overmemory;
-	st.dropped	= q->stats.dropped;
-	st.ecn_mark	= q->stats.ecn_mark;
-	st.new_flow_count = q->new_flow_count;
-	st.memory_usage   = q->memory_usage;
+	st.qdisc_stats.packets_in	= q->stats.packets_in;
+	st.qdisc_stats.overlimit	= q->stats.overlimit;
+	st.qdisc_stats.overmemory	= q->overmemory;
+	st.qdisc_stats.dropped		= q->stats.dropped;
+	st.qdisc_stats.ecn_mark		= q->stats.ecn_mark;
+	st.qdisc_stats.new_flow_count	= q->new_flow_count;
+	st.qdisc_stats.memory_usage	= q->memory_usage;
 
+	sch_tree_lock(sch);
 	list_for_each(pos, &q->new_flows)
-		st.new_flows_len++;
+		st.qdisc_stats.new_flows_len++;
 
 	list_for_each(pos, &q->old_flows)
-		st.old_flows_len++;
+		st.qdisc_stats.old_flows_len++;
 	sch_tree_unlock(sch);
 
 	return gnet_stats_copy_app(d, &st, sizeof(st));
@@ -561,7 +562,111 @@ static void fq_pie_destroy(struct Qdisc *sch)
 	kvfree(q->flows);
 }
 
+static struct Qdisc *fq_pie_leaf(struct Qdisc *sch, unsigned long arg)
+{
+	return NULL;
+}
+
+static unsigned long fq_pie_find(struct Qdisc *sch, u32 classid)
+{
+	return 0;
+}
+
+static unsigned long fq_pie_bind(struct Qdisc *sch, unsigned long parent,
+				 u32 classid)
+{
+	return 0;
+}
+
+static void fq_pie_unbind(struct Qdisc *q, unsigned long cl)
+{
+}
+
+static struct tcf_block *fq_pie_tcf_block(struct Qdisc *sch, unsigned long cl,
+					  struct netlink_ext_ack *extack)
+{
+	struct fq_pie_sched_data *q = qdisc_priv(sch);
+
+	if (cl)
+		return NULL;
+	return q->block;
+}
+
+static int fq_pie_dump_class(struct Qdisc *sch, unsigned long cl,
+			     struct sk_buff *skb, struct tcmsg *tcm)
+{
+	tcm->tcm_handle |= TC_H_MIN(cl);
+	return 0;
+}
+
+static int fq_pie_dump_class_stats(struct Qdisc *sch, unsigned long cl,
+				   struct gnet_dump *d)
+{
+	struct fq_pie_sched_data *q = qdisc_priv(sch);
+	struct gnet_stats_queue qs = { 0 };
+	struct tc_fq_pie_xstats xstats;
+	u32 idx = cl - 1;
+
+	if (idx < q->flows_cnt) {
+		const struct fq_pie_flow *flow = &q->flows[idx];
+
+		memset(&xstats, 0, sizeof(xstats));
+		xstats.type = TCA_FQ_PIE_XSTATS_CLASS;
+		xstats.class_stats.prob = READ_ONCE(flow->vars.prob) << BITS_PER_BYTE;
+		xstats.class_stats.delay =
+			((u32)PSCHED_TICKS2NS(READ_ONCE(flow->vars.qdelay))) /
+			NSEC_PER_USEC;
+		xstats.class_stats.deficit = READ_ONCE(flow->deficit);
+		xstats.class_stats.dq_rate_estimating =
+			READ_ONCE(q->p_params.dq_rate_estimator);
+
+		if (xstats.class_stats.dq_rate_estimating) {
+			xstats.class_stats.avg_dq_rate =
+				READ_ONCE(flow->vars.avg_dq_rate) *
+				(PSCHED_TICKS_PER_SEC) >> PIE_SCALE;
+		}
+
+		qs.qlen    = READ_ONCE(flow->qlen);
+		qs.backlog = READ_ONCE(flow->backlog);
+	}
+	if (gnet_stats_copy_queue(d, NULL, &qs, qs.qlen) < 0)
+		return -1;
+	if (idx < q->flows_cnt)
+		return gnet_stats_copy_app(d, &xstats, sizeof(xstats));
+	return 0;
+}
+
+static void fq_pie_walk(struct Qdisc *sch, struct qdisc_walker *arg)
+{
+	struct fq_pie_sched_data *q = qdisc_priv(sch);
+	unsigned int i;
+
+	if (arg->stop)
+		return;
+
+	for (i = 0; i < q->flows_cnt; i++) {
+		if (list_empty(&q->flows[i].flowchain)) {
+			arg->count++;
+			continue;
+		}
+		if (!tc_qdisc_stats_dump(sch, i + 1, arg))
+			break;
+	}
+}
+
+static const struct Qdisc_class_ops fq_pie_class_ops = {
+	.leaf		=	fq_pie_leaf,
+	.find		=	fq_pie_find,
+	.tcf_block	=	fq_pie_tcf_block,
+	.bind_tcf	=	fq_pie_bind,
+	.unbind_tcf	=	fq_pie_unbind,
+	.dump		=	fq_pie_dump_class,
+	.dump_stats	=	fq_pie_dump_class_stats,
+	.walk		=	fq_pie_walk,
+};
+
 static struct Qdisc_ops fq_pie_qdisc_ops __read_mostly = {
+	.cl_ops		=	&fq_pie_class_ops,
 	.id		= "fq_pie",
 	.priv_size	= sizeof(struct fq_pie_sched_data),
 	.enqueue	= fq_pie_qdisc_enqueue,
diff --git a/tools/include/uapi/linux/pkt_sched.h b/tools/include/uapi/linux/pkt_sched.h
index 587481a19433..9bc190f0b3cf 100644
--- a/tools/include/uapi/linux/pkt_sched.h
+++ b/tools/include/uapi/linux/pkt_sched.h
@@ -847,8 +847,8 @@ enum {
 
 struct tc_pie_xstats {
 	__u32 prob;             /* current probability */
-	__u32 delay;            /* current delay in ms */
-	__u32 avg_dq_rate;      /* current average dq_rate in bits/pie_time */
+	__u32 delay;            /* current delay in microseconds */
+	__u32 avg_dq_rate;      /* current average dq_rate in bytes/second */
 	__u32 packets_in;       /* total number of packets enqueued */
 	__u32 dropped;          /* packets dropped due to pie_action */
 	__u32 overlimit;        /* dropped due to lack of space in queue */
-- 
2.34.1


