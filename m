Return-Path: <netdev+bounces-183222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4B3A8B6B9
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A24E3BC9DF
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9F8247292;
	Wed, 16 Apr 2025 10:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="KSrjpUV1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D3322253BB
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799080; cv=none; b=lEUhgz1YzU3BDJaVawMV00YBSSN7G4ycSBB7IveYYDUAeygjeckroAMCJ6bEi26F5uCKlxt7+eBO3tEmgQVHf/qlkvdjbcnkJXCL+F9mT9kyr6P+K3RS1BiXk9bjFHiWhkYPqTYQ/DOkGw4+5LbX0OXtGjLC6e+RvAzoxMMol8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799080; c=relaxed/simple;
	bh=omETtGJCALA8J9bjWNY0LRya57dd/a1BqnWH+fRZkjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m8jZug1Bj+aHA384MoGNkJLISY9VIQwmr62Kcg/ciZazVICQpKOftfsPSqLfzP6vIlofO3y1Hjm3Ct8uG+OmgADMmG+0m4OAO3btMKagEJKp48iK+gNXfkpzJFwDpOKBu5koKo6H3qKqm0BlosVIYuE0r02NwOkEXAhc9WwRd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=KSrjpUV1; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7394945d37eso5681390b3a.3
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744799078; x=1745403878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4iIKlGhsrCLIi35gr48AEMyyNNnFxBxT5XzC+gCyGo=;
        b=KSrjpUV1V8IeqYJqnnz8DXPVQySr/lCVsTllp4IRDYQPenitjggvVvJgMAaOF4Q3VW
         yOVkLS1psXPyRYd6jxYKZ3+YEPaSSHLREq9S0kSr8sDOHTVCowm3bYguuqPLpkKmXoqN
         6ej9zqCmwFmgig3qXwDIW4ym7O32+NHrfqhS8oWmH4wTNvUW5pM1YSMi0d32+eP+MsTA
         KuWocZCoAFkXTCMSTLSSvLKNKv3htxrx7oPVkKkVIPDnU7HWViLalQ5jiojRnkN3LdZB
         gTsIRGyP4xC+A6na6X6wCpXmWkbD9JWyIkpP2Qe9y2cGr+C+2D4tbZmVy9nUwqFDcjsd
         3PsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744799078; x=1745403878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4iIKlGhsrCLIi35gr48AEMyyNNnFxBxT5XzC+gCyGo=;
        b=SDRzFcimDxoenApa28puWfP36OTXHSmJfQqsC/icPjRx1AVqXzm44R+OrXyVKRYBhI
         oO+zsgO3LlBMiYo5LrSbG2yfQ1RV1fwZVu0FRT3Qw2fc1uv1YuagLnd3CxTy0pb8m+uU
         j6aYKxod7Y3lrl5p1l8/gzJY3QoIIm72mQGJY203+X5xrvipk3Q4b5FGt7oKAfQrJAhC
         hoJ9wMhVuD/USnRZUkoldhM/r/tpIp7RmdGGt0J7LUoF/Zq5ixPLyvONwZaot9IwXxmz
         e3QcXelqUj0vh1GwfNDgp39WdnTROZpKa6pAysEknJ5bv4L5LmqgUfRHFpWlJkFHmJDh
         mK+w==
X-Gm-Message-State: AOJu0YyBpYHAGXD8HKK0pISFjxVenGIwQbv9qah8ZjyxLl1B4QdinSCl
	NpRmjI4cIqhQQq8g6Ibh12bMqFis9eQJ9prBDksT3TS4F1DmRIYwcwN524NOYgM5KI2rFcYaToM
	=
X-Gm-Gg: ASbGnctpgYh6DMMuvNCpvjQEonNuVd0nPE0W/Y82U4LSQoLf8bbtZiTxYrpxE3wQE5y
	y7HVFg/dkKgK0fi1mpd0WPbyyIn8JR7eLbfpofLM5aU6W01MTZs5ylO16129Gflr5AVsT2IcAmo
	OilFmhxymRqEvcMOX7rCObVX8rej2qaS4JmEQ7nyxGvOa/InOosEdG5NlY23dSIN4aYd7li4oyU
	5vhkZXSWuGqYKao7oBzFH8ThIGVFbgZ98vk/UYVkrI65T8FFfXZb3najfWmXhzuDJBYtFiyBrfs
	lMZadpcjayRpiRJ9yHGGChN0CljxuU0bvyyRHNQZ906hYDdMBxK3e0m6e6Xh29/r
X-Google-Smtp-Source: AGHT+IGjkXGjB5u3z5BS/KTAFatBJVj0Cve1uDbJijdbtelQPtXBt4CctdyFqHKnImPMcRjAdhOuAg==
X-Received: by 2002:a17:90a:da83:b0:2f4:4500:bb4d with SMTP id 98e67ed59e1d1-30863f3046emr1716850a91.20.1744799078159;
        Wed, 16 Apr 2025 03:24:38 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308613cb765sm1193075a91.43.2025.04.16.03.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:24:37 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	gerrard.tai@starlabs.sg,
	pctammela@mojatatu.com
Subject: [PATCH net v2 1/5] net_sched: drr: Fix double list add in class with netem as child qdisc
Date: Wed, 16 Apr 2025 07:24:23 -0300
Message-ID: <20250416102427.3219655-2-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416102427.3219655-1-victor@mojatatu.com>
References: <20250416102427.3219655-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in Gerrard's report [1], there are use cases where a netem
child qdisc will make the parent qdisc's enqueue callback reentrant.
In the case of drr, there won't be a UAF, but the code will add the same
classifier to the list twice, which will cause memory corruption.

In addition to checking for qlen being zero, this patch checks whether the
class was already added to the active_list (cl_is_initialised) before
adding to the list to cover for the reentrant case.

[1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/

Fixes: 37d9cf1a3ce3 ("sched: Fix detection of empty queues in child qdiscs")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_drr.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index e0a81d313aa7..b18b7b739deb 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -35,6 +35,11 @@ struct drr_sched {
 	struct Qdisc_class_hash		clhash;
 };
 
+static bool cl_is_initialised(struct drr_class *cl)
+{
+	return !list_empty(&cl->alist);
+}
+
 static struct drr_class *drr_find_class(struct Qdisc *sch, u32 classid)
 {
 	struct drr_sched *q = qdisc_priv(sch);
@@ -357,7 +362,7 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	if (first) {
+	if (first && !cl_is_initialised(cl)) {
 		list_add_tail(&cl->alist, &q->active);
 		cl->deficit = cl->quantum;
 	}
-- 
2.34.1


