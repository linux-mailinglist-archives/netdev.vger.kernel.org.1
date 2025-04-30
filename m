Return-Path: <netdev+bounces-187112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C58AA4FD0
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 17:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 798057BB611
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 15:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB6526A0CA;
	Wed, 30 Apr 2025 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIncw+JU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76730269806;
	Wed, 30 Apr 2025 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746025632; cv=none; b=EebGQ3l3a4RNbVXzhiddC0oeNt26n5Jb316BMQ0sP8rFFmpuoshN1kTf9QShlCx0AVRuBtghDp7p39YvcnkRonGZz01bZNTe+n1cBxG4y01ttch4KTBQ0+Wi353Bd6E2o+rYUecm8xgwT3X2ENoC0MlpPtA+yMBuEXf6au4DfOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746025632; c=relaxed/simple;
	bh=LUr5khTFmeDi+Ua8+P5dJsfAbjq9HmURsDGnKrGJrGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uNH4NYKiBvtP+tPgQKp5uKhqs8hSDcwqnvyWx7wmcK1Q85vR2f57BBnZ7wyVtsh5TEkAmADU/OVVZaF1wEWaWweoANX05YCY+dyb+yKTWtGQfib40h5AFn+rEKzy8lE1Ea/bQdEAermEXz9z2DVCkEHyWZALZ/VzN8uUVkxv2kE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIncw+JU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF7CC4CEEB;
	Wed, 30 Apr 2025 15:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746025632;
	bh=LUr5khTFmeDi+Ua8+P5dJsfAbjq9HmURsDGnKrGJrGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UIncw+JULR396O7QZfyrdatVH1L8iJBNiH7aZTpumnvsny+C0TlcYcRIASTqnu/TU
	 E+zhnQyNLZpHjCbLWM3OeJTl1MIXn9XeytCFEOdW4RaJm97l34nCo2wFcdYdybmDtZ
	 BcN7NzZgzM7V2vYRLGYvltvgyeiQx5/VjqfSh64hM3L7X7HRJibB5xZIYDl4C92L0a
	 FKcZ69JG4J8+MpT2wp9GbpTG3xrmRzjJaxmYjOISMvn+80TDXzan3xjo4E2mkNvBv8
	 X8wgV+2hUeE/BeYJnlKq5UUYxiR8g0QGKq+9759BP4b+4wtDBcpJN22Cj6kUZHxgdw
	 NhGlPh9MdiqIg==
From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Apr 2025 08:06:55 -0700
Subject: [PATCH v6 09/10] i915: add ref_tracker_dir symlinks for each
 tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250430-reftrack-dbgfs-v6-9-867c29aff03a@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1485; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=LUr5khTFmeDi+Ua8+P5dJsfAbjq9HmURsDGnKrGJrGs=;
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoEjyV/8N4BT9kbqBIClZFHdNt0mmYP4nJ9W9Nt
 Q9YrzCvgiKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBI8lQAKCRAADmhBGVaC
 FdLhD/9u59DQA7E9R/z9jUdvpaqGjSDJVU19ns22LWmmWhSpmOgKcFQcu6+Vd270BR/kChw6gY0
 6uqGcPupXfRScg5k8Nz3qcfn3+q/ZQGkPHJeHoyhC8sjzlGPujsWVktBGemSuTRtjwCbYopV0kM
 PC3rzMEmD4/BRbdez/CRbxuIwVWflfSNUZZzAD5gvRvaIPFwpI2yknel7FPS3/wyhTAR2QR+X1i
 2yQVT3r0mYlJjfetoAhGhsuPP5XPmpggvlA1v63vlzeIdVBjbdgevv6i85SaDF4rZqvgKjav2+H
 UL7rJl3wEeIORQRrCP1h1fQKkk6kgtLo7IItzfofaq88Jt69qr6C+jdQ+yPCbQRw+9BVVrArDAM
 1pA7NNvALkho50bn0B2JiZ3Y1Z1I/hHAZkEj5v3/++0zeZLHQn258obo4r1fd8txDbUrSwVhTcj
 jk3bUQpi144MrrpghjtoC5Rxdx225tmwu5IU7megag0VyOS/JgZ2p6EmNJ8AM3dMjtEMtL4Qf3E
 rkdHidXMxuWGxQuqLXx2bLm1eV8fcu0IDRiXcrcnoN2ZK/+gCtqoXLpVwrktDMdFikhzMPE4njD
 bACoCZekNbgK2/qThW8UgcPsTjVyaMOsiZUwmTHXrIK81Y26bJloJ+RwN0p8f+aA6y8D6mvRQ8g
 fgvmwn4kJHtmxxw==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

Now that there is the ability to create a symlink for each tracker, do
so for the i915 entries.

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


