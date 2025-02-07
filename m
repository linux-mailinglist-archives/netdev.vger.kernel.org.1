Return-Path: <netdev+bounces-163875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4618EA2BE8F
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2593AB24A
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 08:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B9A1CDFD4;
	Fri,  7 Feb 2025 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgZogeDW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 826EF1C6FFC;
	Fri,  7 Feb 2025 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738918624; cv=none; b=GMFSAqjdVa0LB0qOfexG4iS6XOdQ1kq7032Tw9K32Ind0H9ScRZxfTFstibw1v12QKtbMplO05jjjRFDQAxym08le2Z3/TbkzN9rsAin6XsJkIMhBeOKowL/MmZdOBt3nShYDThdliS4JD8AgeC062PAQJjUA1hi8jjtCgjVMy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738918624; c=relaxed/simple;
	bh=ppiWtOfT2Ve7e1nS6/HMa2Ajq3jvgAbZc0pgN5Um54k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jeo+kMWZ2vkKFjqX7MzbiOfkw0Sw6jbANDOAaOrQqXCaRl/85ncLuIAHcludBt96UEl/8jTsxDAjA93+Yb+epxUEBNXgMb9jf3f9winxKIYlnF9TgcB3AkiQuGmSzMWOaKBTeP8k+R1DXIkXyCOYa+c9Cyl0o4Rtmusm/xexkyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgZogeDW; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-219f8263ae0so35981785ad.0;
        Fri, 07 Feb 2025 00:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738918621; x=1739523421; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Vx3ELvMf0qmQJJFnyKbMyptnWywqfF72JyrwcCPkjc=;
        b=BgZogeDW2hCNZKD9eIhj73SBApNm6iYintwSB9Fij0+oL9AlfghgYlEPgjVRNcKZRW
         rr9GBv9Hf0f7DhG7Faw6LcUiDWeE9MrtfxVuUz7FE/GY0Uih0yI050Ecb3nGOg2IInmT
         mcpSd09ORA47aTHoY7xK5x+ZVWLy+HVg9ZhFrgGQMMPpW7z996ceMobnv1fujfB7etEc
         QHUkSpx/X1le+iFxXHwkN4i/hHz+Bb0xXmSmn39afl4XkzoB6zGOuI/uoq/sgeT+b3pD
         /ZaMnQwPeRqoGbqMXOpySXz9wWBDSFaYQ2Q8lvpU4k6VIMq/bghlJW+RWdxFqwCNpJ6l
         x7gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738918621; x=1739523421;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Vx3ELvMf0qmQJJFnyKbMyptnWywqfF72JyrwcCPkjc=;
        b=Wsv3J6LIblhV8qDbhhtnTZimhzrvsVh+sFlYPVKJbfSLNRpTG+9BIi+meoBixrJdqK
         6P4bqBE0tTgRkidd/lh+EEaQIsg2dHF4fvHgiV+ll+gsxg49NpomMsqkv0K7jfT4Bjz7
         H6Awasdf006P4HYe6mI4lGta+fo+efQchYCqJcitoOQaNsz/jLAb7PRPrpQupxTSILaJ
         9woHnxVFhb0uJv4R945Ho2AdR7lStYW2wy/rEJhhHTTDSPspRxImTlSDvJHX5d1PhZNq
         +IvTXFKBhVC2E92wsIBolNpATo4a+2WgXrTNABEinGb0Hg2yW86AB42zT1krcQmRcqkh
         McBA==
X-Forwarded-Encrypted: i=1; AJvYcCXBi9OELDOtchy/40m9uy2HsKm/DGikmstsKxBlVIIKrm3cJGah8sd4cUzfubJeaS29l7mw4hczHs4ZahE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHyPRlTJQH3GcVSy5ueL2P5npduqluIpqIEcsAFDC/NwOQNANN
	WYcbtd+n7kEOe7cKzYaBBwI5j/I2923cS2CaaK1UA0yqYNlTGlxl5oM9Fg==
X-Gm-Gg: ASbGncuBCTaE7SX/mQJjTGdi4bQKDKbOtFMe0npiMi+9Uis0zqMOEOd5V7mvFq7hx7C
	OPPcpYQ9NMoieCExDWJm4mAIXELF46ld/umtfEzXf1RzL5otZY5gA41c4m6tIcIZ1CjRzgkbAQf
	wRVP378L62E0Kpv8U/cd0jIDOt1JXysz4Bt/XOyWyQyscVo2aWqwESl0MckRbcVoWsZi1Pj0zvn
	5h2rs/XC1Irrgwkd6P2jcIJDRsp5f6h/OEaisrbvVVpq5Xr7GGceDSNmHApJu9BJFpSQF/5UHXf
	MJ52wlCDo9doWZ5t8WgeAhWHcAbf
X-Google-Smtp-Source: AGHT+IFlNjPnbw667WtlBgeKpirAAyliI8fxFRqc6Br/oWFk5pHJMGbuj7/4JbGsPe3J/2mcAIkPMA==
X-Received: by 2002:a17:903:19cc:b0:21f:35fd:1b6a with SMTP id d9443c01a7336-21f4e76cb06mr47882695ad.51.1738918621258;
        Fri, 07 Feb 2025 00:57:01 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2fa2716c1ecsm945042a91.25.2025.02.07.00.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 00:57:00 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Brad Griffis <bgriffis@nvidia.com>,
	Ido Schimmel <idosch@idosch.org>
Subject: [PATCH net v1] net: stmmac: Apply new page pool parameters when SPH is enabled
Date: Fri,  7 Feb 2025 16:56:39 +0800
Message-Id: <20250207085639.13580-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit df542f669307 ("net: stmmac: Switch to zero-copy in
non-XDP RX path") makes DMA write received frame into buffer at offset
of NET_SKB_PAD and sets page pool parameters to sync from offset of
NET_SKB_PAD. But when Header Payload Split is enabled, the header is
written at offset of NET_SKB_PAD, while the payload is written at
offset of zero. Uncorrect offset parameter for the payload breaks dma
coherence [1] since both CPU and DMA touch the page buffer from offset
of zero which is not handled by the page pool sync parameter.

And in case the DMA cannot split the received frame, for example,
a large L2 frame, pp_params.max_len should grow to match the tail
of entire frame.

[1] https://lore.kernel.org/netdev/d465f277-bac7-439f-be1d-9a47dfe2d951@nvidia.com/

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Reported-by: Brad Griffis <bgriffis@nvidia.com>
Suggested-by: Ido Schimmel <idosch@idosch.org>
Fixes: df542f669307 ("net: stmmac: Switch to zero-copy in non-XDP RX path")
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index b34ebb916b89..c0ae7db96f46 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -2094,6 +2094,11 @@ static int __alloc_dma_rx_desc_resources(struct stmmac_priv *priv,
 	pp_params.offset = stmmac_rx_offset(priv);
 	pp_params.max_len = dma_conf->dma_buf_sz;
 
+	if (priv->sph) {
+		pp_params.offset = 0;
+		pp_params.max_len += stmmac_rx_offset(priv);
+	}
+
 	rx_q->page_pool = page_pool_create(&pp_params);
 	if (IS_ERR(rx_q->page_pool)) {
 		ret = PTR_ERR(rx_q->page_pool);
-- 
2.34.1


