Return-Path: <netdev+bounces-288322-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SP/+LMMnB2qisQIAu9opvQ
	(envelope-from <netdev+bounces-288322-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:03:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 535BC550F54
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 16:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3D75F306C2A0
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAA448A2CB;
	Fri, 15 May 2026 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="crNLsmaw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE594481FCB
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 13:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853121; cv=none; b=TH/B1kwUmX0tZrlYDJU01vhaMnhlPgu65DFTdgao8oFZ8ofDQeMsaG1UIGB+uoradZsiEUdcVu17d6tYQZL4XQkR1Cg6sfKbpLW347Nd6WWO7aEKatvH9x93pNOofL6VFiku5M9uRTEpbU8cjplJ3ex4O6PfUFxYgxOqexOu8VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853121; c=relaxed/simple;
	bh=1BUYyH6FJjq+uusotHC0RGXtPrhUwifyqTlT3V5ZIPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eALsSWGECmqSgp0HeaSFTgokWTe1veW2EJ3mjieZUT1lRrHaq8P3ef1ZKiR409ab+9ScmsPgRFxlUMb4haJXeFKzlic1yHJN6+yx3MnYpUqlzDSmfkOk23C+d48HMg8sTQN+QOGEn8Dg8b7MPejhn8aIfvizFf4MoE2iXTzMfwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=crNLsmaw; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4891b0786beso60103895e9.1
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 06:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778853115; x=1779457915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VA+bG9JdAKJ8uzHR2B1IeGdcCKEHHSGhLn7eeSbzPvg=;
        b=crNLsmawSy5I0G7CrPgHYnHFdvt+hulqPo5UoyW92rWd76+QKownrE2B3DUYWlO1JL
         2/22skQB/KbImVFeu6hVTX9ex3e52K3JsaRa5wmBsb0k/u6nr7M3G9T6OHFtwilq65sW
         xwON24M9D5Ue3nFkwPQ0EaenIl9CDIOWvOme1bsTWeWi3cJMa2KErOp72g6lj3ASjczz
         tN2C7Cb3VGlaAz5yc2hQRGrjvEszxAa2qzS4983uqL5JYl0iZLxPKpvHDI4qGnnpF013
         1Y2qbng4JPUbuq2TYwUpPeD2xLWni6ZfPsnmTz11aZ/gIdO9NUhV7G7Qop9kYNUMCcpy
         nhYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853115; x=1779457915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VA+bG9JdAKJ8uzHR2B1IeGdcCKEHHSGhLn7eeSbzPvg=;
        b=Z9LIhGoSVOz3k3IWYu4Zw4OZvPU41N/l7oH8p/cY9U0Z1pBxZw1l5jXzI95/XprazY
         rh/PutIMOJLcIbyZKDCb4OYe2kO4+t05RsUU0jxRRg7phwRahT1RdUFJPduECI88mQL9
         OaJYD3yRg9g4wwng+cwdEYhyLgwYlwwn0q6T2OmtfPaRcUHi5um6UTgECC0JCM1Awfcb
         96vKX730g8r/CK/dEZ64ppbTXqaWXeeUJI5MHZUssh0yI1ALd0sEdp/ZKB3oFlZiZ014
         ookdAQ4SgauK1+u/tWVr+emvZkH0zJ1U73CY9hWoTROXjhUKjnI7S8RPYakfTezGychv
         OpMg==
X-Forwarded-Encrypted: i=1; AFNElJ9aJ4Psjjnn2nniWktSVosQfElRE5MiwTGQ1wtmjz/cmxXP0w91+KsIpA2iHW2kHitwQV2hpuI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywby5Zymaxdo5y9RN2GGUKPHp7t0wexcmucbKG/2inpg89BqU+2
	Ir5Ria83T9mayK+ul47XXV6quQoBoBP2zf7/t/bSh1ZdB0tpyn0b3IX742uWDlW218U=
X-Gm-Gg: Acq92OHLdX4P4Aq6ZQV3bwCoDn8ZZ4lsty8hHyDQHBB7bDgYLOZqMmmrII6qHpp4WK6
	aevZXlTMYIPh97r/P9tq8zGqLcUYiXw4uCJMVYhGD/EKPGJnaOmm2uDJQuGF722a0Z1JvxlRnNp
	cfvIm7V+Smz6WlS8QgiY99GFHP9pO9TZkiQT/YqgyonUT0uKdA7VoZj/jxqTv6Ly5PP2Ww0fbL2
	pCGQTJe+pnYqXziZw/8cgddw7yXXY5OpJ2efppNBhs1gFC+9j0PZuFUkt5B907m+eQGz2XNpT9q
	zORr/aKsHarQd0UsiSwKPWQRTcpeyOHGjVxztWq14y4DYMhh0tGnlmDaHMN/sGhveZij283d41h
	rcjzheB1/IGXN2n4tPHXBgUHWwK+IlysyDvWNnFKkZ7b6PNqjeHPcLR1YeGdjbjZdGJwkZSQwFF
	5az140BVmz1F2nPLxwyRSZ4tpckaZz1qyjPgV7k5epcB+Y+uI=
X-Received: by 2002:a05:600c:4fc9:b0:489:1c1f:35df with SMTP id 5b1f17b1804b1-48fe60e58ecmr54916975e9.10.1778853115149;
        Fri, 15 May 2026 06:51:55 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fdafc6741sm79592675e9.2.2026.05.15.06.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:51:54 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Simon Horman <horms@verge.net.au>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: [PATCH v2 net-next 2/2] ipvs: Replace use of system_unbound_wq with system_dfl_long_wq
Date: Fri, 15 May 2026 15:51:37 +0200
Message-ID: <20260515135143.259669-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515135143.259669-1-marco.crivellari@suse.com>
References: <20260515135143.259669-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 535BC550F54
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,verge.net.au,google.com,davemloft.net,redhat.com,ssi.bg,netfilter.org,strlen.de,nwl.cc,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-288322-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:email,suse.com:mid,suse.com:dkim,netfilter.org:email,ssi.bg:email,nwl.cc:email,strlen.de:email]
X-Rspamd-Action: no action

This patch continues the effort to refactor workqueue APIs, which has begun
with the changes introducing new workqueues and a new alloc_workqueue flag:

   commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
   commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

The point of the refactoring is to eventually alter the default behavior of
workqueues to become unbound by default so that their workload placement is
optimized by the scheduler.

Before that to happen, workqueue users must be converted to the better named
new workqueues with no intended behaviour changes:

   system_wq -> system_percpu_wq
   system_unbound_wq -> system_dfl_wq

This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
removed in the future.

This specific work is considered long, so enqueue it using
system_dfl_long_wq instead of system_dfl_wq.

Cc: Julian Anastasov <ja@ssi.bg>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Cc: Phil Sutter <phil@nwl.cc>
Cc: lvs-devel@vger.kernel.org
Cc: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 net/netfilter/ipvs/ip_vs_conn.c |  4 ++--
 net/netfilter/ipvs/ip_vs_ctl.c  | 10 +++++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_conn.c b/net/netfilter/ipvs/ip_vs_conn.c
index 9ea6b4fa78bf..4a5c6762489c 100644
--- a/net/netfilter/ipvs/ip_vs_conn.c
+++ b/net/netfilter/ipvs/ip_vs_conn.c
@@ -285,7 +285,7 @@ static inline int ip_vs_conn_hash(struct ip_vs_conn *cp)
 	/* Schedule resizing if load increases */
 	if (atomic_read(&ipvs->conn_count) > t->u_thresh &&
 	    !test_and_set_bit(IP_VS_WORK_CONN_RESIZE, &ipvs->work_flags))
-		mod_delayed_work(system_unbound_wq, &ipvs->conn_resize_work, 0);
+		mod_delayed_work(system_dfl_long_wq, &ipvs->conn_resize_work, 0);
 
 	return ret;
 }
@@ -916,7 +916,7 @@ static void conn_resize_work_handler(struct work_struct *work)
 
 out:
 	/* Monitor if we need to shrink table */
-	queue_delayed_work(system_unbound_wq, &ipvs->conn_resize_work,
+	queue_delayed_work(system_dfl_long_wq, &ipvs->conn_resize_work,
 			   more_work ? 1 : 2 * HZ);
 }
 
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index c7c7f6a7a9f6..49cbc7cfe770 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -800,7 +800,7 @@ static void svc_resize_work_handler(struct work_struct *work)
 	if (!READ_ONCE(ipvs->enable) || !more_work ||
 	    test_bit(IP_VS_WORK_SVC_NORESIZE, &ipvs->work_flags))
 		return;
-	queue_delayed_work(system_unbound_wq, &ipvs->svc_resize_work, 1);
+	queue_delayed_work(system_dfl_long_wq, &ipvs->svc_resize_work, 1);
 }
 
 static inline void
@@ -1833,7 +1833,7 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 	/* Schedule resize work */
 	if (t && ip_vs_get_num_services(ipvs) > t->u_thresh &&
 	    !test_and_set_bit(IP_VS_WORK_SVC_RESIZE, &ipvs->work_flags))
-		queue_delayed_work(system_unbound_wq, &ipvs->svc_resize_work,
+		queue_delayed_work(system_dfl_long_wq, &ipvs->svc_resize_work,
 				   1);
 
 	*svc_p = svc;
@@ -2078,7 +2078,7 @@ static int ip_vs_del_service(struct ip_vs_service *svc)
 	} else if (ns <= t->l_thresh &&
 		   !test_and_set_bit(IP_VS_WORK_SVC_RESIZE,
 				     &ipvs->work_flags)) {
-		queue_delayed_work(system_unbound_wq, &ipvs->svc_resize_work,
+		queue_delayed_work(system_dfl_long_wq, &ipvs->svc_resize_work,
 				   1);
 	}
 	return 0;
@@ -2511,7 +2511,7 @@ static int ipvs_proc_conn_lfactor(const struct ctl_table *table, int write,
 		} else {
 			WRITE_ONCE(*valp, val);
 			if (rcu_access_pointer(ipvs->conn_tab))
-				mod_delayed_work(system_unbound_wq,
+				mod_delayed_work(system_dfl_long_wq,
 						 &ipvs->conn_resize_work, 0);
 		}
 	}
@@ -2543,7 +2543,7 @@ static int ipvs_proc_svc_lfactor(const struct ctl_table *table, int write,
 			    READ_ONCE(ipvs->enable) &&
 			    !test_bit(IP_VS_WORK_SVC_NORESIZE,
 				      &ipvs->work_flags))
-				mod_delayed_work(system_unbound_wq,
+				mod_delayed_work(system_dfl_long_wq,
 						 &ipvs->svc_resize_work, 0);
 			mutex_unlock(&ipvs->service_mutex);
 		}
-- 
2.54.0


