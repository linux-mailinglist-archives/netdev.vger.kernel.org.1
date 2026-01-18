Return-Path: <netdev+bounces-250808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFADD392FB
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 07:16:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B21F3011B36
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 06:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAC1273F9;
	Sun, 18 Jan 2026 06:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B607gwtm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70550213254
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 06:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768716960; cv=none; b=jgjOqct9O+yjeYqagw96No6aPMLlbWnwcGqNvJvWhW/DHllOiIb8CWlCTPrzGqhS1qiu7B6d65TdU1DT4MMl6HO37B1pqoSElgStbM8UN+ZfI4bx2rpvYzDemsvzydpLpQ0xbVlH70PUKWzOfykztubEG+6ldufeoJCPXn8lt9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768716960; c=relaxed/simple;
	bh=5qFXHBiWw7PElA5BpRfqIJ9/SQGrrHfdr+7UyEDe8bI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=u8LE53qAu0yf55odOfJ3q9JsgymtSjZTCcJytPvG1s+wS2pY/NN2F5JwOTrzhdnoJsSyTc+w6UZYe5nU8eUeD6i19xPpHXFwAyXflK67+WZUirTO6/9rzKQjgxPOTMiV6AUo6InnJrOKk77239+y2mUok/Pz0TPf+KbxCKYggFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B607gwtm; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b4520f6b32so4565169eec.0
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 22:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768716958; x=1769321758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZ5cRQXAqdfgbyKraX+CFx/OFSh4TE8N02BoaRXms+Q=;
        b=B607gwtm1lBsf0d0GymjvTYaM371fkWcMWbmk4PKNo61pCwJ+Ut5NdS/YODk1jBV2m
         MLE/Ykphz8D6W7QKef4K18Xm1kjMkNmZcHlPc+V2mpA0NUManBbuFfhjKE3Zg2wVx+x8
         FOc2zhxOUhRPgfCQGFSB8oMrJJkf9RnILG8KjvySYhS79seTUMF4f76/J2gccNyTda+/
         XMj2Yj1VdSz0Ls5m/dbx30WqPYUJibjTLEwCvtiFoIUkQFa1IGOZlkZajRKYCzEaxBtc
         1iknaVTifq7AwS0z0g98yYgObf6+90Kv1ptLVTsrL6r+r6ZuZ+XMpD1nip2z/+SENgtq
         MmQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768716958; x=1769321758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pZ5cRQXAqdfgbyKraX+CFx/OFSh4TE8N02BoaRXms+Q=;
        b=j7+TbUAkU1Tpn8LWVfMyDDFDYRo9I4xWAID6fb9wZbQ5Tt33fTx6RoKErWkeIJJtJb
         qIPrNKQ3LwyZwnbcme8oH9axnPQaHwDdtGAlEiP/CAUiEA6IB9eZbq28WBaivbR3ReJb
         4OKWVqJi/2j5mj+9rTpfoQIhWXCj3rZtesJ+2AdXb5ahmP5prd4jB0AYLh3NgAdVq5H+
         ylbhAPMSaH7qHPuZngn2t+84ACjYJ0NcNLmG7aQqQq68eHD5yzZFZtTtY//lEdLqaTCG
         tpEoKsSnAWMGYb5Q28u6xx+ExueNJn35EuVz27wpcOLvyDaOQvhLX53IAEDRu1arWLrd
         viAg==
X-Gm-Message-State: AOJu0Yw5Ei2BYtysmaiqw0tbHeUE/VAuQVL94BDfx+2Xtw3IEDc1elrc
	IJ+RJnppeDQk12ySbw/UOeyOwx3yz27VR5NymJke4Mfncg/05E6kjX1m7/IH2w==
X-Gm-Gg: AY/fxX4TdLu8xMX1A8hPENPYNKFRh/VGDOgS2OabMC3Is+dQBUpWmLl78GRvS8oVXLQ
	9L/m0Rxh3F74qWpyM27vMfmlT/0FI32oMWiWHJqHk1Fvppx4mleYLDKYLgsFx26hccvK8+ur4p9
	TtEsl73IYiIo30cZlCOpeEMRuaO3NGKlpRXRtNk6DY3QuxbGkTPCBB1xvSjPq0Fy9cL6ce+I0s7
	kFybnYB+6UCBJ6Pi7lsMVUL3s1Dd1cUnqZaxvsw8ZLA8cGL2FyAvsKct+kqlLh5EQDPYlaY74io
	8MEXLRJzj08BWhzGV/jSVW1D5g75F5L7TvPAfg1h5ATkrFCIB2MzqYL8ONsJrp/k46sqek3/9ME
	MHE74V/BAxSaNWc57kGMB198cQw2jYc3vvfip0pv+ZwbSDoH8g8wdvOIl/0XqueTcea+c9BlS1T
	PzHNa4dwy7k8az02VY
X-Received: by 2002:a05:7301:4196:b0:2b0:4fcc:4c69 with SMTP id 5a478bee46e88-2b6b3efe920mr6518601eec.16.1768716957727;
        Sat, 17 Jan 2026 22:15:57 -0800 (PST)
Received: from pop-os.. ([2601:647:6802:dbc0:8fdd:4695:1309:5b93])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b3502c65sm8163816eec.8.2026.01.17.22.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 22:15:56 -0800 (PST)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: Cong Wang <xiyou.wangcong@gmail.com>,
	Xiang Mei <xmei5@asu.edu>,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [Patch net v8 1/9] net_sched: Check the return value of qfq_choose_next_agg()
Date: Sat, 17 Jan 2026 22:15:07 -0800
Message-Id: <20260118061515.930322-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
References: <20260118061515.930322-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

qfq_choose_next_agg() could return NULL so its return value should be
properly checked unless NULL is acceptable.

There are two cases we need to deal with:

1) q->in_serv_agg, which is okay with NULL since it is either checked or
   just compared with other pointer without dereferencing. In fact, it
   is even intentionally set to NULL in one of the cases.

2) in_serv_agg, which is a temporary local variable, which is not okay
   with NULL, since it is dereferenced immediately, hence must be checked.

This fix corrects one of the 2nd cases, and leaving the 1st case as they are.

Although this bug is triggered with the netem duplicate change, the root
cause is still within qfq qdisc.

Fixes: 462dbc9101ac ("pkt_sched: QFQ Plus: fair-queueing service at DRR cost")
Reviewed-by: Xiang Mei <xmei5@asu.edu>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_qfq.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 9d59090bbe93..4b963b6b041e 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1147,6 +1147,8 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 		 * choose the new aggregate to serve.
 		 */
 		in_serv_agg = q->in_serv_agg = qfq_choose_next_agg(q);
+		if (!in_serv_agg)
+			return NULL;
 		skb = qfq_peek_skb(in_serv_agg, &cl, &len);
 	}
 	if (!skb)
-- 
2.34.1


