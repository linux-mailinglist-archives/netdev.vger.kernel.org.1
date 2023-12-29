Return-Path: <netdev+bounces-60592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0391E8200C1
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 18:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63E86B20B28
	for <lists+netdev@lfdr.de>; Fri, 29 Dec 2023 17:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A66712B6B;
	Fri, 29 Dec 2023 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="fpJzBZ4P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-1909.mail.infomaniak.ch (smtp-1909.mail.infomaniak.ch [185.125.25.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D4D12B6E
	for <netdev@vger.kernel.org>; Fri, 29 Dec 2023 17:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
	by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T1sYR3wnczMq4Bk;
	Fri, 29 Dec 2023 17:19:07 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4T1sYQ2kMNzMpnPd;
	Fri, 29 Dec 2023 18:19:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1703870347;
	bh=zsh5RBd+5ocwtQhp5r8hMUfLyFAA3fFN3M6U7VcgUKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fpJzBZ4PJSC1FEN29pjgIE2CYGNjldVQLx8vqcuKGnnabOqut0xRUGTv9esKHRvQc
	 BZLYMRGdh83Bz+qQhUe4bBtulgxeYMNRpqsogw5YWtAKfFwzKtvhUddj6J00B9mLzL
	 vikXUOKAngkVhgNqiKS3cCBeN7mA5We73K+W4hv0=
Date: Fri, 29 Dec 2023 18:18:58 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Paul Moore <paul@paul-moore.com>
Cc: Eric Paris <eparis@parisplace.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Muhammad Usama Anjum <usama.anjum@collabora.com>, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] selinux: Fix error priority for bind with AF_UNSPEC on
 AF_INET6 socket
Message-ID: <20231229.Phaengue0aib@digikod.net>
References: <20231228113917.62089-1-mic@digikod.net>
 <CAHC9VhQMbHLYkhs-k9YEjeAFH7_JOk3RUKAa7jD7HP0NW1cBdA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhQMbHLYkhs-k9YEjeAFH7_JOk3RUKAa7jD7HP0NW1cBdA@mail.gmail.com>
X-Infomaniak-Routing: alpha

(Removing Alexey Kodanev because the related address is no longer
valid.)

On Thu, Dec 28, 2023 at 07:19:07PM -0500, Paul Moore wrote:
> On Thu, Dec 28, 2023 at 6:39 AM Mickaël Salaün <mic@digikod.net> wrote:
> >
> > The IPv6 network stack first checks the sockaddr length (-EINVAL error)
> > before checking the family (-EAFNOSUPPORT error).
> >
> > This was discovered thanks to commit a549d055a22e ("selftests/landlock:
> > Add network tests").
> >
> > Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
> > Cc: Eric Paris <eparis@parisplace.org>
> > Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> > Cc: Paul Moore <paul@paul-moore.com>
> > Cc: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Reported-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> > Closes: https://lore.kernel.org/r/0584f91c-537c-4188-9e4f-04f192565667@collabora.com
> > Fixes: 0f8db8cc73df ("selinux: add AF_UNSPEC and INADDR_ANY checks to selinux_socket_bind()")
> > Signed-off-by: Mickaël Salaün <mic@digikod.net>
> > ---
> >  security/selinux/hooks.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
> > index feda711c6b7b..9fc55973d765 100644
> > --- a/security/selinux/hooks.c
> > +++ b/security/selinux/hooks.c
> > @@ -4667,6 +4667,10 @@ static int selinux_socket_bind(struct socket *sock, struct sockaddr *address, in
> >                                 return -EINVAL;
> >                         addr4 = (struct sockaddr_in *)address;
> >                         if (family_sa == AF_UNSPEC) {
> > +                               if (sock->sk->__sk_common.skc_family ==
> > +                                           AF_INET6 &&
> > +                                   addrlen < SIN6_LEN_RFC2133)
> > +                                       return -EINVAL;
> 
> Please use sock->sk_family to simplify the conditional above, or
> better yet, use the local variable @family as it is set to the sock's
> address family near the top of selinux_socket_bind()

Correct, I'll send a v2 with that.

> ... although, as
> I'm looking at the existing code, is this patch necessary?
> 
> At the top of the AF_UNSPEC/AF_INET case there is an address length check:
> 
>   if (addrlen < sizeof(struct sockaddr_in))
>     return -EINVAL;

This code is correct but not enough in the case of an IPv6 socket.

> 
> ... which I believe should be performing the required sockaddr length
> check (and it is checking for IPv4 address lengths not IPv6 as in the
> patch).  I see that we have a similar check for AF_INET6, so we should
> be covered there as well.

The existing similar check (addrlen < SIN6_LEN_RFC2133) is when the
af_family is AF_INET6, but this patch adds a check for AF_UNSPEC on an
PF_INET6 socket. The IPv6 network stack first checks that the addrlen is
valid for an IPv6 address even if the requested af_family is AF_UNSPEC,
hence this patch.

> 
> I'm probably still in a bit of a holiday fog, can you help me see what
> I'm missing here?

The tricky part is that AF_UNSPEC can be checked against the PF_INET or
the PF_INET6 socket implementations, and the return error code may not
be the same according to addrlen, especially when
sizeof(struct sockaddr_in) < addrlen < SIN6_LEN_RFC2133

The (new) Landlock network tests check this kind of corner case to make
sure the same error codes are return with and without a Landlock
sandbox. Muhammad reported that some of these tests failed on KernelCI
and I found that, when SELinux is enabled (which is the case with the
defconfig), SElinux gets the request after Landlock and returns a wrong
error code (before the network stack can do anything).
See tools/testing/selftests/landlock/net_test.c +728
which checks with and without a Landlock sandbox.

I tested this patch with SELinux and Landlock enabled, and all the
Landlock tests pass.

I'm working on a more global approach to cover all LSMs, with more
checks and Landlock tests, but this will be more complex and then will
take more time to review.

