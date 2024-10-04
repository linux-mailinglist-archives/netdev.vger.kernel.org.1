Return-Path: <netdev+bounces-132254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 188B599122A
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D9031C233ED
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0845E13A3ED;
	Fri,  4 Oct 2024 22:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UXz9rCek"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5361014A4C6
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728079873; cv=none; b=ghSUc/zOZtj4TZLobNfolJzTbkThGjAZ7L+O6M0U39TQqmn+mHihugchRSGixH0U6jjIE6m3dKOqAhYKkm3m+pDfF2wbWHO/bvVZFKWV8mNS3yiKXPuUjz6jjZwS5KpN686zUNHlQOhQdI6OUiOvK5jGah8PsEqXXH0EPRhITEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728079873; c=relaxed/simple;
	bh=mLUMmSb9Y1gdkDF0wQvSbJiMfJhYyJOiFBrEo/GjiPg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NMbgfR3jPVEbOXZunL8Mb1dBpTfyIa/+aXOKOikBL5sdkRswVRTzFeTNmzjL08r/x34yH7TTPbErB/1Yt0ZNqrCuUGkyzp/TFc3mZ2186XJmsDHGFVhgjEMiK9YB7MvgopHL1WKq0LVZGfiWXgpIlLv3JHeU+/4LaoRObc3BAso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UXz9rCek; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728079873; x=1759615873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Lprp5NIa5ikKk/8JJHKe+pTa3FA10yW0FoWbbUxTSB4=;
  b=UXz9rCekwDttk2rFjLCnfoUQ302BORk7jwXd+ehbYMTpdoynAlERFkPN
   9sxW8a9CmZhUe8bZAuIITy2djhlreUWWIhMcn9o+q+2QdVznmGuB+Y/K9
   AQTjuCr5AIqug02Iw2lO09qCrLvida63ciK05fxZUiAnJmL58Qjd6YcJg
   c=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="663828824"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 22:11:10 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:42165]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.158:2525] with esmtp (Farcaster)
 id 7ef83698-bb1a-4561-adba-f671aaefe5e7; Fri, 4 Oct 2024 22:11:09 +0000 (UTC)
X-Farcaster-Flow-ID: 7ef83698-bb1a-4561-adba-f671aaefe5e7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 22:11:07 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 22:11:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 1/4] Revert "rtnetlink: add guard for RTNL"
Date: Fri, 4 Oct 2024 15:10:28 -0700
Message-ID: <20241004221031.77743-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241004221031.77743-1-kuniyu@amazon.com>
References: <20241004221031.77743-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This reverts commit 464eb03c4a7cfb32cb3324249193cf6bb5b35152.

Once we have a per-netns RTNL, we won't use guard(rtnl).

Also, there's no users for now.

  $ grep -rnI "guard(rtnl" || true
  $

Suggested-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/netdev/CANn89i+KoYzUH+VPLdGmLABYf5y4TW0hrM4UAeQQJ9AREty0iw@mail.gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
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


