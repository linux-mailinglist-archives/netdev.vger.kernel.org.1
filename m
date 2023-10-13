Return-Path: <netdev+bounces-40737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E357C88DF
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 17:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52D91B20A79
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 15:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C86F1BDD6;
	Fri, 13 Oct 2023 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXbQOSGf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F8C19BB2
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 15:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15186C433C9;
	Fri, 13 Oct 2023 15:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697211587;
	bh=g8IGIjSrt6iKGQlk0YPtGClAiNwPhcqpiCccTcNNTfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fXbQOSGfEoOdzNzovdfIDZY7ntIJQPT2tKPzl4v6zeCbZtZu6JBP+463oiXc+t431
	 3WIvwSDyeTOM11/lTs+Fsh/EEWWj2LWCiOokf/mKOGIqpS2DD7casdVT9XVfViZ4C6
	 +Lp5Yi0/nVWehV6rlAsDdtOMlfGMKtSHYGqfKqOSGy5XFsTkjHRiEi6QJA9S0QzcNl
	 Ho/1d7ZWa7t3W176IwPAPIdCgrRBkYnvm0IAKtYJbotSjBH6H6UWW3Dd9QRIJABf7B
	 piwWG6H0yaEgfB0OPvneokh//TXmNQop5RotpQv3ONY+0Hjo/YL//SomWZ+DNLzeh6
	 /THmXTU/YBtgA==
Date: Fri, 13 Oct 2023 08:39:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, gal@nvidia.com
Subject: Re: [patch net-next] devlink: don't take instance lock for nested
 handle put
Message-ID: <20231013083945.3f6d8efe@kernel.org>
In-Reply-To: <ZSeOq+I+Z12E/oRC@nanopsycho>
References: <ZSEwO+1pLuV6F6K/@nanopsycho>
	<20231009081532.07e902d4@kernel.org>
	<ZSQeNxmoual7ewcl@nanopsycho>
	<20231009093129.377167bb@kernel.org>
	<ZST9yFTeeTuYD3RV@nanopsycho>
	<20231010075231.322ced83@kernel.org>
	<ZSV0NOackGvWn7t/@nanopsycho>
	<20231010111605.2d520efc@kernel.org>
	<ZSakg8W+SBgahXtW@nanopsycho>
	<20231011172025.5f4bebcb@kernel.org>
	<ZSeOq+I+Z12E/oRC@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Oct 2023 08:14:03 +0200 Jiri Pirko wrote:
> >The current code is a problem in itself. You added another xarray,
> >with some mark, callbacks and unclear locking semantics. All of it
> >completely undocumented.  
> 
> Okay, I will add the documentation. But I thouth it is clear. The parent
> instance lock needs to be taken out of child lock. The problem this
> patch tries to fix is when the rntl comes into the picture in one flow,
> see the patch description.
> 
> >The RCU lock on top is just fixing one obvious bug I pointed out to you.  
> 
> Not sure what obvious bug you mean. If you mean the parent-child
> lifetime change, I don't know how that would help here. I don't see how.
> 
> Plus it has performance implications. When user removes SF port under
> instance lock, the SF itself is removed asynchonously out of the lock.
> You suggest to remove it synchronously holding the instance lock,
> correct? 

The SF is deleted by calling ->port_del() on the PF instance, correct?

> SF removal does not need that lock. Removing thousands of SFs
> would take much longer as currently, they are removed in parallel.
> You would serialize the removals for no good reason.

First of all IDK what the removal rate you're targeting is, and what
is achievable under PF's lock. Handwaving "we need parallelism" without
data is not a serious argument.

> >Maybe this is completely unfair but I feel like devlink locking has
> >been haphazard and semi-broken since the inception. I had to step in   
> 
> Well, it got broken over time. I appreciate you helped to fix it.
> 
> >to fix it. And now a year later we're back to weird locking and random
> >dependencies. The only reason it was merged is because I was on PTO.  
> 
> Not sure what you mean by that. Locking is quite clear. Why weird?
> What's weird exactly? What do you mean by "random dependencies"?
> 
> I have to say I feel we got a bit lost in the conversation.

You have a rel object, which is refcounted, xarray with a lock, and 
an async work for notifications.

All you need is a list, and a requirement that the PF can't disappear
before SF (which your version also has, BTW).

