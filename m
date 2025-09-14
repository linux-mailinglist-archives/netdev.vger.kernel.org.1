Return-Path: <netdev+bounces-222849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D2B4B569CC
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 16:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC58117CF70
	for <lists+netdev@lfdr.de>; Sun, 14 Sep 2025 14:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E428A246BC7;
	Sun, 14 Sep 2025 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RfedOOUv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C174419047F;
	Sun, 14 Sep 2025 14:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757861162; cv=none; b=rWpar75kDoxECV1NYUXmzRrdcrrot95VT9VhAwmbF+7CZaAzBkTGr1t9XfBo3lxzF0oQ9nFUNx1sN7XV9p1zKcHR8ycTLR4O4mbgiDHPXwNTqaviPF0aVaUA5ToPLKqdDSEmN+8e+AehwHsHjjpWMbPk0DzHiMQPowUGEYlGeI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757861162; c=relaxed/simple;
	bh=HnvDW2zHErnh0GG+Edrb3yLGMisILDbYZ1ovzp9d8wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TO2SX2Y9VDKCeVpnxlYuqhDH/YE4r0m0BTP6tOK8vSzBSGg+QGsi65K2j84BIF2TAcbMOhgUbbxfjwEBZfFS1YR4aS/xfNyLreu4Aos2U1CNfqXBZZgEU9PxmOLNIOqPTPFhToZRxwA4+u0D29FRlgB2+K5W+tdeEEsL311BzRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RfedOOUv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZbZXc/D4E+4fCZ1w+feXVqgq8luXyPiNNgM1LGA/m8o=; b=RfedOOUvR/F4TFMNZdMcqcCC8A
	OFjRBvn0JANMl83LFEOY6EGrjNEuc76sQ6yJMJGEXui20i7lQUJsqkrExoYam8I0id19u5aEmyT94
	3jRFXEG4vzmU7ketV9mfVtvF6lisVPsWBTsNEehw0hJq1VRKlVuQ4EPi2uAQCSTJVvEg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uxnzE-008Luw-Ad; Sun, 14 Sep 2025 16:45:52 +0200
Date: Sun, 14 Sep 2025 16:45:52 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Yeounsu Moon <yyyynoom@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dlink: handle copy_thresh allocation failure
Message-ID: <d8494b1b-e110-4c73-87e0-d188d3f1beb5@lunn.ch>
References: <20250912145339.67448-2-yyyynoom@gmail.com>
 <57d58296-c656-4dab-a2e2-faf2452fb4de@lunn.ch>
 <DCSE8SBC2ZD1.Z7BOJYSEIELY@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DCSE8SBC2ZD1.Z7BOJYSEIELY@gmail.com>

On Sun, Sep 14, 2025 at 05:51:54PM +0900, Yeounsu Moon wrote:
> On Sat Sep 13, 2025 at 5:39 AM KST, Andrew Lunn wrote:
> >> -				skb_copy_to_linear_data (skb,
> >> +				skb_copy_to_linear_data(skb,
> >>  						  np->rx_skbuff[entry]->data,
> >>  						  pkt_len);
> >> -				skb_put (skb, pkt_len);
> >> +				skb_put(skb, pkt_len);
> >
> > Please don't include white space changes with other changes. It makes
> > the patch harder to review.
> >
> >     Andrew
> Thank you for reviewing!
> 
> As you mentioned, it indeed becomes harder to see what the real changes
> are. I have a few questions related to that:
> 
> 1. If I remove the whitespace between the funciton name and the
> parenthesis, `checkpatch.pl` will warn about it. Of course, I understand
> that we don't need to follow such rules in a mindessly robotic way.
> 
> 2. However, I also read in the netdev FAQ that cleanup-only patches are
> discouraged. So I thought it would be better to include the cleanup
> together with the patch. But I see your point, and I'll be more careful
> not to send patches that cause such confusion in the future.
> 
> 3. This is more of a personal curiosity: in that case, what would be the
> proper way to handle cleanup patches?

The problem with cleanup patches is that they are often done by
developers who don't have the hardware, and so don't do any
testing. White space changes like this a low risk, but other cleanup
patches are much more risky. So some cleanup patches end up breaking
stuff. We reviewers know this, and so put in more time looking at such
patches and try to make sure they are correct. But cleanup is
generally lower priority than new code. So to some extent, we prefer
the code is left 'dirty but working'.

In this case, you have the hardware. You are testing your change, so
we are much happier to accept such a cleanup patch as part of a
patchset fixing a real problem.

Please submit two patches in a patchset. The first patch fixes the
whitespace. The second fixes the memory problem with copy break. That
should be checkpatch clean. And mention in the commit message that
this has been tested on hardware.

     Andrew

