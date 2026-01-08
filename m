Return-Path: <netdev+bounces-248123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2614D03EBF
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 16:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B0EC33FB77A
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 15:17:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D299D3451D6;
	Thu,  8 Jan 2026 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDEZETrQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8452327BF6;
	Thu,  8 Jan 2026 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767884741; cv=none; b=skxY24NuVgLr0A2pkWnxtAogDeDeenolGBvdgcJCKDFtLePpMbqA5KHnU7AL6oQF0ns7l9yfGL3b9j4qRB0fJw2gUzG9K9kkDAiwe3pKJCg71PQuFB328uD1VstR26n50W2uozlIsEUsn8P4BZv4Rhr/w+wOCbvFrbe9Q6+ILWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767884741; c=relaxed/simple;
	bh=JhbaVv1PdLdceMg/5l3s3xkAwxQ3DqsArTD5uFDz5Zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DuZHC7Fj+RB3QtJef8sD+UScl7w9jjKz42j/PWt6yCQMyewZHjO+GxrpBD0sCpypiXityzDIdoBWK+pxGa0NdvgPEF/229N8ksY7WUfG5MZ52xmjetUg/z95J66EI2I1it3LVmShlTpT+Aje7buLapLFhh51jOMmKptKyohB9Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDEZETrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3FBC16AAE;
	Thu,  8 Jan 2026 15:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767884741;
	bh=JhbaVv1PdLdceMg/5l3s3xkAwxQ3DqsArTD5uFDz5Zw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gDEZETrQ+Z9UPMytldJRovzTnLSjacFXt+Q+B+cfeE+T5YAwNxLbuBmm5nknDN4MH
	 Rw3oTLL05HaAM2aBlgpZoz9qcS9HLs0A75NgCBSx+0qUpvbJUwQTIbpBXSSBDPsEMU
	 tQ0eB3FB1ZVHuO3qjursuCtgYn3GGM3rcmd+JmG9xlEeElXrxRSUiiRM53XeTHhULz
	 cEMd00ikEDxwN0+znh3T3oFeK3heIx+wK8kHlGP0goiSbzSC7Fi0VVz0WpTZCEWWng
	 didFwhkUaSJ/RiyaKH3KXjQ9FktKJmNlSDStvejhEelIwyOblIeGa1YnR8Sh28AmlL
	 K36vWk2VSQkBg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 08 Jan 2026 16:05:08 +0100
Subject: [PATCH net-next v3 2/2] net: airoha: npu: Init BA memory region if
 provided via DTS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260108-airoha-ba-memory-region-v3-2-bf1814e5dcc4@kernel.org>
References: <20260108-airoha-ba-memory-region-v3-0-bf1814e5dcc4@kernel.org>
In-Reply-To: <20260108-airoha-ba-memory-region-v3-0-bf1814e5dcc4@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Initialize NPU Block Ack memory region if reserved via DTS.
Block Ack memory region is used by NPU MT7996 (Eagle) offloading.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 22f72c146065998d5450477f664ed308b1569aa3..a56b3780bb627cc393b94210b6b5c72cc95baea3 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -519,6 +519,14 @@ static int airoha_npu_wlan_init_memory(struct airoha_npu *npu)
 	if (err)
 		return err;
 
+	if (of_property_match_string(npu->dev->of_node, "memory-region-names",
+				     "ba") >= 0) {
+		cmd = WLAN_FUNC_SET_WAIT_DRAM_BA_NODE_ADDR;
+		err = airoha_npu_wlan_set_reserved_memory(npu, 0, "ba", cmd);
+		if (err)
+			return err;
+	}
+
 	cmd = WLAN_FUNC_SET_WAIT_IS_FORCE_TO_CPU;
 	return airoha_npu_wlan_msg_send(npu, 0, cmd, &val, sizeof(val),
 					GFP_KERNEL);

-- 
2.52.0


