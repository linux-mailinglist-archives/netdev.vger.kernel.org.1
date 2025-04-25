Return-Path: <netdev+bounces-186160-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B2CA9D51F
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 00:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF779C78F4
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 22:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C55922FF33;
	Fri, 25 Apr 2025 22:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="mtlx22ED"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72544230BC0
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 22:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745618850; cv=none; b=uBOxsmJW6VrNbRlCIRNUu6S4amsf6R5p/vuGntjuDw9nkl3ZumfwcFFd169oOMy8a/gB8HPaYEvlbC1T/GN8Nt9UFyVqAg+a+y/WXgnXGp1c6lm7VGTri0FeIVYl0CWIWsiF25R7zaPZfe4nJAoUYyYNNDec7QmlDm441hie++g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745618850; c=relaxed/simple;
	bh=8QdK7uoD4v1V+aRsDPdMpFBviVdvxkSDS3Exwm2el0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k/w/ERi8BXV7rlAD2zVkhELtz3Wlhf2cah5m0PtmMg/3m4/xAOVhlpqxztcxjXhtOmqBhtrvTQmofM40wccMiSvFMyFE18lEKjDqiG2K76dxKBVnF5nkdcIsRKSfSrqsVBPu+r9kmKX6vLWC/EbymUV9Axy5xgtLi0f7gVZMKAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=mtlx22ED; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227b828de00so31094295ad.1
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 15:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1745618847; x=1746223647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EncjAhk6vhaYgxdT+qrwduXEae74yDL8WhC87Ano9hQ=;
        b=mtlx22EDzlfvWAZUZdgf6uQwqzaQNkXu25hKFGLVteD0vJcjJwkR/ZyiLOF8e0tgXq
         qMh1A+Sryp0dESM6cnvtdT+hrCFFo0e+oiuIIGZPyuqfZ/mCxexgEmaMDJJacS6+S7mq
         Q7ZNhGFFfLZfx7vF4zq3szOFT1KWfA07fRrXEYhC2+WKnDRxtLcoUbpcGIDhxoo1pcny
         5A3Kd+omxiZCf8GN2xAkk5K0jSu3AtRTifwds9CZTH3wYOHp0iRUuZeo4+LzXWyx+CI0
         /pCfJnqKAzinsEF7W2dPbPEdXh4LzX9Pm24S1B244zhQmcRD03I93AEBzzn8GDUKdk9a
         r2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745618847; x=1746223647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EncjAhk6vhaYgxdT+qrwduXEae74yDL8WhC87Ano9hQ=;
        b=cDOFm04SVBpyIirUPTGtEZOtjOjScXtn80ixY5VejfItDP80LSHB6w+97vKkd14zxa
         ZRR/EKHSqlQyeZ5E5MXnwUwWs0s7jtNKnKnOfDt/5GCqQRg4gsos3Egh/1aOubgoXDD/
         DpreRIH6eTamF0/W7h9S3ILV/2z32qn5BMhZsPzFnXymwYjGBqTrsuLjsWkzYQJTTiYY
         7vs6UP2FVErpiqXVSnRAjXtpxZBrpFF0fgU/CR9B4aga0jFVaSk46K5BcPWbA5Qp+x5Y
         QIgp80D+LC8ukLKpR31tESJzraCcnH+uN1Wsdbgzq6WXYudjiC/5Dx3vY7HzOez9lE5z
         I5sQ==
X-Gm-Message-State: AOJu0YxYqgw/M6iyPyePvDrbslDZDTZhbqlcxJRqcLFliVLyb8kNgdhn
	D/EaddZjHC4fgCXMOTg2gqzx1edulyiQPcKu+CGm4UuTOJMBl5vZq25DPcXwmnmhc+wBfBt4QsA
	=
X-Gm-Gg: ASbGncviwSbjFv49Vto7xcsFxl9WadeuokvoHG3SSTJbGUb1lyVyLFhmadpDmEzyyu8
	Unuysde1T0aRpn7I9c7H7cRzAHWyqxTxrtuZDnq8ovDRgyLKwXpyqzBdrqio920l71KQfOr8SWW
	Jey09E2APNQsXq+XRvNvWeRxmfBMvJNYyJVWMQ8QzcDmR0F7byM/bSy1JPXndHHPaI8TwtghV4c
	AAWBeeCUUbN70ISOFm9eQ1NpqOFQ99+Mvu4R9zo8rihrWsPC/YTEVsKydKtD9K/soI0MR5xq71f
	hI1qEFZSrn/bhmXAAps4dFj6SqpMKTRcTfJ3OrffNhh0thpggd/Q/w==
X-Google-Smtp-Source: AGHT+IHtLdE0re6Vje9IPEQi893urXQk41ZNXAjXfrvg/z1rPjK92t9B+WRoDasyd2trFzKNz8J3GA==
X-Received: by 2002:a17:902:ce0f:b0:223:50f0:b97 with SMTP id d9443c01a7336-22dbf742de5mr56753665ad.52.1745618847481;
        Fri, 25 Apr 2025 15:07:27 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f1:e2c0:73b:9a6c:c614:cc79:b1ba])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4dc3b7bsm37753185ad.100.2025.04.25.15.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Apr 2025 15:07:27 -0700 (PDT)
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
Subject: [PATCH net v3 3/5] net_sched: ets: Fix double list add in class with netem as child qdisc
Date: Fri, 25 Apr 2025 19:07:07 -0300
Message-ID: <20250425220710.3964791-4-victor@mojatatu.com>
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
In the case of ets, there won't be a UAF, but the code will add the same
classifier to the list twice, which will cause memory corruption.

In addition to checking for qlen being zero, this patch checks whether
the class was already added to the active_list (cl_is_active) before
doing the addition to cater for the reentrant case.

[1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/

Fixes: 37d9cf1a3ce3 ("sched: Fix detection of empty queues in child qdiscs")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_ets.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index c3bdeb14185b..2c069f0181c6 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -74,6 +74,11 @@ static const struct nla_policy ets_class_policy[TCA_ETS_MAX + 1] = {
 	[TCA_ETS_QUANTA_BAND] = { .type = NLA_U32 },
 };
 
+static bool cl_is_active(struct ets_class *cl)
+{
+	return !list_empty(&cl->alist);
+}
+
 static int ets_quantum_parse(struct Qdisc *sch, const struct nlattr *attr,
 			     unsigned int *quantum,
 			     struct netlink_ext_ack *extack)
@@ -416,7 +421,6 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	struct ets_sched *q = qdisc_priv(sch);
 	struct ets_class *cl;
 	int err = 0;
-	bool first;
 
 	cl = ets_classify(skb, sch, &err);
 	if (!cl) {
@@ -426,7 +430,6 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	first = !cl->qdisc->q.qlen;
 	err = qdisc_enqueue(skb, cl->qdisc, to_free);
 	if (unlikely(err != NET_XMIT_SUCCESS)) {
 		if (net_xmit_drop_count(err)) {
@@ -436,7 +439,7 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 	}
 
-	if (first && !ets_class_is_strict(q, cl)) {
+	if (!cl_is_active(cl) && !ets_class_is_strict(q, cl)) {
 		list_add_tail(&cl->alist, &q->active);
 		cl->deficit = cl->quantum;
 	}
-- 
2.34.1


