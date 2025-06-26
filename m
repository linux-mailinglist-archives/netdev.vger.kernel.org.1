Return-Path: <netdev+bounces-201421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51989AE96AE
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E311675CB
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 07:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F06323B613;
	Thu, 26 Jun 2025 07:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVGcUQv6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F0223ABAD;
	Thu, 26 Jun 2025 07:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750922594; cv=none; b=uxG/D4iOqQORRhDqPLFmmWt2kQnQy2Ak8DOJTpmYP9tfRCkJ4ZlVNtm3Kl0YVc6VO3jTA+knBE8TdBJeguTpApqUKFE7Rjfu9jm8HeyxwtW9loqT41Ni6upGeYNUvmgqwC3S6eolhQu+VhICrPrOJgIunVQbfSuGIW5arzkl+NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750922594; c=relaxed/simple;
	bh=dSPoY0RTF1Wz7DfHLCqbTmsTIUvPWjfQthz5/822Et8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvcrOZRSB35+ebVkaZTEsqPDd/uUr7l6lrXqDs1wEaVZoGRmYSVgA5i/TWGWLbnM+KR5d1qeMcesiNOPt2mkZR2a3Oi8Jqk9c957F0Iu780dHPDahOCbO7eMM3Ej2v5srKY3Lb9uhff6w00YBcQ6rhsVWnVnGfxxmi2O9yvpuik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVGcUQv6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 404EDC4CEEB;
	Thu, 26 Jun 2025 07:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750922593;
	bh=dSPoY0RTF1Wz7DfHLCqbTmsTIUvPWjfQthz5/822Et8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aVGcUQv6TheU857JqgXR7TFkxH3ZjZlChGuDicn+jBA6zuQVryeNpGhk55jj6jfsE
	 01yDToqQFgLs0rlffFNCCu83JmoqQn+k6ifjjVwhaZNAvkzG9orc0xZeCc61rULHdI
	 JWXfKtHvNQvRBiDqe9g+58fNjHyDkEnSDnT3+Y/J4QkUKQ+s0uiGJbjD+S6wyMcR7Y
	 yQz5aj7uza849zT6OIm1/RCi15qdmkXuBUaL1C8/J1Vbz0Xsf1dNqHwh3Sm2O9XYFt
	 HoOKPLvwaidLCENWzL8xc6ZvKpOR/tDNS2QyEsCmWDHHsgVhA9OuOdQ1AEgfIGwCzT
	 i4Ch+zvhw5GGw==
Date: Thu, 26 Jun 2025 08:23:08 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Wei Fang <wei.fang@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH v2 net-next 0/3] change some statistics to 64-bit
Message-ID: <20250626072308.GQ1562@horms.kernel.org>
References: <20250624101548.2669522-1-wei.fang@nxp.com>
 <20250624181143.6206a518@kernel.org>
 <PAXPR04MB8510EDB597AD25F666C450ED887BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250625163459.GD152961@horms.kernel.org>
 <20250625133224.275a8635@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625133224.275a8635@kernel.org>

On Wed, Jun 25, 2025 at 01:32:24PM -0700, Jakub Kicinski wrote:
> On Wed, 25 Jun 2025 17:34:59 +0100 Simon Horman wrote:
> > > Simon has posted a patch [1] to fix the sparse warnings. Do I need to wait until
> > > Simon's patch is applied to the net-next tree and then resend this patch set?
> > > 
> > > [1] https://lore.kernel.org/imx/20250624-etnetc-le-v1-1-a73a95d96e4e@kernel.org/  
> > 
> > Yes, I have confirmed that with patch[1] applied this patch-set
> > does not introduce any Sparse warnings (in my environment).
> > 
> > I noticed the Sparse warnings that are otherwise introduced when reviewing
> > v1 of this patchset which is why I crated patch[1].
> > 
> > The issue is that there is are long standing Sparse warnings - which
> > highlight a driver bug, albeit one that doesn't manifest with in tree
> > users. They is due to an unnecessary call to le64_to_cpu(). The warnings
> > are:
> > 
> >   .../enetc_hw.h:513:16: warning: cast to restricted __le64
> >   .../enetc_hw.h:513:16: warning: restricted __le64 degrades to integer
> >   .../enetc_hw.h:513:16: warning: cast to restricted __le64
> > 
> > Patches 2/3 and 3/3 multiply the incidence of the above 3 warnings because
> > they increase the callers of the inline function where the problem lies.
> > 
> > But I'd argue that, other than noise, they don't make things worse.
> > The bug doesn't manifest for in-tree users (and if it did, it would
> > have been manifesting anyway).
> > 
> > So I'd advocate accepting this series (or not) independent of resolving
> > the Sparse warnings. Which should disappear when patch[1], or some variant
> > thereof, is accepted (via net or directly into net-next).
> 
> All fair points, but unfortunately if there is a build issue 
> the patches are not fed into the full CI cycle.

Thanks, I wasn't aware of that.

> Simon's fix
> will hit net-next tomorrow, let's get these reposted tomorrow
> so we can avoid any (unlikely) surprises?

Yes, agreed. Let's avoid surprises.

