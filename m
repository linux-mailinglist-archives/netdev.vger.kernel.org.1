Return-Path: <netdev+bounces-137220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B7B9A4E04
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 14:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC90BB2601E
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 12:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD99BA2E;
	Sat, 19 Oct 2024 12:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b="I5S4L8KF"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.buffet.re (mx1.buffet.re [51.83.41.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D7B647;
	Sat, 19 Oct 2024 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.83.41.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729342470; cv=none; b=hy6q/DbvgAgJKkXyHHcZNX124gA0G/TXxkpqQ0Zif51bgV9NAeEL3Rwk4RUcMiMw+XDVNneMQlaS4nC0SPkEvDjMy5PRGHIxNPx7RAQLg3szzgoAnvTweaIJBAwQ0KYAiFU1OS4ZdMtEtL/OyYK03pcive4IqZEMSyI/SoyGJbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729342470; c=relaxed/simple;
	bh=XL5W7c/DX8KZTAFtPHVnEmAg+KHJ3hcoSpFuf9hVAo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pyRd0QXa786rxnvEDCgUiwVxuwdhigmA3HZbAkp+LpS0EuhApsYIRZHoGwXky90QksAXvojRw0V40o4zMNQUdmckNoIUjfXwOJ5NaS0VSqA2+oLzBj5W/EDt6zdZoLbVw43egS9AW4uEeCU5S2uNoeWobJtn9Cv5gWZhs2FIpMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re; spf=pass smtp.mailfrom=buffet.re; dkim=pass (2048-bit key) header.d=buffet.re header.i=@buffet.re header.b=I5S4L8KF; arc=none smtp.client-ip=51.83.41.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=buffet.re
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=buffet.re
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=buffet.re; s=mx1;
	t=1729341894; bh=XL5W7c/DX8KZTAFtPHVnEmAg+KHJ3hcoSpFuf9hVAo0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I5S4L8KFF5zjt5dX/pqiUeb0c4TX5BDaEsj3frPdOylso0FEFE+tBZxyVdM/NZud/
	 YtmTLXAm+zl/9njainVnNTkIpkEh4Ab1jeVdVpWdTN9Yr9vD0eTGiedmxqiEBsPrWl
	 k7A7g6dEWA+UJL7BRkC5poknkw8TgvB8/ANsYna2k7TCzo+iGC8JzO8c0tuQcd3oVD
	 z6c16oR4b3+dYC3yt6w0FvZP2xrYu5YluDb4dSqkTQfPEy4Bprqt+Kg2FCAgK30hAF
	 6Kzcq+OWCrThAvaC6xhFFoNeTI9335umCKaOrU6kLpen0EKVVOoggbBxzPamNf4P5N
	 5kzYeW4G6/+fA==
Received: from [192.168.100.2] (unknown [10.0.1.3])
	by mx1.buffet.re (Postfix) with ESMTPA id 3438F123074;
	Sat, 19 Oct 2024 14:44:54 +0200 (CEST)
Message-ID: <3631edfd-7f41-4ff1-9f30-20dcaa17b726@buffet.re>
Date: Sat, 19 Oct 2024 14:47:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 4/7] landlock: Add UDP send+recv access control
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
 Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
References: <20240916122230.114800-1-matthieu@buffet.re>
 <20240916122230.114800-5-matthieu@buffet.re>
 <20240921.ohCheQuoh1eu@digikod.net>
Content-Language: en-US
From: Matthieu Buffet <matthieu@buffet.re>
In-Reply-To: <20240921.ohCheQuoh1eu@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Mickaël,

I've almost finished merging your review (thanks for all the feedback), 
with the exception of this main point. Just making sure we agree on the 
limitations before I merge this into a new version.

On 9/21/2024 12:23 PM, Mickaël Salaün wrote:
 >> +	/*
 >> +	 * If there is a more specific address in the message, it will take
 >> +	 * precedence over any connect()ed address. Base our access check 
on it.
 >> +	 */
 >> +	if (address) {
 >> +		const bool in_udpv6_sendmsg =
 >> +			(sock->sk->sk_prot == &udpv6_prot);
 >> +
 >> +		err = get_addr_port(address, msg->msg_namelen, in_udpv6_sendmsg,
 >> +				    &port);
 >> +		if (err != 0)
 >> +			return err;
 >> +
 >> +		/*
 >> +		 * In `udpv6_sendmsg`, AF_UNSPEC is interpreted as "no address".
 >> +		 * In that case, the call above will succeed but without
 >> +		 * returning a port.
 >> +		 */
 >> +		if (in_udpv6_sendmsg && address->sa_family == AF_UNSPEC)
 >> +			address = NULL;
 >> +	}
 >> +
 >> +	/*
 >> +	 * Without a message-specific destination address, the socket must be
 >> +	 * connect()ed to an address, base our access check on that one.
 >> +	 */
 >> +	if (!address) {
 >
 > If the address is not specified, I think we should just allow the
 > request and let the network stack handle the rest.  The advantage of
 > this approach would be that if the socket was previously allowed to be
 > connected, the check is only done once and they will be almost no
 > performance impact when calling sendto/write/recvfrom/read on this
 > "connected" socket.
 > [...]
 > What about something like this (with the appropriate comments)?
 >
 > if (!address)
 > 	return 0;
 >
 > if (address->sa_family == AF_UNSPEC && sock->sk->sk_prot ==
 >     &udpv6_prot)
 > 	return 0;
 >
 > err = get_addr_port(address, msg->msg_namelen, &port);
 > if (err)
 > 	return err;
 >
 > return check_access_port(dom, LANDLOCK_ACCESS_NET_SENDMSG_UDP, port);

If I understand correctly, you would like the semantics of 
LANDLOCK_ACCESS_NET_CONNECT_UDP to be {connect(), and sendmsg() without 
explicit address} and LANDLOCK_ACCESS_NET_SENDMSG_UDP to be {sendmsg() 
with explicit address}. This makes it impossible to allow a landlocked 
server to connect() in order to receive traffic only from a specific 
client while at the same time preventing it from sending traffic (that 
is, a receive-only client-specific socket ala Cloudflare's 
"established-over-unconnected"[1]).

 >> +	err = check_access_port(dom, LANDLOCK_ACCESS_NET_RECVMSG_UDP,
 >> +				port_bigendian);
 >> +	if (err != -EACCES)
 >> +		return err;
 >
 > We should be able to follow the same policy for "connected" sockets.

Again if I understand correctly, to fully merge semantics of 
LANDLOCK_ACCESS_NET_BIND_UDP and LANDLOCK_ACCESS_NET_RECVMSG_UDP (since 
if the access check is performed at bind() time, there is nothing to 
check in recvmsg() anymore). Similarly, this makes it impossible to 
allow a send-only program to bind() to set a source port without 
allowing it to recvmsg() traffic.

I do not know of real-life programs that might want to sandbox their 
network workers *that* precisely, nor how much we want to be 
future-proof and support it. If not, I can merge your feedback and:
- remove LANDLOCK_ACCESS_NET_RECVMSG_UDP and the recvmsg() hook;
- change the doc for LANDLOCK_ACCESS_NET_SENDMSG_UDP to mention that it 
is not required if the app uses connect() and then sendmsg() without 
explicit addresses;
- change the doc for LANDLOCK_ACCESS_NET_CONNECT_UDP to mention that it 
grants the right to send traffic (and similarly for 
LANDLOCK_ACCESS_NET_BIND_UDP to receive traffic), and the reason 
(performance, though I haven't managed to get a benchmark);
- rename to LANDLOCK_ACCESS_NET_CONNECT_SENDMSG_UDP, 
LANDLOCK_ACCESS_NET_SENDMSG_UDP, and 
LANDLOCK_ACCESS_NET_BIND_RECVMSG_UDP, what do you think?

If merging semantics is a problem, I mentioned socket tagging in [2] to 
reduce the performance impact (e.g. tag whether it can send traffic at 
connect() time, and tag whether it can recv at bind() time). So another 
option could be to keep precise semantics and explore that?

 >> +	/*
 >> +	 * Slow path: socket is bound to an ephemeral port. Need a second 
check
 >> +	 * on port 0 with different semantics ("any ephemeral port").
 >> +	 */
 >> +	inet_sk_get_local_port_range(sk, &ephemeral_low, &ephemeral_high);
 >
 > Is it to handle recvmsg(with port 0)?

If you mean recvmsg() on a socket that was previously bind(0), yep. This 
second rule lookup added a different meaning to rules on port 0. Without 
this, one would not be able to allow "all ephemeral ports", making the 
feature unusable for servers that bind on ephemeral ports. All this 
disappears if we remove LANDLOCK_ACCESS_NET_RECVMSG_UDP.

Matthieu

[1] 
https://blog.cloudflare.com/everything-you-ever-wanted-to-know-about-udp-sockets-but-were-afraid-to-ask-part-1/
[2] https://github.com/landlock-lsm/linux/issues/10#issuecomment-2267871144

