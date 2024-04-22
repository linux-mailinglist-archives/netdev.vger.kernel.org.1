Return-Path: <netdev+bounces-90109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E8D18ACD38
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 14:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C74AFB24A72
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 12:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE36814EC7D;
	Mon, 22 Apr 2024 12:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QKVetmT4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D6114A61A
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 12:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713790045; cv=none; b=KGJyjoxjef2UF9VWOa3IxIILdrZQVc9jJ9OEslg/trVunwCxjl6pBFkaEYtFWe4zp6fDCWbje3xvq3pB9VZ6awcY4r46hUB4HOLXSCteqYTpCWDoVsTf49e5tL1LMsFpBODei/tVrMIyFcGDae3Rcm8sp87tgzpJ7CzAojsNu+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713790045; c=relaxed/simple;
	bh=xK0xpJYoCLIITlC+CsYauUdtz62QeVeHRGmWzCiWf5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpXMlBxzkPEYmA1NF0P3A1Nk9flFY5fY3tb6nq9YUwFSeCCaJsosR7eEmsujOBg50oZsivuClAiS33uK2Py4K6ZaGRFnhyp1sinakDGjYo0H8XCwcXFmALVQxFJtTGg8l7xjBuwJ0/ZfkIi5QtMWwVO3qwlSb+OIreKZXxjPwY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QKVetmT4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5196c755e82so6087887e87.0
        for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 05:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713790042; x=1714394842; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tAq2BIio/WgpUEPdT8jPUBANtNcgUg2oMhI7FrVaEB0=;
        b=QKVetmT4Qiv2LzM5bk/Rk+DI4aimjEbt6joAxLnYRDLX/FzEMNGF8e7jXAlwsrauwA
         c0xHKqmpHy76N/L5OvbNpQ9raifbYLglRIU6o0U0C47ElT+tlsLhwzs8RywixlGPoKoT
         BG2v89BzOhSKDFCFBbnEZsljWgBsLovuefUO0IenfK5GCcq3ZLK0NxUPLRJ2oHoVVTua
         YPBlZ9cyYeMVcpGP+TANdwTW7jxweUyLoKH3IonGyLckFiGZ1k2H6OF55duhqQWGq77g
         iKxLlyouFq8MohJmDXXj9VIzCMVkDB9FcPmUxoRzOyvl/Xv4+rdFnN0L94sombBSJL9J
         Diaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713790042; x=1714394842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tAq2BIio/WgpUEPdT8jPUBANtNcgUg2oMhI7FrVaEB0=;
        b=Hg4zAyNmaQklxL4/78C2JPebRWbrdr+NBdQNIx+REIcnbSnWCJu7/yAtp9MLmdeql7
         9g9VuB16+MyftAgbVr9Z5cglqLHstTque0VoJK+dJBnv3q4RWkbEZ1DnsIveypUTRAuz
         gemcHQ1DXsf4KFEC5Zh3XvLNPRS+bCZcFGGXsjm3I9M36fEx2YiLIh/Q3vBLQJvLUkj4
         mf8OxJmuRiTK9iFH61dOghKRYgz6woft3NZPDbDGHllRU2nTVjPyMtMrygYA0fI2udt/
         iQfBH20Ugz/cgFacQMRiJn3DsoX4OQXbfj8C7Zp/HQJ2mQQ7VX9TIK2MHOEwF86Zn4ar
         F5kA==
X-Forwarded-Encrypted: i=1; AJvYcCUWROmUpEacQaZmlzXmNt2UWYd3GsnQX1v6GlFui06RjuhiqzOmWEai2kAAvo9zxm2j9rxIRPPuxrBfs8GOWuPLJFKvbTpc
X-Gm-Message-State: AOJu0YzBmgrBGUMF/4nvk9U23nJMqB0JQGJp8jXs/cJQN75EKdar52LJ
	8BTBJ01l8nTAV2qaKgxVJYGDHIk4WQFGAVq8g2LYlofJt2p9e0utUBZIvjlX3NmNuGVO2JOxfX6
	W
X-Google-Smtp-Source: AGHT+IEMH8RihJNVGuEx0Di87sDBlhXnXygmj8MwWRwVHNTMdA9GYNd7ZTy8dfvJApZvwx5iiRjYLw==
X-Received: by 2002:a05:6512:20c3:b0:51a:c3a6:9209 with SMTP id u3-20020a05651220c300b0051ac3a69209mr5156044lfr.68.1713790039896;
        Mon, 22 Apr 2024 05:47:19 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id r25-20020a170906351900b00a55b5c365dfsm1248156eja.199.2024.04.22.05.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 05:47:19 -0700 (PDT)
Date: Mon, 22 Apr 2024 15:47:15 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: ajk@comnets.uni-bremen.de, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot+8e03da5d64bc85098811@syzkaller.appspotmail.com
Subject: Re: [PATCH] hams: Fix deadlock caused by unsafe-irq lock in sp_get()
Message-ID: <bac3fb0d-2810-496d-b3ef-26a7f208ec51@moroto.mountain>
References: <20240418173037.6714-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418173037.6714-1-aha310510@gmail.com>

On Fri, Apr 19, 2024 at 02:30:37AM +0900, Jeongjun Park wrote:
> 
> read_lock() present in sp_get() is interrupt-vulnerable, so the function needs to be modified.
> 
> 
> Reported-by: syzbot+8e03da5d64bc85098811@syzkaller.appspotmail.com
> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> ---
>  drivers/net/hamradio/6pack.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
> index 6ed38a3cdd73..f882682ff0c8 100644
> --- a/drivers/net/hamradio/6pack.c
> +++ b/drivers/net/hamradio/6pack.c
> @@ -372,12 +372,13 @@ static DEFINE_RWLOCK(disc_data_lock);
>  static struct sixpack *sp_get(struct tty_struct *tty)
>  {
>  	struct sixpack *sp;
> +	unsigned long flags;
>  
> -	read_lock(&disc_data_lock);
> +	flags = read_lock_irqsave(&disc_data_lock);

This doesn't compile.  At least build test your patches.

regards,
dan carpenter


