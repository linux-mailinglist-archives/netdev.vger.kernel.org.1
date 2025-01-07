Return-Path: <netdev+bounces-155922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5C6A0459D
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85F06165464
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DF51F7546;
	Tue,  7 Jan 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ad0WrXfJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE3E1F709D
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 16:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736266138; cv=none; b=LilgBzudFO4TroLsdlMKG597IXvjV9yX+8OCJuQom0lk7c3AiD8iAd7yTbdiS0SltVXgaScDc5da1AfNcEXvHHyAQ7nb+HQGAqAqJ3SxkGJ2Jbv1AnT0pzODTY62nWUI87m7fcyZUvQZi7QQrtdXrdnyUvdJ0Q5WVmDAWrWYQlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736266138; c=relaxed/simple;
	bh=ghYOUbYsv1jTLjTl/SdvhL4GpwyJZxRmyp4yAgz2J7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h578UzDcuYmO+fbk0CBYtud9Fd2qPFkpo3MWZQ4JjSZbMc1+33zrm2CXTLjquH3XB5nqO664GM+WawjdLHbhYi3YJ/p/4trZRQt0ZtT26p9CFQBbeCJpIQ/CzrvTk0UvFgJFJuBTg0v5/BtC1iVp5iYgibvU88ADlFuvldN34LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ad0WrXfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1A16C4CED6;
	Tue,  7 Jan 2025 16:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736266138;
	bh=ghYOUbYsv1jTLjTl/SdvhL4GpwyJZxRmyp4yAgz2J7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ad0WrXfJCbkMyUFT+QhEyvS2eQM3DJb38a3fLC4pI0zZAH1ks3l7OPQyFb9OXfTYw
	 lN7XYTJb9BfL8qkrJMu5IQVPGR5AdVXl2mpYoAp+3sDnePH5JvPeUSmlpc+9nrLFBq
	 RYrsCQZ74ObpxHFL/XVD9jQ+oOpq6AWjmr0aQ13RqXJUjloCHXQrx1WPsVvMER7LsV
	 TG8IZUfeUlaeJxC9r0MJA8K4sW21gCRKgCzFicDtfTyf2DKhR3mxyhc6/5W1m5Di95
	 thQ7bgSU7pG6rnF8bs/MkZMSqSBT2aCJ4gOR4iejhtvXb8f+lmwmcVhbt4sY3YPhwN
	 3AC/YmBollxXw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	willemdebruijn.kernel@gmail.com,
	sdf@fomichev.me,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 8/8] selftests: net: test listing NAPI vs queue resets
Date: Tue,  7 Jan 2025 08:08:46 -0800
Message-ID: <20250107160846.2223263-9-kuba@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250107160846.2223263-1-kuba@kernel.org>
References: <20250107160846.2223263-1-kuba@kernel.org>
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

Reviewed-by: Willem de Bruijn <willemb@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
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


