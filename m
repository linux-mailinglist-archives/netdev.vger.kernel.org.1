Return-Path: <netdev+bounces-248830-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AEB8D0F749
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 17:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED4E630477D3
	for <lists+netdev@lfdr.de>; Sun, 11 Jan 2026 16:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7041D33C52A;
	Sun, 11 Jan 2026 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="OuybnFhx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88D334CFDB
	for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768149610; cv=none; b=dFkTkam8qQ5pXW8N+az0UNkeA9Ea+5Dg+uk+egMiIIR2xuMYNjt7X1qqHtf10CpbAQ3EGWCXypE5VnrIKbPztfU8FrxQoqGAAJeS48yAm2ZHd4zA8EGD/YVAHTczWnHXUJoPQ1JAw+DSVK51aBMXZVLCtN6FqHRZ9RAoI2UhPPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768149610; c=relaxed/simple;
	bh=6GbE6f4BtUXWP/Ufu0vmCOgOxmPt3viYw/LQuct9HBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WSZrn7IQ1IGwFvEtOKDWBUOiYGjjFdnKEXD9SZN39c/uusSgntyS0TMJqAe0dXwoXmN+2hq+BdKV3IzdJmIi0ivLsYS+tiGYR1Vidte/B+PFSHBpguqcjctK9aH0EgZLkFAW0XhMM9p6VdmzdGK/eDI5E9ETZ1ZJUNSQ25ni/fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=OuybnFhx; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8ba3ffd54dbso864230185a.1
        for <netdev@vger.kernel.org>; Sun, 11 Jan 2026 08:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768149608; x=1768754408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x22oIWAL2IaU7yqhIG3e7EI/+fsh+jdKMlHxh57/vdc=;
        b=OuybnFhxalCpvGmIKkZH5T8KQe29HVTmodb+5RHRC/32nxwMaQWWr1xcL5dYIbnyf0
         T2Q/bsR6BI/lSC6skkdJZY68DlWqoqSldLCsniiBRhU10joQqAesiURT9xCk+3hJDzY5
         8T3+FPh5saqCxKF1CvRPHADS4woJeuqsMF+yrvwzTPMmqUOKvstt29iX0B9+/TcAz5F9
         OL8jjnyt3vcES8kcVim3CwgVONLyaoYj/7sKH1w6eJvVjeEXWI02TYk8J50xeOmi/omu
         PQ8K7BSZ9JU0PTy0PXGdoMe2PFscKvuRFdcuULnz6OJSC3hVDFC062wpWnJwodkGRczX
         5Hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768149608; x=1768754408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x22oIWAL2IaU7yqhIG3e7EI/+fsh+jdKMlHxh57/vdc=;
        b=XVXlFZL94QwuYYJBb0FOSeEitA90fbvGTcpI8BW5EgBzoyrtzfAyHIhJhrLKwylF+g
         gkiuYx3Q7ukI2koFr/Kdz2H4r9ghh1b4weSd/lalOM18VtnRAgb2oqfJCEVvOruKdD7D
         Jk+0YGTnguyR/O9ZDfm7rhrwDtStImJfHJ2C3unbinqWJyk/gHq0NIsalI2Zvf+xk9eb
         3JOQGXCnrrTf6eav50xi3oc2ewMyDynL8IdXqIcMkHcF7nBvH704VVtgCbN3vGqUChPW
         ZEsNaREyiQFWlJhJ2o8Yum+N/qUoBw1w71NRyG5dgNQp/678vKbV3O2Aq9+iYNqasFoX
         5NyA==
X-Gm-Message-State: AOJu0Yy3SeRUZaQquA/OE+sZjOqw6MFbK/gVfU2j5GQ2ZUv5pNdSgH9n
	zzQWVLzqyPt+J6Z/8jfrx7hyr3c/0sAjalecGgjybv6oDpdt4w1hNK35swZpqHUh7G+Xvyvl5Ny
	Q0jY=
X-Gm-Gg: AY/fxX4LVRvolUMmj0Iyv2qDUqEO8CDAruJx3pkT5bSRf3WphvztlF/H3XCoCJaT15N
	UgIoH29DeToDg+K33tTOGjFDcf3D6Bx16HrbM1S5iEDssG1QMWELh94f6/Ko4IjK2nzUyjAhW/9
	q2JR0Awb7x2bPeH/6dEf69NWTMOKrGjhoud8c0+b6o+ybWgQyUEc1+2fbNWAxzN1gsvdKot+MnK
	3lG3ynRKWU+kM2bJCoOesc8uWQXDkxDLeO9b6Lhl0C+sTxTNUT0cHJmsf0ikKkKymOJr1uVLnao
	RUzOsrHFeWwXbw5ywD6ZbsU42KejGdyuIgG/Ar21ormX40p5CsBD3JNcAIp5d0S3PCTDpW4QOvb
	Qa/efzQMBBYgPyCplztxGgTSRQVKQeUPYp5MnVw31D9dY9Nie1ovokEtX5ak1sM3JxhicKSymi5
	HzCx6LyiVCuLY=
X-Google-Smtp-Source: AGHT+IE7x5Z+vaVdvZhh0LcIyHH8cD7B8nl71csdv7qH4MMTDSuHzNvPOmbATnKKsyn08YB4cQ/QWg==
X-Received: by 2002:a37:f502:0:b0:8b3:3d62:67f5 with SMTP id af79cd13be357-8c389379dcbmr1523764985a.11.1768149607620;
        Sun, 11 Jan 2026 08:40:07 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f4a8956sm1276589085a.10.2026.01.11.08.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 08:40:06 -0800 (PST)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch
Cc: netdev@vger.kernel.org,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	dcaratti@redhat.com,
	lariel@nvidia.com,
	daniel@iogearbox.net,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	zyc199902@zohomail.cn,
	lrGerlinde@mailfence.com,
	jschung2@proton.me,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 2/6] net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop
Date: Sun, 11 Jan 2026 11:39:43 -0500
Message-Id: <20260111163947.811248-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260111163947.811248-1-jhs@mojatatu.com>
References: <20260111163947.811248-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When mirred redirects to ingress (from either ingress or egress) the loop
state from sched_mirred_dev array dev is lost because of 1) the packet
deferral into the backlog and 2) the fact the sched_mirred_dev array is
cleared. In such cases, if there was a loop we won't discover it.

Here's a simple test to reproduce:
ip a add dev port0 10.10.10.11/24

tc qdisc add dev port0 clsact
tc filter add dev port0 egress protocol ip \
   prio 10 matchall action mirred ingress redirect dev port1

tc qdisc add dev port1 clsact
tc filter add dev port1 ingress protocol ip \
   prio 10 matchall action mirred egress redirect dev port0

ping -c 1 -W0.01 10.10.10.10

Fixes: fe946a751d9b ("net/sched: act_mirred: add loop detection")
Tested-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 net/sched/act_mirred.c | 45 ++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 05e0b14b5773..9ef261e19e40 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -26,6 +26,8 @@
 #include <net/tc_act/tc_mirred.h>
 #include <net/tc_wrapper.h>
 
+#define MIRRED_DEFER_LIMIT 3
+
 static LIST_HEAD(mirred_list);
 static DEFINE_SPINLOCK(mirred_list_lock);
 
@@ -234,12 +236,15 @@ tcf_mirred_forward(bool at_ingress, bool want_ingress, struct sk_buff *skb)
 {
 	int err;
 
-	if (!want_ingress)
+	if (!want_ingress) {
 		err = tcf_dev_queue_xmit(skb, dev_queue_xmit);
-	else if (!at_ingress)
-		err = netif_rx(skb);
-	else
-		err = netif_receive_skb(skb);
+	} else {
+		skb->ttl++;
+		if (!at_ingress)
+			err = netif_rx(skb);
+		else
+			err = netif_receive_skb(skb);
+	}
 
 	return err;
 }
@@ -426,6 +431,7 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 	struct netdev_xmit *xmit;
 	bool m_mac_header_xmit;
 	struct net_device *dev;
+	bool want_ingress;
 	int i, m_eaction;
 	u32 blockid;
 
@@ -434,7 +440,8 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 #else
 	xmit = this_cpu_ptr(&softnet_data.xmit);
 #endif
-	if (unlikely(xmit->sched_mirred_nest >= MIRRED_NEST_LIMIT)) {
+	if (unlikely(xmit->sched_mirred_nest >= MIRRED_NEST_LIMIT ||
+		     skb->ttl >= MIRRED_DEFER_LIMIT)) {
 		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
 				     netdev_name(skb->dev));
 		return TC_ACT_SHOT;
@@ -453,23 +460,27 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 		tcf_action_inc_overlimit_qstats(&m->common);
 		return retval;
 	}
-	for (i = 0; i < xmit->sched_mirred_nest; i++) {
-		if (xmit->sched_mirred_dev[i] != dev)
-			continue;
-		pr_notice_once("tc mirred: loop on device %s\n",
-			       netdev_name(dev));
-		tcf_action_inc_overlimit_qstats(&m->common);
-		return retval;
-	}
 
-	xmit->sched_mirred_dev[xmit->sched_mirred_nest++] = dev;
+	m_eaction = READ_ONCE(m->tcfm_eaction);
+	want_ingress = tcf_mirred_act_wants_ingress(m_eaction);
+	if (!want_ingress) {
+		for (i = 0; i < xmit->sched_mirred_nest; i++) {
+			if (xmit->sched_mirred_dev[i] != dev)
+				continue;
+			pr_notice_once("tc mirred: loop on device %s\n",
+				       netdev_name(dev));
+			tcf_action_inc_overlimit_qstats(&m->common);
+			return retval;
+		}
+		xmit->sched_mirred_dev[xmit->sched_mirred_nest++] = dev;
+	}
 
 	m_mac_header_xmit = READ_ONCE(m->tcfm_mac_header_xmit);
-	m_eaction = READ_ONCE(m->tcfm_eaction);
 
 	retval = tcf_mirred_to_dev(skb, m, dev, m_mac_header_xmit, m_eaction,
 				   retval);
-	xmit->sched_mirred_nest--;
+	if (!want_ingress)
+		xmit->sched_mirred_nest--;
 
 	return retval;
 }
-- 
2.34.1


