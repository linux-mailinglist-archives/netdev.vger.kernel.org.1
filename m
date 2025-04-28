Return-Path: <netdev+bounces-186538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE0BA9F88E
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 20:29:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE9F1A81FFA
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 18:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2725529AAFC;
	Mon, 28 Apr 2025 18:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMLwNem1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C1929AAF2;
	Mon, 28 Apr 2025 18:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745864834; cv=none; b=nV+nqydElndeyR3mDpdjqf2Nfw/KWjvJHjmKvhVS4/rjTlVnGJ3a+Ngf04oGSfV1oEcok5H+7ev3dGOIHIpQbvv2+y98uiqDPHZHaTaPIG/nsOZh1Qh2XwbFxWBD7pXb0LJoWAHM8r50pjDsJzumr6njKPhNXxmB8wiycLkOcvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745864834; c=relaxed/simple;
	bh=LUr5khTFmeDi+Ua8+P5dJsfAbjq9HmURsDGnKrGJrGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VZ+LQamJ0M7UXsYZ6bZurBLpxbiD8ECg6uxyS5tF/qHuuuXo8gHAANXndXXXD5Gd/KW0OmVAnFgVmAtVOVnwKW4/JX2ozrJPdrCeA8MdS3TU+YEAorIwyWgSAzzU2OFu1p+oQkQewt2dfdxLe5iYn4aNKdc7y+yUBOfzPV7g/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMLwNem1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE053C4CEED;
	Mon, 28 Apr 2025 18:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745864833;
	bh=LUr5khTFmeDi+Ua8+P5dJsfAbjq9HmURsDGnKrGJrGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CMLwNem1Fcc57a738z/tvDNE5PIQWOMMuBlhcebPgLlVA9nYnYadpQ9oTJKD0G9Pu
	 EffEBnYnNQuY0W0//zEB6jFAluTG/ZGGOLR4iGHhUDfHRAN9PUzY96XEfeFe+vuBlN
	 mlxu+/c8Qp2Geo4BjarYfoLWeTo/eIeMlJnW7P3Yi1RWNphh3oazPbawyTJm0SA+WR
	 +fN66ZP23A4HYk1v8UyndZtSLgL1O/vUzmapnYx7EacKrlAtw3fe8N8N/senlsRw7D
	 xr7QWbMY2Xcu/+NDw0QoWAYqY74eYO3iXDosAD1AUa1SDQ+tKrBNBNC0X0ZddBIxih
	 W9D1CptjskySg==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 28 Apr 2025 11:26:32 -0700
Subject: [PATCH v5 09/10] i915: add ref_tracker_dir symlinks for each
 tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250428-reftrack-dbgfs-v5-9-1cbbdf2038bd@kernel.org>
References: <20250428-reftrack-dbgfs-v5-0-1cbbdf2038bd@kernel.org>
In-Reply-To: <20250428-reftrack-dbgfs-v5-0-1cbbdf2038bd@kernel.org>
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
 b=owEBbQKS/ZANAwAIAQAOaEEZVoIVAcsmYgBoD8h2gRjkmyNDtqQz8jGSWwZwY7At/oqUlVT1Z
 iLVbzuEaAaJAjMEAAEIAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaA/IdgAKCRAADmhBGVaC
 FaUPD/0TiwzsG/qKnXlSUou4EyQ/Rhx5C1GxSJr5nJ/vjfm9VJyXyGfyUEQSKJzmf2PcH5G6Xi5
 kqFV4jqEh3d1hQQmtEnfp5j02RAB4qGgHlZITDXJawCu2DBqW1LSBquWlQMnKZg2ceDNTGoXh7p
 ih2SqyMd9i7WyZFtZ8vNpIYttg1+FSgmMnu/vYZ2PjdWrWBPiwNj5hhaYmnljeKqc8YqphfOzKJ
 f7EoF2/fWAAO9ocbMf/6sx/x4IDqSbdGTFPt3ltzMhezteRuXs9/WDKrotUKl02NsaBflXvjZHf
 megsqTfQcMtp7wjdT/2d+ABVlUO3u431g7US+IbXhExlOcdsQ6497b7bEnEzGFfATG6ONf0+k5N
 tVSeNKBsQoz1LxmEnLs3hd5KuyyZoTtmi+5FR0XCyWgyKdhvusLFn5XKeyjuclD42elHcMoWJKD
 LO6Cv56Y8GOHQ/uTXI3Eb0MnyCfw5jLutZ9uIEMc9aJvuKD5TnR4IHRhGwKXeJww3OxgvWbG3lS
 tj6fjuNQ5lQfAvQfWGuC8o7G6HsQUKsgn0CfIEnpKbAe86Tv+ECv4kMn9zcQUY2zw6NKEzQSLc6
 d0vd4uyTY4k77Lgg5lQh6xDOnnlCJsxxc9J9xmAYoHFW512t+k+JKLPzPo8/XIXMOnDpizory64
 qhdlAV0pNa2R6fg==
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


