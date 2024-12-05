Return-Path: <netdev+bounces-149302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DE59E5113
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 10:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844A8162172
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 09:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95FD11D47A2;
	Thu,  5 Dec 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3/vwMuX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916A11D2B13;
	Thu,  5 Dec 2024 09:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390379; cv=none; b=me0hDaumdA/K3vyQcjRNXRSY6VTv66hkTpjGFmpc2B9jdZ41cvUAaGoRh8icyVcd4G/4wvl6LbCOqbONvJLk9ImwGxNVQnC/uuPmJtmYospnIUSbv2jIX3ua8gpSdEa+7api2ZeOFCmOkATywwTDsWUUk6J4bqe0tQyEyvFwGcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390379; c=relaxed/simple;
	bh=NvuPaqVN7uPk06l42l9WPd/l7xGnaTvLAtemosUcie0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=faiBpcgPkf5jlFygaaJx3yM2J8ZCTd8o4SN1VqYmX0M+kxMvrYkpxIK71l141DP+4Iso7nM8m3dA0ln9FUXt/WjRHOckUlF3uBR1z2qP3xHDu5Pf0Gu8MQW1yZ++TWRN2k0Oybv7cI8sY444CubE/yq2EAHQpGwcGG975l2oXlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3/vwMuX; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21578cfad81so5506355ad.3;
        Thu, 05 Dec 2024 01:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733390376; x=1733995176; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y0HmfRBKBkLsgyW/HeIjKXTJHSnwiReWOxGDbcg2lig=;
        b=M3/vwMuXAtdt078C/aU0C1V/0GfHKO/MYJQTq6/dnIvX792wmckPRl/rAH4nV+5rLt
         9p0yXZuTX0yGGkxpKtgBVYEUSgLSKBz7OqDCuA1wfPJf7GQgY4Jooc6p4vopaJIzMkVF
         ScH03O39JZzeFisMt4LK/ASnrq5/rk1ZzZcyq4ubHDZf/K8m3XNvj2CQzjzYv//dEaq1
         Q4KdYXp7gANghxv9Ea6W1AcWFA+iLrCv5uJGSdGezGcHsgNECU4tIQigRIKq+qcp9Go+
         iIhC7MYgA7GAIjJgmzjFrTjtsXvm4iD4zqtmXJqF0KoGCS/Mv+Ud9lY326poWEenN0OI
         SRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733390376; x=1733995176;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y0HmfRBKBkLsgyW/HeIjKXTJHSnwiReWOxGDbcg2lig=;
        b=WrfppPe6OIX3h3XaRePyWzA7RXMLj2/EQHhzYIca2on7bCpRySwnyKvt3I1opGU/9x
         xH6wXFbN5MIDtBIY9u/+GlgX/tXZFfsSeb7e83ni9+zlrpJ60kZazE1gw521H5pHydQi
         sAJW5m1gwfWGQ9K7ayj9zJZdapgxD+8my6xdogIISXzY+OM5qF1l3hrStfnkqtXoX4Nc
         2asCDjdEK0LWoaUgW2brppJ/pfDO0Igl3PlsaJOFVurImew6w0N3WMBIzPvvT0c/T6iY
         SmDWEuUlbs+lyS4820Gv94vW8YT43yYc9FLbSFHdQFVi7KGbXJwK0x64r4JWn43hhjre
         CntA==
X-Forwarded-Encrypted: i=1; AJvYcCV1kXXugy4S/i4u7aa/3Wv68QaGvnMz07UHKV8d8afs6LMJ8GCK0+ELvrm7GdzCAsOqSamPWB9m57R+H0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAFlkYgpuYBDAHzu9WfNsjnyoABJ2BB7TAzZPgIA7+PMM8b1hQ
	4aAZSUgvo/NPVCbMpbcvYTzlQz6SNsRsK7j5Twex2JwTqkd2Lsvf82i+TA==
X-Gm-Gg: ASbGncuMIMjTM8N5QhehAhC8cHlVJjuTPH0WFOOSbPieNE2ygNs2EICNZRhsytIznYH
	MfQdalCOVRpCozQvJTKO6do1+7LOwuwxAPxsHGIDUILeLc35XErDUOdIUmZeWFo6WOAP1kq9xbq
	Hww1EOcN3CP6uTQ8VpC+zfVhx66loelXzP2HaFq42mb8oAjnHOqoBQ3mr2s6DcPtwyKgu8Tpg33
	hPOE8fgh8LZ02kxEfb8XzJCv7ds8x0XdEs83r4MmZTZxXp3oGHn4DfYVINBFTs=
X-Google-Smtp-Source: AGHT+IHFjK3cGcjfncsTvxz/JQr72PK97p7r+aYYZQ6H2u3kZ0kfRozsXNPN9a0ZsbcFy3VaXfTZ0g==
X-Received: by 2002:a17:903:1ca:b0:20b:8a71:b5c1 with SMTP id d9443c01a7336-215bd1b4604mr141553115ad.1.1733390376224;
        Thu, 05 Dec 2024 01:19:36 -0800 (PST)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-215f8f09270sm8234895ad.203.2024.12.05.01.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 01:19:35 -0800 (PST)
From: Furong Xu <0x1207@gmail.com>
To: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Subject: [PATCH net v1] net: stmmac: TSO: Fix unaligned DMA unmap for non-paged SKB data
Date: Thu,  5 Dec 2024 17:18:30 +0800
Message-Id: <20241205091830.3719609-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 66600fac7a98 ("net: stmmac: TSO: Fix unbalanced DMA map/unmap for
non-paged SKB data") assigns a wrong DMA buffer address that is added an
offset of proto_hdr_len to tx_q->tx_skbuff_dma[entry].buf on a certain
platform that the DMA AXI address width is configured to 40-bit/48-bit,
stmmac_tx_clean() will try to unmap this illegal DMA buffer address
and many crashes are reported: [1] [2].

This patch guarantees that DMA address is passed to stmmac_tx_clean()
unmodified and without offset.

[1] https://lore.kernel.org/all/d8112193-0386-4e14-b516-37c2d838171a@nvidia.com/
[2] https://lore.kernel.org/all/klkzp5yn5kq5efgtrow6wbvnc46bcqfxs65nz3qy77ujr5turc@bwwhelz2l4dw/

Reported-by: Jon Hunter <jonathanh@nvidia.com>
Reported-by: Thierry Reding <thierry.reding@gmail.com>
Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
Fixes: 66600fac7a98 ("net: stmmac: TSO: Fix unbalanced DMA map/unmap for non-paged SKB data")
Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 9b262cdad60b..7227f8428b5e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4192,8 +4192,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct stmmac_txq_stats *txq_stats;
 	struct stmmac_tx_queue *tx_q;
 	u32 pay_len, mss, queue;
+	dma_addr_t tso_hdr, des;
 	u8 proto_hdr_len, hdr;
-	dma_addr_t des;
 	bool set_ic;
 	int i;
 
@@ -4279,6 +4279,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 			     DMA_TO_DEVICE);
 	if (dma_mapping_error(priv->device, des))
 		goto dma_map_err;
+	tso_hdr = des;
 
 	if (priv->dma_cap.addr64 <= 32) {
 		first->des0 = cpu_to_le32(des);
@@ -4310,7 +4311,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
 	 * this DMA buffer right after the DMA engine completely finishes the
 	 * full buffer transmission.
 	 */
-	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
+	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = tso_hdr;
 	tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_headlen(skb);
 	tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = false;
 	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;
-- 
2.34.1


