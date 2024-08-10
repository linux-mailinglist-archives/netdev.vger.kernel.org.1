Return-Path: <netdev+bounces-117351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1637994DAB0
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 06:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D8E41F2209E
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 04:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1798912F5A5;
	Sat, 10 Aug 2024 04:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1l+qvPR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E733B107A0
	for <netdev@vger.kernel.org>; Sat, 10 Aug 2024 04:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723263911; cv=none; b=nsxDwYSYiaFj8yENvZvaBBcVVaCYtmQ86uiU/zmlk90RPUJREI4iWqufhm+w5R2OMhYY0aNK3B83II1ZjDl3STBDTYQCF/EqDQST6OHE7VddqRpTiMqvMkJ3shuKk2Bi9LEVkyD63GOr26zgI7Z9+2ymReV37yZNcOqi3zyRtSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723263911; c=relaxed/simple;
	bh=pEaGJ3HlTNRndI6uF+s+asZgRxPTXyDD6i40zjqV+9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYWRdfU8NSFPzorlh380TE5CP4lRvIeiXNrjs8JRguqaNJC26dN7eAFuSoa7K+flYFCiz7FsxsO8bRAhkhm2LzP15g6vgBc7hI2Xbgeot+xzTnsnAK3gjT8xmBhBMUcaG3oPA2vrBdc0eIr8q8JkNqvzA32FLG0IJnrAC3Uqa0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1l+qvPR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FF79C32781;
	Sat, 10 Aug 2024 04:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723263909;
	bh=pEaGJ3HlTNRndI6uF+s+asZgRxPTXyDD6i40zjqV+9Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e1l+qvPRCeSJauh5Nat2lP38GdCAzuUCI7eaAc3fjfTQt5heLTXamELA7ErhAMsfb
	 ykFS9NUhsGpCyL/OB1/0TXQdn3C8wemNU4l59oRMQX2afoU0Bwiw5PK0wn/a2BM3BJ
	 vkqnpTXILc7QgONjZ8sx5vt+Ciov+ovJAHUkMH6kfDdhj1E2h7LJGZqt5LMw4XiEBG
	 UFA8tg/VBrzg0LrHDsKEHEfikTTRQixGmTpJ8/2nFVXW0DaFUiNz8CMdu1UbF3j1t0
	 k510KVrG6YYXHZl92/2vrttbkD695hyObWqM4DgOFhibMTi0Km4x3BWJZ+zwVPqZgq
	 TAOW8qqLAX/Hw==
Date: Fri, 9 Aug 2024 21:25:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: potential patchwork accuracy problems..
Message-ID: <20240809212508.02617159@kernel.org>
In-Reply-To: <20240809091738.GG3075665@kernel.org>
References: <20240808085415.427b26d7@kernel.org>
	<20240809091738.GG3075665@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 9 Aug 2024 10:17:38 +0100 Simon Horman wrote:
> On Thu, Aug 08, 2024 at 08:54:15AM -0700, Jakub Kicinski wrote:
> > Minor heads up that updating state in patchwork is agony, lately.
> > I think people are building more and more CI systems, and patchwork
> > can't handle the write load. So I get timeouts trying to update patch
> > state 2 of of 3 times. NIPA is struggling, too, but at least it has
> > auto-retry built in..
> > 
> > So long story short if something seems out of whack in patchwork,
> > sorry, I'm doing my best :(  
> 
> Do you know if someone who can address the problem is aware of it?

I have emailed, and offered help. Didn't see a reply.

> My anecdotal experiences is that access has been degraded, on and off,
> for a few months.

Yes, in the past Konstantin was able to chase down the bad actors, 
I think, as well as do some backend magic to improve the DB performance.
But it keeps happening, and patchwork has no built in protection.
(I need to find some weekend time to parse our own logs and graph 
the number of requests we send to make triple sure NIPA is behaving.)

