Return-Path: <netdev+bounces-84080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C30E8957B1
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 17:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA329285002
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 15:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C9912BF1B;
	Tue,  2 Apr 2024 15:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVbqhQio"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F167B86128
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 15:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070251; cv=none; b=qSZpdqylskiBveMKNxtQFaQy8OWDD755kK5cv9u6Zqvs9lwnEljlIdEDmkhv2xjIQ0EKlt3Fp4ZvPCRYNuE5iWYEVH8xbPxNe2EXBf0FMPcUwdG79vn/j89VB3BwyvaCnAk2NPD6dWT6jmg3Q4hTieyM3FqeFSfVF97HGQP3tyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070251; c=relaxed/simple;
	bh=L4gp16RzQVPgLpDa1F9C23q/8o5mjW2bcGpL8M6ptOQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcvHlFYtEu9H+wx877FahPWRtHVj+URHBnCP6FRb1VbtArFCxiuT0ToOyFAmnutOvQjF3l73K4Qf+1u1c0IcF0EWjoq0ZQB0cF9OMHRtEywlJDfsCFNIjdCwWGgMHeJRs4RDIcUx5j1hI9ENPoi058jJz4sqiI9bbnbLYkPv6CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVbqhQio; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B91C433F1;
	Tue,  2 Apr 2024 15:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712070250;
	bh=L4gp16RzQVPgLpDa1F9C23q/8o5mjW2bcGpL8M6ptOQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kVbqhQiolV4DqdQ3KPW6v2mKVQary8TJb9i01VP1TyM/D7TrP0XXxSu4bfVP/c6qA
	 FDmw830iGDkPKXfp1dAdXyXHvodtpy+IRaJ6Q5e1GgCD0iIVkkQXDhPrXcxK04oHDL
	 kFZoWtKe9/yjhCbYk5yddxOonJARX0b9h4kYtFTKk2N+m3p9x8++hqj3z8XxO1YJ6O
	 iaJJoXv6lceGT8rYgqRhBUP7gn9URq+NsqnxdwO1kKGXliAkJiIDSWabDgieVS6HI9
	 Nj5Ezw95+fEkeDt2/tdaCAm6CJ4hxQjeBjDim5JQyCdYZ6UnhF4803ZQCsG6S7+fcL
	 UjidQWi1rVgUg==
Date: Tue, 2 Apr 2024 08:04:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Johannes Berg <johannes@sipsolutions.net>, netdev@vger.kernel.org,
 jhs@mojatatu.com, victor@mojatatu.com, pctammela@mojatatu.com,
 martin@strongswan.org, horms@kernel.org, Johannes Berg
 <johannes.berg@intel.com>
Subject: Re: [PATCH net-next v2 1/2] rtnetlink: add guard for RTNL
Message-ID: <20240402080409.47d7252c@kernel.org>
In-Reply-To: <Zgv6o3rcgFu1DXpV@nanopsycho>
References: <20240328082748.b6003379b15b.I9da87266ad39fff647828b5822e6ac8898857b71@changeid>
	<Zgv6o3rcgFu1DXpV@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 14:31:31 +0200 Jiri Pirko wrote:
> >Signed-off-by: Johannes Berg <johannes.berg@intel.com>  
> 
> Since you add couple of helpers, I believe it is a nice custom to add a
> couple of patches that actually uses them. Would that make sense?

We discussed on v1, we want to open up the use in new code but
I don't see any benefit in rewriting existing, well tested code.
The first users are likely to be in wireless.

