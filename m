Return-Path: <netdev+bounces-281416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPDTCweW72lyDAEAu9opvQ
	(envelope-from <netdev+bounces-281416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:59:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E70476BF2
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62DE63037C02
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9513A8752;
	Mon, 27 Apr 2026 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EzvFW8zb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7004C3ACF0C
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 16:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309112; cv=none; b=eKTJoGPgrsbSi2qwkxUMMoOgXIJAHTOLEAFsq43+gigMo5mkF8NlnkekyynlPXSoXEaZGnTdTx99Y5rUCnROBo1Ec2yDehYR2+ptfFucbBuSeC0LklkEIKs64KNn6VtGxPPXqqDds+aLnBWuX1+qqLs9frLHtohQJ3LXn7BgsXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309112; c=relaxed/simple;
	bh=e1/oREPtnTA4wQq1Eo3tpgKolZGF3xNH1nO8YibBpOw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a5zOqhdXdfpjxrpX7Z9Wbw+xH06qjCH3HtbIhL44j7Bi0TGVMcNsOBsBW8v5kNhM7n42kFJfS/41Hu026R46hcLd335FwdoGZ9jSoTYS38RxQ1UmDm0HIFi0LUUR7WTopyAUwtxs+Usyd2P3AaL+NzUXOrhTQXdH7m9S1HVfS1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EzvFW8zb; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b2589c26e3so97846985ad.1
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 09:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777309111; x=1777913911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=luKCj+y68VOjQ8iKhNLUrEYAVZHaivtKkauGwWPaGIs=;
        b=EzvFW8zbbxdN4KNg0QaQhHuy5DDHEDrJigQfyan5K9LRzVAMEXJEDIY4g7BFTRMnj4
         V/rsn3P+tqgouoy5ojHnPEb6GpG45FRa7JxKZk8ZwOWZfZEYqSBgsrEKw3lHEfGLB3D5
         daEMVSt+YwuIXMmhW+mrotm+abHtM6INVVDB4kdFWJnYQqSaZ/YaCl3QtoMRqxjmZuIp
         89SMf7BAQw+VBU7P6ygtp+G8WnOKkhLA1kDE/OIOmcA9mihhcqB4ldkt4kJI1SZm8LFV
         os7Nniu3wJtuPONb68leUIqZlU9BWUzMgub9+FW0fTaOHdWjpQI5zT20jeJMTURokh6c
         12XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777309111; x=1777913911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=luKCj+y68VOjQ8iKhNLUrEYAVZHaivtKkauGwWPaGIs=;
        b=kt0XiDIqZNaDXQhOuImomE9xM+Fx9/gCP/hH9JeZsllQzoI9eP62edx3BhgCcwK1ns
         FNrzATUXu/1fVOF4rDF8Q7VyJAwsrrF4AvwlLwXpRsonR4ab3ALxD5SEuXoohowxOC4J
         FGU/TnFieq8MumiwoP2xD2FmzG1QuHboHOp3qjTjeNOQwfxMdfuSYTWgv9yQ2EBY85YL
         b/Y0MUqhZVA+5cospE53mb+i8uYeWXCg7b0xmZXBn24/WVYOmhEG2WCYurx/Czg0WtE2
         Ma7FW05EIUuxlp5rLRCz5sc9NolHvGFs6okHE+Cut6uAALL6mfdflRoqaU4m47fTAjut
         1uwg==
X-Forwarded-Encrypted: i=1; AFNElJ8kkwXYLxM0XfQ5p7FWkGEwIG8ZnfS7k7shBq6d8EQ+oA51OQ23LzvXzhzWsCCMezamEZ2cXg4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0R3pq0xt+4H8nvnmmFofuMaYGzK/isFUfn5f0mk44q6DLpuEp
	XLPLf67xeExgmYkQ8pSr6+8dqaWFEG/VgH/EIZL06EAn3iS4zoofCqFt
X-Gm-Gg: AeBDiet62sa153DKR4k4qLBCTkNix7wjRE4Tz94NvIn/orDgTBbaHGBrRkH9MZE7Bpa
	2zIVHWqwfabZ4zdjlMfsdrv2ScPYAkRYj9cio/iHSObJXPVFEkDO1nLdilGnKHLyRINjfHhvZ3l
	7kZEk9AobkWqSLtn+bOTKW/YhKMuW755dxXgYVkkrUb9oL3HL0qTuwireSkq8vmOfGsK3sRgPGj
	HoFm1EYBKgveSejUzFy8S6zgC+PFrMsdjeBUjc4aTxiNVrhSUDAPSlB66H8tmDy5k64WkfWVVTR
	9FCNtACWf4mEWBQaLg2KOkY9/r24ga09Lc7DKQLkLNQXEbw7vbrEHe9hQhVRdeggHl3W1UqBBTQ
	xW492FoSiYf9N5gAjhN6kXZxhoHp1//Ye11KFZdS+icfCxIFkduvuxFW0nm3QNaEz3RHkZ+5w+q
	LeMDmB8SNiwHfWs26xezcNJ5dU5AGf//CdsGAcUQov/2Lw4NJRCw==
X-Received: by 2002:a17:903:1b2c:b0:2b9:7051:2c18 with SMTP id d9443c01a7336-2b97a6b4984mr895215ad.0.1777309110537;
        Mon, 27 Apr 2026 09:58:30 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:4f::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab32cfasm399066965ad.69.2026.04.27.09.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 09:58:30 -0700 (PDT)
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
	netdev@vger.kernel.org
Subject: [PATCH net-next] selftests: drv-net: Enable ntuple-filters if supported
Date: Mon, 27 Apr 2026 09:58:29 -0700
Message-ID: <20260427165829.3898229-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 93E70476BF2
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
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-281416-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email]

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
index 51f4e7bc3e5d..62dbc2ac7841 100755
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


