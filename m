Return-Path: <netdev+bounces-61329-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4024A8236E3
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 22:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3DAC287689
	for <lists+netdev@lfdr.de>; Wed,  3 Jan 2024 21:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B761D54F;
	Wed,  3 Jan 2024 21:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qhgA6zSG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56721D696;
	Wed,  3 Jan 2024 21:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B24FC433C8;
	Wed,  3 Jan 2024 21:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704315806;
	bh=QD5FzN6yb4XKKIWHNV4g4iP1F/YPzPhiGQBAapNVvtQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qhgA6zSGsOLSi2ieOTuDZQtB01KRNK73RK87gFiJodsEj78ZlGhP9kS3M9abrgRd2
	 jVCPN4pupWLYo8ANtXAZICT5gcF6eO7iLMBJxjkNuLuYK4953S3XNQWoIzelzkxJXZ
	 V1fr17cwDx2DmOB71zg2Af0KfW8f81tLSOnBZ7O92MMx5pAliQ2uvSzZjimBPHJhQw
	 WUMDaDNCQb698zCY+N9UN5jcSmuEAKomy84bRq38VBJZy7Ggq5Zz4jrFOe6dQvseq6
	 zdEY5SBz4w5PsunILjZ95aDj6b5kTZJM09Dtgkc5tAzIwYvSzRlf9J83SfZ7DL/Pos
	 V7riDGoD8dtqA==
Date: Wed, 3 Jan 2024 21:03:21 +0000
From: Simon Horman <horms@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev
Subject: Re: [PATCH net-next 3/6] virtio_net: support device stats
Message-ID: <20240103210321.GD31813@kernel.org>
References: <20231222033021.20649-1-xuanzhuo@linux.alibaba.com>
 <20231222033021.20649-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222033021.20649-4-xuanzhuo@linux.alibaba.com>

On Fri, Dec 22, 2023 at 11:30:18AM +0800, Xuan Zhuo wrote:
> As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> 
> Virtio-net supports to get the stats from the device by ethtool -S <eth0>.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Hi Xuan Zhuo,

some minor feedback from my side relating to Sparse warnings.

...

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c

...

> +static int virtnet_get_hw_stats(struct virtnet_info *vi,
> +				struct virtnet_stats_ctx *ctx)
> +{
> +	struct virtio_net_ctrl_queue_stats *req;
> +	struct virtio_net_stats_reply_hdr *hdr;
> +	struct scatterlist sgs_in, sgs_out;
> +	u32 num_rx, num_tx, num_cq, offset;
> +	int qnum, i, j,  qid, res_size;
> +	struct virtnet_stats_map *m;
> +	void *reply, *p;
> +	u64 bitmap;
> +	int ok;
> +	u64 *v;

...

> +	for (p = reply; p - reply < res_size; p += virtio16_to_cpu(vi->vdev, hdr->size)) {

The type of the second parameter of _virtio16_to_cpu() is __virtio16.
But the type of the size field of virtio_net_stats_reply_hdr is __le16.
This does not seem correct.

> +		hdr = p;
> +
> +		qid = virtio16_to_cpu(vi->vdev, hdr->vq_index);

Similarly, the vq_index field of virtio_net_stats_reply_hdr is also __le16.

...

> +		for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
> +			m = &virtio_net_stats_map[i];
> +
> +			if (m->flag & bitmap)
> +				offset += m->num;
> +
> +			if (hdr->type != m->type)
> +				continue;
> +
> +			for (j = 0; j < m->num; ++j) {
> +				v = p + m->desc[j].offset;
> +				ctx->data[offset + j] = virtio64_to_cpu(vi->vdev, *v);

Here the type of the second parameter of virtio64_to_cpu() is __virtio64.
But the type of *v is u64.

> +			}
> +
> +			break;
> +		}
> +	}
> +
> +	kfree(reply);
> +	return 0;
> +}
> +

...

> @@ -3183,11 +3497,35 @@ static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>  static int virtnet_get_sset_count(struct net_device *dev, int sset)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> +	struct virtnet_stats_ctx ctx = {0};
> +	u32 pair_count;
>  
>  	switch (sset) {
>  	case ETH_SS_STATS:
> -		return vi->curr_queue_pairs * (VIRTNET_RQ_STATS_LEN +
> -					       VIRTNET_SQ_STATS_LEN);
> +		if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS) &&
> +		    !vi->device_stats_cap) {
> +			struct scatterlist sg;
> +
> +			sg_init_one(&sg, &vi->ctrl->stats_cap, sizeof(vi->ctrl->stats_cap));
> +
> +			if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_STATS,
> +						  VIRTIO_NET_CTRL_STATS_QUERY,
> +						  NULL, &sg)) {
> +				dev_warn(&dev->dev, "Fail to get stats capability\n");
> +			} else {
> +				__le64 v;
> +
> +				v = vi->ctrl->stats_cap.supported_stats_types[0];
> +				vi->device_stats_cap = virtio64_to_cpu(vi->vdev, v);

Similarly, the type of v is __le64.

> +			}
> +		}
> +
> +		virtnet_stats_ctx_init(vi, &ctx, NULL);
> +
> +		pair_count = VIRTNET_RQ_STATS_LEN + VIRTNET_SQ_STATS_LEN;
> +		pair_count += ctx.num_rx + ctx.num_tx;
> +
> +		return ctx.num_cq + vi->curr_queue_pairs * pair_count;
>  	default:
>  		return -EOPNOTSUPP;
>  	}

...

