Return-Path: <netdev+bounces-167044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C907A387E9
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 16:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B9A3B0AE3
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF062253E3;
	Mon, 17 Feb 2025 15:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8yIdhF7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F34224AF9;
	Mon, 17 Feb 2025 15:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739806834; cv=none; b=jyrY6AW20dc6VcJO/Kcjcgpv7Pg4+n+3iWwLUwbBf2m8o0mDeZiOKGV8c3gd/cr4KwdVPnZKkJRvYLKIYELd8hB6pMVHda1GLo6RRXcgyXIa8aWdkiBHFg0fiESZ6jts/5yahUfv2+SORzoOQZxhyp8+kwN4p0EwhjWebGajnEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739806834; c=relaxed/simple;
	bh=Xy3shhobRgfXOO0gcUvi6Q58ojxHN3hZzhyPOJq5uwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hs3G6I7o2gxJhCXsTyAPVDSicN6JW/qU0BVoy4SAfpNeweEyINv+ERLHudwYW+ia9yWfnBjBvXlG0/yYnNOoTWGFThx0JrWTbT3M8DF+GIgGigeIpqFvOnNjnKO7661k8LUgnSZDmU1/qnnAl5FPxLTAVGMO9BjA/o6ByMZIj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8yIdhF7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73E2C4CED1;
	Mon, 17 Feb 2025 15:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739806834;
	bh=Xy3shhobRgfXOO0gcUvi6Q58ojxHN3hZzhyPOJq5uwY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8yIdhF74bOEhqirSfBNy8zhuEjIjNVbMYoFkBGoT+ASgpLuGQaYuwwqrMbH6l1os
	 1aYxp5U3HCMYU2X5AXWxppScyE3DtJ10/YM1zUM2GD9HYX3znrjOj5Q1dkZUmDHDDS
	 FOm7VoQCiAjXpMxno43YGHS0qBeyxCFqoPRcgt4D5qgYjTMtU/Zn728mUuVfSaKmuJ
	 XeIPeqsSnqkuuUE/A3xPy84ZEnNVn+t821TufyYfRk2ycY2YuMeDB/0ghQeWlFKcqo
	 REZ3ogFby/kp2BSmmxSgDzDS87JLJO4ulzA0ERLbXJjc0j2Qn7qvQI4MZnv9/qh0lP
	 xbFm4YqY2RQHQ==
Date: Mon, 17 Feb 2025 15:40:28 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, sudongming1@huawei.com,
	xujunsheng@huawei.com, shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/7] net: hibmcge: Add rx checksum offload
 supported in this module
Message-ID: <20250217154028.GM1615191@kernel.org>
References: <20250213035529.2402283-1-shaojijie@huawei.com>
 <20250213035529.2402283-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250213035529.2402283-4-shaojijie@huawei.com>

On Thu, Feb 13, 2025 at 11:55:25AM +0800, Jijie Shao wrote:
> This patch implements the rx checksum offload feature
> including NETIF_F_IP_CSUM NETIF_F_IPV6_CSUM and NETIF_F_RXCSUM
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

...

> diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
> index 8c631a9bcb6b..aa1d128a863b 100644
> --- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
> +++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_txrx.c
> @@ -202,8 +202,11 @@ static int hbg_napi_tx_recycle(struct napi_struct *napi, int budget)
>  }
>  
>  static bool hbg_rx_check_l3l4_error(struct hbg_priv *priv,
> -				    struct hbg_rx_desc *desc)
> +				    struct hbg_rx_desc *desc,
> +				    struct sk_buff *skb)
>  {
> +	bool rx_checksum_offload = priv->netdev->features & NETIF_F_RXCSUM;

nit: I think this would be better expressed in a way that
     rx_checksum_offload is assigned a boolean value (completely untested).

	bool rx_checksum_offload = !!(priv->netdev->features & NETIF_F_RXCSUM);

> +
>  	if (likely(!FIELD_GET(HBG_RX_DESC_W4_L3_ERR_CODE_M, desc->word4) &&
>  		   !FIELD_GET(HBG_RX_DESC_W4_L4_ERR_CODE_M, desc->word4)))
>  		return true;

