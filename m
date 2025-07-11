Return-Path: <netdev+bounces-206116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D765B01A30
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 12:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3E087B34B4
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 10:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A1C28D8DF;
	Fri, 11 Jul 2025 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CYoR4lvM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D728CF74
	for <netdev@vger.kernel.org>; Fri, 11 Jul 2025 10:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231352; cv=none; b=UkHU2tu8vp10hArtsoSc8ouVHO2f2oPR6LLvnOwaTewT0pk5ePENsuYsUuKFXNfOeTCdgQKbR9mOogzd3WgS8JvbtTxmrmhaqvC1TlgDU/EK0Iu1Jw+CnYDHiYiUQDNV5oh3ZsXp0nbO2D+fJqpKxtL2xWtYqMRJJuASk2g9Wkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231352; c=relaxed/simple;
	bh=CkrzGUMs0rytj3v721n0Wd48bdyg4FhRhNmPZ5fW2WQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LVLy1PGpU2dSqeQmF6XY54rQRa3tR7kQsUg/iDSzoARk8qmYudZ4EQ7CKutw/kpnO+jNYDdxV478nxRhlLNaqrW0TTlzeZRuFNpHEVGBN+rsFIwN9FxTXblnMP/0Ivn2ph+2DgH77iBp4RcT0V4zjo2LCktO1l+XGd9LD5Sh7K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CYoR4lvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3233C4CEED;
	Fri, 11 Jul 2025 10:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752231352;
	bh=CkrzGUMs0rytj3v721n0Wd48bdyg4FhRhNmPZ5fW2WQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CYoR4lvMBhLAkUQqImg+9CiaL2XRNiqJU5/UvkWLZ3J/8pNrCWNPwljaSCzbOhwqt
	 MA0zT5G6IsdaIFRqtSgqIBrvLwZnuMUA2RDmtrExoms2CpXh/XlHbh9HzrGq3TN1FX
	 WjMi7gBlUIa40rhtQo/iF9BfP0DMyaUJWXmLQOlAT86IyOyI3zx9yZsrfEN8gteUMd
	 SvdhIauzgw3XrB755Cfonl730EKqVtoZIu4mrMNJqRSlzZwgT4qcdYKWxPMMLVtkuF
	 PbfvfwscdrOrv4vWkqW3AWcx9Ei/c+jrMBqxCZQ8GBEwk1J1U6rSpnTqT2Z7JASO/+
	 oKOVYXjSfyDlw==
Date: Fri, 11 Jul 2025 11:55:46 +0100
From: Simon Horman <horms@kernel.org>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
Message-ID: <20250711105546.GT721198@horms.kernel.org>
References: <20250710112817.85741-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710112817.85741-1-xuanzhuo@linux.alibaba.com>

On Thu, Jul 10, 2025 at 07:28:17PM +0800, Xuan Zhuo wrote:
> Add a driver framework for EEA that will be available in the future.
> 
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  MAINTAINERS                                   |   8 +
>  drivers/net/ethernet/Kconfig                  |   1 +
>  drivers/net/ethernet/Makefile                 |   1 +
>  drivers/net/ethernet/alibaba/Kconfig          |  29 +
>  drivers/net/ethernet/alibaba/Makefile         |   5 +
>  drivers/net/ethernet/alibaba/eea/Makefile     |   9 +
>  drivers/net/ethernet/alibaba/eea/eea_adminq.c | 464 +++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_adminq.h |  70 ++
>  drivers/net/ethernet/alibaba/eea/eea_desc.h   | 153 ++++
>  .../net/ethernet/alibaba/eea/eea_ethtool.c    | 310 +++++++
>  .../net/ethernet/alibaba/eea/eea_ethtool.h    |  50 ++
>  drivers/net/ethernet/alibaba/eea/eea_net.c    | 582 +++++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_net.h    | 196 +++++
>  drivers/net/ethernet/alibaba/eea/eea_pci.c    | 548 +++++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_pci.h    |  66 ++
>  drivers/net/ethernet/alibaba/eea/eea_ring.c   | 209 +++++
>  drivers/net/ethernet/alibaba/eea/eea_ring.h   | 144 ++++
>  drivers/net/ethernet/alibaba/eea/eea_rx.c     | 773 ++++++++++++++++++
>  drivers/net/ethernet/alibaba/eea/eea_tx.c     | 405 +++++++++
>  19 files changed, 4023 insertions(+)

This is a large patch.
And it's difficult to cover 4k lines in a review sitting
(having spend some time on this, I am getting hungry for lunch by now :).

Please consider breaking it up in a sensible way.
And if you do so please note that each patch needs to compile (with W=1)
and so on when applied in order so that bisection is not broken.

>  create mode 100644 drivers/net/ethernet/alibaba/Kconfig
>  create mode 100644 drivers/net/ethernet/alibaba/Makefile
>  create mode 100644 drivers/net/ethernet/alibaba/eea/Makefile
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_desc.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.h
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_rx.c
>  create mode 100644 drivers/net/ethernet/alibaba/eea/eea_tx.c

...

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c

...

> +struct eea_aq_create {
> +#define EEA_QUEUE_FLAGS_HW_SPLIT_HDR BIT(0)
> +#define EEA_QUEUE_FLAGS_SQCQ         BIT(1)
> +#define EEA_QUEUE_FLAGS_HWTS         BIT(2)
> +	__le32 flags;
> +	/* queue index.
> +	 * rx: 0 == qidx % 2
> +	 * tx: 1 == qidx % 2
> +	 */
> +	__le16 qidx;
> +	/* the depth of the queue */
> +	__le16 depth;
> +	/*  0: without SPLIT HDR
> +	 *  1: 128B
> +	 *  2: 256B
> +	 *  3: 512B
> +	 */
> +	u8 hdr_buf_size;
> +	u8 sq_desc_size;
> +	u8 cq_desc_size;
> +	u8 reserve0;
> +	/* The verctor for the irq. rx,tx share the same vector */

nit: vector

     checkpatch.pl --codespell is your friend

> +	__le16 msix_vector;
> +	__le16 reserve;
> +	/* sq ring cfg. */
> +	__le32 sq_addr_low;
> +	__le32 sq_addr_high;
> +	/* cq ring cfg. Just valid when flags include EEA_QUEUE_FLAGS_SQCQ. */
> +	__le32 cq_addr_low;
> +	__le32 cq_addr_high;
> +};

...

> +static int eea_adminq_exec(struct eea_net *enet, u16 cmd,
> +			   void *req, u32 req_size, void *res, u32 res_size)
> +{
> +	dma_addr_t req_addr, res_addr;
> +	struct device *dma;
> +	int ret;
> +
> +	dma = enet->edev->dma_dev;
> +
> +	req_addr = 0;
> +	res_addr = 0;
> +
> +	if (req) {
> +		req_addr = dma_map_single(dma, req, req_size, DMA_TO_DEVICE);
> +		if (unlikely(dma_mapping_error(dma, req_addr)))
> +			return -ENOMEM;
> +	}
> +
> +	if (res) {
> +		res_addr = dma_map_single(dma, res, res_size, DMA_FROM_DEVICE);
> +		if (unlikely(dma_mapping_error(dma, res_addr))) {
> +			ret = -ENOMEM;
> +			goto err_map_res;
> +		}
> +	}
> +
> +	ret = eea_adminq_submit(enet, cmd, req_addr, res_addr, req_size, res_size);

Please arrange Networking code so that it is 80 columns wide or less,
where that can be done without reducing readability. E.g. don't split
strings across multiple lines. Do wrap lines like the one above like this:

	ret = eea_adminq_submit(enet, cmd, req_addr, res_addr, req_size,
				res_size);

Note that the start of the non-whitespace portion of the 2nd line
is aligned to be exactly inside the opening parentheses of the previous
line.

checkpatch.pl --max-line-length=80 is useful here.

> +
> +	if (res)
> +		dma_unmap_single(dma, res_addr, res_size, DMA_FROM_DEVICE);
> +
> +err_map_res:
> +	if (req)
> +		dma_unmap_single(dma, req_addr, req_size, DMA_TO_DEVICE);
> +
> +	return ret;
> +}

...

> +struct aq_dev_status *eea_adminq_dev_status(struct eea_net *enet)
> +{
> +	struct aq_queue_drv_status *drv_status;
> +	struct aq_dev_status *dev_status;
> +	void *req __free(kfree);
> +	int err, i, num, size;
> +	struct ering *ering;
> +	void *rep;
> +
> +	num = enet->cfg.tx_ring_num * 2 + 1;
> +
> +	req = kcalloc(num, sizeof(struct aq_queue_drv_status), GFP_KERNEL);
> +	if (!req)
> +		return NULL;
> +
> +	size = struct_size(dev_status, q_status, num);
> +
> +	rep = kmalloc(size, GFP_KERNEL);
> +	if (!rep)
> +		return NULL;
> +
> +	drv_status = req;
> +	for (i = 0; i < enet->cfg.rx_ring_num * 2; ++i, ++drv_status) {
> +		ering = qid_to_ering(enet, i);
> +		drv_status->qidx = cpu_to_le16(i);
> +		drv_status->cq_head = cpu_to_le16(ering->cq.head);
> +		drv_status->sq_head = cpu_to_le16(ering->sq.head);
> +	}
> +
> +	drv_status->qidx = cpu_to_le16(i);
> +	drv_status->cq_head = cpu_to_le16(enet->adminq.ring->cq.head);
> +	drv_status->sq_head = cpu_to_le16(enet->adminq.ring->sq.head);
> +
> +	err = eea_adminq_exec(enet, EEA_AQ_CMD_DEV_STATUS,
> +			      req, num * sizeof(struct aq_queue_drv_status),
> +			      rep, size);
> +	if (err) {
> +		kfree(rep);
> +		return NULL;
> +	}
> +
> +	return rep;
> +}

This function mixes manual cleanup of rep and automatic cleanup of req.
I think this is not the best approach and I'd suggest using the idiomatic
approach of using a goto label ladder to unwind on errors.

	req = kcalloc(...);
	if (!req)
		return NULL;

	...

	rep = kmalloc(size, GFP_KERNEL);
	if (!rep)
		goto error_free_req;

	...

	err = eea_adminq_exec(...);
	if (err)
		goto error_free_rep;

	return rep;

error_free_rep:
	kfree(rep);
error_free_req:
	kfree(req);

	return NULL;

But, if you really want to keep using __free() please do so like this.
Because although the code is currently correct. It will break if
it is subsequently modified to return for any reason before
req is initialised (currently by the return value of kcalloc).

    void *req __free(kfree) = NULL;

The reasoning is that __free() is a bit magic and this could
easily be overlooked in future.

...

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_desc.h b/drivers/net/ethernet/alibaba/eea/eea_desc.h


> new file mode 100644
> index 000000000000..a01288a8435e
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_desc.h
> @@ -0,0 +1,153 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Driver for Alibaba Elastic Ethernet Adaptor.
> + *
> + * Copyright (C) 2025 Alibaba Inc.
> + */
> +
> +#ifndef __EEA_DESC_H__
> +#define __EEA_DESC_H__
> +
> +#define EEA_DESC_TS_MASK (BIT(48) - 1)

I expect GENMASK can be used here.
And for similar cases elsewhere in this driver.

> +#define EEA_DESC_TS(desc) (le64_to_cpu((desc)->ts) & EEA_DESC_TS_MASK)

...

> +struct eea_rx_cdesc {
> +#define EEA_DESC_F_DATA_VALID	BIT(6)
> +#define EEA_DESC_F_SPLIT_HDR	BIT(5)
> +	__le16 flags;
> +	__le16 id;
> +	__le16 len;
> +#define EEA_NET_PT_NONE      0
> +#define EEA_NET_PT_IPv4      1
> +#define EEA_NET_PT_TCPv4     2
> +#define EEA_NET_PT_UDPv4     3
> +#define EEA_NET_PT_IPv6      4
> +#define EEA_NET_PT_TCPv6     5
> +#define EEA_NET_PT_UDPv6     6
> +#define EEA_NET_PT_IPv6_EX   7
> +#define EEA_NET_PT_TCPv6_EX  8
> +#define EEA_NET_PT_UDPv6_EX  9
> +	__le16 pkt_type:10,
> +	       reserved1:6;

Sparse complains about the above. And I'm not at all sure that
a __le16 bitfield works as intended on a big endian system.

I would suggest some combination of: FIELD_PREP, FIELD_GET, GENMASK,
cpu_to_le16() and le16_to_cpu().

Also, please do make sure patches don't introduce new Sparse warnings.

> +
> +	/* hw timestamp [0:47]: ts */
> +	__le64 ts;
> +
> +	__le32 hash;
> +
> +	/* 0-9: hdr_len  split header
> +	 * 10-15: reserved1
> +	 */
> +	__le16 len_ex;
> +	__le16 reserved2;
> +
> +	__le32 reserved3;
> +	__le32 reserved4;
> +};

...

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_ethtool.c b/drivers/net/ethernet/alibaba/eea/eea_ethtool.c

...

> +static const struct eea_stat_desc eea_rx_stats_desc[] = {
> +	EEA_RX_STAT(descs),
> +	EEA_RX_STAT(packets),
> +	EEA_RX_STAT(bytes),
> +	EEA_RX_STAT(drops),
> +	EEA_RX_STAT(kicks),
> +	EEA_RX_STAT(split_hdr_bytes),
> +	EEA_RX_STAT(split_hdr_packets),
> +};
> +
> +static const struct eea_stat_desc eea_tx_stats_desc[] = {
> +	EEA_TX_STAT(descs),
> +	EEA_TX_STAT(packets),
> +	EEA_TX_STAT(bytes),
> +	EEA_TX_STAT(drops),
> +	EEA_TX_STAT(kicks),
> +	EEA_TX_STAT(timeouts),
> +};
> +
> +#define EEA_TX_STATS_LEN	ARRAY_SIZE(eea_tx_stats_desc)
> +#define EEA_RX_STATS_LEN	ARRAY_SIZE(eea_rx_stats_desc)

Some of the stats above appear to cover stats covered by struct
rtnl_link_stats64. And perhaps other standard structures.
Please only report standard counters using standard mechanisms.
And only use get_ethtool_stats to report non-standard counters.

Link: https://www.kernel.org/doc/html/v6.16-rc4/networking/statistics.html#notes-for-driver-authors

...

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c

...

> +int eea_queues_check_and_reset(struct eea_device *edev)

The return value of this function is not checked.
So probably it can not return a value at all.
I.e.

void eea_queues_check_and_reset(struct eea_device *edev)

But if the return value is to be checked then I think that either
of the following would be best:
* returning bool
* returning 0 on sucess, and a negative error value (e.e. -ENOMEM)

Returning -1 in kernel code like this seems odd.

> +{
> +	struct aq_dev_status *dstatus __free(kfree) = NULL;
> +	struct eea_aq_queue_status *qstatus = NULL;

The initialisation of qstatus here seems unnecessary:
It's not accessed before it is initialised to dstatus->q_status below.

> +	struct eea_aq_queue_status *qs;
> +	int num, err, i, need_reset = 0;

Please arrange local variables in Networking code in reverse xmas tree
order - longest line to shortest.

Edward Cree's tool can be of assistance here:
https://github.com/ecree-solarflare/xmastree

> +
> +	num = edev->enet->cfg.tx_ring_num * 2 + 1;
> +
> +	rtnl_lock();
> +
> +	dstatus = eea_adminq_dev_status(edev->enet);
> +	if (!dstatus) {
> +		netdev_warn(edev->enet->netdev, "query queue status failed.\n");
> +		rtnl_unlock();
> +		return -1;

I would use a goto here.

> +	}
> +
> +	if (le16_to_cpu(dstatus->link_status) == EEA_LINK_DOWN_STATUS) {
> +		eea_netdev_stop(edev->enet->netdev);
> +		edev->enet->link_err = EEA_LINK_ERR_LINK_DOWN;
> +		netdev_warn(edev->enet->netdev, "device link is down. stop device.\n");

And here.

> +		rtnl_unlock();
> +		return 0;
> +	}
> +
> +	qstatus = dstatus->q_status;
> +
> +	for (i = 0; i < num; ++i) {
> +		qs = &qstatus[i];
> +
> +		if (le16_to_cpu(qs->status) == EEA_QUEUE_STATUS_NEED_RESET) {
> +			netdev_warn(edev->enet->netdev, "queue status: queue %d needs to reset\n",
> +				    le16_to_cpu(qs->qidx));
> +			++need_reset;
> +		}
> +	}
> +
> +	err = 0;
> +	if (need_reset)
> +		err = eea_reset_hw_resources(edev->enet, NULL);
> +

The label for the goto would go here.
e.g.:

out_unlock:

> +	rtnl_unlock();
> +	return err;
> +}

...

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c

...

> +static inline void iowrite64_twopart(u64 val, __le32 __iomem *lo,
> +				     __le32 __iomem *hi)

If lo and hi are adjacent then I wonder if the callers can be reworked to
use iowrite64_lo_hi().

If not, please no inline functions in .c files in Networking code unless
there is a demonstrable reason to do so, usually performance. Rather, let
the compiler do it's thing and inline code as it sees fit.

> +{
> +	iowrite32((u32)val, lo);

This cast seems unnecessary.

> +	iowrite32(val >> 32, hi);
> +}

...

> +void __force *eea_pci_db_addr(struct eea_device *edev, u32 off)

I'm unsure of the meaning of __force in a function signature.
Perhaps it can be removed?

> +{
> +	return (void __force *)edev->ep_dev->db_base + off;
> +}

Are you sure it is correct to cast-away the __iomem annotation of db_base?
The intention of that annotation is to help ensure that access
to iomem is done correctly.

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/ethernet/alibaba/eea/eea_tx.c

...

> +static void eea_tx_meta_put_and_unmap(struct enet_tx *tx, struct eea_tx_meta *meta)
> +{
> +	struct eea_tx_meta *head;
> +
> +	head = meta;
> +
> +	while (true) {
> +		dma_unmap_single(tx->dma_dev, meta->dma_addr, meta->dma_len, DMA_TO_DEVICE);
> +
> +		meta->data = NULL;
> +
> +		if (meta->next) {
> +			meta = meta->next;
> +			continue;
> +		}
> +
> +		break;
> +	}

Perhaps this can be expressed more succinctly as follows.
(Completely untested!)

	for (; meta->next; meta = meta->next) {
		dma_unmap_single(tx->dma_dev, meta->dma_addr, meta->dma_len,
				 DMA_TO_DEVICE);
		meta->data = NULL;
	}	

> +
> +	meta->next = tx->free;
> +	tx->free = head;
> +}

...

