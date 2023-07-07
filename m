Return-Path: <netdev+bounces-16109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D09EA74B687
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CECC1C2105E
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 18:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA23F1773B;
	Fri,  7 Jul 2023 18:39:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDB917737
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD2CAC433CA;
	Fri,  7 Jul 2023 18:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688755188;
	bh=SwrfaqmlgyimknjnFhBznwhIH7sKLYoZRHbAnHiddUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXF61LL9jpC9i7zQ38ccRho7hc+wOp/Ey15mJgWS/ZMDmTpmZGo3BaK3yGsWONnTU
	 pTZH7Y/J9eZ6A5YNd+v5DLUxZAE3d496RNMLqfMPfjjD2XntspMFWkeXErAX91Seip
	 2c3+JkbDzfYfrgP59KL5zUMMP/PFizSInrDAt7+iHWzBvX512FkSVmQAG/4/WavEjU
	 LMnzoSRgSjFPHH1AeeB41HOdQoEG9GwFAWDxa6m/uYWsU4IAZHHjGBbwVBOqFWkveg
	 W4n7xmbvsAZibLENTA+yOp1oUkH+3+bGh5Z1ffCTIW5k8HMvcLw2SBXlKNlizRmhHy
	 LxHEh/dRcVr5A==
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	edumazet@google.com,
	dsahern@gmail.com,
	michael.chan@broadcom.com,
	willemb@google.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC 10/12] eth: bnxt: make sure we make for recycle skbs before freeing them
Date: Fri,  7 Jul 2023 11:39:33 -0700
Message-ID: <20230707183935.997267-11-kuba@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230707183935.997267-1-kuba@kernel.org>
References: <20230707183935.997267-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just in case the skbs we allocated have any PP pages attached
or head is PP backed - make sure we mark the for recycle before
dropping.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 734c2c6cad69..679a28c038a2 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1132,6 +1132,7 @@ static struct sk_buff *bnxt_rx_agg_pages_skb(struct bnxt *bp,
 	total_frag_len = __bnxt_rx_agg_pages(bp, cpr, shinfo, idx,
 					     agg_bufs, tpa, NULL);
 	if (!total_frag_len) {
+		skb_mark_for_recycle(skb);
 		dev_kfree_skb(skb);
 		return NULL;
 	}
@@ -1535,6 +1536,7 @@ static struct sk_buff *bnxt_gro_func_5730x(struct bnxt_tpa_info *tpa_info,
 		th = tcp_hdr(skb);
 		th->check = ~tcp_v6_check(len, &iph->saddr, &iph->daddr, 0);
 	} else {
+		skb_mark_for_recycle(skb);
 		dev_kfree_skb_any(skb);
 		return NULL;
 	}
@@ -1715,6 +1717,7 @@ static inline struct sk_buff *bnxt_tpa_end(struct bnxt *bp,
 		if (eth_type_vlan(vlan_proto)) {
 			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
 		} else {
+			skb_mark_for_recycle(skb);
 			dev_kfree_skb(skb);
 			return NULL;
 		}
@@ -1987,6 +1990,7 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		if (eth_type_vlan(vlan_proto)) {
 			__vlan_hwaccel_put_tag(skb, vlan_proto, vtag);
 		} else {
+			skb_mark_for_recycle(skb);
 			dev_kfree_skb(skb);
 			goto next_rx;
 		}
-- 
2.41.0


