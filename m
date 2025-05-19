Return-Path: <netdev+bounces-191526-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B185CABBC79
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 13:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 214DF164D27
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 11:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3772777E2;
	Mon, 19 May 2025 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmSnt/Uo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0EB277000;
	Mon, 19 May 2025 11:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747654415; cv=none; b=iHDp5A4eDdep2MAzBbZKxp0MUIV9Y3F0YSEU9ahkfJTkxwuFT2bLi4Dkl3K3pXxWxJ5tScFtUZyaUB3IBy8FilIhNW6a260Q7PA/7UFFsl8O592HI8Lo9sJNmKG3uRNLeFYcGbDFRBBY/OJHKXQ7u+woC4+1ZcWvuUAgd0V2GTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747654415; c=relaxed/simple;
	bh=QaC2K6r6+VjPufo4ZCvNA58qjjRoznDvFEAe2Nvad7c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DcBaKIBK4w5/zqGACKG0TNzx4C1Hr8CAo/yIRMYuuX0ThLWt718eNsYRc66IPAH/a/NdQgutNdWyu2g3C8Yq5IwefBt9VDV1ETK74OmZDPsPvtstlomYcBBEQkUP58BAJF2EVqwR/2pBUkFK71inmBP6Nc22yIkxlCo3AL1JC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmSnt/Uo; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ad216a5a59cso614431166b.3;
        Mon, 19 May 2025 04:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747654412; x=1748259212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bG4sJdUY2Ms05qHHtz+Y/29eATmk6Z+A46I7k7W9WwQ=;
        b=TmSnt/UoRsVJ07bWQFe5M+TjX0hxj32UtEUOynU6CzoKNH/AXfk9ukhdwq6TsYwdrU
         BNOlm1YsnaoT9GETfAJ1ZFY07ItJMi0bKl5uvdJLTJiOpxeWVg1x7xwZOOJkhmgkBqQg
         i+d0NePfJhoaT0cr007QzLQg+tyPH1fNSMbpXOlx5PbtghU0F3pwzX6J2IUhbyx+YC8f
         OzLSesvkY1UhgNlKANsleST9yZQvn+kkPUbfeRgxVi38bNchY1DCVE+STZtbfUWWCTgi
         VfhorgUPhCVhY2TFBS2vx71Ra5RSLRVSzqq+JH9QFvyGktEjJnrx+6WVq2OPBxdrcNQH
         8WcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747654412; x=1748259212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bG4sJdUY2Ms05qHHtz+Y/29eATmk6Z+A46I7k7W9WwQ=;
        b=cpvVWX3cTzT2PyYq157esWUT7OWypvPm9TqoKwE0sSyCj9EYLjNkQx7Ams5IhVgImw
         1iG9iSHSrLFSOiHik2UTKUpkQkFDhIuY3AVqKpaeKTgIzCDmMHzMrWSEVT3i1OGPJ9sE
         P+gs+v5o5r+fnLsD1TcCt4lzbG/0Mb1RlQJfRYgrcpDa1/um+76YKpyTg7CauZ2BEPA1
         1H3zziW88zqG3WK0JZR2g2MeHQEurI/aK4NiSGq5fGBavPNMq+u0y5FwaZCGakXCjpCf
         ZjCZZfT5nznVFfc7qogsRNYF8W3/fzKrEq0+s6sSQ3ZSR5h2xYowairPgmEN+dpvCt59
         FG3w==
X-Forwarded-Encrypted: i=1; AJvYcCUqHduotObE5wXqY9LLhmxV10rMN7vD8a/7dA/r4Imcjk08MEhqJ1Wi65xGRxwwTHc3Px6GfQ7A0tyzK4w=@vger.kernel.org, AJvYcCW//RR8KxY+WE8yHhmCEKEPckJkc388rtf5iUoU0XIM+F3lJ2ynQovDFf2AnDodu/x9Dj9iMLUU@vger.kernel.org
X-Gm-Message-State: AOJu0YyI3ygwJpL9eMkaaAUl8N/7Ksh44NuMdORke3P/UUr7TTyZbu5P
	ZmMvwsUK116ELgGFp3qaflXsj3dWF6cHV+59a3BhRknKjlNbOq/dNVga
X-Gm-Gg: ASbGnctcZvvgu9Uwe7+Khd2GYLMIhayoUANZnC53MTlOoXdTB5SGzzfglyJq0pRIhOX
	2ShvbPgLjBlIv/h2s5sxrOztbqhTVQMPmS/AVtT6PytR7koA+ndWFTViFQZKkJEtU66DUnzVaI2
	YL+0gjxjaJ4h/aDobM2gOY6GemKMw4O2FdNmGg9URNBV3Sb7G1zU/e8oMDRsExBkXJ88lM4kFdV
	tTOOCShcImElfCtGdTIYWVGeJPbiExEiBVYvOpo6/6GoVOwDSdXlwZtVd9t4xn/HW2n499jfLf+
	CbAb285rOzC0DqzLEcvZAbhMrd4CiUWoeFmavtLy5SPmc24UyyIo5/uxIqYAmg==
X-Google-Smtp-Source: AGHT+IGhMhFO6ayoZ2c9hQF9sp8/S6AgLZn7WjYq2tnwpMIbFIAjphEpdew3Z5Wb7tAM/bklKaLgcQ==
X-Received: by 2002:a17:907:6e9e:b0:ad5:6cb5:fc0e with SMTP id a640c23a62f3a-ad56cb60bccmr391569466b.25.1747654411438;
        Mon, 19 May 2025 04:33:31 -0700 (PDT)
Received: from debian-vm.localnet ([2a01:4b00:d20c:cddd:20c:29ff:fe56:c86])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d06bc66sm574279266b.46.2025.05.19.04.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 May 2025 04:33:31 -0700 (PDT)
From: Zak Kemble <zakkemble@gmail.com>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Zak Kemble <zakkemble@gmail.com>
Subject: [PATCH v3 3/3] net: bcmgenet: expose more stats in ethtool
Date: Mon, 19 May 2025 12:32:57 +0100
Message-Id: <20250519113257.1031-4-zakkemble@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250519113257.1031-1-zakkemble@gmail.com>
References: <20250519113257.1031-1-zakkemble@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose more per-queue and overall stats in ethtool

Signed-off-by: Zak Kemble <zakkemble@gmail.com>
---
 .../net/ethernet/broadcom/genet/bcmgenet.c    | 35 +++++++++++++++++--
 .../net/ethernet/broadcom/genet/bcmgenet.h    |  2 ++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index 578db6230..fa0077bc6 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -1029,6 +1029,10 @@ struct bcmgenet_stats {
 			tx_rings[num].stats64, packets), \
 	STAT_GENET_SOFT_MIB64("txq" __stringify(num) "_bytes", \
 			tx_rings[num].stats64, bytes), \
+	STAT_GENET_SOFT_MIB64("txq" __stringify(num) "_errors", \
+			tx_rings[num].stats64, errors), \
+	STAT_GENET_SOFT_MIB64("txq" __stringify(num) "_dropped", \
+			tx_rings[num].stats64, dropped), \
 	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_bytes", \
 			rx_rings[num].stats64, bytes),	 \
 	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_packets", \
@@ -1036,7 +1040,23 @@ struct bcmgenet_stats {
 	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_errors", \
 			rx_rings[num].stats64, errors), \
 	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_dropped", \
-			rx_rings[num].stats64, dropped)
+			rx_rings[num].stats64, dropped), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_multicast", \
+			rx_rings[num].stats64, multicast), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_missed", \
+			rx_rings[num].stats64, missed), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_length_errors", \
+			rx_rings[num].stats64, length_errors), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_over_errors", \
+			rx_rings[num].stats64, over_errors), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_crc_errors", \
+			rx_rings[num].stats64, crc_errors), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_frame_errors", \
+			rx_rings[num].stats64, frame_errors), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_fragmented_errors", \
+			rx_rings[num].stats64, fragmented_errors), \
+	STAT_GENET_SOFT_MIB64("rxq" __stringify(num) "_broadcast", \
+			rx_rings[num].stats64, broadcast)
 
 /* There is a 0xC gap between the end of RX and beginning of TX stats and then
  * between the end of TX stats and the beginning of the RX RUNT
@@ -1057,6 +1077,11 @@ static const struct bcmgenet_stats bcmgenet_gstrings_stats[] = {
 	STAT_RTNL(rx_dropped),
 	STAT_RTNL(tx_dropped),
 	STAT_RTNL(multicast),
+	STAT_RTNL(rx_missed_errors),
+	STAT_RTNL(rx_length_errors),
+	STAT_RTNL(rx_over_errors),
+	STAT_RTNL(rx_crc_errors),
+	STAT_RTNL(rx_frame_errors),
 	/* UniMAC RSV counters */
 	STAT_GENET_MIB_RX("rx_64_octets", mib.rx.pkt_cnt.cnt_64),
 	STAT_GENET_MIB_RX("rx_65_127_oct", mib.rx.pkt_cnt.cnt_127),
@@ -2358,7 +2383,7 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		if (unlikely(!(dma_flag & DMA_EOP) || !(dma_flag & DMA_SOP))) {
 			netif_err(priv, rx_status, dev,
 				  "dropping fragmented packet!\n");
-			BCMGENET_STATS64_INC(stats, errors);
+			BCMGENET_STATS64_INC(stats, fragmented_errors);
 			dev_kfree_skb_any(skb);
 			goto next;
 		}
@@ -2412,6 +2437,8 @@ static unsigned int bcmgenet_desc_rx(struct bcmgenet_rx_ring *ring,
 		u64_stats_add(&stats->bytes, len);
 		if (dma_flag & DMA_RX_MULT)
 			u64_stats_inc(&stats->multicast);
+		else if (dma_flag & DMA_RX_BRDCAST)
+			u64_stats_inc(&stats->broadcast);
 		u64_stats_update_end(&stats->syncp);
 
 		/* Notify kernel */
@@ -3569,6 +3596,7 @@ static void bcmgenet_get_stats64(struct net_device *dev,
 	struct bcmgenet_tx_stats64 *tx_stats;
 	struct bcmgenet_rx_stats64 *rx_stats;
 	u64 rx_length_errors, rx_over_errors;
+	u64 rx_missed, rx_fragmented_errors;
 	u64 rx_crc_errors, rx_frame_errors;
 	u64 tx_errors, tx_dropped;
 	u64 rx_errors, rx_dropped;
@@ -3577,7 +3605,6 @@ static void bcmgenet_get_stats64(struct net_device *dev,
 	unsigned int start;
 	unsigned int q;
 	u64 multicast;
-	u64 rx_missed;
 
 	for (q = 0; q <= priv->hw_params->tx_queues; q++) {
 		tx_stats = &priv->tx_rings[q].stats64;
@@ -3608,12 +3635,14 @@ static void bcmgenet_get_stats64(struct net_device *dev,
 			rx_over_errors = u64_stats_read(&rx_stats->over_errors);
 			rx_crc_errors = u64_stats_read(&rx_stats->crc_errors);
 			rx_frame_errors = u64_stats_read(&rx_stats->frame_errors);
+			rx_fragmented_errors = u64_stats_read(&rx_stats->fragmented_errors);
 			multicast = u64_stats_read(&rx_stats->multicast);
 		} while (u64_stats_fetch_retry(&rx_stats->syncp, start));
 
 		rx_errors += rx_length_errors;
 		rx_errors += rx_crc_errors;
 		rx_errors += rx_frame_errors;
+		rx_errors += rx_fragmented_errors;
 
 		stats->rx_bytes += rx_bytes;
 		stats->rx_packets += rx_packets;
diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.h b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
index 10bbb3eb8..5ec397977 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.h
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.h
@@ -170,11 +170,13 @@ struct bcmgenet_rx_stats64 {
 	u64_stats_t	errors;
 	u64_stats_t	dropped;
 	u64_stats_t	multicast;
+	u64_stats_t	broadcast;
 	u64_stats_t	missed;
 	u64_stats_t	length_errors;
 	u64_stats_t	over_errors;
 	u64_stats_t	crc_errors;
 	u64_stats_t	frame_errors;
+	u64_stats_t	fragmented_errors;
 };
 
 #define UMAC_MIB_START			0x400
-- 
2.39.5


