Return-Path: <netdev+bounces-122308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB56960A4C
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66E3E282BBC
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220EC1B86FE;
	Tue, 27 Aug 2024 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h/PN/1qn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCE41B86DE
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761843; cv=none; b=bKEPLo51nuEBp+Z/u665HNyV+HOgDFkzuDFV+CucaLS0AX15wYLjwp+cIKnow7oUReDsqkLfSHjoNKgGmTmJbzJCM4EbWlDNUPjuXOAJZ7sYBJzUN0jiunqIrvw/IvPec6odA7c2IM+vjrJdRoFjnGQwDwRPoqTJA5KOPW+h05E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761843; c=relaxed/simple;
	bh=IHb940nnJZ2SvuUAkyg/lh8Nw6yehiUQxxd2qj/ZBLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLHAjFwdafpoZPPzwQbb0e1jTlSpq5GY3rbJUc2Tdp7TSR4vbdHDbTefF3xwLvgKvzWeSZ/gM3pIjWBhRfgVPby49FZpPodmqzuhdSYNF5BUtMPUYS5oyo3HSDx6IEo7Kpe4+EvO8m6TH/kJTFGmFJwWnFDM817bwShYD5G+d/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h/PN/1qn; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42ab99fb45dso60444665e9.1
        for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 05:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724761840; x=1725366640; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5VOMn14gOEKue+FH0nvoCYCVPsuyVTuWEK6s6m/CZeo=;
        b=h/PN/1qn3+RhklrN+9ZutApKEWLIjb5zt4S3+v+6eIop/HG8TnmCJEnacFGtwSXZd+
         BU9ZAWjAysKXyPZtHUw4PQx8ZYykPtUAX0Qlx540iS51ZWD8s+PXKi3uJyRHxWGTAlAe
         T9dIAf82zbZkec2WQjO/kkZgjT74uyT84Ve0krH7XuC4UMikyTQ+qM2hDta4lXqYGwA7
         KxpNFIyZ+nXZp9Az5phM1kwGW0/1xkt8bM4YV+YVbru0yh+MNI/S+TN+W4bza5n1THkW
         z69WKUHi9wUtQk24+Jj8bZYOkP00LI2j2fsR9PvxIF00+GD0RrkTDUBD1THmpMCz81sz
         iXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724761840; x=1725366640;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5VOMn14gOEKue+FH0nvoCYCVPsuyVTuWEK6s6m/CZeo=;
        b=Orf2y+9eJmbxMIsYuQqEXn2J+e8Q1MVZJ+asgqSoBdOQOfBojiqxWD0iupLPl5m2yv
         5t6YOidrKZvwFxIKKh+2b8n4y5SH8AyODUaGVARxpxPuXpqKiMNgus0XnpdAfYQmY4dR
         8JwPAP8EIdPxiv5YM/USGwzFgVKe6d+wN7oCL7kgTLK6D/n0Pd/3iBMRKWIF1X2bBsml
         dozjRWIM6Vez0P0LisatJsfYwUylRsIXULHSnFoxu7cIxNF0y4Te/sTXyQBPXtnnw30d
         ldueoRkiNgMGJSM+Q2jDPIYydbSjLQX+UY7eOSdN7vd3BaBSdLoga8VyXcbS8xe1hv6C
         aVSA==
X-Forwarded-Encrypted: i=1; AJvYcCUDWmx6+YKJkycOp4oPbwnPOZz+ITEO1bDdfgrH18qUMyoTlhAAfu25+RRygFEI3w8XAfzfsEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI48Dqab97Vquadbq5GWqKcAEHujbXtXllgVfZYWrvtUoPxSSD
	aWFXfU2aHvmYPeJxfxsEo8TC5KAVcQNlR3ehUmZQknpYFLfGcQk8oEMefUPuDAg=
X-Google-Smtp-Source: AGHT+IFGureTSxwlr38yfaqUQhX5V207pdKbWa+rDiYwnid+SF/4PZRPeUsvQGcVw5VXsLH1QlS+nw==
X-Received: by 2002:a05:600c:181b:b0:42a:a6b8:f09f with SMTP id 5b1f17b1804b1-42acd5dccd8mr111153575e9.23.1724761839563;
        Tue, 27 Aug 2024 05:30:39 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3730817ae1fsm13069817f8f.65.2024.08.27.05.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 05:30:38 -0700 (PDT)
Date: Tue, 27 Aug 2024 15:30:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Hongbo Li <lihongbo22@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, dsahern@kernel.org, ralf@linux-mips.org,
	jmaloy@redhat.com, ying.xue@windriver.com, netdev@vger.kernel.org,
	linux-hams@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net-next 1/6] net: prefer strscpy over strcpy
Message-ID: <a60d4c8f-409e-4149-9eae-64bb3ea2e6bf@stanley.mountain>
References: <20240827113527.4019856-1-lihongbo22@huawei.com>
 <20240827113527.4019856-2-lihongbo22@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827113527.4019856-2-lihongbo22@huawei.com>

On Tue, Aug 27, 2024 at 07:35:22PM +0800, Hongbo Li wrote:
> The deprecated helper strcpy() performs no bounds checking on the
> destination buffer. This could result in linear overflows beyond
> the end of the buffer, leading to all kinds of misbehaviors.
> The safe replacement is strscpy() [1].
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
> 
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
> ---
>  net/core/dev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 0d0b983a6c21..f5e0a0d801fd 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -11121,7 +11121,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_priv, const char *name,
>  	if (!dev->ethtool)
>  		goto free_all;
>  
> -	strcpy(dev->name, name);
> +	strscpy(dev->name, name, sizeof(dev->name));

You can just do:

	strscpy(dev->name, name);

I prefer this format because it ensures that dev->name is an array and not a
pointer.  Also shorter.

regards,
dan carpenter


