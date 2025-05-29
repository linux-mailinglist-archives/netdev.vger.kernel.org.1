Return-Path: <netdev+bounces-194091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8198AC74CC
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 02:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F522188BAC4
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 00:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468811362;
	Thu, 29 May 2025 00:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtBcq3Uf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212C6647
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 00:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477085; cv=none; b=aXeb6GGOXUyx2qvbgLDtUrqVHNl/JZmp1m3S9xoduxiQ4Owqz1/+vjMu5MYHL+uYdd/VxcWCOiRF75WbRAtpAsdB5SfK62Shg/+7vGpgGr/N0o07IwZiC7Yh6Pm21XrpgAhzDxjFhEyIRnBUTifA7uPg9e0TdGa6i/TTK1Cetws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477085; c=relaxed/simple;
	bh=s+opDjxwmv4wxDImpo5hlVGcKr2jceGq14J6mRgLkwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S14sMoNpcIDKVvFCsuCOxlTx+Pz/bF/MiTah9zbxYZThKLbOmRGexHO5uQBfjp4GH/VGyorpRcyvIu696QiGSwDZ4+1YmSKREH/Z7p5lbKG//7CbSavbdLknl8wPMr110P4XwBM6492is6EsSJgQvvAxtbfvkvXUldz4n03k/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtBcq3Uf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DDD0C4CEE3;
	Thu, 29 May 2025 00:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748477083;
	bh=s+opDjxwmv4wxDImpo5hlVGcKr2jceGq14J6mRgLkwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gtBcq3Uf6xE18ycwntj73OG+KYl0yGYkigOjLl4L0MeJljKlDGTWht40pgIxda30Q
	 BRpohIc3SAxHcfeK71vX+KL7iKQqef7Kr2zhaPw0tpNcmlc/Ow+SN/cY3T25Ku82uN
	 h0khjYXcwcTInnxDzJOk80QxI05lEBm5BCHrkbOFuneTHG4y9VCLNWsHBlYsZUTHyR
	 0p2VfKdNHFhhkPBqoIG7mMztwsU6vAmZTkXIxWJTjX7lBMDUGt/87F3a+ctMFUSrm0
	 go/5jIStmcqSHislFourfnUmBbvxdxjuWMyZC2EatOohm1XNtQQk0o+p3IetdWxqSm
	 bl2lb2eYN68LQ==
Date: Wed, 28 May 2025 17:04:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Wei Wang <weiwan@google.com>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 almasrymina@google.com, willemb@google.com, jdamato@fastly.com,
 mkarsten@uwaterloo.ca, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: stop napi kthreads when THREADED napi
 is disabled
Message-ID: <20250528170442.160f6f99@kernel.org>
In-Reply-To: <CAAywjhScfevLxYho-wxU6WNF+0VpwngW8MzZjpx1HQ83NTXUDw@mail.gmail.com>
References: <20250519224325.3117279-1-skhawaja@google.com>
	<20250520190941.56523ded@kernel.org>
	<CAEA6p_BxSA16cMXr5NaJCLZ+KWD2YVVwEdvVX_QG=_gyvNCP=w@mail.gmail.com>
	<CAAywjhR4znr9fsAdBKmYAwcyP8JgoesLkuS8p9D0goJBFFePWg@mail.gmail.com>
	<CAAywjhTjdgjz=oD0NUtp-k7Lccek-4e9wCJfMG-p0AGpDHwJiQ@mail.gmail.com>
	<20250521152147.077f1cb0@kernel.org>
	<CAAywjhScfevLxYho-wxU6WNF+0VpwngW8MzZjpx1HQ83NTXUDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 May 2025 15:50:19 -0700 Samiullah Khawaja wrote:
> > Just to be clear - the stopping of the thread has to be after the
> > proposed loop, so kthread_should_stop() does not come into play.  
> Wait, the thread will unset STATE_THREADED if kthread_should_stop is
> true. right? Otherwise how would thread know that it has to unset the
> bit and stop?
> 
> As I understand, we should be doing something like following:
> 
> while (true) {
>    state = READ_ONCE()
>    can_stop = false;
> 
>    if (kthread_should_stop) {
>        if (SCHED_THREADED || !SCHED) {
>            state &= !THREADED
>        } else {
>            msleep(1);
>            continue;
>        }
> 
>         if (try_cmpxchg) {
>             can_stop = true;
>             if (!SCHED_THREADED)
>                 break;
>         }
>    }
> 
>    if (SCHED_THREADED)
>        poll()
> 
>    if (can_stop))
>        break;
> }

So moving the stopping logic into the polling thread? I don't think this
helps anything. 

Once we unset the THREADED bit we should wait for the thread to clear
SCHED_THREADED (before trying to stop it). SCHED_THREADED going away
is our signal that it's safe to reap the thread.

If you're afraid that the thread will not terminate (because packets
continue to flow in) - we probably want something like:

diff --git a/net/core/dev.c b/net/core/dev.c
index 2b514d95c528..33d4b726395b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -7548,6 +7548,13 @@ static void napi_threaded_poll_loop(struct napi_struct *napi)
                if (!repoll)
                        break;
 
+               /* Thread is going away, give up the ownership */
+               if (!likely(READ_ONCE(napi->state) & NAPIF_STATE_THREADED)) {
+                       clear_bit(NAPI_STATE_SCHED_THREADED, &napi->state);
+                       __napi_schedule(napi);
+                       break;
+               }
+
                rcu_softirq_qs_periodic(last_qs);
                cond_resched();
        }

