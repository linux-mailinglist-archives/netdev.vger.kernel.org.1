Return-Path: <netdev+bounces-224768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D44B8970C
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 14:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 392961C22DE5
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 12:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4AA310647;
	Fri, 19 Sep 2025 12:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="F+Xk3glO"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9AC30CB49
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 12:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758284752; cv=none; b=LiQUp8g41xppmeVsF3vqTsnkT+dNZj1H0kEQuGyLkcj4pUnaX8JRw15VHYSXvJOzwmhAS5LCvd/5OqQpa+jc7IIPVEIx0dUiBSnOtzz0QH3AiRBux6mtd/Klrk0+tv2KF0o8/3Q/Qfk0f7c7PyxvXFK88Vu5M7IITQd4mWbmjUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758284752; c=relaxed/simple;
	bh=vYAp2B9j9qt6EzipuEAQ4I8GMhjImCOP7cCNEmb6aqM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=soGiiwwY1y/zNgEDZ0mONpie7Zgu+YKOg5P1uJExkZWNhQfxjuJKKZkPC2nKuG+FZOg6q/m9mBfza5XiWk/cficU0JqXHaF4HwEuLDZ0zIqhn/9iTpVLnYhNM5SQYUdrr7hpX7BgrSAswLo4y1H5/f9Nu/y4WSozob0gf9js1z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=F+Xk3glO; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250919122548euoutp02149ba28e8f5ef0c902ea85bcc683ee45~mrqm-zINf0448904489euoutp02J
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 12:25:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250919122548euoutp02149ba28e8f5ef0c902ea85bcc683ee45~mrqm-zINf0448904489euoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1758284748;
	bh=xSKIjPyrA9OEriZopMFlNAyxpcs3It57Viautl04tXI=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=F+Xk3glO2cgewx7e1iKp9JX1qLwGgul+qkbyUSnqJFUujLqQCD+JHqtjvA6C3plYu
	 tb6XPaK8AiHnvh314NhvSLRtAY4447tqqdUgXWoNLeXPOAmqkxv+8RUKDUaNPnreiy
	 X7XwGpQUJq2P149JjEd996iP8UKxN6e0DQeU8y+U=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250919122548eucas1p1ef58c5c747bee71acd5f9d6476e7c29c~mrqmcuafh2548325483eucas1p1m;
	Fri, 19 Sep 2025 12:25:48 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250919122546eusmtip2896ff33c135295219ae1f797110c7a94~mrqk2ipmP1691216912eusmtip2-;
	Fri, 19 Sep 2025 12:25:46 +0000 (GMT)
Message-ID: <7605453a-ac62-497b-b77a-76d73e9a6741@samsung.com>
Date: Fri, 19 Sep 2025 14:25:45 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH net-next] net: spacemit: Make stats_lock softirq-safe
To: Vivian Wang <wangruikang@iscas.ac.cn>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
	Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Yixun Lan <dlan@gentoo.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>, Troy Mitchell
	<troy.mitchell@linux.spacemit.com>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>
Cc: netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, Vivian Wang
	<uwu@dram.page>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250919-k1-ethernet-fix-lock-v1-1-c8b700aa4954@iscas.ac.cn>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250919122548eucas1p1ef58c5c747bee71acd5f9d6476e7c29c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250919120522eucas1p224c42d0cc2a59903d85e6c80dfdfa727
X-EPHeader: CA
X-CMS-RootMailID: 20250919120522eucas1p224c42d0cc2a59903d85e6c80dfdfa727
References: <CGME20250919120522eucas1p224c42d0cc2a59903d85e6c80dfdfa727@eucas1p2.samsung.com>
	<20250919-k1-ethernet-fix-lock-v1-1-c8b700aa4954@iscas.ac.cn>

On 19.09.2025 14:04, Vivian Wang wrote:
> While most of the statistics functions (emac_get_stats64() and such) are
> called with softirqs enabled, emac_stats_timer() is, as its name
> suggests, also called from a timer, i.e. called in softirq context.
>
> All of these take stats_lock. Therefore, make stats_lock softirq-safe by
> changing spin_lock() into spin_lock_bh() for the functions that get
> statistics.
>
> Also, instead of directly calling emac_stats_timer() in emac_up() and
> emac_resume(), set the timer to trigger instead, so that
> emac_stats_timer() is only called from the timer. It will keep using
> spin_lock().
>
> This fixes a lockdep warning, and potential deadlock when stats_timer is
> triggered in the middle of getting statistics.
>
> Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/all/a52c0cf5-0444-41aa-b061-a0a1d72b02fe@samsung.com/
> Signed-off-by: Vivian Wang <wangruikang@iscas.ac.cn>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
> Thanks a lot for catching this, Marek!
> ---
>   drivers/net/ethernet/spacemit/k1_emac.c | 30 +++++++++++++++---------------
>   1 file changed, 15 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethernet/spacemit/k1_emac.c
> index 928fea02198c3754f63a7b33fc25c5dd8c2b59f9..e1c5faff3b71c7d4ceba2ea194d9c888f0e71b70 100644
> --- a/drivers/net/ethernet/spacemit/k1_emac.c
> +++ b/drivers/net/ethernet/spacemit/k1_emac.c
> @@ -135,7 +135,7 @@ struct emac_priv {
>   	bool flow_control_autoneg;
>   	u8 flow_control;
>   
> -	/* Hold while touching hardware statistics */
> +	/* Softirq-safe, hold while touching hardware statistics */
>   	spinlock_t stats_lock;
>   };
>   
> @@ -1239,7 +1239,7 @@ static void emac_get_stats64(struct net_device *dev,
>   	/* This is the only software counter */
>   	storage->tx_dropped = emac_get_stat_tx_drops(priv);
>   
> -	spin_lock(&priv->stats_lock);
> +	spin_lock_bh(&priv->stats_lock);
>   
>   	emac_stats_update(priv);
>   
> @@ -1261,7 +1261,7 @@ static void emac_get_stats64(struct net_device *dev,
>   	storage->rx_missed_errors = rx_stats->stats.rx_drp_fifo_full_pkts;
>   	storage->rx_missed_errors += rx_stats->stats.rx_truncate_fifo_full_pkts;
>   
> -	spin_unlock(&priv->stats_lock);
> +	spin_unlock_bh(&priv->stats_lock);
>   }
>   
>   static void emac_get_rmon_stats(struct net_device *dev,
> @@ -1275,7 +1275,7 @@ static void emac_get_rmon_stats(struct net_device *dev,
>   
>   	*ranges = emac_rmon_hist_ranges;
>   
> -	spin_lock(&priv->stats_lock);
> +	spin_lock_bh(&priv->stats_lock);
>   
>   	emac_stats_update(priv);
>   
> @@ -1294,7 +1294,7 @@ static void emac_get_rmon_stats(struct net_device *dev,
>   	rmon_stats->hist[5] = rx_stats->stats.rx_1024_1518_pkts;
>   	rmon_stats->hist[6] = rx_stats->stats.rx_1519_plus_pkts;
>   
> -	spin_unlock(&priv->stats_lock);
> +	spin_unlock_bh(&priv->stats_lock);
>   }
>   
>   static void emac_get_eth_mac_stats(struct net_device *dev,
> @@ -1307,7 +1307,7 @@ static void emac_get_eth_mac_stats(struct net_device *dev,
>   	tx_stats = &priv->tx_stats;
>   	rx_stats = &priv->rx_stats;
>   
> -	spin_lock(&priv->stats_lock);
> +	spin_lock_bh(&priv->stats_lock);
>   
>   	emac_stats_update(priv);
>   
> @@ -1325,7 +1325,7 @@ static void emac_get_eth_mac_stats(struct net_device *dev,
>   	mac_stats->FramesAbortedDueToXSColls =
>   		tx_stats->stats.tx_excessclsn_pkts;
>   
> -	spin_unlock(&priv->stats_lock);
> +	spin_unlock_bh(&priv->stats_lock);
>   }
>   
>   static void emac_get_pause_stats(struct net_device *dev,
> @@ -1338,14 +1338,14 @@ static void emac_get_pause_stats(struct net_device *dev,
>   	tx_stats = &priv->tx_stats;
>   	rx_stats = &priv->rx_stats;
>   
> -	spin_lock(&priv->stats_lock);
> +	spin_lock_bh(&priv->stats_lock);
>   
>   	emac_stats_update(priv);
>   
>   	pause_stats->tx_pause_frames = tx_stats->stats.tx_pause_pkts;
>   	pause_stats->rx_pause_frames = rx_stats->stats.rx_pause_pkts;
>   
> -	spin_unlock(&priv->stats_lock);
> +	spin_unlock_bh(&priv->stats_lock);
>   }
>   
>   /* Other statistics that are not derivable from standard statistics */
> @@ -1393,14 +1393,14 @@ static void emac_get_ethtool_stats(struct net_device *dev,
>   	u64 *rx_stats = (u64 *)&priv->rx_stats;
>   	int i;
>   
> -	spin_lock(&priv->stats_lock);
> +	spin_lock_bh(&priv->stats_lock);
>   
>   	emac_stats_update(priv);
>   
>   	for (i = 0; i < ARRAY_SIZE(emac_ethtool_rx_stats); i++)
>   		data[i] = rx_stats[emac_ethtool_rx_stats[i].offset];
>   
> -	spin_unlock(&priv->stats_lock);
> +	spin_unlock_bh(&priv->stats_lock);
>   }
>   
>   static int emac_ethtool_get_regs_len(struct net_device *dev)
> @@ -1769,7 +1769,7 @@ static int emac_up(struct emac_priv *priv)
>   
>   	netif_start_queue(ndev);
>   
> -	emac_stats_timer(&priv->stats_timer);
> +	mod_timer(&priv->stats_timer, jiffies);
>   
>   	return 0;
>   
> @@ -1807,14 +1807,14 @@ static int emac_down(struct emac_priv *priv)
>   
>   	/* Update and save current stats, see emac_stats_update() for usage */
>   
> -	spin_lock(&priv->stats_lock);
> +	spin_lock_bh(&priv->stats_lock);
>   
>   	emac_stats_update(priv);
>   
>   	priv->tx_stats_off = priv->tx_stats;
>   	priv->rx_stats_off = priv->rx_stats;
>   
> -	spin_unlock(&priv->stats_lock);
> +	spin_unlock_bh(&priv->stats_lock);
>   
>   	pm_runtime_put_sync(&pdev->dev);
>   	return 0;
> @@ -2111,7 +2111,7 @@ static int emac_resume(struct device *dev)
>   
>   	netif_device_attach(ndev);
>   
> -	emac_stats_timer(&priv->stats_timer);
> +	mod_timer(&priv->stats_timer, jiffies);
>   
>   	return 0;
>   }
>
> ---
> base-commit: 315f423be0d1ebe720d8fd4fa6bed68586b13d34
> change-id: 20250919-k1-ethernet-fix-lock-c99681a9aa5d
>
> Best regards,

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


