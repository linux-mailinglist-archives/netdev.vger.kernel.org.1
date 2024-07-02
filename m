Return-Path: <netdev+bounces-108614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB380924967
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 22:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED9411C2287A
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 20:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF669200135;
	Tue,  2 Jul 2024 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V0Dx6JMI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA691B5813
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719952647; cv=none; b=QL8+GdQkuco28hg+sKG22Gs0w0qOlP3n3qW8MiBPB0S0xX3I1N33cwCK8JE15zIWCqNFsMsuY82WO4Ck9Fq7qOomEoGNJU46Uah8q+LjKOq6D/ysCaP1z1dvrixJd+9kukXxv1otGVNLU36IEpPqvR2M6k37ZfLe4pjuXuxLtJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719952647; c=relaxed/simple;
	bh=HAsT+aH+kX4qzvs4QwoN8ulbUS9ZQ8J55ZxlIlYQEx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkTnPTvgmkZRRuUgsBEcN24XPuK1/agl2J6DMWRc6J/DsBfPdyHY4XjlMt/SZbOyg9nzJvxY2W5AZIgb0ksQbLPERgLsOAk61m5GPpUpiLh/weCSJrXVpoet4AGAxz+v7I0cnWWPJEiOEYVMTo+n9b1iYTUxhfTHh8NsWp4EG8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=V0Dx6JMI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=cCgKyv2Jiig0mHxbiPNcpl7uO/GAM/QfwldfnBuhzxA=; b=V0Dx6JMIms9w2za3HET8JbUtuS
	mdGblfAwzhiVs53I709VhScwkaSoyZR4mQBOVJZxHkQg3C4V1hDgX9zCad6bhWJ51wmEARCarywmo
	GAjdqsSASkYrcyONkO8LRgsLAkurkFErjTbKp5c/VjdlgBTDIqYOd8srvAnzGJWzH4Wc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sOkFc-001fZn-Ir; Tue, 02 Jul 2024 22:37:20 +0200
Date: Tue, 2 Jul 2024 22:37:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Alexander Duyck <alexanderduyck@fb.com>, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	kernel-team@meta.com
Subject: Re: [net-next PATCH v3 11/15] eth: fbnic: Add link detection
Message-ID: <e7527f49-60a2-4e64-a93b-c72ad2cc4879@lunn.ch>
References: <171993231020.3697648.2741754761742678186.stgit@ahduyck-xeon-server.home.arpa>
 <171993242260.3697648.17293962511485193331.stgit@ahduyck-xeon-server.home.arpa>
 <ZoQ3LlZZ47AJ5fnL@shell.armlinux.org.uk>
 <CAKgT0UcPExnW2jcZ9pAs0D65gXTU89jPEoCpsGVVT=FAW616Vg@mail.gmail.com>
 <281cdc6a-635f-499d-a312-9c7d8bb949f1@lunn.ch>
 <CAKgT0UcAYxnKkCSk7a3EKv6GzZn51Xfrd2Yr0yjcC2_=tk9ZQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0UcAYxnKkCSk7a3EKv6GzZn51Xfrd2Yr0yjcC2_=tk9ZQA@mail.gmail.com>

> > As for multiple PCS for one connection, is this common, or special to
> > your hardware?
> 
> I would think it is common. Basically once you get over 10G you start
> seeing all these XXXXXbase[CDKLS]R[248] speeds advertised and usually
> the 2/4/8 represents the number of lanes being used. I would think
> most hardware probably has a PCS block per lane as they can be
> configured separately and in our case anyway you can use just the one
> lane mode and then you only need to setup 1 lane, or you can use the 2
> lane mode and you need to setup 2.
> 
> Some of our logic is merged like I mentioned though so maybe it would
> make more sense to just merge the lanes. Anyway I guess I can start
> working on that code for the next patch set. I will look at what I
> need to do to extend the logic. For now I might be able to get by with
> just dropping support for 50R1 since that isn't currently being used
> as a default.

So maybe a dumb question. How does negotiation work? Just one performs
negotiation? They all do, and if you get different results you declare
the link broken? First one to complete wins? Or even, you can
configure each lane to use different negotiation parameters...

    Andrew

