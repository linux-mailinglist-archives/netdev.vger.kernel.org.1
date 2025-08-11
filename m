Return-Path: <netdev+bounces-212660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BE3B2197D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C072464063
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECE823D2B8;
	Mon, 11 Aug 2025 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VoMUomZb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A5623B627
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754955766; cv=none; b=kQGa4T3zSH6dREyaG1wiNHb3tqi4r/9hop40ukMPWmG2ROBigXx5vLlEtxs/J0s82OipWc6klInTKRms2NKWyO/dgjGA5gv5kRbe3+ihG2zOjpp+1lhCQbhbnBoOaUYibfe/44c3caT0+9QTQn/tonWsQbSlru2+vMl1WT3sT00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754955766; c=relaxed/simple;
	bh=AVuJzPA8pFuYwNuHd2NlZAqocac2HB1GGMGejKdbavk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAHtI6G9s0wqz98w4+QitHXPelh+cnv9fuEpVY65tspcmPxunJn2KWojd0LgYDpaVxUAbYSR0mmsMn6+vFFmm40w4jdSo2NgD0zLTGTjZfpJPoYhiObEbJv5KD70ODz5PzV+uvX75gD6waytEvRd5wpcjiDilHxt9lKemzny5wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VoMUomZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7002BC4CEF7;
	Mon, 11 Aug 2025 23:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754955765;
	bh=AVuJzPA8pFuYwNuHd2NlZAqocac2HB1GGMGejKdbavk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VoMUomZbUNV/1fVDJtNBLRrEFdsqfB8VaoXC4dQD1LD4xQlxo+BvnDPB8jeNt93Rg
	 +za+Q+7Eo1T+jOJmCufTcVjdO16IqIJy+5t8jQCLd0efmZ7CnPvjyzVTenXAWy/TdJ
	 PIR2ZfokVJypF1HD0yS/moDf4ZEE3xSveLzezzH9OtpdPl3egP4pWr+JebQhc4tjir
	 tYvP0AkG3/sNsKL5EFtKyfSlzLiYCtcqnpL2x593y0Mv4BX0P18spO7MH2U1SJue6p
	 Saz+4JLMe4hEQBxRJWo1p4JwAsOZAxokMQ7Rnd69+AIALN5POPcagQp+tfOi0xkp8b
	 VJ3PGwkFVXp6w==
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
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	alexanderduyck@fb.com,
	mohsin.bashr@gmail.com
Subject: [PATCH net-next v4 2/4] eth: fbnic: support RSS on IPv6 Flow Label
Date: Mon, 11 Aug 2025 16:42:10 -0700
Message-ID: <20250811234212.580748-3-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811234212.580748-1-kuba@kernel.org>
References: <20250811234212.580748-1-kuba@kernel.org>
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
index dc7ba8d5fc43..461c8661eb93 100644
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


