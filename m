Return-Path: <netdev+bounces-163022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6DF8A28C94
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 14:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 499E77A54A8
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA371442F3;
	Wed,  5 Feb 2025 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIHbyfCN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5084E13C9C4;
	Wed,  5 Feb 2025 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738763310; cv=none; b=dD9cNBIygyX63Ie8PKLfL6mMGe32UKCeB8bG/uC55nQFQHsrJxYyW25aCuCqeElK6h7pmO0KjxC3a61bDqxRsZtkzvPQ98EywEAcCw3qF1j774fA5tspUlTOxLvz/tsq+jSqPAkAvT9wzs1iuPniUILXlm7zNniJcWNFelfUdYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738763310; c=relaxed/simple;
	bh=KJBytwIPJFAahEOcJ20tY1yTFejn1o0rqevE84nSVPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A72M58W87RyUt17JKDh0kPg3ZDNSV17TDZTTZ0F72HDcXx6P1+aMEVYa2mPhXY75cp8XKeumlp+w+Hlsa+N46j3/hy3nhZ9OiklnfYYulQv352KJC1xu28bdx0UZjhBtTcTbG5vps4dk+AAVtA0vWba4lqrJ6uIF6IM1tmpKvbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIHbyfCN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11405C4CED1;
	Wed,  5 Feb 2025 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738763310;
	bh=KJBytwIPJFAahEOcJ20tY1yTFejn1o0rqevE84nSVPo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tIHbyfCNTR7ePdAi/9DhRFtH+kpYwytBniwChEvC9MRW7ixGrYznNKQiP1yYYf9hh
	 yQVQofUVvJ0qmmNvKis16Q/gM9z5HhWxW/XvSi8t7Wnt9amaxLjaUqwyyfCmS7srlW
	 ySavdZY6YrKQVlzOYGjIqvtPE6krjLT4EPIA3O79RqkHFr/y5I+sI3aYPzlQ4o6ScD
	 sBXQs3clHlLpWaImQxCbZ+5x/Sb8IBge/bqm4u2iVZ55oGWomyNS5ySkMCbQW3GKbf
	 r9fdPWHmRJ3At2rhMaq8C4eLbT8LBZcPC3HL7ZZJUCPnVg52L0Po76hNv3+jF1YUA2
	 /aR+krBiH1GNg==
Date: Wed, 5 Feb 2025 13:48:24 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?Q3PDs2vDoXMs?= Bence <csokas.bence@prolan.hu>
Cc: Laurent Badel <laurentbadel@eaton.com>,
	Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: fec: Refactor MAC reset to function
Message-ID: <20250205134824.GF554665@kernel.org>
References: <20250204093604.253436-2-csokas.bence@prolan.hu>
 <20250205132832.GC554665@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250205132832.GC554665@kernel.org>

On Wed, Feb 05, 2025 at 01:28:32PM +0000, Simon Horman wrote:
> On Tue, Feb 04, 2025 at 10:36:03AM +0100, Csókás, Bence wrote:
> > The core is reset both in `fec_restart()` (called on link-up) and
> > `fec_stop()` (going to sleep, driver remove etc.). These two functions
> > had their separate implementations, which was at first only a register
> > write and a `udelay()` (and the accompanying block comment). However,
> > since then we got soft-reset (MAC disable) and Wake-on-LAN support, which
> > meant that these implementations diverged, often causing bugs.
> > 
> > For instance, as of now, `fec_stop()` does not check for
> > `FEC_QUIRK_NO_HARD_RESET`, meaning the MII/RMII mode is cleared on eg.
> > a PM power-down event; and `fec_restart()` missed the refactor renaming
> > the "magic" constant `1` to `FEC_ECR_RESET`.
> > 
> > To harmonize current implementations, and eliminate this source of
> > potential future bugs, refactor implementation to a common function.
> > 
> > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> > Fixes: c730ab423bfa ("net: fec: Fix temporary RMII clock reset on link up")
> > Fixes: ff049886671c ("net: fec: Refactor: #define magic constants")
> > Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Sorry, I think I have to take that back for now.

Unfortunately when I was looking over this I failed to notice: that there
is a newer version of this patch (v3); the following response from Jakub to
v3; and, the response from Laurent that he is referring to.

  "Laurent responded to v1 saying this was intentional. Please give more
   details on how problem you're seeing and on what platforms. Otherwise
   this is not a fix but refactoring.

  "Please don't post new versions in-reply-to, and add lore links to
   the previous version in the changelog.

  Link: https://lore.kernel.org/netdev/20250204074504.523c794c@kernel.org/


