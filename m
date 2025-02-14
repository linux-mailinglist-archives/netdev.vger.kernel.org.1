Return-Path: <netdev+bounces-166558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CBBA3673C
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 22:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08FCF3AE202
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229F91C8613;
	Fri, 14 Feb 2025 21:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9ty/Tj+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCE81C8615
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739567309; cv=none; b=DD0K3bhSjT7YypCmXjgjNj8J9FmSdPo/nGgo/B9J1+epY22wgH3RZsiJgvordS3f/ktYJUOjlfASmZN7hT8q/7qSW97BM4Yz2FWbSveuLxR7kMjCAiTO9h1f/4mI4GMbDKRen05+L4YLVoB8WS+dYWp0QPJnNKTGXoz4B9V7mR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739567309; c=relaxed/simple;
	bh=BIc16QcJoFKRLJ44cWNk4eqF0tI79aX1Am0HIvzXcKo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=goJ7jZQpVziDLzmP/0hJLqr0VlA7vz4+BGHNRZHejKF/eUhNP4lJfBA/SzTP3fK25zFFrpCsUBjA5VJWxexAEuiryq1E2HydEpZgzvKSizJf4p+hELtrEyrD1YLQncBzv27g4CmGprnJ/aHp8Pgk2ywBR7Zglh2Nq8Kxe+h9xYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9ty/Tj+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8FCC4CED1;
	Fri, 14 Feb 2025 21:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739567308;
	bh=BIc16QcJoFKRLJ44cWNk4eqF0tI79aX1Am0HIvzXcKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L9ty/Tj+HWW+zzz89xH62wCnUqj8YIeDWL9klxTMXPpMBMUGnJSj5IOOv4bFGF7as
	 4wPefktOlzTlP3uRLFVkS/uGFETLED716dFezP2xEcz3etF38nC2lcvxvdS2Uqyxim
	 GeqKCHwvIQZCFecv8c95JqQ91pXgLqHDagvHg9bz9aLrf+j4K4OFKZJ3bnO8lkFwBk
	 xgA8jg3XgekewUc5QwsXUSzNRa2x/N1fTQ8X5uTPoddumWYcDZ397juO1pDzek0W1y
	 ABpv3vbT6BAgQx1B/IUabcXT+PYnRZNPER88JEG3WAeJLzWteUwC2NTdhfr4ysxmTy
	 ApOoqmR/HGtKg==
Date: Fri, 14 Feb 2025 13:08:27 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
 <kuni1840@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <ychemla@nvidia.com>
Subject: Re: [PATCH v4 net 2/3] net: Fix dev_net(dev) race in
 unregister_netdevice_notifier_dev_net().
Message-ID: <20250214130827.35d59981@kernel.org>
In-Reply-To: <20250214002557.27185-1-kuniyu@amazon.com>
References: <20250213083217.77e18e10@kernel.org>
	<20250214002557.27185-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 14 Feb 2025 09:25:57 +0900 Kuniyuki Iwashima wrote:
> > Is there a plan to clean this up in net-next? Or perhaps after Eric's
> > dev_net() work? Otherwise I'm tempted to suggest to use a loop, maybe:  
> 
> For sure, I will post a followup patch to net-next.

Sorry, I meant that as distinct alternatives :)
The loop we can do already in net.
The question about net-next was more in case you're planning to rewrite
this entire function anyway, in which case the contents which land in
net are not as important.

Does that make sense?

