Return-Path: <netdev+bounces-169652-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2541A4518B
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 01:36:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5AB47A2DFB
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 00:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 012401487D5;
	Wed, 26 Feb 2025 00:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UwEPWxhi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CFF13BAE4
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 00:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740530184; cv=none; b=uyMioSxvTt0SEforTUHkV/32gPFB8a1vbVyzwUHTK4kD9A9zT0gX2ho3QZARPoQbcKM32p8NJDzzSFZ7s+lGwI0FdKC/3tm+4Vit86Gkj0ai0PhWrIi7qZqt7zg9yhituQH1RohgLESaha6XVTCKRIcpg0K7yXGZ8GmpJz4w73g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740530184; c=relaxed/simple;
	bh=bN8gfJuIIhF73j3nDVVpaoOYFmyR/2OtbGeHfy6t+bs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=UHwjdhBwX8uaxmQEIKYQMVOovCgIWhhuiMXmMUbDSTg4cvVk7tihpVndTet3zzbTozC3hZZDsLd0TbCLYbSFyf1RKpFIUWsC09G9X+vdLD/ZLvE/tyf8czuIjJhRebcW4NEYMTMWgmEtSL4J857x27Tx1b+WWo9FGyFhZ+hKhCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UwEPWxhi; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2fc261eca15so606202a91.1
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 16:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740530183; x=1741134983; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nXsj9VmJS338dGGKNMmEL0zNWuSXmfxwvYQboUIxXE8=;
        b=UwEPWxhiiNnorZC9wJ/Of682IgfnOwCy7G9Xc4NiQ0ygyn4I7nfWJzOO7BYCz9KKv+
         ogReU2zk+SXhOAbNYORDfMjpdaj1oPKwQsf+hNRb9L1UcFbOeL6/KjmmsrzjSUtBv2Vc
         BgjaA5sUYuDqAV+vlNInsQk0TvcvnJujn4aKvAPnKq3kQjXJHS9SXDFBfDw7RaswcGVk
         CDicoCCJt9ShYFFpArbL2B0iDgaQcebIjbEDKs4dSONGw9NmyN+9X41PnSr/hWQnAFoI
         ds0kC+9Me5JFJatAEDLfs+hYaprzs++kiOBLZUYfMizBmAUFCZT6Pf4k0JQzPGOxdvo6
         aBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740530183; x=1741134983;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nXsj9VmJS338dGGKNMmEL0zNWuSXmfxwvYQboUIxXE8=;
        b=s43QEls+A0ZysVQzbU3RD7+wtsAK0wKhKBEuUX2ioS+NSpAvC8ohrWcVJbTrLtBWPn
         9rJVpNFsnlmVu/Waqfr4tmRjAdYLxgrEO8FxoAvCrD86/qD/94RPOm47tDQzxZ5yT1l6
         H+OzcZ3snriMWO7xOmt1qUygv7ks8X4+iZSwdUG9E8g2c+ro0MXKDKAnuzlLn4FDRt4m
         GZFdqlZmbuPBJY15vaYBjlEFnkFzYDbeCE9UbUsMj51rWoRyVava53uojEI0zFVL+TbE
         f8xgbDWoSjXiubl919leod/oM89fBFMMuRMzdkUW++CXxTH291iLOxP+J5s12q6WEEy5
         xiDw==
X-Gm-Message-State: AOJu0YxmiS69T0F08x/nNSxpzlGzaS3ukQ6fNeB64Fk+1a6L8NtmqUGL
	ihq74G2u5yJn/qBOI+7wjt52xiCkp4i8QOorjZbk8SE3wKP633HOnsEejVBNc4ad06hW1Knoxnc
	yJVMYwF+GGUIpvsuJBojlSByvQGfr59U/0wTnOEIGE+AFvC+6ObrWxiRFL6zJUcBV9RBgmjyrI+
	FtkeFKa8t/8ArG0ZwKfaEtJq+8/I7fFvmS8QD3jb3w/tflwvn2SSYxnHkKdI8=
X-Google-Smtp-Source: AGHT+IFAJA9kXjbtodM50cg9NdVfJgqMXkKHhhOKxSVMlYERHkjtSUyApwsAYc+sWvgX0xUTBoLiM0dw3MhKeHxGbw==
X-Received: from pjz15.prod.google.com ([2002:a17:90b:56cf:b0:2fb:fac8:f45b])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1b50:b0:2e2:c2b0:d03e with SMTP id 98e67ed59e1d1-2fce7ae8f31mr29815385a91.5.1740530182660;
 Tue, 25 Feb 2025 16:36:22 -0800 (PST)
Date: Wed, 26 Feb 2025 00:35:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.658.g4767266eb4-goog
Message-ID: <20250226003526.1546854-1-hramamurthy@google.com>
Subject: [PATCH net] gve: unlink old napi when stopping a queue using queue API
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: jeroendb@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	pkaligineedi@google.com, shailend@google.com, willemb@google.com, 
	jacob.e.keller@intel.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When a queue is stopped using the ndo queue API, before
destroying its page pool, the associated NAPI instance
needs to be unlinked to avoid warnings.

Handle this by calling page_pool_disable_direct_recycling()
when stopping a queue.

Cc: stable@vger.kernel.org
Fixes: ebdfae0d377b ("gve: adopt page pool for DQ RDA mode")
Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve_rx_dqo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 8ac0047f1ada..f0674a443567 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -109,10 +109,12 @@ static void gve_rx_reset_ring_dqo(struct gve_priv *priv, int idx)
 void gve_rx_stop_ring_dqo(struct gve_priv *priv, int idx)
 {
 	int ntfy_idx = gve_rx_idx_to_ntfy(priv, idx);
+	struct gve_rx_ring *rx = &priv->rx[idx];
 
 	if (!gve_rx_was_added_to_block(priv, idx))
 		return;
 
+	page_pool_disable_direct_recycling(rx->dqo.page_pool);
 	gve_remove_napi(priv, ntfy_idx);
 	gve_rx_remove_from_block(priv, idx);
 	gve_rx_reset_ring_dqo(priv, idx);
-- 
2.48.1.658.g4767266eb4-goog


