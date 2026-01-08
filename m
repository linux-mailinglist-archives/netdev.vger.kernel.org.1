Return-Path: <netdev+bounces-248291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 597C8D0691B
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 00:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D1E0301D593
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 23:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D681233D518;
	Thu,  8 Jan 2026 23:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="yj8q2dfl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A70C8EB
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 23:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767915926; cv=none; b=KtKLyP4ty7oDq5neTtAoHewny8WEqxPMqb7+MNRwEgiFqfNJ+3ZRaCcQWYz/Jf0EbF7h72rhuDBllgqe35e667ew37jWT1Slyt3+i5yFsDhw0CbcKvQN0ExaKaKhNrlu+r3AQIK2dRxiSDxaJsDe+nWP56YzLxKMR4HRxCB5YME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767915926; c=relaxed/simple;
	bh=Ig1lK/Pwnwhecei1VzTrt9WosWgBzuGkCQEK1V3+2Us=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z8+v822aAzV5DoryEOQIzF0xxWIrflsz9GSlwZBx32OK3seOQTjCnoWJAY0E3ueZVwN/gGI6tZPzI7OnFlHlNDs2d0NyIKgnZR6uQ6UhDCqNaM69e9RhgoTVGKimXKd+wNEwkOkehu0P85h/BBA7/BqTvNGiWJs+6V+EnVvG/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=yj8q2dfl; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-4558f9682efso2425349b6e.3
        for <netdev@vger.kernel.org>; Thu, 08 Jan 2026 15:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1767915924; x=1768520724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AdddjUsrOEJ/NFoBu1ta8xZknX/7x/tr4B8p3DMPG8c=;
        b=yj8q2dflsJBhm9Szr5eC0jATROxULY8cXTI1cWRHp9wdDdLWLApH2AY2Rt1tuDF2qt
         qKWBv5hi0xvhI9inbPZ6zChiypJR1iKnchxlfSs9uH3T/rnnffSbLSnmhzkV+tTAS2sR
         0haN1CsHttp1RrGsD1DfcLDUvnRO4r+wnICmey8x+UDiWNump1wsslsbWdEpAUhsPrTp
         +9SbigEvd2+93wzcsdnWAbPbwF+9keQbMo7a3I3erp3pZWTt6S7OV3dE9iGHzHqyB6Iu
         LsWn/FGglevo3aPH6vQiGtgQ4edEU0ts/Fs7f7i6tKMnPWeDagKn737wF6gi69jTrKSi
         vFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767915924; x=1768520724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AdddjUsrOEJ/NFoBu1ta8xZknX/7x/tr4B8p3DMPG8c=;
        b=jWNvoq3c0LbLPYkdmGHUYaXU7+IhwGRA2/l4fWFj7UItJt9Nri7fcu7T6zfjlTtLCG
         7uZF2ot9CwQc20tCNy3VAvErzoJQqsOREQ4rk5CSROcCqTVfhwg11Ag+zrtXzPpH5gmU
         UQarwk7Pht4Wn5zOBNn7JQkjOfdCZ4OPEYL5V2ig2Q6IWlgzBBlXt36ep9DlwFZzv0H4
         Tv6xVgXH2p+oKzpcOj65jQL1h0Bf4679b+qL/J5lzDmzxBBjxuz3nandJ88sn82fRSwq
         dtEY0RVNI61F+BOg7wfAFpr+xpJArWfXm88Az+vwah/C+FeHdVzAprzyF8HUlVKm9viz
         F1+g==
X-Gm-Message-State: AOJu0YyUQv5UT+KUbiWjf+lL+1J++z7PJiC3P91A54DcVI9ITjGVzpaN
	5Y8GxF15XzltHHfYXwmyoDb1kr8XViqYsgzCyw3QGd+6OgovcTGh1kDrSAYAwj3GN/+mX0Xkd+w
	k5HNu
X-Gm-Gg: AY/fxX40qMREf6Spg5Ud8KD4WL76lQm+qBFE0pE28vvtaR4yVmLHngrU8ZvFRsaVmTI
	rGKXmO39GDim8uKpKso2xp5MkAFYNnERQ3cxLso+Oe+2zWZJvWbA4iOnOf0LQnsTi4OTTjJFe4n
	HpcEGYH1qUz2WqMG0Ouzv++xKhsqAw+SH1QINRXXMvPe8FJYQ0/gQ8rotv7WpPzQJhMWmvflb1D
	r4WjgCMj4VtU681ALT4pxagzTsao0GR1YNNHZ78ydwrT3+WEDGZrxdbOK4brXIyFkIgw5TLmE4I
	whDzSJqwhKQ5IogboeqQLkX+2cBjwLNtI9JVQrGbVgm6UFw4UxYsG0zn4J/lmvWZ0HQc12TftA4
	lbO8nkJt4yIlA3z0A3X3WPPL+5a3PTwMdJThCLhAx9CkR0uiOP/p8L/xXkxz92TN92fED6K7ksP
	/jZay5zqesiVVtsLKQ0GknavPfjuEw
X-Google-Smtp-Source: AGHT+IHz9EGUPv820UesPiOu0sdJOVXNYqQi62yND337h44kw54ZyyuI53ntSX9x9curQVrkjXjksw==
X-Received: by 2002:a05:6808:169f:b0:450:3ff9:f501 with SMTP id 5614622812f47-45a6bcca3dcmr3615851b6e.7.1767915923895;
        Thu, 08 Jan 2026 15:45:23 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:2::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45a76abe858sm1994438b6e.9.2026.01.08.15.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 15:45:23 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <jdamato@meta.com>
Subject: [PATCH net-next] selftests/net: parametrise iou-zcrx.py with ksft_variants
Date: Thu,  8 Jan 2026 15:45:21 -0800
Message-ID: <20260108234521.3619621-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
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


