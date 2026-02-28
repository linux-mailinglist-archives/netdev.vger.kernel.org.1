Return-Path: <netdev+bounces-262081-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGqJNGpuomkn3AQAu9opvQ
	(envelope-from <netdev+bounces-262081-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:26:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C90D1C042A
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 05:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D81A30936D4
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C20322B6F;
	Sat, 28 Feb 2026 04:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWZnhru3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C1E2D8DDF
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 04:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772252715; cv=none; b=mGd/UwToODTVxVYi7F8T3CpCgQt9Fk1B1RtBElRLRPguCi/EOYmAtozoBBTGhI4DzKekTrkD9wShQk2oo9xFcNDhSBmeBqukGtD3Q/m5lkrVvZxw6AjhCFMTJeG1+FdZjVadnqWx9cWUBo8jaOjlMn1/yoMHdh6tFDDrMwpy9e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772252715; c=relaxed/simple;
	bh=IuxMZBMFrqobeGcVZuf94rOyX+J7U6+ehb2d0jQE/ls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nGnsyjqUz9nzRm0HGyim93HZvnbUCRZv6aFo4taDSJgBbha6f5nJJHAnOuKxyHAhDZ2PzdYBacgZcBpUHwAERyS5HszQ6+nE1zaPKne67nTIGALUcjrxeLKpL3Yb/xWeuapsNcgzATPlv62HttPBl8iqTO/fSqFsSJAY2eKtBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lWZnhru3; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-5033c483b76so279786371cf.1
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 20:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772252713; x=1772857513; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5b1vChdq4tLYF4yAE3zvofZaEJCeckIri/kTwraU9E=;
        b=lWZnhru3wpxbEdoc6VLfVu+l2rdevQP2L/2XQFGhxjf7S1qGAWfMvC328Y34bHG+Y0
         kmFd0oHpWmEuiWthpJrzW2vZUJhxmgc86wmAML3htJYqaWKhSsyovh2h3QU8LnivDUig
         J5C7ZuMzNcyzYvk27GOR2OC7tVw+Gljbz0N3b4dyWclni/hdFHFCapOEoTE17mnv8Uw4
         O0Fw9uu+UYRQk8qAA0GMUeLDFiXk5W1/pCBjFnOME3j3naJrEv+xWalgAUZh+vjm65Gy
         yTJ8+PU3aRCMDuIOHSfP5ssr94cxd1pl/lCN0ysRbXQT1u9nPLWRiKU38D8Q4nlghjBc
         5+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772252713; x=1772857513;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5b1vChdq4tLYF4yAE3zvofZaEJCeckIri/kTwraU9E=;
        b=uR6bnzI5+WrrbGh20De5xqgX068GMG9HIoyoGZc0TeXvh70wH6BS4xCQWiRQWFaK7D
         8BZK1I+cVO41L2/Cm467+Drui97DHrRN6rRPTSlBikGt4OBxJTj5hM+IdO7Z8T/T9d7R
         u0DEfI7l8r5zUZf69QTcFJvoqjEPeoypPbre/p8lWoFIMSwiMQiLiQ8Eh5FpXKhD3tKd
         1WW6zOSHunPnwDUnu839QuteIuLwWIGOrSCAeM27dBXdNsnMoARv3uT1Ernmqst64blN
         ybqcF9V8GGQdzHk/2FxjVhLoQhDXkClxb4D+dYkVkChrRnzaXAe8DWYDDT41JwXCKDfO
         cZQg==
X-Forwarded-Encrypted: i=1; AJvYcCVQxA5/EXo/khDsXCMaWSvAF5Mez1SSePO8RbaENETgXIE8G5hzB64OGBjgw+JrnMqFdGfBZR4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNx0Yz8SujW7PCVTEWYjrKSd7DaVx3M7b7PF4L1+OSeMvMIjP4
	Dr0UzNe88O7Yylv9WzU7L27nEZETUEFvZ4StQKv+OF9spz9gaI6/DBu0oNbjJZIZ0bRIcZMeTEF
	/gTjsY3R9qZ4Xvg==
X-Received: from qtbfp6.prod.google.com ([2002:a05:622a:5086:b0:4ee:c07:cab7])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:1445:b0:506:6ec8:835 with SMTP id d75a77b69052e-507529bb500mr63712581cf.54.1772252713127;
 Fri, 27 Feb 2026 20:25:13 -0800 (PST)
Date: Sat, 28 Feb 2026 04:25:01 +0000
In-Reply-To: <20260228042503.3726451-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260228042503.3726451-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260228042503.3726451-6-edumazet@google.com>
Subject: [PATCH net-next 5/7] net-sysfs: get rid of rps_dev_flow_lock
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262081-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C90D1C042A
X-Rspamd-Action: no action

Use unrcu_pointer() and xchg() in store_rps_dev_flow_table_cnt()
instead of a dedicated spinlock.

Make a similar change in rx_queue_release(), so that both
functions use a similar construct and synchronization.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/net-sysfs.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index 07624b682b08b24da790d377f1deec4dc0a84269..52fcf7fa58a808e79c1a17c8719830bcfb7c1674 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1084,7 +1084,6 @@ static ssize_t store_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 {
 	unsigned long mask, count;
 	struct rps_dev_flow_table *table, *old_table;
-	static DEFINE_SPINLOCK(rps_dev_flow_lock);
 	int rc;
 
 	if (!capable(CAP_NET_ADMIN))
@@ -1128,11 +1127,8 @@ static ssize_t store_rps_dev_flow_table_cnt(struct netdev_rx_queue *queue,
 		table = NULL;
 	}
 
-	spin_lock(&rps_dev_flow_lock);
-	old_table = rcu_dereference_protected(queue->rps_flow_table,
-					      lockdep_is_held(&rps_dev_flow_lock));
-	rcu_assign_pointer(queue->rps_flow_table, table);
-	spin_unlock(&rps_dev_flow_lock);
+	old_table = unrcu_pointer(xchg(&queue->rps_flow_table,
+				       RCU_INITIALIZER(table)));
 
 	if (old_table)
 		call_rcu(&old_table->rcu, rps_dev_flow_table_release);
@@ -1161,8 +1157,8 @@ static void rx_queue_release(struct kobject *kobj)
 {
 	struct netdev_rx_queue *queue = to_rx_queue(kobj);
 #ifdef CONFIG_RPS
+	struct rps_dev_flow_table *old_table;
 	struct rps_map *map;
-	struct rps_dev_flow_table *flow_table;
 
 	map = rcu_dereference_protected(queue->rps_map, 1);
 	if (map) {
@@ -1170,11 +1166,9 @@ static void rx_queue_release(struct kobject *kobj)
 		kfree_rcu(map, rcu);
 	}
 
-	flow_table = rcu_dereference_protected(queue->rps_flow_table, 1);
-	if (flow_table) {
-		RCU_INIT_POINTER(queue->rps_flow_table, NULL);
-		call_rcu(&flow_table->rcu, rps_dev_flow_table_release);
-	}
+	old_table = unrcu_pointer(xchg(&queue->rps_flow_table, NULL));
+	if (old_table)
+		call_rcu(&old_table->rcu, rps_dev_flow_table_release);
 #endif
 
 	memset(kobj, 0, sizeof(*kobj));
-- 
2.53.0.473.g4a7958ca14-goog


