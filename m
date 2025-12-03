Return-Path: <netdev+bounces-243431-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EA5CA0C04
	for <lists+netdev@lfdr.de>; Wed, 03 Dec 2025 19:04:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 522263006FEB
	for <lists+netdev@lfdr.de>; Wed,  3 Dec 2025 18:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C30333CEA8;
	Wed,  3 Dec 2025 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OAJ3ZS6s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0645D33C521
	for <netdev@vger.kernel.org>; Wed,  3 Dec 2025 17:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764784524; cv=none; b=fy30JnblRecznO8YHlf6JHdpcCNW0YXJgr/flhKSzDrE0HDi76GYkM8ktmUJkMd1jzk1TjjMhRiH0BTV2Q2ftgzNOS4DYdhi98zalZlQ9I+FMzyfRMe6Zei0TckZWlSiRvpNS8fDTVlxuTTkB+dSAi7Cbui15TO7gUj3AjY+GDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764784524; c=relaxed/simple;
	bh=UEq6YRmzdnKIb5LN0ifPryqVlJKAGV73r36B2kpLLEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHmaPPfhsZxvYp27QDdmU+Hek2DvF+aiHpMxwbKR66bk8Yo/4iorNY8XJRS/OfHpSkqTUMLtOjq+c4iDQRbGc+1csnx5sMzonOcQHMDAgQPMESS/3lZRn9eMejzbWridxtt7oB40orh5XCQ1sEOxgx1rQ++xvlFcHP2X5B6kIAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OAJ3ZS6s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C77AC4CEF5;
	Wed,  3 Dec 2025 17:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764784523;
	bh=UEq6YRmzdnKIb5LN0ifPryqVlJKAGV73r36B2kpLLEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OAJ3ZS6s700Q/czGQgnkZOTw038ubKoePWMiJnSob8BWRvROJZImv2vHLo3orWEq4
	 KDIMkcO+OMkZQWZyD184TaYzZdtT5JXCB6rw/FE8MTE98Ke1ktCbwRZRcvTzMKSNek
	 4DRJxQuoRKOLMuS0P7QaoksFhOREuS+aQRQjrtmb/CXs1dMgtg1anjB6TOyfbicuPx
	 Wz8yTOF3Hyy0TKH4Ypl/wnZUJDGgEk+FOd/soYlGsUIa+FyIA8mK1wk/rSADeC33SR
	 SeFX3qF1nFpV/WC4kgy7aTWKhWBctFjyjvXGV5eOAK51c73D9OwYi8SgmXgpYOa46C
	 UM9iaYJ6FwXEA==
Date: Wed, 3 Dec 2025 17:55:19 +0000
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>, mlxsw@nvidia.com,
	Jiri Pirko <jiri@resnulli.us>
Subject: Re: [PATCH net 2/3] mlxsw: spectrum_router: Fix neighbour
 use-after-free
Message-ID: <aTB5h090Hu9BHFJ1@horms.kernel.org>
References: <cover.1764695650.git.petrm@nvidia.com>
 <92d75e21d95d163a41b5cea67a15cd33f547cba6.1764695650.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92d75e21d95d163a41b5cea67a15cd33f547cba6.1764695650.git.petrm@nvidia.com>

On Tue, Dec 02, 2025 at 06:44:12PM +0100, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> We sometimes observe use-after-free when dereferencing a neighbour [1].
> The problem seems to be that the driver stores a pointer to the
> neighbour, but without holding a reference on it. A reference is only
> taken when the neighbour is used by a nexthop.
> 
> Fix by simplifying the reference counting scheme. Always take a
> reference when storing a neighbour pointer in a neighbour entry. Avoid
> taking a referencing when the neighbour is used by a nexthop as the
> neighbour entry associated with the nexthop already holds a reference.
> 
> Tested by running the test that uncovered the problem over 300 times.
> Without this patch the problem was reproduced after a handful of
> iterations.

...

> Fixes: 6cf3c971dc84 ("mlxsw: spectrum_router: Add private neigh table")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>


Reviewed-by: Simon Horman <horms@kernel.org>


...

