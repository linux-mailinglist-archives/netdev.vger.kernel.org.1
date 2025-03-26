Return-Path: <netdev+bounces-177849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D01A720E0
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E45217B57B
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 21:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE0325DB0E;
	Wed, 26 Mar 2025 21:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtoDoW8S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E733C2505D4;
	Wed, 26 Mar 2025 21:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743025074; cv=none; b=O1iM4hRDCs1e5y591gX/OGOUjUVnA31EQNcz3dDY42KcgTQuTpeLlrYXlDNA6h04rvbYFFqccExSqljfXBCh1uBISFAbyZRwMWwVy9QmISC7/rZp667dvs73OiROt6c01J/XxfJHRxYUJ4MEnpUa8yM6ZncgvHzJ91DIDLvLJfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743025074; c=relaxed/simple;
	bh=kiB1SEQU1ValsM/VIomyIFNU0lPLBSpfINQVhbH/huI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XiJrk4HwqMZPRvtPUsNHOTm2jFD0g2TCCQkLG+GyL3TWmvYCu53ngq1qCacaPmQP/IA437kOchlKXynRkaHcq1Poyx8nV/bf8p0rpSQM1FtBbgo9hQVDwfjj9tPECCoIRwVDVpxkWiuChx3d89IsBd1vYAZ4OuOSp2bg+8xCCEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtoDoW8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649C7C4CEE2;
	Wed, 26 Mar 2025 21:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743025073;
	bh=kiB1SEQU1ValsM/VIomyIFNU0lPLBSpfINQVhbH/huI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=qtoDoW8SIdQY67GtPAEVZrlCDCFR1X0JGOF5Aaujj2hxTjBYbqfnMAJPwV8co2lok
	 BAAR3jHc+6IBZhRghrXJKolBGx2r598avcHbVHzjh798WExq2opS3CFu+u1/j2VFgN
	 9nCeAa3wi2X3Z4FaeTvHAnGPVuw/NUqMMnv7OKEA90u+CfLmxScJfNicqBHO2N6JJA
	 AgkiGFlVzBVpPLZ8o08n7/VYSW5ULd37BRogXj7sUYBhE1K01+jH4PF2aW0IpqbhGA
	 VGKdnBdU1nmt+godxDJ2018i/LAw9GS05nHZHdRlHX9tHl7Ma0Cwx0p2eaUQ0RezDj
	 hcx0F3tJe0spQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 02EF7CE0C2A; Wed, 26 Mar 2025 14:37:52 -0700 (PDT)
Date: Wed, 26 Mar 2025 14:37:52 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Waiman Long <llong@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Breno Leitao <leitao@debian.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, aeh@meta.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	jhs@mojatatu.com, kernel-team@meta.com,
	Erik Lundgren <elundgren@meta.com>
Subject: Re: [PATCH] lockdep: Speed up lockdep_unregister_key() with
 expedited RCU synchronization
Message-ID: <b94e7ecf-8b83-47c0-bf69-d4a98da1fd0d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <f1ae824f-f506-49f7-8864-1adc0f7cbee6@redhat.com>
 <Z-MHHFTS3kcfWIlL@boqun-archlinux>
 <1e4c0df6-cb4d-462c-9019-100044ea8016@redhat.com>
 <Z-OPya5HoqbKmMGj@Mac.home>
 <df237702-55c3-466b-b51e-f3fe46ae03ba@redhat.com>
 <37bbf28f-911a-4fea-b531-b43cdee72915@redhat.com>
 <Z-QvvzFORBDESCgP@Mac.home>
 <712657fb-36bc-40d8-9acc-d19f54586c0c@redhat.com>
 <1554a0dd-9485-4f09-8800-f06439d143e0@paulmck-laptop>
 <67e44a9f.050a0220.31c403.3ad3@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e44a9f.050a0220.31c403.3ad3@mx.google.com>

On Wed, Mar 26, 2025 at 11:42:37AM -0700, Boqun Feng wrote:
> On Wed, Mar 26, 2025 at 10:10:28AM -0700, Paul E. McKenney wrote:
> > On Wed, Mar 26, 2025 at 01:02:12PM -0400, Waiman Long wrote:
> [...]
> > > > > > Thinking about it more, doing it in a lockless way is probably a good
> > > > > > idea.
> > > > > > 
> > > > > If we are using hazard pointer for synchronization, should we also take off
> > > > > "_rcu" from the list iteration/insertion/deletion macros to avoid the
> > > > > confusion that RCU is being used?
> > > > > 
> > > > We can, but we probably want to introduce a new set of API with suffix
> > > > "_lockless" or something because they will still need a lockless fashion
> > > > similar to RCU list iteration/insertion/deletion.
> > > 
> > > The lockless part is just the iteration of the list. Insertion and deletion
> > > is protected by lockdep_lock().
> > > 
> > > The current hlist_*_rcu() macros are doing the right things for lockless use
> > > case too. We can either document that RCU is not being used or have some
> > > _lockless helpers that just call the _rcu equivalent.
> > 
> > We used to have _lockless helper, but we got rid of them.  Not necessarily
> > meaning that we should not add them back in, but...  ;-)
> > 
> 
> I will probably go with using *_rcu() first with some comments, if this
> "hazard pointers for hash table" is a good idea in other places, we can
> add *_hazptr() or pick a better name then.

Works for me!

							Thanx, Paul

