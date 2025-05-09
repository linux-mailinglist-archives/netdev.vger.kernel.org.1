Return-Path: <netdev+bounces-189323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2409CAB1986
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6CF3AE68B
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD92239E9A;
	Fri,  9 May 2025 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g5JtAocV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153D0239E94;
	Fri,  9 May 2025 15:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806075; cv=none; b=nHROeexMNaZaz9NCNJ5r/SI8K7B+X1t33of/US6wnRyhHmjCVVkPgIS8Vk+r04EzdMpBZUAnWX/tPML2Ac27q4CCzOfdyEDGJJYvYUZftYzSu8fkUNMCgruQ/aihqP+6dyRDZw8e/a6F5iGhUvQ8xAsAbxEm6E009s1py25gVI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806075; c=relaxed/simple;
	bh=hjRJC+ai7FiQIRoBwApJsexl2tKLt7dyencvNsS2N6g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UR2v0zXZMCeWrJQxZ8E2aFUyJtM1xBuvnwpZvDwNL/bSlNWB/hsnE4xq8rWaNoWufRzHMaStOp+5P8CPQKL8xhfx4yDZwq6jNZqe8N0MUNKIzGgPjGmLsanaQaT3ZYl48LjawEvu2hZd0a3ZcUGAoj+6oTpSZX/HEyo+cWPAvRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g5JtAocV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C217BC4CEF2;
	Fri,  9 May 2025 15:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746806074;
	bh=hjRJC+ai7FiQIRoBwApJsexl2tKLt7dyencvNsS2N6g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g5JtAocVr6AcfL6ALKR1W3mvnbgHXSlDDyiEoDbasHclIDFIJWdVI2ZdrrTxuWfKn
	 pbtfX1+5lh93dcYl0QBMOw2mLZMSSc/RxiWGdsedsDUcECWfKUQOZZSnwEDlORZq83
	 91QWClOi08GT6Pn5ncMOF+s2eu8rktCLdZ78A87XlfR9GQPFAhagwN3CnJEUoJaDbK
	 Ttt0kEL6/DYKTrnaqZbVfBuGa5D5ahSEEk2OYNYqyig0Huc0wbAr33+xfJGwNOA1Sc
	 H/+4qaAJVb5HRpOdWhVJXZTrbiexsINA2gV2jKaLtajApsAX0yVFjm5iHK0T8lQ1Yy
	 kgHQtcQXZFabg==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 09 May 2025 11:53:40 -0400
Subject: [PATCH v9 04/10] ref_tracker: add a static classname string to
 each ref_tracker_dir
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-reftrack-dbgfs-v9-4-8ab888a4524d@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5956; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=hjRJC+ai7FiQIRoBwApJsexl2tKLt7dyencvNsS2N6g=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoHiUveKte6/xoagWZcgpH8xxuHDPiyf8bg/Ym9
 XqAdciGnZGJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaB4lLwAKCRAADmhBGVaC
 FfMqEADGYmp0itJnR6x3kLRaCHJ0q9UnZp8lj2zKx4StOi9fwJNu9pj1Dx7zSBxurU/P6SQz7Yi
 LqZGH2xdsiM5OQtjYpVhDcUTBAPktkRTnvWT2GdLAxWTPpqJLS4C6202DnrqBRatQlgn82KrVqT
 PDCaLTO7tsHvrFvIec7pwHiIJort3lkeayLa6k/roBIdQ0d9hMeOiCd1ALVLFUvS+YNunQ1O9Gn
 02yvpzeQU3OTA5JPH4vP0lIO+dPOvZmg5r6B2Ecox5UeNzmRnNUCaW3QPP6Nx+7ByLgtxdphYiT
 qIyfb2T8/Croz0h2zy+Vn+8yuRAA+zB6cSW7X2AD363ECLlsQGg2+zFVfVOOHs68U4blfU46Lbp
 zgsXCTdsEiCM9MHFpR8TX2C7Il2rJzNKju8edGWB8UrYL8sEU3mzX4AcpDrgG18ChbkkUEqDdn9
 /tLa/VezbJXzZSJZfRVlvOLrw4QAkyZO0Rasskaw2/4M7kLXA3+OHTKvSo+ZdLKfPU5vz6n7hA2
 93VlWnDfz+KEavKz0o4Y/jA73247Zg6OHDanZv+MFY2mDqm+N7yblQZwLzd+YMcMCWqvKps7cOz
 YzA90GhQDmx1wqtw3aPTsgl+5dFzoUHhjNokfsEl+pjp0vK/iGOPzfk45SeWNPRPeLhOnL5H5L2
 zl5uBy3bIi1cU1Q==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

A later patch in the series will be adding debugfs files for each
ref_tracker that get created in ref_tracker_dir_init(). The format will
be "class@%px". The current "name" string can vary between
ref_tracker_dir objects of the same type, so it's not suitable for this
purpose.

Add a new "class" string to the ref_tracker dir that describes the
the type of object (sans any individual info for that object).

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/gpu/drm/display/drm_dp_tunnel.c | 2 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c | 3 ++-
 drivers/gpu/drm/i915/intel_wakeref.c    | 2 +-
 include/linux/ref_tracker.h             | 4 ++++
 lib/test_ref_tracker.c                  | 2 +-
 net/core/dev.c                          | 2 +-
 net/core/net_namespace.c                | 4 ++--
 7 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/display/drm_dp_tunnel.c
index 90fe07a89260e21e78f2db7f57a90602be921a11..f2a8ef6abf34d89a642d7c7708c41e5b1dc9dece 100644
--- a/drivers/gpu/drm/display/drm_dp_tunnel.c
+++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
@@ -1920,7 +1920,7 @@ drm_dp_tunnel_mgr_create(struct drm_device *dev, int max_group_count)
 	}
 
 #ifdef CONFIG_DRM_DISPLAY_DP_TUNNEL_STATE_DEBUG
-	ref_tracker_dir_init(&mgr->ref_tracker, 16, "dptun");
+	ref_tracker_dir_init(&mgr->ref_tracker, 16, "drm_dptun", "dptun");
 #endif
 
 	for (i = 0; i < max_group_count; i++) {
diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
index 8d9f4c410546e4144d4bc8bbc6696f3bd9498848..3fdab3b44c08cea16ac2f73aafc2bea2ffbb19e7 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -59,7 +59,8 @@ static struct drm_i915_private *rpm_to_i915(struct intel_runtime_pm *rpm)
 
 static void init_intel_runtime_pm_wakeref(struct intel_runtime_pm *rpm)
 {
-	ref_tracker_dir_init(&rpm->debug, INTEL_REFTRACK_DEAD_COUNT, dev_name(rpm->kdev));
+	ref_tracker_dir_init(&rpm->debug, INTEL_REFTRACK_DEAD_COUNT,
+			     "intel_runtime_pm", dev_name(rpm->kdev));
 }
 
 static intel_wakeref_t
diff --git a/drivers/gpu/drm/i915/intel_wakeref.c b/drivers/gpu/drm/i915/intel_wakeref.c
index 07e81be4d3920febece34709c63a63204a41583c..5269e64c58a49884f5d712557546272bfdeb8417 100644
--- a/drivers/gpu/drm/i915/intel_wakeref.c
+++ b/drivers/gpu/drm/i915/intel_wakeref.c
@@ -114,7 +114,7 @@ void __intel_wakeref_init(struct intel_wakeref *wf,
 			 "wakeref.work", &key->work, 0);
 
 #if IS_ENABLED(CONFIG_DRM_I915_DEBUG_WAKEREF)
-	ref_tracker_dir_init(&wf->debug, INTEL_REFTRACK_DEAD_COUNT, name);
+	ref_tracker_dir_init(&wf->debug, INTEL_REFTRACK_DEAD_COUNT, "intel_wakeref", name);
 #endif
 }
 
diff --git a/include/linux/ref_tracker.h b/include/linux/ref_tracker.h
index a0a1ee43724ffa00e60c116be18e481bfe1d1455..3968f993db81e95c0d58c81454311841c1b9cd35 100644
--- a/include/linux/ref_tracker.h
+++ b/include/linux/ref_tracker.h
@@ -19,6 +19,7 @@ struct ref_tracker_dir {
 	bool			dead;
 	struct list_head	list; /* List of active trackers */
 	struct list_head	quarantine; /* List of dead trackers */
+	const char		*class; /* object classname */
 	char			name[32];
 #endif
 };
@@ -27,6 +28,7 @@ struct ref_tracker_dir {
 
 static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
 					unsigned int quarantine_count,
+					const char *class,
 					const char *name)
 {
 	INIT_LIST_HEAD(&dir->list);
@@ -36,6 +38,7 @@ static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
 	dir->dead = false;
 	refcount_set(&dir->untracked, 1);
 	refcount_set(&dir->no_tracker, 1);
+	dir->class = class;
 	strscpy(dir->name, name, sizeof(dir->name));
 	stack_depot_init();
 }
@@ -60,6 +63,7 @@ int ref_tracker_free(struct ref_tracker_dir *dir,
 
 static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
 					unsigned int quarantine_count,
+					const char *class,
 					const char *name)
 {
 }
diff --git a/lib/test_ref_tracker.c b/lib/test_ref_tracker.c
index b983ceb12afcb84ad60360a1e6fec0072e78ef79..d263502a4c1db248f64a66a468e96c8e4cffab25 100644
--- a/lib/test_ref_tracker.c
+++ b/lib/test_ref_tracker.c
@@ -64,7 +64,7 @@ static int __init test_ref_tracker_init(void)
 {
 	int i;
 
-	ref_tracker_dir_init(&ref_dir, 100, "selftest");
+	ref_tracker_dir_init(&ref_dir, 100, "selftest", "selftest");
 
 	timer_setup(&test_ref_tracker_timer, test_ref_tracker_timer_func, 0);
 	mod_timer(&test_ref_tracker_timer, jiffies + 1);
diff --git a/net/core/dev.c b/net/core/dev.c
index 1be7cb73a6024fda6797b6dfc895e4ce25f43251..380d07bec15a1f62ed27c31a6e211e74f3a5561d 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11620,7 +11620,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 
 	dev->priv_len = sizeof_priv;
 
-	ref_tracker_dir_init(&dev->refcnt_tracker, 128, name);
+	ref_tracker_dir_init(&dev->refcnt_tracker, 128, "netdev", name);
 #ifdef CONFIG_PCPU_DEV_REFCNT
 	dev->pcpu_refcnt = alloc_percpu(int);
 	if (!dev->pcpu_refcnt)
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index b0dfdf791ece5aa8fefdc2aea1ff4a9d9c399d72..008de9675ea98fa8c18628b2f1c3aee7f3ebc9c6 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -324,8 +324,8 @@ static __net_init void preinit_net(struct net *net, struct user_namespace *user_
 {
 	refcount_set(&net->passive, 1);
 	refcount_set(&net->ns.count, 1);
-	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net refcnt");
-	ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net notrefcnt");
+	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net_refcnt", "net_refcnt");
+	ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net_notrefcnt", "net_notrefcnt");
 
 	get_random_bytes(&net->hash_mix, sizeof(u32));
 	net->dev_base_seq = 1;

-- 
2.49.0


