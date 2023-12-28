Return-Path: <netdev+bounces-60430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB2081F3E6
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 02:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFA751F21E21
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 01:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF884439;
	Thu, 28 Dec 2023 01:45:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B955232
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 01:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R421e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0VzMRcoc_1703727933;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0VzMRcoc_1703727933)
          by smtp.aliyun-inc.com;
          Thu, 28 Dec 2023 09:45:34 +0800
Message-ID: <1703727887.489213-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v1 1/6] virtio_net: introduce device stats feature and structures
Date: Thu, 28 Dec 2023 09:44:47 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 Zhu Yanjun <yanjun.zhu@linux.dev>
References: <20231226073103.116153-1-xuanzhuo@linux.alibaba.com>
 <20231226073103.116153-2-xuanzhuo@linux.alibaba.com>
 <20231227160338-mutt-send-email-mst@kernel.org>
In-Reply-To: <20231227160338-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 27 Dec 2023 16:05:25 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Tue, Dec 26, 2023 at 03:30:58PM +0800, Xuan Zhuo wrote:
> > The virtio-net device stats spec:
> >
> > https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bbbd243291ab0064f82
> >
> > This commit introduces the relative feature and structures.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  include/uapi/linux/virtio_net.h | 137 ++++++++++++++++++++++++++++++++
> >  1 file changed, 137 insertions(+)
> >
> > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> > index cc65ef0f3c3e..8fca4d1b7635 100644
> > --- a/include/uapi/linux/virtio_net.h
> > +++ b/include/uapi/linux/virtio_net.h
> > @@ -56,6 +56,7 @@
> >  #define VIRTIO_NET_F_MQ	22	/* Device supports Receive Flow
> >  					 * Steering */
> >  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> > +#define VIRTIO_NET_F_DEVICE_STATS 50	/* Device can provide device-level statistics. */
> >  #define VIRTIO_NET_F_VQ_NOTF_COAL 52	/* Device supports virtqueue notification coalescing */
> >  #define VIRTIO_NET_F_NOTF_COAL	53	/* Device supports notifications coalescing */
> >  #define VIRTIO_NET_F_GUEST_USO4	54	/* Guest can handle USOv4 in. */
> > @@ -406,4 +407,140 @@ struct  virtio_net_ctrl_coal_vq {
> >  	struct virtio_net_ctrl_coal coal;
> >  };
> >
> > +/*
> > + * Device Statistics
> > + */
> > +#define VIRTIO_NET_CTRL_STATS         8
> > +#define VIRTIO_NET_CTRL_STATS_QUERY   0
> > +#define VIRTIO_NET_CTRL_STATS_GET     1
> > +
> > +struct virtio_net_stats_capabilities {
> > +
> > +#define VIRTIO_NET_STATS_TYPE_CVQ       (1ULL << 32)
> > +
> > +#define VIRTIO_NET_STATS_TYPE_RX_BASIC  (1ULL << 0)
> > +#define VIRTIO_NET_STATS_TYPE_RX_CSUM   (1ULL << 1)
> > +#define VIRTIO_NET_STATS_TYPE_RX_GSO    (1ULL << 2)
> > +#define VIRTIO_NET_STATS_TYPE_RX_SPEED  (1ULL << 3)
> > +
> > +#define VIRTIO_NET_STATS_TYPE_TX_BASIC  (1ULL << 16)
> > +#define VIRTIO_NET_STATS_TYPE_TX_CSUM   (1ULL << 17)
> > +#define VIRTIO_NET_STATS_TYPE_TX_GSO    (1ULL << 18)
> > +#define VIRTIO_NET_STATS_TYPE_TX_SPEED  (1ULL << 19)
> > +
> > +	__le64 supported_stats_types[1];
> > +};
> > +
> > +struct virtio_net_ctrl_queue_stats {
> > +	struct {
> > +		__le16 vq_index;
> > +		__le16 reserved[3];
> > +		__le64 types_bitmap[1];
> > +	} stats[1];
> > +};
> > +
> > +struct virtio_net_stats_reply_hdr {
> > +#define VIRTIO_NET_STATS_TYPE_REPLY_CVQ       32
> > +
> > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_BASIC  0
> > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_CSUM   1
> > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_GSO    2
> > +#define VIRTIO_NET_STATS_TYPE_REPLY_RX_SPEED  3
> > +
> > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_BASIC  16
> > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_CSUM   17
> > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_GSO    18
> > +#define VIRTIO_NET_STATS_TYPE_REPLY_TX_SPEED  19
> > +	__u8 type;
> > +	__u8 reserved;
> > +	__le16 vq_index;
> > +	__le16 reserved1;
> > +	__le16 size;
> > +};
> > +
> > +struct virtio_net_stats_cvq {
> > +	struct virtio_net_stats_reply_hdr hdr;
> > +
> > +	__le64 command_num;
> > +	__le64 ok_num;
> > +};
> > +
> > +struct virtio_net_stats_rx_basic {
> > +	struct virtio_net_stats_reply_hdr hdr;
> > +
> > +	__le64 rx_notifications;
> > +
> > +	__le64 rx_packets;
> > +	__le64 rx_bytes;
> > +
> > +	__le64 rx_interrupts;
> > +
> > +	__le64 rx_drops;
> > +	__le64 rx_drop_overruns;
> > +};
> > +
> > +struct virtio_net_stats_tx_basic {
> > +	struct virtio_net_stats_reply_hdr hdr;
> > +
> > +	__le64 tx_notifications;
> > +
> > +	__le64 tx_packets;
> > +	__le64 tx_bytes;
> > +
> > +	__le64 tx_interrupts;
> > +
> > +	__le64 tx_drops;
> > +	__le64 tx_drop_malformed;
> > +};
> > +
> > +struct virtio_net_stats_rx_csum {
> > +	struct virtio_net_stats_reply_hdr hdr;
> > +
> > +	__le64 rx_csum_valid;
> > +	__le64 rx_needs_csum;
> > +	__le64 rx_csum_none;
> > +	__le64 rx_csum_bad;
> > +};
> > +
> > +struct virtio_net_stats_tx_csum {
> > +	struct virtio_net_stats_reply_hdr hdr;
> > +
> > +	__le64 tx_csum_none;
> > +	__le64 tx_needs_csum;
> > +};
> > +
> > +struct virtio_net_stats_rx_gso {
> > +	struct virtio_net_stats_reply_hdr hdr;
> > +
> > +	__le64 rx_gso_packets;
> > +	__le64 rx_gso_bytes;
> > +	__le64 rx_gso_packets_coalesced;
> > +	__le64 rx_gso_bytes_coalesced;
> > +};
> > +
> > +struct virtio_net_stats_tx_gso {
> > +	struct virtio_net_stats_reply_hdr hdr;
> > +
> > +	__le64 tx_gso_packets;
> > +	__le64 tx_gso_bytes;
> > +	__le64 tx_gso_segments;
> > +	__le64 tx_gso_segments_bytes;
> > +	__le64 tx_gso_packets_noseg;
> > +	__le64 tx_gso_bytes_noseg;
> > +};
> > +
> > +struct virtio_net_stats_rx_speed {
> > +	struct virtio_net_stats_reply_hdr hdr;
> > +
> > +	__le64 rx_packets_allowance_exceeded;
> > +	__le64 rx_bytes_allowance_exceeded;
> > +};
> > +
> > +struct virtio_net_stats_tx_speed {
> > +	struct virtio_net_stats_reply_hdr hdr;
> > +
> > +	__le64 tx_packets_allowance_exceeded;
> > +	__le64 tx_bytes_allowance_exceeded;
> > +};
> > +
>
> A ton of duplication here. E.g.  virtio_net_stats_rx_speed and
> virtio_net_stats_tx_speed are exactly the same.
>

YES.

But I don't think it matters.

Thanks.


>
>
>
>
> >  #endif /* _UAPI_LINUX_VIRTIO_NET_H */
> > --
> > 2.32.0.3.g01195cf9f
>

