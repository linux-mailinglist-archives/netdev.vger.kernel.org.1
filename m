Return-Path: <netdev+bounces-158483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FBCA121B1
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84061188D91D
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8190A248BB3;
	Wed, 15 Jan 2025 10:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDZxm91A"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441A01E9917
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 10:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736938757; cv=none; b=UTCwjEBZUS72XYqQcjtzpQ8LFWk5oFJHkXUBgAaoC43Bk7A00l6FLjMRvLY5uam8vGVGmaoJstJwaG6HHWbr/PD3YRrIpwg+DX7GBLiJeaZJ+rSvXpKfeQMJ7ayNDM/2Z5ZGBBFO4jbsu78EHaRhy3yHR2nYNmzIA9W2pfj0hx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736938757; c=relaxed/simple;
	bh=1L5g7uZV3oNPMMDbHi/WkRsmnXXmFq6thnnpoRB3bwY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9RptzEW6MU4nSU3sTbSy0MzcMMYf0Z0amqMjw0E3eu+OucbM0nh163bQCWwG8dU84/RWE2hT4Bv2+H0NBQCLXsvNcA1vyOv+eAvIjm7kxMiD8RvayV6RFQ6Vy4i8s/IA5xYASS8PowA/JCnBgZjnc+seTB7Du1yz8bgw/BcKfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDZxm91A; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736938753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QbByJcISCyT3fC9pXiBHiwEQSgme43hamBV6cVUPLrk=;
	b=YDZxm91Aqxt1wkPrtkSQVbzCu4raktNskPwYvaO27NzI3uX33k4hB//8zqTra8cSIVB4h0
	jvO+F2xYIvrSH+wXD04E7/ygS9cW9ZuH+zIeTImcg3qPSGz7qkqFDLsECfndO0byZ9bm2M
	2jiJPk8Leqkj9L/hEOno7jS5skiHQN8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-D6M3CyjyOxqqMme8QauNbQ-1; Wed, 15 Jan 2025 05:59:12 -0500
X-MC-Unique: D6M3CyjyOxqqMme8QauNbQ-1
X-Mimecast-MFC-AGG-ID: D6M3CyjyOxqqMme8QauNbQ
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-386321c8f4bso3951115f8f.0
        for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 02:59:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736938751; x=1737543551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QbByJcISCyT3fC9pXiBHiwEQSgme43hamBV6cVUPLrk=;
        b=Hs1AwLrI3POJdx5R8QLYZ6vC8pa43ag0sM775kOOxVn5SipksOSxBzCi7pffhMaqhp
         lfMbMtv4J4un82ZxHdWfcWzbkITvAxQ0YwLwkQtE83pBhS4XVBNa0zTqE+wn+KeMGN0Z
         rRGL+GXpI8d3P4/pO5P2fZerkWni637vLuVKD0Booeh416CPSmoy87uRsC6j3mQGnhwX
         SqlK28msp4ad8trFZi6NLfaGuhmGbknAoyJQuYHGSNdErXuEXgILeN8eeITri7JWnypf
         783gUBXkPLseuWr5xyhY4dRVGwQ2vMubMQSO/qisSvjb1SNdOPOKHR/7irklzxmoWwAw
         gn6w==
X-Forwarded-Encrypted: i=1; AJvYcCWv3rvVNgMgKvsl9zGICpJbrh2LMQvpIXurbcp8zDLeQ7Z+40g7gUY7T19jfa47M4d5LyUutDE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOMk1HuKQ2liE4J3HfqfCwo5SpexsuS4+uX1Kj9faHGu6ILMXP
	Wi3kHJOv0RSm+oYvNbWaEP0roleCj5p2LHheJAdXtZ/hWyUKS20mgp/S8h8Ryn4IhsCBa3gs9fs
	WKQQK2JGf4G9tvxH9xbfB+aDcK+I9s/MFctAV2XRIhjWFeSiR1lHV3w==
X-Gm-Gg: ASbGncu7+6KcmnESCERWGX1ULOKuqgY7FZWC+kh0Tzv7hbf9ZynMsLjX8LmlMxGcnoT
	vueQGUuOHbyq/HcSgVgG6k8RhN1uK3sGUItMxd5WShT/iyqoFaUA/gjKwFbL1phmJYW6k5DTiuq
	RbuoFm1/4+PCiKIKqbNZ3fgPj0A8xGSbe6cGuDtiZV3EivwEFvCJlQDO2e4aUhfuUXXGNnhxvYC
	I4VmpJe7Eg61mNIgjn3TvKfxPif9RCAtLSVAZp0v8xzkWUSwGdVtjlekDhaHjy9JIWi8ndWYMH7
	Qq7zCq8mGgs1Alj+nvmSIJUkDxCu7oCzmk4j
X-Received: by 2002:a5d:6d84:0:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-38a873140f6mr26504739f8f.33.1736938751481;
        Wed, 15 Jan 2025 02:59:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGccZg+xBu7CT3IyZv6Oe0eoWWo34AocLpH2jsg3GCptJ6+7fI5s+auUVv+j1TnhJREef9Zhw==
X-Received: by 2002:a5d:6d84:0:b0:385:ecdf:a30a with SMTP id ffacd0b85a97d-38a873140f6mr26504713f8f.33.1736938751147;
        Wed, 15 Jan 2025 02:59:11 -0800 (PST)
Received: from debian (2a01cb058d23d6009e7a50f94171b2f9.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9e7a:50f9:4171:b2f9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e38efeesm17627421f8f.62.2025.01.15.02.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 02:59:10 -0800 (PST)
Date: Wed, 15 Jan 2025 11:59:08 +0100
From: Guillaume Nault <gnault@redhat.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	osmocom-net-gprs@lists.osmocom.org
Subject: Re: [PATCH net-next] gtp: Prepare ip4_route_output_gtp() to
 .flowi4_tos conversion.
Message-ID: <Z4eU/DLLTCcdtUXJ@debian>
References: <bcb279c6946a5f584bc9adbe90b05f6b1997fde0.1736871011.git.gnault@redhat.com>
 <Z4d7FqLVGI4oUh3s@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4d7FqLVGI4oUh3s@shredder>

On Wed, Jan 15, 2025 at 11:08:38AM +0200, Ido Schimmel wrote:
> On Tue, Jan 14, 2025 at 05:12:12PM +0100, Guillaume Nault wrote:
> > Use inet_sk_dscp() to get the socket DSCP value as dscp_t, instead of
> > ip_sock_rt_tos() which returns a __u8. This will ease the conversion
> > of fl4->flowi4_tos to dscp_t, as it will just require to drop the
> > inet_dscp_to_dsfield() call.
> > 
> > Signed-off-by: Guillaume Nault <gnault@redhat.com>
> > ---
> >  drivers/net/gtp.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
> > index 89a996ad8cd0..03d886014f5a 100644
> > --- a/drivers/net/gtp.c
> > +++ b/drivers/net/gtp.c
> > @@ -23,6 +23,8 @@
> >  
> >  #include <net/net_namespace.h>
> >  #include <net/protocol.h>
> > +#include <net/inet_dscp.h>
> > +#include <net/inet_sock.h>
> >  #include <net/ip.h>
> >  #include <net/ipv6.h>
> >  #include <net/udp.h>
> > @@ -350,7 +352,7 @@ static struct rtable *ip4_route_output_gtp(struct flowi4 *fl4,
> >  	fl4->flowi4_oif		= sk->sk_bound_dev_if;
> >  	fl4->daddr		= daddr;
> >  	fl4->saddr		= saddr;
> > -	fl4->flowi4_tos		= ip_sock_rt_tos(sk);
> > +	fl4->flowi4_tos		= inet_dscp_to_dsfield(inet_sk_dscp(inet_sk((sk))));
> 
> There seems to be an unnecessary pair of parenthesis here like in the
> other patch. I assume you will take care of that in v2?

Yes, I'll send a v2 tomorrow for both the gtp and dccp patches.


> >  	fl4->flowi4_scope	= ip_sock_rt_scope(sk);
> >  	fl4->flowi4_proto	= sk->sk_protocol;
> >  
> > -- 
> > 2.39.2
> > 
> 


