Return-Path: <netdev+bounces-241017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B77C7DA4B
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 01:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1CFA3352100
	for <lists+netdev@lfdr.de>; Sun, 23 Nov 2025 00:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E22381D90DD;
	Sun, 23 Nov 2025 00:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="KA/kdmTQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D7113A3F7
	for <netdev@vger.kernel.org>; Sun, 23 Nov 2025 00:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763859074; cv=none; b=gWVcOGNcbpqOTOf0EtUxcz8gyDxsYEJJDx7Q3mKX1T/AlPPl+k6tsfdLhbAjyFaJLNKxWOwJ9douoSvcBPA+gqwbs1/8E59Yb33Ces2dL/zn7IWHLGCdb+hO1z/bQUGGo1F0brIrv9vksTo39rApJJowXqcslmt4Kny65qxE3VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763859074; c=relaxed/simple;
	bh=Ig1lK/Pwnwhecei1VzTrt9WosWgBzuGkCQEK1V3+2Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAhL6oOd7DtLwt9zb+mwjppMU2G1t0bV7+M/ZWmo3p15VB8vi2geYJhpv4j34QawF3emb0oThRNUrpjZOAYRHaPOabJcDlNoWCgmVHY61n+5BQYrahI3J1mm2VGAyFfdrOyL44hFlqNfLBw7kuyu8a4MRT8ZjkUjN25FMR0Hz1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=KA/kdmTQ; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-3eae4e590a4so1087340fac.1
        for <netdev@vger.kernel.org>; Sat, 22 Nov 2025 16:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1763859072; x=1764463872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdddjUsrOEJ/NFoBu1ta8xZknX/7x/tr4B8p3DMPG8c=;
        b=KA/kdmTQTD0HWRFAp5BtP8DlztDAHq31jTZLdShmDPFSiVAMD9ZN4hxRc+1UbJuXEo
         OxzvApMO/mHwtuJC1GDT/e/rt2VwxpgfsiOnZOPQ5zWnIX4bR9Kavjcd7iRW4m2Oi0Ff
         XdHA6taKfwLkNpNTmc1jwuohWW0NIzt1V/vV3Hst1Rk6Kx7V65LAqbLMgP6QcxePDHxQ
         0hshB0Xg9qJHsxjqI5qnMki779ptOD+qon+M2OZPIrNAnq1gzJZEGWOEmLq/fZrtQnSM
         QXR9A3ZDAOrQA0SqkUXCddsda4A1+yUtemqaWykE14X+IM3zqe8xA5B8DAksYBK+tPsz
         sRYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763859072; x=1764463872;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AdddjUsrOEJ/NFoBu1ta8xZknX/7x/tr4B8p3DMPG8c=;
        b=WrGGKCE5hGs6IhrhLwzpkieBJKdEyUyyDhHpAnKyOZrfy06DE/zTUR7wSTsjAW9yOl
         ZqMLgtcZbdu9bUy7Inej5o4r9XVX2x5e6SfQ9XUyfGsjVfDelL5rCeY6/ScspxqlZ0CR
         Vdn91Ws2iAdvGvE3hY9vOMxoIiaJRUiNPhIbVQvZ9ZaxygZITXKZO5epbrJvUsF7QUsX
         1si2VK++4mPG5M29PZNaAdwUDq11loGRm9rD3nNaDKlk1ctlkUjaYRVEVm605uWwEVt9
         Ju/Ac5ryy1FOZWxuXaFAaKHl1g3n1caFnr6vW/kkgUouZqGorT3suIRpqlOFcIcKlM9H
         2+4A==
X-Gm-Message-State: AOJu0Yy3/sFvpW3xTGk8OCIam2AzkdVZigP/WM8HFMcQD8d7uQlGBCDs
	YV2Msmek48eCEr2owsXA0uuBD1GbF6g51oCsndmU/9Bqz4+hz+8ydG71LaM6V5tCVzQmjYWE9fS
	hQQij
X-Gm-Gg: ASbGncuIGjFVaqUfg1VwQa6zjnykG9u8C+aX74Ttam4YQ/lSKAeb+hUlNfvxx+4XvSG
	tKcEjUvUWWpp6IfeXzifdWRYJPEIj5P+Jf44YfjXX+289JKLG3pawt65/P/32kuevZN4REXzJdx
	h58OHuhfHuFjlixJebxyXTsVC/o0OIPYrL16z1VLdRs7yY1rqewp7sxUZDWkZ6yqFDBMdCwquae
	Nd7v4CdQgEA5DLHQ7MnRgawyrfZE6HklEd0mqT9IDmLHwWlevTbQAJc2rm4/uVt+t0eAulKzxmY
	xEDYr/w0hRuXSe70gRUO7Wg/M+fsFy+gbtk6l/t6NbH4sfSUSCahQAQwVjUAjrm9y/cmHgUSCj7
	S6RI504vPIFN7wWBy5P/Kgvtss+V8b4XRDwvIge1kjbICEq5ayO3/8yMjr+euNL3XPEoIPoj4RV
	VUvYcJv3YodoAyhNLwPCCbidHUrKVL1tItsJ16Cv7G
X-Google-Smtp-Source: AGHT+IEO2a/49GlrN5KigG/1aTrJqxbNHnFGCiOBBCQk49cpbdyMI0Pyb/KTViwa25Si/EOb5mPPeA==
X-Received: by 2002:a05:6808:448d:b0:44d:badf:f41a with SMTP id 5614622812f47-45115aa5f76mr2702024b6e.32.1763859071944;
        Sat, 22 Nov 2025 16:51:11 -0800 (PST)
Received: from localhost ([2a03:2880:12ff:3::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-450ffe65e6asm2721478b6e.6.2025.11.22.16.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 16:51:11 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH net-next v2 1/5] selftests/net: parametrise iou-zcrx.py with ksft_variants
Date: Sat, 22 Nov 2025 16:51:04 -0800
Message-ID: <20251123005108.3694230-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251123005108.3694230-1-dw@davidwei.uk>
References: <20251123005108.3694230-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use ksft_variants to parametrise tests in iou-zcrx.py to either use
single queues or RSS contexts, reducing duplication.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 .../selftests/drivers/net/hw/iou-zcrx.py      | 162 ++++++++----------
 1 file changed, 73 insertions(+), 89 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index 712c806508b5..2c5acfb4f5dc 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -3,132 +3,114 @@
 
 import re
 from os import path
-from lib.py import ksft_run, ksft_exit, KsftSkipEx
+from lib.py import ksft_run, ksft_exit, KsftSkipEx, ksft_variants, KsftNamedVariant
 from lib.py import NetDrvEpEnv
 from lib.py import bkg, cmd, defer, ethtool, rand_port, wait_port_listen
+from lib.py import EthtoolFamily
 
 
-def _get_current_settings(cfg):
-    output = ethtool(f"-g {cfg.ifname}", json=True)[0]
-    return (output['rx'], output['hds-thresh'])
-
-
-def _get_combined_channels(cfg):
-    output = ethtool(f"-l {cfg.ifname}").stdout
-    values = re.findall(r'Combined:\s+(\d+)', output)
-    return int(values[1])
-
-
-def _create_rss_ctx(cfg, chan):
-    output = ethtool(f"-X {cfg.ifname} context new start {chan} equal 1").stdout
+def create_rss_ctx(cfg):
+    output = ethtool(f"-X {cfg.ifname} context new start {cfg.target} equal 1").stdout
     values = re.search(r'New RSS context is (\d+)', output).group(1)
-    ctx_id = int(values)
-    return (ctx_id, defer(ethtool, f"-X {cfg.ifname} delete context {ctx_id}"))
+    return int(values)
 
 
-def _set_flow_rule(cfg, port, chan):
-    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} action {chan}").stdout
+def set_flow_rule(cfg):
+    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {cfg.port} action {cfg.target}").stdout
     values = re.search(r'ID (\d+)', output).group(1)
     return int(values)
 
 
-def _set_flow_rule_rss(cfg, port, ctx_id):
-    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} context {ctx_id}").stdout
+def set_flow_rule_rss(cfg, rss_ctx_id):
+    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {cfg.port} context {rss_ctx_id}").stdout
     values = re.search(r'ID (\d+)', output).group(1)
     return int(values)
 
 
-def test_zcrx(cfg) -> None:
-    cfg.require_ipver('6')
-
-    combined_chans = _get_combined_channels(cfg)
-    if combined_chans < 2:
-        raise KsftSkipEx('at least 2 combined channels required')
-    (rx_ring, hds_thresh) = _get_current_settings(cfg)
-    port = rand_port()
-
-    ethtool(f"-G {cfg.ifname} tcp-data-split on")
-    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto")
+def single(cfg):
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    channels = channels['combined-count']
+    if channels < 2:
+        raise KsftSkipEx('Test requires NETIF with at least 2 combined channels')
 
-    ethtool(f"-G {cfg.ifname} hds-thresh 0")
-    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}")
+    rings = cfg.ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    rx_rings = rings['rx']
+    hds_thresh = rings.get('hds-thresh', 0)
 
-    ethtool(f"-G {cfg.ifname} rx 64")
-    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}")
+    cfg.ethnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                         'tcp-data-split': 'enabled',
+                         'hds-thresh': 0,
+                         'rx': 64})
+    defer(cfg.ethnl.rings_set, {'header': {'dev-index': cfg.ifindex},
+                                'tcp-data-split': 'unknown',
+                                'hds-thresh': hds_thresh,
+                                'rx': rx_rings})
 
-    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}")
+    cfg.target = channels - 1
+    ethtool(f"-X {cfg.ifname} equal {cfg.target}")
     defer(ethtool, f"-X {cfg.ifname} default")
 
-    flow_rule_id = _set_flow_rule(cfg, port, combined_chans - 1)
+    flow_rule_id = set_flow_rule(cfg)
     defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
 
-    rx_cmd = f"{cfg.bin_local} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1}"
-    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {port} -l 12840"
-    with bkg(rx_cmd, exit_wait=True):
-        wait_port_listen(port, proto="tcp")
-        cmd(tx_cmd, host=cfg.remote)
 
+def rss(cfg):
+    channels = cfg.ethnl.channels_get({'header': {'dev-index': cfg.ifindex}})
+    channels = channels['combined-count']
+    if channels < 2:
+        raise KsftSkipEx('Test requires NETIF with at least 2 combined channels')
 
-def test_zcrx_oneshot(cfg) -> None:
-    cfg.require_ipver('6')
+    rings = cfg.ethnl.rings_get({'header': {'dev-index': cfg.ifindex}})
+    rx_rings = rings['rx']
+    hds_thresh = rings.get('hds-thresh', 0)
 
-    combined_chans = _get_combined_channels(cfg)
-    if combined_chans < 2:
-        raise KsftSkipEx('at least 2 combined channels required')
-    (rx_ring, hds_thresh) = _get_current_settings(cfg)
-    port = rand_port()
+    cfg.ethnl.rings_set({'header': {'dev-index': cfg.ifindex},
+                         'tcp-data-split': 'enabled',
+                         'hds-thresh': 0,
+                         'rx': 64})
+    defer(cfg.ethnl.rings_set, {'header': {'dev-index': cfg.ifindex},
+                                'tcp-data-split': 'unknown',
+                                'hds-thresh': hds_thresh,
+                                'rx': rx_rings})
 
-    ethtool(f"-G {cfg.ifname} tcp-data-split on")
-    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto")
+    cfg.target = channels - 1
+    ethtool(f"-X {cfg.ifname} equal {cfg.target}")
+    defer(ethtool, f"-X {cfg.ifname} default")
 
-    ethtool(f"-G {cfg.ifname} hds-thresh 0")
-    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}")
+    rss_ctx_id = create_rss_ctx(cfg)
+    defer(ethtool, f"-X {cfg.ifname} delete context {rss_ctx_id}")
 
-    ethtool(f"-G {cfg.ifname} rx 64")
-    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}")
+    flow_rule_id = set_flow_rule_rss(cfg, rss_ctx_id)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
 
-    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}")
-    defer(ethtool, f"-X {cfg.ifname} default")
 
-    flow_rule_id = _set_flow_rule(cfg, port, combined_chans - 1)
-    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
+@ksft_variants([
+    KsftNamedVariant("single", single),
+    KsftNamedVariant("rss", rss),
+])
+def test_zcrx(cfg, setup) -> None:
+    cfg.require_ipver('6')
 
-    rx_cmd = f"{cfg.bin_local} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1} -o 4"
-    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {port} -l 4096 -z 16384"
+    setup(cfg)
+    rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {cfg.target}"
+    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {cfg.port} -l 12840"
     with bkg(rx_cmd, exit_wait=True):
-        wait_port_listen(port, proto="tcp")
+        wait_port_listen(cfg.port, proto="tcp")
         cmd(tx_cmd, host=cfg.remote)
 
 
-def test_zcrx_rss(cfg) -> None:
+@ksft_variants([
+    KsftNamedVariant("single", single),
+    KsftNamedVariant("rss", rss),
+])
+def test_zcrx_oneshot(cfg, setup) -> None:
     cfg.require_ipver('6')
 
-    combined_chans = _get_combined_channels(cfg)
-    if combined_chans < 2:
-        raise KsftSkipEx('at least 2 combined channels required')
-    (rx_ring, hds_thresh) = _get_current_settings(cfg)
-    port = rand_port()
-
-    ethtool(f"-G {cfg.ifname} tcp-data-split on")
-    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto")
-
-    ethtool(f"-G {cfg.ifname} hds-thresh 0")
-    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}")
-
-    ethtool(f"-G {cfg.ifname} rx 64")
-    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}")
-
-    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}")
-    defer(ethtool, f"-X {cfg.ifname} default")
-
-    (ctx_id, delete_ctx) = _create_rss_ctx(cfg, combined_chans - 1)
-    flow_rule_id = _set_flow_rule_rss(cfg, port, ctx_id)
-    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
-
-    rx_cmd = f"{cfg.bin_local} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1}"
-    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {port} -l 12840"
+    setup(cfg)
+    rx_cmd = f"{cfg.bin_local} -s -p {cfg.port} -i {cfg.ifname} -q {cfg.target} -o 4"
+    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {cfg.port} -l 4096 -z 16384"
     with bkg(rx_cmd, exit_wait=True):
-        wait_port_listen(port, proto="tcp")
+        wait_port_listen(cfg.port, proto="tcp")
         cmd(tx_cmd, host=cfg.remote)
 
 
@@ -137,7 +119,9 @@ def main() -> None:
         cfg.bin_local = path.abspath(path.dirname(__file__) + "/../../../drivers/net/hw/iou-zcrx")
         cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
 
-        ksft_run(globs=globals(), case_pfx={"test_"}, args=(cfg, ))
+        cfg.ethnl = EthtoolFamily()
+        cfg.port = rand_port()
+        ksft_run(globs=globals(), cases=[test_zcrx, test_zcrx_oneshot], args=(cfg, ))
     ksft_exit()
 
 
-- 
2.47.3


