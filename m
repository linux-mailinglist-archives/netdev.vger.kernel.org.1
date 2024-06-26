Return-Path: <netdev+bounces-106724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CFC91758D
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACEEA1F23723
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CF9FBFC;
	Wed, 26 Jun 2024 01:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bV27Y6l4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1360411184
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365103; cv=none; b=r6MCYRlM5T2utNELB8rAfQKEUI7aTTItwbo+mz4t1cfFtlC26TSNpnFcFbCveqZJP6k14R0Y/ZnnrWiYvVqiPAUCtOGmmhPNhjNV+8sLxZO2cT6mFbOml/GNLqRwI+I1EFuw+AxTD/xM/O1ep3neF78qS6BVWF7T0Iyh1jp4UdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365103; c=relaxed/simple;
	bh=P4eDQUsNxCaPDPgPrNZ12gr9owJd8Zo/6MNl01EI2jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l+smz47+A+L2cjxD0PyDCwW5WvjqUyX69fwy8W1krbkb3XdfYO5+p/r92iYnZbVTvMXHXuDf1xIHW16Gi4uy0th5m/7AcRwgoBLv/T/PrIKt/kNr5ohBXMHPJiXqZJPfomLd0AzlFOs7T+Vwzr3JTGftA47n81Op2so23fG55Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bV27Y6l4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7D31C4AF07;
	Wed, 26 Jun 2024 01:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719365102;
	bh=P4eDQUsNxCaPDPgPrNZ12gr9owJd8Zo/6MNl01EI2jc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bV27Y6l4gW4np1P+7LOZ775X+ujfLBga0fX5+g37xVt2e/FJnR/dfuZNNpgGg7UgR
	 gTS8FYK6n5ghIzE8C6gmXmlQeqlxGrl512lJgdCq1eKluWbnB2WmbwoBUzYsJWq/ef
	 7pYMhTR5L9e+iqGFr2E0gFSPI4JE+zedhjHcNHRV1GVYKQ5jBNEh44S3lLiu0CEKkR
	 2isWOLCLXmrHDPdDCWLkctAXqco89QH/06VZE/TeYxkuqOnpsKFIUDo14M6EPZZtRE
	 evimOZPYdzfbWpcczdT/QPrVIcj+oJO6fGCdp0l92u1Ij0DFriQtGvZ4hP5R+TTT5U
	 euqc76DJwaaog==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	dw@davidwei.uk,
	przemyslaw.kitszel@intel.com,
	michael.chan@broadcom.com,
	andrew.gospodarek@broadcom.com,
	leitao@debian.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 3/4] selftests: drv-net: add ability to wait for at least N packets to load gen
Date: Tue, 25 Jun 2024 18:24:55 -0700
Message-ID: <20240626012456.2326192-4-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626012456.2326192-1-kuba@kernel.org>
References: <20240626012456.2326192-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach the load generator how to wait for at least given number
of packets to be received. This will be useful for filtering
where we'll want to send a non-trivial number of packets and
make sure they landed in right queues.

Reviewed-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - rename pkt_start / pkt_end once more (Willem)
v2:
 - add comment that pps or pkt_cnt are mutually exclusive (David)
 - rename variables (David)
---
 .../selftests/drivers/net/lib/py/load.py      | 30 ++++++++++++++-----
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
index abdb677bdb1c..f6bc57eb304a 100644
--- a/tools/testing/selftests/drivers/net/lib/py/load.py
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -18,15 +18,31 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
                                  background=True, host=env.remote)
 
         # Wait for traffic to ramp up
-        pkt = ip("-s link show dev " + env.ifname, json=True)[0]["stats64"]["rx"]["packets"]
+        if not self._wait_pkts(pps=1000):
+            self.stop(verbose=True)
+            raise Exception("iperf3 traffic did not ramp up")
+
+    def _wait_pkts(self, pkt_cnt=None, pps=None):
+        """
+        Wait until we've seen pkt_cnt or until traffic ramps up to pps.
+        Only one of pkt_cnt or pss can be specified.
+        """
+        pkt_start = ip("-s link show dev " + self.env.ifname, json=True)[0]["stats64"]["rx"]["packets"]
         for _ in range(50):
             time.sleep(0.1)
-            now = ip("-s link show dev " + env.ifname, json=True)[0]["stats64"]["rx"]["packets"]
-            if now - pkt > 1000:
-                return
-            pkt = now
-        self.stop(verbose=True)
-        raise Exception("iperf3 traffic did not ramp up")
+            pkt_now = ip("-s link show dev " + self.env.ifname, json=True)[0]["stats64"]["rx"]["packets"]
+            if pps:
+                if pkt_now - pkt_start > pps / 10:
+                    return True
+                pkt_start = pkt_now
+            elif pkt_cnt:
+                if pkt_now - pkt_start > pkt_cnt:
+                    return True
+        return False
+
+    def wait_pkts_and_stop(self, pkt_cnt):
+        failed = not self._wait_pkts(pkt_cnt=pkt_cnt)
+        self.stop(verbose=failed)
 
     def stop(self, verbose=None):
         self._iperf_client.process(terminate=True)
-- 
2.45.2


