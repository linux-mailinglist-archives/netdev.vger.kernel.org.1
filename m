Return-Path: <netdev+bounces-201586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A41C9AE9FE5
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 16:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B2B07A40CC
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0581E2E175E;
	Thu, 26 Jun 2025 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VozIhQeB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D503228FFEE
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 14:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750946881; cv=none; b=dcdYkfF0Osxzt43q6T/pIJAVhNCR9s9MvLJhLRp0K0U0snh5YPcRuB9/VDiYQbj3Uoeun2STEnithy4muepZ/+jKq0Y7KLje3H1iEC1XbU6/wSfSoEa9LwIakxs3qLHPRelepVieTHBXMUZn+pkDcWautAPYaCO45EDnU/LAQ6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750946881; c=relaxed/simple;
	bh=ICqQsH9iCvctYbV/Mpp5zhuTDztdXpXcAPxSLdZEKx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Podit/fWQztEf7CMrAcILT88mTvUrWkXvgwXCJAol46KPP08lSIIs3rFS3yQFpOwK0+t8t/ZGzQ2JQpR/gLdobGeryQxFdnMyemD6hi65+Za7Pkw/mmOGVVhyGcDw0SOfb3bDbg3R05SapSYMEPneR+VqJoaKQGdW4i6HRYuZEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VozIhQeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F09C4CEEB;
	Thu, 26 Jun 2025 14:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750946881;
	bh=ICqQsH9iCvctYbV/Mpp5zhuTDztdXpXcAPxSLdZEKx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VozIhQeBO7VLSy8/tUg+gzx57cxqHr19zdOAu7JqQPdEMOLuq+dkSiVEflT49KnM1
	 ydhgx63uJUyiLFipkn95G9ditL4CgRFWtAScmG/N1db098YUijdRouTvJck5fi3h3y
	 Xk7Y1xaJW2CQv8GOYEz3+zufH+ionqMGR/NcqByO6h8jl2W2kgY/hMlK+e5cIkBhFI
	 kps1yrPninGhvhjRsgkqk3tJX/wU2zc5/iQWkJVxg5UJtEgPQG+bqNrlx2nhdefuJh
	 ZaQOCXWEphbCY2YgCoqQ+YTvEgK/6TUG1bWf70epAcrHegPZlmqMxOzwb25c0gMKWb
	 0ke6kBmdRfhyw==
Date: Thu, 26 Jun 2025 07:07:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Boris
 Pismenny <borisp@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>, Willem
 de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, Neal
 Cardwell <ncardwell@google.com>, Patrisious Haddad <phaddad@nvidia.com>,
 Raed Salem <raeds@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Dragos
 Tatulea <dtatulea@nvidia.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdl?=
 =?UTF-8?B?bnNlbg==?= <toke@redhat.com>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Jacob Keller <jacob.e.keller@intel.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH v2 04/17] tcp: add datapath logic for PSP with inline
 key exchange
Message-ID: <20250626070759.08d41566@kernel.org>
In-Reply-To: <685c8ef72e61f_2a5da429434@willemb.c.googlers.com.notmuch>
References: <20250625135210.2975231-1-daniel.zahka@gmail.com>
	<20250625135210.2975231-5-daniel.zahka@gmail.com>
	<685c8ef72e61f_2a5da429434@willemb.c.googlers.com.notmuch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Jun 2025 20:06:15 -0400 Willem de Bruijn wrote:
> > @@ -2068,7 +2074,8 @@ bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
> >  	     (TCPHDR_ECE | TCPHDR_CWR | TCPHDR_AE)) ||
> >  	    !tcp_skb_can_collapse_rx(tail, skb) ||
> >  	    thtail->doff != th->doff ||
> > -	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)))
> > +	    memcmp(thtail + 1, th + 1, hdrlen - sizeof(*th)) ||
> > +	    psp_skb_coalesce_diff(tail, skb))
> >  		goto no_coalesce;  
> 
> Since this is a "can these skbs be coalesced" condition check, move it
> inside tcp_skb_can_collapse_rx?

I think the idea was that once the packet is added to the socket rcv
queue we don't really care what exact PSP state it had. I must had
matched what the socket wanted if it got in. The decrypted bit is all
we care about. But packets in the backlog are not fully validated, yet,
so we need an exact comparison.

