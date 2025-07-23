Return-Path: <netdev+bounces-209365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E83B0F65E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FCD3AA2197
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE962FE305;
	Wed, 23 Jul 2025 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiO5J/zV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005652F50BD;
	Wed, 23 Jul 2025 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282447; cv=none; b=NxhzB0sHVge9hgw9SZitVK/up9GBaPvvt886Sxb0oA55rBwhn/je6gfMyxHcZqA4S6RzeBrjt1KE75BBIONTHvoME54mgQf4pgxpbtm158zDlQkKZjxCuPxqFQl1R0fHqDtE9Xt+OPF/8tMC5yX7g/P4Qm4eefkXbpIvUcnTQn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282447; c=relaxed/simple;
	bh=4U/+U3/SF5geYLW4vyxe77t41Yfr2fQzgQTGw6vbhVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kFcbxBKHK1ej3YOnvnyDOtw9rIpXVMazt4NjuD5nbeX5yDRpL1kuN0R7Ofnm7YjTOJFwJYlNT+jMb5JMLNS4T6VYBXyy6c+cB0QmxbMxPhA2iYdYTQskRDqB0YZNx5zzKmd+7fUdciziXmB80obRuTFUQrP8Pc3izrTRLHgvK5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiO5J/zV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03596C4CEFA;
	Wed, 23 Jul 2025 14:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282444;
	bh=4U/+U3/SF5geYLW4vyxe77t41Yfr2fQzgQTGw6vbhVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CiO5J/zV5S6FbLaWm2MKDwnRTJOHgGUSzY22lvLLoCt1suc5TMFQcPrLA148z896s
	 e7YStYXLrNYy7qFW72jehY35t1utnJOTYqVX3Y+SwMDv/mD1ogJSe3floTEmSxanOl
	 MafGxv49RfiE6oHPGql4W8zEnGRW0+3hWeY4So0Li1TCGEJYiBGvNIL8LRNOdSWWz6
	 z6LskuFZfKh2z7m8XRykksR0EMaLnz1QyD/NuLYnxJsDkRykHS6bzgHDZxKKUGEHh8
	 DzU8JGewheVY4nRRqbM0UxZpWw7cF3Bjac89rXx9WaCTcgJNBJLUEE/+07BvLp6RBT
	 b90JExGjbuH3Q==
Date: Wed, 23 Jul 2025 15:54:00 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 4/5] netconsole: use netpoll_parse_ip_addr in
 local_ip_store
Message-ID: <20250723145400.GB1036606@horms.kernel.org>
References: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
 <20250721-netconsole_ref-v2-4-b42f1833565a@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721-netconsole_ref-v2-4-b42f1833565a@debian.org>

On Mon, Jul 21, 2025 at 06:02:04AM -0700, Breno Leitao wrote:
> Replace manual IP address parsing with a call to netpoll_parse_ip_addr
> in local_ip_store(), simplifying the code and reducing the chance of
> errors.
> 
> Also, remove the pr_err() if the user enters an invalid value in
> configfs entries. pr_err() is not the best way to alert user that the
> configuration is invalid.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

My suggestion below not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  drivers/net/netconsole.c | 22 +++++-----------------
>  1 file changed, 5 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index f2c2b8852c603..b24e423a60268 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -751,6 +751,7 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
>  {
>  	struct netconsole_target *nt = to_target(item);
>  	ssize_t ret = -EINVAL;
> +	int ipv6;
>  
>  	mutex_lock(&dynamic_netconsole_mutex);
>  	if (nt->enabled) {
> @@ -759,23 +760,10 @@ static ssize_t local_ip_store(struct config_item *item, const char *buf,
>  		goto out_unlock;
>  	}
>  
> -	if (strnchr(buf, count, ':')) {
> -		const char *end;
> -
> -		if (in6_pton(buf, count, nt->np.local_ip.in6.s6_addr, -1, &end) > 0) {
> -			if (*end && *end != '\n') {
> -				pr_err("invalid IPv6 address at: <%c>\n", *end);
> -				goto out_unlock;
> -			}
> -			nt->np.ipv6 = true;
> -		} else
> -			goto out_unlock;
> -	} else {
> -		if (!nt->np.ipv6)
> -			nt->np.local_ip.ip = in_aton(buf);
> -		else
> -			goto out_unlock;
> -	}
> +	ipv6 = netpoll_parse_ip_addr(buf, &nt->np.local_ip);
> +	if (ipv6 == -1)
> +		goto out_unlock;
> +	nt->np.ipv6 = ipv6;

I don't think this needs to block progress.
And if you disagree that is fine too.
But I would have expressed this as:

	nt->np.ipv6 = !!ipv6;

Because nt->np.ipv6 is a bool and ipv6 is an int.

Likewise for patch 5/5.

...

