Return-Path: <netdev+bounces-82913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C438902BB
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 16:11:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E77D31F25C9D
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 15:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5584D12EBC7;
	Thu, 28 Mar 2024 15:11:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D56612AAC8;
	Thu, 28 Mar 2024 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638673; cv=none; b=m7VdCmy84JmNHVqagulypSzupsL/bRCsxJfJb/Dgy5r4WpUjzy7V+LrEn4SpMacfVCNNGOlQkG9VxZ9LHrCwg5v/6M/y5Pa0TTY0d1ox8CPNdxUs4LzSHFZxaqNIClFNxO5wlA4V6RizPz56j1BrupPOvSC0M3aE7UWqkajkEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638673; c=relaxed/simple;
	bh=9ZVtnhzhZd0WftWAsQOgM+6p7f2COBJFMNa2GVUj5eo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Tek0jt6q+keLOTGnRaSbtn/DcYc8EeRuTJg3oD8RGvqJJl95DW3hdn8nd2/w9s6uCSe9p9y2Ys8trwQq7snhIrdlf6m4nFnoUhltRtNIZRwqCQpOtdcERLiIF6pdAWW4VxflqVWKWsc9rDWctkWtbIKzYYi7I6tN+1AbDiu8RuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V56PM0cjNztQW4;
	Thu, 28 Mar 2024 23:08:39 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id DC92E1401E0;
	Thu, 28 Mar 2024 23:11:05 +0800 (CST)
Received: from [10.123.123.159] (10.123.123.159) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 23:11:01 +0800
Message-ID: <bd62ac88-81bc-cee2-639a-a0ca79843265@huawei-partners.com>
Date: Thu, 28 Mar 2024 18:10:56 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] lsm: Check and handle error priority for
 socket_bind and socket_connect
To: =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, Paul Moore
	<paul@paul-moore.com>
CC: <linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>, Alexey
 Kodanev <alexey.kodanev@oracle.com>, Eric Dumazet <edumazet@google.com>,
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Konstantin Meskhidze
	<konstantin.meskhidze@huawei.com>, Muhammad Usama Anjum
	<usama.anjum@collabora.com>, "Serge E . Hallyn" <serge@hallyn.com>,
	yusongping <yusongping@huawei.com>, <artem.kuzin@huawei.com>
References: <20240327120036.233641-1-mic@digikod.net>
From: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
In-Reply-To: <20240327120036.233641-1-mic@digikod.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 dggpemm500020.china.huawei.com (7.185.36.49)


On 3/27/2024 3:00 PM, Mickaël Salaün wrote:
> Because the security_socket_bind and the security_socket_bind hooks are
> called before the network stack, it is easy to introduce error code
> inconsistencies. Instead of adding new checks to current and future
> LSMs, let's fix the related hook instead. The new checks are already
> (partially) implemented by SELinux and Landlock, and it should not
> change user space behavior but improve error code consistency instead.
It would probably be better to allow the network stack to perform such
checks before calling LSM hooks. This may lead to following improvements:

1. Fixing extra checks. In the current design, (address)checks are
    performed both in validate_inet_addr() function and
    in network stack methods.

2. The network stack can choose which error cases should not be hidden
    during the LSM access check, and which ones can be.

3. LSM will not be responsible for performing all necessary checks
    for every (necessary) protocol.

This may result in adding new method to socket->ops.
>
> The first check is about the minimal sockaddr length according to the
> address family. This improves the security of the AF_INET and AF_INET6
> sockaddr parsing for current and future LSMs.
>
> The second check is about AF_UNSPEC. This fixes error priority for bind
> on PF_INET6 socket when SELinux (and potentially others) is enabled.
> Indeed, the IPv6 network stack first checks the sockaddr length (-EINVAL
> error) before checking the family (-EAFNOSUPPORT error). See commit
> bbf5a1d0e5d0 ("selinux: Fix error priority for bind with AF_UNSPEC on
> PF_INET6 socket").
>
> The third check is about consistency between socket family and address
> family. Only AF_INET and AF_INET6 are tested (by Landlock tests), so no
> other protocols are checked for now.
>
> These new checks should enable to simplify current LSM implementations,
> but we may want to first land this patch on all stable branches.
>
> A following patch adds new tests improving AF_UNSPEC test coverage for
> Landlock.
>
> Cc: Alexey Kodanev <alexey.kodanev@oracle.com>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Günther Noack <gnoack@google.com>
> Cc: Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
> Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: Serge E. Hallyn <serge@hallyn.com>
> Fixes: 20510f2f4e2d ("security: Convert LSM into a static interface")
> Signed-off-by: Mickaël Salaün <mic@digikod.net>
> ---
>   security/security.c | 96 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 96 insertions(+)
>
> diff --git a/security/security.c b/security/security.c
> index 7e118858b545..64fe07a73b14 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -28,7 +28,9 @@
>   #include <linux/xattr.h>
>   #include <linux/msg.h>
>   #include <linux/overflow.h>
> +#include <linux/in.h>
>   #include <net/flow.h>
> +#include <net/ipv6.h>
>   
>   /* How many LSMs were built into the kernel? */
>   #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
> @@ -4415,6 +4417,82 @@ int security_socket_socketpair(struct socket *socka, struct socket *sockb)
>   }
>   EXPORT_SYMBOL(security_socket_socketpair);
>   
> +static int validate_inet_addr(struct socket *sock, struct sockaddr *address,
> +			      int addrlen, bool bind)
> +{
> +	const int sock_family = sock->sk->sk_family;
> +
> +	/* Checks for minimal header length to safely read sa_family. */
> +	if (addrlen < offsetofend(typeof(*address), sa_family))
> +		return -EINVAL;
> +
> +	/* Only handle inet sockets for now. */
> +	switch (sock_family) {
> +	case PF_INET:
> +	case PF_INET6:
> +		break;
> +	default:
> +		return 0;
> +	}
> +
> +	/* Checks minimal address length for inet sockets. */
> +	switch (address->sa_family) {
> +	case AF_UNSPEC: {
> +		const struct sockaddr_in *sa_in;
> +
> +		/* Cf. inet_dgram_connect(), __inet_stream_connect() */
> +		if (!bind)
> +			return 0;
> +
> +		if (sock_family == PF_INET6) {
> +			/* Length check from inet6_bind_sk() */
> +			if (addrlen < SIN6_LEN_RFC2133)
> +				return -EINVAL;
> +
> +			/* Family check from __inet6_bind() */
> +			goto err_af;
> +		}
> +
> +		/* Length check from inet_bind_sk() */
> +		if (addrlen < sizeof(struct sockaddr_in))
> +			return -EINVAL;
> +
> +		sa_in = (struct sockaddr_in *)address;
> +		if (sa_in->sin_addr.s_addr != htonl(INADDR_ANY))
> +			goto err_af;
> +
> +		return 0;
> +	}
> +	case AF_INET:
> +		/* Length check from inet_bind_sk() */
> +		if (addrlen < sizeof(struct sockaddr_in))
> +			return -EINVAL;
> +		break;
> +	case AF_INET6:
> +		/* Length check from inet6_bind_sk() */
> +		if (addrlen < SIN6_LEN_RFC2133)
> +			return -EINVAL;
> +		break;
> +	}
> +
> +	/*
> +	 * Checks sa_family consistency to not wrongfully return -EACCES
> +	 * instead of -EINVAL.  Valid sa_family changes are only (from AF_INET
> +	 * or AF_INET6) to AF_UNSPEC.
> +	 */
> +	if (address->sa_family != sock_family)
> +		return -EINVAL;
> +
> +	return 0;
> +
> +err_af:
> +	/* SCTP services expect -EINVAL, others -EAFNOSUPPORT. */
> +	if (sock->sk->sk_protocol == IPPROTO_SCTP)
> +		return -EINVAL;
> +
> +	return -EAFNOSUPPORT;
> +}
> +
>   /**
>    * security_socket_bind() - Check if a socket bind operation is allowed
>    * @sock: socket
> @@ -4425,11 +4503,23 @@ EXPORT_SYMBOL(security_socket_socketpair);
>    * and the socket @sock is bound to the address specified in the @address
>    * parameter.
>    *
> + * For security reasons and to get consistent error code whatever LSM are
> + * enabled, we first do the same sanity checks against sockaddr as the ones
> + * done by the network stack (executed after hook).  Currently only AF_UNSPEC,
> + * AF_INET, and AF_INET6 are handled.  Please add support for other family
> + * specificities when handled by an LSM.
> + *
>    * Return: Returns 0 if permission is granted.
>    */
>   int security_socket_bind(struct socket *sock,
>   			 struct sockaddr *address, int addrlen)
>   {
> +	int err;
> +
> +	err = validate_inet_addr(sock, address, addrlen, true);
> +	if (err)
> +		return err;
> +
>   	return call_int_hook(socket_bind, sock, address, addrlen);
>   }
>   
> @@ -4447,6 +4537,12 @@ int security_socket_bind(struct socket *sock,
>   int security_socket_connect(struct socket *sock,
>   			    struct sockaddr *address, int addrlen)
>   {
> +	int err;
> +
> +	err = validate_inet_addr(sock, address, addrlen, false);
> +	if (err)
> +		return err;
> +
>   	return call_int_hook(socket_connect, sock, address, addrlen);
>   }
>   

