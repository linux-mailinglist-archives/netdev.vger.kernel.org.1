Return-Path: <netdev+bounces-205869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF78DB00947
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 18:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB697A1484
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 16:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA3E285062;
	Thu, 10 Jul 2025 16:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="eaZDr9HK"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357552AE6D
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 16:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752166432; cv=none; b=DV2FpxsZnvyE9rqr7cIQo8UJsxsa4S8cS0gP0bDEScutGHXLMgNf0QuMLDnjJuKW7WBcichmtyc6QsHU39i3fxdMSdZ/x/9OFb8T2MsWfqx3wG8uKkjEWKMBWlQIZ2+W0JPHQPexbGNuZ96oUkI/OQf1pJLhll7cV5gAm8u1f1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752166432; c=relaxed/simple;
	bh=9p5PIIDJExfDkdS7BDiEdk4vP461ia5bkZdIubSjNnM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oRByFrb4rEBn7fzpkGtU2gfI4j46u6vhY4/MAdt8ND4wfdwplwc/5pKOKakV22xMNoDgyyGVqBDyNgcmum8JnL6ByfQoAyJyGn0aCkxSkJ6MIDcV/DtRoeUSMfn1akBYd1VZh2EftTpMfHWhclavEiwt+41BEf/jHhPmLZLTZk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=eaZDr9HK; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56A9tqId032057;
	Thu, 10 Jul 2025 09:53:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=4gNO+Wk2qrWK5U2TND
	gjCxSVrM4K8TX+5xEPWyGrPQ4=; b=eaZDr9HKCHu2rDHwA45TUPs9Hpgxg6SGTO
	aMxTnrG/s8Mp+mt4UvuUJtPfj3iSf3k+e6AI5JoZ+q51ZYNWmafukmjlCLIPo0Nj
	I3PDdlVIb9zalPbqqBnSsGxHN5MRMwz3dtd33AqjZTQ9heEZIE+G7TProTV7g4CA
	S4IZpjPSIOQlHUOLfE07glttnfNDPoGc3uNozB+TeT6Apqo7apIYpJOlZ0BWw4Oh
	SUII/LgwvIHb1STCNB7n6nJ6szigvLmpMWs3/sV+wSckjyL00EMaUoOB4J4fWWn8
	5hVc/sDb61JGdyyIEf/3uhDOnXK4/ocn6WR70690OBX9y4xTmAfg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 47tbak2w5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 10 Jul 2025 09:53:39 -0700 (PDT)
Received: from localhost (2620:10d:c0a8:1c::1b) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.24; Thu, 10 Jul
 2025 16:53:38 +0000
From: Vishwanath Seshagiri <vishs@meta.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, David Wei <dw@davidwei.uk>,
        "Joe
 Damato" <jdamato@fastly.com>, Simon Horman <horms@kernel.org>,
        <netdev@vger.kernel.org>, Vishwanath Seshagiri <vishs@fb.com>
Subject: [PATCH net-next v2] selftests: flip local/remote endpoints in iou-zcrx.py
Date: Thu, 10 Jul 2025 09:53:37 -0700
Message-ID: <20250710165337.614159-1-vishs@meta.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: xyW6N7lC5ymfdO8OKsKzKVTlIHWDaktH
X-Authority-Analysis: v=2.4 cv=Ip4ecK/g c=1 sm=1 tr=0 ts=686ff013 cx=c_pps a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=FOH2dFAWAAAA:8 a=efhq1SeH5nsRmTzY6XAA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzEwMDE0NCBTYWx0ZWRfX+LUXx4fBPygn c/XVkSprFfDLrWzfPsmQkRwHkYNliqnCi5+TF+bcCar9KieuXpqDM4fPW9HEk8Xb8GB0LZRZjLU H7uK2vWzgOrjLaER0Y2iKePS70NugcUDOCmvGDRuFB/N/fe435yWQj3Fo+USDYa8X0wnZ4B9E/P
 3EmH2OfIS4HeR3iykxeqTAGvWsQWzOloR5zkGRIajYlHw+KqmRgEwMnJJQhgl65ynujYGx17dhA gwcO1F43ALh+gudOqRQ7fE61E4bRej1oDyTgH9ZGvpyg/FFcf3cAHnldhvUhzLmt8FS386h+DPb pgqTfI2gPzd8k+Fn+6+chwTId2E5w4Dj5j8Je3C8BB4bZ2e6JwQqTkGcXFjcwOQSheuB4d0n/e3
 aFKPyParkBOkWaGslu56/79JiAzQrVfuzHR0A6Gsz35H+uyVIHKH7ivYUN4yEFhwyE77Zzcc
X-Proofpoint-GUID: xyW6N7lC5ymfdO8OKsKzKVTlIHWDaktH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-10_04,2025-07-09_01,2025-03-28_01

From: Vishwanath Seshagiri <vishs@fb.com>

The iou-zcrx selftest currently runs the server on the remote host
and the client on the local host. This commit flips the endpoints
such that server runs on localhost and client on remote.
This change brings the iou-zcrx selftest in convention with other
selftests.

Drive-by fix for a missing import exception that happens when the
network interface has less than 2 combined channels.

Test plan: ran iou-zcrx.py selftest between 2 physical machines

Signed-off-by: Vishwanath Seshagiri <vishs@fb.com>
---
Changelog:
v2: Updated patch title, description to provide more context on the
specific changes made.
v1 link: https://lore.kernel.org/netdev/20250707232223.190242-1-vishs@meta.com/T/#u
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


