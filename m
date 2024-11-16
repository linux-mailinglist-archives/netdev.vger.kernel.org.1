Return-Path: <netdev+bounces-145543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 504689CFC6D
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 04:00:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161FE288D84
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 03:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E530918C004;
	Sat, 16 Nov 2024 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoirdFIw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6541158218;
	Sat, 16 Nov 2024 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731726035; cv=none; b=t+pc1jTpP4B1SEWRzEyKMI5vsQvC+eGGjYF5NoeRmklV+SOjKBx7G1oHz6YduGrbLiv1sJQNyAVSqCZveI2H/AK6jsF8hfUYix/ipAiaiAZiM+IWY9j/T46K7nyBUO+aEYLJtBqGAjfd55+I8ayTDPCHSIMUhbXS9olL+GNS4Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731726035; c=relaxed/simple;
	bh=CVhcmjlJVAT/9QDdLdPQPRfwrgG97KWHWW1vpQQD5NY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YY5qdMMrf4pr10SnZoFj5eoRnji9h86w8UKAx7YjvZ6mQV7nBAQ6f/+8wcE4s9URdF58Q15bAtAaBDFCacdNqiE9X/MavxEsCzdlDb+TMcvU8pIVP3fVhThDIgShqQJCSpDEM5w999aDqY7/fxZoz6kDsOGCX0MJxZ1A6PlloZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoirdFIw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAFB2C4CECF;
	Sat, 16 Nov 2024 03:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731726035;
	bh=CVhcmjlJVAT/9QDdLdPQPRfwrgG97KWHWW1vpQQD5NY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SoirdFIwhJduTEXvAB4KIEvQjyOFGqMqgcEb7U0fLVmOhm5u5QCxO1OQPzESfEKws
	 qHKMx4z8qQXdtvrveLzDb8YgCIdl60pnxnchGILAKVGVqniJaxBW3w0I/3mb3TX3GZ
	 nEuUFFOfpXgKlfpw/VOFQoAEQxobalznTx7bTEWdf9dXGUzeaOD0+BaUWWRMF8vwpI
	 7Pu162a644EuizdKnJXlNwwbpMOBLGDWcuHJPisf13epcekT8Xw6WEOcG9Yp4rbKV7
	 pB1HItzOIhMdMSv/vVyCDbmMiQ41kaSuXlEyzuZDZKEIfhY7vEeQq6SoL4GRditpBP
	 t+Vb8moENHR9Q==
Date: Fri, 15 Nov 2024 19:00:33 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: claudiu.manoil@nxp.com, vladimir.oltean@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, frank.li@nxp.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev
Subject: Re: [PATCH v4 net-next 2/5] net: enetc: add Tx checksum offload for
 i.MX95 ENETC
Message-ID: <20241115190033.7452392e@kernel.org>
In-Reply-To: <20241115024744.1903377-3-wei.fang@nxp.com>
References: <20241115024744.1903377-1-wei.fang@nxp.com>
	<20241115024744.1903377-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Nov 2024 10:47:41 +0800 Wei Fang wrote:
> +static inline bool enetc_skb_is_ipv6(struct sk_buff *skb)
> +{
> +	return vlan_get_protocol(skb) == htons(ETH_P_IPV6);
> +}
> +
> +static inline bool enetc_skb_is_tcp(struct sk_buff *skb)
> +{
> +	return skb->csum_offset == offsetof(struct tcphdr, check);
> +}

Please don't use "inline" for trivial functions, compiler will inline
them anyway, and it hides unused code. In addition to being pointless.

>  static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  {
>  	bool do_vlan, do_onestep_tstamp = false, do_twostep_tstamp = false;
> @@ -160,6 +181,27 @@ static int enetc_map_tx_buffs(struct enetc_bdr *tx_ring, struct sk_buff *skb)
>  	dma_addr_t dma;
>  	u8 flags = 0;
>  
> +	enetc_clear_tx_bd(&temp_bd);
> +	if (skb->ip_summed == CHECKSUM_PARTIAL) {
> +		/* Can not support TSD and checksum offload at the same time */
> +		if (priv->active_offloads & ENETC_F_TXCSUM &&
> +		    enetc_tx_csum_offload_check(skb) && !tx_ring->tsd_enable) {
> +			temp_bd.l3_start = skb_network_offset(skb);
> +			temp_bd.ipcs = enetc_skb_is_ipv6(skb) ? 0 : 1;

Linux calculates the IPv4 csum, always, no need.

> +			temp_bd.l3_hdr_size = skb_network_header_len(skb) / 4;
> +			temp_bd.l3t = enetc_skb_is_ipv6(skb) ? 1 : 0;

no need for ternary op, simply :

		temp_bd.l3t = enetc_skb_is_ipv6(skb);

> +			temp_bd.l4t = enetc_skb_is_tcp(skb) ? ENETC_TXBD_L4T_TCP :
> +							      ENETC_TXBD_L4T_UDP;
> +			flags |= ENETC_TXBD_FLAGS_CSUM_LSO | ENETC_TXBD_FLAGS_L4CS;
> +		} else {
> +			if (skb_checksum_help(skb)) {
> +				dev_err(tx_ring->dev, "skb_checksum_help() error\n");
> +
> +				return 0;

don't print errors on the datapath, it may flood the logs
-- 
pw-bot: cr

