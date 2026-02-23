Return-Path: <netdev+bounces-260039-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAWFHW9ZnGmzEgQAu9opvQ
	(envelope-from <netdev+bounces-260039-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:43:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22364177280
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 14:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D53EA302BBDD
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 13:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CF8237180;
	Mon, 23 Feb 2026 13:42:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E2223817E;
	Mon, 23 Feb 2026 13:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854125; cv=none; b=Un5qLfXrXso19gHmVwLpilrgG15U9j+5jYhPjqBJrYQwrP5+oXCAuJIennzeXX/Q5oRAi2LOuZuyUs8hlcmhLiEZdtdNXGFR0DZd1NqbR0DuPO52t1TnddOYj46QXqkfJwTgHz8iIDZHwSEk/6R9AKu4HUJlCkuppYtrYFp4dpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854125; c=relaxed/simple;
	bh=/oLs1LUwNF2tP7k8TlrR8i3D3zYwfYQop3ycAKL2MfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTpYCs9yQQTP3I7onqP7B396T6cEZ0Si2bXm7x7ttuoRgSodi45xZw6HVg5rC6QSIgfj2pbZSnfnc3/zZUJ1SAKM+lyZbImCDUeKmse2u+nLCHQuR9BYOMWic8WNJxz49vFRfUFYy3rpoDrHPIEVKGxh9GC0UHSUkgCuIXVo2ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C9EDD2015FB;
	Mon, 23 Feb 2026 14:32:47 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AF756201FB9;
	Mon, 23 Feb 2026 14:32:47 +0100 (CET)
Received: from lsv051416.swis.nl-cdc01.nxp.com (lsv051416.swis.nl-cdc01.nxp.com [10.168.48.122])
	by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B4F7202AE;
	Mon, 23 Feb 2026 14:32:47 +0100 (CET)
Date: Mon, 23 Feb 2026 14:32:47 +0100
From: Jan Petrous <jan.petrous@oss.nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, shawnguo@kernel.org, kernel@pengutronix.de,
	krzk+dt@kernel.org, robh@kernel.org, andrew+netdev@lunn.ch,
	mbrugger@suse.com, davem@davemloft.net, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, s32@nxp.com, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com, s.hauer@pengutronix.de,
	conor+dt@kernel.org, chester62515@gmail.com, festevam@gmail.com,
	mcoquelin.stm32@gmail.com, ghennadi.procopciuc@oss.nxp.com,
	devicetree@vger.kernel.org, alexandre.torgue@foss.st.com
Subject: Re: [v4,1/4] net: stmmac: platform: read channels irq
Message-ID: <aZxW/5dBz3XPTxhB@lsv051416.swis.nl-cdc01.nxp.com>
References: <20260128-dwmac_multi_irq-v4-1-82fa34fcf2f2@oss.nxp.com>
 <20260129050959.375635-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129050959.375635-1-kuba@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[nxp.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[24];
	FREEMAIL_CC(0.00)[google.com,kernel.org,pengutronix.de,lunn.ch,suse.com,davemloft.net,redhat.com,vger.kernel.org,lists.infradead.org,nxp.com,lists.linux.dev,st-md-mailman.stormreply.com,gmail.com,oss.nxp.com,foss.st.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260039-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jan.petrous@oss.nxp.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.962];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lsv051416.swis.nl-cdc01.nxp.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 22364177280
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 09:09:59PM -0800, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: stmmac: platform: read channels irq
> 
> This patch reads IRQ resources for all rx/tx channels to allow Multi-IRQ
> mode for platform glue drivers.
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index 8979a50b5507..94854bfb6e0d 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> 
> [ ... ]
> 
> > +	/* RX channels irq */
> > +	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
> > +		scnprintf(name, sizeof(name), "rx-queue-%d", i);
> > +		stmmac_res->rx_irq[i] = platform_get_irq_byname_optional(pdev,
> > +									 name);
> > +		if (stmmac_res->rx_irq[i] <= 0) {
> > +			if (stmmac_res->rx_irq[i] == -EPROBE_DEFER)
> > +				return -EPROBE_DEFER;
> > +			dev_dbg(&pdev->dev, "IRQ rx-queue-%d not found\n", i);
> > +
> > +			/* Stop on first unset rx-queue-%i property member */
> > +			break;
> > +		}
> > +	}
> 
> When platform_get_irq_byname_optional() returns a negative error like
> -ENXIO, that value is stored in stmmac_res->rx_irq[i] before the break.
> 
> In stmmac_request_irq_multi_msi(), the check is:
> 
>     if (priv->rx_irq[i] == 0)
>         continue;
>     ret = request_irq(priv->rx_irq[i], ...);
> 
> Should the negative value be cleared before the break? Otherwise if
> rx_queues_to_use exceeds the number of defined IRQs, the negative error
> code could be passed to request_irq().
> 
> > +
> > +	/* TX channels irq */
> > +	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
> > +		scnprintf(name, sizeof(name), "tx-queue-%d", i);
> > +		stmmac_res->tx_irq[i] = platform_get_irq_byname_optional(pdev,
> > +									 name);
> > +		if (stmmac_res->tx_irq[i] <= 0) {
> > +			if (stmmac_res->tx_irq[i] == -EPROBE_DEFER)
> > +				return -EPROBE_DEFER;
> > +			dev_dbg(&pdev->dev, "IRQ tx-queue-%d not found\n", i);
> > +
> > +			/* Stop on first unset tx-queue-%i property member */
> > +			break;
> > +		}
> > +	}
> 
> Same question here for tx_irq[i].
> -- 
> pw-bot: cr

Bot is right. I will address it in v5.

Thanks.
/Jan

