Return-Path: <netdev+bounces-250757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC62D391D6
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DF2733004EEE
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 00:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3933770B;
	Sun, 18 Jan 2026 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LL64QJli"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F1550094E;
	Sun, 18 Jan 2026 00:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768695430; cv=none; b=MGLS8zE9/gxeqbO5AK4eYjb08J9vhnScHNma5YruJKAD0v+RcT52jLPXNMB4e+J5V9/eh0d7gRzhsDJI9Z+RThXeRiJSfxRvZf5egr7PCdzx880EV1vvfk1+WxsPc16sw8BMXG+CdQlI3I6N9vKAx4/f+iJJwF1qY04HRRcmUrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768695430; c=relaxed/simple;
	bh=7ar8QF6GEgKStjgL91te6hHfX5b/Epp1SjWNvQWAm1c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IaYFUIO961VgjyU5xEKOwsqyTOGRFplzRZn+3UqNxBRcCCjLCftyeKE2FaFbmyWRfB0bSP3NRQAlDx33hs0GQWo/4Kt6SmzRnBkjoqiJysGUpoQ3Hf2hF9bld4P1wwAAauA+9dD6b5talFHAp8WsS9Kr36/u1i9Mrb7rVTyCVTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LL64QJli; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68045C4CEF7;
	Sun, 18 Jan 2026 00:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768695430;
	bh=7ar8QF6GEgKStjgL91te6hHfX5b/Epp1SjWNvQWAm1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LL64QJliL7USK9X+LOL/lTZ+bQH+p06yoZsCyOnYwTjhkimYS2A/VB9u9Ulq5/ZjF
	 bLQtQj8N/nHCPEIjKCZJxXCf9BLrmDUq+j5tUuBjScuYz0n+/5xhginziFf+xwmXQj
	 RxUS51Zag1Nu4sBkWUryf0bNiRQ5GlVZUbc2er+TTK00ChsJvtNYXFIqJohy9dYIGB
	 wy7yYN7x9NCUFyJbVU1Le3DNkphCOz8VbfdXdor9CuG32EhI8KBIIdOO3Cf5CcxxMw
	 wPAzYW5zTWuqyu55makSWtS+yaIVE/Pn5gahDz4FrjqGdXO/L8Eo2p/5d9uHxXKkGi
	 0NlyMaqjRymnA==
Date: Sat, 17 Jan 2026 16:17:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chris Mason <clm@meta.com>
Cc: Daniel Golle <daniel@makrotopia.org>, hkallweit1@gmail.com,
 linux-kernel@vger.kernel.org, michael@fossekall.de, linux@armlinux.org.uk,
 edumazet@google.com, andrew@lunn.ch, olek2@wp.pl, davem@davemloft.net,
 vladimir.oltean@nxp.com, netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [v2,2/5] net: phy: realtek: simplify C22 reg access via
 MDIO_MMD_VEND2
Message-ID: <20260117161708.049eec6e@kernel.org>
In-Reply-To: <2279fd03-6261-44fb-b4c5-df2786a17aa0@meta.com>
References: <fd49d86bd0445b76269fd3ea456c709c2066683f.1768275364.git.daniel@makrotopia.org>
	<20260117232006.1000673-1-kuba@kernel.org>
	<aWwd9LoVI6j8JBTc@makrotopia.org>
	<20260117155515.5e8a5dba@kernel.org>
	<2279fd03-6261-44fb-b4c5-df2786a17aa0@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 17 Jan 2026 19:10:15 -0500 Chris Mason wrote:
> >> Yeah. Just that this is not part of the series submitted.
> >> It's rather a (halucinated) partial revert of
> >> [v2,4/5] net: phy: realtek: demystify PHYSR register location  
> > 
> > Oh wow, that's a first. No idea how this happened. Is the chunk if
> > hallucinated from another WIP patch set?
> > 
> > Chris, FWIW this is before we added lore indexing so I don't think 
> > it got it from the list. Is it possible that semcode index is polluted
> > by previous submissions? Still, even if, it's weird that it'd
> > hallucinate a chunk of a patch.  
> 
> We've definitely had it mix up hunks from other commits, but not since 
> I changed the prompts to make it re-read the files before writing
> review-inline.txt.

To be clear as Daniel mentioned the chunk in patch 4 is the other way,
so it "reverted" the direction too. At least we have a chance to use
the "mark as false positive" in the system :)

Daniel, series applied, thanks! The pw-bot is down, I think K is
repacking repos so expect a delay in the official "applied" msg.

