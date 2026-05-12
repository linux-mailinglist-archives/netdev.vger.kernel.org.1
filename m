Return-Path: <netdev+bounces-286999-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCqtFBfjAmpEyQEAu9opvQ
	(envelope-from <netdev+bounces-286999-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:21:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5729451C97E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 10:21:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA2173051C77
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BAF4949EB;
	Tue, 12 May 2026 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TZJ4WY1i"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC64492183
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778573873; cv=none; b=uqPL4kiQllP1QHM0zsdGDIAOMkOlE1iALj++Rml6rlba7aJ6WyN+6z0AUxhARlHkiXd+x/3Y9HtvTVxLZQ1KjEQyfTfygkAQmmYfIWm87wsllVPDo7JFEwyApa0Clu8uBvTEqeqcXq587TndrZNcbuItWuPf7KiLdrFN15D5rxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778573873; c=relaxed/simple;
	bh=WhhEMn4q1SGZedKH4RO/L0LJJrL6ReFEQfDAIxqsRCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eEskSsDOTdzm0F8Au/4mPwAJiwHzWAjbWS89Nq2pedQcfBqGCCpqbg26d6BvBzcMMaQRgPJYbitEakiqWw+LV55tRsRcUc1mgHvQzR/8a1mdw4iCTTGLebEzsNSOaR/WAk9zLqYTb64yomidBR09JLzVWBSui/KZy9RkwQSpig0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TZJ4WY1i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778573867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r1jIh7E0wJSsW4k/GK3a1NAtTTlKwr9vO5nrHvcHlgI=;
	b=TZJ4WY1iF8v6dnaYihfBpRNH8xLpvLTFMmJ+FosmSGI/FmxCqADlseo6FwF3bgAsk/eV54
	ip2kyN1sTssftHC0SveQKV0Ctf/R3K21F0MbSRkxc2fP97llgvVdZQNIwcfJc/qnLZ/SUp
	L8DqO0vh5F0bvaV3LnKzfiErqfFoybU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-452-NFT3x_f_M925_MHtysIYeQ-1; Tue,
 12 May 2026 04:17:42 -0400
X-MC-Unique: NFT3x_f_M925_MHtysIYeQ-1
X-Mimecast-MFC-AGG-ID: NFT3x_f_M925_MHtysIYeQ_1778573861
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A67F619560B2;
	Tue, 12 May 2026 08:17:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.142])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id DEEA0180034E;
	Tue, 12 May 2026 08:17:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] net: stmmac: Add support for TX/RX channel interrupt
Date: Tue, 12 May 2026 10:17:21 +0200
Message-ID: <20260512081721.83704-1-pabeni@redhat.com>
In-Reply-To: <20260508051943.9029-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260508051943.9029-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Queue-Id: 5729451C97E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_NONE(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-286999-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.990];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
net: stmmac: Add support for TX/RX channel interrupt

This change enables per-channel TX/RX interrupt registration for the
stmmac driver by looking up interrupts with dma_rxN / dma_txN names
from the device tree. The commit message documents the new names via
an example interrupts / interrupt-names stanza.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 5cae2aa72906..8f8dc7f08f20 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -732,7 +732,10 @@ static int stmmac_pltfr_get_irq_array(struct platform_device *pdev,
>  int stmmac_get_platform_resources(struct platform_device *pdev,
>  				  struct stmmac_resources *stmmac_res)
>  {
> +	char irq_name[9];
>  	int ret;
> +	int irq;
> +	int i;

[Low]
Is irq_name[9] intentionally sized to the exact minimum for "dma_rxN\0"
with a single-digit N?

MTL_MAX_RX_QUEUES and MTL_MAX_TX_QUEUES are both 8 today, so single
digits fit, but if either constant is raised past 9 the snprintf()
below would silently truncate (for example "dma_rx10" becoming
"dma_rx1") and alias onto another channel name.

The sibling helper stmmac_pltfr_get_irq_array() in the same file uses
a 16-byte buffer and explicitly rejects truncation:

	if (snprintf(name, sizeof(name), fmt, i) >= sizeof(name))
		return -EINVAL;

Would it be worth matching that pattern here, so the two code paths
behave consistently and stay correct if the queue counts grow?

>  
>  	memset(stmmac_res, 0, sizeof(*stmmac_res));
>  
> @@ -767,6 +770,30 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>  		dev_info(&pdev->dev, "IRQ sfty not found\n");
>  	}
>  
> +	/* For RX Channel */
> +	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
> +		snprintf(irq_name, sizeof(irq_name), "dma_rx%i", i);
> +		irq = platform_get_irq_byname_optional(pdev, irq_name);
> +		if (irq == -ENXIO)
> +			break;
> +		else if (irq < 0)
> +			return irq;
> +
> +		stmmac_res->rx_irq[i] = irq;
> +	}
> +
> +	/* For TX Channel */
> +	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
> +		snprintf(irq_name, sizeof(irq_name), "dma_tx%i", i);
> +		irq = platform_get_irq_byname_optional(pdev, irq_name);
> +		if (irq == -ENXIO)
> +			break;
> +		else if (irq < 0)
> +			return irq;
> +
> +		stmmac_res->tx_irq[i] = irq;
> +	}
> +
>  	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
>  
>  	if (IS_ERR(stmmac_res->addr))

[High, Low]
Can this new block actually take effect on a DT that uses the new
dma_rxN / dma_txN names shown in the commit message?

The tail of stmmac_get_platform_resources() (unchanged by this patch)
still calls stmmac_pltfr_get_irq_array() for the legacy names right
after these loops:

	/* TX channels irq */
	ret = stmmac_pltfr_get_irq_array(pdev, "tx-queue-%d",
					 stmmac_res->tx_irq,
					 MTL_MAX_TX_QUEUES);
	...
	/* RX channels irq */
	ret = stmmac_pltfr_get_irq_array(pdev, "rx-queue-%d",
					 stmmac_res->rx_irq,
					 MTL_MAX_RX_QUEUES);

And stmmac_pltfr_get_irq_array() unconditionally overwrites the slot,
zeroing it if the legacy name is absent:

	irqs[i] = platform_get_irq_byname_optional(pdev, name);
	...
	if (irqs[i] <= 0) {
		dev_dbg(&pdev->dev, "IRQ %s not found\n", name);

		/* Stop silently on first unset irq */
		irqs[i] = 0;
		break;
	}

On a DT that only provides dma_rx0 / dma_tx0 (the naming this patch
introduces), tx-queue-0 and rx-queue-0 are not present, so both
stmmac_res->rx_irq[0] and stmmac_res->tx_irq[0] end up back at 0 after
the legacy helper runs.

The MSI registration path in stmmac_main.c treats 0 as "no IRQ":

	if (priv->rx_irq[i] == 0)
		continue;

so channel 0 is silently skipped for both RX and TX. Is that the
intended behaviour, or should the legacy call be removed / made
mutually exclusive with the new names (or gated on the slot being
still 0)?

Relatedly, could the commit message say why both naming schemes need
to exist in the same probe path? Right now the new dma_rxN / dma_txN
names and the pre-existing rx-queue-N / tx-queue-N names are both
consulted with no documented precedence or fallback, which leaves
platform authors without a clear contract.

[Medium]
Does the DT binding need to be updated alongside this driver change?

Documentation/devicetree/bindings/net/snps,dwmac.yaml currently only
enumerates the per-channel DMA IRQ names as:

	- ^rx-queue-[0-7]$
	- ^tx-queue-[0-7]$

The new dma_rxN / dma_txN names consumed here and advertised in the
commit message do not appear in the schema, so a DT using the example
stanza would fail dtbs_check. Should this series include a matching
update to snps,dwmac.yaml so the binding and the driver land together
and DT maintainers can ack the new names?
-- 
This is an AI-generated review.


