Return-Path: <netdev+bounces-193991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C1FAC6BE9
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 16:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A33AA3B3104
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 14:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AEF28C03D;
	Wed, 28 May 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVjGgmEE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF976288CBF;
	Wed, 28 May 2025 14:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442907; cv=none; b=oqDjLZxhIODxHEorZ0cv4sSb41BRtltKuwmF60smCuxWsnLRyi0qnb476+XqvfJJFKhehKsp0ztFv7KVFc68rLW8FW4fsO/wcfqAUOPGSGZDQxyrbFDSl9QmCzDHUAguuLtHdX1eUk6ywoEC83dPSqnlYPjQ8QOBHLG3D3fV7o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442907; c=relaxed/simple;
	bh=C3NjXad8atSO1FZ7CKOXtU5VIRqVojZ9jejAtjAiqWM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K9Af5XnA9hTHPSJoYIl4FOU6XDEXWxXGtiOaMy9hCGu0UtBPPJaavYwd5EZ21YOyy7mB28h9KVh+B1ARnH4Dmv2Zx1z8awoYuv1DrcPqIUFmtOonk5nQU3ac7cKgpNTGEIzmoypXZOaKpvuv770rVM/DdU0j9TsIL2dcjAuKb40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVjGgmEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE21C4CEF1;
	Wed, 28 May 2025 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748442906;
	bh=C3NjXad8atSO1FZ7CKOXtU5VIRqVojZ9jejAtjAiqWM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rVjGgmEEhYyWizmS5qe9pgAkmMhCy5Zj85Jv1kZ7Y2O8Ub7mlkHLihVkcMAk3H3ZN
	 E7iRTygacktYSR7oOXiWRsD4zfrryIKN6MiIByx2cAu0X0ow+A4BOIK/GAo71/xF9U
	 X0OyB/gT4HHIT4NlCAS4XfvCMoDEPPA/8sG+R8eCIs8o12IXwBeruZ6koDYesPjKar
	 GanDmCR5KWzx8+sbyDd4E+RoofJiXj/MsPXJt6yO5IfAiFcv2mYlmADVxxkrg+cOGw
	 ZuH41NBRrISpjmG1UOZLM69X4riZAMF9v1FcxoWKrsjFaiKUW4GbyMBfWRkZ6OfIkA
	 D7xaTgAaGNONA==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 28 May 2025 10:34:41 -0400
Subject: [PATCH v11 09/10] net: add symlinks to ref_tracker_dir for netns
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-reftrack-dbgfs-v11-9-94ae0b165841@kernel.org>
References: <20250528-reftrack-dbgfs-v11-0-94ae0b165841@kernel.org>
In-Reply-To: <20250528-reftrack-dbgfs-v11-0-94ae0b165841@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1850; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=C3NjXad8atSO1FZ7CKOXtU5VIRqVojZ9jejAtjAiqWM=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoNx8G2qhxKRFMIuvaikAolyZRaHqqMfY9w6wlB
 B8ZCTg6SAqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDcfBgAKCRAADmhBGVaC
 FX5mD/4nt7J4dnvaIJZmR0mApa7CMh0kmPKOmUvWbpC4J99+rVd4RfMPu6Hwcj8EaNHJNOyw/+h
 sasuPE/veTJqNVEI4OOcaNY99cNzGgv22I/eGcGZ4NLvKp3mtxed01UIeZAW6SlYpYVHrBc3cxV
 UdGhqdnLJx+91ZubJppxk+9lUHIw4s8xgdSPiz+D/EG66drv/cYSsNETN1Wtjnp1qSMu82c9T4o
 HKs0MLdC3XLCARnfPb0Tb27kbfZmziu50XXL/szr7zIEyQvAlRnWg6pitWPGj19nOnPhMKYrrgH
 ymKlmIOce9dEypxjDuoIj2WHuSqNuAWNj8DNinabRBoN3+/ccM6WXPya3+Go9mOTuQ/9+VDcfX6
 ev+KRvhuwjK1bz+3NCwIi1PWmdmIQFZsppnGicY/PhokPcGBEfXl3zG114KX3y3gDBwyKQbs9Fz
 KOM1hEEy2P9tGBDRVhBZlfelyhJ+V6UIC+pQYeTa0wr1nJNaQRuyEb3PRAO/Jzenz49IjbGui1D
 ue7VyzRbPo6IhyX389oz6CjJNxBzxPrJLFN/RZJsRHjTwORAmkLQZaIuGLd+JM6a5s96nSP8Qhv
 UgStVmt3LYhMSTBdzfg9EqLvvcNMqqbrYDFIUkAtpOXONInWIOi6kyQYexpxxUHP6DF+eb/Udxo
 4+/1LJXwJxD4rDw==
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


