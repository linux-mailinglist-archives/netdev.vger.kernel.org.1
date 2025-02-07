Return-Path: <netdev+bounces-163903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3DDA2BFD6
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 10:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE45C16275D
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 09:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA9C1DC197;
	Fri,  7 Feb 2025 09:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ad7FAkro"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57DF1B042C;
	Fri,  7 Feb 2025 09:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921633; cv=none; b=RmNGRnCn9RLqTVqBhWxlqoB2HGRcx25qa6H6aXKWrPUmWF7oz193Q/HIQsGrgl4por1bxJ84ntaZu7hs7kbDXDr/R6yzY/KmerLRmtccltdOsAa4RW5K2762ojFpJ3Z+PCAX15FQMepMirzvDsCfOHUoHWiCfGbd+sdSTWshsiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921633; c=relaxed/simple;
	bh=2GD/kJT0UypcHoax6z44zVeGP90sawaC342Y4Y/yCm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CC+/I97FjIuKcKdHJCWiy9dRPw14OHG9+dwyMtgg8yIYUZXNiyaiP74o72l043+6CEjmMA3pbn6uFykeZbJgt3P+qV+36nb5Cp/8lVbpg36Me1HVYy/rrLnWreJbvs2kcRcZCH/pfmpz4ZIwquRm9M9gSxtOLkOZvWjDsdt3Vc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ad7FAkro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7680C4CED1;
	Fri,  7 Feb 2025 09:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738921633;
	bh=2GD/kJT0UypcHoax6z44zVeGP90sawaC342Y4Y/yCm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ad7FAkroJZUt8FmE7FHNG6Ev6I1LP0ES5NxMBUoRmDt+JlVJHtggIgL13wmrzUr1W
	 tYrQ9yzDeodLiUIrF7HJ2BpVpFoApU7X4/YJmfXTp8v/n0dm4m8/R1bgCYV7FoKrFi
	 JU0WY1fLwxMhs/vJ3YoV9HPK8tXwCLfllF9KezSGh5pVudzpdm2OoT30xJ7QDrAhZ6
	 OeB730Dax4JVtJ/7M3lP8v3y/1nE2KtMMjCmd5I5N5WJmhY1eN/zrHxH3i+uKS6ouX
	 NCUnPF4FHoqEeFkzL/7VUrlfDoY64TRVJFCiWjU29KebtCVzPs13hEqZEa24ovjg7m
	 fACYD/Z2oZkjQ==
Date: Fri, 7 Feb 2025 09:47:08 +0000
From: Simon Horman <horms@kernel.org>
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH net-next v2 2/7] net: dsa: rzn1_a5psw: Use
 of_get_available_child_by_name()
Message-ID: <20250207094708.GD554665@kernel.org>
References: <20250205124235.53285-1-biju.das.jz@bp.renesas.com>
 <20250205124235.53285-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205124235.53285-3-biju.das.jz@bp.renesas.com>

On Wed, Feb 05, 2025 at 12:42:22PM +0000, Biju Das wrote:
> Simplify a5psw_probe() by using of_get_available_child_by_name().
> 
> While at it, move of_node_put(mdio) inside the if block to avoid code
> duplication.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Rebased and added patch suffix net-next.

Reviewed-by: Simon Horman <horms@kernel.org>


