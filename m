Return-Path: <netdev+bounces-229975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F604BE2D54
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 12:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2F4E485BFB
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 10:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04AF2DF6FF;
	Thu, 16 Oct 2025 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvuCcK+t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ECD328607;
	Thu, 16 Oct 2025 10:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760610523; cv=none; b=ECk+eJjxUulfDJFa+o+9nq/Ij/7o3oZvc/btssTWK3TdchjsuAjnRgw9GCGYwiOyxuEMcvDLLGWUcrH04gHOIC/WeLsxEqIw1k2qB+hrEqjaunyzz3ZeMFNfSdDE1bzsLmZqeg+7Qy2ScIWdkU21MDbdFjzK9LG6BNAB0RVopL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760610523; c=relaxed/simple;
	bh=NITHiO1A/cRdExkggxIIRs5P2A4dim+V/Z/R+2/59Zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ohsy0e7tKT7ALOVwO7BBgmnZQUgslnJ8lDoJhhTX+fL5Qkj1MipAdV1o8EbFHNg/88C5zZxAMba5oTJFDwQtvfJ+RR9RyBObY7OpCvqYP3hrJUQD1pNwXomYXOxGFGTIXEBmXb/91omgzxYGY5BTAQdnRWB/XjQJiJ4J88Wgevs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvuCcK+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D65EC4CEF9;
	Thu, 16 Oct 2025 10:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760610523;
	bh=NITHiO1A/cRdExkggxIIRs5P2A4dim+V/Z/R+2/59Zw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EvuCcK+thh+q6J697mqQ3qV8NAWGloUvDIoH2VYDjy2Dj0fk992/pKEnB6NCma3/P
	 6ou3zWisUYZIUNUchob7MRBQnbCc8RG488q9zRJJxEJYjO4bQbeUDp7DZ5JumnItYt
	 dLN7KinqqWUI0ZFsS5icgW/NVHyf5xY+TdNoFD5D/hz5t01UH+AY5UK+u1NS66AchQ
	 3jqfZZkvDv0MeAl8ZOaElQ3IWw6PC0Opl+wSl/oafrLMATlBDe+SoUmMKgYTFrYWT5
	 AczAD+B77ttJdwLV/n3QWQoU68fqoPcNxCrPpf+GVNWRCoIybzG6zu3tkOqGVyeE66
	 HUphycyRazyCg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Thu, 16 Oct 2025 12:28:16 +0200
Subject: [PATCH net-next v2 02/13] net: airoha: ppe: Dynamically allocate
 foe_check_time array in airoha_ppe struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-an7583-eth-support-v2-2-ea6e7e9acbdb@kernel.org>
References: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
In-Reply-To: <20251016-an7583-eth-support-v2-0-ea6e7e9acbdb@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.2

This is a preliminary patch to properly enable PPE support for AN7583
SoC.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.h | 2 +-
 drivers/net/ethernet/airoha/airoha_ppe.c | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
index cd13c1c1224f64b63d455b24ce722c33c2fa7125..4330b672d99e1e190efa5ad75d13fb35e77d070e 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.h
+++ b/drivers/net/ethernet/airoha/airoha_eth.h
@@ -554,7 +554,7 @@ struct airoha_ppe {
 	struct rhashtable l2_flows;
 
 	struct hlist_head *foe_flow;
-	u16 foe_check_time[PPE_NUM_ENTRIES];
+	u16 *foe_check_time;
 
 	struct airoha_foe_stats *foe_stats;
 	dma_addr_t foe_stats_dma;
diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 691361b254075555549ee80a4ed358c52e8e00b2..8d1dceadce0becb2b1ce656d64ab77bd3c2f914a 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -1440,6 +1440,11 @@ int airoha_ppe_init(struct airoha_eth *eth)
 			return -ENOMEM;
 	}
 
+	ppe->foe_check_time = devm_kzalloc(eth->dev, PPE_NUM_ENTRIES,
+					   GFP_KERNEL);
+	if (!ppe->foe_check_time)
+		return -ENOMEM;
+
 	err = rhashtable_init(&eth->flow_table, &airoha_flow_table_params);
 	if (err)
 		return err;

-- 
2.51.0


