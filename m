Return-Path: <netdev+bounces-134715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CFA99AE85
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 00:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05A31F22172
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 22:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350691D1E85;
	Fri, 11 Oct 2024 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BvPV6c+n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4401D1E81
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728684580; cv=none; b=NGgbZM3RSXR1SlE4ppoq4AiMiVBpBFJdvNrc0LKIyonV5T1SOhcQd6ctTW0ZPtWZTsVrInZR9RoV0xjgsdtbiw++fLSVNX9E9Sa7GkbbbkGGrueEeyPrDVSL1k+7m2cEuvB7EgrxO9vz8b9ZMmuSaAb+SIyzClBVRsMewU89j+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728684580; c=relaxed/simple;
	bh=o3zeH8d9UpUheBWpJQaGj9gALrCTKuM6emWN1oBPSwE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GRJAucaA8vltayLIXUXpiXb5ouE8Q37A7yhRjmTDTKfkYt/4N14sy/vf6O7gjQyjJ1D+zxPA9HThQTzl8NP35smLZu6gcnYfCxuAk1hcu+Ymdp5aBQAiemhrYbx9wECjyGMe1QebSlsJuh9kk+W9GPnQZSN4RwntVWMm3Mi6coU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BvPV6c+n; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728684578; x=1760220578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ie0nO2TEPCRpmURhBgUuiWj/I1vtTweIOite9JiY6tU=;
  b=BvPV6c+n7vzMpaIBQC+CqsKsR1/2bbFq+9WxX27n7sYBiEk7hDLm10G3
   3ksBu+wmk7gTWzb2hqYz+zSJMN9L+jbY2NaDzjAD5HZmRkpMZFXDlpnfe
   RVVLIGkQdQGeFS8kCXb4JFBwkgX9TOgfu1OndaFlOnCRATJCIVkOOJhVh
   c=;
X-IronPort-AV: E=Sophos;i="6.11,196,1725321600"; 
   d="scan'208";a="765895844"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 22:09:32 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:36196]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id 9d4a0044-e145-45e3-9218-3dc82fd5fd40; Fri, 11 Oct 2024 22:09:32 +0000 (UTC)
X-Farcaster-Flow-ID: 9d4a0044-e145-45e3-9218-3dc82fd5fd40
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 11 Oct 2024 22:09:31 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.100.8) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 11 Oct 2024 22:09:29 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 11/11] rtnetlink: Remove rtnl_register() and rtnl_register_module().
Date: Fri, 11 Oct 2024 15:05:50 -0700
Message-ID: <20241011220550.46040-12-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241011220550.46040-1-kuniyu@amazon.com>
References: <20241011220550.46040-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB001.ant.amazon.com (10.13.138.123) To
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
index edaafdcd24ad..dc4fef1e05cc 100644
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


