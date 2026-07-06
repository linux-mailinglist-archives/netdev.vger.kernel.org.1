Return-Path: <netdev+bounces-304959-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jyM7IkyAS2riSQEAu9opvQ
	(envelope-from <netdev+bounces-304959-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:15:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FC970F00B
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 12:15:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=ROTaZoAK;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304959-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304959-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id F16783027372
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 10:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C764348445;
	Mon,  6 Jul 2026 10:10:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20261C84AB
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 10:10:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783332658; cv=none; b=iklPt85+Uvp4c1SqMforGl4D7l/gbUNTqBH0tfX6FxzKWMSFnbKx2zG7OGsGi0/RadmMjkNI8ECYD7CkTgSzqr7URHECUQECueGbnfQUL0IHv2GUxs9WqfYR/jzt5reoP5MhyWkc8SBjeInGqEBuUwNrU/+9wcA9US5CqDP6HZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783332658; c=relaxed/simple;
	bh=ehD/tg0esm9lLt5mPMSX0LhNYICrtgMCjsqu+N1t72M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cry4CsdwFZ1dGxXbQ+QTXd/NLS30Z/mIvE2YE1s3C2/rETJw4dw6O1nWog3VQ9FFU/pSqeiqGz81Z8+eIPXO5PQZOxmMRoSSgX8QtFDn2/2NrSfDyPsKvgmQEWt0AdPJxjX+bnZdtCJw0WVJYcgp2nlPcK/tPgvM0UkoIoAmDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROTaZoAK; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783332655;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6UrHChc8M+M+p0SiB4fBzc+NlWnId3OCW6A/n3Cjpjw=;
	b=ROTaZoAKrh6NObFBpPrp+LBy5ErjtHH7v2MFbuAcZ+NRF+dzeegSjCHugAeXOwiNosloxu
	Ih+6otGMI5Kgmcb80EFgG7bi7yx+peNssTP3O6R+TOA7FFB+Hol75de1pxGZcT8VrHhAQw
	bP+6VwiCXboZYmmvDOpyl2+k+0+GNko=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-61-6UL7jBsPPSGmYehftaPLMA-1; Mon,
 06 Jul 2026 06:10:52 -0400
X-MC-Unique: 6UL7jBsPPSGmYehftaPLMA-1
X-Mimecast-MFC-AGG-ID: 6UL7jBsPPSGmYehftaPLMA_1783332651
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16C851955F72;
	Mon,  6 Jul 2026 10:10:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.156])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4178E1800591;
	Mon,  6 Jul 2026 10:10:49 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: hujy652@gmail.com
Cc: lorenzo@kernel.org,
	nbd@nbd.name,
	netdev@vger.kernel.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net:ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986
Date: Mon,  6 Jul 2026 12:10:44 +0200
Message-ID: <20260706101044.161059-1-pabeni@redhat.com>
In-Reply-To: <20260630144831.1109-1-hujy652@gmail.com>
References: <20260630144831.1109-1-hujy652@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hujy652@gmail.com,m:lorenzo@kernel.org,m:nbd@nbd.name,m:netdev@vger.kernel.org,m:linux-mediatek@lists.infradead.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-304959-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24FC970F00B

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev/
---
net:ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986

This commit updates mtk_wed_start() to configure WDMA_RING_TX(0) on
non-DBDC MT7986 devices. It adds a call to mtk_wed_wdma_tx_ring_setup()
for v2 hardware if the descriptor is not yet set up.

> diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
> index 10d9beaae3721..2420557f6c966 100644
> --- a/drivers/net/ethernet/mediatek/mtk_wed.c
> +++ b/drivers/net/ethernet/mediatek/mtk_wed.c
> @@ -2334,6 +2334,10 @@ mtk_wed_start(struct mtk_wed_device *dev, u32 irq_mask)
>  		if (!dev->rx_wdma[i].desc)
>  			mtk_wed_wdma_rx_ring_setup(dev, i, 16, false);

[Severity: High]
This isn't a bug introduced by this patch, but does this loop need to check
the return value of mtk_wed_wdma_rx_ring_setup()?

If mtk_wed_wdma_rx_ring_setup() returns -ENOMEM, the hardware registers are
not programmed, but mtk_wed_start() continues execution and enables DMA.

Could this lead to hardware DMA using an uninitialized ring base address?

>  
> +	if (mtk_wed_is_v2(dev->hw))
> +		if (!dev->tx_wdma[0].desc)
> +			mtk_wed_wdma_tx_ring_setup(dev, 0, MTK_WED_WDMA_RING_SIZE, false);

[Severity: High]
Are there similar error handling concerns with this new call to
mtk_wed_wdma_tx_ring_setup()?

Like the RX path, if dma_alloc_coherent() fails inside this setup function,
it returns -ENOMEM without programming the hardware registers.

Since mtk_wed_start() doesn't check this return value, it will proceed to
enable hardware DMA, which might attempt to use an uninitialized DMA address.

[Severity: High]
Does the check for !dev->tx_wdma[0].desc prevent necessary hardware
initialization after a warm reset?

When the WLAN driver triggers a hardware reset, the WED hardware registers
are cleared, and mtk_wed_start() is called again.

Because dev->tx_wdma[0].desc was allocated during the initial start, the
guard will evaluate to false, skipping the hardware register reprogramming
for tx_wdma[0].

Will the hardware DMA end up using a zeroed ring base address after a reset?

> +
>  	if (dev->wlan.hw_rro) {
>  		for (i = 0; i < MTK_WED_RX_PAGE_QUEUES; i++) {
>  			u32 addr = MTK_WED_RRO_MSDU_PG_CTRL0(i) +
-- 
This is an AI-generated review.


