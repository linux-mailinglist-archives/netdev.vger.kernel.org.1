Return-Path: <netdev+bounces-165419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 458F3A31F44
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5F2188ACDE
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 06:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A1B1FCF55;
	Wed, 12 Feb 2025 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kjDV2SdR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECD021FCD1A
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 06:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342573; cv=none; b=AKsiLv8Qs9cVBuczWQxyy+IypqQwOq2E95MMEfPYsHRCKUVSg1Glru+W9YsP2/o528rRCAFfSkrplwD+MmmLKD9CY8JhWvY8eTnMHGjNDyAq/oDQkWWueENm6H61Tn+um+GRQWFC46GhbujVncllo+5TX/jZKjBfH4MagGetiDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342573; c=relaxed/simple;
	bh=V7ZR7uJgZtG1yLIPbOn1zlxlX1bIHI0cjLiVct8srrU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QZq1ycoo5RKCc5Cq4sbqKAyxC6NsfWqX6Jfal9bJdS14wqjzhPU6sL0tuUiw2VQyimu1Cqrk8x3NBmUAzxDmIckPyofx4YkKt3WrQKP/4aBgO6co7KIlahhotqulxpS5m1IbBdbDuiNM/IgBHqMFNuZkkVkxenfwnAAQs55q8Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kjDV2SdR; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739342573; x=1770878573;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+hhIvxy2uEPcR1i2bzY+SncfAJ73BVPOCfkwgVvtcbE=;
  b=kjDV2SdRGCMUXOIzYayfW/1gLRr05NX+WjyMpTKz3zPED/unmSFm6Jod
   5K9q8aigj3ltlmPe68MNXXRmZLOu1xqLh/DJhsBq2HPzNdM0jbIauSsrQ
   i+62ypWXhNKlN/tlU3DM2c54MPmLxIbYmInHXfhlppItMDyJMP/E0ot5r
   w=;
X-IronPort-AV: E=Sophos;i="6.13,279,1732579200"; 
   d="scan'208";a="461804627"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 06:42:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:7806]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.65:2525] with esmtp (Farcaster)
 id 560d50e7-18ed-4096-a5aa-d554c15aeb03; Wed, 12 Feb 2025 06:42:47 +0000 (UTC)
X-Farcaster-Flow-ID: 560d50e7-18ed-4096-a5aa-d554c15aeb03
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 06:42:47 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.86) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Feb 2025 06:42:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net 1/3] net: Add net_passive_inc() and net_passive_dec().
Date: Wed, 12 Feb 2025 15:42:04 +0900
Message-ID: <20250212064206.18159-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250212064206.18159-1-kuniyu@amazon.com>
References: <20250212064206.18159-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

net_drop_ns() is NULL when CONFIG_NET_NS is disabled.

The next patch introduces a function that increments
and decrements net->passive.

As a prep, let's rename and export net_free() to
net_passive_dec() and add net_passive_inc().

Suggested-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/netdev/CANn89i+oUCt2VGvrbrweniTendZFEh+nwS=uonc004-aPkWy-Q@mail.gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/net_namespace.h | 11 +++++++++++
 net/core/net_namespace.c    |  8 ++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 7ba1402ca779..f467a66abc6b 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -297,6 +297,7 @@ static inline int check_net(const struct net *net)
 }
 
 void net_drop_ns(void *);
+void net_passive_dec(struct net *net);
 
 #else
 
@@ -326,8 +327,18 @@ static inline int check_net(const struct net *net)
 }
 
 #define net_drop_ns NULL
+
+static inline void net_passive_dec(struct net *net)
+{
+	refcount_dec(&net->passive);
+}
 #endif
 
+static inline void net_passive_inc(struct net *net)
+{
+	refcount_inc(&net->passive);
+}
+
 /* Returns true if the netns initialization is completed successfully */
 static inline bool net_initialized(const struct net *net)
 {
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index cb39a12b2f82..4303f2a49262 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -464,7 +464,7 @@ static void net_complete_free(void)
 
 }
 
-static void net_free(struct net *net)
+void net_passive_dec(struct net *net)
 {
 	if (refcount_dec_and_test(&net->passive)) {
 		kfree(rcu_access_pointer(net->gen));
@@ -482,7 +482,7 @@ void net_drop_ns(void *p)
 	struct net *net = (struct net *)p;
 
 	if (net)
-		net_free(net);
+		net_passive_dec(net);
 }
 
 struct net *copy_net_ns(unsigned long flags,
@@ -523,7 +523,7 @@ struct net *copy_net_ns(unsigned long flags,
 		key_remove_domain(net->key_domain);
 #endif
 		put_user_ns(user_ns);
-		net_free(net);
+		net_passive_dec(net);
 dec_ucounts:
 		dec_net_namespaces(ucounts);
 		return ERR_PTR(rv);
@@ -672,7 +672,7 @@ static void cleanup_net(struct work_struct *work)
 		key_remove_domain(net->key_domain);
 #endif
 		put_user_ns(net->user_ns);
-		net_free(net);
+		net_passive_dec(net);
 	}
 	cleanup_net_task = NULL;
 }
-- 
2.39.5 (Apple Git-154)


