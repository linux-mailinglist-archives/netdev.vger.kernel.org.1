Return-Path: <netdev+bounces-93425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D5B8BBA9C
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 13:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 614E0B21724
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 11:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294AC1BF2A;
	Sat,  4 May 2024 11:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdSEcuHB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68558182CC
	for <netdev@vger.kernel.org>; Sat,  4 May 2024 11:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714820675; cv=none; b=rIhTwkxtxd3TKbrGiW1FLe8LG1UsV6iCWzlFQ2cb7femxCt1ouauy/id1fLItERL+P4wSYWiIIwi0gdJbKmKNQszh/KeHM2xEXkkE2gOGMP3TvuxdTDiCx02S19dI4fdkKB34Wb2e8ZcxN5T1d06SLSfL7+xrk2B5IZ4zGc+D1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714820675; c=relaxed/simple;
	bh=oESbJrzd3NodVfpRoKiTo6HVR3uCwGr/hSqHg54pang=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nT6WxPYyLJAt+spwECG84gQJmHPLYIC5DDgYxAbne4Eb/GqlEslV0rXbMNiQm4ZilodSYPmIVDi9XQi91tfhZcxFzkznbVvDzHzo2D4q2INm0ZCOkvnQiRDIYS2RpCJj6bSRtNatK3hUURF/enxLvqPNEngU256gXcVVSswsqtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NdSEcuHB; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2e20f2db068so4980801fa.2
        for <netdev@vger.kernel.org>; Sat, 04 May 2024 04:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714820672; x=1715425472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QqIw4+jSQ5b87qweNz9VaPv59kaDSpMsRWOBQ8BsgAg=;
        b=NdSEcuHBHsnxVuuIuxZq58ivVP8dULucAlMREwUXNdeXdLpQsRMAUtmCwqdbGWNH9y
         ik+LYWye3m09isZWNiRtP1/RWGsqOruQK6PAkBhmGusQL7Ak+ZeChkF/3TmSszp4ieoj
         3D7yQwQdGjL26cpGHqaMs2KyHM0UvSGZ9G0IYSOG4u4P7RDaRgOgzxbcbvnD4Wm3opVB
         P/PerrDOn8PRdzpATmxrB6uNU9PmjVTT+mlR4bQMtRYPYlQH/NZOBOcisOftf9xGvK89
         AgOpcQ8tvVVZS5xn2fEmzWyAw5iDERf2DFl8QXgr+R1bxW0VGEvl3g0xPFOfsiWnwChc
         uvtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714820672; x=1715425472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqIw4+jSQ5b87qweNz9VaPv59kaDSpMsRWOBQ8BsgAg=;
        b=TTsakwekZh+T6Qx3YEOq40Ydy+iFS9TaRcId+qzfZKGP2VskWulXbutb+70PeFyj41
         4oJvEifKMFHza3rSYpdAULXiG1yP76KTe2xq8m71V8UH9z268k2/WIHmVc/Y25krXFTj
         7w7zgIID2kUDA9NwmVXamtSCsnRXwrN25UafbcGUMm2mqgVgbrds3hilAugoXoJZTy4s
         iFRz1KRcXdju4pk+zA5NufQ9l7/Z6paXxgFs7bn6cqT5wNllNwFyr+dmROzPY6CdTwD+
         0shMsd3TxYlCMAti2t/XH6LLCpltzsmQvQBEZT1dzkBQDtGVh1kXS2kU3y6YmXLRMOtB
         Vxeg==
X-Forwarded-Encrypted: i=1; AJvYcCV0kuqllcxkGco51alU1HWGDVb+vw4GfzwdS2zuw3FrO3r9T/jhN41T0R8JXxVNpqhlT7+xrXEIRYzMZ9OtCSNEQPBRiUDl
X-Gm-Message-State: AOJu0Yyg+s/YA6+Q3qRnZZmNag1R9YMHzehB+HgxJFjy+tiPWBWICRAR
	HcoPmDJ3UhDP6cIrZvzwQfLzZIeo/pTmn1F9yue7wOsowYNNKTcti3NQjVZ/2p8DrO1aA+df3Ua
	s
X-Google-Smtp-Source: AGHT+IEVLFaJ2xohkXrGS/+Gw9GuM+CyPwMFte2/sMkc5UfIYuU5HWmYlOdvr36TRiKJGIRWgrjzcQ==
X-Received: by 2002:a2e:3612:0:b0:2d9:f00c:d2d5 with SMTP id d18-20020a2e3612000000b002d9f00cd2d5mr3018955lja.46.1714820671226;
        Sat, 04 May 2024 04:04:31 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id k6-20020a05600c478600b004185be4baefsm9006237wmo.0.2024.05.04.04.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 May 2024 04:04:30 -0700 (PDT)
Date: Sat, 4 May 2024 14:04:26 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, jreuter@yaina.de,
	lars@oddbit.com
Subject: Re: [PATCH net] ax25: Fix refcount leak issues of ax25_dev
Message-ID: <808ad381-179c-4975-a3f5-1d7cad00320b@moroto.mountain>
References: <20240501060218.32898-1-duoming@zju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501060218.32898-1-duoming@zju.edu.cn>

On Wed, May 01, 2024 at 02:02:18PM +0800, Duoming Zhou wrote:
> @@ -58,7 +59,6 @@ void ax25_dev_device_up(struct net_device *dev)
>  		return;
>  	}
>  
> -	refcount_set(&ax25_dev->refcount, 1);

Let's keep this here, and just delete the ax25_dev_hold().  It makes
the diff smaller and I like setting the refcount earlier anyway.

>  	dev->ax25_ptr     = ax25_dev;

Let's move this assignment under the spinlock where ax25_dev_hold() was.

>  	ax25_dev->dev     = dev;
>  	netdev_hold(dev, &ax25_dev->dev_tracker, GFP_KERNEL);
> @@ -88,7 +88,7 @@ void ax25_dev_device_up(struct net_device *dev)
>  	ax25_dev->next = ax25_dev_list;
>  	ax25_dev_list  = ax25_dev;
>  	spin_unlock_bh(&ax25_dev_lock);
> -	ax25_dev_hold(ax25_dev);
> +	refcount_set(&ax25_dev->refcount, 1);
>  
>  	ax25_register_dev_sysctl(ax25_dev);
>  }
> @@ -135,7 +135,6 @@ void ax25_dev_device_down(struct net_device *dev)
>  
>  unlock_put:
>  	spin_unlock_bh(&ax25_dev_lock);
> -	ax25_dev_put(ax25_dev);
>  	dev->ax25_ptr = NULL;
>  	netdev_put(dev, &ax25_dev->dev_tracker);
>  	ax25_dev_put(ax25_dev);

So far as I can see, the ax25_dev should be on the list.  Also, I think
the dev->ax25_ptr = NULL; assignment should be under the lock.  So this
code should just look like:

        list_for_each_entry(s, &ax25_dev_list, list) {
                if (s->forward == dev)
                        s->forward = NULL;
        }

        list_for_each_entry(s, &ax25_dev_list, list) {
                if (s == ax25_dev) {
                        list_del(&s->list);
                        break;
                }
        }
        dev->ax25_ptr = NULL;
        spin_unlock_bh(&ax25_dev_lock);
        netdev_put(dev, &ax25_dev->dev_tracker);
        ax25_dev_put(ax25_dev);
}

Also it should just be on the list once...  In fact, it's impossible for
one pointer to be on a list twice.  So it would be nice to add a break;
in ax25_addr_ax25dev().  It doesn't change the code, it just makes it
more obvious.

ax25_dev *ax25_addr_ax25dev(ax25_address *addr)
{
        ax25_dev *ax25_dev, *res = NULL;

        spin_lock_bh(&ax25_dev_lock);
        list_for_each_entry(ax25_dev, &ax25_dev_list, list) {
                if (ax25cmp(addr, (const ax25_address *)ax25_dev->dev->dev_addr) == 0) {
                        res = ax25_dev;
			ax25_dev_hold(res);
                        break;
                }
        }
        spin_unlock_bh(&ax25_dev_lock);

        return res;
}

regards,
dan carpenter


