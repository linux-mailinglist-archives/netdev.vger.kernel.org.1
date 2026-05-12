Return-Path: <netdev+bounces-287052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SApJD436AmokzQEAu9opvQ
	(envelope-from <netdev+bounces-287052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:01:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4E451E324
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 12:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81353301414E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E182E4C6F0F;
	Tue, 12 May 2026 10:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="afHZE3Lp"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82793A9636
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778580096; cv=none; b=lm2sQx85Mjur73MSmwvt+cJkd/EtzJZXSq/YwXbkBsAjYw9hpwBtG30IoQxz4l2OMT+XFHOITKJq1kyn7sdL9huG31kBEmIg8sysSQ3gaaVzJyxdaed8ddzOmSytBoesX/B3cm/x2gAYZU5CFl9Y9fpiMzgGthQOHRV1+SyBAfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778580096; c=relaxed/simple;
	bh=S8vX8zFvv8srZJVxvkSRoM8zVN9lkAc27cPWPzmP6fE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WGYPo/ghUHzTYLxftGveO6hJ8UmFWB78c8OY1oBv5AyztwOQp+kGBfRFoYjLc5Z1QKEDhVjUe/PApTeGd0b+re44RMz0J8haSKEIcVd1oPrrvDOcgKUkcEDexSFItcctALTE/9SOYTmp8XufvFnWsU5JdewadGecgIfOeui5AeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=afHZE3Lp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778580091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQAD/fKc7URc7rajZ6nr8soqR+SrsyqeWEhxOAsPY1o=;
	b=afHZE3LphRx7F6o0IVRWlLo3BbQFn9GzTFy0tEwQKvkI7FltbL2b6mLLQwBZVqr93Xt+Pc
	6QWOl6S9IIXjnWavaKpzaIP58vjjxJD+DfcK2ua92ckD0bdI+7sQfzv4iiQlgfPXCAwyTd
	Bu2obOuIBA+wfEhNOW2BmxB6B7C6PZ0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-Gx6vOyXBNFeWoZJINHyfMA-1; Tue,
 12 May 2026 06:01:26 -0400
X-MC-Unique: Gx6vOyXBNFeWoZJINHyfMA-1
X-Mimecast-MFC-AGG-ID: Gx6vOyXBNFeWoZJINHyfMA_1778580084
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A948D18005B6;
	Tue, 12 May 2026 10:01:24 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.142])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 41CF53002D30;
	Tue, 12 May 2026 10:01:21 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: sukhdeeps@marvell.com
Cc: netdev@vger.kernel.org,
	irusskikh@marvell.com,
	epomozov@marvell.com,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 9/9] net: atlantic: add PTP support for AQC113 (Antigua) (Antigua)
Date: Tue, 12 May 2026 12:01:14 +0200
Message-ID: <20260512100114.144670-1-pabeni@redhat.com>
In-Reply-To: <20260508120156.3060-10-sukhdeeps@marvell.com>
References: <20260508120156.3060-10-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 6E4E451E324
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287052-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,linux.dev];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.989];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: atlantic: add PTP support for AQC113 (Antigua) (Antigua)

This patch adds IEEE 1588 PTP support for the AQC113 (Antigua) controller
alongside the existing AQC107 (Atlantic) PTP path. It introduces dual TSG
clocks, descriptor-writeback TX timestamps, per-instance PTP offsets,
L3/L4 multicast filters, and reworks IRQ vector math and RX filter
application order.

> Subject: net: atlantic: add PTP support for AQC113 (Antigua) (Antigua)

[Low]
The codename "(Antigua)" is duplicated in the subject line.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> @@ -68,20 +70,14 @@ int aq_ndev_open(struct net_device *ndev)
>  	if (err < 0)
>  		goto err_exit;
>  
> -	err = aq_reapply_rxnfc_all_rules(aq_nic);
> -	if (err < 0)
> -		goto err_exit;
> -
> -	err = aq_filters_vlans_update(aq_nic);
> -	if (err < 0)
> -		goto err_exit;
> -
>  	err = aq_nic_start(aq_nic);
>  	if (err < 0) {
>  		aq_nic_stop(aq_nic);
>  		goto err_exit;
>  	}
>  
> +	aq_utils_obj_set(&aq_nic->aq_hw->flags, AQ_HW_FLAG_STARTED);
> +
>  err_exit:
>  	if (err < 0)
>  		aq_nic_deinit(aq_nic, true);
> @@ -97,6 +93,7 @@ int aq_ndev_close(struct net_device *ndev)
>  	err = aq_nic_stop(aq_nic);
>  	aq_nic_deinit(aq_nic, true);
>  
> +	aq_utils_obj_clear(&aq_nic->aq_hw->flags, AQ_HW_FLAG_STARTED);
>  	return err;
>  }

[Medium]
AQ_HW_FLAG_STARTED is set in aq_ndev_open() and cleared in
aq_ndev_close(), but a grep across the tree shows no reader of that
flag.

The commit message lists "Add AQ_HW_FLAG_STARTED flag management in
open/close" as one of the changes.

Is there a consumer of AQ_HW_FLAG_STARTED that was intended to be part
of this patch but was omitted, or should the flag writes be dropped?

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> @@ -172,7 +180,11 @@ static int aq_nic_update_link_status(struct aq_nic_s *self)
>  		aq_nic_update_interrupt_moderation_settings(self);
>  
>  		if (self->aq_ptp) {
> -			aq_ptp_clock_init(self);
> +			/* PTP does not work in some modes even if physical link is up */
> +			bool ptp_link_good = (self->aq_hw->aq_link_status.mbps >= 100 &&
> +					      self->aq_hw->aq_link_status.full_duplex);
> +
> +			aq_ptp_clock_init(self, ptp_link_good ? AQ_PTP_LINK_UP : AQ_PTP_NO_LINK);
>  			aq_ptp_tm_offset_set(self,
>  					     self->aq_hw->aq_link_status.mbps);
>  			aq_ptp_link_change(self);

[High]
aq_nic_update_link_status() runs from aq_linkstate_threaded_isr() and
from aq_nic_service_task(), neither of which holds rtnl_lock. The new
AQC113 path calls into aq_ptp_clock_init() which in turn calls
aq_ptp_dpath_enable().

aq_ptp_dpath_enable() writes aq_ptp->udp_filter[] and programs L3/L4/L2
filter registers. The ioctl path aq_ndev_hwtstamp_set() ->
aq_ptp_hwtstamp_config_set() -> aq_ptp_dpath_enable() runs under
rtnl_lock only, so the lockset intersection with the link-change path
is empty.

Can two concurrent callers of aq_ptp_dpath_enable() tear udp_filter[]
entries and interleave hw_filter_l3l4_set / hw_filter_l2_set register
writes on different CPUs? Before this patch the A1 flow touched these
filters only from the ioctl path, so this race did not exist.

> @@ -279,6 +291,9 @@ static int aq_nic_hw_prepare(struct aq_nic_s *self)
>  	int err = 0;
>  
>  	err = self->aq_hw_ops->hw_soft_reset(self->aq_hw);
> +
> +	self->aq_hw->clk_select = -1;
> +
>  	if (err)
>  		goto exit;

[Medium]
clk_select is set to -1 here and is then fed, without validation, into
hw_atl2_tsg_clock_read() / hw_atl2_tsg_clock_add() /
hw_atl2_tsg_clock_sub() / hw_atl2_tsg_clock_increment_set() through
aq_get_ptp_ts(), hw_atl2_adj_sys_clock() and
hw_atl2_adj_clock_freq().

Those helpers plug the value into HW_ATL2_TSG_REG_ADR(clock_sel, ...)
with no range check. Since clk_select is s8, -1 promoted through the
unsigned int parameter becomes 0xffffffff and produces an out-of-range
MMIO offset.

In aq_ptp_init() the PTP clock is exposed to userspace via
ptp_clock_register() before hw_atl2_enable_ptp() sets clk_select to 0
or 1. A gettime/adjtime on the newly appearing /dev/ptpN during that
window would land in the above helpers with clk_select still equal to
-1.

Would a guard like "if (self->clk_select < 0) return 0;" at the top of
each of those helpers be appropriate?

[Medium]
clk_select is also written by hw_atl2_enable_ptp() (called from
aq_ptp_init / aq_ptp_free / hw_atl2_hw_reset) and read on the TX fast
path via self->aq_hw_ops->hw_get_clk_sel(self->aq_hw) from
aq_nic_map_skb(), as well as by hw_atl2_hw_rx_ptp_ring_init() and
hw_atl2_hw_reset(). There is no lock, no READ_ONCE/WRITE_ONCE, and no
atomic wrapper.

Can a TX in flight during reset/enable/disable observe a torn or stale
clk_select and either tag a descriptor with the wrong clock selector
or propagate -1 into the HW register macros?

> @@ -450,7 +465,14 @@ int aq_nic_init(struct aq_nic_s *self)
>  	}
>  
>  	if (aq_nic_get_cfg(self)->is_ptp) {
> -		err = aq_ptp_init(self, self->irqvecs - 1);
> +		u32 ptp_isr_vec;
> +
> +		if (self->irqvecs > AQ_HW_PTP_IRQS)
> +			ptp_isr_vec = self->irqvecs - AQ_HW_PTP_IRQS;
> +		else
> +			ptp_isr_vec = 0;
> +
> +		err = aq_ptp_init(self, ptp_isr_vec);

[ ... ]

> @@ -793,6 +823,12 @@ unsigned int aq_nic_map_skb(struct aq_nic_s *self, struct sk_buff *skb,
>  
>  	first->eop_index = dx;
>  	dx_buff->is_eop = 1U;
> +	if (skb_shinfo(skb)->tx_flags & SKBTX_IN_PROGRESS &&
> +	    self->aq_hw_ops->enable_ptp &&
> +	    self->aq_hw_ops->hw_get_clk_sel) {
> +		dx_buff->request_ts = 1U;
> +		dx_buff->clk_sel = self->aq_hw_ops->hw_get_clk_sel(self->aq_hw);
> +	}
>  	dx_buff->skb = skb;
>  	dx_buff->xdpf = NULL;
>  	goto exit;

[Critical]
request_ts is armed here whenever SKBTX_IN_PROGRESS is set and the op
pointers exist, not only for PTP traffic. SKBTX_IN_PROGRESS fires for
any SO_TIMESTAMPING socket on AQC113, which makes the following
aq_ring_tx_clean() path reachable via ordinary unprivileged traffic:

drivers/net/ethernet/aquantia/atlantic/aq_ring.c
aq_ring_tx_clean() {
    ...
    if (likely(buff->is_mapped)) {
        ...
        dma_unmap_single(dev, buff->pa, buff->len, DMA_TO_DEVICE);
        /* or dma_unmap_page(...) */
    }

    if (unlikely(buff->is_eop)) {
        if (unlikely(buff->request_ts) &&
            self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts) {
            u64 ts = ...->hw_ring_tx_ptp_get_ts(self);

            if (!ts)
                break;           /* HW has not set DD/TS_VALID yet */
            ...
        }
        ...
    }
    buff->skb = NULL;
    buff->xdpf = NULL;
    buff->pa = 0U;
    ...
    self->sw_head = aq_ring_next_dx(self, self->sw_head);
}

hw_atl2_hw_ring_tx_ptp_get_ts() explicitly returns 0 when DD or
TS_VALID is not yet set, so the zero-timestamp break path is
deliberately reachable.

On the next aq_ring_tx_clean() invocation, sw_head is unchanged,
buff->is_mapped is still 1, and buff->pa still holds the original DMA
handle. Is the second pass going to call dma_unmap_single() or
dma_unmap_page() a second time on the already-unmapped address? A grep
for "is_mapped = 0" in the driver returns no matches, so buff->is_mapped
is never cleared by any other path.

Additionally, the commit message states:

    Poll for TX timestamp completion in aq_ring_tx_clean() with a
    timeout mechanism (aq_ptp_tx_ts_timedout/clear)

Neither aq_ptp_tx_ts_timedout nor aq_ptp_tx_ts_clear exists anywhere
in the tree. If HW never produces a timestamp (for example when
request_ts is armed but AQ_HW_TXD_CTL_TS_EN is not set, or under a HW
glitch), sw_head never advances and the TX ring wedges until the TX
watchdog fires.

Would it be safer to check the timestamp before any DMA unmap and/or
guard the break path so it does not leave buff->is_mapped and buff->pa
live for a repeat unmap?

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> @@ -572,53 +770,53 @@ void aq_ptp_hwtstamp_config_get(struct aq_ptp_s *aq_ptp,
>  	*config = aq_ptp->hwtstamp_config;
>  }
>  
> -static void aq_ptp_prepare_filters(struct aq_ptp_s *aq_ptp)
> +static unsigned int aq_ptp_parse_rx_filters(enum hwtstamp_rx_filters rx_filter)
>  {
> [ ... ]
> +	return ptp_en_flags;
>  }

[Low]
aq_ptp_parse_rx_filters() is typed to take enum hwtstamp_rx_filters,
but aq_ptp_clock_init() calls it with AQ_HW_PTP_DISABLE, which belongs
to the driver-internal AQ_HW_PTP_* bitmask enum. This works today only
because AQ_HW_PTP_DISABLE happens to equal HWTSTAMP_FILTER_NONE (both
zero).

Could the call site pass HWTSTAMP_FILTER_NONE explicitly, or the
helper be reshaped to take a boolean disable argument, so future
renumbering of either enum does not silently break link-down filter
teardown?

> @@ -972,11 +1179,13 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
>  	if (err)
>  		goto err_exit_ptp_tx;
>  
> -	err = aq_ring_hwts_rx_alloc(&aq_ptp->hwts_rx, aq_nic, PTP_HWST_RING_IDX,
> -				    aq_nic->aq_nic_cfg.rxds,
> -				    aq_nic->aq_nic_cfg.aq_hw_caps->rxd_size);
> -	if (err)
> -		goto err_exit_ptp_rx;
> +	if (aq_ptp->a1_ptp) {
> +		err = aq_ring_hwts_rx_alloc(&aq_ptp->hwts_rx, aq_nic, PTP_HWST_RING_IDX,
> +					    aq_nic->aq_nic_cfg.rxds,
> +					    aq_nic->aq_nic_cfg.aq_hw_caps->rxd_size);
> +		if (err)
> +			goto err_exit_ptp_rx;
> +	}
>  
>  	err = aq_ptp_skb_ring_init(&aq_ptp->skb_ring, aq_nic->aq_nic_cfg.rxds);
>  	if (err != 0) {
> @@ -984,7 +1193,7 @@ int aq_ptp_ring_alloc(struct aq_nic_s *aq_nic)
>  		goto err_exit_hwts_rx;
>  	}
>  
> [ ... ]
>  err_exit_hwts_rx:
> -	aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
> +	if (aq_ptp->a1_ptp)
> +		aq_ring_free(&aq_ptp->hwts_rx);
>  err_exit_ptp_rx:

[High]
aq_ring_hwts_rx_alloc() allocates size * dx_size + AQ_CFG_RXDS_DEF via
dma_alloc_coherent(), and aq_ring_hwts_rx_free() passes the same
"+ AQ_CFG_RXDS_DEF" back to dma_free_coherent(). The replacement call
aq_ring_free() here passes only self->size * self->dx_size:

drivers/net/ethernet/aquantia/atlantic/aq_ring.c
aq_ring_free() {
    ...
    dma_free_coherent(aq_nic_get_dev(self->aq_nic),
                      self->size * self->dx_size, self->dx_ring,
                      self->dx_ring_pa);
    ...
}

The DMA API requires dma_free_coherent() to be called with the same
size as dma_alloc_coherent(). The non-error path in aq_ptp_ring_free()
still calls aq_ring_hwts_rx_free().

Is this asymmetric free intentional, and if not, should the error path
use aq_ring_hwts_rx_free() as well?

> @@ -1244,30 +1514,45 @@ void aq_ptp_free(struct aq_nic_s *aq_nic)
>  	if (!aq_ptp)
>  		return;
>  
> +	/* disable ptp */
> +	if (aq_ptp->a1_ptp) {
> +		mutex_lock(&aq_nic->fwreq_mutex);
> +		aq_nic->aq_fw_ops->enable_ptp(aq_nic->aq_hw, 0);
> +		mutex_unlock(&aq_nic->fwreq_mutex);
> +	}
> +
> +	if (aq_ptp->a2_ptp)
> +		aq_nic->aq_hw_ops->enable_ptp(aq_nic->aq_hw,
> +					      aq_ptp->ptp_clock_sel, 0);
> +
> +	cancel_delayed_work_sync(&aq_ptp->poll_sync);
> +

[Medium]
The prior ordering cancelled poll_sync before disabling PTP. This hunk
disables PTP first and then cancels the delayed work.

aq_ptp_poll_sync_work_cb() calls aq_ptp_check_sync1588(), which
touches PTP hardware state (hw_ts_to_sys_clock, ptp_clock_event on
aq_ptp->ptp_clock) and reschedules itself via schedule_delayed_work()
when extts_pin_enabled is set.

Can a pending callback run against PTP hardware that was just turned
off, and would it be better to cancel_delayed_work_sync() first and
only then tear the hardware down?

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> @@ -308,24 +308,30 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
> [ ... see Critical comment above on dma_unmap / break ordering ... ]

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> @@ -886,6 +912,138 @@ static struct aq_stats_s *hw_atl2_utils_get_hw_stats(struct aq_hw_s *self)
> +static int hw_atl2_gpio_pulse(struct aq_hw_s *self, u32 index, u32 clk_sel,
> +			      u64 start, u32 period, u32 hightime)
> +{
> +	u32 mode;
> +
> +	if (start == 0)
> +		mode = HW_ATL2_GPIO_PIN_SPEC_MODE_GPIO;
> +	else if (clk_sel == ATL_TSG_CLOCK_SEL_0)
> +		mode = HW_ATL2_GPIO_PIN_SPEC_MODE_TSG0_EVENT_OUTPUT;
> +	else
> +		mode = HW_ATL2_GPIO_PIN_SPEC_MODE_TSG1_EVENT_OUTPUT;
> +
> +	if (index == 1 || index == 3) { /* Hardware limitation */
> +		hw_atl2_gpio_special_mode_set(self, mode, index);
> +	}
> +
> +	hw_atl2_tsg_ptp_gpio_gen_pulse(self, clk_sel, start, period, hightime);
> +
> +	return 0;
> +}

[Medium]
hw_atl2_gpio_special_mode_set() is only called when index is 1 or 3,
but hw_atl2_tsg_ptp_gpio_gen_pulse() is invoked unconditionally and 0
is returned for every index.

For a PTP_PIN_SETFUNC on pin 0, 2 or any other non-special index, the
TSG pulse generator is armed but the pin mux is never reprogrammed, so
no signal appears on the pin and the userspace request appears to
succeed.

Should invalid indices be rejected with -EINVAL, or should the pulse
generator only be armed when the pin can actually be muxed?

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2_internal.h
> @@ -29,7 +29,8 @@
>  #define HW_ATL2_TXBUF_MAX              128U
>  #define HW_ATL2_PTP_TXBUF_SIZE           8U
>  
> -#define HW_ATL2_RXBUF_MAX              192U
> +/* Reduced from 192 to reserve space for PTP RX timestamp trailer */
> +#define HW_ATL2_RXBUF_MAX              172U
>  #define HW_ATL2_PTP_RXBUF_SIZE          16U

[Medium]
HW_ATL2_RXBUF_MAX is reduced unconditionally for every AQC113 user,
but hw_atl2_hw_qos_set() already subtracts HW_ATL2_PTP_RXBUF_SIZE when
cfg->is_ptp is true, so the reduction appears redundant when PTP is
enabled and a pure loss for non-PTP deployments.

The justification in the comment is per-packet (HW_ATL2_RX_TS_SIZE is
8 bytes, handled in hw_atl2_hw_rx_extract_ts), while this register
programs the on-chip packet-buffer KB allocation.

Could this change be gated on cfg->is_ptp, or is there a separate
reason to take ~10% of the RX packet buffer from non-PTP users?
-- 
This is an AI-generated review.


