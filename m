Return-Path: <netdev+bounces-293427-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WN8+DJw1HGoeLgkAu9opvQ
	(envelope-from <netdev+bounces-293427-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 15:20:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9544D61654D
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 15:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 058E6302F3B4
	for <lists+netdev@lfdr.de>; Sun, 31 May 2026 13:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C050638C427;
	Sun, 31 May 2026 13:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o2JmH5WY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150F8371893
	for <netdev@vger.kernel.org>; Sun, 31 May 2026 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780233289; cv=none; b=gNQGOy/BxnnsR8ejeggf3SSW+IL+uMavWX5LTfMEmZZrRqTu+v+36Iq0hQJmgMqxVbFzpotejxuNrtRuUNKu4E7D5N++5Y2ruQSfo9sU0ZxqFKYwqE8KxxBiAy6+Y8KYkfTtB8kGWYxoBZoVMoSjoxwfePs5E719OJj2dvZZk9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780233289; c=relaxed/simple;
	bh=0aShnTLAhiuyEB5pyT5AYtZfG/JhG9Yw7MCMWNgnOG0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aAvptZzhu79oZbV4R5F06SP8+FICA6LAFdSJerb8w9KucvKurlUqqQ02//LqewFTSK4c8iNyUK5NM0SY3U4YHMiY6gHReDXJpmhC8rO0Bg6yLkvHv3YIff0doaLf4FL+w3In9UszW5RO4cGXFGsrNlU8IMqAPJ+r4ASf2ZUOTDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o2JmH5WY; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c8588f8fef3so329289a12.0
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 06:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780233287; x=1780838087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LDSYzXlHDg7TAcmv0nXLDs8v9+ggmKHkwJHTwxsSA0U=;
        b=o2JmH5WYxhNf/hoJEmRoM9yQWAOkFTqq66Dl5s0Kt3/8ZOeUdp6c/6sxsysHLMQE1X
         GrAkcqBSAoFK2IC6ufePhNbueEg+Y8aoWyrY0d05xOb6i9XaOoz4ZXyNewTCoiKDpaNT
         q5aMUTw+8mVJbhSeaO23WqKhle5JONbYPg/q6KfGfnuUNPy+Vb4okQeafbKQMj1H8woE
         NkdCpA6fj+2zbzDcYHoRXOqcV+yQHwf6fNnhAGwkGyv842U0oqobO5mePrt3hE6arAem
         +PyTioKrdFSb9vNSV2MmPOsF1OryADl+55xBgfMk1pwRP8E/wD+rIsnCLLZhIy0oxyZx
         qkcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780233287; x=1780838087;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LDSYzXlHDg7TAcmv0nXLDs8v9+ggmKHkwJHTwxsSA0U=;
        b=ogWjxGlgio0pVbLVVEIETJaM6BDhwWZgIOVaoDA1m6RzMkXdut/7xFiHluKqedFOxC
         4EBvdc9tCRvOi4rQ/9S1uXzuibT1fMCQXzLPttJ3l515Xwxmk64CT/leStx/Prni7zWx
         DdwjHNHSeFlk0cds73Ha3FK8cdFC7Xt28DIjtaGf0/W59geA2bJll93Wr4g1ZC+sfwiE
         6qrnT/d/1F8LKlp4N1KKohqLnADhdqSRpFEXq3tOkOojXlqp7YzOk3uR8PWT3BEr4ZHZ
         skfhPKkDkEzHh2HYxCb2DlMbvuPlRbtPDcsxfL5SLwqmdSI6WXHmbBKM3rei4yWWInnx
         kCcw==
X-Gm-Message-State: AOJu0YxLhY58yKfWzkHpZBgvqg62Dx3eI53LKUYV8l2ZM7XWezUgE5Zk
	TQGcJmWPOpftqwbsBm+0+wM1V7svrC7a7Ad5P9G8sOn1u31JvuBjwmK4+9uEoZy31vc=
X-Gm-Gg: Acq92OF9iASSGM6FSk9zKerdvsWHrukouJRUe+pyQySbT+WfL8+FXKMy6B3sXydhjDN
	XnM8qZV2KuJUZ5UHlHlVdPy/mc9U2kno+Cq31LN2D7rPUbwsLFRf1FKX/KyqCA3yXnjknF02gEU
	rp7q8G+PejEga5xfbDZbClzP2DGqgHsziYY6l0ZRadLsMaKWwQSUsqD2eHtc64ft3IyXvWrkQgP
	ZJCEUBuB1/+g3OSomez8mBMCoGf3m3DPt9hONYwowUbtwj6tOYQ8UfqPNZtuCDdxdptZBipr6pn
	zxRdelP1FmJL31UwAbgYL9cZPv5VcgvI6S1g+URtPUZbUjkAPJJs0S7kS4514zCAkSo0TGGp68H
	ZAIn7pb8dzdA62o5eqBDj6GbwtYlxZ6EeIvT+RdpwX7kvkgPR6Kd6r5nYS9znA9/wrmJfBfAvrb
	yAMUjKERWnM3T3atyXMmFzRnWbX3QxvMr2FWR3EkLqPf1Jd2xx6Q==
X-Received: by 2002:a05:6a20:1c8f:b0:39b:8dcb:f37d with SMTP id adf61e73a8af0-3b427eb0f6cmr7039190637.17.1780233286923;
        Sun, 31 May 2026 06:14:46 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:7f12:602a:a4c6:2b38])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c859391cbfbsm3442107a12.17.2026.05.31.06.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 06:14:46 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next] tc: display per-flow class statistics for fq_pie
Date: Sun, 31 May 2026 18:44:11 +0530
Message-Id: <20260531131411.28213-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[resnulli.us,mojatatu.com,vger.kernel.org,gmail.com,nitk.edu.in];
	TAGGED_FROM(0.00)[bounces-293427-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hemendranaik@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nitk.edu.in:email]
X-Rspamd-Queue-Id: 9544D61654D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for printing per-flow PIE statistics exposed by the kernel
via the new TCA_FQ_PIE_XSTATS_CLASS type in tc_fq_pie_xstats.

'tc -s class show' against an fq_pie qdisc now prints:

 prob           drop probability for the flow
 delay          per-flow queue sojourn time (microseconds)
 deficit        remaining DRR byte credits (signed integer)
 avg_dq_rate    dequeue rate estimate in bytes/second
            	(dq_rate_estimator mode only)

avg_dq_rate is formatted using tc_print_rate(), which converts the
kernel's bytes/second value to a human-readable bits/second string
(e.g. '3906Kbit'), consistent with how other tc schedulers display
rate fields. Apply the same fix to tc/q_pie.c, where avg_dq_rate was
also printed as a raw integer without a unit.

Update the UAPI header to mirror tc_fq_pie_cl_stats from the kernel.
Fix the 'delay' field comment in struct tc_pie_xstats from "in ms" to
"in microseconds" to match the kernel's
PSCHED_TICKS2NS / NSEC_PER_USEC conversion.

Add a 'tc -s class show' example to tc-fq_pie(8) with dq_rate_estimator
enabled, showing all per-flow fields (prob, delay, deficit, avg_dq_rate)
across multiple flows. Update tc-pie(8) avg_dq_rate example from a raw
integer to a formatted bits/second string.

The corresponding kernel patch can bew viewed: 
https://lore.kernel.org/netdev/20260531125314.22492-1-hemendranaik@gmail.com/

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
 include/uapi/linux/pkt_sched.h | 29 +++++++++++++++--
 man/man8/tc-fq_pie.8           | 19 ++++++++++++
 man/man8/tc-pie.8              |  2 +-
 tc/q_fq_pie.c                  | 57 +++++++++++++++++++++++-----------
 tc/q_pie.c                     |  4 +--
 5 files changed, 87 insertions(+), 24 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index fb07a889..9cc040b1 100644
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
diff --git a/man/man8/tc-fq_pie.8 b/man/man8/tc-fq_pie.8
index 457a56bb..1c8ca1a6 100644
--- a/man/man8/tc-fq_pie.8
+++ b/man/man8/tc-fq_pie.8
@@ -153,6 +153,25 @@ dq_rate_estimator
   pkts_in 6082 overlimit 0 overmemory 0 dropped 4 ecn_mark 0
   new_flow_count 94 new_flows_len 0 old_flows_len 8 memory_used 1157632
 
+# tc qdisc add dev eth0 parent 100:1 handle 200: fq_pie target 15ms flows 3 dq_rate_estimator
+.br
+# tc -s class show dev eth0
+.br
+class fq_pie 200:1 parent 200:
+ (dropped 0, overlimits 0 requeues 0)
+ backlog 0b 0p requeues 0
+  prob 0.000000 delay 0us  deficit 1514 avg_dq_rate 0bit
+.br
+class fq_pie 200:2 parent 200:
+ (dropped 0, overlimits 0 requeues 0)
+ backlog 0b 0p requeues 0
+  prob 0.000000 delay 0us  deficit 1514 avg_dq_rate 0bit
+.br
+class fq_pie 200:3 parent 200:
+ (dropped 0, overlimits 0 requeues 0)
+ backlog 4470b 3p requeues 0
+  prob 0.509691 delay 6.1ms  deficit -82 avg_dq_rate 3906Kbit
+
 .SH SEE ALSO
 .BR tc (8),
 .BR tc-pie (8),
diff --git a/man/man8/tc-pie.8 b/man/man8/tc-pie.8
index 5a8c7820..ec0d4af2 100644
--- a/man/man8/tc-pie.8
+++ b/man/man8/tc-pie.8
@@ -115,7 +115,7 @@ is turned off.
    qdisc pie 8036: dev eth0 root refcnt 2 limit 1000p target 15.0ms tupdate 16.0ms alpha 2 beta 20
     Sent 63947420 bytes 42414 pkt (dropped 41, overlimits 0 requeues 0)
     backlog 271006b 179p requeues 0
-     prob 0.000092 delay 22200us avg_dq_rate 12145996
+     prob 0.000092 delay 22200us avg_dq_rate 10742Kbit
      pkts_in 41 overlimit 343 dropped 0 maxq 50 ecn_mark 0
 
  # tc qdisc add dev eth0 root pie limit 100 target 20ms tupdate 30ms ecn
diff --git a/tc/q_fq_pie.c b/tc/q_fq_pie.c
index dc2710cd..80b956e8 100644
--- a/tc/q_fq_pie.c
+++ b/tc/q_fq_pie.c
@@ -274,6 +274,8 @@ static int fq_pie_print_xstats(const struct qdisc_util *qu, FILE *f,
 {
 	struct tc_fq_pie_xstats _st = {}, *st;
 
+	SPRINT_BUF(b1);
+
 	if (xstats == NULL)
 		return 0;
 
@@ -283,25 +285,44 @@ static int fq_pie_print_xstats(const struct qdisc_util *qu, FILE *f,
 		st = &_st;
 	}
 
-	print_uint(PRINT_ANY, "pkts_in", "  pkts_in %u",
-		   st->packets_in);
-	print_uint(PRINT_ANY, "overlimit", " overlimit %u",
-		   st->overlimit);
-	print_uint(PRINT_ANY, "overmemory", " overmemory %u",
-		   st->overmemory);
-	print_uint(PRINT_ANY, "dropped", " dropped %u",
-		   st->dropped);
-	print_uint(PRINT_ANY, "ecn_mark", " ecn_mark %u",
-		   st->ecn_mark);
+	if (st->type == TCA_FQ_PIE_XSTATS_QDISC) {
+		print_uint(PRINT_ANY, "pkts_in", "  pkts_in %u",
+			   st->qdisc_stats.packets_in);
+		print_uint(PRINT_ANY, "overlimit", " overlimit %u",
+			   st->qdisc_stats.overlimit);
+		print_uint(PRINT_ANY, "overmemory", " overmemory %u",
+			   st->qdisc_stats.overmemory);
+		print_uint(PRINT_ANY, "dropped", " dropped %u",
+			   st->qdisc_stats.dropped);
+		print_uint(PRINT_ANY, "ecn_mark", " ecn_mark %u",
+			   st->qdisc_stats.ecn_mark);
+		print_nl();
+		print_uint(PRINT_ANY, "new_flow_count", "  new_flow_count %u",
+			   st->qdisc_stats.new_flow_count);
+		print_uint(PRINT_ANY, "new_flows_len", " new_flows_len %u",
+			   st->qdisc_stats.new_flows_len);
+			print_uint(PRINT_ANY, "old_flows_len", " old_flows_len %u",
+				   st->qdisc_stats.old_flows_len);
+			print_uint(PRINT_ANY, "memory_used", " memory_used %u",
+				   st->qdisc_stats.memory_usage);
+	}
+
+	if (st->type == TCA_FQ_PIE_XSTATS_CLASS) {
+		print_float(PRINT_ANY, "prob", "  prob %lg",
+			    (double)st->class_stats.prob / (double)UINT64_MAX);
+		print_uint(PRINT_JSON, "delay", NULL, st->class_stats.delay);
+		print_string(PRINT_FP, NULL, " delay %s",
+			     sprint_time(st->class_stats.delay, b1));
+		print_int(PRINT_ANY, "deficit", "  deficit %d",
+			  st->class_stats.deficit);
+
+		if (st->class_stats.dq_rate_estimating) {
+			tc_print_rate(PRINT_ANY, "avg_dq_rate", " avg_dq_rate %s",
+				      st->class_stats.avg_dq_rate);
+	}
 	print_nl();
-	print_uint(PRINT_ANY, "new_flow_count", "  new_flow_count %u",
-		   st->new_flow_count);
-	print_uint(PRINT_ANY, "new_flows_len", " new_flows_len %u",
-		   st->new_flows_len);
-	print_uint(PRINT_ANY, "old_flows_len", " old_flows_len %u",
-		   st->old_flows_len);
-	print_uint(PRINT_ANY, "memory_used", " memory_used %u",
-		   st->memory_usage);
+	}
+
 
 	return 0;
 
diff --git a/tc/q_pie.c b/tc/q_pie.c
index 04c9aa61..97690d49 100644
--- a/tc/q_pie.c
+++ b/tc/q_pie.c
@@ -220,8 +220,8 @@ static int pie_print_xstats(const struct qdisc_util *qu, FILE *f,
 	print_string(PRINT_FP, NULL, " delay %s", sprint_time(st->delay, b1));
 
 	if (st->dq_rate_estimating)
-		print_uint(PRINT_ANY, "avg_dq_rate", " avg_dq_rate %u",
-			   st->avg_dq_rate);
+		tc_print_rate(PRINT_ANY, "avg_dq_rate", " avg_dq_rate %s",
+			      st->avg_dq_rate);
 
 	print_nl();
 	print_uint(PRINT_ANY, "pkts_in", "  pkts_in %u", st->packets_in);
-- 
2.34.1


