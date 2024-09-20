Return-Path: <netdev+bounces-129089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7D2E97D670
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 15:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4665AB2282B
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 13:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C88A17B4FF;
	Fri, 20 Sep 2024 13:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="plXYD0uO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [45.157.188.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20BB17995E
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726839915; cv=none; b=acR7hNGU9aR/CLwqSe55yitKngRuSonAixPvLKKtTOonccHuCKXpKRMGe3IMefIXLAkxbm8Yph+JwECDoBDLBPbruoQQNLJljTgc5o42N2FMClVz1sVzhEFemkPmQkLcvWAwxHMWXuejP3G9I5vatZuXXUdnbqP/pNRCp/s+wY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726839915; c=relaxed/simple;
	bh=fPDSelq1zxnLLqtV4shJ+E+iQsItEMSqurwY6B8OgZU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YWlQ2rRZZdn+jxRhj3hcmSNludZmZ50/AFus0RXii8Z9TFAS+uX2lxrmJsUsV1TBJel0COEv8MuOU/DVmdX+CI3fAXaEW01wsIYsX2MY1lDro3eRNsfc804+DKZ+En1xD0eF4c/2I/vkssoc6hfM4h7sNuTNUacALBeWwxSOZ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=plXYD0uO; arc=none smtp.client-ip=45.157.188.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4X9D5B0Z1lztGl;
	Fri, 20 Sep 2024 15:39:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1726839565;
	bh=dr5nU5SlKLcmYNUhEmWx1GhyOTVcH7v2oOWucrZayZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=plXYD0uO14RitumnKe9wVcc2UmZvU+vtIoq8BHSOXK4+Kv3zZ5vOOhOjVdpTvdcbL
	 AXfCgPNYRiwMpTIXlF/EeyMLjlSxhcqV/v/l4hZwhHVo/ZG891BUOX1n5Pu6Gt8YpZ
	 Mjano6zo/E+dCyiZnUCiRKJI4ZN/IqEbfJ6qlNIE=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4X9D591f76zYxC;
	Fri, 20 Sep 2024 15:39:25 +0200 (CEST)
Date: Fri, 20 Sep 2024 15:39:17 +0200
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Matthieu Buffet <matthieu@buffet.re>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Ivanov Mikhail <ivanov.mikhail1@huawei-partners.com>
Subject: Re: [RFC PATCH v1 3/7] landlock: Add UDP bind+connect access control
Message-ID: <20240920.choPhoa8ahp8@digikod.net>
References: <20240916122230.114800-1-matthieu@buffet.re>
 <20240916122230.114800-4-matthieu@buffet.re>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240916122230.114800-4-matthieu@buffet.re>
X-Infomaniak-Routing: alpha

On Mon, Sep 16, 2024 at 02:22:26PM +0200, Matthieu Buffet wrote:
> Add support for two more access rights:
> 
> - LANDLOCK_ACCESS_NET_CONNECT_UDP, to gate the possibility to connect()
>   an inet SOCK_DGRAM socket. This will be used by some client applications
>   (those who want to avoid specifying a destination for each datagram in
>   sendmsg), and for a few servers (those creating a socket per-client, who
>   want to only receive traffic from each client on these sockets)
> 
> - LANDLOCK_ACCESS_NET_BIND_UDP, to gate the possibility to bind() an
>   inet SOCK_DGRAM socket. This will be required for most server
>   applications (to start listening for datagrams on a non-ephemeral
>   port) and can be useful for some client applications (to set the
>   source port of future datagrams)
> 
> Also bump the ABI version from 5 to 6 so that userland can detect
> whether these rights are supported and actually use them.
> 

Closes: https://github.com/landlock-lsm/linux/issues/10

> Signed-off-by: Matthieu Buffet <matthieu@buffet.re>
> ---
>  include/uapi/linux/landlock.h | 48 +++++++++++++++++++++++--------
>  security/landlock/limits.h    |  2 +-
>  security/landlock/net.c       | 54 ++++++++++++++++++++++++++---------
>  security/landlock/syscalls.c  |  2 +-
>  4 files changed, 79 insertions(+), 27 deletions(-)
> 
> diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> index 2c8dbc74b955..7f9aa1cd2912 100644
> --- a/include/uapi/linux/landlock.h
> +++ b/include/uapi/linux/landlock.h
> @@ -113,12 +113,15 @@ struct landlock_net_port_attr {
>  	 *
>  	 * It should be noted that port 0 passed to :manpage:`bind(2)` will bind
>  	 * to an available port from the ephemeral port range.  This can be
> -	 * configured with the ``/proc/sys/net/ipv4/ip_local_port_range`` sysctl
> -	 * (also used for IPv6).
> +	 * configured globally with the
> +	 * ``/proc/sys/net/ipv4/ip_local_port_range`` sysctl (also used for
> +	 * IPv6), and on a per-socket basis using
> +	 * ``setsockopt(IP_LOCAL_PORT_RANGE)``.

Interesting... setsockopt(IP_LOCAL_PORT_RANGE) can always be set
independant of the sysctl, but fortunately it is only taken into account
if it fits into the sysctl range (see inet_sk_get_local_port_range),
which makes sense.

>  	 *
>  	 * A Landlock rule with port 0 and the ``LANDLOCK_ACCESS_NET_BIND_TCP``
> -	 * right means that requesting to bind on port 0 is allowed and it will
> -	 * automatically translate to binding on the related port range.
> +	 * or ``LANDLOCK_ACCESS_NET_BIND_UDP`` right means that requesting to
> +	 * bind on port 0 is allowed and it will automatically translate to
> +	 * binding on the related port range.
>  	 */
>  	__u64 port;
>  };

