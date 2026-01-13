Return-Path: <netdev+bounces-249468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C04DD198AA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF5683008F50
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8432128506A;
	Tue, 13 Jan 2026 14:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UZg4nc/N";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nigjGHDr"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEBC285072
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 14:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768314752; cv=none; b=FpnqfLy2A2Z+3HheXi2HfLuh8TW0y1RWqfB060zZurAqQD+3BeCyNO749bKV39NU2pOKhhWjPbrTRhTy3AsBB3N0G9cYd4yELVZFAtOmWDoUnkINWMgs6tOgAjORM4gl/SlsYQuKzb4gPd4WFABlvpL+EminDtDZxmGksP3jrOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768314752; c=relaxed/simple;
	bh=MfqKVHtv0vqzjMqznyO3Be6RMpXSTRkmeRmaH7eIsW8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pwU+nq/HIKQFhvxIeiKhXTseGwEsEzQ0z2QbYFivPSZxWR5rQOgVnC5Gn23EkZGxeT6ChwZnxcHP2dcDPO3CGJ6D3xxSm3Q/0w2eQu8qIBMsNAPdX/DmCt/TbtUTRK0FSk3mhCVSuGoWR7FB3UI27yOrHS1kzjOfvNoGGxBqd5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UZg4nc/N; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nigjGHDr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768314749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=dkuxnI9DAgtlkp1zs4xwDhM8bobKr8HeiWSG4uzIRZg=;
	b=UZg4nc/NhS5NTu8WUfR1v7ToFlfDFstTZJu+6EMWzTg1a05ehutvFWtro4ld/ZauDmqpbO
	mzo+fpiOstXWiEBm+LpTkfYSlW6RKlzvBrH+aUCtk8O6X1RU3kZe5hU0IXNQunsNWTQPk0
	q2mBCHoJw2DkViGUJiZHXIudx12YJnQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39--CWXTZd0NWqo6VT6FiweYA-1; Tue, 13 Jan 2026 09:32:24 -0500
X-MC-Unique: -CWXTZd0NWqo6VT6FiweYA-1
X-Mimecast-MFC-AGG-ID: -CWXTZd0NWqo6VT6FiweYA_1768314743
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8701175a88so209760566b.1
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 06:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768314743; x=1768919543; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dkuxnI9DAgtlkp1zs4xwDhM8bobKr8HeiWSG4uzIRZg=;
        b=nigjGHDriPOgdQndt4nLsIae0X3p3G+YdTu/90CkfXT9gHTouPYUJJYewlrygnbbm2
         hjkvcgDZYiGoc1irBJ9GVyrAJscK5gSgqOKRr9eNvfFvHBAx0OZDKAYIk1EMIjIIXRLC
         9X1oD2tEEuBhcXpEP2XjkQUmjF1LVHQ6+6NHm2tbeptlRLXyxxWrSRVJIfI6q3+QIUhO
         XS6sJ+A+6WV2suBbhA0zwGJtGOZeJJf5LigirQ1L+lfzLl0Wdh6s/AHqcBIwxzC++V++
         C6ZUwEgRYtnFggKeiASSWbg7LMx2kXHn/paYOfoITtDV93y2+VQMDQEitGH9vkx9LfC6
         otFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768314743; x=1768919543;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkuxnI9DAgtlkp1zs4xwDhM8bobKr8HeiWSG4uzIRZg=;
        b=gyt8ZqmFCk9kB9aILCEnj2R1VneznqtZfmr2XFA4YvPSkZtWaQBbI4gUZ4DE89w0uy
         QxOGUt0S+XRzlQZofjlTsX2P23jMonRWarFuEmM5ViNAg8ntfvj+6lQ48HcCuDvRe6yt
         Ms3cunrRQSsZ6Xz97EFSeMS29tvhoRgMlMGW8fokGTzZqu4fhVH1X/OdFjFqzS8JU/b5
         fpSBBTDqkoAMW5b17mQGftB/Gd9K4Ckqo3vfspFTgMhIQMXpqGSqxSCigXFem/Os+Cnz
         BVVujciX2NnWfFlXDJj+jGNI/tY5VIUf5/gTj6M7uAY3OMbv+912acHKiqL2UoulY+TU
         o7xQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVv7Q6VHWaQXBwv6tV53V+itHBD9Mtc8MU4hObdN3hOa+/weONJGC5xiqweuNBGTJotrNRAq8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyegjSfWyPP9LapksaaOS9txmK7E6fm4ZjRfgVh4+X3+HfSKi56
	/DHLscOp515g5+ntnT9vlJ4zvqTYq2W5SVB2flG1f7qXWG7FVVjhZQFx9YA3E/hZZLEXKihIhrp
	4Ze+pTw/sFa+KUmwYiO5rbYuxCLWDo7X73AyDdPKeefSdEsbTKkFLl6s1Bw==
X-Gm-Gg: AY/fxX4L7vl6CuSJia959JU2olTcX6FkKNW5NppuUyzjE1c/ZcDfYIElc8tZ8UqjvHP
	nXQgs8eFcZPOkAI/nMUC8yUb9bmfhJHFvoS+zfZylAgNI4ko30i5T3AUGqmTHoqsKdl7y4j9Jvy
	sUERYPfJdA5YOzMbLSj9YamXHo5zKQkr1B18w9owQ73QCopFqNh9jfRE4gZme5vi7eJr2yjfpjw
	dUCY6ew8i/XSS401tMhsURD+O2Q1oUtsiY6pY6F7qcsuagjRAoaoSQC6WIBmiMJh0J5E9qQqkkC
	rovE7lS49QcPyoorUqJ+Tzsg0WnGyFYvZWSf1/MXmjmvRTrWujaaeIKSM8zWUbIGXKhXn+blWuq
	bEUu4CUGtqb70HfNNNfKuA+vWJk1fzGlumsfJ
X-Received: by 2002:a17:907:1b1d:b0:b73:6c97:af4b with SMTP id a640c23a62f3a-b84453eb56amr2069034866b.45.1768314742852;
        Tue, 13 Jan 2026 06:32:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB+MEceAg42yKB6X3GnjXTXcTjic7cEQBXwGrKiPhtu7WnQmtOEtd433LcjlYixKzqnjazwg==
X-Received: by 2002:a17:907:1b1d:b0:b73:6c97:af4b with SMTP id a640c23a62f3a-b84453eb56amr2069032066b.45.1768314742303;
        Tue, 13 Jan 2026 06:32:22 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b86f0d6d7c6sm1037956666b.42.2026.01.13.06.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:32:21 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 739F240894F; Tue, 13 Jan 2026 15:32:18 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net/sched: cake: avoid separate allocation of struct cake_sched_config
Date: Tue, 13 Jan 2026 15:31:56 +0100
Message-ID: <20260113143157.2581680-1-toke@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Paolo pointed out that we can avoid separately allocating struct
cake_sched_config even in the non-mq case, by embedding it into struct
cake_sched_data. This reduces the complexity of the logic that swaps the
pointers and frees the old value, at the cost of adding 56 bytes to the
latter. Since cake_sched_data is already almost 17k bytes, this seems
like a reasonable tradeoff.

Suggested-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/sch_cake.c | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index e30ef7f8ee68..fd56b7d88301 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -221,6 +221,7 @@ struct cake_sched_data {
 	struct tcf_block *block;
 	struct cake_tin_data *tins;
 	struct cake_sched_config *config;
+	struct cake_sched_config initial_config;
 
 	struct cake_heap_entry overflow_heap[CAKE_QUEUES * CAKE_MAX_TINS];
 
@@ -2798,8 +2799,6 @@ static void cake_destroy(struct Qdisc *sch)
 	qdisc_watchdog_cancel(&q->watchdog);
 	tcf_block_put(q->block);
 	kvfree(q->tins);
-	if (q->config && !q->config->is_shared)
-		kvfree(q->config);
 }
 
 static void cake_config_init(struct cake_sched_config *q, bool is_shared)
@@ -2822,13 +2821,9 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 		     struct netlink_ext_ack *extack)
 {
 	struct cake_sched_data *qd = qdisc_priv(sch);
-	struct cake_sched_config *q;
+	struct cake_sched_config *q = &qd->initial_config;
 	int i, j, err;
 
-	q = kzalloc(sizeof(*q), GFP_KERNEL);
-	if (!q)
-		return -ENOMEM;
-
 	cake_config_init(q, false);
 
 	sch->limit = 10240;
@@ -2842,14 +2837,13 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 
 	if (opt) {
 		err = cake_change(sch, opt, extack);
-
 		if (err)
-			goto err;
+			return err;
 	}
 
 	err = tcf_block_get(&qd->block, &qd->filter_list, sch, extack);
 	if (err)
-		goto err;
+		return err;
 
 	quantum_div[0] = ~0;
 	for (i = 1; i <= CAKE_QUEUES; i++)
@@ -2857,10 +2851,8 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 
 	qd->tins = kvcalloc(CAKE_MAX_TINS, sizeof(struct cake_tin_data),
 			    GFP_KERNEL);
-	if (!qd->tins) {
-		err = -ENOMEM;
-		goto err;
-	}
+	if (!qd->tins)
+		return -ENOMEM;
 
 	for (i = 0; i < CAKE_MAX_TINS; i++) {
 		struct cake_tin_data *b = qd->tins + i;
@@ -2893,22 +2885,13 @@ static int cake_init(struct Qdisc *sch, struct nlattr *opt,
 	qd->last_checked_active = 0;
 
 	return 0;
-err:
-	kvfree(qd->config);
-	qd->config = NULL;
-	return err;
 }
 
 static void cake_config_replace(struct Qdisc *sch, struct cake_sched_config *cfg)
 {
 	struct cake_sched_data *qd = qdisc_priv(sch);
-	struct cake_sched_config *q = qd->config;
 
 	qd->config = cfg;
-
-	if (!q->is_shared)
-		kvfree(q);
-
 	cake_reconfigure(sch);
 }
 
-- 
2.52.0


