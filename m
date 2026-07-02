Return-Path: <netdev+bounces-304102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PzHrKy5ARmozMwsAu9opvQ
	(envelope-from <netdev+bounces-304102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:40:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69A096F60CF
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 12:40:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=evbrMBdM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304102-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304102-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E6B003003603
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 10:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E943C366DD3;
	Thu,  2 Jul 2026 10:40:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3356E35CB9C
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 10:39:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782988801; cv=none; b=a59REiTWy4IYmRnpED92pQdPikYco/7R3JqF5z6X3TKmAFqVUI8n1CebT55otjDZTnUpCJiood3bk+NUCQpOeGssnxBOx0GDxNihPCrJ6CFkQR3iBjQunzfn86ds55W3ssXZqHLn4gZkyW+Jofx1mt1uwUBEgIeU+40bGBqxKSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782988801; c=relaxed/simple;
	bh=KoWbYlzVQHvb+guOfND1PbW3pUo10r8sy3URtG78n1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EB5KoHxcTu1VWq1M8V56Wc2WV2rN3scUFtkuAEHaSEzmBTvT85kWYTuARY0vEthWfkr6vqgdMcKS+wLYERqJXSbNiXanGC0mEG5z7ehem+8hTAQPOsuXfbGOYfqNrzDHLEFmuA0KBO44gMEm91Qbyu1qWMyTUM5VD9ZrDSTRyEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=evbrMBdM; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782988799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B+Qs95JbC7lZDApVNv7QZGEq+/t0cSDX8VtIS7Qisn8=;
	b=evbrMBdMWC+Z6xTTeky81+G7lkgi32DNJqIDP2njNl5rr15DXTOrGahD/8xxjNk8Zmtjfz
	37gt35UCT3NxI4qZrrDR6ptIZ0PUpFbbfzv7B+zS13VuRMr6M0X9txsBBRxmHhzTt28NBa
	M5828b2ExJY73OgJ7Zxkx8jJ0qhAlZA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-MAydsVWRN26F3aMm_KgxjQ-1; Thu,
 02 Jul 2026 06:39:56 -0400
X-MC-Unique: MAydsVWRN26F3aMm_KgxjQ-1
X-Mimecast-MFC-AGG-ID: MAydsVWRN26F3aMm_KgxjQ_1782988795
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5E8891944D20;
	Thu,  2 Jul 2026 10:39:55 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.252])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id D80C53001D86;
	Thu,  2 Jul 2026 10:39:52 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] net: emac: fix DMA API mapping and unmapping correctness
Date: Thu,  2 Jul 2026 12:39:31 +0200
Message-ID: <20260702103931.147571-1-pabeni@redhat.com>
In-Reply-To: <20260630041634.284127-8-rosenp@gmail.com>
References: <20260630041634.284127-8-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304102-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69A096F60CF

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: emac: fix DMA API mapping and unmapping correctness

This patch adds dma_mapping_error() checks after every dma_map_single()
and skb_frag_dma_map() call in the ibm emac driver, introduces a shadow
rx_dma[] array in struct emac_instance, and replaces the map-and-leak
pattern in emac_recycle_rx_skb() with dma_sync_single_for_device().

A few questions follow inline.

> net: emac: fix DMA API mapping and unmapping correctness

[Low]
The subject says the fix is for DMA API mapping and unmapping
correctness, but the in-tree comment added by this patch states:

  + * TX buffers still lack dma_unmap calls for the reasons explained in the
  + * original note below (a single skb may be split across multiple BDs on
  + * TAH-equipped EMACs, making per-fragment tracking complex).

Should the subject be scoped to the RX path (for example, "fix DMA API
correctness on the RX path") since the TX-side DMA API violation is
intentionally preserved?

[Low]
The commit message bullet says:

    - emac_recycle_rx_skb: map first, check error, then unmap old;
      use dma_sync_single_for_device() with SKB_DATA_ALIGN(len + NET_IP_ALIGN)

But emac_recycle_rx_skb() only calls dma_sync_single_for_device() and
performs no map/check/unmap sequence; the "map first, check, unmap old"
sequence is in the emac_poll_rx() MAL_RX_CTRL_FIRST branch. Would it
help to split this bullet across the two functions?

[Low]
The changelog ends with:

    For whatever reason after this patch, ath9k stopped throwing DMA
    errors with CONFIG_DMA_API_DEBUG.

Is this perhaps an artifact of CONFIG_DMA_API_DEBUG hash exhaustion
caused by the leaked mappings in the pre-patch driver? It might be
worth investigating and stating the mechanism rather than leaving it
as an unexplained side effect.

[Low]
The emac_recycle_rx_skb() change (discarding the returned DMA address
from dma_map_single()) looks like a long-standing functional bug on
systems with IOMMU/SWIOTLB. Would a Fixes: tag and stable consideration
be appropriate for that hunk?

> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index ced9690cddc3..aed1ad21e2ea 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c

[ ... ]

> @@ -1058,6 +1066,7 @@ static int emac_resize_rx_ring(struct emac_instance *dev, int new_mtu)
>  	/* Second pass, allocate new skbs */
>  	for (i = 0; i < NUM_RX_BUFF; ++i) {
>  		struct sk_buff *skb;
> +		dma_addr_t dma;
>  
>  		skb = netdev_alloc_skb_ip_align(dev->ndev, rx_skb_size);
>  		if (!skb) {
> @@ -1066,12 +1075,24 @@ static int emac_resize_rx_ring(struct emac_instance *dev, int new_mtu)
>  		}
>  
>  		BUG_ON(!dev->rx_skb[i]);
> +		dma_unmap_single(&dev->ofdev->dev,
> +				 dev->rx_dma[i],
> +				 dev->rx_sync_size, DMA_FROM_DEVICE);
>  		dev_kfree_skb(dev->rx_skb[i]);
>  
> -		dev->rx_desc[i].data_ptr =
> -		    dma_map_single(&dev->ofdev->dev, skb->data - NET_IP_ALIGN,
> -				   rx_sync_size, DMA_FROM_DEVICE)
> -				   + NET_IP_ALIGN;
> +		dma = dma_map_single(&dev->ofdev->dev, skb->data - NET_IP_ALIGN,
> +				     rx_sync_size, DMA_FROM_DEVICE);
> +		if (dma_mapping_error(&dev->ofdev->dev, dma)) {
> +			dev_kfree_skb(skb);
> +			dev->rx_skb[i] = NULL;
> +			dev->rx_dma[i] = 0;
> +			dev->rx_desc[i].data_ptr = 0;
> +			dev->rx_desc[i].ctrl = 0;
> +			ret = -ENOMEM;
> +			goto oom;
> +		}

[High]
Can this error path leave the descriptor ring in a state that crashes
the next NAPI poll?

The first pass earlier in emac_resize_rx_ring() initialises every
slot's ctrl with:

    dev->rx_desc[i].ctrl = MAL_RX_CTRL_EMPTY |
        (i == (NUM_RX_BUFF - 1) ? MAL_RX_CTRL_WRAP : 0);

so software (which polls with "if (ctrl & MAL_RX_CTRL_EMPTY) break;")
treats those slots as owned by hardware and skips them. The new error
path here sets ctrl = 0 instead, which clears MAL_RX_CTRL_EMPTY (and
MAL_RX_CTRL_WRAP for the last slot).

The oom: label below unconditionally re-enables RX:

    oom:
        clear_bit(MAL_COMMAC_RX_STOPPED, &dev->commac.flags);
        dev->rx_slot = 0;
        mal_enable_rx_channel(dev->mal, dev->mal_rx_chan);
        emac_rx_enable(dev);
        emac_netif_start(dev);

On the next emac_poll_rx() call, the loop reads ctrl = 0, finds the
EMPTY bit clear, and proceeds with skb = dev->rx_skb[slot] = NULL,
followed by memcpy()/skb_put()/eth_type_trans() on that NULL skb.

Additionally, the slot's rx_skb[i] is now NULL but the loop above
starts each iteration with BUG_ON(!dev->rx_skb[i]). Would a subsequent
MTU change deterministically panic on that BUG_ON()?

Should this error path mirror the first pass and use MAL_RX_CTRL_EMPTY
(plus MAL_RX_CTRL_WRAP for the last slot) rather than zero?

[ ... ]

> @@ -1176,15 +1201,23 @@ static void emac_clear_mal_desc(struct mal_descriptor *desc, int count)
>  static int
>  __emac_prepare_rx_skb(struct sk_buff *skb, struct emac_instance *dev, int slot)
>  {
> +	dma_addr_t dma;
> +
>  	if (unlikely(!skb))
>  		return -ENOMEM;
>  
>  	dev->rx_skb[slot] = skb;
>  	dev->rx_desc[slot].data_len = 0;
>  
> -	dev->rx_desc[slot].data_ptr =
> -	    dma_map_single(&dev->ofdev->dev, skb->data - NET_IP_ALIGN,
> -			   dev->rx_sync_size, DMA_FROM_DEVICE) + NET_IP_ALIGN;
> +	dma = dma_map_single(&dev->ofdev->dev, skb->data - NET_IP_ALIGN,
> +			     dev->rx_sync_size, DMA_FROM_DEVICE);
> +	if (dma_mapping_error(&dev->ofdev->dev, dma)) {
> +		dev->rx_skb[slot] = NULL;
> +		dev_kfree_skb(skb);
> +		return -ENOMEM;
> +	}
> +	dev->rx_desc[slot].data_ptr = dma + NET_IP_ALIGN;
> +	dev->rx_dma[slot] = dma;

[Critical]
Can this corrupt the slot state on a DMA mapping failure?

The new skb is installed into the slot before the mapping is performed:

    dev->rx_skb[slot] = skb;
    dev->rx_desc[slot].data_len = 0;

    dma = dma_map_single(...);
    if (dma_mapping_error(...)) {
        dev->rx_skb[slot] = NULL;
        dev_kfree_skb(skb);
        return -ENOMEM;
    }

On failure, the new skb is freed and rx_skb[slot] is set to NULL, but
dev->rx_desc[slot].data_ptr and dev->rx_dma[slot] still hold the old
mapping, and the previous skb pointer that the caller saved (the
emac_poll_rx() local "skb") is also lost.

The emac_poll_rx() caller paths handle the failure as:

    } else if (unlikely(emac_alloc_rx_skb_napi(dev, slot)))
        goto oom;
    ...
    oom:
        ++dev->estats.rx_dropped_oom;
        emac_recycle_rx_skb(dev, slot, 0);

emac_recycle_rx_skb() then re-arms the descriptor with
MAL_RX_CTRL_EMPTY, handing the still-mapped old buffer back to
hardware. On the next received packet, dev->rx_skb[slot] is NULL and:

    skb = dev->rx_skb[slot];
    ...
    memcpy(copy_skb->data - NET_IP_ALIGN,
           skb->data - NET_IP_ALIGN,
           len + NET_IP_ALIGN);

would dereference NULL in NAPI context. The MAL_RX_CTRL_FIRST branch
that calls emac_alloc_rx_skb_napi() has the same shape.

Would it be safer to perform the dma_map_single() and error check
before installing the new skb into rx_skb[slot], so the slot still
points at a valid skb and mapping on failure?

[ ... ]

> @@ -1808,12 +1863,17 @@ static int emac_poll_rx(void *param, int budget)
>  		continue;
>  	sg:
>  		if (ctrl & MAL_RX_CTRL_FIRST) {
> +			dma_addr_t old_dma = dev->rx_dma[slot];
> +
>  			BUG_ON(dev->rx_sg_skb);
>  			if (unlikely(emac_alloc_rx_skb_napi(dev, slot))) {
>  				DBG(dev, "rx OOM %d" NL, slot);
>  				++dev->estats.rx_dropped_oom;
>  				emac_recycle_rx_skb(dev, slot, 0);
>  			} else {
> +				dma_unmap_single(&dev->ofdev->dev, old_dma,
> +						 dev->rx_sync_size,
> +						 DMA_FROM_DEVICE);
>  				dev->rx_sg_skb = skb;
>  				skb_put(skb, len);
>  			}

[High]
The commit message bullet says:

    - emac_poll_rx: use rx_dma[] shadow array, unmap old skb before
      passing to napi_gro_receive

but the new dma_unmap_single() above only covers the SG
MAL_RX_CTRL_FIRST branch. The non-SG large-packet path
(len >= EMAC_RX_COPY_THRESH) is in emac_poll_rx():

    skb = dev->rx_skb[slot];
    ...
    if (len && len < EMAC_RX_COPY_THRESH) {
        ...
    } else if (unlikely(emac_alloc_rx_skb_napi(dev, slot)))
        goto oom;

    skb_put(skb, len);
    push_packet:
        skb->protocol = eth_type_trans(skb, dev->ndev);
        emac_rx_csum(dev, skb, ctrl);
        napi_gro_receive(&dev->mal->napi, skb);

emac_alloc_rx_skb_napi() calls __emac_prepare_rx_skb() which
overwrites dev->rx_dma[slot] with the new mapping, so the previous
mapping address is lost. The original "skb" is then handed to
napi_gro_receive() while still mapped DMA_FROM_DEVICE.

Does this leak one DMA mapping per large-packet RX, and on the
non-coherent PowerPC platforms this patch targets, hand the stack a
buffer that has not been dma_unmap_single()'d?

Should the non-SG large-packet branch also save old_dma before
emac_alloc_rx_skb_napi() and call dma_unmap_single() before
napi_gro_receive(), mirroring the SG-first branch?

[ ... ]
-- 
This is an AI-generated review.


