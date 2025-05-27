Return-Path: <netdev+bounces-193579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA155AC497F
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 09:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4341898EBE
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 07:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6666B1FCF41;
	Tue, 27 May 2025 07:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="NDpeLKdJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36411B85CC
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 07:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748331987; cv=none; b=p2FnKJjTsSYBMsM4E/6vUVkSd3GPXibKsyKkEPdYh37jvQaLXdFwG70iyzlgFg10wu+5+Fj381kZfSd5TfhTfr6Z3jjdKB0fN2s6fizZeY3rpBIQm0IBwFRAlMXsHBn8QJED7W07z7i56JN4xCryhUq3YPkbT9mcdoN6MH44kwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748331987; c=relaxed/simple;
	bh=i2T3p2EyLKpfma8wlWQvN6kiIYZyZoNEmL0GOLsbc28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HxoBcZzQT23brzDvb8uU+Ga7l/WMZoYKsI7OJF9ZzCBpMlE95URkfxH4Qrpwu8ivbH2mJnoJa2qFr8tEg24bF0ppgnygbG4lOjY8zRzz7ZufzjqeVyafKNa3t0w7QG8RrRYkUGkJPfVCk8I8eYd+Fiqk93LglZkYbsD+7nrz/D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=NDpeLKdJ; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-604bde84d0fso2273417a12.3
        for <netdev@vger.kernel.org>; Tue, 27 May 2025 00:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748331983; x=1748936783; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=v0f6FCwOWwM+Arg3uaMTCy41zKGE5RFmE6l80FIBOOg=;
        b=NDpeLKdJ/qP3z9IPyyCfZL9TTE+eq59cTQeoPwCC0WOUPXiPAP3EZWsuD4fYv7yoZP
         coUM4jqPMbhF0O5saTI7jCTUvBtm7M/qVLvRFwSyc9Gv+19YK+9dDYEwVSjIOwygX6gh
         2JKqFtImGpkXSxLejYiIvwT7z0AHvHVSHL8uRiT7Cj8PsAvGNrZTvmb5N/74sxKJqYv3
         ggR3HYlrEUpxSMVm54Xmhc67kyelun35CofFZdX3pSn+fuNZnOGb8IAvV5IXE2CnWAh3
         i7eNRq3P8q9R9MwprnP7IyC6BG61a/C/9dScmGiTN5tyWph+bN+pROAypm+Z/svC6IGp
         IBFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748331983; x=1748936783;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v0f6FCwOWwM+Arg3uaMTCy41zKGE5RFmE6l80FIBOOg=;
        b=fxdenKN+6jpvGV3PkMVjkEhonXM1ZlLZoqsEDGvOHtbIUeiPnL+QOk34tseekMvA6K
         G7sd27xVTZH2kXSPHe1LBJVgXjOm787QYwoPrMIMztEq75kylRwr+i1PpQZYNcS1vfA9
         lih91KGQ+UW6i1HnqoFeXO3pa8InE3/bWMVLnyK20vkbAPXg5BizvFw/rbYjQ6EkY8rV
         Nr1qTgFZMo7RGYCWtfOgkeRQe2FuQkDpwuYHPl51mj8riSLQIhbzP98a4PRjWGaf6Duv
         tmoFdOPZZ1iUNkIMS/mRaTsxsSI/SUK2utS5YPiAnfClYXFehxbBiKGTNPeUyuz/qGOU
         EWJA==
X-Forwarded-Encrypted: i=1; AJvYcCWZ8DjOSpxhExmOnaSZfquXrTOTALujv4/6JNX6trm9nb+C7vHbrZCIVpCcpZLGXGHN4Wo99Ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtNB/SxmTpCaq3raixSLBrP1F9aACI5zYBYHtvNnEjYXe/9dwG
	iYt4s7NwzvqouNckqJzUkwfqTUUsk496DZryx/5bkzL1Ecwyrshs+2rIYfM9Jt3Wa/6YaAdgrr6
	KPV3F9K16iOm9DyUZRigryVdhG2CFvJlT6rcEM8s0e22NX3a0zlA=
X-Gm-Gg: ASbGncvVLOPI6nZ3nQXoL6arHAsnRqFRMkK78vZnnWonduUs3wan0muKp0/tgVvRymw
	2WOeQ3kmwb0xZbAgMHLNS0L5UE/LoL+DD3bWSTV15c3w3cMJhqLa8WSJ2ldpvS93/QnQVqx3noG
	ME3Wa0+Q+M8n56dRnxS7AQYOagtLSw8jL631Em2a0Hr7XunRtLG3hAbHaJTwf2CGrQYCkJjheSG
	pkYZCwqrkxJ2v1DlA2otv8U1y14/1FJOAHWOZfly63RoAdaYd7J7QMK/eS21UUT+7yuOBKprcbT
	t7Sz8aztuO4L1aBtnqR+CLiEkO8c/a2OAzORzfDhkcowMOP89gFAyyS8f7vqf+FaWFrNqh81e99
	qLO2pbuJ+SMPNEw==
X-Google-Smtp-Source: AGHT+IFWy9zqG2KMEKmNyKq2TlHsRqIslAss3Q/6hVpdUMw4T4b5lNsaUBUtz6MxDg3rXkWvjRrfmg==
X-Received: by 2002:a17:907:8686:b0:ad5:2328:e39b with SMTP id a640c23a62f3a-ad85b16cf5amr1053571466b.31.1748331982898;
        Tue, 27 May 2025 00:46:22 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:4361:ed83:f62f:c07b? ([2001:67c:2fbc:1:4361:ed83:f62f:c07b])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d4967e2sm1792611266b.128.2025.05.27.00.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 00:46:22 -0700 (PDT)
Message-ID: <2fdfcff0-aa80-4098-95e1-55d8733b7bc1@openvpn.net>
Date: Tue, 27 May 2025 09:46:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] ovpn: properly deconfigure UDP-tunnel
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sabrina Dubroca <sd@queasysnail.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>, netdev@vger.kernel.org
References: <20250522140613.877-1-antonio@openvpn.net>
 <20250522140613.877-2-antonio@openvpn.net>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250522140613.877-2-antonio@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jakub,

please refrain from pulling this series.

While stress testing the code in this patch, we realized that:

1) udp_tunnel_encap_disable() is calling the wrong bit-related function 
(copy/paste error);

2) cleanup_udp_tunnel_sock() can race with udp_destroy_socket() and lead 
to a double decrease of udp_encap_needed_key.

We have already developed and verified the fixes, which I will send with 
a following PR.

Should I already target 'net' (even though there is no 6.16-rc1 yet)?

Regards,

On 22/05/2025 16:06, Antonio Quartulli wrote:
> When deconfiguring a UDP-tunnel from a socket, we cannot
> call setup_udp_tunnel_sock(), as it is expected to be invoked
> only during setup.
> 
> Implement a new function named cleanup_udp_tunnel_sock(),
> that reverts was what done during setup, and invoke it.
> 
> This new function takes care of reverting everything that
> was done by setup_udp_tunnel_sock() (i.e. unsetting various
> members and cleaning up the encap state in the kernel).
> 
> Note that cleanup_udp_tunnel_sock() takes 'struct sock'
> as argument in preparation for a follow up patch, where
> 'struct ovpn' won't hold any reference to any 'struct socket'
> any more, but rather to its 'struct sock' member only.
> 
> Moreover implement udpv6_encap_disable() in order to
> allow udpv6_encap_needed_key to be decreased outside of
> ipv6.ko (similarly to udp_encap_disable() for IPv4).
> 
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Simon Horman <horms@kernel.org>
> Cc: David Ahern <dsahern@kernel.org>
> Cc: Sabrina Dubroca <sd@queasysnail.net>
> Cc: Oleksandr Natalenko <oleksandr@natalenko.name>
> Reported-by: Paolo Abeni <pabeni@redhat.com>
> Closes: https://lore.kernel.org/netdev/1a47ce02-fd42-4761-8697-f3f315011cc6@redhat.com
> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> ---
>   drivers/net/ovpn/udp.c     |  5 +----
>   include/net/ipv6_stubs.h   |  1 +
>   include/net/udp.h          |  1 +
>   include/net/udp_tunnel.h   | 13 +++++++++++++
>   net/ipv4/udp_tunnel_core.c | 22 ++++++++++++++++++++++
>   net/ipv6/af_inet6.c        |  1 +
>   net/ipv6/udp.c             |  6 ++++++
>   7 files changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> index aef8c0406ec9..c8a81c4d6489 100644
> --- a/drivers/net/ovpn/udp.c
> +++ b/drivers/net/ovpn/udp.c
> @@ -442,8 +442,5 @@ int ovpn_udp_socket_attach(struct ovpn_socket *ovpn_sock,
>    */
>   void ovpn_udp_socket_detach(struct ovpn_socket *ovpn_sock)
>   {
> -	struct udp_tunnel_sock_cfg cfg = { };
> -
> -	setup_udp_tunnel_sock(sock_net(ovpn_sock->sock->sk), ovpn_sock->sock,
> -			      &cfg);
> +	cleanup_udp_tunnel_sock(ovpn_sock->sock->sk);
>   }
> diff --git a/include/net/ipv6_stubs.h b/include/net/ipv6_stubs.h
> index 8a3465c8c2c5..2a57df87d11b 100644
> --- a/include/net/ipv6_stubs.h
> +++ b/include/net/ipv6_stubs.h
> @@ -55,6 +55,7 @@ struct ipv6_stub {
>   			       struct nl_info *info);
>   
>   	void (*udpv6_encap_enable)(void);
> +	void (*udpv6_encap_disable)(void);
>   	void (*ndisc_send_na)(struct net_device *dev, const struct in6_addr *daddr,
>   			      const struct in6_addr *solicited_addr,
>   			      bool router, bool solicited, bool override, bool inc_opt);
> diff --git a/include/net/udp.h b/include/net/udp.h
> index a772510b2aa5..e3d7b8622f59 100644
> --- a/include/net/udp.h
> +++ b/include/net/udp.h
> @@ -580,6 +580,7 @@ void udp_encap_disable(void);
>   #if IS_ENABLED(CONFIG_IPV6)
>   DECLARE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
>   void udpv6_encap_enable(void);
> +void udpv6_encap_disable(void);
>   #endif
>   
>   static inline struct sk_buff *udp_rcv_segment(struct sock *sk,
> diff --git a/include/net/udp_tunnel.h b/include/net/udp_tunnel.h
> index 2df3b8344eb5..843e7c11e5ee 100644
> --- a/include/net/udp_tunnel.h
> +++ b/include/net/udp_tunnel.h
> @@ -92,6 +92,7 @@ struct udp_tunnel_sock_cfg {
>   /* Setup the given (UDP) sock to receive UDP encapsulated packets */
>   void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
>   			   struct udp_tunnel_sock_cfg *sock_cfg);
> +void cleanup_udp_tunnel_sock(struct sock *sk);
>   
>   /* -- List of parsable UDP tunnel types --
>    *
> @@ -218,6 +219,18 @@ static inline void udp_tunnel_encap_enable(struct sock *sk)
>   	udp_encap_enable();
>   }
>   
> +static inline void udp_tunnel_encap_disable(struct sock *sk)
> +{
> +	if (udp_test_and_set_bit(ENCAP_ENABLED, sk))
> +		return;
> +
> +#if IS_ENABLED(CONFIG_IPV6)
> +	if (READ_ONCE(sk->sk_family) == PF_INET6)
> +		ipv6_stub->udpv6_encap_disable();
> +#endif
> +	udp_encap_disable();
> +}
> +
>   #define UDP_TUNNEL_NIC_MAX_TABLES	4
>   
>   enum udp_tunnel_nic_info_flags {
> diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
> index 2326548997d3..624b6afcf812 100644
> --- a/net/ipv4/udp_tunnel_core.c
> +++ b/net/ipv4/udp_tunnel_core.c
> @@ -98,6 +98,28 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
>   }
>   EXPORT_SYMBOL_GPL(setup_udp_tunnel_sock);
>   
> +void cleanup_udp_tunnel_sock(struct sock *sk)
> +{
> +	/* Re-enable multicast loopback */
> +	inet_set_bit(MC_LOOP, sk);
> +
> +	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
> +	inet_dec_convert_csum(sk);
> +
> +	udp_sk(sk)->encap_type = 0;
> +	udp_sk(sk)->encap_rcv = NULL;
> +	udp_sk(sk)->encap_err_rcv = NULL;
> +	udp_sk(sk)->encap_err_lookup = NULL;
> +	udp_sk(sk)->encap_destroy = NULL;
> +	udp_sk(sk)->gro_receive = NULL;
> +	udp_sk(sk)->gro_complete = NULL;
> +
> +	rcu_assign_sk_user_data(sk, NULL);
> +	udp_tunnel_encap_disable(sk);
> +	udp_tunnel_cleanup_gro(sk);
> +}
> +EXPORT_SYMBOL_GPL(cleanup_udp_tunnel_sock);
> +
>   void udp_tunnel_push_rx_port(struct net_device *dev, struct socket *sock,
>   			     unsigned short type)
>   {
> diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
> index acaff1296783..f3745705a811 100644
> --- a/net/ipv6/af_inet6.c
> +++ b/net/ipv6/af_inet6.c
> @@ -1049,6 +1049,7 @@ static const struct ipv6_stub ipv6_stub_impl = {
>   	.fib6_rt_update	   = fib6_rt_update,
>   	.ip6_del_rt	   = ip6_del_rt,
>   	.udpv6_encap_enable = udpv6_encap_enable,
> +	.udpv6_encap_disable = udpv6_encap_disable,
>   	.ndisc_send_na = ndisc_send_na,
>   #if IS_ENABLED(CONFIG_XFRM)
>   	.xfrm6_local_rxpmtu = xfrm6_local_rxpmtu,
> diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
> index 7317f8e053f1..2f40aa605c82 100644
> --- a/net/ipv6/udp.c
> +++ b/net/ipv6/udp.c
> @@ -602,6 +602,12 @@ void udpv6_encap_enable(void)
>   }
>   EXPORT_SYMBOL(udpv6_encap_enable);
>   
> +void udpv6_encap_disable(void)
> +{
> +	static_branch_dec(&udpv6_encap_needed_key);
> +}
> +EXPORT_SYMBOL(udpv6_encap_disable);
> +
>   /* Handler for tunnels with arbitrary destination ports: no socket lookup, go
>    * through error handlers in encapsulations looking for a match.
>    */

-- 
Antonio Quartulli
OpenVPN Inc.


