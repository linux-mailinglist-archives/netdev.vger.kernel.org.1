Return-Path: <netdev+bounces-299218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +cENOBaoLmqH1gQAu9opvQ
	(envelope-from <netdev+bounces-299218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 15:09:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E360681163
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 15:09:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=iTRAY52k;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299218-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299218-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D65A0300BD97
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 13:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72AB6383C8F;
	Sun, 14 Jun 2026 13:08:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177723264DA
	for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 13:08:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781442492; cv=none; b=O9sYKk7N/gywBMWzp/jd+E0mSwTotGzaY81+PyjbooLvhum9QG847xmVIGa2/ByWkoDgjA4kTAndEbRvyqCQlxdZOWaJBGeq/XC9C+UJ+0c7dLh58E7q96kTq9CvfpYLGTuehNNL+oCvFtzG65PPJhResQZKVnuyvheNfH1+5Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781442492; c=relaxed/simple;
	bh=tlonLiFfkD+xGtzUT7c1md7QnYH9qfAly1HI3onYnOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YpF7NnyCyAYnexedRSwjmo6+5N4bBN8myabnxvMtfDDBEXLAVwNNy9kRVcCHL85w623OWRtkoLw3PUI9U1v39RTh/b08MlGieTrAlw8dk/Wgg+ivDJxCABQwIVeFeXMOVJT5usI9qmCDwy8DAPNXDOaxuPFKRCMzxxAKrbkzbaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTRAY52k; arc=none smtp.client-ip=209.85.215.178
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c85893bce34so983974a12.1
        for <netdev@vger.kernel.org>; Sun, 14 Jun 2026 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781442490; x=1782047290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AuthO5LcoqLqe+VONYls6Sna191y1VrvgjZGMSzSn2Y=;
        b=iTRAY52k1Bo9WFSeapd9Hy2uLPsZbJEmLR9Ot6V0d6eBPMQwGptXy8lb3RfBhNOWcl
         5uxFfA5oQqf1JmlvtvpDM8xuaGalwL/+GGbnp8teP4kpWeKsNbo6yV49h8yXRBnP5NnF
         RuyAYYqjV5xJEm4PQGUBvnnfIA3pA92sIZhTu8WrRwmyiXFZQKnGpMcRainDPwiziRID
         Mwpzxx+l89lu2WBysXhisGjOFMIjASjYT5FlG7UWfPqwopOsEr2cHVETTG1BYMguZFFH
         kDea7PQdEuakDcZjO67MUQyv0rT9YzjBtE9RKlNGHY+2P3ClKVU8SxK3oDOU7ldXwOA2
         pKAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781442490; x=1782047290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AuthO5LcoqLqe+VONYls6Sna191y1VrvgjZGMSzSn2Y=;
        b=X5T8ukRvTXEjzNWav4qHTB2p8N1Jn6sME7prvlTCd5J0roF3R7TzvkBQi6KTAIf7Oz
         RezXNMHWfjtkyB6ZSz5SI9WfAN4rRbyVMjfkbiT3B93BCzLRuXV7fC9aA+f2ynr+IhPE
         TUVEjzcYz1nGgmZoWgr4r/039vtXuVbZau1mMhOXEdsfCsXFjXVYv1rS4iyFIkjA0gU9
         e23ZNNXyDSLKs4WSKtxatF+xC2NN7/DSclYN5YIbxONAzteZraSa1eeRnYtT6z4ycQ1u
         2naNpo3GD/hywVqnohpZWAYX4Twh78jPU95U1CBLLixHuaFMefasnguIM7J4tEmQZUz5
         DJmQ==
X-Gm-Message-State: AOJu0Yx6+SJFlhvJ4TQvXUKFAVqQDtfGRohPlqaGHAwF7mNbjITELg9E
	bYEyUY3LGAN1HmqBNoZIKEZrGZDrEJcxMhqhO8Harl4GFejqx+RmISX37VGJs/q0cZ4SGw==
X-Gm-Gg: Acq92OFTWE6h/Bcd5qS/l7zh1xSgA6bcteKB42c9IEQWwVQOGMq8qdS4VxJ3SDvfnk3
	roKIgIOovqw9vxqZ1sZQhgUhpfN6PrpqRNR/w6WFV4H17rCVOzJpZ6bpaJlAUwwNxfJZjW9dbIC
	Amu36vQQCGvdlG5MA1V6XHM/n81o5Do/M4aZjy8pk4FTP/csbQiG0tRpZvmvuq/Nco0nPI5XXrh
	XHZnr2u5cPS13WQ6SYiyLR6+hfdjYcQ7T/BVXa6FAYTCEjV7Y7A2dSwni/ry45AlomEW8y2np6M
	poBogFgKgBPYY/aHlLmaLYY8IsxZuGFEzdvQAPaerbIFj2BSKTHbynGy6opOJTXn2tBK0Vbtw/w
	f+Y9rxDRuvMfDDZ4qnPaxR5Ffe/St3JWGGyHjfWj1/HTquYp4NhuxmXFMS8PSTl5OZg+T6Axa9s
	oGIY6OGM7K0uIaS/OVelpmXW4Q3I+XwP0rx2VTkhY=
X-Received: by 2002:a05:6a21:6190:b0:3a3:2b7e:a49b with SMTP id adf61e73a8af0-3b79600bb18mr7729599637.0.1781442490378;
        Sun, 14 Jun 2026 06:08:10 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:90b2:9957:66e9:8cb4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434afc8a5bsm7460244b3a.33.2026.06.14.06.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 06:08:10 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v2] tc: fq_pie: add support for printing per-flow PIE statistics
Date: Sun, 14 Jun 2026 18:37:29 +0530
Message-Id: <20260614130729.10076-1-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[resnulli.us,mojatatu.com,vger.kernel.org,gmail.com,nitk.edu.in];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-299218-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:jhs@mojatatu.com,m:linux-kernel@vger.kernel.org,m:vishy0777@gmail.com,m:tahiliani@nitk.edu.in,m:hemendranaik@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hemendranaik@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hemendranaik@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,nitk.edu.in:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3E360681163

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

The corresponding kernel patch can be viewed here:
https://lore.kernel.org/netdev/20260614125000.6058-1-hemendranaik@gmail.com/

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>

---
Changelog:
v2: Addressed ABI backward compatibility issue for tc_fq_pie_xstats

v1: https://lore.kernel.org/netdev/20260531131411.28213-1-hemendranaik@gmail.com/
---
 include/uapi/linux/pkt_sched.h | 29 +++++++++++++++--
 man/man8/tc-fq_pie.8           | 18 +++++++++++
 man/man8/tc-pie.8              |  2 +-
 tc/q_fq_pie.c                  | 57 +++++++++++++++++++++++-----------
 tc/q_pie.c                     |  4 +--
 5 files changed, 87 insertions(+), 23 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index fb07a889..4927f7b8 100644
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
@@ -943,6 +943,25 @@ enum {
 };
 #define TCA_FQ_PIE_MAX   (__TCA_FQ_PIE_MAX - 1)
 
+enum {
+	TCA_FQ_PIE_XSTATS_QDISC,
+	TCA_FQ_PIE_XSTATS_CLASS,
+};
+
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
+struct tc_fq_pie_xqd_stats {
+	/* placeholder for new qdisc-level stats */
+};
+
 struct tc_fq_pie_xstats {
 	__u32 packets_in;	/* total number of packets enqueued */
 	__u32 dropped;		/* packets dropped due to fq_pie_action */
@@ -953,6 +972,12 @@ struct tc_fq_pie_xstats {
 	__u32 new_flows_len;	/* count of flows in new list */
 	__u32 old_flows_len;	/* count of flows in old list */
 	__u32 memory_usage;	/* total memory across all queues */
+	__u32 type;
+	union {
+		struct tc_fq_pie_cl_stats class_stats;
+		struct tc_fq_pie_xqd_stats xqdisc_stats;
+	};
+
 };
 
 /* CBS */
diff --git a/man/man8/tc-fq_pie.8 b/man/man8/tc-fq_pie.8
index 457a56bb..bf988f5f 100644
--- a/man/man8/tc-fq_pie.8
+++ b/man/man8/tc-fq_pie.8
@@ -153,6 +153,24 @@ dq_rate_estimator
   pkts_in 6082 overlimit 0 overmemory 0 dropped 4 ecn_mark 0
   new_flow_count 94 new_flows_len 0 old_flows_len 8 memory_used 1157632
 
+# tc qdisc add dev eth0 parent 100:1 handle 200: fq_pie target 2ms flows 3
+.br
+# tc -s class show dev eth0
+.br
+class fq_pie 200:2 parent 200:
+ Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
+ backlog 22800b 2p requeues 0
+  prob 0.57679 delay 2.38ms
+
+# tc qdisc add dev eth0 parent 100:1 handle 200: fq_pie target 2ms flows 3 dq_rate_estimator
+.br
+# tc -s class show dev eth0
+.br
+class fq_pie 200:2 parent 200:
+ Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
+ backlog 22800b 2p requeues 0
+  prob 0.57679 delay 2.38ms avg_dq_rate 10742Kbit
+
 .SH SEE ALSO
 .BR tc (8),
 .BR tc-pie (8),
diff --git a/man/man8/tc-pie.8 b/man/man8/tc-pie.8
index 5a8c7820..f3a09616 100644
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
index dc2710cd..678f045f 100644
--- a/tc/q_fq_pie.c
+++ b/tc/q_fq_pie.c
@@ -274,6 +274,8 @@ static int fq_pie_print_xstats(const struct qdisc_util *qu, FILE *f,
 {
 	struct tc_fq_pie_xstats _st = {}, *st;
 
+	SPRINT_BUF(b1);
+
 	if (xstats == NULL)
 		return 0;
 
@@ -283,25 +285,43 @@ static int fq_pie_print_xstats(const struct qdisc_util *qu, FILE *f,
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
+	if (!st->type || st->type == TCA_FQ_PIE_XSTATS_QDISC) {
+		print_uint(PRINT_ANY, "pkts_in", "  pkts_in %u",
+			   st->packets_in);
+		print_uint(PRINT_ANY, "overlimit", " overlimit %u",
+			   st->overlimit);
+		print_uint(PRINT_ANY, "overmemory", " overmemory %u",
+			   st->overmemory);
+		print_uint(PRINT_ANY, "dropped", " dropped %u",
+			   st->dropped);
+		print_uint(PRINT_ANY, "ecn_mark", " ecn_mark %u",
+			   st->ecn_mark);
+		print_nl();
+		print_uint(PRINT_ANY, "new_flow_count", "  new_flow_count %u",
+			   st->new_flow_count);
+		print_uint(PRINT_ANY, "new_flows_len", " new_flows_len %u",
+			   st->new_flows_len);
+		print_uint(PRINT_ANY, "old_flows_len", " old_flows_len %u",
+			   st->old_flows_len);
+		print_uint(PRINT_ANY, "memory_used", " memory_used %u",
+			   st->memory_usage);
+	}
+
+	if (st->type == TCA_FQ_PIE_XSTATS_CLASS) {
+		print_float(PRINT_ANY, "prob", " prob %lg",
+			    (double)st->class_stats.prob / (double)UINT64_MAX);
+		print_uint(PRINT_JSON, "delay", NULL, st->class_stats.delay);
+		print_string(PRINT_FP, NULL, " delay %s",
+			     sprint_time(st->class_stats.delay, b1));
+		print_int(PRINT_ANY, "deficit", " deficit %d",
+			  st->class_stats.deficit);
+
+		if (st->class_stats.dq_rate_estimating) {
+			tc_print_rate(PRINT_ANY, "avg_dq_rate", " avg_dq_rate %s",
+				      st->class_stats.avg_dq_rate);
+		}
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
 
 	return 0;
 
diff --git a/tc/q_pie.c b/tc/q_pie.c
index 04c9aa61..abae1ced 100644
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


