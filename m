Return-Path: <netdev+bounces-106299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DF4915B74
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 946171C2159C
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BC617991;
	Tue, 25 Jun 2024 01:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftj7UZxS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B41759F
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277337; cv=none; b=WcQaWnnS8rfTsfCxsnjOK/0O38Kt/1ZSIgnOBxwPuKw5QSv0C2fcyYobKUsQsahOmbj7ZjIqmoOU2+zmPUORW+ybpUY8tDE7YrkBGTUqxUv/8lmSQ2ALpTBh7FUevhqYvqAGst6OR9kaF8y78q3cWbLpC0igCMSX0HpgcpYt5wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277337; c=relaxed/simple;
	bh=iWCdjTfoWwSTy32hpkdOaIMMdcw1GMxmUJIC/EpH8u0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZS+Qfxv33vKilHy4CNkUos1y9wK+O9jz35s2Lh1g4ypeh+kdLvarB3hC/gTjmw7yfmzG7/0/+/X+z4ayCVpA6pjliBigbL4sepmz36wYqHcNHPNMc49epJsOdj1kR+xKs50Ohc0lmIdOIqznaZJVaTH0yoV9c49gfxy5HtMUwq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftj7UZxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65289C32789;
	Tue, 25 Jun 2024 01:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719277336;
	bh=iWCdjTfoWwSTy32hpkdOaIMMdcw1GMxmUJIC/EpH8u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ftj7UZxSR1FyGjOeENFzs3zWv8q7FIEpYUM3RL4uBPjdSGVHJRFlxnMP6ZlrcngMN
	 8SLO7pyPs8CEml4T7r7cMpqutQhq89C5hjivhcOxJcG5ilGAX1woCCwmBF4O7FPjjO
	 MnKDCFBt+ogiWtspGwKzE+YZKJo46qEHdauy32uDJSs74K0Q94CsBDGR0GR4fQom/x
	 /zG3W5FldhYXkhtUYcqXZh8og0tNM4fDh5FdrmiUunRdZdaCokE9EKmLiay9Yc9ins
	 K6I5zLXC57cPxH+nCEKz9YClT9Ya8h3XIxignIZKfXf+HrGKH0cdzRLFM9h5nGUsuA
	 6Ys10/5/CEe9A==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/4] selftests: drv-net: add helper to wait for HW stats to sync
Date: Mon, 24 Jun 2024 18:02:08 -0700
Message-ID: <20240625010210.2002310-3-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625010210.2002310-1-kuba@kernel.org>
References: <20240625010210.2002310-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some devices DMA stats to the host periodically. Add a helper
which can wait for that to happen, based on frequency reported
by the driver in ethtool.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - sleep for 25ms on top of the driver DMA period
   (and remove confusing comment)
---
 .../selftests/drivers/net/lib/py/env.py       | 20 ++++++++++++++++++-
 tools/testing/selftests/net/lib/py/utils.py   |  4 ++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/env.py b/tools/testing/selftests/drivers/net/lib/py/env.py
index edcedd7bffab..16d24fe7107d 100644
--- a/tools/testing/selftests/drivers/net/lib/py/env.py
+++ b/tools/testing/selftests/drivers/net/lib/py/env.py
@@ -1,9 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
 import os
+import time
 from pathlib import Path
 from lib.py import KsftSkipEx, KsftXfailEx
-from lib.py import cmd, ip
+from lib.py import cmd, ethtool, ip
 from lib.py import NetNS, NetdevSimDev
 from .remote import Remote
 
@@ -82,6 +83,8 @@ from .remote import Remote
 
         self.env = _load_env_file(src_path)
 
+        self._stats_settle_time = None
+
         # Things we try to destroy
         self.remote = None
         # These are for local testing state
@@ -222,3 +225,18 @@ from .remote import Remote
         if remote:
             if not self._require_cmd(comm, "remote"):
                 raise KsftSkipEx("Test requires (remote) command: " + comm)
+
+    def wait_hw_stats_settle(self):
+        """
+        Wait for HW stats to become consistent, some devices DMA HW stats
+        periodically so events won't be reflected until next sync.
+        Good drivers will tell us via ethtool what their sync period is.
+        """
+        if self._stats_settle_time is None:
+            self._stats_settle_time = 0.025
+
+            data = ethtool("-c " + self.ifname, json=True)[0]
+            if 'stats-block-usecs' in data:
+                self._stats_settle_time += data['stats-block-usecs'] / 1000 / 1000
+
+        time.sleep(self._stats_settle_time)
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 16907b51e034..11dbdd3b7612 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -78,6 +78,10 @@ import time
     return tool('ip', args, json=json, host=host)
 
 
+def ethtool(args, json=None, ns=None, host=None):
+    return tool('ethtool', args,  json=json, ns=ns, host=host)
+
+
 def rand_port():
     """
     Get a random unprivileged port, try to make sure it's not already used.
-- 
2.45.2


