Return-Path: <netdev+bounces-185816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B12DA9BCC1
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C047C1BA5A39
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE314D283;
	Fri, 25 Apr 2025 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="08xJSJbZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3AED136351
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745547654; cv=none; b=McSujNIUMmtZqD+IQ15XR12jY/lPQVev7LLuruhJdS7yBcCRlD/Cg4Z9Z/lrIU4Yq1ZNAYfyQMoECslp7dI/AJBwwZmvAeC6hrWQwDdrs90NHIEcWwQsCsaHoWi0raCO1GfktOXpwNqhlvcLxYdbUv1bCls6zVIGrPPITjuNMFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745547654; c=relaxed/simple;
	bh=ws0C0x15wI7BsKPl4yWmhokYxE1YK1JS2d6WcuIHPYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q2VfmO4sBuI7yLtLPYwLyTsMjYbx8TMJACOBwChwofbdvgtxSRPUVnT3zXpE9ae7EOglxDXRHdFOZhLH9Uinfk8PDGOwSIvrTQ2kQlrpUYYbZkzSibBjUzTIQswL3tCKSRlvhuCCaGhivjWK8qy89meCS0wlZqf9qx5vkToQbmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=08xJSJbZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736ab1c43c4so1657896b3a.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 19:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1745547652; x=1746152452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBslYUjycEY2oOas7pvcntBNxtMUMF5f5XTl5h36HQA=;
        b=08xJSJbZmO+Izk1tThzLyx85hNtoN7iJ8vF2R/eL5TdWryMV3Qx63kYpNDZGRF6Gon
         +tJE7ybhYQL2NYd2CHc0l7mLu75UcizSqbqpb72JU9A+Yjzv8i4IV2SNmJ8ObqIO0uIh
         A+iFZ6aPxRMr/NLh59JWo0s7fBic4Q+qTR1TEz3PWkh/NKQhm8qierz1Q/QZwYHUGj4N
         w5pIaPq4wDdwNxtlGTvChRNPIhMFtjvKtbkkm9NeQof9KyhpKqpy+ulKGfYfvx8GngYU
         Fh7QCc9Emu9PuWk2BoWODfCKhOHsdV9GVOYAZzRV31+6xsSnQoJHdOm30IxVdQ/UdbE2
         jedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745547652; x=1746152452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBslYUjycEY2oOas7pvcntBNxtMUMF5f5XTl5h36HQA=;
        b=P88KUoVhVoz2gkZ25q59Uj/oww8xG2jmv57vRLyRYr1S9XDaes44p/Mhr9WNoy7k2P
         jjvDTC4RO2UvHoC3fw3DPBHJmb5aqzH3SaO9ShEnoixK9O2YEmZbb1qd+j2D93sGu2U9
         ndfoJr2qmFXQ9oclK63mPOXLCQlcoedCCWmwwPUxbyXymzTpCI4a5MJn3cQ1KLgYgWmf
         PAT9xj6ajXfPCZjV81TQyjWqmQoTKG2cTjyzixdBNrzgnYEs5ap1QjgvzubGTMPZ8a7z
         1uH/+GkZLriRzCnBorexNYEYDjJTGVF8qx149TmuOfNxAGCvt9DaXfweC8DUj03H7+qK
         k8Hw==
X-Gm-Message-State: AOJu0YxZgWexJ/Ptg3ZF1hW4QrzM4CLx1r7+GhmXe8TpRPtuMDezO1U+
	tbBJuSjLMVB80RoMFWiuBfJ1XQ+1SNu/nTfU8bO1mmYELkLvBeOW1i2VVCBZZAcZEorcmcV2PFI
	q
X-Gm-Gg: ASbGnctlHEswPtuUbEIyJuxDp3Waq/0ry6vyMxls2urytYsRWJskC7HKYqCMibFguL6
	BzJePQcZPYC+eVSj+1VAh0KnBNY2eDwfZrf+lJ14Ugerr9FLE3oCQKM0YqKzb3YqOaCvHBTufxb
	8nlwABHAX7uzWFtkXP4Wr3QCsQ2efp+cJv57/JZKpHdw6xcB+yB2o49hr7X0V4xzv3RpaIgAtfK
	6DoKulcds44MaAa9MS7enFyLjOXi9NUCGbcSmhLkeeZJb3fUWvkPTOPH1dm16b9/yTcXMSqaOzX
	AIaPA4YUNozjAaNTjJ2d609crQ==
X-Google-Smtp-Source: AGHT+IEhlHkAFcMp1LCO4FtXIygypMMfoCqLoJs+wwd802VIfW0aI9f9iXIsAC1qKhIoKiii16v2HA==
X-Received: by 2002:a05:6a00:10d1:b0:736:4cde:5c0e with SMTP id d2e1a72fcca58-73fd72c7776mr762610b3a.10.1745547651942;
        Thu, 24 Apr 2025 19:20:51 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9db7asm2188095b3a.145.2025.04.24.19.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 19:20:51 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 1/3] io_uring/zcrx: selftests: switch to using defer() for cleanup
Date: Thu, 24 Apr 2025 19:20:47 -0700
Message-ID: <20250425022049.3474590-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250425022049.3474590-1-dw@davidwei.uk>
References: <20250425022049.3474590-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch to using defer() for putting the NIC back to the original state
prior to running the selftest.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 .../selftests/drivers/net/hw/iou-zcrx.py      | 61 +++++++++----------
 1 file changed, 29 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index 6a0378e06cab..698f29cfd7eb 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -5,7 +5,7 @@ import re
 from os import path
 from lib.py import ksft_run, ksft_exit
 from lib.py import NetDrvEpEnv
-from lib.py import bkg, cmd, ethtool, wait_port_listen
+from lib.py import bkg, cmd, defer, ethtool, wait_port_listen
 
 
 def _get_rx_ring_entries(cfg):
@@ -34,22 +34,21 @@ def test_zcrx(cfg) -> None:
         raise KsftSkipEx('at least 2 combined channels required')
     rx_ring = _get_rx_ring_entries(cfg)
 
-    try:
-        ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
-        ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
-        ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
-        flow_rule_id = _set_flow_rule(cfg, combined_chans - 1)
 
-        rx_cmd = f"{cfg.bin_remote} -s -p 9999 -i {cfg.ifname} -q {combined_chans - 1}"
-        tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p 9999 -l 12840"
-        with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
-            wait_port_listen(9999, proto="tcp", host=cfg.remote)
-            cmd(tx_cmd)
-    finally:
-        ethtool(f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
-        ethtool(f"-X {cfg.ifname} default", host=cfg.remote)
-        ethtool(f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
-        ethtool(f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
+    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
+    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
+    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
+    defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
+    flow_rule_id = _set_flow_rule(cfg, combined_chans - 1)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
+
+    rx_cmd = f"{cfg.bin_remote} -s -p 9999 -i {cfg.ifname} -q {combined_chans - 1}"
+    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p 9999 -l 12840"
+    with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
+        wait_port_listen(9999, proto="tcp", host=cfg.remote)
+        cmd(tx_cmd)
 
 
 def test_zcrx_oneshot(cfg) -> None:
@@ -60,22 +59,20 @@ def test_zcrx_oneshot(cfg) -> None:
         raise KsftSkipEx('at least 2 combined channels required')
     rx_ring = _get_rx_ring_entries(cfg)
 
-    try:
-        ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
-        ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
-        ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
-        flow_rule_id = _set_flow_rule(cfg, combined_chans - 1)
-
-        rx_cmd = f"{cfg.bin_remote} -s -p 9999 -i {cfg.ifname} -q {combined_chans - 1} -o 4"
-        tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p 9999 -l 4096 -z 16384"
-        with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
-            wait_port_listen(9999, proto="tcp", host=cfg.remote)
-            cmd(tx_cmd)
-    finally:
-        ethtool(f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
-        ethtool(f"-X {cfg.ifname} default", host=cfg.remote)
-        ethtool(f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
-        ethtool(f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
+    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
+    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
+    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
+    defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
+    flow_rule_id = _set_flow_rule(cfg, combined_chans - 1)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
+
+    rx_cmd = f"{cfg.bin_remote} -s -p 9999 -i {cfg.ifname} -q {combined_chans - 1} -o 4"
+    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p 9999 -l 4096 -z 16384"
+    with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
+        wait_port_listen(9999, proto="tcp", host=cfg.remote)
+        cmd(tx_cmd)
 
 
 def main() -> None:
-- 
2.47.1


