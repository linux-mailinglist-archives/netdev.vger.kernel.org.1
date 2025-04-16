Return-Path: <netdev+bounces-183226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79960A8B6BF
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B431B1905279
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 10:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732AB247298;
	Wed, 16 Apr 2025 10:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="qZ7SLIyu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A3E248869
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744799090; cv=none; b=mZBiEiyJDWyKNZUWSMfE+timC8I/JPAdaOrilueRj22r5JmFGS+/lzdLnB1PgsTESooYpGHQDMTbbJyBk95q5SlXckNoOrTpbw0N5m6VOb7AdsiZmSmzGJJYNZfWkdRpBEUQsb+X1H8Hm85R11NXh9pmCxDKZkHWQ+zK5bHCeBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744799090; c=relaxed/simple;
	bh=HKdT9C7x2YNQsFK1Qb8EDAr+x07HveeAegcxUMxhyew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScqYVFwAmiPYWIQF1qTbrlTjFZ8vtzwzcMmbSaN5tdOEbrjY/S59ajNei//Oa8PblP0M7ag3OBJPBxcX2vWoGhMX6X5w7U1/Hdmh6Z85ARoWkxAAKxcIlCLszGDDPCogrtcyOwV8UZ9jG2E67KnUkj8XeYr5l4hTfnz+SCPpesY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=qZ7SLIyu; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-226185948ffso69809215ad.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 03:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1744799088; x=1745403888; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XScvW62lTqsHAZZjpfgHq1RtWhakC6xCLet4pFaP59k=;
        b=qZ7SLIyu3pFqukTzYYROsXF5IztOmieUdFxNEYSLxTbse4Ni8u31IVQ8yftYwIQgWs
         wnSW6HIK2qAL/azYYAs4iZc0NA2yaOWUazvInbh5shgF63uKsgs7uhJBOa4+ArzSRsPv
         6lePE+39/T3HxqAXrXKnt89byscU/aEyov737POCj5gGfemDPeDKp6Vc3lFKY2IJWn71
         28ooR2ChdePX/bWeyQw68y/tSQ4i6w2Gzu4fqSqUz+1XKzA1idG2gbXKUFJ9nWBQSUYF
         q/TDlVnej6lsTXHI4gYrtKj1T8vGVLnTqdwdJENtHSlVGgRcur2nbjtG3UnXb69m4uXx
         C0BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744799088; x=1745403888;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XScvW62lTqsHAZZjpfgHq1RtWhakC6xCLet4pFaP59k=;
        b=PZRahEs+ShnmzYyirQ4jEEAdqapZK1WgaJj3yodd5IcwQp91ijqiqhqLdVn3MjC8FN
         b7OODVtbRW99ISDZh5IIjh3fGSxS0JuLlFAB2qdB9DeS7HpB48KR5ewfT21u72KldvML
         fb9Cce8B72pseHXxrdt6giK2cadMAtmxGKqnS1lrxVJi/a20GE8kUY7LlOMQmPAe+MkD
         EpnNkWzbtdezO3HkD7QDab/JVXyU/koEibBlj/MuuWcCMRdTopgjwwnOdQDzusSz0RRD
         bOwBA7UZRR/uhvGPVMJefTZfR9Did5dDgjHmsvzJFPQx+nZjQx1okYDhz11qDXGzS0lT
         tGJw==
X-Gm-Message-State: AOJu0Yz2b7042arT7OF7Go0k+iQd6X8aW1G0+bRQZIamY+ssAwkXm0k+
	TpqcSR+ygeBCECEtBxT1HxIBht8z3osGivniKGxK5A6N8ODVUWNro2nBdztX/zr1iEwFq56J5NQ
	=
X-Gm-Gg: ASbGncvUEvYb6FAlfS6zUVX7ou+k5BNU2XHMzN4yFnPdnWgDhNjGD6+61PaBnYuSqbJ
	LZYzWGmGV4vjsPTB/PSzpTZg05PtYKkXdvNu4Chk44OeiJf9X17v7AlAeLkVaPo38gxR6OUImKo
	/BqG8tVGX0Bl6844GjBRXT5Jz3RBFxcMIXsJm4/jEtpiMX9BYCbeyH1grLQH3oqL+QcMUMgICw7
	r5Gm5hA9ihpOIkDf0hb3Mte239SHx7XPB2UNfHpwkmTJyfKVTcdV/dAl7p0uWmhiLl2LIyjOzjy
	zojukGFRf97b9dC+wqVEgDiS2hM7NKurgiyD8tQt1z0dKc+0kfgxF1E3VE8JCz5P
X-Google-Smtp-Source: AGHT+IEklg/+LERHYyQKmGOvh0yTAJuQ7wjHaAOlKj/PKxlJVNBmzTnFRt9ViopH+u3PST2tc7Og0Q==
X-Received: by 2002:a17:90a:ab0e:b0:305:2d27:7c9f with SMTP id 98e67ed59e1d1-30863f2f5eemr1740840a91.16.1744799088200;
        Wed, 16 Apr 2025 03:24:48 -0700 (PDT)
Received: from exu-caveira.tail33bf8.ts.net ([2804:7f1:e2c3:dc7b:da12:1e53:d800:3508])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308613cb765sm1193075a91.43.2025.04.16.03.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 03:24:47 -0700 (PDT)
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
	pctammela@mojatatu.com
Subject: [PATCH net v2 4/5] net_sched: qfq: Fix double list add in class with netem as child qdisc
Date: Wed, 16 Apr 2025 07:24:26 -0300
Message-ID: <20250416102427.3219655-5-victor@mojatatu.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416102427.3219655-1-victor@mojatatu.com>
References: <20250416102427.3219655-1-victor@mojatatu.com>
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
list (cl_is_initialised) before doing the addition to cater for the
reentrant case.

[1] https://lore.kernel.org/netdev/CAHcdcOm+03OD2j6R0=YHKqmy=VgJ8xEOKuP6c7mSgnp-TEJJbw@mail.gmail.com/

Fixes: 37d9cf1a3ce3 ("sched: Fix detection of empty queues in child qdiscs")
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Victor Nogueira <victor@mojatatu.com>
---
 net/sched/sch_qfq.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 687a932eb9b2..b7767b105506 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -202,6 +202,11 @@ struct qfq_sched {
  */
 enum update_reason {enqueue, requeue};
 
+static bool cl_is_initialised(struct qfq_class *cl)
+{
+	return !list_empty(&cl->alist);
+}
+
 static struct qfq_class *qfq_find_class(struct Qdisc *sch, u32 classid)
 {
 	struct qfq_sched *q = qdisc_priv(sch);
@@ -1260,6 +1265,9 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		    == cl && cl->deficit < len)
 			list_move_tail(&cl->alist, &agg->active);
 
+		return err;
+	/* cater for reentrant call */
+	} else if (cl_is_initialised(cl)) {
 		return err;
 	}
 
-- 
2.34.1


