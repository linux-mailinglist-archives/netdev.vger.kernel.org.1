Return-Path: <netdev+bounces-192188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1B0ABECEC
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 09:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9FF1895C8D
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 07:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C4923372E;
	Wed, 21 May 2025 07:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAnZTiv4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D37422D9E0;
	Wed, 21 May 2025 07:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747811822; cv=none; b=F5K1R0lpJra6yYxbNZNBQC5H+Fa/yDsu8cTw1JokXI5pIGEU3PVO1nLosqAOZJNlFI/almpXH58Espr/S2CY2zNCu51icrK0dgunKxnXpFV9AAzw+7yejJwbYGdM3+10rsrlvVgVfFf4ftW/TzFZrd3SKFzq6U4MSDotZfC90Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747811822; c=relaxed/simple;
	bh=v3IDqAlY8Az7L+Vv8S1TOU7ZJgmqIP9lDQvJud2e9V8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lL25wYvKkPsHfJbL/c6CzMWqdhPNfDtcRPCwY8hCmirs1wDipMmaLnIOYbu6ihuPot8zWf1lueDeLfEN9W18HlIC2ziySQKW2jpcalA6Sywge5KeDM4JOdvAk/5indcAJR2W0Nxnz0Kze3Cc8Ngv9QwvrBSsTEBYRIvjWL7Aog0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAnZTiv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F66C4CEE4;
	Wed, 21 May 2025 07:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747811821;
	bh=v3IDqAlY8Az7L+Vv8S1TOU7ZJgmqIP9lDQvJud2e9V8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DAnZTiv4wisfgfcLcXxlQuuqejtk+eIFHgyxjTtv1GO1v8D2G68zp51CxGsx/Qw12
	 bcVsO5P52y5dzB1Irx0RjlfpoN9zPAXFIKi7tefBVkRMdoPMk5vXFq6tgxkkj7ZMVH
	 8bWttSvsk3f5hIDmSFY5sxgc/LVv8hDPrHwMHFUW6wrvE3zwWuc/v9Ik7wBd8+AaCu
	 s5p+XywdIATVLfloXkBr3zQUvvXeyS5u3iFnkUT4JF7CUOgWiz9Du1U2flpvw1tH3n
	 qKdU5OBIJjdF7bdhX4KECjI1L2FTUbO4TRGn1cuC56msLKBY0nbdbdvDS5wRc1Pgrk
	 F3wPfMrilnbiQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 21 May 2025 09:16:37 +0200
Subject: [PATCH net-next v3 2/4] net: airoha: Do not store hfwd references
 in airoha_qdma struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250521-airopha-desc-sram-v3-2-a6e9b085b4f0@kernel.org>
References: <20250521-airopha-desc-sram-v3-0-a6e9b085b4f0@kernel.org>
In-Reply-To: <20250521-airopha-desc-sram-v3-0-a6e9b085b4f0@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

Since hfwd descriptor and buffer queues are allocated via
dmam_alloc_coherent() we do not need to store their references
in airoha_qdma struct. This patch does not introduce any logical changes,
just code clean-up.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 8 ++------
 drivers/net/ethernet/airoha/airoha_eth.h | 6 ------
 2 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 16c7896f931fd9532aa3b8cc78f41afc676aa117..5f7cbbcbb1d469836dfcea95137c960bfd076744 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1081,17 +1081,13 @@ static int airoha_qdma_init_hfwd_queues(struct airoha_qdma *qdma)
 	int size;
 
 	size = HW_DSCP_NUM * sizeof(struct airoha_qdma_fwd_desc);
-	qdma->hfwd.desc = dmam_alloc_coherent(eth->dev, size, &dma_addr,
-					      GFP_KERNEL);
-	if (!qdma->hfwd.desc)
+	if (!dmam_alloc_coherent(eth->dev, size, &dma_addr, GFP_KERNEL))
 		return -ENOMEM;
 
 	airoha_qdma_wr(qdma, REG_FWD_DSCP_BASE, dma_addr);
 
 	size = AIROHA_MAX_PACKET_SIZE * HW_DSCP_NUM;
-	qdma->hfwd.q = dmam_alloc_coherent(eth->dev, size, &dma_addr,
-					   GFP_KERNEL);
-	if (!qdma->hfwd.q)
+	if (!dmam_alloc_coherent(eth->dev, size, &dma_addr, GFP_KERNEL))
 		return -ENOMEM;
 
 	airoha_qdma_wr(qdma, REG_FWD_BUF_BASE, dma_addr);
diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index 531a3c49c1562a986111a1ce1c215c8751c16e09..3e03ae9a5d0d21c0d8d717f2a282ff06ef3b9fbf 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -513,12 +513,6 @@ struct airoha_qdma {
 
 	struct airoha_queue q_tx[AIROHA_NUM_TX_RING];
 	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
-
-	/* descriptor and packet buffers for qdma hw forward */
-	struct {
-		void *desc;
-		void *q;
-	} hfwd;
 };
 
 struct airoha_gdm_port {

-- 
2.49.0


