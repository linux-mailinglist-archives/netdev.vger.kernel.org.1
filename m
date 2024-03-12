Return-Path: <netdev+bounces-79432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB678792F5
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 12:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018571F223A8
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 11:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD5779B78;
	Tue, 12 Mar 2024 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2+DuQgE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C03179B75
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710242795; cv=none; b=GXXYcROdfHumT5hyIuPDz7b/nr9RXOq0MOLJu7AQyaR7eipZxmkFGnC3ZW/tBNkEEmaJIKaDK9yd64PwAY6xXl7W9S8bwtgKpe1Limlat2+EA+Vgi87iP1cBsh0ahQh5ZSBrQUCyZpzybfNR0zCmdlIrnmWwTbOWn6ZY28HmVOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710242795; c=relaxed/simple;
	bh=Z93SpRdX3ahrnHvKqjp06CphRVRd99Ed9gkPvHYTwrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H4g5wVj53tQKcTu81BDPn7f0odfX68QRqtCSGe35XN7zaVvqgDxWUy0IYPDQiHB7sKVlXQ/XUGMKFHiJYXsC+rj80bxVgMg0bhdlgWwTFqLhLzSkYadKK9UWwA+F4yaexC3MYfGWMgygIxC5FwJbtQ5H/6nkfZc8dpIn1wpXpXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2+DuQgE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 406E6C433C7;
	Tue, 12 Mar 2024 11:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710242795;
	bh=Z93SpRdX3ahrnHvKqjp06CphRVRd99Ed9gkPvHYTwrw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z2+DuQgEIESYU5ogbUeoLcmMkAEzdHd6xK1u7HcXbm6FlhMWzXPZp0djle8euN3av
	 GAqmoGbM+EnFSGvDOP87MH1sCboOvTV33cEQNUsXqq/iojQJg/c5Nctni6Un8hJvrD
	 whXf9su2J12JLuup5QA1s/WPoJkW6TmerEXOw/8pxstenE9LdhF9yZJnKwQRvZ+IWV
	 8WvWiFZtnvmdLlOY9Nv9Z4vMy+WdKoqiiwb7xQS38/rRHehdKpYnlejlZ4kFF/XY5p
	 kjAAguEWnHqkQWRkjejsA5mOn9zIpaRztQEm1Upco5aqVw5w+wgMCFwZjSWGHh+7dA
	 TQ5ZXERs6+aZQ==
Date: Tue, 12 Mar 2024 13:26:30 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/5] xfrm: Pass UDP encapsulation in TX packet offload
Message-ID: <20240312112630.GU12921@unreal>
References: <20240306100438.3953516-1-steffen.klassert@secunet.com>
 <20240306100438.3953516-3-steffen.klassert@secunet.com>
 <a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com>
 <Ze/0Fi5oqkcqwbIX@gauss3.secunet.de>
 <20240312111528.GT12921@unreal>
 <ZfA6kauSNCbPLIuM@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfA6kauSNCbPLIuM@gauss3.secunet.de>

On Tue, Mar 12, 2024 at 12:20:49PM +0100, Steffen Klassert wrote:
> On Tue, Mar 12, 2024 at 01:15:28PM +0200, Leon Romanovsky wrote:
> > On Tue, Mar 12, 2024 at 07:20:06AM +0100, Steffen Klassert wrote:
> > > On Mon, Mar 11, 2024 at 05:25:03PM +0100, Paolo Abeni wrote:
> > > > Hi,
> > > > 
> > > > On Wed, 2024-03-06 at 11:04 +0100, Steffen Klassert wrote:
> > > > > From: Leon Romanovsky <leonro@nvidia.com>
> > > > > 
> > > > > In addition to citied commit in Fixes line, allow UDP encapsulation in
> > > > > TX path too.
> > > > > 
> > > > > Fixes: 89edf40220be ("xfrm: Support UDP encapsulation in packet offload mode")
> > > > > CC: Steffen Klassert <steffen.klassert@secunet.com>
> > > > > Reported-by: Mike Yu <yumike@google.com>
> > > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> > > > > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> > > > 
> > > > This is causing self-test failures:
> > > > 
> > > > https://netdev.bots.linux.dev/flakes.html?tn-needle=pmtu-sh
> > > > 
> > > > reverting this change locally resolves the issue.
> > > > 
> > > > @Leon, @Steffen: could you please have a look?
> > > 
> > > Looks like the check for x->encap was removed unconditionally.
> > > I should just be removed when XFRM_DEV_OFFLOAD_PACKET is set,
> > > otherwise we might create a GSO packet with UPD encapsulation.
> > > 
> > > Leon?
> > 
> > Right, I missed IPsec SW path, that x->encap check can be removed
> > in packet offload because HW supports it and in crypto offload, because
> > there is a check in xfrm_dev_state_add() to prevent it.
> > 
> > What about this fix?
> > 
> > diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
> > index 653e51ae3964..6e3e5a09cfeb 100644
> > --- a/net/xfrm/xfrm_device.c
> > +++ b/net/xfrm/xfrm_device.c
> > @@ -407,7 +407,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
> >         struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
> >         struct net_device *dev = x->xso.dev;
> > 
> > -       if (!x->type_offload)
> > +       if (!x->type_offload || x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED)
> >                 return false;
> 
> Then we can't generate GSO packets for the SW path anymore. We just need
> to reject UDP enacpsulation in SW here.

Is it better?

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 653e51ae3964..6346690d5c69 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -407,7 +407,8 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
        struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
        struct net_device *dev = x->xso.dev;

-       if (!x->type_offload)
+       if (!x->type_offload ||
+           (x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED && x->encap))
                return false;

        if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||

> 

