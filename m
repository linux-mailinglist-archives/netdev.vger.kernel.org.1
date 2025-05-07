Return-Path: <netdev+bounces-188638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C755AAE036
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BDED1C01182
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273E428A1E1;
	Wed,  7 May 2025 13:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PEMOod6K"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F033C28A1DA;
	Wed,  7 May 2025 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623229; cv=none; b=Shyj7QQJTTq1SOOobLc7cp41AG2cqWX7L9XKJtDO+ki0I/TVQ/nngwUgnpmBCNryyw3tc0HtyJ0vf+2mE2M3fSdJkjf/ImefMkI5u/PkkcKe6x9V0cewXfTW3Mljc5c/MTGLpQNtgu2j0Kz+6IqRQu+VXtaz3vVox+eGtzmY+pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623229; c=relaxed/simple;
	bh=HO4xbozyJMxD8zWDiEa6K7DNK6Y9m2+KGX7iMwR0BG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X9offzhccePY/jBqlVS/23OCZ8UKBzptb93ZOoRpdwlHN1Fusr9KkOIDhoowmzv4xt69jMsooF0JDmJo3tajUD+jLcXk1/QrFg+/tEqmn0RDB3UNIWqFoxvzRIknSNXEKfOhf9EpL39ec3QBLFzjQGgWEoIVSjdU9uOY5lYJq28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PEMOod6K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6843C4CEE7;
	Wed,  7 May 2025 13:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746623228;
	bh=HO4xbozyJMxD8zWDiEa6K7DNK6Y9m2+KGX7iMwR0BG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PEMOod6KU9PVRGVpZ4Gcw+iwdFO25WoEzI7sxQqIPemICVpnlzHXAGF5G5OXQGJ5u
	 7sjL9SbqPV11CaMXdv3pYqeYh5Xa6Jc2REDn7pfJZojwG6wdDdM3J/TgOaWVXDnewl
	 1ACOPKX+DxssryRPH1pJ8gEHw86F5xQ2RK1k0bnV2ZU+HDbjj/kcPDpaD2Bp2ZPGbY
	 60hy4oauCRNq33Un3n1Rbsn5eyGZd8VdYSFreLEJpuYKqb10/wwEdBjCJZQ6iBMdNo
	 8eCHJR87IiSc2MnCSXQDcvZLsV8d+FEMuaE1sRSG8OW8WahcOhUt+c5f3r4akHlVVF
	 qPueO54ECCxSQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 07 May 2025 09:06:33 -0400
Subject: [PATCH v8 08/10] net: add symlinks to ref_tracker_dir for netns
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-reftrack-dbgfs-v8-8-607717d3bb98@kernel.org>
References: <20250507-reftrack-dbgfs-v8-0-607717d3bb98@kernel.org>
In-Reply-To: <20250507-reftrack-dbgfs-v8-0-607717d3bb98@kernel.org>
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
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoG1rp/8dRU+okF/dK0ceL7n0cYyDdzyTteOfWs
 Y5VZy4bCYqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBta6QAKCRAADmhBGVaC
 FRSED/0fr3wOnxxiq0T8aCKbZbTIrIB3phIIAZjsA2FIm0rmml4DNHhERPpmeGqvMRqhKT9rcGc
 QzBsQexvHh3RHfY1C7IzeADX3AGVpI9cuDY4ySC6Xoey6VnhSuO0forj/HpHFGCU4n2DEaNObIz
 l3mWdcElISuwP8t+BI5G/65/UKrtCHezR8pVwcytBtIInv2OnWFZ9BVmrjwZ93hOMV6YjvNaNDZ
 qnviKszbmgS1FHaQFGjPXWyAJG0KvHFQzHihhg1LAtdcrUyXUEMwUTkfvbbg4MfB6T1WY9gCi+i
 ODDP6lnLI58v1YSOmX/6R+C428kuJ5ulDkS/Azd54lmSwhZk41HC0X9njt2Aji9fJaayjra7Uk+
 qVoTneTDHbXsznzCzK906DGDw9jiHRUUDdyGU7Uchfhy1JHtuZDeZW3++hmjFQvozqiyBuQMpKK
 sPPDFlQsWbdQECb0cchy7n1EXf9C/kv1M1QNgBhCX68EAthP5bv0SU9tE4ZuIIMAqVZO1YuCz2W
 Di9rbkTxPbpyggkVRD3f8ossPp57njhBH7RvSypT3DaSKjhvTHqJ3P6rI4HeUikwWTVrGSIP5qG
 WwUh+dQ9iTrCvczyt16nNRiy4LhtSllmjaS6bSzMYTMiY1vq0E+35Utr0YeRUSel3Ku2rtKKNRc
 2703n1OZRfuXZSw==
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


