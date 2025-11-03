Return-Path: <netdev+bounces-235038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC65C2B7AC
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 12:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218A53A7A44
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 11:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBF0303A2E;
	Mon,  3 Nov 2025 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="CAC0wr58"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C558303A13;
	Mon,  3 Nov 2025 11:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762170207; cv=none; b=jaMnkzCIpVs4IJy1n2kjdfmHtg50LLuFYZC39+uovmZx/JCFpOaGFdLbryifPATm2e96h+depIzrF4AdQYEfd8W2fC1RFx2WWIpx3/CgF7jCh5vBsoHkZt9GHmdOYnkxwEMvUG9m5au6K0TGZfUpyn1+xlkzPqwwi9tqjDgL0VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762170207; c=relaxed/simple;
	bh=WC+IlFx59Kg7tN31UkLDaE+SqlheI6tgR12CJZRleTc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CC1ZzMlJLRE5MxhTw9b9wBuY8xAulYLTyD9xGOMjpYPmdcoaKOlzavguIKgb44UjjH9R7b0pk/iKF49YSI3Zdv+4mC1IXsR16wsltebhScReald7sNoJ+EWzCndKKTPaifU36IKWjm4Bzy9uZjRzhdMuNo7jaJ1g7M3B1HjX7ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=CAC0wr58; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A31BEC0D7AA;
	Mon,  3 Nov 2025 11:43:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5F48260628;
	Mon,  3 Nov 2025 11:43:22 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9D08F10B500C5;
	Mon,  3 Nov 2025 12:43:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762170201; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=r8CA+vdYfhYepnKUhOERQCJShsp4s/lW0pNczBAWdSg=;
	b=CAC0wr58URPaBSd9FY9zqhAcElpRWn9kXxq1d02X/sHJRoXYTtMd2IKLh/OnKa/HtJwMxC
	RxQIESj2rIAoCPH1EsxrAzH27FmSlaK4DR9ykqIndBURYcY7C3Aq91hMLh1rKwgfMns4S1
	lj+1f1l1lekKSWlwPL9Js7STbvY/3lCN5cvLQSiZ3iHiiLh/80FAnFxCD5yY4wE6y8vJ/w
	glYEnzIxSvukOoJ7o9+XmPQUJu0X+PB5wLVUAajDAybDAeAkKIgPB3ahykBEMYVRW5G3sf
	Twd3wAQe2GjKuFKrvTjqrUe4UAC4Oc76hXC78Ndke8syQAJhIYWh4bKrmXBiyQ==
Date: Mon, 3 Nov 2025 12:43:16 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Haotian Zhang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: wan: framer: pef2256: Fix missing
 mfd_remove_devices() call
Message-ID: <20251103124316.1557e070@bootlin.com>
In-Reply-To: <20251103111844.271-1-vulab@iscas.ac.cn>
References: <20251103111844.271-1-vulab@iscas.ac.cn>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Haotian,

On Mon,  3 Nov 2025 19:18:44 +0800
Haotian Zhang <vulab@iscas.ac.cn> wrote:

> The driver calls mfd_add_devices() but fails to call mfd_remove_devices()
> in error paths after successful MFD device registration and in the remove
> function. This leads to resource leaks where MFD child devices are not
> properly unregistered.
> 
> Add mfd_remove_devices() call in the error path after mfd_add_devices()
> succeeds, and add the missing mfd_remove_devices() call in pef2256_remove()
> to properly clean up MFD devices.
> 
> Fixes: c96e976d9a05 ("net: wan: framer: Add support for the Lantiq PEF2256 framer")
> Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
> ---
>  drivers/net/wan/framer/pef2256/pef2256.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/wan/framer/pef2256/pef2256.c b/drivers/net/wan/framer/pef2256/pef2256.c
> index 1e4c8e85d598..d43fbf9bb27d 100644
> --- a/drivers/net/wan/framer/pef2256/pef2256.c
> +++ b/drivers/net/wan/framer/pef2256/pef2256.c
> @@ -821,27 +821,34 @@ static int pef2256_probe(struct platform_device *pdev)
>  
>  	ret = pef2256_setup_e1(pef2256);
>  	if (ret)
> -		return ret;
> +		goto err_mfd_remove;
>  
>  	framer_provider = devm_framer_provider_of_register(pef2256->dev,
>  							   framer_provider_simple_of_xlate);
> -	if (IS_ERR(framer_provider))
> -		return PTR_ERR(framer_provider);
> +	if (IS_ERR(framer_provider)) {
> +		ret = PTR_ERR(framer_provider);
> +		goto err_mfd_remove;
> +	}
>  
>  	/* Add audio devices */
>  	ret = pef2256_add_audio_devices(pef2256);
>  	if (ret < 0) {
>  		dev_err(pef2256->dev, "add audio devices failed (%d)\n", ret);
> -		return ret;
> +		goto err_mfd_remove;
>  	}
>  
>  	return 0;
> +
> +err_mfd_remove:
> +	mfd_remove_devices(pef2256->dev);
> +	return ret;
>  }
>  
>  static void pef2256_remove(struct platform_device *pdev)
>  {
>  	struct pef2256 *pef2256 = platform_get_drvdata(pdev);
>  
> +	mfd_remove_devices(pef2256->dev);
>  	/* Disable interrupts */
>  	pef2256_write8(pef2256, PEF2256_IMR0, 0xff);
>  	pef2256_write8(pef2256, PEF2256_IMR1, 0xff);

Thanks for the patch.

Instead of calling mfd_remove_devices() in the error path and the remove()
function, can you replace the mfd_add_devices() call by the device managed
variant devm_mfd_add_devices()?

The device managed variant will handle the removal.

Best regards,
Hervé

