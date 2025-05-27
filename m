Return-Path: <netdev+bounces-193629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96286AC4DA2
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 13:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 538A9189FF7C
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 11:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929392741A6;
	Tue, 27 May 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/Qd9G2z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A33F258CD8;
	Tue, 27 May 2025 11:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748345642; cv=none; b=LpD+NRnlXep6bH7PggLok/UIbfzs6l/LeHw7QNfQUEeL8k41xVovXd2+uGYXH8fkkm8YOAZpWmqOZjoN2Trv3L2NfrSlmCoyu+7B6Q4wvipp/BuYL3HVa5qhHJPE7nPrW/rp35rGpGpLpa/NA83QEGv3gufmAZEJWVjWy6Pbj8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748345642; c=relaxed/simple;
	bh=1AohjNsJ/5u7SWnSQ59F0LOjK/wKNx2WHjos8H9MEes=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M08Msh0M1BLF/ysuW9XkHVZEsriJP3DMEwKJxt+1pNKydW+BvKrG35CwnlUPcdSzL4GyWp9YwuYxeizdyjSMCr+yUKFTCFDBW7F7r7fA+ftz78CiW9oRLZM7zTFTtBjH33D/qon2URUtJ0aeflNchSpyi+hkzwWhlFLY9vSn4lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/Qd9G2z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E14EC4CEF6;
	Tue, 27 May 2025 11:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748345641;
	bh=1AohjNsJ/5u7SWnSQ59F0LOjK/wKNx2WHjos8H9MEes=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=P/Qd9G2zvDpVWcyRAxVqjoE4w3rXgBziU37W5NbgLORAm8RSpoyDaPmetz64T450S
	 8W4d1+J1WXbT8Dnb8XkO92tGGLlavpAlKfd8lWIxZqF7hw18V8sXUhZn5b5JrrYYsm
	 bNG4CLpuXaHnmpvD5xyHfeIwbyC+HvdmPoGdZJ+k1PxbBu55lpldJFpChlOTAl4gNb
	 1Mpzoz2JGjx5agCZqbT1wyKc8lJFQzAfn5bDxkIn5SoWrxqLrgq8NW/c9OXZN4UNA0
	 3s4bfCKqNOsxCfhMlEqkIwedcLSvwvK/RFR8xZpo+Rll2jcss91meTypABrppZb+GY
	 5VRPXu7YeLd2Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 27 May 2025 07:33:39 -0400
Subject: [PATCH v10 8/9] net: add symlinks to ref_tracker_dir for netns
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-reftrack-dbgfs-v10-8-dc55f7705691@kernel.org>
References: <20250527-reftrack-dbgfs-v10-0-dc55f7705691@kernel.org>
In-Reply-To: <20250527-reftrack-dbgfs-v10-0-dc55f7705691@kernel.org>
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
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, Qasim Ijaz <qasdev00@gmail.com>, 
 Nathan Chancellor <nathan@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1849; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=1AohjNsJ/5u7SWnSQ59F0LOjK/wKNx2WHjos8H9MEes=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoNaMXOK09R4jSfVB8gdNvrjW+aO6jrUnbP/1CY
 t50wMnUT/+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDWjFwAKCRAADmhBGVaC
 FWixD/0XOX0kufIOnTf3V6fk9Dj2Z799XOtudAidPehZJIYIpgM+dc/y4A0UGc6+g4tzsFajs/d
 +EbxW+wxUHHECScP0IYHUAH28rjwGO1+f3lcMuLwKnBBmT1YJ4B/jGjyvVOD4QvyprabwW1ZT16
 Ai4GJrycV3b3Rj8HSxqszYJYEwriLCk6Dhspsfc1JLbAil7z023a09hSxK0WNTpuyWMzn6nYyLt
 a/6adaQ80qAAMMWh3ExXjMQOcI0ZLfEwg8JGKN+fGgEDG+Ykiiq3RSM3gCsJXbcMbL0MetJL0T6
 iIe7pvaBin/cXCToQV9ovOY+bJJJVcxDJn4HxZmb4fF7FGpJm8MF8Zts6zhlpvwEIG0+8BKdj6A
 Mn0neHMNrBPjT7Wha87sOomrhVsOXmSxj5Psqymw3t5U9Hb6ocsX+hlJRn5IdDb+nZ1aWsTb/KI
 gh0JBC1CboF0FDEyj6rYSyRG8nORrrNPVATqd1tENMP6qck3pAB2FBZkN3Occw8WKTJdKJlRND2
 VeD2JrZ/c7RIj85RloOhGKCYd0/ccDBtPCBdfmr1TJvCr8YaJuOyQH8g1My1nVugBRkFHMZchc9
 +JLZTQUit3FPgvYwt8ZtR2TR3VUzr62fzQnhB0Bb/t7EHhtHhbITaGuIYUFdWty4gAfNuciD4Fg
 4ivEwns6h1Z5WFw==
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
index 8708eb975295ffb78de35fcf4abef7cc281f5a51..39b01af90d240df48827e5c3159c3e2253e0a44d 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -791,12 +791,40 @@ struct net *get_net_ns_by_pid(pid_t pid)
 }
 EXPORT_SYMBOL_GPL(get_net_ns_by_pid);
 
+#ifdef CONFIG_NET_NS_REFCNT_TRACKER
+static void net_ns_net_debugfs(struct net *net)
+{
+	ref_tracker_dir_symlink(&net->refcnt_tracker, "netns--%lx-%u-refcnt",
+				net->net_cookie, net->ns.inum);
+	ref_tracker_dir_symlink(&net->notrefcnt_tracker, "netns-%lx-%u-notrefcnt",
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


