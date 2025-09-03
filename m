Return-Path: <netdev+bounces-219721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BE7B42CB6
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 00:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72DF3B3346
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 22:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC6B2E9ED8;
	Wed,  3 Sep 2025 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yw4W1lVd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774B0155333;
	Wed,  3 Sep 2025 22:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756938213; cv=none; b=eUeKkdIEjDso4uS0UxBJXi7C8oTxW9KGvJw16Ea0Vjpt8IMrxrfXE96cMG8bRJ0cghniLlpn/XAy6aLBQWYluwsPQtTD3hjFMP5yLhLHZPw/Ghj5wpy4Zelvl3EoTjp+VKZX4oH5XPVao00+GnhOO9jpOdpUaeHFq8UCzf3bTD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756938213; c=relaxed/simple;
	bh=jrkblcjGxSiHwQsBa5HDYIOJoo+Comb6dZxIOGsodJA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xu9VJwAdN0m5eJKzDBOXBWxS23XeTZgNjHVGornj6S4zqj/y9EHnbTSkWXMTlOqpGrLCTeatTnvtuYPI8qRhjJ+jutwyWK74Qdz79bFUn5I+okmnNF0kpzPmIUbCsZkIcTT9XogpMq4Lylyp0N1RBf//7++NtGHTxFbw9i4RjMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yw4W1lVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52122C4CEE7;
	Wed,  3 Sep 2025 22:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756938213;
	bh=jrkblcjGxSiHwQsBa5HDYIOJoo+Comb6dZxIOGsodJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yw4W1lVdTw2HhsxWgMLW0uUb8zYiFaLgc8aN24/kXXkMu23QXcNagj1dOsAidxwaF
	 qTlvhFhgRdidp9L3nAfegzmk2PIrP9122rriJFGB5WKpQjsdMB8dI2zAiI9UvyObzP
	 ihCyPZfIP2Py7t4z3Ci/0MDsSuYIVg8pty36Pe0dYhna6/KmyS47cUODUsYh9+EwAk
	 pGifHX9/Vn+fB2PaWcVApaTF8p2bYG5ZdD3wrW/PC34PXrszHd79+XIGxi//NqL/fC
	 C2v9tf3sxs1Hce9shI9EbrJe3P5wQQv6YEtlZ6Jyjs6ZShrK6KEXVFziz8XIYfjKa0
	 zx0i+dqKi1u+w==
Date: Wed, 3 Sep 2025 15:23:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dmitry Safonov <dima@arista.com>
Cc: Dmitry Safonov via B4 Relay <devnull+dima.arista.com@kernel.org>, Eric
 Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Bob Gilligan
 <gilligan@arista.com>, Salam Noureddine <noureddine@arista.com>, Dmitry
 Safonov <0x7f454c46@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/2] tcp: Free TCP-AO/TCP-MD5 info/keys
 without RCU
Message-ID: <20250903152331.2e31b3cf@kernel.org>
In-Reply-To: <CAGrbwDRHOaiBcMecGrE=bdRG6m0aHyk_VBtpN6-g-B92NF=hTA@mail.gmail.com>
References: <20250830-b4-tcp-ao-md5-rst-finwait2-v3-0-9002fec37444@arista.com>
	<20250830-b4-tcp-ao-md5-rst-finwait2-v3-2-9002fec37444@arista.com>
	<20250902160858.0b237301@kernel.org>
	<CAGrbwDRHOaiBcMecGrE=bdRG6m0aHyk_VBtpN6-g-B92NF=hTA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Sep 2025 18:41:39 +0100 Dmitry Safonov wrote:
> > On Sat, 30 Aug 2025 05:31:47 +0100 Dmitry Safonov via B4 Relay wrote:  
> > > Now that the destruction of info/keys is delayed until the socket
> > > destructor, it's safe to use kfree() without an RCU callback.
> > > As either socket was yet in TCP_CLOSE state or the socket refcounter is
> > > zero and no one can discover it anymore, it's safe to release memory
> > > straight away.
> > > Similar thing was possible for twsk already.  
> >
> > After this patch the rcu members of struct tcp_ao* seem to no longer
> > be used?  
> 
> Right. I'll remove tcp_ao_info::rcu in v4.
> For tcp_ao_key it's needed for the regular key rotation, as well as
> for tcp_md5sig_key.

Hm, maybe I missed something. I did a test allmodconfig build yesterday
and while the md5sig_key rcu was still needed, removing the ao_key
didn't cause issues. But it was just a quick test I didn't even config
kconfig is sane.

