Return-Path: <netdev+bounces-64803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E736837238
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 20:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4967E1C2A2FB
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D49D47A4D;
	Mon, 22 Jan 2024 19:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu8U8ZvF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A428E4B5B9
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 19:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705950431; cv=none; b=M9Lkwke2PPIhvcGwyt0M18c9YRPNl6eQ4aYQl83BvCV+iMZCL5n2PjAEhse73mpyTn6v2SMGP9UC1etOOjJQkMlqamPlJuVF3SMgVoT+HRR9vUbckrnLFv9qxUkSczeJ/iocqJOArdtid23VHU7XKGV3d5g4MNR9XnB8ky4caJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705950431; c=relaxed/simple;
	bh=J3X8GVbPwbWprmfKxurMXfCYtRxL+wL4zwEU0P0GXRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOuRtpvvNZ4plPUaSqaOV41d2J4j7XAqoKczFMzNqtirkz82V1iSJHfkILp28Vl7YAa6yy6jBNz7jj4TDOjdHhUPeu3jaY7Gl29QrFKiYhfp0FOEbeIXoh8xX9yLpPx6reNtKaNBbm4EECPw1RA4qM5mevWlklRDrPHDwL5vvs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu8U8ZvF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40eb28271f8so5118845e9.2
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705950428; x=1706555228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+61oH9jxk08/F+Ys2f393i8HD1ofs6XPqrs+bNHPwWE=;
        b=lu8U8ZvFA1Ch8Wr9j+5JNY1o6/HZUZjHEZ5wUXVl5Obq7VyVFPVb0/ax6k4vJYe8Pt
         ev7pjvGvFIcMWulwZeCBDEuOcc4gltHJisa8/YI/yd7SOFBCm2ARczNJdxXtFwfjo250
         vmR+8B71CM/vSXhdfbEOGCEMiHpcA0UqFlOTXl0pr39vdXmjGOu8/CU92hkw9hv9iFhY
         XOOYj1Eb1WU7HZIRdw/M9BEO1Tbbas7zswSWeZWLdITmLpiB4lBHUmSFDdktgXj3KfRY
         UsdDitRroExOHqX4ZApQjxHId8uXp55jYykvRfJ/Zv+n7xLSHPIljHZh0G55oQbux8uI
         1GLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705950428; x=1706555228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+61oH9jxk08/F+Ys2f393i8HD1ofs6XPqrs+bNHPwWE=;
        b=M0N9+trDa3GApB3TNamCPDlfCiS5WTN6+j5IBFGKEx2omgLjufmlvDVsNjUucquCO2
         GPmBEqgaCLoLIAGVC+gO7FR6a+9nFgx0y8pvCVeemntbBBQ4PQTm/Y3Lr0+2/FBS1fhJ
         6rySHH5aQZyu8ueur7o6Ej2evEvlw+vi0L5+2Kn7skn32S08jHyKbAuAFl7XzT5jWMmU
         VlT2B1jwO+yCqTpldTPSWZIqmVCevFzTle7HTzv3gDVdwSwUPeAY8jHwuAZAIIlJv3VJ
         ALcOjPivGTF10dcOrj6P5u2JRz3YSslXbpvEpKkjAw1b54oLMlwQFlx8Xkwx/cNgoXDO
         2Zpg==
X-Gm-Message-State: AOJu0YyCGYJCPW2q7Y5dMNfB4GliZ/KKbJvjqtcFJ0lqAYmD4gLwKBYy
	Zfcjbdo/yvEj4oAfJjpWiFTd2wlcio1r6FpUUGV93TDMR4rPplaS
X-Google-Smtp-Source: AGHT+IE2bbHeral2QsCEe0BKqPYfjzpDMfI/YKIep2u+GT57rJIfmrG17Iv5QVUlwNwU9sl1hJxMlQ==
X-Received: by 2002:a05:600c:470f:b0:40d:58d7:6370 with SMTP id v15-20020a05600c470f00b0040d58d76370mr1305544wmo.46.1705950427438;
        Mon, 22 Jan 2024 11:07:07 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id fl6-20020a05600c0b8600b0040ea9ba9d58sm6980385wmb.37.2024.01.22.11.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 11:07:06 -0800 (PST)
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
Subject: [PATCH net-next] taprio: validate TCA_TAPRIO_ATTR_FLAGS through policy instead of open-coding
Date: Mon, 22 Jan 2024 20:07:38 +0100
Message-ID: <20240122190738.32327-1-alessandromarcolini99@gmail.com>
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

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
---
 net/sched/sch_taprio.c | 71 +++++++++++++++---------------------------
 1 file changed, 25 insertions(+), 46 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 31a8252bd09c..b8ecebe17ae8 100644
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
+	__u32 taprio_flags;
 	ktime_t start;
 	int i, err;
 
@@ -1863,12 +1827,27 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
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
+		NL_SET_ERR_MSG_MOD(extack, "TXTIME_ASSIST and FULL_OFFLOAD are mutually exclusive");
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


