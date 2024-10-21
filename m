Return-Path: <netdev+bounces-137374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D35159A5A30
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 08:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C801C210A6
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 06:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E9E1CF292;
	Mon, 21 Oct 2024 06:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V2e3+F64"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5C31946D0;
	Mon, 21 Oct 2024 06:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729491047; cv=none; b=hAndFI9eR+aRjjdeJDNAJVlEXNnHzhBFyUpHLGT/RBjsLruEnMmvswrXIuh0B5MxkCjmo/Rl5eVrJaZZdWvuvzgYHuzsYEmCTv9priOzvm5drm0wdXsu15IqdzkhCfDDnoA1sahNUK6lUjS1L7FG6eHVKkWWqdhWANaMj5s+o5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729491047; c=relaxed/simple;
	bh=fc+HEIHCLf3cvwkrzW93vSxGWX+d0v9vT2JlNhSi5h4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F2HL/QKXMR6o8zNPFwF6kJYVxZNIdnWKxXCaNMKN62Eej9+lsal3VexjORouS5iC17xp2qPQAf4XOMAgCCCUQdl+AZsDdHRHzNX6Ylw5dabkqku8raf8pgqthI7GtJFKeMfO4CwPT6A1BcfUeEjXh6Kerjn2SxpZDAHaTGuvCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V2e3+F64; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e61b47c6cso3199841b3a.2;
        Sun, 20 Oct 2024 23:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729491044; x=1730095844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iQESqJ9aYfd46Wdo01VIZ5qOywZL6bQHldy6wnuTUU8=;
        b=V2e3+F64zVJHXF4Gb7sE+JZQ9YBasSkHxFlietCqTDT3J+5nEdmad+D+AbT3xNGV2X
         nZ9B1blDfFlS0faFdlQfRvMR0GJdjRWqmlAhusIpmNxZL6pCLAZtOzpmuKhTUL5tdqhL
         YGFjyH9N9f1etxXxlsCmATkpf65Vhgvn96sqkobr6HKMo1q3NSFXdDxWXtrQYA2F+4N0
         qABvZQMHSvD8COf3o1QeMaSWshcomOA6n+qQV6v2gb4kDfvi4lFc84nxO7MxRO4DhLPg
         WzT4oeu+gshl2d7hJsRq34Fivqlp+0o8ziB3kGCCjjD/TL+SZTLVvPTHvSESPdFHRg3S
         Mbdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729491044; x=1730095844;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iQESqJ9aYfd46Wdo01VIZ5qOywZL6bQHldy6wnuTUU8=;
        b=dKFcLiTGjdI2/mVcvt+99T41bEORN+pW5ItLOxmPIwPYl0ToCxmi8IBEG1iqMd/Vd5
         YEyJ7igCa/Z/UjWJ4U/bIJXkyiiKXg0lnYO/QjqNgPKNnmrCKUvoKvITBngsFfpeN1Q7
         VuDoG68ngvAUmAoV+rDoOb77bZ+Cn7XDPgz93WRpL5QcUjoL8D+VpFYKAUIH+X0XPMxD
         kipoSdfM5aQ4ufaDQ9BiiSwfJ5R5urMYlMO3YwiZ8gm0/Ch4H7CwuUkoC83nLEJW6YwO
         bhHds8Lf9HeviqllvOiwZphXtxpEvsnM6CF913I2namyFbsN1mUJupyeJ0xxJ9EYZ6qx
         Lqjw==
X-Forwarded-Encrypted: i=1; AJvYcCUd9RAdN9/ANQ69zl3AwSMEpEBtEO47v2hb8SvVEjTd+7RVas3d6rneIdU0rSc6dFsqGd5InpiI0i3Uxlc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzADeuMH5cYTE4f5cdqx7Q7Gr0W2Iej9SJny83GKf1UvqcnyQgH
	n6HSvgxPi4+POjhVAopgnhVVRTSlmOvNvXhpoMGU4q+j5JjA1EBcmi2n8g==
X-Google-Smtp-Source: AGHT+IFfcM3mmxhkbfvMBoyB5bFdlWr6KbbE9WM+AEcGbqCxvjfTNgq2Enq1ESlcFgxrfwc/MvRFcQ==
X-Received: by 2002:a05:6a00:3d15:b0:71e:79a9:ec47 with SMTP id d2e1a72fcca58-71ea3118addmr16050357b3a.6.1729491043923;
        Sun, 20 Oct 2024 23:10:43 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71ec13d7422sm2145735b3a.97.2024.10.20.23.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 23:10:43 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>
Subject: [PATCH net v1] net: stmmac: TSO: Fix unbalanced DMA map/unmap for non-paged SKB data
Date: Mon, 21 Oct 2024 14:10:23 +0800
Message-Id: <20241021061023.2162701-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case the non-paged data of a SKB carries protocol header and protocol
payload to be transmitted on a certain platform that the DMA AXI address
width is configured to 40-bit/48-bit, or the size of the non-paged data
is bigger than TSO_MAX_BUFF_SIZE on a certain platform that the DMA AXI
address width is configured to 32-bit, then this SKB requires at least
two DMA transmit descriptors to serve it.

For example, three descriptors are allocated to split one DMA buffer
mapped from one piece of non-paged data:
    dma_desc[N + 0],
    dma_desc[N + 1],
    dma_desc[N + 2].
Then three elements of tx_q->tx_skbuff_dma[] will be allocated to hold
extra information to be reused in stmmac_tx_clean():
    tx_q->tx_skbuff_dma[N + 0],
    tx_q->tx_skbuff_dma[N + 1],
    tx_q->tx_skbuff_dma[N + 2].
Now we focus on tx_q->tx_skbuff_dma[entry].buf, which is the DMA buffer
address returned by DMA mapping call. stmmac_tx_clean() will try to
unmap the DMA buffer _ONLY_IF_ tx_q->tx_skbuff_dma[entry].buf
is a valid buffer address.

The expected behavior that saves DMA buffer address of this non-paged
data to tx_q->tx_skbuff_dma[entry].buf is:
    tx_q->tx_skbuff_dma[N + 0].buf = NULL;
    tx_q->tx_skbuff_dma[N + 1].buf = NULL;
    tx_q->tx_skbuff_dma[N + 2].buf = dma_map_single();
Unfortunately, the current code misbehaves like this:
    tx_q->tx_skbuff_dma[N + 0].buf = dma_map_single();
    tx_q->tx_skbuff_dma[N + 1].buf = NULL;
    tx_q->tx_skbuff_dma[N + 2].buf = NULL;

On the stmmac_tx_clean() side, when dma_desc[N + 0] is closed by the
DMA engine, tx_q->tx_skbuff_dma[N + 0].buf is a valid buffer address
obviously, then the DMA buffer will be unmapped immediately.
There may be a rare case that the DMA engine does not finish the
pending dma_desc[N + 1], dma_desc[N + 2] yet. Now things will go
horribly wrong, DMA is going to access a unmapped/unreferenced memory
region, corrupted data will be transmited or iommu fault will be
triggered :(

In contrast, the for-loop that maps SKB fragments behaves perfectly
as expected, and that is how the driver should do for both non-paged
data and paged frags actually.

This patch corrects DMA map/unmap sequences by fixing the array index
for tx_q->tx_skbuff_dma[entry].buf when assigning DMA buffer address.

Tested and verified on DWXGMAC CORE 3.20a

Reported-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
Fixes: f748be531d70 ("stmmac: support new GMAC4")
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index d3895d7eecfc..208dbc68aaf9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4304,11 +4304,6 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	if (dma_mapping_error(priv->device, des))
 		goto dma_map_err;
 
-	tx_q->tx_skbuff_dma[first_entry].buf = des;
-	tx_q->tx_skbuff_dma[first_entry].len = skb_headlen(skb);
-	tx_q->tx_skbuff_dma[first_entry].map_as_page = false;
-	tx_q->tx_skbuff_dma[first_entry].buf_type = STMMAC_TXBUF_T_SKB;
-
 	if (priv->dma_cap.addr64 <= 32) {
 		first->des0 = cpu_to_le32(des);
 
@@ -4327,6 +4322,23 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	stmmac_tso_allocator(priv, des, tmp_pay_len, (nfrags == 0), queue);
 
+	/* In case two or more DMA transmit descriptors are allocated for this
+	 * non-paged SKB data, the DMA buffer address should be saved to
+	 * tx_q->tx_skbuff_dma[].buf corresponding to the last descriptor,
+	 * and leave the other tx_q->tx_skbuff_dma[].buf as NULL to guarantee
+	 * that stmmac_tx_clean() does not unmap the entire DMA buffer too early
+	 * since the tail areas of the DMA buffer can be accessed by DMA engine
+	 * sooner or later.
+	 * By saving the DMA buffer address to tx_q->tx_skbuff_dma[].buf
+	 * corresponding to the last descriptor, stmmac_tx_clean() will unmap
+	 * this DMA buffer right after the DMA engine completely finishes the
+	 * full buffer transmission.
+	 */
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_headlen(skb);
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = false;
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
+
 	/* Prepare fragments */
 	for (i = 0; i < nfrags; i++) {
 		const skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
-- 
2.34.1


