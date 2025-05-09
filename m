Return-Path: <netdev+bounces-189327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5AFAB198A
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FB351885E5D
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3830B23FC7D;
	Fri,  9 May 2025 15:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9vg4ykV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDA823F41D;
	Fri,  9 May 2025 15:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806083; cv=none; b=Z/aCEvFosw/K801BNla8iiFzmTJMrDaiWFqEo8ovqeJZ5snR36uxLXsognWy8Nw2xFXD+Aqzzo6btQnV5yENmfAkD9J40BPbjxRcxnF0fQyFRtGGHYOL6lYi9tXPtDwTdRgXZCgUh9jYvsurQS9M9kNL/OT/6+1Btr6ByRS8DNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806083; c=relaxed/simple;
	bh=HO4xbozyJMxD8zWDiEa6K7DNK6Y9m2+KGX7iMwR0BG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X0MQDdK4xDACk3FDnBy1eA4fXeD5oGSMeKD6svLn2n1nVwAVcMmOJCidjHNtleOYL/5TJlC/vMAIC4zsMTAmfS6Ob3D2S/A5v5bW/DFSWEsICO6cqzBj/o2jbKlf2EUBO7mDoBAriBBNL6oYGUpc3PZRE673w7Oi28nC9nZ7uCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9vg4ykV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B16BFC4CEEF;
	Fri,  9 May 2025 15:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746806082;
	bh=HO4xbozyJMxD8zWDiEa6K7DNK6Y9m2+KGX7iMwR0BG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=C9vg4ykVk4V/bn+FJSZiX9or5Xb2CHkrni7GKVTaFnmmp6cfh7WxTdJ0bqVaHL3ic
	 n1h7lsP7MR2PehoFh3opW77CawZHHzUVBvbig0mmgRNv3YMOqqXjIEiAS7G/0G3dwm
	 FR7sd4oRwzEgdvpxAeVP+1OatRz367Zl5J9duMLnULJdnyCHisNz17nDHB6rYq1Ia5
	 QwSNefDUKQ1n5wh4lnXifUxC6R+p6foyXga9LP3KN0/dJnd92xEqeAESNMxgTwSKUa
	 vMDPdKLsuVR4ZvMNJzl2IeMTj6JwTo8kfSeF9jlxNCaNIExLaIHvU96ehgnSqh9LuX
	 0Wd8auZuoDo4g==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 09 May 2025 11:53:44 -0400
Subject: [PATCH v9 08/10] net: add symlinks to ref_tracker_dir for netns
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-reftrack-dbgfs-v9-8-8ab888a4524d@kernel.org>
References: <20250509-reftrack-dbgfs-v9-0-8ab888a4524d@kernel.org>
In-Reply-To: <20250509-reftrack-dbgfs-v9-0-8ab888a4524d@kernel.org>
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
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoHiUvlAQQocoaJK/ytWY/RnDG9yXvfUBn3xDsF
 ODOiyJTA2GJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaB4lLwAKCRAADmhBGVaC
 FaRrD/4tuPMdB9+m+eEEjmwxR0dyUaU70WNTU9byec8w0ld0DuH62XIFK2JLglAzCmQM8QtTw/z
 fVkO6dgPCliopqLtBVQDnsF69XJnIjQ3Rul61w3uCkCWlmhCgKzhRv39ZMbNjFHmg1/MTTyInuj
 3iugHd9BjQgM2+khIARWbSYM/q2m8GUspoa1MHaeDHGRSFLT+B9eA6tT9yZU2KgfIto0ygP40TG
 GwHpq6Q5VVNQ6Gw+OxvmZl/Jz7rMQ6mqBWBLz9qdfxFkUDFDxKhbwX1EaAkVMQ8UWYhCHwnjBbk
 iDdLVTBrwq0XP51tBt6ByFCEDk3spn6pnfQ+/jb+snujC60fbQf7rF5EOFBd2GfjpyHj9thgy5A
 dsFGQzSzzUl3nllRVEVOGWtvk2ZvgUeEeZPaC8LUS50OBwZ1kQ1ANz8Owxyq2+TuYCa+LK53FlW
 BtoWwVoNTHK74Si2s0uUvgvEvQ7GumOhec+bOq5WG2m6bseRn81VczY3vqOUcSKtRiTRiEZifUe
 XSthEU/KxgdrbhbHsZUdauYRrVwHAWks78Gcclw6cZFxRJcKeGpxIhuKy8GfbB5dKuWMxR1Viq7
 LSlv/EB2CEyQwFw5GHrws/BBtzmhAI5Lk6t2ecA3V96U04nqgYu0tLEO2Wgvylz7755rexxkawf
 P8qv8t6/pS/X+Ng==
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


