Return-Path: <netdev+bounces-193987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE11DAC6BDF
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 16:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A78ACA229AA
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 14:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CD828AB12;
	Wed, 28 May 2025 14:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mp7sPzIY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3B128AAFE;
	Wed, 28 May 2025 14:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442899; cv=none; b=nJ79JWY+SJ1pirO+XsqHu9/HTnHphNykxr+Jqxprp7EUi9FkczMK08mzMjO85Cb4KX/Cz2ZHJYSS6aR4DCC0Tpl17SXgtq1KKl4mGwwtUGd2Vv7VdaigEz5sHtsEGwigKrr9NIHWfj2YMte31VT5VpIr7muTBfULI+i+pfP11+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442899; c=relaxed/simple;
	bh=yBa7ifHp2eEzkVC7ksvSn07Jj9NvKIPB+yWSqGSHorE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N1Dn3CK5207/fPn1tV4UomKIiq4aJFM4MZ+YFYUVFDnAYoRbNjP8OsWL7/FmK+7Zz+l6kWMqbgcmZs0yWiQJ4TjTNknYvgc5GkshcGwh1b5s4nbcK3HbRxPU91wH5EabpfAUB8r5++6oFBcsFucRzFjoLzQs0HE/LkfXuF2I/M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mp7sPzIY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14F4C4CEED;
	Wed, 28 May 2025 14:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748442898;
	bh=yBa7ifHp2eEzkVC7ksvSn07Jj9NvKIPB+yWSqGSHorE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Mp7sPzIY1gPH6IBnKaOobixohW9sngW5pUFTPCRR3UWJeLsX15NRHFpeq2xJyoCIU
	 a9uYu1LGpp2jQUwBkrFp0GJivihc8NQPRVKBzyXpAD0kgkSaf7kUAI9cLU2EslvCTy
	 4cGM9zxFk1k1Ms4HTX68V94tYDlxdfBJIq5uOnt3MWkPRoM0tfq0lBf9Kp2PRlZV5O
	 52BrZW+cc0qVtTlB+4A+ASPslJhgWkQvgCGtX+7SaOnjUd2aA2W8st6Yfz86LfVGDm
	 xSxeVmdIW3M+uky/m4aaf9mpsC4S6bihOnvV7Xwnrj9amWO0UIh+eRfvKLhnU7hBiT
	 Y7EmJQME+DV7w==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 28 May 2025 10:34:37 -0400
Subject: [PATCH v11 05/10] ref_tracker: add a static classname string to
 each ref_tracker_dir
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-reftrack-dbgfs-v11-5-94ae0b165841@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6071; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=yBa7ifHp2eEzkVC7ksvSn07Jj9NvKIPB+yWSqGSHorE=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoNx8F17DDgq/6aKRW8+AjuMf9twD61q0iG//V+
 g821NuXlP+JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDcfBQAKCRAADmhBGVaC
 FdruEACl9d3KF9MnOGca38VAjVRvu2FxFIinj83AUttzdTNh+2NbCV+23PISNr3j6hKhoT654sD
 zSkaO9MqkyW8uQr1fA8u28UC5HpwxoUsewad9NpUhafbs3Fg7+GNOJx3g2oTdcYOWcAuhxvQ34v
 9jO83cEbBoToA40gNNVcFdoDgejXWc/ThTLk1si1kPdWXZ1mx0H2oH/tlb4bZeOaR9P0c1tFhnC
 p5cRFVqxxj7McM+PwoXsujvcph4pIKJZudxqrMN5e755pN3P4uGMeBu/QcAberGqeFv5kSvg7xP
 aHbf+ec94mYVwIauHlx2N8andt/gGmV+a2XZ2Neyfb6q1C/5ksGkJPAHEc1FEz79XRtf1qL27zc
 Cmx9Yts0ho/p6gwf2m+VeYIEHA1QjOinPbQ1wq734jEy1U0H2cyFMx+697U1Os1tOkFFCn/Rt37
 yxkwuf9XnwMMGDkjLfOyCPRxw4ScdWiTDL5LVkSzhiarLjw1/1UY/KPl/dkdN87R0Wqk0y/OkSO
 +HXYpiWwLWVgXZyk4Cxyf5uDrTLPqIASdiOwQY/dpE34wRvNnyGGGp3/Vxj0IEYCiom0FZmk4FQ
 wjPWrapclnKj+0WI7mCtTHZLHhOw99f3nK3zp/1bpsQ+iaFpLBBgw/j5ABMhSjMMiQmou0H3FgY
 zFR7ziUH2sp3NXQ==
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
 drivers/gpu/drm/i915/intel_runtime_pm.c | 5 +++--
 drivers/gpu/drm/i915/intel_wakeref.c    | 4 ++--
 include/linux/ref_tracker.h             | 4 ++++
 lib/test_ref_tracker.c                  | 2 +-
 net/core/dev.c                          | 2 +-
 net/core/net_namespace.c                | 4 ++--
 7 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/display/drm_dp_tunnel.c
index 076edf1610480275c62395334ab0536befa42f15..b9c12b8bf2a3e400b6d8e9d184145834c603b9e1 100644
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
index 1b2ad1e0aef7d317f63a23b39193ea81c90401f0..90d90145a1890bf788e789858ddad3b3d8e3b978 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -59,8 +59,9 @@ static struct drm_i915_private *rpm_to_i915(struct intel_runtime_pm *rpm)
 
 static void init_intel_runtime_pm_wakeref(struct intel_runtime_pm *rpm)
 {
-	if (!rpm->debug.name[0])
-		ref_tracker_dir_init(&rpm->debug, INTEL_REFTRACK_DEAD_COUNT, dev_name(rpm->kdev));
+	if (!rpm->debug.class)
+		ref_tracker_dir_init(&rpm->debug, INTEL_REFTRACK_DEAD_COUNT,
+				     "intel_runtime_pm", dev_name(rpm->kdev));
 }
 
 static intel_wakeref_t
diff --git a/drivers/gpu/drm/i915/intel_wakeref.c b/drivers/gpu/drm/i915/intel_wakeref.c
index 3cfd68c98023fef75faa4dd69eba55e093130dd7..21dcee7c9a659ac1fb0aa19f3018647be3bda754 100644
--- a/drivers/gpu/drm/i915/intel_wakeref.c
+++ b/drivers/gpu/drm/i915/intel_wakeref.c
@@ -114,8 +114,8 @@ void __intel_wakeref_init(struct intel_wakeref *wf,
 			 "wakeref.work", &key->work, 0);
 
 #if IS_ENABLED(CONFIG_DRM_I915_DEBUG_WAKEREF)
-	if (!wf->debug.name[0])
-		ref_tracker_dir_init(&wf->debug, INTEL_REFTRACK_DEAD_COUNT, name);
+	if (!wf->debug.class)
+		ref_tracker_dir_init(&wf->debug, INTEL_REFTRACK_DEAD_COUNT, "intel_wakeref", name);
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
index 3eb4e945f3120f26605a0b407cb98b12492bc61e..bac9d29486556023cd99f5101b96b052acb9ba70 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11713,7 +11713,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 
 	dev->priv_len = sizeof_priv;
 
-	ref_tracker_dir_init(&dev->refcnt_tracker, 128, name);
+	ref_tracker_dir_init(&dev->refcnt_tracker, 128, "netdev", name);
 #ifdef CONFIG_PCPU_DEV_REFCNT
 	dev->pcpu_refcnt = alloc_percpu(int);
 	if (!dev->pcpu_refcnt)
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 42ee7fce3d95b5a2756d6a3780edba070f01ddb6..8708eb975295ffb78de35fcf4abef7cc281f5a51 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -403,8 +403,8 @@ static __net_init void preinit_net(struct net *net, struct user_namespace *user_
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


