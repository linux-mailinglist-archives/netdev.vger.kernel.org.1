Return-Path: <netdev+bounces-187111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FA5AA4FD5
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D93F3A54A3
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0784F266EEA;
	Wed, 30 Apr 2025 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9iJvpoL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9E826659E;
	Wed, 30 Apr 2025 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025631; cv=none; b=MSnVSZ3XXL7Hj1p0PjGfj9tkQxoTMBVhGQ+RwLsKj/ASLYQi32l88kwMjGs+OcUqa65cPxqSzwAoJLE5rY4sWePvkPowKniXRCoITTQKZ8airB2WeHLDHC28LV2/VTuuIRHu5fwwc9mghwXk2y4UgyWHViR9spHuYnyh55iT04s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025631; c=relaxed/simple;
	bh=HxYYob4i7WkZ4QVFzXDuapuOVvHl8o21L1EhBkSyHxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YF/9GECLyloC7aLP23T7NFLh4bgOZP10GUv1dfSCtpvWkMQBTmJhAYG9ozkLwEkric/3rynM1NH2KnuoIc5LsBn0DT2tosGrSaqgKjaYE+nhGD3hVdycl/EW7JoteMJz3V6fdqSol0Eg9r12omZAvuWerG9/6GCUX4PB7WgV8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9iJvpoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABDDC4CEE7;
	Wed, 30 Apr 2025 15:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746025631;
	bh=HxYYob4i7WkZ4QVFzXDuapuOVvHl8o21L1EhBkSyHxk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c9iJvpoLxME0pedJkdJYf/mTX07Z1tRYXv2izX2mDQLS6fHRGun2hceoO/G2qCD1A
	 s7g/3R8cvH+O4lxFY/YX8n2wYx8tZPifI8VYoOZesL/hkvlQIpQb/VL/gd1U8pQIME
	 z9CLMyOnS3fM4cCyVJlKCrmE98U5fIEDS2ZnV5B+4YZlbewcwIA2ypb+PTx4Sr6/4r
	 Ej3vBWOSg5FvnTOh40zwpeCrg8igtXk5xWt+qYY8dd9G3O40CUl3GOHwYGE7vH6G0z
	 oSfiKav/kYS5Rjsy0zPF6J3yO34p60BUGe3p4sgzmJyJcOn1PcbmAgE7jtK321g75h
	 qO6sbQdruCJ+A==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Apr 2025 08:06:54 -0700
Subject: [PATCH v6 08/10] net: add symlinks to ref_tracker_dir for netns
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-reftrack-dbgfs-v6-8-867c29aff03a@kernel.org>
References: <20250430-reftrack-dbgfs-v6-0-867c29aff03a@kernel.org>
In-Reply-To: <20250430-reftrack-dbgfs-v6-0-867c29aff03a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1775; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=HxYYob4i7WkZ4QVFzXDuapuOVvHl8o21L1EhBkSyHxk=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoEjyUuVkMoy78wN5CCpwW5xj/qphR1mAoNEtn4
 Nv5KKjK06qJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBI8lAAKCRAADmhBGVaC
 FWCzD/9Zc84uzNPo6OQ36eKyNx0rmSVtujwMSxaE3qqL/DbF8sjCwhHNv57yeK3dYr1mkvWvlvw
 udhBtJK0gSu2bHhYIuoDDQCSfLqX+8CdC2KsaQkGDbLg1DBtjzgN2rTN1asqBXIEfpkkU77zxup
 9vmEmvrEaVhU5221dGZcPlacieR/cX+yr20I+Pc619rhUxt0yAT97BPmPZXVIUjoHe0Gq7TM6aJ
 96eUQnKDBvNJZyjF/3Du3bq/uOIoqtQ15nuwtCWoinzzar/zlm+E0MPU66I5bf6is65nhVaBrPD
 njb57ITAKq7FMcpft0ZGTUMhyH4nF6m4UHRcebYIgQ4rx6DaiQae7SX9wIX1o8BAgDmDS2sd8ww
 HLIo5WQIkO6pM9jr7nMlXHLF3VbvTSg25jW7gXPwT248UPn0v+DdR8viq7z6zoyIxNywQifpUUQ
 OFn0Y2Id9yJhbypaioY5Pl1jk1Wfz7swqVR/lpCc9IegvZV5TbYHgNfpzpxj34FkmKJzOwYtUmj
 69/vVc9T3cNLIK3o2qar/sImF8Ayi8D8EmirTw4cvT6JQRkt8Ym66v4dQ0WnJK6XKudou0PCkQE
 1OAEIwo0IsqjmWWmeoHIIILTUVHwliw6gCIcvI/QECSfDmLqXoSDYrAmpkxOFUV05S0BrsYP7V0
 iTRKApfY2p9eKzQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

After assigning the inode number to the namespace, use it to create a
unique name for each netns refcount tracker with the ns.inum value in
it, and register a symlink to the debugfs file for it.

init_net is registered before the ref_tracker dir is created, so add a
late_initcall() to register its files and symlinks.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 net/core/net_namespace.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 008de9675ea98fa8c18628b2f1c3aee7f3ebc9c6..6cbc8eabb8e56c847fc34fa8ec9994e8b275b0af 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -763,12 +763,38 @@ struct net *get_net_ns_by_pid(pid_t pid)
 }
 EXPORT_SYMBOL_GPL(get_net_ns_by_pid);
 
+#ifdef CONFIG_NET_NS_REFCNT_TRACKER
+static void net_ns_net_debugfs(struct net *net)
+{
+	ref_tracker_dir_symlink(&net->refcnt_tracker, "netns-%u-refcnt", net->ns.inum);
+	ref_tracker_dir_symlink(&net->notrefcnt_tracker, "netns-%u-notrefcnt", net->ns.inum);
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


