Return-Path: <netdev+bounces-155976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68275A0478C
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 18:06:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DFE818889E0
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 17:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5BFC1F191A;
	Tue,  7 Jan 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLA6IpJ8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15C5219EB
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736269603; cv=none; b=kfxZNqilWF8q/sWm9MRwuwyt/ZuppfaGzrkn8TlJTtO6qwGIWJCGPMAaCgeFij4zpELOSm+mMM5qYsLbp20o79GRN2tulepnz/AAjOaPSNSO2APRnqblz+9krlBdjNbE7wzxUY6k9x4quDnZ0QSBnw2Ra4tssVJgkM+jFVyH3JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736269603; c=relaxed/simple;
	bh=XMFhmjoKPM4LQx39viuWTczk2jRoHQXRYHaGymJbaLU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C27AOwZwMeN5qcf/jif7ZBBQju7mNg0Wqcb+NByJN+Mc2upGVl4Deefqabw/5ZhumoxahbjoF+j4a0A2GEZ6mQYuHWHAzJc/8ByBq64HnqMqffHUMPK4vKYSPMzfGxchIlxwhpGmo5i4lpALCMzLQgmWL4Z1hZPh+G2H2tDQKv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLA6IpJ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C75D5C4CEE3;
	Tue,  7 Jan 2025 17:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736269603;
	bh=XMFhmjoKPM4LQx39viuWTczk2jRoHQXRYHaGymJbaLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PLA6IpJ8917MRgba62oSKDUck6mYEFxt6wYPgsd8NpHYvo6yh1Wm0VF71IpSYclaO
	 RtZy1i75cVKxFqt8+bqb+m/oCFVaQ8yxCXv/5/LFajx1Sotn6qA/jHk3Cb48AySXZ7
	 3MTy4dw2F/W+ksdm0+zJFqJB+HToYDzr7TAxey62ZAH/9P8n/zqa3h+ZTOaj81N5FK
	 1vwegk2toxWHnmar+VfoiCp8ZT6AvtN9uIVL0q41g8e2n0nlOCvo8Yb20uRRfkF81C
	 +bPwoCAQWTE/5y6eMIyKTkqjz0MIJku/fTOAQH6IG26TeuBo65ECAcE7JNWy189BLA
	 qcLxKjGKZ/8XA==
Date: Tue, 7 Jan 2025 09:06:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, gregkh@linuxfoundation.org, mhocko@suse.com,
 stephen@networkplumber.org
Subject: Re: [RFC PATCH net-next 1/4] net-sysfs: remove rtnl_trylock from
 device attributes
Message-ID: <20250107090641.39d70828@kernel.org>
In-Reply-To: <173626740387.3685.11436966751545966054@kwain>
References: <20231018154804.420823-1-atenart@kernel.org>
	<20231018154804.420823-2-atenart@kernel.org>
	<20250102143647.7963cbfd@kernel.org>
	<173626740387.3685.11436966751545966054@kwain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 07 Jan 2025 17:30:03 +0100 Antoine Tenart wrote:
> Quoting Jakub Kicinski (2025-01-02 23:36:47)
> > On Wed, 18 Oct 2023 17:47:43 +0200 Antoine Tenart wrote:  
> > > We have an ABBA deadlock between net device unregistration and sysfs
> > > files being accessed[1][2]. To prevent this from happening all paths
> > > taking the rtnl lock after the sysfs one (actually kn->active refcount)
> > > use rtnl_trylock and return early (using restart_syscall)[3] which can
> > > make syscalls to spin for a long time when there is contention on the
> > > rtnl lock[4].  
> > 
> > I was looking at the sysfs locking, and ended up going down a very
> > similar path. Luckily lore search for sysfs_break_active_protection()
> > surfaced this thread so I can save myself some duplicated work :)  
> 
> Seeing that thread in my inbox again is a nice surprise :-)
> 
> Did you encounter any specific issue that made you look at the sysfs
> locking?

I started working on broadening the use of the netdev->lock 
(per instance lock) to lower the rtnl_lock pressure.
I wanted to make sure I will not end up with the same trylock
hack when it comes to sysfs, so I started digging into the existing
issue...

> > Is there any particular reason why you haven't pursued this solution
> > further? I think it should work.  
> 
> I felt there wasn't much interest and feedback at the time and we had
> things in place to ease the initial issue we were working on (~ slow
> boot time w/ lots of netns and containers). With that and given the
> change was a bit tricky I didn't wanted to be the only one pushing for
> this.
> 
> But I still think this could be beneficial for various use cases so if
> you're interested I'll be happy to revive it. I'll have to refresh my
> mind and run some tests again first. (Any additional testing will be
> appreciated too).

TBH my interest is a bit tangential. We keep adding device configuration
APIs to netdev, and they all end up taking rtnl_lock, even tho vast
majority of the time the configuration is completely local to a single
instance. I'm trying to lay enough the groundwork for using the instance
lock to enable less experienced developers using it. Kuniyuki is also
working on making rtnl_lock per netns. I think it's a good time to fix
the sysfs situation.

> > My version, FWIW:
> > https://github.com/kuba-moo/linux/commit/2724bb7275496a254b001fe06fe20ccc5addc9d2  
> 
> I might take a few of your changes in there, eg. I see you used an
> interruptible lock. With this and the few minors comments this RFC got I
> can prepare a new series.

Perfect.

