Return-Path: <netdev+bounces-238776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 538A7C5F52B
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 22:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E72E35CDE1
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 21:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB763446CF;
	Fri, 14 Nov 2025 21:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hLMy7JoI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397A2301486
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 21:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763154745; cv=none; b=XHLgIuZ+2SHtu9McD9DEAs4sVdEqhMIPqEbQLThXGCEQ9jahaHEuWyq5OqVcl41z1m6riJko5/UsjrxDQVd4+BEzIlMCGLud6q4C78iU4v8MAq0J2Ygjx1d9LcvhRv9PLWXnBzGqwybHczF+tXIG6YmcngzfDEKDgO6nRayGMhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763154745; c=relaxed/simple;
	bh=ByKZPuk2HGQW6OhN65KtLVsYzAqmXFSrQnJxwSyHvLI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZL+DXxL1+zVIDUCQSWMM5zH9Lf8KeFXvT3zlcT7ArlNoX0t9aO/4hYr/Bke4MSk2zvxGS4PAowao/Oe4WAH0X5PMkgeSNEElrae3abmNNFEIlqJnIGGCrKdY1J9yMhfqSHOvUW2yE9Hf89DpxRGCAlPsYuQXtrzKWvniAjyBmw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hLMy7JoI; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-343725e6243so3688813a91.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 13:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763154743; x=1763759543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QKBHl2B0t2rsNVRLaKmcfcEl1iIRuO5Q1cRjHVhm6UQ=;
        b=hLMy7JoICx8hjCHoeyfhipxGfrq8dFXdrwbUYzuqzmbBmucoAvJt9sp8jOJhaFdy9f
         w24d3hticl5H3hjsgPf8zlWh0/KOFwY3c5hBbSzLTYGZJ8I+Prk3kywUL4pqzPQASGJn
         cJe0xEGpKT1+RXvARBAMzrnAv/RNmYIzyjdpNKr5zuL7i3yc/bCEZ58+4QvjfsjTK7Il
         SZSLdvEqemTJaHyIu1kpDlvswhzCrIdz8YTtOTElZgpJVqd/aysNiqCabuoE6iZKSOJ2
         ws2oY9AWxwFFPV7PuHE8TTQfcqqWwSMki5GKdzWDrTtCzunNYn3Eg/Pp6ppRa5x+N+Wu
         jNvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763154743; x=1763759543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QKBHl2B0t2rsNVRLaKmcfcEl1iIRuO5Q1cRjHVhm6UQ=;
        b=WcAlnIHXhNDDxQiQaLy/g6G4BUBrSXkdUZhREF7GX5Y5yJTuRE9MzomMvfzqsQ4ir0
         SC4WZuIlUZD6c+ivrd962jYAUXrnkc3FhMCGwQkPUnvDIFLhJw7pVOAZ+IZ0yhksJiiu
         MP+ug1nk2PnYkRxzn/9gwj/R6J0CjV8rDyGYi0zOd+BZbtkfE3Vwnq4tWHq7zqVbOHu7
         rCdXlibP9EnMQEkZJMXNAGtd2ixGPLk/Wd3AikPES8K73T0huj9fO6KzGVcEGShrRZAC
         9bB6/azi0Fq7wtRmMTgFwtR+aT24yBM2sN3PxztroWCdOTg5bBC3T2QZ1AjqnxbEvUVe
         F0kQ==
X-Gm-Message-State: AOJu0YyPH+FfYP2C54r1f7UMw3dqONKVUzGbeEgu9cj0bbc4yIkDKhIM
	wZ8G9yj1+q3x/ExVpkjevL2oQ/EwvVjiVOeinnob50Y9ts72IFvPBlEGtqZPAfbuQDp8YJ7JUBZ
	j9+hd8ttMzmU4rw64QguDOhq3dWlP6LQpEgpPmXhVicessoOx1EcItEoM1p+QvKDRv8AcCzqejB
	zW652VwlUHO/n9mnPoQ5b3WqqNj0+GzPLyNv1rc7/A/m/O4l4=
X-Google-Smtp-Source: AGHT+IGWVBv3Pww1t7WePIYslvvfU7cKUspRKFbH+20W0IFFp4fY2S5t4bjF/WQt153NaTPY5mB4phKvdG0f9g==
X-Received: from pjbms13.prod.google.com ([2002:a17:90b:234d:b0:341:adc3:c051])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1811:b0:341:1a50:2ea9 with SMTP id 98e67ed59e1d1-343eacbf2e9mr9594441a91.16.1763154743307;
 Fri, 14 Nov 2025 13:12:23 -0800 (PST)
Date: Fri, 14 Nov 2025 13:11:43 -0800
In-Reply-To: <20251114211146.292068-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251114211146.292068-1-joshwash@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251114211146.292068-2-joshwash@google.com>
Subject: [PATCH net-next 1/4] gve: Move ptp_schedule_worker to gve_init_clock
From: joshwash@google.com
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Willem de Bruijn <willemb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Tim Hostetler <thostet@google.com>, Kevin Yang <yyd@google.com>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Tim Hostetler <thostet@google.com>

Previously, gve had been only initializing ptp aux work when
hardware timestamping was initialized through ndo_hwtsatmp_set. As this
patch series introduces XDP hardware timestamp metadata which will
require the ptp aux work, the work can't be gated on the
kernel_hwtstamp_config being set and must be initialized elsewhere.

For simplicity, ptp_schedule_worker is invoked right after the ptp_clock
is registered with the kernel (which happens during gve_probe or
following reset). The worker is scheduled in GVE_NIC_TS_SYNC_INTERVAL_MS
as the synchronous call to gve_clock_nic_ts_read makes the worker
redundant if scheduled immediately.

If gve cannot read the device clock immediately, it errors out of
gve_init_clock.

Signed-off-by: Tim Hostetler <thostet@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c |  4 ----
 drivers/net/ethernet/google/gve/gve_ptp.c  | 12 ++++++++++++
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 6fb8fbb38a7d..2b41a42fb516 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2188,10 +2188,6 @@ static int gve_set_ts_config(struct net_device *dev,
 		}
 
 		kernel_config->rx_filter = HWTSTAMP_FILTER_ALL;
-		gve_clock_nic_ts_read(priv);
-		ptp_schedule_worker(priv->ptp->clock, 0);
-	} else {
-		ptp_cancel_worker_sync(priv->ptp->clock);
 	}
 
 	priv->ts_config.rx_filter = kernel_config->rx_filter;
diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
index a384a9ed4914..073677d82ee8 100644
--- a/drivers/net/ethernet/google/gve/gve_ptp.c
+++ b/drivers/net/ethernet/google/gve/gve_ptp.c
@@ -133,9 +133,21 @@ int gve_init_clock(struct gve_priv *priv)
 		err = -ENOMEM;
 		goto release_ptp;
 	}
+	err = gve_clock_nic_ts_read(priv);
+	if (err) {
+		dev_err(&priv->pdev->dev, "failed to read NIC clock %d\n", err);
+		goto release_nic_ts_report;
+	}
+	ptp_schedule_worker(priv->ptp->clock,
+			    msecs_to_jiffies(GVE_NIC_TS_SYNC_INTERVAL_MS));
 
 	return 0;
 
+release_nic_ts_report:
+	dma_free_coherent(&priv->pdev->dev,
+			  sizeof(struct gve_nic_ts_report),
+			  priv->nic_ts_report, priv->nic_ts_report_bus);
+	priv->nic_ts_report = NULL;
 release_ptp:
 	gve_ptp_release(priv);
 	return err;
-- 
2.51.2.1041.gc1ab5b90ca-goog


