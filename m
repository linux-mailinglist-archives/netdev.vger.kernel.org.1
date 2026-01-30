Return-Path: <netdev+bounces-255272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH0nIKA/fWmoRAIAu9opvQ
	(envelope-from <netdev+bounces-255272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 00:32:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 23585BF61E
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 00:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 390A5300830C
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 23:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8B236AB6E;
	Fri, 30 Jan 2026 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rl2jT3+D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9900035BDBC
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 23:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769815965; cv=none; b=oSXerNvmfh+MmXAoGat2koHuEB0EL9KyL2ax6P2Ss3I7L2MlYduM/6xqxN7DS+Ffi3137nQtW+QcYn3mE7YOl5uiY4y3hXXptTifD6l+Je3ZWAr1NYEL3eAaVnbyPvFPJwevf2ady4kXfgCN54JVnRpVdio199igOcho6L/nqG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769815965; c=relaxed/simple;
	bh=d/h304ukK0GXxv3BfTPX4/5hvZmMXtS72A/BlC5G3Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwsCTl4nxvJ3gqIsPU4vh3HWcChV5GJPrXAOxC7oAghFz4ymFVAPeIqa+kQIUQgySt1Xfq6P806M+ADZ0ZTYsuM4wLnEPeethzQqEUTysrnxf3iPiyonBEmRJ65u89FXnKsEfts2ajfAjeVHflYc2RNV0E+x+hc8kRXcr5f9E9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rl2jT3+D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65670C16AAE;
	Fri, 30 Jan 2026 23:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769815965;
	bh=d/h304ukK0GXxv3BfTPX4/5hvZmMXtS72A/BlC5G3Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rl2jT3+DWPyH7vpXr3B+hXOUF3VjUEUBRKmdZM8i4oar7OW+9hD98AOlzeaWeMO0X
	 ki01Mm3dlHZ01YdndlVlTLMOE3LLU+YJGgvFj/zU9V9hwGcdNRKNKE5ZuavhrG0dzK
	 VP90673WQT1UrFF2YLEe/SIjPCKXmwZXr07RwVbQONTnLRPVLxSCzTfM6pEFth1/Cc
	 BTkuQPY7S/uYFXBpuO9yJfm5OjynCPKc5qckWS/VtTStmdlXwxvQgD2IgYJxITg2Qa
	 qvd+d9NwHiEDloQtVXAej//VY2dDVtc01vKHj9U75MfWCIwtorKUWhUDVUxJRMVzMs
	 PncjJ6yxEakXg==
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	lulie@linux.alibaba.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	guwen@linux.alibaba.com,
	dong100@mucse.com,
	lukas.bulwahn@redhat.com,
	vadim.fedorenko@linux.dev,
	enelsonmoore@gmail.com
Subject: Re: [net-next,v24,4/6] eea: create/destroy rx,tx queues for netdevice open and stop
Date: Fri, 30 Jan 2026 15:32:43 -0800
Message-ID: <20260130233243.923376-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130093412.98407-5-xuanzhuo@linux.alibaba.com>
References: <20260130093412.98407-5-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,linux.alibaba.com,google.com,davemloft.net,redhat.com,vger.kernel.org,mucse.com,linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-255272-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23585BF61E
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
eea: create/destroy rx,tx queues for netdevice open and stop

This commit introduces the implementation for netdevice open and stop in
the Alibaba Elastic Ethernet Adapter (EEA) driver, including RX/TX queue
allocation, NAPI setup, and resource management.

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
> index 65b236c412a9..4897c07a25ae 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_net.c
> +++ b/drivers/net/ethernet/alibaba/eea/eea_net.c

[ ... ]

> +static int enet_bind_new_q_and_cfg(struct eea_net *enet,
> +				   struct eea_net_init_ctx *ctx)
> +{
> +	struct eea_net_rx *rx;
> +	struct eea_net_tx *tx;
> +	int i, err;
> +
> +	err = netif_set_real_num_queues(enet->netdev, ctx->cfg.tx_ring_num,
> +					ctx->cfg.rx_ring_num);
> +	if (err)
> +		return err;
> +
> +	enet->cfg = ctx->cfg;
> +
> +	enet->rx = ctx->rx;
> +	enet->tx = ctx->tx;
> +
> +	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
> +		rx = ctx->rx[i];
> +		tx = &ctx->tx[i];

Does this code overflow ctx->tx when rx_ring_num > tx_ring_num?

The driver reads rx_num and tx_num from separate hardware registers
(eea_pci.c:212-213), but assumes they're always equal without validation.
The ctx->tx array is allocated with tx_ring_num elements at
eea_alloc_rxtx_q_mem:89, while ctx->rx is allocated with rx_ring_num
elements at line 93. Then this loop iterates to rx_ring_num and accesses
ctx->tx[i].

If the hardware returns rx_num=4 and tx_num=2, the driver allocates ctx->tx
with 2 elements but this loop accesses ctx->tx[2] and ctx->tx[3], which are
out-of-bounds.

The same issue appears in:
- eea_alloc_rxtx_q_mem:114 accessing ctx->tx[i]
- eea_alloc_rxtx_q_mem:123 in the error path
- eea_free_rxtx_q_mem:70
- eea_queues_check_and_reset in error handling

The driver uses a "queue pairs" model, but fails to validate or enforce
this constraint on hardware-provided values.

> +
> +		rx->enet = enet;
> +		tx->enet = enet;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +/* alloc tx/rx: struct, ring, meta, pp, napi */
> +static int eea_alloc_rxtx_q_mem(struct eea_net_init_ctx *ctx)
> +{
> +	struct eea_net_cfg *cfg = &ctx->cfg;
> +	struct eea_net_rx *rx;
> +	struct eea_net_tx *tx;
> +	int err, i;
> +
> +	ctx->tx = kvcalloc(cfg->tx_ring_num, sizeof(*ctx->tx), GFP_KERNEL);
> +	if (!ctx->tx)
> +		return -ENOMEM;
> +
> +	ctx->rx = kvcalloc(cfg->rx_ring_num, sizeof(*ctx->rx), GFP_KERNEL);
> +	if (!ctx->rx) {
> +		err = -ENOMEM;
> +		goto err_free;
> +	}
> +
> +	/* modify cfg for alloc */
> +	ctx->cfg.tx_cq_desc_size /= 2;
> +
> +	if (!ctx->cfg.split_hdr)
> +		ctx->cfg.rx_sq_desc_size /= 2;
> +
> +	for (i = 0; i < ctx->cfg.rx_ring_num; i++) {
> +		rx = eea_alloc_rx(ctx, i);
> +		if (!rx)
> +			goto err_free;
> +
> +		ctx->rx[i] = rx;
> +
> +		tx = ctx->tx + i;
> +		err = eea_alloc_tx(ctx, tx, i);
> +		if (err)
> +			goto err_free;
> +	}

[ ... ]

> +static int eea_netdev_open(struct net_device *dev)
> +{
> +	struct eea_net *enet = netdev_priv(dev);
> +	struct eea_net_init_ctx ctx;
> +	int err;
> +
> +	enet_init_ctx(enet, &ctx);
> +
> +	err = eea_alloc_rxtx_q_mem(&ctx);
> +	if (err)
> +		return err;
> +
> +	err = enet_bind_new_q_and_cfg(enet, &ctx);
> +	if (err)
> +		goto err_free_q;
> +
> +	err = eea_active_ring_and_irq(enet);
> +	if (err)
> +		goto err_free_q;
> +
> +	eea_start_rxtx(enet);
> +
> +	return 0;
> +
> +err_free_q:
> +	eea_free_rxtx_q_mem(enet);

Does this code leak the newly allocated queues when enet_bind_new_q_and_cfg
fails?

The function allocates new queue resources in ctx at line 244 via
eea_alloc_rxtx_q_mem(&ctx). When enet_bind_new_q_and_cfg fails at line 248,
it goes to err_free_q which calls eea_free_rxtx_q_mem(enet).

However, eea_free_rxtx_q_mem operates on enet->rx and enet->tx, not on
ctx->rx and ctx->tx. When bind fails, the resources remain in ctx and are
never transferred to enet. The function eea_free_rxtx_q_mem will either free
old queues if the device was previously opened, or do nothing if enet->rx
and enet->tx are NULL (first open). In either case, the newly allocated
ctx->rx and ctx->tx are leaked.

The allocated resources include ring buffers, DMA allocations, page pools,
and NAPI structures.

> +
> +	return err;
> +}

[ ... ]

> +static int eea_reset_hw_resources(struct eea_net *enet)
> +{
> +	struct eea_net_init_ctx ctx;
> +	int err;
> +
> +	enet_init_ctx(enet, &ctx);
> +
> +	err = eea_alloc_rxtx_q_mem(&ctx);
> +	if (err)
> +		return err;
> +
> +	eea_netdev_stop(enet->netdev);
> +
> +	/* We skip resource cleanup on error paths in this function. Resources
> +	 * are deferred for later teardown when the netdev is closed or the
> +	 * driver unloads. This approach is deliberate: it simplifies the error
> +	 * handling and avoids the complexity of undoing partial operations
> +	 * during recovery.
> +	 */
> +
> +	err = enet_bind_new_q_and_cfg(enet, &ctx);
> +	if (err) {
> +		netdev_err(enet->netdev,
> +			   "eea reset: bind new queues failed. err %d\n",
> +			   err);
> +
> +		return err;

Does this code leak the newly allocated queues when enet_bind_new_q_and_cfg
fails?

The function allocates new queue resources in ctx at line 277 via
eea_alloc_rxtx_q_mem(&ctx), then calls eea_netdev_stop at line 285 which
frees the OLD enet->rx and enet->tx and sets them to NULL. When
enet_bind_new_q_and_cfg fails at line 294, it returns early without
transferring ownership of ctx->rx and ctx->tx to enet.

The error path at line 300 returns without freeing the newly allocated
ctx->rx and ctx->tx, causing a memory leak. These resources include ring
buffers, DMA allocations, page pools, and NAPI structures.

The ctx variable is stack-allocated, so when the function returns, the
pointers ctx->rx and ctx->tx are lost forever, orphaning the allocated
memory.

> +	}
> +
> +	err = eea_active_ring_and_irq(enet);
> +	if (err) {
> +		netdev_err(enet->netdev,
> +			   "eea reset: active new ring and irq failed. err %d\n",
> +			   err);
> +		return err;

Does this code leak the newly allocated queues when eea_active_ring_and_irq
fails?

In this scenario:
1. New queues allocated in ctx at line 277
2. Old queues freed by eea_netdev_stop at line 285
3. enet_bind_new_q_and_cfg succeeds at line 294, transferring ctx->rx and
   ctx->tx to enet->rx and enet->tx
4. eea_active_ring_and_irq fails at line 303
5. Function returns at line 308 without freeing enet->rx and enet->tx

The newly allocated and transferred resources remain in enet->rx and
enet->tx but are never freed. The comment at lines 287-292 claims resources
are deferred for cleanup, but there is no mechanism to track these orphaned
resources for later cleanup.

> +	}
> +
> +	eea_start_rxtx(enet);
> +
> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c
> index 8e9dd0f06f64..bf1b7e68fa45 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_pci.c
> +++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c

[ ... ]

> @@ -336,6 +507,8 @@ static int eea_pci_probe(struct pci_dev *pci_dev, const struct pci_device_id *e
> +
> +	ep_dev->pci_dev = pci_dev;
> +	mutex_init(&edev->ha_lock);
> +	err = __eea_pci_probe(pci_dev, ep_dev);

This isn't a bug, but should mutex_destroy() be called for ha_lock?

The mutex is initialized in eea_pci_probe() at line 510 with
mutex_init(&edev->ha_lock), but it is never destroyed with mutex_destroy()
before the structure is freed.

In the success path, eea_pci_remove() calls kfree(ep_dev) at line 530
without destroying the mutex.

In the error path of eea_pci_probe(), if __eea_pci_probe() fails at line
512, the code calls kfree(ep_dev) at line 514 without destroying the mutex.

While mutex_destroy() is a no-op when CONFIG_DEBUG_MUTEXES is disabled, it
is still considered best practice in the kernel to pair mutex_init() with
mutex_destroy(). Other networking drivers such as mlxsw consistently call
mutex_destroy() before freeing structures containing mutexes.

> +	if (err) {
> +		kfree(ep_dev);
> +		return err;
> +	}

[ ... ]

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.h b/drivers/net/ethernet/alibaba/eea/eea_pci.h
> index 696d82c3fe7d..91cb0be2d25b 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_pci.h
> +++ b/drivers/net/ethernet/alibaba/eea/eea_pci.h

[ ... ]

> @@ -47,7 +54,14 @@ struct eea_device_reset {
>  void eea_pci_reset_finished_callback(struct eea_device *edev);
>  void eea_pci_remove_nets(struct eea_device *edev);
>  int eea_pci_probe_nets(struct eea_device *edev);
> +void eea_pci_device_update_ts_off(struct eea_device *edev, u64 ts_off);
>  u64 eea_pci_device_ts(struct eea_device *edev);
> +int eea_pci_set_affinity(struct eea_ring *ering,
> +			 const struct cpumask *cpu_mask);

This isn't a bug, but eea_pci_set_affinity() is declared here but never
implemented or called.

The function is declared at line 64-65 of eea_pci.h, but there is no
implementation of this function in any .c file in drivers/net/ethernet/
alibaba/eea/, and the function is not called anywhere in the codebase.

This could be dead code that should be removed, or a forward declaration for
a future implementation that was forgotten. Given that this is part of a new
driver introduction, this might be intentional preparation for future
functionality. However, it's generally better practice to add function
declarations when they are actually implemented and used, rather than adding
them speculatively.

> +void eea_pci_free_nets(struct eea_device *edev);
> +
> +int eea_pci_set_adminq_irq_affinity(struct eea_device *edev,
> +				    const struct cpumask *cpu_mask);
> +int eea_pci_adminq_irq_num(struct eea_device *edev);
>
>  #endif

[ ... ]

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_rx.c b/drivers/net/ethernet/alibaba/eea/eea_rx.c
> new file mode 100644
> index 000000000000..3a7c06cdb89c
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_rx.c

[ ... ]

> +static int eea_alloc_rx_hdr(struct eea_net_rx *rx, struct eea_net_cfg *cfg)
> +{
> +	struct eea_rx_meta *meta;
> +	struct page *hdr_page;
> +	struct device *dmadev;
> +	u32 offset, i, sz;
> +	dma_addr_t dma;
> +	int err;
> +
> +	dmadev = ering_get_dma_device(rx->ering);
> +	sz = meta_align_offset(cfg);
> +	hdr_page = NULL;
> +	dma = 0;
> +	offset = PAGE_SIZE;
> +
> +	for (i = 0; i < cfg->rx_ring_depth; i++) {
> +		meta = &rx->meta[i];
> +
> +		if (!hdr_page || (PAGE_SIZE - offset) < sz) {
> +			hdr_page = alloc_page(GFP_KERNEL);
> +			if (!hdr_page) {
> +				err = -ENOMEM;
> +				goto err_free;
> +			}
> +
> +			dma = dma_map_page(dmadev, hdr_page, 0, PAGE_SIZE,
> +					   DMA_FROM_DEVICE);
> +			if (dma_mapping_error(dmadev, dma)) {
> +				__free_page(hdr_page);
> +				err = -ENOMEM;
> +				goto err_free;
> +			}
> +
> +			offset = 0;
> +			meta->hdr_page = hdr_page;
> +			meta->dma = dma;

This isn't a bug, but line 175 incorrectly assigns header page DMA address
to meta->dma field.

The meta->dma field is intended for the data page DMA address (set by
eea_alloc_rx_buffer at line 97), while meta->hdr_dma (correctly set at line
178) is for the header page DMA address. In the code:

    dma = dma_map_page(dmadev, hdr_page, 0, PAGE_SIZE, DMA_FROM_DEVICE);
    ...
    meta->hdr_page = hdr_page;
    meta->dma = dma;  // WRONG: overwrites data page DMA with header page DMA
    ...
    meta->hdr_dma = dma + offset;  // CORRECT: sets header DMA

While this doesn't cause a functional bug (because eea_alloc_rx_buffer later
overwrites meta->dma with the correct value), it violates the semantic
meaning of struct fields, creates confusion about field purposes, and
temporarily leaves meta->dma with a wrong value between eea_alloc_rx_hdr and
eea_alloc_rx_buffer.

> +		}
> +
> +		meta->hdr_dma = dma + offset;
> +		meta->hdr_offset = offset;
> +
> +		offset += sz;
> +	}

[ ... ]

> +static int eea_harden_check_overflow(struct eea_rx_ctx *ctx,
> +				     struct eea_net *enet)
> +{
> +	if (unlikely(ctx->len > ctx->meta->truesize - ctx->meta->room)) {
> +		pr_debug("%s: rx error: len %u exceeds truesize %u\n",
> +			 __func__, ctx->len, ctx->meta->truesize);
> +		eea_rx_meta_put(ctx->meta);
> +		return -EINVAL;
> +	}

Does this code use an uninitialized field for buffer overflow validation?

The struct eea_rx_meta field 'room' is never assigned anywhere in the code.
Since meta is allocated with kvcalloc, room is always 0.

In eea_rx_post (line 480-510), the code calculates:

    tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
    headroom = rx->headroom;
    room = headroom + tailroom;
    len = PAGE_SIZE - meta->offset - room;
    meta->truesize = len + room;

The local variable 'room' is used but never stored in meta->room. This
causes the validation check to be incorrect:

Current behavior (room=0):
    ctx->len > ctx->meta->truesize - 0
    ctx->len > (len + room)  // allows receiving up to full truesize

Intended behavior (room set correctly):
    ctx->len > ctx->meta->truesize - room
    ctx->len > (len + room) - room
    ctx->len > len  // correctly validates against usable buffer size

With room=0, the hardware could send up to (len + room) bytes, potentially
overflowing into the headroom/tailroom reserved space. Since this is a
hardening check meant to catch misbehaving hardware, the incorrect
validation defeats its purpose.

> +
> +	return 0;
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/ethernet/alibaba/eea/eea_tx.c
> new file mode 100644
> index 000000000000..79cc9baaebe9
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_tx.c

[ ... ]

> +static void eea_meta_free_xmit(struct eea_net_tx *tx, struct eea_tx_meta *meta,
> +			       int budget)
> +{
> +	struct eea_net_stats *stats = &tx->stats;
> +
> +	++stats->packets;
> +	stats->bytes += meta->skb->len;
> +	napi_consume_skb(meta->skb, budget);

The second parameter to napi_consume_skb() should be a boolean indicating
NAPI context (0 or non-zero), not the actual budget value.

Jakub Kicinski raised this concern in v21 review, referencing commit
cd18e8ac030e646 which added kdoc clarifying this. The current code passes
'budget' (which could be any positive integer like 64) instead of just 1 to
indicate NAPI context. While the function still works correctly (any
non-zero value indicates NAPI context), using the budget value is
semantically incorrect.

Reference: https://lore.kernel.org/netdev/20260121170658.371e0e63@kernel.org/

> +	meta->skb = NULL;
> +
> +	eea_tx_meta_put_and_unmap(tx, meta);
> +}

[ ... ]

> +static void eea_clean_tx(struct eea_net_tx *tx, int budget)
> +{
> +	const struct eea_tx_desc *desc;
> +	struct eea_tx_meta *meta;
> +
> +	while ((desc = ering_cq_get_desc(tx->ering))) {
> +		meta = &tx->meta[le16_to_cpu(desc->id)];
> +
> +		if (meta->data) {
> +			meta->num = le16_to_cpu(desc->num);
> +
> +			eea_meta_free_xmit(tx, meta, budget);
> +		} else {
> +			netdev_err(tx->enet->netdev,
> +				   "tx meta->data is null. id %d num: %d\n",
> +				   meta->id, meta->num);
> +		}
> +
> +		ering_cq_ack_desc(tx->ering, meta->num);

Can this code cause an infinite loop on invalid completion descriptor?

When hardware returns a completion descriptor with an ID pointing to a meta
that has NULL data (line 103 check fails), the code logs an error (lines
107-109) but still calls ering_cq_ack_desc() with meta->num at line 112.

If the meta was never properly posted (or was already cleaned up), meta->num
will be 0 (from kvcalloc zero-initialization at line 360 in eea_alloc_tx).
Calling ering_cq_ack_desc() with num=0 acknowledges zero descriptors, making
no progress in the completion queue.

This causes the while loop (line 100) to read the same invalid completion
descriptor on the next iteration, logging the same error and ACKing 0
descriptors again, resulting in an infinite loop that hangs the TX
completion processing:

    Line 100: while ((desc = ering_cq_get_desc(tx->ering)))
    Line 101: meta = &tx->meta[le16_to_cpu(desc->id)];
    Line 103: if (meta->data) check fails
    Line 107-109: Log error
    Line 112: ering_cq_ack_desc(tx->ering, meta->num) with num=0
    Loop back to line 100: Same descriptor still pending

While this error condition should not normally happen, when it does occur
due to hardware/firmware bugs or race conditions, the driver should handle
it gracefully rather than hanging.

> +	}
> +}

[ ... ]

> +static struct eea_tx_meta *eea_tx_desc_fill(struct eea_net_tx *tx,
> +					    dma_addr_t addr, u32 size,
> +					    bool is_last, struct sk_buff *skb,
> +					    u32 flags)
> +{
> +	struct eea_tx_desc *desc;
> +	struct eea_tx_meta *meta;
> +
> +	meta = eea_tx_meta_get(tx);
> +
> +	desc = ering_sq_alloc_desc(tx->ering, meta->id, is_last, flags);

Can this code dereference a NULL pointer?

eea_tx_meta_get() can return NULL when the free list is exhausted (tx->free
is NULL, as seen in lines 40-41 of eea_tx_meta_get). When NULL is returned,
line 182 unconditionally dereferences meta->id without checking if meta is
NULL, causing a kernel crash.

The TX queue flow control check (netif_txq_maybe_stop) happens AFTER packet
posting in eea_tx_xmit (line 280), not before. When the ring is under heavy
load with fragmented packets, the meta free list can be exhausted before the
queue is stopped.

The meta array has cfg.tx_ring_depth entries (allocated at line 360 in
eea_alloc_tx). Each packet can consume 1 + nr_frags meta entries (up to
MAX_SKB_FRAGS + 1). With small ring depths and many large fragmented packets
in flight, the free list can be completely exhausted.

Call path:
Network stack -> eea_tx_xmit -> eea_tx_post_skb (line 274) ->
eea_tx_desc_fill (line 231) -> eea_tx_meta_get (line 180) returns NULL ->
line 182 crashes.

> +
> +	meta->data = (void *)skb;
> +	meta->dma = addr;
> +	meta->desc = desc;
> +
> +	return meta;
> +}

[ ... ]

> +static int eea_tx_post_skb(struct sk_buff *skb, struct eea_net_tx *tx,
> +			   int flags)
> +{
> +	dma_addr_t addr;
> +	u32 hlen;
> +	struct skb_shared_info *shinfo = skb_shinfo(skb);
> +	struct eea_tx_meta *meta;
> +	int err, last = 0;
> +	struct device *dmadev;
> +
> +	dmadev = ering_get_dma_device(tx->ering);
> +
> +	hlen = skb_headlen(skb);
> +
> +	addr = dma_map_single(dmadev, skb->data, hlen, DMA_TO_DEVICE);
> +	if (dma_mapping_error(dmadev, addr))
> +		return -ENOMEM;
> +
> +	meta = eea_tx_desc_fill(tx, addr, hlen, !shinfo->nr_frags, skb, flags);
> +
> +	if (eea_fill_desc_from_skb(skb, tx->ering, meta->desc))

Can this code dereference a NULL pointer?

eea_tx_desc_fill() at line 231 can return NULL when the meta free list is
exhausted (root cause explained earlier). Line 233 unconditionally
dereferences meta->desc without checking if meta is NULL.

This is a consequence of the same underlying issue: the TX queue flow
control happens after packet posting rather than before.

Call path:
eea_tx_xmit (line 274) -> eea_tx_post_skb -> eea_tx_desc_fill (line 231)
returns NULL -> line 233 crashes accessing meta->desc.

> +		goto err_cancel;

[ ... ]

