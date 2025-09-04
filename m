Return-Path: <netdev+bounces-220076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1F5B445FD
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 20:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16A9616C2DA
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAD825FA10;
	Thu,  4 Sep 2025 18:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtvNF0Wg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C1129E6E;
	Thu,  4 Sep 2025 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757012371; cv=none; b=dwOjZyoKQ6eJkmDHfWwHrjToBYta7lXl9BayF6gKU5NH7ftO0CizVlgtqvfNBBYNwkUmLm62WFawu1QsU69JY9oT8uhD6dYbwfj8ZJHExml5NyzG5zDk7eZBtGUT5QPo0eo3Uf8gQs/fH0PdBswFZ79Z+ZMhgpq8Wx0Gin8ycIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757012371; c=relaxed/simple;
	bh=2LsO001V0l4Tc423T37yosrI/A+M9/Ey6WikTWHyqBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hInm8YsaurDCWr/xEWSZEGF9BGfFi/3Fc2zjAwoRC2S9lvXNzmFs7EkRhGJZAKOVb1yhfqwLlbCxBhhoy+sYN6ogT0YXFz39nCbPjeEdRQ9CT2efC8ogR6uTl0etk309eDZkc8FXtMn0WlBs8DFAg8Y6zQ0jIUmITIIZLkpWqSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtvNF0Wg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83449C4CEF0;
	Thu,  4 Sep 2025 18:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757012370;
	bh=2LsO001V0l4Tc423T37yosrI/A+M9/Ey6WikTWHyqBI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZtvNF0Wgpb6H+ZBeS6+5V6hw8cjzLR/uZfjp01ZCt4iwbOGA7vp5wukWmpbHnhktt
	 A+1kTW6CWhWsQlCrWfOToVhtKlR0Yq3QXuifCZtB3iV9XKupAUctndcd3sZOo7dC+M
	 +dZNeGoVRa/3RBEQWNAYGGPVLYhoMxDhh6t09QLDzx7fuArz7bocLHCFy3eMqL/+FP
	 TBFh9fL99WVlf/aZGzbuvg6aG7IggModD6HRSlKK/mkLQ0Wf0EfBxSBZkT+wDkzP6O
	 5v3VprrUV63fVEyVEvPveIisAnRbxdYH4YOBnFeg8qXeCBwFYuzvBIL3EnVjaS/i85
	 Y3T1oagSt1xbA==
Date: Thu, 4 Sep 2025 19:59:26 +0100
From: Simon Horman <horms@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	Christoph Niedermaier <cniedermaier@dh-electronics.com>
Subject: Re: [PATCH net] net: fec: Fix possible NPD in
 fec_enet_phy_reset_after_clk_enable()
Message-ID: <20250904185926.GM372207@horms.kernel.org>
References: <20250904091334.53965-1-wahrenst@gmx.net>
 <20250904065836.5d0f4486@kernel.org>
 <0ae16ef0-45d7-4775-a825-87a352fc03e0@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ae16ef0-45d7-4775-a825-87a352fc03e0@gmx.net>

On Thu, Sep 04, 2025 at 08:01:42PM +0200, Stefan Wahren wrote:
> Hi Jakub,
> 
> [drop bouncing address]
> 
> Am 04.09.25 um 15:58 schrieb Jakub Kicinski:
> > On Thu,  4 Sep 2025 11:13:34 +0200 Stefan Wahren wrote:
> > >   		phy_dev = of_phy_find_device(fep->phy_node);
> > >   		phy_reset_after_clk_enable(phy_dev);
> > > -		put_device(&phy_dev->mdio.dev);
> > > +		if (phy_dev) 
> > > +			put_device(&phy_dev->mdio.dev);
> > Looks correct, but isn't it better to also wrap
> > phy_reset_after_clk_enable() with the if()?
> since phy_reset_after_clk_enable() have an internal check, i thought it
> won't be necessary. So this variant has fewer lines.

FWIIW, I had the same thought as Jakub.
But I think it's a judgement call because, as Stefan says,
phy_reset_after_clk_enable() checks for NULL anyway.

Maybe one is easier to read than the other.
But I guess that is in the eye of the beholder.
And as we have this version I think it's just as well to stick with it.

Reviewed-by: Simon Horman <horms@kernel.org>


