Return-Path: <netdev+bounces-186278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBAAEA9DCF9
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 21:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C1D71BA12AD
	for <lists+netdev@lfdr.de>; Sat, 26 Apr 2025 19:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF0D1F2BB8;
	Sat, 26 Apr 2025 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="Dcvx56vv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761891EA7D8
	for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745697334; cv=none; b=CMTTSFHIinkShl6d3nrmT/EL21/lUhMJsGDP7rnbEhLwBS1O8pciVYxsczucuoAFgWgv9LbVzf4+63VMeaR1JZNdbHRbJw3qc6xlpuobZFHgR8G3qJVuh/+64FkIbyqLrKEcVbnjRnu8Fb1SG1qu5Ubh9Hb9XcRYs+G5lx5OSyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745697334; c=relaxed/simple;
	bh=CzUX0er1XUd/LZ1UJwsp8GHUXbH6zQJkRAL2lwQO8jY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZIETjRvXXVvCKVaeRxknsOMsZsFI4xmB+t+CdmhZ0etxEIbKx6NcpjU5Z4KV48vYLcG2KgoO+PsWMn32hWof75Q/5kT9yBltzVKvIbtf+8lJESVzLzw/8uMouMYBtSbmeElDgicygsfD1BVEvrBoTTfMPobWIy9F28fFVz/STc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=Dcvx56vv; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b170c99aa49so1608200a12.1
        for <netdev@vger.kernel.org>; Sat, 26 Apr 2025 12:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1745697331; x=1746302131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pyb7T17ifIi6AYkpLObnOfBj8Aju7GJ4Camw1Sf8n+g=;
        b=Dcvx56vv9GxJ+zWP9V4tyMtVq3lZdOeML9VgXJuOnhBaak2lceMjyPxRyltCx0HyLu
         sraOU+H72m5rgqL3w0DFN7/J99moISY9APB165ykv6vCHBguF0HTkhdzns0plFNN56C5
         wXUlfYA1uTw45z7KkcLOYiXBxQlUlRrK/bX1k4bkPMCxGmX4XnO6Jq/4aeKisogfSNPp
         Jo5JkXgrowGlNNV7Zje8AMt2SKvAmzuHI9Wrj4dwQSk91fU5rZOYYuRZmofuRL6B49x1
         5GjiwWqxXlLOM/UEtEvzZdCHr4l0QvG6dI+qeISVrm59uURSjScZJuhbsnJMf05GQIcV
         Ixjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745697331; x=1746302131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pyb7T17ifIi6AYkpLObnOfBj8Aju7GJ4Camw1Sf8n+g=;
        b=VfUj/Hteltz1Q968HpIdfhUXn5cj7+DbxYBMGrhvuD60SayuSu2oI2heZ5/H0CiPOG
         lf4kkaAtdKXnuZ9u7ILWD4DoqRpg0nllydLzgC0ZEYyX1fkT3exhb61SI1vqT/Su57KL
         Hc/cCDJSYfXMh7lI+rKIcH2rd5VhHuMewJuSYtYNmBmsut7KOo5ssO+jMgj7jbgdXivb
         iK2b5Q/YBQnqGmreDCFzH3BgqSNB29UGW/xWH1192XeZZYJuf+SCoDZqDOhGc2wsZIBf
         AI+bvDY8d7iPy2s1z9hPPnMTErtuyc+EQ8f2E7HH6gV8qNY0Ib6cjv7DwQPaKNYqcTuH
         IDDg==
X-Gm-Message-State: AOJu0YxZfQTynBltlULbACIkJ4Sxe0xB22zdDQ+ws8yqpmfesEx9xCFH
	B7wwom/ibCU9YY/x90CGxEUqwW/LAYY1KJ7A0FBZlrfxyrzfo4ap4IT3T9l9V1jJYx0QGpwxeXK
	C
X-Gm-Gg: ASbGnctt0e719TjPmM5K3uMhweP1QiFU/KYHQV73iJIb2Q+Rdc4gkcTnpSfK1HxM2oF
	QURghuF2pMHJtEvjxnWbBqv14jzZxg+sckUo1RLhYOmHUlcDSCQ6s/GtEJwC9IXftzJgCzGyF0d
	PssA0nHlrvknNYbgCGqC9UOWKsu/cMvy3B4JwA7HH2F+9FONGdZz1441l9MpcIq8WayQIHC4TPe
	RP7lYyM3zgNEYeRIFTYRpD1t6G7jzKqDLF61K+Z3r2HeoFeau/HzFZavL2YqeK/IJauK5hhMWXy
	sUUmThqxDA2NJh3tXVGFV0NllzI=
X-Google-Smtp-Source: AGHT+IFuYdUfnZCN3+qPUuFjCndGvAbSeZEjyTlQkWroXO/wK7t+/T8JhL2gPwuGySsvtxlA1ndLjg==
X-Received: by 2002:a05:6a21:9184:b0:1f3:345e:4054 with SMTP id adf61e73a8af0-2045b703084mr10890036637.14.1745697331144;
        Sat, 26 Apr 2025 12:55:31 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b15faded547sm4731100a12.69.2025.04.26.12.55.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Apr 2025 12:55:30 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH net-next v1 1/2] io_uring/zcrx: selftests: use rand_port()
Date: Sat, 26 Apr 2025 12:55:24 -0700
Message-ID: <20250426195525.1906774-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250426195525.1906774-1-dw@davidwei.uk>
References: <20250426195525.1906774-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use rand_port() and stop hard coding port 9999.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 .../selftests/drivers/net/hw/iou-zcrx.py      | 48 ++++++++++++-------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index c2977871ddaf..3962bf002ab6 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -5,7 +5,7 @@ import re
 from os import path
 from lib.py import ksft_run, ksft_exit
 from lib.py import NetDrvEpEnv
-from lib.py import bkg, cmd, defer, ethtool, wait_port_listen
+from lib.py import bkg, cmd, defer, ethtool, rand_port, wait_port_listen
 
 
 def _get_current_settings(cfg):
@@ -28,14 +28,14 @@ def _create_rss_ctx(cfg, chans):
     return (ctx_id, defer(ethtool, f"-X {cfg.ifname} delete context {ctx_id}", host=cfg.remote))
 
 
-def _set_flow_rule(cfg, chan):
-    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port 9999 action {chan}", host=cfg.remote).stdout
+def _set_flow_rule(cfg, port, chan):
+    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} action {chan}", host=cfg.remote).stdout
     values = re.search(r'ID (\d+)', output).group(1)
     return int(values)
 
 
-def _set_flow_rule_rss(cfg, chan):
-    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port 9999 action {chan}", host=cfg.remote).stdout
+def _set_flow_rule_rss(cfg, port, chan):
+    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} action {chan}", host=cfg.remote).stdout
     values = re.search(r'ID (\d+)', output).group(1)
     return int(values)
 
@@ -47,22 +47,27 @@ def test_zcrx(cfg) -> None:
     if combined_chans < 2:
         raise KsftSkipEx('at least 2 combined channels required')
     (rx_ring, hds_thresh) = _get_current_settings(cfg)
+    port = rand_port()
 
     ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
     defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
+
     ethtool(f"-G {cfg.ifname} hds-thresh 0", host=cfg.remote)
     defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}", host=cfg.remote)
+
     ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
     defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
+
     ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
     defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
-    flow_rule_id = _set_flow_rule(cfg, combined_chans - 1)
+
+    flow_rule_id = _set_flow_rule(cfg, port, combined_chans - 1)
     defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
 
-    rx_cmd = f"{cfg.bin_remote} -s -p 9999 -i {cfg.ifname} -q {combined_chans - 1}"
-    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p 9999 -l 12840"
+    rx_cmd = f"{cfg.bin_remote} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1}"
+    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p {port} -l 12840"
     with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
-        wait_port_listen(9999, proto="tcp", host=cfg.remote)
+        wait_port_listen(port, proto="tcp", host=cfg.remote)
         cmd(tx_cmd)
 
 
@@ -73,22 +78,27 @@ def test_zcrx_oneshot(cfg) -> None:
     if combined_chans < 2:
         raise KsftSkipEx('at least 2 combined channels required')
     (rx_ring, hds_thresh) = _get_current_settings(cfg)
+    port = rand_port()
 
     ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
     defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
+
     ethtool(f"-G {cfg.ifname} hds-thresh 0", host=cfg.remote)
     defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}", host=cfg.remote)
+
     ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
     defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
+
     ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
     defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
-    flow_rule_id = _set_flow_rule(cfg, combined_chans - 1)
+
+    flow_rule_id = _set_flow_rule(cfg, port, combined_chans - 1)
     defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
 
-    rx_cmd = f"{cfg.bin_remote} -s -p 9999 -i {cfg.ifname} -q {combined_chans - 1} -o 4"
-    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p 9999 -l 4096 -z 16384"
+    rx_cmd = f"{cfg.bin_remote} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1} -o 4"
+    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p {port} -l 4096 -z 16384"
     with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
-        wait_port_listen(9999, proto="tcp", host=cfg.remote)
+        wait_port_listen(port, proto="tcp", host=cfg.remote)
         cmd(tx_cmd)
 
 
@@ -99,24 +109,28 @@ def test_zcrx_rss(cfg) -> None:
     if combined_chans < 2:
         raise KsftSkipEx('at least 2 combined channels required')
     (rx_ring, hds_thresh) = _get_current_settings(cfg)
+    port = rand_port()
 
     ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
     defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
+
     ethtool(f"-G {cfg.ifname} hds-thresh 0", host=cfg.remote)
     defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}", host=cfg.remote)
+
     ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
     defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
+
     ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
     defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
 
     (ctx_id, delete_ctx) = _create_rss_ctx(cfg, combined_chans)
-    flow_rule_id = _set_flow_rule_rss(cfg, ctx_id)
+    flow_rule_id = _set_flow_rule_rss(cfg, port, ctx_id)
     defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
 
-    rx_cmd = f"{cfg.bin_remote} -s -p 9999 -i {cfg.ifname} -q {combined_chans - 1}"
-    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p 9999 -l 12840"
+    rx_cmd = f"{cfg.bin_remote} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1}"
+    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p {port} -l 12840"
     with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
-        wait_port_listen(9999, proto="tcp", host=cfg.remote)
+        wait_port_listen(port, proto="tcp", host=cfg.remote)
         cmd(tx_cmd)
 
 
-- 
2.47.1


