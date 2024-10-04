Return-Path: <netdev+bounces-132263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F15991246
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186231F2212E
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0781AE01F;
	Fri,  4 Oct 2024 22:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="U/KL1Tk8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1471AE016
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080677; cv=none; b=PIc4knIGJxREDuTN2oG1KRAKs8Uzkro12+YXnXBGV1kUV9KRwZLW8yBzECjFisEQz4WFOWkHw6rlTMB8O3MZasbWQArewsQpBO0cxR9IhmYqDcoKUBMw0yCP+/6UrowHPcyqwXzMHdQ+21PYI7OmoOo5WDmXwLO6cyzH7QfTTNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080677; c=relaxed/simple;
	bh=EOjVh/y4SslOWLXNzHTY7N5QGXsYG3/niD1gPvO43TQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e595XlPLrB+0rPJSKi5/K8I2HggmgKbRLcERUkqNBP02aYYCsYW8zHXiRVBkn0Q8leYpvJceRFBJdYNl4HHAWL4SQivMTuAJXGGumS06//WjVX2P0QDXDk2Pnk2SnCKbWhrUQ+dy2SEcREKPwfQ+bnWkYuJp9rSdHc5R71Rf3Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=U/KL1Tk8; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728080676; x=1759616676;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=seOYwIJkBjxJmZoQqu+ysVQtUocOzwWaMd0oDOzAIrY=;
  b=U/KL1Tk8nMZW4mv7i2mB2PD8Qxnew2AECj7RyBkE0RTaa/6mYhw051MJ
   UeKZNMirQwt0/4ya11mozOimcZKuu7IFK7hg2170Ck4fKPBBN5L2Qnr/U
   G5oaK3rqu9CtusQqa+larsbZGHsBNNAOL2RDctTPTS0kUusPvIXXyv/74
   o=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="339909027"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 22:24:34 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:30475]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.198:2525] with esmtp (Farcaster)
 id d3beda05-1003-467b-899c-1ce44e71cc18; Fri, 4 Oct 2024 22:24:34 +0000 (UTC)
X-Farcaster-Flow-ID: d3beda05-1003-467b-899c-1ce44e71cc18
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 22:24:33 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 22:24:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 1/6] rtnetlink: Add bulk registration helpers for rtnetlink message handlers.
Date: Fri, 4 Oct 2024 15:23:53 -0700
Message-ID: <20241004222358.79129-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241004222358.79129-1-kuniyu@amazon.com>
References: <20241004222358.79129-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
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


