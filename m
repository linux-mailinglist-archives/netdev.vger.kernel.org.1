Return-Path: <netdev+bounces-51759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE0B7FBEF1
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 17:07:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32A50B212B5
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 16:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459425CD1F;
	Tue, 28 Nov 2023 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="u4xuGGkm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA8012A
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 08:06:53 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cfa5840db3so36103835ad.2
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 08:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1701187613; x=1701792413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gRYnfsB83r2Y3EpTtj+KZgbH+GMrURwzjA60UCxP2YI=;
        b=u4xuGGkmNrWibqhlsyQRXnWfIkbtfFPPqTXcvfdvajlWkrEXo9y8UeduQjt8etR0yK
         buYihoqnoHvXj3ITDXXuJRUL68+PP8hihHbZDbN4sjP7m2GYbXNQDhDwMQVDuTKRHN1D
         eDN0VPu1n17z38JDHv5lXU2BwFYL+iAsJiuw6XoGFaP3yM3OuMUBIbizI26g5VS7Jk+k
         VoxJkc9sO8KhhgSOyjWo6/zLrcgu/UGJRRviWWnxA0Yv0U+5OgNM48wle76I+y2qQnhx
         zYlp39ZIKb4nhPFTYNLr9ZnU9EX3SRmYXEag2VBTvjdk1mvzCsJ/d9eDLe2I0R74ZCWU
         nWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701187613; x=1701792413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gRYnfsB83r2Y3EpTtj+KZgbH+GMrURwzjA60UCxP2YI=;
        b=l1GYboeRcyW7Z0R124McwiJdmbpmiusoLATvrvoO2TcuCPuaQNrjId4y+F+Uz8HrW9
         kQEYCkuuAqtrQGYwknt5+zmEVphPfM8/creLsZAMF/TEnq7az/N2qllNXbYu+sqaP7JV
         eNMmFW/yJoeZRacrW38WNW99tfuT+aWAWosqSDQEOFr6Pfo21mv20a1RK7Y2qHZ4XA4r
         u1cUoZvhcayPwb1jTHz2WgMjDll49rU+gbgH09f69/2RBLWMWnvBZMpONtkHJsZXjXRJ
         Z5ZtTJuT1NxjsMTbBsnfyL6zDZVn9pImfqx9fZ/tfWWFHK4iZBBfR5w38hVaOaaT4jaG
         Cr+Q==
X-Gm-Message-State: AOJu0Yw5ClIi7/cITQGuQu2i5m40glJBUyW97KdpSDzp8mXANt6KPlA9
	DHxfmP1vg3G9Hipoo318T/VkFPjWy/GdVvzX3kM=
X-Google-Smtp-Source: AGHT+IEJQFuvq4Lgnsr/IXokZXR3o+vEMRcqrQsBatKcS1YxqVylYy0Lf1O6WY5mDcqUd52JQW/zDg==
X-Received: by 2002:a17:902:e5c7:b0:1cf:a4e8:d2be with SMTP id u7-20020a170902e5c700b001cfa4e8d2bemr18271114plf.12.1701187613073;
        Tue, 28 Nov 2023 08:06:53 -0800 (PST)
Received: from rogue-one.tail33bf8.ts.net ([201.17.86.134])
        by smtp.gmail.com with ESMTPSA id i4-20020a170902c94400b001bf52834696sm8510504pla.207.2023.11.28.08.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 08:06:52 -0800 (PST)
From: Pedro Tammela <pctammela@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	vladbu@nvidia.com,
	mleitner@redhat.com,
	Pedro Tammela <pctammela@mojatatu.com>
Subject: [PATCH RFC net-next 1/4] net/sched: act_api: rely on rcu in tcf_idr_check_alloc
Date: Tue, 28 Nov 2023 13:06:28 -0300
Message-Id: <20231128160631.663351-2-pctammela@mojatatu.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231128160631.663351-1-pctammela@mojatatu.com>
References: <20231128160631.663351-1-pctammela@mojatatu.com>
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
index c39252d61ebb..048e660aba30 100644
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


