Return-Path: <netdev+bounces-185817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 122DEA9BCC2
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 04:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D071BA5A0E
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 02:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2984C155342;
	Fri, 25 Apr 2025 02:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="cnBUwAUz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5031482E7
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 02:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745547655; cv=none; b=Uu8C1CoXdY5daaNPty+wXmIsjqG/vPZFjV6YONle2IBU6NTXN0U4xHS9ubOXx0A+uoUjv02/rGIAXK1wt47/d0TWt0W40+vzsn9sn1FxXnDDuMh5z+JhRDTjiFl4I0L8vm14bazDbuJNW1szxF9b9kJAIQQ5AvPG9M8ndwNS1fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745547655; c=relaxed/simple;
	bh=XUOzoXQ/Juh1wPXYRtBYu10MzV6wWdRGmL8YlhgCS2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UTRirTBhT+V2Lcs5Zwsc7L8nYdm0cL1UnqRQYvKBOB1NR/r6pBTPs/x+SAw7I0ipD2VauMN1GTo+3WZLgMjTLy1PP2HqS3MFCHqCnH1Gf6B8OyW/Jy+g+VCl+i6qtJ0N7+BdPWGa1ylqXRwGjviMBaiuBKUBpHkiWW0a7/xuONY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=cnBUwAUz; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223fd89d036so22140565ad.1
        for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 19:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1745547653; x=1746152453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDwAHMbfvpZyfmoa3ErGmEnc1IDh6zA+iMngd5kbowo=;
        b=cnBUwAUzIqIptPG3zsAZOojAPHaWpKgE9AEtVeCJaCNCoBfYQDwzCZXeUHS8rACnRH
         qv92PHkQGA4U8X+DunYU+ljKe1UtrsfMK5x8FUgcWpTI8EnWm6wv+kZx4QG2MithbKc7
         rM4MPyPh3TOEHs+8PFVOKHfDLRfmTNeAUtO+/FKeZ309jqMscmxCnD6xA4UgG9Cf2tO9
         IhTsAb71xDoVbhgCe0pTAUgd/JgRPdhQ9a+Tb7NxjYZtWRY3mNWLXqwdyDxsTcTtHaTI
         DKdirSXDbUc00kq/E8BxzcsatuaJJXldEz5yp9mChxXd+Kt9FUCrrCzlb9bBfQuA2Icz
         5HIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745547653; x=1746152453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDwAHMbfvpZyfmoa3ErGmEnc1IDh6zA+iMngd5kbowo=;
        b=Ap6fq9ITYOqzLTVSxK6bE3wCV8mFcMulWZz2eZo2LR4R9Qnr+yhl5qwfhpqDyClC4a
         oEog9xBh6U3vwi0WG120JI55PmcbeEb2J282kj681gXt6U9vCQkKTtNT2HhW8mOSpZdv
         /NZ+Hwo4bZqWUUp/PfMAZrUE0PzJJFE9TDHVmSCV/4V4xPBY7/oEMYYKR5PSdVlP2cLz
         4TvszMhHIBBX4VH5g7EqdhCClYv57z1Hqb0T3SeAfH4suDO/R++abN5AwUFFa0ad4bj6
         jH0J+a297g91b+uFIer7gn45SWfoUrmaW36B7ALXrIqktA4SSoZFxbTaJynUx9McxVeH
         br+Q==
X-Gm-Message-State: AOJu0YxTwekZb4Sdu3XVhhbgVkFwkCO75I/FeoUE6xBkwOnacJjQZcWa
	0rtvfPlkLP2SZ8z+WU52MLvdHzCU2bADce9K5BI/H23Br/pFpY9PqdkRsOE2K0u6912k9Bx25WH
	l
X-Gm-Gg: ASbGncvBabf7sqaPjYuekKPI9ORyNcol/OY8ELmsqCovWX+3zZ6ObTyB5mnw3MfKxB4
	PtNY7f/8JM/hVMQFN6IJBnzahaW7HHQcJ/v+VhZlle7zXiV2PB+Eam6bY2a89NTLT4d7idmpWrU
	33t9+/EvOgp4aL+GSeJvsvXtU3+Uhu60jarbrTWTRpcsgcTuv13DQ1zUwdzt6zpqnESARKHHKGK
	Gn/BUA0QwQ2XNcAlsZuJrUdWJ7x9MIpxn2crGdkHQhIKHMTj+b2zV4Dwfae4Rc0gt05hv4E/bFu
	HKodX7Nrtqz4Xo0zA5SRpSoKYQ==
X-Google-Smtp-Source: AGHT+IH6rz38r33SGwkuBWAEWWmR+5+Sq1QZr3KZ4pnPfPgmYfglNiKfjHqCABJLCzfGLbYBi7Xcvg==
X-Received: by 2002:a17:902:cf05:b0:227:eb61:34b8 with SMTP id d9443c01a7336-22dbf5f3302mr8729135ad.25.1745547652868;
        Thu, 24 Apr 2025 19:20:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76ff7sm21114715ad.10.2025.04.24.19.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 19:20:52 -0700 (PDT)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v1 2/3] io_uring/zcrx: selftests: set hds_thresh to 0
Date: Thu, 24 Apr 2025 19:20:48 -0700
Message-ID: <20250425022049.3474590-3-dw@davidwei.uk>
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

Setting hds_thresh to 0 is required for queue reset.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 .../testing/selftests/drivers/net/hw/iou-zcrx.py | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
index 698f29cfd7eb..0b0b6a261159 100755
--- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
+++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
@@ -8,10 +8,11 @@ from lib.py import NetDrvEpEnv
 from lib.py import bkg, cmd, defer, ethtool, wait_port_listen
 
 
-def _get_rx_ring_entries(cfg):
+def _get_current_settings(cfg):
     output = ethtool(f"-g {cfg.ifname}", host=cfg.remote).stdout
-    values = re.findall(r'RX:\s+(\d+)', output)
-    return int(values[1])
+    rx_ring = re.findall(r'RX:\s+(\d+)', output)
+    hds_thresh = re.findall(r'HDS thresh:\s+(\d+)', output)
+    return (int(rx_ring[1]), int(hds_thresh[1]))
 
 
 def _get_combined_channels(cfg):
@@ -32,11 +33,12 @@ def test_zcrx(cfg) -> None:
     combined_chans = _get_combined_channels(cfg)
     if combined_chans < 2:
         raise KsftSkipEx('at least 2 combined channels required')
-    rx_ring = _get_rx_ring_entries(cfg)
-
+    (rx_ring, hds_thresh) = _get_current_settings(cfg)
 
     ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
     defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} hds-thresh 0", host=cfg.remote)
+    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}", host=cfg.remote)
     ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
     defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
     ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
@@ -57,10 +59,12 @@ def test_zcrx_oneshot(cfg) -> None:
     combined_chans = _get_combined_channels(cfg)
     if combined_chans < 2:
         raise KsftSkipEx('at least 2 combined channels required')
-    rx_ring = _get_rx_ring_entries(cfg)
+    (rx_ring, hds_thresh) = _get_current_settings(cfg)
 
     ethtool(f"-G {cfg.ifname} tcp-data-split on", host=cfg.remote)
     defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto", host=cfg.remote)
+    ethtool(f"-G {cfg.ifname} hds-thresh 0", host=cfg.remote)
+    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}", host=cfg.remote)
     ethtool(f"-G {cfg.ifname} rx 64", host=cfg.remote)
     defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}", host=cfg.remote)
     ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}", host=cfg.remote)
-- 
2.47.1


