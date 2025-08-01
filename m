Return-Path: <netdev+bounces-211373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC70B1864D
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 19:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 304B43B0EFF
	for <lists+netdev@lfdr.de>; Fri,  1 Aug 2025 17:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB741DED47;
	Fri,  1 Aug 2025 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzdIPICz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972821DE3C8
	for <netdev@vger.kernel.org>; Fri,  1 Aug 2025 17:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754068078; cv=none; b=kT1i+XLRgLmctdfQ9TtImV/o9DyvYP6CQihvJ+/pFbiLxtIfyetRMJzZWtlGm3nnGhFXthKWHUKRj2jvxDqb5sTxTHT337lfwg4V7JNTtUX+0B01hU3ueYtupVNnSjABHwph69nVKYnPuXaMeh9G7MxpSK/w4pnLGxs2ypDU0tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754068078; c=relaxed/simple;
	bh=HyNyjzGPjk28Tm0TAXn34iMnyXtod/2OYBlYsMrTIoQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bftvyhWLNDHMBJwVj1hKW7HBoYxKFSpz+zq1+CJYXecyINej39xLjVBfE+OypOdkabH1iBe6CU36aoImK6rqc3xPvar8Tyh8e2IbnMtgh7ImsRYPdF5XhMG6NtaEhJkfEEQYY6QFvBOvcSa6hbOYtol0dssJGFXs7mWiBxnZMzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzdIPICz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CA3C4CEE7;
	Fri,  1 Aug 2025 17:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754068077;
	bh=HyNyjzGPjk28Tm0TAXn34iMnyXtod/2OYBlYsMrTIoQ=;
	h=From:To:Cc:Subject:Date:From;
	b=uzdIPICzYz3ma5z5klTnOmAYEPIQVoHN9cKlDp52KWIzsHMFmFMkypTsuYg67C4Pm
	 qfQ9kn3Lw5N69H1UMph3/IL93+YidfSlZzu3GN1N1CV30TaWtAd9zykkAEIzJ+hjIJ
	 fDk9dBAaorM5ATULTK3kBp05FgfR7ggJMF+iXcY7/PaSg/lOe6ADUVlIeWZ9sOoiAh
	 RGRe9Is1xAUmPC17pP/FMD2nbAV8Jr5uJpcGyywONzzYa/iUyWnOZ6QPxg44AhaWnl
	 F+OdReWyU8o5LjFCF29A9gbpVqxamX5NbpWaa1Msi0xQlsJgnmiZtvYw+EBgatFSw9
	 ZW9vRkx5M1x1g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	alexanderduyck@fb.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] eth: fbnic: remove the debugging trick of super high page bias
Date: Fri,  1 Aug 2025 10:07:54 -0700
Message-ID: <20250801170754.2439577-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alex added page bias of LONG_MAX, which is admittedly quite
a clever way of catching overflows of the pp ref count.
The page pool code was "optimized" to leave the ref at 1
for freed pages so it can't catch basic bugs by itself any more.
(Something we should probably address under DEBUG_NET...)

Unfortunately for fbnic since commit f7dc3248dcfb ("skbuff: Optimization
of SKB coalescing for page pool") core _may_ actually take two extra
pp refcounts, if one of them is returned before driver gives up the bias
the ret < 0 check in page_pool_unref_netmem() will trigger.

While at it add a FBNIC_ to the name of the driver constant.

Fixes: 0cb4c0a13723 ("eth: fbnic: Implement Rx queue alloc/start/stop/free")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h | 6 ++----
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c | 4 ++--
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index 2e361d6f03ff..34693596e5eb 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -91,10 +91,8 @@ struct fbnic_queue_stats {
 	struct u64_stats_sync syncp;
 };
 
-/* Pagecnt bias is long max to reserve the last bit to catch overflow
- * cases where if we overcharge the bias it will flip over to be negative.
- */
-#define PAGECNT_BIAS_MAX	LONG_MAX
+#define FBNIC_PAGECNT_BIAS_MAX	PAGE_SIZE
+
 struct fbnic_rx_buf {
 	struct page *page;
 	long pagecnt_bias;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index ac11389a764c..f9543d03485f 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -661,8 +661,8 @@ static void fbnic_page_pool_init(struct fbnic_ring *ring, unsigned int idx,
 {
 	struct fbnic_rx_buf *rx_buf = &ring->rx_buf[idx];
 
-	page_pool_fragment_page(page, PAGECNT_BIAS_MAX);
-	rx_buf->pagecnt_bias = PAGECNT_BIAS_MAX;
+	page_pool_fragment_page(page, FBNIC_PAGECNT_BIAS_MAX);
+	rx_buf->pagecnt_bias = FBNIC_PAGECNT_BIAS_MAX;
 	rx_buf->page = page;
 }
 
-- 
2.50.1


