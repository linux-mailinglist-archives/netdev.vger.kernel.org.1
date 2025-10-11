Return-Path: <netdev+bounces-228590-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA51EBCF3C3
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 12:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F404043CA
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 10:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EF8258ED5;
	Sat, 11 Oct 2025 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7YRL+Xv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8F3256C88
	for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 10:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760179398; cv=none; b=SyR0eC8ZvspLg+gqGQ5hDXgHz+61d/9X8Cp5P1cco+sSc2MXVO/JIwtX0wss+O3pEzAyiJao0MxJhOT+Ssw4I77b7XvsRoJIrTcJLKtAmiTthPwEcCdvdnXWshqUaOVL/w1hy6fcHQFVekdUmnBZ0FUUTNLPg0Wo2oQVW2hnA9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760179398; c=relaxed/simple;
	bh=nvw6W22YNUcuYDkHM+/YmRNu7p7dmP/S/3RcNhOY36U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QbHcUteNNn491RmY/73BEYgD7LQNpj3mgSOfep02B+E60sgsqQ8Sjq2YBLKNDIx4x8Njv+8XWfTXMm7Rd2kJFqbA7vpcWVK5AHcDMPrvl9T3+f1cf18sgdGcDJT8hsw1ZZpqhSm+BXyWH5oXWLgx8ypIcP+2cqMBzByvD+MPR+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7YRL+Xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 737BCC4CEF4;
	Sat, 11 Oct 2025 10:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760179398;
	bh=nvw6W22YNUcuYDkHM+/YmRNu7p7dmP/S/3RcNhOY36U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z7YRL+XvPTvkgZK8XFE7+R7vW0qu3Q9vz9NeH6kX1WYopPqSBVEDm/tpicH10elOm
	 mtxO8+nClsaSliE7N9vg0ra4GVLP34we1YWBfftqCtl8W8C1+9kLBhXC9fOZfMI//6
	 x2BNtd3E8Z05g9V7prCiRug5HF950H2QOuKWorVId+dSXVEmSQZf5hnp4A1Kv/s8ey
	 nsAOW+PvetWJife73IN+NqWpjUS1y8+bujPHItr8wjrcn81inYRccNvV0ls7/Rrcxj
	 2W/qz3tcMo/BwmmA2o4VA4i3A8LQerqjX5DWx6kGVfQQwHvCNv2Xuz9/4y675ycEol
	 OMFiEChbBUG/g==
Date: Sat, 11 Oct 2025 11:43:14 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Take into account out-of-order tx
 completions in airoha_dev_xmit()
Message-ID: <aOo0woPiMxjABFv2@horms.kernel.org>
References: <20251010-airoha-tx-busy-queue-v1-1-9e1af5d06104@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010-airoha-tx-busy-queue-v1-1-9e1af5d06104@kernel.org>

On Fri, Oct 10, 2025 at 07:21:43PM +0200, Lorenzo Bianconi wrote:
> Completion napi can free out-of-order tx descriptors if hw QoS is
> enabled and packets with different priority are queued to same DMA ring.
> Take into account possible out-of-order reports checking if the tx queue
> is full using circular buffer head/tail pointer instead of the number of
> queued packets.
> 
> Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> index 833dd911980b3f698bd7e5f9fd9e2ce131dd5222..5e2ff52dba03a7323141fe9860fba52806279bd0 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.c
> +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> @@ -1873,6 +1873,19 @@ static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
>  #endif
>  }
>  
> +static bool airoha_dev_is_tx_busy(struct airoha_queue *q, u32 nr_frags)
> +{
> +	u16 index = (q->head + nr_frags) % q->ndesc;
> +
> +	/* completion napi can free out-of-order tx descriptors if hw QoS is
> +	 * enabled and packets with different priorities are queued to the same
> +	 * DMA ring. Take into account possible out-of-order reports checking
> +	 * if the tx queue is full using circular buffer head/tail pointers
> +	 * instead of the number of queued packets.
> +	 */
> +	return index >= q->tail && (q->head < q->tail || q->head > index);

Hi Lorenzo,

I think there is a corner case here.
Perhaps they can't occur, but here goes.

Let us suppose that head is 1.
And the ring is completely full, so tail is 2.

Now, suppose nr_frags is ndesc - 1.
In this case the function above will return false. But the ring is full.

Ok, ndesc is actually 1024 and nfrags should never be close to that.
But the problem is general. And a perhaps more realistic example is:

  ndesc is 1024
  head is 1008
  The ring is full so tail is 1009
  (Or head is any other value that leaves less than 16 slots free)
  nr_frags is 16

airoha_dev_is_tx_busy() returns false, even though the ring is full.

Probably this has it's own problems. But if my reasoning above is correct
(is it?) then the following seems to address it by flattening and extending
the ring. Because what we are about is the relative value of head, index
and tail. Not the slots they occupy in the ring.

N.B: I tetsed the algorirthm with a quick implementation in user-space.
The following is, however, completely untested.

static bool airoha_dev_is_tx_busy(struct airoha_queue *q, u32 nr_frags)
{
	unsigned int tail = q->tail < q->head ? q->tail + q->ndesc : q->tail;
	unsigned int index = q->head + nr_frags;

	return index >= tail;
}

...

