Return-Path: <netdev+bounces-129513-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C269843B8
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CAAD1F224B4
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A25F193082;
	Tue, 24 Sep 2024 10:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="sW83jQn8"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A408317C203
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727174078; cv=none; b=kZeBpgjsAOM0OXLPHmzfzKil5sjWYNefo4b10k98CwKx1v8ANQ+YX7JUXHRTqPmHk5V+qdIh+tS/Kefm8cdOPPbi7sfiyh1VE82EJrSWuSCI6dlUJgwB2WtlSUmtI5xm1VP/jlXLO2+f+SHI8Qpy4o14oKhH3SR8vK3vjGR8pZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727174078; c=relaxed/simple;
	bh=TL01j6AaDyaKSUO8AQaljcrtz6PX0ORv98ip9qbwnaw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFvQCeKxgziG2YJPRBjv0mLZUdcszvJvs6ti+WNZgeDcUOtbPSYKLw/yfW3cHJcpKrXQ4cVHgO/fLSkEWRYFEhdN4YT4E2KVOGZIyEudVSRgsiO2YfLZVA6vVn18cS4EH+uvTB1k2XDQ9TIEEoWu5poFifCkNWeietcNkeEWhIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=sW83jQn8; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 8CBCE206F0;
	Tue, 24 Sep 2024 12:34:33 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yj84e_i8AQOo; Tue, 24 Sep 2024 12:34:32 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id B7D1E205E3;
	Tue, 24 Sep 2024 12:34:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com B7D1E205E3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1727174072;
	bh=/zktVwylOClWU4d75C8ynrRHR+5YfRBbRfJOcHkx9m0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=sW83jQn8BqRskaytp9rT5aYVdW/Ai+GT1yRmQiMb6Tt5Qo/2rCWA+NYtnbiCaqoJ+
	 u8U7nUozoT8JA/g9XX7ZipJvqavJjH6S+YCxXlJmosKoXNZYTWmeSKR7ueiU6oxzdr
	 380HhEMS+mJna75tEnPdfxHTAg8r32dY1/Gcv5JA7uFcFxAc9Ap9qXmw0jap4dZ1bc
	 gpyNC8oSG2eOWH+uaax8ib1UTTMDTyatOGrrbNJ1mLvrfgym7AYeYtVEbQJx/jWNvM
	 Oh0NtitSthb8nPEcIJKCUZN/c2ai0gC5UXnaUlc3UUzuFig+/ps2Y7aVS0Oc7JhFtu
	 2QcVkneOwuR+A==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 24 Sep 2024 12:34:32 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 12:34:32 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 247643180BC8; Tue, 24 Sep 2024 12:34:32 +0200 (CEST)
Date: Tue, 24 Sep 2024 12:34:32 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Leon Romanovsky <leon@kernel.org>
CC: Feng Wang <wangfe@google.com>, <netdev@vger.kernel.org>,
	<antony.antony@secunet.com>
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <ZvKVuBTkh2dts8Qy@gauss3.secunet.de>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal>
 <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
 <20240902094452.GE4026@unreal>
 <Zt67MfyiRQrYTLHC@gauss3.secunet.de>
 <20240911104040.GG4026@unreal>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240911104040.GG4026@unreal>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Sep 11, 2024 at 01:40:40PM +0300, Leon Romanovsky wrote:
> On Mon, Sep 09, 2024 at 11:09:05AM +0200, Steffen Klassert wrote:
> > On Mon, Sep 02, 2024 at 12:44:52PM +0300, Leon Romanovsky wrote:
> > > On Mon, Sep 02, 2024 at 09:44:24AM +0200, Steffen Klassert wrote:
> > > > > 
> > > > > Steffen,
> > > > > 
> > > > > What is your position on this patch?
> > > > > It is the same patch (logically) as the one that was rejected before?
> > > > > https://lore.kernel.org/all/ZfpnCIv+8eYd7CpO@gauss3.secunet.de/
> > > > 
> > > > This is an infrastructure patch to support routing based IPsec
> > > > with xfrm interfaces. I just did not notice it because it was not
> > > > mentioned in the commit message of the first patchset. This should have
> > > > been included into the packet offload API patchset, but I overlooked
> > > > that xfrm interfaces can't work with packet offload mode. The stack
> > > > infrastructure should be complete, so that drivers can implement
> > > > that without the need to fix the stack before.
> > > 
> > > Core implementation that is not used by any upstream code is rarely
> > > right thing to do. It is not tested, complicates the code and mostly
> > > overlooked when patches are reviewed. The better way will be to extend
> > > the stack when this feature will be actually used and needed.
> > 
> > This is our tradeoff, an API should be fully designed from the
> > beginning, everything else is bad design and will likely result
> > in band aids (as it happens here). The API can be connected to
> > netdevsim to test it.
> > 
> > Currently the combination of xfrm interfaces and packet offload
> > is just broken. 
> 
> I don't think that it is broken.

I don't see anything that prevents you from offloading a SA
with an xfrm interface ID. The binding to the interface is
just ignored in that case.

> It is just not implemented. XFRM
> interfaces are optional field, which is not really popular in the
> field.

It is very popular, I know of more than a billion devices that
are using xfrm interfaces.

> 
> > Unfortunalely this patch does not fix it.
> > 
> > I think we need to do three things:
> > 
> > - Fix xfrm interfaces + packet offload combination
> > 
> > - Extend netdevsim to support packet offload
> > 
> > - Extend the API for xfrm interfaces (and everything
> >   else we forgot).
> 
> This is the most challenging part. It is not clear what should
> we extend if customers are not asking for it and they are extremely
> happy with the current IPsec packet offload state.

We just need to push the information down to the driver,
and reject the offload if not supported.

> 
> BTW, I'm aware of one gap, which is not clear how to handle, and
> it is combination of policy sockets and offload.

Socket policies are a bit special as they are configured by
the application that uses the socket. I don't think that
we can even configure offload for a socket policy.


