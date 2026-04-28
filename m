Return-Path: <netdev+bounces-282123-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YGd8KhI/8WmhfAEAu9opvQ
	(envelope-from <netdev+bounces-282123-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:13:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E1748CE93
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 01:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5812E3034BF0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 23:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7A133ADAE;
	Tue, 28 Apr 2026 23:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ca41f8tj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9842C08DC;
	Tue, 28 Apr 2026 23:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777417998; cv=none; b=N0lsOY17m3WAqPRNBNpFoEEsxBOWUl1apZsMr3M8gVlfs0JjRhx4+ZX8uZWdarAL2qILkENXGARYgVaiTSCjWk2TsxIxhjR/75PeZG8Q3HgdSZcczmiXDgBfo0Zx88X16OBP12h+Zb0KhJZZSGqUZNksNWoWWV+jEN1hgH+dZko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777417998; c=relaxed/simple;
	bh=2n4qSOg2jbpexL50UfpGrOX+XcF388VT5jDUb87M9LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8TMdZWNAatcq/FVSIvnOeszLy11G089N2l4EdiDtTBCdOGiChZJtXT+mT8d3zx/bcNYmNICUB/k3ikrAowjsgy1bhS73YwXFaAcbkpm57pe98YIw9myC44e1Gky5wz7kmQ6D29sOMrAjuibJed4xuyG8yWyjDPdLlRzLI6Va3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ca41f8tj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/YKeeC5igUYtrX1cdVwe4XIBHgS8EWnZYDlr+hLRE3E=; b=Ca41f8tjj/nPZzGCoeW0P8dKAD
	vG5Qdzl++c8Z6AbzTukIzz4pcFhQ6e9te7xw546JioOYwAtq3tKxrQTVGZ4pVYlp94uyci1eDrDEe
	zCLyrEhIUVejTnlvdMFK11OCF4rqkhb7v+ezXl6EpoRxCaQpT3awvDdK5MpMHT6ukbAg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHrc3-000QTs-Pl; Wed, 29 Apr 2026 01:13:07 +0200
Date: Wed, 29 Apr 2026 01:13:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: gianfar: use alloc_ethdev_mqs
Message-ID: <0f704ce2-e936-4bc1-8ab2-144de9e74af8@lunn.ch>
References: <20260428223058.113013-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428223058.113013-1-rosenp@gmail.com>
X-Rspamd-Queue-Id: 06E1748CE93
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282123-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 03:30:58PM -0700, Rosen Penev wrote:
> >From looking at git history, mqs was introduced after mq and after this
> code was written. Having said that, mqs can be used as there is already
> an RX queue variable in place. Not only that, mqs already sets the
> num_xx_queues members. No need to open code this.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/freescale/gianfar.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> index 3271de5844f8..7b47c7c49c08 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -669,7 +669,7 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
>  		return -EINVAL;
>  	}
>  
> -	*pdev = alloc_etherdev_mq(sizeof(*priv), num_tx_qs);
> +	*pdev = alloc_etherdev_mqs(sizeof(*priv), num_tx_qs, num_rx_qs);
>  	dev = *pdev;
>  	if (NULL == dev)
>  		return -ENOMEM;
> @@ -679,10 +679,6 @@ static int gfar_of_init(struct platform_device *ofdev, struct net_device **pdev)
>  
>  	priv->mode = mode;
>  
> -	priv->num_tx_queues = num_tx_qs;
> -	netif_set_real_num_rx_queues(dev, num_rx_qs);
> -	priv->num_rx_queues = num_rx_qs;

Please add to the commit message an explanation of why these two
assignments can be removed, because it is not obvious.

    Andrew

---
pw-bot: cr

