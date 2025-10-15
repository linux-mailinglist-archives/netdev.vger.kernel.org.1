Return-Path: <netdev+bounces-229684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 099ADBDFB7B
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 18:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4272C4E27A3
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 16:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F0193376BD;
	Wed, 15 Oct 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YYN4w4Yy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DDC33768B;
	Wed, 15 Oct 2025 16:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760546614; cv=none; b=JuT+/EJAyvtyGEOOIHMui4Kfo/2qjCaNwZDx1/lhV/v0q9lXLzm5Uz3JC6Wu+AmA9mamTCIH+C/R20uFfPWFhCy4NX5vRhXEMFDVtkptO+6YAi4Sw8r7QGY7Gf4E3XMsNAJEmvNf4Re7564ZUnrFMoba6yolt0k1eKPbTL1XY+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760546614; c=relaxed/simple;
	bh=4nrEEDuiqojf/f9RqiSpynaXP0mqkulPdbzuB7ofuXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VgyqZUExMIyp5HUMxH/iADbmInMoVS03V794KPTp3fPf8UzovFXUs8tKxs2AI+8rOE092Z5THhEhKuKaA8g8ZkZVkSr8nk1tUSaauYOmku+9PmJKzHLEBoA6QzWD8sSCCko9u/gmGUdpdOVLZQoTGXFFJyngMKo/AZdBbTdsn0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YYN4w4Yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCE6C4CEF8;
	Wed, 15 Oct 2025 16:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760546613;
	bh=4nrEEDuiqojf/f9RqiSpynaXP0mqkulPdbzuB7ofuXY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YYN4w4Yy8DJ8eml8J9REG94kgUAktX7OJjE8ISwCJONcX+3na55LYmctaeMGbfXTZ
	 2wYXXd3JtrGQS08GyiVKLuxmbXWrWkoWZ+xwgDLVUJlie9fHeHbMqydBRAru+wRwfM
	 aVrMcFYzYG7ygPwq7eCYFKObyB4JCiJqgc11hsS/Du/LhW2D0GrgzxhRi3V/128rFG
	 4UScwXsilq3wlQgakwOd/HgeKtbNNAGaKfFi04DPPF+8FvG+VNaV6SVj6W4o3ayyUj
	 OwKS2Zc8//B35GVcAowdxCyzBMN/DOfUVBkVd2ARaVPp2/3NhdkTdyD9JMeH/w+S4v
	 DV1kO2ObKWT/w==
Date: Wed, 15 Oct 2025 17:43:29 +0100
From: Simon Horman <horms@kernel.org>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?utf-8?B?w4FsdmFybyBGZXJuw6FuZGV6?= Rojas <noltari@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: tag_brcm: legacy: fix untagged rx on
 unbridged ports for bcm63xx
Message-ID: <aO_PMWQlv0DhHukm@horms.kernel.org>
References: <20251015070854.36281-1-jonas.gorski@gmail.com>
 <aO_H6187Oahh24IX@horms.kernel.org>
 <CAOiHx=nbRAkFW2KMHwFoF3u6yoN28_LbMrar1BoF37SA=Mz4gg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOiHx=nbRAkFW2KMHwFoF3u6yoN28_LbMrar1BoF37SA=Mz4gg@mail.gmail.com>

On Wed, Oct 15, 2025 at 06:24:33PM +0200, Jonas Gorski wrote:
> On Wed, Oct 15, 2025 at 6:12 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Wed, Oct 15, 2025 at 09:08:54AM +0200, Jonas Gorski wrote:
> > > The internal switch on BCM63XX SoCs will unconditionally add 802.1Q VLAN
> > > tags on egress to CPU when 802.1Q mode is enabled. We do this
> > > unconditionally since commit ed409f3bbaa5 ("net: dsa: b53: Configure
> > > VLANs while not filtering").
> > >
> > > This is fine for VLAN aware bridges, but for standalone ports and vlan
> > > unaware bridges this means all packets are tagged with the default VID,
> > > which is 0.
> > >
> > > While the kernel will treat that like untagged, this can break userspace
> > > applications processing raw packets, expecting untagged traffic, like
> > > STP daemons.
> > >
> > > This also breaks several bridge tests, where the tcpdump output then
> > > does not match the expected output anymore.
> > >
> > > Since 0 isn't a valid VID, just strip out the VLAN tag if we encounter
> > > it, unless the priority field is set, since that would be a valid tag
> > > again.
> > >
> > > Fixes: 964dbf186eaa ("net: dsa: tag_brcm: add support for legacy tags")
> > > Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> >
> > ...
> >
> > > @@ -237,8 +239,14 @@ static struct sk_buff *brcm_leg_tag_rcv(struct sk_buff *skb,
> > >       if (!skb->dev)
> > >               return NULL;
> > >
> > > -     /* VLAN tag is added by BCM63xx internal switch */
> > > -     if (netdev_uses_dsa(skb->dev))
> > > +     /* The internal switch in BCM63XX SoCs will add a 802.1Q VLAN tag on
> > > +      * egress to the CPU port for all packets, regardless of the untag bit
> > > +      * in the VLAN table.  VID 0 is used for untagged traffic on unbridged
> > > +      * ports and vlan unaware bridges. If we encounter a VID 0 tagged
> > > +      * packet, we know it is supposed to be untagged, so strip the VLAN
> > > +      * tag as well in that case.
> >
> > Maybe it isn't important, but here it is a TCI 0 that is being checked:
> > VID 0, PCP 0, and DEI 0.
> 
> Right, that is intentional (I tried to convey it in the commit
> message, though should probably also extend it here).

Thanks, I see that more clearly now.

> If any of the fields is non-zero, then the tag is meaningful, and we
> don't want to strip it (e.g. 802.1p tagged packets).

I guess there are already a lot of words there. But, FWIIW, I would lean
to wards tightening up the comment a bit.

