Return-Path: <netdev+bounces-287049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2P7lMwj5AmqvzAEAu9opvQ
	(envelope-from <netdev+bounces-287049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:55:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F5651E1C2
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 11:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7DDA33028AA4
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 199C14C0415;
	Tue, 12 May 2026 09:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LCJFpZ9q"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85FC4C0435
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 09:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778579677; cv=none; b=oJQzt9VJ/oRy3jR4eh3ZAL/PaTcWtADuUtpZepe3Th2i2qaLm4486mubc8BnAOlkwtCsENRRRbBLI8WZdvDqFJqbE7iRm2LF5cVx15ZTEumnTka08MkRDCDVtr8e/NL8m6O8yCkqrusBbhm1zc5y1RFuwBWXU+iWxTv/fZfri1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778579677; c=relaxed/simple;
	bh=IMsNmkRy65sUW9v62AiJOonQE2B1RApX+6cIlsh6xak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QY+opbN6sUFlnH0pPSg5qIIHUSWcYAeqhiPNqQpVDDCF7B5Ih1a/kswsA4kaoxgTfVBT9IwvMUmU8wEKu+4KVoIUuwDWcDtO0IUvAXsmWZCI/JWobnujpvMO0286iI0DSZg9jNE6CPAXXrQdfnfQ1K6ENPbSEf+BRdf6Ph04JSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LCJFpZ9q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778579674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JRPVSpStjZBit8morGDi+j0KMspQHSDSGS/B7HW63Y8=;
	b=LCJFpZ9q1xHnRhkby0Z3WS41G1NxODrQ/BZczh3fPQaBnp9Hq3j4fq41RctXqeDD+fUmB6
	EP6XpcLB9vRi4S5wnZcvAAbDZmW+iYLY7Y+w2qLIahtypWr2EAORu/XjV5J2YsdxrBhKZM
	e9HORFN95nI+Cp1c5iNs+zBqgzH2mSk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-mW96yfF-NYOHznek-_KM2g-1; Tue,
 12 May 2026 05:54:28 -0400
X-MC-Unique: mW96yfF-NYOHznek-_KM2g-1
X-Mimecast-MFC-AGG-ID: mW96yfF-NYOHznek-_KM2g_1778579666
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8D1C118002D6;
	Tue, 12 May 2026 09:54:26 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.142])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5E2751955D84;
	Tue, 12 May 2026 09:54:23 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 9/9] net: atlantic: add PTP support for AQC113 (Antigua) (Antigua)
Date: Tue, 12 May 2026 11:54:20 +0200
Message-ID: <20260512095420.134936-1-pabeni@redhat.com>
In-Reply-To: <20260506135706.2834-10-sukhdeeps@marvell.com>
References: <20260506135706.2834-10-sukhdeeps@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Queue-Id: 78F5651E1C2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,marvell.com,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-287049-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.990];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: atlantic: add PTP support for AQC113 (Antigua) (Antigua)

This patch adds IEEE 1588 PTP support for the AQC113 (Antigua) controller
alongside the existing AQC107 implementation, covering dual TSG clocks,
descriptor-writeback TX timestamps, per-instance PTP offsets, L3/L4
multicast filters, and direct hardware clock control.

A few observations and questions below.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_main.c b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> index 4ef4fe64b8ac..aadf3f7f40d0 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_main.c
> @@ -113,16 +110,25 @@ static netdev_tx_t aq_ndev_start_xmit(struct sk_buff *skb, struct net_device *nd
>  		 * and hardware PTP design of the chip. Otherwise ptp stream
>  		 * will fail to sync
>  		 */
> -		if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) ||
> -		    unlikely((ip_hdr(skb)->version == 4) &&
> -			     (ip_hdr(skb)->protocol == IPPROTO_UDP) &&
> -			     ((udp_hdr(skb)->dest == htons(319)) ||
> -			      (udp_hdr(skb)->dest == htons(320)))) ||
> -		    unlikely(eth_hdr(skb)->h_proto == htons(ETH_P_1588)))
> +		if (unlikely(skb->protocol == htons(ETH_P_IP) &&
> +			     ip_hdr(skb)->protocol == IPPROTO_UDP &&
> +			     (udp_hdr(skb)->dest == htons(PTP_EV_PORT) ||
> +			      udp_hdr(skb)->dest == htons(PTP_GEN_PORT))))
> +			return aq_ptp_xmit(aq_nic, skb);
> +
> +		/* PTP over IPv6 does not use extension headers */
> +		if (unlikely(skb->protocol == htons(ETH_P_IPV6) &&
> +			     ipv6_hdr(skb)->nexthdr == IPPROTO_UDP &&
> +			     (udp_hdr(skb)->dest == htons(PTP_EV_PORT) ||
> +			      udp_hdr(skb)->dest == htons(PTP_GEN_PORT))))
> +			return aq_ptp_xmit(aq_nic, skb);
> +
> +		if (unlikely(eth_hdr(skb)->h_proto == htons(ETH_P_1588)))
>  			return aq_ptp_xmit(aq_nic, skb);
>  	}
>  #endif
>  
> +	skb_tx_timestamp(skb);
>  	return aq_nic_xmit(aq_nic, skb);
>  }

The commit message states:

    Move skb_tx_timestamp() to non-PTP path to avoid double timestamps

Was there actually a pre-existing double-timestamp?  The prior code had
exactly one skb_tx_timestamp() per packet (aq_nic_xmit() for non-PTP,
aq_ptp_xmit() for PTP), so this move appears functionally equivalent for
the PTP case.

However, the new placement in aq_ndev_start_xmit() is before
aq_nic_xmit()'s __netif_subqueue_stopped()/map-failure/NETDEV_TX_BUSY
handling, so software TX timestamps may now be generated for frames that
end up returning NETDEV_TX_BUSY.  Is that intentional?  It changes a
user-visible SO_TIMESTAMPING point for all atlantic chips, not just
AQC113.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
> index 3cec853e9fad..63a4987a60de 100644
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

aq_ptp_clock_init() now calls aq_ptp_dpath_enable(), which writes
hw_filter_l3l4_set/hw_filter_l2_set and mutates aq_ptp->udp_filter[i].cmd
and aq_ptp->eth_type_filter.

The caller of aq_nic_update_link_status() is the service task and
aq_linkstate_threaded_isr, neither of which hold rtnl_lock.  The
hwtstamp ioctl path enters aq_ptp_hwtstamp_config_set() (and thence
aq_ptp_dpath_enable()) under rtnl_lock.  Is there a lock covering both
sides?  The same filter structures and registers can be programmed
concurrently from the two paths, and hwtstamp_config.rx_filter is read
unsynchronized from the link path while written by the ioctl path.

[ ... ]

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> index 7486a28d7ff8..781d865e1127 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ptp.c

[ ... ]

> +static int aq_ptp_dpath_enable(struct aq_ptp_s *aq_ptp,
> +			       int enable_flags, u16 rx_queue)
> +{
[ ... ]
> +		if (enable_flags & AQ_HW_PTP_L2_ENABLE) {
> +			aq_ptp->eth_type_filter.ethertype = ETH_P_1588;
> +			aq_ptp->eth_type_filter.queue = rx_queue;
> +		}
> +
> +		if (hw_ops->hw_filter_l3l4_set) {
> +			for (i = 0; i < flt_idx; i++) {
> +				err = hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
> +						&aq_ptp->udp_filter[i]);
[ ... ]
> +		}
> +
> +		if (!err && hw_ops->hw_filter_l2_set) {
> +			err = hw_ops->hw_filter_l2_set(aq_nic->aq_hw,
> +					&aq_ptp->eth_type_filter);

When enable_flags is AQ_HW_PTP_L4_ENABLE only (for example
HWTSTAMP_FILTER_PTP_V1_L4_* or HWTSTAMP_FILTER_PTP_V2_L4_*), the block
that sets eth_type_filter.ethertype/queue is skipped, but
hw_filter_l2_set is still called unconditionally.  Will that install a
stale L2 filter (zero ethertype from kzalloc, or leftover ETH_P_1588
from a previous call) into hardware?

The pre-patch aq_ptp_prepare_filters() populated both filter
descriptions together, so this is a new behavior.

> +	} else {
> +		/* PTP disabled, clear all UDP/L2 filters */
> +		for (i = 0; i < PTP_UDP_FILTERS_CNT; i++) {
> +			aq_ptp->udp_filter[i].cmd &=
> +				~HW_ATL_RX_ENABLE_FLTR_L3L4;
> +			if (hw_ops->hw_filter_l3l4_set) {
> +				err = hw_ops->hw_filter_l3l4_set(aq_nic->aq_hw,
> +						&aq_ptp->udp_filter[i]);

On the a1_ptp path, only udp_filter[0] is ever populated with real cmd
content; slots 1..3 have only their location field set.  This disable
branch now pushes all four slots through hw_filter_l3l4_set on every
hwtstamp-disable.  Is programming the extra three zero-cmd filter
entries intended for AQC107?

[ ... ]

> @@ -1035,46 +1246,49 @@ static struct ptp_clock_info aq_ptp_clock = {
[ ... ]
> +int aq_ptp_init(struct aq_nic_s *aq_nic, unsigned int idx_ptp_vec)
>  {
>  	bool a1_ptp = ATL_HW_IS_CHIP_FEATURE(aq_nic->aq_hw, ATLANTIC);
> +	bool a2_ptp = ATL_HW_IS_CHIP_FEATURE(aq_nic->aq_hw, ANTIGUA);
[ ... ]
> -	hw_atl_utils_mpi_read_stats(aq_nic->aq_hw, &mbox);
> -
> -	if (!(mbox.info.caps_ex & BIT(CAPS_EX_PHY_PTP_EN))) {
> +	if (a1_ptp) {
> +		hw_atl_utils_mpi_read_stats(aq_nic->aq_hw, &mbox);
> +		if (!(mbox.info.caps_ex & BIT(CAPS_EX_PHY_PTP_EN))) {
> +			aq_nic->aq_ptp = NULL;
> +			return 0;
> +		}
> +	} else {
> +		memset(&mbox, 0, sizeof(mbox));
> +
> +		if (a2_ptp) {
> +			mbox.info.ptp_offset.ingress_100 = HW_ATL2_PTP_OFFSET_INGRESS_100;
[ ... ]
> +		}
> +	}

The A1 path gates PTP on caps_ex & BIT(CAPS_EX_PHY_PTP_EN), but the A2
path enables PTP unconditionally on any ATL_HW_IS_CHIP_FEATURE(...,
ANTIGUA) chip.  The commit message only mentions AQC113, but AQC115c
and AQC116c also match ANTIGUA.  Is there a capability bit that should
gate this for the non-AQC113 Antigua variants?

[ ... ]

>  	/* enable ptp counter */
> +	aq_ptp->ptp_clock_sel = ATL_TSG_CLOCK_SEL_0;
>  	aq_utils_obj_set(&aq_nic->aq_hw->flags, AQ_HW_PTP_AVAILABLE);
> -	mutex_lock(&aq_nic->fwreq_mutex);
> -	aq_nic->aq_fw_ops->enable_ptp(aq_nic->aq_hw, 1);
> -	aq_ptp_clock_init(aq_nic);
> -	mutex_unlock(&aq_nic->fwreq_mutex);
> +	if (a1_ptp) {
> +		mutex_lock(&aq_nic->fwreq_mutex);
> +		aq_nic->aq_fw_ops->enable_ptp(aq_nic->aq_hw, 1);
> +		mutex_unlock(&aq_nic->fwreq_mutex);
> +	}
> +	if (a2_ptp)
> +		aq_nic->aq_hw_ops->enable_ptp(aq_nic->aq_hw, aq_ptp->ptp_clock_sel, 1);

The A1 enable_ptp call is wrapped in fwreq_mutex, but the A2
enable_ptp (which performs hw_atl2_tsg_clock_reset / _en /
hw_atl2_adj_clock_freq / hw_atl2_tpb_tps_highest_priority_tc_enable_set)
is not.  aq_ptp_hw_pin_conf() holds fwreq_mutex when programming the
same TSG/GPIO block via hw_gpio_pulse().  hw_atl2_hw_reset() also calls
hw_atl2_enable_ptp() without fwreq_mutex.  Should the A2 enable_ptp
paths also take fwreq_mutex to avoid concurrent writes to the TSG
block?

[ ... ]

> @@ -1244,30 +1514,45 @@ void aq_ptp_unregister(struct aq_nic_s *aq_nic)
[ ... ]
>  void aq_ptp_free(struct aq_nic_s *aq_nic)
>  {
>  	struct aq_ptp_s *aq_ptp = aq_nic->aq_ptp;
> +	int i;
>  
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
>  	aq_nic_release_filter(aq_nic, aq_rx_filter_ethertype,
>  			      aq_ptp->eth_type_filter.location);
[ ... ]

The pre-patch code cancelled poll_sync first, then disabled PTP.  The
new order disables PTP before cancel_delayed_work_sync(&aq_ptp->poll_sync).

A poll_sync worker running concurrently will call
aq_ptp_check_sync1588() / hw_ts_to_sys_clock() against TSG clocks that
enable_ptp(..., 0) has just torn down.  For A2 the same worker may race
with hw_atl2_tsg_clock_en register writes.

Is there a reason to invert this ordering?  The standard pattern is
cancel_delayed_work_sync() first, then tear down the resources the
worker uses.

> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> index e270327e47fd..a52d6d3fe464 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
> @@ -308,24 +308,30 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
>  			}
>  		}
>  
> -		if (likely(!buff->is_eop))
> -			goto out;
[ ... ]
> +		if (unlikely(buff->is_eop)) {
> +			if (unlikely(buff->request_ts) &&
> +			    self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts) {
> +				u64 ts = self->aq_nic->aq_hw_ops->hw_ring_tx_ptp_get_ts(self);
> +
> +				if (!ts)
> +					break;
>  
> -out:
> +				aq_ptp_tx_hwtstamp(self->aq_nic, ts);
> +			}
> +			if (buff->skb) {
[ ... ]
> +			}
> +		}
>  		buff->skb = NULL;
>  		buff->xdpf = NULL;
>  		buff->pa = 0U;

When hw_ring_tx_ptp_get_ts() returns 0 (TX timestamp not yet ready),
the loop does break.  At that point dma_unmap_single()/dma_unmap_page()
has already run earlier in the iteration, but buff->is_mapped remains
1, buff->pa still holds the original DMA address, buff->skb is still
set, and sw_head is not advanced.

On the next aq_ring_tx_clean() call the same descriptor is revisited
and dma_unmap is called a second time on the already-unmapped address.
Under CONFIG_DMA_API_DEBUG this triggers a WARN; under an IOMMU it may
corrupt mappings.

The commit message also says:

    Poll for TX timestamp completion in aq_ring_tx_clean() with a
    timeout mechanism (aq_ptp_tx_ts_timedout/clear)

but no aq_ptp_tx_ts_timedout or aq_ptp_tx_ts_clear helper appears in
this patch.  Where is the timeout that bounds this polling loop?
If the HW never writes back DD|TS_VALID (silicon quirk, link flap, lost
packet), does the TX ring stall indefinitely and leak the skb and DMA
mapping?

> diff --git a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> index c71e8d1adfc9..3047bda619c0 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/hw_atl2/hw_atl2.c
> @@ -719,14 +735,24 @@ static int hw_atl2_hw_ring_rx_init(struct aq_hw_s *self,
>  				   struct aq_ring_s *aq_ring,
>  				   struct aq_ring_param_s *aq_ring_param)
>  {
> -	return hw_atl_b0_hw_ring_rx_init(self, aq_ring, aq_ring_param);
> +	int res = hw_atl_b0_hw_ring_rx_init(self, aq_ring, aq_ring_param);
> +
> +	if (aq_ptp_ring(aq_ring->aq_nic, aq_ring))
> +		hw_atl2_hw_rx_ptp_ring_init(self, aq_ring);
> +
> +	return res;
>  }
>  
>  static int hw_atl2_hw_ring_tx_init(struct aq_hw_s *self,
>  				   struct aq_ring_s *aq_ring,
>  				   struct aq_ring_param_s *aq_ring_param)
>  {
> -	return hw_atl_b0_hw_ring_tx_init(self, aq_ring, aq_ring_param);
> +	int res = hw_atl_b0_hw_ring_tx_init(self, aq_ring, aq_ring_param);
> +
> +	if (aq_ptp_ring(aq_ring->aq_nic, aq_ring))
> +		hw_atl2_hw_tx_ptp_ring_init(self, aq_ring);
> +
> +	return res;
>  }

hw_atl2_hw_{rx,tx}_ptp_ring_init() return aq_hw_err_from_flags(self),
which reports -ENXIO/-EIO when AQ_HW_FLAG_ERR_UNPLUG or
AQ_HW_FLAG_ERR_HW is set.  The return value is discarded here, so PTP
ring setup errors are hidden from the caller.  Should this be something
like:

    return res ? res : aq_hw_err_from_flags(self);

[ ... ]

> +static u64 hw_atl2_hw_ring_tx_ptp_get_ts(struct aq_ring_s *ring)
> +{
> +	struct hw_atl2_txts_s *txts;
> +
> +	txts = (struct hw_atl2_txts_s *)&ring->dx_ring[ring->sw_head *
> +						HW_ATL2_TXD_SIZE];
> +	/* DD + TS_VALID */
> +	if ((txts->ctrl & HW_ATL2_TXTS_DD) && (txts->ctrl & HW_ATL2_TXTS_TS_VALID))
> +		return txts->ts;
> +
> +	return 0;
> +}

txts lives in DMA-coherent memory written by the device.  The compiler
can issue two separate loads of txts->ctrl between the two bitmask
checks, producing a torn state (DD set, TS_VALID appears unset, or vice
versa).  On weakly-ordered architectures (arm64, powerpc) the CPU can
also speculate txts->ts ahead of the ctrl check.

Should this use a READ_ONCE on ctrl followed by dma_rmb() before
reading txts->ts?

> +static u16 hw_atl2_hw_rx_extract_ts(struct aq_hw_s *self, u8 *p,
> +				    unsigned int len, u64 *timestamp)
> +{
> +	unsigned int offset = HW_ATL2_RX_TS_SIZE;
> +	u8 *ptr;
> +
> +	if (len <= offset || !timestamp)
> +		return 0;
> +
> +	ptr = p + (len - offset);
> +	memcpy(timestamp, ptr, sizeof(*timestamp));
> +
> +	return HW_ATL2_RX_TS_SIZE;
> +}

The data at ptr is written by the device in a defined wire byte order,
but is being copied into a plain host-order u64 with no byteswap.
The A1 helper hw_atl_b0_rx_extract_ts() handles this with explicit
__be64/__be32 locals and be64_to_cpu/be32_to_cpu accessors.  Is the AQC113
field really host-endian, or should big-endian hosts byteswap here as
well?  Also, struct hw_atl2_txts_s declares ts as u64 rather than a
__bitwise type, which will not be caught by sparse.

[ ... ]

aq_ptp_ring_alloc() error path in aq_ptp.c:

> +	if (aq_ptp->a1_ptp) {
> +		err = aq_ring_hwts_rx_alloc(&aq_ptp->hwts_rx, aq_nic, PTP_HWST_RING_IDX,
> +					    aq_nic->aq_nic_cfg.rxds,
> +					    aq_nic->aq_nic_cfg.aq_hw_caps->rxd_size);
> +		if (err)
> +			goto err_exit_ptp_rx;
> +	}
[ ... ]
>  err_exit_hwts_rx:
> -	aq_ring_hwts_rx_free(&aq_ptp->hwts_rx);
> +	if (aq_ptp->a1_ptp)
> +		aq_ring_free(&aq_ptp->hwts_rx);

aq_ring_hwts_rx_alloc() allocates sz = size * dx_size + AQ_CFG_RXDS_DEF
bytes of DMA-coherent memory, but the err_exit_hwts_rx label now calls
aq_ring_free() which frees size * dx_size (the AQ_CFG_RXDS_DEF padding
is dropped).  The pre-patch code used aq_ring_hwts_rx_free() which
matched the allocation size.  Should this stay as aq_ring_hwts_rx_free()
in the error path so dma_free_coherent() sees the original allocation
size?
-- 
This is an AI-generated review.


