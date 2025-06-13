Return-Path: <netdev+bounces-197670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F12FAD9897
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B77D17B68A
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 23:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A3B28ECF1;
	Fri, 13 Jun 2025 23:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="PtwTQ81R";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="be1YZTZf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A6C28F51A
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 23:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749856793; cv=none; b=qn8OeLpNulJKPAKTfB8LNJXwRZ+gzG4sC48N4I4Vdrx/gUIGK+QmXwDgRR2shBgyuOORQ2jnmq6O6YqNUqocFCqINAb31fHGxFrVYrfvZqWpcIqQg/tEsV9NHB4HhwE/+Nu1N4HHTzP4d7UXOwcoxl+oGS4TbS8WL7RYkjXpxYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749856793; c=relaxed/simple;
	bh=czMyxVLUMUoebdpMIQ2D6zfDdWFW0XZFRekC/1Q1Zog=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=IKGZuoRQNWXqG5YaStGLL7JkSPJndrWVNi6+pUsFd5zgB1sqP7NzUAKQk+kqzFb5kYsmEZoBRFV3Ph3HuBMVzUUIGeCcoqtwvhjQi9+859HDazQdqNMQtlrrEPylBSe4vziww0Uhs/DdNy6Ute1RnbbPtMC6V9jjs9X9r3aKcd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=PtwTQ81R; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=be1YZTZf; arc=none smtp.client-ip=160.80.4.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 55DNJPNi032545;
	Sat, 14 Jun 2025 01:19:30 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 810B2120589;
	Sat, 14 Jun 2025 01:19:21 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1749856761; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dsxsze9ZUR9dIllIHCcpecyHR+Q/rAFquxA82RU6Rp0=;
	b=PtwTQ81Rsy0Gq838bBV2BmBIWc0BznPssIbFuJ+DNdEYB3hXd9Hs1ytblJNpv/tt8O7pTW
	MCUctNKv+0c6rKDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1749856761; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dsxsze9ZUR9dIllIHCcpecyHR+Q/rAFquxA82RU6Rp0=;
	b=be1YZTZfbEb7oCxYy5aljA0Ocp0ggbHibo348FYw5UJIeshqdm+I0zmFMg7KZrCWomckLg
	xGc8N/pD8tOcXkNfwaTsWqH2z2wFy7/9+zmW4HtvS5k5wfiQJlo+5UPCP2vhpvXKvbJQpy
	l2rl6tzAk6ZEtVIetxfCMcni0yXx1uCk1OyJQn8hwNn5qAvtzzAUsISi0OIrkSJXkwI5Zg
	193djIUZj0h0MKfXNnhYvzUkv2723FrmyjhM2Pb3Kdi+caLlRmRFm0G3J5p2Ehn1Nl2HOr
	SAm/FrYLrkW8qF+NRHF5RQcfx1zpHwDt7/1h//o8ypRvL2Uk5rJkSKJr9PFUDA==
Date: Sat, 14 Jun 2025 01:19:21 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <edumazet@google.com>, <dsahern@kernel.org>,
        <horms@kernel.org>, <petrm@nvidia.com>,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>, stefano.salsano@uniroma2.it,
        paolo.lungaroni@uniroma2.it
Subject: Re: [PATCH net-next 3/4] seg6: Allow End.X behavior to accept an
 oif
Message-Id: <20250614011921.273dffed57221d3af04f008e@uniroma2.it>
In-Reply-To: <20250612122323.584113-4-idosch@nvidia.com>
References: <20250612122323.584113-1-idosch@nvidia.com>
	<20250612122323.584113-4-idosch@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Thu, 12 Jun 2025 15:23:22 +0300
Ido Schimmel <idosch@nvidia.com> wrote:

> Extend the End.X behavior to accept an output interface as an optional
> attribute and make use of it when resolving a route. This is needed when
> user space wants to use a link-local address as the nexthop address.
> 
> Before:
> 
>  # ip route add 2001:db8:1::/64 encap seg6local action End.X nh6 fe80::1 oif eth0 dev sr6
>  # ip route add 2001:db8:2::/64 encap seg6local action End.X nh6 2001:db8:10::1 dev sr6
>  $ ip -6 route show
>  2001:db8:1::/64  encap seg6local action End.X nh6 fe80::1 dev sr6 metric 1024 pref medium
>  2001:db8:2::/64  encap seg6local action End.X nh6 2001:db8:10::1 dev sr6 metric 1024 pref medium
> 
> After:
> 
>  # ip route add 2001:db8:1::/64 encap seg6local action End.X nh6 fe80::1 oif eth0 dev sr6
>  # ip route add 2001:db8:2::/64 encap seg6local action End.X nh6 2001:db8:10::1 dev sr6
>  $ ip -6 route show
>  2001:db8:1::/64  encap seg6local action End.X nh6 fe80::1 oif eth0 dev sr6 metric 1024 pref medium
>  2001:db8:2::/64  encap seg6local action End.X nh6 2001:db8:10::1 dev sr6 metric 1024 pref medium
> 
> Note that the oif attribute is not dumped to user space when it was not
> specified (as an oif of 0) since each entry keeps track of the optional
> attributes that it parsed during configuration (see struct
> seg6_local_lwt::parsed_optattrs).
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  net/ipv6/seg6_local.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>

