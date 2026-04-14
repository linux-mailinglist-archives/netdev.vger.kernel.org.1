Return-Path: <netdev+bounces-278587-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OONMOPTL3mnnIQAAu9opvQ
	(envelope-from <netdev+bounces-278587-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:21:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 450D83FF00C
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 01:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1168B303CA59
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 23:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FF439903C;
	Tue, 14 Apr 2026 23:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IEgrMzpl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E847E389DEB
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776208838; cv=none; b=l71g0EuQF9nIVyxNy00tdkjZhvP/piZbWOWg1pCaPL8hgA2SK+lcQ1Tdp7qWyA/H6tWq96F9lUsb3Y6oOvqEbGQLYYXFE4sdwJIrk4EiAohIRPD6XP9/s0hoQuVPfgM0Kr5S2vSOfF5WYDYWmJU8Yj3v7wJV2wv0N2AdnwwjUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776208838; c=relaxed/simple;
	bh=sXWSjkI2x2ulkH+O8/Qc+zL1CHMbazjbAzl27srzbVw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C9ZiI/1p5tYtWyYcwmVoyjgV2HWib09K5P2cCGiPJhmksLHjAHsEE81Hv7tiTXy7+0MmQW8GKgK8cHnAHWtIxghL9gyCJcf2o0Cy8tBwoS3vczh2tqKenBQiZ4JfW+6hHM/X+qN0xPTITmwqXfdjsMLOEAT8melaEKN/jnRkFKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IEgrMzpl; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso60096455e9.1
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 16:20:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776208835; x=1776813635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U8Lf8VBeYUO7ZSYpV41igFLgwMtvvclZ9hr/Y+OcW/Y=;
        b=IEgrMzplJ4P8mJnsEU3l2m0Upk0HLaWgsQoAj65WUD+Z0JUYynk+7RaEVsiG31jzsj
         qt3kJ2vtkrV5lTPHOl16h9UWvkmxUEK0h4yMCDTWtWo+CIi30UUrbqj2Ce+EEjXT7gaR
         svP6xrQy5BrhW6DliPXK6+TL+n5yTorZ+mXkY26q90X3jZSk2hMGerHelDqg4sTFAduH
         OSPfr8Fm2Q1k5NhJ5DXBHru+hr7If/Rcjqobr2Aa61ioqujMox+iHNyolgIMcsD4JrJR
         Dx8rIwRBoaUSSc/3JJLHE4ysm8HsvAUUo7T+VT2o3/PUQ9J4hyIbPYrdwgyttXADZNgi
         U9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776208835; x=1776813635;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U8Lf8VBeYUO7ZSYpV41igFLgwMtvvclZ9hr/Y+OcW/Y=;
        b=OW3OKmVBokVTM0iSSWEY1MHIkgBL3ZuV5KT8WA8SvdTIag8g7G3IHLXwlZDNtAz5a/
         Liqs5wo7+CYvf6GwhhOD96EGjM9eA5bKBpzLO6JaEz2xT9xo2pN46zO40GzR+3l0lYGN
         v/OGDiiaO7PujqTDEuHDb5nDSQaWzNRasl+LI+PvCxenmbx0BV6eGVXxqFO7xxkSBSdy
         QVIgeX6yvFfm+FTMC88TrPDklG/J4I5NKP7aJJskGd4r4LNd/N+iyeKGC7sy1E1to7LA
         4tiCGXx52gT/8YlQ+xBOCru7lWb/6Q33To/TU5y1lzb9jD1p2pa9WBSoOEYi5o17d7ez
         lMMw==
X-Forwarded-Encrypted: i=1; AFNElJ9kOIBQVNkuccmQaHc+L8BeP3uWTaVhsJeYAlU6IIPNTdwCRU3qBZXHz1IldpADTGlRSil+b3M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsjbd946GoSyyTkwETWL41GP0Bx+W1R3w6NE+zPh9iyQKslbky
	Qgz+WlJNYyHEMwlsURIorL7g3N7c04D3nJ9T1o+cYJ3NonrBN/LXjfyNpRbDXkxM
X-Gm-Gg: AeBDievFR52q3DCjMcBKanPQvTqqRLs5Ko6E+mbD8u7btwx0ZM2KKa7xVo14qRep+WR
	m7QjqJJA02rrHT8kTS8kQxEldkm7AMN5BVvzXbAvMy3kzD4FZjJ92RSn8qkvvv48oiPprmH3mj5
	yrp2My6VuCIqwyoLTKSb/5x+Ml1cztKioKiP9uzjaVDOGsu2KbbubI0PmP93RTzIbbIQrGnt4zO
	faKShwz3LcV+Oun4QowURV5ddx7gR+Hu+Q28bAJ/dCd6f7XwBKI8gmhwnh56sM1UTb7STDsknDR
	rBcR48wL+ZqGo8v2oPwBsl2xNQJrx3IIMGRyGOtfDBvS2sBKY0pp5PvoBg6XF2cmNKKON3mPt/v
	XPysFqO4LTHGRhHrTxz6cKuMtvFcRqIDgTQpT93hQSWoFhOf5mikZDyS09XlPMjSwUKdl+ttd4O
	RJ2h2pK7KRLJbzf681uWeuaoF1cR/9aq+z0YRLKqpLzka3mVVoNlKo+nR2CT7RUO+cuUHUxLKx1
	oZY+Zw1eQV3nwLbVMkVYyFGT8Llm/GoDZ4ZgPUlww==
X-Received: by 2002:a05:600c:5306:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-488d68c3385mr261389455e9.27.1776208835113;
        Tue, 14 Apr 2026 16:20:35 -0700 (PDT)
Received: from SD.localdomain (heme-13-b2-v4wan-167795-cust403.vm32.cable.virginm.net. [81.108.45.148])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ede1e05bsm138321825e9.6.2026.04.14.16.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 16:20:34 -0700 (PDT)
From: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Carolina Jubran <cjubran@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Tariq Toukan <tariqt@nvidia.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
Subject: [PATCH v5] net/mlx5: Fix PTP event stack info leak and NULL ptp_clock use
Date: Wed, 15 Apr 2026 00:19:20 +0100
Message-ID: <20260414232001.21875-1-prathameshdeshpande7@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,nvidia.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278587-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prathameshdeshpande7@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 450D83FF00C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In mlx5_pps_event(), ptp_event is not zero-initialized. Since it contains
a union, partial assignment can leave stale stack data in unused members.

Also, clock->ptp may be NULL if ptp_clock_register() fails.

Fix by zero-initializing ptp_event, using a local timestamp variable for
event data assignment, and guarding ptp_clock_event() with a NULL check.

Fixes: 7c39afb394c7 ("net/mlx5: PTP code migration to driver core section")
Signed-off-by: Prathamesh Deshpande <prathameshdeshpande7@gmail.com>
---
v5:
- Drop MAX_PIN_NUM check per review.
- Drop pin_config local guard to keep this revision narrowly scoped.
v4:
- Validate pin index against MAX_PIN_NUM instead of n_pins.
v3:
- Fix union corruption by using a local timestamp variable.
- Validate pin index against n_pins with WARN_ON_ONCE.
- Remove redundant pin < 0 check and cleanup TODO comment.
v2:
- Zero-initialize ptp_event to prevent stack information leak.
- Add bounds check for hardware pin index to prevent OOB access.
- Add NULL guard for pin_config to handle initialization failures.
- Add NULL check for clock->ptp as originally intended.

 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index bd4e042077af..77d7b81a0a25 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1164,7 +1164,7 @@ static int mlx5_pps_event(struct notifier_block *nb,
 							       pps_nb);
 	struct mlx5_core_dev *mdev = clock_state->mdev;
 	struct mlx5_clock *clock = mdev->clock;
-	struct ptp_clock_event ptp_event;
+	struct ptp_clock_event ptp_event = {};
 	struct mlx5_eqe *eqe = data;
 	int pin = eqe->data.pps.pin;
 	unsigned long flags;
@@ -1173,7 +1173,7 @@ static int mlx5_pps_event(struct notifier_block *nb,
 	switch (clock->ptp_info.pin_config[pin].func) {
 	case PTP_PF_EXTTS:
 		ptp_event.index = pin;
-		ptp_event.timestamp = mlx5_real_time_mode(mdev) ?
+		ns = mlx5_real_time_mode(mdev) ?
 			mlx5_real_time_cyc2time(clock,
 						be64_to_cpu(eqe->data.pps.time_stamp)) :
 			mlx5_timecounter_cyc2time(clock,
@@ -1181,12 +1181,13 @@ static int mlx5_pps_event(struct notifier_block *nb,
 		if (clock->pps_info.enabled) {
 			ptp_event.type = PTP_CLOCK_PPSUSR;
 			ptp_event.pps_times.ts_real =
-					ns_to_timespec64(ptp_event.timestamp);
+					ns_to_timespec64(ns);
 		} else {
 			ptp_event.type = PTP_CLOCK_EXTTS;
+			ptp_event.timestamp = ns;
 		}
-		/* TODOL clock->ptp can be NULL if ptp_clock_register fails */
-		ptp_clock_event(clock->ptp, &ptp_event);
+		if (clock->ptp)
+			ptp_clock_event(clock->ptp, &ptp_event);
 		break;
 	case PTP_PF_PEROUT:
 		if (clock->shared) {
-- 
2.43.0


