Return-Path: <netdev+bounces-193983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD8AC6BCA
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 16:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376A71BC0E55
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 14:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4648E288CBC;
	Wed, 28 May 2025 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B/G2qhEf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC11288CAF;
	Wed, 28 May 2025 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748442891; cv=none; b=EIlkk0W/GFVblRYMduCZ6rBW7C3338rzHkkmglclpSd4DNXMIagvoqtyAdEtDs7yJObHXxj8z4Z3f/IXNbY1tZkZZJ461UKwBxThASEi5AbZzgdgjrKCKGMTIHZAPfdhLb+sVwU1YU78BD2mSRWBktGGDa9odQvZzOWieWd0dN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748442891; c=relaxed/simple;
	bh=xcaFZVbsEvJyxxrP8wl5wB3qpU0YQ92i4Uv2VYSOZus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tX1b/O+1MHFFzSE5mFcIbZMjxKfHCe4DvQFLkqFFtHjKD7wZZf+12fvL6V7FIgYKbU2MVniKSazPxf+XhrCiPa03pqaimODqZ7+eoOfe//gk62Gx0x31zFlM6cmdUO0Up+8RQavTuRlioNlGiwHfOxJ0f0YcTd/pzo3/LZZCsb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B/G2qhEf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF92C4CEED;
	Wed, 28 May 2025 14:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748442890;
	bh=xcaFZVbsEvJyxxrP8wl5wB3qpU0YQ92i4Uv2VYSOZus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=B/G2qhEfNssorY7U9YWyXBSF7siZDygdMbGGxq3Z1zMJG1BOR6WnZJHoytMqI6HMA
	 Jv6kwz9FIZEzHSvHjG+622OTB/CQK4fL/nJ3TQ0/Jnjh+f1w4t5MKbHrQMNtZsaXvU
	 Edwkx2rs8uiYpN4VBBmwr6YarYl+L6+LkS5TStvuDEI536z9IKFG4dQJoKhbSwbJj3
	 jnc5K0/IC94l99/xZP8liBxOCibFhq+nfibRak53dL/yVUQnlhjgnGJtX9GtNEXAXs
	 98Mn1XX1DgV119J3GDqSCYg8jcyrNHscE+4chldrjM8IcmehLDIVy4MovwNIaps+z5
	 2EZfxIpGMV1rg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 28 May 2025 10:34:33 -0400
Subject: [PATCH v11 01/10] i915: only initialize struct ref_tracker_dir
 once
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250528-reftrack-dbgfs-v11-1-94ae0b165841@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1979; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=xcaFZVbsEvJyxxrP8wl5wB3qpU0YQ92i4Uv2VYSOZus=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoNx8EmI6fWV2Eg8Xc7r5K/kMheNd8UdmOtmoO3
 tlVLfOHahKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDcfBAAKCRAADmhBGVaC
 FbGSD/9jzwiUc0TWPeNT+GglWj/jlFf8GvvgXw380X6AKkj9UkpMXvsNnjcHnLVrEtdetSkTa67
 0P95tMf5mkiIf9XnYUBTyEcX4lUdPd2u4abq3MGbVpWOM+I1b2nbRl+OgSqNlnZEPnLeshSDqWW
 Seqpn1O3eD64B8a+Z7LwoAtDcT+zyvrJL+stNAHG3862LEL+Z0oM2EaXzYanp8Gta584DmX126s
 q0KynOEuesl4MPcWxsrXeuTlo2r/e5NFR03fdj65XU6PurTxRfSx0qeJhvqUnk+GL/uk99jaLVi
 bT2jX4M7ZDzJ01dMo5aQ0+7NHCFU/XPSQmGsNcr0L51DzYrtQLY2IceI03bu2uxve8bw8CAD6Lz
 umSxnAZw3JPlW3y8/HpE3Z9GSFuE5eK4ZBLLZQI4YoePaj8X9GpjCsUqNdBH3XQTcykWfttlL0E
 X/Wk6+v/6uwHVBKIiXp1PiH86jscrzXxXMvSmR8dzgeJfHeEqxPQGagtt30bGHdWhZpZTPrOc06
 ZNBi4Gr4jj3vnXFNFNqKnn20TvarkHh/8pkECDEqJjoO3kC6vg7zrAileGhwJelCMTzrLsX4Wrg
 6FkJtAnd+wlZqn3zJFa4LQ5HZiHGJi6PPeYp16L4iSnL/XzzvsySBsouY5Xc04Vu/BBvIdmnGyk
 vwygWSCqB3E/RRA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

I got some warnings from the i915 CI with the ref_tracker debugfs
patches applied, that indicated that these ref_tracker_dir_init() calls
were being called more than once. If references were held on these
objects between the initializations, then that could lead to leaked ref
tracking objects.

Since these objects are zalloc'ed, ensure that they are only initialized
once by testing whether the first byte of the name field is 0.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/gpu/drm/i915/intel_runtime_pm.c | 3 ++-
 drivers/gpu/drm/i915/intel_wakeref.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
index 8d9f4c410546e4144d4bc8bbc6696f3bd9498848..1b2ad1e0aef7d317f63a23b39193ea81c90401f0 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -59,7 +59,8 @@ static struct drm_i915_private *rpm_to_i915(struct intel_runtime_pm *rpm)
 
 static void init_intel_runtime_pm_wakeref(struct intel_runtime_pm *rpm)
 {
-	ref_tracker_dir_init(&rpm->debug, INTEL_REFTRACK_DEAD_COUNT, dev_name(rpm->kdev));
+	if (!rpm->debug.name[0])
+		ref_tracker_dir_init(&rpm->debug, INTEL_REFTRACK_DEAD_COUNT, dev_name(rpm->kdev));
 }
 
 static intel_wakeref_t
diff --git a/drivers/gpu/drm/i915/intel_wakeref.c b/drivers/gpu/drm/i915/intel_wakeref.c
index 07e81be4d3920febece34709c63a63204a41583c..3cfd68c98023fef75faa4dd69eba55e093130dd7 100644
--- a/drivers/gpu/drm/i915/intel_wakeref.c
+++ b/drivers/gpu/drm/i915/intel_wakeref.c
@@ -114,7 +114,8 @@ void __intel_wakeref_init(struct intel_wakeref *wf,
 			 "wakeref.work", &key->work, 0);
 
 #if IS_ENABLED(CONFIG_DRM_I915_DEBUG_WAKEREF)
-	ref_tracker_dir_init(&wf->debug, INTEL_REFTRACK_DEAD_COUNT, name);
+	if (!wf->debug.name[0])
+		ref_tracker_dir_init(&wf->debug, INTEL_REFTRACK_DEAD_COUNT, name);
 #endif
 }
 

-- 
2.49.0


