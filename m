Return-Path: <netdev+bounces-262471-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6fzkEDbqpGmhvgUAu9opvQ
	(envelope-from <netdev+bounces-262471-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 02:39:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 370C81D2557
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 02:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C28C930055FC
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 01:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5731A9F90;
	Mon,  2 Mar 2026 01:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m0EnvhAd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9B013B58C
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 01:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772415534; cv=none; b=i2MsMPWuNmPypErhqmtos04of7NhDv7bG8OX309hCbpPNQdn7n65HBXVxJJF0uJWlEJ2IgLyFPFWgP1/OpS4OvwXNMJFng5wMxNj57vd6CK6SnrFfX7d/xpJtTy8MxwHxVdqFpiinpKiCcyAdMgKQ9Te3i9fDmHl35MtJHweOto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772415534; c=relaxed/simple;
	bh=gCR/VUAdErCYtTJeVNqXaOxY519eMv9wYj2Rl/+Pn+0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uadk86hh5c2DsdLrMXpbEE4GjXL66IqnedDIp2+sTHk6oHM3CtWd4/fJ9KfeOwTsjjf/As2mYUNHdIl5hD016wB6C76JS3TRc8k/hLIBCxo66fqb7oFPLJyUqA90B+e0qM5Z06VbonxiejxI7bV+wD9ZueE3h6bi5Q7Op6q6mA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m0EnvhAd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B046C116C6;
	Mon,  2 Mar 2026 01:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772415534;
	bh=gCR/VUAdErCYtTJeVNqXaOxY519eMv9wYj2Rl/+Pn+0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=m0EnvhAd9gwism0gztuQKDUv6J64W3T6l70v/vXnre9+LWC0lEWo9px71AusljJ0t
	 xdWtl76w9feoDJq3LVIXfNHYLeNjoRu1JYmfyzes5LjlJwM6QLGTYbSsWFudNYFzBX
	 HjhrLJBUAp/eUWYkfa1FqkHtA34Wg3VUcIn81anpwjgdeHjpnPyfslWdKA05kOMppe
	 B1SzaesFncIoTkFEscerRpgz6YnzhRiNgYHeoNRJgC+W2/WgSBYa2yf3XY/t2hAy47
	 qWC6o6I0YdwGamJ9vCzUrqNTNafdUH/wMda+8UM5QZPewtDTLR2JKSIKV1B3XEin9d
	 Af91ThuTtACcA==
Message-ID: <859d39ff-cb1e-4f3f-b154-d8bf2c7997c9@kernel.org>
Date: Sun, 1 Mar 2026 18:38:53 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ipv6: fix NULL pointer deref in ip6_rt_get_dev_rcu()
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
References: <20260301194548.927324-1-kuba@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260301194548.927324-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262471-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 370C81D2557
X-Rspamd-Action: no action

On 3/1/26 12:45 PM, Jakub Kicinski wrote:
> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> index 85df25c36409..7db0c837196c 100644
> --- a/net/ipv6/route.c
> +++ b/net/ipv6/route.c
> @@ -1063,7 +1063,8 @@ static struct net_device *ip6_rt_get_dev_rcu(const struct fib6_result *res)
>  		 */
>  		if (netif_is_l3_slave(dev) &&
>  		    !rt6_need_strict(&res->f6i->fib6_dst.addr))
> -			dev = l3mdev_master_dev_rcu(dev);
> +			dev = l3mdev_master_dev_rcu(dev) ? :
> +			      dev_net(dev)->loopback_dev;

how can the flag on the netdev say there is L3 master, yet the device
not be there within an rcu window?


>  		else if (!netif_is_l3_master(dev))
>  			dev = dev_net(dev)->loopback_dev;
>  		/* last case is netif_is_l3_master(dev) is true in which


