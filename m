Return-Path: <netdev+bounces-187584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C51FAA7E67
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 06:21:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FD6466F5F
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 04:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0073C188CCA;
	Sat,  3 May 2025 04:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="h97f5fMN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849FB171C9
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 04:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746246102; cv=none; b=cczEIZy34kkmX3ii3RtsE2HO9JZJPur9JDOYk9hl2cY29vLDuKeBJuhtz3GNTDgg8ROCZyl508GQXuxHMR1qalFkybN7Fnz6kAwTza9yyq17Cuscr4r6hQTk4uI0DL5pm9tkCyCZJhMqLT43NqbwdrJ4aZ56nivxWf+T1BFXOPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746246102; c=relaxed/simple;
	bh=QxiMRswJkuoSynqOCz9IQJxo1uYgcyJj6ly+F1R7OnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MTMIeeZrnoyDlOUPo2OCpu0ssFmVH3hw5A2QfvDBSvc8+aRdracJUi9M7BgitTgZERl1w4eYUYsbs9ATyZaRSPlfZbYprDv6LoLCA2atJuxVsSWiEHfAslIXIrY8Cp1kIuoRSLzcttkIQ69IlCyqlJr3quWPDnetjm84HyPGiqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=h97f5fMN; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b1fb2040de6so1005227a12.1
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 21:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1746246101; x=1746850901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dyxDzNRXnL7I1hojL9XNTjNOZBCXHZFUbgUsmuVCr30=;
        b=h97f5fMNLuZDyCt0OV9IYF+7+Jm1D9TM3R/qC1LQdk/fOvj2T+Z5LbZPECG0ZgaDfS
         PrrdLfJ7XqTBtQVuqFN6kRV/XVBXwznLjunZwlGDW8cS6pfj/gsL1pV5wqevDRwl47Up
         A9TvOIN5gEnjQ62Pu0Fw6dEMKb54nYnoOA2OBq9fYXYooze6yf6+XZNPI4Mg/3PDaNXw
         0AkyHI6Q3Yblv7vt8wL/csPlkSbMcWT6BTemB5suPpdKf/HxGsTWHku5tfRRgNk463/D
         3gw0PNBYKNLT0Tj1j3iEFYUlFRh6vs1I3uhfqvIvJHbHeSNKmL9wjB2SjsRJFe3kuu8B
         zNfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746246101; x=1746850901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dyxDzNRXnL7I1hojL9XNTjNOZBCXHZFUbgUsmuVCr30=;
        b=q0sPWKjPzKNMGZOMU23y78KUI3JwIFT9RDOwvb0cVLltm2xt0qpBgZRI6ZbCNifGbG
         X/13RkJVIGLDEERyQtlwSoaCnYMHsZkeq6txXWqZIl2dTfNa6boJewW/yDdkaAkQ17g6
         AxGn+JZfmpaSQU83qPwRPSlwRkGRlolt0aK+I/hy8R0yg+a+zQwNX0YwHfh4CCgvZx1T
         HaXJwN+2OgZ1bJC4OY0DzFy1PC6iLza3aVCH8j9+WXDpmK3goLk+ySLWjktLmm0OlFcR
         0ppGGyG6uLfGW/JrvvvWLsz598uISCV+ke8jAAE9LgqCQmeJqgzD+9cAXiAHusItsFYV
         Vatw==
X-Gm-Message-State: AOJu0Yz57xBrmRvxMX8uJsOO8s7KndJyMmW96pVp3EF4C5ZY8FkCgat9
	0HtXo4iZQHojF5v3SikQ0DCUl4LTvlD2XmgyWP2VbRK5no+PX08su92jJXoCvpPHKVnEY4OCMfj
	V
X-Gm-Gg: ASbGncu6IttAwWXNXLkF2Mc2rdOqMcqTb74K4rj/0ABBbVP1AXJByx2RlPeGAChoWoC
	6vAvSyCdTgEZkAVtU3kfcVMY0fVGVw48wodMJP20m4YVJ5+MxYQvdsA8K+M7TvL6QT/+90z9DdV
	mYkwe1tKC7FBIVb5mCpLQsj8czeiKwOfMI0ZJ3RpVZsykP6WLnoc8+WnOHNRX4LthgSTBWc0x7m
	d11FDb9x9SLkNTdB4w8HdospByIGNpeB1KFSwrjhCoS1BGeAo1i7kJytLOffNwg+GuvEr31nfc1
	X2qf+ybaKPq/eCqnzsG6n9ko9FA=
X-Google-Smtp-Source: AGHT+IEFBFQcqCqZLasR15Clpy5EseZk+HljA1puBc6LqxZ8dmXkVPt5wAUJs7+nh0JHjJDCzT4UZQ==
X-Received: by 2002:a17:902:d486:b0:215:58be:334e with SMTP id d9443c01a7336-22e1006129bmr74320105ad.10.1746246100700;
        Fri, 02 May 2025 21:21:40 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e150ebfb1sm16208635ad.11.2025.05.02.21.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 21:21:40 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH net-next v1] io_uring/zcrx: selftests: fix setting ntuple rule into rss
Date: Fri,  2 May 2025 21:21:33 -0700
Message-ID: <20250503042133.800768-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix ethtool syntax for setting ntuple rule into rss. It should be
`context' instead of `action'.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index aef43f82edd5..9c03fd777f3d 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -19,8 +19,8 @@ def _get_combined_channels(cfg):
     return int(values[1])
 
 
-def _create_rss_ctx(cfg, chans):
-    output = ethtool(f"-X {cfg.ifname} context new start {chans - 1} equal 1", host=cfg.remote).stdout
+def _create_rss_ctx(cfg, chan):
+    output = ethtool(f"-X {cfg.ifname} context new start {chan} equal 1", host=cfg.remote).stdout
     values = re.search(r'New RSS context is (\d+)', output).group(1)
     ctx_id = int(values)
     return (ctx_id, defer(ethtool, f"-X {cfg.ifname} delete context {ctx_id}", host=cfg.remote))
@@ -32,8 +32,8 @@ def _set_flow_rule(cfg, port, chan):
     return int(values)
 
 
-def _set_flow_rule_rss(cfg, port, chan):
-    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} action {chan}", host=cfg.remote).stdout
+def _set_flow_rule_rss(cfg, port, ctx_id):
+    output = ethtool(f"-N {cfg.ifname} flow-type tcp6 dst-port {port} context {ctx_id}", host=cfg.remote).stdout
     values = re.search(r'ID (\d+)', output).group(1)
     return int(values)
 
@@ -121,7 +121,7 @@ def test_zcrx_rss(cfg) -> None:
     ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
     defer(ethtool, f"-X {cfg.ifname} default", host=cfg.remote)
 
-    (ctx_id, delete_ctx) = _create_rss_ctx(cfg, combined_chans)
+    (ctx_id, delete_ctx) = _create_rss_ctx(cfg, combined_chans - 1)
     flow_rule_id = _set_flow_rule_rss(cfg, port, ctx_id)
     defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
 
-- 
2.47.1


