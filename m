Return-Path: <netdev+bounces-109619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 918B092924E
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 11:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404E91F2177B
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 09:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006A546556;
	Sat,  6 Jul 2024 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oF3hrZ8H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0BD1F61C;
	Sat,  6 Jul 2024 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720259583; cv=none; b=BkkLkTZfA/G64fFj0ov+oo926y8t5s5mLWPnRK5T5etWveAvPMaKIbEwrWtwCX2HqM/4UCfG8OTmc3X83tjtVOFdipebcElbOKyOyNkgn68Z0WirnC5gwJqvJzOouNLOjW6MHTGRFBf3jKjqCrsTpmMtfLwZ4ifFqxEeoUB2OH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720259583; c=relaxed/simple;
	bh=EoJn9pc2K+C/K7BLu1o4zFCKx6+NE9Wo+WHt6QnrWSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ds6LzIMqjmJdcB7XrT6UsXx4uXx8H8/p4W0mKCmK3pZtfkuEjx7+PC+eAaf/ne931ootbZTyenO13L1JWfmqYaTXXA4BQt4QsT3I/xSm7I5XctDe+/W45AuL6Abc4ejBoWcwomFbg07nXezRqQL2k19p4Xan5cF+jWRQMVhaNZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oF3hrZ8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E28E8C2BD10;
	Sat,  6 Jul 2024 09:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720259583;
	bh=EoJn9pc2K+C/K7BLu1o4zFCKx6+NE9Wo+WHt6QnrWSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oF3hrZ8HY+7i9IMoKfw0AtfX5ocmKNXTt9vQ41mFKyuTSb1Mzp9OYb+rg2lKQdX5v
	 Gkha4nLpVioUDVOrnvBybTy1NEUc6pJVk2OlY8fmhUgRjaDESph8fY61qACYvJ8vRX
	 FsI5/5g6PWk8ZZIocJOUxC6+I6SDnOvn5P4lTb6Ubx8n8fz9ybDZvcAKKF07dy1cVl
	 08d7OLyM5/bySva0iotFvQhNRK8VpQSfhXfh/e4xOClw9xJateezPtgPyf8ZqI/SHb
	 5c3uU9a/V2dDtLv6kayhdVB9/B+2vgU26ZJFj6Ui0IYr1fT/B8n+Ue9iK75xiK4sho
	 HXWXsYewNPg8g==
Date: Sat, 6 Jul 2024 10:52:58 +0100
From: Simon Horman <horms@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH net] ice: Adjust memory overrun in
 ice_sched_add_root_node() and ice_sched_add_node()
Message-ID: <20240706095258.GB1481495@kernel.org>
References: <20240705163620.12429-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705163620.12429-1-amishin@t-argos.ru>

On Fri, Jul 05, 2024 at 07:36:20PM +0300, Aleksandr Mishin wrote:
> In ice_sched_add_root_node() and ice_sched_add_node() there are calls to
> devm_kcalloc() in order to allocate memory for array of pointers to
> 'ice_sched_node' structure. But in this calls there are 'sizeof(*root)'
> instead of 'sizeof(root)' and 'sizeof(*node)' instead of 'sizeof(node)'.
> So memory is allocated for structures instead pointers. This lead to
> significant memory overrun.
> Looks like it was done for "coverity[suspicious_sizeof] workaround".

Hi Aleksandr,

While I agree that your patch is correct, I doesn't look to me like it was
done for "coverity[suspicious_sizeof] workaround", as that annotation was
added after the cited patch where the problem appears to have been
introduced.

> 
> Adjust memory overrun by correcting devm_kcalloc() parameters.

I also think it is misleading to describe this as an overrun.  In my
opinion, an overrun refers to writing over the end of a buffer, or similar
conditions where values are written to memory or read from that is not
intended for that purpose.

But that is not the case here.  Instead it is an over allocation of memory.
Which is, in a sense, the opposite of an overrun. I suggest updating the
description of the problem.

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: dc49c7723676 ("ice: Get MAC/PHY/link info and scheduler topology")

I do agree there is a problem. But I'm not convinced this is fixing a bug -
is the overallocation of memory manifesting, in a real problem, other than
perhaps contributing to memory pressure (I assume in not a very significant
way).

My feeling is that it would be better to target this change to net-next and
drop the Fixes tag.

> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>

...

