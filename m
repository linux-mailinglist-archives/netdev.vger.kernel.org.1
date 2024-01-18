Return-Path: <netdev+bounces-64233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8FFD831DB2
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 17:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCED1F21CA1
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CF825770;
	Thu, 18 Jan 2024 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qQ8vmb5O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121402C194
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 16:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705596023; cv=none; b=T9Fgk88ES9WKLoWg6TJBw0OorTJB/vIdce5Y/9cl13TO02Ux0teNu/7qKuoEiqLF0Tre8FAbbHfC6XBUFWNIxwpVla0DuVgWTgkyjL6JcueWpm8StPXJb4qZAZg4XXjzkZKr1qyNnp+VsL/6HSl4P3ULwaA12flwRZWcYvqphGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705596023; c=relaxed/simple;
	bh=+yGA9rVL6ddnR00ZXq0EiWezS0MO/kpVSRmWwKZLQaM=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding; b=fKfG3pW3m9wnsdLMsMyIp9wzA6S9OH7LnkIVIf2dCwEfnFPeXFA8TvtrrTJjJuqqY1cVjtOMNHNneQHHmnL41HRceVTH0BpO4AQ90KUk6SZR/StNDgkMKVgU3ASPaZL9ZkBmSQU/3p2bp32lYQv1TPiAHWfVUJJ5B1rCfXFczNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qQ8vmb5O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF115C433C7;
	Thu, 18 Jan 2024 16:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705596022;
	bh=+yGA9rVL6ddnR00ZXq0EiWezS0MO/kpVSRmWwKZLQaM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qQ8vmb5OdU9A9Bx+cqWbuFOWwLLAWhuHRm600IJuc8nhmk44w4MyDtTMVeZnbzJwW
	 ggmu/FHhq7bMd6W9t/1tHxmDv89/PO+2nXpPYsW7spnaEjg3rf5zkmsgyrX5DmX0v6
	 4OstMyUFYT4etmGP5S4Kz2tNZ+uLiuw33JmAIPe2NBMMfIT4mK/McCi15MuiMnkF1f
	 4nEKsCwpOwHMKDZiIABxrsnNyFoYmFc7awL7ju1AM94/puWtVZWJ0t7Imacuj3Rpzn
	 1W7eMYPjkU/mZ14AosD01k7SjE3rHnbAPQvnYbFYd/ZgC0+wuHssxNaU2Kib0Ffdgh
	 UE0qZLX057jtQ==
Date: Thu, 18 Jan 2024 08:40:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Salvatore Dipietro
 <dipiets@amazon.com>, alisaidi@amazon.com, benh@amazon.com,
 blakgeof@amazon.com, davem@davemloft.net, dipietro.salvatore@gmail.com,
 dsahern@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v3] tcp: Add memory barrier to tcp_push()
Message-ID: <20240118084020.2326c3ac@kernel.org>
In-Reply-To: <CANn89iLmx=u9_==xr-2OfZRA-B3DQE11_Oz3uP-DNLH7k-HwxQ@mail.gmail.com>
References: <CANn89i+XkcQV6_=ysKACN+JQM=P7SqbfTvhxF+jSwd=MJ6t0sw@mail.gmail.com>
	<20240117231646.22853-1-dipiets@amazon.com>
	<e69835dd96eb2452b8d4a6b431c7d6100b582acd.camel@redhat.com>
	<CANn89iLmx=u9_==xr-2OfZRA-B3DQE11_Oz3uP-DNLH7k-HwxQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Jan 2024 11:42:40 +0100 Eric Dumazet wrote:
> > > diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> > > index ff6838ca2e58..ab9e3922393c 100644
> > > --- a/net/ipv4/tcp.c
> > > +++ b/net/ipv4/tcp.c
> > > @@ -726,6 +726,7 @@ void tcp_push(struct sock *sk, int flags, int mss_now,
> > >               /* It is possible TX completion already happened
> > >                * before we set TSQ_THROTTLED.
> > >                */
> > > +             smp_mb__after_atomic();  
> >
> > Out of sheer ignorance I'm wondering if moving such barrier inside the
> > above 'if' just after 'set_bit' would suffice?  
> 
> I think this would work just fine.

Sorry, "this" as in Paolo's suggestion or "this" as in the v3 patch 
as posted? :)

