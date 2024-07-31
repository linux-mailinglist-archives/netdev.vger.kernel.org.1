Return-Path: <netdev+bounces-114350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 624E6942420
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 03:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37F9284B50
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 01:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7941E8BFC;
	Wed, 31 Jul 2024 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUKOqtf7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF0A4C80;
	Wed, 31 Jul 2024 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722388822; cv=none; b=ux06CJQ16JHbI8vxFDJlgkenKqKq+AUTNVm/yvzWfShBdQZxPUpyXcwY+6/FC/T3rYYR8qqn7yJOLF/efHc0AaBnyB63bxsm3LNOaiMDMzYr1Syj6RNhOOVeuK19cBvYsRAhXrxd5YYNdTThrCN7i/q7gt9wZTh73P0D8Ww+Lh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722388822; c=relaxed/simple;
	bh=k2MWMZVN+gSbg1lYV39k//TGqnZsbiq2ed/o3H2/EjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjuPLnSQ+udCSBT5GoaxYb9eWN3tGRVR9Vsr9pZguzNMuVX4MsJEWGp1RPyTCRiN3hhZXCWTwzVka7PPuT1UkP7hA5uvc26yPdoh1evUuIKCzir6es1X0PTx9LD05xVXMplHmngti1LoAb8UPh+lqto4UH/aQOBCA021NGw/Vlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUKOqtf7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79054C32782;
	Wed, 31 Jul 2024 01:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722388822;
	bh=k2MWMZVN+gSbg1lYV39k//TGqnZsbiq2ed/o3H2/EjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NUKOqtf7goZs+vFsigZdVk/KOtpCmnV7CgeYE+GO9kWcnovpwHku2GTlc8PUkePBC
	 Po/e8OPxT45lGxZt6/gThSwu8ovuFTmc5JcR/UkTsVL+rI61HW03OvbLmsGpLU/Dl7
	 VyeJe5a7+PJRavc9im0HqKllveC+axFcANyNZ7HXRjNaSs87o342cLGtMtW/SZUokY
	 TxpD+7Z/5UUJ6BsXCPGYAPMJzzIJkyCLBfallPQwiUrGVuhfoHbing+AZLlvdffNVd
	 2MXhBe45wh/+4t3oWMZQpIUiYhydzcWiEmbCdcTAgZ7Ema9ZAzF3L7Oxk6yXP1Gnb2
	 9WbsKl1GG94bg==
Date: Tue, 30 Jul 2024 18:20:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, virtualization@lists.linux.dev, Eugenio
 =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing
 commands
Message-ID: <20240730182020.75639070@kernel.org>
In-Reply-To: <20240729124755.35719-1-hengqi@linux.alibaba.com>
References: <20240729124755.35719-1-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 29 Jul 2024 20:47:55 +0800 Heng Qi wrote:
> Subject: [PATCH net] virtio_net: Avoid sending unnecessary vq coalescing commands

subject currently reads like this is an optimization, could you
rephrase?

> From the virtio spec:
> 
> 	The driver MUST have negotiated the VIRTIO_NET_F_VQ_NOTF_COAL
> 	feature when issuing commands VIRTIO_NET_CTRL_NOTF_COAL_VQ_SET
> 	and VIRTIO_NET_CTRL_NOTF_COAL_VQ_GET.
> 
> The driver must not send vq notification coalescing commands if
> VIRTIO_NET_F_VQ_NOTF_COAL is not negotiated. This limitation of course
> applies to vq resize.
> 
> Fixes: f61fe5f081cf ("virtio-net: fix the vq coalescing setting for vq resize")
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0383a3e136d6..eb115e807882 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3708,6 +3708,7 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  	u32 rx_pending, tx_pending;
>  	struct receive_queue *rq;
>  	struct send_queue *sq;
> +	u32 pkts, usecs;
>  	int i, err;
>  
>  	if (ring->rx_mini_pending || ring->rx_jumbo_pending)
> @@ -3740,11 +3741,13 @@ static int virtnet_set_ringparam(struct net_device *dev,
>  			 * through the VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver
>  			 * did not set any TX coalescing parameters, to 0.
>  			 */
> -			err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i,
> -							       vi->intr_coal_tx.max_usecs,
> -							       vi->intr_coal_tx.max_packets);
> -			if (err)
> -				return err;
> +			if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> +				usecs = vi->intr_coal_tx.max_usecs;
> +				pkts = vi->intr_coal_tx.max_packets;
> +				err = virtnet_send_tx_ctrl_coal_vq_cmd(vi, i, usecs, pkts);
> +				if (err)
> +					return err;

Can you check the feature inside the
virtnet_send_.x_ctrl_coal_vq_cmd() helpers?
5 levels of indentation is a bit much
-- 
pw-bot: cr

