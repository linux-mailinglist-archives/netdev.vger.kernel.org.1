Return-Path: <netdev+bounces-33538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5AE79E6BD
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 13:29:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 340752828BA
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078E71E537;
	Wed, 13 Sep 2023 11:29:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B784E1E530
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 11:29:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE689C433C7;
	Wed, 13 Sep 2023 11:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694604575;
	bh=88nEUax8u6kdvh9kiAW5sEKDYzPF0xZL7tjnJ+l2y4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OAqltYxtm8qUWi/ua5tmt8XqqkZARwO20XiKAGc/W6c5QJqwMzsTd7qpU4zC9OxKq
	 n4TfMea2gwG3l8kjrhu1LwhMq/wtgfiSfqLMY14XtdMAE8CiYQ2+AhZobub9hh2MkX
	 l4ZznQSP02854MS+OjvSMCddY8v28ZNmbqumqzz0XzY0Wx6gWKErtxut4O/aBBxkW9
	 COSbbtSY/BcwojMDixmphXKXE8c+2th/hM6Y0jNWCIxP8P9IwLFSdjk5yW5+OQatol
	 Pip+tgKxcu/qfY6s9DcVBLt9z+DBIgxG/X54SrS3ZRWD9rdnzYFPncpK7TmFxf9cuc
	 Zvh/IdQycAYlg==
Date: Wed, 13 Sep 2023 13:29:29 +0200
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
	john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: check
 update_wo_rx_stats in mtk_wed_update_rx_stats()
Message-ID: <20230913112929.GS401982@kernel.org>
References: <b0d233386e059bccb59f18f69afb79a7806e5ded.1694507226.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0d233386e059bccb59f18f69afb79a7806e5ded.1694507226.git.lorenzo@kernel.org>

On Tue, Sep 12, 2023 at 10:28:00AM +0200, Lorenzo Bianconi wrote:
> Check if update_wo_rx_stats function pointer is properly set in
> mtk_wed_update_rx_stats routine before accessing it.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Hi Lorenzo,

I'm a little curious about this.

Is there a condition where it is not set but accessed,
which would presumably be a bug that warrants a fixes tag and
targeting at 'net'?

Or can it not occur, in which case this check is perhaps not needed?

Or something else?

> ---
>  drivers/net/ethernet/mediatek/mtk_wed_mcu.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
> index 071ed3dea860..72bcdaed12a9 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed_mcu.c
> @@ -68,6 +68,9 @@ mtk_wed_update_rx_stats(struct mtk_wed_device *wed, struct sk_buff *skb)
>  	struct mtk_wed_wo_rx_stats *stats;
>  	int i;
>  
> +	if (!wed->wlan.update_wo_rx_stats)
> +		return;
> +
>  	if (count * sizeof(*stats) > skb->len - sizeof(u32))
>  		return;
>  
> -- 
> 2.41.0
> 
> 

