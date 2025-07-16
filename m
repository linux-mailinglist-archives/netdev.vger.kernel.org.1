Return-Path: <netdev+bounces-207320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE76B06A57
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E564E4200
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D7410F1;
	Wed, 16 Jul 2025 00:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DeYwpnxV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F5210E4
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624894; cv=none; b=sVocAp5cpTH1VNLUAl0FEye0YewcTiBldtGiRx3UILHC5d4/rIotIobrKswLbGy9ST+kZqnmuNDgietvvnkgqyQEBQ2aZ7EGQ+QLPp/99TKaSv0L8zphgHeYuOb5PpQjGK+sx+gILlQMfl7T6h467wEzdaGxeEyLZdwFRJiavDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624894; c=relaxed/simple;
	bh=TVlTYrup1SQLajCh4QGBTD5RZHUhR32Zoq3jQCUQRBY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIJ8+DZZ7nrZrufYcOtIsW64lBMlgq3KtE5180icBYcx6qXOLlfV8Lt1+hOGTBA4jyUnVNXCSfbEeQeBrY7d3uHk/fcB69+scrjEPmdXZ04/XgCVlQ77mqFAh80wNFpydJUEEVfhIvyZwatT9W/oWlw7r83hPtgdXEVP60/pURM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DeYwpnxV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45B24C4CEE3;
	Wed, 16 Jul 2025 00:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752624893;
	bh=TVlTYrup1SQLajCh4QGBTD5RZHUhR32Zoq3jQCUQRBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DeYwpnxVpf5qM2ui5Bu7UkYkOtQVYAYF1El4KzjO2Jdrixr+XH9p4H356m1kasdQi
	 qY6w+DLIkNWWMNEf4seYNiWjP2rZgXSoZJyuCCZm1kWnjWVFrDyTgIR3WFD5a8xCXB
	 drRrE6C6ubuqLFE8CRnaHs9KR2w/S8go5+wDGWW3D1OdvXQRvzdga3o/2e6r0d+BPG
	 snoP6cV8gnrFGT5rWKZi+WQdVvP3aC2WEwOjEg68HsgX3ecpJLMEIOV0OJXqEccktX
	 Xb1HW+/lVMsZ1oYiLqQ5gLtvORJzGMhBQ39tgWT/E2n5XsYoZ9OmD2Augajmt6RZ/0
	 TVzHK+0TOGZbA==
Date: Tue, 15 Jul 2025 17:14:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mingming Cao <mmc@linux.ibm.com>
Cc: netdev@vger.kernel.org, horms@kernel.org, bjking1@linux.ibm.com,
 haren@linux.ibm.com, ricklind@linux.ibm.com, davemarq@linux.ibm.com
Subject: Re: [PATCH v3 net-next 1/2] ibmvnic: Use atomic64_t for queue stats
Message-ID: <20250715171452.193ac348@kernel.org>
In-Reply-To: <20250714173507.73096-2-mmc@linux.ibm.com>
References: <20250714173507.73096-1-mmc@linux.ibm.com>
	<20250714173507.73096-2-mmc@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 13:35:06 -0400 Mingming Cao wrote:
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 92647e137cf8..79fdba4293a4 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -2314,9 +2314,17 @@ static void ibmvnic_tx_scrq_clean_buffer(struct ibmvnic_adapter *adapter,
>  		tx_buff = &tx_pool->tx_buff[index];
>  		adapter->netdev->stats.tx_packets--;
>  		adapter->netdev->stats.tx_bytes -= tx_buff->skb->len;
> -		adapter->tx_stats_buffers[queue_num].batched_packets--;
> -		adapter->tx_stats_buffers[queue_num].bytes -=
> -						tx_buff->skb->len;
> +		atomic64_dec(&adapter->tx_stats_buffers[queue_num].batched_packets);
> +		if (atomic64_sub_return(tx_buff->skb->len,
> +					&adapter->tx_stats_buffers[queue_num].bytes) < 0) {
> +			atomic64_set(&adapter->tx_stats_buffers[queue_num].bytes, 0);
> +			netdev_warn(adapter->netdev,

Any datapath print needs to be rate limited, otherwise it may flood
the logs.

> +				    "TX stats underflow on queue %u: bytes (%lld) < skb->len (%u),\n"
> +				    "clamping to 0\n",
> +				    queue_num,
> +				    atomic64_read(&adapter->tx_stats_buffers[queue_num].bytes),
> +				    tx_buff->skb->len);
> +		}
>  		dev_kfree_skb_any(tx_buff->skb);
>  		tx_buff->skb = NULL;
>  		adapter->netdev->stats.tx_dropped++;
> @@ -2652,10 +2660,10 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
>  	netdev->stats.tx_packets += tx_bpackets + tx_dpackets;
>  	adapter->tx_send_failed += tx_send_failed;
>  	adapter->tx_map_failed += tx_map_failed;
> -	adapter->tx_stats_buffers[queue_num].batched_packets += tx_bpackets;
> -	adapter->tx_stats_buffers[queue_num].direct_packets += tx_dpackets;
> -	adapter->tx_stats_buffers[queue_num].bytes += tx_bytes;
> -	adapter->tx_stats_buffers[queue_num].dropped_packets += tx_dropped;
> +	atomic64_add(tx_bpackets, &adapter->tx_stats_buffers[queue_num].batched_packets);
> +	atomic64_add(tx_dpackets, &adapter->tx_stats_buffers[queue_num].direct_packets);
> +	atomic64_add(tx_bytes, &adapter->tx_stats_buffers[queue_num].bytes);
> +	atomic64_add(tx_dropped, &adapter->tx_stats_buffers[queue_num].dropped_packets);

Are atomics really cheap on your platform? Normally having these many
atomic ops per packet would bring performance concerns.
I assume queue accesses are already protected by some sort of a lock
so isn't it enough to make the stats per queue without making them
atomic?
-- 
pw-bot: cr

