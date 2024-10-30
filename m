Return-Path: <netdev+bounces-140203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 103F99B5895
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 01:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BD5E283B91
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A6911187;
	Wed, 30 Oct 2024 00:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyBpilZw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B590BA4A
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 00:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730248007; cv=none; b=XxRfGTVLfJ9YBnZuTKJ8BLepD1NXABdEgbA3B3exxt9z+X0docRDbf+1WADSwv9VD+ytl0jWc8iDrZhkqBx48DV6QamNTyQuHKnIFdXAfMbRCu/9tZKxj6j/HxoIXsj1nXNcaRSDCeOUlizmPSz8Ub5KKaEhqw7Ix8V6ANP//yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730248007; c=relaxed/simple;
	bh=zd88StyOhjzjHySQr8kpJEgsrhxqHnjBmx5BjhTdaQw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NH6c6L1PYd50/7yjK561RuQzHPp25pr71ivBugZ2/9KDWpYNIJptTr9kZoB8qrdoCz9UnaDnUrgwivpJMmWQVh5URkEvuGEuv/CJRHCjAiqiep7/KfDiAK20q8ihJtTAHSUp5izvTwWotusC6eDCThFf27fxQk8ggGqfszBhwB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyBpilZw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3D4C4CECD;
	Wed, 30 Oct 2024 00:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730248006;
	bh=zd88StyOhjzjHySQr8kpJEgsrhxqHnjBmx5BjhTdaQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AyBpilZwajuhqfSjZ+u1HinbpAxGUwsjTK4bHH7n+fZtM78sfu1sJvsIesiR2YDQ+
	 7AHvoGttfw+WlEq31VszoHmdlBau/m7SbnPv0/xlKnFjoLAKo5USdun6IojrSw6JbQ
	 G9z/MMjXip5bbiGEZ9UcdojM8uDfu5N1s0fPxhPf3BWT+Flk4TGGznUJJZ/Y74JoRA
	 KEtL05faxGWmT2Cb209Ob6eMcTWSwmX1RZ/saH1/lm0ZDG3uvH1TFQoHuN3YMRFHp6
	 aH9uK0i9tTBoSKhBDf/bXYp4dCxLxVAvLdaV5r+RhqnR5KNbQDG9koMDPyA6cPOZIJ
	 oPZ+M2YU+AEsg==
Date: Tue, 29 Oct 2024 17:26:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Mohsin Bashir <mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
 <alexanderduyck@fb.com>, <andrew@lunn.ch>, <andrew+netdev@lunn.ch>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <kernel-team@meta.com>, <sanmanpradhan@meta.com>, <sdf@fomichev.me>,
 <vadim.fedorenko@linux.dev>
Subject: Re: [PATCH net-next v2] eth: fbnic: Add support to write TCE TCAM
 entries
Message-ID: <20241029172645.61935736@kernel.org>
In-Reply-To: <b44d50d8-23a2-47d6-99f7-856539e1de69@intel.com>
References: <20241024223135.310733-1-mohsin.bashr@gmail.com>
	<5a640b00-2ab2-472f-b713-1bb97ceac6ca@intel.com>
	<20241028163554.7dddff8b@kernel.org>
	<b44d50d8-23a2-47d6-99f7-856539e1de69@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 16:30:54 +0100 Alexander Lobakin wrote:
> >> Please declare loop iterators right in loop declarations, we're GNU11
> >> for a couple years already.
> >>
> >> 	for (u32 i = 0; ...  
> > 
> > Why?  
> 
> Because we usually declare variables only inside the scopes within which
> they're used, IOW
> 
> 	for (...) {
> 		void *data;
> 
> 		data = ...
> 	}
> 
> is preferred over
> 
> 	void *data;
> 
> 	for (...) {
> 		data = ...
> 	}

Are you actually actively pointing that out in review?
If it was an important rule why is there no automation
to catch cases where variable is only used in a single
basic block but is declared at function scope.

> Here it's the same. `for (int` reduces the scope of the iterator.
> The iter is not used outside the loop.
> 
> > Please avoid giving people subjective stylistic feedback, especially  
> 
> I didn't say "You must do X" anywhere, only proposed some stuff, which
> from my PoV would improve the code.

You said "please do XYZ" which in English is pretty strong.

> And make the style more consistent. "Avoiding giving people subjective
> stylistic feedback" led to that it's not really consistent beyond the
> level of checkpatch's complaints.

checkpatch is obviously bad at its job but I don't think random people
giving subjective stylistic feedback will improve the situation.
We have a handful of reviewers who review maybe 1 in 10 patches.
The reviews are very much appreciated but since those reviewers are not
covering substantial portion of the code merged they should not come up
with guidelines of their own making.

I see plenty of cases where one patch gets nit picked to death on small
stylistic issues and another gets merged even tho its far below average.
Doesn't feel very fair.

> > when none of the maintainers have given such feedback in the past.  
> 
> I don't think my mission as a reviewer is to be a parrot?

Not what I'm saying. Please focus on functional review of the code,
and process / stylistic review only to the extent to which such
rules are widely applied. We even documented this in the netdev "FAQ".

> >> (+ don't use signed when it can't be < 0)  
> > 
> > Again, why. int is the most basic type in C, why is using a fixed side
> > kernel type necessary here?  
> 
> Because the negative part is not used at all here. Why not __u128 or
> double then if it doesn't matter?

We have plenty of bugs because someone decided to use an unsigned type 
and then decided to decrement as long as its >= 0..

