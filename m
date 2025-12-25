Return-Path: <netdev+bounces-246071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7B5CDE1B6
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 22:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2155A3009F8B
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 21:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCC623EA8A;
	Thu, 25 Dec 2025 21:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="eiBMlunc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB6212560
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766696566; cv=none; b=I+GYcP4xRUw5WtmJpokFkmuNL793gXet0FEeqx7jU1d37UkTge5m3k+yQaS4J9PiMEsZBRc44P9oUIfeJNo51qZyOMJ0VhXhFnQvRKSmmx5BgB3xAx4azMibu1EuOMnWTcNS8fp6w2CwI3HkQ1aaK98/5JsDdBB44d1tzfv+Nyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766696566; c=relaxed/simple;
	bh=5/mJ+GM77wd9yVHoRhoZ6HzRdQGOxB4xaIBCLekK+Rk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IqD2+v3mqMsUaWVubNi4jwUdV28cA4Xq2sA5F6S04UWRwNo7ewPoYgA7+rgi0vsXH68E4f0o/LETgktQWK1ejJ6HyHsO4dn/K+oPbQJHKbKYHqFLv7iOhuHu3ijOy4brcITuKfZaK6WXbt5Lg8F6JJ7lVThxgFaNtCNBOYkBo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=eiBMlunc; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8888a16d243so60250966d6.1
        for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 13:02:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1766696563; x=1767301363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E9rsTX5Yid/6usuz603tSD+vnaGi2M2iqYSzD/+yP+A=;
        b=eiBMluncCm6QL23KKmyKDjNf5pCoKgS55KIVOuGfsD1mDrLS57VCxgHmqEc1D87kVv
         j3j5cYkd0kUikTTBXuZI64UFLOUEFCZRU/rMEbFjVXbhYhtYWNR4bWqrXHThI4E9gDIv
         zRFuIlVVM3mTj2DVlkx7NGSr6r+2BNQbiY52Ph9GpRltsRzFkcM5dWceW+fTJMFUxMqv
         uBfapAV3r99PXlgRBysqWQBxKS99huAmRu6F0eXVGxhRwMln/rIFu0C8a2szX0x8jiCl
         du6hW456SYf/zV08YkoHLUMIWtFUbc6EaekyfmRLu2Y90DW/OppCS2zotOCE+fXP3TkU
         tM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766696563; x=1767301363;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E9rsTX5Yid/6usuz603tSD+vnaGi2M2iqYSzD/+yP+A=;
        b=WUosjYO8cSTk9wMCTnhhc1eHf9vy4Hi6/si7/qUQ3ZHorwKOzjbzNKet5AXvFilVlM
         5dCUeGsVft2xGPL+m6jaYfnCNpNNRXVlFzoyXWHZkoNKd1bscHPgYgSa8D8Rs9cwQsrA
         7PyG68rsWJC7QA5GBjLZaK4UJnuVlie/TCrARtNKpEOA4j18q27Cfv+5itVlFhq2R4W3
         mMCacdt/jWgzXsNFAFPRpltC8To2lTJ9EJDapMO7h4tHdqQz6pWMNWWqWdr+xQ5bqZUl
         U4tzUfY+ua8IpEG4kWuN7QrYtmZWDO/1ysIgJOyipWUjd8QCiqe4j7ZLZvoq7ETjDoT4
         ddtA==
X-Gm-Message-State: AOJu0Yy8kEzfgVaR5dLmtVEIm8RVA2XR4qAyRW3Fort7BQchFXXWadxV
	IpQr28M24YgNMBumVfL+hI9OOHq4SUtPNPGam676h9sWZJYElcfYR853qkwOoERzdA==
X-Gm-Gg: AY/fxX6m7DGHQ2+mSJ3aaI3wJMUTLV/bPBUz1RH48Xnrv2ma9fw3q4H102PIqF0noHG
	MKgOHkDjf7sDBZyFqHo1i12eHR5DuD5jXi8Q/VYngft4BgOK1jutBACi4P9yRkW4HKBLF0WHLGA
	V0VzqsBXDnBrvyBfAhmnSl+KjVP2FSqrjQx57zFdpbP7Qs8IlrCmykY6d+zGHApJviwCtnO8OzM
	yNoNDCFxVrQHt8Rwh/Qv3vHo+TcfYrG+d7ssmcTtr2fhE+6m4czwGF9wYOybsZln07nwA5uR7yU
	LOmpic+Y0o5fFCwUGTSnvwi0YYRuWMXvEhcs3vlJEowSMF/0ij/ZwsHvYyh1FzHfsrz9i2ydjCd
	O8rE8cyiO1Mp3ZyYCzV2FKqOJuzhmsLkFDRPOmLmt40OypZA/9p8/OjTlD/yHtNkDJHImNGRvn/
	j2a5NijuAO4o+RtM9Pcq6ZDw==
X-Google-Smtp-Source: AGHT+IEhxElW9Wxc4MWiMp2RDmmsBUDoUeYPP1kJv7VCYwX3ped446mLuxxgktp8zI8BF72G+c8emw==
X-Received: by 2002:a05:6214:1873:b0:88a:2343:3ae0 with SMTP id 6a1803df08f44-88d851fd745mr248900036d6.3.1766696558666;
        Thu, 25 Dec 2025 13:02:38 -0800 (PST)
Received: from majuu.waya ([70.50.89.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88d99d7e926sm149254146d6.42.2025.12.25.13.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 13:02:37 -0800 (PST)
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
	will@willsroot.io,
	stephen@networkplumber.org,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH RFC net v4 1/1] net: sched: Fix ethx:ingress -> ethy:egress -> ethx:ingress mirred loop
Date: Thu, 25 Dec 2025 16:02:21 -0500
Message-Id: <20251225210221.152189-1-jhs@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes since V1:
1) Fix compile issues found by Intel bot. Thank you bot
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512121401.3NRi0dUf-lkp@intel.com/
2) Fix other issues found by patchwork
 - https://patchwork.kernel.org/project/netdevbpf/patch/20251210172554.1071864-1-jhs@mojatatu.com/
3) The AI reviewer claimed there was an issue but the link was a 404
 - https://netdev-ai.bots.linux.dev/ai-review.html?id=23b3f0a5-ca6c-4cd2-962e-34cbf46f9d24

Changes since V2:
Fix compile issues found by Intel bot. Thank you bot!
The bot created the issue by unselecting ifb.
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512140745.hsk9Cf0J-lkp@intel.com/

Changes since v3:
From Victor - add support for netem loop fix.
Post RFC would need for William's patch to be reverted.

This patch could be broken down into multiple patches(at least three), but
posted as one because it is an RFC.

For netem, see Will's current fix: ec8e0e3d7ade ("net/sched: Restrict conditions for adding duplicating netems to qdisc tree")

A simple test:

tc qdisc add dev lo root handle 1: netem limit 1 duplicate 100%
tc qdisc add dev lo parent 1: handle 2: netem gap 1 limit 1 duplicate 100% delay 1us reorder 100%
ping -I lo -f -c1 -s48 -W0.001 127.0.0.1

For the mirred case:
When mirred redirects from egress to ingress the loop state is lost.
This is because the current loop detection mechanism depends on the device
being rememebred on the sched_mirred_dev array; however, that array is
cleared when we go from egress->ingress because the packet ends up in the
backlog and when we restart from the backlog the loop is amplified, on and
on...

A simple test case:

tc qdisc add dev ethx clsact
tc qdisc add dev ethy clsact
tc filter add dev ethx ingress protocol ip \
   prio 10 matchall action mirred egress redirect dev ethy
tc filter add dev ethy egress protocol ip \
   prio 10 matchall action mirred ingress redirect dev ethx

ping such that packets arrive on ethx. Puff and sweat while the cpu
consumption goes up. Or just delete those two qdiscs from above
on ethx and ethy.

For this to work we need to _remember the loop state in the skb_.
We reclaim the bit "skb->from_ingress" to the qdisc_skb_cb since its use
is constrained for ifb. We then use an extra bit that was available on
the skb for a total of 2 "skb->ttl" bits.
Mirred increments the ttl whenever it sees the same skb. We then
catch it when it exceeds MIRRED_NEST_LIMIT iterations of the loop.

Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 drivers/net/ifb.c              |  2 +-
 include/linux/skbuff.h         | 24 ++----------------------
 include/net/sch_generic.h      | 27 +++++++++++++++++++++++++++
 net/netfilter/nft_fwd_netdev.c |  1 +
 net/sched/act_mirred.c         |  4 +++-
 net/sched/sch_netem.c          |  7 +++----
 6 files changed, 37 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index d3dc0914450a..137a20e4bf8c 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -124,7 +124,7 @@ static void ifb_ri_tasklet(struct tasklet_struct *t)
 		rcu_read_unlock();
 		skb->skb_iif = txp->dev->ifindex;
 
-		if (!skb->from_ingress) {
+		if (!qdisc_skb_cb(skb)->from_ingress) {
 			dev_queue_xmit(skb);
 		} else {
 			skb_pull_rcsum(skb, skb->mac_len);
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 86737076101d..7f18b0c28728 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -840,6 +840,7 @@ enum skb_tstamp_type {
  *	@no_fcs:  Request NIC to treat last 4 bytes as Ethernet FCS
  *	@encapsulation: indicates the inner headers in the skbuff are valid
  *	@encap_hdr_csum: software checksum is needed
+ *	@ttl: time to live count when a packet loops.
  *	@csum_valid: checksum is already valid
  *	@csum_not_inet: use CRC32c to resolve CHECKSUM_PARTIAL
  *	@csum_complete_sw: checksum was completed by software
@@ -1000,6 +1001,7 @@ struct sk_buff {
 	/* Indicates the inner headers are valid in the skbuff. */
 	__u8			encapsulation:1;
 	__u8			encap_hdr_csum:1;
+	__u8			ttl:2;
 	__u8			csum_valid:1;
 #ifdef CONFIG_IPV6_NDISC_NODETYPE
 	__u8			ndisc_nodetype:2;
@@ -1016,9 +1018,6 @@ struct sk_buff {
 	__u8			offload_l3_fwd_mark:1;
 #endif
 	__u8			redirected:1;
-#ifdef CONFIG_NET_REDIRECT
-	__u8			from_ingress:1;
-#endif
 #ifdef CONFIG_NETFILTER_SKIP_EGRESS
 	__u8			nf_skip_egress:1;
 #endif
@@ -5352,30 +5351,11 @@ static inline bool skb_is_redirected(const struct sk_buff *skb)
 	return skb->redirected;
 }
 
-static inline void skb_set_redirected(struct sk_buff *skb, bool from_ingress)
-{
-	skb->redirected = 1;
-#ifdef CONFIG_NET_REDIRECT
-	skb->from_ingress = from_ingress;
-	if (skb->from_ingress)
-		skb_clear_tstamp(skb);
-#endif
-}
-
 static inline void skb_reset_redirect(struct sk_buff *skb)
 {
 	skb->redirected = 0;
 }
 
-static inline void skb_set_redirected_noclear(struct sk_buff *skb,
-					      bool from_ingress)
-{
-	skb->redirected = 1;
-#ifdef CONFIG_NET_REDIRECT
-	skb->from_ingress = from_ingress;
-#endif
-}
-
 static inline bool skb_csum_is_sctp(struct sk_buff *skb)
 {
 #if IS_ENABLED(CONFIG_IP_SCTP)
diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index c3a7268b567e..b34a1ba258c1 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -459,6 +459,14 @@ struct qdisc_skb_cb {
 	u8			post_ct:1;
 	u8			post_ct_snat:1;
 	u8			post_ct_dnat:1;
+#ifdef CONFIG_NET_REDIRECT
+	/* XXX: For RFC,  we should review and/or fix CONFIG_NET_REDIRECT
+	 * dependency or totally get rid of the NET_REDIRECT Kconfig (which
+	 * would work assuming qdisc_skb_cb is omni present; need to check
+	 * on netfilter dependency; everything else depends on mirred.
+	 */
+	u8			from_ingress:1;
+#endif
 };
 
 typedef void tcf_chain_head_change_t(struct tcf_proto *tp_head, void *priv);
@@ -1140,6 +1148,25 @@ static inline void qdisc_dequeue_drop(struct Qdisc *q, struct sk_buff *skb,
 	q->to_free = skb;
 }
 
+static inline void skb_set_redirected(struct sk_buff *skb, bool from_ingress)
+{
+	skb->redirected = 1;
+#ifdef CONFIG_NET_REDIRECT
+	qdisc_skb_cb(skb)->from_ingress = from_ingress;
+	if (qdisc_skb_cb(skb)->from_ingress)
+		skb_clear_tstamp(skb);
+#endif
+}
+
+static inline void skb_set_redirected_noclear(struct sk_buff *skb,
+					      bool from_ingress)
+{
+	skb->redirected = 1;
+#ifdef CONFIG_NET_REDIRECT
+	qdisc_skb_cb(skb)->from_ingress = from_ingress;
+#endif
+}
+
 /* Instead of calling kfree_skb() while root qdisc lock is held,
  * queue the skb for future freeing at end of __dev_xmit_skb()
  */
diff --git a/net/netfilter/nft_fwd_netdev.c b/net/netfilter/nft_fwd_netdev.c
index 152a9fb4d23a..d62c856ef96a 100644
--- a/net/netfilter/nft_fwd_netdev.c
+++ b/net/netfilter/nft_fwd_netdev.c
@@ -16,6 +16,7 @@
 #include <net/netfilter/nf_dup_netdev.h>
 #include <net/neighbour.h>
 #include <net/ip.h>
+#include <net/sch_generic.h>
 
 struct nft_fwd_netdev {
 	u8	sreg_dev;
diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
index 91c96cc625bd..4a945ea00197 100644
--- a/net/sched/act_mirred.c
+++ b/net/sched/act_mirred.c
@@ -318,8 +318,10 @@ static int tcf_mirred_to_dev(struct sk_buff *skb, struct tcf_mirred *m,
 
 		skb_set_redirected(skb_to_send, skb_to_send->tc_at_ingress);
 
+		skb_to_send->ttl++;
 		err = tcf_mirred_forward(at_ingress, want_ingress, skb_to_send);
 	} else {
+		skb_to_send->ttl++;
 		err = tcf_mirred_forward(at_ingress, want_ingress, skb_to_send);
 	}
 	if (err)
@@ -434,7 +436,7 @@ TC_INDIRECT_SCOPE int tcf_mirred_act(struct sk_buff *skb,
 #else
 	xmit = this_cpu_ptr(&softnet_data.xmit);
 #endif
-	if (unlikely(xmit->sched_mirred_nest >= MIRRED_NEST_LIMIT)) {
+	if (skb->ttl >= MIRRED_NEST_LIMIT - 1) {
 		net_warn_ratelimited("Packet exceeded mirred recursion limit on dev %s\n",
 				     netdev_name(skb->dev));
 		return TC_ACT_SHOT;
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 32a5f3304046..7363e13286de 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -461,7 +461,8 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	skb->prev = NULL;
 
 	/* Random duplication */
-	if (q->duplicate && q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
+	if (q->duplicate && !skb->ttl &&
+	    q->duplicate >= get_crandom(&q->dup_cor, &q->prng))
 		++count;
 
 	/* Drop packet? */
@@ -539,11 +540,9 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	 */
 	if (skb2) {
 		struct Qdisc *rootq = qdisc_root_bh(sch);
-		u32 dupsave = q->duplicate; /* prevent duplicating a dup... */
 
-		q->duplicate = 0;
+		skb2->ttl++; /* prevent duplicating a dup... */
 		rootq->enqueue(skb2, rootq, to_free);
-		q->duplicate = dupsave;
 		skb2 = NULL;
 	}
 
-- 
2.34.1


