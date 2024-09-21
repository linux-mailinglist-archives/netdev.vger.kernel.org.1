Return-Path: <netdev+bounces-129140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EB6E97DCD2
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 12:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BACC62823DA
	for <lists+netdev@lfdr.de>; Sat, 21 Sep 2024 10:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73094150997;
	Sat, 21 Sep 2024 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="anjPekdZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [185.125.25.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FD6250EC
	for <netdev@vger.kernel.org>; Sat, 21 Sep 2024 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726914228; cv=none; b=KMAKmuzUJgIDfBGZLDjuvz+9SV0dNWgvqUlr2Yf5cXF3UTCtTY73JEveF9w7+TPQP1Spwlfe1mr537BJjf77n/DVzEbcjiqlaFRmFr4cbBHt9/JFtZeGSCFpivyped5Ulo+BwsaTr4p3bPOeIYWkO0NpBFWQ2PHoxRcQ+/1lcns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726914228; c=relaxed/simple;
	bh=VvG/JRhYD+YgwYNiBZbB03QIasBYS3NIaLOyfWg3Yr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=llIZSqkDOq6Mxer+tQ5EAmNmyQnyZbImgwy0YSpr9BM24urIt7dAeSdRn8YXBsfr6zf3xC/P/GKRd/uHApTOOYwZ18kc5h6+fccQ+Du+haDXVinNRdp4f7FJSSPfz3wy5s2FvLqcVcS8NdIMpoKVW3SBSw/x+OBl7du00fEFDQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=anjPekdZ; arc=none smtp.client-ip=185.125.25.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4X9lhm3PK8zld2;
	Sat, 21 Sep 2024 12:23:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1726914216;
	bh=YwcGMU98XB5r3e3xk8Pb31K7iMPEMOYw4NZzCKRMdrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=anjPekdZsMQ78Xcf8WkBjOTrA63uZKWDiAx8Pl0ldNY/xBwuJ5fs7d9ruxvdUXvQi
	 u1z4/4fQCINYqFiAkevZtlr6ylt/anwzCeKmDXbcc5m1+oV6O3WEe4zg8V9F2rsAmR
	 mt+3YiM5fLiViTkmhcZtVy63awKzB06GsptgHmTs=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4X9lhk2lqsz8Q1;
	Sat, 21 Sep 2024 12:23:34 +0200 (CEST)
Date: Sat, 21 Sep 2024 12:23:22 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Subject: Re: [RFC PATCH v1 4/7] landlock: Add UDP send+recv access control
Message-ID: <20240921.ohCheQuoh1eu@digikod.net>
References: <20240916122230.114800-1-matthieu@buffet.re>
 <20240916122230.114800-5-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240916122230.114800-5-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

On Mon, Sep 16, 2024 at 02:22:27PM +0200, Matthieu Buffet wrote:
> Add support for two UDP access rights, complementing the two previous
> LANDLOCK_ACCESS_NET_CONNECT_UDP and LANDLOCK_ACCESS_NET_BIND_UDP:
> 
> - LANDLOCK_ACCESS_NET_RECVMSG_UDP: to prevent a process from receiving

I'm wondering what would make the most sense between NET_RECVMSG_UDP and
NET_RECVFROM_UDP.  Is one more known or understood than the other?  Same
for sendmsg vs. sendto.

>   datagrams. Just removing LANDLOCK_ACCESS_NET_BIND_UDP is not enough:
>   it can just send a first datagram or call connect() and get an
>   ephemeral port assigned, without ever calling bind(). This access right
>   allows blocking a process from receiving UDP datagrams, without
>   preventing them to bind() (which may be required to set source ports);
> 
> - LANDLOCK_ACCESS_NET_SENDMSG_UDP: to prevent a process from sending
>   datagrams. Just removing LANDLOCK_ACCESS_NET_CONNECT_UDP is not enough:
>   the process can call sendmsg() with an unconnected socket and an
>   arbitrary destination address.
> 
> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  include/uapi/linux/landlock.h |  18 ++-
>  security/landlock/limits.h    |   2 +-
>  security/landlock/net.c       | 205 +++++++++++++++++++++++++++++-----
>  3 files changed, 193 insertions(+), 32 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 7f9aa1cd2912..7ea3d1adb8c3 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -287,15 +287,25 @@ struct landlock_net_port_attr {
>   *   receive datagrams from (if you create a client-specific socket for a
>   *   client-specific process, e.g. using the established-over-unconnected
>   *   method)
> - *
> - * Note that ``bind(0)`` means binding to an ephemeral kernel-assigned port,
> - * in the range configured in ``/proc/sys/net/ipv4/ip_local_port_range``
> - * globally (or on a per-socket basis with ``setsockopt(IP_LOCAL_PORT_RANGE)``).
> + * - %LANDLOCK_ACCESS_NET_RECVMSG_UDP: receive datagrams on the given local port
> + *   (this is a distinct right from %LANDLOCK_ACCESS_NET_BIND_UDP, because you
> + *   may want to allow a process to set its datagrams source port using bind()
> + *   but not be able to receive datagrams)
> + * - %LANDLOCK_ACCESS_NET_SENDMSG_UDP: send datagrams to the given remote port
> + *   (this is a distinct right from %LANDLOCK_ACCESS_NET_CONNECT_UDP, because
> + *   you may want to allow a process to set which client it wants to receive
> + *   datagrams from using connect(), and not be able to send datagrams)
> + *
> + * Note that ``bind(0)`` has special semantics, meaning bind on any port in the
> + * range configured in ``/proc/sys/net/ipv4/ip_local_port_range`` globally (or
> + * on a per-socket basis with ``setsockopt(IP_LOCAL_PORT_RANGE)``).
>   */
>  /* clang-format off */
>  #define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
>  #define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
>  #define LANDLOCK_ACCESS_NET_BIND_UDP			(1ULL << 2)
>  #define LANDLOCK_ACCESS_NET_CONNECT_UDP			(1ULL << 3)
> +#define LANDLOCK_ACCESS_NET_RECVMSG_UDP			(1ULL << 4)
> +#define LANDLOCK_ACCESS_NET_SENDMSG_UDP			(1ULL << 5)
>  /* clang-format on */
>  #endif /* _UAPI_LINUX_LANDLOCK_H */
> diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> index 182b6a8d2976..e2697348310c 100644
> --- a/security/landlock/limits.h
> +++ b/security/landlock/limits.h
> @@ -22,7 +22,7 @@
>  #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
>  
> -#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_CONNECT_UDP
> +#define LANDLOCK_LAST_ACCESS_NET	LANDLOCK_ACCESS_NET_SENDMSG_UDP
>  #define LANDLOCK_MASK_ACCESS_NET	((LANDLOCK_LAST_ACCESS_NET << 1) - 1)
>  #define LANDLOCK_NUM_ACCESS_NET		__const_hweight64(LANDLOCK_MASK_ACCESS_NET)
>  
> diff --git a/security/landlock/net.c b/security/landlock/net.c
> index becc62c02cc9..9a3c44ad3f26 100644
> --- a/security/landlock/net.c
> +++ b/security/landlock/net.c
> @@ -10,6 +10,8 @@
>  #include <linux/net.h>
>  #include <linux/socket.h>
>  #include <net/ipv6.h>
> +#include <net/transp_v6.h>
> +#include <net/ip.h>
>  
>  #include "common.h"
>  #include "cred.h"
> @@ -61,6 +63,45 @@ static const struct landlock_ruleset *get_current_net_domain(void)
>  	return dom;
>  }
>  
> +static int get_addr_port(const struct sockaddr *address, int addrlen,
> +			 bool in_udpv6_sendmsg_ctx, __be16 *port)
> +{
> +	/* Checks for minimal header length to safely read sa_family. */
> +	if (addrlen < offsetofend(typeof(*address), sa_family))
> +		return -EINVAL;
> +
> +	switch (address->sa_family) {
> +	case AF_UNSPEC:

Please create a simple patch refactoring this code, but without any
semantic change, and then include the UDP specific part in the patch
adding support for UDP control.  This helps verify (and test) what is
the code refactoring and what is the actual change, and it could also
help for backports.  Moving this code to a standalone helper should then
be the first patch of this series.

> +		/*
> +		 * Backward compatibility games: AF_UNSPEC is mapped to AF_INET
> +		 * by `bind` (v4+v6), `connect` (v4) and `sendmsg` (v4), but

Instead of backticks, just name these syscalls as functions: bind(),
connect()...

> +		 * interpreted as "no address" by `sendmsg` (v6). In that case
> +		 * this call must succeed (even if `address` is shorter than a
> +		 * `struct sockaddr_in`), and caller must check for this
> +		 * condition.

Weird dance, but good catch.

> +		 */
> +		if (in_udpv6_sendmsg_ctx) {
> +			*port = 0;

Why set the port to zero?  In udp_sendmsg(), it looks like such a port
would return -EINVAL right?

And in this case, why ignoring the following addrlen check?

Couldn't we just remove this in_udpv6_sendmsg_ctx argument, extract the
port as long as we can, and only deal with the in_udpv6_sendmsg case in
hook_socket_sendmsg()

> +			return 0;
> +		}
> +		fallthrough;
> +	case AF_INET:
> +		if (addrlen < sizeof(struct sockaddr_in))
> +			return -EINVAL;
> +		*port = ((struct sockaddr_in *)address)->sin_port;
> +		return 0;
> +#if IS_ENABLED(CONFIG_IPV6)
> +	case AF_INET6:
> +		if (addrlen < SIN6_LEN_RFC2133)
> +			return -EINVAL;
> +		*port = ((struct sockaddr_in6 *)address)->sin6_port;
> +		return 0;
> +#endif /* IS_ENABLED(CONFIG_IPV6) */
> +	}
> +
> +	return -EAFNOSUPPORT;
> +}
> +
>  static int current_check_access_socket(struct socket *const sock,
>  				       struct sockaddr *const address,
>  				       const int addrlen,
> @@ -73,39 +114,18 @@ static int current_check_access_socket(struct socket *const sock,
>  		.type = LANDLOCK_KEY_NET_PORT,
>  	};
>  	const struct landlock_ruleset *const dom = get_current_net_domain();
> +	int err;
>  
>  	if (!dom)
>  		return 0;
>  	if (WARN_ON_ONCE(dom->num_layers < 1))
>  		return -EACCES;
>  
> -	/* Checks if it's a (potential) UDP or TCP socket. */
> -	if (sock->type != SOCK_STREAM && sock->type != SOCK_DGRAM)
> -		return 0;
> -
> -	/* Checks for minimal header length to safely read sa_family. */
> -	if (addrlen < offsetofend(typeof(*address), sa_family))
> -		return -EINVAL;
> -
> -	switch (address->sa_family) {
> -	case AF_UNSPEC:
> -	case AF_INET:
> -		if (addrlen < sizeof(struct sockaddr_in))
> -			return -EINVAL;
> -		port = ((struct sockaddr_in *)address)->sin_port;
> -		break;
> -
> -#if IS_ENABLED(CONFIG_IPV6)
> -	case AF_INET6:
> -		if (addrlen < SIN6_LEN_RFC2133)
> -			return -EINVAL;
> -		port = ((struct sockaddr_in6 *)address)->sin6_port;
> -		break;
> -#endif /* IS_ENABLED(CONFIG_IPV6) */
> -
> -	default:
> -		return 0;
> -	}
> +	err = get_addr_port(address, addrlen, false, &port);
> +	if (err == -EAFNOSUPPORT)
> +		return 0; // restrictions are not applicable to this socket family

Comments need to be /* Like this and before the commented code. */
See https://docs.kernel.org/process/maintainer-tip.html#comment-style

> +	else if (err != 0)
> +		return err;
>  
>  	/* Specific AF_UNSPEC handling. */
>  	if (address->sa_family == AF_UNSPEC) {
> @@ -174,6 +194,27 @@ static int current_check_access_socket(struct socket *const sock,
>  	return -EACCES;
>  }
>  
> +static int check_access_port(const struct landlock_ruleset *const dom,
> +			     access_mask_t access_request, __be16 port)
> +{
> +	layer_mask_t layer_masks[LANDLOCK_NUM_ACCESS_NET] = {};
> +	const struct landlock_rule *rule;
> +	const struct landlock_id id = {
> +		.key.data = (__force uintptr_t)port,
> +		.type = LANDLOCK_KEY_NET_PORT,
> +	};
> +	BUILD_BUG_ON(sizeof(port) > sizeof(id.key.data));
> +
> +	rule = landlock_find_rule(dom, id);
> +	access_request = landlock_init_layer_masks(
> +		dom, access_request, &layer_masks, LANDLOCK_KEY_NET_PORT);
> +	if (landlock_unmask_layers(rule, access_request, &layer_masks,
> +				   ARRAY_SIZE(layer_masks)))
> +		return 0;
> +
> +	return -EACCES;
> +}
> +
>  static int hook_socket_bind(struct socket *const sock,
>  			    struct sockaddr *const address, const int addrlen)
>  {
> @@ -215,9 +256,119 @@ static int hook_socket_connect(struct socket *const sock,
>  					   access_request);
>  }
>  
> +static int hook_socket_sendmsg(struct socket *const sock,
> +			       struct msghdr *const msg, const int size)

We can probably constify these references.

> +{
> +	const struct landlock_ruleset *const dom = get_current_net_domain();
> +	const struct sockaddr *address = (const struct sockaddr *)msg->msg_name;
> +	int err;
> +	__be16 port;
> +
> +	if (sock->type != SOCK_DGRAM)
> +		return 0;
> +	if (sock->sk->sk_protocol != IPPROTO_UDP)
> +		return 0;
> +	if (!dom)
> +		return 0;

I'd prefer this !dom check to be the first (like for most other hooks)
because it makes it clear that Landlock doesn't mess with not sandboxed
tasks.  Moreover in this case it would avoid two pointer dereferences.

> +	if (WARN_ON_ONCE(dom->num_layers < 1))
> +		return -EACCES;

This num_layers check can stay just after to the dom check though.

> +
> +	/*
> +	 * Don't mimic all checks udp_sendmsg() and udpv6_sendmsg() do. Just
> +	 * read what we need for access control, and fail if we can't (e.g.
> +	 * because the input buffer is too short) with the same error codes as
> +	 * they do. Selftests enforce that these error codes do not diverge
> +	 * with the actual implementation's ones.
> +	 */
> +
> +	/*
> +	 * If there is a more specific address in the message, it will take
> +	 * precedence over any connect()ed address. Base our access check on it.
> +	 */
> +	if (address) {
> +		const bool in_udpv6_sendmsg =
> +			(sock->sk->sk_prot == &udpv6_prot);
> +
> +		err = get_addr_port(address, msg->msg_namelen, in_udpv6_sendmsg,
> +				    &port);
> +		if (err != 0)
> +			return err;
> +
> +		/*
> +		 * In `udpv6_sendmsg`, AF_UNSPEC is interpreted as "no address".
> +		 * In that case, the call above will succeed but without
> +		 * returning a port.
> +		 */
> +		if (in_udpv6_sendmsg && address->sa_family == AF_UNSPEC)
> +			address = NULL;
> +	}
> +
> +	/*
> +	 * Without a message-specific destination address, the socket must be
> +	 * connect()ed to an address, base our access check on that one.
> +	 */
> +	if (!address) {

If the address is not specified, I think we should just allow the
request and let the network stack handle the rest.  The advantage of
this approach would be that if the socket was previously allowed to be
connected, the check is only done once and they will be almost no
performance impact when calling sendto/write/recvfrom/read on this
"connected" socket.

> +		/*
> +		 * We could let this through and count on `udp_sendmsg` and
> +		 * `udpv6_sendmsg` to error out, but they could change in the
> +		 * future and open a hole here without knowing. Enforce an
> +		 * error, and enforce in selftests that we don't diverge in
> +		 * behaviours compared to them.

This is a good approach for this patch, but if we allow connected
sockets to be freely used when the address is not specified, this check
should not be required because we would allow such action anyway and the
network stack would handle the other error cases.

> +		 */
> +		if (sock->sk->sk_state != TCP_ESTABLISHED)
> +			return -EDESTADDRREQ;
> +
> +		port = inet_sk(sock->sk)->inet_dport;
> +	}
> +
> +	return check_access_port(dom, LANDLOCK_ACCESS_NET_SENDMSG_UDP, port);


What about something like this (with the appropriate comments)?

if (!address)
	return 0;

if (address->sa_family == AF_UNSPEC && sock->sk->sk_prot == &udpv6_prot)
	return 0;

err = get_addr_port(address, msg->msg_namelen, &port);
if (err)
	return err;

return check_access_port(dom, LANDLOCK_ACCESS_NET_SENDMSG_UDP, port);

> +}
> +
> +static int hook_socket_recvmsg(struct socket *const sock,
> +			       struct msghdr *const msg, const int size,
> +			       const int flags)
> +{
> +	const struct landlock_ruleset *const dom = get_current_net_domain();
> +	struct sock *sk = sock->sk;
> +	int err;
> +	__be16 port_bigendian;
> +	int ephemeral_low;
> +	int ephemeral_high;
> +	__u16 port_hostendian;
> +
> +	if (sk->sk_protocol != IPPROTO_UDP)
> +		return 0;

ditto

> +	if (!dom)
> +		return 0;
> +	if (WARN_ON_ONCE(dom->num_layers < 1))
> +		return -EACCES;
> +
> +	/* "fast" path: socket is bound to an explicitly allowed port */
> +	port_bigendian = inet_sk(sk)->inet_sport;
> +	err = check_access_port(dom, LANDLOCK_ACCESS_NET_RECVMSG_UDP,
> +				port_bigendian);
> +	if (err != -EACCES)
> +		return err;

We should be able to follow the same policy for "connected" sockets.

> +
> +	/*
> +	 * Slow path: socket is bound to an ephemeral port. Need a second check
> +	 * on port 0 with different semantics ("any ephemeral port").
> +	 */
> +	inet_sk_get_local_port_range(sk, &ephemeral_low, &ephemeral_high);

Is it to handle recvmsg(with port 0)?

> +	port_hostendian = ntohs(port_bigendian);
> +	if (ephemeral_low <= port_hostendian &&
> +	    port_hostendian <= ephemeral_high)
> +		return check_access_port(dom, LANDLOCK_ACCESS_NET_RECVMSG_UDP,
> +					 0);
> +
> +	return -EACCES;
> +}
> +
>  static struct security_hook_list landlock_hooks[] __ro_after_init = {
>  	LSM_HOOK_INIT(socket_bind, hook_socket_bind),
>  	LSM_HOOK_INIT(socket_connect, hook_socket_connect),
> +	LSM_HOOK_INIT(socket_sendmsg, hook_socket_sendmsg),
> +	LSM_HOOK_INIT(socket_recvmsg, hook_socket_recvmsg),
>  };
>  
>  __init void landlock_add_net_hooks(void)
> -- 
> 2.39.5
> 
> 

