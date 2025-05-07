Return-Path: <netdev+bounces-188640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324F9AAE03A
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC223B531B
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351DE28A419;
	Wed,  7 May 2025 13:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnHg3+DG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB48288C03;
	Wed,  7 May 2025 13:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623233; cv=none; b=j3okzgxwiflZuDVdBgJK7juqWq6+Zef7WPSBjw+Dpx3AddmsPSdfxXJqJ3CuSN2DRUfM8SLo0+S9OGAWlh9J30FlWsVGWUGZoOzrrBhN2vhpMYfqjsr2o/N+aLYP9ar/EOH5Zmas67cXXSDm1xt5n0tcHfTHSjerleoIawai+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623233; c=relaxed/simple;
	bh=okYdOkUfuYxZjDxBTddV/Z8yQpoJhL8u5feYj7TGts0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QyXjT44J98brIS8RstuTusbqdf0COTe4KORYjqWVVNMLplAGsj28Zt3Aox0czSzRJlOea8VaaCgWovTvo546Xp3Mqj/AzNMPmB/UrPrt9dW2jQvnjZY3SqsqN8dS00huEUNttzXVOpGhQkqRHj5JzY/staSMlz8ylc6TdRxONDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnHg3+DG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA731C4CEEE;
	Wed,  7 May 2025 13:07:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746623232;
	bh=okYdOkUfuYxZjDxBTddV/Z8yQpoJhL8u5feYj7TGts0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HnHg3+DGLlrxKZ9mSjuCGsnGd5Y+1rwaDvjYe1G+LvQsO4UYdJfmEaNt6OBhBeC5C
	 gU6/75IcmlFeKf8HD7/uy8O8bDHpTcSqKPTBj1GAdyeDAC2mrTR+na1/2iHzyz+EEA
	 yqpXV3B7pP97SInR4tjfp2S/3SUMLDTorpNkvWbnocgZIIUZSpyAKXtc37XLr3b3C5
	 IYlFz8GuoImULqAhku6T0I885x1XuqPlexM7vVNfHrGolh9lb/TLoe5R9ogQ8xYIFH
	 F93ILorXRmDaA65Ix5gFK1gKWY+zagWJoOGpHqdmxqbOiIF8d0AdlextZ2XXHB8jVZ
	 +0rz6RscGYZ3Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 07 May 2025 09:06:35 -0400
Subject: [PATCH v8 10/10] ref_tracker: eliminate the ref_tracker_dir name
 field
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-reftrack-dbgfs-v8-10-607717d3bb98@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7622; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=okYdOkUfuYxZjDxBTddV/Z8yQpoJhL8u5feYj7TGts0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoG1rqU5ozLBZRcDd03PFM46qf2B9VyS2sK1Zk5
 rBzl+kH1TqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBta6gAKCRAADmhBGVaC
 FViCEADDWuqtGBgeCFg273dBepRhG7snk2v/1x6vSEBcVK6AIrLQvGy88yjzw+df03FW5WRqSFM
 x9xamRt2FAQRgGPeoKnx+XUwbuiIoqFypI5iGeB3Ef2m6iwZr6+d0YLv3MENbiVCbEK8iaaYlnm
 gGDi4Aam/VDumyaT3IPiBs3iDJftSCzzmnE4MiVDEn/XvJYeMe0dTbCQIcCriOsFquWFxZOoBvL
 LStIwQ9sPBM8ZNM/Opi0MXveQh6pNoPFQdXVFFUyAGGFe6wuM5+Gx2FdCP1RB1QMnU/oy5o/wSA
 yreRShQQNZBLK6wGInfjoN/YEallMpkr3dsFHBrO/MQQhlfyn+uLly6SpDInZsFqIeZHKhJILZu
 UkJ+TWhxCnvXdycngwoJiQh1CQKsHVcvvNAAJYYC4QvnQodmEftfYhjSI/KgzBVZuPNcQCKVRfS
 oAXU6KRCfyEBcdAt1eP4BljWnI/0Ejz98LMyoogC/FBq3gMJ1pHcHzEMvZ6zZkbTts/Hwca66sM
 2ZBdPRdCDByazoquHrnTnZOzGBslsw6yVJifkV0KwzT/jZ9+qQ75F00Dko3QoOLgNwJtaKs7j7o
 7Gv0OIgBcAeW1Nuasth3UROqjqifZLnq72MAW/1dMqsm7W+02D19gWtKFCz+y9u4no46Uvi+rT1
 jbSq1GdWS7tRR0A==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Now that we have dentries and the ability to create meaningful symlinks
to them, don't keep a name string in each tracker. Switch the output
format to print "class@address", and drop the name field.

Also, add a kerneldoc header for ref_tracker_dir_init().

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/gpu/drm/display/drm_dp_tunnel.c |  2 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c |  2 +-
 drivers/gpu/drm/i915/intel_wakeref.c    |  2 +-
 include/linux/ref_tracker.h             | 20 ++++++++++++++------
 lib/ref_tracker.c                       |  6 +++---
 lib/test_ref_tracker.c                  |  2 +-
 net/core/dev.c                          |  2 +-
 net/core/net_namespace.c                |  4 ++--
 8 files changed, 24 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_tunnel.c b/drivers/gpu/drm/display/drm_dp_tunnel.c
index f2a8ef6abf34d89a642d7c7708c41e5b1dc9dece..f8d1f9c60e86c5a7b1866e1c9f6425e99d4ca9c6 100644
--- a/drivers/gpu/drm/display/drm_dp_tunnel.c
+++ b/drivers/gpu/drm/display/drm_dp_tunnel.c
@@ -1920,7 +1920,7 @@ drm_dp_tunnel_mgr_create(struct drm_device *dev, int max_group_count)
 	}
 
 #ifdef CONFIG_DRM_DISPLAY_DP_TUNNEL_STATE_DEBUG
-	ref_tracker_dir_init(&mgr->ref_tracker, 16, "drm_dptun", "dptun");
+	ref_tracker_dir_init(&mgr->ref_tracker, 16, "drm_dptun");
 #endif
 
 	for (i = 0; i < max_group_count; i++) {
diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
index 94315e952ead9be276298fb2a0200d102005a0c1..d560f94af7a86f1fc139204a4e901eaea22c6ef1 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -60,7 +60,7 @@ static struct drm_i915_private *rpm_to_i915(struct intel_runtime_pm *rpm)
 static void init_intel_runtime_pm_wakeref(struct intel_runtime_pm *rpm)
 {
 	ref_tracker_dir_init(&rpm->debug, INTEL_REFTRACK_DEAD_COUNT,
-			     "intel_runtime_pm", dev_name(rpm->kdev));
+			     "intel_runtime_pm");
 	ref_tracker_dir_symlink(&rpm->debug, "intel_runtime_pm-%s", dev_name(rpm->kdev));
 }
 
diff --git a/drivers/gpu/drm/i915/intel_wakeref.c b/drivers/gpu/drm/i915/intel_wakeref.c
index 2e0498b3fa7947f994de1339d4d2bed93de1a795..bbd5171ce0a22435e540f10821f2a0dad59c1d2f 100644
--- a/drivers/gpu/drm/i915/intel_wakeref.c
+++ b/drivers/gpu/drm/i915/intel_wakeref.c
@@ -114,7 +114,7 @@ void __intel_wakeref_init(struct intel_wakeref *wf,
 			 "wakeref.work", &key->work, 0);
 
 #if IS_ENABLED(CONFIG_DRM_I915_DEBUG_WAKEREF)
-	ref_tracker_dir_init(&wf->debug, INTEL_REFTRACK_DEAD_COUNT, "intel_wakeref", name);
+	ref_tracker_dir_init(&wf->debug, INTEL_REFTRACK_DEAD_COUNT, "intel_wakeref");
 	ref_tracker_dir_symlink(&wf->debug, "intel_wakeref-%s", name);
 #endif
 }
diff --git a/include/linux/ref_tracker.h b/include/linux/ref_tracker.h
index ddc5a7b2bd84692bbc1e1ae67674ec2c6857e1ec..cb61ddd3f770a118f3da5d22f98ea2a67a43c6b2 100644
--- a/include/linux/ref_tracker.h
+++ b/include/linux/ref_tracker.h
@@ -24,7 +24,6 @@ struct ref_tracker_dir {
 	struct dentry		*dentry;
 	struct dentry		*symlink;
 #endif
-	char			name[32];
 #endif
 };
 
@@ -48,10 +47,21 @@ void ref_tracker_dir_symlink(struct ref_tracker_dir *dir, const char *fmt, ...)
 
 #endif /* CONFIG_DEBUG_FS */
 
+/**
+ * ref_tracker_dir_init - initialize a ref_tracker dir
+ * @dir: ref_tracker_dir to be initialized
+ * @quarantime_count: max number of entries to be tracked
+ * @class: pointer to static string that describes object type
+ *
+ * Initialize a ref_tracker_dir. If debugfs is configured, then a file
+ * will also be created for it under the top-level ref_tracker debugfs
+ * directory.
+ *
+ * Note that @class must point to a static string.
+ */
 static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
 					unsigned int quarantine_count,
-					const char *class,
-					const char *name)
+					const char *class)
 {
 	INIT_LIST_HEAD(&dir->list);
 	INIT_LIST_HEAD(&dir->quarantine);
@@ -65,7 +75,6 @@ static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
 	dir->dentry = NULL;
 	dir->symlink = NULL;
 #endif
-	strscpy(dir->name, name, sizeof(dir->name));
 	ref_tracker_dir_debugfs(dir);
 	stack_depot_init();
 }
@@ -90,8 +99,7 @@ int ref_tracker_free(struct ref_tracker_dir *dir,
 
 static inline void ref_tracker_dir_init(struct ref_tracker_dir *dir,
 					unsigned int quarantine_count,
-					const char *class,
-					const char *name)
+					const char *class)
 {
 }
 
diff --git a/lib/ref_tracker.c b/lib/ref_tracker.c
index 5e84e5fd78e147a036d4adb511e657da07866a55..5fb384dd919e1f1ad632eaf595b954118bcfddab 100644
--- a/lib/ref_tracker.c
+++ b/lib/ref_tracker.c
@@ -123,7 +123,7 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 	stats = ref_tracker_get_stats(dir, display_limit);
 	if (IS_ERR(stats)) {
 		pr_ostream(s, "%s%s@%p: couldn't get stats, error %pe\n",
-			   s->prefix, dir->name, dir, stats);
+			   s->prefix, dir->class, dir, stats);
 		return;
 	}
 
@@ -134,14 +134,14 @@ __ref_tracker_dir_pr_ostream(struct ref_tracker_dir *dir,
 		if (sbuf && !stack_depot_snprint(stack, sbuf, STACK_BUF_SIZE, 4))
 			sbuf[0] = 0;
 		pr_ostream(s, "%s%s@%p has %d/%d users at\n%s\n", s->prefix,
-			   dir->name, dir, stats->stacks[i].count,
+			   dir->class, dir, stats->stacks[i].count,
 			   stats->total, sbuf);
 		skipped -= stats->stacks[i].count;
 	}
 
 	if (skipped)
 		pr_ostream(s, "%s%s@%p skipped reports about %d/%d users.\n",
-			   s->prefix, dir->name, dir, skipped, stats->total);
+			   s->prefix, dir->class, dir, skipped, stats->total);
 
 	kfree(sbuf);
 
diff --git a/lib/test_ref_tracker.c b/lib/test_ref_tracker.c
index d263502a4c1db248f64a66a468e96c8e4cffab25..b983ceb12afcb84ad60360a1e6fec0072e78ef79 100644
--- a/lib/test_ref_tracker.c
+++ b/lib/test_ref_tracker.c
@@ -64,7 +64,7 @@ static int __init test_ref_tracker_init(void)
 {
 	int i;
 
-	ref_tracker_dir_init(&ref_dir, 100, "selftest", "selftest");
+	ref_tracker_dir_init(&ref_dir, 100, "selftest");
 
 	timer_setup(&test_ref_tracker_timer, test_ref_tracker_timer_func, 0);
 	mod_timer(&test_ref_tracker_timer, jiffies + 1);
diff --git a/net/core/dev.c b/net/core/dev.c
index 380d07bec15a1f62ed27c31a6e211e74f3a5561d..00776cba0276554066c94a6fc86f5ed4df430cfa 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11620,7 +11620,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 
 	dev->priv_len = sizeof_priv;
 
-	ref_tracker_dir_init(&dev->refcnt_tracker, 128, "netdev", name);
+	ref_tracker_dir_init(&dev->refcnt_tracker, 128, "netdev");
 #ifdef CONFIG_PCPU_DEV_REFCNT
 	dev->pcpu_refcnt = alloc_percpu(int);
 	if (!dev->pcpu_refcnt)
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 1c5e0289f0f0b37c61852d95d4e11a8c12a868f3..5b06a0bf88e62c19f6f610eca3a4c4750ff4a2ea 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -324,8 +324,8 @@ static __net_init void preinit_net(struct net *net, struct user_namespace *user_
 {
 	refcount_set(&net->passive, 1);
 	refcount_set(&net->ns.count, 1);
-	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net_refcnt", "net_refcnt");
-	ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net_notrefcnt", "net_notrefcnt");
+	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net_refcnt");
+	ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net_notrefcnt");
 
 	get_random_bytes(&net->hash_mix, sizeof(u32));
 	net->dev_base_seq = 1;

-- 
2.49.0


