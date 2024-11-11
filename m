Return-Path: <netdev+bounces-143839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB279C465E
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 21:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27EB1F22B5D
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 20:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075A21AC427;
	Mon, 11 Nov 2024 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HktOJQFp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D56D6156C72
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 20:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731355683; cv=none; b=kUK165VlgO5VuW/Ux7MvTk5seBur+adCPdcWaPFgAksSqz2EgX1CdiGL0WgURumCqezoNk5YRvpzQUV9g5O81O4pneMRinzKPvreWdq8+1lzazNZgKWTG/ekwGcmjC4aDDwLCae+DmLX8xmSTWonsHkRzPsW/v3n7s0hUjfJwIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731355683; c=relaxed/simple;
	bh=8ntH9vYy1sqUtOC+sK1nfs92SPdwfavfOMSHVYlsCrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwAaCo6q1uk2WAs4uMtXclyAPK7kPf1DUXpd8o8h1KjWcBLbreM8EedITwgM+uPbRuEzSsuec5jCnKky1nyuxS9BR6bwWFwx+wva+DC8FXj82aoZSHpaiGWKO9UkgyefWcpYw+ytMPqCA3/mYCd1HgZyfww0A5G8xDiJ4JJiN0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HktOJQFp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B96C4CECF;
	Mon, 11 Nov 2024 20:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731355683;
	bh=8ntH9vYy1sqUtOC+sK1nfs92SPdwfavfOMSHVYlsCrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HktOJQFpNWrCgDzPE3eJujxCVvIluaKVErXXOuK9qWacOPAzYUe+W3nKn3yx5SNlh
	 xLFw6UXcmIZwkUkRxQZdjpburmy8YciBFzjBV5IDK7SLMXVUcMh7DBAo4cmB+VPJoy
	 Ti5XN4i3tQv5hv0Oji91xN7Lk7PMz9jBaRm2kgVAAjnBEZ6lbJ45A0yCate6ucHQt7
	 3WUDjsCe1KucTAa//3xkAb/Of8/qA6Ovgp+Ov6k5vllEzFUpWD/uY9NuO+uSdjQx+S
	 S7BvYebRv5d0YLhJvMYRT85HbI3hvCSwd/9DUEoOVlXhrHwB/yaP4hkmud7XE+wna7
	 k8Z6yRozW03cw==
Date: Mon, 11 Nov 2024 20:07:59 +0000
From: Simon Horman <horms@kernel.org>
To: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Pedro Tammela <pctammela@mojatatu.com>, edumazet@google.com,
	jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] Fix u32's systematic failure to free IDR entries for
 hnodes.
Message-ID: <20241111200759.GM4507@kernel.org>
References: <20241104102615.257784-1-alexandre.ferrieux@orange.com>
 <433f99bd-5f68-4f4a-87c4-f8fd22bea95f@mojatatu.com>
 <b08fb88f-129d-4e4a-8656-5f11334df300@gmail.com>
 <27042bd2-0b71-4001-acf8-19a0fa4a467b@linux.dev>
 <46ddc6aa-486e-4080-a89b-365340ef7c54@gmail.com>
 <20241110140017.GS4507@kernel.org>
 <9662e6fe-cc91-4258-aba1-ab5b016a041a@orange.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9662e6fe-cc91-4258-aba1-ab5b016a041a@orange.com>

On Sun, Nov 10, 2024 at 04:40:26PM +0100, Alexandre Ferrieux wrote:
> On 10/11/2024 15:00, Simon Horman wrote:
> > On Mon, Nov 04, 2024 at 10:51:01PM +0100, Alexandre Ferrieux wrote:
> >> 
> >> I believe you mean "let the compiler decide whether to _inline_ it or not".
> >> Sure, with a sufficiently modern Gcc this will do. However, what about more
> >> exotic environments ? Wouldn't it risk a perf regression for style reasons ?
> >> 
> >> And speaking of style, what about the dozens of instances of "static inline" in
> >> net/sched/*.c alone ? Why is it a concern suddenly ?
> > 
> > Hi Alexandre,
> > 
> > It's not suddenly a concern. It is a long standing style guideline for
> > Networking code, even if not always followed. Possibly some of the code
> > you have found in net/sched/*.c is even longer standing than the
> > guideline.
> > 
> > Please don't add new instances of inline to .c files unless there is a
> > demonstrable - usually performance - reason to do so.
> 
> Sure, I will abide in the next version :)
> 
> That said, please note it is hard to understand why such a rule would be
> enforced both locally and tacitly. Things would be entirely different if it were
> listed in coding-style.rst, advertising both consensus and wide applicability.

Thanks,

I completely agree that it would be better if it was documented somewhere.
I will add that to my TODO list.

