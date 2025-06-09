Return-Path: <netdev+bounces-195807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00A83AD2509
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 19:35:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C211B3AE436
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 17:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E1421CA0A;
	Mon,  9 Jun 2025 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiIIW5f5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4909621C9F4
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 17:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749490496; cv=none; b=rZBjmre6GHl1lLeV+h6ZLVcaBDKKhAq8hXSpqSPbDxVrEmkFOGQ72dOMICsuuRMWuU1ZI4y7C8XRJxCXPgtsaJsSCbf01ZsfPz5k7qHTCgcoUZtg0PAsG1GaHlPPraYnisiMfDnuP6akcsNxCiFAT6+fNCK1kTIXqOv4/eyiaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749490496; c=relaxed/simple;
	bh=Ig2a4Rqw00Ev0rBaZXCNs6ox4VZYSR3Hd6qvbjyWkT0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R5R156M+dNllm9NH3YyBLeXNGW8nqEd8LcT5l1Z4V0M1sD8adE0Zuvcv8eZQgGFtv1fvNsMTAgb1yUwOG9MFBuOThGp2TxkTewHhWlb7keihFiifFucMeAj6UvLWsk0OVJvjWVavb0yxX3ntRk8z6ua8LqrCkcr+e63X1JuktMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiIIW5f5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E50C4CEEF;
	Mon,  9 Jun 2025 17:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749490496;
	bh=Ig2a4Rqw00Ev0rBaZXCNs6ox4VZYSR3Hd6qvbjyWkT0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qiIIW5f57v2NXgIToVdgQ8IScyRbmTxGz0jeMDmal83Jpn7Gx/u0hECnsPU+tNJvM
	 NWWyLUXm7Q9hSTvUfM7+lEpanl6n3aKkorP3YXh7WG0S7XugGTTk/etlgUuE6/vo2y
	 LjXS8m810jk5Vs3pUZ76xhAFKjy9NJ/MnnAtcpEaizUP545PXZV8yXvq7lnF1xUPzV
	 vLn4wYre6W26mHVbnYUQncklVFzmjbAm9Ore9f09qmJTZQapbAtOQM1HK8TP0be2k+
	 6qqUkH03WbnFUUSBjV9fnvboG58r7SGijWBpW8mk4r4Ruei8n4wgq/Iy6V7k+8LqPr
	 9lPPCunBlAjFQ==
From: Jakub Kicinski <kuba@kernel.org>
To: michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com
Cc: willemdebruijn.kernel@gmail.com,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	alexanderduyck@fb.com,
	mohsin.bashr@gmail.com
Subject: [RFC net-next 3/6] eth: fbnic: support RSS on IPv6 Flow Label
Date: Mon,  9 Jun 2025 10:34:39 -0700
Message-ID: <20250609173442.1745856-4-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250609173442.1745856-1-kuba@kernel.org>
References: <20250609173442.1745856-1-kuba@kernel.org>
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
index 5c7556c8c4c5..24f5dc3baa70 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -806,7 +806,7 @@ static int fbnic_get_rxnfc(struct net_device *netdev,
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
2.49.0


