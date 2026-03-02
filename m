Return-Path: <netdev+bounces-262780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WEt0FcrTpWmvHAAAu9opvQ
	(envelope-from <netdev+bounces-262780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 19:15:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2751DE4F8
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 19:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8496A307CEBA
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 18:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6254C3431E6;
	Mon,  2 Mar 2026 18:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KpnsfrZi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1053B337BA1
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772475285; cv=none; b=rBRyNVLjaLonUOeSm6CB9uLlCJxd0xlttbZt6ZG5U9lcTT5k2WkWmirpWje09PzzWTIztSlId8qe12/3pBbahlUPnvDxOUyxh7BSsxca8J9jCekKvLeaJgMBjZ512gDlFwO6sKm7cUoBQRUOSNaexVdpuyYIst0pLbhiTh/BPnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772475285; c=relaxed/simple;
	bh=IuxMZBMFrqobeGcVZuf94rOyX+J7U6+ehb2d0jQE/ls=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WsuLp5YPBfcubXRIPc/3dLXfkRtUn30dfx1ptNDHbCh8brZ1ggMnCbX2DpOCWOtdlvzh4RbZKWZJdvVcgB9efvZTcGhoEqCcYWb2379nBSpvz8QyyQk+Qss4yssuTJvmtnpiSzQII/ajFfNceQLCmjgBvbL7khs/MCwypF4n1d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KpnsfrZi; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cbb8040f48so3966425385a.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 10:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772475283; x=1773080083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=m5b1vChdq4tLYF4yAE3zvofZaEJCeckIri/kTwraU9E=;
        b=KpnsfrZiYqyagSyQ8SuOM+1+pRnbnXtfGH4TZrbCVMwGE5Crbqsr+p+plpMXYHX5te
         QEpQKLEW0N04po2MYtctiOwENJUnoAdJmmK9B0fRRM6rgDq2t/bVViD6OtvfUJhxUqFG
         dMaoo/xxNco4Cqcv/woAE61y7Qh8ym3Zpb8wVATJfIisEvSGmx0Y8o3ga2b6bN+y/aDM
         aXsqPzoCIxCEfdASkkndvdUtIHuTlvUVsrAVeudO30Em7+ikMLRXrgUDKiGzqJGVSqYa
         kqLM+SzGsI4ShvsoulqE9TioNHtfZG5XNPIekNZK/2ZeeV0j34skTepMDIYCzUmzmMS+
         x1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772475283; x=1773080083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m5b1vChdq4tLYF4yAE3zvofZaEJCeckIri/kTwraU9E=;
        b=NUxm7gDiggR7mlsVJEKj5Ph9iAIbwyXF/RelgMR954/VLd/wOxV2Yend0Qmz6QQUWt
         ro/3mFwpJ6pn7OsNGlp4alvVW5Is6zPKkqgK4o2xraX2DVztmqVyVDPAFAnVhRCGd3Qp
         IX9W9RhbPIVD1LF3uzMCWW4T9DmMxJeApQ5xFRj9qUygetIbKHmTWAy4oKS3Gn8kIn7g
         Ui2h+62Ed+GUQxqPSiUDN2/vVlOtfHpsJeK4X6SqLIbG8PCKAqekQrk0QrJ5DdUkzZvE
         N2gTJeWzeVYjlD1ogAE4L3YWgEer7Xo+Kh9MJsja8Thmvz70Ls5m+rCdEFdi/Z/r4YQV
         rWUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX67AubR+JvcpX/mj3WkUnGMRfrfPixW62sWhiDk3cHiKdzju55FtFsXDCrzwSQcufM9QGHW1o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzwul35KlHgJW7xxLuYAGVSes0L26K6ZWTn8YfgtSuyRKzNI2Y
	g/+IDi/l2+vUeUAuBCJJl0w3RQ1tOayML1ZfGRwdmUYE1rQep9yz03BbpMgz9HPszDS5PynJ0Cc
	4+XEf6vU8ibwWWA==
X-Received: from qknro12.prod.google.com ([2002:a05:620a:398c:b0:8c3:8900:223])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4409:b0:8c6:b425:4779 with SMTP id af79cd13be357-8cbc8dc28a6mr1552833385a.7.1772475282636;
 Mon, 02 Mar 2026 10:14:42 -0800 (PST)
Date: Mon,  2 Mar 2026 18:14:30 +0000
In-Reply-To: <20260302181432.1836150-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260302181432.1836150-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260302181432.1836150-6-edumazet@google.com>
Subject: [PATCH v3 net-next 5/7] net-sysfs: get rid of rps_dev_flow_lock
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CE2751DE4F8
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
	TAGGED_FROM(0.00)[bounces-262780-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
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


