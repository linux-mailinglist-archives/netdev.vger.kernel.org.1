Return-Path: <netdev+bounces-146839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 562CD9D632C
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 18:32:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6669B26D2E
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 17:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2280A2E40B;
	Fri, 22 Nov 2024 17:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pg4fQiV3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E624A1DF973
	for <netdev@vger.kernel.org>; Fri, 22 Nov 2024 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732296683; cv=none; b=h6Hx6eUVU8xrYSxbKayjoZ/Ofzr9FeP1DrvDdG3zH8TlPchbjvMox1XS5cixpH51yny0y8APFR7cS3nz6Xjr3ztvwKC/TBLTW60VpIdHcx+jpIrVQ0FuI3RvsQTkcEZLlc3cVhs0HvKoSAmx7k1WQNSZb4DBD0khf9LLNJaur4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732296683; c=relaxed/simple;
	bh=knPrv+6mTfUrMZ6JUca7OgQR+yXrwZDEhKrYS4lZZ5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SyVk70FHwQwXtABQoTRmkM6Mfg0WA7NqJ36dOTJ4V98jSEIYx8HUoNVcNc5XeAB6adj8pj3hY9rb2cQLin33hYyTEpvzTM3yh+f3teGAp12jJIbwgVgSCP3Vm+qitSV8hezPNOJ2rwiLs1trp/yfrwhlGHJ6kuBdnLyTocGzb+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pg4fQiV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CD6FC4CECE;
	Fri, 22 Nov 2024 17:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732296682;
	bh=knPrv+6mTfUrMZ6JUca7OgQR+yXrwZDEhKrYS4lZZ5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pg4fQiV3DxMnkDl3bWdEPdgVEsov7C3fXY6c+sLqmPq9q9d3EuDvpQ3b7Zvhm5q94
	 mUToadbgCYqh5GM+OS3hP1bJXtGgwjSpfparLf5X1m2HHeU79CLktwJZMBCxS2FeeA
	 99Ic76j+DG23Ilk8rgaaCIviK/iipO9DP/N1SsgJzX1jxQTlS/sA/rCgOlFOhavHE/
	 +pHCG6hyiMNzt7itlg0Lyz+1wTW5YD3XV7Oz19hlFGn7IGX0DOOUl4RHRpoABZo5at
	 gbfRAvFnJu65iDWYF7pCwFEWRLemUYNWlBEeRAnRw1mVb0Ka4XukB2xgM3u42yGrB8
	 1uRWlJ1+cUiLw==
Date: Fri, 22 Nov 2024 09:31:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Subject: Re: [PATCH net] net_sched: sch_fq: don't follow the fast path if Tx
 is behind now
Message-ID: <20241122093120.61806727@kernel.org>
In-Reply-To: <CANn89iKBUJ6p56+3TRNB5JAn0bmuRPDWLeOwGmvLh5yjwnDasA@mail.gmail.com>
References: <20241122162108.2697803-1-kuba@kernel.org>
	<CANn89iKBUJ6p56+3TRNB5JAn0bmuRPDWLeOwGmvLh5yjwnDasA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Nov 2024 17:44:33 +0100 Eric Dumazet wrote:
> Interesting... I guess we could also call fq_check_throttled() to
> refresh a better view of the qdisc state ?
> 
> But perhaps your patch is simpler. I guess it could be reduced to
> 
> if (q->time_next_delayed_flow <= now + q->offload_horizon)
>       return false;
> 
> (Note the + q->offload_horizon)
> 
> I do not think testing q->throttled_flows is strictly needed :
> If 0, then q->time_next_delayed_flow is set to ~0ULL.

Makes sense, I'll respin using your check tomorrow.
-- 
pw-bot: cr

