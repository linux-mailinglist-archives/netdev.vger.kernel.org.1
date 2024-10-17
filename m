Return-Path: <netdev+bounces-136510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 868609A1F4A
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 12:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1409BB24B1C
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 10:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE071D90C9;
	Thu, 17 Oct 2024 10:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czdWatzy"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9660E1DA100
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 10:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729159271; cv=none; b=eDSbXhFO7b8AXhbFQr1mEeVv210NURdwOxgmPnnR1cjkJLb3l/81UuoHusKEtvKscBggsa0MeSY9Y6Y66SP1xi72Gy3ZPIdaKBcQDVTOjb2GeGRRqIl4efukyITXJsh+M6Lx2739JncyU5miOyFBjodfK67qTYlAbbAoAYCwbfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729159271; c=relaxed/simple;
	bh=vN5XyVfrxrxoAZYcVh5tDUAZHsclorzekDqmFxRKq+c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dEogL8rAxJWjb9v1zPA0qoxzuCb5zz51ajkKVLP17J/nBG1xrhn8zDiribKzMY849Mg7+X8ktcep3MvHZ395Q+ukVCmbkqZjTX4DsPRLHXgJasiBcCXOHcgGAT9uAtvbW9A8wh4JeappxF0FO114vc2GdHlZZlhKlMift4p6Cyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=czdWatzy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729159266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bY7iWoxj9CZSiYPztvl4Gv25W+IisCK/5xSZ4Gjk1ss=;
	b=czdWatzy2ARGLbjXV/qSRTMeTMaUVpDICDquSYcDFyZkF5s2arPh5ZKwy6bGhiHGRXPqnU
	v+SxUpwi6cH2x3iei/5qfHV7Zoa49GS16mgmJ3/dvd8INgTXSub5/rmpbBWDSnjQOcVTRI
	LTWSIEOqAIZ301xOzHuVS4e6k5bolyI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-kcCnNE4RM5W7IyNa1l7XXQ-1; Thu, 17 Oct 2024 06:01:05 -0400
X-MC-Unique: kcCnNE4RM5W7IyNa1l7XXQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d49887a2cso377398f8f.0
        for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 03:01:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729159264; x=1729764064;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bY7iWoxj9CZSiYPztvl4Gv25W+IisCK/5xSZ4Gjk1ss=;
        b=hUUtq6n0uBnZ5z4LJ52cxowp17AXdKnO88dXN5PV95QgxEj/ZXt3MZ9s+hAdOG7iBr
         rMilznDT/LgrjYzYrITeMVeNuIdAYMW2LLROGGN3ypcCJfS6hDZ4Et8+jmKHMOLywt1h
         0/xjHa+AY5+gbP7uXb9KbLPSuCjmYiyReAs9a6ONWULlQ/cyB9YUJbO6EA853uI8iDtm
         +kz6oydGBzN7xyhd8Z3LaVN/MryIo+3pW28hrwGtn3Dz1dnfUCS4T7Q321sWadpBRyPG
         K5kimP7tNHfKmNCglxZFm0NkyLZBApKZ0mH3gu1yOryfAWwbszP8XMakz9ae9wf25YKz
         n87g==
X-Forwarded-Encrypted: i=1; AJvYcCU+zlBUW2tzh7J5uAy8yBNwnyeTozsoncUKS/qIbzAwECUQJK+u707a6oa+s0WCsAXj8wiYhqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKxvrcLcst/642bVI3Tzo7xGacfPn1DTvKk8qOoT4hMAr/Bxgr
	QebZWj8vSVvdtcKjg3PoM9J84BXdldCY+DscSE48oZsOMjAPOAv947O3VNK8mA8WBLsozCMxFfX
	QXhRZM5HNmyzugBOmPFGGltpFB2woBcnjoe2ZHxJeV8phqbULQB6v5A==
X-Received: by 2002:adf:eed1:0:b0:37d:364c:b410 with SMTP id ffacd0b85a97d-37d93e7c0demr1376162f8f.33.1729159264162;
        Thu, 17 Oct 2024 03:01:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6m9HZ9VFkMarpnDHPdKY9Ze3IrDZnULc4nzyeU8rI4nQl9HH2QzNL2vR2k5JWur7cDZ09Hw==
X-Received: by 2002:adf:eed1:0:b0:37d:364c:b410 with SMTP id ffacd0b85a97d-37d93e7c0demr1376135f8f.33.1729159263735;
        Thu, 17 Oct 2024 03:01:03 -0700 (PDT)
Received: from [192.168.88.248] (146-241-63-201.dyn.eolo.it. [146.241.63.201])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d94626094sm1972380f8f.88.2024.10.17.03.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 03:01:03 -0700 (PDT)
Message-ID: <a0aec660-c18b-4d85-b85b-58fce3668e64@redhat.com>
Date: Thu, 17 Oct 2024 12:01:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] fsl/fman: Fix refcount handling of fman-related
 devices
To: Aleksandr Mishin <amishin@t-argos.ru>,
 Igal Liberman <igal.liberman@freescale.com>
Cc: Simon Horman <horms@kernel.org>, Madalin Bucur <madalin.bucur@nxp.com>,
 Sean Anderson <sean.anderson@seco.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <20241015060122.25709-1-amishin@t-argos.ru>
 <20241015060122.25709-3-amishin@t-argos.ru>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241015060122.25709-3-amishin@t-argos.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/15/24 08:01, Aleksandr Mishin wrote:
> In mac_probe() there are multiple calls to of_find_device_by_node(),
> fman_bind() and fman_port_bind() which takes references to of_dev->dev.
> Not all references taken by these calls are released later on error path
> in mac_probe() and in mac_remove() which lead to reference leaks.
> 
> Add references release.
> 
> Fixes: 3933961682a3 ("fsl/fman: Add FMan MAC driver")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
> Compile tested only.
> 
>   drivers/net/ethernet/freescale/fman/mac.c | 62 +++++++++++++++++------
>   1 file changed, 47 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/fman/mac.c b/drivers/net/ethernet/freescale/fman/mac.c
> index 9b863db0bf08..11da139082e1 100644
> --- a/drivers/net/ethernet/freescale/fman/mac.c
> +++ b/drivers/net/ethernet/freescale/fman/mac.c
> @@ -204,7 +204,7 @@ static int mac_probe(struct platform_device *_of_dev)
>   	if (err) {
>   		dev_err(dev, "failed to read cell-index for %pOF\n", dev_node);
>   		err = -EINVAL;
> -		goto _return_of_node_put;
> +		goto _return_dev_put;

We are after a succesful of_find_device_by_node and prior to 
fman_bind(), mac_dev->fman_dev refcount is 1

> @@ -213,40 +213,51 @@ static int mac_probe(struct platform_device *_of_dev)
>   	if (!priv->fman) {
>   		dev_err(dev, "fman_bind(%pOF) failed\n", dev_node);
>   		err = -ENODEV;
> -		goto _return_of_node_put;
> +		goto _return_dev_put;
>   	}
>   
> +	/* Two references have been taken in of_find_device_by_node()
> +	 * and fman_bind(). Release one of them here. The second one
> +	 * will be released in mac_remove().
> +	 */
> +	put_device(mac_dev->fman_dev);
>   	of_node_put(dev_node);
> +	dev_node = NULL;
>   
>   	/* Get the address of the memory mapped registers */
>   	mac_dev->res = platform_get_mem_or_io(_of_dev, 0);
>   	if (!mac_dev->res) {
>   		dev_err(dev, "could not get registers\n");
> -		return -EINVAL;
> +		err = -EINVAL;
> +		goto _return_dev_put;

Here we are after a successful fman_bind(), mac_dev->fman_dev  refcount 
is 2. _return_dev_put will drop a single reference, this error path 
looks buggy.

Similar issue for the _return_dev_arr_put error path below.

Cheers,

Paolo


