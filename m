Return-Path: <netdev+bounces-282952-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEaUCI2J82md4wEAu9opvQ
	(envelope-from <netdev+bounces-282952-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:55:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6F24A6151
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 18:55:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44CF0301301D
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 16:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5EC33F59E;
	Thu, 30 Apr 2026 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ey98PURv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68368342CB0
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777567941; cv=none; b=ALBBocnKNea8P/EmFmfllEfU9N0pIDCzpiYr1NZ25uCgzCkDXT1MG7Vt15ZyHMew5KU7uSc/2H4/D87sSe/MpTf9bZ1fbof4Rl30q4KR13U1XhzA6RqYM407JvQYzXs8qpUmMMOLCZdXPrJ3ZKH+Ky+wOe1av76960KP/SpE5B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777567941; c=relaxed/simple;
	bh=5r2qpsebSMkvi3m6XvxmESYtctah89wmlMLrA/0+UFU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mBAGR1PFKGRbEvqR6vbyAHpyTFCDlN4O1tl1GJ2hMIljBdr6rpO89FDShDOtxxsOZ8lVSy6SZklh8f/NgvE5pI8dauNUV4FVGNcH3uT5CG6umzsdFmSPJ8ELM45ywDBs/urLC5B7m2BwCuVZzjYE2Y1yGC22J9bM4DQnT6faCds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ey98PURv; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c795eacbeb0so480776a12.2
        for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 09:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777567939; x=1778172739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yz+m5ys36cUhA483WJwMNGt1SvzoVUKacxRP5e2sWBU=;
        b=Ey98PURvpuuUo/13vjTP9+/CxPA/w7sG4xemOazsJVHhPRpQ2H/uAXr/Zfd0gstPZ7
         zoVIsky8QgZ7je/zX4yfpEWnS+c5CmTgJjJsBTBuzN4NM6OVaDEvMDMIJCXh5fzee8Bs
         wqnCGt2kqHkGB+X8Jolq5FFhxv0+/NukrfD+Vs0ExNMc9RMeS0xCFwmqifvZi/RmOjJ7
         L3IUegXZKx58pe0Vz0m6tD5d0Wa9UKK/dA7mRqSNA31aY/JU9edelt+VZ+TyQNi72Hyq
         nNw3sfxqh9RhuNnMy1EsFm4AB8Ft1DZI7ebdes34imn93dDgBaom7b0OfLcxwCZnGhf2
         cp4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777567939; x=1778172739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yz+m5ys36cUhA483WJwMNGt1SvzoVUKacxRP5e2sWBU=;
        b=hUlfe45ACCywKV2G54UCHGVoQ/3MmPfwynMWcjeQbnreu7VTKR1/gMzGvI3mhGm/zV
         tHA6huHEiTMRaPwtzBCWwsvxenvrkRAceFCUYSWky4eXLk05UD2kEKZVaqkqvVpusH2E
         1nHcF1PHQLvlUd3CrXBcY6mz+6QogEFUm7Vc+L8IJ4wfCA+psulbrPnM8V4wATmYqmdG
         WNyz5+Zpsj5lh72YG5Sc5o5hrTTcTyIr7cApAR/b3tTOhARvCy8okkCyTYcBzIY/3UQh
         J87eudFZwdRI72vy0hMf5tFsIc0JaeRPcNRv2A/1xGNRVZbub77KOojbF/6bulfD+0/g
         cVng==
X-Forwarded-Encrypted: i=1; AFNElJ9dGCnwH81HxitwdkFWBE/RRlMPQMqHHu6WamYrxt1RS9MVneh04fKFe2LEO0SjeaFzmmwpvHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz805ufmNBezKdDge2mdHwa9uHojjpMxtmxMDj8FTv+aMzuABDy
	2Ccwh9IpgSWVW4IqgyKVhuiaxlJNM4heE+MMzhuXojCXkfoq2qKj/ond
X-Gm-Gg: AeBDiese4UC+m5ugp1ixDf0/TU1dzEGlmwa0UFzTs9kRV9XTkgiVr7kLlrVK9QlofvV
	AkFrD2xZ4MJDJm3lSx5ujG9oX4WD9AjEwnsG7e9bkDIMhHIb1gVhAdGpNX3CMhuOP6Zdc1pJTQe
	/KluFWI7VrHxuZ02t4L6ySHG3eqJWYlzIUZeF6cn1qxeu/HM1QrLK0VLK6Di1e1XyMWdvc6GrQ5
	eS3yiA4YXIVyKv8sVa38i91I6VITvRovDN3g1uzj6LUtBKcC2kg0HGXpuKVlYyGJnK3R99uY280
	uzOZBmwvYNwOXbAznX1yHiYzYA7ydGic5SBb2UjiHnr46VG5BVrpZQuy5k8JyJjsap4Frps0diZ
	Yp6qA9AfTbdBVoOIoMKavJxbHmsSO8AXtoSFpPPR79rBCsuW32aa1a1UW6fQkjP0EIYC5F6YRBX
	d/b9S6Vskc3rYx/z69NqfzzXVygwBPDTujWr6oxCM=
X-Received: by 2002:a05:6a21:6d95:b0:3a2:f14a:427e with SMTP id adf61e73a8af0-3a3cf82c8b0mr4540828637.43.1777567938653;
        Thu, 30 Apr 2026 09:52:18 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:70::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7ffbbbe8e9sm163022a12.10.2026.04.30.09.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 09:52:18 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S . Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dimitri Daskalakis <daskald@meta.com>,
	David Wei <dw@davidwei.uk>,
	Joe Damato <joe@dama.to>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Vishwanath Seshagiri <vishs@fb.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Gal Pressman <gal@nvidia.com>,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: Enable ntuple-filters if supported
Date: Thu, 30 Apr 2026 09:52:17 -0700
Message-ID: <20260430165217.3700469-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7D6F24A6151
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-282952-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,google.com,kernel.org,redhat.com,meta.com,davidwei.uk,dama.to,nvidia.com,fb.com,gmail.com,broadcom.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[dimitridaskalakis1@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cfg.target:url,meta.com:email]

From: Dimitri Daskalakis <daskald@meta.com>

Certain devices which support ntuple-filters do not enable the feature
by default. The existing tests will skip (if they check for the feature),
or fail if they blindly attempt to install rules. Therefore, attempt to turn
on ntuple-filters if the device supports them.

Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/gro.py         | 10 ++++++++++
 tools/testing/selftests/drivers/net/hw/gro_hw.py   | 10 ++++++++++
 tools/testing/selftests/drivers/net/hw/iou-zcrx.py | 12 ++++++++++++
 tools/testing/selftests/drivers/net/hw/ntuple.py   |  5 ++++-
 tools/testing/selftests/drivers/net/hw/rss_ctx.py  |  7 ++++---
 5 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/gro.py b/tools/testing/selftests/drivers/net/gro.py
index 221f27e57147..5ffaa7bdbff4 100755
--- a/tools/testing/selftests/drivers/net/gro.py
+++ b/tools/testing/selftests/drivers/net/gro.py
@@ -132,11 +132,21 @@ def _get_queue_stats(cfg, queue_id):
     return {}
 
 
+def _require_ntuple(cfg):
+    features = ethtool(f"-k {cfg.ifname}", json=True)[0]
+    if not features["ntuple-filters"]["active"]:
+        if features["ntuple-filters"]["fixed"]:
+            raise KsftXfailEx("Device does not support ntuple-filters")
+        ethtool(f"-K {cfg.ifname} ntuple-filters on")
+        defer(ethtool, f"-K {cfg.ifname} ntuple-filters off")
+
+
 def _setup_isolated_queue(cfg):
     """Set up an isolated queue for testing using ntuple filter.
 
     Remove queue 1 from the default RSS context and steer test traffic to it.
     """
+    _require_ntuple(cfg)
     test_queue = 1
 
     qcnt = len(glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*"))
diff --git a/tools/testing/selftests/drivers/net/hw/gro_hw.py b/tools/testing/selftests/drivers/net/hw/gro_hw.py
index 10e08b22ee0e..70e76e3888bd 100755
--- a/tools/testing/selftests/drivers/net/hw/gro_hw.py
+++ b/tools/testing/selftests/drivers/net/hw/gro_hw.py
@@ -51,11 +51,21 @@ def _resolve_dmac(cfg, ipver):
     return getattr(cfg, attr)
 
 
+def _require_ntuple(cfg):
+    features = ethtool(f"-k {cfg.ifname}", json=True)[0]
+    if not features["ntuple-filters"]["active"]:
+        if features["ntuple-filters"]["fixed"]:
+            raise KsftSkipEx("Device does not support ntuple-filters")
+        ethtool(f"-K {cfg.ifname} ntuple-filters on")
+        defer(ethtool, f"-K {cfg.ifname} ntuple-filters off")
+
+
 def _setup_isolated_queue(cfg):
     """Set up an isolated queue for testing using ntuple filter.
 
     Remove queue 1 from the default RSS context and steer test traffic to it.
     """
+    _require_ntuple(cfg)
     test_queue = 1
 
     qcnt = len(glob.glob(f"/sys/class/net/{cfg.ifname}/queues/rx-*"))
diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index e81724cb5542..d72b76ba0835 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -100,12 +100,22 @@ def rss(cfg):
     defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
 
 
+def _require_ntuple(cfg):
+    features = ethtool(f"-k {cfg.ifname}", json=True)[0]
+    if not features["ntuple-filters"]["active"]:
+        if features["ntuple-filters"]["fixed"]:
+            raise KsftSkipEx("Device does not support ntuple-filters")
+        ethtool(f"-K {cfg.ifname} ntuple-filters on")
+        defer(ethtool, f"-K {cfg.ifname} ntuple-filters off")
+
+
 @ksft_variants([
     KsftNamedVariant("single", single),
     KsftNamedVariant("rss", rss),
 ])
 def test_zcrx(cfg, setup) -> None:
     cfg.require_ipver('6')
+    _require_ntuple(cfg)
 
     setup(cfg)
     rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {cfg.target}"
@@ -121,6 +131,7 @@ def test_zcrx(cfg, setup) -> None:
 ])
 def test_zcrx_oneshot(cfg, setup) -> None:
     cfg.require_ipver('6')
+    _require_ntuple(cfg)
 
     setup(cfg)
     rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {cfg.target} -o 4"
@@ -134,6 +145,7 @@ def test_zcrx_large_chunks(cfg) -> None:
     """Test zcrx with large buffer chunks."""
 
     cfg.require_ipver('6')
+    _require_ntuple(cfg)
 
     hp_file = "/proc/sys/vm/nr_hugepages"
     with open(hp_file, 'r+', encoding='utf-8') as f:
diff --git a/tools/testing/selftests/drivers/net/hw/ntuple.py b/tools/testing/selftests/drivers/net/hw/ntuple.py
index 232733142c02..ef4604bfa8ef 100755
--- a/tools/testing/selftests/drivers/net/hw/ntuple.py
+++ b/tools/testing/selftests/drivers/net/hw/ntuple.py
@@ -22,7 +22,10 @@ class NtupleField(Enum):
 def _require_ntuple(cfg):
     features = ethtool(f"-k {cfg.ifname}", json=True)[0]
     if not features["ntuple-filters"]["active"]:
-        raise KsftSkipEx("Ntuple filters not enabled on the device: " + str(features["ntuple-filters"]))
+        if features["ntuple-filters"]["fixed"]:
+            raise KsftSkipEx("Device does not support ntuple-filters")
+        ethtool(f"-K {cfg.ifname} ntuple-filters on")
+        defer(ethtool, f"-K {cfg.ifname} ntuple-filters off")
 
 
 def _get_rx_cnts(cfg, prev=None):
diff --git a/tools/testing/selftests/drivers/net/hw/rss_ctx.py b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
index 1243fe426d35..f36f76d6ca59 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@ -57,9 +57,10 @@ def ethtool_create(cfg, act, opts):
 def require_ntuple(cfg):
     features = ethtool(f"-k {cfg.ifname}", json=True)[0]
     if not features["ntuple-filters"]["active"]:
-        # ntuple is more of a capability than a config knob, don't bother
-        # trying to enable it (until some driver actually needs it).
-        raise KsftSkipEx("Ntuple filters not enabled on the device: " + str(features["ntuple-filters"]))
+        if features["ntuple-filters"]["fixed"]:
+            raise KsftSkipEx("Device does not support ntuple-filters")
+        ethtool(f"-K {cfg.ifname} ntuple-filters on")
+        defer(ethtool, f"-K {cfg.ifname} ntuple-filters off")
 
 
 def require_context_cnt(cfg, need_cnt):
-- 
2.52.0


