Return-Path: <netdev+bounces-135313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FB599D81E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8C891C21668
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833B91D0DEB;
	Mon, 14 Oct 2024 20:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="or0Cg0bo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58DD1D0943
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728937338; cv=none; b=kENY0KyLO30K32Nir64jpMvo1s39owW0v9vpV9wPDKAnMYoxTmR3SsXAupS7lT41/hDY4fgP1C+AmERsw0zcdlYHCXKBL/bBkD3U1oSKY0wfNHLMFDf4tbpwwhmGM+2uQpucAwdkqM3rcVVt028csySMXhoOmkHNd6sTyQKHYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728937338; c=relaxed/simple;
	bh=LpOndllIAxcBG13ZYSNZuRr2zXqyl7X0RaEl/I/ku20=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WlPSUYzH/NPgRZ/iFFmNVDqIsu5QE26aazPH1QrW4W3Vfg9chulMKG2kVDWzdfPzg10NBNY2qAKMyopKmzZcbmNmdikYQ9KpDE2gYa/BoubqKKhR+w1m7lz2SadjDHD4CZjCVHvz/b4aAa5Bp+rDLctvmdwxV2pBWWkucdwBlrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=or0Cg0bo; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728937337; x=1760473337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8dwptSTJN0DiVuJVkYG/a9xZa+YOAOsdyYaD++ooLDc=;
  b=or0Cg0bo0fPtfrGgvEqh04lG8384LKmraAF8ObMZ6QUr8R2ekujf2ELy
   uiv6fFd0Ztcfj4kEp4SE15Qlj03HQq9qGKRiNYXTbB9zojxL/B4wGrCqZ
   J68CeryEe6nwceKPPZ8xW/OBcDu4BOYNNh2vLPfDNUDQjATFgTlyXkRXL
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="666112151"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:22:14 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:42129]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.5.202:2525] with esmtp (Farcaster)
 id 75084963-0824-4e83-8d93-a1b48f2f95bd; Mon, 14 Oct 2024 20:22:13 +0000 (UTC)
X-Farcaster-Flow-ID: 75084963-0824-4e83-8d93-a1b48f2f95bd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 20:22:13 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 20:22:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 11/11] rtnetlink: Remove rtnl_register() and rtnl_register_module().
Date: Mon, 14 Oct 2024 13:18:28 -0700
Message-ID: <20241014201828.91221-12-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014201828.91221-1-kuniyu@amazon.com>
References: <20241014201828.91221-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

No one uses rtnl_register() and rtnl_register_module().

Let's remove them.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/rtnetlink.h | 15 ++++++---
 net/core/rtnetlink.c    | 74 ++++++++++++-----------------------------
 2 files changed, 31 insertions(+), 58 deletions(-)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index 2d3eb7cb4dff..bb49c5708ce7 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -29,6 +29,16 @@ static inline enum rtnl_kinds rtnl_msgtype_kind(int msgtype)
 	return msgtype & RTNL_KIND_MASK;
 }
 
+/**
+ *	struct rtnl_msg_handler - rtnetlink message type and handlers
+ *
+ *	@owner: NULL for built-in, THIS_MODULE for module
+ *	@protocol: Protocol family or PF_UNSPEC
+ *	@msgtype: rtnetlink message type
+ *	@doit: Function pointer called for each request message
+ *	@dumpit: Function pointer called for each dump request (NLM_F_DUMP) message
+ *	@flags: rtnl_link_flags to modify behaviour of doit/dumpit functions
+ */
 struct rtnl_msg_handler {
 	struct module *owner;
 	int protocol;
@@ -38,11 +48,6 @@ struct rtnl_msg_handler {
 	int flags;
 };
 
-void rtnl_register(int protocol, int msgtype,
-		   rtnl_doit_func, rtnl_dumpit_func, unsigned int flags);
-int rtnl_register_module(struct module *owner, int protocol, int msgtype,
-			 rtnl_doit_func, rtnl_dumpit_func, unsigned int flags);
-int rtnl_unregister(int protocol, int msgtype);
 void rtnl_unregister_all(int protocol);
 
 int __rtnl_register_many(const struct rtnl_msg_handler *handlers, int n);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 0fbbfeb2cb50..a9c92392fb1d 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -338,57 +338,6 @@ static int rtnl_register_internal(struct module *owner,
 	return ret;
 }
 
-/**
- * rtnl_register_module - Register a rtnetlink message type
- *
- * @owner: module registering the hook (THIS_MODULE)
- * @protocol: Protocol family or PF_UNSPEC
- * @msgtype: rtnetlink message type
- * @doit: Function pointer called for each request message
- * @dumpit: Function pointer called for each dump request (NLM_F_DUMP) message
- * @flags: rtnl_link_flags to modify behaviour of doit/dumpit functions
- *
- * Like rtnl_register, but for use by removable modules.
- */
-int rtnl_register_module(struct module *owner,
-			 int protocol, int msgtype,
-			 rtnl_doit_func doit, rtnl_dumpit_func dumpit,
-			 unsigned int flags)
-{
-	return rtnl_register_internal(owner, protocol, msgtype,
-				      doit, dumpit, flags);
-}
-EXPORT_SYMBOL_GPL(rtnl_register_module);
-
-/**
- * rtnl_register - Register a rtnetlink message type
- * @protocol: Protocol family or PF_UNSPEC
- * @msgtype: rtnetlink message type
- * @doit: Function pointer called for each request message
- * @dumpit: Function pointer called for each dump request (NLM_F_DUMP) message
- * @flags: rtnl_link_flags to modify behaviour of doit/dumpit functions
- *
- * Registers the specified function pointers (at least one of them has
- * to be non-NULL) to be called whenever a request message for the
- * specified protocol family and message type is received.
- *
- * The special protocol family PF_UNSPEC may be used to define fallback
- * function pointers for the case when no entry for the specific protocol
- * family exists.
- */
-void rtnl_register(int protocol, int msgtype,
-		   rtnl_doit_func doit, rtnl_dumpit_func dumpit,
-		   unsigned int flags)
-{
-	int err;
-
-	err = rtnl_register_internal(NULL, protocol, msgtype, doit, dumpit,
-				     flags);
-	if (err)
-		pr_err("Unable to register rtnetlink message handler, "
-		       "protocol = %d, message type = %d\n", protocol, msgtype);
-}
-
 /**
  * rtnl_unregister - Unregister a rtnetlink message type
  * @protocol: Protocol family or PF_UNSPEC
@@ -396,7 +345,7 @@ void rtnl_register(int protocol, int msgtype,
  *
  * Returns 0 on success or a negative error code.
  */
-int rtnl_unregister(int protocol, int msgtype)
+static int rtnl_unregister(int protocol, int msgtype)
 {
 	struct rtnl_link __rcu **tab;
 	struct rtnl_link *link;
@@ -419,7 +368,6 @@ int rtnl_unregister(int protocol, int msgtype)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(rtnl_unregister);
 
 /**
  * rtnl_unregister_all - Unregister all rtnetlink message type of a protocol
@@ -454,6 +402,26 @@ void rtnl_unregister_all(int protocol)
 }
 EXPORT_SYMBOL_GPL(rtnl_unregister_all);
 
+/**
+ * __rtnl_register_many - Register rtnetlink message types
+ * @handlers: Array of struct rtnl_msg_handlers
+ * @n: The length of @handlers
+ *
+ * Registers the specified function pointers (at least one of them has
+ * to be non-NULL) to be called whenever a request message for the
+ * specified protocol family and message type is received.
+ *
+ * The special protocol family PF_UNSPEC may be used to define fallback
+ * function pointers for the case when no entry for the specific protocol
+ * family exists.
+ *
+ * When one element of @handlers fails to register,
+ * 1) built-in: panics.
+ * 2) modules : the previous successful registrations are unwinded
+ *              and an error is returned.
+ *
+ * Use rtnl_register_many().
+ */
 int __rtnl_register_many(const struct rtnl_msg_handler *handlers, int n)
 {
 	const struct rtnl_msg_handler *handler;
-- 
2.39.5 (Apple Git-154)


