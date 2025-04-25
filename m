Return-Path: <netdev+bounces-186161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CD7A9D51A
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C42C87B5225
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950B623027C;
	Fri, 25 Apr 2025 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="SvdH/PDC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EB622AE41
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745618853; cv=none; b=ecRCvAb2uehbr01fXll0X1yxkLOYhB6kUEFm0ANQzc83ZJgUxm/t22F2ApQxrwGMQW6I1MQ239LV7OjKoPGA84uPW8qHbtlp/ub0EBJrCU7r5sXaKSrJaCgxxqBuIhVvVBM3Scdd4StS3+8PZPnuqUkrna5ZaAdNiv5YU4QEepY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745618853; c=relaxed/simple;
	bh=P4oEHuginbJ7VmQ0d0xyRlgdyuv9A2PqAAEqPF9FUOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2t7Uj0bG15SukQhJ0DZ13FlwiW1bcmEa2F/eUxrUGT/JN/PfYxcL3yEWFaiXYkl12mSJHEmNFGPLYLcizrbbC7/zrafhJy8O9oOrE8PjAMe62EGuRACpIlcwtSk9PkQbOXS44dMKS+0lqYGzzuPsyZpGr/vrU4jEp7MueflHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=SvdH/PDC; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-aee773df955so3374871a12.1
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1745618851; x=1746223651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G51CSaSeaXjQygUaqk5LQux0Rdif9WS8lX4IMOtaNhY=;
        b=SvdH/PDCXl1N1lhA1X3PxN8eMNpL4UBuYyLncH0/SwKn1gviHKiBvdzlB9MXDzVUnu
         3fvQLOEgSl9tFyeQK31oTFcpPTDAg6005yvppwlvm+vhs7r3vA6bw9iPPTfHVK/o5Oaa
         Q9b2W/DX5/0U0zyGN58A4hPdX495vrxBP9EwidW6YE0udPIYBT7Sye15wYMnQsZjJkAP
         s4dBPQA4m6Lwq41XYHpZLg2EO+h3oPc4zatsIPr6OJ/c4LzCWzVu/1Hde1IanrTNov/k
         JEU7UnaUCN+M8n6lTInMgGhElD8AtjfQ4aeEzBG76d+SuNPO2jzaKxKtoL1NrOXtk2Ni
         7NiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745618851; x=1746223651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G51CSaSeaXjQygUaqk5LQux0Rdif9WS8lX4IMOtaNhY=;
        b=ZPFPBA8t7EbmqtGBQJbPHoBbNB5x5kyUzLHEl8JAAFQixG0dHbsDeemntlqAz3gg6+
         LCud9Rb7e/OdNmkpbbDzXD4MWHAfenAxzjMTE/Ya9tukVk+2Fja7VxpK80UWFkUbL5fy
         SQwz/DrdhNBQb+q6R41VpfvjqPhrpnXm64sHA2uSVtNmflMIOiJ0swMlavenTMyDekpr
         ZbKKfEOLVmzO8bR7CZ/FAPOq43gDCRJlPZAgNxAhH9Rx0jh7IpnmW5mzd9ML+mQ3rSGC
         k5rptQQbeqJJTaLFXY9TT36pLgG/a1kpzPmozGCiVnZ1J3U49p4H+8/FoLiyKjzvTB6O
         39+Q==
X-Gm-Message-State: AOJu0YwcYuEaqeGfS1fZ7+CWwUU6WU0S1bLQurkX2r1qZPKqXd6yalti
	4FbtJyCikzJFQHmnMxXEHVLvO13kZMjLZEbmFyU2BBzsTH5nAO1cfw6G4PU7ewH8rZfoJGXo0nc
	=
X-Gm-Gg: ASbGnctKkdW6/+3RmY4ztr3XPrL3wTr/4I7i16c1h5mE1M+RtYBdWMT6AccqgdUR5vL
	GfGKrooysSCUye2ungX4iQKg0YN+Coq4D3MzfBhhf2djelpHNb0DFniCXIbElPn2lOGQW2hj1iV
	k41Qd0dFLpeYNpROIqIVTmsRmkq4Juk8103WN2Gy1BcYob7Fb08RdBwWZ9jn1lRZ0pzOQD3j3Jh
	c/RGnO3sNCR4jf4WisLXAdc8s0gHYsQgPkuFxtpni1lRh1vJCK3SuPywQ7oqr5rojBbme2cf1ZH
	/+Ba9GbaBKlXezjnoOlvfaSiKB+kVlHhzTZ6GlYYJ/BTCn2EM61M1w==
X-Google-Smtp-Source: AGHT+IE3C+es5wn8VrYWvWJp4TPZoqPLq44HtqC7CNGs7uFKH1alHdFF2diarYP4kRmDomjjt55N9w==
X-Received: by 2002:a17:902:d486:b0:21f:6d63:6f4f with SMTP id d9443c01a7336-22db4794b0bmr109665785ad.2.1745618851010;
        Fri, 25 Apr 2025 15:07:31 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c0:73b:9a6c:c614:cc79:b1ba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dc3b7bsm37753185ad.100.2025.04.25.15.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 15:07:30 -0700 (PDT)
From: Victor Nogueira <victor@mojatatu.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	gerrard.tai@starlabs.sg,
	pctammela@mojatatu.com,
	stephen@networkplumber.org
Subject: [PATCH net v3 4/5] net_sched: qfq: Fix double list add in class with netem as child qdisc
Date: Fri, 25 Apr 2025 19:07:08 -0300
Message-ID: <20250425220710.3964791-5-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425220710.3964791-1-victor@mojatatu.com>
References: <20250425220710.3964791-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As described in Gerrard's report [1], there are use cases where a netem
child qdisc will make the parent qdisc's enqueue callback reentrant.
In the case of qfq, there won't be a UAF, but the code will add the same
classifier to the list twice, which will cause memory corruption.

This patch checks whether the class was already added to the agg->active
list (cl_is_active) before doing the addition to cater for the reentrant
case.

[1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/

Fixes: 37d9cf1a3ce3 ("sched: Fix detection of empty queues in child qdiscs")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_qfq.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 687a932eb9b2..bf1282cb22eb 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -202,6 +202,11 @@ struct qfq_sched {
  */
 enum update_reason {enqueue, requeue};
 
+static bool cl_is_active(struct qfq_class *cl)
+{
+	return !list_empty(&cl->alist);
+}
+
 static struct qfq_class *qfq_find_class(struct Qdisc *sch, u32 classid)
 {
 	struct qfq_sched *q = qdisc_priv(sch);
@@ -1215,7 +1220,6 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct qfq_class *cl;
 	struct qfq_aggregate *agg;
 	int err = 0;
-	bool first;
 
 	cl = qfq_classify(skb, sch, &err);
 	if (cl == NULL) {
@@ -1237,7 +1241,6 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	gso_segs = skb_is_gso(skb) ? skb_shinfo(skb)->gso_segs : 1;
-	first = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		pr_debug("qfq_enqueue: enqueue failed %d\n", err);
@@ -1253,8 +1256,8 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	++sch->q.qlen;
 
 	agg = cl->agg;
-	/* if the queue was not empty, then done here */
-	if (!first) {
+	/* if the class is active, then done here */
+	if (cl_is_active(cl)) {
 		if (unlikely(skb == cl->qdisc->ops->peek(cl->qdisc)) &&
 		    list_first_entry(&agg->active, struct qfq_class, alist)
 		    == cl && cl->deficit < len)
-- 
2.34.1


