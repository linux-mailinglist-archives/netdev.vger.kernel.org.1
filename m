Return-Path: <netdev+bounces-304911-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id druZHgd+S2o1SQEAu9opvQ
	(envelope-from <netdev+bounces-304911-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:05:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF73970EE47
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:05:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=U5BckmyC;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304911-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304911-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 282E534EBBC6
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 09:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9809B42F715;
	Mon,  6 Jul 2026 09:13:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5958395AE4
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:13:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329225; cv=none; b=tNFzDjenVgdRPiDaCijZDKUNHUcsh+fQ7KwwAQBDudS+pikNh8YHYM6WSAgQ26W2moMmncsqdlsLCTvEJoAnmR6WWoe7D8bI/G7pnl+uvIkdShskCHsuhVOHNwmxttAO8rrycBpW/LsMB6tKylROgGiE724S8B3nRrSruSj3lFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329225; c=relaxed/simple;
	bh=IMyw4cRZ7R1CsubNzgxgt8Of/Rq8Ggx4vxJ68Om5cu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NaHWt9dMrHw9RSLBrKL72GprRCtXhOo30Z+eUwv0fEzX6cQVD5Gsq1EFk8KtaMBfUhfhGBA4ZcN4UI460oDPYe8dx1pZd1bVuG8jVFzfDQrM2+YeZjPI3ScQkbtSy8i4OpH0NcRlvVNFL85CGAYSPEdS3uQhzjPgi4LbdqzNEr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5BckmyC; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783329213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zxf73Z9LVcCtgiRAVysSS0IZVg1LZRrQrjTa3gvtixQ=;
	b=U5BckmyC7wOg2koVF0HDERHl4pLDUg2dIj7vLQP91000yC5r3ZQCBx/uOEjYjnqpaACtA2
	kEDM+GBdh7KnRpwmBebhDyRAtEqRgo9+n5l2Gr5cpGOFnG4Nytm96gx/wOVdzJk4x0lGSl
	+NabfoxFnyf99C6w5bfjW/EqLeKd9Is=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-404-TJYIGl1TMu61YYIhCbunfg-1; Mon,
 06 Jul 2026 05:13:31 -0400
X-MC-Unique: TJYIGl1TMu61YYIhCbunfg-1
X-Mimecast-MFC-AGG-ID: TJYIGl1TMu61YYIhCbunfg_1783329208
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F79F1955F18;
	Mon,  6 Jul 2026 09:13:28 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 86BB5300070A;
	Mon,  6 Jul 2026 09:13:20 +0000 (UTC)
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
Subject: Re: [PATCH net-next v2 1/3] net: ti: icssm-prueth: Add HSR and PRP HW offload mode support for AM57xx, AM437x and AM335x
Date: Mon,  6 Jul 2026 11:13:14 +0200
Message-ID: <20260706091314.134721-1-pabeni@redhat.com>
In-Reply-To: <20260630124958.894360-2-parvathi@couthit.com>
References: <20260630124958.894360-2-parvathi@couthit.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304911-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: CF73970EE47

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
Subject: net: ti: icssm-prueth: Add HSR and PRP HW offload mode support for AM57xx, AM437x and AM335x

This commit introduces hardware offload support for the HSR and PRP redundancy
protocols on TI PRU-ICSS Ethernet MACs. It enables firmware-based frame
duplicate detection and L2 forwarding, treating PRU Ethernet ports as Link
Redundancy Entity (LRE) slaves. The driver can now dynamically switch between
dual-EMAC, switch, and HSR/PRP modes.

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
[ ... ]
> @@ -564,7 +592,7 @@ static int icssm_prueth_tx_enqueue(struct prueth_emac *emac,
[ ... ]
>         /* update first buffer descriptor */
>  	wr_buf_desc = (pktlen << PRUETH_BD_LENGTH_SHIFT) &
>  		       PRUETH_BD_LENGTH_MASK;
> +	if (PRUETH_IS_HSR(prueth))
> +		wr_buf_desc |= BIT(PRUETH_BD_HSR_FRAME_SHIFT);

[Severity: High]
Does padding small packets with eth_skb_pad() in icssm_emac_ndo_start_xmit()
interfere with PRP trailer detection here?

When a short PRP frame is padded to 60 bytes in icssm_emac_ndo_start_xmit(),
the zero-padding is appended after the RCT. Later, in
icssm_prueth_tx_enqueue(), the driver attempts to read the RCT like this:

    struct prp_txopt_rct *rct =
        (struct prp_txopt_rct *)(skb_tail_pointer(skb) - ICSSM_LRE_TAG_SIZE);

Won't this calculation point into the trailing zero-padding instead of the
actual RCT? This would cause small PRP frames to bypass redundancy
duplication.

[ ... ]
> @@ -912,6 +963,25 @@ static int icssm_emac_request_irqs(struct prueth_emac *emac)
>  	return ret;
>  }
>  
> +static int icssm_emac_sanitize_feature_flags(struct prueth_emac *emac)
> +{
> +	netdev_features_t request_lre;
> +
> +	request_lre = emac->ndev->features & NETIF_PRUETH_LRE_OFFLOAD_FEATURES;
> +
> +	if (prueth_is_lre(emac->prueth) && !request_lre) {
> +		netdev_err(emac->ndev, "Error: Turn ON HSR offload\n");
> +		return -EINVAL;
> +	}

[Severity: Medium]
Is this check sufficient to handle partial feature toggling?

If a user disables NETIF_F_HW_HSR_TAG_RM via ethtool while leaving
NETIF_F_HW_HSR_FWD active, request_lre will still evaluate to non-zero and
bypass this validation. Since the firmware unconditionally strips the tag,
could this mismatched configuration cause the software stack to misinterpret
the inner IP header as an HSR tag?

[ ... ]
> @@ -1079,6 +1162,9 @@ static int icssm_emac_ndo_stop(struct net_device *ndev)
>  	else
>  		rproc_shutdown(emac->pru);
>  
> +	if (prueth_is_lre(prueth))
> +		icssm_prueth_lre_cleanup(prueth);

[Severity: High]
Could this unconditionally cancel the global HSR/PRP duplicate table check
timer while the other LRE port is still running?

If eth0 is brought down, the timer is canceled here, but if eth1 remains
active, the duplication tables could silently fill up and drop legitimate
frames because the check timer is never restarted.

[ ... ]
> @@ -1122,7 +1208,8 @@ static int icssm_prueth_change_mode(struct prueth *prueth,
>  		}
>  	}
>  
> -	if (mode == PRUSS_ETHTYPE_EMAC || mode == PRUSS_ETHTYPE_SWITCH) {
> +	if (mode == PRUSS_ETHTYPE_EMAC || mode == PRUSS_ETHTYPE_SWITCH ||
> +	    mode == PRUSS_ETHTYPE_HSR || mode == PRUSS_ETHTYPE_PRP) {

[Severity: High]
This is a pre-existing issue, but can the direct invocation of ndo_open() and
ndo_stop() inside icssm_prueth_change_mode() cause a deadlock?

If ndev->netdev_ops->ndo_open(ndev) fails and returns an error, the function
aborts without restoring the NAPI state. Later, when the interface is brought
down, the kernel naturally invokes ndo_stop() again. A second napi_disable()
call on an already disabled NAPI might trigger an infinite sleep waiting for
NAPI_STATE_SCHED.

[ ... ]
> @@ -1360,6 +1465,8 @@ static void icssm_emac_ndo_set_rx_mode(struct net_device *ndev)
[ ... ]
>  	/* It is a shared table. So lock the access */
> -	spin_lock_irqsave(&emac->addr_lock, flags);
> +	spin_lock_irqsave(mc_filter_tbl_lock, flags);
>  
>  	/* Disable and reset multicast filter, allows allmulti */
>  	icssm_emac_mc_filter_ctrl(emac, false);

[Severity: High]
Does this function corrupt the shared multicast hardware filter table in LRE
mode?

By calling icssm_emac_mc_filter_reset() the shared table in DRAM1 is cleared.
The code then repopulates the table by iterating only over the current
net_device's multicast addresses. Could this silently drop multicast traffic
for the other active slave port since its addresses are wiped out?

[ ... ]
> +static int icssm_prueth_hsr_port_link(struct net_device *ndev,
> +				      struct net_device *hsr_ndev)
> +{
[ ... ]
> +	spin_lock_irqsave(&emac->addr_lock, flags);
> +
> +	if (!prueth->hsr_members) {

[Severity: Low]
Is the per-port emac->addr_lock the correct lock to use when modifying the
device-wide shared state in prueth->hsr_members and prueth->hsr_dev?

While the networking core's global rtnl_lock might serialize this path during
NETDEV_CHANGEUPPER, using a local instance lock to protect global state could
be a maintainability hazard.

[ ... ]
> +free_hsr:
> +	spin_lock_irqsave(&emac->addr_lock, flags);
> +
> +	prueth->hsr_dev = NULL;
> +	prueth->hsr_members &= ~BIT(emac->port_id);
> +
> +	spin_unlock_irqrestore(&emac->addr_lock, flags);
> +	return ret;
> +}

[Severity: High]
If adding the second HSR/PRP port fails (e.g., during
icssm_prueth_change_mode), does this error path corrupt the bridge state?

Unconditionally clearing the shared prueth->hsr_dev pointer while the first
port is still present in prueth->hsr_members appears to permanently break
subsequent link attempts for the second port, because future links will fail
on the earlier condition:

    if (prueth->hsr_dev != hsr_ndev)
-- 
This is an AI-generated review.


