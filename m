Return-Path: <netdev+bounces-281185-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8G2PJkxj7mnTtAAAu9opvQ
	(envelope-from <netdev+bounces-281185-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:11:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D54F446ADDE
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 21:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12E653025283
	for <lists+netdev@lfdr.de>; Sun, 26 Apr 2026 19:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BFC370D6A;
	Sun, 26 Apr 2026 19:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b="I9rTXQWT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7AB37C0F3
	for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777230575; cv=none; b=c2mtOJqTAj4AKs2uWyJ4hnKViukp/nluOlpPEiSkqTZJmLdrgaV/ILbD9QVC9tX6IQ0QFyaAk1288nkv5qJSe6nLp4+qgxPJqYpuWttBCRu1Bm9yVz+4zSszww/Q5BuePP7eazwDq2Cbpfq/+2gFpgNo7OA+ARtuPc4zwrCqtjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777230575; c=relaxed/simple;
	bh=WGxAeKTxTcqPXol1JgbB+htJuE/wfkV5ZyNoWfg6XJM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jmTd5LhYdD6jqSrTHZV3yONHNaOyo9jQDGC062v1zeeDOheFut30FcgcCkvL0Nb49pCf/E/4XKCvbUnF4Xwxa1zh4bQVDTRlY6DTgTLpep4X70A/7QGwCFTI1tN+Hpta1topmxsPLij5wAceY/3b3YuwNOrfFWTDD4+u9REHKnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20251104.gappssmtp.com header.i=@mojatatu-com.20251104.gappssmtp.com header.b=I9rTXQWT; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8aca2726f61so115859416d6.0
        for <netdev@vger.kernel.org>; Sun, 26 Apr 2026 12:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20251104.gappssmtp.com; s=20251104; t=1777230571; x=1777835371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oog38IBNWbJv/RF4cw3l1EJ34HjgbdeNukc21P71EV4=;
        b=I9rTXQWTvWNPCpW3cO8wd9o657oo5wppgkVm//UZYyeM9ERU7HEsoyUbYwtr3yM2zf
         /jV1NykgeYP07HcgqDvAJ5jSmriz9zW4Jy+ENHZOoFLoWes870B/kAbH4A5VpbU5IR4y
         2pxrIongMIsNQgNGkcDAENvdOfWkpViAx8I5KBIEodp34An5nOADRqsJOjbHlbqOSCot
         9ac1UCloVeCARijdyf6ZzyE6xFy8IOPo8ok+nSJXEmedoLW0zaf5KgbypAn9UfP3/d97
         FlAo2Fs0Wsm0Q//u7pPcLy3vUIZkA9Muu3+slCSsh84+9iLojFx/WoM0PQ77BngXCiV/
         G9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777230571; x=1777835371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oog38IBNWbJv/RF4cw3l1EJ34HjgbdeNukc21P71EV4=;
        b=WKMGCFqm/zKeyFSDTnT0QvUYtwJN3QiirWdUxnwjhYz2gq5XVXWl+EpXlmRrfybPtn
         f8bHp+T5X+m7KbwUEftByKjb60m7SOVsgZNQmjDAo0N3aF0nJN1m0wZAqXz4L2wkDIh+
         UO4ngQPB9qnpgo83cshG0lyMyhwI9tAOUw6Adlef2IXbAsZEQz5ahFAAIir1/VMJT4kJ
         uusMc9iHX/imCqxBFfYmaIxCflIuf16trrf1ss93vHKSGCkWWKoxCdgR9i3XtnO7DSNW
         1gumRC8EUR80EkamNukA2Ag2pcbXUFLZG83MI4mxv+O6Fkknn0xjhnSvAA3LDOob2T5N
         92Pw==
X-Gm-Message-State: AOJu0YypzRQo9xZZFxTDMAmLg4DR+Dny6qnPZCgedDxt0YcGc8LTeLuH
	5sN9qw8p6uklXyhctgvEBqNHE87JQyl7Bw2Ceexpy4Akq9S+WIgD6XAwWCSRf1Tx+8v89ZtR2tX
	hG/k=
X-Gm-Gg: AeBDieuNxLt4Rpfc6wxKDVEt3naFzPgURtVuVnoZvY+rEypo5kEawWdgoCqgOnh91wx
	ekN6RXTClb46MkhpAwEhCIgulxqP7Z8rveoO9io1f96RYfYQwTloMCoc/zbXIbHXhgMEPHkW6Hi
	PgdTiAywlvFzMe/CJFLYEbRKKPdXuOoOuxoU6g983ZuplZcZ71KABsoNfGXuojp0imBOLCgMCVq
	9vQDIxFKecwcB8Q5IYQBoEZhv1PlbKJ1AVTK0mwisNL39c/ZKx/O6UgbSXi7ZmpuiQe9eqRObOR
	aTF/3ZGC3Xbl0zNUggCGq3h9khm1V4pvtNzZvK+ZBrl0DJE2idHzrtHhtpuA61zar9LPurkAaJ4
	RfduvJRaQSCo+HzdnlVqKKzfuwctwQbcEVC9nnjxCFWctxy0lQ1CG3qnIXQeMwbp7xO4FovPoD5
	72464lgcnpqwc1K0XTwOx6wMAcotoQwPjLYo2ST1neknVy8efRTmsdBugpKHRDfwg0z9WQuUhiO
	CxHB0INwqjRV2hS+gFm7x3HctIDFSw=
X-Received: by 2002:a05:6214:400a:b0:8ac:b5e0:bf83 with SMTP id 6a1803df08f44-8b0280439e8mr568100786d6.19.1777230570766;
        Sun, 26 Apr 2026 12:09:30 -0700 (PDT)
Received: from majuu.waya (bras-base-kntaon1621w-grc-04-184-144-29-222.dsl.bell.ca. [184.144.29.222])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ae5eaf1sm245421306d6.30.2026.04.26.12.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 12:09:29 -0700 (PDT)
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
	savy@syst3mfailure.io,
	will@willsroot.io,
	xmei5@asu.edu,
	pctammela@mojatatu.com,
	kuniyu@google.com,
	toke@toke.dk,
	willemdebruijnkernel@gmail.com,
	hxzene@gmail.com,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: [PATCH net 5/9] net/sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop
Date: Sun, 26 Apr 2026 15:09:12 -0400
Message-Id: <20260426190916.128489-6-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260426190916.128489-1-jhs@mojatatu.com>
References: <20260426190916.128489-1-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D54F446ADDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281185-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,resnulli.us,networkplumber.org,mojatatu.com,syst3mfailure.io,willsroot.io,asu.edu,toke.dk,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	DKIM_TRACE(0.00)[mojatatu-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jhs@mojatatu.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber.org:email,mojatatu.com:mid,mojatatu.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20251104.gappssmtp.com:dkim]

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
Reviewed-by: Stephen Hemminger <stephen@networkplumber.org>
---
 net/sched/act_mirred.c | 47 +++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 2c5a7a321a94..dd5e7ea7ef26 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -26,6 +26,10 @@
 #include <net/tc_act/tc_mirred.h>
 #include <net/tc_wrapper.h>
 
+#define MIRRED_DEFER_LIMIT 3
+_Static_assert(MIRRED_DEFER_LIMIT <= 3,
+	       "MIRRED_DEFER_LIMIT exceeds tc_depth bitfield width");
+
 static LIST_HEAD(mirred_list);
 static DEFINE_SPINLOCK(mirred_list_lock);
 
@@ -234,12 +238,15 @@ tcf_mirred_forward(bool at_ingress, bool want_ingress, struct sk_buff *skb)
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
+		skb->tc_depth++;
+		if (!at_ingress)
+			err = netif_rx(skb);
+		else
+			err = netif_receive_skb(skb);
+	}
 
 	return err;
 }
@@ -426,6 +433,7 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 	struct netdev_xmit *xmit;
 	bool m_mac_header_xmit;
 	struct net_device *dev;
+	bool want_ingress;
 	int i, m_eaction;
 	u32 blockid;
 
@@ -434,7 +442,8 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 #else
 	xmit = this_cpu_ptr(&softnet_data.xmit);
 #endif
-	if (unlikely(xmit->sched_mirred_nest >= MIRRED_NEST_LIMIT)) {
+	if (unlikely(xmit->sched_mirred_nest >= MIRRED_NEST_LIMIT ||
+		     skb->tc_depth >= MIRRED_DEFER_LIMIT)) {
 		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
 				     netdev_name(skb->dev));
 		return TC_ACT_SHOT;
@@ -453,23 +462,27 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
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


