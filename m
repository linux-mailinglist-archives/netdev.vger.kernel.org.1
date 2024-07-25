Return-Path: <netdev+bounces-113120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E472C93CAD8
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 00:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214631C22105
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 22:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C35149C50;
	Thu, 25 Jul 2024 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpxYg4KE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D8D149C45
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 22:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946248; cv=none; b=ZGlYRuEL5+jFlXYEU8TFGLQ/21VASWCV9ymHf3f9+dxgnSFH1QqLX9JAcARWuSR76EVUSdhZJHaYcmAc8GfUecLmBBnwsrg2MALvWR0dbd5uCIBb+C7flbCVB2cJvtpxReMEAGyJIULxa16QRbxkI9Nid83FXAQLvP0YcQl4S1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946248; c=relaxed/simple;
	bh=dsSnne8Bi1bYb7EKJ3HIsjhUoGpd07DdslYzg3yiPtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JybUFvCd3G4ncSwjd/pehhZbNRvVZUIw8ZH2GcRNuCPQD84ZNGn+u+UYsX9OTOGWuoiBmN93hQ/qSJcyDnc2/jpnNTZzlnJBhIzwhFa5Wgwm1w0/NjXhIhfVHs4ZaEwD7LgPevlZoChdLj6zDtowEuGpDYflBF793NlMEcHfM4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpxYg4KE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58C14C4AF12;
	Thu, 25 Jul 2024 22:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721946248;
	bh=dsSnne8Bi1bYb7EKJ3HIsjhUoGpd07DdslYzg3yiPtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpxYg4KEwmApU+4KBRKmk2jVvkcaZl4hGD1MA/q3DxE6AL/t8E8i980Mod3lYAQ8/
	 INe3oe3wQ3GrrI6D4C48ZTa60oFp/MHKA5M+kyHhOe09VW8vOSOoDUoCEhHUg+JNzs
	 0uVUnv4cX4dj9RRTZicJO7WvvbNH6lzzbdLWzvsxGbN+pRVZE6Xt5YXW4H91ZyEYih
	 2WngXHGXGfekiJzwqD2J8edLaTPxQVUkF3kYigWsHQs6BrbMIIn4uKb8vkBPeq34TT
	 VCp4hu5HL5HCX7YdLIvjwH8YP3dGqdRyHk2eL30YKS75C0tYS7aGh9fU8YCOnnG4jy
	 bzfOFaNo/LsKg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	michael.chan@broadcom.com,
	shuah@kernel.org,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	ahmed.zaki@intel.com,
	andrew@lunn.ch,
	willemb@google.com,
	pavan.chebbi@broadcom.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 5/5] selftests: drv-net: rss_ctx: check for all-zero keys
Date: Thu, 25 Jul 2024 15:23:53 -0700
Message-ID: <20240725222353.2993687-6-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725222353.2993687-1-kuba@kernel.org>
References: <20240725222353.2993687-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We had a handful of bugs relating to key being either all 0
or just reported incorrectly as all 0. Check for this in
the tests.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/hw/rss_ctx.py       | 37 +++++++++++++++++--
 1 file changed, 34 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 931dbc36ca43..011508ca604b 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -19,6 +19,15 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     return [random.randint(0, 255) for _ in range(length)]
 
 
+def _rss_key_check(cfg, data=None, context=0):
+    if data is None:
+        data = get_rss(cfg, context=context)
+    if 'rss-hash-key' not in data:
+        return
+    non_zero = [x for x in data['rss-hash-key'] if x != 0]
+    ksft_eq(bool(non_zero), True, comment=f"RSS key is all zero {data['rss-hash-key']}")
+
+
 def get_rss(cfg, context=0):
     return ethtool(f"-x {cfg.ifname} context {context}", json=True)[0]
 
@@ -90,8 +99,9 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
 def test_rss_key_indir(cfg):
     """Test basics like updating the main RSS key and indirection table."""
 
-    if len(_get_rx_cnts(cfg)) < 2:
-        KsftSkipEx("Device has only one queue (or doesn't support queue stats)")
+    qcnt = len(_get_rx_cnts(cfg))
+    if qcnt < 3:
+        KsftSkipEx("Device has fewer than 3 queues (or doesn't support queue stats)")
 
     data = get_rss(cfg)
     want_keys = ['rss-hash-key', 'rss-hash-function', 'rss-indirection-table']
@@ -101,6 +111,7 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
         if not data[k]:
             raise KsftFailEx(f"ethtool results empty for '{k}': {data[k]}")
 
+    _rss_key_check(cfg, data=data)
     key_len = len(data['rss-hash-key'])
 
     # Set the key
@@ -110,9 +121,26 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
     data = get_rss(cfg)
     ksft_eq(key, data['rss-hash-key'])
 
+    # Set the indirection table and the key together
+    key = _rss_key_rand(key_len)
+    ethtool(f"-X {cfg.ifname} equal 3 hkey " + _rss_key_str(key))
+    reset_indir = defer(ethtool, f"-X {cfg.ifname} default")
+
+    data = get_rss(cfg)
+    _rss_key_check(cfg, data=data)
+    ksft_eq(0, min(data['rss-indirection-table']))
+    ksft_eq(2, max(data['rss-indirection-table']))
+
+    # Reset indirection table and set the key
+    key = _rss_key_rand(key_len)
+    ethtool(f"-X {cfg.ifname} default hkey " + _rss_key_str(key))
+    data = get_rss(cfg)
+    _rss_key_check(cfg, data=data)
+    ksft_eq(0, min(data['rss-indirection-table']))
+    ksft_eq(qcnt - 1, max(data['rss-indirection-table']))
+
     # Set the indirection table
     ethtool(f"-X {cfg.ifname} equal 2")
-    reset_indir = defer(ethtool, f"-X {cfg.ifname} default")
     data = get_rss(cfg)
     ksft_eq(0, min(data['rss-indirection-table']))
     ksft_eq(1, max(data['rss-indirection-table']))
@@ -317,8 +345,11 @@ from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
             ctx_cnt = i
             break
 
+        _rss_key_check(cfg, context=ctx_id)
+
         if not create_with_cfg:
             ethtool(f"-X {cfg.ifname} context {ctx_id} {want_cfg}")
+            _rss_key_check(cfg, context=ctx_id)
 
         # Sanity check the context we just created
         data = get_rss(cfg, ctx_id)
-- 
2.45.2


