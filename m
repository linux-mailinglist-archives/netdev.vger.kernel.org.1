Return-Path: <netdev+bounces-230947-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBC4BF2345
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 17:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 21B184E4449
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 15:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D93274FFE;
	Mon, 20 Oct 2025 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBXmj6EO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D8E244669
	for <netdev@vger.kernel.org>; Mon, 20 Oct 2025 15:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760975334; cv=none; b=KeQgu66v7BTWNGNE0PCelRdAZq98KqVDzOwGTV8QsBieEBA9loeGYCmXnpUMr+Vn1xg8UgjB4ZwO5wiK3/7XOw9PbvVNdJZJrjbD9DsxhiL+xHfW9qYKVQfcny2NkQIXpG0TPdPVDhTU9cxCdfDrKyMvNrjJq1vCd1Qqy4zYKPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760975334; c=relaxed/simple;
	bh=mcpkDt4yyfppXtm3PZXAu5VXFtbjJKkj7KKMhEpAAj0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJ+Z166+bJ16I0tSwE/pUVdinNFCG1hmmMtX/6IqxL7CsECdJygFma5vmLzEAkpcuJ6dOkpsaiL1PpQZh2lxj7tbmaq4F6KIRY0yIEefbdpPLD1cL7IQfUcQC03R/bKXDaE96j4wR7z9dzXwUNKhGTAeNRCJz58qQOukHfF2wac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBXmj6EO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F363FC4CEF9;
	Mon, 20 Oct 2025 15:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760975334;
	bh=mcpkDt4yyfppXtm3PZXAu5VXFtbjJKkj7KKMhEpAAj0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uBXmj6EO1hsKCNeIMp01qgt4h+l8krsDIZa0Ajor+Z2Kv2Aafdlj05Ttr+sSaCIrT
	 w/yoT7qc9HqhTPG+whPOKnbqswsC3wQqgsLtDi7cEMswr4EStxnNPx1FqNl9h2XPjO
	 4HQK3Atv72/LGn+XpWN9WVYmL52gMeY9Mg1fnetrpgZTM3WckOoRnzu1ITeVSc3Xg6
	 ROwS+BjRUVHWp5CsKDsmsRKVvEQHLHYRZNQUKjP5bDPiHx5FgHeA73xPzsI8bhDoaD
	 bRngT9588sIMvHNMZ3IW9Y/0mKsc2grndCpqwmefQooI4Bk/Lpj3TUxq9/MYb7XRlO
	 ezGu/XBBsnx5Q==
Date: Mon, 20 Oct 2025 08:48:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Mengyuan Lou
 <mengyuanlou@net-swift.com>
Subject: Re: [PATCH net-next 2/3] net: txgbe: support TX head write-back
 mode
Message-ID: <20251020084852.1a26a330@kernel.org>
In-Reply-To: <20251020082609.6724-3-jiawenwu@trustnetic.com>
References: <20251020082609.6724-1-jiawenwu@trustnetic.com>
	<20251020082609.6724-3-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Oct 2025 16:26:08 +0800 Jiawen Wu wrote:
> +	tx_ring->headwb_mem = dma_alloc_coherent(tx_ring->dev,
> +						 sizeof(u32),
> +						 &tx_ring->headwb_dma,
> +						 GFP_KERNEL);
> +	if (!tx_ring->headwb_mem) {
> +		dev_info(tx_ring->dev, "Allocate headwb memory failed, disable it\n");
> +		return;
> +	}
> +
> +	memset(tx_ring->headwb_mem, 0, sizeof(u32));

drivers/net/ethernet/wangxun/libwx/wx_lib.c:2932:23-41: WARNING: dma_alloc_coherent used in tx_ring -> headwb_mem already zeroes out memory, so memset is not needed
-- 
pw-bot: cr

