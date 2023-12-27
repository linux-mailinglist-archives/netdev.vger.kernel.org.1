Return-Path: <netdev+bounces-60422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB7D81F22A
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 22:09:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB0D281054
	for <lists+netdev@lfdr.de>; Wed, 27 Dec 2023 21:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC742481B4;
	Wed, 27 Dec 2023 21:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/zAncLJ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20F481A8
	for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 21:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703711334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4g1zthHZUD9xmBpGJUBoJ+taAemxhkY7fsheWGb/mzs=;
	b=T/zAncLJzg8npdEl34dqfDB/7/3TCjYyVOkDu1I96I8eNoim4fqFVYuSKFX5NLctcA+C9t
	enPYEqRwaNQTXxaFe3noVb6H+n+4kf9bASKMHenR1tQuG4t5ZZM6x4EEWv8EOdRtZNC2wa
	gfPYn7x92/D9tqOF5/DDMzDdrfC5KL8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-509-6lJ_ccB3O0eUsAbQ9XyxtQ-1; Wed, 27 Dec 2023 16:08:52 -0500
X-MC-Unique: 6lJ_ccB3O0eUsAbQ9XyxtQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40d31116cffso44269065e9.2
        for <netdev@vger.kernel.org>; Wed, 27 Dec 2023 13:08:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703711331; x=1704316131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4g1zthHZUD9xmBpGJUBoJ+taAemxhkY7fsheWGb/mzs=;
        b=OeVfQ48w1oLiSd4dNFvygUXxz59jvA7uFQEqvHUleIphpLoie12yBwrK4e9ySIlXY6
         zStAUQvUF4OE9HecYCv0RX2o8oDMVLRi/1HgGiQqiT9aLVZbV2BCxsBDx0nwzqlQZKcb
         ED20jvBkVDVI+MjEyVPp4e1R7+g6T14yTRuVGh9XUWOIZa/KjtInufTLY4q67nCy1PEx
         f1bIraIX7sjZTDdKL8XAX3OYDvpsD1UHg3bDA5DMgq83iI9lTUNzbMY6oKBYdjGDwe+w
         UWr/1/EaC7pIIsAWigoV8PBzmsWsO2vQS52EgW6tHHUEwo8J5BA1G1csiQqmb6nRNToS
         IFzQ==
X-Gm-Message-State: AOJu0YwH2cdilBIzDe83ogC9+H8Gdzyryu6SyjdnNkFD0aYz+LNCbJlb
	Ax6gBgfGfHJIw9ZrGiwDMNm3X6qA5DrutDktkWVX8TD9oc3s3t3FwXkqWLC+CQmieIRPMXYH4Dv
	por/LAYzeN2SSYCg/ydcTZeNA
X-Received: by 2002:a05:600c:3505:b0:40d:5ae2:c803 with SMTP id h5-20020a05600c350500b0040d5ae2c803mr1670748wmq.72.1703711331573;
        Wed, 27 Dec 2023 13:08:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFlrlf+P0DP9PoLoUihtQdFjKqBKMEtFfhuC87ZNH5zokTGbtkRaxlBxBTLhjW4wxTAJhpWYQ==
X-Received: by 2002:a05:600c:3505:b0:40d:5ae2:c803 with SMTP id h5-20020a05600c350500b0040d5ae2c803mr1670739wmq.72.1703711331122;
        Wed, 27 Dec 2023 13:08:51 -0800 (PST)
Received: from redhat.com ([2.55.177.189])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b0040d18ffbeeasm25469909wmg.31.2023.12.27.13.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 13:08:50 -0800 (PST)
Date: Wed, 27 Dec 2023 16:08:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux.dev, Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: Re: [PATCH net-next v1 3/6] virtio_net: support device stats
Message-ID: <20231227155438-mutt-send-email-mst@kernel.org>
References: <20231226073103.116153-1-xuanzhuo@linux.alibaba.com>
 <20231226073103.116153-4-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226073103.116153-4-xuanzhuo@linux.alibaba.com>

On Tue, Dec 26, 2023 at 03:31:00PM +0800, Xuan Zhuo wrote:
> As the spec https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> 
> Virtio-net supports to get the stats from the device by ethtool -S <eth0>.

you mean "make Virtio-net support getting..."

> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 354 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 350 insertions(+), 4 deletions(-)


> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 31b9ead6260d..1f4d9605552f 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -127,6 +127,113 @@ static const struct virtnet_stat_desc virtnet_rq_stats_desc[] = {
>  #define VIRTNET_SQ_STATS_LEN	ARRAY_SIZE(virtnet_sq_stats_desc)
>  #define VIRTNET_RQ_STATS_LEN	ARRAY_SIZE(virtnet_rq_stats_desc)
>  
> +#define VIRTNET_STATS_DESC(qtype, class, name) \
> +	{#name, offsetof(struct virtio_net_stats_ ## qtype ## _ ## class, qtype ## _ ## name)}
> +
> +static const struct virtnet_stat_desc virtnet_stats_cvq_desc[] = {
> +	{"command_num", offsetof(struct virtio_net_stats_cvq, command_num)},
> +	{"ok_num", offsetof(struct virtio_net_stats_cvq, ok_num)}
> +};

Use named initializers please this is confusing enough.

> +
> +static const struct virtnet_stat_desc virtnet_stats_rx_basic_desc[] = {
> +	VIRTNET_STATS_DESC(rx, basic, packets),
> +	VIRTNET_STATS_DESC(rx, basic, bytes),
> +
> +	VIRTNET_STATS_DESC(rx, basic, notifications),
> +	VIRTNET_STATS_DESC(rx, basic, interrupts),
> +
> +	VIRTNET_STATS_DESC(rx, basic, drops),
> +	VIRTNET_STATS_DESC(rx, basic, drop_overruns),
> +};
> +
> +static const struct virtnet_stat_desc virtnet_stats_tx_basic_desc[] = {
> +	VIRTNET_STATS_DESC(tx, basic, packets),
> +	VIRTNET_STATS_DESC(tx, basic, bytes),
> +
> +	VIRTNET_STATS_DESC(tx, basic, notifications),
> +	VIRTNET_STATS_DESC(tx, basic, interrupts),
> +
> +	VIRTNET_STATS_DESC(tx, basic, drops),
> +	VIRTNET_STATS_DESC(tx, basic, drop_malformed),
> +};
> +
> +static const struct virtnet_stat_desc virtnet_stats_rx_csum_desc[] = {
> +	VIRTNET_STATS_DESC(rx, csum, csum_valid),
> +	VIRTNET_STATS_DESC(rx, csum, needs_csum),
> +
> +	VIRTNET_STATS_DESC(rx, csum, csum_none),
> +	VIRTNET_STATS_DESC(rx, csum, csum_bad),
> +};
> +
> +static const struct virtnet_stat_desc virtnet_stats_tx_csum_desc[] = {
> +	VIRTNET_STATS_DESC(tx, csum, needs_csum),
> +	VIRTNET_STATS_DESC(tx, csum, csum_none),
> +};
> +
> +static const struct virtnet_stat_desc virtnet_stats_rx_gso_desc[] = {
> +	VIRTNET_STATS_DESC(rx, gso, gso_packets),
> +	VIRTNET_STATS_DESC(rx, gso, gso_bytes),
> +	VIRTNET_STATS_DESC(rx, gso, gso_packets_coalesced),
> +	VIRTNET_STATS_DESC(rx, gso, gso_bytes_coalesced),
> +};
> +
> +static const struct virtnet_stat_desc virtnet_stats_tx_gso_desc[] = {
> +	VIRTNET_STATS_DESC(tx, gso, gso_packets),
> +	VIRTNET_STATS_DESC(tx, gso, gso_bytes),
> +	VIRTNET_STATS_DESC(tx, gso, gso_segments),
> +	VIRTNET_STATS_DESC(tx, gso, gso_segments_bytes),
> +	VIRTNET_STATS_DESC(tx, gso, gso_packets_noseg),
> +	VIRTNET_STATS_DESC(tx, gso, gso_bytes_noseg),
> +};
> +
> +static const struct virtnet_stat_desc virtnet_stats_rx_speed_desc[] = {
> +	VIRTNET_STATS_DESC(rx, speed, packets_allowance_exceeded),
> +	VIRTNET_STATS_DESC(rx, speed, bytes_allowance_exceeded),
> +};
> +
> +static const struct virtnet_stat_desc virtnet_stats_tx_speed_desc[] = {
> +	VIRTNET_STATS_DESC(tx, speed, packets_allowance_exceeded),
> +	VIRTNET_STATS_DESC(tx, speed, packets_allowance_exceeded),
> +};
> +
> +struct virtnet_stats_map {

This seems to be somehow trying to do a table driven design?
All this effort does not seem to have resulted in less or
cleaner code.

Keep it simple: for each structure add a function decoding from
UAPI format to ethtool format. No offsetof games nothing.




> +	u64 flag;

is it a single flag rly?

> +	u32 len;

len here means "bytes"?

> +	u32 num;
> +
> +#define VIRTNET_STATS_Q_TYPE_RX 0
> +#define VIRTNET_STATS_Q_TYPE_TX 1
> +#define VIRTNET_STATS_Q_TYPE_CQ 2
> +	u32 queue_type;
> +
> +	u8 type;
> +	const struct virtnet_stat_desc *desc;
> +};
> +
> +#define VIRTNET_DEVICE_STATS_MAP_ITEM(TYPE, type, queue_type)	\
> +	{							\
> +		VIRTIO_NET_STATS_TYPE_##TYPE,			\
> +		sizeof(struct virtio_net_stats_ ## type),	\
> +		ARRAY_SIZE(virtnet_stats_ ## type ##_desc),	\
> +		VIRTNET_STATS_Q_TYPE_##queue_type,		\
> +		VIRTIO_NET_STATS_TYPE_REPLY_##TYPE,		\
> +		&virtnet_stats_##type##_desc[0]			\
> +	}
> +
> +static struct virtnet_stats_map virtio_net_stats_map[] = {
> +	VIRTNET_DEVICE_STATS_MAP_ITEM(CVQ, cvq, CQ),
> +
> +	VIRTNET_DEVICE_STATS_MAP_ITEM(RX_BASIC, rx_basic, RX),
> +	VIRTNET_DEVICE_STATS_MAP_ITEM(RX_CSUM,  rx_csum,  RX),
> +	VIRTNET_DEVICE_STATS_MAP_ITEM(RX_GSO,   rx_gso,   RX),
> +	VIRTNET_DEVICE_STATS_MAP_ITEM(RX_SPEED, rx_speed, RX),
> +
> +	VIRTNET_DEVICE_STATS_MAP_ITEM(TX_BASIC, tx_basic, TX),
> +	VIRTNET_DEVICE_STATS_MAP_ITEM(TX_CSUM,  tx_csum,  TX),
> +	VIRTNET_DEVICE_STATS_MAP_ITEM(TX_GSO,   tx_gso,   TX),
> +	VIRTNET_DEVICE_STATS_MAP_ITEM(TX_SPEED, tx_speed, TX),
> +};
> +
>  struct virtnet_interrupt_coalesce {
>  	u32 max_packets;
>  	u32 max_usecs;
> @@ -232,6 +339,7 @@ struct control_buf {
>  	struct virtio_net_ctrl_coal_tx coal_tx;
>  	struct virtio_net_ctrl_coal_rx coal_rx;
>  	struct virtio_net_ctrl_coal_vq coal_vq;
> +	struct virtio_net_stats_capabilities stats_cap;
>  };
>  
>  struct virtnet_info {
> @@ -314,6 +422,8 @@ struct virtnet_info {
>  
>  	/* failover when STANDBY feature enabled */
>  	struct failover *failover;
> +
> +	u64 device_stats_cap;
>  };
>  
>  struct padded_vnet_hdr {
> @@ -3157,6 +3267,204 @@ static int virtnet_set_channels(struct net_device *dev,
>  	return err;
>  }
>  
> +static void virtnet_get_hw_stats_string(struct virtnet_info *vi, int type, int qid, u8 **data)
> +{
> +	struct virtnet_stats_map *m;
> +	int i, j;
> +	u8 *p = *data;
> +
> +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
> +		return;
> +
> +	for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
> +		m = &virtio_net_stats_map[i];
> +
> +		if (m->queue_type != type)
> +			continue;
> +
> +		if (!(vi->device_stats_cap & m->flag))
> +			continue;
> +
> +		for (j = 0; j < m->num; ++j) {
> +			if (type == VIRTNET_STATS_Q_TYPE_RX)
> +				ethtool_sprintf(&p, "rx_queue_hw_%u_%s", qid, m->desc[j].desc);
> +
> +			else if (type == VIRTNET_STATS_Q_TYPE_TX)
> +				ethtool_sprintf(&p, "tx_queue_hw_%u_%s", qid, m->desc[j].desc);
> +
> +			else if (type == VIRTNET_STATS_Q_TYPE_CQ)
> +				ethtool_sprintf(&p, "cq_hw_%s", m->desc[j].desc);

what is this XX_queue_hw_ cuteness? I don't see other drivers
doing this.

> +		}
> +	}
> +
> +	*data = p;
> +}
> +
> +struct virtnet_stats_ctx {

what is this struct? I don't understand the need for this one either.
If you want a union of UAPI types just do that.


> +	u32 num_cq;
> +	u32 num_rx;
> +	u32 num_tx;
> +
> +	u64 bitmap_cq;
> +	u64 bitmap_rx;
> +	u64 bitmap_tx;

Can't this be an array indexed by type?

> +
> +	u32 size_cq;
> +	u32 size_rx;
> +	u32 size_tx;

Using "size" to mean "bytes" is weird.

> +
> +	u64 *data;
> +};
> +
> +static void virtnet_stats_ctx_init(struct virtnet_info *vi,
> +				   struct virtnet_stats_ctx *ctx,
> +				   u64 *data)
> +{
> +	struct virtnet_stats_map *m;
> +	int i;
> +
> +	ctx->data = data;
> +
> +	for (i = 0; i < ARRAY_SIZE(virtio_net_stats_map); ++i) {
> +		m = &virtio_net_stats_map[i];
> +
> +		if (vi->device_stats_cap & m->flag) {
> +			if (m->queue_type == VIRTNET_STATS_Q_TYPE_CQ) {
> +				ctx->bitmap_cq |= m->flag;
> +				ctx->num_cq += m->num;
> +				ctx->size_cq += m->len;
> +			}
> +
> +			if (m->queue_type == VIRTNET_STATS_Q_TYPE_RX) {
> +				ctx->bitmap_rx |= m->flag;
> +				ctx->num_rx += m->num;
> +				ctx->size_rx += m->len;
> +			}
> +
> +			if (m->queue_type == VIRTNET_STATS_Q_TYPE_TX) {
> +				ctx->bitmap_tx |= m->flag;
> +				ctx->num_tx += m->num;
> +				ctx->size_tx += m->len;
> +			}
> +		}
> +	}
> +}
> +
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
> +
> +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_DEVICE_STATS))
> +		return 0;
> +
> +	qnum = 0;
> +	if (ctx->bitmap_cq)
> +		qnum += 1;
> +
> +	if (ctx->bitmap_rx)
> +		qnum += vi->curr_queue_pairs;
> +
> +	if (ctx->bitmap_tx)
> +		qnum += vi->curr_queue_pairs;
> +
> +	req = kcalloc(qnum, sizeof(*req), GFP_KERNEL);
> +	if (!req)
> +		return -ENOMEM;
> +
> +	res_size = (ctx->size_rx + ctx->size_tx) * vi->curr_queue_pairs + ctx->size_cq;
> +	reply = kmalloc(res_size, GFP_KERNEL);
> +	if (!reply) {
> +		kfree(req);
> +		return -ENOMEM;
> +	}
> +
> +	j = 0;
> +	for (i = 0; i < vi->curr_queue_pairs; ++i) {
> +		if (ctx->bitmap_rx) {
> +			req->stats[j].vq_index = cpu_to_le16(i * 2);
> +			req->stats[j].types_bitmap[0] = cpu_to_le64(ctx->bitmap_rx);
> +			++j;
> +		}
> +
> +		if (ctx->bitmap_tx) {
> +			req->stats[j].vq_index = cpu_to_le16(i * 2 + 1);
> +			req->stats[j].types_bitmap[0] = cpu_to_le64(ctx->bitmap_tx);
> +			++j;
> +		}
> +	}
> +
> +	if (ctx->size_cq) {
> +		req->stats[j].vq_index = cpu_to_le16(vi->max_queue_pairs * 2);
> +		req->stats[j].types_bitmap[0] = cpu_to_le64(ctx->bitmap_cq);
> +		++j;
> +	}
> +
> +	sg_init_one(&sgs_out, req, sizeof(*req) * j);
> +	sg_init_one(&sgs_in, reply, res_size);
> +
> +	ok = virtnet_send_command(vi, VIRTIO_NET_CTRL_STATS,
> +				  VIRTIO_NET_CTRL_STATS_GET,
> +				  &sgs_out, &sgs_in);
> +	kfree(req);
> +
> +	if (!ok) {
> +		kfree(reply);
> +		return ok;
> +	}
> +
> +	num_rx = VIRTNET_RQ_STATS_LEN + ctx->num_rx;
> +	num_tx = VIRTNET_SQ_STATS_LEN + ctx->num_tx;
> +	num_cq = ctx->num_tx;
> +
> +	for (p = reply; p - reply < res_size; p += virtio16_to_cpu(vi->vdev, hdr->size)) {
> +		hdr = p;
> +
> +		qid = virtio16_to_cpu(vi->vdev, hdr->vq_index);
> +
> +		if (qid == vi->max_queue_pairs * 2) {
> +			offset = 0;
> +			bitmap = ctx->bitmap_cq;
> +		} else if (qid % 2) {
> +			offset = num_cq + num_rx * vi->curr_queue_pairs + num_tx * (qid / 2);
> +			offset += VIRTNET_SQ_STATS_LEN;
> +			bitmap = ctx->bitmap_tx;
> +		} else {
> +			offset = num_cq + num_rx * (qid / 2) + VIRTNET_RQ_STATS_LEN;
> +			bitmap = ctx->bitmap_rx;
> +		}
> +
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
>  static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> @@ -3165,16 +3473,22 @@ static void virtnet_get_strings(struct net_device *dev, u32 stringset, u8 *data)
>  
>  	switch (stringset) {
>  	case ETH_SS_STATS:
> +		virtnet_get_hw_stats_string(vi, VIRTNET_STATS_Q_TYPE_CQ, 0, &p);
> +
>  		for (i = 0; i < vi->curr_queue_pairs; i++) {
>  			for (j = 0; j < VIRTNET_RQ_STATS_LEN; j++)
>  				ethtool_sprintf(&p, "rx_queue_%u_%s", i,
>  						virtnet_rq_stats_desc[j].desc);
> +
> +			virtnet_get_hw_stats_string(vi, VIRTNET_STATS_Q_TYPE_RX, i, &p);
>  		}
>  
>  		for (i = 0; i < vi->curr_queue_pairs; i++) {
>  			for (j = 0; j < VIRTNET_SQ_STATS_LEN; j++)
>  				ethtool_sprintf(&p, "tx_queue_%u_%s", i,
>  						virtnet_sq_stats_desc[j].desc);
> +
> +			virtnet_get_hw_stats_string(vi, VIRTNET_STATS_Q_TYPE_TX, i, &p);
>  		}
>  		break;
>  	}
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
> @@ -3197,11 +3535,17 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
>  				      struct ethtool_stats *stats, u64 *data)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> -	unsigned int idx = 0, start, i, j;
> +	struct virtnet_stats_ctx ctx = {0};
> +	unsigned int idx, start, i, j;
>  	const u8 *stats_base;
>  	const u64_stats_t *p;
>  	size_t offset;
>  
> +	virtnet_stats_ctx_init(vi, &ctx, data);
> +	virtnet_get_hw_stats(vi, &ctx);
> +
> +	idx = ctx.num_cq;
> +
>  	for (i = 0; i < vi->curr_queue_pairs; i++) {
>  		struct receive_queue *rq = &vi->rq[i];
>  
> @@ -3215,6 +3559,7 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
>  			}
>  		} while (u64_stats_fetch_retry(&rq->stats.syncp, start));
>  		idx += VIRTNET_RQ_STATS_LEN;
> +		idx += ctx.num_rx;
>  	}
>  
>  	for (i = 0; i < vi->curr_queue_pairs; i++) {
> @@ -3230,6 +3575,7 @@ static void virtnet_get_ethtool_stats(struct net_device *dev,
>  			}
>  		} while (u64_stats_fetch_retry(&sq->stats.syncp, start));
>  		idx += VIRTNET_SQ_STATS_LEN;
> +		idx += ctx.num_tx;
>  	}
>  }
>  
> @@ -4760,7 +5106,7 @@ static struct virtio_device_id id_table[] = {
>  	VIRTIO_NET_F_SPEED_DUPLEX, VIRTIO_NET_F_STANDBY, \
>  	VIRTIO_NET_F_RSS, VIRTIO_NET_F_HASH_REPORT, VIRTIO_NET_F_NOTF_COAL, \
>  	VIRTIO_NET_F_VQ_NOTF_COAL, \
> -	VIRTIO_NET_F_GUEST_HDRLEN
> +	VIRTIO_NET_F_GUEST_HDRLEN, VIRTIO_NET_F_DEVICE_STATS
>  
>  static unsigned int features[] = {
>  	VIRTNET_FEATURES,
> -- 
> 2.32.0.3.g01195cf9f


