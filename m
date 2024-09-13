Return-Path: <netdev+bounces-128080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF63977E23
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 13:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154D31C23E01
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 11:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758BD1D6C63;
	Fri, 13 Sep 2024 11:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKQKSV1K"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108543716D;
	Fri, 13 Sep 2024 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726225418; cv=none; b=gBKSoG6m2wsuUuWjYPFpHgryuCubesynOUyM87n7eWtIlYsuUdiwkR68ZmfYeB/ZrUSvIOQlvJuoRzMbvsAS21cIf2h5yiCK3uYW68+cNWQviWb+SHaLVjeNdinjx6MO9Soz2mRRUGU3ZKHtCY6OEwFiRtLvtpMIjxIViYaZzIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726225418; c=relaxed/simple;
	bh=tGroz9xO+4pLwYkYzjpk5tj4Try4hVWwSk5qr61pvLM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UBLkZ9Xmcq0sMk9S5sRRtGbVhsPISIShLExKdLQCEkosJ/cpQ4Z6pEr4aarL1YXKe6kzqFtn4Tw0J+FyMYb1R4cKu7XB/Gfs0mGU4STTA40nE6e0k2m5bEaUoaoGIZKgh+fhnDrm6wiVJKIJyM+5h3MAYnv+tJdAl2lJl0Vefwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKQKSV1K; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718a3b8a2dcso625990b3a.2;
        Fri, 13 Sep 2024 04:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726225416; x=1726830216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kekk9n1SKeIq8mwQfBadmC6X0rQ17ZPly6vPtHna6So=;
        b=KKQKSV1KtqsNBto+NNz3oSl2+WYgaCIBqcYWL8XekE6Vg63ZqD4h4aO4hHr33wqFv8
         IQZM/Rm6vvdWISnYrpAwBqgydDhfYQLrobwO7r5fT32U8e/ZJdjL4MKpsEUBpb2JPh/x
         Kz+BblQOxUmtwxm9SwcDlRtUIZVrIzKuHgkSJF8haJhJiNJkM3p8Y/n5y8rQd2upOtUT
         Tld6hrEvmVHaW9wInjWciFphfUQVvJwEsIup0Exbs5Fo5vyWCb0LM0m7Oqn6D4hjPgIt
         OR4eehQxqJyLcA3FXZNko5GYHCUMgDrI8NwkvB27+RxrqtzwM8aKzrrZpoVJWot7MZz6
         AHPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726225416; x=1726830216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kekk9n1SKeIq8mwQfBadmC6X0rQ17ZPly6vPtHna6So=;
        b=wPzcyLjTM0TRwSc2XJDuykX+2yKZkjaS4uDvbHR8yteCDl6T0SeufZ0IiATYs+WJdC
         wc6vszFJ4g8fv04hIA6juCY0cA+E6E9nEIuFbw0eVn9AICQv+T1vVSeuSxV9P0gAH2Ee
         MleyLx4kJ04frqadJ0lk64TmSw69iY0/7gtyC+kKDlETCyvB2xYIYJV/nFsfG9P4QuEb
         C2dDiO7Ya/4qEiUPqyJzDmnLC53lg+27ti3dtB7mYckGfUcbxrNbjpXO9mUzGdLgntqF
         30NnZrK/OJ2lz6lC4TTd+pHyVhgHba3T/UqU/EWJRm3hJ14SH6prm2+0A227eN9nxFIo
         9kRA==
X-Forwarded-Encrypted: i=1; AJvYcCXV87BLd+L/en0lcnK3YW/IB8ddczvlTd+ZFxZwLtjCqqXR2jOI33U+Sb4i3ume1Fw96jsruddJ2DQMseE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz145OwxN/cMM25feOs5No8mTbQMJbYISpdivgILoxv5G8Jq2Vt
	xcP47PJufGg6epXZkX6+VZS+ElW91Ivaf9GG0i31mDigAzlS8dGu
X-Google-Smtp-Source: AGHT+IGwEoyrvESSqovr/1cjtEp4lX2jChUMznGaRwX1hjVp0qpnhQ9RUdRvLc6shj18XvoBOrPGEg==
X-Received: by 2002:a05:6a00:23c3:b0:718:ea3c:35c3 with SMTP id d2e1a72fcca58-71936a5e2d6mr3704608b3a.15.1726225415732;
        Fri, 13 Sep 2024 04:03:35 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71909092560sm5882778b3a.138.2024.09.13.04.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 04:03:35 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Ong Boon Leong <boon.leong.ong@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	rmk+kernel@armlinux.org.uk,
	linux@armlinux.org.uk,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net v1] net: stmmac: set PP_FLAG_DMA_SYNC_DEV only if XDP is enabled
Date: Fri, 13 Sep 2024 19:02:59 +0800
Message-Id: <20240913110259.1220314-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When XDP is not enabled, the page which holds the received buffer
will be recycled once the buffer is copied into SKB by
skb_copy_to_linear_data(), then the MAC core will never reuse this
page any longer. Set PP_FLAG_DMA_SYNC_DEV wastes CPU cycles.

This patch brings up to 9% noticeable performance improvement on
certain platforms.

Fixes: 5fabb01207a2 ("net: stmmac: Add initial XDP support")
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index f3a1b179aaea..95d3d1081727 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2022,7 +2022,7 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	rx_q->queue_index = queue;
 	rx_q->priv_data = priv;
 
-	pp_params.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+	pp_params.flags = PP_FLAG_DMA_MAP | (xdp_prog ? PP_FLAG_DMA_SYNC_DEV : 0);
 	pp_params.pool_size = dma_conf->dma_rx_size;
 	num_pages = DIV_ROUND_UP(dma_conf->dma_buf_sz, PAGE_SIZE);
 	pp_params.order = ilog2(num_pages);
-- 
2.34.1


