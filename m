Return-Path: <netdev+bounces-207537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E946AB07B3C
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 18:32:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B7327A9D68
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 16:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F11A2F549E;
	Wed, 16 Jul 2025 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ylRKZB7A"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E482F5489
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 16:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752683542; cv=none; b=FEOSj0fjGUBYayyDAzy05mx4M62jIuKXpu08nh3otgJ77+7uEzLy8zKzRwIXnK7jO7+b+hG5joOtIvWkw1AFxY5rvUJdt5AySgliVHfAFT+aVgYFiek9DEQMjX8n1582mDnmkPrR6WLJj1rNZVle5llCt1pYPryjzmvwXcUcndI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752683542; c=relaxed/simple;
	bh=a+v+Sm/Xcby6NMDIqSFvyDaq1y845R333v2c83TetRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVsbcKwghbAbk6gSBDaI6ZcQmppKnp2uAfe85k6mTEeYbn5Re+97TsPY1nYx6q4yRPDjHVUSkUma1hWzwNpoPKmtOshauE9NLkqYm1eAc+LRNN40KebCdxMw9cfa83LHjMF0iWPhbgkkWKC40vGvzYFVjBzT2SskDThsGWpDM+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ylRKZB7A; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=GLp0HTfenv42t1ZJgJJyBPupICKl7uXZLO6FiC9Y5fE=; b=ylRKZB7Ag1HUCf0KpE20wwyEx9
	/cabOgo3R/8dXj0NOapNZ+uLHnaezZ4+xuBossas3h5dD1RGHEGzh/ivVCFRhL3mc6eS0nbrPiH9p
	RPcuDfRLNUX7Ofw9AKkIufeTrTb09T3HFwZeVGYlXytjj5vf0U2Erhs8SzbE+I/Rup1w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uc53G-001hs2-Cu; Wed, 16 Jul 2025 18:32:14 +0200
Date: Wed, 16 Jul 2025 18:32:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>,
	Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Dust Li <dust.li@linux.alibaba.com>
Subject: Re: [PATCH net-next] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
Message-ID: <3cb1810d-377d-4988-bf8a-75274f7b8216@lunn.ch>
References: <20250710112817.85741-1-xuanzhuo@linux.alibaba.com>
 <20250711105546.GT721198@horms.kernel.org>
 <1752645720.5179944-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752645720.5179944-2-xuanzhuo@linux.alibaba.com>

> > > +	ret = eea_adminq_submit(enet, cmd, req_addr, res_addr, req_size, res_size);
> >
> > Please arrange Networking code so that it is 80 columns wide or less,
> > where that can be done without reducing readability. E.g. don't split
> > strings across multiple lines. Do wrap lines like the one above like this:
> >
> > 	ret = eea_adminq_submit(enet, cmd, req_addr, res_addr, req_size,
> > 				res_size);
> >
> > Note that the start of the non-whitespace portion of the 2nd line
> > is aligned to be exactly inside the opening parentheses of the previous
> > line.
> >
> > checkpatch.pl --max-line-length=80 is useful here.
> 
> We are aware of the current limit of 100 characters, and we have been coding
> according to that guideline. Of course, we try to keep lines within 80
> characters where possible. However, in some cases, we find that using up to 100
> characters improves readability, so 80 is not a strict requirement for us.
> 
> Is there a specific rule or convention in the networking area that we should
> follow? Sorry, I have not heard of such a rule before.

That suggests to me you are not subscribed to the netdev list and are
not reading reviews made to other drivers. This comes up every couple
of weeks. You should be spending a little bit of time very day just
looking at the comments other patches get, and make sure you don't
make the same mistakes.

In this particularly case, i don't think wrapping the line makes any
difference to readability. There are some cases where it does, which
is why you don't 100% enforce checkpatch. But in general, you should
keep with 80 for networking.

> > > +#define EEA_NET_PT_UDPv6_EX  9
> > > +	__le16 pkt_type:10,
> > > +	       reserved1:6;
> >
> > Sparse complains about the above. And I'm not at all sure that
> > a __le16 bitfield works as intended on a big endian system.
> >
> > I would suggest some combination of: FIELD_PREP, FIELD_GET, GENMASK,
> > cpu_to_le16() and le16_to_cpu().
> >
> > Also, please do make sure patches don't introduce new Sparse warnings.
> 
> I will try.

FYI: We take sparse warnings pretty seriously. So please try quite
hard.

	Andrew

