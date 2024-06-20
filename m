Return-Path: <netdev+bounces-105487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC189116B9
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 01:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B8BE2837D1
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 23:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902C914C580;
	Thu, 20 Jun 2024 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zq1cek3C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B00814A615
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 23:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718926154; cv=none; b=Rfkb2P5P1YqTjoqh8LW1FuAoGBSZ8o3qOuV4FJMwbcEEJ5FCy49nYramc8MG8CxHLMs5kdzQDsEeg17goVN6ifXVkYka3TyJB1YsqAG6EYHvgWMw8Vx108sNZgx7jx0sipIVe4LSZMHZM0i5ZvSnCINMkioeWtFkJ9IusLUXkIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718926154; c=relaxed/simple;
	bh=9JErtGL3/Z1VDYeNIUkrIb3x6eLeoWnQLPq3nfQNJeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inMzSy2Jv1/kF9LzzGtIt2UkLNskICB90vI3ZlLpw6s+jrzDZh1pHlkykaofbOWzTOAH3CNfBOobtY91Uwe+oCWEcouqbiMyYTIXBfU3URQsI3qymAszf/adkwISW9ISvy7ja8BfIMpIdxKfDUPsfycxFZz2nxgZW2f7tTd2zyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zq1cek3C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21F0C4AF0B;
	Thu, 20 Jun 2024 23:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718926154;
	bh=9JErtGL3/Z1VDYeNIUkrIb3x6eLeoWnQLPq3nfQNJeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zq1cek3CMmhukyVBFD7OzvdJE6Us174XzQ13axF6x6FxCGaUkd8xlm79xm/qwVklh
	 YAjff7LybnTZPjyR8151KGoOvS6YLUdZKhnTaHlc6JaadzadAoYBeNUcntUGPCuEz2
	 OGKlHj9PHWq0Ia8lomkt0UqhQDHMWhZF+w/81T3dqF0QNkWieUdb/W5bKogqo8sY2o
	 pG2RpaaCXk9zN8akbvemwQdXzD/4GvvydU78oJcXh3AiMlsCGyIYVVUUdeT9Xed9v6
	 lZFovRGYkHb9/R0fbWQEcE4Yhn+ldxvS+UxQYVQ5sex/kbZXZP/PqHpPNUaOg5r6aH
	 th2W08wb9LPmw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/4] selftests: drv-net: add ability to wait for at least N packets to load gen
Date: Thu, 20 Jun 2024 16:29:00 -0700
Message-ID: <20240620232902.1343834-4-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240620232902.1343834-1-kuba@kernel.org>
References: <20240620232902.1343834-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 .../selftests/drivers/net/lib/py/load.py      | 26 ++++++++++++++-----
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/load.py b/tools/testing/selftests/drivers/net/lib/py/load.py
index abdb677bdb1c..ae60c438f6c2 100644
--- a/tools/testing/selftests/drivers/net/lib/py/load.py
+++ b/tools/testing/selftests/drivers/net/lib/py/load.py
@@ -18,15 +18,27 @@ from lib.py import ksft_pr, cmd, ip, rand_port, wait_port_listen
                                  background=True, host=env.remote)
 
         # Wait for traffic to ramp up
-        pkt = ip("-s link show dev " + env.ifname, json=True)[0]["stats64"]["rx"]["packets"]
+        if not self._wait_pkts(pps=1000):
+            self.stop(verbose=True)
+            raise Exception("iperf3 traffic did not ramp up")
+
+    def _wait_pkts(self, pkt_cnt=None, pps=None):
+        pkt = ip("-s link show dev " + self.env.ifname, json=True)[0]["stats64"]["rx"]["packets"]
         for _ in range(50):
             time.sleep(0.1)
-            now = ip("-s link show dev " + env.ifname, json=True)[0]["stats64"]["rx"]["packets"]
-            if now - pkt > 1000:
-                return
-            pkt = now
-        self.stop(verbose=True)
-        raise Exception("iperf3 traffic did not ramp up")
+            now = ip("-s link show dev " + self.env.ifname, json=True)[0]["stats64"]["rx"]["packets"]
+            if pps:
+                if now - pkt > pps / 10:
+                    return True
+                pkt = now
+            elif pkt_cnt:
+                if now - pkt > pkt_cnt:
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


