Return-Path: <netdev+bounces-63800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8047982F7A6
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 21:27:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9315A1C24ABE
	for <lists+netdev@lfdr.de>; Tue, 16 Jan 2024 20:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A262622F04;
	Tue, 16 Jan 2024 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SplWXPA6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6E122F03;
	Tue, 16 Jan 2024 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434557; cv=none; b=YH7BjzOLQYuazT6X4oWrd8U3clES7+br9y0W/F03rzoZ2JHja4TmlbN6Nl62SC9OtaW74lndkvc9JEhEI/jUEBQnhFRsfoRkmCZDR6P1n0uCjv0hepzsc3fjpVmY3bm7SFhKe7TklrgErTIlIlZMBQPVggyhjk/qG7gY/sHD8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434557; c=relaxed/simple;
	bh=UlR1vzAunUYAVA7h0+hGXquiBWPvzaB/M+M2k4Oo93Y=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=QshZe+jzmPrT/I7DHwOz//IVuKtpcM855tl4z3w7SH24E3HotoEQJNZ9tiIQFf4N/2Jf986Eayg5PTVbDmFpCGb4wKi5C/NZq90l87EDGPOUo7smp2Opo7Ohhgm29O57grSm2y8XNLK5/6HJLrzLvUmJ23xPNxyzYpIN8UUPqdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SplWXPA6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AA1C433C7;
	Tue, 16 Jan 2024 19:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434557;
	bh=UlR1vzAunUYAVA7h0+hGXquiBWPvzaB/M+M2k4Oo93Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SplWXPA6IGc3JIiEWpBLpIBZ/IkVf1GiZDX7uK07GZqVFCZ1CikouJjhZQLNqjiJE
	 4Ewxv5BnctuxPUXi91HkCBo8Z9GzYr3f/i6cuhswv95RYDock3JPwsa0AX//8bEI/0
	 NpP+Udx6kTEhAxVG4SdjQpgYI6i2UrcyP4LKCx44RwFVKpjuBpp5M9y3AtgvP/PXR+
	 em1uXYIYHoiSPS1B1rgnt2nDKvrRbaEXI3bycENqtcmND0vVnflqQaGGGDUSVcCIt/
	 iyOI/TOlCKTe13OASuKFV9q1Z8CbNmriRJ1wEvToCgWMOkTYEMOYyqBK3msdcpa2h6
	 oDJgbvKetgvzw==
Date: Tue, 16 Jan 2024 19:49:12 +0000
From: Simon Horman <horms@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
	Jason Wang <jasowang@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 2/3] virtio-net: batch dim request
Message-ID: <20240116194912.GE588419@kernel.org>
References: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
 <1705410693-118895-3-git-send-email-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1705410693-118895-3-git-send-email-hengqi@linux.alibaba.com>

On Tue, Jan 16, 2024 at 09:11:32PM +0800, Heng Qi wrote:
> Currently, when each time the driver attempts to update the coalescing
> parameters for a vq, it needs to kick the device.
> The following path is observed:
>   1. Driver kicks the device;
>   2. After the device receives the kick, CPU scheduling occurs and DMA
>      multiple buffers multiple times;
>   3. The device completes processing and replies with a response.
> 
> When large-queue devices issue multiple requests and kick the device
> frequently, this often interrupt the work of the device-side CPU.
> In addition, each vq request is processed separately, causing more
> delays for the CPU to wait for the DMA request to complete.
> 
> These interruptions and overhead will strain the CPU responsible for
> controlling the path of the DPU, especially in multi-device and
> large-queue scenarios.
> 
> To solve the above problems, we internally tried batch request,
> which merges requests from multiple queues and sends them at once.
> We conservatively tested 8 queue commands and sent them together.
> The DPU processing efficiency can be improved by 8 times, which
> greatly eases the DPU's support for multi-device and multi-queue DIM.
> 
> Suggested-by: Xiaoming Zhao <zxm377917@alibaba-inc.com>
> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>

...

> @@ -3546,16 +3552,32 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>  		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
>  		if (update_moder.usec != rq->intr_coal.max_usecs ||
>  		    update_moder.pkts != rq->intr_coal.max_packets) {
> -			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
> -							       update_moder.usec,
> -							       update_moder.pkts);
> -			if (err)
> -				pr_debug("%s: Failed to send dim parameters on rxq%d\n",
> -					 dev->name, qnum);
> -			dim->state = DIM_START_MEASURE;
> +			coal->coal_vqs[j].vqn = cpu_to_le16(rxq2vq(i));
> +			coal->coal_vqs[j].coal.max_usecs = cpu_to_le32(update_moder.usec);
> +			coal->coal_vqs[j].coal.max_packets = cpu_to_le32(update_moder.pkts);
> +			rq->intr_coal.max_usecs = update_moder.usec;
> +			rq->intr_coal.max_packets = update_moder.pkts;
> +			j++;
>  		}
>  	}
>  
> +	if (!j)
> +		goto ret;
> +
> +	coal->num_entries = cpu_to_le32(j);
> +	sg_init_one(&sgs, coal, sizeof(struct virtnet_batch_coal) +
> +		    j * sizeof(struct virtio_net_ctrl_coal_vq));
> +	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
> +				  VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET,
> +				  &sgs))
> +		dev_warn(&vi->vdev->dev, "Failed to add dim command\n.");
> +
> +	for (i = 0; i < j; i++) {
> +		rq = &vi->rq[(coal->coal_vqs[i].vqn) / 2];

Hi Heng Qi,

The type of .vqn is __le16, but here it is used as an
integer in host byte order. Perhaps this should be (completely untested!):

		rq = &vi->rq[le16_to_cpu(coal->coal_vqs[i].vqn) / 2];

> +		rq->dim.state = DIM_START_MEASURE;
> +	}
> +
> +ret:
>  	rtnl_unlock();
>  }
>  

