Return-Path: <netdev+bounces-79427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7B1F8792CB
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 12:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2132128162B
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 11:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B61079B65;
	Tue, 12 Mar 2024 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pldhCYWS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3C79956
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 11:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710242133; cv=none; b=SRXRSDBmC56uQ8Hvj9BlqPmlo3fb8tyyjlSbD5EJalsvhIeox1FSFGqg+MKyLaXpOhtY11wbVm24Vl9/8+1aheXzmHFK35taw+UTV7w3ZPM2znXZfw4EkflEEun1m2fT+re53+XjijDRBGOgaa6qOVGvsWO+05ZPBTZ0wcZeghg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710242133; c=relaxed/simple;
	bh=R+2h4+YGxxorZLUIGuvcYtPBXptNwjxU8waN/UknsDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jr3WG7cC6wIpfMomjXkFEowviVmEmSf40Gt0gHGHrOHdwCvk9ME4/Yb+oIYW1EPwr2XNnjXYuxzBrMVSvybAsVg9/mrhEGWYewS6JWj8JH8TkMf7Dx7Bz2c/EBjT5KhbpsB58JCOcJlb/Zp97+vN+sJcr2l6iVNMwCYVu6SkHOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pldhCYWS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F47C43399;
	Tue, 12 Mar 2024 11:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710242132;
	bh=R+2h4+YGxxorZLUIGuvcYtPBXptNwjxU8waN/UknsDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pldhCYWS/fa868qU3rnOUnlnno98EByqHX1mjVgbXB1g960HitHnR5SFEk0Kj0IFY
	 T0uEywJFQl2RSPWnSJmNBCMFdAg5NuS6GS8ESrjveYhYiRysGljcfdfRAYRZjofspr
	 WmIb9u9e7fYVhr6Vpci3XOvp98vszhqxCku+cgT++kDAj354PhbwEgR1DFOMwNVvGo
	 AJ6j1QZCs9lnQLbISXQbtkqzM0h6ykgbmVcVNVr0h+9K8OhO24VEXSqQJ+aKgDGHP5
	 +YH088MxSgA5rMNNEFEzfUd8NCEJTPR6eH0Ay5OTBk2HJgecmNq2CpKtfKrz0il34M
	 Vhyrgidxj961Q==
Date: Tue, 12 Mar 2024 13:15:28 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/5] xfrm: Pass UDP encapsulation in TX packet offload
Message-ID: <20240312111528.GT12921@unreal>
References: <20240306100438.3953516-1-steffen.klassert@secunet.com>
 <20240306100438.3953516-3-steffen.klassert@secunet.com>
 <a650221ae500f0c7cf496c61c96c1b103dcb6f67.camel@redhat.com>
 <Ze/0Fi5oqkcqwbIX@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ze/0Fi5oqkcqwbIX@gauss3.secunet.de>

On Tue, Mar 12, 2024 at 07:20:06AM +0100, Steffen Klassert wrote:
> On Mon, Mar 11, 2024 at 05:25:03PM +0100, Paolo Abeni wrote:
> > Hi,
> > 
> > On Wed, 2024-03-06 at 11:04 +0100, Steffen Klassert wrote:
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > > 
> > > In addition to citied commit in Fixes line, allow UDP encapsulation in
> > > TX path too.
> > > 
> > > Fixes: 89edf40220be ("xfrm: Support UDP encapsulation in packet offload mode")
> > > CC: Steffen Klassert <steffen.klassert@secunet.com>
> > > Reported-by: Mike Yu <yumike@google.com>
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> > > Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> > 
> > This is causing self-test failures:
> > 
> > https://netdev.bots.linux.dev/flakes.html?tn-needle=pmtu-sh
> > 
> > reverting this change locally resolves the issue.
> > 
> > @Leon, @Steffen: could you please have a look?
> 
> Looks like the check for x->encap was removed unconditionally.
> I should just be removed when XFRM_DEV_OFFLOAD_PACKET is set,
> otherwise we might create a GSO packet with UPD encapsulation.
> 
> Leon?

Right, I missed IPsec SW path, that x->encap check can be removed
in packet offload because HW supports it and in crypto offload, because
there is a check in xfrm_dev_state_add() to prevent it.

What about this fix?

diff --git a/net/xfrm/xfrm_device.c b/net/xfrm/xfrm_device.c
index 653e51ae3964..6e3e5a09cfeb 100644
--- a/net/xfrm/xfrm_device.c
+++ b/net/xfrm/xfrm_device.c
@@ -407,7 +407,7 @@ bool xfrm_dev_offload_ok(struct sk_buff *skb, struct xfrm_state *x)
        struct xfrm_dst *xdst = (struct xfrm_dst *)dst;
        struct net_device *dev = x->xso.dev;

-       if (!x->type_offload)
+       if (!x->type_offload || x->xso.type == XFRM_DEV_OFFLOAD_UNSPECIFIED)
                return false;

        if (x->xso.type == XFRM_DEV_OFFLOAD_PACKET ||


Thanks



> 

