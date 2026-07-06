Return-Path: <netdev+bounces-304913-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yRAyN4+RS2qxVgEAu9opvQ
	(envelope-from <netdev+bounces-304913-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:29:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A52170FD87
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 13:29:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="jUE/xGOL";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304913-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304913-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55440320FDE8
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E965432BED;
	Mon,  6 Jul 2026 09:14:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3EF432BD8
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:14:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329250; cv=none; b=HJYUM8Va1814jFgb/IhaqFhUvl0AzjiCRG3b6EWsxO1ycHAgZ21VIHLEM21rgASkSeK9ABsa8VeWY9WpBpqyvr/7GeoO+pxo9LrRwxCzePXCbrXhSF7jFibsPuH0B6vGmldT2nfob+EaauXeTj6IeBbYeWulOGfrhSo5FFqjq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329250; c=relaxed/simple;
	bh=xjbqe6Ea7FqsVWuk0HgiPhmVFC0rjaG4stXuA+LRMRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KoQyZ/OEiKI350YcGXxj67btZq9g4vmsAOVnkrAyD8zTCerMUqW6ghMECRvA/qNPW3BLgjkQppIDr6Yb5UGuco6y6w684mx8Qm/iY8rIAvdCO+FpxVhvvBoN8Kyk0oREJd1u52GFoQe3frkFVz/yeQ+2IUa2439vEhtQavBgbXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jUE/xGOL; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783329235;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OZJn90Px9hZJUz6AB3nf2Qs9xkQXJCI5324Fe6y0Nzs=;
	b=jUE/xGOLf/NgoUhxLrHJU++uFNekRSGPvv39ah8TvlGXN+qiStZRYf60KecX0UAEcPdXPO
	VZZfL42QxmmiifCzqty0w8XoFX3WDSzVaWG3PhZunoQDSOas1cPA2F6p4pkraDN8W1Qhc1
	SifwKH3WzQESvJXVgjWbLrvmojRxFQ8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-k0_NrMkTMqa0sm7gCWKE4w-1; Mon,
 06 Jul 2026 05:13:51 -0400
X-MC-Unique: k0_NrMkTMqa0sm7gCWKE4w-1
X-Mimecast-MFC-AGG-ID: k0_NrMkTMqa0sm7gCWKE4w_1783329228
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D9A361955F05;
	Mon,  6 Jul 2026 09:13:47 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EEED918005A2;
	Mon,  6 Jul 2026 09:13:40 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2 3/3] net: ti: icssm-prueth: Support duplicate HW offload feature for HSR and PRP
Date: Mon,  6 Jul 2026 11:13:38 +0200
Message-ID: <20260706091338.134754-1-pabeni@redhat.com>
In-Reply-To: <20260630124958.894360-4-parvathi@couthit.com>
References: <20260630124958.894360-4-parvathi@couthit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304913-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:parvathi@couthit.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:danishanwar@ti.com,m:rogerq@kernel.org,m:pmohan@couthit.com,m:afd@ti.com,m:basharath@couthit.com,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:pratheesh@ti.com,m:j-rameshbabu@ti.com,m:vigneshr@ti.com,m:praneeth@ti.com,m:srk@ti.com,m:rogerq@ti.com,m:m-malladi@ti.com,m:krishna@couthit.com,m:mohan@couthit.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A52170FD87

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net: ti: icssm-prueth: Support duplicate HW offload feature for HSR and PRP

This commit introduces hardware duplicate offload for HSR and PRP modes. It
implements a common shared queue between the two ports, writing frames once
to OCMC RAM and relying on the firmware to replicate the transmission.

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> index 2ab78a98f8568..cbe666a212c3b 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> @@ -97,6 +125,17 @@ static void icssm_prueth_write_reg(struct prueth *prueth,
>  static enum pruss_mem pruss_mem_ids[] = { PRUSS_MEM_DRAM0, PRUSS_MEM_DRAM1,
>  					  PRUSS_MEM_SHRD_RAM2 };
>  
> +struct prp_txopt_rct {
> +	__be16 sequence_nr;
> +	__be16 lan_id_and_lsdu_size;
> +	__be16 prp_suffix;
> +};

[Severity: High]
Does this structure definition need the __packed attribute?

This struct consists of three 16-bit fields but lacks the __packed attribute,
so it inherits a 2-byte alignment requirement.  Later in
icssm_prueth_tx_enqueue, a pointer to this structure is derived directly
from skb_tail_pointer.

If an ethernet frame payload has an odd byte length, wouldn't casting and
dereferencing this pointer cause an unaligned 16-bit memory access, resulting
in hardware traps or panics on architectures that do not support it?

[ ... ]
> @@ -549,15 +588,24 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
[ ... ]
> +	other_emac = emac->prueth->emac[(emac->port_id == PRUETH_PORT_MII0) ?
> +				PRUETH_PORT_MII1 - 1 : PRUETH_PORT_MII0 - 1];
> +
> +	if (prueth_is_lre(prueth) && (emac->link || other_emac->link))
> +		link_up = true;

[Severity: High]
Could this logical OR cause the shared transmission queue to stall completely
if only one of the slave links goes down?

If one port loses its link, its emac->link is 0, but the other active port
will still evaluate link_up as true. The active port would continue sending
duplicate frames to the shared queue.

[ ... ]
> @@ -605,6 +659,29 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
[ ... ]
> +		if (free_blocks_other_port < free_blocks)
> +			free_blocks = free_blocks_other_port;
> +	}

[Severity: High]
Following up on the link_up logic above, since the available queue space is
bounded by the slowest reader here, wouldn't the inactive port's read pointer
remain frozen?

This appears to exhaust the free_blocks pool, causing the active port to
eventually spin and return -ENOBUFS permanently, defeating the redundancy.

[ ... ]
> +		} else {
> +			/* Read PRP RCT to extract sequence number and LAN ID */
> +			struct prp_txopt_rct *rct =
> +				(struct prp_txopt_rct *)(skb_tail_pointer(skb) -
> +							 ICSSM_LRE_TAG_SIZE);
> +
> +			if (rct->prp_suffix == htons(ETH_P_PRP)) {

[Severity: High]
Is it safe to directly dereference rct->prp_suffix here?

As mentioned above regarding the struct definition, this might lead to an
unaligned memory access on certain architectures. Perhaps using the
get_unaligned_be16 helper would be safer here, or adding the __packed
attribute to the structure definition.

[ ... ]
> @@ -1341,18 +1516,30 @@ static enum netdev_tx icssm_emac_ndo_start_xmit(struct sk_buff *skb,
[ ... ]
> +	raw_spin_lock(lock_queue);
> +	ret = icssm_prueth_tx_enqueue(emac, skb, qid);
> +	raw_spin_unlock(lock_queue);

[Severity: High]
Does this need to use the irqsave variant to protect against cross-device
deadlocks with netpoll?

The lre_host_queue_lock is shared between the two ports. If a hardirq
preempts a CPU while it holds this lock during a transmission, and the
interrupt handler invokes a printk that triggers netconsole over the second
interface, netpoll might bypass the netif_tx_lock.

When the second interface calls into ndo_start_xmit, it would attempt to
acquire the exact same lre_host_queue_lock, causing it to spin forever on
the same CPU.
-- 
This is an AI-generated review.


