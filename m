Return-Path: <netdev+bounces-115048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC86E944F76
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 17:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7A302881CE
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 15:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA721B011B;
	Thu,  1 Aug 2024 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MsPw0tTr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C4F42049
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722526766; cv=none; b=CNcbMmE9wb4x3rAv5uMdwPRdt9caHrRObSj3koB8k64bU8GHsS/9TJJZq29NLM6oemnjOt5I/7QyqPsfHcA1UW+BTXw5ReTRXAzAGXjObAPf7RTeSf1fcSjoOyle4EYT7v5HQylG4uOYqQxGxlfITGpH7Lc2lGZI8/B/SlT1/i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722526766; c=relaxed/simple;
	bh=L/wpsnAwKN7PTZCTYmONMORUMXaXj4L2ZsaC36+CGhg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmbXDTvPmmLs/R74Ng9gIVOeQXe7NQ1FBXbceWbRrwmHOQDUamR4a7lNH1jE0T9DhQV/K9NagM1UUqdz4Lk+hZnZkp/WT1ZI6EISKkt7SR2NaXJGRy8b9pycyTASbFbL+zBHoj3XBt16B1agc+JxwF2rC4JhjMMRxcWEnEeibvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MsPw0tTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B4EC32786;
	Thu,  1 Aug 2024 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722526766;
	bh=L/wpsnAwKN7PTZCTYmONMORUMXaXj4L2ZsaC36+CGhg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MsPw0tTraUsUSufggt37ouEGGaGrGcsehyymKzhU267qGg59StYpXSeCM4W6oQ6GV
	 s/rOIaIjrd6B4eFn6KJ4S8J4OqJhhx2tTN94jGgszwHeIcVLF25gyxP5BDV2NvCvC0
	 CIyEYAzWI+PWhmkYZHImxe5Ob2c7DBQMafiWA9+iqoGNACUJs5C9QPeHgK3TGxNeux
	 mKu6MhJxhZGgLJXjTz83wheE2UQ232IMahpF5nq8rmKuH8SIx3C4H0uCGzEzJkh3NW
	 ooyZUZ8NXXoVYPAe9SLRAh9mLIm/LbZaTne2MptzT8CAiXt9JmsDTqRVdFLIaOQn2/
	 4GR3qsGzsAuLg==
Date: Thu, 1 Aug 2024 08:39:24 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH v3 04/12] net-shapers: implement NL set and delete
 operations
Message-ID: <20240801083924.708c00be@kernel.org>
In-Reply-To: <144865d1-d1ea-48b7-b4d6-18c4d30603a8@redhat.com>
References: <cover.1722357745.git.pabeni@redhat.com>
	<e79b8d955a854772b11b84997c4627794ad160ee.1722357745.git.pabeni@redhat.com>
	<20240801080012.3bf4a71c@kernel.org>
	<144865d1-d1ea-48b7-b4d6-18c4d30603a8@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 1 Aug 2024 17:25:50 +0200 Paolo Abeni wrote:
> When deleting a queue-level shaper, the orchestrator is "returning" the 
> ownership of the queue from the container to the host. If the container 
> wants to move the queue around e.g. from:
> 
> q1 ----- \
> q2 - \SP1/ RR1
> q3 - /        \
>      q4 - \ RR2 -> RR(root)
>      q5 - /    /
>      q6 - \ RR3
>      q7 - /
> 
> to:
> 
> q1 ----- \
> q2 ----- RR1
> q3 ---- /   \
>      q4 - \ RR2 -> RR(root)
>      q5 - /    /
>      q6 - \ RR3
>      q7 - /
> 
> It can do it with a group() operation:
> 
> group(inputs:[q2,q3],output:[RR1])

Isn't that a bit odd? The container was not supposed to know / care
about RR1's existence. We achieve this with group() by implicitly
inheriting the egress node if all grouped entities shared one.

Delete IMO should act here like a "ungroup" operation, meaning that:
 1) we're deleting SP1, not q1, q2
 2) inputs go "downstream" instead getting ejected into global level

Also, in the first example from the cover letter we "set" a shaper on
the queue, it feels a little ambiguous whether "delete queue" is
purely clearing such per-queue shaping, or also has implications 
for the hierarchy.

Coincidentally, others may disagree, but I'd point to tests in patch 
8 for examples of how the thing works, instead the cover letter samples.

> That will implicitly also delete SP1.

