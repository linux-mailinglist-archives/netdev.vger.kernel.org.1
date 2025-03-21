Return-Path: <netdev+bounces-176628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 576F5A6B243
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 01:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07AA218992D2
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 00:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AC370820;
	Fri, 21 Mar 2025 00:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="geEeMLjT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931601E4A9
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 00:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742516964; cv=none; b=UvuBDMurrw6v7hR88A67wwHXH1Fh107tdDpT7N1+bPTcIihKl4Iy1Tqynbp+Eb8XjKHlw4eUD1nDGTQ90agOB0r7YLWCouesm6HL8trn1ylobbeK/O/fr87HaaOJb8+/igJsSIWii5+zmu6jCEYP3Q5e5G+RN+FzCVRYfKQX7iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742516964; c=relaxed/simple;
	bh=Jbm7GYaJXcjd03+tuScQgxz8fqw00dOQwC1LuGpDchY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YGkij1Gk1r6UHg9sH7hPi5iXF3hQYRT2XZZ9jBl/P25EsCkOgq/L95+HuIOhavZRAlbyhBvoTVrINhe2hImuIMemnAzJ1k3hcA2etBlX9QtO3uMq/Plx3LulwLRi4ofFHUf1eAlGRQnI3pkNW8cr1sUEMIP3vzzy07R4H+OPn0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=geEeMLjT; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2feb47c6757so1494508a91.3
        for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 17:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742516962; x=1743121762; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KoTBbWww7JEQC+F5jRMP+bnOpvYvD/+5OAlhy1ULkuk=;
        b=geEeMLjTSdLTdOKmTL2VSJ6nhZu2vOQdxNxwK934MjNLfhmNL72gdx0YamiIFAduVu
         0/jNV6T/6traltcsEO2ihRo5TNMFXhvbLNyOWlxE7dS93JntCDH07lCjSgiNMaigo0p7
         GrXvXcgv65+UarRPSEFu7kN5H2j0klMDkJTNcLsGN5iEh2Vtpdk3aujHYZmXheHFsrzb
         0td9JZ/4zrBvkSGlTB+/W4MzNkO9iS2y7PkPoIoNUSzI7uxlSGcB/bzpLgyiHDNtdc/J
         NxhgBprpAaDXhbH16oSqzLhcyqQ2cHsJTh9amDiRbGPxFZtkwWtPa6fXolrt9b66kzQD
         sDOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742516962; x=1743121762;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KoTBbWww7JEQC+F5jRMP+bnOpvYvD/+5OAlhy1ULkuk=;
        b=Ur/WR36PjZIxDd5J8UpFkqXtbmRUgdz5h0aK+ZRv/FW7wGFVtMbIxubZTxMaF2PtPY
         FJkgKxCzoVPfTpHc+mCWQdnW5P1gDQ2FPWLGb1QONjM4/LVaR1Ned0OFHZwe/l+/a9eX
         By3pyWJhg9MOYyxlXz9jLZx9Cxih8vBht/jPd2M5fPbpQDvRFCBZetQ5CGk85xqWUJtW
         h7yANEyEw8jjg8yx0XIemlYVtVNKCIVJeDhz4VnVuJyPx8bX2VC9IXhUBaB8EY5zsuNQ
         /MfWigroVGuSzVbeqOoFNqF3+/1Jo4xd2wp6q4SGgnLdw9Q2qXRAPRiBGQr/qhk/wKc3
         AjYQ==
X-Gm-Message-State: AOJu0YwejSgjTe9LzG+OxmaWQ13zV7u/MUkWLImCFrHOj+Y6LgJkf2gI
	098XO7gF4ebF5NR5yzMQhL/1+/HbV3SVnYiEToZq3Gt0DX3IYiU9prgQ9hzWyXQgTUWKSGXVNyB
	7/kNn/bPZ4R7lFRE5baEcIbw0nG0CtNphKv22947QPvcqlDJyl/6fQKpZ0e5hROQC0eulD8qO/0
	x1cw649ZRbvj41bE4EXqRsXHwK8kAUq5Vryf50dUKUU1RgGtBg/OdqmCjLrXg=
X-Google-Smtp-Source: AGHT+IF/RKffTkar3eNChq0M93Wm9yCSbeUCKsyAMrO6ynd5mACmphLhb4ZEULjZm1n+Oj8W1m67dSwK7GHZr2a5Lg==
X-Received: from pgbdo13.prod.google.com ([2002:a05:6a02:e8d:b0:af2:8474:f67e])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:2448:b0:1f5:8179:4f42 with SMTP id adf61e73a8af0-1fe42f090fdmr2537813637.6.1742516961712;
 Thu, 20 Mar 2025 17:29:21 -0700 (PDT)
Date: Fri, 21 Mar 2025 00:29:05 +0000
In-Reply-To: <20250321002910.1343422-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321002910.1343422-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
Message-ID: <20250321002910.1343422-2-hramamurthy@google.com>
Subject: [PATCH net-next 1/6] gve: remove xdp_xsk_done and xdp_xsk_wakeup statistics
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, pkaligineedi@google.com, willemb@google.com, 
	ziweixiao@google.com, joshwash@google.com, horms@kernel.org, 
	shailend@google.com, bcf@google.com, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Joshua Washington <joshwash@google.com>

These statistics pollute the hotpath and do not have any real-world use
or meaning.

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         | 2 --
 drivers/net/ethernet/google/gve/gve_ethtool.c | 8 +++-----
 drivers/net/ethernet/google/gve/gve_tx.c      | 8 ++------
 3 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 483c43bab3a9..2064e592dfdd 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -613,8 +613,6 @@ struct gve_tx_ring {
 	dma_addr_t complq_bus_dqo; /* dma address of the dqo.compl_ring */
 	struct u64_stats_sync statss; /* sync stats for 32bit archs */
 	struct xsk_buff_pool *xsk_pool;
-	u32 xdp_xsk_wakeup;
-	u32 xdp_xsk_done;
 	u64 xdp_xsk_sent;
 	u64 xdp_xmit;
 	u64 xdp_xmit_errors;
diff --git a/drivers/net/ethernet/google/gve/gve_ethtool.c b/drivers/net/ethernet/google/gve/gve_ethtool.c
index a572f1e05934..bc59b5b4235a 100644
--- a/drivers/net/ethernet/google/gve/gve_ethtool.c
+++ b/drivers/net/ethernet/google/gve/gve_ethtool.c
@@ -63,8 +63,8 @@ static const char gve_gstrings_rx_stats[][ETH_GSTRING_LEN] = {
 static const char gve_gstrings_tx_stats[][ETH_GSTRING_LEN] = {
 	"tx_posted_desc[%u]", "tx_completed_desc[%u]", "tx_consumed_desc[%u]", "tx_bytes[%u]",
 	"tx_wake[%u]", "tx_stop[%u]", "tx_event_counter[%u]",
-	"tx_dma_mapping_error[%u]", "tx_xsk_wakeup[%u]",
-	"tx_xsk_done[%u]", "tx_xsk_sent[%u]", "tx_xdp_xmit[%u]", "tx_xdp_xmit_errors[%u]"
+	"tx_dma_mapping_error[%u]",
+	"tx_xsk_sent[%u]", "tx_xdp_xmit[%u]", "tx_xdp_xmit_errors[%u]"
 };
 
 static const char gve_gstrings_adminq_stats[][ETH_GSTRING_LEN] = {
@@ -417,9 +417,7 @@ gve_get_ethtool_stats(struct net_device *netdev,
 					data[i++] = value;
 				}
 			}
-			/* XDP xsk counters */
-			data[i++] = tx->xdp_xsk_wakeup;
-			data[i++] = tx->xdp_xsk_done;
+			/* XDP counters */
 			do {
 				start = u64_stats_fetch_begin(&priv->tx[ring].statss);
 				data[i] = tx->xdp_xsk_sent;
diff --git a/drivers/net/ethernet/google/gve/gve_tx.c b/drivers/net/ethernet/google/gve/gve_tx.c
index 4350ebd9c2bd..c8c067e18059 100644
--- a/drivers/net/ethernet/google/gve/gve_tx.c
+++ b/drivers/net/ethernet/google/gve/gve_tx.c
@@ -959,14 +959,10 @@ static int gve_xsk_tx(struct gve_priv *priv, struct gve_tx_ring *tx,
 
 	spin_lock(&tx->xdp_lock);
 	while (sent < budget) {
-		if (!gve_can_tx(tx, GVE_TX_START_THRESH))
+		if (!gve_can_tx(tx, GVE_TX_START_THRESH) ||
+		    !xsk_tx_peek_desc(tx->xsk_pool, &desc))
 			goto out;
 
-		if (!xsk_tx_peek_desc(tx->xsk_pool, &desc)) {
-			tx->xdp_xsk_done = tx->xdp_xsk_wakeup;
-			goto out;
-		}
-
 		data = xsk_buff_raw_get_data(tx->xsk_pool, desc.addr);
 		nsegs = gve_tx_fill_xdp(priv, tx, data, desc.len, NULL, true);
 		tx->req += nsegs;
-- 
2.49.0.rc1.451.g8f38331e32-goog


