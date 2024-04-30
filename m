Return-Path: <netdev+bounces-92640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F9E08B82EE
	for <lists+netdev@lfdr.de>; Wed,  1 May 2024 01:15:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E00D1C21053
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 23:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FF61C2300;
	Tue, 30 Apr 2024 23:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gukbBwcC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BBC1BF6EC
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 23:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518883; cv=none; b=tmdnKOLzxiYvAyGLPyD4epOG7oxahHeg25WTJDTSN8VmvjgftL24aKUp02JSAD9E2JPwBtDHTx027pMoi8KHRyZQmiCX7Yz5USxRNhEwHvhFdQaFye+FAE0SZs4/gx9fct7HY9i1c64bexG2qXJ3VrfaOXnqlKTaVn94gmhMqDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518883; c=relaxed/simple;
	bh=eIqn1LVUwugkpeRlzua2n5lFrHJQor+qYee1aB04brY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PxiL9+8S0g2RbrYoKPgFCQTONMK30VjXCMWtCNj+67itnqHef+JJzVyCgF9fDVhzgjDREwmtGAJZGerJkVLPZNg4SbwNS1I4ak12yGCY/PHJpBMP8IbiXnrofiOJAEhviE4LimIpQ1LymWGpQS2iMzHqM5Mnt/GFfXTxI3uvX4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gukbBwcC; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shailend.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso11995862276.1
        for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 16:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714518880; x=1715123680; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sX4HEYwsHS+rl8A8xVeENYauPKI62gnoZdac5LeFbE4=;
        b=gukbBwcCLgT83dIFXmxWHIZbri6zHxCXPAQc4cAhg4ldUynGEP1dYKJVpn7YfAP43G
         vqjJsW82Pg+Lc3eHLfjxhWoGPOarqrQ+or+7SRhMOxVl/N5tgdF14lRVhjfxtThHCz5x
         Gkq/nD2VOLW8mMW9AuqlqXSazq6NtDHt+BBSciywun8iSy7Fb8jTqBBMpVRG9g9ZU9Au
         khH3lwhypeMHfEY24s+E18ahilf3S2/gGI4JVGRAbxrlObW1IlcAZZ7TMkoKgAE+qZh5
         oKQxiuw6gYoMXGqLSp/TXoCY/4H66Z7J+F+c5P8lmWWOTD8FA/cdi6L90CER2NzWeAfz
         GXzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714518880; x=1715123680;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sX4HEYwsHS+rl8A8xVeENYauPKI62gnoZdac5LeFbE4=;
        b=ro3DZW3HHLkOIV2oRjQVhRVAEMrtYgWEX4SK1GNW1eeW9Z0l1WrXKWSmueV95th2ue
         AIvx/UaGy2PeZS5U5sfXAFu8AU118wNWjyW/f+ckkiSFj14Lr5k6/z2ljnLNpmP/gBcG
         3WUYmNKcHWPVLU76uVp1wt1T0rqx7hptUlqR1z1xe8FSuOQQe3aItWwmgupPPV1U/goD
         mxMHN6Zu9TrRFOyQE8MQGOGjdG8C61oIy3QDiOI9K6+jIUaLXgdGSHy2DFtrT+irEKG9
         Mj83hd4oj4G4Bn7MhXrR7CuFsjHf0Df3O07wDMEMRvH6vlwVB8m3xrsVlhINf76dMR1J
         Zgow==
X-Gm-Message-State: AOJu0Yxp5wtJzCKmXyULQ9dYw+P/OsMXUnfjPrfxGwmyGuVPo9M/kU8K
	NzYECSY3xJmhYR7CJpR49EBrkMzK8HpKz6eezhl67v5lVi68VkWQ9FyptPznyf0K0phSKdQxG4W
	7V40Zzcw/uH53lew996tFFFS/57Kq5pw8v+ijHoNtfXw7YPFC0JLbL+DxMuJ5+rcb0i9oNZ8SGV
	DGDB5cxnIBZky+vUJlgTv1tetIz9t3u89TLx5a7um2Ons=
X-Google-Smtp-Source: AGHT+IEfK1bmtuf/QDdiXvokMD8m7h2kAS6gymB6WztzogP+Ik8EBqoM7xhXlx5hU1JPlZ3QseqX0l3IVIpRMA==
X-Received: from shailendkvm.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2648])
 (user=shailend job=sendgmr) by 2002:a05:6902:c09:b0:de5:2694:45ba with SMTP
 id fs9-20020a0569020c0900b00de5269445bamr340138ybb.0.1714518880413; Tue, 30
 Apr 2024 16:14:40 -0700 (PDT)
Date: Tue, 30 Apr 2024 23:14:13 +0000
In-Reply-To: <20240430231420.699177-1-shailend@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430231420.699177-1-shailend@google.com>
X-Mailer: git-send-email 2.45.0.rc0.197.gbae5840b3b-goog
Message-ID: <20240430231420.699177-5-shailend@google.com>
Subject: [PATCH net-next 04/10] gve: Make gve_turn(up|down) ignore stopped queues
From: Shailend Chand <shailend@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, davem@davemloft.net, edumazet@google.com, 
	hramamurthy@google.com, jeroendb@google.com, kuba@kernel.org, 
	pabeni@redhat.com, pkaligineedi@google.com, willemb@google.com, 
	Shailend Chand <shailend@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently the queues are either all live or all dead, toggling from one
state to the other via the ndo open and stop hooks. The future addition
of single-queue ndo hooks changes this, and thus gve_turnup and
gve_turndown should evolve to account for a state where some queues are
live and some aren't.

Tested-by: Mina Almasry <almasrymina@google.com>
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Shailend Chand <shailend@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 61039e3dd2bb..469a914c71d6 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1937,12 +1937,16 @@ static void gve_turndown(struct gve_priv *priv)
 		int ntfy_idx = gve_tx_idx_to_ntfy(priv, idx);
 		struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
+		if (!gve_tx_was_added_to_block(priv, idx))
+			continue;
 		napi_disable(&block->napi);
 	}
 	for (idx = 0; idx < priv->rx_cfg.num_queues; idx++) {
 		int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
 		struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
+		if (!gve_rx_was_added_to_block(priv, idx))
+			continue;
 		napi_disable(&block->napi);
 	}
 
@@ -1965,6 +1969,9 @@ static void gve_turnup(struct gve_priv *priv)
 		int ntfy_idx = gve_tx_idx_to_ntfy(priv, idx);
 		struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
+		if (!gve_tx_was_added_to_block(priv, idx))
+			continue;
+
 		napi_enable(&block->napi);
 		if (gve_is_gqi(priv)) {
 			iowrite32be(0, gve_irq_doorbell(priv, block));
@@ -1977,6 +1984,9 @@ static void gve_turnup(struct gve_priv *priv)
 		int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
 		struct gve_notify_block *block = &priv->ntfy_blocks[ntfy_idx];
 
+		if (!gve_rx_was_added_to_block(priv, idx))
+			continue;
+
 		napi_enable(&block->napi);
 		if (gve_is_gqi(priv)) {
 			iowrite32be(0, gve_irq_doorbell(priv, block));
-- 
2.45.0.rc0.197.gbae5840b3b-goog


