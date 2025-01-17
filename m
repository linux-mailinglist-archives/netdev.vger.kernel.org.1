Return-Path: <netdev+bounces-159452-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3AD2A15859
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 20:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CBB3169900
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 19:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E901B042D;
	Fri, 17 Jan 2025 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKre49ng"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1441B0409
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 19:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737143302; cv=none; b=HyVUOUmb6i4hk0QkFrlVjQUbbD87G+hMGBYqadXCo6a0syVkoyKMNNAiG+Zcry4JYWWP+Cf0n8GLrQ2bDnE8lJvPRcvIfnCeipa4amtTjbhusfptGv+MFIDQ9uWe+Qxo9HDSR4fdUKMEsfK060bmNZdUZwSyQo7fWomB+3CtZbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737143302; c=relaxed/simple;
	bh=W7g5mzKYbLZMyqo4vpbvxQf4UQRTdOwmKnBZtmNVrTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OcvwDUfrtzMny7MCtoKGMxlqNC6tulJWP1oDUhgDT34uIfpY53Gmqv1W9SBa5je0OBuzXWOiXa6/GlMKfTH+aVqcD42qG+4m2PQT2kxPxJDo60MhsVNB6bZ4tg4742due74ZTz4h+ZTM8zbjz4ltdvjNxkpoqhmywP3B+SKl5UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKre49ng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C38C4CEE2;
	Fri, 17 Jan 2025 19:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737143302;
	bh=W7g5mzKYbLZMyqo4vpbvxQf4UQRTdOwmKnBZtmNVrTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UKre49nglAPfog17YI6wqLfbHl+s4LMxTlWEESUz/dOlgw8lWMrgpr2y1Ki128GXQ
	 zr2o4WjBv/lH6dRohB7tu7/ZT/UcNMnWF1imlha04al7k0TFpgRFNG7oYdUNM6fIAn
	 cPNti9NXjigptrMpRLHesnvUMYje/uVjdZgMB36qI0Q/Pe+mvc7Jm9xRt9Vs1+StgR
	 HA91uvtkNUY94eGWhaWEjHCxp3ZgrMA0cHAUff5c9mMS97GgQ9LPUqPyxGgtcUeFuZ
	 zt+hTqMaLZo0fLbBdpsGLkFz3rCHPwqIF16ZLabX+fI880Dm6RADw3a6jzkNlLuUql
	 6b/wyBnz+K87A==
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
Subject: [PATCH net-next 6/6] eth: bnxt: update header sizing defaults
Date: Fri, 17 Jan 2025 11:48:15 -0800
Message-ID: <20250117194815.1514410-7-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250117194815.1514410-1-kuba@kernel.org>
References: <20250117194815.1514410-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

300-400B RPC requests are fairly common. With the current default
of 256B HDS threshold bnxt ends up splitting those, lowering PCIe
bandwidth efficiency and increasing the number of memory allocation.

Increase the HDS threshold to fit 4 buffers in a 4k page.
This works out to 640B as the threshold on a typical kernel confing.
This change increases the performance for a microbenchmark which
receives 400B RPCs and sends empty responses by 4.5%.
Admittedly this is just a single benchmark, but 256B works out to
just 6 (so 2 more) packets per head page, because shinfo size
dominates the headers.

Now that we use page pool for the header pages I was also tempted
to default rx_copybreak to 0, but in synthetic testing the copybreak
size doesn't seem to make much difference.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 19e723493c4e..589a1008601c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4609,8 +4609,13 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
 
 static void bnxt_init_ring_params(struct bnxt *bp)
 {
+	unsigned int rx_size;
+
 	bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
-	bp->dev->cfg->hds_thresh = BNXT_DEFAULT_RX_COPYBREAK;
+	/* Try to fit 4 chunks into a 4k page */
+	rx_size = SZ_1K -
+		NET_SKB_PAD - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	bp->dev->cfg->hds_thresh = max(BNXT_DEFAULT_RX_COPYBREAK, rx_size);
 }
 
 /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
-- 
2.48.1


