Return-Path: <netdev+bounces-75638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D71A586AC03
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 11:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04D71C2115C
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 10:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D0C44C71;
	Wed, 28 Feb 2024 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sKxKZKBm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C47444C69
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709115445; cv=none; b=t/Ajg9JJ0L3ao8o6gNSmH7Rb/0gOb/UJ0xlI30Ch4Bwx45D4h+gs//+9jMaVoETi4y25XLPwGlwcbEl62thQDs5z8cTgArLSB1vcHOhtATQ9we2hpiLgoYwgbPsQSxu4wvDN8WaMTwQ80f08gNI3iqpMmak7uEq4OSA3qd5Yh2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709115445; c=relaxed/simple;
	bh=IH3Bikqi68/A7myTJacr+ILlvEGyjU3gcgKm2F9+LWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1gj4wU7hhp718lw3jNjKnckn4MOBOOArZ4X2WK8Evor/3UqC7oUeQ5u+pyOut68o5ebC7sX5KozFrDORVq98tDjrkZoznpXTXubCYBRaiZANBh3ql0y5WbUNl04cywn0LXa5sYoX4uVfMytMlH/S4PmqSDCBr6kZVZ2hs1zxxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sKxKZKBm; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412b272799aso5252945e9.3
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 02:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709115442; x=1709720242; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CoC1aILR23YFVOifjxSejtqanuyoJI7UmmW0U6nvIzU=;
        b=sKxKZKBmuqS3jUyOaAKDYxS5lPkpLaDSQnWoSPTw/9PWDdU5/OAMFe3frRcOFUrxyd
         +3G4CFaVhIQVaSBnFozZqYWIVvRsDNNN9T0Eb/xmzbJzLKQ0uiYTqnQ/7kUuIggNTYXi
         uHTc3yPutfAM/HxmiTFP9pb+jkCk3Op+zbWVjpGea3Y9rMSqVXDcrfSf7eVivpYjzn9N
         gL5QcHTSONvdYbazTKN6BK51U19VVsjCaxS6GyKwPhRUB4dwplONnnOvXR5pZqq1mfJZ
         cEW5swr9cPbURo7xGrhc80Ep0AXMvXZAF9O6gqmAPik51PTLFQNQTeDldWTYH4zkH6T3
         zTQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709115442; x=1709720242;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CoC1aILR23YFVOifjxSejtqanuyoJI7UmmW0U6nvIzU=;
        b=MxQTScDMxzz3v6/caEt6bAhs1lZEaRbIKRfPbFi5SmEH7G+jvyMNzyLptUfdtcqZ8T
         d38JLrsC5UcEukTW0vl+nYWmEQrGGuK9b4IwW2zzVLhP7wmKFoqNoDCcCAk622rmLu3P
         VqnvTO0nC0yA1Osr0fta6ZAOzA15iZDX9nN3Q6loephYJFeVoxCkgx8bICeoq4eyYH8S
         i7lor3T92GRsgg6GrgYeXs1Yr4C94eyyQB+kpVLaE+HWNvoXsXq1XrA+ZNm46nRfMOoL
         Y9JCNwHmfgfvmAbq2XpWkoTaiLDmxGAgjYKFpJmWUH0aB456xXbxwgevPnkcYAS6X8aK
         I0FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQeRgaKRjY38VjBsnQUzRFMLwe05AtRbjZ+svf4zTIzTB8fQe6NB1GotK7UY28xCPP3REkonD5jMVnQN93iTqAV+jlir4c
X-Gm-Message-State: AOJu0YxCCclLnd3qTMknc/9+A8Sf89bs9QiYAr4tOa7dxN8suY0KdBc0
	Su3tmy0ykRJZKuuKIoMmFEaQmRloX3h1An1mA9L5tXqm0kNqdTdbIb8ul9CGhqo=
X-Google-Smtp-Source: AGHT+IEpamqaOQJDn0FhlvGVDX/h+ul85tspB7tBYEVrVbYsrmgIR5nB914VhdUa8+jQISj4AybjKg==
X-Received: by 2002:a05:600c:548a:b0:412:9e75:29f1 with SMTP id iv10-20020a05600c548a00b004129e7529f1mr8539047wmb.28.1709115441614;
        Wed, 28 Feb 2024 02:17:21 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id s28-20020a05600c319c00b00412a38e732csm1605103wmp.35.2024.02.28.02.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 02:17:21 -0800 (PST)
Date: Wed, 28 Feb 2024 13:17:17 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: andy@greyhouse.net, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: tehuti: Fix leaks in the error handling
 path of bdx_probe()
Message-ID: <3b12e1e2-4859-40b6-8d9d-0a940251bed4@moroto.mountain>
References: <cover.1709066709.git.christophe.jaillet@wanadoo.fr>
 <9090b599c7574892b77a9521e3ddb3a52a154205.1709066709.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9090b599c7574892b77a9521e3ddb3a52a154205.1709066709.git.christophe.jaillet@wanadoo.fr>

On Tue, Feb 27, 2024 at 09:50:56PM +0100, Christophe JAILLET wrote:
> If an error occurs when allocating the net_device, all the one already
> allocated and registered should be released, as already done in the remove
> function.
> 
> Add a new label, remove the now useless 'err_out_disable_msi' label and
> adjust the error handling path accordingly.
> 
> Fixes: 1a348ccc1047 ("[NET]: Add Tehuti network driver.")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> ---
>  drivers/net/ethernet/tehuti/tehuti.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/tehuti/tehuti.c b/drivers/net/ethernet/tehuti/tehuti.c
> index 938a5caf5a3b..6678179885cb 100644
> --- a/drivers/net/ethernet/tehuti/tehuti.c
> +++ b/drivers/net/ethernet/tehuti/tehuti.c
> @@ -1965,7 +1965,7 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		ndev = alloc_etherdev(sizeof(struct bdx_priv));
>  		if (!ndev) {
>  			err = -ENOMEM;
> -			goto err_out_disable_msi;
> +			goto err_out_free;
>  		}
>  
>  		ndev->netdev_ops = &bdx_netdev_ops;
> @@ -2031,13 +2031,13 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		if (bdx_read_mac(priv)) {
>  			pr_err("load MAC address failed\n");
>  			err = -EFAULT;
> -			goto err_out_disable_msi;
> +			goto err_out_free_current;
>  		}
>  		SET_NETDEV_DEV(ndev, &pdev->dev);
>  		err = register_netdev(ndev);
>  		if (err) {
>  			pr_err("register_netdev failed\n");
> -			goto err_out_free;
> +			goto err_out_free_current;
>  		}
>  		netif_carrier_off(ndev);
>  		netif_stop_queue(ndev);
> @@ -2046,9 +2046,14 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  	}
>  	RET(0);
>  
> -err_out_free:
> +err_out_free_current:
>  	free_netdev(ndev);

Since it seems like you're going to be resending this patch, could you
do this free_netdev() before gotos?  That way if someone adds more code
after the loop then we can still use the goto ladder to unwind.  (No one
is going to add more code after the loop, I know...  I wouldn't have
commented except that it seemed like you were going to resend.)

		if (bdx_read_mac(priv)) {
			free_netdev(ndev);
			pr_err("load MAC address failed\n");
			err = -EFAULT;
			goto err_out_free;
		}

regards,
dan carpenter



