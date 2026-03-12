Return-Path: <netdev+bounces-267216-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLZ5AvM+s2k/TgAAu9opvQ
	(envelope-from <netdev+bounces-267216-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:32:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A3227AED6
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 23:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F17C230F3D4D
	for <lists+netdev@lfdr.de>; Thu, 12 Mar 2026 22:32:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EDAC31E83D;
	Thu, 12 Mar 2026 22:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="QFXVBt6y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EED231F9A5
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 22:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773354732; cv=none; b=iVbsAnPLfvDyxvxAzASnaJlo1D18VXpY22RuvJdsRFQbgyjC2P/EMVzlsczi13c2l7R4h6NPo5OlcB0mZE70OWcB1kX9/bZOVvQxH7Dl+O2nV4tNdpCxwaEUVkLuWKeIXrer38aZS12Q7munHMzyNvg1zbCSh0o6Tm1uj73yLVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773354732; c=relaxed/simple;
	bh=5LO45ZuoQ4fpB1CeZE8Jooq7YtevscjJKU7vw0VwJBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qYv3Ls32AjA2fonAXOHrXsrO7v1W2rSMXQtL3t8pxEF24/czYpIsTbbPwLOnTmMgpziVbpx73c9aXwqokKXVeWIvweha0mtHd1kpqfcJhMadSR3+t4PevuspeCeLMLqQZ/xLICHVavJ9uurUN/QjHuDX2/8HFu2WxgJPxwW9In8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=QFXVBt6y; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-2be1ab1fa7dso1206902eec.0
        for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 15:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1773354730; x=1773959530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CFTQ/9EY2qpWAsJtKWK/DmanWo4AnpzW4k7Uv6lI5+c=;
        b=QFXVBt6yfYWkYjSJMMYJQ/jN62hMJEHpqeKXWr0XBRvxnoHtuB7iBH5s3dBCqsxQ/b
         thn8iEGGlezMPixW8BFjnFWgeRsWThYwe9mz6VEcxeFuyCtxSu5SXAkk7901WY0MLU8s
         t5NVf47jiOjOQVCKlSjs/OvnrKe0Duqy7OJl8I7q/86lrAjRjQDQ2i0vF0OXOGqu7VoI
         6LkdHAhG0LdXVzENS/VRCx+YXAh1JV38X8YmrFqcr3lqxfPLRxtrMdbSW7Hz3eD1qfQd
         hfkpaTkVvf96J4vwzt5WPs1th4paXymCuv5l974IKp7FdsmKzTooHxr1VUnlw7NM5MOH
         Lz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773354730; x=1773959530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CFTQ/9EY2qpWAsJtKWK/DmanWo4AnpzW4k7Uv6lI5+c=;
        b=lp6FMiKBq2XcZlxroZCHCEoy0Nt5a4/dhDRaQk6Vg4pIMUiVd/EnWNC9KseyGnsWgl
         Ee1R17t2aMhAYfwxCprYAJZ6oTFwalNLH3wWAQSS3YnPVObB+Gn16IR0GXWZFjfjjvXF
         yjK+NEvt845d/5msVJ1YBZbmNOlj37Zfg/WapXKG9arkEfq6DXdi9rZ9r1cLot6TnCc6
         uFcMSlz8J2ZNhb8whLXW9nE+usVe+lfLR0/EZXhUApCHUGyCKqa/tKkEHLdRp28azorH
         QGlGrjwimXg73XjUgQYPfrDyYrujz0/pVMRbfcSqsOdsX0tAIZ4JE8nq+Nis/+Y6QS+s
         OpUw==
X-Forwarded-Encrypted: i=1; AJvYcCVPzmBDIB+xw/XNMVX9zMw+7QA/MIllK7/2J+ZL+Nxlm4UxoGbFTz+Jangvn7XtPNRLLPYpZNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE20JQwToM7R9iqzG87W3mC2O2R7CxHX3/kcZvSq6lrOwEcg33
	j7Hm9/7MFmXjZ19W8rZByRgFq5FaM59G0U8uXv1VmZMMN6++1Slo3zhyl1NkH+nM9g==
X-Gm-Gg: ATEYQzyMTahkKbj2RDCGpYurn04rjGl0+h1tPjusb+hiAbU892DzIIv8x/l9W76AJ8q
	c2g8KqUWyvMyS7GMNf1QKpW6zcSVNbEDLXT0GoHk6EkFJ/xkhcaVgoCvfYvRMbvZGA1R0Z8o9Gn
	SdG/GeQgQQhXsGOOCNMU02ihs9d+Euor6AawPH+Y2scHwYhJvQenKivT2XVoF5HeDvI6Y7VGof+
	StkpksJrUXlMGO3uTS4172vFp0DhF++rz0MRB+wOZ+WbVLn8DloRKg1XrEtU9H+5kbtkqL1rHkK
	VV2rURM4dgXCd/AjkaSwGuy0yRm2QTr9kWsuzYASl4Gv4FKdlPhUiVRps7iT7t2DpgJunPRdx/F
	K85r5Rv7S88Lkam0NoOFPX32FwgW4tWnA53yvSBLYxC9J3LLtcBGx4lFxP1dXfVgN+IH3APhX9Q
	uy7gzxuTo+b0Jvn8baUv0yB24mVywwNA73b3vMTywYouhXv29huPpx
X-Received: by 2002:a05:7300:e2cb:b0:2ae:55ac:3ff6 with SMTP id 5a478bee46e88-2bea53d83eemr681650eec.1.1773354729647;
        Thu, 12 Mar 2026 15:32:09 -0700 (PDT)
Received: from localhost.localdomain ([74.123.28.19])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2beab3a110csm71286eec.6.2026.03.12.15.32.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Mar 2026 15:32:09 -0700 (PDT)
From: Prasanna S Panchamukhi <panchamukhi@arista.com>
To: netfilter-devel@vger.kernel.org
Cc: panchamukhi@arista.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH net-next v2] netfilter: conntrack: expose gc_scan_interval_max via sysctl
Date: Thu, 12 Mar 2026 15:31:57 -0700
Message-ID: <20260312223157.25083-1-panchamukhi@arista.com>
X-Mailer: git-send-email 2.50.1
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
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267216-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_NEQ_ENVFROM(0.00)[panchamukhi@arista.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[arista.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63A3227AED6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The conntrack garbage collection worker uses an adaptive algorithm that
adjusts the scan interval based on the average timeout of tracked
entries.  The upper bound of this interval is hardcoded as
GC_SCAN_INTERVAL_MAX (60 seconds).

Expose the upper bound as a new sysctl,
net.netfilter.nf_conntrack_gc_scan_interval_max, so it can be tuned at
runtime without rebuilding the kernel.  The default remains 60 seconds
to preserve existing behavior.  The sysctl is global and read-only in
non-init network namespaces, consistent with nf_conntrack_max and
nf_conntrack_buckets.

In environments where long-lived offloaded flows dominate the table,
the adaptive average drifts toward the maximum, delaying cleanup
of short-lived expired entries such as those in TCP CLOSE state
(10s timeout). Adding sysctl to set the maximum GC scan helps to
tune according to the evironment.

Signed-off-by: Prasanna S Panchamukhi <panchamukhi@arista.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: Jonathan Corbet <corbet@lwn.net>
cc: Shuah Khan <skhan@linuxfoundation.org>
cc: Pablo Neira Ayuso <pablo@netfilter.org>
cc: Florian Westphal <fw@strlen.de>
cc: Phil Sutter <phil@nwl.cc>
cc: netdev@vger.kernel.org
cc: linux-doc@vger.kernel.org
cc: linux-kernel@vger.kernel.org
to: netfilter-devel@vger.kernel.org
cc: coreteam@netfilter.org
---
 Documentation/networking/nf_conntrack-sysctl.rst | 13 +++++++++++++
 include/net/netfilter/nf_conntrack.h             |  1 +
 net/netfilter/nf_conntrack_core.c                | 10 +++++++---
 net/netfilter/nf_conntrack_standalone.c          | 10 ++++++++++
 4 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/networking/nf_conntrack-sysctl.rst b/Documentation/networking/nf_conntrack-sysctl.rst
index 35f889259fcd..0e79f6ad1062 100644
--- a/Documentation/networking/nf_conntrack-sysctl.rst
+++ b/Documentation/networking/nf_conntrack-sysctl.rst
@@ -64,6 +64,19 @@ nf_conntrack_frag6_timeout - INTEGER (seconds)
 
 	Time to keep an IPv6 fragment in memory.
 
+nf_conntrack_gc_scan_interval_max - INTEGER (seconds)
+	default 60
+
+	Maximum interval between garbage collection scans of the connection
+	tracking table. The GC worker uses an adaptive algorithm that adjusts
+	the scan interval based on average entry timeouts; this parameter caps
+	the upper bound. Lower values cause expired entries (e.g. connections
+	in CLOSE state) to be cleaned up faster, at the cost of slightly more
+	CPU usage. Consider tuning this on systems with high connection churn
+	(e.g. NAT gateways, load balancers) where expired entries accumulate
+	and cause the conntrack table to fill up. Minimum value is 1.
+	This sysctl is only writeable in the initial net namespace.
+
 nf_conntrack_generic_timeout - INTEGER (seconds)
 	default 600
 
diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index bc42dd0e10e6..0449577f322e 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -331,6 +331,7 @@ extern struct hlist_nulls_head *nf_conntrack_hash;
 extern unsigned int nf_conntrack_htable_size;
 extern seqcount_spinlock_t nf_conntrack_generation;
 extern unsigned int nf_conntrack_max;
+extern unsigned int nf_conntrack_gc_scan_interval_max;
 
 /* must be called with rcu read lock held */
 static inline void
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 27ce5fda8993..8647e6824cec 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -91,7 +91,7 @@ static DEFINE_MUTEX(nf_conntrack_mutex);
  * allowing non-idle machines to wakeup more often when needed.
  */
 #define GC_SCAN_INITIAL_COUNT	100
-#define GC_SCAN_INTERVAL_INIT	GC_SCAN_INTERVAL_MAX
+#define GC_SCAN_INTERVAL_INIT	READ_ONCE(nf_conntrack_gc_scan_interval_max)
 
 #define GC_SCAN_MAX_DURATION	msecs_to_jiffies(10)
 #define GC_SCAN_EXPIRED_MAX	(64000u / HZ)
@@ -204,6 +204,9 @@ EXPORT_SYMBOL_GPL(nf_conntrack_htable_size);
 
 unsigned int nf_conntrack_max __read_mostly;
 EXPORT_SYMBOL_GPL(nf_conntrack_max);
+
+unsigned int nf_conntrack_gc_scan_interval_max __read_mostly = GC_SCAN_INTERVAL_MAX;
+
 seqcount_spinlock_t nf_conntrack_generation __read_mostly;
 static siphash_aligned_key_t nf_conntrack_hash_rnd;
 
@@ -1515,6 +1518,7 @@ static void gc_worker(struct work_struct *work)
 	unsigned int i, hashsz, nf_conntrack_max95 = 0;
 	u32 end_time, start_time = nfct_time_stamp;
 	struct conntrack_gc_work *gc_work;
+	unsigned long gc_scan_max = READ_ONCE(nf_conntrack_gc_scan_interval_max);
 	unsigned int expired_count = 0;
 	unsigned long next_run;
 	s32 delta_time;
@@ -1568,7 +1572,7 @@ static void gc_worker(struct work_struct *work)
 				delta_time = nfct_time_stamp - gc_work->start_time;
 
 				/* re-sched immediately if total cycle time is exceeded */
-				next_run = delta_time < (s32)GC_SCAN_INTERVAL_MAX;
+				next_run = delta_time < (s32)gc_scan_max;
 				goto early_exit;
 			}
 
@@ -1630,7 +1634,7 @@ static void gc_worker(struct work_struct *work)
 
 	gc_work->next_bucket = 0;
 
-	next_run = clamp(next_run, GC_SCAN_INTERVAL_MIN, GC_SCAN_INTERVAL_MAX);
+	next_run = clamp(next_run, GC_SCAN_INTERVAL_MIN, gc_scan_max);
 
 	delta_time = max_t(s32, nfct_time_stamp - gc_work->start_time, 1);
 	if (next_run > (unsigned long)delta_time)
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 207b240b14e5..f8cab779763f 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -637,6 +637,7 @@ enum nf_ct_sysctl_index {
 	NF_SYSCTL_CT_PROTO_TIMEOUT_GRE,
 	NF_SYSCTL_CT_PROTO_TIMEOUT_GRE_STREAM,
 #endif
+	NF_SYSCTL_CT_GC_SCAN_INTERVAL_MAX,
 
 	NF_SYSCTL_CT_LAST_SYSCTL,
 };
@@ -920,6 +921,14 @@ static struct ctl_table nf_ct_sysctl_table[] = {
 		.proc_handler   = proc_dointvec_jiffies,
 	},
 #endif
+	[NF_SYSCTL_CT_GC_SCAN_INTERVAL_MAX] = {
+		.procname	= "nf_conntrack_gc_scan_interval_max",
+		.data		= &nf_conntrack_gc_scan_interval_max,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_jiffies,
+		.extra1		= SYSCTL_ONE,
+	},
 };
 
 static struct ctl_table nf_ct_netfilter_table[] = {
@@ -1043,6 +1052,7 @@ static int nf_conntrack_standalone_init_sysctl(struct net *net)
 		table[NF_SYSCTL_CT_MAX].mode = 0444;
 		table[NF_SYSCTL_CT_EXPECT_MAX].mode = 0444;
 		table[NF_SYSCTL_CT_BUCKETS].mode = 0444;
+		table[NF_SYSCTL_CT_GC_SCAN_INTERVAL_MAX].mode = 0444;
 	}
 
 	cnet->sysctl_header = register_net_sysctl_sz(net, "net/netfilter",
-- 
2.50.1 (Apple Git-155)


