Return-Path: <netdev+bounces-151959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C87789F1FED
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 17:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A551887D0F
	for <lists+netdev@lfdr.de>; Sat, 14 Dec 2024 16:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5692C194ACA;
	Sat, 14 Dec 2024 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKPFwpfl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B5326AFF
	for <netdev@vger.kernel.org>; Sat, 14 Dec 2024 16:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734195072; cv=none; b=FOGRGb3VIbck6JAKgiHRgXd5/mv5KXg2PvrsvqRpiQcuFtdhHhTYba74R47fCmgbhwbe2fX+sgSyXcOoZ7+r915KiXBzfFugtiRL8qklZFilJdHcfcJVYrpcVntVYoJs//o72BNcOSTzRte+687fS712KwDmJ7Tv+mgge/tkXfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734195072; c=relaxed/simple;
	bh=GqwNr5Qx/BusN03aNgrXdPEF+nq2bWmqf4Aoq602EIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EEh2CoCbrU/AQOlmEQ0R6iczXjgJ7PRuwdliPmCZSj6a4fAjPmFzfg1KbzXRBhLhrrqGrrBjAXmcbjxyoLvJYY3TnGVb0ixNKxM1wJNe773zla8ABaPy4gL25v70nwDJRz1qlFfQjcKvCi1nps4CKTCRfj8szMrwtcRQXpqlLA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKPFwpfl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734195068;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RVlWdKCOQ6DeLuyGiOQjvrzYUdtBv49oGjdWIYwMtNo=;
	b=NKPFwpflmmUWJezEadXqsUhRKOhTZEA8uTZDwzNI74Y1ZESYj22W1CdSAdIahAQOS98ZGd
	DF23WYzKc/FguEkjUltEdcvhdRaQwAuPwgmUenjbsuzcjZmx9wxQbrkUwymyC1XOuRhvfG
	Tpn8/wWJjZYeDG9JeCSx1NCLdbg9rLY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-IIuvXM78P8CImEdj0I6Hiw-1; Sat, 14 Dec 2024 11:51:07 -0500
X-MC-Unique: IIuvXM78P8CImEdj0I6Hiw-1
X-Mimecast-MFC-AGG-ID: IIuvXM78P8CImEdj0I6Hiw
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-53e3a872209so1001839e87.2
        for <netdev@vger.kernel.org>; Sat, 14 Dec 2024 08:51:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734195066; x=1734799866;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RVlWdKCOQ6DeLuyGiOQjvrzYUdtBv49oGjdWIYwMtNo=;
        b=P4f3UGAqVopiZIvm7arDIt45QhLq27ltVD9C+wayxoMC/4CRgT6emxTwI/s0B+bumr
         UC+R71rFWj7tZZEx4Kt6VCARSW/6uAFpK5wq1oC7T7G9IyEMJpiB95hqV+QAJiOCSeiX
         x0ogjwNzl6bU/1ryxXGliJ/IeeI5RPh/iWyo8MlM2SDh80tfagbte+5gB48UV96cEe4p
         G+wGI3TC2YS3RFUrsh40SZ/7Hhk+BzExWhJd3X3/0qHN5Ppl49FFxOoA/zyaGjkS7Wjx
         hiAnw9/OLUZOa5q0TjvHNgLCELFJ6gAl0LBuOnEFYrLOmXz/AY9Gu4TePdCMp8xMDb/+
         v8Gw==
X-Gm-Message-State: AOJu0YybuP4eCtrpkfuCTdkXP4smrlisPglz5wNiUW3JmvIza0oTAeKA
	x1A5riPTPlvp4p3LdxHvJmLdpwtDwSY3saPS8YS3l9ln5H44Imj8P3H6GPfmY2Tz3Z/j4RfHOwI
	M/7/FnLRml4XAY7Vkb0yNrMvwXGFoPxA5RnkN0dvsObbgdhvWI3iOyw==
X-Gm-Gg: ASbGncuKOyrmiy/R2EJpnZ9gWqvWgmVRl/xesduYmQeJ/YEKnApblWMUibflopmJFdL
	OtyqhlUvdezFJGlcatQv4zETCIADRut9xVls9NbO2ub1wdO4/Szkv9n15ULzHxWwiUEwtbptgoN
	iC22CWakrhzlqexaxMZCRHW5cpNiHKZATO/gJLJhC1KhFGJQQC2KIwiUHYEJd+vmbzhj8uSViF/
	QqDQNmG2OdSZ6TIBAQ3U2zAEPTQOQYxefker0MiGkc2cfWFUs3twseXs1torAsHQGx2XCUiA4lz
	h9YeVQ==
X-Received: by 2002:a05:6512:3b23:b0:53e:389d:8ce4 with SMTP id 2adb3069b0e04-54090563fc7mr2172362e87.34.1734195065829;
        Sat, 14 Dec 2024 08:51:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGstJdmlcN6C5hWslWNy31W+hyyNBA7o56+oy2e7zTdVXbUOLiWOCVYUGTocGrCSxR/N/48tg==
X-Received: by 2002:a05:6512:3b23:b0:53e:389d:8ce4 with SMTP id 2adb3069b0e04-54090563fc7mr2172352e87.34.1734195065407;
        Sat, 14 Dec 2024 08:51:05 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54120b9f269sm266297e87.42.2024.12.14.08.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Dec 2024 08:51:04 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 57BF216F9775; Sat, 14 Dec 2024 17:51:03 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Sat, 14 Dec 2024 17:50:59 +0100
Subject: [PATCH net-next] net/sched: Add drop reasons for AQM-based qdiscs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241214-fq-codel-drop-reasons-v1-1-2a814e884c37@redhat.com>
X-B4-Tracking: v=1; b=H4sIAHK3XWcC/x3MMQrDMAxG4asEzRXUiofSq5QOJv6dCoqcyqEEQ
 u4ek/Eb3tupwRWNnsNOjr82rdYRbgNNn2QzWHM3yV1ikDBy+fFUM76cvS7sSK1aY5RRSop4IAr
 1dnEU3a7viwwrG7aV3sdxAubfEsBxAAAA
X-Change-ID: 20241213-fq-codel-drop-reasons-ef32fa4e8e42
To: Jamal Hadi Salim <jhs@mojatatu.com>, 
 Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

Now that we have generic QDISC_CONGESTED and QDISC_OVERLIMIT drop
reasons, let's have all the qdiscs that contain an AQM apply them
consistently when dropping packets.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/sch_codel.c    | 5 +++--
 net/sched/sch_fq_codel.c | 3 ++-
 net/sched/sch_fq_pie.c   | 6 ++++--
 net/sched/sch_gred.c     | 4 ++--
 net/sched/sch_pie.c      | 5 ++++-
 net/sched/sch_red.c      | 4 +++-
 net/sched/sch_sfb.c      | 4 +++-
 7 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index 3e8d4fe4d91e3ef2b7715640f6675aa5e8e2a326..81189d02fee761ad21142a205c347f33ef9a3edf 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -52,7 +52,7 @@ static void drop_func(struct sk_buff *skb, void *ctx)
 {
 	struct Qdisc *sch = ctx;
 
-	kfree_skb(skb);
+	kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_CONGESTED);
 	qdisc_qstats_drop(sch);
 }
 
@@ -89,7 +89,8 @@ static int codel_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 	q = qdisc_priv(sch);
 	q->drop_overlimit++;
-	return qdisc_drop(skb, sch, to_free);
+	return qdisc_drop_reason(skb, sch, to_free,
+				 SKB_DROP_REASON_QDISC_OVERLIMIT);
 }
 
 static const struct nla_policy codel_policy[TCA_CODEL_MAX + 1] = {
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 4f908c11ba9528f8f9f3af6752ff10005d6f6511..799f5397ad4c17ba69ad64ea7abb058f6da3da9b 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -168,6 +168,7 @@ static unsigned int fq_codel_drop(struct Qdisc *sch, unsigned int max_packets,
 		skb = dequeue_head(flow);
 		len += qdisc_pkt_len(skb);
 		mem += get_codel_cb(skb)->mem_usage;
+		tcf_set_drop_reason(skb, SKB_DROP_REASON_QDISC_OVERLIMIT);
 		__qdisc_drop(skb, to_free);
 	} while (++i < max_packets && len < threshold);
 
@@ -274,7 +275,7 @@ static void drop_func(struct sk_buff *skb, void *ctx)
 {
 	struct Qdisc *sch = ctx;
 
-	kfree_skb(skb);
+	kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_CONGESTED);
 	qdisc_qstats_drop(sch);
 }
 
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index c38f33ff80bde74cfe33de7558f66e5962ffe56b..93c36afbf576246fc696dc2787121d54e4850331 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -130,6 +130,7 @@ static inline void flow_queue_add(struct fq_pie_flow *flow,
 static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 				struct sk_buff **to_free)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_QDISC_OVERLIMIT;
 	struct fq_pie_sched_data *q = qdisc_priv(sch);
 	struct fq_pie_flow *sel_flow;
 	int ret;
@@ -161,6 +162,8 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		q->overmemory++;
 	}
 
+	reason = SKB_DROP_REASON_QDISC_CONGESTED;
+
 	if (!pie_drop_early(sch, &q->p_params, &sel_flow->vars,
 			    sel_flow->backlog, skb->len)) {
 		enqueue = true;
@@ -198,8 +201,7 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 out:
 	q->stats.dropped++;
 	sel_flow->vars.accu_prob = 0;
-	__qdisc_drop(skb, to_free);
-	qdisc_qstats_drop(sch);
+	qdisc_drop_reason(skb, sch, to_free, reason);
 	return NET_XMIT_CN;
 }
 
diff --git a/net/sched/sch_gred.c b/net/sched/sch_gred.c
index 7d2151c62c4a1452ec4914f0d25a2648f886af49..ab6234b4fcd541956ce0bdb0773de448df4c9e51 100644
--- a/net/sched/sch_gred.c
+++ b/net/sched/sch_gred.c
@@ -251,10 +251,10 @@ static int gred_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	q->stats.pdrop++;
 drop:
-	return qdisc_drop(skb, sch, to_free);
+	return qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_OVERLIMIT);
 
 congestion_drop:
-	qdisc_drop(skb, sch, to_free);
+	qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_CONGESTED);
 	return NET_XMIT_CN;
 }
 
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index b3dcb845b32759357f4db1980a7cb4db531bfad5..bb1fa9aa530b2737d901a7a76c481398cb1b75a2 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -85,6 +85,7 @@ EXPORT_SYMBOL_GPL(pie_drop_early);
 static int pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			     struct sk_buff **to_free)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_QDISC_OVERLIMIT;
 	struct pie_sched_data *q = qdisc_priv(sch);
 	bool enqueue = false;
 
@@ -93,6 +94,8 @@ static int pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		goto out;
 	}
 
+	reason = SKB_DROP_REASON_QDISC_CONGESTED;
+
 	if (!pie_drop_early(sch, &q->params, &q->vars, sch->qstats.backlog,
 			    skb->len)) {
 		enqueue = true;
@@ -121,7 +124,7 @@ static int pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 out:
 	q->stats.dropped++;
 	q->vars.accu_prob = 0;
-	return qdisc_drop(skb, sch, to_free);
+	return qdisc_drop_reason(skb, sch, to_free, reason);
 }
 
 static const struct nla_policy pie_policy[TCA_PIE_MAX + 1] = {
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 6029bc29b51e5d5adfa12c68225691b68648b2dc..ef8a2afed26bd6e8205592389907bf4986e1aea6 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -70,6 +70,7 @@ static int red_use_nodrop(struct red_sched_data *q)
 static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		       struct sk_buff **to_free)
 {
+	enum skb_drop_reason reason = SKB_DROP_REASON_QDISC_CONGESTED;
 	struct red_sched_data *q = qdisc_priv(sch);
 	struct Qdisc *child = q->qdisc;
 	unsigned int len;
@@ -107,6 +108,7 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		break;
 
 	case RED_HARD_MARK:
+		reason = SKB_DROP_REASON_QDISC_OVERLIMIT;
 		qdisc_qstats_overlimit(sch);
 		if (red_use_harddrop(q) || !red_use_ecn(q)) {
 			q->stats.forced_drop++;
@@ -143,7 +145,7 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (!skb)
 		return NET_XMIT_CN | ret;
 
-	qdisc_drop(skb, sch, to_free);
+	qdisc_drop_reason(skb, sch, to_free, reason);
 	return NET_XMIT_CN;
 }
 
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index b717e15a3a17bc2e166308a74dbfc4a75c0bb2a2..d2835f1168e1dcef44044df8c4505bfc03a5d0cb 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -280,6 +280,7 @@ static int sfb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		       struct sk_buff **to_free)
 {
 
+	enum skb_drop_reason reason = SKB_DROP_REASON_QDISC_OVERLIMIT;
 	struct sfb_sched_data *q = qdisc_priv(sch);
 	unsigned int len = qdisc_pkt_len(skb);
 	struct Qdisc *child = q->qdisc;
@@ -380,6 +381,7 @@ static int sfb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	r = get_random_u16() & SFB_MAX_PROB;
+	reason = SKB_DROP_REASON_QDISC_CONGESTED;
 
 	if (unlikely(r < p_min)) {
 		if (unlikely(p_min > SFB_MAX_PROB / 2)) {
@@ -414,7 +416,7 @@ static int sfb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	return ret;
 
 drop:
-	qdisc_drop(skb, sch, to_free);
+	qdisc_drop_reason(skb, sch, to_free, reason);
 	return NET_XMIT_CN;
 other_drop:
 	if (ret & __NET_XMIT_BYPASS)

---
base-commit: 9bc5c9515b4817e994579b21c32c033cbb3b0e6c
change-id: 20241213-fq-codel-drop-reasons-ef32fa4e8e42


