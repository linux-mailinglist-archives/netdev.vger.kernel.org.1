Return-Path: <netdev+bounces-170374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7BBA485D7
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809853A99FD
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 16:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1127A1DD0D6;
	Thu, 27 Feb 2025 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Inum+z0T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8921ACECF
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 16:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740675369; cv=none; b=QAMAJesElBY3y+UubTrAuxnDxe2cnuLUZv9gAbfXJl6G/QDKdL5L6ncx2TBXeOoJjhLpU64sBP/vfUG/qZNVIW9a2jNTtegDw7EdgYZcAEPV6le4nTp+CnMfX62DPG2pd/2QTBrPA7GNA2vT3tV5H4KTj+F3Cb24RLb9xgBnM8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740675369; c=relaxed/simple;
	bh=HzxrezDueZWLOUuiVzvWvhBUY2zuMYKdpRPKpdryPhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dP28eEwVJgUSlCniv8e6/9WA/QLZtzaUGGmLN9F2SmdES+ZktWkcS52Zb8nudM7pgxHX/cENzMaN6Unwk0MOSH2Q0SHyfhpWkwZq6huJM4ZOIgZd+sPc50HxS4Sf7zRQbTgn/9cJIQTgw4o+BmVzExeEs/PGpszkIx4p14aJb1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Inum+z0T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3688BC4CEE8;
	Thu, 27 Feb 2025 16:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740675369;
	bh=HzxrezDueZWLOUuiVzvWvhBUY2zuMYKdpRPKpdryPhA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Inum+z0TwvTO/u0cw+GEhs66hTxr5sd3q5HbAh11GFMlSjBIDwH0ycwbejHIlCWjz
	 ocmmrA1+Bc+uMhbmd0FAWYtLkTMPTRw0y6SkGNX+le/u0oHGXdnBitgD0JBbLkq73Z
	 9AhjpDpCz0GvkJoroyEWdDd0IvBoVcVdQu0StMiv2zN5/vBx1TrgEfNQzJnH0BWzt7
	 8q96N0bxiSol3MIrI4WpBdie6nduVJn+tgX1Rg2+DSYt+3HK79usJ8caMBNJ3vbpGQ
	 YCio3OJ7M1wmxXp+87mMecPKTwrqcZdNKWuqvatyUEslPS0kQXttKecVJNE0YMv3zY
	 5129DzRZUw+HA==
Date: Thu, 27 Feb 2025 08:56:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Gal Pressman <gal@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Joe Damato
 <jdamato@fastly.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH net-next] net: ethtool: Don't check if RSS context
 exists in case of context 0
Message-ID: <20250227085608.5a3e32d7@kernel.org>
In-Reply-To: <c034259f-ec9a-2e78-1fc0-f16981cd4e54@gmail.com>
References: <20250225071348.509432-1-gal@nvidia.com>
	<20250225170128.590baea1@kernel.org>
	<8a53adaa-7870-46a9-9e67-b534a87a70ed@nvidia.com>
	<20250226182717.0bead94b@kernel.org>
	<20250226204503.77010912@kernel.org>
	<275696e3-b2dd-3000-1d7b-633fff4748f0@gmail.com>
	<20250227072933.5bbb4e2c@kernel.org>
	<c034259f-ec9a-2e78-1fc0-f16981cd4e54@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Feb 2025 16:24:52 +0000 Edward Cree wrote:
> > I never uttered the thought that lead me to opposing. 
> > ctx 0 is a poor man's pass / accept. If someone needs a pass we should
> > add an explicit "action pass".  
> 
> To me 'pass' is just a shorthand for whatever specific behaviour
>  happens to match the default.  I.e. if you can already express
>  that behaviour directly, then 'pass' is a strictly nonorthogonal
>  addition and therefore bad interface design.

I presume sfc matches only one rule. For devices which terminate on
first hit and rules are ordered by ntuple ID, the following rules*:

 src-ip 192.168.0.2                 context 0
 src-ip 192.0.0.0   m 0.255.255.255 action -1

implement allowing only 192.168.0.2 out of the 192.0.0.0/8 subnet. 
The device may not even support RSS contexts.

I agree that pass is not very clean, but context 0 _is_ a pass.
It's not asking for context 0, it's asking for a nop rule which
prevents a more general rule from matching. To me at least.

* coin toss on the mask polarity

> But then, I'm the guy who thinks ed(1) is a good UI, so...
> 
> > Using ctx 0 as implicit pass is a very easy thing to miss
> > for driver developers.  
> 
> I don't see why drivers need anything special to handle "0 is
>  pass".  They need to handle "0 isn't in the xarray" (so map it
>  to the default HW context), which I suppose we ought to call out
>  explicitly in the struct ethtool_rxnfc kdoc if we're going to
>  continue allowing it, but it's not the fact that it's "an
>  implicit pass" that makes this necessary.  If there's something
>  I'm missing here please educate me :)

Nothing super specific, but it does produce corner cases.
We may find out if someone got it wrong once we have the test.

