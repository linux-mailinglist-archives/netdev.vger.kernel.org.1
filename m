Return-Path: <netdev+bounces-185818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDCEA9BCC5
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 959C817CE30
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B741607AC;
	Fri, 25 Apr 2025 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="uo2AR+pa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341415278E
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745547655; cv=none; b=ki7YrivLKDPx2sr/Sd0lGRl+uTdbVETGawHsBgOzMgGRUGzSnZSDF7gIvVSVlxNq9W4HV2+Oa13RrMl0Jipk9uyPFmUIScN5qFkumMmeoK6bfqkZ+2xGQH0SA9wgr/2AiTDSzcbq77+FEgXM/hqW+Ai4luISdRKGIIeNixkLMzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745547655; c=relaxed/simple;
	bh=ssKFSwXRK89XSDZ0ERguyz74WyG0R5XwvHuMIz7TidU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DJZUA05vwmqi/UObTZnbsDzYoaJvOAN2yKAIlGjr0rq+sVS5woDA1AQhWOOpG135mP9fYKpMrVfgbSSWo9bc/1rwQY+vZhZ1ki3QtinUDWgpheIU9JjJx9+0ThO/B1qh3InmixMvRgIMNNNIbhfDQgbSPM7UrSby+i5Qai3MDSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=uo2AR+pa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-224171d6826so27344735ad.3
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 19:20:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1745547654; x=1746152454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Z2jlM5e39jGIpwIqeo/VcG2il6Ox8bCBjNtFCFByOM=;
        b=uo2AR+patnAX6A3nCnLwJjMw1yNr/YzEHc8hd9uGemS0wtxc9zGw9FW29DpuMsS7HH
         McGkyEshFT0u5Y1n4g8FIUJ63kq/aleUJdQLkTPaY3zBrrPNXJelGomwfMHkNVLXvIys
         Wt526CyHN9kDDK3aFV+9sSP3gqd2TflxoAVegPkFsMT+s19HtHVRZgyhz5E1DXBcrXcU
         +5FBmBh8hQ/lxwvFPvSyr71lnxlMIvc6kAgKQg51JwUNRTJLKf+BnjY+RIoThQFZgMpv
         u0pZRyCma00DdTJczNLTzAD77Ls5teavkAphDBnWaCK+JIFChOYmoHv5hksxEphRbgeT
         F9Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745547654; x=1746152454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8Z2jlM5e39jGIpwIqeo/VcG2il6Ox8bCBjNtFCFByOM=;
        b=XXaLOVq8Mo8tvFkt9lxpcdCLfEz1KPgvFIcTHvqZ7OpGwlij5Rw2RBCljPhCIyGOxW
         BwkozgRIRcyQOVSxnkf35YyPpTRl+HwBlrl3McyNC7e73BOd5jT32bkOk3pIN1tvnWyD
         Nm4gLyXo9ocG6tVexb5Z7duxcUKOtf1xGixb1Q/PB4gECZHV0h7FcYTkSQ9caAGeLdI0
         0HOqDBxJ2pM1HuerDih91HPXnu/8jI+T5a+XplKCGgXOstJ7gtGfzP9nvEzjRZrbhuOk
         wcyd8WjTa7bRqk85IKlJQMvusbdA//5XT7i0ouLwMCioyLu4bY1KT9g94OHxHBjj5coG
         bPqQ==
X-Gm-Message-State: AOJu0YzNqVnN63jBySeWvG84I3Px3e/ALlx0OWwyst3GSyGpUMh0WzpX
	B5A/5RtrSYL0gryT2wUkHkyVH87oqyYaKI362ftTzgWDzFAfhZdhd0i+yLMbD4MQYjKpZx9pqSp
	7
X-Gm-Gg: ASbGncux26DQbnGSkNpe1Vp3pq2xJiKBEH2zeiajBIy03YNlaASabm77jN0H2qdACWK
	LrD8H27oGrUrNcRdkQFs7EO3Yc9ab45DuEA4I9tpss6XGlmXsy/bZGvRD/0erJUBob2FjZp2bma
	sBdaWSkpiFs9jFZN98/DtzjtpUxZOBl/JGChFiZ90nDTIx9jtjR/R8te3BxyYqCOtGdgs5+lq1+
	H5paQcycn5MjvfRv63jAxFsa7nN4jcRYmkr2VUORXap5eRtOEk9InkB60yJJFkdR17zdfsXxyq1
	7pKGJ5M7+4mLrORjWLwC/bG3XMk16ylr4GSF
X-Google-Smtp-Source: AGHT+IHxE0pFM4miAILMdDw6mZ6NT2mZ+j4p1bGQlkHFKcXnkOJj2z1x9SRH4foYICYZG35740Yd6A==
X-Received: by 2002:a17:902:da88:b0:224:c46:d166 with SMTP id d9443c01a7336-22dbf62c7b2mr9349385ad.40.1745547653727;
        Thu, 24 Apr 2025 19:20:53 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5216c02sm20982005ad.211.2025.04.24.19.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 19:20:53 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 3/3] io_uring/zcrx: selftests: add test case for rss ctx
Date: Thu, 24 Apr 2025 19:20:49 -0700
Message-ID: <20250425022049.3474590-4-dw@davidwei.uk>
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

RSS contexts are used to shard work across multiple queues for an
application using io_uring zero copy receive. Add a test case checking
that steering flows into an RSS context works.

Until I add multi-thread support to the selftest binary, this test case
only has 1 queue in the RSS context.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 .../selftests/drivers/net/hw/iou-zcrx.py      | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index 0b0b6a261159..48b3d27cf472 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -21,12 +21,25 @@ def _get_combined_channels(cfg):
     return int(values[1])
 
 
+def _create_rss_ctx(cfg, chans):
+    output = ethtool(f"-X {cfg.ifname} context new start {chans - 1} equal 1", host=cfg.remote).stdout
+    values = re.search(r'New RSS context is (\d+)', output).group(1)
+    ctx_id = int(values)
+    return (ctx_id, defer(ethtool, f"-X {cfg.ifname} delete context {ctx_id}", host=cfg.remote))
+
+
 def _set_flow_rule(cfg, chan):
     output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port 9999 action {chan}", host=cfg.remote).stdout
     values = re.search(r'ID (\d+)', output).group(1)
     return int(values)
 
 
+def _set_flow_rule_rss(cfg, chan):
+    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port 9999 action {chan}", host=cfg.remote).stdout
+    values = re.search(r'ID (\d+)', output).group(1)
+    return int(values)
+
+
 def test_zcrx(cfg) -> None:
     cfg.require_ipver('6')
 
@@ -79,6 +92,34 @@ def test_zcrx_oneshot(cfg) -> None:
         cmd(tx_cmd)
 
 
+def test_zcrx_rss(cfg) -> None:
+    cfg.require_ipver('6')
+
+    combined_chans = _get_combined_channels(cfg)
+    if combined_chans < 2:
+        raise KsftSkipEx('at least 2 combined channels required')
+    (rx_ring, hds_thresh) = _get_current_settings(cfg)
+
+    ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
+    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} hds-thresh 0", host=cfg.remote)
+    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
+    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
+    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
+    defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
+
+    (ctx_id, delete_ctx) = _create_rss_ctx(cfg, combined_chans)
+    flow_rule_id = _set_flow_rule_rss(cfg, ctx_id)
+    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
+
+    rx_cmd = f"{cfg.bin_remote} -s -p 9999 -i {cfg.ifname} -q {combined_chans - 1}"
+    tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p 9999 -l 12840"
+    with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
+        wait_port_listen(9999, proto="tcp", host=cfg.remote)
+        cmd(tx_cmd)
+
+
 def main() -> None:
     with NetDrvEpEnv(__file__) as cfg:
         cfg.bin_local = path.abspath(path.dirname(__file__) + "/../../../drivers/net/hw/iou-zcrx")
-- 
2.47.1


