Return-Path: <netdev+bounces-180876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA07DA82C78
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 18:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96B5F1759D8
	for <lists+netdev@lfdr.de>; Wed,  9 Apr 2025 16:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4275D26FA5D;
	Wed,  9 Apr 2025 16:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="yQBl2ndn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B80267F5F
	for <netdev@vger.kernel.org>; Wed,  9 Apr 2025 16:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744216317; cv=none; b=fGLdmjQ5KYXbEm0ybesrsYzRXxBAwBg/0OmznHy0b8Rr5H08rYcs62Z3ZgzsDKZtPU+Tnn7BcHnOWiNpyrScSFILUET6AgbgCyiMg4J76HKEzEtYRJNfaE/HccvIGteU0CtJwI6QujJUg7hYpwaUV+eL1A9JgT4vTGYNRS2i+DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744216317; c=relaxed/simple;
	bh=GMlQkZAtqyu38Kh1mR6CNmcMksc79HmSKMDhLSYUQ9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EctPndfoppbCRfml33EiQM/csPdO1ToxHyyrnAFWG1zra4z0wAFm8oxtAts/YuVlWdlSSPYBjzOwI1oFOAXs9vFH/PtkCY8GlBN/unnrwa9GqfAWS6WpsJ70bWffY4MDoOMghHI4pXtwr/CsG6k3DhFmpzThB6E8MazkTZYCuMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=yQBl2ndn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-223f4c06e9fso11074515ad.1
        for <netdev@vger.kernel.org>; Wed, 09 Apr 2025 09:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1744216315; x=1744821115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=caFMeXLzKhYkJN016TTIAL1oCP7p/mYPtRG7DKEdig8=;
        b=yQBl2ndnSqVvAwumLQiFqdHsFZ01Kd3ESIsbSLJS29tyIQxzx6wj2VSidnC5zKRcux
         XCykHFFC6XbaYFCYZ8iqqe7z0XEg40pWSoy3LsTuySSjfENrGanewZqlluJ3f7INhd+t
         roNfXR8r2jRadoLQ+FWWuA05dLjZRzyE8qreDotQaH8nIsC3iMimpSanh+yWwTpFRp08
         Txec+cyHAaYqVkKUVLQ1LDOHlH92qrwSxX8ZQHa2qgyN+9LTBBT5NQsM4v1EnV5nf7kY
         DINH/RpitM2WJPZMAbZePAbG1hFVlnuIWufLwQJVb0NYcUj1Ria7sqkf+1+CKSDaCnpV
         rNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744216315; x=1744821115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=caFMeXLzKhYkJN016TTIAL1oCP7p/mYPtRG7DKEdig8=;
        b=slW263u1iHaTiSHcPIM+wd3ct8YegV2MgoBND6UJYMdEJfCYrEE2vS0LUXmhNGCzif
         GL0UFMBa0fdEKbrU6b3/2zZcCNxgXA+kAfhE5FOCAoKqEJao/S1Sviy5DeFF9B9o8Zpy
         1jFnwZFWNfhdIHIwEg7J0IShhzBYIkOlrabO7L8cPl04598AeZmqqgaUDMESYRJ94Dha
         5eCtcFV5ul2asDcMhpDQGE1HgCYzlZlKn+bWT7jWDQLPZ4lqyUbKXitjcrVmnsc/3WIj
         5RttF4+Sy69pzSkQUHwBJVY6UQOdKBOfhKeT1uiA2RoVM4AuGWi5zNVpOMQHE+hA16lw
         3xLQ==
X-Gm-Message-State: AOJu0YyTnsiGoCibgD9AECYywTWrkAKEipM9SLvV4rAqItA+SaVQRpxi
	3qH17NQp+cbYlBccONRkwfF1wTPcq+Qmf2A/2eMQ3fdIbtzzGaIpXwkP47B7qRYuf5WFn991JRN
	R
X-Gm-Gg: ASbGncs8IPPuAUuHo/jJAQ93vHIz8AhpOjbMevee16+js+nTlGsH+BXI7l3u2/bL+Ly
	Ng75EpOkRmiY/AsjlzPTPNLFNR+aTSVlL6rE5bnNC9Ek9xX9ateumHGZMEQHNmMHulJsH7YrpXV
	OX81qj052L64TFU8LcCIPMIq0YbUCjfipIDSlGTIDPrhD2OIhIAmgH+6Aw4WsC7uu6taIZu6Vxq
	hnuSDGBC7STlIR7PxWhhjJuKteoR9vwfqoSdS0GtkIQdVUTk399cOqHFzJDyky9nZeX83r3JQrN
	G3CGLqyXKc+7jioF1x/2Bv8=
X-Google-Smtp-Source: AGHT+IF3P1bhC2OymPSGdmvjE3MPnNHHSD5VFcTFLwJa1MMq1m/SlDKND0R8A4QoPPMBKLO++hRdvA==
X-Received: by 2002:a17:903:41c7:b0:21f:53a5:19e0 with SMTP id d9443c01a7336-22acfe55ba7mr1623325ad.12.1744216314910;
        Wed, 09 Apr 2025 09:31:54 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bb1d68cb1sm1548275b3a.75.2025.04.09.09.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 09:31:54 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: [PATCH net-next] io_uring/zcrx: enable tcp-data-split in selftest
Date: Wed,  9 Apr 2025 09:31:53 -0700
Message-ID: <20250409163153.2747918-1-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For bnxt when the agg ring is used then tcp-data-split is automatically
reported to be enabled, but __net_mp_open_rxq() requires tcp-data-split
to be explicitly enabled by the user.

Enable tcp-data-split explicitly in io_uring zc rx selftest.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/hw/iou-zcrx.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index 9f271ab6ec04..6a0378e06cab 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -35,6 +35,7 @@ def test_zcrx(cfg) -> None:
     rx_ring = _get_rx_ring_entries(cfg)
 
     try:
+        ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
         ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
         ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
         flow_rule_id = _set_flow_rule(cfg, combined_chans - 1)
@@ -48,6 +49,7 @@ def test_zcrx(cfg) -> None:
         ethtool(f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
         ethtool(f"-X {cfg.ifname} default", host=cfg.remote)
         ethtool(f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
+        ethtool(f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
 
 
 def test_zcrx_oneshot(cfg) -> None:
@@ -59,6 +61,7 @@ def test_zcrx_oneshot(cfg) -> None:
     rx_ring = _get_rx_ring_entries(cfg)
 
     try:
+        ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
         ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
         ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
         flow_rule_id = _set_flow_rule(cfg, combined_chans - 1)
@@ -72,6 +75,7 @@ def test_zcrx_oneshot(cfg) -> None:
         ethtool(f"-N {cfg.ifname} delete {flow_rule_id}", host=cfg.remote)
         ethtool(f"-X {cfg.ifname} default", host=cfg.remote)
         ethtool(f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
+        ethtool(f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
 
 
 def main() -> None:
-- 
2.47.1


