Return-Path: <netdev+bounces-65390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9548A83A533
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45FF828FD48
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 09:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E654FEEC2;
	Wed, 24 Jan 2024 09:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYM8h51g"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A16E18046
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088047; cv=none; b=a0wZBIkdi5L0+WIPZ1UL5NYj8tHuBLwVYHwpzFxlQcP/926bRHCJMehAA8TQkXOi9A/tBgw6Ywu14rdsZNtYgT5M+2aFqT0vVgnA0W94gMQjjuy4LXelHd+YZ+wtVe1D7rJ36byXKKCDfM9rmjV0BxMKOFALNbcmu3MZYGSn7b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088047; c=relaxed/simple;
	bh=pIaxCm0BdTGQQl5j5AVo1QAjzXSWk71ot2uZGwLHwuU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NEP8ilWmbmApFaD0epS24Qlb9r0fZNUXri+RVwgrjI18HnxZRd3Gn/UwsZ6jkMqPknpFDJa6FSFTSC2x/hl7+yFddlWFJ/Cx2c9n81fICxlqHM/zJRY8nX4hAch+lg0vIH9Yh03fi+gtHxThS2tlWlj7Kwb/3mvdLQMfo2pEcCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aYM8h51g; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40e76109cdeso57938755e9.0
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 01:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706088044; x=1706692844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gbgXcjMo0b1tw7GtKUoz78SRHuz+q9W4Uz72HU1vbaY=;
        b=aYM8h51gKD5va30SvjHB739rlws6TXAX2w/WTbBkb5F5yyxQBKl5EnmDoeEPT8T7wj
         7FXTfDd5D8IqUmPdDGNWedg/c4orp1+Rj/o5TPcExGWHv7D1iEx4bB9B78ZebTpe/F8+
         zPxDT2LugL2At3USU5aqwjmWXUX2IpqQdnAuzRRA5IYnSyS12xGkKy81vhDqR7AYSM9a
         d+H+sEF+4ifMoSw8Lvb0qmieRcuMwwg3CYWVGYce7OWTtQC8KAcqiMrhT0frL9WkDIXz
         h4Zo6AIAhuBQNmERLCeINxhA8Oy/R5m1qj+/HVqX+kxrrrXLjEtuO4LCg5Ikhz5bKiGJ
         XQww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706088044; x=1706692844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gbgXcjMo0b1tw7GtKUoz78SRHuz+q9W4Uz72HU1vbaY=;
        b=t5P9j0Vva9J1rS9KQZrCQ8vg4+OFvlRws/LZaeesETC3IggPaVQXt5zc5lH490KoTu
         ob1rQx3dU4YHw/tcCeHm9PJUO8+7az9nXHxJw3rLqiCB0YxC6VjiS9ZM1E9wTuNBefde
         07/GMq+LUm8L6+M7TElE7e1h1AhuBbcjWBvgzQb4NCIipvPPO0bSkmw1HhkLIOkiap8+
         dBQ3/PslcQkr4590XZkLw72t/vSVwMFfyNqGzX6V/GBPKuxQ9SQGPIXtzHvo4Oqxw/M7
         dkgZwP/ZFyvDXBhC7baaZeSKvEwWAOnwdCvWws5DvHJvz2t9GZ6R9d6Nih+b7d/8zgjr
         jhVA==
X-Gm-Message-State: AOJu0Yzl7pAgGpKG1q9TjoN/IKi25qwYI6WYqLm1pA4fSg80DyDczgp2
	DAcNAgAwxxzneL6SykONImZOJoejuLllNVHAxlEN2PS8WSnmdHZJliwRZUqboGBk+A==
X-Google-Smtp-Source: AGHT+IEcMMS7dpfJpDBiFiYQXXFrSfTWA3OzEER6pD2Fsh2VjY2hQsGDsyhof16D/GKJbzVkKbj1Uw==
X-Received: by 2002:a05:600c:4e86:b0:40e:b195:6bdb with SMTP id f6-20020a05600c4e8600b0040eb1956bdbmr866618wmq.2.1706088043990;
        Wed, 24 Jan 2024 01:20:43 -0800 (PST)
Received: from localhost.localdomain ([2001:b07:646f:4a4d:e17a:bd08:d035:d8c2])
        by smtp.gmail.com with ESMTPSA id y8-20020a5d4ac8000000b00337af95c1d2sm18205477wrs.14.2024.01.24.01.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:20:43 -0800 (PST)
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
Subject: [PATCH v2 net-next] taprio: validate TCA_TAPRIO_ATTR_FLAGS through policy instead of open-coding
Date: Wed, 24 Jan 2024 10:21:18 +0100
Message-ID: <20240124092118.8078-1-alessandromarcolini99@gmail.com>
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

Changes since v1 (https://lore.kernel.org/netdev/b90a8935-ab4b-48e2-a21d-1efc528b2788@gmail.com/T/#t):
- Changed NL_SET_ERR_MSG_MOD to NL_SET_ERR_MSG_ATTR when wrong flags
  issued
- Changed __u32 to u32

Signed-off-by: Alessandro Marcolini <alessandromarcolini99@gmail.com>
---
 net/sched/sch_taprio.c | 72 +++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 46 deletions(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 31a8252bd09c..9beecaa4e4d4 100644
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
+		NL_SET_ERR_MSG_ATTR(extack,
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


