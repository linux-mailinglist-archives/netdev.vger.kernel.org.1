Return-Path: <netdev+bounces-295242-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sv56JZB7IWraHAEAu9opvQ
	(envelope-from <netdev+bounces-295242-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:20:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E526D640421
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 15:20:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=QHDsM81D;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295242-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295242-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08F3F30590A0
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 13:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5562745BD6F;
	Thu,  4 Jun 2026 13:16:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FCA428837
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 13:16:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780578983; cv=none; b=g9TQOTVCeeRSf2UDkdDRzO9Pqx4UOk7bN2eSI+kv4HjCE8uLRB8XgFIYhrhbAeMUDavsXfRU2Ytiw3Obnue9o2MSmOKKAAIjqcjjs2iYaeTPKHlgS7t5gqKjVDzIRV8CSW9H4TzF20jn1m4A0vjN4RIfXC7oSYOgruSEb745E7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780578983; c=relaxed/simple;
	bh=8OD6vercM0NQHHJSxm5Sh0hKSf3htVrAK5i51eWlaSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OTKxp/i5696pOskM/XFXobkceEeTp8s1JubcgsKpDVh3RcDz6VPOtgKlC4QCQsqUHaJjJLunVH3/fHc8ackDa1xdRqCUYNbsXhj4KvVP0pEHqgjJdXRWC6FGtS92jiD5bz6hsg7FBsenORPObVQBr+qKkc/UdrcNe5YufWhXvWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QHDsM81D; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780578981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GhL0S4CuF0yaYjDeJxiaG9Bkv2Z5ozlbJ8LkQmq7O/4=;
	b=QHDsM81Dvc9NZR4+bckQxl3mR6l2QEPZdpLGNR7B7pqvSOOtbEgEhJC/38mnQFHsYHGYux
	XOhJlIgkpQ6AWqIq8dsi/VFKZjV/THmnHbxt4zIwDp1UxIHpCIx5DgF+RU80AdvsbrkhuI
	CwMdHr8bKZB4UDD7dJd0cVTkRSnIgJY=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-230-uYZtNnHnOEKK1fT3yG-frw-1; Thu,
 04 Jun 2026 09:16:17 -0400
X-MC-Unique: uYZtNnHnOEKK1fT3yG-frw-1
X-Mimecast-MFC-AGG-ID: uYZtNnHnOEKK1fT3yG-frw_1780578975
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 581311956088;
	Thu,  4 Jun 2026 13:16:15 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.49.23])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 751C9763;
	Thu,  4 Jun 2026 13:16:11 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: j.raczynski@samsung.com
Cc: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	linux-kernel@vger.kernel.org,
	k.domagalski@samsung.com,
	k.tegowski@samsung.com,
	cs0617.lee@samsung.com
Subject: Re: [PATCH net-next v2 3/3] include/stmmac: Increase max DMA/MTL channel count from 8 to 16
Date: Thu,  4 Jun 2026 15:16:06 +0200
Message-ID: <20260604131606.185700-1-pabeni@redhat.com>
In-Reply-To: <20260601162537.553512-4-j.raczynski@samsung.com>
References: <20260601162537.553512-4-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,samsung.com];
	TAGGED_FROM(0.00)[bounces-295242-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:j.raczynski@samsung.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-kernel@vger.kernel.org,m:k.domagalski@samsung.com,m:k.tegowski@samsung.com,m:cs0617.lee@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E526D640421

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
include/stmmac: Increase max DMA/MTL channel count from 8 to 16

Newer XGMAC hardware does support up to 16 DMA/MTL queues. Add support for
these after previous modifications of driver to accommodate for that.

> diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> index 4430b967abdeb..a9d19e2c388c6 100644
> --- a/include/linux/stmmac.h
> +++ b/include/linux/stmmac.h
> @@ -15,9 +15,9 @@
>  #include <linux/platform_device.h>
>  #include <linux/phylink.h>
>  
> -#define MTL_MAX_RX_QUEUES	8
> -#define MTL_MAX_TX_QUEUES	8
> -#define STMMAC_CH_MAX		8
> +#define MTL_MAX_RX_QUEUES	16
> +#define MTL_MAX_TX_QUEUES	16
> +#define STMMAC_CH_MAX		16

[Severity: High]
Does increasing these limits to 16 cause undefined behavior and silent register
truncation in the hardware configuration functions when queue >= 8?

In dwxgmac2_core.c:dwxgmac2_tx_queue_prio(), when queue >= 8, the logic
only subtracts 4:

    if (queue >= 4)
        queue -= 4;

This leaves queue >= 4, which causes XGMAC_PSTC_SHIFT(queue) to shift by >= 32
bits, overflowing the 32-bit integer.

A similar regression occurs in dwmac4_core.c:dwmac4_tx_queue_priority() where
it shifts by GMAC_TXQCTRL_PSTQX_SHIFT(queue).

Additionally, in dwmac4_core.c:dwmac4_rx_queue_routing(), the queue variable
is masked against a 3-bit bitmask, which silently truncates any queue >= 8:

    value |= (queue << route_possibilities[packet-1].reg_shift) & 
             route_possibilities[packet - 1].reg_mask;

Finally, dwmac4_core.c:dwmac4_map_mtl_dma() only maps queues up to 7 (using
MAP0 and MAP1):

    if (queue < 4) {
    ...
    } else {
        value = readl(ioaddr + MTL_RXQ_DMA_MAP1);
        value &= ~MTL_RXQ_DMA_QXMDMACH_MASK(queue - 4);

For queue >= 8, the shift calculation overflows and corrupts register data.
Should these hardware configuration functions be updated to handle the expanded
queue limits?

[Severity: Critical]
This is a pre-existing issue, but does missing bounds checking on the device
tree properties expose an out-of-bounds array access during device probe?

In stmmac_platform.c:stmmac_mtl_setup(), the device tree property
snps,tx-queues-to-use is parsed and clamped only to 255 (U8_MAX):

    if (!of_property_read_u32(tx_node, "snps,tx-queues-to-use", &value)) {
        if (value > U8_MAX)
            value = U8_MAX;
        plat->tx_queues_to_use = value;
    }

Later in stmmac_main.c:stmmac_hw_setup(), it attempts to dynamically clamp
this value to the hardware capabilities:

    if (priv->dma_cap.number_tx_queues &&
        priv->plat->tx_queues_to_use > priv->dma_cap.number_tx_queues) {
        priv->plat->tx_queues_to_use = priv->dma_cap.number_tx_queues;
    }

However, if the hardware feature registers report 0 (which happens for older
GMAC versions), this check is bypassed. The driver fails to clamp the
requested queues against the static internal array limit MTL_MAX_TX_QUEUES.

As a result, in stmmac_main.c:init_dma_tx_desc_rings(), the initialization
loop iterates up to the unvalidated tx_queues_to_use:

    for (queue = 0; queue < tx_queue_cnt; queue++)
        __init_dma_tx_desc_rings(priv, dma_conf, queue);

This will overrun the bounds of arrays embedded in struct stmmac_priv (like
dma_conf->tx_queue) if the device tree configuration exceeds the static array
limits. Should we add a strict bounds check against MTL_MAX_TX_QUEUES and
MTL_MAX_RX_QUEUES during probe?
-- 
This is an AI-generated review.


