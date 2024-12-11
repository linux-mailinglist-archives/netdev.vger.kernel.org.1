Return-Path: <netdev+bounces-151074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF3F9ECABB
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 11:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06B4A1882502
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7822040B2;
	Wed, 11 Dec 2024 10:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="EoLsbCk+"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91E41EE7BB
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733914634; cv=none; b=NHi48mfRoatIJpRULU2EMGrrtGd9KTPE7z4mSWhrRvLGd9RbV69/q/nGtM3apghI92IgTvNN7ItcWM3/Oteylh0E7/VAaQmXUERvPxp5Ukd/3CrNCVrsQxqN1sDlb/HkjzgdM4hY5qoePIQW6+EHkxyQrQBjkeC09Vy7uDAE0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733914634; c=relaxed/simple;
	bh=71yklx03qQQJsAgZx+0nzCCvGzWqBU/MWhsKuVjVInc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mnURtFuix2jBDmxnLg5vpb+K85cXyKdrmQZzOeHoXOZk2jGUDoCtahMgrjOEPQ7RyXzZHVC8CPr4shZvX+IrZFcnjRl0OvDC55GAsR3G66Xr6R/S5xODDggPM13mhgfyusrvE9u382kJ497zZU/KQvYGXNmBzCO8k35Aj7msOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=EoLsbCk+; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 7E8A2207CA;
	Wed, 11 Dec 2024 11:57:04 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NmNOOJhvd4UJ; Wed, 11 Dec 2024 11:57:04 +0100 (CET)
Received: from cas-essen-02.secunet.de (rl2.secunet.de [10.53.40.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id E8D28207AC;
	Wed, 11 Dec 2024 11:57:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com E8D28207AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1733914623;
	bh=mB+BhSa583ON4mE1AMoIZmMTmjeLB65bbpDm/9kVQsA=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=EoLsbCk+JCPytyK0QQuxqbGbnLxJWevyIdAJAE779OxLN6lhPgZsCiOokUnAlcqQU
	 csXbnHI55uQ7KkQ7/kv0GI8hVa4Vyzvr+tVugDx2OeRurYQ9Z8m3az6hqOkBBWUIiW
	 IY/nE5gTk/evxBVAxyVSmzsrqlazBYoFf3UOJPXUaIQ9gqYDqR/BnB5yhY/sOqhVM2
	 DMmFPOUEiKOH/b9VbDeSjr5ClvtqXxps/ovskZi2/DGZBvmN6etnkph7d22Mc+HrVZ
	 i1baVq+JPtyMhMN/gWSn7+YZ4298ylig8rKKm5/gA8HLTmsKA4L+tSbEqRc+UeXgvw
	 n7x0+C+7ucAfw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-02.secunet.de (10.53.40.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 11 Dec 2024 11:57:03 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 11 Dec
 2024 11:57:03 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 3A05E318133F; Wed, 11 Dec 2024 11:57:03 +0100 (CET)
Date: Wed, 11 Dec 2024 11:57:03 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Feng Wang <wangfe@google.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <antony.antony@secunet.com>, <pabeni@redhat.com>
Subject: Re: [PATCH v7] xfrm: add SA information to the offloaded packet when
 if_id is set
Message-ID: <Z1lv/+VBldgUYTGw@gauss3.secunet.de>
References: <20241209202811.481441-2-wangfe@google.com>
 <20241209215301.GC1245331@unreal>
 <CADsK2K_NnizU+oY02PW9ZAiLzyPH=j=LYyjHnzgcMptxr95Oyg@mail.gmail.com>
 <Z1gMGlYPCywoqJK5@gauss3.secunet.de>
 <20241210192048.386d518a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241210192048.386d518a@kernel.org>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Tue, Dec 10, 2024 at 07:20:48PM -0800, Jakub Kicinski wrote:
> On Tue, 10 Dec 2024 10:38:34 +0100 Steffen Klassert wrote:
> > > This patch was done based on our previous discussion.  I did the
> > > changes we agreed on.  
> > 
> > there is still no real packet offload support for netdev sim.
> > And as said, this is at most the second best option.
> > 
> > You need to prove that this works. I want a complete API,
> > but I also want a working one.
> > 
> > The easiest way to prove that this is implemented correctly
> > is to upstream your driver. Everyting else is controversial
> > and complicated.
> 
> Yes, I don't have full context but FWIW offload changes accompanied 
> by just netdevsim modifications raise a red flag:

Actually, we have the mlx5 driver that supports packet offload.
When that was implemented, xfrm interfaces were no usecase.
Because of that, we forgot to care for the xfrm interface ID as
a lookup key. The problem is that users can still configure
policies/states for xfrm interfaces and packet offload.
The driver then just don't know if a packet was routed via
a xfrm interface, and if so, via which one. So it might happen
that a wrong policy/state is applied to a packet.

My idea was to fix that by supporting xfrm interfaces
with packet offload in the stack. But after looking
a bit closer to the code yesterday, I noticed that we
might not need any stack changes to get this right.

I think the driver should do the following:

If xfrm interfaces are not supported:

- Reject policies and states that have xfrm interfaces
  configured.

If xfrm interfaces are supported:

- Accept policies and states that have xfrm interfaces
  configured.

- On TX: Use the drivers xdo_dev_offload_ok function
  to check if the packet came via the correct xfrm
  interface and/or amend that info by adding the
  xfrm state to the packets secpath.

- On RX: Driver traveses through the list of registered
  xfrm interfaces and match these against the used SAs
  xfrm interface ID.


By doing that, no stack changes should be required.

