Return-Path: <netdev+bounces-262441-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHrXMMCCpGnOiwUAu9opvQ
	(envelope-from <netdev+bounces-262441-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:17:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3401C1D1112
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17CBF302F9A9
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 18:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ED03382CD;
	Sun,  1 Mar 2026 18:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kMN39a+5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F5632720C
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772388910; cv=none; b=eSIf5zXtgDFVSIwULdxOWFXdfDxTwQuxMcRYicI0ndcEuNZTd4/jWeLwhIQvhXnIMK3Dl0xtFG3Zc7/IHFCHoWPf6/A6HjxouDEkAN01gxqwo3xbZbH9/znSUi3mDuPQpWKaOcERGYYj965BXyKv3V3wK8OHl0SgRkYL7cgWLTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772388910; c=relaxed/simple;
	bh=i0s2jMnm3hYZngJv4K/QTbRjAuGsVclPA1pNuEwKiNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jZnJFQ8QTlV1Ovd9lyKRuacjVo74Oj/YMZn+yzuN/5pYRKKhdKYXWRm+ktM1y7pdiHaKspjH9ays39z+GzNBUyXh3dd1jiA9trNm83rTlVzgJxXw0WO4n7u1vKf8/FjKHdaM/ahA7jchiH49rHLJI29TBCooYDrZlboZTiokQm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kMN39a+5; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8c882774f0dso3074038785a.2
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 10:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772388908; x=1772993708; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVYacPiJSJO5cSbY5SOeRlsCxSqadtlsMm00j720Rbk=;
        b=kMN39a+52oi7Lh6ykg6l3gdy8lTIXR16yPQqcAvFHlhOVxEtYmhCTD46/Gg3/MU967
         HZLKAU8vywzD4tGyKueFFP0QZFHra+IOvul3NuyXXGga4Bb4vf84qgOwghXnUS19SYCj
         vPeBnkKpyvNL382MA23aHn6V3yfFw6fKfYVeGQ3OQxqr6rYwZTNeHOye8ukW6QJxyRB9
         q35lGJbCbkWJU9ZfCHCUmogiFhpd2Ask4zboSgutZZQz3Dp5TnlM5lDfMMj+52PVfrTI
         OJoPlZYGv5oxJ85j14yIDHsK8IVyo/m1RzJJT1FX9ATgSQbT+OfALrV5Ve6eeJmkn3Mf
         g5SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772388908; x=1772993708;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NVYacPiJSJO5cSbY5SOeRlsCxSqadtlsMm00j720Rbk=;
        b=rntQKgYhlS8SRCq3fOsID5HmPyDWelu8kOxaLzEK4gbzR34Or6S9ooNGXa3qnqWR/0
         JHzqucT45xniuYyltNtld3oOw2qFGa8xPmDskhS2PgUDlyizldY8VbT/70w9xL1T6f4c
         9+U/VtFcRcV7POrvxeo+ZCQFhaaGPAG4Gl9wUSjyXN524yBp0oj24xhiP3XqlsGLs6XA
         +v10cEjTY8zr6wrVZ8sg0IUHqLE+4p7MWuuAS7saAGXWwvTEJM30VxtfmQ93ihQhqrpH
         mR1EfnMlCJYI1KZJ3e0KjdcWoK9vBrmaiGNKHEqqXqxp8iRMdhkOnhJ2jO4Ax+nLmvvn
         PBLg==
X-Forwarded-Encrypted: i=1; AJvYcCVU/BMcLvgbkkX2CMTDJU8xnl36Q94eO4yCDohmW7D/EwctTC3ZpW08n4so6BbbZnU64p44lBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXz1BlIyRbBac0D8LJlCf/2pSU6dGS0B5nd7Hea71rXuKz+rKx
	DCNDQVMAOBOJhyIkG6Fh1LClVLS/sw0aHdUijSFhLjgMaRfd6l1Xwj2heYxC1foj0a/+oNDOsKy
	JCw07i5hZoC5MtQ==
X-Received: from qkbde5.prod.google.com ([2002:a05:620a:3705:b0:8cb:bdbd:fecd])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1aa8:b0:8b2:f26e:3220 with SMTP id af79cd13be357-8cbc8d72817mr1073813085a.8.1772388908414;
 Sun, 01 Mar 2026 10:15:08 -0800 (PST)
Date: Sun,  1 Mar 2026 18:14:56 +0000
In-Reply-To: <20260301181457.3539105-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260301181457.3539105-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260301181457.3539105-7-edumazet@google.com>
Subject: [PATCH v2 net-next 6/7] net-sysfs: remove rcu field from 'struct rps_dev_flow_table'
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262441-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3401C1D1112
X-Rspamd-Action: no action

Remove rps_dev_flow_table_release() in favor of kvfree_rcu_mightsleep().

In the following pach, we will remove "u8 @log" field
and 'struct rps_dev_flow_table' size will be a power-of-two.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/rps.h    |  1 -
 net/core/net-sysfs.c | 11 ++---------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/net/rps.h b/include/net/rps.h
index dee930d9dd38e0e975e78d938bc7adc96048b724..e900480e828b487c721b3ef392f4abb427ad442c 100644
--- a/include/net/rps.h
+++ b/include/net/rps.h
@@ -44,7 +44,6 @@ struct rps_dev_flow {
  */
 struct rps_dev_flow_table {
 	u8			log;
-	struct rcu_head		rcu;
 	struct rps_dev_flow	flows[];
 };
 #define RPS_DEV_FLOW_TABLE_SIZE(_num) (sizeof(struct rps_dev_flow_table) + \
diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 52fcf7fa58a808e79c1a17c8719830bcfb7c1674..fd6f81930bc6437957f32206c84db87ee242fede 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1072,13 +1072,6 @@ static ssize_t show_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 	return sysfs_emit(buf, "%lu\n", val);
 }
 
-static void rps_dev_flow_table_release(struct rcu_head *rcu)
-{
-	struct rps_dev_flow_table *table = container_of(rcu,
-	    struct rps_dev_flow_table, rcu);
-	vfree(table);
-}
-
 static ssize_t store_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 					    const char *buf, size_t len)
 {
@@ -1131,7 +1124,7 @@ static ssize_t store_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 				       RCU_INITIALIZER(table)));
 
 	if (old_table)
-		call_rcu(&old_table->rcu, rps_dev_flow_table_release);
+		kvfree_rcu_mightsleep(old_table);
 
 	return len;
 }
@@ -1168,7 +1161,7 @@ static void rx_queue_release(struct kobject *kobj)
 
 	old_table = unrcu_pointer(xchg(&queue->rps_flow_table, NULL));
 	if (old_table)
-		call_rcu(&old_table->rcu, rps_dev_flow_table_release);
+		kvfree_rcu_mightsleep(old_table);
 #endif
 
 	memset(kobj, 0, sizeof(*kobj));
-- 
2.53.0.473.g4a7958ca14-goog


