Return-Path: <netdev+bounces-176260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690DBA69889
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 20:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9721B19C4F31
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFC3211A1D;
	Wed, 19 Mar 2025 19:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eILa/PEG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A919220C48E
	for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410846; cv=none; b=LAlvMvRKMJjISoZcCf8UPGGPQr7it9PszBxUthWMTMztgi4t6vRzJgvSAJDpk4Wod77luySQSZM6fE5oBGJwRnevNSDBkxQhQwEuO/loTn+FgDoMBE2v/MH9u5zht34/qREH5LkvbgyfjK9HLVQdZSMxPeZI4h2xOyvIitGwJ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410846; c=relaxed/simple;
	bh=3sSkP2l2Uf1bIGM8mDACVKydgQ0cyMtdnMA7cfmVoi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tYxvIwdneDGvYFlY7mPmWYul5+IYtpg2dvnIs4aD95RVjhoYrGFjr0AwE9lBYWLyWmfHxf9rIe8Fca6PBHb7UMbnvnF+qT1YjHNPEippv9QORsfN9X6cbVK7npxZR7LvlfYmndVpSR/6aXn49P4Mr6/wGGhPARQsGG3Uuj7Nd5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eILa/PEG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso6593983f8f.2
        for <netdev@vger.kernel.org>; Wed, 19 Mar 2025 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1742410842; x=1743015642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7zgEL8Mx8/B7Q/0PZEH0TfrlyQlRsXZt3StXoAekBKo=;
        b=eILa/PEGrsR7c8ge2emnKBgR4rkZmqxzLm2e3ldAlTTTislgIO2GSwQxiyT66KhukC
         8hYgS6eJqd7BRDjfpwgSHslsxc44owHGn/x+DUUzpfzpHJFAhezxjeWrb5XNg+e6aGC2
         Y0IM8xB3EuL9BFMAk57swISrJqLyrHzM6ZiRmiYDdYkI0/UF9YPGfel96Adwuc14WMaC
         5kFvALTgfM3uVWbixM+2dZZqZNJIWeL7U4yh67kvqjJGua4OJqJsr1ZU0rhAH3u1BuuM
         sXR/Q84Lf5rvWxdcQZfNyA2DmsXsZBj4wqp2orJCSmO1yxBtolPGXQe5l0FpcwR3w5xI
         aFFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742410842; x=1743015642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7zgEL8Mx8/B7Q/0PZEH0TfrlyQlRsXZt3StXoAekBKo=;
        b=QGzf3L6jlBQC3Oqigh9H8tJkF7JhVDj7dwBwKUnVHQEUT0A0LgawYvmOz0rvKCFc0s
         x2wPvVPhHeec+t2DRQYTyrlxxf+djzAsIgvoD1uo9XjpIMUyPwgIz7EIbVbNl/w80U/p
         28rqrMTAUlRso1l+SAjjPdI84cIkYXWs9QQ7RjWhG43ksm48xd2DnC+8UBrXEHwwzVNW
         PffMDLxWp/k7vKl9xdaPs76yrZ7wIGbkMalNR7RFb9kpU28Yox8UfmO+6yJXVeKfAxcT
         MsHPxB4qj8cWaQLYaTpFwNdOP1VuYs3BYb9GQCQD9Z/V8p81lKZz9DlNol7FfFH7+Shv
         Jcjw==
X-Forwarded-Encrypted: i=1; AJvYcCVMQ/bB8OYWS3/rOCrH8n2rJPMrl+J+11GoTYTZL77Az/3rMLv6GMVev5WcAX2jINy3uUDSVlc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh5a/gJHcPz+wvSmOLDBcfwQHVg+kuoOZcTQ/uWua7m640Px3e
	XlHuyFn0r7qvHmBVo9mXojtNsMe6Rp3qrbvFYl5ODu6RMiept0kmo6X6we2+zAc=
X-Gm-Gg: ASbGncuWU+ExbMXfaTgBS1FaMZM4GUSiC8x7W+PvY5DKI25ienolvZPiYAdi2krJqTK
	zdAs8QbSHNjfPhOLuPwmHv8J4AmZUDQis1Ylp4cQEVTrJCRudgt4XkZqrz+8KONCjd7XGEkBY4Z
	ep6hX4lczY0epn4Wpesnzfq8JcYuqzeCxEIQITmNVQ7NE0/Melzt691OrXWMwfF2SxKkvFeCHHn
	bawo2PWtThSQpwbQF1egIs4fBFdflLuN/ljw0Ngmayn76WT2dmyhwjnaB5Knv8alcFlGMwUhyEB
	+fSUHR2g8jI+nKKm5KaKJpzj6ZYRmNWXLAkhgb9F44/SxEo4C183BlfXnwcj
X-Google-Smtp-Source: AGHT+IGyMDvYfspCQT78uhsvlh24pX9FnXD8UzlfC9oEilO5QDfsmKkmRkCbD3pHrVgGuTpZmexMzA==
X-Received: by 2002:a5d:6487:0:b0:38f:2a49:f6a5 with SMTP id ffacd0b85a97d-399795acc99mr630336f8f.15.1742410841802;
        Wed, 19 Mar 2025 12:00:41 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb40fab8sm22335475f8f.63.2025.03.19.12.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:00:41 -0700 (PDT)
Date: Wed, 19 Mar 2025 22:00:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next] xfrm: Remove unnecessary NULL check in
 xfrm_lookup_with_ifid()
Message-ID: <81d101da-45a3-4e2d-8bb9-4401efe0c44e@stanley.mountain>
References: <2eebea1e-5258-4bcb-9127-ca4d7c59e0e2@stanley.mountain>
 <6365c171-5550-4640-92bc-0151a4de61a1@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6365c171-5550-4640-92bc-0151a4de61a1@redhat.com>

On Wed, Mar 19, 2025 at 06:38:49PM +0100, Paolo Abeni wrote:
> On 3/12/25 6:21 PM, Dan Carpenter wrote:
> > This NULL check is unnecessary and can be removed.  It confuses
> > Smatch static analysis tool because it makes Smatch think that
> > xfrm_lookup_with_ifid() can return a mix of NULL pointers and errors so
> > it creates a lot of false positives.  Remove it.
> > 
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > I have wanted to remove this NULL check for a long time.  Someone
> > said it could be done safely.  But please, please, review this
> > carefully.
> 
> I think it's better if this patch goes first into the ipsec/xfrm tree,
> so that hopefully it gets some serious testing before landing into net-next.
> 
> @Steffen, @Herber: could you please take this in your tree?
> 

Thanks.  The issue for me is that I've had a check which complains that
the caller doesn't check for NULL but I've expanded the check and now
there are 16 new warnings.

regards,
dan carpenter

net/mpls/af_mpls.c:633 inet6_fib_lookup_dev() warn: 'dst' can also be NULL
net/xfrm/xfrm_policy.c:2926 xfrm_policy_queue_process() warn: 'dst' can also be NULL
net/xfrm/xfrm_interface_core.c:463 xfrmi_xmit2() warn: 'dst' can also be NULL
net/core/lwt_bpf.c:242 bpf_lwt_xmit_reroute() warn: 'dst' can also be NULL
net/l2tp/l2tp_ip6.c:673 l2tp_ip6_sendmsg() warn: 'dst' can also be NULL
net/l2tp/l2tp_ip6.c:673 l2tp_ip6_sendmsg() warn: 'dst' can also be NULL
net/dccp/ipv6.c:949 dccp_v6_connect() warn: 'dst' can also be NULL
net/ipv4/ip_vti.c:223 vti_xmit() warn: 'dst' can also be NULL
net/ipv6/syncookies.c:249 cookie_v6_check() warn: 'dst' can also be NULL
net/ipv6/syncookies.c:259 cookie_v6_check() warn: 'dst' can also be NULL
net/ipv6/ip6_udp_tunnel.c:171 udp_tunnel6_dst_lookup() warn: 'dst' can also be NULL
net/ipv6/ip6_tunnel.c:1182 ip6_tnl_xmit() warn: 'dst' can also be NULL
net/ipv6/af_inet6.c:859 inet6_sk_rebuild_header() warn: 'dst' can also be NULL
net/ipv6/ip6_vti.c:489 vti6_xmit() warn: 'dst' can also be NULL
net/ipv6/ila/ila_lwt.c:92 ila_output() warn: 'dst' can also be NULL
net/ipv6/ndisc.c:510 ndisc_send_skb() warn: 'dst' can also be NULL
net/ipv6/inet6_connection_sock.c:109 inet6_csk_route_socket() warn: 'dst' can also be NULL
net/ipv6/tcp_ipv6.c:283 tcp_v6_connect() warn: 'dst' can also be NULL
net/ipv6/netfilter/nf_reject_ipv6.c:316 nf_send_reset6() warn: 'dst' can also be NULL
net/ipv6/raw.c:929 rawv6_sendmsg() warn: 'dst' can also be NULL
net/ipv6/raw.c:929 rawv6_sendmsg() warn: 'dst' can also be NULL
net/ipv6/datagram.c:114 ip6_datagram_dst_update() warn: 'dst' can also be NULL
drivers/net/vrf.c:447 vrf_process_v6_outbound() warn: 'dst' can also be NULL
drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c:1156 chtls_recv_sock() warn: 'dst' can also be NULL
drivers/net/ethernet/netronome/nfp/flower/action.c:475 nfp_fl_set_tun() warn: 'dst' can also be NULL
drivers/net/ethernet/netronome/nfp/flower/tunnel_conf.c:826 nfp_tunnel_request_route_v6() warn: 'dst' can also be NULL
drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c:464 mlx5e_route_lookup_ipv6_get() warn: 'dst' can also be NULL
drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c:466 mlx5e_route_lookup_ipv6_get() warn: 'dst' can also be NULL
drivers/net/wireguard/socket.c:153 send6() warn: 'dst' can also be NULL
drivers/infiniband/core/addr.c:434 addr6_resolve() warn: 'dst' can also be NULL

