Return-Path: <netdev+bounces-292170-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3S14FBCpFmr+oAcAu9opvQ
	(envelope-from <netdev+bounces-292170-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:19:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9C15E0FB6
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6BC530117DD
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F4D3DA5D4;
	Wed, 27 May 2026 08:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YwOBcf6e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635873D564D
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779869932; cv=none; b=O8iZY0+kO/hA8HfNr6niMia0PHEDZHbody9TE3q1/gUAiqKwI3kQdoA/Ov9rG72X+5WsfpxPAUBS1gpojLcYyQysGJP4qHjQIhAvFxGf/Z2nIyZbGr4bRp5vHMcOR/JLLZvOo5Fznd+dMWwsRUT+4VrK0BTQajvxK/GG/iApmGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779869932; c=relaxed/simple;
	bh=ntqUhQxKdtXnX0R9vFxVOW1lGrRRsy9CTwu/jXzhNiU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MY9ymKXfq6qs/u1I9qrXrYbbSZb5LPOJ9Hfjf524KLxlCM901WHiGttVz3u4VQ8CJWKXLLCD9zW2AqgrC0/95z1nRPVe5ToTIvqsoz3F7tF6dwlBxOa97+k2kzbuwCVuQjdf+2FnNOx7Cp4RasgUmuZcwD0jKMzOZ+HirKdIVJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YwOBcf6e; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-48fde648a71so75296955e9.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779869927; x=1780474727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1FRVTOS6KpbsSFKdGurs5f5+mBekao3A7RoQFphZcMg=;
        b=YwOBcf6eU5/Nz0IpFPa6uvPwMO4HRAqwYvFuROy7oXlerhaX1Ld9LPZjSKzqy9sUHL
         v8Piyr+E5j7AhMWp5Ju7gNNsohMaF6FNEzbSgPu8MVY6cicjkaAw179wkR1eUp1IgeYj
         Ve82YWZd9aYFEpeHoh+TDuaCpxw+2KGRz83GvK9Y2DVGvK6vJh2CshSH9BpV22QhquxX
         p8nRjqqOrVlwa55Gy9LPWGmmZWwAvLnRmEmSALzV6PusmmebVK2AxTWePiAQzhhJN+t/
         91RPzPG5qdezbv9BdpDCrJBcyqq8DOwYjWkm4EH06B5JDXLnl1sEZo6gJCnBLRsIvd/K
         C//w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779869927; x=1780474727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1FRVTOS6KpbsSFKdGurs5f5+mBekao3A7RoQFphZcMg=;
        b=MUYDD2bgdUXdwoDzaSWOm4TNmqRx79qIAva9YVj2TdOle23UqtvXE5Ln8qSuBA0fLH
         G75zCPCYLcCI3n5XrSLVjRO49kWNHZxQINIcDyTtPIl7+vW/crDdv9H6bjbFHWSIfdzk
         vorOJ2hXXfsSxwwc0LJIc/n4tiYyJb2yBdOYK0XZ0Zh1se2sMlWHnGvb2jK2neJJE3ie
         1mi4CzittYXrZMa21nKHGwFkRvj2r4/2Tac84fhWBbaSH9nSqO5IDsyfrKgdEi46dMkp
         cFhBYXjEr6qfY5kknW61gDsPghmeHFL542Uv9WzKCyiJOXuUZsiXPXmVTVaItn7sg+AO
         fzgA==
X-Forwarded-Encrypted: i=1; AFNElJ9Vr0LB138XjtL6JXGr6QwjENa6A5ui4VdXE0k8ArkO26z0WSvDbylBPCCfbB9CusTNPLLgixo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/aVHRCe+7rd/lnLXD3kHzAKy3CqbMRHZ+ttASL8V+2APVB+B8
	b0dMrfQTwOtY7G5x6VuZenSlDy/ykx0Pzqt4gKnBr18qMmF/WbBPse4fV5pe8RygzT2XhR3bLjV
	0Ec9mu/k=
X-Gm-Gg: Acq92OGTMykqDu4mDpaFpcGtrgUMvWt7QI36+hOCobvAxedfIaEGPrL1Kszzhk0iUD+
	2y72NHiEsjMxFITzlxxTkasn8wC7NM8G6FYGcOsbEImOsPeCHCIQ/Y2u8NnXkI5KTN+4uMT0kxr
	8d0J/mTt7EjJCakjjibwQZu8ZYOHHWQ3Ykr5wLcaTjvQisZANafe+xW/1H1QGYBZTrdJsns/gzW
	aE7bDJsgROhMGXHYrsjT+LDdmT6WVd5x2vwsWWlc8Im/uRl9EE4p10B8lYVqoOxz8piRj0WyFQM
	FE6yEIUOeyEtSEsaqxe9EU3aWBRKkv2zAlgMbgC9/iptfCTaBZOEByWeUC47RrjLfVdvkn4Y5mT
	16mrY/WNp83CVrijvO6/piO/n8TLDn/xBaWeBJL1Gei/qyGDEhn/nAr4SiDZ/K5lp68nBZnDkth
	6uzcps3jhuDHpi6hGeOh+4AQw2dxevKmX+z1o0
X-Received: by 2002:a05:600d:4448:20b0:48f:d620:c27f with SMTP id 5b1f17b1804b1-490422687c3mr223428245e9.4.1779869927490;
        Wed, 27 May 2026 01:18:47 -0700 (PDT)
Received: from linux ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490838b2b9fsm11594305e9.0.2026.05.27.01.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:18:47 -0700 (PDT)
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
Subject: [PATCH v3] ipvs: Replace use of system_unbound_wq with system_dfl_long_wq
Date: Wed, 27 May 2026 10:18:34 +0200
Message-ID: <20260527081834.86987-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.54.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,verge.net.au,google.com,davemloft.net,redhat.com,ssi.bg,netfilter.org,strlen.de,nwl.cc,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292170-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marco.crivellari@suse.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,suse.com:email,suse.com:mid,suse.com:dkim,nwl.cc:email,ssi.bg:email,strlen.de:email,netfilter.org:email]
X-Rspamd-Queue-Id: DD9C15E0FB6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
Changes in v3:
- removed 1/2 "ipmr: Replace use of system_unbound_wq with system_dfl_wq" because
  already merged.

Changes in v2:
- this is considered a long work, so change the workqueue with system_dfl_long_wq

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
index bd9cae44d214..2b53562c8605 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -821,7 +821,7 @@ static void svc_resize_work_handler(struct work_struct *work)
 	if (!READ_ONCE(ipvs->enable) || !more_work ||
 	    test_bit(IP_VS_WORK_SVC_NORESIZE, &ipvs->work_flags))
 		return;
-	queue_delayed_work(system_unbound_wq, &ipvs->svc_resize_work, 1);
+	queue_delayed_work(system_dfl_long_wq, &ipvs->svc_resize_work, 1);
 	return;
 
 unlock_m:
@@ -1869,7 +1869,7 @@ ip_vs_add_service(struct netns_ipvs *ipvs, struct ip_vs_service_user_kern *u,
 
 	/* Schedule resize work */
 	if (grow && !test_and_set_bit(IP_VS_WORK_SVC_RESIZE, &ipvs->work_flags))
-		queue_delayed_work(system_unbound_wq, &ipvs->svc_resize_work,
+		queue_delayed_work(system_dfl_long_wq, &ipvs->svc_resize_work,
 				   1);
 
 	*svc_p = svc;
@@ -2122,7 +2122,7 @@ static int ip_vs_del_service(struct ip_vs_service *svc)
 		rcu_read_unlock();
 		if (shrink && !test_and_set_bit(IP_VS_WORK_SVC_RESIZE,
 						&ipvs->work_flags))
-			queue_delayed_work(system_unbound_wq,
+			queue_delayed_work(system_dfl_long_wq,
 					   &ipvs->svc_resize_work, 1);
 	}
 	return 0;
@@ -2564,7 +2564,7 @@ static int ipvs_proc_conn_lfactor(const struct ctl_table *table, int write,
 		} else {
 			WRITE_ONCE(*valp, val);
 			if (rcu_access_pointer(ipvs->conn_tab))
-				mod_delayed_work(system_unbound_wq,
+				mod_delayed_work(system_dfl_long_wq,
 						 &ipvs->conn_resize_work, 0);
 		}
 	}
@@ -2596,7 +2596,7 @@ static int ipvs_proc_svc_lfactor(const struct ctl_table *table, int write,
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


