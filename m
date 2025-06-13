Return-Path: <netdev+bounces-197563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78FF2AD9321
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 18:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AEAE7A561F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 16:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EA7B1E3DCD;
	Fri, 13 Jun 2025 16:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLPL/nOl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0AE1E00A0
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 16:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833288; cv=none; b=KEN0SrB81+mV/fJcdayXGmitGR4mIFNZb0f5vatXKkOEMYFaogg+4hNBR7Puy1oJ4oiE1Bstye/cGr+Zw2kY19MQtZvBuuZhccodRjM7H2L1EXObusthoS7rSTnvT17180evr0iKMZmlwEAtXZVG4v57ynUXFmudvv7yKGRQceI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833288; c=relaxed/simple;
	bh=wVM1PldOxfnbUsioxOLDO5ZIHTOBjhRcNxrbX09d/DU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kxAiH0CIOLnchOMUDBffLbpKIrBg/Um/kE3HKvSfPfbVeoEtWwVGgRZuGn7Sflhe0Sc1CAVLwPEySAXUGAwBbkJ+ZOhj/B2/YRI3V9QICGablI30GBhFZDGlqlcg38noVWqTMimzXwz7xTFzxxurcTWfK29/S48eY2Xo9mUwLKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aLPL/nOl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1014DC4CEE3;
	Fri, 13 Jun 2025 16:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749833287;
	bh=wVM1PldOxfnbUsioxOLDO5ZIHTOBjhRcNxrbX09d/DU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aLPL/nOly9w8Hi62MAy2uzVYcdustZRVLyJJ2il2BhEXuwxIeCMokLvByazxfPyN7
	 PZEERrdORNQ7ZOhNLhrNtYuvOcxTo+CZgEkdskqc2I7SCxmuQV8YZngM+uV460IaFw
	 20Oe691QAA3HJHNMVTg7KZSi7x1NilUA2mghgYsK4s9U7IS1+Ke8AUggcJCiyHP/KS
	 96DfycXjGyNpFXeL1/c757/pJMxkyKrEDXtljbcHf35X39F3e/F+C9cvj6BFtgwFvq
	 +59ADUBNvs7f284tPpRU0EfkDmQuXd6unu9mly8Sm0Sykwn6S7HB3w3qweJRlPoMEB
	 bEkT61lDdfW0A==
Date: Fri, 13 Jun 2025 09:48:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@gmail.com>, <netdev@vger.kernel.org>, Simon Horman
 <horms@kernel.org>, Nikolay Aleksandrov <razor@blackwall.org>, Ido Schimmel
 <idosch@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next v2 09/14] net: ipv6: Add ip6_mr_output()
Message-ID: <20250613094806.2e67594c@kernel.org>
In-Reply-To: <175561dc917afb9a9773c229d671488f3e155225.1749757582.git.petrm@nvidia.com>
References: <cover.1749757582.git.petrm@nvidia.com>
	<175561dc917afb9a9773c229d671488f3e155225.1749757582.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Jun 2025 22:10:43 +0200 Petr Machata wrote:
> +static inline int
> +ip6_mr_output(struct net *net, struct sock *sk, struct sk_buff *skb)
> +{
> +	return 0;
> +}

Shouldn't this free the skb?

That would explain why you're not seeing the problem our netdevsim
runner doesn't have IPV6_MROUTE set, and you probably do?

Now that I found the bug in your code I will give you some extra
comments :P

