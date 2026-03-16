Return-Path: <netdev+bounces-268281-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBqSEgFzuGn5dgEAu9opvQ
	(envelope-from <netdev+bounces-268281-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:15:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A86062A0A79
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 22:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 652BE3169C9F
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 21:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E314B363C60;
	Mon, 16 Mar 2026 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="0TOgnUWy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402E636403F
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 21:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773695475; cv=none; b=S6iaUGZ39kGhShpcmfxBWke/3X9J4tpOKO5KiBOmSuMQvW+MkNti5mljPxxb12FLTZ4bBHhyiLalj++nMxXfkzU0gyUjLE2IsausFVo+QHkvqdXs61x2jUNFZzDVsqhryfOpiAZHrTq2+hnftp2GVe6A6MaCXk20rAEswxo33Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773695475; c=relaxed/simple;
	bh=CAsS4J/t10sG/T5I0JKSMPwaRbUDZapGaHx1j261f38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a/NqZFHUoK8meTiaZCVSBmLLBXp/zmxf8ZEUSA/ND5ZmcJvjkzPTRkpgtOwdCQvWSVgaaAhSbxKLFPL/E72r//0h7lYwv6421gCmm/tbwgsKm1SdgFz4HHxUcigp08ak/bbm8URmSlRSBJuXBo/0gO9Vqc2QUgAwNCiP7QOyj/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=0TOgnUWy; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-89a465bd7edso36601566d6.0
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 14:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773695473; x=1774300273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mV2WxSgOnrukTiiplrhReP9OynL7VhGvdToCkKNiSXQ=;
        b=0TOgnUWylaA5JXzVLPIy/zuML6n4sa4jerdpRE1EmYQrS9+Lnzw0LtxyyMWVdMNEK3
         4ZO/aghWaBBa8VM2sjG5gvCrPpfQic/8Ze4dz4Kbu5+Ep6oqGH99x6FEsE50kWxX/wMQ
         eg7e7DBzRAuarPkGIDVhlF5eVP6Kdq7bQmFG44GK1ZLqLvBndGr5V+vneHB9YZOcCt9L
         0gmL7mtTevKANQzqBd2vdj8EFVqx+QjowuBeZDIh3eWwxubE9cWjaSNVb2Aaw9ITx+t6
         MI6hSdXAsCG23Dd25PM/nqy0/KB5wudiNSTCQIeaIz9KS57S9i3vxa23hG1YNjWLpD0X
         SBOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773695473; x=1774300273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mV2WxSgOnrukTiiplrhReP9OynL7VhGvdToCkKNiSXQ=;
        b=PvojH0gxlTpeIKPoJdx9v2LoNQkCY+qT1jjHMC18a6pjoHC36VMar7naKmsFIPflZt
         EdXvicsYe99l4o3Paw18l4ObmS4qaaiZT1l4AkJ0m0JPHPURVx/Nz8WGlNvEg73cetrb
         oUa2r17let52t2OJYlp6ygM2CWzgQePqk0gG40WfDYDGGCY6BBuZMKepqRGxbjBzZ3oG
         awCYfyMe+0OwquK13XB1eqT9JNKCQI98ex8xZDtpeIeIF/JuKPN2mDA0Sf1JoUY/WBCh
         A3fhphdWJ6SlpTSMR3sURP+D48jus9AIemvdzIfFHl9bya1Ua+OSQBMHQoPCxhkc/VZu
         UXrQ==
X-Gm-Message-State: AOJu0YxU84J2PXORDy53B2tx4qFUukXQShOc6oUsojnMLBjoNDln2MQh
	oWESnbjulCTpIV7puV7CgnRIyqPbgq3u7rudc2JmPuYRYiwUIdyMcVqIHuCjD3whKuSKMmaQaVE
	r38A=
X-Gm-Gg: ATEYQzx9DTZIn8+Fwou1qTR7oKpuNiqyC4TcKEw8hL0PV/kuyzbJNU53618uKH7ylNe
	HdOqtA/RLKkm5ngV5KLFqTdZEZqZNsBlnxQ6tZC01jVL1pTTikjK1K6xGjWrGJjhAUKCN2C5KYy
	KvNc4k7xUQ3NmmY1uKorMvwHfH95usKJMS0/2Qp7O8lGWPIy3k2pVpHo3jOS18Mw51R9mZsHGPK
	5PnHn3Cu7FcjLnsrnvfihHjWHRFXksUE7xk3vooCz0ZvvR1wAvickmYNm5gjxoVgr/vmef306ON
	r05dhB6JOfxtRyIS9Om2ETFGbLFIJGpaG5nUdR31OCDfNrtUu9EuMOLomcvOpSCSRUsZIKfvreC
	qGES92NQ2akY/4lNXIH+Tuf/D16fFsnuBEGnKCjuM7CZdnoUCBeobCN8M4EFsqJ8CD0FBl7qdDw
	PIJ3aTXx0auF3vVHP6RebhQ3FVaYB2Dy69xA==
X-Received: by 2002:a05:6214:c6f:b0:89c:5385:3476 with SMTP id 6a1803df08f44-89c53853f1cmr65618776d6.39.1773695472727;
        Mon, 16 Mar 2026 14:11:12 -0700 (PDT)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c53374573sm27356266d6.7.2026.03.16.14.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 14:11:11 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org,
	victor@mojatatu.com,
	will@willsroot.io,
	xmei5@asu.edu,
	pctammela@mojatatu.com,
	savy@syst3mfailure.io,
	kuniyu@google.com,
	toke@toke.dk,
	willemdebruijnkernel@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net v2 2/6] net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop
Date: Mon, 16 Mar 2026 17:10:48 -0400
Message-Id: <20260316211052.332383-3-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316211052.332383-1-jhs@mojatatu.com>
References: <20260316211052.332383-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268281-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,willsroot.io,asu.edu,syst3mfailure.io,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,mojatatu.com:mid,mojatatu-com.20230601.gappssmtp.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A86062A0A79
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Another bug fixed here is a false positive, example current code will claim
this is a loop when its not:
tc qdisc add dev port0 clsact
tc qdisc add dev port1 clsact
# port0 ingress --> port1 ingress
tc filter add dev port0 ingress protocol ip \
   prio 10 matchall action mirred ingress redirect dev port1
# port1 ingress --> port1 egress
tc filter add dev port1 ingress protocol ip \
   prio 10 matchall action mirred egress redirect dev port1
#port1 egress --> port0 egress
tc filter add dev port1 egress protocol ip \
   prio 11 matchall action mirred egress redirect dev port0

ping -c 1 -W0.01 10.10.10.10
And see the ping fail

Fixes: fe946a751d9b ("net/sched: act_mirred: add loop detection")
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


