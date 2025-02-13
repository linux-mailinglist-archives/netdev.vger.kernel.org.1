Return-Path: <netdev+bounces-166209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD79A34F83
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 21:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D92C189010E
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 20:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA99C2661A1;
	Thu, 13 Feb 2025 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EViDjZsQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5CA245B08;
	Thu, 13 Feb 2025 20:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479095; cv=none; b=gdt3HvFFInubGR84CETZLyynua0QGL2Eyv0J9fXvVn1VD3tdage8qpBScgPksg32xmMOdvjA6wJ7oQSpDi7SLYVwtb4q01dyyuoJspkMl+fqtNDV4YpyAbkt6raQzWHIj+FdL6glz7Y08FRvlbaT7dteapXJ+v7OM9IP0i5Xh9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479095; c=relaxed/simple;
	bh=vRx3aCxKD64lcDldByrYSeK3x46VtWp7TM7XgTNx4Ik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X20Tj+N7a7PuhpuqpDLO2G9Tf8N3cmANrpaOrgnWyZ5amn7suvQ4llIFOijnuxx6vN5J4YaZUZfKWuIHaOQp6L7yAR4Orn4A/33yIjyzlTVKbubke8MuwdxxnVHhMObuspmnFed2X+g8SEi+KxK6R1tc8KuVUQeVhKuUxPosL6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EViDjZsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBF5C4CEE4;
	Thu, 13 Feb 2025 20:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739479095;
	bh=vRx3aCxKD64lcDldByrYSeK3x46VtWp7TM7XgTNx4Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EViDjZsQAtsBOdNMgWGCJ4XuI3GPwNvCUFM5TU7oaJAgR2UKLFcap62XsOTY9KOzo
	 w6CyCch3eMERUT9YSBCp0P8IUrSzZvt14s0t4EYKPtg01fwzxsgdBwiVFRzrHEiBjD
	 B+Qv7+3TBBJ2HIVxDg82zKqbY8H+1oO98Q9ExH4vVPb6c0wh6AwlDO+Bb7gypy98Q4
	 TmmFN+w3h+wDWbLYi5P04BJxWVzKL+4m34pBEyQWEFyKHxzFuSjzYJuVfc7dHjmaSi
	 douA1RxXNCWBJYgAxXICXwTWO/PFO8LCof93zOg61lgGg8MwFwJiAhFsspRDvYwB2x
	 QwcF/ImUbtcaw==
Date: Thu, 13 Feb 2025 21:38:12 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Hayes Wang <hayeswang@realtek.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] net: Assert proper context while calling
 napi_schedule()
Message-ID: <Z65YNFGxh-ORF7hm@pavilion.home>
References: <20250212174329.53793-1-frederic@kernel.org>
 <20250212174329.53793-2-frederic@kernel.org>
 <20250212194820.059dac6f@kernel.org>
 <20250213-translucent-nightingale-of-upgrade-b41f2e@leitao>
 <20250213071426.01490615@kernel.org>
 <20250213-camouflaged-shellfish-of-refinement-79e3df@leitao>
 <20250213110452.5684bc39@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250213110452.5684bc39@kernel.org>

Le Thu, Feb 13, 2025 at 11:04:52AM -0800, Jakub Kicinski a écrit :
> On Thu, 13 Feb 2025 10:14:02 -0800 Breno Leitao wrote:
> > > The problem is a bit nasty, on a closer look. We don't know if netcons
> > > is called in IRQ context or not. How about we add an hrtimer to netdevsim,
> > > schedule it to fire 5usec in the future instead of scheduling NAPI
> > > immediately? We can call napi_schedule() from a timer safely.
> > > 
> > > Unless there's another driver which schedules NAPI from xmit.
> > > Then we'd need to try harder to fix this in netpoll.
> > > veth does use NAPI on xmit but it sets IFF_DISABLE_NETPOLL already.  
> > 
> > Just to make sure I follow the netpoll issue. What would you like to fix
> > in netpoll exactly?
> 
> Nothing in netpoll, the problem is that netdevsim calls napi_schedule
> from the xmit path. That's incompatible with netpoll. We should fix
> netdevsim instead (unless more real drivers need napi-from-xmit to
> work).

Let me clarify, because I don't know much this area. If the problem is that xmit
can't call napi_schedule() by design, then I defer to you. But if the problem is that
napi_schedule() may or may not be called from an interrupt, please note that
local_bh_enable() won't run softirqs from a hardirq and will instead defer to
IRQ tail. So it's fine to do an unconditional pair of local_bh_disable() / local_bh_enable().

Thanks.

