Return-Path: <netdev+bounces-279878-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oI4bM4dy5mlgwgEAu9opvQ
	(envelope-from <netdev+bounces-279878-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:37:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C37C432F4C
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 20:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E89131A982D
	for <lists+netdev@lfdr.de>; Mon, 20 Apr 2026 17:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A33339EF24;
	Mon, 20 Apr 2026 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g9yY9vVr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3D439D6D0
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 17:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705524; cv=none; b=e1mRmYRZQVEHhv0cb+jYdZe+ikXrAQ5R13DrVuv8Za6TMyz5dEwHK7a+LymJi+Ltu7LS4ykaquCBu43MvLCaRHThNsCiOXA/s2GxYY/9PeviZjplBl+NQivHkoL35I2j+YwY2aPpdltQh8ISdleB5WaJ6OccWh7xR94Po/31RaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705524; c=relaxed/simple;
	bh=u0UVsOozKt4Tg7IC9nw6qxk0e3pyOwuHpeuJX0VNCQM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JgMo2ELMj81mMdnTsgKGXkrtqboZM7ZgiLkD4s6Cl8Wl96gaQRn9p/AhD6XqBdCSaLrtWeQkqbiIqMrTBbtQxG3cFN8MJt+UncziMDsi6yIuE8MSjDwwFbGWz6D1i2NvOXlokpQwmAbDPeeiNKxW0oy/Ftd86vUVMBNIr07McPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g9yY9vVr; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-358e95e81aeso7012266a91.0
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 10:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776705522; x=1777310322; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+0Cj3kzc2z6biU160rJ3owwxifAK2ueeF94SXw4tnzM=;
        b=g9yY9vVrV0M1Wqmco3v5QErLyz7rFhkGkkhHRjh92Wv+qrmwK11DeEDZEhS2lYcTQo
         FQeS/EtL1F76QEGPYRhwQ1oXq/O5s85WBK+8fbeZyaV+5NOCF0nzY8vOsR0ModEvdKEW
         9ePHghw/11Skrr+Dvn65b2cA5d9fEdnA2m6eZxant40htr9N8P7Urh2TJ2QjHvYeMKs0
         H+jQIV1BvuGokCRLsz+dRBQfR6ZWbm3rVJqxub3LmbggsLn7UIDvJo8Tw1ah4ztRWv+I
         wxnPxUNyG8lApBUOR9zheV+ROP5ASwtM4/xByuyYAZgCy5ljB2XYBJznWa3+Pr1Fla6c
         KLWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776705522; x=1777310322;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0Cj3kzc2z6biU160rJ3owwxifAK2ueeF94SXw4tnzM=;
        b=XMdV9T16+M+dO77N4HfWR9FQ6vMfE8CJGSTNsZV+VzOkEPP/a1pmWDs0ia5sZOcw6D
         Jrn4KixwjtFbKZ1DdIAQfSvuHaVEe1PZhVgRq1oGd8dmovZ50pAmszTPej8bkVCezHBh
         vVQ0YQsilJO3gUzsBRYwXFShrOAUxnvS1nW+gp30EqVZ8NdHhQ7iTj29zPvkT9TXMlLR
         dEIIYKL8JwagYMRR2LHvB9o2frMQAuhg+XOAeh3+Yl1cj22CWWgqrkGzF6Ejl/QPZIXq
         DZwCXiBv4FLcZvBx8N4K30Xp6YmszEgcC0FxcVEQpBQ4M/BPwmqcUi16HUj40zDrmcX+
         rU3w==
X-Gm-Message-State: AOJu0YzTenEghn1OKJMrcCMXxHTjvv8AFPhNKYLcacouXS3Vhfmb3xTw
	+arxVD1v+eHVcDXQQzLElJwGherFmyYm555w+PbgKVvl7BLhYHHOz57hvJihTFImGQOYBgoHCry
	FNjMB3JfGzTCRTdYC5DO2Gqlv8x3x1RSNj8btNkEKfEpr5tZ4ERMoYdt6NdKRyaK36FAz1ZT8xH
	nThKN4WHh5arzvcFR+CUk7nnh4TuSy0vfME9YHMPsT/vYidqdof3tE3WWxM89tXj0=
X-Received: from pjtl11.prod.google.com ([2002:a17:90a:c58b:b0:35d:a8d7:ccda])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4e85:b0:35f:b5df:450 with SMTP id 98e67ed59e1d1-3614048a226mr15714612a91.19.1776705522232;
 Mon, 20 Apr 2026 10:18:42 -0700 (PDT)
Date: Mon, 20 Apr 2026 17:18:34 +0000
In-Reply-To: <20260420171837.455487-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260420171837.455487-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.54.0.rc1.555.g9c883467ad-goog
Message-ID: <20260420171837.455487-2-hramamurthy@google.com>
Subject: [PATCH net 1/4] gve: Add NULL pointer checks for per-queue statistics
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	willemb@google.com, maolson@google.com, nktgrg@google.com, jfraker@google.com, 
	ziweixiao@google.com, jacob.e.keller@intel.com, pkaligineedi@google.com, 
	shailend@google.com, jordanrhee@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Debarghya Kundu <debarghyak@google.com>, 
	Pin-yen Lin <treapking@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279878-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hramamurthy@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3C37C432F4C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Debarghya Kundu <debarghyak@google.com>

gve_get_[tx/rx]_queue_stats references the [tx/rx] null rings when the
link is down. Add NULL pointer checks to guard this.

This was discovered by drivers/net/stats.py selftest.

Cc: stable@vger.kernel.org
Fixes: 2e5e0932dff5 ("gve: add support for basic queue stats")
Signed-off-by: Debarghya Kundu <debarghyak@google.com>
Signed-off-by: Pin-yen Lin <treapking@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 0ee864b0afe0..675382e9756c 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -2705,9 +2705,13 @@ static void gve_get_rx_queue_stats(struct net_device *dev, int idx,
 				   struct netdev_queue_stats_rx *rx_stats)
 {
 	struct gve_priv *priv = netdev_priv(dev);
-	struct gve_rx_ring *rx = &priv->rx[idx];
+	struct gve_rx_ring *rx;
 	unsigned int start;
 
+	if (!priv->rx)
+		return;
+	rx = &priv->rx[idx];
+
 	do {
 		start = u64_stats_fetch_begin(&rx->statss);
 		rx_stats->packets = rx->rpackets;
@@ -2721,9 +2725,13 @@ static void gve_get_tx_queue_stats(struct net_device *dev, int idx,
 				   struct netdev_queue_stats_tx *tx_stats)
 {
 	struct gve_priv *priv = netdev_priv(dev);
-	struct gve_tx_ring *tx = &priv->tx[idx];
+	struct gve_tx_ring *tx;
 	unsigned int start;
 
+	if (!priv->tx)
+		return;
+	tx = &priv->tx[idx];
+
 	do {
 		start = u64_stats_fetch_begin(&tx->statss);
 		tx_stats->packets = tx->pkt_done;
-- 
2.54.0.rc0.605.g598a273b03-goog


