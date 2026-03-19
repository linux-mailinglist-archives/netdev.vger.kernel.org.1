Return-Path: <netdev+bounces-269440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8ABkCunwu2nkqQIAu9opvQ
	(envelope-from <netdev+bounces-269440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:49:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C038D2CB58D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 13:49:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 10E3430090BD
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 12:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4651638E5D5;
	Thu, 19 Mar 2026 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XfYN8Y3p"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43FA246BC6
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773924581; cv=none; b=j2SwiTlAwTQxmtvsDBtJATb7WmTk3bkuXHSNuL0izl0YZI7aKEC33RjDh2SRsYkEJpOIi7FIPA/WUkq8XAs5XrNLHFGrcf0yHekfI4dp0LkGkkay2tW+qGH3/jBL0xEpmwxWKVVMtAcp7QrBrZHN6Z1Kzo61DLWweF0D4wdY5ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773924581; c=relaxed/simple;
	bh=oRTuRL04AZMLgCWp90IPlP1T4HpI9JgZS1fLNJ4R7qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f0t/1ArXg/iRKlY3WCTOtyPidcSiWXhIq2a0nHkpxmzDGDFijTKffaecQIFp5U2swXihPwa6Tmm9HumquJUczWLvoHchRNlvtjYXtc+xPxIdjBHh7H49lNUkPHKV7gPW/sUuGTDLEnilEomuccNS5lU6DWoU5bmlWFSQRRo/zHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XfYN8Y3p; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773924578;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SmlJz28vEgXrMcvJHKgmmZgjPFgGnDjqpkEd65rD/S0=;
	b=XfYN8Y3pt74aXxTDgl7xLT5ZjQfJokiIBqWTN103EYC5sLGN/0X5r8G/G/gLQ0Ly9pHCug
	fUt2Kaji1OTamrqvtXoPV3iV6gmQkFaRxKecC6ueOLbMvV8WyDptauOzmklRM/pf6RF5Qd
	EHF0DXXfyMmVPzG/m8BCIQJ9QAf7UR4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-JEL7GZ2zMhOZOPbDg8q1Rw-1; Thu,
 19 Mar 2026 08:49:35 -0400
X-MC-Unique: JEL7GZ2zMhOZOPbDg8q1Rw-1
X-Mimecast-MFC-AGG-ID: JEL7GZ2zMhOZOPbDg8q1Rw_1773924574
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E243A180049D;
	Thu, 19 Mar 2026 12:49:33 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.32.182])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9BB4C30001A1;
	Thu, 19 Mar 2026 12:49:31 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: cohenyang511@gmail.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	yangg9@xiaopeng.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Subject: Re: net: stmmac: Reorder cleanup sequence and disable IRQ earlier in reset path
Date: Thu, 19 Mar 2026 13:46:20 +0100
Message-ID: <20260319124620.226576-1-pabeni@redhat.com>
In-Reply-To: <20260317121937.109211-1-yangg9@xiaopeng.com>
References: <20260317121937.109211-1-yangg9@xiaopeng.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-269440-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.869];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C038D2CB58D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: stmmac: Reorder cleanup sequence and disable IRQ earlier in reset path

The recent changes restructure resource cleanup in __stmmac_release() to
free IRQ lines, stop DMA, and release descriptors before stopping the PHY.
Additionally, stmmac_reset_subtask() now disables IRQ earlier to prevent
spurious interrupts during the DOWN transition.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 124d7a00f9f0..fa06b2eb33f2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4202,6 +4202,15 @@ static void __stmmac_release(struct net_device *dev)
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	u8 chan;
>
> +	/* Free the IRQ lines */
> +	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
> +
> +	/* Stop TX/RX DMA and clear the descriptors */
> +	stmmac_stop_all_dma(priv);
> +
> +	/* Release and free the Rx/Tx resources */
> +	free_dma_desc_resources(priv, &priv->dma_conf);
> +
>  	/* Stop and disconnect the PHY */
>  	phylink_stop(priv->phylink);
>
> @@ -4212,15 +4221,6 @@ static void __stmmac_release(struct net_device *dev)
>
>  	netif_tx_disable(dev);
>
> -	/* Free the IRQ lines */
> -	stmmac_free_irq(dev, REQ_IRQ_ERR_ALL, 0);
> -
> -	/* Stop TX/RX DMA and clear the descriptors */
> -	stmmac_stop_all_dma(priv);
> -
> -	/* Release and free the Rx/Tx resources */
> -	free_dma_desc_resources(priv, &priv->dma_conf);
> -
                ^^^^

Moving free_dma_desc_resources() before stmmac_disable_all_queues() looks
problematic. Can a TX coalesce hrtimer fire after the DMA resources are
freed?

The stmmac driver has TX coalesce timers (stmmac_tx_timer) that can call
napi_schedule(). If free_dma_desc_resources() frees tx_q->tx_skbuff_dma
and tx_q->tx_skbuff via __free_dma_tx_desc_resources():

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:__free_dma_tx_desc_resources() {
    ...
    kfree(tx_q->tx_skbuff_dma);
    tx_q->tx_skbuff_dma = NULL;
    kfree(tx_q->tx_skbuff);
    tx_q->tx_skbuff = NULL;
    ...
}

But the hrtimer hasn't been cancelled yet (hrtimer_cancel is in
stmmac_disable_all_queues), and NAPI hasn't been disabled yet, then:

stmmac_tx_timer() fires
  -> napi_schedule_prep()
  -> __napi_schedule()
  -> NAPI poll eventually runs
  -> stmmac_napi_poll_tx()
  -> stmmac_tx_clean()
  -> accesses freed tx_q->tx_skbuff_dma[entry] and tx_q->tx_skbuff[entry]

The original order disabled NAPI and cancelled hrtimers before freeing DMA
resources. The stmmac_xdp_release() function in this same file shows the
correct pattern:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_xdp_release() {
    ...
    stmmac_disable_all_queues(priv);
    for (chan = 0; chan < priv->plat->tx_queues_to_use; chan++)
        hrtimer_cancel(&priv->dma_conf.tx_queue[chan].txtimer);
    ...
    free_dma_desc_resources(priv, &priv->dma_conf);
    ...
}


>  	stmmac_release_ptp(priv);
>
>  	if (stmmac_fpe_supported(priv))

[ ... ]

> @@ -7331,6 +7331,9 @@ static void stmmac_reset_subtask(struct stmmac_priv *priv)
>  	while (test_and_set_bit(STMMAC_RESETING, &priv->state))
>  		usleep_range(1000, 2000);
>
> +	/* Close IRQ entry as early as possible before DOWN short-circuit path. */
> +	disable_irq_nosync(priv->dev->irq);
> +
                ^^^^

disable_irq_nosync() increments the IRQ descriptor's depth counter, but
where is the corresponding enable_irq()?

The stmmac driver doesn't call enable_irq() anywhere. After dev_close()
and dev_open() complete:

stmmac_reset_subtask()
  -> disable_irq_nosync(dev->irq)   // depth++
  -> dev_close()
      -> __stmmac_release()
          -> stmmac_free_irq()
              -> free_irq(dev->irq, dev)
  -> dev_open()
      -> stmmac_request_irq_single()
          -> request_irq(dev->irq, ..., IRQF_SHARED, ...)

For non-shared IRQs, this works by coincidence: free_irq's last-handler
removal calls irq_shutdown (depth++), then request_irq's first-handler
registration calls irq_startup which resets depth to 0.

However, when dev->irq is shared with another device (IRQF_SHARED is set
in stmmac_request_irq_single), free_irq does NOT call irq_shutdown because
other handlers remain on desc->action. The depth stays at 1. The
subsequent request_irq takes the shared path in __setup_irq which does NOT
call irq_startup, leaving depth at 1.

The IRQ line remains disabled after the reset completes, breaking
interrupts for all devices on that shared line. Should enable_irq() be
added after dev_open()?


>  	set_bit(STMMAC_DOWN, &priv->state);
>  	dev_close(priv->dev);
>  	dev_open(priv->dev, NULL);


