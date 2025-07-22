Return-Path: <netdev+bounces-208756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13512B0CF4C
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 03:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6580C1897B0B
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 01:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A5F1D5ADC;
	Tue, 22 Jul 2025 01:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T74guxEo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A065E1CCB40
	for <netdev@vger.kernel.org>; Tue, 22 Jul 2025 01:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753148973; cv=none; b=QrE5YcLHUvw2pMlWjnuwB8qWDekT09lOMhncOwowhvwXWDQqzbuWj4zLghlcz55n/80ZRyKC/f5Z/zrvQTAktBnOgWSAwAuc3moxj9n26oECNbTnNDrGFnKQ7nnke+CxwVoHvlxsx4uF0X/9/kHZ30ZusuEXZGg6daC1S4kcWhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753148973; c=relaxed/simple;
	bh=GLhBndVuu/ON447hgfJ/Gm3e/7zo6AmcKT338lV1+TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fnpDWmsfkl5BclHcbGTGi1XlSRKKcRgefFUXiMy2rTBgmzNSE1YmaieyjP3JvFfP4bkWHHRpUM3F1imk+UAn686QI22qr7BSiKFinVDr0iibKi9bZqwOac99vVCHVIGJ+CbME2k1yc8v0ekkO8gXv0ITIVQqiVCr68seKpC0GQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T74guxEo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1151C4CEF5;
	Tue, 22 Jul 2025 01:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753148973;
	bh=GLhBndVuu/ON447hgfJ/Gm3e/7zo6AmcKT338lV1+TA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T74guxEo73oC3eWH10EGX+GvdLGBdnsABBjg/zO5S8D1dl89Mfa5sSuSwKLs3whYD
	 tEQMhnlaeMOq0LatqIwJpC/Edbc7BK+D61pwVia2exSPODrs+ZcZk8w0fuvO8ExECF
	 /5uTK0js7UTY6+YlYPtrI4oRLOHlIysUiXlulCuE0qrvjsIrNDtTgQj1C8IbEAG7LS
	 Ajz/F7pVN/Vxb5Y80bmYq2RZ6EfM7E8t8x6cvtuFPX5OuGtmhQ+E1Qt3Zg47XHUygN
	 OVKxRaekMytknnVKhjSgdDk7bLrHKlXQtKe3fL1CAgaz3Y6xhaYw8de2E/8sj1wNHQ
	 8dl9vOMQBlQUw==
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
	gal@nvidia.com,
	andrew@lunn.ch,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	alexanderduyck@fb.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next v2 2/4] eth: fbnic: support RSS on IPv6 Flow Label
Date: Mon, 21 Jul 2025 18:49:13 -0700
Message-ID: <20250722014915.3365370-3-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722014915.3365370-1-kuba@kernel.org>
References: <20250722014915.3365370-1-kuba@kernel.org>
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


