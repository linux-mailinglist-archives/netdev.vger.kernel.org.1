Return-Path: <netdev+bounces-286376-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIcbCaHUAGp8NAEAu9opvQ
	(envelope-from <netdev+bounces-286376-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:55:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A01EA505D07
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 20:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 91508300538B
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 18:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F6231E844;
	Sun, 10 May 2026 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqz5ozX7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA2253B42;
	Sun, 10 May 2026 18:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778439300; cv=none; b=R6SH5xFE7DCLCIeSTd4cQOuo1PW8O3zCPILemW7UFfNHsr3iTPACCKTsmGI8JC6R7vl+Fqn5A6hjQdSh6lwl1U1kgncBa0gt1ZBv6rlnviXgJkmjZXqcZZHucWj59d6GUxpr/kB3oZcMTaEGTAVou74KrXqrx8Rhz7kGi0EfRVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778439300; c=relaxed/simple;
	bh=JlE1vn872snGxe5CIqBp4/RQqX0O9OHxCwmfqNARZjI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A8mVZrVCr9LrOyP8VkvV3vpdN/Om2y61L7IRQ2t47F5P1uTBbmflhGo5GvPC3m5HBODexgd34obvpKNgDzXuvhz1w9yIUZ5Tz8H0r3vW2thx2NcvvsgVt0fmN07SJpAREOceKFle9aR0UrunaWr41IjR/1clMrwdmKhygduL6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqz5ozX7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4497BC2BCB8;
	Sun, 10 May 2026 18:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778439300;
	bh=JlE1vn872snGxe5CIqBp4/RQqX0O9OHxCwmfqNARZjI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqz5ozX7p4TrZCX2h3tfsD39NuwZhwQXTDVYyHe679gDwbYy6NfM8j8azWxYfhq+v
	 h8j2G2p4LfqRxWJ3A4KkcsjbCgFzcgwpmPUWGa2mshTv5WnH5TKQ/RNmOsliEUcSGz
	 disldo+LRShXI/FQfcALHtA8GCTzVBWvPoD69h9WHYQatowJaydYqoa/1m3/7CfGtf
	 b7Fq1vULms28SdxxTinJT2HqcW4X/zdh473vHqt7j3Ccq0mw4VkqxRvyv4t3dGLN86
	 to3JKx9cvj1R1AUr2v17PmN3DywaDzbWem/9hKrnwhTzmwyMH5/RT5HwcxhFIptbTW
	 sYv5HAnV0mILw==
From: Jakub Kicinski <kuba@kernel.org>
To: nb@tipi-net.de
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	justin.chen@broadcom.com,
	horms@kernel.org,
	mohsin.bashr@gmail.com,
	opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	pabeni@redhat.com,
	davem@davemloft.net,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH net-next v9 4/7] net: bcmgenet: add XDP_TX support
Date: Sun, 10 May 2026 11:52:56 -0700
Message-ID: <20260510185255.3958629-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506095553.55357-5-nb@tipi-net.de>
References: <20260506095553.55357-5-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A01EA505D07
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,broadcom.com,gmail.com,lunn.ch,google.com,redhat.com,davemloft.net,iogearbox.net,fomichev.me];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-286376-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
    net: bcmgenet: add XDP_TX support
    
    Implement XDP_TX using ring 16 (DESC_INDEX), the hardware default
    descriptor ring, dedicated to XDP TX for isolation from SKB TX queues.

[ ... ]

> diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> index ee1d4ecc2b874..f1e515526787a 100644
> --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> @@ -49,8 +49,10 @@
>  
>  #define GENET_Q0_RX_BD_CNT	\
>  	(TOTAL_DESC - priv->hw_params->rx_queues * priv->hw_params->rx_bds_per_q)
> +#define GENET_Q16_TX_BD_CNT	32

Will this cause deterministic packet drops on XDP_TX? The NAPI budget is
typically 64. Since the RX poll reclaims XDP TX completions only once at the
beginning of the NAPI cycle, a burst of more than 32 XDP_TX actions would
exhaust the TX ring and drop subsequent packets in that burst.

>  #define GENET_Q0_TX_BD_CNT	\
> -	(TOTAL_DESC - priv->hw_params->tx_queues * priv->hw_params->tx_bds_per_q)
> +	(TOTAL_DESC - priv->hw_params->tx_queues * priv->hw_params->tx_bds_per_q \
> +	 - GENET_Q16_TX_BD_CNT)

[ ... ]

> @@ -2315,14 +2432,42 @@ static unsigned int bcmgenet_run_xdp(struct bcmgenet_rx_ring *ring,
>  	switch (act) {
>  	case XDP_PASS:
>  		return XDP_PASS;
> +	case XDP_TX:
> +		/* Prepend a zeroed TSB (Transmit Status Block).  The GENET
> +		 * MAC has TBUF_64B_EN set globally, so hardware expects every
> +		 * TX buffer to begin with a 64-byte struct status_64.  Back
> +		 * up xdp->data into the RSB area (which is no longer needed
> +		 * after the BPF program ran) and zero it.
> +		 */
> +		if (xdp->data - xdp->data_hard_start <
> +		    sizeof(struct status_64) + sizeof(struct xdp_frame)) {

Does this headroom check need to account for the metadata size? If headroom
is tight, shifting the pointers might cause xdp_update_frame_from_buff()
to fail with -ENOSPC and drop the packet.

Jakub: it may be cleaner to invalidate XDP metadata instead of half-hangling it.
       AFAIU it doesn't get used past this point anyway.

> +			page_pool_put_full_page(ring->page_pool, rx_page,
> +						true);
> +			return XDP_DROP;
> +		}
> +		xdp->data -= sizeof(struct status_64);
> +		xdp->data_meta -= sizeof(struct status_64);
> +		memset(xdp->data, 0, sizeof(struct status_64));

Could this corrupt XDP metadata and copy uninitialized memory?

If the XDP program attached metadata, the physical metadata bytes immediately
precede the original xdp->data. The memset() here spans the exact memory area
where the original metadata resides, overwriting it with zeros.

Because xdp->data_meta is decremented, it now points to uninitialized
headroom memory, which xdp_convert_buff_to_frame() would read as the frame's
metadata.

> +
> +		xdpf = xdp_convert_buff_to_frame(xdp);
> +		if (unlikely(!xdpf)) {
> +			page_pool_put_full_page(ring->page_pool, rx_page,
> +						true);
> +			return XDP_DROP;
> +		}

[ ... ]

> @@ -2548,9 +2693,15 @@ static int bcmgenet_rx_poll(struct napi_struct *napi, int budget)
>  {
>  	struct bcmgenet_rx_ring *ring = container_of(napi,
>  			struct bcmgenet_rx_ring, napi);
> +	struct bcmgenet_priv *priv = ring->priv;
>  	struct dim_sample dim_sample = {};
>  	unsigned int work_done;
>  
> +	/* Reclaim completed XDP TX frames (ring 16 has no interrupt) */
> +	if (priv->xdp_tx_ring.free_bds < priv->xdp_tx_ring.size)
> +		bcmgenet_tx_reclaim(priv->dev,
> +				    &priv->xdp_tx_ring, false);

If the NAPI budget is not fully consumed, napi_complete_done() is called and
NAPI exits. Since there is no TX interrupt for ring 16, could XDP TX
completions stall indefinitely if RX traffic stops? This might leave buffers
in the TX ring, eventually leading to page pool exhaustion.

Also, is there a risk of severe lock and MMIO contention here?

Since the single XDP TX ring is shared across all RX queues, every active
RX NAPI will concurrently evaluate this condition. Since hardware transmission
takes time, this condition could remain true across multiple concurrent NAPI
polls. As a result, all active RX queues could simultaneously call
bcmgenet_tx_reclaim(), heavily contending for spin_lock_bh(&ring->lock) and
performing expensive MMIO reads.

Jakub: also, you can't reclaim XDP Tx if budget is 0

> +
>  	work_done = bcmgenet_desc_rx(ring, budget);
>  
>  	if (work_done < budget && napi_complete_done(napi, work_done))

