Return-Path: <netdev+bounces-184165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA638A938A2
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 16:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55D7119E84F9
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 14:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAD01DB551;
	Fri, 18 Apr 2025 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeNdgVay"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA811D9A49;
	Fri, 18 Apr 2025 14:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744986284; cv=none; b=nokOauGQtrbFQkngoEsDeJ4hZ8XhYUnr5bITxOVg5Faih4SEt7eQVnKhriZrqG0LrGEpdnfJlzIYtWoiDvUZpZvystVshRgspMifLid9dG6+8NYCnpClXg/uVMhckNcGbl1oL9JeqW00apOWLc1mWrVCYXl71XKqIE8bgZ/8W+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744986284; c=relaxed/simple;
	bh=RJRtNHg+95+XLhuKEmif7q5hF0e32tweD3eXg7ZWvp4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ds/w3P7JXGV1Cko9E0oQ0vCN6Kc9balhBVU/wi1JlA+7cxKJAqvnlGc7Kazo56njc+rHWc4Oy8GxMIWlfdN0mnwHZ6O2aiPivaZqEerd/OpNLShEMxfokRX3XFQ84XI1KCE8u5nFKxzQNt/8LRXNVzcTjaA+CnnJ0PVN13d6n/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeNdgVay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8537C4CEEB;
	Fri, 18 Apr 2025 14:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744986283;
	bh=RJRtNHg+95+XLhuKEmif7q5hF0e32tweD3eXg7ZWvp4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VeNdgVayFj7g81N/T0wYgYXvc5vkQxRW6Dr73vNE6/YURWzxqHsXGP8Xj2zhle0vf
	 oyJOs4Pl3on3r2+OXeSbBycZ+CIbIopaGA39/fikfGQWpoeLcOZLyVVXKsEGHtprxS
	 HwzxZu1vDaSV1ddRK2874K5WGVud+iBGg0XwSLd2Ilbb1vHODrvF9Njyg5j3qi+zrN
	 FMUoa4kZUaqo8OQyo1KPfnjRU+BZOcL98l1ET4SOc3PxBejE/ndSW8gGZ+FNw0Za7E
	 9TNw0WpG6Zm5R72eAy1Ih4mSDTbw7Z100sm0JCiv/gMOfW+d9GHbJ+o2JtugkI9Wyg
	 ButLHD8TVTjBg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 18 Apr 2025 10:24:30 -0400
Subject: [PATCH v4 6/7] net: add ref_tracker_dir_debugfs() calls for netns
 refcount tracking
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250418-reftrack-dbgfs-v4-6-5ca5c7899544@kernel.org>
References: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
In-Reply-To: <20250418-reftrack-dbgfs-v4-0-5ca5c7899544@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1907; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=RJRtNHg+95+XLhuKEmif7q5hF0e32tweD3eXg7ZWvp4=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoAmCicPUIx1rMgKXr3BYoBZgUTPjX2XxnGzZVy
 Upw31d0cFGJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaAJgogAKCRAADmhBGVaC
 FdubD/475MUWwIHIQUz/yNHpnwmkhhYeaMJ7e2yG1OPlCGP23IoBwV4LUEXbQ7m0k+XKk29OamO
 T8/TnNv8PAmIykKFeTzJInwL26E0lOMIJlkvIq35WpwvxbA86tfYZ2u3g3Ht0OgtgIEQVLtaw2C
 DaLxy4HwFciNexX92IC4mz2k0PJJuz6cJWpAFR4uKHNxxyDcn1smHbKLlYFy15rbZYuBAV2qEDo
 k5e9igZgAmCobycugu64dW3+0pmK+/fYYJeF4Bny+3Vjd2V0wnipBBQcj47NOyQBq5nOLNLn2TE
 xeK3KJsK/EZIQl26xiVGQZtL3Sxw4D8oJUd8VVGzxPqKcYwmu3ToRgUCJ7xQycOf0p6nR1h664R
 ougHLj18GpcLYGWqT2n4atAwwVh2qb5Gv6OhludJNkt1XwOGIkC+Banwyuum9f1+FzM+Evqw9Ko
 55ak70A7YjhZ65J2UT2KjhgDaYX55kTnBx6jjG7dcvPghH35bZ7bIdIc3WS7o+/O4p/AfSyoVi3
 mrRAb5fTjwM83tigr9TisgMyWsObZcOHuYgtd6kEk3WZDpRy0+ulbSoPJeBEUwqu0JrK9HFMO8F
 OARsqk6FNl8eKg4zkMZzl6Th/xEHeaCm60ud8UA7a82zPt5tVmnMfDRFZNZ5i7UvRaaWnmYJNBx
 4unARLotJ/oxcFg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

After assigning the inode number to the namespace, use it to create a
unique name for each netns refcount tracker and register the debugfs
files for them.

init_net is registered before the ref_tracker dir is created, so add a
late_initcall() to register its files.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/core/net_namespace.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 4303f2a4926243e2c0ff0c0387383cd8e0658019..f35c51f1eddacf3e84cdd51d77dee9f1d6dc4f87 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -761,12 +761,44 @@ struct net *get_net_ns_by_pid(pid_t pid)
 }
 EXPORT_SYMBOL_GPL(get_net_ns_by_pid);
 
+#ifdef CONFIG_NET_NS_REFCNT_TRACKER
+static void net_ns_net_debugfs(struct net *net)
+{
+	char name[NAME_MAX + 1];
+	size_t len;
+
+	len = snprintf(name, sizeof(name), "netns-%u-refcnt", net->ns.inum);
+	if (len < sizeof(name))
+		ref_tracker_dir_debugfs(&net->refcnt_tracker, name);
+
+	len = snprintf(name, sizeof(name), "netns-%u-notrefcnt", net->ns.inum);
+	if (len < sizeof(name))
+		ref_tracker_dir_debugfs(&net->notrefcnt_tracker, name);
+}
+
+static int __init init_net_debugfs(void)
+{
+	net_ns_net_debugfs(&init_net);
+	return 0;
+}
+late_initcall(init_net_debugfs);
+#else
+static void net_ns_net_debugfs(struct net *net)
+{
+}
+#endif
+
 static __net_init int net_ns_net_init(struct net *net)
 {
+	int ret;
+
 #ifdef CONFIG_NET_NS
 	net->ns.ops = &netns_operations;
 #endif
-	return ns_alloc_inum(&net->ns);
+	ret = ns_alloc_inum(&net->ns);
+	if (!ret)
+		net_ns_net_debugfs(net);
+	return ret;
 }
 
 static __net_exit void net_ns_net_exit(struct net *net)

-- 
2.49.0


