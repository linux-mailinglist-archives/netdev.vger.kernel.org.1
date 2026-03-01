Return-Path: <netdev+bounces-262440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QM+sFqqCpGnOiwUAu9opvQ
	(envelope-from <netdev+bounces-262440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:17:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E17B51D110B
	for <lists+netdev@lfdr.de>; Sun, 01 Mar 2026 19:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A1DC0302BE9E
	for <lists+netdev@lfdr.de>; Sun,  1 Mar 2026 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5613382CD;
	Sun,  1 Mar 2026 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HyaD8kj+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3409D3370EC
	for <netdev@vger.kernel.org>; Sun,  1 Mar 2026 18:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772388909; cv=none; b=i1fYeI1A6wVHZdzEmMGdddTj4WEqbT407mjuLlPgcukKQfXbHYa9p2QSClTx+ZP82yEJhpcQHrxjIc/2KFOiqhx3JgCPo/rL3FHoxaYyMTTJ8Ij1aGWPrW2u4vWvD5AMfzgNbfGDE1HzcPOAhpftvpAZLz7D2/XXYBKTz1nlef0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772388909; c=relaxed/simple;
	bh=IuxMZBMFrqobeGcVZuf94rOyX+J7U6+ehb2d0jQE/ls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CgRFB8hVjXjTk+MxhnaUQ2yt5W5LQtM2b0GKjj2/KiLZc85/LsE1WhldsJN2zj9WH5TLD1RquCfL9GvZVGTMPSK2PCuQYLQst7yflwpvDcxHV3Th+9imsXfUt9qj/ghAVZ8zcbcYZQ+IMGNbiEI6k/DXnG77tqV2QAOUsq4cP7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HyaD8kj+; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50335bd75bdso411535721cf.0
        for <netdev@vger.kernel.org>; Sun, 01 Mar 2026 10:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772388907; x=1772993707; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5b1vChdq4tLYF4yAE3zvofZaEJCeckIri/kTwraU9E=;
        b=HyaD8kj+lmKC0QmxXHRGT9wGjeCW7/qxpfUX2x0V2rFYkxVgeaEBaZg5sbcKO8zh9W
         TIw/1kWV74bJbqzaXRGLbkh9T5HngKe2TVM2xrWadUOxWS4z69Pd00ydtQ/1zCR4rTGm
         Wn+kQmZbhHJc4jSbj+/COXssRcerbDcZbS8BUJuRAaLdOSVNWali5SfJF2hsxvarlSwd
         uuFBm/qknLFmlP/f+iEGM+QAkH24ZoGOFmm4i6j0glEMkd6mRIyplLDGLAUPOxcQtPdr
         ym12CUV4W/wHc0ENeJm77OODLQG8jBV5kEbM03HvrQ6TyuNHCEwfGMsWoXP1cHvGfDSY
         UT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772388907; x=1772993707;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5b1vChdq4tLYF4yAE3zvofZaEJCeckIri/kTwraU9E=;
        b=YGw24gg6qN3bxH5As8/zSzS86g90Vk2cloMh6aRpDLilUfe0YPu1Bdykfmeh3LEiqf
         FooJk0+cdYssGz/e1wkSB3GJlrxVufArLpPWbPcuvb7BjIErUBJJ34p0aVVjDwvxYIKu
         7M5jlH1fW2lT8ZTZ32sHc0YhtbZ9RWjE08UjtdXz1V9yGuBSGiALltTAUhkJASIIErys
         5gd4Q3KNtdqJhw9iJyCPLIAQmBls2HMkl6F3vWRRq4MCzCsmYCcDqZochxHRFt89SPhY
         p2TY/Ej0GqTgkKDCj/2DnzRGWKGT9wZWrVKp7eHpSIIK3q1nuTJ+oZqCIaBVTOfMv+cT
         4VpA==
X-Forwarded-Encrypted: i=1; AJvYcCU4dJ6wIlzA3hGSnu6NPPap82BjewrXkV0ZydosycRgIKO1lU8eIu8OkhsrNSxD08lKGK//1mY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWqzvM88mM1DWfNLrzwqJ3UAcPN2siLX32HIHVRwPWK62ZDs8N
	dT7mI/libl96NH01us6UnHd+35FnFauAZVz+LWXPcdcwbN3o7ywCVmQNM6WMz+xHbJp5s1kdYn4
	Ei4/7l4TnD+7qrw==
X-Received: from qtjk4.prod.google.com ([2002:ac8:1404:0:b0:506:45f9:29ec])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5712:0:b0:501:17e3:30bb with SMTP id d75a77b69052e-50752763898mr148226561cf.25.1772388906895;
 Sun, 01 Mar 2026 10:15:06 -0800 (PST)
Date: Sun,  1 Mar 2026 18:14:55 +0000
In-Reply-To: <20260301181457.3539105-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260301181457.3539105-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260301181457.3539105-6-edumazet@google.com>
Subject: [PATCH v2 net-next 5/7] net-sysfs: get rid of rps_dev_flow_lock
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
	TAGGED_FROM(0.00)[bounces-262440-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: E17B51D110B
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


