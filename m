Return-Path: <netdev+bounces-222175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9E5B535E6
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 16:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 443AD173760
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C56434166B;
	Thu, 11 Sep 2025 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1uwPbDX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E86341668
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601511; cv=none; b=e7b1v+EtYGOM10THTLuGkS2yiWxJVLaBSKdvV9xq2++QQimKkiN7zPQSRuUkLFtbltl229f99m9GCrWr92lBz7vpTsttV/2YGAlYkxYgH1pxHGAI51t5jcdbrxu5v5yExOBHHo5tfWTwX2bZz5687ITw6VxvBJ5FbWavVIW7WFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601511; c=relaxed/simple;
	bh=0aMBCWuZxegRTdBEVWfVFqr2DQag4E3Yte4YgTlkMGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c+jyueGfGJrhN8ZzW9WUmJji7jNgU9pDNQHtxCKIAM09bdQQSs6fkMjjhBH799zrcHLgHAltfjGEWXZrNfboaAJjncki/nnZ8zrMDIGKNgYkerfTNvhUoWRrEo276Y1U12uQtaoXgTHWt7kAuG5PGsDkpwM4NWvOb18OqUgO6YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1uwPbDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A4DC4CEF8;
	Thu, 11 Sep 2025 14:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757601511;
	bh=0aMBCWuZxegRTdBEVWfVFqr2DQag4E3Yte4YgTlkMGQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F1uwPbDX0debbPFztyhfnqUlnR58W02DO73xViz6y9m6cKqfGpFhEz+1hsktMlhUB
	 y6RtIm3lUzF5ru1rN75B6Jx3PftNUVykGktQGmC4xpw4vn5vJQ5+IIq7iSy+uHog2s
	 l2qLSmnFsFrgLa6Sn5nAgR7mchZXBlmR0odCRNKdhkrQHbvOZhu3XzRDvbxm9M+vcV
	 u5U7OzUesl+OC0x1k9+Sb/rz9gBaYXiA45t+8Pms26ZkYjE5XITmCoN5Y+RHEbtJnf
	 yHkNtxzFwXlpsBJTDSXdaDvswFdaTgQh4hXOZlFKFCj2/lsckfGmLXsQ7swnxmGYVk
	 OcR4grBJJ9QWg==
Date: Thu, 11 Sep 2025 07:38:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, willemb@google.com,
 netdev@vger.kernel.org, mkarsten@uwaterloo.ca
Subject: Re: [PATCH net] net: Use NAPI_* in test_bit when stopping napi
 kthread
Message-ID: <20250911073829.5f1bb612@kernel.org>
In-Reply-To: <CAAywjhQZ=4hYaCrO6Uue+cfB4xyyPDMbRTtucEQ4vvxozqxKEQ@mail.gmail.com>
References: <20250910203716.1016546-1-skhawaja@google.com>
	<20250911064021.026ad6f2@kernel.org>
	<CAAywjhTkX3N5CY8+DCEu-DD_0y+Ts0SEkkVphKam1vScMRWdgA@mail.gmail.com>
	<CAAywjhQZ=4hYaCrO6Uue+cfB4xyyPDMbRTtucEQ4vvxozqxKEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Sep 2025 07:31:11 -0700 Samiullah Khawaja wrote:
> > > Is this basically addressing the bug that Martin run into?  
> > Not really. That one was because the busy polling bit remained set
> > during kthread stop. Basically in this function when we unset
> > STATE_THREADED, we also needed to unset STATE_THREADED_BUSY_POLL.
> >
> > @@ -7000,7 +7002,8 @@ static void napi_stop_kthread(struct napi_struct *napi)
> >                  */
> >                 if ((val & NAPIF_STATE_SCHED_THREADED) ||
> >                     !(val & NAPIF_STATE_SCHED)) {
> > -                       new = val & (~NAPIF_STATE_THREADED);
> > +                       new = val & (~(NAPIF_STATE_THREADED |
> > +                                      NAPIF_STATE_THREADED_BUSY_POLL));
> >  
> Just to add to my last email: I did find this test_bit issue while
> working on the fix for that other problem.

I see, makes sense. I was curious whether your previous posting would
work with just this fix. I guess we'll wait until next week 'cause
this fix didn't make it to today's PR in time :(

