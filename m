Return-Path: <netdev+bounces-131261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5AFC98DEEB
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 17:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0FB7B2BC23
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 15:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B2C1D0792;
	Wed,  2 Oct 2024 15:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ejIsttcD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DDF1D0F71
	for <netdev@vger.kernel.org>; Wed,  2 Oct 2024 15:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727882008; cv=none; b=mAzkRTUT1UTu+jWvjh+puzX/H9J2x/m/GYYrSf7GCJlkykd3MZXpIACyZZB8yozO7jyc4AlSJ0gQ5aV+f+ot+HPVhELv8/t3URsmYBLsFcnFNzTc6RyvzKeAsesQ95nRlxg5XygX//3Wp+MZenO4ALFLJwfa32I3iF+B48MSeWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727882008; c=relaxed/simple;
	bh=l1sqcAhqEXtfHhIwx/aPS5eP/rmpt3YXCBbbgiyP4yM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E/E5uQVr2L3ZVG24z5miuINoVQT8j0FVa2yiw+mS1le8hz0XGuCuiwMt9nZaORTj5DCgy11Mm/fOAmYcf8bO2ovpRM2yw6adRYiaWbB7ciHjPaukvlJ5pQ5e1BrrZmduT8mlpzSENajU36MJEjR+JPURZ28jmPDggxmG40QGOF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ejIsttcD; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727882006; x=1759418006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ih6fQXpNZmVx0N2TvH1VLVWRNFDKQZz1DJ/oXU45KXE=;
  b=ejIsttcDMhd6eQlBRUbP+Y/nilAyyo7Bndd4EExG/Q+aDOAVaU+EX0p1
   +j+osHM0wL4UHqj0qo4MJ7QwgzEknjPX4+avhizXnAE2n47tmKwkXJXxP
   FFS/ZSMgHJW19MlHYmvUknx2AM+uXa+4xNUs0TCkckFz8ymACuQpnZwp8
   I=;
X-IronPort-AV: E=Sophos;i="6.11,172,1725321600"; 
   d="scan'208";a="134191098"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 15:13:21 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:39538]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.107:2525] with esmtp (Farcaster)
 id 36674f2f-4583-4c08-b693-0a9a89b884aa; Wed, 2 Oct 2024 15:13:21 +0000 (UTC)
X-Farcaster-Flow-ID: 36674f2f-4583-4c08-b693-0a9a89b884aa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 2 Oct 2024 15:13:18 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 2 Oct 2024 15:13:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 1/4] Revert "rtnetlink: add guard for RTNL"
Date: Wed, 2 Oct 2024 08:12:37 -0700
Message-ID: <20241002151240.49813-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241002151240.49813-1-kuniyu@amazon.com>
References: <20241002151240.49813-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This reverts commit 464eb03c4a7cfb32cb3324249193cf6bb5b35152.

Once we have a per-netns RTNL, we won't use guard(rtnl).

Also, there's no users for now.

  $ grep -rnI "guard(rtnl" || true
  $

Suggested-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/netdev/CANn89i+KoYzUH+VPLdGmLABYf5y4TW0hrM4UAeQQJ9AREty0iw@mail.gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/linux/rtnetlink.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index a7da7dfc06a2..cdfc897f1e3c 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -7,7 +7,6 @@
 #include <linux/netdevice.h>
 #include <linux/wait.h>
 #include <linux/refcount.h>
-#include <linux/cleanup.h>
 #include <uapi/linux/rtnetlink.h>
 
 extern int rtnetlink_send(struct sk_buff *skb, struct net *net, u32 pid, u32 group, int echo);
@@ -47,8 +46,6 @@ extern int rtnl_is_locked(void);
 extern int rtnl_lock_killable(void);
 extern bool refcount_dec_and_rtnl_lock(refcount_t *r);
 
-DEFINE_LOCK_GUARD_0(rtnl, rtnl_lock(), rtnl_unlock())
-
 extern wait_queue_head_t netdev_unregistering_wq;
 extern atomic_t dev_unreg_count;
 extern struct rw_semaphore pernet_ops_rwsem;
-- 
2.30.2


