Return-Path: <netdev+bounces-206292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7945B02814
	for <lists+netdev@lfdr.de>; Sat, 12 Jul 2025 02:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8CE77BE4D5
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 23:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B95322D4FF;
	Fri, 11 Jul 2025 23:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FDGJe12W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W7kso2If"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C276A22A801;
	Fri, 11 Jul 2025 23:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278339; cv=none; b=sEJV49lXX7QU0v7UORBwI7QrxA8VmjW6wgnCXHa0NDZZlua34n/n4MX40ubNrxqvbwIhhhJnXINGXUUTiQR5w5MdRwGhqCgJjJKCAzwOZPLDIUZRC0exosz7i9CFP/KkUSB/jlq7RkP9ozDcFP73ws4yFZzOM7JJChYCGhe5DT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278339; c=relaxed/simple;
	bh=/5hS7jwAB0F42rvVLLlXskkWnYfakJs6Bk5EEuedoho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epzzDdgPuqPVp/fxQ7A+QzNfL0iWMh4J0xEMF0GN1offOqs4Qul5QiJaypMjC+F2NODcaD9oEKUIOr0aJBfm28IqZchorSOhmKMyJQ2f37b3sjpARf2eykrMJ2/bQrwUG8RSNmhtLHpuGzChfZNVK/VKB3aN75T90PTu3LWudH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FDGJe12W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W7kso2If; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Jul 2025 01:58:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752278335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=imT5HqEkRSNprP7W6NEIrAdL8HwowAu3v+5Es6PMFwM=;
	b=FDGJe12WV9YV6S3fOxMQ+q4kz9C+xvc9/5227EAJ793/L4hXgNzPtri4QIAKKLFHbVO8RT
	uW6B9B05weML4Vz4LU0D3IjvnvYmFpD7BweyRpEGBbQ9ASPi38tPIZusebyM26b1dUzau4
	brQSyBwmjYDNOqfrE7eYeeRvMSFs0YxpAdHh7rppoY71nJXYqDfhFObtnbtqP+L1kY93jf
	9b4OokjKzeM1KDIhVuehERYguwk4E9xu5Psh1sE/ZOuOXxSnvKRyDADdOWnov36ibGbqLX
	xzn5096FQq7D3q30RjJ35gwY0pWI/19ITsKGatekP02CfRQeVtTXKYlkG2sDow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752278335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=imT5HqEkRSNprP7W6NEIrAdL8HwowAu3v+5Es6PMFwM=;
	b=W7kso2IfTKsUrGr4a0eZJAEAENj+pddcsr3DyvSVsWDnogvCKgOeudCbk4HPfVsHOG/80i
	4W9bLePA2Sc7K1AA==
From: Nam Cao <namcao@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Valentin Schneider <vschneid@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@gmail.com>,
	davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, pabeni@redhat.com,
	dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [GIT PULL] Networking for v6.16-rc6 (follow up)
Message-ID: <20250711235854.c7rIj1Ix@linutronix.de>
References: <20250711114642.2664f28a@kernel.org>
 <CAHk-=wjb_8B85uKhr1xuQSei_85u=UzejphRGk2QFiByP+8Brw@mail.gmail.com>
 <CAHk-=wiwVkGyDngsNR1Hv5ZUqvmc-x0NUD9aRTOcK3=8fTUO=Q@mail.gmail.com>
 <CAHk-=whMyX44=Ga_nK-XUffhFH47cgVd2M_Buhi_b+Lz1jV5oQ@mail.gmail.com>
 <CAHk-=whxjOfjufO8hS27NGnRhfkZfXWTXp1ki=xZz3VPWikMgQ@mail.gmail.com>
 <20250711125349.0ccc4ac0@kernel.org>
 <CAHk-=wjp9vnw46tJ_7r-+Q73EWABHsO0EBvBM2ww8ibK9XfSZg@mail.gmail.com>
 <CAHk-=wjv_uCzWGFoYZVg0_A--jOBSPMWCvdpFo0rW2NnZ=QyLQ@mail.gmail.com>
 <CAHk-=wi8+Ecn9VJH8WYPb7BR4ECYRZGKiiWdhcCjTKZbNkbTkQ@mail.gmail.com>
 <CAHk-=wiMJWwgJ4HYsLzJ4_OkhzJ75ah0HrfBBk+W-RGjk4-h2g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiMJWwgJ4HYsLzJ4_OkhzJ75ah0HrfBBk+W-RGjk4-h2g@mail.gmail.com>

On Fri, Jul 11, 2025 at 03:19:00PM -0700, Linus Torvalds wrote:
> On Fri, 11 Jul 2025 at 14:46, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I've only tested the previous commit being good twice now, but I'll go
> > back to the head of tree and try a revert to verify that this is
> > really it. Because maybe it's the now Nth time I found something that
> > hides the problem, not the real issue.
> >
> > Fingers crossed that this very timing-dependent odd problem really did
> > bisect right finally, after many false starts.
> 
> Ok, verified. Finally.
> 
> I've rebooted this machine five times now with the revert in place,
> and now that I know to recognize all the subtler signs of breakage,
> I'm pretty sure I finally got the right culprit.
> 
> Sometimes the breakage is literally just something like "it takes an
> extra ten or fifteen seconds to start up some app" and then everything
> ends up working, which is why it was so easy to overlook, and why my
> other bisection attempts were such abject failures.
> 
> But that last bisection when I was more careful and knew what to look
> for ended up laser-guided to that thing.
> 
> And apologies to the drm and netlink people who I initially blamed
> just because there were unrelated bugs that just got merged in the
> timeframe when I started noticing oddities. You may have had your own
> bugs, but you were blameless on this issue that I basically spent the
> last day on (I'd say "wasted" the last day on, but right now I feel
> good about finding it, so I guess it wasn't wasted time after all).
> 
> Anyway, I think reverting that commit 8c44dac8add7 ("eventpoll: Fix
> priority inversion problem") is the right thing for 6.16, and
> hopefully Nam Cao & co can figure out what went wrong and we'll
> revisit this in the future.

Yes, please revert it. I had another person reported to me earlier today
about a breakage. We also think that reverting this commit for 6.16 is the
right thing.

Sorry for causing trouble. Strangely my laptop has been running with this
commit for ~6 weeks now without any trouble. Maybe I shouldn't have touched
this lockless business in the first place.

Best regards,
Nam

