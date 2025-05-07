Return-Path: <netdev+bounces-188768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E14AAE91C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 20:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 898B84E6D8B
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2C128DF5B;
	Wed,  7 May 2025 18:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="U1Cj1AO+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-1908.mail.infomaniak.ch (smtp-1908.mail.infomaniak.ch [185.125.25.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540EA28BA92
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746642867; cv=none; b=mPqEZ+DsgKHQeh9WgjnVOs25mDiNAnSLe76jFXM1Y2cRiRu0E3VqHwcj8vIhkJapRGdMAvbJE4LJOptCif3F6r9y3LGbSEXA8DvhfpFpEcUB1Oi6QlMolDmh7n11GW2C207s1+YXs1hzp9j474aMSc57R5BNlgXtMRGC+xubjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746642867; c=relaxed/simple;
	bh=NBToG/AciZDbMvzA31ccgEUcWNBjM7xnKTulT/6/qgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kBTI2915EFc3/slYnU74L9g2dDgAE9Bnp5s5vTwluuzWNWaYdaJTs28M2fWOfO8YS43KgCKeFzO5JnJEUeqYIheQrW+pdatFvCOs6rAG1fLPIdEXDY72od2pYxu86Rr14qVSBHpCaYrb4N5r5R5fATQbOy6rAoNZXAFdTKFU8PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=U1Cj1AO+; arc=none smtp.client-ip=185.125.25.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Zt3nh438nzwky;
	Wed,  7 May 2025 20:34:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1746642856;
	bh=UDOvGdA2DhLPcDKhb29sc57SUIgsv1FWMsjXSpnI7XE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U1Cj1AO+93w4KYltrM6aHLMINy5LaUdgfB//HeUnT3hEmubw5QoFEnTj9i3RkwfPy
	 8jB7fb6hGaDg3EK5XiJPaXts8zDsNppvOo3tNBVDLJLF89g+F6JMT3Ru6v0sm0bMUZ
	 7/w6GLxVFHw6OEO8u1crVk19ZPF2ObnavFbq8IlY=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Zt3nf2JBczTnN;
	Wed,  7 May 2025 20:34:14 +0200 (CEST)
Date: Wed, 7 May 2025 20:34:13 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>, linux-fsdevel@vger.kernel.org, 
	Jann Horn <jannh@google.com>, Eric Dumazet <edumazet@google.com>, 
	Oleg Nesterov <oleg@redhat.com>, "David S. Miller" <davem@davemloft.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	David Rheinsberg <david@readahead.eu>, Jakub Kicinski <kuba@kernel.org>, Jan Kara <jack@suse.cz>, 
	Lennart Poettering <lennart@poettering.net>, Luca Boccassi <bluca@debian.org>, Mike Yuan <me@yhndnzj.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v4 09/11] pidfs, coredump: allow to verify coredump
 connection
Message-ID: <20250507.uS1oa0shi0eu@digikod.net>
References: <20250507-work-coredump-socket-v4-0-af0ef317b2d0@kernel.org>
 <20250507-work-coredump-socket-v4-9-af0ef317b2d0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250507-work-coredump-socket-v4-9-af0ef317b2d0@kernel.org>
X-Infomaniak-Routing: alpha

On Wed, May 07, 2025 at 06:13:42PM +0200, Christian Brauner wrote:
> When a coredump connection is initiated use the socket cookie as the
> coredump cookie and store it in the pidfd. The receiver can now easily
> authenticate that the connection is coming from the kernel.
> 
> Unless the coredump server expects to handle connection from
> non-crashing task it can validate that the connection has been made from
> a crashing task:
> 
>    fd_coredump = accept4(fd_socket, NULL, NULL, SOCK_CLOEXEC);
>    getsockopt(fd_coredump, SOL_SOCKET, SO_PEERPIDFD, &fd_peer_pidfd, &fd_peer_pidfd_len);
> 
>    struct pidfd_info info = {
>            info.mask = PIDFD_INFO_EXIT | PIDFD_INFO_COREDUMP,
>    };
> 
>    ioctl(pidfd, PIDFD_GET_INFO, &info);
>    /* Refuse connections that aren't from a crashing task. */
>    if (!(info.mask & PIDFD_INFO_COREDUMP) || !(info.coredump_mask & PIDFD_COREDUMPED) )
>            close(fd_coredump);
> 
>    /*
>     * Make sure that the coredump cookie matches the connection cookie.
>     * If they don't it's not the coredump connection from the kernel.
>     * We'll get another connection request in a bit.
>     */
>    getsocketop(fd_coredump, SOL_SOCKET, SO_COOKIE, &peer_cookie, &peer_cookie_len);
>    if (!info.coredump_cookie || (info.coredump_cookie != peer_cookie))
>            close(fd_coredump);
> 
> The kernel guarantees that by the time the connection is made the
> coredump info is available.

Nice approach to tie the coredump socket with the coredumped pidfd!
This indeed removes previous race condition.

I guess a socket's cookie is never zero?

