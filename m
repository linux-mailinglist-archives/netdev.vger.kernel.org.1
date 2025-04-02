Return-Path: <netdev+bounces-178865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA831A793CE
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 19:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336E0163751
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 17:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B5119F419;
	Wed,  2 Apr 2025 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="AlEN19kK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A51519A7
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743614704; cv=none; b=rK3Tk5Rj9YUWXjHaU9XnPJrVkZlVfgWWrvoiboXqwsH+zP+r9cW6CfbuAOxHqMeA1s92c11YJeZoR+QfxTebQ5sHkuzAgyOvcnjfj997FGfvfDfhpnvQ+k/wD/EOijTmHrOW6pq/Su93PYB54CtpFWAd9Rnjrffq/9IGQcpGuzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743614704; c=relaxed/simple;
	bh=fOiC6Hiuda03aNQg4vRQ/rSLcFRDP8t43svVgEeXdEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RvNRzRHXyPNue2MSRnrYUMAeEd/Gdyc43v/KKUWtDBmfLrVlSBPz+kXoOT7TjsBhkEO00m0u4fuIs2oQdbk/ZlBGHnqMgXt54bsydg1pn8ycNGdFqsWaItEXA0EGylV0wCKBA+FOqeH092uqOQ+kF7NrVYVOx70zOa0J+I9TLxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=AlEN19kK; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2254e0b4b79so1036425ad.2
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 10:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1743614702; x=1744219502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xn3IXbD9u4lsSxpjVk10/JAE9D6FY55+ZqseSA0nMuA=;
        b=AlEN19kKCpOU/HJWbsXY30H7BtW9U8owAJvuNzNwOjyKfoxi8Y9+5880SIqdFa6jRj
         HKmuSr5gA7stFsZcYE3jAmHJ/dYGovUu6xF+696fyS3auiKTY95z4lDwADq688xmAdZT
         PXEVY/vdukA11shdiF02tcPP0uAuEKewym6FiGjQ8dyPdrhCpIT4wuCk/pnIkCwpuh3e
         yKd8GgRfNxa8ZQ7DTml6hpqSHctwkjsJoc/+/cEuUh6BGzZ+2EzeBgmQLSdaAprP7dH4
         UmRKdtAyPeZmHO0b7uYOwrkpHw7YVEOjZ7ISG5EN2+0m3C4miGQpnAJAXoqyywGuW5PE
         9LSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743614702; x=1744219502;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xn3IXbD9u4lsSxpjVk10/JAE9D6FY55+ZqseSA0nMuA=;
        b=jMy9+yYptXD430MZXoyVpwGvVG4vvEwxGR9xOCSH30Yt7oMK0JKYmcggxnG8uU5J8O
         XTpeLE8gYMTqX24Y9HhkO15DQdfrnWsP/VJIWh2YFHDPAr2VPCvhrSTZuaSjEXowXIah
         UwAPox8YT9A6zO03ujebEbiNy5q5PJHFEuS7wJup4wAb/NFfvaDSYnnwUNl0RhjQDzts
         13uMDvOAfzkx/xPTc4N0DuFp5HIwo/ACoMjX+fybj5jhWFOo8SB63XfrRJ8Lmh931Ttc
         GKJcI58m76kQCdRufvT8TzfYPMUMoNFoFyFF0WWLgGvzXbu941CN1UhW7LCuBmrkHKmB
         SybQ==
X-Gm-Message-State: AOJu0YzzFbZytTTM1eQXASWgXbf8MTYWgv0XCQasjhGSrmHpdU+k0WCn
	wPRkXHGd2jTb1LGkuAufrFx5XXkQiN5pNsxxWOs2biPDhkAQL94ZftAzcjjQ7snrmv9HMkvgBbp
	A
X-Gm-Gg: ASbGncvdWlC7vNoWBmD3wQ59m0xLkhzCaPCjijbJFRhRhw4tHV+PhjaCergYHGjALD4
	wD3M1A98BSLmeKbyMhOF4SY68D9CrRjGXroj9bjzWMJDMNLY52sxIV6AapBaBOrNQwwKDjrgaaA
	ZfGa3fqdCPST2A10ylTLm8qcESqPXR05IEQrRP/wZjkoFGLb2+/08XTtvMOekWPzMSLWz9J6+lY
	+VViXHWE4mcsyNJeYEzb6MASpmegpf2vA03rOORfA4+hb9mAPC2hxlc19TC1sT3RkHWAvEU3k45
	ydkhdAPQOLwEy+PHOcf9o0YYqPCgGAhi0hORr5LYaA==
X-Google-Smtp-Source: AGHT+IGfzuEy4cbopAmt7XwpZhK64D04u8piY8NJQ60QzD9/cEtm9dD6NFDY5C99mRU7IobBgAbXmQ==
X-Received: by 2002:a17:902:ea03:b0:220:c813:dfcc with SMTP id d9443c01a7336-2292f9fa333mr294073445ad.40.1743614702327;
        Wed, 02 Apr 2025 10:25:02 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291eec71dbsm111145075ad.1.2025.04.02.10.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 10:25:02 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net] io_uring/zcrx: fix selftests w/ updated netdev Python helpers
Date: Wed,  2 Apr 2025 10:24:14 -0700
Message-ID: <20250402172414.895276-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix io_uring zero copy rx selftest with updated netdev Python helpers.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index d301d9b356f7..9f271ab6ec04 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -27,7 +27,7 @@ def _set_flow_rule(cfg, chan):
 
 
 def test_zcrx(cfg) -> None:
-    cfg.require_v6()
+    cfg.require_ipver('6')
 
     combined_chans = _get_combined_channels(cfg)
     if combined_chans < 2:
@@ -40,7 +40,7 @@ def test_zcrx(cfg) -> None:
         flow_rule_id = _set_flow_rule(cfg, combined_chans - 1)
 
         rx_cmd = f"{cfg.bin_remote} -s -p 9999 -i {cfg.ifname} -q {combined_chans - 1}"
-        tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_v6} -p 9999 -l 12840"
+        tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p 9999 -l 12840"
         with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
             wait_port_listen(9999, proto="tcp", host=cfg.remote)
             cmd(tx_cmd)
@@ -51,7 +51,7 @@ def test_zcrx(cfg) -> None:
 
 
 def test_zcrx_oneshot(cfg) -> None:
-    cfg.require_v6()
+    cfg.require_ipver('6')
 
     combined_chans = _get_combined_channels(cfg)
     if combined_chans < 2:
@@ -64,7 +64,7 @@ def test_zcrx_oneshot(cfg) -> None:
         flow_rule_id = _set_flow_rule(cfg, combined_chans - 1)
 
         rx_cmd = f"{cfg.bin_remote} -s -p 9999 -i {cfg.ifname} -q {combined_chans - 1} -o 4"
-        tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_v6} -p 9999 -l 4096 -z 16384"
+        tx_cmd = f"{cfg.bin_local} -c -h {cfg.remote_addr_v['6']} -p 9999 -l 4096 -z 16384"
         with bkg(rx_cmd, host=cfg.remote, exit_wait=True):
             wait_port_listen(9999, proto="tcp", host=cfg.remote)
             cmd(tx_cmd)
-- 
2.47.1


