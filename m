Return-Path: <netdev+bounces-136848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3552E9A33A9
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 06:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8349285141
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D62165F11;
	Fri, 18 Oct 2024 04:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hXxXfqm2"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318FB2A1A4
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 04:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729224640; cv=none; b=eUUDcRtGfbSJykCouTRf5hNiHal50PAfEmSYZJ3FCznbmz15xNoS1rB4bY3uUMD90cRa+XJUcDWmqpSaa0r32q4Rp2XAoExRdnxqCd2YBD8yG+QORu0Byssu9MIG+UQzL/iznBxCNhaQ/LSoC8dB0Rx/riGdtqyusHb7XGSOGPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729224640; c=relaxed/simple;
	bh=pB0/SIQHDpifii99FLKZIhldOX29oyDePukTu+ZGGgw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uNLrMIbgeq2LwJNoQvkDNMfH7eyDaP87QW6cjxGHXNQMFvDHNUtbqTl+zmU7L1yAlKie5E9+n3iX2Tc9sFvgdqw+vqNZr9cITKbFpYvEwYZ+DCMkGs3jEvovLaWd8C0VWDE44D7SX0LHQLcU1JQ3nLaKlq5kLj89Lxot2WKiNaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hXxXfqm2; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1729224635;
	bh=P6NCaulY4SsQck/tKEIg71JRpUuLgLXnXmMnKEY/PJA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hXxXfqm2NflJxAAiNrdy/J+J9SATDRaI0a5+pQKbw+8qLfmkUdzYcC4cwyam9vvO5
	 vycgga2zrfRC/SeM4TBNm6kOFmW5e1PI8hJ1GEwixXhwLudXSwYkcS5CUFaQ8XwtNe
	 8X1qp25lk95EVtm7k4DR82kD7Tbi7h9nOWIfLdCdH9fvk2TenhE3xqm4w/6aYQW6SW
	 QB75Mh6Wqo1fQ9VDd3ZIhQ5uUsGfx8q5y3HfN45NjAEVawfc4vG/kmDXdMtgtxAg+I
	 pW2pUn1cIVZE/zzbwigF9nM2Ay75yf0G14V0VB8QFRoSafAIlNCa+LZj1i0mkXvFsV
	 hfTftNiVr+GEQ==
Received: from [192.168.14.220] (unknown [159.196.94.230])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id AAA0367F48;
	Fri, 18 Oct 2024 12:10:35 +0800 (AWST)
Message-ID: <b82788e2fb368b31d5f3c942bbfae31035057c2f.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 net-next 13/14] rtnetlink: Return int from
 rtnl_af_register().
From: Matt Johnston <matt@codeconstruct.com.au>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, Roopa
 Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, David
 Ahern <dsahern@kernel.org>, Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 18 Oct 2024 12:10:35 +0800
In-Reply-To: <20241016185357.83849-14-kuniyu@amazon.com>
References: <20241016185357.83849-1-kuniyu@amazon.com>
	 <20241016185357.83849-14-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-16 at 11:53 -0700, Kuniyuki Iwashima wrote:
> The next patch will add init_srcu_struct() in rtnl_af_register(),
> then we need to handle its error.
>=20
> Let's add the error handling in advance to make the following
> patch cleaner.
>=20
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>

The error cleanup changes look correct to me.

Reviewed-by: Matt Johnston <matt@codeconstruct.com.au>

> ---
> Cc: Roopa Prabhu <roopa@nvidia.com>
> Cc: Nikolay Aleksandrov <razor@blackwall.org>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Jeremy Kerr <jk@codeconstruct.com.au>
> Cc: Matt Johnston <matt@codeconstruct.com.au>
> ---
>  include/net/rtnetlink.h |  2 +-
>  net/bridge/br_netlink.c |  6 +++++-
>  net/core/rtnetlink.c    |  4 +++-
>  net/ipv4/devinet.c      |  3 ++-
>  net/ipv6/addrconf.c     |  5 ++++-
>  net/mctp/device.c       | 16 +++++++++++-----
>  net/mpls/af_mpls.c      |  5 ++++-
>  7 files changed, 30 insertions(+), 11 deletions(-)
>=20
> diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
> index 1a6aa5ca74f3..969138ae2f4b 100644
> --- a/include/net/rtnetlink.h
> +++ b/include/net/rtnetlink.h
> @@ -204,7 +204,7 @@ struct rtnl_af_ops {
>  	size_t			(*get_stats_af_size)(const struct net_device *dev);
>  };
> =20
> -void rtnl_af_register(struct rtnl_af_ops *ops);
> +int rtnl_af_register(struct rtnl_af_ops *ops);
>  void rtnl_af_unregister(struct rtnl_af_ops *ops);
> =20
>  struct net *rtnl_link_get_net(struct net *src_net, struct nlattr *tb[]);
> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 6b97ae47f855..3e0f47203f2a 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
> @@ -1924,7 +1924,9 @@ int __init br_netlink_init(void)
>  	if (err)
>  		goto out;
> =20
> -	rtnl_af_register(&br_af_ops);
> +	err =3D rtnl_af_register(&br_af_ops);
> +	if (err)
> +		goto out_vlan;
> =20
>  	err =3D rtnl_link_register(&br_link_ops);
>  	if (err)
> @@ -1934,6 +1936,8 @@ int __init br_netlink_init(void)
> =20
>  out_af:
>  	rtnl_af_unregister(&br_af_ops);
> +out_vlan:
> +	br_vlan_rtnl_uninit();
>  out:
>  	return err;
>  }
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 445e6ffed75e..70b663aca209 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -686,11 +686,13 @@ static const struct rtnl_af_ops *rtnl_af_lookup(con=
st int family)
>   *
>   * Returns 0 on success or a negative error code.
>   */
> -void rtnl_af_register(struct rtnl_af_ops *ops)
> +int rtnl_af_register(struct rtnl_af_ops *ops)
>  {
>  	rtnl_lock();
>  	list_add_tail_rcu(&ops->list, &rtnl_af_ops);
>  	rtnl_unlock();
> +
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(rtnl_af_register);
> =20
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index d81fff93d208..2152d8cfa2dc 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -2812,7 +2812,8 @@ void __init devinet_init(void)
>  	register_pernet_subsys(&devinet_ops);
>  	register_netdevice_notifier(&ip_netdev_notifier);
> =20
> -	rtnl_af_register(&inet_af_ops);
> +	if (rtnl_af_register(&inet_af_ops))
> +		panic("Unable to register inet_af_ops\n");
> =20
>  	rtnl_register_many(devinet_rtnl_msg_handlers);
>  }
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index ac8645ad2537..d0a99710d65d 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -7468,7 +7468,9 @@ int __init addrconf_init(void)
> =20
>  	addrconf_verify(&init_net);
> =20
> -	rtnl_af_register(&inet6_ops);
> +	err =3D rtnl_af_register(&inet6_ops);
> +	if (err)
> +		goto erraf;
> =20
>  	err =3D rtnl_register_many(addrconf_rtnl_msg_handlers);
>  	if (err)
> @@ -7482,6 +7484,7 @@ int __init addrconf_init(void)
>  errout:
>  	rtnl_unregister_all(PF_INET6);
>  	rtnl_af_unregister(&inet6_ops);
> +erraf:
>  	unregister_netdevice_notifier(&ipv6_dev_notf);
>  errlo:
>  	destroy_workqueue(addrconf_wq);
> diff --git a/net/mctp/device.c b/net/mctp/device.c
> index 85cc5f31f1e7..3d75b919995d 100644
> --- a/net/mctp/device.c
> +++ b/net/mctp/device.c
> @@ -535,14 +535,20 @@ int __init mctp_device_init(void)
>  	int err;
> =20
>  	register_netdevice_notifier(&mctp_dev_nb);
> -	rtnl_af_register(&mctp_af_ops);
> +
> +	err =3D rtnl_af_register(&mctp_af_ops);
> +	if (err)
> +		goto err_notifier;
> =20
>  	err =3D rtnl_register_many(mctp_device_rtnl_msg_handlers);
> -	if (err) {
> -		rtnl_af_unregister(&mctp_af_ops);
> -		unregister_netdevice_notifier(&mctp_dev_nb);
> -	}
> +	if (err)
> +		goto err_af;
> =20
> +	return 0;
> +err_af:
> +	rtnl_af_unregister(&mctp_af_ops);
> +err_notifier:
> +	unregister_netdevice_notifier(&mctp_dev_nb);
>  	return err;
>  }
> =20
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index a0573847bc55..1f63b32d76d6 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -2753,7 +2753,9 @@ static int __init mpls_init(void)
> =20
>  	dev_add_pack(&mpls_packet_type);
> =20
> -	rtnl_af_register(&mpls_af_ops);
> +	err =3D rtnl_af_register(&mpls_af_ops);
> +	if (err)
> +		goto out_unregister_dev_type;
> =20
>  	err =3D rtnl_register_many(mpls_rtnl_msg_handlers);
>  	if (err)
> @@ -2773,6 +2775,7 @@ static int __init mpls_init(void)
>  	rtnl_unregister_many(mpls_rtnl_msg_handlers);
>  out_unregister_rtnl_af:
>  	rtnl_af_unregister(&mpls_af_ops);
> +out_unregister_dev_type:
>  	dev_remove_pack(&mpls_packet_type);
>  out_unregister_pernet:
>  	unregister_pernet_subsys(&mpls_net_ops);


