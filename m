Return-Path: <netdev+bounces-203188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7DCCAF0B6A
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C54863B68CF
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 06:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB8F1D5CDE;
	Wed,  2 Jul 2025 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gdPkLedk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ABE1F582B
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 06:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751436963; cv=none; b=YV4x/Z+W2elHcK+UHkKPZeaxllNZQGVx8v9Gmr06beMmU3n6MfM5Ud6o/vyF2sqldhy/3Ajry0eaFJg4ka3TQS+bxgZ3dquLqjFHMv+tYf1c+n9x6sD6LP/wfReGNjc3FlJmq3KqZF9brAKYmKsGPBXXhJz7V3elK9lGzePfUXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751436963; c=relaxed/simple;
	bh=Hm/nU6tLNt5zkKUAlxx0eIRSVWZ7ar6TiAsZkKiQXZM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=KMs8SZL5IfxcYh+7xkY2F9Z9i/jA1ZK8hkT9goidGBkOWXUsgCu/ws0Po+7TsBTTDkUBLh8uC+TOgS3S/Q5WhOKiY5dwzddZD+9QYHcfnv0mh5Xecw/tXV4SPv1SvPLC2mzuMmVylbYMGPwaKsP0M2iaDsjXb3nnbupJJZvN2aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gdPkLedk; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6fd0a3f15daso222185896d6.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 23:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751436961; x=1752041761; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jPVLos0Vz2QmjAza5/vWenEa6RJrZBLhxm/CC+IHOGQ=;
        b=gdPkLedkjt2WNrpF990ks4BaxoTEocAE7RBLVCmiI20+/aWwdPOY0Wk0JBTQ6ZZhsS
         warYtx8pIaSy+eaOasVIFt9IpDVm/d14SrdEojtu7E8CCb5nBW6osFwuBqoKpGNnGVRF
         2Uw04BJQqwIEmjrgSI3Xe4pFaciHrQ+l3FKqch+XzeSYbf4kc5ZtaLl8nYYrRnzytpIb
         eU3mS4JS5KDvZ9wJgiJNO4W2xqX1lgyx/yMBVMjYtQ8HRKxi7NiYSF+Elu8b6XiDnMtY
         NVZNF4wqqslX7/USVQcHz2pu+E6k9bh69ACS/poXkIfVHGMBXwq+zPaqIgVqeQuWZo0c
         Pkgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751436961; x=1752041761;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jPVLos0Vz2QmjAza5/vWenEa6RJrZBLhxm/CC+IHOGQ=;
        b=ehnpMdiJnXiuLG4ep8UglksLZ/Lf36hd5dh1xD8ldqpFhKzZPZmBADu3/pfqpKSvno
         Vd3+DCHhqhG04hzamYS22P0Ib4y5Q3soeKpw5dFm1n0qHLRhgaqIgAAq8xDnVfbjRA/d
         ruj4QRahr/gni3WUIQSzDnUaBviBVhnTBes+YK6mBswfWIR/5TSSyNO7kuyNKgjbMKV5
         WYwEiUpdGDfIhbyQ5XbCor6Bj7FieYTwMFLTnlhZf/U0USScrsx0C6rjP4tzHDmji/XN
         ir2BhbMmU0ZJwjwf71ahEbDDomBcdiL99UybDAuZvTOLnOMC8M0uKvbfoFMwzjOJwIoT
         W8vw==
X-Forwarded-Encrypted: i=1; AJvYcCXPVVlEtuIw4ZsndoMCp5mcp6NrslZTXvyn/Kfqn9TrJfAWF4MzqdlqjF7SGpvdh/efM9bQ7vk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4YLKYsZLT5vozmgnYJP0DS2sfv7pa0D53IHhInpD4DFZprEmT
	txyaN5Pk8UsxQEZ+Av4B0JIu+RaDlidSdE4n046R0BRO+juJhbDq7GPaxYYiCFakhssmNFgBoTe
	iXXZNizE5W8gXoA==
X-Google-Smtp-Source: AGHT+IFNZ19N+ZGt6M1bZAJz4/5Md3oy7nQ5FDf/jnWIg2LnYdInvwFJ3o3wp45aKt5MI2K4Ir9c7Mz+b7LD1A==
X-Received: from qvc21.prod.google.com ([2002:a05:6214:8115:b0:702:b0c0:3ab8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1bcb:b0:700:fe38:6bd8 with SMTP id 6a1803df08f44-702b1b6eb8emr20285516d6.19.1751436960766;
 Tue, 01 Jul 2025 23:16:00 -0700 (PDT)
Date: Wed,  2 Jul 2025 06:15:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250702061558.1585870-1-edumazet@google.com>
Subject: [PATCH v2 net-next] net: remove RTNL use for /proc/sys/net/core/rps_default_mask
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Content-Type: text/plain; charset="UTF-8"

Use a dedicated mutex instead.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
v2: addressed Jakub feedback
v1: https://lore.kernel.org/netdev/20250627130839.4082270-1-edumazet@google.com/

 net/core/net-sysfs.c       | 15 ++++++++++++---
 net/core/net-sysfs.h       |  2 ++
 net/core/sysctl_net_core.c | 37 ++++++++++++++-----------------------
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
index c9b96938639999ddc1fe52560e0ba2c4f1adff1f..8f897e2c8b4fe125a941f869709458830310169d 100644
--- a/net/core/net-sysfs.c
+++ b/net/core/net-sysfs.c
@@ -1210,12 +1210,21 @@ static int rx_queue_default_mask(struct net_device *dev,
 				 struct netdev_rx_queue *queue)
 {
 #if IS_ENABLED(CONFIG_RPS) && IS_ENABLED(CONFIG_SYSCTL)
-	struct cpumask *rps_default_mask = READ_ONCE(dev_net(dev)->core.rps_default_mask);
+	struct cpumask *rps_default_mask;
+	int res = 0;
 
+	mutex_lock(&rps_default_mask_mutex);
+
+	rps_default_mask = dev_net(dev)->core.rps_default_mask;
 	if (rps_default_mask && !cpumask_empty(rps_default_mask))
-		return netdev_rx_queue_set_rps_mask(queue, rps_default_mask);
-#endif
+		res = netdev_rx_queue_set_rps_mask(queue, rps_default_mask);
+
+	mutex_unlock(&rps_default_mask_mutex);
+
+	return res;
+#else
 	return 0;
+#endif
 }
 
 static int rx_queue_add_kobject(struct net_device *dev, int index)
diff --git a/net/core/net-sysfs.h b/net/core/net-sysfs.h
index 8a5b04c2699aaee13ccc3a5b1543eecd0fc10d29..e938f25e8e86f9dfd8f710a08922c4cabf662c2e 100644
--- a/net/core/net-sysfs.h
+++ b/net/core/net-sysfs.h
@@ -11,4 +11,6 @@ int netdev_queue_update_kobjects(struct net_device *net,
 int netdev_change_owner(struct net_device *, const struct net *net_old,
 			const struct net *net_new);
 
+extern struct mutex rps_default_mask_mutex;
+
 #endif
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 5dbb2c6f371defbf79d4581f9b6c1c3fb13fa9d9..8cf04b57ade1e0bf61ad4ac219ab4eccf638658a 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -28,6 +28,7 @@
 #include <net/rps.h>
 
 #include "dev.h"
+#include "net-sysfs.h"
 
 static int int_3600 = 3600;
 static int min_sndbuf = SOCK_MIN_SNDBUF;
@@ -96,50 +97,40 @@ static int dump_cpumask(void *buffer, size_t *lenp, loff_t *ppos,
 
 #ifdef CONFIG_RPS
 
-static struct cpumask *rps_default_mask_cow_alloc(struct net *net)
-{
-	struct cpumask *rps_default_mask;
-
-	if (net->core.rps_default_mask)
-		return net->core.rps_default_mask;
-
-	rps_default_mask = kzalloc(cpumask_size(), GFP_KERNEL);
-	if (!rps_default_mask)
-		return NULL;
-
-	/* pairs with READ_ONCE in rx_queue_default_mask() */
-	WRITE_ONCE(net->core.rps_default_mask, rps_default_mask);
-	return rps_default_mask;
-}
+DEFINE_MUTEX(rps_default_mask_mutex);
 
 static int rps_default_mask_sysctl(const struct ctl_table *table, int write,
 				   void *buffer, size_t *lenp, loff_t *ppos)
 {
 	struct net *net = (struct net *)table->data;
+	struct cpumask *mask;
 	int err = 0;
 
-	rtnl_lock();
+	mutex_lock(&rps_default_mask_mutex);
+	mask = net->core.rps_default_mask;
 	if (write) {
-		struct cpumask *rps_default_mask = rps_default_mask_cow_alloc(net);
-
+		if (!mask) {
+			mask = kzalloc(cpumask_size(), GFP_KERNEL);
+			net->core.rps_default_mask = mask;
+		}
 		err = -ENOMEM;
-		if (!rps_default_mask)
+		if (!mask)
 			goto done;
 
-		err = cpumask_parse(buffer, rps_default_mask);
+		err = cpumask_parse(buffer, mask);
 		if (err)
 			goto done;
 
-		err = rps_cpumask_housekeeping(rps_default_mask);
+		err = rps_cpumask_housekeeping(mask);
 		if (err)
 			goto done;
 	} else {
 		err = dump_cpumask(buffer, lenp, ppos,
-				   net->core.rps_default_mask ? : cpu_none_mask);
+				   mask ?: cpu_none_mask);
 	}
 
 done:
-	rtnl_unlock();
+	mutex_unlock(&rps_default_mask_mutex);
 	return err;
 }
 
-- 
2.50.0.727.gbf7dc18ff4-goog


