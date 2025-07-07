Return-Path: <netdev+bounces-204728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AE9AFBE8B
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 01:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1849A17E78B
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 23:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2868259CBD;
	Mon,  7 Jul 2025 23:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="vXHyRYdS"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8E21C3C04
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 23:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751930556; cv=none; b=hPhaf5oc2aSmhDcFnRR5xE+2+Hx5l/NjXxWFCxdNOp6IcrroUqYjSN9KNOaoI663cj8RrYDvcNMeNilZaYDeASDfYJPfrIHbYxh+sctmnYw4IX+E/sRUL+/3Vxf42PAaIXvurjKqXagYNjb8YPhWvMZ9xBSp9QzJtNDvVPR7pg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751930556; c=relaxed/simple;
	bh=rUY+cXujY7fR1eCloQcH21DyFjaY/Xup9Blgkp+MNkU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XsvZxZU5B0qWw3Oq3A3hQDuYTtwam6PRqk9EdyaLf3F7rJEqD2lN1eX7+V8q1GMjdEP+KOoKEIYeNeL/pHVMaDBAU0wsOi6yd9X8HRxB/xnt90NGFFCdbVhXTRoyv+4HnTtaA56rAQIeuxaH8PTbBXpB1n2+7R2SUuDjO/J3lh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=vXHyRYdS; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
	by m0001303.ppops.net (8.18.1.2/8.18.1.2) with ESMTP id 567N5GKO017358;
	Mon, 7 Jul 2025 16:22:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=JKETNTJEw3no+DxFCy
	KrYI86oqZmOEUl1Ji50MM1ap0=; b=vXHyRYdSjnNY1Dz/bvmad4y6rvPFu1fFqH
	UKTcRIqEHJYCRltcv+4ZWC+dIzwM65n4HLyikbHVOmDC8nxIDnPV/7EFD1jAEAV3
	udux3lbMLG/PpnMN+1Hz87dGUeg5uynTzXAWp/Hx4jxMJKTMTvR8a12T8xIx0Mdx
	a4otGOpuBpHFi+ghuhsQTyWWI47/GFIosgxywM1mxi1jnE4EJEZ0kMcKb27a4vga
	YjgqmQbHN11QIdDYk0ng6KbBG46I4jbMgZMfvmEzuiDZkQDlDDw9Bx1LRbQt9cbu
	Tqia5xf1gDRnt4p8LyIjQtuKPv8cfeNrq1Msja1yvK3Zw5ZjJrKA==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0001303.ppops.net (PPS) with ESMTPS id 47rk9ja0n0-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Mon, 07 Jul 2025 16:22:25 -0700 (PDT)
Received: from localhost (2620:10d:c085:208::7cb7) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.24; Mon, 7 Jul
 2025 23:22:24 +0000
From: Vishwanath Seshagiri <vishs@meta.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, David Wei <dw@davidwei.uk>,
        "Joe
 Damato" <jdamato@fastly.com>, Simon Horman <horms@kernel.org>,
        "Vishwanath
 Seshagiri" <vishs@fb.com>, <netdev@vger.kernel.org>
Subject: [PATCH] selftests: net: hw: modify ZCRX testing support
Date: Mon, 7 Jul 2025 16:22:23 -0700
Message-ID: <20250707232223.190242-1-vishs@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ZnXsv6xqhCFvJcj36YQl56UP8U2GPYMA
X-Authority-Analysis: v=2.4 cv=ac9hnQot c=1 sm=1 tr=0 ts=686c56b1 cx=c_pps a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17 a=Wb1JkmetP80A:10 a=FOH2dFAWAAAA:8 a=TK1p4gQUNFFb7Zxd88cA:9
X-Proofpoint-ORIG-GUID: ZnXsv6xqhCFvJcj36YQl56UP8U2GPYMA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA3MDE2MyBTYWx0ZWRfX1eUMV1oPoLiL SjaDsKYeMD17W/sRtHuIm+02zD6Xks1q8hSwxQFQ8CihWgJNgbcv7AxIS+ib0rqFwoSkQgQjWcr tUwrofSkzsQSps3xom0Xo4di5JHfUF5Ls6xLxY2E9q/75DuLkXw6EYoHbvPyTHHYkynXNQ8bLI6
 5e/lc34ZE05AfdA1MRI4KLtzi9RHeh2V0RpuuHyi2fLPPaEc99LEzAVdhlKS6ahpgZbx9rld/OV 7Ks3wKp7gctG6Xc2OXuliyWbR8dS7WWVpQNV0CF/mW7LfUyHUSUBXxQVV7GD6oqzrHwW2CG1rhp rKl6be9EHqs61UsayMOVJpj145zKrKORzfV+o8h76vJ4BD8MiFHJpRqYxGJRR2FX9R7NFsbaJWo
 /wJMonec1gk02as04sWQKT3v2DGz4fnEWvIjAUK/hWQ4jGPpveYJeAiKFGSIn5n/TxbYq59Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-07_06,2025-07-07_01,2025-03-28_01

From: Vishwanath Seshagiri <vishs@fb.com>

Changed the test cases such that the endpoints of sender
and receiver are flipped based on the typical conventions of netdev 
selftests.

Test plan: ran selftests between 2 vms

Signed-off-by: Vishwanath Seshagiri <vishs@fb.com>
---
 .../selftests/drivers/net/hw/iou-zcrx.py      | 98 +++++++++----------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index 9c03fd777f3d..712c806508b5 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -3,37 +3,37 @@
 
 import re
 from os import path
-from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_run, ksft_exit, KsftSkipEx
 from lib.py import NetDrvEpEnv
 from lib.py import bkg, cmd, defer, ethtool, rand_port, wait_port_listen
 
 
 def _get_current_settings(cfg):
-    output = ethtool(f"-g {cfg.ifname}", json=True, host=cfg.remote)[0]
+    output = ethtool(f"-g {cfg.ifname}", json=True)[0]
     return (output['rx'], output['hds-thresh'])
 
 
 def _get_combined_channels(cfg):
-    output = ethtool(f"-l {cfg.ifname}", host=cfg.remote).stdout
+    output = ethtool(f"-l {cfg.ifname}").stdout
     values = re.findall(r'Combined:\s+(\d+)', output)
     return int(values[1])
 
 
 def _create_rss_ctx(cfg, chan):
-    output = ethtool(f"-X {cfg.ifname} context new start {chan} equal 1", host=cfg.remote).stdout
+    output = ethtool(f"-X {cfg.ifname} context new start {chan} equal 1").stdout
     values = re.search(r'New RSS context is (\d+)', output).group(1)
     ctx_id = int(values)
-    return (ctx_id, defer(ethtool, f"-X {cfg.ifname} delete context {ctx_id}", host=cfg.remote))
+    return (ctx_id, defer(ethtool, f"-X {cfg.ifname} delete context {ctx_id}"))
 
 
 def _set_flow_rule(cfg, port, chan):
-    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} action {chan}", host=cfg.remote).stdout
+    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} action {chan}").stdout
     values = re.search(r'ID (\d+)', output).group(1)
     return int(values)
 
 
 def _set_flow_rule_rss(cfg, port, ctx_id):
-    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} context {ctx_id}", host=cfg.remote).stdout
+    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} context {ctx_id}").stdout
     values = re.search(r'ID (\d+)', output).group(1)
     return int(values)
 
@@ -47,26 +47,26 @@ def test_zcrx(cfg) -> None:
     (rx_ring, hds_thresh) = _get_current_settings(cfg)
     port = rand_port()
 
-    ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
-    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} tcp-data-split on")
+    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto")
 
-    ethtool(f"-G {cfg.ifname} hds-thresh 0", host=cfg.remote)
-    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} hds-thresh 0")
+    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}")
 
-    ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
-    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} rx 64")
+    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}")
 
-    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
-    defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
+    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}")
+    defer(ethtool, f"-X {cfg.ifname} default")
 
     flow_rule_id = _set_flow_rule(cfg, port, combined_chans - 1)
-    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
 
-    rx_cmd = f"{cfg.bin_remote} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1}"
-    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p {port} -l 12840"
-    with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
-        wait_port_listen(port, proto="tcp", host=cfg.remote)
-        cmd(tx_cmd)
+    rx_cmd = f"{cfg.bin_local} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1}"
+    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {port} -l 12840"
+    with bkg(rx_cmd, exit_wait=True):
+        wait_port_listen(port, proto="tcp")
+        cmd(tx_cmd, host=cfg.remote)
 
 
 def test_zcrx_oneshot(cfg) -> None:
@@ -78,26 +78,26 @@ def test_zcrx_oneshot(cfg) -> None:
     (rx_ring, hds_thresh) = _get_current_settings(cfg)
     port = rand_port()
 
-    ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
-    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} tcp-data-split on")
+    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto")
 
-    ethtool(f"-G {cfg.ifname} hds-thresh 0", host=cfg.remote)
-    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} hds-thresh 0")
+    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}")
 
-    ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
-    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} rx 64")
+    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}")
 
-    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
-    defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
+    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}")
+    defer(ethtool, f"-X {cfg.ifname} default")
 
     flow_rule_id = _set_flow_rule(cfg, port, combined_chans - 1)
-    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
 
-    rx_cmd = f"{cfg.bin_remote} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1} -o 4"
-    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p {port} -l 4096 -z 16384"
-    with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
-        wait_port_listen(port, proto="tcp", host=cfg.remote)
-        cmd(tx_cmd)
+    rx_cmd = f"{cfg.bin_local} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1} -o 4"
+    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {port} -l 4096 -z 16384"
+    with bkg(rx_cmd, exit_wait=True):
+        wait_port_listen(port, proto="tcp")
+        cmd(tx_cmd, host=cfg.remote)
 
 
 def test_zcrx_rss(cfg) -> None:
@@ -109,27 +109,27 @@ def test_zcrx_rss(cfg) -> None:
     (rx_ring, hds_thresh) = _get_current_settings(cfg)
     port = rand_port()
 
-    ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
-    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} tcp-data-split on")
+    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto")
 
-    ethtool(f"-G {cfg.ifname} hds-thresh 0", host=cfg.remote)
-    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} hds-thresh 0")
+    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}")
 
-    ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
-    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} rx 64")
+    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}")
 
-    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
-    defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
+    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}")
+    defer(ethtool, f"-X {cfg.ifname} default")
 
     (ctx_id, delete_ctx) = _create_rss_ctx(cfg, combined_chans - 1)
     flow_rule_id = _set_flow_rule_rss(cfg, port, ctx_id)
-    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
 
-    rx_cmd = f"{cfg.bin_remote} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1}"
-    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p {port} -l 12840"
-    with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
-        wait_port_listen(port, proto="tcp", host=cfg.remote)
-        cmd(tx_cmd)
+    rx_cmd = f"{cfg.bin_local} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1}"
+    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {port} -l 12840"
+    with bkg(rx_cmd, exit_wait=True):
+        wait_port_listen(port, proto="tcp")
+        cmd(tx_cmd, host=cfg.remote)
 
 
 def main() -> None:
-- 
2.47.1


