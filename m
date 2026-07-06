Return-Path: <netdev+bounces-304912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S64qEcR7S2q1SAEAu9opvQ
	(envelope-from <netdev+bounces-304912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 11:56:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6E470ED2B
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 11:56:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="e0bhBOq/";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304912-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304912-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 733A9317BD2C
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BED432BE7;
	Mon,  6 Jul 2026 09:14:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD8842640F
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:13:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329243; cv=none; b=EkYcf1ymJ8wOhzbsJrk6603f3COmd3svp5AG0xVA15b7IWO6+n1dXiBDPkJmu2uv7RXcT+LlbKCfF9qt+iZBJsiZ/2vfcskf3RXJQ6aLM5+g6MddoKgkl4+b8dCXL7BdQ8H90NLedqc5Kd1Prt6EEuda0vxa7xce1iuY/v8Qy8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329243; c=relaxed/simple;
	bh=uqY9/ockpjF8+4Do6D/QxS1IP5urphdi71NM82HUtvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEiG6hAHMSGPKMZXDVd4vzNZo0Lvok/kbu9777T4xD6wxOO9+xauMZr0w1vaCh29z23jXBp+IDPXbyk00nB141Yjmrfgtpi1Lkun4KeILxj1WHq+dN9q1Nbtx/2iHmgk23ovlzT5AJA1HQxMmUv1FENC2OlO9sHlqqfzH8SYRVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e0bhBOq/; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783329225;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/vMmcC4kWrSghj9zOYbdr017eZqpNDv49JorGXwtkQ=;
	b=e0bhBOq/NHM3GlJ9OyOfaMSsSbPXwnCwvEfRS4lpFbfAKDx86CTwJQ7saoRSs1ZTkXKgW6
	FXUYP75GJ60lwbY4gLT4wydNMAdajysGOqh33tBPLy0NaCdYaWGFv1cW9MbF+pWPut1BLt
	Zoq5r7oda7QNq3xu1POollCqYo3XumM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-7D3y0LjYNc-pGmC_Q9qfLw-1; Mon,
 06 Jul 2026 05:13:41 -0400
X-MC-Unique: 7D3y0LjYNc-pGmC_Q9qfLw-1
X-Mimecast-MFC-AGG-ID: 7D3y0LjYNc-pGmC_Q9qfLw_1783329219
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 536F31800846;
	Mon,  6 Jul 2026 09:13:38 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 453EE300070A;
	Mon,  6 Jul 2026 09:13:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: parvathi@couthit.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	danishanwar@ti.com,
	rogerq@kernel.org,
	pmohan@couthit.com,
	afd@ti.com,
	basharath@couthit.com,
	arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	pratheesh@ti.com,
	j-rameshbabu@ti.com,
	vigneshr@ti.com,
	praneeth@ti.com,
	srk@ti.com,
	rogerq@ti.com,
	m-malladi@ti.com,
	krishna@couthit.com,
	mohan@couthit.com
Subject: Re: [PATCH net-next v2 2/3] net: ti: icssm-prueth: Add priority based RX IRQ handlers
Date: Mon,  6 Jul 2026 11:13:28 +0200
Message-ID: <20260706091328.134740-1-pabeni@redhat.com>
In-Reply-To: <20260630124958.894360-3-parvathi@couthit.com>
References: <20260630124958.894360-3-parvathi@couthit.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304912-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:parvathi@couthit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:danishanwar@ti.com,m:rogerq@kernel.org,m:pmohan@couthit.com,m:afd@ti.com,m:basharath@couthit.com,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:pratheesh@ti.com,m:j-rameshbabu@ti.com,m:vigneshr@ti.com,m:praneeth@ti.com,m:srk@ti.com,m:rogerq@ti.com,m:m-malladi@ti.com,m:krishna@couthit.com,m:mohan@couthit.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9F6E470ED2B

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net: ti: icssm-prueth: Add priority based RX IRQ handlers

This patch adds support for priority based interrupt handling for the STP/
RSTP Switch, HSR and PRP protocols along with extra logic to address first
come first served to avoid port dominance. The driver will read the RX HW
timestamp from the frame to achieve wire-arrival ordering.

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
[ ... ]
> @@ -1188,26 +1188,26 @@ static int icssm_emac_ndo_stop(struct net_device *ndev)
>  	/* disable the mac port */
>  	icssm_prueth_port_enable(emac, false);
>  
> +	netif_stop_queue(ndev);
> +
>  	/* stop PHY */
>  	phy_stop(emac->phydev);
>  
> -	napi_disable(&emac->napi);
>  	hrtimer_cancel(&emac->tx_hrtimer);
>  
[ ... ]
>  	/* stop the PRU */
>  	if (!PRUETH_IS_EMAC(prueth))
>  		icssm_prueth_sw_shutdown_prus(emac, ndev);
>  
>  	if (prueth_is_lre(prueth))
>  		icssm_prueth_lre_cleanup(prueth);

[Severity: High]
This is a pre-existing issue, but is the LRE duplicate detection timer
prematurely canceled when a single port goes down?

In icssm_emac_ndo_stop, icssm_prueth_lre_cleanup is called unconditionally
when any interface is brought down.

If one port in the HSR/PRP bridge goes down while the other remains active,
this cancels the shared tbl_check_timer, potentially causing duplicate
frames to stop being detected and dropped by the hardware.

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_common.c
> @@ -0,0 +1,286 @@
[ ... ]
> +static int icssm_prueth_common_emac_rx_packets(struct prueth_emac *emac,
> +					       int quota, u8 qid1, u8 qid2)
> +{
[ ... ]
> +		if ((*pkt_info_p).length < EMAC_MIN_PKTLEN) {
> +			/* Undersized frame: firmware should have filtered
> +			 * these before they reach the host queue. Advance
> +			 * the read pointer to skip it.
> +			 */
> +			update_rd_ptr = *bd_wr_ptr_p;
> +			ndevstats_p->rx_length_errors++;

[Severity: High]
This is a pre-existing issue, but does this error path flush the entire
pending RX queue?

When the driver detects an undersized or oversized packet, it attempts to
skip it by updating the read pointer. However, setting update_rd_ptr to
*bd_wr_ptr_p appears to assign the hardware's write pointer (the very end of
the queue), rather than advancing by one descriptor.

Could this discard all pending descriptors instead of just the malformed one?

[Severity: High]
Does this introduce a race condition on the network statistics?

This patch introduces split NAPI polling with separate priority threads
(napi_hpq and napi_lpq) that process the high and low priority queues across
both physical ports. These NAPI instances can be scheduled on different CPUs
concurrently.

Both instances invoke icssm_prueth_common_emac_rx_packets, which updates raw
unsigned long statistics like ndevstats_p->rx_length_errors (and 64-bit
stats like emac->stats.rx_bytes in icssm_emac_rx_packet) using += without
atomic instructions or locks.

On 32-bit platforms, could this cause lost updates for concurrent writers, or
torn reads when read by ndo_get_stats64?

> +		} else if ((*pkt_info_p).length > EMAC_MAX_FRM_SUPPORT) {
> +			/* Oversized frame: firmware should have filtered
> +			 * these before they reach the host queue. Advance
> +			 * the read pointer to skip it.
> +			 */
> +			update_rd_ptr = *bd_wr_ptr_p;
> +			ndevstats_p->rx_length_errors++;
> +		} else {
> +			update_rd_ptr = *bd_rd_ptr_p;
> +			ret = icssm_emac_rx_packet(emac_p, &update_rd_ptr,
> +						   pkt_info_p, rxqueue_p);
> +			if (ret)
> +				return used;

[Severity: High]
This is a pre-existing issue, but does a memory allocation failure in this RX
path cause a permanent RX queue stall?

If icssm_emac_rx_packet fails to allocate an SKB, it returns -ENOMEM. The
driver immediately aborts the NAPI polling loop without updating the hardware
read pointer or consuming the packet.

Because it returns used (which is less than budget), it triggers
napi_complete_done() which re-enables the RX interrupt. Since the packet is
still pending in the hardware queue, the interrupt fires again immediately in
an infinite loop.

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c b/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_lre.c
> @@ -152,6 +152,14 @@ static void icssm_prueth_lre_protocol_init(struct prueth *prueth)
>  	       dram1 + ICSS_LRE_SUP_ADDR_LOW);
>  }
>  
> +static void icssm_prueth_lre_config_packet_timestamping(struct prueth *prueth)
> +{
> +	void __iomem *sram = prueth->mem[PRUETH_MEM_SHARED_RAM].va;
> +
> +	writeb(1, sram + ICSS_LRE_PRIORITY_INTRS_STATUS_OFFSET);
> +	writeb(1, sram + ICSS_LRE_TIMESTAMP_PKTS_STATUS_OFFSET);
> +}
> +
[ ... ]
> @@ -202,6 +210,11 @@ void icssm_prueth_lre_config(struct prueth *prueth)
>  	icssm_prueth_lre_init(prueth);
>  	icssm_prueth_lre_dbg_init(prueth);
>  	icssm_prueth_lre_protocol_init(prueth);
> +	/* Enable per-packet timestamping so the driver can order
> +	 * received frames by arrival time across the two slave ports.
> +	 */
> +	icssm_prueth_lre_config_packet_timestamping(prueth);
> +
>  }

[Severity: High]
Does this fail to enable hardware timestamping in Switch mode?

The patch introduces timestamp-based packet ordering for Switch, HSR, and PRP
modes, requiring configuration via ICSS_LRE_PRIORITY_INTRS_STATUS_OFFSET and
ICSS_LRE_TIMESTAMP_PKTS_STATUS_OFFSET.

However, icssm_prueth_lre_config_packet_timestamping is only called from
icssm_prueth_lre_config, which is gated by prueth_is_lre() (only true for HSR
and PRP).

In Switch mode, these registers appear to never be written, potentially
leaving timestamps disabled in firmware and breaking the wire-arrival
ordering logic.

[Severity: High]
This is a pre-existing issue, but are the dynamically allocated FDB learning
work items tracked for cleanup?

When learning a new source MAC address in icssm_prueth_sw_learn_fdb()
(drivers/net/ethernet/ti/icssm/icssm_prueth_switch.c), the driver dynamically
allocates a struct icssm_prueth_sw_fdb_work and queues it.

If these are not tracked in a list, unloading the module could leave pending
work items that execute unmapped memory, potentially causing a kernel panic.

[Severity: High]
This is a pre-existing issue, but can the unbounded GFP_ATOMIC allocations
for FDB learning lead to memory exhaustion?

Every received frame with an unlearned source MAC address triggers
icssm_prueth_sw_learn_fdb(), which uses kzalloc_obj(..., GFP_ATOMIC) without
rate limiting.

A continuous flood of frames with randomized source MAC addresses could
trigger thousands of allocations per second, potentially exhausting the
kernel's atomic memory pools.
-- 
This is an AI-generated review.


