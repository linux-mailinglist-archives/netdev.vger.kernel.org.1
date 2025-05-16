Return-Path: <netdev+bounces-190954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC5AAB970A
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:00:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27D41A020BC
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 08:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBD222C32D;
	Fri, 16 May 2025 08:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aaN/JQIl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF49E22B8BF
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 08:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747382441; cv=none; b=K+MUZ7rdwFXLyJHyHa8ei0AV0fwvGJL0Ru11nZTlGB6J70Vbz3osTT2NUlP8c1l+7C/LUMICjCjY+LJ1NoWZoQgNmVC4lVU/0uOPNww2aByJWqLs8H7G06CCz9I6gR2DvhE2/9jkUATNr+lxEX+fVcfBq+zRN/UoecNW2mUjJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747382441; c=relaxed/simple;
	bh=9MI7SAT2s//V30kRWI98bF2/4dui8LFg708YvOASUg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dToYM2e8lFJgsOGOq05vjwg/Lm69WKmSUMI3JKSNbcY+hzOwCHT54IUE1v/WxfegAaCd8sIIz+JDCIBjpEj+lvaGi+kNqD6O/dzOmiMiOEWgfIzjwfAZzCoRsGk1+wziY/3v9MmOfQVTjBdg0qE/Tj1ng3WDoIHyHZiQaVysrrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aaN/JQIl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A111C4CEE4;
	Fri, 16 May 2025 08:00:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747382440;
	bh=9MI7SAT2s//V30kRWI98bF2/4dui8LFg708YvOASUg8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aaN/JQIl3NYET13p1kb9UjadklcbTuU88wEh36k0a1NcJqEiXcr1EZrVYOjBBmPtA
	 Ytbp6UhjqTGbYRW2xPrW3q6pwwqSsjQVJ/66x++lwz9xE1l8IU+mTAWkE456CCHqd2
	 Ys5K6YGrA8sVXbJmOK7k2ruMhKcUX+4R5RwMi+jXKYnVn02DWg66qHJvsEsy3NQdOS
	 cRddLmyGt5Orbrxe8kfn+Iiv+gpzr1bjtn/rlXwRiJw79DINxvpblg07zraM3SJVK3
	 pssC0DrxyFwYrIFkwfrhSYH4aD3Du/zQDqhFkT4dtp9clWqNWfIge2psNkZ3MRIceZ
	 c84l1ioOKCCeA==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Fri, 16 May 2025 10:00:01 +0200
Subject: [PATCH net-next v2 3/3] net: airoha: ppe: Disable packet keepalive
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250516-airoha-en7581-flowstats-v2-3-06d5fbf28984@kernel.org>
References: <20250516-airoha-en7581-flowstats-v2-0-06d5fbf28984@kernel.org>
In-Reply-To: <20250516-airoha-en7581-flowstats-v2-0-06d5fbf28984@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Since netfilter flowtable entries are now refreshed by flow-stats
polling, we can disable hw packet keepalive used to periodically send
packets belonging to offloaded flows to the kernel in order to refresh
flowtable entries.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_ppe.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/airoha/airoha_ppe.c b/drivers/net/ethernet/airoha/airoha_ppe.c
index 70598ba9f5ad1d30c1e408d3d97c6fa4cb0f4f4d..2d273937f19cf304ab4b821241fdc3ea93604f0e 100644
--- a/drivers/net/ethernet/airoha/airoha_ppe.c
+++ b/drivers/net/ethernet/airoha/airoha_ppe.c
@@ -84,6 +84,7 @@ static void airoha_ppe_hw_init(struct airoha_ppe *ppe)
 
 		airoha_fe_rmw(eth, REG_PPE_TB_CFG(i),
 			      PPE_TB_CFG_SEARCH_MISS_MASK |
+			      PPE_TB_CFG_KEEPALIVE_MASK |
 			      PPE_TB_ENTRY_SIZE_MASK,
 			      FIELD_PREP(PPE_TB_CFG_SEARCH_MISS_MASK, 3) |
 			      FIELD_PREP(PPE_TB_ENTRY_SIZE_MASK, 0));

-- 
2.49.0


