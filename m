Return-Path: <netdev+bounces-158365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC3BAA117CE
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 04:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85B563A5A3E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 03:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD8322F827;
	Wed, 15 Jan 2025 03:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jOugD/YN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3139B22F152;
	Wed, 15 Jan 2025 03:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736911669; cv=none; b=tPKGrfJAC/deesjvr306ugZFqRFvB09VjoUBaG8oETDOE8eP/ZBAj37rhVqCRmB3s5+MHRCadd595rfdIg3/JAHFTIMd0R2c6NLj8T/loPGRYLs4e6NRSAxdlqdm4B/4BkCbza66ZMnRoUleYWEYwWZVLMGXO40T/QPAdSM773Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736911669; c=relaxed/simple;
	bh=ELqzb7GOkkxhmiH++knkIhUE2YwbBBJ9bPiY6iO6wrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PCGjAhYnphbkbWz4TffCo/IL2Q+vPrhcZiuCV9XMZvoTop8yBpo7GWe8XTeIqM81w2mi7PZJsTSWZrNJLBBAu1VbABOVzIv81928p70AYeT+FMHNtUC42PvBvdECfq3b5wl3agrKyp2iQwm1HMDpfQa3ii6xH/aeb7Ll34H6LYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jOugD/YN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-21669fd5c7cso113757105ad.3;
        Tue, 14 Jan 2025 19:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736911667; x=1737516467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrnZOWuzbTsFJQSfUdSJAVwNu1OpPEJIPOluJRIjDnY=;
        b=jOugD/YNA4Gm8aXCfSyMZNMds8icosDlcijNlpHFbi/tKpdG9jYScups+2NRPertoG
         JZeay0eRQ0mbfYni4MwXLwCzJ2SEVVhkkUGFpuLmWqIINmsKMgb3myOsVgZE1ruOp9xY
         PgJTEwHiUe5H63nt1lB4RyrysjGdu72a9jgwnaQTygASei2fp8XPH46ySzAV40njOuK8
         jYh3F7ZHXBHZCwOkMouU1xAcxG6eK8tZCJD1MTqiSWd+yMBpDHc6VvlxmbC154OfCoeW
         q5MXBDtJndt9EDDSkeJr+003bXzLqxVEjZYNdWBBApMXJplDuMLo0mq15oVdPIz9rFz8
         r6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736911667; x=1737516467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrnZOWuzbTsFJQSfUdSJAVwNu1OpPEJIPOluJRIjDnY=;
        b=JwbtGsnkP1A78KLWCZD7TW1+USlBK6ZcE0tb9zYmGAzZlFXcGfgot58UOQpUvZFCVC
         Mrt4PNMJQsfpjce9quWL3BBtOnidd+FgAtmlffKixw9M6t4CJTvOvtoZSrgLkbhOOAMs
         FCsl4YX5wA1K5GZHKxdFcuFzSWrT7EadWcpCN/wYh3Yabth5w51e7GptW3MieOt9LuH7
         tM/MpGX4cPDl3Yt7e28jpX5jLnVu16J8y4W2OY74WlzaAVHGZ44AFjGxfBwA8Plsop+m
         XqS/02QsoUcqHiWxWv6ZQrh+EVSDZEVbmeimJxZCHsrA+tXHQcbWtnU3K3s8D0BhCd7g
         Y6jg==
X-Forwarded-Encrypted: i=1; AJvYcCXkzQ4WVxkqo7/TPnHF0EqBhUUeYJVmZSWNudVe1uoZ0tA7fzPPpYExiOg/YUZMGpjCO+v06ozlhM0gMgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTaRwl0nPkbjDZPySyfWm+udHbLlaeE2aaawKiaQdT5E7RM/rQ
	P+dr3lJZgz5lgCeBIp0aP3B/J6BHDsuDAY7Guy682zB38G0asDRcS4lXCA==
X-Gm-Gg: ASbGnctXAWfTLLO2XezSU9iba3gg6HKcDlwX3obSu6cJUAKZSQdrSo5WOGoVQOOrEzI
	YcOVIKeYNPmjqaesksvuVv3qUCQvqTVzkt5Kzr1ODcAiT8DYbjivHajskVpZNiOIxsPt11YaRgl
	iAsmGdsL4FEKt07JdqXnDg1bbetsUHBBJGZCq2GQ2aAN4uf5OltwforY0NrBdBrllZeBrM0rWJx
	JXtDEzdN43/KMjQ8u2YIj31fh0cKqNd4kpi2GREs4TY4Lacz4LehdAHflg5Ct5i1ySiZQ==
X-Google-Smtp-Source: AGHT+IEgvbbedPhMmlQrROuWhBJEvCl3rJhkcO1ll2KbOYDFwCkOh7dbSjQ3/MMG4kA76MxUXWGidA==
X-Received: by 2002:a05:6a00:39a7:b0:728:e382:5f14 with SMTP id d2e1a72fcca58-72d21f314e9mr32614582b3a.9.1736911665971;
        Tue, 14 Jan 2025 19:27:45 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-72d405493basm8166452b3a.27.2025.01.14.19.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 19:27:45 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Joe Damato <jdamato@fastly.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v3 4/4] net: stmmac: Convert prefetch() to net_prefetch() for received frames
Date: Wed, 15 Jan 2025 11:27:05 +0800
Message-Id: <909631f38edfac07244ea62d94dc76953d52035e.1736910454.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736910454.git.0x1207@gmail.com>
References: <cover.1736910454.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The size of DMA descriptors is 32 bytes at most.
net_prefetch() for received frames, and keep prefetch() for descriptors.

This patch brings ~4.8% driver performance improvement in a TCP RX
throughput test with iPerf tool on a single isolated Cortex-A65 CPU
core, 2.92 Gbits/sec increased to 3.06 Gbits/sec.

Suggested-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index ad928e8e21a9..49b41148d594 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -5529,7 +5529,8 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 
 			dma_sync_single_for_cpu(priv->device, buf->addr,
 						buf1_len, dma_dir);
-			prefetch(page_address(buf->page) + buf->page_offset);
+			net_prefetch(page_address(buf->page) +
+				     buf->page_offset);
 
 			xdp_init_buff(&ctx.xdp, buf_sz, &rx_q->xdp_rxq);
 			xdp_prepare_buff(&ctx.xdp, page_address(buf->page),
-- 
2.34.1


