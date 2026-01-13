Return-Path: <netdev+bounces-249282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71236D167CA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 04:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E991302FA1D
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 03:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DF3327210;
	Tue, 13 Jan 2026 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLJFoH13"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6596E324B17
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 03:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768274894; cv=none; b=h/kr8Vyo/gj7PtxY2+0gqJvqv+uGlf5m7mduH7jI4iSL02Q4PoheOPjVQ2HuUclLFGRbTJ6+jMliJADg6XFW8H+570vFM+h7x2rC1GRhK6GphCyDFXydOIz17aKxNnckxofMNJUxgwpjERcdC97cgZdp3nfS+3PEslOCWXT+bF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768274894; c=relaxed/simple;
	bh=W/He71vHBFDRw7h+/ifMRWBk1Qhj09bEoNkPRU2XnJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K95JXLHFGxRNezYMVJxLrip1s2WVVr9RzEVWeZBJk7QwEqgl5QDAeYBH2Om4s6xRA0VHjfdXW2C5N5bQnshSpM5TxEhh72xO0lwZoLsSA6TCerPIZvBGfqwO+uvVZ5UNQNHxBNIDi/+gNa+eXRDJEnm9j8j3WuxhoWXhd5BbyAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLJFoH13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A9AC116D0;
	Tue, 13 Jan 2026 03:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768274893;
	bh=W/He71vHBFDRw7h+/ifMRWBk1Qhj09bEoNkPRU2XnJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FLJFoH13W2Do+wmS/NDIZPGkUz5nWPI2fcWeNM1pOf09fWboRuJUA3GMrIehHS41x
	 I5H5kJakUBpQ61LVF0YFP3HRy+BKbK1k097aSiynfEMXTK/3Pd+6xFt/+Pl0Eafddf
	 TXmtL3WbGmdFHIY62crmY0u1Xn+U1WayTwyq7ETnaFfrIbEt/lKoHlVKoNooLD8B9y
	 kqoKLVROJtGduBUN7ggQo1Kmz/QmwkRhAcWuocz8EnSfJACo4ZyMSIqeXhk/GOKb1o
	 F1egEbVHnGNLhKtvdnvWSDRtf/qiCRnfCV2UrM5yBPZ5dnX8/C1dWPgT10jSGW/pKc
	 9x8ISL+WVCR1w==
Date: Mon, 12 Jan 2026 19:28:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
 <davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Thomas.Lendacky@amd.com>,
 <Shyam-sundar.S-k@amd.com>
Subject: Re: [PATCH net] amd-xgbe: avoid misleading per-packet error log
Message-ID: <20260112192812.5b0aad55@kernel.org>
In-Reply-To: <20260110170422.3996690-1-Raju.Rangoju@amd.com>
References: <20260110170422.3996690-1-Raju.Rangoju@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Jan 2026 22:34:22 +0530 Raju Rangoju wrote:
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> index 0d19b09497a0..c8797a338542 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
> @@ -75,6 +75,8 @@ static const struct xgbe_stats xgbe_gstring_stats[] = {
>  	XGMAC_MMC_STAT("rx_pause_frames", rxpauseframes),
>  	XGMAC_EXT_STAT("rx_split_header_packets", rx_split_header_packets),
>  	XGMAC_EXT_STAT("rx_buffer_unavailable", rx_buffer_unavailable),
> +	XGMAC_EXT_STAT("rx_buffer_overflow", rx_buffer_overflow),

"rx_buffer_overflow" sounds like something that should be categorized
to one of the struct rtnl_link_stats64 stats. See the kdoc in if_link.h

> +	XGMAC_EXT_STAT("rx_pkt_errors", rx_pkt_errors),

Are these counted to standard rx_errors somewhere?
-- 
pw-bot: cr

