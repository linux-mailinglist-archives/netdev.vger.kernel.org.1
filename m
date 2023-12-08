Return-Path: <netdev+bounces-55353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1D680A84A
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 17:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174D21F21037
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 16:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC50535289;
	Fri,  8 Dec 2023 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZCJd6yb0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A158F32C94
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 16:11:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F21FC433C8;
	Fri,  8 Dec 2023 16:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702051885;
	bh=Sc9YQc2ZtERirKilR5PYEwCVk4l9Nb2+xp/9aa3xndg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZCJd6yb0znj+OD5PXLlKDbIcWCgjari7yVGK34opK5nXUsKq6qhNw+qUlL1h6lGom
	 EooE1cdE5C6VzuuHNdp4XmS+jB+lInSBeKSgRLc/YEOzbk92Wtm0HM/tIH6tADdfYM
	 Ys7+qSjIY7vOrML9MQufvtAhOhnr0nGl7vK/Ft4AA0rHL1vbw4czr1HRpOykaFaVzU
	 s7bx5Q8OVnhsYwst9SDBZQyEsqmaSxhimd1JaJyWaBq94Hn16x80cX212w4vXlkJkZ
	 shL9TR48O85hvJGOsPl8cLel/J/naoPmOTsgwOJlkFrdQm8/Qw6B+Veva6QqGD8n3S
	 Y4o7CjT8LdCug==
Date: Fri, 8 Dec 2023 08:11:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, jacob.e.keller@intel.com, jhs@mojatatu.com,
 johannes@sipsolutions.net, andriy.shevchenko@linux.intel.com,
 amritha.nambiar@intel.com, sdf@google.com, horms@kernel.org,
 przemyslaw.kitszel@intel.com
Subject: Re: [patch net-next v5 5/9] genetlink: introduce per-sock family
 private storage
Message-ID: <20231208081123.448e4c5b@kernel.org>
In-Reply-To: <ZXMmgJHPdBUFlROg@nanopsycho>
References: <20231206182120.957225-1-jiri@resnulli.us>
	<20231206182120.957225-6-jiri@resnulli.us>
	<20231207185526.5e59ab53@kernel.org>
	<ZXMmgJHPdBUFlROg@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 8 Dec 2023 15:21:52 +0100 Jiri Pirko wrote:
> >> +static struct genl_sk_priv *genl_sk_priv_alloc(struct genl_family *family)
> >> +{
> >> +	struct genl_sk_priv *priv;
> >> +
> >> +	priv = kzalloc(size_add(sizeof(*priv), family->sock_priv_size),
> >> +		       GFP_KERNEL);
> >> +	if (!priv)
> >> +		return ERR_PTR(-ENOMEM);
> >> +	priv->destructor = family->sock_priv_destroy;  
> >
> >family->sock_priv_destroy may be in module memory.
> >I think you need to wipe them when family goes :(  
> 
> Crap. That's a bit problematic. Family can unregister and register
> again, with user having the same sock sill opened with legitimate
> expectation of filter being applied. Don't see now how to handle this
> other then no-destroy and just kfree here in genetlink.c :/ Going back
> to v4?

When family gets removed all subs must be cleared. So the user
sock will have to resolve the mcast ID again, and re-subscribe
again to get any notification. Having to re-sub implies having
to re-add filters in my mind.

