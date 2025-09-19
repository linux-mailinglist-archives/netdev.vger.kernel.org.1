Return-Path: <netdev+bounces-224874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F306B8B25F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 21:56:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 410A57E6072
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 19:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641FE30F547;
	Fri, 19 Sep 2025 19:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IdY+CtxJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E4A322DCF
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 19:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758311710; cv=none; b=qFqCavgfrEawpAUTaV0APKmJN8wfxBnJia3wij6fegaqlpqGAbcNHior9MpLpYVIc+gOlev/6UdK4L9bC/9Te6F9BPrTTuxqesRQVGX+IaQvuiTBflMm8nOT5yg952ZRNLdX1w0lf3pt5dXEFjA1aMix0xgQyt0n/9DezvFTweE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758311710; c=relaxed/simple;
	bh=nwQP+FP+u9RCNSE6WztrdGgKTEygtq+qE5vP0cdfJss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KJaTRuOjNwrW6tvAWq++I8gz6HmHGc97ow80AtXQmW6o6e34H66dPDG52nAn3Jso4XT3aC8iIuarnmSUuK53u7rbDaZWaSzJq658inN2It6994ZhoOvrKXLHn6pE/5e3VaickCelPgIL2Zs9Y/v3TxnfQ3ixOhhRoonUr/HHH80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IdY+CtxJ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758311705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CnZCjqoEahQWY1Uj9sMTWSoFWTsJ1zeUtzuSBvyDx0E=;
	b=IdY+CtxJ/MMOb2TZMbBOFoOpPgXISZcTYb+HVEiK+lNmS+QBAnadT4Ff5mOlihMAZIjGIf
	D9nvqxYGpTtjlEEeYnDBAyg83RvqLxviElnN5l6s/WZUvfgL+AXZp+eEuKuCL3jlJ7aimy
	zV3J5uC/huUNu/1zFtWMzNc2ZTLT9Vc=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	intel-wired-lan@lists.osuosl.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Carolina Jubran <cjubran@nvidia.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 5/5] selftests: net-drv: stats: sanity check FEC histogram
Date: Fri, 19 Sep 2025 19:46:51 +0000
Message-ID: <20250919194651.2164987-6-vadim.fedorenko@linux.dev>
In-Reply-To: <20250919194651.2164987-1-vadim.fedorenko@linux.dev>
References: <20250919194651.2164987-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Simple tests to validate kernel's output. FEC bin range should be valid
means high boundary should be not less than low boundary. Bin boundaries
have to be provided as well as error counter value. Per-plane value
should match bin's value.

Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
---
 tools/testing/selftests/drivers/net/stats.py | 35 ++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/stats.py b/tools/testing/selftests/drivers/net/stats.py
index c2bb5d3f1ca1..d433ac71aa02 100755
--- a/tools/testing/selftests/drivers/net/stats.py
+++ b/tools/testing/selftests/drivers/net/stats.py
@@ -57,6 +57,36 @@ def check_fec(cfg) -> None:
     ksft_true(data['stats'], "driver does not report stats")
 
 
+def check_fec_hist(cfg) -> None:
+    """
+    Check that drivers which support FEC histogram statistics report
+    reasonable values.
+    """
+
+    try:
+        data = ethnl.fec_get({"header": {"dev-index": cfg.ifindex,
+                                         "flags": {'stats'}}})
+    except NlError as e:
+        if e.error == errno.EOPNOTSUPP:
+            raise KsftSkipEx("FEC not supported by the device") from e
+        raise
+    if 'stats' not in data:
+        raise KsftSkipEx("FEC stats not supported by the device") from e
+    if 'hist' not in data['stats']:
+        raise KsftSkipEx("FEC histogram not supported by the device") from e
+
+    hist = data['stats']['hist']
+    for fec_bin in hist:
+        for key in ['bin-low', 'bin-high', 'bin-val']:
+            ksft_in(key, fec_bin,
+	            "Drivers should always report FEC bin range and value")
+        ksft_ge(fec_bin['bin-high'], fec_bin['bin-low'],
+                "FEC bin range should be valid")
+        if 'bin-val-per-lane' in fec_bin:
+            ksft_eq(sum(fec_bin['bin-val-per-lane']), fec_bin['bin-val'],
+                    "FEC bin value should be equal to sum of per-plane values")
+
+
 def pkt_byte_sum(cfg) -> None:
     """
     Check that qstat and interface stats match in value.
@@ -279,8 +309,9 @@ def main() -> None:
     """ Ksft boiler plate main """
 
     with NetDrvEnv(__file__, queue_count=100) as cfg:
-        ksft_run([check_pause, check_fec, pkt_byte_sum, qstat_by_ifindex,
-                  check_down, procfs_hammer, procfs_downup_hammer],
+        ksft_run([check_pause, check_fec, check_fec_hist, pkt_byte_sum,
+		  qstat_by_ifindex, check_down, procfs_hammer,
+		  procfs_downup_hammer],
                  args=(cfg, ))
     ksft_exit()
 
-- 
2.47.3


