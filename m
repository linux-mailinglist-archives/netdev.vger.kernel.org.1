Return-Path: <netdev+bounces-180967-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 856E4A834F1
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 02:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842B81B63839
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 00:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945B3136E;
	Thu, 10 Apr 2025 00:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lioUr3eF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4AA647
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 00:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744243818; cv=none; b=f7oBChNQAkkoNaH9kE/l97BSFH77ZNsXkogz2jMPQ001gLCCHSqYxzRUX2BbPynGDLScf8xxcNTdorXlevYPIXuPRfaplueUkJ+CGGTK2EQI7xZ5T/mCmeFO0lO/oz8wlVbSaHDey0U4+hjoKit1EGw9SzWfQgxUjU+unLLWLLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744243818; c=relaxed/simple;
	bh=Y/3zIKLJmfQb37DAZ9zeo0RLNEd7pIX4VMmklazrmyg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bFJZ0HW1dSVXzZkTKdQTHBsBLfeQ13kMlMhrFhz+dzXDn6dUICIyWBnJNN+zGUBjWNeRaOYbxVR7fLp0Fltb8W02m+9upQiTQ12nIBFQw4nVnUpQyV0V6IUoZcPde5l/1oa5w/LmbTD5cIfNka67JhDDrXN2uWUAF0qtezftQWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lioUr3eF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D87C4CEE2;
	Thu, 10 Apr 2025 00:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744243817;
	bh=Y/3zIKLJmfQb37DAZ9zeo0RLNEd7pIX4VMmklazrmyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lioUr3eFb9JYpdvMHC4wieYmvIjHLIfBNoInf1ggMlOBeY55P3KvcZcn/XdLUZeGL
	 skmIq6w46UTD0p/PH298MocbGWSJetHtFZ6RLhD9SyunX79WmVRf+IPfNDRZ5sE35s
	 HuGlbS8RvUUdzEN3l/Vgs/QLSSldaJ06LB9DVgUdpQKnirMd6+TCGsM49pdRv9AoWV
	 BhvqhyVfZnA1OMLhZEX3pS3aV/qhpH1tqzS7HQQJPbL18FUB+iR4XdqyNWwAqGGOz8
	 agAI2UKJkVx/o/sLtgDiQwvwOcTmyweGEWZv5/V1KYHlBzQyfEc5cQmQn/jvBLYwKk
	 vnSR1pkdYeZFA==
Date: Wed, 9 Apr 2025 17:10:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?= <toke@redhat.com>, Jamal
 Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] tc: Return an error if filters try to attach
 too many actions
Message-ID: <20250409171016.57d7d4b7@kernel.org>
In-Reply-To: <Z/aj8D1TRQBC7QtU@pop-os.localdomain>
References: <20250409145523.164506-1-toke@redhat.com>
	<Z/aj8D1TRQBC7QtU@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 9 Apr 2025 09:44:32 -0700 Cong Wang wrote:
> > +	if (tb[TCA_ACT_MAX_PRIO + 1]) {
> > +		NL_SET_ERR_MSG_FMT(extack,
> > +				   "Only %d actions supported per filter",
> > +				   TCA_ACT_MAX_PRIO);
> > +		return -EINVAL;  
> 
> I wonder ENOSPC is a better errno than EINVAL here?

I think EINVAL is fine, it's the generic "netlink says no" error code. 
The string error should be clear enough.

