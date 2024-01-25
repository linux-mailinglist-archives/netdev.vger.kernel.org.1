Return-Path: <netdev+bounces-65941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D6783C959
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 18:08:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1C9E1C2564A
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 17:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A22C130E32;
	Thu, 25 Jan 2024 16:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlDAwVub"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAEC13172B
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706201951; cv=none; b=cc3sns5FL2RIbkTjEM37JoHspuco3Kz2+ZEg1SlWnJRo4HM/e3hYFI9+K/adEtP/7+/x7CBrF5hN/AINKK4ECrr2Nn6Jbvag0D9oBBWIa0tztz0BTe20zk3LMjFAOWi3CSSAmEAWXH07uObEV4LWcS40sBpYgT+dxHkAHYzjNO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706201951; c=relaxed/simple;
	bh=iWqnIieplAexm5b3NmizA6tw4WA7F42nlPxrG3bEjSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VVKbVTiGIV6Kuaz+I+ws9YbAHjx5E92EHlOwc4J5XmL7wHRcwQTOCRTkAMBAXqIszC357koLiFvQcb3OGpXoiwd6Qyu/yflog7L7SCg3ldIVIXy9osHF+C4cuVp8W5tkrJtcErjQF7PGnl5WgtmFaN4WJM9Fkg9FLdj2cDBKaMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QlDAwVub; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55d20f24275so18113a12.0
        for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 08:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706201947; x=1706806747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ncYSXF4bTpyZ/DBhzXGGCGuyzw9JfT3zVe+J0FxiOoc=;
        b=QlDAwVubduwGnDFNGJLzx4FTP7XjzqsBK2JKT9k0GW4ZAE6OeICfEJaaGAeDMHvAfo
         s01bf64ecISq8SimRHJPq21hnSPYrnPYniIU/QvVmUXsDWZgQ+wFugE0QFaQCPjalKcO
         9RTFmRX7+1zwe0xYUVFUCKWkrXesmknCwta8dhq3r/bTTaHh+J/0NGEbdzLmXPe6rShM
         O793Bc0ad79vmgLFr1nqPggUxXSf1SNO3X7oMTXjRdR8TnQSAtAcNeAAx4KVngG5EE48
         tLl6MbXWHyrsuQkraY/sHJPr3NYpJ/7t7equ2rupZSHbO0u89vufHMr0/ppvYIiEjb6w
         XHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706201947; x=1706806747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ncYSXF4bTpyZ/DBhzXGGCGuyzw9JfT3zVe+J0FxiOoc=;
        b=YX7RwOaF29UXCaI1FYsE0XJu2hdt2n1s1Z5A87hRq6pPRjaFxsr5qWTfxp5y3s+JUQ
         L5PRgqrl4KuxJ8iQ1Njr7GKJEUU4SplZQptCCCBdDHK391+ZJrtVRGAYYtbOJBw307Jf
         agnH4GFEA5vUkPZVvmV6XYbbnCEi+i5Qs8wXPeFM+gDlYkZZRr0aeWX3yrM3CjCcPxeu
         dpT3PidaphgtEsAfEqfqslVSuv1Xt54eG9Ud60U2KpF4p6ZtCiA1k3dw2H7T82QEP0ba
         piiSQHTZmtIjX9LsrTfh8Iq4En/5c4rzMnqzHO+61YSQ0GgUI7og529mHpD3Q54XHP5D
         wC4g==
X-Gm-Message-State: AOJu0YwPvn2mKZAmFdOmVQY/ycus7gkA2r3/kyUfYdKaWyE+4RmIdOCA
	EWWGCfXDdlwQ+ucqc4M0SwYpTbv070tZpgGQsG5XCgkTszbPCHk+
X-Google-Smtp-Source: AGHT+IGESaFO4T45MdC6E6nCD9XBNedmQ6JHe3ytnk3RumwEPctG3XJs0Lm1gwwmA8onVJPCRhFnVg==
X-Received: by 2002:aa7:db52:0:b0:55c:a88a:b1d3 with SMTP id n18-20020aa7db52000000b0055ca88ab1d3mr775605edt.31.1706201947471;
        Thu, 25 Jan 2024 08:59:07 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id fk4-20020a056402398400b005576a384b46sm17605822edb.10.2024.01.25.08.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 08:59:07 -0800 (PST)
From: Alessandro Marcolini <alessandromarcolini99@gmail.com>
To: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>
Subject: [PATCH v3 net-next] taprio: validate TCA_TAPRIO_ATTR_FLAGS through policy instead of open-coding
Date: Thu, 25 Jan 2024 17:59:42 +0100
Message-ID: <20240125165942.37920-1-alessandromarcolini99@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of now, the field TCA_TAPRIO_ATTR_FLAGS is being validated by manually
checking its value, using the function taprio_flags_valid().

With this patch, the field will be validated through the netlink policy
NLA_POLICY_MASK, where the mask is defined by TAPRIO_SUPPORTED_FLAGS.
The mutual exclusivity of the two flags TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD
and TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST is still checked manually.

Changes since RFC:
- fixed reversed xmas tree
- use NL_SET_ERR_MSG_MOD() for both invalid configuration

Changes since v1:
- Changed NL_SET_ERR_MSG_MOD to NL_SET_ERR_MSG_ATTR when wrong flags
  issued
- Changed __u32 to u32

Changes since v2:
- Added the missing parameter for NL_SET_ERR_MSG_ATTR (sorry again for
  the noise)

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
---
 net/sched/sch_taprio.c | 72 +++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 46 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 31a8252bd09c..b73f7d6b7a45 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -40,6 +40,8 @@ static struct static_key_false taprio_have_working_mqprio;
 
 #define TXTIME_ASSIST_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST)
 #define FULL_OFFLOAD_IS_ENABLED(flags) ((flags) & TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)
+#define TAPRIO_SUPPORTED_FLAGS \
+	(TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST | TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)
 #define TAPRIO_FLAGS_INVALID U32_MAX
 
 struct sched_entry {
@@ -408,19 +410,6 @@ static bool is_valid_interval(struct sk_buff *skb, struct Qdisc *sch)
 	return entry;
 }
 
-static bool taprio_flags_valid(u32 flags)
-{
-	/* Make sure no other flag bits are set. */
-	if (flags & ~(TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST |
-		      TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD))
-		return false;
-	/* txtime-assist and full offload are mutually exclusive */
-	if ((flags & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST) &&
-	    (flags & TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD))
-		return false;
-	return true;
-}
-
 /* This returns the tstamp value set by TCP in terms of the set clock. */
 static ktime_t get_tcp_tstamp(struct taprio_sched *q, struct sk_buff *skb)
 {
@@ -1031,7 +1020,8 @@ static const struct nla_policy taprio_policy[TCA_TAPRIO_ATTR_MAX + 1] = {
 	[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME]           =
 		NLA_POLICY_FULL_RANGE_SIGNED(NLA_S64, &taprio_cycle_time_range),
 	[TCA_TAPRIO_ATTR_SCHED_CYCLE_TIME_EXTENSION] = { .type = NLA_S64 },
-	[TCA_TAPRIO_ATTR_FLAGS]                      = { .type = NLA_U32 },
+	[TCA_TAPRIO_ATTR_FLAGS]                      =
+		NLA_POLICY_MASK(NLA_U32, TAPRIO_SUPPORTED_FLAGS),
 	[TCA_TAPRIO_ATTR_TXTIME_DELAY]		     = { .type = NLA_U32 },
 	[TCA_TAPRIO_ATTR_TC_ENTRY]		     = { .type = NLA_NESTED },
 };
@@ -1815,33 +1805,6 @@ static int taprio_mqprio_cmp(const struct net_device *dev,
 	return 0;
 }
 
-/* The semantics of the 'flags' argument in relation to 'change()'
- * requests, are interpreted following two rules (which are applied in
- * this order): (1) an omitted 'flags' argument is interpreted as
- * zero; (2) the 'flags' of a "running" taprio instance cannot be
- * changed.
- */
-static int taprio_new_flags(const struct nlattr *attr, u32 old,
-			    struct netlink_ext_ack *extack)
-{
-	u32 new = 0;
-
-	if (attr)
-		new = nla_get_u32(attr);
-
-	if (old != TAPRIO_FLAGS_INVALID && old != new) {
-		NL_SET_ERR_MSG_MOD(extack, "Changing 'flags' of a running schedule is not supported");
-		return -EOPNOTSUPP;
-	}
-
-	if (!taprio_flags_valid(new)) {
-		NL_SET_ERR_MSG_MOD(extack, "Specified 'flags' are not valid");
-		return -EINVAL;
-	}
-
-	return new;
-}
-
 static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 			 struct netlink_ext_ack *extack)
 {
@@ -1852,6 +1815,7 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	struct net_device *dev = qdisc_dev(sch);
 	struct tc_mqprio_qopt *mqprio = NULL;
 	unsigned long flags;
+	u32 taprio_flags;
 	ktime_t start;
 	int i, err;
 
@@ -1863,12 +1827,28 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 	if (tb[TCA_TAPRIO_ATTR_PRIOMAP])
 		mqprio = nla_data(tb[TCA_TAPRIO_ATTR_PRIOMAP]);
 
-	err = taprio_new_flags(tb[TCA_TAPRIO_ATTR_FLAGS],
-			       q->flags, extack);
-	if (err < 0)
-		return err;
+	/* The semantics of the 'flags' argument in relation to 'change()'
+	 * requests, are interpreted following two rules (which are applied in
+	 * this order): (1) an omitted 'flags' argument is interpreted as
+	 * zero; (2) the 'flags' of a "running" taprio instance cannot be
+	 * changed.
+	 */
+	taprio_flags = tb[TCA_TAPRIO_ATTR_FLAGS] ? nla_get_u32(tb[TCA_TAPRIO_ATTR_FLAGS]) : 0;
 
-	q->flags = err;
+	/* txtime-assist and full offload are mutually exclusive */
+	if ((taprio_flags & TCA_TAPRIO_ATTR_FLAG_TXTIME_ASSIST) &&
+	    (taprio_flags & TCA_TAPRIO_ATTR_FLAG_FULL_OFFLOAD)) {
+		NL_SET_ERR_MSG_ATTR(extack, tb[TCA_TAPRIO_ATTR_FLAGS],
+				    "TXTIME_ASSIST and FULL_OFFLOAD are mutually exclusive");
+		return -EINVAL;
+	}
+
+	if (q->flags != TAPRIO_FLAGS_INVALID && q->flags != taprio_flags) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Changing 'flags' of a running schedule is not supported");
+		return -EOPNOTSUPP;
+	}
+	q->flags = taprio_flags;
 
 	err = taprio_parse_mqprio_opt(dev, mqprio, extack, q->flags);
 	if (err < 0)
-- 
2.43.0


