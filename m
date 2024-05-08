Return-Path: <netdev+bounces-94608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAAEE8BFFD6
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 16:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549EE1F223EA
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 14:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C34385279;
	Wed,  8 May 2024 14:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foVciofR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160CE54FA3
	for <netdev@vger.kernel.org>; Wed,  8 May 2024 14:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178215; cv=none; b=kgEG3kJmTr/zWAmwwjWFuy6aJXkyGYq0zLonoAk1A/aVxhoJA4kdHjp3g27ink+1to4PXO1jxBROoAo2XcwC8a3sNJSzFcqpsIY7QRqe4GyfizrgRQ1Er246PGvRGyMKCG1b6fYK9P84LGdWhtJZBOuGqgImA3vf3Bf2QXXyat8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178215; c=relaxed/simple;
	bh=8fH6jRdDmbAnB9N28iTR7F5I1XJIrOvaMZXp3yLpkDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq8dyAi4mKXWtp7iiC8c+9ACegyvUu7tTawVdayJW7UyXus+F7kCJu2Q5cdRWIhdQDNAIm9nIe/kXWkbh7yOfNX8NqYXBE3glwhCigLeoZPZttk91bnfQfcU/U3xjqgwp0gLJ08DCn6neMSkD1JKu6L/s46pBQcLv3Loy4yEow8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foVciofR; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ed9fc77bbfso3329412b3a.1
        for <netdev@vger.kernel.org>; Wed, 08 May 2024 07:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715178213; x=1715783013; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yWFDb/XC5HCMPYI0Z8fskivsrqr1wR3MQAkFu/Af6yE=;
        b=foVciofRW7DRjbC/BSkG9dV7FNXAzgMYWS1BsMaBAl9SIL7+aWBEsh/9zfxSnxcXhL
         nClIJnrR9Fa8rDTAbAqk2OwTjEEnJ5wS1gL1hh3cJPJvtthIIxiEy9gWb7JTkz/gNilI
         gqCEJm33xTQL2zir71JX+ISDtohJU+g8gEuYQxju//ChaFVEVdM3JW3tkeIgOqg2edpA
         ZnlbY6ZLb95BvrK5nQA8fAgeQfKlrCCr9crKz+0daoPb7qXyvdcGyjxLvMFeCbhxLL/6
         jBRWjrQ7bnystCFYsAQSXVhjfWLJDS+V8MDy0t7WZrt4ZPsBRuc+Fk4S0SWXJkpm2HRp
         Ajaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715178213; x=1715783013;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWFDb/XC5HCMPYI0Z8fskivsrqr1wR3MQAkFu/Af6yE=;
        b=Bl4XHTTrmGwEu81ck+qP7cUryITpEMz6fsucAADgvNTcyWWvig3ULSoSBFYefDJiyh
         b2BUwVBeig1GJEg1JtmY9DKCX7S9M5yde3w+6Exzx+e1Hc42CmD/qGIxhvIqSfrQ8As+
         XNCc7IrleerxMyTzS1R6Pony07+UPlotZe2QyYgkg/zl+ibSes1aRYhAic19dpVecE5e
         0JN2hOy/wDF1GoCNiXbjmg08fjrIQKZF9HQaH58AAKF0TRhUpysiOlb3jJqQuVSeFbwN
         Hk/L6LD7tB29nUA/t1ssQHFcv+S8MpZODPNRzBDY/CNh99rjuyNjm0uzYBNeVb9CWgWQ
         snGg==
X-Gm-Message-State: AOJu0YwZULZTr4Frd8yT2o6EBYWf+CUsiRyLhsyL2u1wGgMaYrpywyQg
	5ccPMqh12O5icsYNJA8OhNJIK1HpwTOiKsRAO/nu+gdFORyXxzEX
X-Google-Smtp-Source: AGHT+IHAPmTfJDMlM8sVXwx0ivcH90uQ9i9aIyXyCPz0EQ7bDzwCfk1kONesK1XvFOXFIw0rrh8gCQ==
X-Received: by 2002:a05:6a20:9c8d:b0:1af:a35b:a34f with SMTP id adf61e73a8af0-1afc8d4e5a3mr3300831637.25.1715178213035;
        Wed, 08 May 2024 07:23:33 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d13-20020aa7868d000000b006f49c07f9dasm1684351pfo.21.2024.05.08.07.23.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 07:23:32 -0700 (PDT)
Date: Wed, 8 May 2024 22:23:28 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vasiliy Kovalev <kovalev@altlinux.org>,
	Guillaume Nault <gnault@redhat.com>
Subject: Re: [PATCHv2 net] ipv6: sr: fix invalid unregister error path
Message-ID: <ZjuK4AT-B_NQmFkb@Laptop-X1>
References: <20240508025502.3928296-1-liuhangbin@gmail.com>
 <ZjtG3iQywq2xll6H@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjtG3iQywq2xll6H@hog>

On Wed, May 08, 2024 at 11:33:18AM +0200, Sabrina Dubroca wrote:
> > ---
> > v2: define label out_unregister_genl in CONFIG_IPV6_SEG6_LWTUNNEL(Sabrina Dubroca)
> > ---
> >  net/ipv6/seg6.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/ipv6/seg6.c b/net/ipv6/seg6.c
> > index 35508abd76f4..6a80d93399ce 100644
> > --- a/net/ipv6/seg6.c
> > +++ b/net/ipv6/seg6.c
> > @@ -551,8 +551,8 @@ int __init seg6_init(void)
> >  #endif
> >  #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
> >  out_unregister_genl:
> > -	genl_unregister_family(&seg6_genl_family);
> >  #endif
> > +	genl_unregister_family(&seg6_genl_family);
> 
> Sorry, I didn't notice when you answered my comment yesterday, but
> this will create unreachable code after return when
> CONFIG_IPV6_SEG6_LWTUNNEL=n and CONFIG_IPV6_SEG6_HMAC=n:

Oh.. Didn't notice this...

> 
> out:
> 	return err;
> 	genl_unregister_family(&seg6_genl_family);
> out_unregister_pernet:
> 	unregister_pernet_subsys(&ip6_segments_ops);
> 	goto out;
> 
> 
> (stragely, gcc doesn't complain about it, I thought it would)

Yes, I also complied the patch with not complain, so I just posted it.

> 
> 
> The only solution I can think of if we want to avoid it is ugly:
> 
>  #ifdef CONFIG_IPV6_SEG6_LWTUNNEL
>  out_unregister_genl:
>  #endif
> +#if IS_ENABLED(CONFIG_IPV6_SEG6_LWTUNNEL) || IS_ENABLED(CONFIG_IPV6_SEG6_HMAC)
>  	genl_unregister_family(&seg6_genl_family);
> +#endif
>  out_unregister_pernet:
>  	unregister_pernet_subsys(&ip6_segments_ops);
>  	goto out;
> 
> (on top of v2)
> 
> For all other cases your patch looks correct.

Thanks, I will check if there are any other workaround. If not, I will do
like what you said.

Hangbin

