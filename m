Return-Path: <netdev+bounces-101869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D8AF290056E
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 15:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48083B2333B
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 13:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AB719413C;
	Fri,  7 Jun 2024 13:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEkpLLv1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3141CA85;
	Fri,  7 Jun 2024 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717768049; cv=none; b=Lyyf2FrH5wYtll19EJvEdbw4J2JQKSdd/uWbRugYDOTg65vQi3VXQprwjd9/XJWjg6WehSjSqKHPHv0pdCT6V0xFh9C193pJOhq6ZR5rnuFehc7N17oUBydBscQYj4HE3H385UX1rqv/kjNjLu3ChyqmkRVCWEQ7kgiw9T7HvLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717768049; c=relaxed/simple;
	bh=q8GCB4TXSIqeMhG+CRclgf0UKbJmwPTvZO4PRwJnmYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cJZjcaoWL/PPlshKkkGWZJUcrLNq7ssS5vmiSm9EV/fSre+UTQ9Pp4dcZmOufBaPcb+BPpklazFBuffZYl2/EAya4OlJ8+QQ7gbmxuCZbuj089UY3gMQ37+81BbnYK9P0cFC+kpz0BGUlwq07++6WcPFMQottOdl70Tsh+GL6UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEkpLLv1; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-57a4ea8058bso2426690a12.1;
        Fri, 07 Jun 2024 06:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717768046; x=1718372846; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KmgBm9ThJPNKXmPz1Y3oHMiCl5cXiVptHJkrXtuToGI=;
        b=EEkpLLv1udx+zJ9bZza0CR0hnepGgAkIpF/XJIho6HDmdGpHLSkFi0BsZpEHktbTiQ
         MMMoYXqQwbtlzC2skmo4mLZa9tjNjsd+3htWzPCwo3G1KzBGxfERcuFqMQNUIa5oDhnp
         KoNCJwEua/uYJ1dRRaXHgYQ47eb61we9UkdNyartQ7aGmKwOvgNTje+7hY4KnrTSR+Bw
         dlNh8n3W63TT9GM5IesjIFeT4ilcqUX694dY3aG4dr7y878+HUySBZSd75fEu0Sz3kCO
         IOdn+/xZiOZypexu36dMA8RX8bNpNOOCq2zvq0+emG/trTERm6VN98XfBLCdanJdQECa
         CIOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717768046; x=1718372846;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KmgBm9ThJPNKXmPz1Y3oHMiCl5cXiVptHJkrXtuToGI=;
        b=OYfkom3AkqDGv51Stei3ikAEatID48RNuFbdqptJq4EJVWfoRod32XlvBTfJqnbbdZ
         ioTBkrSuSjV2PLRotcu6pusXV7reno7bF/f7KSriGUntvYcvBPDJvtnjgwK3PPuNsKbK
         Y8hq5QHkpjFxQgl6o/iKULJyOerJacOamHeagLLsqiqoEJV55cJiB5/OsNaQmixFpejX
         zBlaRqOTZJD/3MGJ+wfFMugyVnYvZJIszTETC/I41dB23HZhdj8bHEbFllrTvJDMzZjG
         o2OB2NbSJV9HpIrISP+GaFpTG+tAuGYRoJUuwGXs5Ozxfyga2ckEX1WCao9kONIlwjg4
         Fkzg==
X-Forwarded-Encrypted: i=1; AJvYcCVn1vnLzmbYewbxqNIqKeKdZ7BUsm0lQPc34keJneM75JmKAYwGoAMx/qVoBAzGf/7UZo9I7Py+842Y5eb8Zl1FV9yujSAHPFn2VXVqrwmWI5Z5wJBMtVDmq0B1sflcwL5T7Bq5
X-Gm-Message-State: AOJu0Yy0UFdftT2xq87jzc00yczZG4KxioNtIHY7gW+AStPwRXpoV7Y3
	4szlFFxMX7zaIqRPQFQX4DMbLGCK91zxgeWeIf8Ad+aTV8lkBISq
X-Google-Smtp-Source: AGHT+IGxJly2Ygnl7BBvSpHo2MzTbd4GTMItTxW3Hu6qDDGLINsRJ6cxScLTVygUaG+CuvUghmikPg==
X-Received: by 2002:a50:d799:0:b0:57a:2fc1:e838 with SMTP id 4fb4d7f45d1cf-57c50928dd9mr1603090a12.22.1717768045293;
        Fri, 07 Jun 2024 06:47:25 -0700 (PDT)
Received: from skbuf ([188.25.55.166])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57aae1412a0sm2779581a12.56.2024.06.07.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 06:47:24 -0700 (PDT)
Date: Fri, 7 Jun 2024 16:47:21 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Xiaolei Wang <xiaolei.wang@windriver.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, alexandre.torgue@foss.st.com,
	joabreu@synopsys.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [net PATCH] net: stmmac: replace priv->speed with the
 portTransmitRate from the tc-cbs parameters
Message-ID: <20240607134721.qxwyp63p5dlxw7ui@skbuf>
References: <20240607103327.438455-1-xiaolei.wang@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607103327.438455-1-xiaolei.wang@windriver.com>

On Fri, Jun 07, 2024 at 06:33:27PM +0800, Xiaolei Wang wrote:
> Since the given offload->sendslope only applies to the
> current link speed, and userspace may reprogram it when
> the link speed changes, don't even bother tracking the
> port's link speed, and deduce the port transmit rate
> from idleslope - sentslope instead.
> 
> Signed-off-by: Xiaolei Wang <xiaolei.wang@windriver.com>

Patches to the "net" tree usually need a Fixes: tag pointing to the
first commit introducing an issue. They also need an explanation of the
problem being addressed and how it can negatively affect an user.

Still on the process topic, please increment the patch version from the
previous submissions, and post a change log under the "---" sign below,
as well as links on patchwork or lore to previous versions.

> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 222540b55480..48500864017b 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> @@ -348,6 +348,7 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>  	u32 mode_to_use;
>  	u64 value;
>  	int ret;
> +	s64 port_transmit_rate_kbps;
>  
>  	/* Queue 0 is not AVB capable */
>  	if (queue <= 0 || queue >= tx_queues_count)
> @@ -355,27 +356,24 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>  	if (!priv->dma_cap.av)
>  		return -EOPNOTSUPP;
>  
> +	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
> +
>  	/* Port Transmit Rate and Speed Divider */
> -	switch (priv->speed) {
> +	switch (div_s64(port_transmit_rate_kbps, 1000)) {
>  	case SPEED_10000:
>  		ptr = 32;
> -		speed_div = 10000000;
>  		break;
>  	case SPEED_5000:
>  		ptr = 32;
> -		speed_div = 5000000;
>  		break;
>  	case SPEED_2500:
>  		ptr = 8;
> -		speed_div = 2500000;
>  		break;
>  	case SPEED_1000:
>  		ptr = 8;
> -		speed_div = 1000000;
>  		break;
>  	case SPEED_100:
>  		ptr = 4;
> -		speed_div = 100000;
>  		break;
>  	default:
>  		return -EOPNOTSUPP;

This can be further compressed after the elimination of speed_div:

	switch (div_s64(port_transmit_rate_kbps, 1000)) {
	case SPEED_10000:
	case SPEED_5000:
		ptr = 32;
	case SPEED_2500:
	case SPEED_1000:
		ptr = 8;
		break;
	case SPEED_100:
		ptr = 4;
		break;
	default:
		return -EOPNOTSUPP;
	}

> @@ -397,11 +395,13 @@ static int tc_setup_cbs(struct stmmac_priv *priv,
>  		priv->plat->tx_queues_cfg[queue].mode_to_use = MTL_QUEUE_DCB;
>  	}
>  
> +	port_transmit_rate_kbps = qopt->idleslope - qopt->sendslope;
> +

You don't need to calculate it twice in the same function.

>  	/* Final adjustments for HW */
> -	value = div_s64(qopt->idleslope * 1024ll * ptr, speed_div);
> +	value = div_s64(qopt->idleslope * 1024ll * ptr, port_transmit_rate_kbps);
>  	priv->plat->tx_queues_cfg[queue].idle_slope = value & GENMASK(31, 0);
>  
> -	value = div_s64(-qopt->sendslope * 1024ll * ptr, speed_div);
> +	value = div_s64(-qopt->sendslope * 1024ll * ptr, port_transmit_rate_kbps);
>  	priv->plat->tx_queues_cfg[queue].send_slope = value & GENMASK(31, 0);
>  
>  	value = qopt->hicredit * 1024ll * 8;
> -- 
> 2.25.1
> 

