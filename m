Return-Path: <netdev+bounces-133251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FA799564E
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C9B283315
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27292212652;
	Tue,  8 Oct 2024 18:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DS2Vm7Xx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC2A620B20;
	Tue,  8 Oct 2024 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411569; cv=none; b=NKfzq61d7cBJ1As3oZFzmbIA84/ugio0fYvSXAFm0IICL54XxVLh/V/KNFAKWCdbfm9dIdjJq7RIiDB90PJmPGCzbaT8lAyDz55Ye1OzeESIPRQ70cWKfRsp92eIauCJF8rvUo/PZyxaTy/hwOje7riifRJu4SYDS1yYdacRsq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411569; c=relaxed/simple;
	bh=ByxbPWhI8UOclhnkIzO18lHVlE7wgBDRt5E/FoeWnxU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=muyghzFBxfj+T2fwxvbYPFC8quVgZklA4aXa4nkchnofR1ECEmmhOdvzoxRt8sQV3vQldQ4Z6PW4caIfg8o9mbnjpzOaqPiaKGHXmUB+tdPuwyY2Vgg0QOPWPAnu9hQMiVsY2+09iyAOOaMfxvuuS3rzmXcIeAnyiqWjGUeylMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DS2Vm7Xx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02287C4CECE;
	Tue,  8 Oct 2024 18:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728411568;
	bh=ByxbPWhI8UOclhnkIzO18lHVlE7wgBDRt5E/FoeWnxU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DS2Vm7Xx0/JkkKhLFi3/GjxAMdv9pllBXvlQkh9VAcRTPlSUpeUSBCeLSvo6ay1ba
	 vROdWEt/GqyKXTp9xNEC1A8paIsY09XYD58ZJQDP7cYhiRXw0TwacUm/IXeFyQeRop
	 rHMpNjY5dhhKKp5uL5jPM+oBPy3RggD38l9HjUyJzcM62QE/OMwlOl4oep5zC2dOgG
	 WwRPLmDXs6mSL1CuQMUFkJSLGpLnS++enHLzsAOgPuYU1T3YUcgK2+FvKdSgTTjzlE
	 UxjAu/dVWBccCQoq4IhH247j3uJq++Z/rQbvWx6x67PUzK2uUBw0snz7iIFWFVdo8Q
	 hY9VFprZmfbAA==
Date: Tue, 8 Oct 2024 11:19:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 almasrymina@google.com, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 donald.hunter@gmail.com, corbet@lwn.net, michael.chan@broadcom.com,
 kory.maincent@bootlin.com, andrew@lunn.ch, maxime.chevallier@bootlin.com,
 danieller@nvidia.com, hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 asml.silence@gmail.com, kaiyuanz@google.com, willemb@google.com,
 aleksander.lobakin@intel.com, dw@davidwei.uk, sridhar.samudrala@intel.com,
 bcreeley@amd.com
Subject: Re: [PATCH net-next v3 2/7] bnxt_en: add support for tcp-data-split
 ethtool command
Message-ID: <20241008111926.7056cc93@kernel.org>
In-Reply-To: <20241003160620.1521626-3-ap420073@gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
	<20241003160620.1521626-3-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Oct 2024 16:06:15 +0000 Taehee Yoo wrote:
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> index fdecdf8894b3..e9ef65dd2e7b 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
> @@ -829,12 +829,16 @@ static void bnxt_get_ringparam(struct net_device *dev,
>  	if (bp->flags & BNXT_FLAG_AGG_RINGS) {
>  		ering->rx_max_pending = BNXT_MAX_RX_DESC_CNT_JUM_ENA;
>  		ering->rx_jumbo_max_pending = BNXT_MAX_RX_JUM_DESC_CNT;
> -		kernel_ering->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
>  	} else {
>  		ering->rx_max_pending = BNXT_MAX_RX_DESC_CNT;
>  		ering->rx_jumbo_max_pending = 0;
> -		kernel_ering->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_DISABLED;
>  	}
> +
> +	if (bp->flags & BNXT_FLAG_HDS)
> +		kernel_ering->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
> +	else
> +		kernel_ering->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_DISABLED;

This breaks previous behavior. The HDS reporting from get was
introduced to signal to user space whether the page flip based
TCP zero-copy (the one added some years ago not the recent one)
will be usable with this NIC.

When HW-GRO is enabled HDS will be working.

I think that the driver should only track if the user has set the value
to ENABLED (forced HDS), or to UKNOWN (driver default). Setting the HDS
to disabled is not useful, don't support it.

>  	ering->tx_max_pending = BNXT_MAX_TX_DESC_CNT;
>  
>  	ering->rx_pending = bp->rx_ring_size;
> @@ -854,9 +858,25 @@ static int bnxt_set_ringparam(struct net_device *dev,
>  	    (ering->tx_pending < BNXT_MIN_TX_DESC_CNT))
>  		return -EINVAL;
>  
> +	if (kernel_ering->tcp_data_split != ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
> +	    BNXT_RX_PAGE_MODE(bp)) {
> +		NL_SET_ERR_MSG_MOD(extack, "tcp-data-split can not be enabled with XDP");
> +		return -EINVAL;
> +	}

Technically just if the XDP does not support multi-buffer.
Any chance we could do this check in the core?

