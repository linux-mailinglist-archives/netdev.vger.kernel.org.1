Return-Path: <netdev+bounces-128542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A83E097A3B8
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 16:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FFAD1F28586
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 14:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B097015855C;
	Mon, 16 Sep 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DKHyL6O5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBD41EB35
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 14:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726495294; cv=none; b=D9dlorV3g7GPnfsSoKaEVs9KSUy1nID7OHsoDdh1znGKxo/rHP82tuF8O0HzADMN9sTTok7EOuY58pE/XnXnaiTzoP0Pryooq0llT15Vm4dhEWysJ0jjQfkSJOg2FZXL9FLieP+QEHhzFuFgcuJ4jaFRk0eQbr8Epz7+XbmvX5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726495294; c=relaxed/simple;
	bh=beFTMkMJdS0FseC33L2gcXHxaiNHOqzikiM0Gpc7kgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFnnUbRZh0XDqJ5GhyjYGvx8t054Vc3WKdSxXZZshEFo+h3ZPestD6pGbf0Yqv4iT3eM7wXegkY4MsWqvbXm+9NwkyuyVLhY+FjxPSvCygulBLYv010lbtn+9+8qAHlAruKNATSWjUe/vWrJAPlnX1ScdJXQF4yZULzgSJhPv/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DKHyL6O5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC07CC4CEC4;
	Mon, 16 Sep 2024 14:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726495294;
	bh=beFTMkMJdS0FseC33L2gcXHxaiNHOqzikiM0Gpc7kgo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DKHyL6O5T60jgN5xPLM/I9EDHSgWrd8A0+UIbqpRzcN8UAbtOPQ/YLBVQ7FI6oKZd
	 2VcmdJeMoNZODh8UfwTEaiqWrBtWDDQRSiFyXyQSJARrD+dNHU1SkzmRxdudNPIxZw
	 1L/KEQ71Bvim+JLWa1CxdQLrUyGHPfCGpKE7DuRvZWdOIaVKTM2wX9zOf1XqzK+L48
	 fAUN/YutSMTVqcTVZd079uAIdJRkjA4iSl34wmT8UctszN1Vb3Pvt7lAolxTV3z9v7
	 rL1pbF4MTJGtSlIvALUS5X7OqmNWXRHfottjb3Yjuykh9/GQtFPdA8Drh135jgwz4Y
	 J7uXpukQjUnfw==
Date: Mon, 16 Sep 2024 15:01:30 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
	Alexandre Ferrieux <alexandre.ferrieux@orange.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org
Subject: Re: RFC: Should net namespaces scale up (>10k) ?
Message-ID: <20240916140130.GB415778@kernel.org>
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
 <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db6ecdc4-8053-42d6-89cc-39c70b199bde@intel.com>

On Mon, Sep 16, 2024 at 12:13:35PM +0200, Przemek Kitszel wrote:
> On 9/15/24 22:49, Alexandre Ferrieux wrote:
> > (thanks Simon, reposting with another account to avoid the offending disclaimer)
> > 
> > Hi,
> > 
> > Currently, netns don't really scale beyond a few thousands, for
> > mundane reasons (see below). But should they ? Is there, in the
> > design, an assumption that tens of thousands of network namespaces are
> > considered "unreasonable" ?
> > 
> > A typical use case for such ridiculous numbers is a tester for
> > firewalls or carrier-grade NATs. In these, you typically want tens of
> > thousands of tunnels, each of which is perfectly instantiated as an
> > interface. And, to avoid an explosion in source routing rules, you
> > want them in separate namespaces.
> > 
> > Now why don't they scale *today* ? For two independent, seemingly
> > accidental, O(N) scans of the netns list.
> > 
> > 1. The "netdevice notifier" from the Wireless Extensions subsystem
> > insists on scanning the whole list regardless of the nature of the
> > change, nor wondering whether all these namespaces hold any wireless
> > interface, nor even whether the system has _any_ wireless hardware...
> > 
> >          for_each_net(net) {
> >                  while ((skb = skb_dequeue(&net->wext_nlevents)))
> >                          rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL,
> >                                      GFP_KERNEL);
> >          }
> > 
> > 2. When moving an interface (eg an IPVLAN slave) to another netns,
> > __dev_change_net_namespace() calls peernet2id_alloc() in order to get
> > an ID for the target namespace. This again incurs a full scan of the
> > netns list:
> > 
> >          int id = idr_for_each(&net->netns_ids, net_eq_idr, peer);
> 
> this piece is inside of __peernet2id(), which is called in for_each_net
> loop, making it O(n^2):
> 
>  548│         for_each_net(tmp) {
>  549│                 int id;
>  550│
>  551│                 spin_lock_bh(&tmp->nsid_lock);
>  552│                 id = __peernet2id(tmp, net);
> 
> > 
> > Note that, while IDR is very fast when going from ID to pointer, the
> > reverse path is awfully slow... But why are IDs needed in the first
> > place, instead of the simple netns pointers ?
> > 
> > Any insight on the (possibly very good) reasons those two apparent
> > warts stand in the way of netns scaling up ?
> > 
> > -Alex
> > 
> 
> I guess that the reason is more pragmatic, net namespaces are decade
> older than xarray, thus list-based implementation.

Yes, I would also guess that the reason is not that these limitations were
part of the design. But just that the implementation scaled sufficiently at
the time. And that if further scale is required, then the implementation
can be updated.

