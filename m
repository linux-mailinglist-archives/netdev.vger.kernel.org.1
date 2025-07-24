Return-Path: <netdev+bounces-209579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43713B0FE77
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 03:51:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E3627B82E3
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 01:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C4E192D8A;
	Thu, 24 Jul 2025 01:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f665C2Cs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8450D1922D3
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 01:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753321882; cv=none; b=gpuwjIWuTQI8F3b0ZgPhj71rY5Wa/doqQ6+sKydajkM1dUUbl64TnH5ENaxGSKN07tG5RHcV6fW/vn8IGh0htNIvMOaZPo049qfuPEKx5Om0c8VMWdp1gBAXzQ0CwIrN2IJOxHPddosWQ03pJP5wGy5bS+vDOywdFwPz2THP3RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753321882; c=relaxed/simple;
	bh=GLhBndVuu/ON447hgfJ/Gm3e/7zo6AmcKT338lV1+TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DLIvXgJDIuo4ba65nia+WJNZXo/I4gW3GzSXAmAXO2vX9MRXkoWHFG5fQhqMi8O4F4ZBLQShu1TNG4Rl70YkGphR5oEoQ6WOQXBIk7Ecq1ORQpPE6nJLQH4x7DCU5VwTLeBZ1rd0LBrZEgG/um0BUf20tPxqIJSXKTsHt3L5HzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f665C2Cs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00446C4CEF6;
	Thu, 24 Jul 2025 01:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753321882;
	bh=GLhBndVuu/ON447hgfJ/Gm3e/7zo6AmcKT338lV1+TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f665C2CsnCikYxj242xAzMCv+8+aDEHkxXGKynr+pzqZO4tLugXb2Rm9HkEOa0M4A
	 y7coTCb66WsQdouvkSm4l9pxtsSy5rdC+DlipvcxL/DtoiOr0/+mWmL4uVR9CElPIY
	 04AXU06iDnIL0c0C8EQo8ubSZUNclkpfHSv7F1h4jwiiBey4s3aJQA88EhBm300JiX
	 XROPTevYlOZeo6qSP9dBmOQz4KtAqs8tr8erwD4HMCrmMgO3Qnu9O61qtaV5+ETIjx
	 zBkT7aZZ8JjHLePuZkL9RKVaycA55QKz5Oev17Os2Kfa68laj0w0qNXWUTGHEgCi1q
	 r/5k3mTGQXaEg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	andrew@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	alexanderduyck@fb.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next v3 2/4] eth: fbnic: support RSS on IPv6 Flow Label
Date: Wed, 23 Jul 2025 18:50:59 -0700
Message-ID: <20250724015101.186608-3-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250724015101.186608-1-kuba@kernel.org>
References: <20250724015101.186608-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Support IPv6 Flow Label hashing. Use both inner and outer IPv6
header's Flow Label if both headers are detected. Flow Label
is unlike normal header fields, by enabling it user accepts
the unstable hash and possible reordering. Because of that
I think it's reasonable to hash over all Flow Labels we can
find, even tho we don't hash over all L3 addresses.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: alexanderduyck@fb.com
CC: mohsin.bashr@gmail.com
---
 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 2 +-
 drivers/net/ethernet/meta/fbnic/fbnic_rpc.c     | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 588da02d6e22..fe3a203dee75 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -1310,7 +1310,7 @@ fbnic_get_rss_hash_opts(struct net_device *netdev,
 #define FBNIC_L2_HASH_OPTIONS \
 	(RXH_L2DA | RXH_DISCARD)
 #define FBNIC_L3_HASH_OPTIONS \
-	(FBNIC_L2_HASH_OPTIONS | RXH_IP_SRC | RXH_IP_DST)
+	(FBNIC_L2_HASH_OPTIONS | RXH_IP_SRC | RXH_IP_DST | RXH_IP6_FL)
 #define FBNIC_L4_HASH_OPTIONS \
 	(FBNIC_L3_HASH_OPTIONS | RXH_L4_B_0_1 | RXH_L4_B_2_3)
 
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
index 8ff07b5562e3..a4dc1024c0c2 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_rpc.c
@@ -71,6 +71,8 @@ u16 fbnic_flow_hash_2_rss_en_mask(struct fbnic_net *fbn, int flow_type)
 	rss_en_mask |= FBNIC_FH_2_RSSEM_BIT(IP_DST, IP_DST, flow_hash);
 	rss_en_mask |= FBNIC_FH_2_RSSEM_BIT(L4_B_0_1, L4_SRC, flow_hash);
 	rss_en_mask |= FBNIC_FH_2_RSSEM_BIT(L4_B_2_3, L4_DST, flow_hash);
+	rss_en_mask |= FBNIC_FH_2_RSSEM_BIT(IP6_FL, OV6_FL_LBL, flow_hash);
+	rss_en_mask |= FBNIC_FH_2_RSSEM_BIT(IP6_FL, IV6_FL_LBL, flow_hash);
 
 	return rss_en_mask;
 }
-- 
2.50.1


