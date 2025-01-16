Return-Path: <netdev+bounces-159008-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F532A141AD
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 19:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F5316AB60
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 18:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427DA22D4EC;
	Thu, 16 Jan 2025 18:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVNDS9t0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12226190685;
	Thu, 16 Jan 2025 18:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737051892; cv=none; b=DBcffc0EiY9UzRtd/j9HNmaeg2HKmxk89/hNiShByt/5uOdUpdBGrfmeJFV+uoJY/pEsqyWRVpqrQdGl0GtT3ZVjynhH1MR6HLvglJWks78lAgjkNfGENoU4C7W9Uiikv2xzGAf5EvZK3PqzWBYGjI2KO5Bx7fKGEWsvwZ8T3dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737051892; c=relaxed/simple;
	bh=TRTJU+NnbhhpvFno4E254yvAe4GWlFpJ/VleavVsJYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsyfo5DwSNScUn6bE/wWySpDfdL1GNqc567rylD97WzpudmbS7SeaEqQvRQiEMrv7tdzmxMhjFaQS1N15h+mieu8DB8OS/WV2lhaQKgARsulCfyzWMgcqgU8HBKkArn+0iGtn01Ow12LM+Yy6LEn2cJ8/XkNBSv8YD2Yqxtz25Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVNDS9t0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40E4EC4CED6;
	Thu, 16 Jan 2025 18:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737051891;
	bh=TRTJU+NnbhhpvFno4E254yvAe4GWlFpJ/VleavVsJYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tVNDS9t0Vd1UPtuOc8+CUv6YJJTA7kLdgokgAB/5Rx9M7fYGLl+nAlWIVgOjY8WlI
	 698dlBUtHYMcTZtqaVlwIcntA2W5ZMm/6PKhuH1b9as4TFVTNLmxu4Xg15DBXd6tuO
	 7juSBzOluLIYFIe44ijZEl31p9f0v4Cj4QCAI+t0MEvKrSJ/pdCaHORKORD2Ht4S/1
	 IxxvaJdJkHnZAX4gt5KwnY9Eldn34zF3znMcTLVNi1NZ3SjX/7XFqYD3JMMjRpJX2/
	 k/lOKGDa6+DJYnmzsqTwj4NwszRAKJkDNCX6eMznAEynYwaVYKfXVViDYv85Q8fet1
	 yBobewVIZZiTw==
Date: Thu, 16 Jan 2025 18:24:47 +0000
From: Simon Horman <horms@kernel.org>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: fec: implement TSO descriptor cleanup
Message-ID: <20250116182447.GF6206@kernel.org>
References: <20250116130920.30984-1-dheeraj.linuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116130920.30984-1-dheeraj.linuxdev@gmail.com>

On Thu, Jan 16, 2025 at 06:39:20PM +0530, Dheeraj Reddy Jonnalagadda wrote:
> Implement the TODO in fec_enet_txq_submit_tso() error path to properly
> release buffer descriptors that were allocated during a failed TSO
> operation. This prevents descriptor leaks when TSO operations fail
> partway through.
> 
> The cleanup iterates from the starting descriptor to where the error
> occurred, resetting the status and buffer address fields of each
> descriptor.
> 
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
> index b2daed55bf6c..eff065010c9e 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -913,7 +913,18 @@ static int fec_enet_txq_submit_tso(struct fec_enet_priv_tx_q *txq,
>  	return 0;
>  
>  err_release:
> -	/* TODO: Release all used data descriptors for TSO */
> +	/* Release all used data descriptors for TSO */
> +	struct bufdesc *tmp_bdp = txq->bd.cur;

Hi Dheeraj,

This is not a full review. But variable declarations
should appear at the top of the block they are in,
in this case that would be at the top of the function.

> +
> +	while (tmp_bdp != bdp) {
> +		tmp_bdp->cbd_sc = 0;
> +		tmp_bdp->cbd_bufaddr = 0;
> +		tmp_bdp->cbd_datlen = 0;
> +		tmp_bdp = fec_enet_get_nextdesc(tmp_bdp, &txq->bd);
> +	}
> +
> +	dev_kfree_skb_any(skb);
> +
>  	return ret;
>  }

-- 
pw-bot: changes-requested

