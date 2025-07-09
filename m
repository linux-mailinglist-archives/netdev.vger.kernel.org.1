Return-Path: <netdev+bounces-205216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E4FAFDD0B
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A866E4E26CA
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 01:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E297404E;
	Wed,  9 Jul 2025 01:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcNIel8F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7CFEEB3
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 01:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752025255; cv=none; b=IlWYfDVzJ84vCYWxE4O+fpB4kE18P3tzssTRyskoJJ3JyCoGeiBqAM4N3nZynaPPTv5s8MKAVj9PkHnneq5JFTCm6NQtZa6FlbYG3731KemrvPF7Ur4z+iRVi6WbLUIrWEFfuQMfNa+8FYBx46pf1Y0Q5/rpY65d1uzjreHw9Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752025255; c=relaxed/simple;
	bh=JJrGX+/Q7KDQnbrK5X/3p13snF6+OyBlb9FLWSmpjEE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhF8LzYwEmyq4cc62xye+Jb4ifdoWcnPZKHQNyXK479bhTRYfRXuANuGIbiUm06kxtNXMgE3IdHpzvdpF05RewAhHPx330TCpxq10iTEu8se6sxYvfwHFlfgE17/0TgDvx3aXXn31I5F2/fApjmVy6YJhUqEWBUOa5xJLFiC6qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcNIel8F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D4B3C4CEED;
	Wed,  9 Jul 2025 01:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752025254;
	bh=JJrGX+/Q7KDQnbrK5X/3p13snF6+OyBlb9FLWSmpjEE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bcNIel8FzjI1H7pMorLAiZCS/cWhdcn2C7su2NEMn5nRhfyfl0Qxtq6qglBw/PrfD
	 HRogYlHEiX/a0mLjf+LHrOzzGd27+Lw1D8twWWVt7CmUHOnH73wErzR70dkJYhTmvu
	 FicLH9FgeCsWh7zqK5Pj5NIl+D7Q1LohkXP+tE9z5iF5solmWOfw6p37V+XipSiQqo
	 i/n3Pwvh5IxjWY8sypeOnbqJ52YK74ptw7WtNQrayhEwKcavcFTbv9nMjKj18Z4Gf8
	 JDiQLLRT4Fh9xTsELHME294FyD3BR0oxTjJfeCQmGLS3CGyQ8DgeJb2yeySL3x0ohA
	 5v4hPi/oNQIew==
Date: Tue, 8 Jul 2025 18:40:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 14/15] ipv6: anycast: Don't hold RTNL for
 IPV6_JOIN_ANYCAST.
Message-ID: <20250708184053.102109f6@kernel.org>
In-Reply-To: <20250702230210.3115355-15-kuni1840@gmail.com>
References: <20250702230210.3115355-1-kuni1840@gmail.com>
	<20250702230210.3115355-15-kuni1840@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Jul 2025 16:01:31 -0700 Kuniyuki Iwashima wrote:
> -struct net_device *__dev_get_by_flags(struct net *net, unsigned short if_flags,
> -				      unsigned short mask)
> +struct net_device *dev_get_by_flags_rcu(struct net *net, unsigned short if_flags,
> +					unsigned short mask)

Could you follow up and toss a netdev tracker in here?
Not sure how much it matters but looks trivial, and we shouldn't really
add APIs that take a bare reference these days..

