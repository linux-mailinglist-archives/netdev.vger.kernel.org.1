Return-Path: <netdev+bounces-57027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A45B811A2E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CEE31F218B2
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A425A2208A;
	Wed, 13 Dec 2023 16:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="L8pCNEkL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF195AF
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 08:57:58 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id 46e09a7af769-6d7fa93afe9so5292596a34.2
        for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 08:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702486678; x=1703091478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4djG6mlncQ5cDDuqSKlyJ4sw+dt1BUtqB30NNGpiggY=;
        b=L8pCNEkLH0v//dVbgUDisZejvrWw+JfT+9DYbBXwZf16tof71zQcHox2eEMzuLeOwT
         kVCPTe0UsztGFZxsjW2kXIfru1i+6D+Qfdaznz8YdDD8lteiC1FrzAfSTdwoa6CTEV1U
         jnXq/i063bggWlJD8LbLfYXpznGZNar98FM7tVzlNmnD/aTUn/n4FpY+qU/Fb8hYpmz0
         48VvhDGxIDfAfDFB31XJSvFmAl6GxJgkbJDFxeoubGz7AnpbvM1UKxd7SDJfPxDFwZy8
         jvPBcVWN4xd9T/Usvj4ZskjiFIkC8ZqtJ+Sm5/KTcW6OFGbJGqkP5xukQbV7Ym6S51IZ
         EYPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702486678; x=1703091478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4djG6mlncQ5cDDuqSKlyJ4sw+dt1BUtqB30NNGpiggY=;
        b=PHC8GRzWebxqQ03MRAPh98goagBCPQHN75071aetAzieCX82guOiZXPbdLFL3+WQmZ
         SF0dfbyExmfy6SGz79z3FQxIdZloJTgiukf9zdrDjbxqhVOKjlV4iuToa5CnxtqR/zSJ
         PVMW2GlgGpVlRQB/bLbTg4aZQbuPHHXplE5KC/MXqH+mGXj8uxpZ70k9mLloO9OxO1oB
         t+9w5XW52CKiqRP3hIjiyF9EQwvnM/+IU24XqnXrXhQSesHobmMCZ46DAkc6PfjL59xW
         ZVSwqLE1toWT0kZEFUBJR0oWz9s+m+iWdyhuYXmPXZIFrX6yfWPxarq9uXEI/Tw1hI4t
         zyAg==
X-Gm-Message-State: AOJu0Yxpr7ISEszfxSxlFCSLzUBuQKfLTbEcTZAI1hz6Ts8HFzGl0jpb
	aA41LuvF0UkSbgTE7pmAOJyXJ6Wt2tcu8PBImKU=
X-Google-Smtp-Source: AGHT+IGP1tHhXrWJOVtZoqWkTDENBWm7ajF4FkNfxaQD96uZGtiMd9IvgQDk8dQ2gGkmlwQwCmGGHA==
X-Received: by 2002:a05:6830:1051:b0:6d8:74f5:dc38 with SMTP id b17-20020a056830105100b006d874f5dc38mr6900722otp.9.1702486678226;
        Wed, 13 Dec 2023 08:57:58 -0800 (PST)
Received: from majuu.waya ([174.91.6.24])
        by smtp.gmail.com with ESMTPSA id qt6-20020a05620a8a0600b0077d8622ee6csm4618017qkn.81.2023.12.13.08.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 08:57:57 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Cc: jiri@resnulli.us,
	xiyou.wangcong@gmail.com,
	netdev@vger.kernel.org,
	pctammela@mojatatu.com,
	victor@mojatatu.com,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Coverity Scan <scan-admin@coverity.com>
Subject: [PATCH net 1/1] net_sched: sch_fq: Fix out of range band computation
Date: Wed, 13 Dec 2023 11:57:41 -0500
Message-Id: <20231213165741.93528-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It is possible to compute a band of 3. Doing so will overrun array
q->band_pkt_count[0-2] boundaries.

Fixes: 29f834aa326e ("net_sched: sch_fq: add 3 bands and WRR scheduling")
Reported-by: Coverity Scan <scan-admin@coverity.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/sch_fq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index 3a31c47fea9b..217c430343df 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -159,7 +159,7 @@ struct fq_sched_data {
 /* return the i-th 2-bit value ("crumb") */
 static u8 fq_prio2band(const u8 *prio2band, unsigned int prio)
 {
-	return (prio2band[prio / 4] >> (2 * (prio & 0x3))) & 0x3;
+	return (prio2band[prio / 4] >> (2 * (prio & 0x3))) % 0x3;
 }
 
 /*
-- 
2.34.1


