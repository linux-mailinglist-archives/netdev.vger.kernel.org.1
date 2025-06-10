Return-Path: <netdev+bounces-196171-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60265AD3C22
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 17:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3B3317D305
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 15:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AC123AE83;
	Tue, 10 Jun 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RxVsxavL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1CC23ABAB;
	Tue, 10 Jun 2025 15:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749567600; cv=none; b=Bc0FR6hl46f8nGv5XKoGLNrmNStrk0XAYlPVIYEENUkmsKjXfZ2abS2Ezp4NIOIjau+OP1SgNumZn21S59dDe0nWxrMw6ls7vxnjXgQQp54ZXySBkpYF3sULWLkTbW3zOTDA54tkY4In/09XmTJF6y5G6d0fyci742tG/rjqIuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749567600; c=relaxed/simple;
	bh=YMnNgfS5IcXRGDhGxBj9UTTtfo/Re9Qj3nh2BIc6ugE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pDGqsq+Jb7DPwrUFOKimlfTlCkPDdFOWHe6we/byoD+glalZWhp7/bdvG/X5+eqGdmLlILzE3UDCvn4gWK/FA8k8lkgXaobPxY9R6PwXxSs0vAmM0B3Xup//PSYk4xflC72QKkQWy/LKXUdLr0LDfZeZhvf7OrYWijV/yUqxxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RxVsxavL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176C0C4CEF1;
	Tue, 10 Jun 2025 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749567599;
	bh=YMnNgfS5IcXRGDhGxBj9UTTtfo/Re9Qj3nh2BIc6ugE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RxVsxavLcI+lnDIlga13yI8c0cnXUE9sFNR97RHIQ8gqYoB/LYT7CSZnbSdnybg/f
	 aN3EBGN2663enOloyG+dSipZzBaaw5S24ueXREuMLpNx+23EzIKlvQtq5hNJjfliBh
	 erNCbTXh1JDBnFP7Zg97mHmf0dF6LDzG7WaqBXZBSwMLckwP1xztgF4ObV8OBaXhJk
	 pv+2pCKwRtztQPbkDBenDtHKj0Lst64FJAdYR2fTxBuo1rZ5OBnP6cjvBxsaygIT/C
	 5iJDOPy68hRyEZLFvSbrXPc08Z+8pZI1Ok1bgYyl3mx7gC4Ax/c4rbPaZjq7Xylm+C
	 rCyJTmN/CUTPg==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 10 Jun 2025 10:59:28 -0400
Subject: [PATCH v14 8/9] net: add symlinks to ref_tracker_dir for netns
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250610-reftrack-dbgfs-v14-8-efb532861428@kernel.org>
References: <20250610-reftrack-dbgfs-v14-0-efb532861428@kernel.org>
In-Reply-To: <20250610-reftrack-dbgfs-v14-0-efb532861428@kernel.org>
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
 h=from:subject:message-id; bh=YMnNgfS5IcXRGDhGxBj9UTTtfo/Re9Qj3nh2BIc6ugE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoSEhda2NSSlMwJbGmtJM03rnnBts2o8hxzaQAB
 pI5k2DCNXOJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaEhIXQAKCRAADmhBGVaC
 FfBPD/0d+ayWz365la64UnrK/4njC9O23j4b89YXDZt1sfshz25GSKrTqYXGZA8QNsZSk77dveY
 bcKeuWIJ0WzvIeMGDbCuDLpn97WnsedcXc4YjMIaXAMipbf6bYU1UPqMApu24c7sO9USAu7oiWg
 SqK0rsxpayjUete2N+9DsAII+qaf/AzJxOc50trNmoDyHEztEwKc+6en2eXJhQ5Do/UUw50ADA6
 nbZV96f2wAypOJXBvnz5BQaAdkhoiSxt8wY0OxGDazf4h27cubqySfPzBN5HXyE4jUKYZmeTfUl
 bi2LJjMZDvg2GWifibASM9jq4Ir9/R5E4WXNm6uDmXF7cDtmrr0xNIMcHrelCBcMzL45spT2Nch
 XFqnNEjNHSN1/5lZLPIVo8aH/4HtlGK9Ed7gRs97sY+yUKaqhXg98oMklA3FMwRXyW/x9GZcXnm
 pngtSCwLd5AdqZR1ttxZhEjzaGPF/kn3j0wHlPuUBhERhHShmwXSelRiLmE/Nvt2K8Qe2tggD4u
 ibMtawpxufOHn8DEETGB6Loir3tLQwe3iZT33w8yzuVBtePloXX1Q+qns/fsiEJRWaTaAml2ype
 DgxZaIxlhSmZYf/qNGhS2qrbNdKeISET7UN3/bO44OPxLVPyOTCNP9eWnTnuXg96n+VW2nQC2hC
 XKsvynEH6xrgMtw==
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
index aa1e34181ed6f353921a23411fa227b612db661a..45de05d8f0877a4e717bdad4ed776ae27f98944a 100644
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


