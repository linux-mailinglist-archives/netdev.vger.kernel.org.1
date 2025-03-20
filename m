Return-Path: <netdev+bounces-176586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4D4A6AEFB
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 21:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD83460F39
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 20:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E012288C0;
	Thu, 20 Mar 2025 20:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+6bwsxk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638821CA00
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 20:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742501430; cv=none; b=KNGnLUglUngvhMKB1C6YfMKRjAU8RFQW9ZpAqLf1/SdTdYyPwVDjikFQJIUk8sdanjq0D8y9h92cJm6aCCvdWHXnfvyUp20MPoEcQWgpodMDe/7s0KoZaJSqJYnlmM7KTMswGJktncPA0nqfmiR1EoYynzFNov+IplYhtpkU8x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742501430; c=relaxed/simple;
	bh=y/IXyoxhP4uT8m79Qjj4i5WJKkNwCj06J/1Q53cG5Fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8q9EYMqgdLbIuDJfBCQqBbsBRTzVxVjhQ4H29TGPXpAXasce4uT1ky1dI61kjnitZ/6qn7vzV8IlMeTLvNXssgZV3UbGxGN+h9w8k5DOUZJuAU17GkzuI8Mq8Tz3DQ/2E4mvt0VidpJBvoF5eqTBalmOEOBmnic0tEI860ISiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+6bwsxk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD7AC4CEDD;
	Thu, 20 Mar 2025 20:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742501429;
	bh=y/IXyoxhP4uT8m79Qjj4i5WJKkNwCj06J/1Q53cG5Fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+6bwsxkgpQ75DoDz8F0CzF8yP7gOX25w0hPpdZDcXq3FTRTZZi5uaI64O4o9N4G6
	 3SmLpGzqSn0nuboR2Y2dyf9vuCZMcvpAKqj7Mpsy0CWN8XuyF+7g4OgnPqPqD+lYZ1
	 9v71VcNWdJpDcCqnKE0bWUR/VURHgz0oQZw3Bj9bQTOVIfXiJsBsjSgG4B8UIFBzq5
	 HQ6AQDzTHcJ/K2WrL3ljEUPKHgGdLQBWxkClXuyl5iGH9v+XTakNr1Lv3+5dhLcwVH
	 qZeZ0oLq7XRyH61MtWSsw1zqYwfb0o/NWo8i6oDiLvmUhhq9OkccbzU4Dii/4L7kFk
	 6BHOEAV51CFqA==
Date: Thu, 20 Mar 2025 20:10:25 +0000
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 2/2] tcp/dccp: remove icsk->icsk_ack.timeout
Message-ID: <20250320201025.GL892515@horms.kernel.org>
References: <20250318154359.778438-1-edumazet@google.com>
 <20250318154359.778438-3-edumazet@google.com>
 <20250320183858.GJ892515@horms.kernel.org>
 <CANn89iLD2jEm5wVhCVEmr=dMp8mr6PVTrzZDmH30qL=GfBmVHA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iLD2jEm5wVhCVEmr=dMp8mr6PVTrzZDmH30qL=GfBmVHA@mail.gmail.com>

On Thu, Mar 20, 2025 at 08:00:29PM +0100, Eric Dumazet wrote:
> On Thu, Mar 20, 2025 at 7:39 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Tue, Mar 18, 2025 at 03:43:59PM +0000, Eric Dumazet wrote:
> > > icsk->icsk_ack.timeout can be replaced by icsk->csk_delack_timer.expires
> > >
> > > This saves 8 bytes in TCP/DCCP sockets and helps for better cache locality.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > ---
> > > v2: rebase after "tcp: cache RTAX_QUICKACK metric in a hot cache line"
> >
> > Hi Eric,
> >
> > I hate to be a bore, but patch 2/2 does seem to apply to net-next.
> 
> Hmm, what is the message you have ?
> 
> It applies fine here.

Ok, there must be something weird going on in my environment.

FTR, I see this:

$ git checkout net-next/main
HEAD is now at 6855b9be9cf7 Merge branch 'mptcp-pm-prep-work-for-new-ops-and-sysctl-knobs'

$ b4 mbox 20250318154359.778438-1-edumazet@google.com
Grabbing thread from lore.kernel.org/all/20250318154359.778438-1-edumazet@google.com/t.mbox.gz
5 messages in the thread
Saved ./20250318154359.778438-1-edumazet@google.com.mbx

$ git am ./20250318154359.778438-1-edumazet@google.com.mbx
Applying: tcp/dccp: remove icsk->icsk_ack.timeout
error: corrupt patch at line 31
Patch failed at 0001 tcp/dccp: remove icsk->icsk_ack.timeout
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config advice.mergeConflict false"

