Return-Path: <netdev+bounces-121065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF3195B8B6
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 16:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05F931F23DAE
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 14:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8CE1CB31D;
	Thu, 22 Aug 2024 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2EfJKBB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A2B26AC1
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 14:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724337673; cv=none; b=CVmrwzEekGEq/8/b8RReY24mQwwEuZvE4T9f27Udihow+MDZ1VtR9pPkB9ZlRbAnZIP4XLAcv0bpXLrmFgsZHbI+pO10CWpTlA1vtQT9Xg51aVckDFbBTVZJCRNZFlKAh8E2grlGoqK/IVvGSjD7uqiGwoKSN2kCULXKEdUEcrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724337673; c=relaxed/simple;
	bh=HRGyu2ZLDmHAVY6/VBIUN7nMaIP/UYvPrcnsTJQHVWk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c13ZR6FOjiVj+7xV0TDilxqYXG03iOdg96MC8MS73fxI1vPKhqSokpIpWtdj0vm/IjciMk9p1PTvYC+bReyetFDeEoJsuhsCnl3uqnJBA3ZM3c2xjgJPxS2TvvFs+DNsq+IbUL4mNFOju1A3kFKy8cyYrsz3FMH9cyONrDxawnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2EfJKBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDDC8C32782;
	Thu, 22 Aug 2024 14:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724337673;
	bh=HRGyu2ZLDmHAVY6/VBIUN7nMaIP/UYvPrcnsTJQHVWk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m2EfJKBB3NbfouVEn/2erHSA1+P7DCvt9YOm0U7HNp7wP7bGP25+pwVhd4srRQUMC
	 ovBQl2PgX5gVwAaMlAyNoyDA0jUNtBSz8Kvg8C9dMAEZyzgtFR90G7zE0HweyunbcD
	 MrE2k5VwHNvdAdKhVCEgh63rGVko5POC1cFh8/XG0A1lSHXr8BUrrtevmuCZkw9vl3
	 nlECmoC+ufYAbjLg8+sL5AzLGDvqFBNWCkw6gnTd9N/9mMpwrMgR1qLjei2n8vHTIe
	 Nn5eRV0+Zpfo2M7yRlwo0jApQBKKwy3elKS8RrHaZgGnZodSmW4ZCGfTm1P8WqFJJL
	 edixU3NdbaOFQ==
Date: Thu, 22 Aug 2024 07:41:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH v3 03/12] net-shapers: implement NL get operation
Message-ID: <20240822074112.709f769e@kernel.org>
In-Reply-To: <Zsco7hs_XWTb3htS@nanopsycho.orion>
References: <cover.1722357745.git.pabeni@redhat.com>
	<7ed5d9b312ccda58c3400c7ba78bca8e5f8ea853.1722357745.git.pabeni@redhat.com>
	<ZquQyd6OTh8Hytql@nanopsycho.orion>
	<b75dfc17-303a-4b91-bd16-5580feefe177@redhat.com>
	<ZrxsvRzijiSv0Ji8@nanopsycho.orion>
	<f320213f-7b1a-4a7b-9e0c-94168ca187db@redhat.com>
	<Zr8Y1rcXVdYhsp9q@nanopsycho.orion>
	<4cb6fe12-a561-47a4-9046-bb54ad1f4d4e@redhat.com>
	<ZsMyI0UOn4o7OfBj@nanopsycho.orion>
	<47b4ab84-2910-4501-bbc8-c6a9b251d7a5@redhat.com>
	<Zsco7hs_XWTb3htS@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Aug 2024 14:02:54 +0200 Jiri Pirko wrote:
>>> This is what I understood was a plan from very beginning.  
>>
>> Originally the scope was much more limited than what defined here. Jakub
>> asked to implement an interface capable to unify the network device
>> shaping/rate related callbacks.  
> 
> I'm not saying this is deal breaker for me. I just think that if the api
> is designed to be independent of the object shaper is bound to
> (netdev/devlink_port/etc), it would be much much easier to extend in the
> future. If you do everything netdev-centric from start, I'm sure no
> shaper consolidation will ever happen. And that I thought was one of the
> goals.
> 
> Perhaps Jakub has opinion.

I think you and I are on the same page :) Other than the "reference
object" (netdev / devlink port) the driver facing API should be
identical. Making it possible for the same driver code to handle
translating the parameters into HW config / FW requests, whether
they shape at the device (devlink) or port (netdev) level.

Shaper NL for netdevs is separate from internal representation and
driver API in my mind. My initial ask was to create the internal
representation first, make sure it can express devlink and handful of
exiting netdev APIs, and only once that's merged worry about exposing
it via a new NL.

I'm not opposed to showing devlink shapers in netdev NL (RO as you say)
but talking about it now strikes me as cart before the horse.

