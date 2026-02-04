Return-Path: <netdev+bounces-256556-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCfnM0zGgml9awMAu9opvQ
	(envelope-from <netdev+bounces-256556-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 05:08:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E6DE179F
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 05:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C41EA3037AB9
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 04:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495C4301001;
	Wed,  4 Feb 2026 04:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8vMOyLk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC9B3009EC
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 04:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770178122; cv=none; b=G35ads9XsvKruo5xvdHO05ZMsWgmJ9tx3PoaOHhUHs80KrBynrMhyXgwjXC3K2DwaBYmlz13JSFeEx3HXIabwaSCaO2AK4RMb2iEW2aWuyO79rvOW8SgmGBw355jD7Jf8gLFXEpHapD+Es/sGB+993oUGJhbw8nBhR0YQZUP0fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770178122; c=relaxed/simple;
	bh=e8huZO4xz0ml+BI2F97/KQfPwH7LID94bWdHKbwJG50=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=df++/hpfeIGTuGX1prgLJxH7c3sDUZ2Q1bSO2bYJFUzTHgtizVtnR5/TgJpxuumhRZ2kJhdsjoHWjl/ozSeHOE4F9/3ANVCNrVclKJ3mYgRQxrKK+Zu7bYsNSR+BOUK/+g92WthbPdgbFFXFv4E3Qy6t1dlJYG3zuCAHd/zQPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8vMOyLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 361D0C19425;
	Wed,  4 Feb 2026 04:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770178120;
	bh=e8huZO4xz0ml+BI2F97/KQfPwH7LID94bWdHKbwJG50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q8vMOyLkwrgV9ef9CaXWAPKv8ujkJf1JZ8Q6U5SuSbPpleeLX7nv6feQ0mSWOMbme
	 c72ELJfdwy33nfwlFpLT91BxF5tkkWipzlXu0HiWk682gfxe3cmC+FQEzHlnjjgmEA
	 ssdOochGixsVCdOIDVI2NfETLnDEUVc7KNb5a66Bl2d6d15OpRNfPCRilSrCdy9w6T
	 oyXj3/Fkh3WeC47GGZye0Wj2txgo69LFtmctaUO5NP+Zqs0Bo285y8eLqFu4ek9Ztv
	 pEPgKNoWWPUHtyfAVMiUyF7uIuP3SPGG5KMDBex6l8UJ8t4lpICfa1mIZ1CN/T+PZi
	 aKXL9fwMXfRwg==
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	davem@davemloft.net,
	guwen@linux.alibaba.com,
	lulie@linux.alibaba.com,
	hkallweit1@gmail.com,
	edumazet@google.com,
	lukas.bulwahn@redhat.com,
	andrew@lunn.ch,
	dong100@mucse.com,
	dust.li@linux.alibaba.com,
	netdev@vger.kernel.org
Subject: Re: [net-next,v25,4/6] eea: create/destroy rx,tx queues for netdevice open and stop
Date: Tue,  3 Feb 2026 20:00:55 -0800
Message-ID: <20260204040054.1698677-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202090638.46836-5-xuanzhuo@linux.alibaba.com>
References: <20260202090638.46836-5-xuanzhuo@linux.alibaba.com>
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
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,redhat.com,linux.dev,davemloft.net,linux.alibaba.com,gmail.com,google.com,mucse.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-256556-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: 76E6DE179F
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
eea: create/destroy rx,tx queues for netdevice open and stop

This commit introduces the implementation for netdevice open and stop
operations for the Alibaba Elastic Ethernet Adapter (EEA). It adds RX/TX
queue creation/destruction, interrupt handling, and basic packet processing.

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.c b/drivers/net/ethernet/alibaba/eea/eea_net.c
> index 31cb9ca5b408..3439152eaf79 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_net.c
> +++ b/drivers/net/ethernet/alibaba/eea/eea_net.c

[ ... ]

> @@ -18,6 +18,353 @@
>
>  #define EEA_SPLIT_HDR_SIZE 128
>
> +/* resources: ring, buffers, irq */
> +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_init_ctx *ctx)
> +{
> +	int err;
> +
> +	if (!netif_running(enet->netdev)) {
> +		enet->cfg = ctx->cfg;
> +		return 0;
> +	}
> +
> +	err = eea_alloc_rxtx_q_mem(ctx);
> +	if (err) {
> +		netdev_warn(enet->netdev,
> +			    "eea reset: alloc q failed. stop reset. err %d\n",
> +			    err);
> +		return err;
> +	}
> +
> +	eea_netdev_stop(enet->netdev);
> +
> +	/* If we encounter an error (which is, of course, a very
> +	 * low-probability event), but we do not immediately free the queues
> +	 * resources here. Instead, we defer their release until the normal NIC
> +	 * cleanup, or until the user or hardware triggers a reset operation.
> +	 * Because that the dev is running.
> +	 */
> +
> +	err = enet_bind_new_q_and_cfg(enet, ctx);
> +	if (err) {
> +		netdev_err(enet->netdev,
> +			   "eea reset: bind new queues failed. err %d\n",
> +			   err);
> +
> +		return err;
> +	}

When enet_bind_new_q_and_cfg() fails, what happens to the queues allocated
by eea_alloc_rxtx_q_mem() at line 289? They're now assigned to ctx->rx and
ctx->tx but haven't been bound to enet yet.

After eea_netdev_stop() sets enet->started = false, a subsequent call to
eea_netdev_stop() will return early at line 228 without calling
eea_free_rxtx_q_mem(). If enet_bind_new_q_and_cfg() fails before binding,
the queues remain in ctx with no cleanup path.

The comment suggests deferring cleanup to "normal NIC cleanup" but
eea_net_remove() doesn't call eea_free_rxtx_q_mem(), and future reset
attempts would allocate new queues without freeing these.

> +
> +	err = eea_active_ring_and_irq(enet);
> +	if (err) {
> +		netdev_err(enet->netdev,
> +			   "eea reset: active new ring and irq failed. err %d\n",
> +			   err);
> +		return err;
> +	}

If eea_active_ring_and_irq() fails after enet_bind_new_q_and_cfg()
succeeded, are the queues now bound to enet->rx/enet->tx? If so, the same
cleanup issue applies since enet->started remains false.

Should both error paths call eea_free_rxtx_q_mem(enet) before returning?

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
> index 03a9abda345e..109aa638559d 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_net.h
> +++ b/drivers/net/ethernet/alibaba/eea/eea_net.h

[ ... ]

> @@ -134,9 +153,38 @@ struct eea_net {
>  	u64 hw_ts_offset;
>  };
>
> +/* tx apis */
> +int eea_poll_tx(struct eea_net_tx *tx, int budget);
> +void eea_poll_cleantx(struct eea_net_rx *rx);
> +netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev);
> +
> +void eea_tx_timeout(struct net_device *netdev, u32 txqueue);

This isn't a bug, but the header declares eea_poll_cleantx() without any
implementation or callers in the codebase. Should this be removed?

Also, eea_tx_timeout() is declared with parameter type u32 txqueue, but the
implementation uses unsigned int txqueue. The kernel's ndo_tx_timeout
callback signature expects unsigned int. The header should match.

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c
> index 182e463d73a0..f426d003a813 100644
> --- a/drivers/net/ethernet/alibaba/eea/eea_pci.c
> +++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c

[ ... ]

> @@ -250,6 +259,153 @@ void eea_pci_active_aq(struct eea_ring *ering)
>  				    cfg_read32(ep_dev->reg, aq_db_off));
>  }
>
> +static int eea_ha_handle_reset(struct eea_pci_device *ep_dev)
> +{
> +	struct eea_device *edev;
> +	struct pci_dev *pci_dev;
> +	u16 reset;
> +
> +	if (!ep_dev->reset_pos)
> +		return 0;
> +
> +	edev = &ep_dev->edev;
> +
> +	pci_read_config_word(ep_dev->pci_dev, ep_dev->reset_pos, &reset);
> +
> +	/* clear bit */
> +	pci_write_config_word(ep_dev->pci_dev, ep_dev->reset_pos, 0xFFFF);
> +
> +	if (reset & EEA_PCI_CAP_RESET_FLAG) {
> +		dev_warn(&ep_dev->pci_dev->dev, "recv device reset request.\n");
> +
> +		pci_dev = ep_dev->pci_dev;
> +
> +		/* The pci remove callback may hold this lock. If the
> +		 * pci remove callback is called, then we can ignore the
> +		 * ha interrupt.
> +		 */
> +		if (mutex_trylock(&edev->ha_lock)) {
> +			edev->ha_reset = true;
> +
> +			__eea_pci_remove(pci_dev, false);
> +			__eea_pci_probe(pci_dev, ep_dev);

What happens if __eea_pci_probe() fails during this HA reset recovery?
Looking at __eea_pci_probe(), it can fail in eea_pci_setup(),
eea_init_device(), or eea_pci_ha_init().

If probe fails after remove succeeded, the device is left in a removed
state with no error logged. The function returns 1 indicating success, even
though reprobe failed.

The normal probe path at line 512 checks the return value and handles
errors. Should this path also check for errors and at minimum log them?

> @@ -336,6 +507,8 @@ static int eea_pci_probe(struct pci_dev *pci_dev,
>
>  	ep_dev->pci_dev = pci_dev;
>
> +	mutex_init(&edev->ha_lock);
> +
>  	err = __eea_pci_probe(pci_dev, ep_dev);
>  	if (err) {
>  		pci_set_drvdata(pci_dev, NULL);
>  		kfree(ep_dev);

Is mutex_destroy() needed on this error path? The mutex ha_lock is
initialized at line 510, but when __eea_pci_probe() fails, the error path
calls kfree(ep_dev) without calling mutex_destroy(&edev->ha_lock).

Looking at eea_pci_remove() which calls mutex_destroy() at line 534 before
kfree(ep_dev) at line 535, there's an inconsistency between the error path
and success path. Should mutex_destroy() be added before kfree(ep_dev) in
the error handler?

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_rx.c b/drivers/net/ethernet/alibaba/eea/eea_rx.c
> new file mode 100644
> index 000000000000..55c1d19c5706
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_rx.c

[ ... ]

> +static struct sk_buff *eea_rx_build_split_hdr_skb(struct eea_net_rx *rx,
> +						  struct eea_rx_ctx *ctx)
> +{
> +	struct eea_rx_meta *meta = ctx->meta;
> +	struct sk_buff *skb;
> +	u32 truesize;
> +
> +	dma_sync_single_for_cpu(rx->enet->edev->dma_dev, meta->hdr_dma,
> +				ctx->hdr_len, DMA_FROM_DEVICE);
> +
> +	skb = napi_alloc_skb(&rx->napi, ctx->hdr_len);
> +	if (unlikely(!skb))
> +		return NULL;
> +
> +	truesize = meta->headroom + ctx->len;
> +
> +	skb_put_data(skb, ctx->meta->hdr_addr, ctx->hdr_len);
> +
> +	if (ctx->len) {
> +		skb_add_rx_frag(skb, 0, meta->page,
> +				meta->offset + meta->headroom,
> +				ctx->len, truesize);
> +
> +		eea_consume_rx_buffer(rx, meta, truesize);
> +	}

Is the truesize calculation correct for split header mode? Looking at line
255, truesize is calculated as meta->headroom + ctx->len.

In eea_rx_post() at line 500, buffers are allocated with space for
[headroom][data][tailroom], where tailroom is typically 128 bytes for
skb_shared_info. The tailroom is reserved but not included in the truesize
calculation here.

When eea_consume_rx_buffer() advances meta->offset by only
(headroom + data_len), the reserved tailroom space remains unconsumed. After
alignment in meta_align_offset(), the next fragment may overlap with the
previous fragment's tailroom space.

Compare with the non-split header path in eea_rx_build_skb() at line 290,
which includes shinfo_size in truesize:

    truesize = meta->headroom + ctx->len + shinfo_size;

Should the split header path also include meta->tailroom or shinfo_size in
the truesize calculation?

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_tx.c b/drivers/net/ethernet/alibaba/eea/eea_tx.c
> new file mode 100644
> index 000000000000..3ef8a2f2eac2
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_tx.c

[ ... ]

> +static void eea_free_meta(struct eea_net_tx *tx, struct eea_net_cfg *cfg)
> +{
> +	struct eea_sq_free_stats stats;
> +	struct eea_tx_meta *meta;
> +	int i;
> +
> +	while ((meta = eea_tx_meta_get(tx)))
> +		meta->skb = NULL;
> +
> +	for (i = 0; i < cfg->tx_ring_depth; i++) {
> +		meta = &tx->meta[i];
> +
> +		if (!meta->skb)
> +			continue;
> +
> +		eea_tx_meta_put_and_unmap(tx, meta);
> +
> +		eea_meta_free_xmit(tx, meta, 0, NULL, &stats);
> +	}

Is the stats variable initialized here? At line 293, stats is declared
without initialization, then passed to eea_meta_free_xmit() at line 308.

Looking at eea_meta_free_xmit() in lines 87-88, the code performs
++stats->packets and stats->bytes += meta->skb->len, which reads and
increments uninitialized memory.

Compare with eea_clean_tx() at line 96 which initializes:
struct eea_sq_free_stats stats = {0};

Should line 293 use the same initialization?

