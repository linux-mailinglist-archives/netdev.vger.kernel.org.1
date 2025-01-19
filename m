Return-Path: <netdev+bounces-159610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DFBFAA15FF0
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 03:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFD9D3A6CB8
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40D0139D19;
	Sun, 19 Jan 2025 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Em6YVMe7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9088F2BB13
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737252324; cv=none; b=D0SErxQc8Ht4cRQ5Xx9abN/4QCOOfVlc5Bp2jJJL4jj5visyTwQny+B+Jv5EGyPyH0HWe5+BMvgo6pwaZYMkq26NDfVhDi0sYU/ZaWWEEE9/r+sRgjzAo88L6pzjVKXDw8bEp/HjkbwAjVhLIlWIRzn5tZIUL0v6aSXjXaIsx/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737252324; c=relaxed/simple;
	bh=W7g5mzKYbLZMyqo4vpbvxQf4UQRTdOwmKnBZtmNVrTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLryeuTPyleQx2zhpdCD4I/YsuiWlRmpLeKsQdgX3I4f30k8kseLdQwq2p1G97bkJA5oLk5H6p7CwDgH/YA7dUKf1VkpYs3lY8IUNTiZn6P+wGLAzjcvPbYMgVAlT1tiCW5OvaEbjCJLkQb4BoO+PEuTz1mXhdTb1dbQg9vG888=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Em6YVMe7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16272C4CEDF;
	Sun, 19 Jan 2025 02:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737252324;
	bh=W7g5mzKYbLZMyqo4vpbvxQf4UQRTdOwmKnBZtmNVrTo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Em6YVMe7V2Dh3xrN8RcfFMnOiUyXBWxKvUjAGujqaxbxaM2jXADCBQOWRYAGLxbko
	 PEF/jwfwc+yudk9TfnVaxxTboGutu1sMvjoMmrYejxZTvTuZ69hMdKxkojp7rbmk9q
	 VZvEc5+oyZZs/ELG1QLvm2ryjYoXz6JvjSzFRK+8+GhUTex1/+ey+oF+Vn4Fbq0QZp
	 OsOHCBVuKg3D0h+E7DrkSJ+F8vHKkDjCswI3Afn4Xbl9BvtDqi9dl9wal6lWX2muCM
	 2JAAfHQ82+ENS5h3dEDxJp46MVDdLtJRYfeXFt36Ul0LWXhYWYapma+EfWrjz8hBZQ
	 NNd2ibWKEKjzg==
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
Subject: [PATCH net-next v2 7/7] eth: bnxt: update header sizing defaults
Date: Sat, 18 Jan 2025 18:05:17 -0800
Message-ID: <20250119020518.1962249-8-kuba@kernel.org>
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


