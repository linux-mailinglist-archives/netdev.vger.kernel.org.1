Return-Path: <netdev+bounces-187800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD927AA9AC9
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 19:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5157D17AC5B
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 17:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97E54276046;
	Mon,  5 May 2025 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AcSYv9qL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E70927602E;
	Mon,  5 May 2025 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466427; cv=none; b=OXjJ9sGwDWLNR+VkZPGjLkhlDj5D88D+FZGZJu9izqxd17Y19HICnDs6TiEPkqU7m4INmWJ1YXVKaSFFu+gBm2UHTiO2NffGnTQvtFUd5LJEY9r1IeXrA8BaZoAdhHpfVzlTC+tRPCL0R4dlz3i095Q2VDQ4mZuiWg9S6TjXozE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466427; c=relaxed/simple;
	bh=LUr5khTFmeDi+Ua8+P5dJsfAbjq9HmURsDGnKrGJrGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S57wDj4CRDZ6sb948FBhL0YG8Co4bd3bNi/gWGmmtMy7EX1DL7/t98SBZFsbxUK6mPbT+sbQh72GgFz0bajNaxHAbCEraBzQIWss9B0IWnkFXN/N2apJ/JzAIhzGQcL9YTuj5vWc5KyWFyU/WPP0zCrUhNK7jTQsl4xUhU4NIZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AcSYv9qL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AAA8C4CEF3;
	Mon,  5 May 2025 17:33:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746466427;
	bh=LUr5khTFmeDi+Ua8+P5dJsfAbjq9HmURsDGnKrGJrGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AcSYv9qL9QxetukxyT6UauCSZR//wxaHjcUeh7lWEJWAJWkanBFIoA0xfl8gf+m4r
	 KPNQHMa2e4B/YDfkKnejR5MU4B8lTMMYsQqf+u9/p2QYP3oWMXbtobj7VXdC5L5lsV
	 U66FtwjO74jyrC0wp5UUWKbetuRTiPiJf8tOifjVCSI1HwkD9QJmtIImFjrIQa1dIg
	 2CqRReU3xQK1tQA1ykeMghhaK/H5+mFcaAJm2yeiGhD8Z1GxE0Mo92+WBxcmBlA1TB
	 aLA72+9SDzAFAvh1AkhcMHZZFVeN2jq8JI4XvNYt4pzCXyhB591p39tObsq8gs1VB9
	 8epbkG/IPMSAg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 05 May 2025 13:33:23 -0400
Subject: [PATCH v7 09/10] i915: add ref_tracker_dir symlinks for each
 tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-reftrack-dbgfs-v7-9-f78c5d97bcca@kernel.org>
References: <20250505-reftrack-dbgfs-v7-0-f78c5d97bcca@kernel.org>
In-Reply-To: <20250505-reftrack-dbgfs-v7-0-f78c5d97bcca@kernel.org>
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
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoGPZmWmFz1ESaZFMQZZ6Qr0A+Q8I2qE3VNQO5z
 5egiMFJBtKJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaBj2ZgAKCRAADmhBGVaC
 FexjD/9hLcEg6DYxJ4wVEmKQpEYCCS5MFN450o/uGUbvLOPL65lanJhTpwz4tBupWcVyfavCrhP
 Tt/c7fyR36PQ+beppoY8fiXHWm59g7o7mt5I0ryBFicV3nacxZ6tfr0s4q+07zDZJ1DHh+eMr6T
 IpDtC67gA/XH12NPlwtelMR+NlLt0oNAJLgutDhgpy4vhBPFG5UgJz/H0k83pfyWPb2tR1qIn3z
 VdQovvR54XulStcp2feTuKmAEdiACBohQ8YXwdTSATF0eMezfqoaIOwSRSzSqEHQq0IgC8d/eAq
 xzGFdFuzMlS2PoXSdi61Ryh36uDryiFrRmNQR8klFVeetl5/o3oaM3zzq7c+DTcDWjNqcUudbiG
 /1evAnet8XPTtR/rJdupyhDC1qoTAKKLtxy37FbOhBYPKtkTCiMd4Wj/Qe5g7PDgum53Sz5tM1T
 T/sAtJKLIG5gHO+Ym/cElPz5awUx5eeFON+rlVufu6Uc/HwL9ZmPxE4c4+XelbL45TbWO3WLzyh
 lAVCKcl8ThPheW2laaGu6k0Ctxu69Bh/jJ3YEChT2shXDNEFmXeT/WiqTLoGDEiJ+C8mXRFLcw4
 SMze8aBLpL7uwg2yGyaDW+VskVR/r7JogFdA1gQgfZ3h/zWdFD0QQRlQHTzpXxhiq5M+b0QXIom
 oJHlLwY+nW2sqcg==
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


