Return-Path: <netdev+bounces-93225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 109F88BAAB4
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 12:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 507ADB21EC4
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 10:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC492150981;
	Fri,  3 May 2024 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MwDGpIt9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D86A14F9DB
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 10:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732071; cv=none; b=hnxXEiP8+/Qr976vi2VggRkdZs1UmJF9Rj7KEVazVnif4ksBz2xgUbNNZnM9LyGSEy56+RB0c7Gw5Um2heD0eGzFcFTP+HzVR0qQoK9O081+pWSMbm6cQ/7WHlV30Y6u9J/PEzA9LDKpFwg6yTIbuhbp61VwAW1ff2JsopRT4ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732071; c=relaxed/simple;
	bh=fIg2b0eoabEZcfqs8HbWsHGNoi0o86ZduFTw81bipk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PD6rf3JDovcl0U+kX2VJn523j/n7L55YklRjD19yQPB4un5dOji4Ln8Bd/XOBft63ga20rL/f73qdKWkNZFXS9peYrkzF4VRS8XGUCE9p88Rj+RPWYSLC98E4b4pyZrkLd8XHJqJv14uEtg8VVDW6rgLN8MjylZ5wGHXxWSO3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MwDGpIt9; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e242b1dfd6so6715001fa.0
        for <netdev@vger.kernel.org>; Fri, 03 May 2024 03:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714732068; x=1715336868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NnM2HIzTSjECVNLS4hAwp1K6tHwNQq7xSWvIcegLu/o=;
        b=MwDGpIt9rKJD0OP1cHKXA4q41CcGCNQvkPLAmI+EarvuUW0lOAxiPwbgK7RWnOtbmi
         EITnRfQrsMjLY7m+1J8sOH16KNk3AkZK71fUopeFYM2tRJgGXqJVa1GpwMV9+Xss2yhw
         5tYVzAjVv6SsDbs5Sf4T49zZhbXibNk6+7Sl9jqHkSsLFVuELhN8BU8tspyVM14nnmTq
         eieyNLLoZnYpSU5Dji6/8ClcTlvL1Jv2Mq0YCguqZ/Ye1xpklCMDhVZ5pga397Kxq70A
         glgalFgc9lRPqdzt7jTzz62L7JBmP7sp7e6zROpTbTAy7hrqQLeIQHqouiV1ak9w2EbY
         eZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714732068; x=1715336868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NnM2HIzTSjECVNLS4hAwp1K6tHwNQq7xSWvIcegLu/o=;
        b=fXVf5po+Rz31iuZdPP/G6GKZlOYk5R8xUYWqVJ6uNbs88p7KX2D01so1Zex256DIND
         ctRqiIeZHtMlP0oXxwBkqLHPmCbVBgV9slB72NzQ+m9/XoF/xm+kKzZOUy7q7YaqT4va
         pd2h4oAP9sF1nGgY35PA/Zx9fyPmkKhvjqlwZiztjI2R4WJRy6hvfqzEq2QXGOOnI9qs
         88CQSPFNMsbSgCdIdpfYl4pdHcbcyEEiyLhxsutgv5wdwWmDsI0MvvnpjXsw1znk8qxe
         LT9b5g+Z50926HZRKSRDYQApHl6qbHUKIyZdsiMqxcb00BgP899K+iiPlXnXgciGAltU
         n7ng==
X-Forwarded-Encrypted: i=1; AJvYcCVy1W7/UPGd8lmlCWB5EN0iiNI9az3Hsx5iO8gk70mdFxyTvkPfrYKhlHs8E0CLdx4w3FhoAhmXCBZCAzu1gJYaWAeY3FBD
X-Gm-Message-State: AOJu0YxA4cnaUJj2Y7lr3rm5OwA0jdaGToKuhgEP5CpmW4ckLMiYuzEG
	2gnLLIT6CiResnFlFd7au0Nc2M3hk/KBTyJVb39EefwxKEBkps8v
X-Google-Smtp-Source: AGHT+IGC02gp0E1i5DZBTIuMqSZJaTgwPW0YQZ7x3Xcn3ZtHeiC3wjRlD5BgFCcc4vyYIYWJ58OyDg==
X-Received: by 2002:a2e:b531:0:b0:2e0:c81c:25da with SMTP id z17-20020a2eb531000000b002e0c81c25damr1292841ljm.30.1714732067985;
        Fri, 03 May 2024 03:27:47 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id r6-20020a2eb606000000b002dd7b339bdesm474797ljn.1.2024.05.03.03.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 03:27:47 -0700 (PDT)
Date: Fri, 3 May 2024 13:27:44 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Yanteng Si <siyanteng@loongson.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, peppe.cavallaro@st.com, 
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, Jose.Abreu@synopsys.com, 
	chenhuacai@kernel.org, linux@armlinux.org.uk, guyinggang@loongson.cn, 
	netdev@vger.kernel.org, chris.chenfeiyang@gmail.com, siyanteng01@gmail.com
Subject: Re: [PATCH net-next v12 03/15] net: stmmac: Export dwmac1000_dma_ops
Message-ID: <uyvl7lcleoaw4hze5y6z5ihbnzdvc2e6zwmmsgfskkuqslgwae@p7nnrsc6ry6k>
References: <cover.1714046812.git.siyanteng@loongson.cn>
 <12eab04fb430b58574731fbab98ee1354f91100c.1714046812.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12eab04fb430b58574731fbab98ee1354f91100c.1714046812.git.siyanteng@loongson.cn>

On Thu, Apr 25, 2024 at 09:01:56PM +0800, Yanteng Si wrote:
> The loongson gnet will call it in the future.

More descriptive commit log:

"Export the DW GMAC DMA-ops descriptor so one could be available in
the low-level platform drivers. It will be utilized to override some
callbacks in order to handle the LS2K2000 GNET device specifics. The
GNET controller support is being added in one of the following up
commits."

Other than that the change looks good. Thanks.

Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
> Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
> Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> index f161ec9ac490..66c0c22908b1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
> @@ -296,3 +296,4 @@ const struct stmmac_dma_ops dwmac1000_dma_ops = {
>  	.get_hw_feature = dwmac1000_get_hw_feature,
>  	.rx_watchdog = dwmac1000_rx_watchdog,
>  };
> +EXPORT_SYMBOL_GPL(dwmac1000_dma_ops);
> -- 
> 2.31.4
> 

