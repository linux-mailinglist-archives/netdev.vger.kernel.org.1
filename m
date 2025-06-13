Return-Path: <netdev+bounces-197644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD899AD97C8
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 23:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06D51BC1A3D
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 21:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4DE24BBE4;
	Fri, 13 Jun 2025 21:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ye3A92jN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCE51FA15E
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749851536; cv=none; b=IZUmuUC8wq6HL8t0jcSFS0Vvgg7s4eWCyQXBJNcoZ7Z5PyXWUTjL86XTOdAuj0/FrCKwI0qDYmFQLN23wt+TvgUnK9cVToAfZrL0h9Rgx8pOWYM1++KQgoQO09ptaL2JHwvGIky75yzBVscVl23izAOVzK70RG9PnqonQm4Qf7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749851536; c=relaxed/simple;
	bh=uxHIeWgAl/LcaMbR79uzNT6mh4DBDLlnS/HLYxwU4i4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u9roJvjgIFuDOjFAJzJTVN+UC21Bdg3dpTdK3GxVeWUcMRWOe/eSlON4Vtf1wnJtkhdtHx+Escx84TEc//AJ/a28ZERuIZj6/Jkty3y0cbmNf8p8v7Hu3cPGJCPB3jP2jGvZ+whnPGKXUettbKxUq7PoiNuXAKGGzdpMECtEQ6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ye3A92jN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27258C4CEE3;
	Fri, 13 Jun 2025 21:52:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749851536;
	bh=uxHIeWgAl/LcaMbR79uzNT6mh4DBDLlnS/HLYxwU4i4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ye3A92jNZqlReokBnF2muvh+iIvENFLJfxloeuv9VrurcbSRXs7d5Ts8BZbH5Ywv9
	 jPuDh8jwH9/SuKSlMFqhhyrD9WYbIa6P7cZ8uQql+rh6bCYOA2B3e2UIyRoDwEOe79
	 jMrlumepSnb/pvVtNhVAp4yvKB+UOayQKaayMU2RwRKel/SP6We0SnIHwJjwiVVx+W
	 FzBBNLj1h3xfsrtuXEd8AzO9+0gn4scun1u9tsUkt+QACt8QGwFHPjza5ALiYIs3pj
	 DtfBwZW+BjmVANoaq0kRlp6B3BSKGnlTOa0gNF8dmju0Fj2UoeVDeL6toN0wzFDhYN
	 yvcoO2B3qnhWA==
Date: Fri, 13 Jun 2025 14:52:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "David Ahern"
 <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 09/14] net: ipv6: Add ip6_mr_output()
Message-ID: <20250613145215.282076c7@kernel.org>
In-Reply-To: <875xgz4fag.fsf@nvidia.com>
References: <cover.1749757582.git.petrm@nvidia.com>
	<175561dc917afb9a9773c229d671488f3e155225.1749757582.git.petrm@nvidia.com>
	<20250613094806.2e67594c@kernel.org>
	<875xgz4fag.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 20:59:27 +0200 Petr Machata wrote:
> > That would explain why you're not seeing the problem our netdevsim
> > runner doesn't have IPV6_MROUTE set, and you probably do?  
> 
> Yep, that's what reproduces it. The NIPA how-to-reproduce instructions
> show they use tools/testing/selftests/net/forwarding/config, but those
> enable IPV6_MROUTE, hence why it didn't reproduce for me.

I see. I think the wiki tries to mention that only local config is used.
I will add a couple of sentences to emphasize this.

