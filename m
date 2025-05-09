Return-Path: <netdev+bounces-189328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 029A8AB198C
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 17:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7ED21C46DBA
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D624242909;
	Fri,  9 May 2025 15:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/1Z1FF2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E222417F0;
	Fri,  9 May 2025 15:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806085; cv=none; b=SoddLC22WQ9gXopUYioT8tBvnhUfunz+ZFOzuzIZZneuVpQCuPqDS1nrV2V+0BokaLxqtx3mPIwhbvJJEvgBGICByokQdVdNFQZRskypDYPSRKQ55k+uScj2n6K4melJOFp5ulk16T4IAxq3YnjehSKujtMHU5XM1KJfcnK8wf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806085; c=relaxed/simple;
	bh=Les2Q1JDGDchAASaheHbCbzDsZvfcnT1V7XgBGKxhhs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JJzC3SnHlmPqzEr1sgrbrHrhsQELJr+pMGHOqbMKllECd6QLijyZIyBPfyPz9LPYDNmCkmfvT2HXDZ7EWrn1NF92YanvHeyIBQelYD8dsCjVgcAJQ2XDkVjmdW/iNch3h6uQZE7USqql4A7rK6lb/jnPC5GwVh/ai4/u3WBaNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/1Z1FF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF7BC4CEED;
	Fri,  9 May 2025 15:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746806084;
	bh=Les2Q1JDGDchAASaheHbCbzDsZvfcnT1V7XgBGKxhhs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G/1Z1FF2sDlh8rzNTtBhbPYIpla0iT1GaPO57MPPrbIvXy1+h38PirspvcoWIyjJ7
	 AbcSD550VKMMjXQ22K+NyEPy1k6X6sTQY6nVMQ1xc2EKZQRnMk2Hvp3LYJ60UPdovs
	 4HYXWX+KycCl22/wbaGaWqCXgXJpwtm7Ey1/iWVPwAJjE8BiddUwIKu1m8wythLgWs
	 f7TLz7ZkioQhJWJ9RlaG6eRY88vect+hVl3V6G/7EmYSkth3rbY00yUlyOtdXGc/Et
	 FqkK81zdYkXge/373CLUCNnOdhTxO1dH1CqTXqhEhbukG5lxvpwUFCZozlE9XSaBrj
	 KUqFJau6vZU7Q==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 09 May 2025 11:53:45 -0400
Subject: [PATCH v9 09/10] i915: add ref_tracker_dir symlinks for each
 tracker
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250509-reftrack-dbgfs-v9-9-8ab888a4524d@kernel.org>
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
 Jeff Layton <jlayton@kernel.org>, Jani Nikula <jani.nikula@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1532; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=Les2Q1JDGDchAASaheHbCbzDsZvfcnT1V7XgBGKxhhs=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBoHiUwgYXNMuLWTr7s6QnRaLRoXJ0I2i/1kYd1u
 w+TY6LosRKJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaB4lMAAKCRAADmhBGVaC
 FbuBEACyCMSaZdQrb5+qfWbknXd2TSel14YSmialcBJY+8oYVkleiO28T5yl4M/TqgXhUSuTzJ4
 SWSiCysPWTP7wGowlokclp5TRjSjd/sZkhLyGOqpt4nB0v6JgdIeGujIqdVRFrajC2HEjmLwauh
 dl1eAiZpKv9soPKhFROa17/XLgFlkWNRBHtE52GBpA+YIKRsF/JrarbIXKu+nvhUuOJw7V4EZ2l
 YZWBjgN6q8O9abfP42+99yycuYjV+kft4+u80Tu9rM46ABTwtTreS7fL4n/EugPIapSbAgy4aq8
 OkX8cSYqGP4kvE6soX5mAh6gnf1zoD5KgCj0MRRlHFRNhhsqobsOaxyrmHpndZOGtaW3XOjBAh7
 rZKpaGAlnEGjcooGs0FxK0Ml/EN2x+YCan1ywIxW2peCVeipH9PKKvv7gHrGTw5ONXomfDx9UZ+
 oiZtILhxYnM/vzkDjFOblcM/Qi6MpdR37hJnXpmJsp7pyICslcMPmLZNrtZm/ZDLxFfacX5SXP7
 aCLb5BmBemu5qzMl9OINqd8Sxz4m4oyjvqN/LASHueGnm9QA58lXJJ101Sm7cyGPMVLmpr75mOo
 W1hjzTVkKEgJLXsN+ZAz1Xa5tJZR/M27GMDuM8tgTIur8DB4JXujXPYz0oV1vI84ykb+MiO545G
 rpoBUFbP6rgwvTw==
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


