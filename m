Return-Path: <netdev+bounces-243294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id ED297C9CA7C
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 19:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E2C5D345867
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 18:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B7028C00C;
	Tue,  2 Dec 2025 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWPr7HSq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D6A28506B
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 18:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764700494; cv=none; b=c9RHslH5v8WAZRwUU45Q4KKz4hunjO6968HoaSZUeIZh7BNx+X16gjydZoQgjxrCRQH0aYXGsOIBPZNU/eNIALVhTfkql9gQy3RIkwAMfx3VZrs7HaFi/5jU9dDP12k7gzUOufsPLB1HE7jq3U6l6zwhDXJWplPUcDL2BQ+Dq+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764700494; c=relaxed/simple;
	bh=Cu6psR00lGqDPUq9cuj2S9rijvgdPxkKstnZaesz5SM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPv+anEBw2s0o8iL/XWlyLH9UEyrNvWifAbbaW8WGPmdo4IRjSz01sHEcfczEA6RWy31b5PWh3wqWrrQhnZ+XMKjtIP9C2rAFgtWsmj1YpiCQszou3OCBbMPZsVxPyiwnRWHRrnJwBYvup1uSivj/EEeMma36avMCCwijdaX0Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWPr7HSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B28C4CEF1;
	Tue,  2 Dec 2025 18:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764700494;
	bh=Cu6psR00lGqDPUq9cuj2S9rijvgdPxkKstnZaesz5SM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YWPr7HSqlXslcAroHEVvdFJme2us/ctcCU+grKqfbvrZ+U9wGbwILna8HFMawLom/
	 qjesvq7unUgojXZXN/dZGr2KPSBx7FtJTX9iOdnrS0OdTQj6tb6ScxVr3qIdGQOqdM
	 CzNOJ9FY4GhEWL+iNEEINFEqwFiCqMUApkpugMau6ZbWuPDTIfJPhZnWt7TfIlXjig
	 V4H5grinH/K3oBuCPWqIADjiz13w+1anVhG3DNUnrz9Qvc9Z5IrG/J+y1t654YZnrI
	 DqcVHhY1w2p69c6Euw0IUKKTsXodz4O4DaAsGe8kiRUvgO+SYMv4lLtBcCKymp9wrm
	 TtM4OLx09R6Uw==
Date: Tue, 2 Dec 2025 10:34:52 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: 2694439648@qq.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 hailong.fan@siengine.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, inux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: stmmac: Modify the judgment condition of
 "tx_avail" from 1 to 2
Message-ID: <20251202103452.0d2df13d@kernel.org>
In-Reply-To: <tencent_4A0CBC92B9B22C699AC2890E139565FCB306@qq.com>
References: <tencent_4A0CBC92B9B22C699AC2890E139565FCB306@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Dec 2025 15:43:59 +0800 2694439648@qq.com wrote:
> From: "hailong.fan" <hailong.fan@siengine.com>
> 
>     Under certain conditions, a WARN_ON will be triggered
>     if avail equals 1.
> 
>     For example, when a VLAN packet is to send,
>     stmmac_vlan_insert consumes one unit of space,
>     and the data itself consumes another.
>     actually requiring 2 units of space in total.
> 
>     ---
>     V0-V1:
>        1. Stop their queues earlier
>     V2-V1:
>        1. add fixes tag
>        2. Add stmmac_extra_space to count the additional required space

Why is the commit message indented ? Please looks around the mailing
list and try to follow the format others are using. Or read the
documentation. Either of the two will do.
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#changes-requested

> Fixes: 30d932279dc2 ("net: stmmac: Add support for VLAN Insertion Offload")
> Signed-off-by: hailong.fan <hailong.fan@siengine.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 7b90ecd3a..9a665a3b2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4476,6 +4476,15 @@ static bool stmmac_has_ip_ethertype(struct sk_buff *skb)
>  		(proto == htons(ETH_P_IP) || proto == htons(ETH_P_IPV6));
>  }
>  
> +static inline int stmmac_extra_space(struct stmmac_priv *priv,
> +				     struct sk_buff *skb)
> +{
> +	if (!priv->dma_cap.vlins || !skb_vlan_tag_present(skb))
> +		return 0;
> +
> +	return 1;
> +}
> +
>  /**
>   *  stmmac_xmit - Tx entry point of the driver
>   *  @skb : the socket buffer
> @@ -4529,7 +4538,8 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  		}
>  	}
>  
> -	if (unlikely(stmmac_tx_avail(priv, queue) < nfrags + 1)) {
> +	if (unlikely(stmmac_tx_avail(priv, queue) <
> +		nfrags + 1 + stmmac_extra_space(priv, skb))) {

extra logic is likely not worth the single descriptor saving, can you
use the same + 2 as in the condition for stopping the queue, please?

>  		if (!netif_tx_queue_stopped(netdev_get_tx_queue(dev, queue))) {
>  			netif_tx_stop_queue(netdev_get_tx_queue(priv->dev,
>  								queue));
> @@ -4675,7 +4685,7 @@ static netdev_tx_t stmmac_xmit(struct sk_buff *skb, struct net_device *dev)
>  		print_pkt(skb->data, skb->len);
>  	}
>  
> -	if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 1))) {
> +	if (unlikely(stmmac_tx_avail(priv, queue) <= (MAX_SKB_FRAGS + 2))) {

