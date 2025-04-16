Return-Path: <netdev+bounces-183435-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EFAA90A6F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE14C5A1DEB
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 17:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD12217723;
	Wed, 16 Apr 2025 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdBVAovm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D1F215F42;
	Wed, 16 Apr 2025 17:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744825728; cv=none; b=M4/jKtEAcclRuxO3szEucFJ2/RiDrzwm72BTqFF2xqfoOvWZLRExNvdgElyrgV2n7B1sz6rI6OVKVLN2HgW+E85NnnpFkTYUH3l4VkvFr6htFT5OavAPYik96GZD/OsGHMOrs1BbSB+vejanCAcmVJeiBkcHT4R3H2yI0nCSqbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744825728; c=relaxed/simple;
	bh=v4XwhaUeZk3BYsAXaR29UkZdFjLWFGa044ZokdLWR8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz7VWr1tycKxD89N08ox1V7PAHE7egYE1f8UeFFrI9FyO8SYVxNAR3Hb6SubB/0Tl+9MWprqHLA1oQWkIahH8w7Vo13Ii9u2dTe0I5Z9KSAE6ac1rn7VvwSef2H8ffOmJPokMAEshLmWEBxWW70WNptWjVUySJwJ13YSfK5Ofaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdBVAovm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0408C4CEE2;
	Wed, 16 Apr 2025 17:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744825727;
	bh=v4XwhaUeZk3BYsAXaR29UkZdFjLWFGa044ZokdLWR8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GdBVAovmhB1UljmHHNyLhF0hxqGhhRuRKXZwqcyO/adBY48zZBRbdDbJB9M7PJs+9
	 0j2ko3cmHZdfFrkH5ZvxYdo9QFPEclZ3dj/jgrPIp3sr9duFHwG5JT2pijcIt27V07
	 ZNX2u2l/RkL/hLsy/MtGuWmctwaG39Vfk7ejLVl+rzVAMCzANGUNVa9rlfzZYwIuNl
	 AxFhvAvI0iDRRAQnzJZ3nFXpyy0F9M4Jmp8pKWFsEjPqMUDzjlZl99QnYpNx1IAIHf
	 xvazOMDRyHkBglCDin7oFj4gJXMJRW+IYMi4GP7mzpkt1qGQpeus7aotP6Kaj8CDgY
	 wlFKWO6r1sP8A==
Date: Wed, 16 Apr 2025 10:48:45 -0700
From: Kees Cook <kees@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	Jeroen de Borst <jeroendb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>, Geoff Levand <geoff@infradead.org>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Joshua Washington <joshwash@google.com>,
	Furong Xu <0x1207@gmail.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jisheng Zhang <jszhang@kernel.org>, Petr Tesarik <petr@tesarici.cz>,
	netdev@vger.kernel.org, imx@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	Shailend Chand <shailend@google.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Andrew Halaney <ahalaney@redhat.com>, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: ethtool: Adjust exactly ETH_GSTRING_LEN-long stats
 to use memcpy
Message-ID: <202504161047.79ED8EF5@keescook>
References: <20250416010210.work.904-kees@kernel.org>
 <20250416110351.1dbb7173@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416110351.1dbb7173@kmaincent-XPS-13-7390>

On Wed, Apr 16, 2025 at 11:03:51AM +0200, Kory Maincent wrote:
> On Tue, 15 Apr 2025 18:02:15 -0700
> Kees Cook <kees@kernel.org> wrote:
> 
> > Many drivers populate the stats buffer using C-String based APIs (e.g.
> > ethtool_sprintf() and ethtool_puts()), usually when building up the
> > list of stats individually (i.e. with a for() loop). This, however,
> > requires that the source strings be populated in such a way as to have
> > a terminating NUL byte in the source.
> > 
> > Other drivers populate the stats buffer directly using one big memcpy()
> > of an entire array of strings. No NUL termination is needed here, as the
> > bytes are being directly passed through. Yet others will build up the
> > stats buffer individually, but also use memcpy(). This, too, does not
> > need NUL termination of the source strings.
> > 
> > However, there are cases where the strings that populate the
> > source stats strings are exactly ETH_GSTRING_LEN long, and GCC
> > 15's -Wunterminated-string-initialization option complains that the
> > trailing NUL byte has been truncated. This situation is fine only if the
> > driver is using the memcpy() approach. If the C-String APIs are used,
> > the destination string name will have its final byte truncated by the
> > required trailing NUL byte applied by the C-string API.
> > 
> > For drivers that are already using memcpy() but have initializers that
> > truncate the NUL terminator, mark their source strings as __nonstring to
> > silence the GCC warnings.
> 
> Shouldn't we move on to ethtool_cpy in these drivers too to unify the code?

I decided that the code churn wasn't worth it. Perhaps in a follow-up
patch if folks want to see the removal of the explicit memcpy() uses?

-- 
Kees Cook

