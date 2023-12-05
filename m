Return-Path: <netdev+bounces-53995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4167E8058BC
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 16:30:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629801C20F71
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 15:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDD35F1DA;
	Tue,  5 Dec 2023 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="oLMD5nEf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A3DA9
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 07:30:31 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cf7a8ab047so23265645ad.1
        for <netdev@vger.kernel.org>; Tue, 05 Dec 2023 07:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701790230; x=1702395030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBeO4uD5WmpB1aJU//2ZqVMWJ1KMTm3aSrEbBbQl+GQ=;
        b=oLMD5nEf9t+LAxTDU3OYK+iloExtYxgA4KRp08bPiHC9XLrNuxJ2eu/cY9+I2RLgTG
         awrVkCcDvb3Pf69u2QP+T3fQDXVa6U/G/s7Kvn8Atn/huY/SiK6CWyW+yAwNxvFMRfJT
         wJztwAmafI+2jciFNNSqUX6yRRvt+Q3XiJtRkAJ1iY57BEH48ZKXFn8SAZo3VmyfxtNF
         ZqzeskgcTIPxXBo9YS62H+GsGiUHnA2Jy1hGfzTzsNUssCvH6k7cguosswhKQr1788mg
         Wmt6j7NsVwIRNUWF2LIIkO1TqWyaVMf6pwcM9KKuBFnkFAVmTFBm/JL+IKTCC8bkTlmU
         Rmhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790230; x=1702395030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBeO4uD5WmpB1aJU//2ZqVMWJ1KMTm3aSrEbBbQl+GQ=;
        b=HyIdQLOJfXTsQ9LwyLVuleCCKI+tUBFWsQ3BbKeymKShC777U1oK7tKLQgdJXcs5vT
         mwJVF19L0qxoVjbvCQPaBNKGudRFhgEOysBgdDt5t19Fx7WmihrGydG700RHKGS8slLn
         GMwFN6mUqRav6+pYRqGyQs/HxNiJPjbDHdS3An4RI+qDbm1rQsJoxuGjneFrXlLjFIPG
         hEQHGl1JwwidMWgbsidGtR0Vs3MzLslDcQoLSBPDecSoauFsixhwgW/0bnbeHL19m7/e
         BJUaSUV0bhKVKqcBRbSbXfa09I3ksrMFhC4uXQKciImISfxmr8K+tDZ67dQNKMEIcJwa
         CU7A==
X-Gm-Message-State: AOJu0YzJZmZcflUPQhikkkBNC6zpY+7G9XM1tYntDzBJ2dS1p1g9OuvM
	7jNTvTOF+D4+gqC6CGyTuXWFbHBGTQgtOKSUAIs=
X-Google-Smtp-Source: AGHT+IF9rv3X8VaxDOvqKs+349wzROnnmG726xgEil+piqg37VPmDRzOgvuzzu6IcYWKaE1tpgqzbw==
X-Received: by 2002:a17:902:bd49:b0:1d0:b4cc:43ef with SMTP id b9-20020a170902bd4900b001d0b4cc43efmr2110852plx.24.1701790230489;
        Tue, 05 Dec 2023 07:30:30 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id w3-20020a170902a70300b001cfc34965aesm10384427plq.50.2023.12.05.07.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:30:30 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	marcelo.leitner@gmail.com,
	vladbu@nvidia.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH net-next 1/2] net/sched: act_api: rely on rcu in tcf_idr_check_alloc
Date: Tue,  5 Dec 2023 12:30:11 -0300
Message-Id: <20231205153012.484687-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231205153012.484687-1-pctammela@mojatatu.com>
References: <20231205153012.484687-1-pctammela@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of relying only on the idrinfo->lock mutex for
bind/alloc logic, rely on a combination of rcu + mutex + atomics
to better scale the case where multiple rtnl-less filters are
binding to the same action object.

Action binding happens when an action index is specified explicitly and
an action exists which such index exists. Example:
  tc actions add action drop index 1
  tc filter add ... matchall action drop index 1
  tc filter add ... matchall action drop index 1
  tc filter add ... matchall action drop index 1
  tc filter ls ...
     filter protocol all pref 49150 matchall chain 0 filter protocol all pref 49150 matchall chain 0 handle 0x1
     not_in_hw
           action order 1: gact action drop
            random type none pass val 0
            index 1 ref 4 bind 3

   filter protocol all pref 49151 matchall chain 0 filter protocol all pref 49151 matchall chain 0 handle 0x1
     not_in_hw
           action order 1: gact action drop
            random type none pass val 0
            index 1 ref 4 bind 3

   filter protocol all pref 49152 matchall chain 0 filter protocol all pref 49152 matchall chain 0 handle 0x1
     not_in_hw
           action order 1: gact action drop
            random type none pass val 0
            index 1 ref 4 bind 3

When no index is specified, as before, grab the mutex and allocate
in the idr the next available id. In this version, as opposed to before,
it's simplified to store the -EBUSY pointer instead of the previous
alloc + replace combination.

When an index is specified, rely on rcu to find if there's an object in
such index. If there's none, fallback to the above, serializing on the
mutex and reserving the specified id. If there's one, it can be an -EBUSY
pointer, in which case we just try again until it's an action, or an action.
Given the rcu guarantees, the action found could be dead and therefore
we need to bump the refcount if it's not 0, handling the case it's
in fact 0.

As bind and the action refcount are already atomics, these increments can
happen without the mutex protection while many tcf_idr_check_alloc race
to bind to the same action instance.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/act_api.c | 56 +++++++++++++++++++++++++++------------------
 1 file changed, 34 insertions(+), 22 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index abec5c45b5a4..79a044d2ae02 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -824,43 +824,55 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
 	struct tcf_idrinfo *idrinfo = tn->idrinfo;
 	struct tc_action *p;
 	int ret;
+	u32 max;
 
-again:
-	mutex_lock(&idrinfo->lock);
 	if (*index) {
+again:
+		rcu_read_lock();
 		p = idr_find(&idrinfo->action_idr, *index);
+
 		if (IS_ERR(p)) {
 			/* This means that another process allocated
 			 * index but did not assign the pointer yet.
 			 */
-			mutex_unlock(&idrinfo->lock);
+			rcu_read_unlock();
 			goto again;
 		}
 
-		if (p) {
-			refcount_inc(&p->tcfa_refcnt);
-			if (bind)
-				atomic_inc(&p->tcfa_bindcnt);
-			*a = p;
-			ret = 1;
-		} else {
-			*a = NULL;
-			ret = idr_alloc_u32(&idrinfo->action_idr, NULL, index,
-					    *index, GFP_KERNEL);
-			if (!ret)
-				idr_replace(&idrinfo->action_idr,
-					    ERR_PTR(-EBUSY), *index);
+		if (!p) {
+			/* Empty slot, try to allocate it */
+			max = *index;
+			rcu_read_unlock();
+			goto new;
+		}
+
+		if (!refcount_inc_not_zero(&p->tcfa_refcnt)) {
+			/* Action was deleted in parallel */
+			rcu_read_unlock();
+			return -ENOENT;
 		}
+
+		if (bind)
+			atomic_inc(&p->tcfa_bindcnt);
+		*a = p;
+
+		rcu_read_unlock();
+
+		return 1;
 	} else {
+		/* Find a slot */
 		*index = 1;
-		*a = NULL;
-		ret = idr_alloc_u32(&idrinfo->action_idr, NULL, index,
-				    UINT_MAX, GFP_KERNEL);
-		if (!ret)
-			idr_replace(&idrinfo->action_idr, ERR_PTR(-EBUSY),
-				    *index);
+		max = UINT_MAX;
 	}
+
+new:
+	*a = NULL;
+
+	mutex_lock(&idrinfo->lock);
+	ret = idr_alloc_u32(&idrinfo->action_idr, ERR_PTR(-EBUSY), index, max,
+			    GFP_KERNEL);
 	mutex_unlock(&idrinfo->lock);
+
 	return ret;
 }
 EXPORT_SYMBOL(tcf_idr_check_alloc);
-- 
2.40.1


