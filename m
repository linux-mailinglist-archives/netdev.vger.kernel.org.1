Return-Path: <netdev+bounces-113715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7999493FA40
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 18:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 238131F22E08
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 16:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74E6548F7;
	Mon, 29 Jul 2024 16:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pr3i31Ap"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4E481ACA
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 16:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722269147; cv=none; b=BlNCn1UjyMAdMj2SY11vatLPe5do+eS5uxq+dT4IRzgFHuKw09TwnX9UOfbplFz3H7vhKgDF2zpI0pApqNU+SRVMmaOkMERxXFEUJQl5tZlRpfN7gVUvl5AFjDbZ3mLphFx1Tn2mvzevPUpEMvaDZB0NAVuNtPAciHvo9s/YjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722269147; c=relaxed/simple;
	bh=MsOWdSBOx56ptdjoqaZXVz6kcxRdM5T/8IcA9Y1Dnko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPGUf4rqwnkS+ixNEozwij019//Buj9Z7E9dXqOJTF40UScUUKjWzD2HmfE3uTwN7IjgC10J0/jTdkSabizQlSVqs2ykkG6qfabxEBihoFgeyN7VzSf4wmq8P+n+FDY9bqcI7IyGN+cLfezLuplS6Y9nnH1YWAuA4t4RFWP6Zco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pr3i31Ap; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722269145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lVXhebfLKQ1qVAZhgnufBwBYTzf46N8GHu+5vhKidxE=;
	b=Pr3i31Apa5Nj4kQN5/X5X0nw56e6ltYMF2N82sIif70EWKdQZCc7tef3ZwL5Feini6I9CO
	7BZs4rIQRPAfgzSz9A/qfWoNV+feI21CwmKd0Mxdeb+sfGCcmtev0oVBaQu75/XpT2ipIY
	04hM2bqRC+lvcOpBt7j9WjdWE7c8dGk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-Vo0Ij2bJMi-MdUdcl_ol5w-1; Mon, 29 Jul 2024 12:05:43 -0400
X-MC-Unique: Vo0Ij2bJMi-MdUdcl_ol5w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4281ca9f4dbso10918375e9.0
        for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 09:05:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722269142; x=1722873942;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVXhebfLKQ1qVAZhgnufBwBYTzf46N8GHu+5vhKidxE=;
        b=U/ef3Q4yEGG/aZQ8p7yqjNilwhEN9sKaZzM0ydIyqSEMKpmYZgZZ3HQb7sU7uQjE9E
         6OisWUhY9JqcZ7OBUBOITdU12Iw++oVWKaJTnYIwou0zJFRj6LZNnMj6Rz+cfvDgPOd/
         +OZhUI50G+8cepd9EJ2HO8nazEK0rpNXvy6MrVu21OqQ38ISty+f6Q4nN2uDF+N8zIVU
         zKb27733qVijz4T3hQ53GIvrwEieHi7MzTgfr6yiashFPzRkJYC9DIktMRdHq+woA2yH
         mRX/ZX3grl2E57HW/eWFOmJNzuJubs11VqF5pJgxSzaIKepPks/t9WDUHgkqOgOnixOZ
         GiEg==
X-Gm-Message-State: AOJu0Yxq3/r/O7e+yJvdzf3pgshMmoNSz7w73UfXtO8fxG51q6IAv896
	YuWCGSI0WhdaZAvO7rsRLJl9MlP3sMoUW+2kCIuJDF5a6CByI2O8LixRRyHhPuYC7C4U0iCjDB9
	So6LcFDVBHuWapWALD+XvoXUoQt52R6UAVwOVDTkeOeuw0H93rX5CeA==
X-Received: by 2002:a05:600c:45cb:b0:426:6455:f124 with SMTP id 5b1f17b1804b1-42811aa99femr61919745e9.0.1722269142561;
        Mon, 29 Jul 2024 09:05:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqKbY2OIof3gK3KJKMX93Wm8kZD3yMiqyPvZH52DuqqXNIf98EwIa872LfC+4Tf/NlfLBwRQ==
X-Received: by 2002:a05:600c:45cb:b0:426:6455:f124 with SMTP id 5b1f17b1804b1-42811aa99femr61919365e9.0.1722269141783;
        Mon, 29 Jul 2024 09:05:41 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42819d9a007sm60564415e9.1.2024.07.29.09.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jul 2024 09:05:41 -0700 (PDT)
Date: Mon, 29 Jul 2024 18:05:38 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, dsahern@kernel.org, pablo@netfilter.org,
	kadlec@netfilter.org, fw@strlen.de
Subject: Re: [RFC PATCH net-next 3/3] ipv4: Centralize TOS matching
Message-ID: <Zqe90nCtknOUnDEG@debian>
References: <20240725131729.1729103-1-idosch@nvidia.com>
 <20240725131729.1729103-4-idosch@nvidia.com>
 <ZqOh24k4UQUqYLoN@debian>
 <ZqYsrgnWwdQb1zgp@shredder.mtl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqYsrgnWwdQb1zgp@shredder.mtl.com>

On Sun, Jul 28, 2024 at 02:34:06PM +0300, Ido Schimmel wrote:
> On Fri, Jul 26, 2024 at 03:17:15PM +0200, Guillaume Nault wrote:
> > On Thu, Jul 25, 2024 at 04:17:29PM +0300, Ido Schimmel wrote:
> > > diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
> > > index 72af2f223e59..967e4dc555fa 100644
> > > --- a/include/net/ip_fib.h
> > > +++ b/include/net/ip_fib.h
> > > @@ -22,6 +22,8 @@
> > >  #include <linux/percpu.h>
> > >  #include <linux/notifier.h>
> > >  #include <linux/refcount.h>
> > > +#include <linux/ip.h>
> > 
> > Why including linux/ip.h? That doesn't seem necessary for this change.
> 
> RT_TOS() is defined in linux/in_route.h as ((tos)&IPTOS_TOS_MASK), but
> IPTOS_TOS_MASK is defined in liunx/ip.h which is not included by
> linux/in_route.h for some reason.
> 
> This also works:
> 
> diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
> index 967e4dc555fa..269ec10f63e4 100644
> --- a/include/net/ip_fib.h
> +++ b/include/net/ip_fib.h
> @@ -22,7 +22,6 @@
>  #include <linux/percpu.h>
>  #include <linux/notifier.h>
>  #include <linux/refcount.h>
> -#include <linux/ip.h>
>  #include <linux/in_route.h>
>  
>  struct fib_config {
> diff --git a/include/uapi/linux/in_route.h b/include/uapi/linux/in_route.h
> index 0cc2c23b47f8..10bdd7e7107f 100644
> --- a/include/uapi/linux/in_route.h
> +++ b/include/uapi/linux/in_route.h
> @@ -2,6 +2,8 @@
>  #ifndef _LINUX_IN_ROUTE_H
>  #define _LINUX_IN_ROUTE_H
>  
> +#include <linux/ip.h>
> +

Thanks, I prefer this solution, which I find cleaner.


