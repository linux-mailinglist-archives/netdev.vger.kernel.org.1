Return-Path: <netdev+bounces-194235-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAD0AC8015
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 17:21:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6196A4A503A
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 15:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7817B22D4DC;
	Thu, 29 May 2025 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfblEMqC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAF622D4D0;
	Thu, 29 May 2025 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748532076; cv=none; b=PqibYeVVcqxVV2JmFHTIX9F3NcSeOt+oFFJ37x8d4Cne/hlHOo6uJRF1sounCyqDBr8wsKMX6V2rkhBjJroE3bo0GjTNz3IAZXyhIQv9KIVA+dq+3v16d3AnAkO58dCmgWiREgAWgytnmVqmfmwY9sVxWjEtB3ZKbTi5xE2C1Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748532076; c=relaxed/simple;
	bh=xcaFZVbsEvJyxxrP8wl5wB3qpU0YQ92i4Uv2VYSOZus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vi1GY3i6SzXi86wbvKkt1vQErGB5lulPAKLbM6TKUKSNSwd+q7jIYk1GHvj65DucdSlYrghFNnO+n/lh9C7g0GdCTjn6IhOc1Jv3qS/kUQ5lZlfduEzr+t5BvpjlQb2WRB2kHlH1Br1m6NJioAupGFd44VItQ/f0V2hi9OMNWW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfblEMqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF91FC4CEF2;
	Thu, 29 May 2025 15:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748532075;
	bh=xcaFZVbsEvJyxxrP8wl5wB3qpU0YQ92i4Uv2VYSOZus=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lfblEMqCGjjntqP+1um0GeeAZzdkRronCPNuG3/9DXO5LIJNOhNuZ4VVN2I2F07sC
	 YkCtPhYmJ2DMIDxIATpW6sIY6TFdhT60csCW5dSE/tpjcuo+n/I5KvCyccBKQqPytp
	 15VSYU9JQcr++CLxOcAVEOD6zIqYPptJuH09AeCf+dHIRWy7msFb8Hh+JZ+g6C7Zx/
	 dZ926qDSl4p/Yf+M1TMSDYZQCSrmIR1zRRPf42a9vFoEhQG+ZaUlp5oSx02aBHZzhw
	 grami1z/3sfqW2B3YSLiyBfZYqIKFRDPRk5Bt/Z2DnPFTOL1eX6BG4CJcFqxIQTfSl
	 sceOA9bOHA88A==
From: Jeff Layton <jlayton@kernel.org>
Date: Thu, 29 May 2025 11:20:37 -0400
Subject: [PATCH v12 01/10] i915: only initialize struct ref_tracker_dir
 once
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-reftrack-dbgfs-v12-1-11b93c0c0b6e@kernel.org>
References: <20250529-reftrack-dbgfs-v12-0-11b93c0c0b6e@kernel.org>
In-Reply-To: <20250529-reftrack-dbgfs-v12-0-11b93c0c0b6e@kernel.org>
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
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoOHtlJoeQSp7XCmOWB2Q+I8Ys5r35/tdfxUIPx
 9Ha6LPME86JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaDh7ZQAKCRAADmhBGVaC
 FT0aEACXjOhHIZep0Wr1ZF4on21GzNvpYxrrHMEU4mKeiMCrm6xqX+ssru+3F1XjkLVe56APTUc
 k1n1cVyYmDo0hRJWKu2iqNtnLuty6OObsOQkWWJZRK2jUG1WiLZZwWNQS61414JyVRfdhqOrs17
 stoXxlPAxxVhAgLpJDRy0oj3qSAn7jzlocNK3JbbmWG5D8/mYO1P8nK2jFa2NJKWfPpFIjTn9vc
 3Mby8ZRpGykayY8GqnIMVykioglTIR7qbUNy+AbuXk5L/wHF9T5eCvCAwE3QVTGqwG5LPQXSFeN
 xHPoIGmmIS173L9Ib8CFDPUIFN8BOWo50MZAqqKWEP/l4SgEn6q5MsPfV5L5LYmmzWUSVj8ZW6M
 8aJYkO8CTH++vN9hbpOQJIblvWycEr2hznF/YcE7kQSeIsbwM2KEXGHVJ+ln+3oOX8ej2qlplNT
 vsHj8l+s3U+FYkWsosS2pQEnHxs05mBvNWH4JV5eyP8bpE/0qLnQaAkxpa7ILWYiBkpDibB/PGm
 1/h1S3ZPqK0J8mtGu+wflqotjDRuBe+xd1Qwx0euzgigafbL8rB1/z02j2mHCvNUZprK8x2ujOx
 iM90gyjpme3LszgUslrGFPBzJJwfyuKz2PHSUqS+iztOVXtfRAFzZFAeZbLBE2vY0NCSpDnWP5Y
 amcraq9c1SB4UzA==
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


