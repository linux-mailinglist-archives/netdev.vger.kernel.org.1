Return-Path: <netdev+bounces-234033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E73AC1BC09
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 16:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33B0B5045AC
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 15:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153B9254848;
	Wed, 29 Oct 2025 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWrzeflg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7445D1B87C0
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 15:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761750028; cv=none; b=D+V6XPWqyc/M+eFcbTVHDfE5xZL0JCyfW1pfGj4mIucfYcQ6zPTZER4IbTR25FNiECwMGwJ6/iCVCfeuMRIcdf2WPiNoYV0S3t6H9NwlMK0Jpt+bUEzDYze/70FFdPRcCBkYb5B6VVnVjzjcf6YoqeC0SvUkOtO6nUV8hpYexFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761750028; c=relaxed/simple;
	bh=kDmf77tedE88aPpyfJr7LDLMgEGahb6mvhghT+unsfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XlSO2OQ91Dz9Kj6Bx3RYu+C4Tg07c2soe0ulpJ+ibeXNm5HdRIm1elUdIUURHlEhZtsOsAn0rRCRlSn7F249VW9by50DAa2+npFFfl6xNZ5WLd8qWT8bW2/WKFK5xb0dwQBoJcDxrHtXrfWPMHrwzkzlDeVb/MjtWcY1T9trWBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IWrzeflg; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78619d34979so22765647b3.2
        for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 08:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761750025; x=1762354825; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Ql3kbMwxhnndJ3lbzZIORatm4L5GmMvBgTbUDswXes=;
        b=IWrzeflgq6ZHT/wxLIr+4fEBpjETAJUJVtsmHELbhDPpUcxsGmKD+FI86zC8sKdLQZ
         9jhc5eKRz+m9XZBeJ1GUvnOwi0hk+mkxG96ECAPYlETNAsx4J6DC+c+uqCPZ5NJQ9l9n
         bN4Ke/3xZctGvre6aklfK3SVUXsJzCWkXd+sqRtpd1BQUSWe+3D8h7CoPbMmN68im+Mv
         t5jG7eSaeX79OAOjXkNGbGH/JA6qth4kvxICu1Jyj/oAqmNnzsXiTtB3+yJ4yHxZtKXJ
         ew4LtUsL0FPqRfxDm3sCa0DlDZn5d+B+N90kZE7atkqy1jLqbo8wNE/4dMlcwDD1xnM9
         q2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761750025; x=1762354825;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ql3kbMwxhnndJ3lbzZIORatm4L5GmMvBgTbUDswXes=;
        b=lkpEsKKYGb2QWUQBxVmb0lLObnJYq/u+BX8AbEqiFfGs9Owrbuon17j8cWXWUrU9Jv
         2gtF1k7jKZr7h0gY+wsEpIYFwZNiL3IJHUfC7vpXjAuvZDYv0Hcuiqk89bEuwnD1wV4/
         /bCFiys3KZ+yW+9+i8DDeIzeULZ0EWowyYr1wfQiLJY3zfIwcpjQzMzMvewKSwRAZgSE
         YazRgfjA7biGtZ2aL5Bg2UVmj1VjXaF+bNVLI1Xg2VkUj+Dxcecs+IOb/1ZcMFFypzz9
         2byaENkWQ/0Swu4HTuIfpzrKzkwLZ9q5e270sQMeLSda7pQGztQ5VRQKM3Pz2fqo2XXv
         jVMg==
X-Forwarded-Encrypted: i=1; AJvYcCXmey5xDMjQOz+ViqsEZDXHw3V4YHtOkvLdvN6HROnQnZ7efKIkjo65karmMUz8XbCukm4Y/o8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyser8Y7HCUI1hRI4W/8MGM9muRw6IJMSOFYVQal71FG5bJl2Ja
	/lYZANZ2Z2Z8BqdURlkMk7000sltngJnm9r3E/8J6UIIoSLs+/ZoaFTI
X-Gm-Gg: ASbGncsUbVzfZBRjdh52ljmjTl5KOLqgQUJF2gkdrzTsTJlKbG986HeqhdliM6hOYdm
	1z/uJBIH4p9qxqrXl73gbwZ4ezpjiSx/aWYv9//gEfg4TxVBpziIRjp69jC8mR4p3wiLFkg3grO
	Cdp8H/nFGdwLJhKPX2GFin2AYZKDGSlDNgPik79t2DgwZrvqJf85cuIqqfGMyGNoda73wHMjBF3
	T2b1HvnmO2M2zxkO/ty2E6UpD2UOW5/wMHL3H3oH5zntSzLcKmtZ0kNUxiuHDL2ZV8yt4ySauc2
	9jdly34ctUxwmMTgNENY4wSAA5WzLINfnDp2632hKxXS5gqvsIeYswLkw1BDDXJDB4LUfoQva+n
	96nKVh9KBadaeAcKiF6OrXBcFwdfEYHN0DqICJZPiAXoZe/uK3hj37UGvH9vUDEjCCJUaMct+hD
	/wMqHRS255Da3PMucSqPB875fL/sFcoZn8Qoh3
X-Google-Smtp-Source: AGHT+IFvEwZzVVStxJAjLYAeH/0cv5R0d8RA0ZIolpAcU/vC/ccLMmOqB8ZJKQUFbO9HNadpf3N1Dw==
X-Received: by 2002:a05:690c:6d8a:b0:774:cc25:7f51 with SMTP id 00721157ae682-7862932fa5bmr29953597b3.36.1761750025100;
        Wed, 29 Oct 2025 08:00:25 -0700 (PDT)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:5b::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-785ed140812sm36577547b3.9.2025.10.29.08.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 08:00:24 -0700 (PDT)
Date: Wed, 29 Oct 2025 08:00:22 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v5 4/4] net: add per-netns sysctl for devmem
 autorelease
Message-ID: <aQIsBlf4O7cyrXq8@devvm11784.nha0.facebook.com>
References: <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-0-47cb85f5259e@meta.com>
 <20251023-scratch-bobbyeshleman-devmem-tcp-token-upstream-v5-4-47cb85f5259e@meta.com>
 <CAHS8izP2KbEABi4P=1cTr+DGktfPWHTWhhxJ2ErOrRW_CATzEA@mail.gmail.com>
 <aQEyQVyRIchjkfFd@devvm11784.nha0.facebook.com>
 <CAHS8izPB6Fn+_Kn-6PWU19rNYOn_0=EngvXyg9Qu48s32Zs9gQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izPB6Fn+_Kn-6PWU19rNYOn_0=EngvXyg9Qu48s32Zs9gQ@mail.gmail.com>

On Tue, Oct 28, 2025 at 07:09:58PM -0700, Mina Almasry wrote:
> On Tue, Oct 28, 2025 at 2:14 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > On Mon, Oct 27, 2025 at 06:22:16PM -0700, Mina Almasry wrote:
> > > On Thu, Oct 23, 2025 at 2:00 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > [...]
> >
> > > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > > index 8f3199fe0f7b..9cd6d93676f9 100644
> > > > --- a/net/core/devmem.c
> > > > +++ b/net/core/devmem.c
> > > > @@ -331,7 +331,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> > > >                 goto err_free_chunks;
> > > >
> > > >         list_add(&binding->list, &priv->bindings);
> > > > -       binding->autorelease = true;
> > > > +       binding->autorelease = dev_net(dev)->core.sysctl_devmem_autorelease;
> > > >
> > >
> > > Do you need to READ_ONCE this and WRITE_ONCE the write site? Or is
> > > that silly for a u8? Maybe better be safe.
> >
> > Probably worth it to be safe.
> > >
> > > Could we not make this an optional netlink argument? I thought that
> > > was a bit nicer than a sysctl.
> > >
> > > Needs a doc update.
> > >
> > >
> > > -- Thanks, Mina
> >
> > Sounds good, I'll change to nl for the next rev. Thanks for the review!
> >
> 
> Sorry to pile the requests, but any chance we can have the kselftest
> improved to cover the default case and the autorelease=on case?
> 
No problem, I had the same thought.

> I'm thinking out loud here: if we make autorelease a property of the
> socket like I say in the other thread, does changing the value at
> runtime blow everything up. My thinking is that no, what's important
> is that the sk->devmem_info.autorelease **never** gets toggled for any
> active sockets, but as long as the value is constant, everything
> should work fine, yes?

I agree, autorelease can be toggled so long as the xarray is empty
and there are no outstanding urefs (to avoid sock_devmem_dontneed from
doing the wrong thing with the tokens).

Best,
Bobby

