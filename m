Return-Path: <netdev+bounces-158450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8ABA11EB1
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D843D1603E2
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8951EEA56;
	Wed, 15 Jan 2025 09:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nEM67yj/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD071E7C31
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935022; cv=none; b=j+4kjz1+qvuTjgLY1NUtcTfMXGtkNlwXNwLUK6mYr1mYsSzIK6WORcj2xk+dgxqS00XBalZcNMlpChAT4C2ZtQddt0hNg2oJHGeGCT4Kfd76ScXnzrh6/4OzoeYW+sKxKe6wBKA2/JdNQuWd/iTWsG1KWXvCxpBQyG+r1wjXbU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935022; c=relaxed/simple;
	bh=iz/SPz7soug+gvSFvwr0hx1f9IKzObUg9KW4Cuy1aGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tx74Dlxz9LTz9YNnxHpH0ajOVI6xX3FCgb2yYSqKGX5QciOknzBkRGszKYGhm2H8DfmL90gTccBOZCRIig0c2oDfKPFBaxmR68NP+b3OLDXZVyDDnIIoFS6oABbKAKBw2msTModkhxySAOl5uDcezsAFy1f8A8LCy5OzNt1hmQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nEM67yj/; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736935022; x=1768471022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7tXawSgLV3EvdrwD2F7oURoNSzI/E8zx1rX6HoIJbhI=;
  b=nEM67yj/KIVMhYDYrmkfKdLtS2Em9/9GyN3OxY3OWmtZQanLUawJrf3r
   o4Xz2QLhpzGbiO3QqiB5YCePpATyYgPuDlSFGXXHqTcS5GJ1FezhKS+zP
   /fcsb4Bv/Dnz0G7cqA8kKZ6HSrm4Mu7l+bJQbTmnWZ++3kAAgK16f3wSd
   0=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="486122155"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 09:56:56 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:60379]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.27:2525] with esmtp (Farcaster)
 id 761e9bcf-c20d-4cff-b6ae-dc898a0822a2; Wed, 15 Jan 2025 09:56:55 +0000 (UTC)
X-Farcaster-Flow-ID: 761e9bcf-c20d-4cff-b6ae-dc898a0822a2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:56:55 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.2.246) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:56:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/3] dev: Remove devnet_rename_sem.
Date: Wed, 15 Jan 2025 18:55:44 +0900
Message-ID: <20250115095545.52709-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115095545.52709-1-kuniyu@amazon.com>
References: <20250115095545.52709-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

devnet_rename_sem is no longer used since commit
0840556e5a3a ("net: Protect dev->name by seqlock.").

Also, RTNL serialises dev_change_name().

Let's remove devnet_rename_sem.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 0237687d4a41..7d30129bf2a0 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -180,8 +180,6 @@ static DEFINE_SPINLOCK(napi_hash_lock);
 static unsigned int napi_gen_id = NR_CPUS;
 static DEFINE_READ_MOSTLY_HASHTABLE(napi_hash, 8);
 
-static DECLARE_RWSEM(devnet_rename_sem);
-
 static inline void dev_base_seq_inc(struct net *net)
 {
 	unsigned int val = net->dev_base_seq + 1;
@@ -1249,12 +1247,8 @@ int dev_change_name(struct net_device *dev, const char *newname)
 
 	net = dev_net(dev);
 
-	down_write(&devnet_rename_sem);
-
-	if (strncmp(newname, dev->name, IFNAMSIZ) == 0) {
-		up_write(&devnet_rename_sem);
+	if (!strncmp(newname, dev->name, IFNAMSIZ))
 		return 0;
-	}
 
 	memcpy(oldname, dev->name, IFNAMSIZ);
 
@@ -1262,10 +1256,8 @@ int dev_change_name(struct net_device *dev, const char *newname)
 	err = dev_get_valid_name(net, dev, newname);
 	write_sequnlock_bh(&netdev_rename_lock);
 
-	if (err < 0) {
-		up_write(&devnet_rename_sem);
+	if (err < 0)
 		return err;
-	}
 
 	if (oldname[0] && !strchr(oldname, '%'))
 		netdev_info(dev, "renamed from %s%s\n", oldname,
@@ -1281,12 +1273,9 @@ int dev_change_name(struct net_device *dev, const char *newname)
 		memcpy(dev->name, oldname, IFNAMSIZ);
 		write_sequnlock_bh(&netdev_rename_lock);
 		WRITE_ONCE(dev->name_assign_type, old_assign_type);
-		up_write(&devnet_rename_sem);
 		return ret;
 	}
 
-	up_write(&devnet_rename_sem);
-
 	netdev_adjacent_rename_links(dev, oldname);
 
 	netdev_name_node_del(dev->name_node);
@@ -1302,7 +1291,6 @@ int dev_change_name(struct net_device *dev, const char *newname)
 		/* err >= 0 after dev_alloc_name() or stores the first errno */
 		if (err >= 0) {
 			err = ret;
-			down_write(&devnet_rename_sem);
 			write_seqlock_bh(&netdev_rename_lock);
 			memcpy(dev->name, oldname, IFNAMSIZ);
 			write_sequnlock_bh(&netdev_rename_lock);
-- 
2.39.5 (Apple Git-154)


