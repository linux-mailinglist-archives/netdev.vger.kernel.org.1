Return-Path: <netdev+bounces-209819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DBF8B10FD9
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 18:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E927DB40801
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 16:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280D01DD0D4;
	Thu, 24 Jul 2025 16:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k0eoRstl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C56187332
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 16:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753375464; cv=none; b=qj9HnjIyFBNdKyEjsg3sgZd7XqTokAnDpGEePbLm9e1P/xbcy8ojCnMBebPa10+uOz6OhjVCe6mCBHk5UwLttvkSvm/tH115FnMnIs44Ntt6iChgG8pvyELwVG4wENSVzJlU0l/13eT6bu4M2/4BLg7iP5VWOlVP8IiwsaKLIc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753375464; c=relaxed/simple;
	bh=5/jYf71fERcYxbX2G17SH2n5p0U7GHrMjf24ETW+fN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQwVb+sN+uVao5JJyvicZCJyzfbVmyR/x7AEfwJv2GlCC9bvxJZ7Z/BBmUPFiTOE5DWBCpGKOInO/WMuz4gJDe04lvS3CTFvKQ1FSIaqjBPFyzq+FNlu+RzbaX9fy7rNQ0FekkNn8RVVnrgkSPsH4Cc5cwWuEQtjINn8bnjTxHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k0eoRstl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2F7C4CEED;
	Thu, 24 Jul 2025 16:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753375463;
	bh=5/jYf71fERcYxbX2G17SH2n5p0U7GHrMjf24ETW+fN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k0eoRstlJ+3HZHA6Ly3PRWQOX18XgrlRXc9K2Orrs4NG6q/f1IoRaxsY6goc1reio
	 OriHI0bwJAQkTt5w/hq/mGXUONxBEirBjadxOVLS5yJq8JJrZA4ov9Vj4LD1ZSVVa+
	 vsNJU2gE9gaWwpHNyQ8kegqOYMuPysebuSo1/B5G2x6aVdDIeZrWRb0sezNCnzcN8S
	 gSBzFgzsPAxq5PU5j5M8RZ3HN9+nUDqtqZaqeP8FsS+sut/4H6g5oDxOzfPpPJwmCQ
	 tW9EQvl/l6L//5jK0QvgBZIfOFr6KxiQN2mtzxsJpXTPgPE4pg81XJPRnalGKpiaoL
	 y9uBhKWmDpIxA==
Date: Thu, 24 Jul 2025 17:44:18 +0100
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
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next v1] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
Message-ID: <20250724164418.GB1266901@horms.kernel.org>
References: <20250724110645.88734-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724110645.88734-1-xuanzhuo@linux.alibaba.com>

On Thu, Jul 24, 2025 at 07:06:45PM +0800, Xuan Zhuo wrote:
> Add a driver framework for EEA that will be available in the future.

This is a 40k LoC patch.
It would be nice to add a bit more information about
what it includes.

> 
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---

...

>  19 files changed, 4067 insertions(+)

...

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c

> +int eea_adminq_config_host_info(struct eea_net *enet)
> +{
> +	struct device *dev = enet->edev->dma_dev;
> +	struct eea_aq_host_info_cfg *cfg;
> +	struct eea_aq_host_info_rep *rep;
> +	int rc = -ENOMEM;
> +
> +	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> +	if (!cfg)
> +		return rc;
> +
> +	rep = kzalloc(sizeof(*rep), GFP_KERNEL);
> +	if (!rep)
> +		goto free_cfg;
> +
> +	cfg->os_type = EEA_OS_LINUX;

The type of the lvalue above is a little endian integer.
While the type of the rvalue is a host byte order integer.
I would address this as follows:

	cfg->os_type = cpu_to_le16(EEA_OS_LINUX);

Likewise for other members of cfg set in this function,
noting that pci_domain is a 32bit entity.

Flagged by Sparse.

There are a number of other (minor) problems flagged by Sparse
in this patch. Please address them and make sure patches
are Sparse-clean.

> +	cfg->os_dist = EEA_OS_DISTRO;
> +	cfg->drv_type = EEA_DRV_TYPE;
> +
> +	if (sscanf(utsname()->release, "%hu.%hu.%hu", &cfg->kern_ver_major,
> +		   &cfg->kern_ver_minor, &cfg->kern_ver_sub_minor) != 3) {
> +		rc = -EINVAL;
> +		goto free_rep;
> +	}
> +
> +	cfg->drv_ver_major	= EEA_VER_MAJOR;
> +	cfg->drv_ver_minor	= EEA_VER_MINOR;
> +	cfg->drv_ver_sub_minor	= EEA_VER_SUB_MINOR;
> +
> +	cfg->spec_ver_major	= EEA_SPEC_VER_MAJOR;
> +	cfg->spec_ver_minor	= EEA_SPEC_VER_MINOR;
> +
> +	cfg->pci_bdf		= eea_pci_dev_id(enet->edev);
> +	cfg->pci_domain		= eea_pci_domain_nr(enet->edev);
> +
> +	strscpy(cfg->os_ver_str, utsname()->release, sizeof(cfg->os_ver_str));
> +	strscpy(cfg->isa_str, utsname()->machine, sizeof(cfg->isa_str));
> +
> +	rc = eea_adminq_exec(enet, EEA_AQ_CMD_HOST_INFO,
> +			     cfg, sizeof(*cfg), rep, sizeof(*rep));
> +
> +	if (!rc) {
> +		if (rep->op_code == EEA_HINFO_REP_REJECT) {
> +			dev_err(dev, "Device has refused the initialization "
> +				"due to provided host information\n");
> +			rc = -ENODEV;
> +		}
> +		if (rep->has_reply) {
> +			rep->reply_str[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
> +			dev_warn(dev, "Device replied in host_info config: %s",
> +				 rep->reply_str);
> +		}
> +	}
> +
> +free_rep:
> +	kfree(rep);
> +free_cfg:
> +	kfree(cfg);
> +	return rc;
> +}

...

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c

...

> +int eea_queues_check_and_reset(struct eea_device *edev)
> +{
> +	struct aq_dev_status *dstatus __free(kfree) = NULL;
> +	struct eea_aq_queue_status *qstatus;
> +	int num, err, i, need_reset = 0;
> +	struct eea_aq_queue_status *qs;
> +
> +	num = edev->enet->cfg.tx_ring_num * 2 + 1;
> +
> +	rtnl_lock();
> +
> +	dstatus = eea_adminq_dev_status(edev->enet);
> +	if (!dstatus) {
> +		netdev_warn(edev->enet->netdev, "query queue status failed.\n");
> +		rtnl_unlock();
> +		return -ENOMEM;
> +	}
> +
> +	if (le16_to_cpu(dstatus->link_status) == EEA_LINK_DOWN_STATUS) {
> +		eea_netdev_stop(edev->enet->netdev);
> +		edev->enet->link_err = EEA_LINK_ERR_LINK_DOWN;
> +		netdev_warn(edev->enet->netdev, "device link is down. stop device.\n");
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

nit: I thunk %u would be more appropriate here, as the value is unsigned

> +				    le16_to_cpu(qs->qidx));
> +			++need_reset;
> +		}
> +	}
> +
> +	err = 0;
> +	if (need_reset)
> +		err = eea_reset_hw_resources(edev->enet, NULL);
> +
> +	rtnl_unlock();
> +	return err;
> +}

...

> +void *ering_cq_get_desc(const struct ering *ering)
> +{
> +	u8 phase;
> +	u8 *desc;
> +
> +	desc = ering->cq.desc + (ering->cq.head << ering->cq.desc_size_shift);
> +
> +	phase = *(u8 *)(desc + ering->cq.desc_size - 1);
> +
> +	if ((phase & ERING_DESC_F_CQ_PHASE)  == ering->cq.phase) {

nit: unnecessary inner-parentheses
     extra whitespace before '==': one is enough

> +		dma_rmb();
> +		return desc;
> +	}
> +
> +	return NULL;
> +}
> +
> +/* sq api */
> +void *ering_sq_alloc_desc(struct ering *ering, u16 id, bool is_last, u16 flags)
> +{
> +	struct ering_sq *sq = &ering->sq;
> +	struct common_desc *desc;
> +
> +	if (!sq->shadow_num) {
> +		sq->shadow_idx = sq->head;
> +		sq->shadow_id = cpu_to_le16(id);
> +	}
> +
> +	if (!is_last)
> +		flags |= ERING_DESC_F_MORE;
> +
> +	desc = sq->desc + (sq->shadow_idx << sq->desc_size_shift);

This logic seems to be repeated. Maybe a helper is appropriate.

> +
> +	desc->flags = cpu_to_le16(flags);
> +	desc->id = sq->shadow_id;
> +
> +	if ((unlikely(++sq->shadow_idx >= ering->num)))

nit: unnecessary outer parentheses: one is enough

> +		sq->shadow_idx = 0;
> +
> +	++sq->shadow_num;
> +
> +	return desc;
> +}
> +
> +void *ering_aq_alloc_desc(struct ering *ering)
> +{
> +	struct ering_sq *sq = &ering->sq;
> +	struct common_desc *desc;
> +
> +	sq->shadow_idx = sq->head;
> +
> +	desc = sq->desc + (sq->shadow_idx << sq->desc_size_shift);
> +
> +	if ((unlikely(++sq->shadow_idx >= ering->num)))

Ditto

> +		sq->shadow_idx = 0;
> +
> +	++sq->shadow_num;
> +
> +	return desc;
> +}

...

> +static void *ering_alloc_queue(struct eea_device *edev, size_t size,
> +			       dma_addr_t *dma_handle)
> +{
> +	u32 flags = GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO;

Sparse warns that the type of flags should be gfp_t.

> +
> +	return dma_alloc_coherent(edev->dma_dev, size, dma_handle, flags);
> +}

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_rx.c b/drivers/net/ethernet/alibaba/eea/eea_rx.c

...

> +static void meta_align_offset(struct enet_rx *rx, struct eea_rx_meta *meta)
> +{
> +	int h = rx->headroom;
> +	int b = meta->offset + h;

As is mostly the case in this patchset, please follow reverse xmas tree -
longest line to shortest - for local variable declarations.

In this case, this could be:

	int b, h;

	h = rx->headroom;
	b = meta->offset + h;

Edward Cree's tool can help in this area:
https://github.com/ecree-solarflare/xmastree


> +
> +	if (!IS_ALIGNED(b, 128))
> +		b = ALIGN(b, 128);

nit: I wonder if this conditional gives us any value.
     Can this just be:

	b = ALIGN(b, 128);

> +
> +	meta->offset = b - h;
> +}

...

> +static int eea_rx_post(struct eea_net *enet,
> +		       struct enet_rx *rx, gfp_t gfp)
> +{
> +	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +	u32 headroom = rx->headroom;
> +	u32 room = headroom + tailroom;
> +	struct eea_rx_meta *meta;
> +	struct eea_rx_desc *desc;
> +	int err = 0, num = 0;
> +	dma_addr_t addr;
> +	u32 flags, len;
> +
> +	while (true) {
> +		meta = eea_rx_meta_get(rx);
> +		if (!meta)
> +			break;
> +
> +		err = eea_alloc_rx_buffer(rx, meta);
> +		if (err) {
> +			eea_rx_meta_put(rx, meta);
> +			break;
> +		}
> +
> +		len = PAGE_SIZE - meta->offset - room;
> +		addr = meta->dma + meta->offset + headroom;
> +
> +		desc = ering_sq_alloc_desc(rx->ering, meta->id, true, 0);
> +		desc->addr = cpu_to_le64(addr);
> +		desc->len = cpu_to_le32(len);
> +
> +		if (meta->hdr_addr)
> +			desc->hdr_addr = cpu_to_le64(meta->hdr_dma);
> +
> +		ering_sq_commit_desc(rx->ering);
> +
> +		meta->truesize = len + room;
> +		meta->headroom = headroom;
> +		meta->tailroom = tailroom;
> +		meta->len = len;
> +		++num;
> +	}
> +
> +	if (num) {
> +		ering_kick(rx->ering);
> +
> +		flags = u64_stats_update_begin_irqsave(&rx->stats.syncp);
> +		u64_stats_inc(&rx->stats.kicks);
> +		u64_stats_update_end_irqrestore(&rx->stats.syncp, flags);
> +	}
> +
> +	/* true means busy, napi should be called again. */
> +	return !!err;

I wonder if the return type of this function should be bool.

> +}
> +
> +int eea_poll(struct napi_struct *napi, int budget)
> +{
> +	struct enet_rx *rx = container_of(napi, struct enet_rx, napi);
> +	struct eea_net *enet = rx->enet;
> +	struct enet_tx *tx = &enet->tx[rx->index];
> +	struct rx_ctx ctx = {};
> +	bool busy = false;
> +	u32 received;
> +
> +	eea_poll_tx(tx, budget);
> +
> +	received = eea_cleanrx(rx, budget, &ctx);
> +
> +	if (rx->ering->num_free > budget)
> +		busy |= eea_rx_post(enet, rx, GFP_ATOMIC);
> +
> +	eea_update_rx_stats(&rx->stats, &ctx.stats);
> +
> +	busy |= (received >= budget);

nit: unnecessary parentheses

> +
> +	if (!busy) {
> +		if (napi_complete_done(napi, received))
> +			ering_irq_active(rx->ering, tx->ering);
> +	}
> +
> +	if (busy)
> +		return budget;
> +
> +	return budget - 1;
> +}

...

