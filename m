Return-Path: <netdev+bounces-207363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61CBAB06DBC
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 08:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C953A7B77
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 06:12:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C940F280328;
	Wed, 16 Jul 2025 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mlFc3x+r"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9802459E5
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 06:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752646391; cv=none; b=PmIEjRm4MSmLc+DGoav155FrbT+1/0J+Mfmf762fv546RU+dSYpEQYiJlZSmmf66bllKH6kw1Lt1zcNxwWc771nrE5megKjn10kzlqzWRGcGTv4Ru6hXQXNSc0ujqxA6zmsLyy0HfQyvjKlOOouhQjwJDtFS7sjFd5DIx58NMbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752646391; c=relaxed/simple;
	bh=rbWtUj9mFhSEweHjAgRNuP6lkAZXacthVS7S5nWO53M=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To:
	 Content-Type; b=bw2aO3J32Kgs9dLy67mlPIu6J3MqaZuCiK91VaFZibjRCjHgZgg3AEbBc9pNxc1SpRUkPiBTioLdXyVhsYPUauW5J+vbxi6CF7ov8gcbBv8KApryjAda0swJ57Bd8q9Xa6V/2VGdRWhlYbDQetJPntm9ywvsnhm55sxHAJ+1YGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mlFc3x+r; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752646378; h=Message-ID:Subject:Date:From:To:Content-Type;
	bh=o2zSwp1I9WMW3AVVFOCLD25xHl5LABxU4RfhOH+rgeQ=;
	b=mlFc3x+rFFk3QMvmwSI2mvXe7Ki6xPsqhHctjv/F/AErO+XsvdVdEONQafpijRhDJ+K7pcWcCg9B+dw6YjhPSkRd95B7yottZVuhFkGzWUkbw8o/0OXqtbsn7eIFZNU4c2b6tt4kMJa1EnV8jRNf6kzQ05E89GzKeJqEvuv4KuY=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0Wj3-eMH_1752646376 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 16 Jul 2025 14:12:57 +0800
Message-ID: <1752645720.5179944-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] eea: Add basic driver framework for Alibaba Elastic Ethernet Adaptor
Date: Wed, 16 Jul 2025 14:02:00 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Wen Gu <guwen@linux.alibaba.com>,
 Philo Lu <lulie@linux.alibaba.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Dust Li <dust.li@linux.alibaba.com>
References: <20250710112817.85741-1-xuanzhuo@linux.alibaba.com>
 <20250711105546.GT721198@horms.kernel.org>
In-Reply-To: <20250711105546.GT721198@horms.kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 11 Jul 2025 11:55:46 +0100, Simon Horman <horms@kernel.org> wrote:
> On Thu, Jul 10, 2025 at 07:28:17PM +0800, Xuan Zhuo wrote:
> > Add a driver framework for EEA that will be available in the future.
> >
> > Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >  MAINTAINERS                                   |   8 +
> >  drivers/net/ethernet/Kconfig                  |   1 +
> >  drivers/net/ethernet/Makefile                 |   1 +
> >  drivers/net/ethernet/alibaba/Kconfig          |  29 +
> >  drivers/net/ethernet/alibaba/Makefile         |   5 +
> >  drivers/net/ethernet/alibaba/eea/Makefile     |   9 +
> >  drivers/net/ethernet/alibaba/eea/eea_adminq.c | 464 +++++++++++
> >  drivers/net/ethernet/alibaba/eea/eea_adminq.h |  70 ++
> >  drivers/net/ethernet/alibaba/eea/eea_desc.h   | 153 ++++
> >  .../net/ethernet/alibaba/eea/eea_ethtool.c    | 310 +++++++
> >  .../net/ethernet/alibaba/eea/eea_ethtool.h    |  50 ++
> >  drivers/net/ethernet/alibaba/eea/eea_net.c    | 582 +++++++++++++
> >  drivers/net/ethernet/alibaba/eea/eea_net.h    | 196 +++++
> >  drivers/net/ethernet/alibaba/eea/eea_pci.c    | 548 +++++++++++++
> >  drivers/net/ethernet/alibaba/eea/eea_pci.h    |  66 ++
> >  drivers/net/ethernet/alibaba/eea/eea_ring.c   | 209 +++++
> >  drivers/net/ethernet/alibaba/eea/eea_ring.h   | 144 ++++
> >  drivers/net/ethernet/alibaba/eea/eea_rx.c     | 773 ++++++++++++++++++
> >  drivers/net/ethernet/alibaba/eea/eea_tx.c     | 405 +++++++++
> >  19 files changed, 4023 insertions(+)
>
> This is a large patch.
> And it's difficult to cover 4k lines in a review sitting
> (having spend some time on this, I am getting hungry for lunch by now :).
>
> Please consider breaking it up in a sensible way.
> And if you do so please note that each patch needs to compile (with W=3D1)
> and so on when applied in order so that bisection is not broken.

Thank you very much for your review and the suggestion. We understand the
concern, and we're aware that large patches can be challenging to review.
However, given the nature of this driver and how similar implementations ha=
ve
been handled historically, we don't plan to split this patch at this time, =
as
doing so wouldn't bring significant benefits in this case.

We've already removed most of the features and kept only the core functiona=
lity
=E2=80=94 this is already a minimal implementation.

We've addressed most of the comments and will include the fixes in the next
version. A few remaining items are still under discussion and listed below =
for
reference.

Appreciate your time and effort, and hope you=E2=80=99ve enjoyed your lunch!


>
> >  create mode 100644 drivers/net/ethernet/alibaba/Kconfig
> >  create mode 100644 drivers/net/ethernet/alibaba/Makefile
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/Makefile
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.c
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.h
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_desc.h
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.c
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.h
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.c
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.h
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.c
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.h
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.c
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.h
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_rx.c
> >  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_tx.c
>
> ...
>
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/ne=
t/ethernet/alibaba/eea/eea_adminq.c
>
> ...
>
> > +struct eea_aq_create {
> > +#define EEA_QUEUE_FLAGS_HW_SPLIT_HDR BIT(0)
> > +#define EEA_QUEUE_FLAGS_SQCQ         BIT(1)
> > +#define EEA_QUEUE_FLAGS_HWTS         BIT(2)
> > +	__le32 flags;
> > +	/* queue index.
> > +	 * rx: 0 =3D=3D qidx % 2
> > +	 * tx: 1 =3D=3D qidx % 2
> > +	 */
> > +	__le16 qidx;
> > +	/* the depth of the queue */
> > +	__le16 depth;
> > +	/*  0: without SPLIT HDR
> > +	 *  1: 128B
> > +	 *  2: 256B
> > +	 *  3: 512B
> > +	 */
> > +	u8 hdr_buf_size;
> > +	u8 sq_desc_size;
> > +	u8 cq_desc_size;
> > +	u8 reserve0;
> > +	/* The verctor for the irq. rx,tx share the same vector */
>
> nit: vector
>
>      checkpatch.pl --codespell is your friend
>
> > +	__le16 msix_vector;
> > +	__le16 reserve;
> > +	/* sq ring cfg. */
> > +	__le32 sq_addr_low;
> > +	__le32 sq_addr_high;
> > +	/* cq ring cfg. Just valid when flags include EEA_QUEUE_FLAGS_SQCQ. */
> > +	__le32 cq_addr_low;
> > +	__le32 cq_addr_high;
> > +};
>
> ...
>
> > +static int eea_adminq_exec(struct eea_net *enet, u16 cmd,
> > +			   void *req, u32 req_size, void *res, u32 res_size)
> > +{
> > +	dma_addr_t req_addr, res_addr;
> > +	struct device *dma;
> > +	int ret;
> > +
> > +	dma =3D enet->edev->dma_dev;
> > +
> > +	req_addr =3D 0;
> > +	res_addr =3D 0;
> > +
> > +	if (req) {
> > +		req_addr =3D dma_map_single(dma, req, req_size, DMA_TO_DEVICE);
> > +		if (unlikely(dma_mapping_error(dma, req_addr)))
> > +			return -ENOMEM;
> > +	}
> > +
> > +	if (res) {
> > +		res_addr =3D dma_map_single(dma, res, res_size, DMA_FROM_DEVICE);
> > +		if (unlikely(dma_mapping_error(dma, res_addr))) {
> > +			ret =3D -ENOMEM;
> > +			goto err_map_res;
> > +		}
> > +	}
> > +
> > +	ret =3D eea_adminq_submit(enet, cmd, req_addr, res_addr, req_size, re=
s_size);
>
> Please arrange Networking code so that it is 80 columns wide or less,
> where that can be done without reducing readability. E.g. don't split
> strings across multiple lines. Do wrap lines like the one above like this:
>
> 	ret =3D eea_adminq_submit(enet, cmd, req_addr, res_addr, req_size,
> 				res_size);
>
> Note that the start of the non-whitespace portion of the 2nd line
> is aligned to be exactly inside the opening parentheses of the previous
> line.
>
> checkpatch.pl --max-line-length=3D80 is useful here.

We are aware of the current limit of 100 characters, and we have been coding
according to that guideline. Of course, we try to keep lines within 80
characters where possible. However, in some cases, we find that using up to=
 100
characters improves readability, so 80 is not a strict requirement for us.

Is there a specific rule or convention in the networking area that we should
follow? Sorry, I have not heard of such a rule before.

Here, we think one line is better.

>
> > +
> > +	if (res)
> > +		dma_unmap_single(dma, res_addr, res_size, DMA_FROM_DEVICE);
> > +
> > +err_map_res:
> > +	if (req)
> > +		dma_unmap_single(dma, req_addr, req_size, DMA_TO_DEVICE);
> > +
> > +	return ret;
> > +}
>
> ...
>
> > +struct aq_dev_status *eea_adminq_dev_status(struct eea_net *enet)
> > +{
> > +	struct aq_queue_drv_status *drv_status;
> > +	struct aq_dev_status *dev_status;
> > +	void *req __free(kfree);
> > +	int err, i, num, size;
> > +	struct ering *ering;
> > +	void *rep;
> > +
> > +	num =3D enet->cfg.tx_ring_num * 2 + 1;
> > +
> > +	req =3D kcalloc(num, sizeof(struct aq_queue_drv_status), GFP_KERNEL);
> > +	if (!req)
> > +		return NULL;
> > +
> > +	size =3D struct_size(dev_status, q_status, num);
> > +
> > +	rep =3D kmalloc(size, GFP_KERNEL);
> > +	if (!rep)
> > +		return NULL;
> > +
> > +	drv_status =3D req;
> > +	for (i =3D 0; i < enet->cfg.rx_ring_num * 2; ++i, ++drv_status) {
> > +		ering =3D qid_to_ering(enet, i);
> > +		drv_status->qidx =3D cpu_to_le16(i);
> > +		drv_status->cq_head =3D cpu_to_le16(ering->cq.head);
> > +		drv_status->sq_head =3D cpu_to_le16(ering->sq.head);
> > +	}
> > +
> > +	drv_status->qidx =3D cpu_to_le16(i);
> > +	drv_status->cq_head =3D cpu_to_le16(enet->adminq.ring->cq.head);
> > +	drv_status->sq_head =3D cpu_to_le16(enet->adminq.ring->sq.head);
> > +
> > +	err =3D eea_adminq_exec(enet, EEA_AQ_CMD_DEV_STATUS,
> > +			      req, num * sizeof(struct aq_queue_drv_status),
> > +			      rep, size);
> > +	if (err) {
> > +		kfree(rep);
> > +		return NULL;
> > +	}
> > +
> > +	return rep;
> > +}
>
> This function mixes manual cleanup of rep and automatic cleanup of req.
> I think this is not the best approach and I'd suggest using the idiomatic
> approach of using a goto label ladder to unwind on errors.
>
> 	req =3D kcalloc(...);
> 	if (!req)
> 		return NULL;
>
> 	...
>
> 	rep =3D kmalloc(size, GFP_KERNEL);
> 	if (!rep)
> 		goto error_free_req;
>
> 	...
>
> 	err =3D eea_adminq_exec(...);
> 	if (err)
> 		goto error_free_rep;
>
> 	return rep;
>
> error_free_rep:
> 	kfree(rep);
> error_free_req:
> 	kfree(req);
>
> 	return NULL;
>
> But, if you really want to keep using __free() please do so like this.
> Because although the code is currently correct. It will break if
> it is subsequently modified to return for any reason before
> req is initialised (currently by the return value of kcalloc).
>
>     void *req __free(kfree) =3D NULL;
>
> The reasoning is that __free() is a bit magic and this could
> easily be overlooked in future.


I see.


>
> ...
>
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_desc.h b/drivers/net/=
ethernet/alibaba/eea/eea_desc.h
>
>
> > new file mode 100644
> > index 000000000000..a01288a8435e
> > --- /dev/null
> > +++ b/drivers/net/ethernet/alibaba/eea/eea_desc.h
> > @@ -0,0 +1,153 @@
> > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > +/*
> > + * Driver for Alibaba Elastic Ethernet Adaptor.
> > + *
> > + * Copyright (C) 2025 Alibaba Inc.
> > + */
> > +
> > +#ifndef __EEA_DESC_H__
> > +#define __EEA_DESC_H__
> > +
> > +#define EEA_DESC_TS_MASK (BIT(48) - 1)
>
> I expect GENMASK can be used here.
> And for similar cases elsewhere in this driver.
>
> > +#define EEA_DESC_TS(desc) (le64_to_cpu((desc)->ts) & EEA_DESC_TS_MASK)
>
> ...
>
> > +struct eea_rx_cdesc {
> > +#define EEA_DESC_F_DATA_VALID	BIT(6)
> > +#define EEA_DESC_F_SPLIT_HDR	BIT(5)
> > +	__le16 flags;
> > +	__le16 id;
> > +	__le16 len;
> > +#define EEA_NET_PT_NONE      0
> > +#define EEA_NET_PT_IPv4      1
> > +#define EEA_NET_PT_TCPv4     2
> > +#define EEA_NET_PT_UDPv4     3
> > +#define EEA_NET_PT_IPv6      4
> > +#define EEA_NET_PT_TCPv6     5
> > +#define EEA_NET_PT_UDPv6     6
> > +#define EEA_NET_PT_IPv6_EX   7
> > +#define EEA_NET_PT_TCPv6_EX  8
> > +#define EEA_NET_PT_UDPv6_EX  9
> > +	__le16 pkt_type:10,
> > +	       reserved1:6;
>
> Sparse complains about the above. And I'm not at all sure that
> a __le16 bitfield works as intended on a big endian system.
>
> I would suggest some combination of: FIELD_PREP, FIELD_GET, GENMASK,
> cpu_to_le16() and le16_to_cpu().
>
> Also, please do make sure patches don't introduce new Sparse warnings.

I will try.

Thanks.

>
> > +
> > +	/* hw timestamp [0:47]: ts */
> > +	__le64 ts;
> > +
> > +	__le32 hash;
> > +
> > +	/* 0-9: hdr_len  split header
> > +	 * 10-15: reserved1
> > +	 */
> > +	__le16 len_ex;
> > +	__le16 reserved2;
> > +
> > +	__le32 reserved3;
> > +	__le32 reserved4;
> > +};
>
> ...
>
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_ethtool.c b/drivers/n=
et/ethernet/alibaba/eea/eea_ethtool.c
>
> ...
>
> > +static const struct eea_stat_desc eea_rx_stats_desc[] =3D {
> > +	EEA_RX_STAT(descs),
> > +	EEA_RX_STAT(packets),
> > +	EEA_RX_STAT(bytes),
> > +	EEA_RX_STAT(drops),
> > +	EEA_RX_STAT(kicks),
> > +	EEA_RX_STAT(split_hdr_bytes),
> > +	EEA_RX_STAT(split_hdr_packets),
> > +};
> > +
> > +static const struct eea_stat_desc eea_tx_stats_desc[] =3D {
> > +	EEA_TX_STAT(descs),
> > +	EEA_TX_STAT(packets),
> > +	EEA_TX_STAT(bytes),
> > +	EEA_TX_STAT(drops),
> > +	EEA_TX_STAT(kicks),
> > +	EEA_TX_STAT(timeouts),
> > +};
> > +
> > +#define EEA_TX_STATS_LEN	ARRAY_SIZE(eea_tx_stats_desc)
> > +#define EEA_RX_STATS_LEN	ARRAY_SIZE(eea_rx_stats_desc)
>
> Some of the stats above appear to cover stats covered by struct
> rtnl_link_stats64. And perhaps other standard structures.
> Please only report standard counters using standard mechanisms.
> And only use get_ethtool_stats to report non-standard counters.
>
> Link: https://www.kernel.org/doc/html/v6.16-rc4/networking/statistics.htm=
l#notes-for-driver-authors
>
> ...
>
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/e=
thernet/alibaba/eea/eea_net.c
>
> ...
>
> > +int eea_queues_check_and_reset(struct eea_device *edev)
>
> The return value of this function is not checked.
> So probably it can not return a value at all.
> I.e.
>
> void eea_queues_check_and_reset(struct eea_device *edev)
>
> But if the return value is to be checked then I think that either
> of the following would be best:
> * returning bool
> * returning 0 on sucess, and a negative error value (e.e. -ENOMEM)
>
> Returning -1 in kernel code like this seems odd.
>
> > +{
> > +	struct aq_dev_status *dstatus __free(kfree) =3D NULL;
> > +	struct eea_aq_queue_status *qstatus =3D NULL;
>
> The initialisation of qstatus here seems unnecessary:
> It's not accessed before it is initialised to dstatus->q_status below.
>
> > +	struct eea_aq_queue_status *qs;
> > +	int num, err, i, need_reset =3D 0;
>
> Please arrange local variables in Networking code in reverse xmas tree
> order - longest line to shortest.
>
> Edward Cree's tool can be of assistance here:
> https://github.com/ecree-solarflare/xmastree
>
> > +
> > +	num =3D edev->enet->cfg.tx_ring_num * 2 + 1;
> > +
> > +	rtnl_lock();
> > +
> > +	dstatus =3D eea_adminq_dev_status(edev->enet);
> > +	if (!dstatus) {
> > +		netdev_warn(edev->enet->netdev, "query queue status failed.\n");
> > +		rtnl_unlock();
> > +		return -1;
>
> I would use a goto here.
>
> > +	}
> > +
> > +	if (le16_to_cpu(dstatus->link_status) =3D=3D EEA_LINK_DOWN_STATUS) {
> > +		eea_netdev_stop(edev->enet->netdev);
> > +		edev->enet->link_err =3D EEA_LINK_ERR_LINK_DOWN;
> > +		netdev_warn(edev->enet->netdev, "device link is down. stop device.\n=
");
>
> And here.
>
> > +		rtnl_unlock();
> > +		return 0;
> > +	}
> > +
> > +	qstatus =3D dstatus->q_status;
> > +
> > +	for (i =3D 0; i < num; ++i) {
> > +		qs =3D &qstatus[i];
> > +
> > +		if (le16_to_cpu(qs->status) =3D=3D EEA_QUEUE_STATUS_NEED_RESET) {
> > +			netdev_warn(edev->enet->netdev, "queue status: queue %d needs to re=
set\n",
> > +				    le16_to_cpu(qs->qidx));
> > +			++need_reset;
> > +		}
> > +	}
> > +
> > +	err =3D 0;
> > +	if (need_reset)
> > +		err =3D eea_reset_hw_resources(edev->enet, NULL);
> > +
>
> The label for the goto would go here.
> e.g.:
>
> out_unlock:
>
> > +	rtnl_unlock();
> > +	return err;
> > +}
>
> ...
>
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/e=
thernet/alibaba/eea/eea_pci.c
>
> ...
>
> > +static inline void iowrite64_twopart(u64 val, __le32 __iomem *lo,
> > +				     __le32 __iomem *hi)
>
> If lo and hi are adjacent then I wonder if the callers can be reworked to
> use iowrite64_lo_hi().
>
> If not, please no inline functions in .c files in Networking code unless
> there is a demonstrable reason to do so, usually performance. Rather, let
> the compiler do it's thing and inline code as it sees fit.
>
> > +{
> > +	iowrite32((u32)val, lo);
>
> This cast seems unnecessary.
>
> > +	iowrite32(val >> 32, hi);
> > +}
>
> ...
>
> > +void __force *eea_pci_db_addr(struct eea_device *edev, u32 off)
>
> I'm unsure of the meaning of __force in a function signature.
> Perhaps it can be removed?
>
> > +{
> > +	return (void __force *)edev->ep_dev->db_base + off;
> > +}
>
> Are you sure it is correct to cast-away the __iomem annotation of db_base?
> The intention of that annotation is to help ensure that access
> to iomem is done correctly.
>
> > diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/et=
hernet/alibaba/eea/eea_tx.c
>
> ...
>
> > +static void eea_tx_meta_put_and_unmap(struct enet_tx *tx, struct eea_t=
x_meta *meta)
> > +{
> > +	struct eea_tx_meta *head;
> > +
> > +	head =3D meta;
> > +
> > +	while (true) {
> > +		dma_unmap_single(tx->dma_dev, meta->dma_addr, meta->dma_len, DMA_TO_=
DEVICE);
> > +
> > +		meta->data =3D NULL;
> > +
> > +		if (meta->next) {
> > +			meta =3D meta->next;
> > +			continue;
> > +		}
> > +
> > +		break;
> > +	}
>
> Perhaps this can be expressed more succinctly as follows.
> (Completely untested!)
>
> 	for (; meta->next; meta =3D meta->next) {
> 		dma_unmap_single(tx->dma_dev, meta->dma_addr, meta->dma_len,
> 				 DMA_TO_DEVICE);
> 		meta->data =3D NULL;
> 	}
>
> > +
> > +	meta->next =3D tx->free;
> > +	tx->free =3D head;
> > +}
>
> ...

