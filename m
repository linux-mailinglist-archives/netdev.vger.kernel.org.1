Return-Path: <netdev+bounces-227894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BABCBBB98B5
	for <lists+netdev@lfdr.de>; Sun, 05 Oct 2025 17:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 790EF4E0EE3
	for <lists+netdev@lfdr.de>; Sun,  5 Oct 2025 15:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF60528727C;
	Sun,  5 Oct 2025 15:08:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDC523CB;
	Sun,  5 Oct 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759676934; cv=none; b=cWU+XOqA7UbGkAfFSSpWkb9BapTsN8+KclC6gVDQuIxxAwhnDn9b4d1sfQdzGNJ5QJ2b4WaabTGQm0jr+El6PwMGD+KFY4cxWVV36ZtCo06n7Sj+qi9tW8ZV3ALQ0+W7atroHRoSn08O3rCrJkKOck1/uciCo7MU3Ab1hSrokfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759676934; c=relaxed/simple;
	bh=3quiIO5jYKlDA/ZOOrXmMOLZql0PdzXHlyQItCfidMo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eg+HUQacrui/y3VZFBPbpK37s+YiVXsGi54Pm4WgAe+8OkaQ6UJBLtbX5q0XahwEwriAU+66XmtDthWVZ2ohP5fG+arDegA20+A/3unYPxEdDglF0W+B4lE2kZcbSlZG11DL5D+GNnO7KxH4laRC7ooiHkRjZgGxq2KwQItmUIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: Fushuai Wang <wangfushuai@baidu.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <ast@kernel.org>,
	<martin.lau@kernel.org>, <houtao1@huawei.com>, <jkangas@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Fushuai Wang
	<wangfushuai@baidu.com>
Subject: [PATCH bpf-next] bpf: Use rcu_read_lock_dont_migrate() and and rcu_read_unlock_migrate()
Date: Sun, 5 Oct 2025 23:08:16 +0800
Message-ID: <20251005150816.38799-1-wangfushuai@baidu.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc12.internal.baidu.com (172.31.3.22) To
 bjkjy-exc17.internal.baidu.com (172.31.50.13)
X-FEAS-Client-IP: 172.31.50.13
X-FE-Policy-ID: 52:10:53:SYSTEM

Replace the combination of migrate_disable()/migrate_enable() and rcu_read_lock()/rcu_read_unlock()
with rcu_read_lock_dont_migrate()/rcu_read_unlock_migrate() in bpf_sk_storage.c.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 net/core/bpf_sk_storage.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 2e538399757f..bdb70cf89ae1 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -50,16 +50,14 @@ void bpf_sk_storage_free(struct sock *sk)
 {
 	struct bpf_local_storage *sk_storage;
 
-	migrate_disable();
-	rcu_read_lock();
+	rcu_read_lock_dont_migrate();
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
 	if (!sk_storage)
 		goto out;
 
 	bpf_local_storage_destroy(sk_storage);
 out:
-	rcu_read_unlock();
-	migrate_enable();
+	rcu_read_unlock_migrate();
 }
 
 static void bpf_sk_storage_map_free(struct bpf_map *map)
@@ -161,8 +159,7 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 
 	RCU_INIT_POINTER(newsk->sk_bpf_storage, NULL);
 
-	migrate_disable();
-	rcu_read_lock();
+	rcu_read_lock_dont_migrate();
 	sk_storage = rcu_dereference(sk->sk_bpf_storage);
 
 	if (!sk_storage || hlist_empty(&sk_storage->list))
@@ -213,9 +210,8 @@ int bpf_sk_storage_clone(const struct sock *sk, struct sock *newsk)
 	}
 
 out:
-	rcu_read_unlock();
-	migrate_enable();
 
+	rcu_read_unlock_migrate();
 	/* In case of an error, don't free anything explicitly here, the
 	 * caller is responsible to call bpf_sk_storage_free.
 	 */
-- 
2.36.1


