Return-Path: <netdev+bounces-140176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 818119B56A3
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D94C4283DF9
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A3320ADDC;
	Tue, 29 Oct 2024 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dosKoYq8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B22F2076DE
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 23:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244145; cv=none; b=KP8VumGQqyPnPDtdOxmcftAQNZau5Rv35ybThC+d2bgtH51VFb8r5Hd3iiOEabK+DQJSzplUgAB4rx7AZhukV3X9wBwFRgRH/q/vsPz/ewdJ42/b4pztqGL3ivT4dZ9mKf7CrD3/d0WOaLUehQsiv2YG2dgFEKoodj1WxewKlng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244145; c=relaxed/simple;
	bh=UZKNwb7VmkfgCX23HytNMsE0FMA9Nd/sg4wokKcDKWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VMklytOmwF2MW1o6wjbl59Ay9D6/iEXxljW+/Y1V3jnIMbG0grFvkgvHyrk/8h7K7HxA999Aktut9L0By6bbQ7mfjR9vKGJXIoVuORbBkjNYM12mDpSqi7XSiQeGeVDxvKmwXNToo8JqLm7MvA3PVD0H9EhH2hdd61C59D6SIAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dosKoYq8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77957C4CEE3;
	Tue, 29 Oct 2024 23:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730244144;
	bh=UZKNwb7VmkfgCX23HytNMsE0FMA9Nd/sg4wokKcDKWE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=dosKoYq8PM37Cz8+5OfiFrcfPFCjp9gSpNV1IaAE1AKeYnZRL7WC81UsjY5VU1kv1
	 XGQIOROc2DUlAVwpW2pclwjiSzUKWC6PsNIeiRGhydfde6Z+xtQNxImnzFDPE3kSw/
	 vsTpi7/0+5qhvi58l88l2/5pHym900gazgsL6/jQjKRpyPvBGtc6VJSFHaz6XyX3sg
	 0V8d6pW5xwHtFVbQc58oS3b6iL5whXz5kQJcQK9JAJiqbvR1Mxl1/2r9DWGdMJlk6+
	 gTOT8QRLcm6blI7zbqvlq9X8+qagMCoG1EjXPAaVF0ypvlYhkfNh8xWVrBz2VTGqvw
	 vgFGZmLYm6REw==
Message-ID: <736cdd43-4c4b-4341-bd77-c9a365dec2e5@kernel.org>
Date: Tue, 29 Oct 2024 17:22:23 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ipv4: Cache pmtu for all packet paths if multipath
 enabled
To: Vladimir Vdovin <deliran@verdict.gg>, netdev@vger.kernel.org,
 davem@davemloft.net, Ido Schimmel <idosch@idosch.org>
References: <20241029152206.303004-1-deliran@verdict.gg>
Content-Language: en-US
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20241029152206.303004-1-deliran@verdict.gg>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/24 9:21 AM, Vladimir Vdovin wrote:
> Check number of paths by fib_info_num_path(),
> and update_or_create_fnhe() for every path.
> Problem is that pmtu is cached only for the oif
> that has received icmp message "need to frag",
> other oifs will still try to use "default" iface mtu.
> 
> An example topology showing the problem:
> 
>                     |  host1
>                 +---------+
>                 |  dummy0 | 10.179.20.18/32  mtu9000
>                 +---------+
>         +-----------+----------------+
>     +---------+                     +---------+
>     | ens17f0 |  10.179.2.141/31    | ens17f1 |  10.179.2.13/31
>     +---------+                     +---------+
>         |    (all here have mtu 9000)    |
>     +------+                         +------+
>     | ro1  |  10.179.2.140/31        | ro2  |  10.179.2.12/31
>     +------+                         +------+
>         |                                |
> ---------+------------+-------------------+------
>                         |
>                     +-----+
>                     | ro3 | 10.10.10.10  mtu1500
>                     +-----+
>                         |
>     ========================================
>                 some networks
>     ========================================
>                         |
>                     +-----+
>                     | eth0| 10.10.30.30  mtu9000
>                     +-----+
>                         |  host2
> 
> host1 have enabled multipath and
> sysctl net.ipv4.fib_multipath_hash_policy = 1:
> 
> default proto static src 10.179.20.18
>         nexthop via 10.179.2.12 dev ens17f1 weight 1
>         nexthop via 10.179.2.140 dev ens17f0 weight 1
> 
> When host1 tries to do pmtud from 10.179.20.18/32 to host2,
> host1 receives at ens17f1 iface an icmp packet from ro3 that ro3 mtu=1500.
> And host1 caches it in nexthop exceptions cache.
> 
> Problem is that it is cached only for the iface that has received icmp,
> and there is no way that ro3 will send icmp msg to host1 via another path.
> 
> Host1 now have this routes to host2:
> 
> ip r g 10.10.30.30 sport 30000 dport 443
> 10.10.30.30 via 10.179.2.12 dev ens17f1 src 10.179.20.18 uid 0
>     cache expires 521sec mtu 1500
> 
> ip r g 10.10.30.30 sport 30033 dport 443
> 10.10.30.30 via 10.179.2.140 dev ens17f0 src 10.179.20.18 uid 0
>     cache
> 

well known problem, and years ago I meant to send a similar patch.

Can you add a test case under selftests; you will see many pmtu,
redirect and multipath tests.

> So when host1 tries again to reach host2 with mtu>1500,
> if packet flow is lucky enough to be hashed with oif=ens17f1 its ok,
> if oif=ens17f0 it blackholes and still gets icmp msgs from ro3 to ens17f1,
> until lucky day when ro3 will send it through another flow to ens17f0.
> 
> Signed-off-by: Vladimir Vdovin <deliran@verdict.gg>
> ---
>  net/ipv4/route.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index 723ac9181558..8eac6e361388 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -1027,10 +1027,23 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
>  		struct fib_nh_common *nhc;
>  
>  		fib_select_path(net, &res, fl4, NULL);
> +#ifdef CONFIG_IP_ROUTE_MULTIPATH
> +		if (fib_info_num_path(res.fi) > 1) {
> +			int nhsel;
> +
> +			for (nhsel = 0; nhsel < fib_info_num_path(fi); nhsel++) {
> +				nhc = fib_info_nhc(res.fi, nhsel);
> +				update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
> +					jiffies + net->ipv4.ip_rt_mtu_expires);
> +			}
> +			goto rcu_unlock;
> +		}
> +#endif /* CONFIG_IP_ROUTE_MULTIPATH */
>  		nhc = FIB_RES_NHC(res);
>  		update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
>  				      jiffies + net->ipv4.ip_rt_mtu_expires);
>  	}
> +rcu_unlock:

compiler error when CONFIG_IP_ROUTE_MULTIPATH is not set.

>  	rcu_read_unlock();
>  }
>  
> 
> base-commit: 66600fac7a984dea4ae095411f644770b2561ede


