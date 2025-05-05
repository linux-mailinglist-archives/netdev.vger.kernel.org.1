Return-Path: <netdev+bounces-187776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FC6AA99A6
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 18:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DEFE17D73E
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D3926A083;
	Mon,  5 May 2025 16:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IdhvAZRG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C146B1A255C
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 16:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746463708; cv=none; b=gaUh7uRPGltR4nRSO5KjEI6GIz7+iTtpC4mGwww+UFdsfvuiJxV6/dMyKfh5hmutTTRzaVi9Q6br6mj/jlloBIJULvStiXHL+U71ebpNDX2FMQSVr2++K7plSENNsR8Rhjo8Y+s5YbXsNeNMWtzHX64FSp3Xb9nJO7jCw1SZ9N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746463708; c=relaxed/simple;
	bh=Dnn16LNkkCICXme+9DoZUxLUZqWokxT4o0BVlzmiQcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LIjNHL5IACGw9RAfbPBuV7Ay9bm0JgUZbiqMHDED7Sjw8FFjqNgsYxRohCToQ6qMjmsBGlXTwrck4nnLSFjA8/3bAo6/d2D1W71gs4K+OnW1KV2tua6lKTA5fylN7y4gdf5vrjKA+ivTWsAxCx3iToE6j4O+v6V8PeO+7FqqyY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IdhvAZRG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=bl1u2pXrYd36ihH4EhwJyN2TU38SMRjTCsNDCK8PNlc=; b=IdhvAZRGZXRNPdDYinJYJ15qqw
	0Vv+gJRMkOMZ5iTWky4Wwodei/e92DKz4q0NFLKPM1JhpUKwpqpd8vrIQF42hfgZ9ShBy6Z0ydajg
	aDKV2knP+498kfJyRk8QnJ60ZXYPaFnuyYwIS+D2IZ0DML59a6Ep509k5ydW7Da296rk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uByzN-00BcGl-PZ; Mon, 05 May 2025 18:48:21 +0200
Date: Mon, 5 May 2025 18:48:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next v8 01/15] net: homa: define user-visible API for
 Homa
Message-ID: <56dfa989-92b9-42c6-afbd-c5eefcca42cf@lunn.ch>
References: <20250502233729.64220-1-ouster@cs.stanford.edu>
 <20250502233729.64220-2-ouster@cs.stanford.edu>
 <938931dc-2157-44c8-b192-f6737b69f317@redhat.com>
 <CAGXJAmzqj3V=gubPBAH=zpNmHnW7g2Wk8mQ8=4wGhcJ9AsYb_g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXJAmzqj3V=gubPBAH=zpNmHnW7g2Wk8mQ8=4wGhcJ9AsYb_g@mail.gmail.com>

> > > +int     homa_send(int sockfd, const void *message_buf,
> > > +               size_t length, const struct sockaddr *dest_addr,
> > > +               __u32 addrlen,  __u64 *id, __u64 completion_cookie,
> > > +               int flags);
> > > +int     homa_sendv(int sockfd, const struct iovec *iov,
> > > +                int iovcnt, const struct sockaddr *dest_addr,
> > > +                __u32 addrlen,  __u64 *id, __u64 completion_cookie,
> > > +                int flags);
> > > +ssize_t homa_reply(int sockfd, const void *message_buf,
> > > +                size_t length, const struct sockaddr *dest_addr,
> > > +                __u32 addrlen,  __u64 id);
> > > +ssize_t homa_replyv(int sockfd, const struct iovec *iov,
> > > +                 int iovcnt, const struct sockaddr *dest_addr,
> > > +                 __u32 addrlen,  __u64 id);
> >
> > I assume the above are user-space functions definition ??? If so, they
> > don't belong here.
> 
> Yes, these are declarations for user-space functions that wrap the
> sendmsg and recvmsg kernel calls. If not here, where should they go?
> Are you suggesting a second header file (suggestions for what it
> should be called?)? These are very thin wrappers, which I expect
> people will almost always use instead of invoking raw sendmsg and
> recvmsg, so I thought it would be cleanest to put them here, next to
> other info related to the Homa kernel calls.

Maybe put the whole library into tools/lib/homa.

      Andrew

