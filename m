Return-Path: <netdev+bounces-299392-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aDn9BRrWL2rlHgUAu9opvQ
	(envelope-from <netdev+bounces-299392-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:38:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0289968562B
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 12:38:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299392-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-299392-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF8463003BC6
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 10:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFC43074B1;
	Mon, 15 Jun 2026 10:38:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0AA40D586
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 10:38:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781519892; cv=none; b=Tt3us18aUSiU0UiB3uTz+H6GpE6jSuTIiufCWff+IujHG999I2Wiumy7jE5PYCzY7ivCwnd9JMPMMMhWNt55jZVrHyabJQ50CebBikOiVVL8XOoxfGIEVJiBcI9j3fGZqQr6LersLqe9jj/sKmujcQEQVUplTURVRox+ET2DaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781519892; c=relaxed/simple;
	bh=s0PnjE2XXkSyiM2t29c+YcY2r0+0fCEpTkVys6WiIP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CDd8YeFO+11g88f4SkElqdby/BiY/+ScQKfYS9rCTqtOevVVGujgPynwnYDuHmLY/g1/h86VPEFCZ+wuTkiF31lmVJS3fWSSg5A2ZkkxcOUso8fx+MauHoyjf7RTH3EPMdIrqzDlSWPLK8l7h8cifSNFsygEZf7EKRx3uaVFwF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.164.118
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app1 (Coremail) with SMTP id ygmowACnv7kG1i9q3FiIAA--.41541S3;
	Mon, 15 Jun 2026 18:38:01 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	petrm@mellanox.com,
	davem@davemloft.net,
	yuantan098@gmail.com,
	yifanwucs@gmail.com,
	tomapufckgml@gmail.com,
	zcliangcn@gmail.com,
	bird@lzu.edu.cn,
	bronzed_45_vested@icloud.com,
	n05ec@lzu.edu.cn
Subject: [PATCH net 1/1] net: sched: ets: avoid deficit wrap and empty-round livelock
Date: Mon, 15 Jun 2026 18:37:54 +0800
Message-ID: <20260615103759.2404228-2-n05ec@lzu.edu.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260615103759.2404228-1-n05ec@lzu.edu.cn>
References: <20260615103759.2404228-1-n05ec@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowACnv7kG1i9q3FiIAA--.41541S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJF1kGFWDtF47CFWUJF1DJrb_yoWrXrWxpF
	93JF90kFW8Jrs3Wa4xG3y7X3WSkrs3G3Z8ArW3Kw1rKrn8ua1rt34rKw12krn3KFZ8u3sF
	yF1jva4qkr47CFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB01xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E
	87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
	8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_
	JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
	xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFylc2xSY4AK6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_Gr4l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUFg4SDUUUU
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQATCWovtdIDMAAAsK
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-299392-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[lzu.edu.cn];
	FREEMAIL_CC(0.00)[mojatatu.com,resnulli.us,mellanox.com,davemloft.net,gmail.com,lzu.edu.cn,icloud.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:jhs@mojatatu.com,m:jiri@resnulli.us,m:petrm@mellanox.com,m:davem@davemloft.net,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,m:n05ec@lzu.edu.cn,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[n05ec@lzu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,icloud.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0289968562B

From: Wyatt Feng <bronzed_45_vested@icloud.com>

ETS keeps each DRR-style deficit in a u32 and replenishes it with
the configured quantum whenever the head packet is too large. Both
the quantum and qdisc_pkt_len() are user-controlled inputs: a large
quantum can wrap the deficit counter, while a tiny quantum combined
with an inflated qdisc_pkt_len() can force billions of iterations in
softirq context before any packet becomes eligible.

Store deficits in u64 so replenishment remains monotonic, and after
one complete pass over the active list compute how many additional
full rounds cannot dequeue from any class. Add that budget in bulk
instead of advancing one quantum at a time. This preserves ETS ordering
while removing the non-productive loop.

Fixes: dcc68b4d8084 ("net: sch_ets: Add a new Qdisc")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 net/sched/sch_ets.c | 63 +++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index a4b07b661b77..ed3b191781ee 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -40,7 +40,7 @@ struct ets_class {
 	struct list_head alist; /* In struct ets_sched.active. */
 	struct Qdisc *qdisc;
 	u32 quantum;
-	u32 deficit;
+	u64 deficit;
 	struct gnet_stats_basic_sync bstats;
 	struct gnet_stats_queue qstats;
 };
@@ -465,8 +465,10 @@ ets_qdisc_dequeue_skb(struct Qdisc *sch, struct sk_buff *skb)
 static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 {
 	struct ets_sched *q = qdisc_priv(sch);
-	struct ets_class *cl;
+	struct ets_class *cl, *first;
 	struct sk_buff *skb;
+	u64 extra_rounds;
+	u64 rounds;
 	unsigned int band;
 	unsigned int len;
 
@@ -481,26 +483,49 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
 		if (list_empty(&q->active))
 			goto out;
 
-		cl = list_first_entry(&q->active, struct ets_class, alist);
-		skb = cl->qdisc->ops->peek(cl->qdisc);
-		if (!skb) {
-			qdisc_warn_nonwc(__func__, cl->qdisc);
-			goto out;
-		}
+		first = list_first_entry(&q->active, struct ets_class, alist);
+		extra_rounds = U64_MAX;
 
-		len = qdisc_pkt_len(skb);
-		if (len <= cl->deficit) {
-			cl->deficit -= len;
-			skb = qdisc_dequeue_peeked(cl->qdisc);
-			if (unlikely(!skb))
+		do {
+			cl = list_first_entry(&q->active, struct ets_class, alist);
+			skb = cl->qdisc->ops->peek(cl->qdisc);
+			if (!skb) {
+				qdisc_warn_nonwc(__func__, cl->qdisc);
 				goto out;
-			if (cl->qdisc->q.qlen == 0)
-				list_del_init(&cl->alist);
-			return ets_qdisc_dequeue_skb(sch, skb);
-		}
+			}
+
+			len = qdisc_pkt_len(skb);
+			if (len <= cl->deficit) {
+				cl->deficit -= len;
+				skb = qdisc_dequeue_peeked(cl->qdisc);
+				if (unlikely(!skb))
+					goto out;
+				if (cl->qdisc->q.qlen == 0)
+					list_del_init(&cl->alist);
+				return ets_qdisc_dequeue_skb(sch, skb);
+			}
+
+			cl->deficit += cl->quantum;
+			list_move_tail(&cl->alist, &q->active);
+
+			if (len <= cl->deficit) {
+				extra_rounds = 0;
+				continue;
+			}
+
+			rounds = div64_u64((u64)len - cl->deficit + cl->quantum - 1,
+					   cl->quantum);
+			if (rounds < extra_rounds)
+				extra_rounds = rounds;
+		} while (list_first_entry(&q->active, struct ets_class,
+					  alist) != first);
+
+		if (!extra_rounds)
+			continue;
 
-		cl->deficit += cl->quantum;
-		list_move_tail(&cl->alist, &q->active);
+		/* Skip full rounds where no active class can dequeue. */
+		list_for_each_entry(cl, &q->active, alist)
+			cl->deficit += extra_rounds * cl->quantum;
 	}
 out:
 	return NULL;
-- 
2.43.7


