Return-Path: <netdev+bounces-159609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D870A15FEF
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 03:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBA23A66B5
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:05:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BB0126C13;
	Sun, 19 Jan 2025 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XcfuuSs9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C084A2B
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737252324; cv=none; b=joJeOoGVgmHd/INs42k9CdRipq343GMcKuz5iXPrZSSgaFsfNjeejgY9IXsG5s90k1FWLPkvPAQo4Ts5oXXn1sOyplO2DCYfc2+LhIvWRvAqNzAzTGhAZJXFjQqWdeDm3ALrkNh9dOkOtcyyiMY/SOmPjnfIMpnMQOIGl40SdY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737252324; c=relaxed/simple;
	bh=liEb6FrciZS5IMCArR+0U4lSsdrh9MYWLJ5LVZqT+gg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLMcfg9kgOKfnonmqcW3gqJIvB7KoHDjG/CdX8H66++xw0lqO6xpfRMeDD8tdZHfeQ6yKqoXp9Kyxba9cNVWjtU8+LItxg1n3VEMk5AsGcNSW8OqiXNDJJB3jDJfHQ8WvFynKs6q6aQhIoOVSebXLDvj2/85TkM9YDTKiZYE27U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XcfuuSs9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8884FC4CED1;
	Sun, 19 Jan 2025 02:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737252323;
	bh=liEb6FrciZS5IMCArR+0U4lSsdrh9MYWLJ5LVZqT+gg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XcfuuSs9VS+7fn7nWbF33T7smYlr+3pLB+br6z8qJLtLNwAD4ib6fbOeG7pvkchCK
	 djHsDT0V7dBEypf4XhlR6IfWHRrkh7+ImoEyuKSk6rUKHzWEocWAEDMzyy5dzm1oar
	 mWxeltlXt/grHFJ1wfXLyYd265A+iHOYm8nBKsBlpeFkhqwYUZW91xBa9AgkXGI5vc
	 5YyaajPGxdBE21Mfr/DuWaE1LoN4P0rhWNVin78zDOGuzzG7hfb8x4QOn1k+7YPx3z
	 nGbpDClTeqIEAtgfaq/VfRJAB1ctYcdEjEuUbPyU3RhmSMDtfDYnO10VMM9Ag0wsbM
	 jmONumy82mjqQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	ap420073@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 6/7] eth: bnxt: allocate enough buffer space to meet HDS threshold
Date: Sat, 18 Jan 2025 18:05:16 -0800
Message-ID: <20250119020518.1962249-7-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250119020518.1962249-1-kuba@kernel.org>
References: <20250119020518.1962249-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that we can configure HDS threshold separately from the rx_copybreak
HDS threshold may be higher than rx_copybreak.

We need to make sure that we have enough space for the headers.

Fixes: 6b43673a25c3 ("bnxt_en: add support for hds-thresh ethtool command")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 2eeed4c11b64..19e723493c4e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4671,9 +4671,10 @@ void bnxt_set_ring_params(struct bnxt *bp)
 				  ALIGN(max(NET_SKB_PAD, XDP_PACKET_HEADROOM), 8) -
 				  SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 		} else {
-			rx_size = SKB_DATA_ALIGN(max(BNXT_DEFAULT_RX_COPYBREAK,
-						     bp->rx_copybreak) +
-						 NET_IP_ALIGN);
+			rx_size = max3(BNXT_DEFAULT_RX_COPYBREAK,
+				       bp->rx_copybreak,
+				       bp->dev->cfg_pending->hds_thresh);
+			rx_size = SKB_DATA_ALIGN(rx_size + NET_IP_ALIGN);
 			rx_space = rx_size + NET_SKB_PAD +
 				SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 		}
-- 
2.48.1


