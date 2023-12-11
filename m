Return-Path: <netdev+bounces-56023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B31280D521
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 19:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BC6F1C21489
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 18:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECCD5101A;
	Mon, 11 Dec 2023 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="wcsR0+Vs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8333A95
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:18:36 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5c66bbb3d77so2738484a12.0
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1702318716; x=1702923516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wrv71yZI1vMcwPeSb8jbzs2gCeHuFZowYmJ6Qtm1GVI=;
        b=wcsR0+VsdvXapXjZ4D8fo2EBmpeD07XtrTKhuG40C/AWfR9C/ittnn5d5q5cTCS0Kq
         Hz6Ab/aazZ4rErQxR6Srcv2rA+IMa04FCwILbZUKWnyz0zbPvMelHgSLs9SsEgkIOo+G
         dlT9iS0+X7ZtVMDUtVSV352Pl/Y9G0E0U1Gd6mpT5dSB62WaSF+GQrmCQ6wmwh/hE48T
         6CqZxFcAYlarYHGP8L0Yx4pS4iBOWWaXwC/xzAcLr4vUKezHBDUHaQcnNaFmziGFaYAw
         2oqMWd7cfZ8W+J8HkcTp4PeWZ2WCWix/nRXfsjk0w0hEWFoKNh+nSxX3X+QB8K19VNkC
         htGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702318716; x=1702923516;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wrv71yZI1vMcwPeSb8jbzs2gCeHuFZowYmJ6Qtm1GVI=;
        b=XUTWL+1d+5P87EY/LepT6wWOsQ+Q6GEfyEvw8wMdTi1V2X5FUOMXThn2lWzYpj8io0
         Eo3A3rmbXSVpZWAS664TazRM4/k5nfkvSfgQMnx0f7V0H+aezUYV0NPgeDSQgvIWS7Ia
         /3cJtWay6xkSmhSnkvUAAKl5T3+fwopMQZu47EeEMbuR5lNSA7bQjV9rIoLBRxf1NBeh
         PsmXNOraycsPGftlC8uQ5gI67SA4wLNaVCJM5vVXZROV54RauSFUB3yWo4A1EfGUUdr2
         fArkmG3c1pK/eKlvY3MYLs6d+L19b8JfsUliAbzQc9GfIxO/Qo/n9qJcBJbFIHZMDM4F
         2tew==
X-Gm-Message-State: AOJu0Yzo8hRwAvk06XznWfnbMo1v7iq6GiVfi0Py8Jdh/BlySGamaykV
	9duPBab0RNNu7/l+tLz1GKUYRTphEAkNwvdPJPU=
X-Google-Smtp-Source: AGHT+IGhE4Xf7DFsP4MREHbpXpQ5MSe5+QUo1CC6NtzfMHBptoe2C7Ddv8mu3Bu6CYh2oPl/+CdxQA==
X-Received: by 2002:a05:6a20:748f:b0:18f:ea5b:6830 with SMTP id p15-20020a056a20748f00b0018fea5b6830mr2766900pzd.40.1702318715675;
        Mon, 11 Dec 2023 10:18:35 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id o17-20020a656151000000b005c2420fb198sm5756139pgv.37.2023.12.11.10.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 10:18:34 -0800 (PST)
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
Subject: [PATCH net-next v2 1/2] net/sched: act_api: rely on rcu in tcf_idr_check_alloc
Date: Mon, 11 Dec 2023 15:18:06 -0300
Message-Id: <20231211181807.96028-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231211181807.96028-1-pctammela@mojatatu.com>
References: <20231211181807.96028-1-pctammela@mojatatu.com>
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

In case binding encounters a parallel delete or add, it will return
-EAGAIN in order to try again. Both filter and action apis already
have the retry machinery in-place. In case it's an unlocked filter it
retries under the rtnl lock.

Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
---
 net/sched/act_api.c | 65 ++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 22 deletions(-)

diff --git a/net/sched/act_api.c b/net/sched/act_api.c
index abec5c45b5a4..688227acac45 100644
--- a/net/sched/act_api.c
+++ b/net/sched/act_api.c
@@ -816,6 +816,9 @@ EXPORT_SYMBOL(tcf_idr_cleanup);
  * its reference and bind counters, and return 1. Otherwise insert temporary
  * error pointer (to prevent concurrent users from inserting actions with same
  * index) and return 0.
+ *
+ * May return -EAGAIN for binding actions in case of a parallel add/delete on
+ * the requested index.
  */
 
 int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
@@ -824,43 +827,61 @@ int tcf_idr_check_alloc(struct tc_action_net *tn, u32 *index,
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
+			return -EAGAIN;
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
+	/* N binds raced for action allocation,
+	 * retry for all the ones that failed.
+	 */
+	if (ret == -ENOSPC && *index == max)
+		ret = -EAGAIN;
+
 	return ret;
 }
 EXPORT_SYMBOL(tcf_idr_check_alloc);
-- 
2.40.1


