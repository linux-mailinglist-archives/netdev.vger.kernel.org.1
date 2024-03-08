Return-Path: <netdev+bounces-78828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A470B876B3A
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 20:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443A71F219CF
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 19:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9C35A7A2;
	Fri,  8 Mar 2024 19:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rxaG6iIh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DFC2BD0F
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 19:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709926288; cv=none; b=OMWNkZWYExaaiYpbDrRvQQjoCqeXWp3IFOw8JUT21gmfIVIFoA/+h9CUE8OhTwWeqFbyhaMU92yScuAXwCuR7b5P91MkpRcIyL5p0G/BDY9aS2AG74u5nNC+2qDBgcXkNG5a+Dwvk+EMtQh/sHsXS81WHrtMQu1cEEbmDWyXb5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709926288; c=relaxed/simple;
	bh=t3JTR5HK46+4dS0EnF6ae+NHT4Dw5ciQxwQXHuA/e9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5VIfSbE/DCfbmHziWDGHylL5MXx2L0xuCjFu+ry7NJr8LGXuPb1QfGoqowRGpyMfG9e6KKf4tB92w1/d0cv6MUGUwnLAP38Iq//IyiRSm3neAII8g7UPPCBHZsBecow4jypLX/k7eT2LrkzWUEEdJiUk+amvYQI6K2aq1ADozM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rxaG6iIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA39C433C7;
	Fri,  8 Mar 2024 19:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709926287;
	bh=t3JTR5HK46+4dS0EnF6ae+NHT4Dw5ciQxwQXHuA/e9U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rxaG6iIhldAk8qnPcqAU6OQmfPCS74OhDrX90dWbCpZYCUy1A3CDszUOjVjkVbCpx
	 SkR4slzkpoAK1qIxaypleWSljcyMOGFyvdWI+i13QTUYHco+7b63Pakv2vZ6fnzXgU
	 KoW2/Lf3jg6ZpnMy3mlRXt8pVlrk+IyUaMgM4hHadILD3Fe67QuCJc/RUr2SEx7g4X
	 Ptd3sruM2R/nJsvklDIHX8ZzeVhVy5pfr5N/vT89wuWDo0jMZIqAthjhfrNEqBeOeJ
	 eqrO87ajv90vYGL3jekzh8Yw1tBZ8balREFyw07xYoZe9MwXilq48irz/uAtdJ59Gt
	 f+HFvJSburWKA==
Date: Fri, 8 Mar 2024 11:31:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Ahern <dsahern@kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 1/4] ipv6: make inet6_fill_ifaddr() lockless
Message-ID: <20240308113126.33920e12@kernel.org>
In-Reply-To: <106b95fc-139e-45dd-87ba-f8e536b37ff3@kernel.org>
References: <20240306155144.870421-1-edumazet@google.com>
	<20240306155144.870421-2-edumazet@google.com>
	<f4bcf5fd-b1b0-47a8-9eb3-5aae2c5171b7@kernel.org>
	<CANn89iJDfhJRPta063ujaASOvgvZ_imeBytm0OWsJ_7oKC4txg@mail.gmail.com>
	<106b95fc-139e-45dd-87ba-f8e536b37ff3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Mar 2024 08:26:56 -0700 David Ahern wrote:
> > If I had to explain this in the changelog, I guess I would not do all
> > these changes, this would be too time consuming.  
> 
> The request was something simple as the following in the changelog:
> 
> "New objects not in any list or table do not need the annotations, nor
> do updates done while holding a lock."

I was gonna add this when apply but looks like DaveM's already merged
this :S

