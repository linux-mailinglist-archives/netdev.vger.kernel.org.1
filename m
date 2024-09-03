Return-Path: <netdev+bounces-124687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3A796A710
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 21:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BA7D1F2510F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 19:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96E61D223A;
	Tue,  3 Sep 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVSOy3sV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31AD1D222E
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 19:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725390263; cv=none; b=Ly/3Z4mYLUm5hEg1wDUq9mKkdooj7WYZ+K1lfLWE+Tuhw0UCGcmaRSOX10t2vBG9S7SpbXt9Ft2HyCLy5mln1BUbq/qWfL8hgbfgkW5aEeTpuBFHqxwUcJ43LfAWKc0wC5otQyLZ01nm2LjqZkbaW1eXfG1XA6hJ+75ZugswiLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725390263; c=relaxed/simple;
	bh=jdxC7E9HrLhB6tJuAbl4SHYAmXAeRYQlGzJQzLuzjl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gE2fk0oHq+lrv0G+DNRT7kYnnly6btK3xPs2fOSBgDoR0NAxfJ9C9Md/dR4Qjsc4sEMO+O4V4dEZVnIOCS1GzaHDQE64zavEbJpro27b+ONQomh795ag602ccz1+exC2xGTQJJ7hJwV+pEtkoZh07JN9nrapTP8nvTEN7LCrnwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVSOy3sV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C54C4CEC5;
	Tue,  3 Sep 2024 19:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725390263;
	bh=jdxC7E9HrLhB6tJuAbl4SHYAmXAeRYQlGzJQzLuzjl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVSOy3sVt4Dd8NLQuX9Epz6zLv+tn/C8eCfizxjU3sAl6mM8GithrSZwPLUjpVtqx
	 taIDPy64ImZqHaj33l8gHZxG2LHgcRXsP3+TTX1NhE/dEWZF7yfPoiC+ZvwsDZTrs6
	 SuBaPiF5FE3B/mO+Qdo3Z5s7/pOwg6V16hTfe6Fbam1atIYPfv4smRnrhtw/OZe9w3
	 ox2GnITSWeUcBgLkHWYjxPNfIKPwytKtHta3rQVATNjQavJDRhVRkM3BIq2GVNV6t6
	 /DNLq5PBifS1+JRKYoOQhzY2zEk9HBxfZYVWNzOqfICho7ZhvrbYZWa7qmI0GwjPft
	 Xrc1RjHSAmkMg==
Date: Tue, 3 Sep 2024 22:04:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Feng Wang <wangfe@google.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>, netdev@vger.kernel.org,
	antony.antony@secunet.com
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <20240903190418.GK4026@unreal>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
 <20240831173934.GC4000@unreal>
 <ZtVs2KwxY8VkvoEr@gauss3.secunet.de>
 <20240902094452.GE4026@unreal>
 <CADsK2K9_MVnMp+_SQmjweUoX1Hpnyquc1nW+qh2DDVUqPpEw8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADsK2K9_MVnMp+_SQmjweUoX1Hpnyquc1nW+qh2DDVUqPpEw8w@mail.gmail.com>

On Tue, Sep 03, 2024 at 11:19:41AM -0700, Feng Wang wrote:
> This patch simply assigns a value to a field, replicating existing
> crypto offload behavior - it's working/tested in that mode. Many
> instances within the kernel code utilize this information in different
> cases, making the implementation pretty simple and safe.

Not really, the thing that you are adding secpath in the place which
wasn't designed to have it, is very problematic. Crypto and packet
offloads are two different things as they treat packets differently.
First one sees them as ESP packets, while the second one sees them as
plain text packets.

> 
> Hi Leon,
> 
> "It is not specific to mlx5, but to all HW offload drivers. They should
> implement both policy and SA offloading. It is violation of current mailing
> list deign to do not offload policy. If you offload both policy and SA, you
> won't need if_id at all."
> 
> Could you please clarify why the if_id is unnecessary in scenarios
> with hardware offload?

I have no objections to support xfrm IDs in the packet offload, my
request is to have upstream driver which uses this feature.

> 
> For instance, imagine I have two tunnel sessions sharing the same
> source and destination addresses. One tunnel utilizes xfrm ID 1, while
> the other uses xfrm ID 2. If a packet is sent out via xfrm ID 1 and
> lacks any specific markings, how does the hardware offload determine
> that this packet belongs to xfrm ID 1 and not xfrm ID 2? This
> distinction is crucial for the hardware to locate the correct
> encryption information and encrypt the packet accordingly.

HW doesn't know about xfrm ID, as this information is kernel specific.
In order HW will use this information someone needs to pass it to HW,
while configuring SA/policy and nothing in the kernel does that.

Thanks

> 
> Thanks for your help.
> 
> Feng

