Return-Path: <netdev+bounces-187799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8EEAA9AC6
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4412717416C
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995D42750EC;
	Mon,  5 May 2025 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cjgKnVJP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701AF2741B6;
	Mon,  5 May 2025 17:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466425; cv=none; b=TaSKY1y1w/sDGI3ikwhMPabQIzPZXukFbEONMjTRiuWmr8JDBPBqgkKnYh/7ljlVHN5pxy08Q+tMFRwAQnPUpxbZHUeu/YjFgb7S+W1+AS/jtzb+GgcN7N/+Gpn2qBb/Ca2qUCGY8DoWI6KSSl9F+cOarVO2MJqsYBhJrbayVX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466425; c=relaxed/simple;
	bh=HO4xbozyJMxD8zWDiEa6K7DNK6Y9m2+KGX7iMwR0BG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H+CWM8KuRwC6XvKtlA9VY3Sp/NlNvh2Y9TrT7We8K5DsHq7XaYWfdVI1NZqhfCjDE3yiw+2wXHmIejWeY+LbV6knKsPnOvXamPlNtShrCeZ82ooBClYorIWyM/2hw5i3eLP/gInvu0mwOMVwp5jI1yfwzBIoVkUNbMMPLoappVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cjgKnVJP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5F8C4CEEF;
	Mon,  5 May 2025 17:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746466425;
	bh=HO4xbozyJMxD8zWDiEa6K7DNK6Y9m2+KGX7iMwR0BG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cjgKnVJP0NxiQCgS6ccr3g74jbnfVKX0mTAvbsKWVRSt6PQysSLcS5butKG4L7m2F
	 6Oub0oiPzut5fTdG46vAY2WAuZxhIEF/Eyy6Tm/rIxD7eeVIt90PET0KsFzUDGEnQh
	 0WqCViVLWP7dte+LJ0o6F/grx5fSZWeQ2Nsoi9IJPpegyGs4LAaoL1CO/fdaoo1kdh
	 TFOrUU9RdioVa24/jtOYDN5uoaOhJbE9i6frd19kFvXdgftQX2pUOnORRw6wqUWPlT
	 ESs6fESX5/BLjC+JrXSkBCT08qccM3VCY4PNayCKnpePVEmQKAAljViFV+lUQv2Lwl
	 o77ZJwMZW4rJQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 05 May 2025 13:33:22 -0400
Subject: [PATCH v7 08/10] net: add symlinks to ref_tracker_dir for netns
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-reftrack-dbgfs-v7-8-f78c5d97bcca@kernel.org>
References: <20250505-reftrack-dbgfs-v7-0-f78c5d97bcca@kernel.org>
In-Reply-To: <20250505-reftrack-dbgfs-v7-0-f78c5d97bcca@kernel.org>
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
 h=from:subject:message-id; bh=HO4xbozyJMxD8zWDiEa6K7DNK6Y9m2+KGX7iMwR0BG8=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoGPZmYwQ+Q/CJWoKPdkB67+whcmC/OacHNJ4dH
 Vy/dKshE4KJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBj2ZgAKCRAADmhBGVaC
 FbcVD/4k7jRscq+utxi9aI9kyxYHiT6RAVH+tCM0GODchSU6e7OAYwQx0wlLnBnIqPUE+10Czg0
 za/opTFwdgl/7gTqRI67Twc3TCLp7nZWoMq+/THh1vl6J7/sLLql48sGWm/QgB2mthqXJMCU0X9
 EF07MMZxvwPWuNqnGDdWms5LDntZe9bpyrerkXLuxPU+p9J6wZfV0Gt4d5kAvlewV7c40k665/O
 kLSONvE6xtX9tgEfvoJQ37oOYKem3u2RAJ7JctRJ3/fb7J1lfdAnwsx2leGYFADFAkS4ojGzIRC
 bOj8wjCwGT8zfst0hH6knOW6opu1pBXv8qkQX5Xy75EZoQ7eJFrGGr3TQ+NFPc4g/gkALcOUnTg
 XmGvAyaX3xTm7DZ8tDs5/PXvbmSHIz73pDkxbXcE7e6vOH7MUY9PU1H0slC3ELjFV2QyA4inEUp
 UZRqqZ95EWbXxLJ7ibj+GsHP+Ye2rYtFTtyzXXEqfNt2HSyvgr4wtm79x4llbHHtWGXUS8fMwYE
 MryL3SkeSxpTqbBDzIcV87VaG+ATrGKH12Ahsr1dORSzVHVZGex8LdggYYrvf9EcVcBRKZ7eaid
 l+uCziEFJ1lfW3tzAxrHYxR48BqPTfht9tNTeFBPBprurPPKLbXwhLHuThpA0K1eZO0HbxT3ezp
 KJtA+xOhEQwc4/Q==
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
index 008de9675ea98fa8c18628b2f1c3aee7f3ebc9c6..1c5e0289f0f0b37c61852d95d4e11a8c12a868f3 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -763,12 +763,40 @@ struct net *get_net_ns_by_pid(pid_t pid)
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


