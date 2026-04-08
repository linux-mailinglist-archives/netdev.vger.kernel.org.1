Return-Path: <netdev+bounces-276681-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN2dNDKi1mlUGwgAu9opvQ
	(envelope-from <netdev+bounces-276681-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:45:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 719AE3C16D3
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 20:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D695B302CE08
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F883AEF5F;
	Wed,  8 Apr 2026 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="rsHR1N/V"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63033D6689
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673905; cv=none; b=aHLrAULAyIbeZCfaesEetZdn/1GXYoMLsEYMRSQzD3EouN+3HqscKuyYRz8oCEJIerBmXW05u0mlrzW581Qt3r/oLnEpA+0bIsriAlPs3F1xxpINa9et16MW9d62kw3uD7N6011/DwiiP8fGJQ4P1j62hASl3lEDEon8u46XD/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673905; c=relaxed/simple;
	bh=4ourjhFNyqPpKvwJ8NGSQQW1AjLtpzj4KUeHaeRYcQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqGwbkV4NyovS8rG1yLIHHqZn7o7nfYGhXfEEvYDGO5cDaIsHtolTIkWRSh+jQAvXdaLA69DN4j1ITWJeM/pvevFmx9Sp5KUDV0RVZ1Ponn2QaC0A2lyscvmiL7ukCYQ5kluTu3Flvpb38BbteyGfly9az/58BPxG2yuBze0OSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=rsHR1N/V; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso448825e9.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1775673902; x=1776278702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=L0S2R3Jh2NO33hqto219r9Y9rGESH0KYk2ZJTa8dPv8=;
        b=rsHR1N/VHqNNP8XX6Jrmq9EEVyPDajohdFH+bV0TxBEXiIuktL9kqHyb57w2rNIyPb
         +rDbJUG7C0YJDG1c+kYdcKbL+DqFeKRynu0XV9hDEaFcUSLh962lD+B8DZthZ++xXq1d
         z5HYOtzc6XK1uE7abDbbxrHkyqnILL1rN0tZu9xGZI5o8NKpQShkaE4FPsoHRORDA5HK
         E+um06b/PAhfjFyj0MMC69k33uiKUgc9bwjrP4ZG7WYE9hfhtYGwMw5aGUGbHN9WcQcW
         hLt6jbe7oTD2tat0Ox7IsCGKHN8tgBOxM9ZHv4KTkZnVBySmEb3jjet4uuwqQTGdM7Uo
         vH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775673902; x=1776278702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L0S2R3Jh2NO33hqto219r9Y9rGESH0KYk2ZJTa8dPv8=;
        b=Hxk4gPx6mpynmA6sG0moDo1sOjdlqGq63S7BX+2tRFnTUt8i9GrL+XFXdRVSxN78iB
         pD1Qww5MRLTlyENiqZGNnD+//lg9QNKUG37G+NsbKqFbbRnO/zsW3QyHduecJWy07YIb
         sKqiwEXyhqPCY6NeJ+iJzy8LKy8nnxvW+eU5s4OU2GuV3bphyxYB2rlBjv0ln3FoougO
         yLpMOaXn3CU7hxHoY4sMOVKsT6xBayOP7XrNsoGzzN2gGdV2/5txMcmNTqfpKNCECaEu
         XubUISqXZPqBiqnPv/BttrY5PgGUudvdWRzUzMTQgzymOIPBbERj/l4oeixtfeK/yDZS
         Q1UQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1lu/hWJeUxDMBN2DCle5r7GoimHuZDqUbdI+R3fxGPeZiYETr8pPNoLX5PiCCtVSf5mkZA9c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRCKkBOhf7rr2MaQ2qc7Ayi/6aqKMJEkytMG5tgvXuLoMu0O4d
	KzizJGngQbuAD70LCzlY+RTChT2vAxp8X1O8B5TTh2ebAkEYzY4S/EI1uGOlE6HfOvY=
X-Gm-Gg: AeBDieuPRnhY5qQVjBfziqPpun4bKJ0hlYaWzP3VtN0RyE1DcwNlz2PJJ5YVRamPMOu
	3QWTy/XcE1dOnPX+TufzYZUo700S9lENyJqufn8024lk15p5pXJ4fikSW2Y3VGwReOXkdYooug1
	A6b6tOfB0RaPTXOC8fQ4wih27x1+WiJhayFsz2atEW0mjpVrSrdTdh5MEUkWfnOYrTZfrU2f0XY
	miN5PDSON25VHTL75hnv8B26UYCguvofmef42I7Mx6JA4MIJRfWv6ENDBtyLJ2L6/dJaBln/Xm9
	jSuMjRMiscR9pde+gvJxmwapkqVEsFbhhcc4yidRz38LcIeZl3IIRtnHN4VWTYkFGboJED5rIY4
	ey5rKpPPiut7zBeUeeg5k6c6+46YXoIkMYUtXkPJTDspkulq+tsQUsolZtITGnSKAx8326N30yg
	isv49bADR02IQjlfvZ1DWy3Tbc6g==
X-Received: by 2002:a05:600c:8b52:b0:486:f9d0:aac8 with SMTP id 5b1f17b1804b1-4889978140bmr335703905e9.18.1775673901890;
        Wed, 08 Apr 2026 11:45:01 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:ec8::179:1f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488cd0f4d7bsm8293615e9.1.2026.04.08.11.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 11:45:01 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: [PATCH net] net/mlx5e: Fix use-after-free in mlx5e_tx_reporter_timeout_recover
Date: Wed,  8 Apr 2026 19:44:58 +0100
Message-ID: <20260408184458.1274662-1-matt@readmodwrite.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[readmodwrite-com.20251104.gappssmtp.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-276681-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[readmodwrite.com];
	DKIM_TRACE(0.00)[readmodwrite-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matt@readmodwrite.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cloudflare.com:email,readmodwrite.com:mid]
X-Rspamd-Queue-Id: 719AE3C16D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Matt Fleming <mfleming@cloudflare.com>

mlx5e_tx_reporter_timeout_recover() accesses sq->netdev after
mlx5e_safe_reopen_channels() has torn down and freed the channel (and
its embedded SQs). Replace the three sq->netdev references with
priv->netdev which is safe because priv outlives channel teardown.

The netdev_err() call already used priv->netdev for this reason; make
the trylock/unlock and health_channel_eq_recover calls consistent.

This fixes the following KASAN splat:

  BUG: KASAN: use-after-free in mlx5e_tx_reporter_timeout_recover+0x1dd/0x360 [mlx5_core]
  Read of size 8 at addr ffff889860ed0b28 by task kworker/u113:2/5277

  Call Trace:
   mlx5e_tx_reporter_timeout_recover+0x1dd/0x360 [mlx5_core]
   devlink_health_reporter_recover+0xa2/0x150
   devlink_health_report+0x254/0x7c0
   mlx5e_reporter_tx_timeout+0x297/0x380 [mlx5_core]
   mlx5e_tx_timeout_work+0x109/0x170 [mlx5_core]
   process_one_work+0x677/0xf20
   worker_thread+0x51f/0xd90
   kthread+0x3a5/0x810
   ret_from_fork+0x208/0x400
   ret_from_fork_asm+0x1a/0x30

Fixes: 83ac0304a2d7 ("net/mlx5e: Fix deadlocks between devlink and netdev instance locks")
Signed-off-by: Matt Fleming <mfleming@cloudflare.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index afdeb1b3d425..8409ae73768f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -160,13 +160,13 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
 	 * channels are being closed for other reason and this work is not
 	 * relevant anymore.
 	 */
-	while (!netdev_trylock(sq->netdev)) {
+	while (!netdev_trylock(priv->netdev)) {
 		if (!test_bit(MLX5E_STATE_CHANNELS_ACTIVE, &priv->state))
 			return 0;
 		msleep(20);
 	}
 
-	err = mlx5e_health_channel_eq_recover(sq->netdev, eq, sq->cq.ch_stats);
+	err = mlx5e_health_channel_eq_recover(priv->netdev, eq, sq->cq.ch_stats);
 	if (!err) {
 		to_ctx->status = 0; /* this sq recovered */
 		goto out;
@@ -186,7 +186,7 @@ static int mlx5e_tx_reporter_timeout_recover(void *ctx)
 		   "mlx5e_safe_reopen_channels failed recovering from a tx_timeout, err(%d).\n",
 		   err);
 out:
-	netdev_unlock(sq->netdev);
+	netdev_unlock(priv->netdev);
 	return err;
 }
 
-- 
2.43.0


