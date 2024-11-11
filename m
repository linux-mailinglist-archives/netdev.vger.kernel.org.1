Return-Path: <netdev+bounces-143811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0A99C447D
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 19:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3094128407C
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FCB71AA793;
	Mon, 11 Nov 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2UxKp1z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6FB1AA790
	for <netdev@vger.kernel.org>; Mon, 11 Nov 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348207; cv=none; b=TP0LSlQYqQPLIS89z6L5JxvKGmLq18bLFDx8PJ/P63WlM71pFpvO8JEVCiGinimFL9KH74hFKYnL+4Mv/ech+4dWD4ZInnm25OhmRZthHusvPP1bnFwA4KWb25HjB8HN9oO7G48Y1cvtIzfUUJySb604pB1PtThDn/9KA7Mon+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348207; c=relaxed/simple;
	bh=nuMisY+O3UfXT1SqBNAzrsgTpg551vJwhtz0eDIBedg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j4Gz/SahaMlyRM6ePlGsMpT93sg2AA6NS8uYbUdKiVRxfa8LyAEQ9E1f31iWJEhPgyk3pPaPimFJW8NOPGrKzDBVTkOd32f/pP4bT7A1mPXpk4pnCB7M98bkv3m2CXxWmKrT3TUm6rIMGkks3Knj+0j7Y1ec3WmDy8bNRTYMXQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2UxKp1z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727BCC4CECF;
	Mon, 11 Nov 2024 18:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731348206;
	bh=nuMisY+O3UfXT1SqBNAzrsgTpg551vJwhtz0eDIBedg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e2UxKp1zVQe6pDOx7y7h/VDj+5auWr/A/C5pa9cuU+N7sYhSQf98znCkr1lmZg2gU
	 V36PA8CbT+fzjXGkjX+uRhZo/7pqHt2SZlxBz2FA8PeXKIJbTaW7Wttrh1JX4AOoEo
	 c6FGw5gac00YMb+0L0JNIH83frQVOFeBfVE+/y1888E8kFuKLVMcyKnMU/BdIaUsUJ
	 6eEttZV2LgvZt99Lfkzvy69YlusBtmtPh326WCROLbu7avyMpkXXrxmkV/5ZhkRH1F
	 pqbUcAAP3HkG+8/OHVeAbCLZsLUo9N9OJYAZOK4bKvYumkB1bHlzP4VhvGbTGo0T1M
	 MtvN0nEmlOvhg==
Date: Mon, 11 Nov 2024 10:03:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Xiao Liang <shaw.leon@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/2] tools/net/ynl: add async notification
 handling
Message-ID: <20241111100325.3b09ccb8@kernel.org>
In-Reply-To: <m2cyj2uj11.fsf@gmail.com>
References: <20241108123816.59521-1-donald.hunter@gmail.com>
	<20241108123816.59521-3-donald.hunter@gmail.com>
	<20241109134011.560db783@kernel.org>
	<m2cyj2uj11.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 11:06:18 +0000 Donald Hunter wrote:
> > On Fri,  8 Nov 2024 12:38:16 +0000 Donald Hunter wrote:  
> >> +    def poll_ntf(self, interval=0.1, duration=None):
> >> +        endtime = time.time() + duration if duration else None  
> >
> > could we default duration to 0 and always check endtime?
> > I think we can assume that time doesn't go back for simplicity  
> 
> I don't follow; what are you suggesting I initialise endtime to when
> duration is 0 ?

I was suggesting:

	def poll_nft([...], duration=0)

	endtime = time.time() + duration

> >> +        while True:
> >> +            try:
> >> +                self.check_ntf()
> >> +                yield self.async_msg_queue.get_nowait()
> >> +            except queue.Empty:
> >> +                try:
> >> +                    time.sleep(interval)  
> >
> > Maybe select or epoll would be better that periodic checks?  
> 
> This was the limit of my python knowledge TBH. I can try using python
> selectors but I suspect periodic checks will still be needed to reliably
> check the endtime.

I thought select is pretty trivial to use in python, basically:

	sock, _, _ = select.select([sock], [], [], timeout=to)
	if sock:
		handle_sock()
	to = endtime - time.time()
	if to <= 0:
		return

