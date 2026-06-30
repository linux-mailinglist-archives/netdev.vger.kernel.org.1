Return-Path: <netdev+bounces-303334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HH8XFgoPRGpDnwoAu9opvQ
	(envelope-from <netdev+bounces-303334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:46:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B78006E74B4
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 20:46:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="DV0nusJ/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303334-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303334-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F1BDB3068996
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 18:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F84B3E0C4A;
	Tue, 30 Jun 2026 18:45:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D712D37AA81
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 18:45:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782845114; cv=none; b=B5VIb6wNXGW49zbiAnsWm8aKqfKIza2kOqnalgLonO40RKle2M3KYeoKujLuOq4YQr5+5ecAMSj1zWyECfPN2zS0+fM/Idda97nWV0EMSc7xRlNkJn5Gmr6hhyVfiX8yLlJvQfPyITq8dKNay8OSDrLGbfxiPvfmcqJcZdvredo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782845114; c=relaxed/simple;
	bh=gkBE4BmL/lLL1TpaRcEmsRLpqgjqr+jhYOoEpQK61mo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qxLdzLtQx1qqAfIDCvMFjxyz0jYGQr+Q+O7H0dmvEHXIBgE7uSJAuERlXkYITaLC1AC1MBPmxyKHtdLkUklK01pPDkPRp89lmG34bDHP9WdJ/4ii4pbvRinLVzIoYrStiqKJnME2AHKG55QrpNGUMNIXQzoBmBYQT1P3EgfTpq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DV0nusJ/; arc=none smtp.client-ip=74.125.82.171
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30c965eab27so1264889eec.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 11:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782845112; x=1783449912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IEkqmSirL0a+BTywhjvGg4Eyi1ij0+HKAe8dlHec8fM=;
        b=DV0nusJ/5HGsu+Rw7Dsx14nim6dqXUtskLiOyc94k1WZUxEeM7ZGriPCWvorNm8nlL
         VgwVe0HaLJNhgkpra8rb7qyTNPVkMs/ePEwV1yLwBha+s9ofg1o4+29xFGiw/Jb/l+YF
         vMsCqzjo2BPe2dO8HIE1zNxnhTqXBAJWLUfE0zK7cIA+OyWIf4K1MUkVOisBw6QnAsxk
         Nowzl8hliPfEUtGZrghcAQqaQ9gw1CIhfqe4Vy8b8Z04UyJ51moZTOxwLUwi49obpQV3
         BNznLJwtaUE4rJPmxC6eG1ioo5SooveAY+ecFPI+LSfWod/ENSYVHn/N0/0emLjqK1RJ
         g0FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782845112; x=1783449912;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IEkqmSirL0a+BTywhjvGg4Eyi1ij0+HKAe8dlHec8fM=;
        b=ZjfGCCvDFmIpQ42+pxX7bE6p16xNEA5PUobojNDdHicdMuGdegoWzVBIl9zboM0og4
         Lh6Ze4znp+3syJbL1N5pmxNHH9ogSNyPP7NPy3/gilhI/W23Skb/X0J/MFTeGGYXtA/y
         kyyPox5rHLwToWfRQBCFxyIFIC7BwMChd+A3/iR35fZ1tM3bef3106Cjl8J0RjBRz2XT
         2bKImOFTGRfeDOjP7rFfsJyFM67sAsJEOGBwDoKolcD4Pfr044ZKZFgaRb2VoYdEVtca
         tTYGx8eeh+I6NkJUqkwCxvBS/JSWDY4c1Lcu+TbMWBvh/efI4+xr5pPukZTaoECSuTmS
         PieQ==
X-Gm-Message-State: AOJu0Yx0xA+lKf5quaG1rMvS4cK3abOUHUK6Ekly30NcLZY4HCf7Skq2
	LfUgeV0XvlYWhCWVUhyULY54IKAlAfwwvVjJUrAvTmHW0V8/TOeR6e8yUsOsGRfD
X-Gm-Gg: AfdE7ck+IKVVkkIWBdI5QMsZjm2CroWeUql/YwI2j0nd3Pg+6jYtASQZelAqdRNZTTh
	k2zXHfmauYZu3VO1DoAZc56OmvrBxf1eQScQKK2Pjv3G/VoEHWBwq7x5lIbsLlLvAqKI29gpYwR
	nnLXocaSaiXeJzk1gthvemhuiFKTsfgj8HS7SWueh1OtAsdsOpfAd7B6XUezAkQ0C8lRTJMt0if
	M3QWk/ibrPBJrr8b2DG7ldFFy2WB5N7rLIx0pr6Kk9il77cRnEHh6lgOhjc9E+ckj9r2bY1BcOv
	UCDyINbtddxWDKXiHPPmpWqEH9FpIvmYfhpTT5VPGKDbdJZg47N5QFgNzgsgUcKKebhJv06Kxim
	m81HTArhF2W+89cPBy1UPwnaYGE+NADX7LokK1TlhaJS5/V6PjJUv+W7WgIBnTdgNkJfL+WbLkF
	AZGBdLywQZWGA//7yGsXCIcfPKmw==
X-Received: by 2002:a05:7301:1e90:b0:30c:57ff:454e with SMTP id 5a478bee46e88-30ef085996cmr1216660eec.18.1782845111881;
        Tue, 30 Jun 2026 11:45:11 -0700 (PDT)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:b5a1:965b:86fd:756])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee2fb6514sm9145614eec.7.2026.06.30.11.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:45:11 -0700 (PDT)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	jhs@mojatatu.com,
	linux-kernel@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH iproute2-next v3] Add support for printing per-flow PIE statistics exposed by the kernel via the new TCA_FQ_PIE_XSTATS_CLASS type in tc_fq_pie_xstats.
Date: Wed,  1 Jul 2026 00:14:53 +0530
Message-Id: <20260630184453.171410-1-hemendranaik@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[resnulli.us,mojatatu.com,vger.kernel.org,gmail.com,nitk.edu.in];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-303334-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jiri@resnulli.us,m:jhs@mojatatu.com,m:linux-kernel@vger.kernel.org,m:vishy0777@gmail.com,m:tahiliani@nitk.edu.in,m:hemendranaik@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hemendranaik@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nitk.edu.in:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B78006E74B4

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
https://lore.kernel.org/netdev/20260630183702.170798-1-hemendranaik@gmail.com/

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>

---
Changelog:

v3: 
 - Moved print_nl() into each xstats type block to preserve output formatting.

v2:
 - Addressed ABI backward compatibility issue. (https://lore.kernel.org/netdev/20260614130729.10076-1-hemendranaik@gmail.com/)

v1:
 - https://lore.kernel.org/netdev/20260531131411.28213-1-hemendranaik@gmail.com/
---
 include/uapi/linux/pkt_sched.h | 29 +++++++++++++++--
 man/man8/tc-fq_pie.8           | 18 +++++++++++
 man/man8/tc-pie.8              |  2 +-
 tc/q_fq_pie.c                  | 59 +++++++++++++++++++++++-----------
 tc/q_pie.c                     |  4 +--
 5 files changed, 88 insertions(+), 24 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index d1f67ef8..f56f24ad 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -920,9 +920,9 @@ enum {
 
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
@@ -953,6 +953,25 @@ enum {
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
@@ -963,6 +982,12 @@ struct tc_fq_pie_xstats {
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
index dc2710cd..1b89ee3a 100644
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
-	print_nl();
-	print_uint(PRINT_ANY, "new_flow_count", "  new_flow_count %u",
-		   st->new_flow_count);
-	print_uint(PRINT_ANY, "new_flows_len", " new_flows_len %u",
-		   st->new_flows_len);
-	print_uint(PRINT_ANY, "old_flows_len", " old_flows_len %u",
-		   st->old_flows_len);
-	print_uint(PRINT_ANY, "memory_used", " memory_used %u",
-		   st->memory_usage);
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
+		print_nl();
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
+		print_nl();
+	}
 
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


