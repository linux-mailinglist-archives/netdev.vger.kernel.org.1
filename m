Return-Path: <netdev+bounces-89234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D58A9BE7
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 15:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D615C1C21ABE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 13:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1DE1635D8;
	Thu, 18 Apr 2024 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4ffGn1f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3B71635D4
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713448695; cv=none; b=beXUxUmp0Lc2dMXKdMc1zb4LVZXs1KjPWW4EX+89B9ukmjxD2AMxOGw0azx3s6kcYly4xsecVGYErP8hdg4RmSD/Upjs1OYrQwC5ija6ENk7MVnIQzo+8oo5diSJe1pqYTu6zD4RucfHHvLqJb5b396SLtHhKBt+xzDAgKOqb9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713448695; c=relaxed/simple;
	bh=0Hlhg7CAxtJeB2ULMeQM+X8/O48EaLJRzhMk+EsLOnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faqiouWdzkus0FEtu2hjIP7OKFGcNNDT1nyld4MxIfvRWsgoa7fhAf4EwF5SuYSHZ25OHt/hTB09Y1nRBWEKLc27gRpGorRsf5RbN+dviHfxSS20tYQN5ULg62npgoL5Maz6NkvAsiBJSZLcQ0qtinIKCYqjIWCoumZ7SGbfdK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4ffGn1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24306C3277B;
	Thu, 18 Apr 2024 13:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713448695;
	bh=0Hlhg7CAxtJeB2ULMeQM+X8/O48EaLJRzhMk+EsLOnw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n4ffGn1faYb6q556tu+LhCaa53Qf9Yms/lZpvk9+vWXwKmDsPU5Jd41qLtG8HNFR5
	 w792o/EcWXemzB+0kEIs4UsKQ6y9rSDk67wAK2xirGgr1mDU0EagveOiJ8o31/RiYY
	 Oc4w3svEGFKCKqYEGHd5Tw3PxNWB/SkMnZX2/J/tsAyy9YAQMKZQzAEQKyfpO2HwmP
	 tW+WWBuKe9eY1qkS6ZVBXVDwy+G3SnADVDjSNUxQ1Nbkhf5rAGRtT2/380cUt1Ee5A
	 Pbm2T2BpeglAhx5LUvZ7rEEF79fLHCEaofdcbo6Uv48cqbTHoMGG0wyyLFxwbWAOJF
	 MLs+umdrfwDsQ==
Date: Thu, 18 Apr 2024 14:58:10 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 04/14] net_sched: sch_choke: implement
 lockless choke_dump()
Message-ID: <20240418135810.GC3975545@kernel.org>
References: <20240418073248.2952954-1-edumazet@google.com>
 <20240418073248.2952954-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418073248.2952954-5-edumazet@google.com>

On Thu, Apr 18, 2024 at 07:32:38AM +0000, Eric Dumazet wrote:
> Instead of relying on RTNL, choke_dump() can use READ_ONCE()
> annotations, paired with WRITE_ONCE() ones in choke_change().
> 
> v2: added a WRITE_ONCE(p->Scell_log, Scell_log)
>     per Simon feedback in V1
>     Removed the READ_ONCE(q->limit) in choke_enqueue()
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Simon Horman <horms@kernel.org>


