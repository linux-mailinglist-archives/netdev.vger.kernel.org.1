Return-Path: <netdev+bounces-194782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D7BACC577
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:30:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A1603A3B7A
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5769237163;
	Tue,  3 Jun 2025 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJWf9PqE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5C5236A79;
	Tue,  3 Jun 2025 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748950062; cv=none; b=gsxRXx4Q3jkltwxH+pziL7ebLSJ/OczCmY7TLv2WiGgafnxzlga836MeCR8nP4u/Qmsh1uQ/J0Y56YNFRpwhtHo2hDo1xD33Ce2pTQOo3DmV4D0AKdXXc2AX/x+ldA/X3uBGRf6lbIRakr/Miw/X4YmklNPT9OrLE3ziukjRY3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748950062; c=relaxed/simple;
	bh=C3NjXad8atSO1FZ7CKOXtU5VIRqVojZ9jejAtjAiqWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rh3URRMdBPhRlqyiajw2wFGlS5VIDq3PlyJqoxeyBctWXfIQJm9ywJl54ovT2OcBW8saWAr6aTYLCUPhNZguhq6IO+P15GfgPjxtiD37ok2LqdZ/MtklHGh9kI+r6cOrMc6saffutmaXaxCl8/BjHg9KLke/a56qV4Gy46cTvRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJWf9PqE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77930C4CEF4;
	Tue,  3 Jun 2025 11:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748950062;
	bh=C3NjXad8atSO1FZ7CKOXtU5VIRqVojZ9jejAtjAiqWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nJWf9PqEnvvty5KAcKmlN+gkgwCN0pRwDvUNlP/s8LJeimjpochQRjmhpblQs21qj
	 UMrRB+Yp+bEhCOd6pNKooz5fDGl+bTfP0GkfD3//TUHuzii0hy30L+cBBdh5WkzUtc
	 lwURWzi4/xjLBnqN3RjMKDPvxVqMPSu+YU2gfT3Y1muPT7AG5reR2pbhYLJHEcydD7
	 LEfFVgtwkpd6hcqPrIWNJiZj/xWcW1YBkevQ9i1+51q9eVQflfRyV4zU1bKxCYHD4o
	 KcHT05jzWcdzV3YBpd1lvtIo1eVSdB/ghWbakGddINUODqsJPSLJqwbtXKDdkp6p0/
	 ilj0aa+DtjJhw==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 03 Jun 2025 07:27:19 -0400
Subject: [PATCH v13 8/9] net: add symlinks to ref_tracker_dir for netns
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-reftrack-dbgfs-v13-8-7b2a425019d8@kernel.org>
References: <20250603-reftrack-dbgfs-v13-0-7b2a425019d8@kernel.org>
In-Reply-To: <20250603-reftrack-dbgfs-v13-0-7b2a425019d8@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Krzysztof Karas <krzysztof.karas@intel.com>, 
 Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=C3NjXad8atSO1FZ7CKOXtU5VIRqVojZ9jejAtjAiqWM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoPtwbkd0+Vc5/RnhkEbQLT4EKS5SAlBOjIR8p6
 BRo+WaHO3aJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaD7cGwAKCRAADmhBGVaC
 FREPD/9x+zTUX2dX1RQhNJM3fFxh5Ld2OWYtR6yA38853uwtfD5KYH/wclEWNZhqqLAuhBSkbI0
 Z5G2lVl4J77oUYo4qNWbj8F2K5r5POTQeUd1gAhmkS7h7jIH6VzMq1gaOp8+ye4fkSLfz11Iv8m
 JQthJknt7p+JajHmnbdTz6jLwx+eVrM2uXslX0zFAB+40fQyXZUlwwI5aA+FywvXze5seYOAe13
 H3APF9c7uFgrm8uT5+I81NrgDdV2SP0cAEZAknaTgsZUG5YLoVnBmQNdBjhMYBRohz5t8w4Xfm6
 hx+bXi41LnySkKb2WAgPwgWf7Ey/dHIBmL2+f2eIs9uxV2/Bi7eMtf+bGu0Qya3+w9OWWwJyMnH
 M7o3vIXk7ZzSugtviSLHxvX0cwpGMXHaPOGgAFIHPE3DMyJeCyNSl+XBPqHQxiN1UYgA5gFfiOD
 wwrZ9va8lfDOj9n4V1RSrH+x9L0+e4V/OJt2UzrH64wO7NLSInCLNWwdkeq7cEOd1/5QLFOSg02
 Btf+yYu7fCnr0GA6wnT79mrYKFefjZ2TErUn472EQkIkQCeBLwRcvlDWFxSYqG1icOO2zi53NQ2
 Q8FrtNw5N0chfEC29xvMQOqyNG/pdBjGS2eNPLbcKzTW8Go49U+Bp4aXkI+AKU9udDUcDJrc22b
 fOe/pMX2g9cQ/iA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

After assigning the inode number to the namespace, use it to create a
unique name for each netns refcount tracker with the ns.inum and
net_cookie values in it, and register a symlink to the debugfs file for
it.

init_net is registered before the ref_tracker dir is created, so add a
late_initcall() to register its files and symlinks.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/core/net_namespace.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 8708eb975295ffb78de35fcf4abef7cc281f5a51..b2fd9c5635ecf8fccd48f1d5b967a5c6c41cfec4 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -791,12 +791,40 @@ struct net *get_net_ns_by_pid(pid_t pid)
 }
 EXPORT_SYMBOL_GPL(get_net_ns_by_pid);
 
+#ifdef CONFIG_NET_NS_REFCNT_TRACKER
+static void net_ns_net_debugfs(struct net *net)
+{
+	ref_tracker_dir_symlink(&net->refcnt_tracker, "netns-%llx-%u-refcnt",
+				net->net_cookie, net->ns.inum);
+	ref_tracker_dir_symlink(&net->notrefcnt_tracker, "netns-%llx-%u-notrefcnt",
+				net->net_cookie, net->ns.inum);
+}
+
+static int __init init_net_debugfs(void)
+{
+	ref_tracker_dir_debugfs(&init_net.refcnt_tracker);
+	ref_tracker_dir_debugfs(&init_net.notrefcnt_tracker);
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


