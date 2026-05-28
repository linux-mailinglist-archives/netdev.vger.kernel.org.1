Return-Path: <netdev+bounces-292673-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8MJmJ84vGGpwfggAu9opvQ
	(envelope-from <netdev+bounces-292673-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:06:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD695F1D8E
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:06:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09219304B7FF
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 12:02:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217883E7BD5;
	Thu, 28 May 2026 12:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTAExcmY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B5643BCD0A
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 12:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969747; cv=none; b=Ba4zl3m/f+Ycv02Mx38eVm66Bk5WvnqTp+6rFbe6NvCzgDCnWLKTAQmlAFvG+bNNSmG4R3Mf8PJqpZqb7pjY3YrklwDRZk6bVoA75di+JRX4E6guDnuT3v3rGBH9AxkUy4VcJKxgavqVS+srTEnukqbEcYZDZlB+0Mp2k63Gyto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969747; c=relaxed/simple;
	bh=6cM35Bx2qrgmMK0CzTokmkZPVcv63xB6Vnfev5Z9dyw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0q+9ewjQOo3M1qSxScsuN+1ex5Sfc3rT05R/85QYuktYEuS02DPmn1U4CZLe5+biO7qFuQlGG2efbqzg8Zgim1VFojua0olCGg5sctCW1s9Dmw361yl+vpQpMs6fhfHoec8AxWpw5ZGiZZlAUwM9dtkipL51eSnaJ26jx+sBx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FTAExcmY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779969744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FwpPKrXQ70T1twLFwNf8lR/i2OUb1jZoS9ZO8mh+Lqw=;
	b=FTAExcmYCSJNQ/hmg7FsGBQ1RcCwO3Q/f8NMy7TYULZq2HmwW5GtaV/CmVv6zS4pri1mvF
	Vq8mY2xgiKWhpLUtAL7hh1/sC3ANRZrxINBu/NJCCk3sqT4kAFhPMzx5Ycxv1SrDVHZ/N7
	oMU0tIVTH3koVLL9HM+YdCaA6VOr3S8=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-pl0e5186NvS9R3RHH2gBjg-1; Thu,
 28 May 2026 08:02:20 -0400
X-MC-Unique: pl0e5186NvS9R3RHH2gBjg-1
X-Mimecast-MFC-AGG-ID: pl0e5186NvS9R3RHH2gBjg_1779969738
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5A8B819560B1;
	Thu, 28 May 2026 12:02:17 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.235])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B990219560AB;
	Thu, 28 May 2026 12:02:09 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: dinghui1111@163.com
Cc: andrew@lunn.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	dinghui@lixiang.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xiasanbo@lixiang.com,
	yangchen11@lixiang.com,
	liuxuanjun@lixiang.com
Subject: Re: [PATCH v2] net: stmmac: fix fatal bus error on resume by reinitializing RX buffers
Date: Thu, 28 May 2026 14:02:02 +0200
Message-ID: <20260528120203.245762-1-pabeni@redhat.com>
In-Reply-To: <20260526022620.501229-1-dinghui1111@163.com>
References: <20260526022620.501229-1-dinghui1111@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,lixiang.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292673-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[163.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[19];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1DD695F1D8E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: stmmac: fix fatal bus error on resume by reinitializing RX buffers

This patch adds stmmac_reinit_rx_descriptors() and calls it from
stmmac_resume() before stmmac_clear_descriptors() to re-program the RX
descriptor buffer-address fields from buffers that survived across the
PM transition, avoiding any allocation in the resume path.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 3591755ea30b..0dc27d8c66a0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1642,6 +1642,79 @@ static void stmmac_clear_descriptors(struct stmmac_priv *priv,
>  		stmmac_clear_tx_descriptors(priv, dma_conf, queue);
>  }
>  
> +/**
> + * stmmac_reinit_rx_descriptors - re-program RX descriptors from existing
> + *				   buffers (allocation-free)

[ ... ]

> +static void stmmac_reinit_rx_descriptors(struct stmmac_priv *priv,
> +					 struct stmmac_dma_conf *dma_conf,
> +					 u32 queue)
> +{
> +	struct stmmac_rx_queue *rx_q = &dma_conf->rx_queue[queue];
> +	int i;
> +
> +	for (i = 0; i < dma_conf->dma_rx_size; i++) {
> +		struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
> +		struct dma_desc *p = stmmac_get_rx_desc(priv, rx_q, i);
> +
> +		if (rx_q->xsk_pool) {
> +			dma_addr_t dma_addr;
> +
> +			/* The XSK pool may not be fully populated (e.g.
> +			 * xdpsock TX-only); skip empty slots.
> +			 */
> +			if (!buf->xdp)
> +				continue;

[High]
Does the continue here regress to the same fatal bus error this patch
sets out to fix?

When the slot is skipped, its descriptor address fields keep whatever
HW writeback left behind. Then stmmac_clear_descriptors() runs right
after stmmac_reinit_rx_descriptors() in stmmac_resume() and unconditionally
re-arms OWN on every slot. For dwmac4 that is dwmac4_set_rx_owner():

	p->des3 |= cpu_to_le32(RDES3_OWN | RDES3_BUFFER1_VALID_ADDR |
			       RDES3_INT_ON_COMPLETION_EN);

and for enh_desc / ndesc the equivalent OR of RDES0_OWN / RDES1 fields.
None of these clear the address fields.

When stmmac_hw_setup() restarts the DMA, the controller sees an owned
descriptor with VALID_ADDR set and a stale address — the exact failure
mode the commit message describes. Could the skipped slots be cleared
(stmmac_clear_desc() or zeroing des0/des1/des2) instead of left intact,
or arranged so clear_descriptors() does not arm OWN on them?

> +
> +			dma_addr = xsk_buff_xdp_get_dma(buf->xdp);
> +			stmmac_set_desc_addr(priv, p, dma_addr);
> +			stmmac_set_desc_sec_addr(priv, p, 0, false);
> +		} else {
> +			/* Theoretically unreachable: napi_disable() in
> +			 * stmmac_suspend() ensures all initialized slots
> +			 * have a valid page before we get here.
> +			 * Defensive check only.
> +			 */
> +			if (!buf->page)
> +				continue;

[High]
Is the comment "Theoretically unreachable: napi_disable() in
stmmac_suspend() ensures all initialized slots have a valid page"
accurate?

stmmac_rx() assigns buf->page = NULL at multiple points when handing the
page on to the stack or to XDP, for example:

	buf->page = NULL;

in stmmac_rx() after the page has been consumed.

stmmac_rx_refill() allocates with GFP_ATOMIC | __GFP_NOWARN and breaks
on allocation failure without advancing dirty_rx, leaving the failing
slot (and any subsequent slots) with buf->page == NULL:

	if (!buf->page) {
		buf->page = page_pool_alloc_pages(rx_q->page_pool, gfp);
		if (!buf->page)
			break;
		...
	}

stmmac_disable_all_queues() only does synchronize_rcu() and
napi_disable() — it does not retry refills. Under the memory-pressure
scenario this patch is explicitly designed to make safe, a prior
GFP_ATOMIC failure can leave the ring with NULL-page slots at the
moment suspend happens.

If such a slot is then skipped here, the same OWN-with-stale-address
condition described above applies on resume. Should the page_pool path
also clear the descriptor for skipped slots, or allocate a replacement
buffer rather than leave a stale-address descriptor for
stmmac_clear_descriptors() to arm?

> +
> +			stmmac_set_desc_addr(priv, p, buf->addr);
> +			stmmac_set_desc_sec_addr(priv, p, buf->sec_addr,
> +						 priv->sph_active &&
> +						 buf->sec_page);
> +
> +			if (dma_conf->dma_buf_sz == BUF_SIZE_16KiB)
> +				stmmac_init_desc3(priv, p);
> +		}
> +	}

[ ... ]

> +}
> +
-- 
This is an AI-generated review.


