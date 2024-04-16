Return-Path: <netdev+bounces-88438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 453D28A7357
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 20:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FD71C20C2A
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 18:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901A51353F3;
	Tue, 16 Apr 2024 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bX0e47ZZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0654C132C37
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 18:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713292786; cv=none; b=TV1KNADGnhpxTtutmnWuVry9sqWsOeSjrZdAk76mVd8tt1Y4v8n0NX+F5ExKxXRxnoJs4/YhOOnFIlE/dcgam0T2p29CsftNMwAU7XZqyXuC+DM2j2IfEA52MTFbmJ1NH4d/f6yhCrh0KOUnGtdpN/zLZ19Jf9eHl4WLn91eA48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713292786; c=relaxed/simple;
	bh=IzLdLmZsOVhygyqZD3YHCBEAjqCi2F84E0UBopOxjmw=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=sgN3JUFhIgXYD5HpvV69mUW2OE+LleXS48roTbbLlDupiF+NifCyfWyR7+klCCNu7Rz99Fob8rJDQ13emUZv+rVYrkZS0aB5gqGYhp/ZgR32BGx8FvSacYSSpSKnUFtrPxgmBpikI1lXYUD0vB3zD1NHccCmGQ0PmrYy1OZHkDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bX0e47ZZ; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-36b1774e453so10282255ab.1
        for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 11:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1713292784; x=1713897584; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iDc/as2umO5yOV3gBttijC1OB8STXg7uxsekpXHiEoU=;
        b=bX0e47ZZj0oeaZMfc5VJ1lzgipNg6+H7gpGnpMhGv4910sMp61eWmfwI+L+CYyaeG5
         SWruTftZ6n42MZpIlMQR9qHTnKlZCJxA9+cUvAqEjd9xxzAhQfNrBkoNMM3KWsyRIqLo
         uq12KqDgU4ikddhFkB9aG8DPR1YdVM+RKBuFBX0vt8kELIJBKgWbYYlRDPPKBwaTTqi1
         avASHPL0IAgXxl+WpxF9giKjxCH1J2MIzuGTI2sdhX9U4o7CeL/JdaPxUEOHwRgS28wZ
         AB85YZa5/hsUTBRWZYZSn3QvO7aXNEhz7uZ1vTJY8BQcG3TkzGSrKe2+ke8Dl2ie5E3R
         tMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713292784; x=1713897584;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iDc/as2umO5yOV3gBttijC1OB8STXg7uxsekpXHiEoU=;
        b=gL85ikauurxbSKW9Xp+psV6gYCNrlTWV1P2i2xmnkaQi+9+/06k5/wLdQRdfzeaIYw
         R+dUXr9YPuplabpFarPyspftwtAB6t9nqaWZyOU9Ie1ZU4cQPZjLDw/PRei6nwxZV9sZ
         ggZfC/5r98ZGLGE52DFD5xlJKv2eApoZSxpQzvaE+ESqIBaAVwDDhqhVBRBBVPvlPH8o
         BBFxzv93Jt30O4l1Gy/4Qg5SY9KzJTKiER28ZvlUAgwR9GUT8JnsAg09yyIntO8fgAIy
         swVnEMxQZA3aqD8P4IHhxMomjtoa23/BGVT+K46ZXD/IYJHXTgye/RMcESgq2bi0y6/K
         vy+w==
X-Gm-Message-State: AOJu0YySKJQibtWSo+3Eu8LfjnHruV+Z0ldrZaeMTr2w8eAY06iQmvxJ
	ZKSZ45aY8u8gIO43wt+QCnQjoMAif+kgYvwVIAtkZx6LMT5tc6RPYNRjBTjES7Ilczyd3zIlLnc
	=
X-Google-Smtp-Source: AGHT+IEaJMfAJXXS8ckHiwVn4d6kqbcwJ2mTV3WxofEHSRHnhHOkrySCakIjaRhnVZOAP/6qvsVDBg==
X-Received: by 2002:a05:6e02:188f:b0:36b:83a:557e with SMTP id o15-20020a056e02188f00b0036b083a557emr17264150ilu.17.1713292784088;
        Tue, 16 Apr 2024 11:39:44 -0700 (PDT)
Received: from localhost ([75.104.108.48])
        by smtp.gmail.com with ESMTPSA id bm6-20020a05663842c600b0047f100b70e1sm4113540jab.105.2024.04.16.11.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 11:39:43 -0700 (PDT)
Date: Tue, 16 Apr 2024 14:39:37 -0400
Message-ID: <0a814ce3acdea2c07cef6f7c31008e19@paul-moore.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/2] cipso: fix total option length computation
References: <20240416152913.1527166-2-omosnace@redhat.com>
In-Reply-To: <20240416152913.1527166-2-omosnace@redhat.com>

On Apr 16, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> 
> As evident from the definition of ip_options_get(), the IP option
> IPOPT_END is used to pad the IP option data array, not IPOPT_NOP. Yet
> the loop that walks the IP options to determine the total IP options
> length in cipso_v4_delopt() doesn't take it into account.
> 
> Fix it by recognizing the IPOPT_END value as the end of actual options.
> Also add safety checks in case the options are invalid/corrupted.
> 
> Fixes: 014ab19a69c3 ("selinux: Set socket NetLabel based on connection endpoint")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  net/ipv4/cipso_ipv4.c | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/net/ipv4/cipso_ipv4.c b/net/ipv4/cipso_ipv4.c
> index 8b17d83e5fde4..75b5e3c35f9bf 100644
> --- a/net/ipv4/cipso_ipv4.c
> +++ b/net/ipv4/cipso_ipv4.c
> @@ -2012,12 +2012,21 @@ static int cipso_v4_delopt(struct ip_options_rcu __rcu **opt_ptr)
>  		 * from there we can determine the new total option length */
>  		iter = 0;
>  		optlen_new = 0;
> -		while (iter < opt->opt.optlen)
> -			if (opt->opt.__data[iter] != IPOPT_NOP) {
> -				iter += opt->opt.__data[iter + 1];
> -				optlen_new = iter;
> -			} else
> +		while (iter < opt->opt.optlen) {
> +			if (opt->opt.__data[iter] == IPOPT_END) {
> +				break;
> +			} else if (opt->opt.__data[iter] == IPOPT_NOP) {
>  				iter++;
> +			} else {
> +				if (WARN_ON(opt->opt.__data[iter + 1] < 2))
> +					iter += 2;
> +				else
> +					iter += opt->opt.__data[iter + 1];
> +				optlen_new = iter;

I worry that WARN_ON(), especially in conjunction with the one below,
could generate a lot of noise on the console and system logs, let's
be a bit more selective about what we check and report on.  Presumably
the options have already gone through a basic sanity check so there
shouldn't be anything too scary in there.

  if (opt == IPOPT_END) {
    /* ... */
  } else if (opt == IPOPT_NOP) {
    /* ... */
  } else {
    iter += opt[iter + 1];
    optlen_new = iter;
  }

> +			}
> +		}
> +		if (WARN_ON(optlen_new > opt->opt.optlen))
> +			optlen_new = opt->opt.optlen;

This is also probably not really necessary, but it bothers me less.

>  		hdr_delta = opt->opt.optlen;
>  		opt->opt.optlen = (optlen_new + 3) & ~3;
>  		hdr_delta -= opt->opt.optlen;
> -- 
> 2.44.0

--
paul-moore.com

