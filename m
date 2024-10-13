Return-Path: <netdev+bounces-135012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4059B99BC74
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 00:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAA9B1F21293
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 22:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBFD14F12D;
	Sun, 13 Oct 2024 22:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJue6bXK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD33612DD88;
	Sun, 13 Oct 2024 22:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728857345; cv=none; b=LlhQtqn+CuHbkoM5QrmqzkVgYf1oMFGG4vRMXq+iNv7wNCu2Tck2dZyLcBpItsifVOCG9dcnQPkp5M8OTWLoDczq/Z2g0/H9KvB9xL24+ZKBpZUdfAb352Pvassyn6oHma98HLpmP9JczWel7Ng0/9Mm1VJ8Mn/nsoxcTn1wAGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728857345; c=relaxed/simple;
	bh=/GKPgCdm1mBgRK9eIeQBYqyP6YXxB870epx4GpO1es0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HmmChkZ9js4xg6zBf6BWEUmCbJtxKxSA07AweBnXUTDpzJomy23eWDR9y15Eadc9pyvf5vUfhWX4IoxLj1VBbvgQTENPWAhjjeOo5jzb9YGtuy9wONHMhokBcONP+qghvQXoNY8pKuDdxXNvOpgPXcU0JaV/kNOYrDC+D4QNMqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJue6bXK; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a9a156513a1so7830966b.0;
        Sun, 13 Oct 2024 15:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728857342; x=1729462142; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=g8IgltpRl4YdaKKPHMOvORvjaB1Lk4/3OAMCCKkqtZQ=;
        b=bJue6bXKSlmrVa77viAZ7/QAwXi0i2OUIdxd3lpil3bQj1w9sP4eTM6Yz5OxmWDVeV
         Z2YvVs5OPmC7fTy9P5grhsWNVq8mx5In2leq7iGlvPFe1AGDgrX2kIfC+PiV/XvVFASO
         AMRwdWVxfaNUJCorWkkm9C9hikh2uAf/dS4B5Y/a1HNmzBbgrMdPpI18ZwViwKMfrCrW
         128YBHBuheJb+KCJ5ujOWTe5+vZcVeXLjM27on55+LdRp8Ix4qDXSbilRwOLXFmvI+aQ
         1Fg9p61QBhCsGP6DL4nkXI4Y7jm6gqAXBJdxZDvqh6RHNn0Aw9L0SrzFCG0vXbVtC59W
         MDwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728857342; x=1729462142;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g8IgltpRl4YdaKKPHMOvORvjaB1Lk4/3OAMCCKkqtZQ=;
        b=M50y8c2NS1zsYWBnu0w9KRxvTbTUGji9KEt8muF7/23ak/atEOOfw1DSZeMHcThTcA
         tGIrLDbyUeXQfyWQipRlE1JSDnu0buh48UkGvU81sFhQOJghcDOSYyOCGjTEYhlgLoN/
         HeBIjuIWs+d/l0Q1BcfMkp5QU09aayO9uX8s2T9gywOQkg1s3AtAH6U3g0n/USRwRH+m
         ijZxaomtVD5d8XyhcNwb6QmG6d+oaLqUm2oTq68mnZcNXRik0n5GWUUGuHOKDg8kUyxz
         +m+oqrAyZe/K3e3VYRz1iT7+l9YhSrvAiUf7qV16Rl7xNripdRCCj05sLXkuN57yoeCy
         ubbg==
X-Forwarded-Encrypted: i=1; AJvYcCVMlCVFJMoqWNwhsgqaG96nrCkQTkIewuN+roxjB4Tw4+vRSMPSwmLTAWzub+XAC+BnjtCohRzV@vger.kernel.org, AJvYcCWpDTL1K7hdRoAqm1e9F1P10nktXHtFzj02KAOvDMHxSH+i3uGuHkaZABl+pEOlZEz96oKdoujL2kjPTfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKUak25T4QItlv+iqLWomtPtHEZ2sEuYP341QY8rMbkRt0x8mS
	YXtpgHgxYfX/gbF83OPnZQ1afiEb0ndvcjNOVj0rybA3DZhfxK8Oi07gsA==
X-Google-Smtp-Source: AGHT+IEGLyOM9C6DNXIBOKCeb/9MUxexlVdY381v+Z5lTKKj+ty/Y1PjUGzpDB4miMsIbPpVfVS5kA==
X-Received: by 2002:a17:907:7e9b:b0:a9a:1092:b10d with SMTP id a640c23a62f3a-a9a1092b228mr94415166b.33.1728857341814;
        Sun, 13 Oct 2024 15:09:01 -0700 (PDT)
Received: from ?IPV6:2a02:3100:aefe:d400:f8ab:214a:795a:fa3? (dynamic-2a02-3100-aefe-d400-f8ab-214a-795a-0fa3.310.pool.telefonica.de. [2a02:3100:aefe:d400:f8ab:214a:795a:fa3])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9a1413fa91sm17260066b.131.2024.10.13.15.09.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Oct 2024 15:09:01 -0700 (PDT)
Message-ID: <c7176768-1999-4167-b657-3afba97b81b7@gmail.com>
Date: Mon, 14 Oct 2024 00:09:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2 net-next] net: bgmac: use devm for register_netdev
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20241013213400.9627-1-rosenp@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20241013213400.9627-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13.10.2024 23:34, Rosen Penev wrote:
> Removes need to unregister in _remove.
> 
> Tested on ASUS RT-N16. No change in behavior.
> 
This patch changes the order of calls. unregister_netdev() is now called
only after remove(). Shouldn't there be some words about why this is safe
and doesn't e.g. possibly result in race windows?

> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  v2: added reviewed/tested-by broadcom.
>  drivers/net/ethernet/broadcom/bgmac.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index 6ffdc4229407..2599ffe46e27 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c
> @@ -1546,7 +1546,7 @@ int bgmac_enet_probe(struct bgmac *bgmac)
>  
>  	bgmac->in_init = false;
>  
> -	err = register_netdev(bgmac->net_dev);
> +	err = devm_register_netdev(bgmac->dev, bgmac->net_dev);
>  	if (err) {
>  		dev_err(bgmac->dev, "Cannot register net device\n");
>  		goto err_phy_disconnect;
> @@ -1568,7 +1568,6 @@ EXPORT_SYMBOL_GPL(bgmac_enet_probe);
>  
>  void bgmac_enet_remove(struct bgmac *bgmac)
>  {
> -	unregister_netdev(bgmac->net_dev);
>  	phy_disconnect(bgmac->net_dev->phydev);
>  	netif_napi_del(&bgmac->napi);
>  	bgmac_dma_free(bgmac);


