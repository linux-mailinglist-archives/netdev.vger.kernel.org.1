Return-Path: <netdev+bounces-131771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFD398F853
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 22:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA3D8B2188B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 20:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945721A7AF6;
	Thu,  3 Oct 2024 20:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="UkM51d7o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6C12EBDB
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 20:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989085; cv=none; b=NX4uY/quMt7rNy46Tm2LQqXGNerTtXOsoax/G9gLcmli/xfQsEwblhSUo0+ZISgZTVon/z8CHad/liZQJugQ2zU+D/kQAxiqb8DeiXZAa4PgH43oVnRzGahd4RWCkjHJ4CZLBw+JLnKwjj+hXZboHIsvgBN/7pxGoxQOLmIU/vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989085; c=relaxed/simple;
	bh=EOjVh/y4SslOWLXNzHTY7N5QGXsYG3/niD1gPvO43TQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nKyKqodTJLyueUq3bdurPoW7YmpPdhzTuMYe5Kt4PlEB7yHOnFhgU29ELQtQQMiReL6B5nchvQe2G15byPcDJYVIAXjqGWLMMc1Ilf3/AI8doJ5Y9ogcmfaYqcKDvFhYfTehzJGulo2uqE5WwjP0giSUmLb5/8O600Z7UuHOiTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=UkM51d7o; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727989084; x=1759525084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=seOYwIJkBjxJmZoQqu+ysVQtUocOzwWaMd0oDOzAIrY=;
  b=UkM51d7oy8w0+dnZHp4zVlKYYFBKjEdV3fC71uxV9EjQDyhABzCzIabf
   oclM/cos6N2fcJYEziwKAl58WATEhsKYGnT9IoGjpiIR4Ucsdhi3CFY0Q
   k6xCL7X+vINGj50QT04X87gDHoJGdJ3dPH01ZwKfH9mez36SCrwFTFXLR
   4=;
X-IronPort-AV: E=Sophos;i="6.11,175,1725321600"; 
   d="scan'208";a="134885993"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 20:58:01 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:48809]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.107:2525] with esmtp (Farcaster)
 id 493d5ea5-81ff-4c78-97fd-9f58cbffc4ad; Thu, 3 Oct 2024 20:58:00 +0000 (UTC)
X-Farcaster-Flow-ID: 493d5ea5-81ff-4c78-97fd-9f58cbffc4ad
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 3 Oct 2024 20:58:00 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 3 Oct 2024 20:57:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 1/6] rtnetlink: Add bulk registration helpers for rtnetlink message handlers.
Date: Thu, 3 Oct 2024 13:57:20 -0700
Message-ID: <20241003205725.5612-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241003205725.5612-1-kuniyu@amazon.com>
References: <20241003205725.5612-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC003.ant.amazon.com (10.13.139.214) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Before commit addf9b90de22 ("net: rtnetlink: use rcu to free rtnl message
handlers"), once rtnl_msg_handlers[protocol] was allocated, the following
rtnl_register_module() for the same protocol never failed.

However, after the commit, rtnl_msg_handler[protocol][msgtype] needs to
be allocated in each rtnl_register_module(), so each call could fail.

Many callers of rtnl_register_module() do not handle the returned error,
and we need to add many error handlings.

To handle that easily, let's add wrapper functions for bulk registration
of rtnetlink message handlers.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/rtnetlink.h | 19 +++++++++++++++++++
 net/core/rtnetlink.c    | 30 ++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index b45d57b5968a..b6b91898dc13 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -29,6 +29,14 @@ static inline enum rtnl_kinds rtnl_msgtype_kind(int msgtype)
 	return msgtype & RTNL_KIND_MASK;
 }
 
+struct rtnl_msg_handler {
+	int protocol;
+	int msgtype;
+	rtnl_doit_func doit;
+	rtnl_dumpit_func dumpit;
+	int flags;
+};
+
 void rtnl_register(int protocol, int msgtype,
 		   rtnl_doit_func, rtnl_dumpit_func, unsigned int flags);
 int rtnl_register_module(struct module *owner, int protocol, int msgtype,
@@ -36,6 +44,17 @@ int rtnl_register_module(struct module *owner, int protocol, int msgtype,
 int rtnl_unregister(int protocol, int msgtype);
 void rtnl_unregister_all(int protocol);
 
+int __rtnl_register_many(struct module *owner,
+			 struct rtnl_msg_handler *handlers, int n);
+void __rtnl_unregister_many(struct rtnl_msg_handler *handlers, int n);
+
+#define rtnl_register_many(handlers)						\
+	__rtnl_register_many(NULL, handlers, ARRAY_SIZE(handlers))
+#define rtnl_register_module_many(handlers)					\
+	__rtnl_register_many(THIS_MODULE, handlers, ARRAY_SIZE(handlers))
+#define rtnl_unregister_many(handlers)						\
+	__rtnl_unregister_many(handlers, ARRAY_SIZE(handlers))
+
 static inline int rtnl_msg_family(const struct nlmsghdr *nlh)
 {
 	if (nlmsg_len(nlh) >= sizeof(struct rtgenmsg))
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index f0a520987085..1fac9e786315 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -384,6 +384,36 @@ void rtnl_unregister_all(int protocol)
 }
 EXPORT_SYMBOL_GPL(rtnl_unregister_all);
 
+int __rtnl_register_many(struct module *owner,
+			 struct rtnl_msg_handler *handlers, int n)
+{
+	struct rtnl_msg_handler *handler;
+	int i, err;
+
+	for (i = 0, handler = handlers; i < n; i++, handler++) {
+		err = rtnl_register_internal(owner, handler->protocol,
+					     handler->msgtype, handler->doit,
+					     handler->dumpit, handler->flags);
+		if (err) {
+			__rtnl_unregister_many(handlers, i);
+			break;
+		}
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(__rtnl_register_many);
+
+void __rtnl_unregister_many(struct rtnl_msg_handler *handlers, int n)
+{
+	struct rtnl_msg_handler *handler;
+	int i;
+
+	for (i = n - 1, handler = handlers + n - 1; i >= 0; i--, handler--)
+		rtnl_unregister(handler->protocol, handler->msgtype);
+}
+EXPORT_SYMBOL_GPL(__rtnl_unregister_many);
+
 static LIST_HEAD(link_ops);
 
 static const struct rtnl_link_ops *rtnl_link_ops_get(const char *kind)
-- 
2.30.2


