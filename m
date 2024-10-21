Return-Path: <netdev+bounces-137413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCFD9A6161
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 12:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 198F71F23928
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 10:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2441E47BA;
	Mon, 21 Oct 2024 10:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="G4O7qF5J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8BE1E3DFC
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 10:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729505090; cv=none; b=qPquLQmZX+qFQmJzF0X2jI16lTO//IOpthBU6t1iRgiP3oe+LBNCP4yJJmx0zEaq1OBLctmU1Bpjrk7e9CMhrZpIQH45M67pSWftVq33pwUijwgMrx6te+tmzt8DKRMrKegdvVgWbx4CVQsSt29dwiEU5Q9bfAt1M/y7Z6Tr2q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729505090; c=relaxed/simple;
	bh=EVL4wUmYrTJEyHGsQ/62BPsBtlNsOUVSRfFQ61ReZ6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G68fEWQee7oVSBRPGkgbdznL/510FoSe+Fzyojqcm3k1Y2Kfg6A8wi0yATI8k3ppz8ZY21CjoiIMJWHRe/liHTnnrX6B1ex2PtHmd4PJAqc7qP4GNFexkdhPAra0rHEfCvgbqrGULvdYi/E4/FIk71ywMESKs/p7BtIMcOrqch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=G4O7qF5J; arc=none smtp.client-ip=45.157.188.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246c])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XX9jH57xszXs9;
	Mon, 21 Oct 2024 11:57:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1729504675;
	bh=oQqDcNvi3dV/GKQZTqzoU9Gy+j6RUcYEDosffosB1cE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G4O7qF5Jlq8MVI5T7TPwo0OXw/iZ+oNwBlrtKbywh/q/ICD+2YW2GyClZm/L4XJFD
	 JirGE6PckwP2NdFR8Wh4hcrBRrMwUqn2ESk2UpSyHYxxB2zcRTl6D1AmdJR5j4L5Zm
	 4GNjbCAHym9OHgf4mKwFXzNhtpdBpc3CyQhu/4Qk=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XX9jG0KMHzcSf;
	Mon, 21 Oct 2024 11:57:53 +0200 (CEST)
Date: Mon, 21 Oct 2024 11:57:53 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Subject: Re: [RFC PATCH v1 4/7] landlock: Add UDP send+recv access control
Message-ID: <20241021.Abohbuph8eet@digikod.net>
References: <20240916122230.114800-1-matthieu@buffet.re>
 <20240916122230.114800-5-matthieu@buffet.re>
 <20240921.ohCheQuoh1eu@digikod.net>
 <3631edfd-7f41-4ff1-9f30-20dcaa17b726@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3631edfd-7f41-4ff1-9f30-20dcaa17b726@buffet.re>
X-Infomaniak-Routing: alpha

On Sat, Oct 19, 2024 at 02:47:48PM +0200, Matthieu Buffet wrote:
> Hi Mickaël,
> 
> I've almost finished merging your review (thanks for all the feedback), with
> the exception of this main point. Just making sure we agree on the
> limitations before I merge this into a new version.
> 
> On 9/21/2024 12:23 PM, Mickaël Salaün wrote:
> >> +	/*
> >> +	 * If there is a more specific address in the message, it will take
> >> +	 * precedence over any connect()ed address. Base our access check on
> it.
> >> +	 */
> >> +	if (address) {
> >> +		const bool in_udpv6_sendmsg =
> >> +			(sock->sk->sk_prot == &udpv6_prot);
> >> +
> >> +		err = get_addr_port(address, msg->msg_namelen, in_udpv6_sendmsg,
> >> +				    &port);
> >> +		if (err != 0)
> >> +			return err;
> >> +
> >> +		/*
> >> +		 * In `udpv6_sendmsg`, AF_UNSPEC is interpreted as "no address".
> >> +		 * In that case, the call above will succeed but without
> >> +		 * returning a port.
> >> +		 */
> >> +		if (in_udpv6_sendmsg && address->sa_family == AF_UNSPEC)
> >> +			address = NULL;
> >> +	}
> >> +
> >> +	/*
> >> +	 * Without a message-specific destination address, the socket must be
> >> +	 * connect()ed to an address, base our access check on that one.
> >> +	 */
> >> +	if (!address) {
> >
> > If the address is not specified, I think we should just allow the
> > request and let the network stack handle the rest.  The advantage of
> > this approach would be that if the socket was previously allowed to be
> > connected, the check is only done once and they will be almost no
> > performance impact when calling sendto/write/recvfrom/read on this
> > "connected" socket.
> > [...]
> > What about something like this (with the appropriate comments)?
> >
> > if (!address)
> > 	return 0;
> >
> > if (address->sa_family == AF_UNSPEC && sock->sk->sk_prot ==
> >     &udpv6_prot)
> > 	return 0;
> >
> > err = get_addr_port(address, msg->msg_namelen, &port);
> > if (err)
> > 	return err;
> >
> > return check_access_port(dom, LANDLOCK_ACCESS_NET_SENDMSG_UDP, port);
> 
> If I understand correctly, you would like the semantics of
> LANDLOCK_ACCESS_NET_CONNECT_UDP to be {connect(), and sendmsg() without
> explicit address} and LANDLOCK_ACCESS_NET_SENDMSG_UDP to be {sendmsg() with
> explicit address}.

Not exactly, here is the rewording with my thinking:
...the semantics of LANDLOCK_ACCESS_NET_CONNECT_UDP to be {connect()}
and LANDLOCK_ACCESS_NET_SENDMSG_UDP to be {sendmsg() with explicit
address}.

sendmsg() without explicit address should always be allowed,
whatever the Landlock policy (similarly as write(2) on a write-opened
file descriptor).  In a nutshell, sendmsg(2) without explicit address
should be handled the same as a write(2) call on a connected socket (I
guess the kernel handles such action on connected datagram sockets the
same as on connected stream sockets).

I think it is more important to first have a simple model that
enables developers to initialize a socket with connect(2) and then
sandbox the process to only be able to use this socket to communicate
with the configured peer, similar to what can be enforced with TCP
sockets.

sendmsg(2) can do two different thinks: (optionally) configure a
peer/port and write data. recvmsg(2) only reads data.  We should first
start by controlling exchange from/to peers, and maybe later controlling
data flow.

An alternative approach would be to not add a sendmsg specific access
right but only LANDLOCK_ACCESS_NET_CONNECT_UDP because connect should
be a superset of sendmsg.  This would make it impossible to specifically
deny (shared) socket's configuration change though.  I think it's
better to stick to the kernel semantic with 3 dedicated access rights,
and it should make more sense for users too.  What do you think?


> This makes it impossible to allow a landlocked server to
> connect() in order to receive traffic only from a specific client while at
> the same time preventing it from sending traffic (that is, a receive-only
> client-specific socket ala Cloudflare's "established-over-unconnected"[1]).

My proposal would indeed makes this use case impossible to enforce only
with the proposed access rights, and we would need to restrict write(2)
too BTW.  However, I think it would make sense to add complementary
access rights to restrict reading or writing to a socket.  I guess this
semantic would be useful for non-UDP protocols too with
LANDLOCK_ACCESS_NET_{READ,WRITE}_{TCP,UDP} access rights set at
socket-creation time and stored in the socket object (instead of looking
at a Landlock domain for each read/write call, similarly to the truncate
and ioctl_dev access rights).  What do you think?

I wonder what happens if we call recvmsg(2) on a newly created (and then
unconfigured) socket.  Without prior call to bind(2) I would guess that
the recvmsg(2) call fail but I'm not so sure with a datagram socket.  We
should check that.

> 
> >> +	err = check_access_port(dom, LANDLOCK_ACCESS_NET_RECVMSG_UDP,
> >> +				port_bigendian);
> >> +	if (err != -EACCES)
> >> +		return err;
> >
> > We should be able to follow the same policy for "connected" sockets.
> 
> Again if I understand correctly, to fully merge semantics of
> LANDLOCK_ACCESS_NET_BIND_UDP and LANDLOCK_ACCESS_NET_RECVMSG_UDP (since if
> the access check is performed at bind() time, there is nothing to check in
> recvmsg() anymore).

Correct (I was a bit confused with recvmsg, but it doesn't set the
receiving address/port).

> Similarly, this makes it impossible to allow a send-only
> program to bind() to set a source port without allowing it to recvmsg()
> traffic.

Correct with the current access rights.  We would need a
LANDLOCK_ACCESS_NET_READ_UDP.

> 
> I do not know of real-life programs that might want to sandbox their network
> workers *that* precisely, nor how much we want to be future-proof and
> support it. If not, I can merge your feedback and:
> - remove LANDLOCK_ACCESS_NET_RECVMSG_UDP and the recvmsg() hook;

Yes

> - change the doc for LANDLOCK_ACCESS_NET_SENDMSG_UDP to mention that it is
> not required if the app uses connect() and then sendmsg() without explicit
> addresses;

Yes

> - change the doc for LANDLOCK_ACCESS_NET_CONNECT_UDP to mention that it
> grants the right to send traffic (and similarly for
> LANDLOCK_ACCESS_NET_BIND_UDP to receive traffic), and the reason

The documentation should highlight that these flags grants the right to
configure a socket, but indeed, no restrictions are enforced on reading
or writing on sockets.

> (performance, though I haven't managed to get a benchmark);
> - rename to LANDLOCK_ACCESS_NET_CONNECT_SENDMSG_UDP,
> LANDLOCK_ACCESS_NET_SENDMSG_UDP, and LANDLOCK_ACCESS_NET_BIND_RECVMSG_UDP,
> what do you think?

The first and third rights are confusing.  I prefer simple names such as
LANDLOCK_ACCESS_NET_CONNECT_UDP and LANDLOCK_ACCESS_NET_BIND_UDP.
Moreover, LANDLOCK_ACCESS_NET_CONNECT_UDP would not impact sendmsg(2)
calls at all.

> 
> If merging semantics is a problem, I mentioned socket tagging in [2] to
> reduce the performance impact (e.g. tag whether it can send traffic at
> connect() time, and tag whether it can recv at bind() time). So another
> option could be to keep precise semantics and explore that?

This tagging mechanism looks like a good idea to implement
LANDLOCK_ACCESS_NET_{READ,WRITE}_{TCP,UDP}, but that should be a
future separate patch series.

> 
> >> +	/*
> >> +	 * Slow path: socket is bound to an ephemeral port. Need a second check
> >> +	 * on port 0 with different semantics ("any ephemeral port").
> >> +	 */
> >> +	inet_sk_get_local_port_range(sk, &ephemeral_low, &ephemeral_high);
> >
> > Is it to handle recvmsg(with port 0)?
> 
> If you mean recvmsg() on a socket that was previously bind(0), yep. This
> second rule lookup added a different meaning to rules on port 0. Without
> this, one would not be able to allow "all ephemeral ports", making the
> feature unusable for servers that bind on ephemeral ports. All this
> disappears if we remove LANDLOCK_ACCESS_NET_RECVMSG_UDP.

OK

> 
> Matthieu
> 
> [1] https://blog.cloudflare.com/everything-you-ever-wanted-to-know-about-udp-sockets-but-were-afraid-to-ask-part-1/
> [2] https://github.com/landlock-lsm/linux/issues/10#issuecomment-2267871144
> 

