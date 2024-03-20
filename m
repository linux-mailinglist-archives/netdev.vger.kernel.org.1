Return-Path: <netdev+bounces-80775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B76288108A
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 12:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D915B23A92
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 11:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCBB3BB3D;
	Wed, 20 Mar 2024 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hd1hhKpi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3DD3B1B2
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710933079; cv=none; b=SsyEsp4/mQhwD0HZfcFt1CPpmZDPNNJMVo46qZKBYGzqfqR8JJl3xNoYy/seZzWn9hd+A+kU3ki/vxziuuMl2cALVtn0OYuKt+pe9aDAdXPti18ilLpiaKo6Jkm7OMm8TnARzTLbZJpjp+9IrdB9C0s+aiztUYJj8IXCy8Bx2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710933079; c=relaxed/simple;
	bh=pdchhpQnt3CQHuZw8DTa8vf5YnjfPZ9D1i3TB34sEQA=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:Cc:
	 To:Date:Message-ID; b=CtWZpsV00XYGt/uU54xu35r9PnZDgWFQiNPhAPEe2mPZ2Fsw9PBe2B5Mz/O5gWixvXVIhg9ff7/aMCLxB9k9biPxVuVuHuWbP2be8W3I6jiwDUKF/Yv3kLzLH62SjWSIzIUA1TyHioWJGM6SOvjApyOrvucvCg3XDcXeiiqTq2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hd1hhKpi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD795C433C7;
	Wed, 20 Mar 2024 11:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710933079;
	bh=pdchhpQnt3CQHuZw8DTa8vf5YnjfPZ9D1i3TB34sEQA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Hd1hhKpiw/xhzQGYn4hJjf3rapHhglHSMRDNuyKeSovAYqHJDCtGP0taQM9GjhleQ
	 e62wimEJTgU/ZUeH0IYb7BsQUiLF+5vC+qF4JD8Qjp9HzGYBjfSKkNn0mdBogQ8ewz
	 IezPjittlAoh79R2T+tfYLcgyq2GWB0bsLqyAAnlLBUto4U7Lblz9GDjkTU060Vd4V
	 qJEYbkKIJEtH4w8ikzctARvBphkyFbb5pPsdOgNJ1rNFUksGELHiP/WmJNFZzpL9YQ
	 InLXGo8DbWPdVi4ucDsqrkfy+u/PSktV+h47H2IcVvT4+eTcaBXlrwG3xAAfsqCAHL
	 b14Sad3riX9gw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240319194124.25097f5a@kernel.org>
References: <20240319093140.499123-1-atenart@kernel.org> <20240319093140.499123-2-atenart@kernel.org> <20240319194124.25097f5a@kernel.org>
Subject: Re: [PATCH net v2 1/4] udp: do not accept non-tunnel GSO skbs landing in a tunnel
From: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com, steffen.klassert@secunet.com, willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org, Willem de Bruijn <willemb@google.com>
To: Jakub Kicinski <kuba@kernel.org>
Date: Wed, 20 Mar 2024 12:11:16 +0100
Message-ID: <171093307600.5492.12887061012668630550@kwain>

Quoting Jakub Kicinski (2024-03-20 03:41:24)
> On Tue, 19 Mar 2024 10:31:36 +0100 Antoine Tenart wrote:
> > +DECLARE_STATIC_KEY_FALSE(udp_encap_needed_key);
>=20
> nit: our build bot says you need to export this as well for v6=3Dm.

Thanks for the heads up, missed that. And udpv6_encap_needed_key needs
to be defined outside ipv6.ko and exported as well. The following should
fix the remaining build issues,

  diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
  index 661d0e0d273f..c02bf011d4a6 100644
  --- a/net/ipv4/udp.c
  +++ b/net/ipv4/udp.c
  @@ -582,6 +582,13 @@ static inline bool __udp_is_mcast_sock(struct net *n=
et, const struct sock *sk,
   }

   DEFINE_STATIC_KEY_FALSE(udp_encap_needed_key);
  +EXPORT_SYMBOL(udp_encap_needed_key);
  +
  +#if IS_ENABLED(CONFIG_IPV6)
  +DEFINE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
  +EXPORT_SYMBOL(udpv6_encap_needed_key);
  +#endif
  +
   void udp_encap_enable(void)
   {
          static_branch_inc(&udp_encap_needed_key);
  diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
  index 7c1e6469d091..8b1dd7f51249 100644
  --- a/net/ipv6/udp.c
  +++ b/net/ipv6/udp.c
  @@ -447,7 +447,7 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg=
, size_t len,
          goto try_again;
   }

  -DEFINE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
  +DECLARE_STATIC_KEY_FALSE(udpv6_encap_needed_key);
   void udpv6_encap_enable(void)
   {
          static_branch_inc(&udpv6_encap_needed_key);

Thanks!
Antoine

