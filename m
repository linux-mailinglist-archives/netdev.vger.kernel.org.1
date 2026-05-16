Return-Path: <netdev+bounces-288672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBW5EPnqCGpD/QMAu9opvQ
	(envelope-from <netdev+bounces-288672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 00:08:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8B055E0DF
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 00:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 263003013B7E
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 22:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373E5388E61;
	Sat, 16 May 2026 22:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br3+k/Ik"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C0D38B14C
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 22:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778969255; cv=none; b=IrH+IXupPTYCLTDPSSLt87vXyvQPuHYZgdWiM8AiWinQpmlnthyo+04+Rr76dzpqWGhAsTVnrU1CdQTAkm7CCD1UmK8gh9vjfQ18g3CY/rzFkZhYSxJj/IU3xqQ+V0onhvR0qaGd280+VMMp7D+BQB/McveJzBiVp+VImI+RlnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778969255; c=relaxed/simple;
	bh=moQtC3wsesbiFuZLWdkWCEAAj7TKhK0xPTuk8lP2cMk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mEwXpcMCc49IudR5QjKrtTgCpArsQ4QtKSxFEVmnrnp76TDNaqoPw1LkCKHHgx+1RCpX4VwPEzw2txy9j+VDJ62r2mkL9G8PclV6O+dd826maXcn+7kLS3cGNjAiIPLFu7v9+pH/7hhvCqPfTS0358jIgvewX+k+tnrLUPi+p9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br3+k/Ik; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48d102471a4so6829045e9.2
        for <netdev@vger.kernel.org>; Sat, 16 May 2026 15:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778969252; x=1779574052; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+wKhZSb9cCkHmBev0VWOG/+bjDaCYCIRmW5W59h5f4Q=;
        b=br3+k/Ik/Gd8WkwLhB8gE75CRjZhboUaP6xfiemicutMlm49pEKT8vln4p+p9mAbwp
         HLZTJgd76uysRxmuraN3LAtyxiJPXZiCLAa5t9OX9ATXrab88Ca8bH1k7oSbsvSmx8u8
         CbdyNszmoWK9CqmqitAJfEvippoy28vxRncie3nFvQcaQbpEOfvUYOVYtTVEMYBZlrU4
         iRzD/ISLb7h67Hq5UyW9WcRNWWVqYg2SRUTCpMvgBh5tIRpdOa7UyEdKFgJV4udeww84
         KtbM6iuGH++fzvi9bCgCIEKUDmGoUuttsADvjxIwEgxHHncAltiJH4+N9d6RihrmD6l0
         gKpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778969252; x=1779574052;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+wKhZSb9cCkHmBev0VWOG/+bjDaCYCIRmW5W59h5f4Q=;
        b=KNy6OLU2WHdX6Php9j7+nXfINLYKR42exXlEZNJeJMn7ZKheku5OC42pWQ3GU71c0K
         RdYyqeuk9hJa1ZYaVpCWlgA7bpLB8a219yrTsFdyh8GDOFtTilCtsfJG9bAPARFURvQ2
         wB1P7bfpDxM7X76AOnp9FP9qFd7FdjXYn2bpx0f8jZe9RuWf4NSr4PqpTaUdFrU1ijGX
         B/qJ/2E+aZl150BjLAK/atpRR8EMnz/7C+J1u4R32KipKm5JjmA8GExuIEq7lqlKB0Bd
         leC+66Hvaieg5QPtbiYYjNCw2jcBA04uaeisDx6g+U/doVBi8M8wGJv5aq+Qh4d3QcWb
         gAig==
X-Gm-Message-State: AOJu0YzLgtOnhzjAoMWrYz7Wnj3MI/2/VSG63VB2pCEpBsXiQVaSouGn
	fv/KFSVmBqt6PbnYQZbwYGjnuCQJYGFrRVKAqlovmlXbHGcOmcRlwRB1
X-Gm-Gg: Acq92OG7bGdal6KbZF1lZZjYAa8B5FsMztaPmWdAnbGLDH9/Afw/FIktQv2TDPWtAma
	CwW4JZOu/bY/osBvt0Ev7FcBuYrcpIYXc3/Y/k1Q7HH208NqtaT6RgvecLJTZFV24Go14RV4FPg
	WPtej0Wii9qeYf6seNJ7iXMzsmuTlt3Qoz01EHirvfgZKMsyn7VIsQcl7ZtKcRK3VSzcEsPHaow
	llMJ8oGkPoyZBfi5el00Ge3YmikNoygr0SHq7gv8Z7UH/YkwudJsFrKoG/FVLV5H3lbUn4q+nC/
	qzyFmdBn8QZHU5bhcTw7ywK5QwFE9zisL+UbjvpK07sfqKQgEVg+ObepSWg/Wf5BB7WfknZh54m
	RU9zcjFtrLj5G1OhfGFRQI628rLOalrxdiSYQmHwcrTttxwVo4HrJzPTMJC2rO9cxW+67fK7TzK
	sHC+4lOOoVjGTeEF8/+iSuBQg9CTuAVhMYkAgfTuHVj+yFID1lfCzX3bo7+MyyNIOf2yCPKBTN5
	Ei6YqcnV+0zjyKJmQyOmj081GQDsQRW5eLNHOf4ohX0BqRH6uvpGYohlLy0siQBlU39CgcxVA==
X-Received: by 2002:a05:600c:2d09:b0:48f:e1ac:c96d with SMTP id 5b1f17b1804b1-48fe61f2bcemr72856845e9.20.1778969251736;
        Sat, 16 May 2026 15:07:31 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f2c:8500:bde1:c576:18ad:a53? (p200300ea8f2c8500bde1c57618ad0a53.dip0.t-ipconnect.de. [2003:ea:8f2c:8500:bde1:c576:18ad:a53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fe537c788sm144690005e9.12.2026.05.16.15.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 May 2026 15:07:31 -0700 (PDT)
Message-ID: <172ed6a7-4e20-4fcf-a192-b8d3116b7d9b@gmail.com>
Date: Sun, 17 May 2026 00:07:30 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [Patch net-next v3 7/7] r8169: add support for ethtool
To: javen <javen_xu@realsil.com.cn>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260513115543.1730-1-javen_xu@realsil.com.cn>
 <20260513115543.1730-8-javen_xu@realsil.com.cn>
Content-Language: en-US
In-Reply-To: <20260513115543.1730-8-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AA8B055E0DF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288672-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On 13.05.2026 13:55, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch add support for changing rx queues by ethtool. We can set rx
> 1, 2, 4, 8 by ethtool -L eth1 rx num.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - no changes
> 
> Changes in v3:
>  - no changes
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 126 ++++++++++++++++++++++
>  1 file changed, 126 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index f654e98e47be..ae64955e47d4 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -6269,6 +6269,130 @@ static void r8169_init_napi(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static void rtl8169_get_channels(struct net_device *dev,
> +				 struct ethtool_channels *ch)
> +{
> +	struct rtl8169_private *tp = netdev_priv(dev);
> +
> +	ch->max_rx = tp->hw_supp_num_rx_queues;
> +	ch->max_tx = 1;
> +	ch->max_other = 0;
> +	ch->max_combined = 0;

The struct comes zero-initialized, so explicitly setting zero
values shouldn't be needed.

> +
> +	ch->rx_count = tp->num_rx_rings;
> +	ch->tx_count = 1;
> +	ch->other_count = 0;
> +	ch->combined_count = 0;
> +}
> +
> +static int rtl8169_realloc_rx(struct rtl8169_private *tp,
> +			      struct rtl8169_rx_ring *new_rx,
> +			      int new_count)
> +{
> +	int i, ret;
> +
> +	for (i = 0; i < new_count; i++) {
> +		struct rtl8169_rx_ring *ring = &new_rx[i];
> +
> +		ring->rx_desc_array = dma_alloc_coherent(&tp->pci_dev->dev,
> +							 R8169_RX_RING_BYTES,
> +							 &ring->rx_phy_addr,
> +							 GFP_KERNEL);
> +		if (!ring->rx_desc_array) {
> +			ret = -ENOMEM;
> +			goto err_free;
> +		}
> +
> +		memset(ring->rx_databuff, 0, sizeof(ring->rx_databuff));
> +		ret = rtl8169_rx_fill(tp, ring);
> +		if (ret) {
> +			dma_free_coherent(&tp->pci_dev->dev, R8169_RX_RING_BYTES,
> +					  ring->rx_desc_array, ring->rx_phy_addr);
> +			goto err_free;
> +		}
> +	}
> +	return 0;
> +
> +err_free:
> +	while (--i >= 0) {
> +		rtl8169_rx_clear(tp, &new_rx[i]);
> +		dma_free_coherent(&tp->pci_dev->dev, R8169_RX_RING_BYTES,
> +				  new_rx[i].rx_desc_array, new_rx[i].rx_phy_addr);
> +	}
> +	return ret;
> +}
> +
> +static int rtl8169_set_channels(struct net_device *dev,
> +				struct ethtool_channels *ch)
> +{
> +	struct rtl8169_private *tp = netdev_priv(dev);
> +	bool if_running = netif_running(dev);
> +	struct rtl8169_rx_ring *new_rx;
> +	u8 old_tx_desc_type = tp->init_rx_desc_type;
> +	u8 new_desc_type;
> +	bool new_rss_enable;
> +	int i, ret;
> +
> +	if (!tp->rss_support && (ch->rx_count > 1 || ch->tx_count > 1)) {
> +		netdev_warn(dev, "This chip does not support multiple channels/RSS.\n");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!(tp->features & RTL_VEC_MAP_ENABLE))
> +		return -EINVAL;
> +
> +	new_rss_enable = (ch->rx_count > 1 && tp->rss_support);
> +	new_desc_type = new_rss_enable ? RX_DESC_RING_TYPE_RSS : RX_DESC_RING_TYPE_DEFAULT;
> +	tp->init_rx_desc_type = new_desc_type;
> +
> +	if (!if_running) {
> +		tp->num_rx_rings = ch->rx_count;
> +		tp->rss_enable = new_rss_enable;
> +		return 0;
> +	}
> +
> +	new_rx = kcalloc(R8169_MAX_RX_QUEUES, sizeof(*new_rx), GFP_KERNEL);

Better use the new _obj allocators, like kzalloc_objs here.

> +	if (!new_rx)
> +		return -ENOMEM;
> +
> +	ret = rtl8169_realloc_rx(tp, new_rx, ch->rx_count);
> +	if (ret) {
> +		kfree(new_rx);
> +		tp->init_rx_desc_type = old_tx_desc_type;
> +		return ret;
> +	}
> +
> +	netif_stop_queue(dev);
> +	rtl8169_down(tp);
> +
> +	for (i = 0; i < tp->num_rx_rings; i++)
> +		rtl8169_rx_clear(tp, &tp->rx_ring[i]);
> +	rtl8169_free_rx_desc(tp);
> +
> +	tp->num_rx_rings = ch->rx_count;
> +	tp->rss_enable = new_rss_enable;
> +
> +	memset(tp->rx_ring, 0, sizeof(tp->rx_ring));
> +	memcpy(tp->rx_ring, new_rx, sizeof(*new_rx) * ch->rx_count);
> +
> +	for (i = 0; i < tp->rss_data->hw_supp_indir_tbl_entries; i++) {
> +		if (tp->rss_enable)
> +			tp->rss_data->rss_indir_tbl[i] =
> +				ethtool_rxfh_indir_default(i, tp->num_rx_rings);
> +		else
> +			tp->rss_data->rss_indir_tbl[i] = 0;
> +	}
> +
> +	rtl_set_irq_mask(tp);
> +
> +	rtl8169_up(tp);
> +	netif_start_queue(dev);
> +
> +	kfree(new_rx);
> +
> +	return 0;
> +}
> +
>  static const struct ethtool_ops rtl8169_ethtool_ops = {
>  	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
>  				     ETHTOOL_COALESCE_MAX_FRAMES,
> @@ -6287,6 +6411,8 @@ static const struct ethtool_ops rtl8169_ethtool_ops = {
>  	.nway_reset		= phy_ethtool_nway_reset,
>  	.get_eee		= rtl8169_get_eee,
>  	.set_eee		= rtl8169_set_eee,
> +	.get_channels		= rtl8169_get_channels,
> +	.set_channels		= rtl8169_set_channels,
>  	.get_link_ksettings	= phy_ethtool_get_link_ksettings,
>  	.set_link_ksettings	= rtl8169_set_link_ksettings,
>  	.get_ringparam		= rtl8169_get_ringparam,


