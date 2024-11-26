Return-Path: <netdev+bounces-147439-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FB39D97CF
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 13:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BED4285F46
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 12:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F861D45F0;
	Tue, 26 Nov 2024 12:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="YTA8Di+B"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12061D4340;
	Tue, 26 Nov 2024 12:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732625977; cv=none; b=tAwir90hsoqmPmYzysrthIWyWn0Rt6nImXOykPciVn4ikHI/7GYnP+5jtXhWuLf4oFUPkqsmthWBv2Pgb0aMn7DDRgUugbGkVvSBg8IbnC1fqbEWVu7XkFDPLVTX+tiZYY7HNKRcqQ2ZhHJBdirwNDhpf6sIBLDYnkLqeT/Rbds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732625977; c=relaxed/simple;
	bh=cnvnj0VfxIvQRO2vsdi0eRPwYK1wWOUyT57uL5dMTLQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Atu/KbiWU0tI4e7FVnIZ8wmUkLtnA4QnxPoACd5mvkgomX8DirJSqnr7o7NCTa6+RmM0E+KrMgPOYWBfGV6yxlF1XrAZMql+cVxVq6JG0s4Bq87+OM2d/36965tEnEGVhIaonyDzlC+C5CJ36EADQAIK3gmfHQb5gIaaFCXwk9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=YTA8Di+B; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id E24C5207CA;
	Tue, 26 Nov 2024 13:59:32 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L1OXqsNFQURN; Tue, 26 Nov 2024 13:59:32 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 06E99207BB;
	Tue, 26 Nov 2024 13:59:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 06E99207BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1732625972;
	bh=MZSNHrkoFWQwpMSZYUXRA/Mg+7OUMb1wtcBhBpfF0m0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=YTA8Di+B1fnLRKo6JFQ9iUjCSJwKEvH7enJVv3F4Q5DZ3IITOBdrKOV44m0P4rayn
	 B9mcEXJUCaaFrbH1WAtKYkHCviUMjtcxEsCNgdON8glUFKv9ilUSz0mPfzTNrWCi2Q
	 tvbx92q0BAgdjq5SacNCER8C0O+D8079TUluG32B5ea92KP6IDcPVFGuey1oImHjGT
	 fCwSM/0vJ0HbMyE0vhh8vNSd9yPi7GNQIbrOplJtJj0tY0T+6N5uLSUzxDAsAC2axd
	 RPQbs5FDvbFcg7ZMs/ekvHCSfSmPN/2+PNyvdhMjFXC6MRZ+FD4x5ABCCw3Pq0vsKk
	 Xo0fEy2zAgr+A==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 26 Nov 2024 13:59:31 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 26 Nov
 2024 13:59:31 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 393393184178; Tue, 26 Nov 2024 13:59:31 +0100 (CET)
Date: Tue, 26 Nov 2024 13:59:31 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Ilia Lin <ilia.lin@kernel.org>, <herbert@gondor.apana.org.au>, "David
 Miller" <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xfrm: Add pre-encap fragmentation for packet offload
Message-ID: <Z0XGMxSou3AZrB2f@gauss3.secunet.de>
References: <20241124093531.3783434-1-ilia.lin@kernel.org>
 <20241124120424.GE160612@unreal>
 <CA+5LGR2n-jCyGbLy9X5wQoUT5OXPkAc3nOr9bURO6=9ObEZVnA@mail.gmail.com>
 <20241125194340.GI160612@unreal>
 <CA+5LGR0e677wm5zEx9yYZDtsCUL6etMoRB2yF9o5msqdVOWU8w@mail.gmail.com>
 <20241126083513.GL160612@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241126083513.GL160612@unreal>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Nov 26, 2024 at 10:35:13AM +0200, Leon Romanovsky wrote:
> On Tue, Nov 26, 2024 at 09:09:03AM +0200, Ilia Lin wrote:
> > On Mon, Nov 25, 2024 at 9:43 PM Leon Romanovsky <leon@kernel.org> wrote:
> > >
> > > On Mon, Nov 25, 2024 at 11:26:14AM +0200, Ilia Lin wrote:
> > > > On Sun, Nov 24, 2024 at 2:04 PM Leon Romanovsky <leon@kernel.org> wrote:
> > > > >
> > > > > On Sun, Nov 24, 2024 at 11:35:31AM +0200, Ilia Lin wrote:
> > > > > > In packet offload mode the raw packets will be sent to the NiC,
> > > > > > and will not return to the Network Stack. In event of crossing
> > > > > > the MTU size after the encapsulation, the NiC HW may not be
> > > > > > able to fragment the final packet.
> > > > >
> > > > > Yes, HW doesn't know how to handle these packets.
> > > > >
> > > > > > Adding mandatory pre-encapsulation fragmentation for both
> > > > > > IPv4 and IPv6, if tunnel mode with packet offload is configured
> > > > > > on the state.
> > > > >
> > > > > I was under impression is that xfrm_dev_offload_ok() is responsible to
> > > > > prevent fragmentation.
> > > > >
> > https://elixir.bootlin.com/linux/v6.12/source/net/xfrm/xfrm_device.c#L410
> > > >
> > > > With my change we can both support inner fragmentation or prevent it,
> > > > depending on the network device driver implementation.
> > >
> > > The thing is that fragmentation isn't desirable thing. Why didn't PMTU
> > > take into account headers so we can rely on existing code and do not add
> > > extra logic for packet offload?
> > 
> > I agree that PMTU is preferred option, but the packets may be routed from
> > a host behind the VPN, which is unaware that it transmits into an IPsec
> > tunnel,
> > and therefore will not count on the extra headers.
> 
> My basic web search shows that PMTU works correctly for IPsec tunnels too.

Yes, at least SW and crypto offload IPsec PMTU works correctly.

> 
> Steffen, do we need special case for packet offload here? My preference is
> to make sure that we will have as less possible special cases for packet
> offload.

Looks like the problem on packet offload is that packets
bigger than MTU size are dropped before the PMTU signaling
is handled.

