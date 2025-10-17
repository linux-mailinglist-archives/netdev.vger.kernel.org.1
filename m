Return-Path: <netdev+bounces-230387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 547DDBE76D5
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 11:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DFC1AA2776
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F273112BA;
	Fri, 17 Oct 2025 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FQRlR/t1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CAE42D6630;
	Fri, 17 Oct 2025 09:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691996; cv=none; b=H3xVBpvGgNfqQpihx0vHjsPu8ppsmOwxLY0f8Novk1nskMCMdcN/35o2fqKtrITWT2AAHlu/eNjJ3c5vJWplE24B/yKHji9NsW0MahqoXM2mJCNr2yuAg0nM7tm6WRbFIiIwuQKD5VJVkOuPNiGnCMrO0C9QStb1zMbLnIXeMzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691996; c=relaxed/simple;
	bh=NITHiO1A/cRdExkggxIIRs5P2A4dim+V/Z/R+2/59Zw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k2oL7FY2CxSYdgkR78XCvrdPRLuIyiSw/tvgUrcVCjdk6P/KLDgUumvDtlVQh8IdyBE40lCPkM5rBYG1Jsf4MSY7Yb6MY6C7+CDEsljj80spsS0FkTpkw+kB6K9P8ByxZ5Qx+I7NbAMA8JbbB1oNwchZ/dx2wEAPMx4PbjOF76M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FQRlR/t1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E640DC4CEF9;
	Fri, 17 Oct 2025 09:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760691996;
	bh=NITHiO1A/cRdExkggxIIRs5P2A4dim+V/Z/R+2/59Zw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=FQRlR/t1DYlWIGETDPrEEbEKgHOSo/HveKwQP+/yGIROiN7BOdFDqhH6OcSXl5VFn
	 9OG5yhoqecHo/zX5c+3tNMct2o2WBJyhxkmsZyRHl1Kr9JRHriFZV3nH3DixA2n7uC
	 mLQ7TKMKPcfp3tFsmzqXTN8IntEGF2WW/liitnqP8xluqmq1jDptWc2bBD5d7H1SPO
	 u5s5eaNWZbkSLcVP59w/x+cTJDS3QhZWDeSpu4u2VI3AyPt1p7d0x2t9B0ZIhHUE3F
	 gg4+mKmrTpRHtVs3GbGcGT4k+Lab8YnzjLQdyMVjZftj9isWjD7lBhiRU1IpPtBwTJ
	 s7i45dYiXPSkA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 17 Oct 2025 11:06:11 +0200
Subject: [PATCH net-next v3 02/13] net: airoha: ppe: Dynamically allocate
 foe_check_time array in airoha_ppe struct
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-an7583-eth-support-v3-2-f28319666667@kernel.org>
References: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
In-Reply-To: <20251017-an7583-eth-support-v3-0-f28319666667@kernel.org>
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


