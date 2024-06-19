Return-Path: <netdev+bounces-104901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87A3190F0D9
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FA6D1F23C49
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 14:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1F022612;
	Wed, 19 Jun 2024 14:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b="DPRo9UiM"
X-Original-To: netdev@vger.kernel.org
Received: from lan.nucleusys.com (lan.nucleusys.com [92.247.61.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533901F94D;
	Wed, 19 Jun 2024 14:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.247.61.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718807825; cv=none; b=Jkr12ZqkAL587Dlq/FApG1Y8dANd/uZRvOM8h2e5txTP+1TvcdmM4Jn+egd01iMS5fKXgxcJtVgk4X8OqD3lt4fZxezzuBsAZq66l5us+KdmGcp6DvO3aZH/JqkEsRb3YkDBCL2CBbItBzqMas8RvSHZXCx/vcrGBlafPyBmLTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718807825; c=relaxed/simple;
	bh=GKJQP8b1zlzBtB7Nw8Wg91kyevfxGQ9EerYqgJk9e9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rBHkU13BHTtUkwOLMeDJU5cwlW1TjsuTLE3K+JrfrVGAUkvD4icReqe04+aBmr2vk9GFioccphRVEnE5foVoMkPgNia7oA8GR3W1hhnuckfkCNtZtX3q8mn8ONpCWpXONNo5dBLgs0wAzCo43IG+Yn4yV5/jzNTO30AbLhN8nbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nucleusys.com; spf=pass smtp.mailfrom=nucleusys.com; dkim=pass (1024-bit key) header.d=nucleusys.com header.i=@nucleusys.com header.b=DPRo9UiM; arc=none smtp.client-ip=92.247.61.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nucleusys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nucleusys.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=nucleusys.com; s=xyz; h=In-Reply-To:Content-Type:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NHlgvKgkmz/r5O4COSwNlcOqz89YyW4SjGocwrI7G50=; b=DPRo9UiMRQ0tkUF3s7/iJIDXkF
	9WWXUNVABckCSjHnD3GqmZTso4TmtUWBvNlrPuvJ4WqqOOk+9utY05TUYPFh+/7cuDxW5eChZWLkd
	hqfvf+sZtPxIEL3LWqSahs28Z1A1UiEjjARfvwqdAc2ddVi/yHBsZNk4xtkApK/0kX00=;
Received: from [192.168.234.1] (helo=bender.k.g)
	by lan.nucleusys.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <petkan@nucleusys.com>)
	id 1sJw79-007H4v-1s;
	Wed, 19 Jun 2024 17:16:44 +0300
Date: Wed, 19 Jun 2024 17:16:43 +0300
From: Petko Manolov <petkan@nucleusys.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+5186630949e3c55f0799@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: usb: rtl8150 fix unintiatilzed variables in
 rtl8150_get_link_ksettings
Message-ID: <20240619141643.GB3770@bender.k.g>
References: <20240619132816.11526-1-oneukum@suse.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619132816.11526-1-oneukum@suse.com>
X-Spam_score: -1.0
X-Spam_bar: -

On 24-06-19 15:28:03, Oliver Neukum wrote:
> This functions retrieves values by passing a pointer. As the function that
> retrieves them can fail before touching the pointers, the variables must be
> initialized.

ACK.


		Petko


> Reported-by: syzbot+5186630949e3c55f0799@syzkaller.appspotmail.com
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/net/usb/rtl8150.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index 97afd7335d86..01a3b2417a54 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -778,7 +778,8 @@ static int rtl8150_get_link_ksettings(struct net_device *netdev,
>  				      struct ethtool_link_ksettings *ecmd)
>  {
>  	rtl8150_t *dev = netdev_priv(netdev);
> -	short lpa, bmcr;
> +	short lpa = 0;
> +	short bmcr = 0;
>  	u32 supported;
>  
>  	supported = (SUPPORTED_10baseT_Half |
> -- 
> 2.45.1
> 
> 

