Return-Path: <netdev+bounces-199107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C56ADEF48
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A09407724
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489D3280027;
	Wed, 18 Jun 2025 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIAvokyL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1108F2ED169;
	Wed, 18 Jun 2025 14:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256678; cv=none; b=srXGSMJcl5TTrD/+9i0FHwLb+HwnKIckYgXz3SSPn2Lg/abv4asdS+X+z/ifvAHI+EDyc6JxRV+QYk+Vd+vMhwYcrmDkEj/DLDNnGn/ey6RP+33AMFlGwCRHytyDKTq0nt0qLO9KqrpBdcgpbBH3v1fWgtijraOEqrTbl8cp02g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256678; c=relaxed/simple;
	bh=sDvBzK8bp/Z2sPKX3249YaEV241YJ6Xk50FlZaY0KPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRYbgO5BAvBfvPp9RtEdY6pINndvzArUEECe9inNyTHsPZ0TJ6Zt9+tBu7/etR7NlNFRvsH62j5KwwJ9hUegF4VhRs6l966wZ5Y4aKuWSQCwdxKO5WnzTxjh5cuIwdE6yEEnmUmgR4A0tk325nuTMtKlY6A//a0xasuNgmfwOVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIAvokyL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69ECC4CEF2;
	Wed, 18 Jun 2025 14:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750256676;
	bh=sDvBzK8bp/Z2sPKX3249YaEV241YJ6Xk50FlZaY0KPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bIAvokyLBVf3zdQRPKOZ1Y43xIP4ItvRImpi+HkkQz+FcWRICTSBu6SFTH6fq84Ym
	 zmETIeqjPna5EgTuHDY8zsO5YJLN3Ce4dbCQuLRKOgv0hT1+x/4UcKKsSOFHSl8uTL
	 669wuTwpbIohnZeQKsZxSS011csU0bWOKR/9jN90KLy0M25UlzttZ2jSiaIS48MqOP
	 vbzeu+5mIaTup/u+PlOv2baXrDXSQE02IBvCT9eVjqODzUPhgxo+rmHp2iB5f/B5ID
	 8VpblOX3lBCeTLqL16DJOnKIidxzxfO68u9AKfo2KN639vOtosd3l7l1+QVWjqXDxJ
	 QYTzhaqPf51uw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 18 Jun 2025 10:24:17 -0400
Subject: [PATCH v15 4/9] ref_tracker: add a static classname string to each
 ref_tracker_dir
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-reftrack-dbgfs-v15-4-24fc37ead144@kernel.org>
References: <20250618-reftrack-dbgfs-v15-0-24fc37ead144@kernel.org>
In-Reply-To: <20250618-reftrack-dbgfs-v15-0-24fc37ead144@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6203; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=sDvBzK8bp/Z2sPKX3249YaEV241YJ6Xk50FlZaY0KPY=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoUswYxLGiMf3xnackVRyECrcTiDvHdTo2H5Qe5
 8wxRYY3mhiJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaFLMGAAKCRAADmhBGVaC
 Fc9oD/9ePYCrYPP9+wrxERgYc5NLLRmWdKrsZZwKILpQjXGW7tk1fj8QA9ukM9dJ5z/3bTIcd92
 4F85d8y2jSi44mFZy4H0sVHPV5y2np3KRwySIvElNhnKXazwL0HHkmXMTVaTfHY+IO6M367rPME
 b8w/qyfseaymPyK+tyvmQDyfTVUODiOHwVxY7FwhExGv9y/dOj/88YL/8i+XcNyywbsf8o67nRk
 hs5kp1CaJz76NhzWrmviD0KjEY0c9X4JoH/nqqR2cbeFiL+niF9Q0PsUU2pQDJsG6+0IhgXlVDj
 tlkoKVlwRZT2gOKOJmeDpwEnDao46z4gZ3P+LSVSZUhrVes/pxqv3+mkqCorHQl6wMdGEYXCZHh
 ugPBpubdaWYb0hivDcwbJaw3+49LT7C6Sc5DxFffGJisiT62FFqLsoQOloLfvAj5d+CUe9pJHdA
 Cu/7P+38j6wrxJWyeaqN1PWfkNZom2SiK59St2mLeJsqZ5QZ+6u3GX/scZKuDVjskmWwK0KG4G6
 DXyG3gxZZC55jv24rf76D916WYPuX+ZgNk/p935wRKzCfirwZmW3w0FnYt1Ajg6DrTFe9CnS13e
 ehkRTbFyQGiFsuml0mEcq5iMNy0OGZ4JhTkMgksjlmPzw3evGHAQxu0m8pImiT1EJHEyiukyTRY
 wTybtyFecvJ7WYw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

A later patch in the series will be adding debugfs files for each
ref_tracker that get created in ref_tracker_dir_init(). The format will
be "class@%px". The current "name" string can vary between
ref_tracker_dir objects of the same type, so it's not suitable for this
purpose.

Add a new "class" string to the ref_tracker dir that describes the
the type of object (sans any individual info for that object).

Also, in the i915 driver, gate the creation of debugfs files on whether
the dentry pointer is still set to NULL. CI has shown that the
ref_tracker_dir can be initialized more than once.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/gpu/drm/display/drm_dp_tunnel.c | 2 +-
 drivers/gpu/drm/i915/intel_runtime_pm.c | 4 +++-
 drivers/gpu/drm/i915/intel_wakeref.c    | 3 ++-
 include/linux/ref_tracker.h             | 4 ++++
 lib/test_ref_tracker.c                  | 2 +-
 net/core/dev.c                          | 2 +-
 net/core/net_namespace.c                | 4 ++--
 7 files changed, 14 insertions(+), 7 deletions(-)

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
index 8d9f4c410546e4144d4bc8bbc6696f3bd9498848..90d90145a1890bf788e789858ddad3b3d8e3b978 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -59,7 +59,9 @@ static struct drm_i915_private *rpm_to_i915(struct intel_runtime_pm *rpm)
 
 static void init_intel_runtime_pm_wakeref(struct intel_runtime_pm *rpm)
 {
-	ref_tracker_dir_init(&rpm->debug, INTEL_REFTRACK_DEAD_COUNT, dev_name(rpm->kdev));
+	if (!rpm->debug.class)
+		ref_tracker_dir_init(&rpm->debug, INTEL_REFTRACK_DEAD_COUNT,
+				     "intel_runtime_pm", dev_name(rpm->kdev));
 }
 
 static intel_wakeref_t
diff --git a/drivers/gpu/drm/i915/intel_wakeref.c b/drivers/gpu/drm/i915/intel_wakeref.c
index 07e81be4d3920febece34709c63a63204a41583c..21dcee7c9a659ac1fb0aa19f3018647be3bda754 100644
--- a/drivers/gpu/drm/i915/intel_wakeref.c
+++ b/drivers/gpu/drm/i915/intel_wakeref.c
@@ -114,7 +114,8 @@ void __intel_wakeref_init(struct intel_wakeref *wf,
 			 "wakeref.work", &key->work, 0);
 
 #if IS_ENABLED(CONFIG_DRM_I915_DEBUG_WAKEREF)
-	ref_tracker_dir_init(&wf->debug, INTEL_REFTRACK_DEAD_COUNT, name);
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
index be97c440ecd5f993344ae08d76c0b5216c4d296a..12cf4e5ae9c5437bcfec657e37b7e08792bc14bf 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11715,7 +11715,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
 
 	dev->priv_len = sizeof_priv;
 
-	ref_tracker_dir_init(&dev->refcnt_tracker, 128, name);
+	ref_tracker_dir_init(&dev->refcnt_tracker, 128, "netdev", name);
 #ifdef CONFIG_PCPU_DEV_REFCNT
 	dev->pcpu_refcnt = alloc_percpu(int);
 	if (!dev->pcpu_refcnt)
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index ae54f26709ca242567e5d62d7b5dcc7f6303da57..aa1e34181ed6f353921a23411fa227b612db661a 100644
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


