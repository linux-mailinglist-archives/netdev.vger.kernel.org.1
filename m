Return-Path: <netdev+bounces-112588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4524693A158
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765051C22210
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85811514DA;
	Tue, 23 Jul 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2sXSS8a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848A414D6EE
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741391; cv=none; b=aNgcJ+W4SoeOw+Bg+NKi+H5VsKqlgYgbn5qdtOVwioLgmiBcapN1MstjpEnRh70b2lrstqIDd7rndfP6HE501CItxky7V7ygY3mkT5kEDvmKrDvLMGDOsOG4GQM5G5E4zz3WEOkc2ZNAVfVvHn1lDf/i4qrMfFmHmGVVnT7ru5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741391; c=relaxed/simple;
	bh=v7xTTTAZwomN72O0knYlTFevwV55+zMTLZdFClVkxzk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=PlJ9inyHJq6cZhJs/zid3eaD+5iOI7gQhhwfGZlZkIFh5xMJ010QGRLPR6qZ7EeO2jj4/3uPKV8wt7AqUK144NcTlwIdRWvvmqkZ/zaR0L3gLxeOtbXNoESA9UzEaMb/zsoXv6BbFh0f45JA1FFHNt7kBnvwOi4XGjlN1Ug3cHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2sXSS8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B172C4AF09;
	Tue, 23 Jul 2024 13:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721741391;
	bh=v7xTTTAZwomN72O0knYlTFevwV55+zMTLZdFClVkxzk=;
	h=From:Date:Subject:To:Cc:From;
	b=U2sXSS8aIkoARycDNPnjpYu6yU15o71yppWgDlbHTIFkOBF21l4R4rtVwAmb/Plqt
	 0okWVho+qS774hX26XPrlUBkA36cuAc31b6oZ5l4im1yck/SdKhf5gEAnlaeHFYWUV
	 nDQtJFwE9oFQA90LM9rcbI9NorS6LYUJXHGeKpjgxRoSZL1JfNM/0VpjCdOvAVYMqE
	 F2fAWtYrmvlzCl1lZvHLoWf+0aVFOXkmWT7OIZYk+z+FpO7g01MQdyuiKRDMh9c1Rs
	 TTtC90oedft70AsZBomd+kH+nqFmn7fpsJ3QNoOH3xUkO/9Wgw2k0nRCSHSh7ax2ai
	 /X13CtDSlvsuA==
From: Simon Horman <horms@kernel.org>
Date: Tue, 23 Jul 2024 14:29:27 +0100
Subject: [PATCH net] net: stmmac: Correct byte order of perfect_match
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240723-stmmac-perfect-match-v1-1-678a800343b2@kernel.org>
X-B4-Tracking: v=1; b=H4sIADawn2YC/x3MQQqDMBBG4avIrB3QGCn0KqWLYfyjs0gqSSiCe
 HeDy2/x3kkF2VDo3Z2U8bdiv9Qw9h3pJmkF29JMbnB+eLmJS41RlHfkAK0cperG8+RHL2GGiqe
 W7hnBjmf7oYRK3+u6ASygMaxrAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.14.0

The perfect_match parameter of the update_vlan_hash operation is __le16,
and is correctly converted from host byte-order in the lone caller,
stmmac_vlan_update().

However, the implementations of this caller, dwxgmac2_update_vlan_hash()
and dwxgmac2_update_vlan_hash(), both treat this parameter as host byte
order, using the following pattern:

	u32 value = ...
	...
	writel(value | perfect_match, ...);

This is not correct because both:
1) value is host byte order; and
2) writel expects a host byte order value as it's first argument

I believe that this will break on big endian systems. And I expect it
has gone unnoticed by only being exercised on little endian systems.

The approach taken by this patch is to update the callback, and it's
caller to simply use a host byte order value.

Flagged by Sparse.
Compile tested only.

Fixes: c7ab0b8088d7 ("net: stmmac: Fallback to VLAN Perfect filtering if HASH is not available")
Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c   | 2 +-
 drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c | 2 +-
 drivers/net/ethernet/stmicro/stmmac/hwif.h          | 2 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c   | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index dbd9f93b2460..f98741d2607e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -977,7 +977,7 @@ static void dwmac4_set_mac_loopback(void __iomem *ioaddr, bool enable)
 }
 
 static void dwmac4_update_vlan_hash(struct mac_device_info *hw, u32 hash,
-				    __le16 perfect_match, bool is_double)
+				    u16 perfect_match, bool is_double)
 {
 	void __iomem *ioaddr = hw->pcsr;
 	u32 value;
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 6a987cf598e4..f196cd99d510 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -615,7 +615,7 @@ static int dwxgmac2_rss_configure(struct mac_device_info *hw,
 }
 
 static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
-				      __le16 perfect_match, bool is_double)
+				      u16 perfect_match, bool is_double)
 {
 	void __iomem *ioaddr = hw->pcsr;
 
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 97934ccba5b1..e53c32362774 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -393,7 +393,7 @@ struct stmmac_ops {
 			     struct stmmac_rss *cfg, u32 num_rxq);
 	/* VLAN */
 	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash,
-				 __le16 perfect_match, bool is_double);
+				 u16 perfect_match, bool is_double);
 	void (*enable_vlan)(struct mac_device_info *hw, u32 type);
 	void (*rx_hw_vlan)(struct mac_device_info *hw, struct dma_desc *rx_desc,
 			   struct sk_buff *skb);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 4b6a359e5a94..12689774d755 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6641,7 +6641,7 @@ static u32 stmmac_vid_crc32_le(__le16 vid_le)
 static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 {
 	u32 crc, hash = 0;
-	__le16 pmatch = 0;
+	u16 pmatch = 0;
 	int count = 0;
 	u16 vid = 0;
 
@@ -6656,7 +6656,7 @@ static int stmmac_vlan_update(struct stmmac_priv *priv, bool is_double)
 		if (count > 2) /* VID = 0 always passes filter */
 			return -EOPNOTSUPP;
 
-		pmatch = cpu_to_le16(vid);
+		pmatch = vid;
 		hash = 0;
 	}
 


