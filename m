Return-Path: <netdev+bounces-247633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 878D3CFCA15
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 09:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 376F030F0F85
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 08:30:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D9928642D;
	Wed,  7 Jan 2026 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPH41ztZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B882528506B;
	Wed,  7 Jan 2026 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767774597; cv=none; b=gw2hoGD0l09iJT/uzas3xHlOSO7dWKIMn4q/lQWaHS6cKnkyHp4nphFbcnr6eJjXBzxofKh/0o1DYJX7iUGq8XQaee0EwTybgSzvzKVhaYBLWcq8EfPhcq+NYCwFZQamalATPUfyzFe8gOlbXnPr/FHRPk5g+D28CKFF5Uf/y8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767774597; c=relaxed/simple;
	bh=JhbaVv1PdLdceMg/5l3s3xkAwxQ3DqsArTD5uFDz5Zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j4/xTPczb9bPmqzdRjz7Az25u2uEhJEGh+ruzvgQ3/8hAYs+I4eZtisKjHrmLlJA+qdgpdHttV+X1ryTkME6XwEZqNx/3M8/QlGUDEiXYt+YY9HGO7QqkQItHgLPjCJbl7TIYZV2+9Hg4PS9+W6IMNKz08B9TzycruvqnCiFoME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPH41ztZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07FEDC4CEF7;
	Wed,  7 Jan 2026 08:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767774597;
	bh=JhbaVv1PdLdceMg/5l3s3xkAwxQ3DqsArTD5uFDz5Zw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hPH41ztZ6KrETrjSif7OcedDsaM0tXMLZA+B/HITPU9EZYBHX11DUnApCg7dapckJ
	 8Qqgz5YrUmh1KwiB0cX55QDGH8uPjIJkmio3oBYyFZ8m7Kgfyl3Zo01WDpwtiFVwqB
	 g1cNOfFBDdKO9MvU4Hsp2F6duQlz8aKJOt2VgTgj3NCV/7Ax0MgmlrgNBZVidwbnOr
	 SoTS6/Xu1Pkravnms2qxmOm1/L8uhmmkv8dv1Vmojj4KaJVgpvEohlXNOHR+zPU6e/
	 WPqCgmxl3Zcpx5EUTTfeIlrQIfSiATIqHl4GJ0gJtjntnB2yFQ2N50Kl10yAeUaLMf
	 7vOmO54pyqQBQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 07 Jan 2026 09:29:35 +0100
Subject: [PATCH net-next v2 2/2] net: airoha: npu: Init BA memory region if
 provided via DTS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-airoha-ba-memory-region-v2-2-d8195fc66731@kernel.org>
References: <20260107-airoha-ba-memory-region-v2-0-d8195fc66731@kernel.org>
In-Reply-To: <20260107-airoha-ba-memory-region-v2-0-d8195fc66731@kernel.org>
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


