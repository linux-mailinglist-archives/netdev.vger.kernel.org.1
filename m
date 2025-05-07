Return-Path: <netdev+bounces-188639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05377AAE039
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 15:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2EF417DE69
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D07928A3E0;
	Wed,  7 May 2025 13:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tw3CzRp4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CA228A1FC;
	Wed,  7 May 2025 13:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623231; cv=none; b=Db/GCZQPPuU1EyuzLb3fE4YM9z60Pt73O6+W1QwfV/Fgv8YWhG3TXmyWyKZkQ0UlZrN1A6Luj4MKyzpkXlRg+wBfgPlgB+6YZtpjAl/xANEq0aNo7xQh+ee0RvdEwxZpspZmd30LBE9ic9+PjNhP/Em3O7uS7GVnJhKSSSvpXuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623231; c=relaxed/simple;
	bh=Les2Q1JDGDchAASaheHbCbzDsZvfcnT1V7XgBGKxhhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pY5F6olhJkXFemHBnT7gjumA1UgzmDGA+hCCTc3HFNvcOUsuboiXJzsNfKVB+5Gzeh4IRiACuV0B5iYvPsoCsYEEVcSsKDFGi4AbOtHREvmPGCA8bIAh9S3ihBmooDoOJRz9axjqa74LWFHEgFRS9BAgUuOYYNZoHjscG+Fn2io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tw3CzRp4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A75C4CEF0;
	Wed,  7 May 2025 13:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746623230;
	bh=Les2Q1JDGDchAASaheHbCbzDsZvfcnT1V7XgBGKxhhs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tw3CzRp4L3LQr5czxN2kUEnEz0LL5mCdcY1maVcQFzv9DBDF1O0c0smvQkaSmXiBq
	 LEVJ+ON+Chyo0MWcRso6HsL5CIzE8sAeaJY6qT6pSWC57Z33cR7TpaQFS7jCFPBVdF
	 PC4A+ot/1i9kNVXX4ClXBmgyqi1MHY3/EFMDiUxbjsTHvM+jxIhBI8Pq6gtSTmI3V9
	 6y98wWiqYFkT9BHEMCMjkgAoSPh4Clc23eg30n2VJuVUbGthQB1FRvUyHwUxiNUwte
	 A4xfB61VQxt7A4bcD/rNF1E6B/XWT8S+oTPGlpHt9reJPjESuzwvdm8x/SHS1ioB2t
	 in5yKCR0iOsYw==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 07 May 2025 09:06:34 -0400
Subject: [PATCH v8 09/10] i915: add ref_tracker_dir symlinks for each
 tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250507-reftrack-dbgfs-v8-9-607717d3bb98@kernel.org>
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
 Jeff Layton <jlayton@kernel.org>, Jani Nikula <jani.nikula@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Les2Q1JDGDchAASaheHbCbzDsZvfcnT1V7XgBGKxhhs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoG1rpnQ80pXEoPAGYv6tv9H2PzPm2jcqdwBtyS
 QaXU2VToM6JAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBta6QAKCRAADmhBGVaC
 FePeD/95w0gUIXb5xCFLvY2PHFN0MuH9m318jSFEga+naOGgx6O/OZfGaiHphb/rKy9bdRcABUB
 rlWJP9KHiqSy9aKzsPn8JFJ2LWiSY65wesScQDh+RJAYiUPtBhFQbzgn7J/ADdFmQenqRFZKTKI
 vSJ1Bp/CpJ78Jmwv97kaTCMudRR2oNIKlixRFB4L0AtPLuYVxcMXcbjuSSIt4OmRw33eGfoBKED
 PEF45CLu/qvRISjL0xdHjmrlD8u88Kb9Omr9/1+mxua+XPc7FBUoLJdo85cO8ExUHM6PZGdwXTA
 RlQjPIvdjT7a01OB+c3dkn6hmr3T2Uhv8mQmV8y9px/0Ic30ATlA5tsB1uXuhldeBiUs+u68/zT
 FHpNVlmUQ85DF1s68uiga6V/Vn+39ogPxNTSZUXZ8GiHPntNjwKuIWvtaeoN+YSZ86ruriFZwYy
 Wh4p0hKrU/cAkX+3fVFp/+tiNV7oju5IleRWV33kB6XpMwcvq8fBUTcGHY8JMT+OBYSZzqDQv9Z
 UTv2PqtPgb1o4/z8B1hb8CX7Us6ClFkOvDpKfrUky30d06sIwX8JK/1UqXmV6E9sOj8KDCXs6YQ
 Tv03mBEeIS2iHUCzs4f0OnNb6rCYQtDGQsnDHF+i4dbifSXZEzRNL5IlOg/VclSfd9ToJOgVk1h
 ypVGb5sVS1Sv4oA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Now that there is the ability to create a symlink for each tracker, do
so for the i915 entries.

Acked-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/gpu/drm/i915/intel_runtime_pm.c | 1 +
 drivers/gpu/drm/i915/intel_wakeref.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/i915/intel_runtime_pm.c b/drivers/gpu/drm/i915/intel_runtime_pm.c
index 3fdab3b44c08cea16ac2f73aafc2bea2ffbb19e7..94315e952ead9be276298fb2a0200d102005a0c1 100644
--- a/drivers/gpu/drm/i915/intel_runtime_pm.c
+++ b/drivers/gpu/drm/i915/intel_runtime_pm.c
@@ -61,6 +61,7 @@ static void init_intel_runtime_pm_wakeref(struct intel_runtime_pm *rpm)
 {
 	ref_tracker_dir_init(&rpm->debug, INTEL_REFTRACK_DEAD_COUNT,
 			     "intel_runtime_pm", dev_name(rpm->kdev));
+	ref_tracker_dir_symlink(&rpm->debug, "intel_runtime_pm-%s", dev_name(rpm->kdev));
 }
 
 static intel_wakeref_t
diff --git a/drivers/gpu/drm/i915/intel_wakeref.c b/drivers/gpu/drm/i915/intel_wakeref.c
index 5269e64c58a49884f5d712557546272bfdeb8417..2e0498b3fa7947f994de1339d4d2bed93de1a795 100644
--- a/drivers/gpu/drm/i915/intel_wakeref.c
+++ b/drivers/gpu/drm/i915/intel_wakeref.c
@@ -115,6 +115,7 @@ void __intel_wakeref_init(struct intel_wakeref *wf,
 
 #if IS_ENABLED(CONFIG_DRM_I915_DEBUG_WAKEREF)
 	ref_tracker_dir_init(&wf->debug, INTEL_REFTRACK_DEAD_COUNT, "intel_wakeref", name);
+	ref_tracker_dir_symlink(&wf->debug, "intel_wakeref-%s", name);
 #endif
 }
 

-- 
2.49.0


