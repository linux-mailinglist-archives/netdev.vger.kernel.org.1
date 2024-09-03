Return-Path: <netdev+bounces-124622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1531B96A3C4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 18:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55320B213AB
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C379318953E;
	Tue,  3 Sep 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cP3pd9aJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B61F189BAE
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379784; cv=none; b=EQne2EU987BGMpc6sglOz17wlxKarqv0HK24pAnroUVIe2vOe5wMvMrVXtnolN2AbrMDvAej/vCgxGCWVtEh7rUl9LicjQoTPCdo2B8Fi/0Lla7K6RNqA1KUiPdBmN6fBYj/g7ivbGIids8plj5pH9L/xqCDelfsO2qmMLFp9Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379784; c=relaxed/simple;
	bh=2JAIWCNARORnR5nwbT0e9zqPb925Y4igEhQKyQG1FaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kKn8FUfNjMQeR1ZresKf2ZRaktR/dkB3B5cCRJHqSKNCOXFCDvmfuAyVvYeQgHtqOwoUKsmarHCbHMa9LoF1qScdoQBIBNgZp5mEua6DBl0wN5v22EgfarHKnnY/t/wwGovIcifxurfS2BL99DuhIPheByuyBP0naueQ+WxjMzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cP3pd9aJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725379782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+vEL9t9N3TjzDKFfGVpcEH/htsU0bsy4GSN4Thmrm6E=;
	b=cP3pd9aJDW/O/0jFVRgCDC2edcxmr9S43vrFrwpi1IOUpN4FzhSYXEUmBwPzFRI5eh5iLc
	UE3rclVdQUbtZ+EVtfg9Rybj3h3oj843ik9Ms4RxsQ8xA4nWom+QHjtXZCKM+qsT5somrc
	UsjrzhRfRjBaArcvwbWJVAfPyuTJoZk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-CkBYjhVLNeGkCf0MolSgTw-1; Tue, 03 Sep 2024 12:09:41 -0400
X-MC-Unique: CkBYjhVLNeGkCf0MolSgTw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f3f6d581fbso63052891fa.1
        for <netdev@vger.kernel.org>; Tue, 03 Sep 2024 09:09:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725379779; x=1725984579;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+vEL9t9N3TjzDKFfGVpcEH/htsU0bsy4GSN4Thmrm6E=;
        b=hnizZOUMD8v1e8VQCqjmKPEJZlCwg0rBP6pQI+4vixf1Yc/PTPd8ND98EduowKAxRP
         Ytg9g6dtgr+sXZv3+YT3qf49Md2PpTt6sE9fCFsgGri/Kpc4HDRvB4CsTq/eqMtcNJMH
         wvRq8c0mNLUU3pfTTMqThzrSU/vjB91f2JGc4n/uTJwn0EoANKBXsBjP6XDJf4WZW5lj
         tIeExJxsfwaz7eXm9JmBTYvLCT5GBjq8ISXroJESo2eb3RTMIQe0BdymcXIItcPeAMQO
         R8ejvkHFGcjjRcXJB4tXay3UtVvO33v1z3Y/TFInBvXgTvpK+uyO6tmYMVLAcjSD1L3N
         PKww==
X-Forwarded-Encrypted: i=1; AJvYcCXAKCaAdMQWHbbbsWA1m432+OlBdp72r7LNsGx0/ZeYmcRrOoOHtz4JDQiHr/tRfjyvWRjd3xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYuD285GcyHXb1P4LM+3H6f68F3ZTo/lurhFX53rsUR1RzN6Cm
	rrUypxI/HkpQJ3TgV8GyMsOUh5UsBhl7AYQvh2kTtdI+CfhR8MQD1GndeEc2TeFNmm761JPDwXo
	GSm2XIXslxc+2Xya5Azx+8QuOfhLPzC3JV3iIW7suojoKvzpEa/rwAQ==
X-Received: by 2002:a05:651c:19a3:b0:2ef:c8a1:ff4 with SMTP id 38308e7fff4ca-2f6105c49a9mr156218281fa.7.1725379779286;
        Tue, 03 Sep 2024 09:09:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM6IKnpjCa0SnPQDJqUDSYbdjdv3ACYWXRRNarHq2mh9lv5GtfRZskmFFlzTcDySivB4h63w==
X-Received: by 2002:a05:651c:19a3:b0:2ef:c8a1:ff4 with SMTP id 38308e7fff4ca-2f6105c49a9mr156217921fa.7.1725379778590;
        Tue, 03 Sep 2024 09:09:38 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8989233403sm696395866b.212.2024.09.03.09.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 09:09:38 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id DA5BA14AE5EC; Tue, 03 Sep 2024 18:09:36 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	George Amanakis <gamanakis@gmail.com>,
	"David S. Miller" <davem@davemloft.net>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	syzbot+7fe7b81d602cc1e6b94d@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org
Subject: [PATCH net] sched: sch_cake: fix bulk flow accounting logic for host fairness
Date: Tue,  3 Sep 2024 18:08:45 +0200
Message-ID: <20240903160846.20909-1-toke@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In sch_cake, we keep track of the count of active bulk flows per host,
when running in dst/src host fairness mode, which is used as the
round-robin weight when iterating through flows. The count of active
bulk flows is updated whenever a flow changes state.

This has a peculiar interaction with the hash collision handling: when a
hash collision occurs (after the set-associative hashing), the state of
the hash bucket is simply updated to match the new packet that collided,
and if host fairness is enabled, that also means assigning new per-host
state to the flow. For this reason, the bulk flow counters of the
host(s) assigned to the flow are decremented, before new state is
assigned (and the counters, which may not belong to the same host
anymore, are incremented again).

Back when this code was introduced, the host fairness mode was always
enabled, so the decrement was unconditional. When the configuration
flags were introduced the *increment* was made conditional, but
the *decrement* was not. Which of course can lead to a spurious
decrement (and associated wrap-around to U16_MAX).

AFAICT, when host fairness is disabled, the decrement and wrap-around
happens as soon as a hash collision occurs (which is not that common in
itself, due to the set-associative hashing). However, in most cases this
is harmless, as the value is only used when host fairness mode is
enabled. So in order to trigger an array overflow, sch_cake has to first
be configured with host fairness disabled, and while running in this
mode, a hash collision has to occur to cause the overflow. Then, the
qdisc has to be reconfigured to enable host fairness, which leads to the
array out-of-bounds because the wrapped-around value is retained and
used as an array index. It seems that syzbot managed to trigger this,
which is quite impressive in its own right.

This patch fixes the issue by introducing the same conditional check on
decrement as is used on increment.

The original bug predates the upstreaming of cake, but the commit listed
in the Fixes tag touched that code, meaning that this patch won't apply
before that.

Fixes: 712639929912 ("sch_cake: Make the dual modes fairer")
Reported-by: syzbot+7fe7b81d602cc1e6b94d@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/sched/sch_cake.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 9602dafe32e6..d2f49db70523 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -786,12 +786,15 @@ static u32 cake_hash(struct cake_tin_data *q, const struct sk_buff *skb,
 		 * queue, accept the collision, update the host tags.
 		 */
 		q->way_collisions++;
-		if (q->flows[outer_hash + k].set == CAKE_SET_BULK) {
-			q->hosts[q->flows[reduced_hash].srchost].srchost_bulk_flow_count--;
-			q->hosts[q->flows[reduced_hash].dsthost].dsthost_bulk_flow_count--;
-		}
 		allocate_src = cake_dsrc(flow_mode);
 		allocate_dst = cake_ddst(flow_mode);
+
+		if (q->flows[outer_hash + k].set == CAKE_SET_BULK) {
+			if (allocate_src)
+				q->hosts[q->flows[reduced_hash].srchost].srchost_bulk_flow_count--;
+			if (allocate_dst)
+				q->hosts[q->flows[reduced_hash].dsthost].dsthost_bulk_flow_count--;
+		}
 found:
 		/* reserve queue for future packets in same flow */
 		reduced_hash = outer_hash + k;
-- 
2.46.0


