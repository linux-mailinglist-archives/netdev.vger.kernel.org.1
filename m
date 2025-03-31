Return-Path: <netdev+bounces-178431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB551A77004
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 23:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8241188AA3C
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 21:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333FE210F5D;
	Mon, 31 Mar 2025 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iuR1lnpL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE00414601C
	for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 21:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743456005; cv=none; b=kJrb0hUrmOtFQGnoKheu5xr61WHVT1u5zPiKruhsvOcq5Tt0DhKNkuSsdJ8mQ144OnD4k3Ri02n3vZRsSM9vVub8pz2U1LfpBz5lV36qkA7KwujggNmuKbCkPNwcLTnhh26srZn2/z5v6vGKc0rr1gl3Q1PXInyJOKeH77xsIh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743456005; c=relaxed/simple;
	bh=N5mIgxJf8B5ihSDqYrngLgxMfPNsqf1epb9ewWylxRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V04OvWBUskB3FcmYvADuAjoCV+44u9RKq1c88JjDuviG0qOZ8n6GAW8bKevZ9SqyOAUbWEtRQF6xZUmHBCt4D1HyYGoNRRhTJwP0jPzJGZz0E+ddmXV5Xj91G6TKl9W2g1//DRpJnNQwVa6PwDW1vsrtvXCve2pBYMLpjxj2dF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iuR1lnpL; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22401f4d35aso94730165ad.2
        for <netdev@vger.kernel.org>; Mon, 31 Mar 2025 14:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743456003; x=1744060803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5ySsbroBBjgBpvMStqh1ru1s+YtkjgCRMYoW0RRXayE=;
        b=iuR1lnpLoNd5mHydclQyoIgmU98iwTP9zKAqLqaC8HCDqAOB/+O8ppmnHSctfyYiUS
         xmV+2y08OuDdyGNqnjiT8BQjz+pQvgdzB9XuhawdBYnEC8XV8Zi0lhpxa9FnSgSUzaqE
         7+RZcXjHjJKbhH69NCdhMZQ82ZTgg7wkXZ3rytVwlZesmKkxEBQLAbcXCnJ78lQWc9w0
         ccaMuc4n26HLjl0qEd7e/BUeUA9V6PhrKdrmz4BGj/zGqkzNw+8+8/KycYlrg80xyizl
         UhGNDcs5sNgrXkj1WQxm95W/aBPNKq4Wldh2qlp/v0uo7Tp2jaxTBbAF+s/PKXhASbwk
         rKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743456003; x=1744060803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5ySsbroBBjgBpvMStqh1ru1s+YtkjgCRMYoW0RRXayE=;
        b=pl+1y09fvMavaqFM29YoLwQ68ZBkak8DvXNfttEGCT+RBRzpET6HguiFo3gVkmUPRW
         h0QIZXPlIFLaDUHbHXqynn150Qr4ABvVtVxykYTOy/3b/m+8KfvYONz3xcbJeHiTwuq5
         iliP4BvLx2Ytt5YcPQyLknQSvZn+FGzguK9cXpxrYDLEa8OYfmfAgMqL1LSzRPGTaEbU
         9CzYlX82OK6UJwQ5auePR9gyKSSOC/43T9uLIQ9V8G3HQffUUs7Ls+mjs0R3YJ4YDMw2
         CFvGGABh4i0PqBJLAw0CBlx1iPBew+XhC6sYNRKsuiUYooWqpjho7uh9HqoySCyp+DAw
         4Tog==
X-Forwarded-Encrypted: i=1; AJvYcCUbBj5YaaOywep7/ztMWoW8nI45wFRKFcDbiA27lr9UHceUn6hmDkBOhebz7y1/gcVaqg3d8XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyenrkgU/udPoO9chJz5Ir2Og0e+sQjcte8sciIDYxYBrUiMi4n
	EWuEeHjb939qyoTvXDU8TN0sK1fcqtSMob1CoFrrTJ6ZDj49LmU=
X-Gm-Gg: ASbGnctjW46mlnpD2KkgZJk8HngNKgkHXJGfkCezdEodI1LJzVwskQ3P/9XfenfuSlJ
	dw8wg9VEpGXrJwkz/4+CvXlgiPtSAbLVlzHx2nVAN0EGSHCM6LFp/zpntGgN56YB1KiSZUs4ygW
	3zLEvSvoNTScWgxxBajfhCWHNvvvJ+RkHR4bNUQAoVNbK+rb7Uq/VK3QP8BEE7pRQD32hZaFDBi
	8/U0mxmrHezZbCfIYizIKQBjYKCY6FJw1iYxTuWsu4uRHJEak4sx1jj1tEp+ax6gGtOAGeOzP+W
	4NUQrYDnZzIjMoDv6d54h6C9SfJgXkclmVnLfRc/sj4H
X-Google-Smtp-Source: AGHT+IGGR8WEpyGMHkTo8Ykzxi3I8bxyRlVfx+jaIv7tgYXsutCZZ+5E46pVuwjK9+dNR0jqIS61XQ==
X-Received: by 2002:a17:902:f70f:b0:224:1d1c:8837 with SMTP id d9443c01a7336-2292f95f2bamr184372405ad.19.1743456002941;
        Mon, 31 Mar 2025 14:20:02 -0700 (PDT)
Received: from localhost ([2601:646:9e00:f56e:123b:cea3:439a:b3e3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2291f1ded84sm74069675ad.170.2025.03.31.14.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 14:20:02 -0700 (PDT)
Date: Mon, 31 Mar 2025 14:20:01 -0700
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com
Subject: Re: [PATCH net v4 05/11] netdevsim: add dummy device notifiers
Message-ID: <Z-sHAbqPcmPQv8Nj@mini-arch>
References: <20250331150603.1906635-1-sdf@fomichev.me>
 <20250331150603.1906635-6-sdf@fomichev.me>
 <20250331135421.018c49db@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250331135421.018c49db@kernel.org>

On 03/31, Jakub Kicinski wrote:
> On Mon, 31 Mar 2025 08:05:57 -0700 Stanislav Fomichev wrote:
> > +#if IS_ENABLED(CONFIG_DEBUG_NET)
> > +int netdev_debug_event(struct notifier_block *nb, unsigned long event,
> > +		       void *ptr);
> > +#else
> > +static inline int netdev_debug_event(struct notifier_block *nb,
> > +				     unsigned long event, void *ptr)
> > +{
> > +	return 0;
> > +}
> > +#endif
> 
> Maybe we can wrap the while notifier setup in
> 
> 	if (IS_ENABLED(CONFIG_DEBUG_NET)) {
> 
> instead? We don't expect more users of the event callback, and it may
> be useful to give readers of the netdevsim code a hint that this
> callback will only do something when DEBUG_NET=y

Will do. I'm not sure if (IS_ENABLED()) will compile, will double-check;
worst case will wrap into #ifdef
 
> >  #endif
> > diff --git a/net/core/lock_debug.c b/net/core/lock_debug.c
> > index 7ecd28cc1c22..506899164f31 100644
> > --- a/net/core/lock_debug.c
> > +++ b/net/core/lock_debug.c
> 
> > @@ -66,6 +69,7 @@ static int rtnl_net_debug_event(struct notifier_block *nb,
> >  
> >  	return NOTIFY_DONE;
> >  }
> > +EXPORT_SYMBOL_GPL(netdev_debug_event);
> 
> EXPORT_SYMBOL_NS_GPL(netdev_debug_event, "NETDEV_INTERNAL");

Ah, good, and it's already imported by netdevsim. I was toying with making
this export dependent on netdevsim=ym...

