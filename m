Return-Path: <netdev+bounces-186799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2462AA130C
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 19:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AA9D16B1AD
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FA23250C15;
	Tue, 29 Apr 2025 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nvQ0eYrH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC4B24EAB2
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745945891; cv=none; b=M/9sxv4iKuqxe5Wcyx5yCwD5dx+LRBr2lkB5wZSQ3vPaTsrnX30/2BFZGNpMbXcuOurAyitjH6kpTAMdgIr6PJwikwjybJSvkjnsnM/UJoqNQloXaMA8t1N5pTcKXoormvLrEcGh1SgI7Gz/lM5sXeSO/5CxcgzUxHQfRUfo0JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745945891; c=relaxed/simple;
	bh=CXeuuacRQiUPgfGn9X2aS8wImkw75hTDe3VXsb8Myj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hyqmtO/wBNRikPzhUWXqS1aPxPTQOmhwyK9sAdybhP5xgGGApjdFp247SVvLAJE4+fMR8cKKh7iE7HZMHYqV/N8e91qwnazKNpz+AzHcy/QmgYf766QdevJg2amSVPbswTrvZUek5pkmQVaHl7rlXm+lWZTepBQEQ7jDP7fqw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nvQ0eYrH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA705C4CEF0;
	Tue, 29 Apr 2025 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745945891;
	bh=CXeuuacRQiUPgfGn9X2aS8wImkw75hTDe3VXsb8Myj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nvQ0eYrHWezaM1eJIGRWGli/n3nD7urFiIN2S2A5grk160A3LEbiyx25UQ8maguUy
	 s6rF3xZnZ73Xv5v9S0k/dvyAJlmxjKFJyUY5deCC6GAXgt6jJyKnhGSArE5e2w5zU8
	 1E11mMbPT9RkDtuTMx8DZ8CYf9FHk0BzHAgG60E6kiSaoBgoR4/B0hX/kozGYG5Jh3
	 pdSMEz+8mOMje9VjP2m1RdStAAY4HF05ZkEnQVwVCX9k6q+UlNtdYKFW4HmeCggdzI
	 imI5SwwAVZTIf1kvNScykRYasGMqXzB99qDA+ko2wESTbspW5kQEwS2wEi4YjE7d/9
	 fX4hW7QhLwGkg==
Date: Tue, 29 Apr 2025 09:58:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
 <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
 netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
 <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>
Subject: Re: [PATCH net-next V3 14/15] devlink: Implement devlink param
 multi attribute nested data values
Message-ID: <20250429095809.1cbabba4@kernel.org>
In-Reply-To: <bdk3jo2w7mg5meofpj7c5v6h5ngo46x4zev7buh7iqw3uil3yx@3rljgtc3l464>
References: <20250425214808.507732-1-saeed@kernel.org>
	<20250425214808.507732-15-saeed@kernel.org>
	<20250428161732.43472b2a@kernel.org>
	<bdk3jo2w7mg5meofpj7c5v6h5ngo46x4zev7buh7iqw3uil3yx@3rljgtc3l464>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Apr 2025 13:34:57 +0200 Jiri Pirko wrote:
> >I'd really rather not build any more complexity into this funny
> >indirect attribute construct. Do you have many more arrays to expose?  
> 
> How else do you imagine to expose arrays in params?
> Btw, why is it "funny"? I mean, if you would be designing it from
> scratch, how would you do that (params with multiple types) differently?
> From netlink perspective there's nothing wrong with it, is it?

The attribute type (nla_type) should define the nested type. Having 
the nested type carried as a value in another attribute makes writing
generic parsers so much harder. I made a similar mistake in one the the
ethtool commands.

We should have basically have separate attr types for each of the value
sizes:
	DEVLINK_ATTR_PARAM_VALUE_DATA_U32
	DEVLINK_ATTR_PARAM_VALUE_DATA_BOOL
etc. They should be in a separate attr space, not the main devlink_attr
one, but every type should have its own value_data attr type.

