Return-Path: <netdev+bounces-155068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5285A00E2D
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 20:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BCFC164458
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 19:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20DEE1FCFF9;
	Fri,  3 Jan 2025 19:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVczcvz8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ABF1FCFF1
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 19:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735930803; cv=none; b=Gb6Cp+60rshhzXhGNcLioPOlFEZUuYnT/BwTmh9G8WPFFW87ZvSQEGxnlwDiBsCgVPN3e3YFr8ljIHDuAJBC1M7/CSkJVQp4TwtvDkE20Ze+N5nT/dMyw9dXHzeawsEj8V9iIlaPOXzkdiWlD7TuZa683iodRQWuTgCm67m6PnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735930803; c=relaxed/simple;
	bh=gvHX7VWjxDX0RbahGVYfmherI0/uEt5X+Q/OTPYMd8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eVr6SPqIvu1tvAn2yz+aThFL8KW/dN4yjduy7cxH3cwg8qNwrBS+JTc0qPnEjuaroprZPJvxL+6MybVHmSFbsrdVSPyhW1UxHOQAvViG0plqef+Dv5L/nh85G/PH5J88YiVI3zJyRoX4X0jGo6SoD1zPkpwAi1xAItgif0Rynog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVczcvz8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA89C4CECE;
	Fri,  3 Jan 2025 19:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735930802;
	bh=gvHX7VWjxDX0RbahGVYfmherI0/uEt5X+Q/OTPYMd8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AVczcvz8bFfBsBvvnh9jPNZeO5SuLrWzOQXsFWnGeR0JBVicBK9++7rzRUuioXYNv
	 gcyydoEmM0l0PaSYtUYRknCEQ37a6ewDwpVP3OZUG9prvS16zOO5fjUstDfLAb5gKh
	 LIPW/HVpUngY66mIdOOH4dESDzeZHUhO7juSsK9qfiK+AcE3nTpRW25O8dMMBUk5gE
	 GmySKiDMif/6ZwRRq3TbeCzkE4WpsNQ4TGCN8Q9aIJADtEuzXhYM2RaT/LWIEMCfCn
	 /RT+1vuFkGXlUHxj9XsY3JGBVYc5WeSpu0QqGpLlsDvC3JvhY8cxQNrMnjG9DEq5Z0
	 xfBhX1hVK1uEQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dw@davidwei.uk,
	almasrymina@google.com,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 8/8] selftests: net: test listing NAPI vs queue resets
Date: Fri,  3 Jan 2025 10:59:53 -0800
Message-ID: <20250103185954.1236510-9-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250103185954.1236510-1-kuba@kernel.org>
References: <20250103185954.1236510-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test listing netdevsim NAPIs before and after a single queue
has been reset (and NAPIs re-added).

Start from resetting the middle queue because edge cases
(first / last) may actually be less likely to trigger bugs.

  # ./tools/testing/selftests/net/nl_netdev.py
  KTAP version 1
  1..4
  ok 1 nl_netdev.empty_check
  ok 2 nl_netdev.lo_check
  ok 3 nl_netdev.page_pool_check
  ok 4 nl_netdev.napi_list_check
  # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/nl_netdev.py | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index 93d9d914529b..93e8cb671c3d 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -18,6 +18,23 @@ from lib.py import NetdevFamily, NetdevSimDev, ip
     ksft_eq(len(lo_info['xdp-rx-metadata-features']), 0)
 
 
+def napi_list_check(nf) -> None:
+    with NetdevSimDev(queue_count=100) as nsimdev:
+        nsim = nsimdev.nsims[0]
+
+        ip(f"link set dev {nsim.ifname} up")
+
+        napis = nf.napi_get({'ifindex': nsim.ifindex}, dump=True)
+        ksft_eq(len(napis), 100)
+
+        for q in [50, 0, 99]:
+            for i in range(4):
+                nsim.dfs_write("queue_reset", f"{q} {i}")
+                napis = nf.napi_get({'ifindex': nsim.ifindex}, dump=True)
+                ksft_eq(len(napis), 100,
+                        comment=f"queue count after reset queue {q} mode {i}")
+
+
 def page_pool_check(nf) -> None:
     with NetdevSimDev() as nsimdev:
         nsim = nsimdev.nsims[0]
@@ -89,7 +106,7 @@ from lib.py import NetdevFamily, NetdevSimDev, ip
 
 def main() -> None:
     nf = NetdevFamily()
-    ksft_run([empty_check, lo_check, page_pool_check],
+    ksft_run([empty_check, lo_check, page_pool_check, napi_list_check],
              args=(nf, ))
     ksft_exit()
 
-- 
2.47.1


