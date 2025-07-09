Return-Path: <netdev+bounces-205445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1C1AFEBC8
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 16:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3135616466F
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 14:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FCA22DC330;
	Wed,  9 Jul 2025 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBC825Gc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7883E2C3257
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752070531; cv=none; b=j8kR6NH2Z+J0d0mpdt7PQ0ouIUTc+SgI3+T/yFq/S2ecETnXxrgCl5EtIYqgunZh9I985PFGr9YHMLhwN8Tzym+iocFFGQI71VJIo4Kug8n9LTAKYzjoXSWj9MOei6TfLQmdwFgArXmElzlBq3GfKxA5W3FLTXFaxSungXd0eQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752070531; c=relaxed/simple;
	bh=kGkLKLbgp14TcmwsTFjLVyoBFEDP7o9mP/o6UPbzpcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9dK8oDTraj0ntQuZdCKrXyIXFcbP77KjdaGh0GvMbfPJ1oRvqq6x7jjYg/bhIunUrTENWYKxDIrcM8nBNQ3POu37ki27enx+Izm7cPNBSwPhhcWvacuwdCDHyeK7gz4tLt/n8VzbUgf3+R2uHXhEgNXnYXcSyBhw8c9X5UV5U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UBC825Gc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752070528;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ky/7x6DvH9EhPAV3HjIH0no4xaouHgpeQ8/ySQ2r2rU=;
	b=UBC825GcsgJ0b4yqBrExlsePqqKkPfpffvpbdmsMqh9+lkNsnUzlndTQbGcL69w8uwPesk
	BmMDA7sCtXuENDpj6Z46d9T/H6ndyQHpCy3K68BKtHLbkf5Chywfho0/JBRO2VPRy7G02e
	XBIfEqnihIzGjQ0SqS+DxujWZH8z+Dc=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-mCNevlZZNlWRKmuIS0yATw-1; Wed, 09 Jul 2025 10:15:26 -0400
X-MC-Unique: mCNevlZZNlWRKmuIS0yATw-1
X-Mimecast-MFC-AGG-ID: mCNevlZZNlWRKmuIS0yATw_1752070526
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f7f1b932so3723127f8f.2
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 07:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752070525; x=1752675325;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ky/7x6DvH9EhPAV3HjIH0no4xaouHgpeQ8/ySQ2r2rU=;
        b=ZcsxydY+T7GjH43eZbWNmqEngeP9qLHYGD0f4ALRkqBUxFiEsCDTeRuv2J5nhc+Z6C
         PoiBdFDSGv5l6r7jcsLvbDjH682y2v7sBEKRvt4cqlkUkaJEqLZdtLyQQKewdFJdxQ27
         kvSqBImKyZUWJmIT39XfLGYrXQXlWs20cUPRw4rhtKhzZztzPiYuO47dNPEbNRQk/537
         ua+InXGSiepgpckSyPcBwTNar9Ml9X+YWElIYeqFqZC4lapLe5A4lP00hkMNgptWi4CX
         OiJ2yuMCgUvhCniyQE5SRWnA07vWBVBe3TZ/H0iozZ8dXEGR7Ms1U+EYRCqXk9iZVtQD
         iQ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV9OVKTysuHls6v3stn3HTIGkWuQbIxIz9ymXTyGR33mtWkKknkuKNkQM4NkE08SFsQp6s+KwY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/nuB00upAPU325VAh3BfYVt008qmJb7LyPbJ+BfYrmJRIXkVd
	0VaD5YGkXq0Damo2z1S0XVThZhg44LB9dWCTyC6vV4TrLwVioflPGxSqj3V07u6DYsgB7SzH17o
	GGB38ZUBxYrwq79N3mca2dRKxO2Ov8cnB3qgbukesUAPgyDr5+7zkGeANww==
X-Gm-Gg: ASbGncsCPDZk8c3GCxO+SIburfE7ELetho00jHfHlClwOgXIeixSCKZ6KXPGNKIJdfK
	jjv4rsyovZGtRF5wolkXkZX94I5VXUFP7KrkYaxhmENQyaC7X6ZqE1pxl1CyvVTSrMmdqdhNLj7
	jA36ekfuIOIbJmIOjCfAwPLWiggqAnxCl/nOaE4xlz/jJnvT4MLmubhxiri5JXeZRx7mkXoTpf2
	0wOmBaIQhb/F5HXEitlw8uXUrka6mnFlpRM7gG01geSo2OumOd5isuCMUlwYriCNf999p6n3jTl
	TCHIQxf2Sg==
X-Received: by 2002:a05:6000:2313:b0:3a4:fbd9:58e6 with SMTP id ffacd0b85a97d-3b5e4530f28mr2348269f8f.50.1752070525539;
        Wed, 09 Jul 2025 07:15:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHJ9guzGEu6LsDd3s8dzvUQCpYjaNvz1LiX+hCFrH/tfoZaINYGrF+3wLoBFP8RviUuzjVig==
X-Received: by 2002:a05:6000:2313:b0:3a4:fbd9:58e6 with SMTP id ffacd0b85a97d-3b5e4530f28mr2348225f8f.50.1752070525032;
        Wed, 09 Jul 2025 07:15:25 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454d5050794sm24762395e9.13.2025.07.09.07.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 07:15:24 -0700 (PDT)
Date: Wed, 9 Jul 2025 16:15:21 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Gary Guo <gary@kernel.org>
Cc: davem@davemloft.net, idosch@idosch.org, kuba@kernel.org,
	ling@moedove.com, netdev@vger.kernel.org, noc@moedove.com,
	pabeni@redhat.com, Gary Guo <gary@garyguo.net>
Subject: Re: [BUG] net: gre: IPv6 link-local multicast is silently dropped
 (Regression)
Message-ID: <aG55eUOdypOWYY2d@debian>
References: <aGUGBjVZZPBWcRlA@debian>
 <20250706154030.3010068-1-gary@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706154030.3010068-1-gary@kernel.org>

On Sun, Jul 06, 2025 at 04:40:30PM +0100, Gary Guo wrote:
> On Wed, 2 Jul 2025 12:12:22 +0200, Guillaume Nault wrote:
> > Aiden, can you confirm that the following patch fixes the issue on your
> > side?
> 
> Not Aiden, but I get hit with the same regression after updating kernel on my
> router from v6.12.28 to v6.12.35 today. Symptom for me is bird complaining
> about "Socket error: Network is unreachable", and strace shows that it's sending
> packets to ff02::1:6 and get hit with ENETUNREACH.
> 
> I can confirm that applying this patch on top of v6.12.35 fixes the issue for me.
> I also took a look of the code, not a net expert, but this approach does look
> like a proper fix to me.

Thanks Gary, it's good to have such feedback.
I'm going to formally send the patch soon.

> Reviewed-by: Gary Guo <gary@garyguo.net>
> Tested-by: Gary Guo <gary@garyguo.net>
> 
> > 
> > ---- >8 ----
> > 
> > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> > index ba2ec7c870cc..870a0bd6c2ba 100644
> > --- a/net/ipv6/addrconf.c
> > +++ b/net/ipv6/addrconf.c
> > @@ -3525,11 +3525,9 @@ static void addrconf_gre_config(struct net_device *dev)
> >  
> >  	ASSERT_RTNL();
> >  
> > -	idev = ipv6_find_idev(dev);
> > -	if (IS_ERR(idev)) {
> > -		pr_debug("%s: add_dev failed\n", __func__);
> > +	idev = addrconf_add_dev(dev);
> > +	if (IS_ERR(idev))
> >  		return;
> > -	}
> >  
> >  	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
> >  	 * unless we have an IPv4 GRE device not bound to an IP address and
> > @@ -3543,9 +3541,6 @@ static void addrconf_gre_config(struct net_device *dev)
> >  	}
> >  
> >  	add_v4_addrs(idev);
> > -
> > -	if (dev->flags & IFF_POINTOPOINT)
> > -		addrconf_add_mroute(dev);
> >  }
> >  #endif
> 


