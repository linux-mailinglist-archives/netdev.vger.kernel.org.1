Return-Path: <netdev+bounces-203064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C314AF0719
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775D017E3D7
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 23:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C752272E63;
	Tue,  1 Jul 2025 23:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNKT66/A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E538E142E73;
	Tue,  1 Jul 2025 23:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751414172; cv=none; b=DFafYhEy3sR4qpwmzugbajlQE50GlXL0H1Gy8esObLCr1TTwnbnT98MgTSdXdIggRvNALDOxyCxyMkcyrZQcYiItamgb4TpIZecDDPWOdmb4z8ClrjWMDcJVxZ3c2ePHCI8xs8Y+aoSM6REShFsU3zltpr8xzeqHYdPV2013bLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751414172; c=relaxed/simple;
	bh=pYj5+WQU/sktJR79YRM0lmYymjvKJlt7JjVVcz6QYfM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUBOE7VyWmitG8cH/Ocidfp0sZMjyfIm0Pmqkx8e+fjEVSPrx7kLEVyfbPUDMjYsZpmdP17xOqvqKDDzfubhKLHcrSCGRCKsul95i5XFxaNL1S1ovmdFQMG/nrS3ZRyBYhI5O6gT0HWuXPk0Rzxyn29wwgbl/iSDaV3hZyvGktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNKT66/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22B4C4CEEB;
	Tue,  1 Jul 2025 23:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751414171;
	bh=pYj5+WQU/sktJR79YRM0lmYymjvKJlt7JjVVcz6QYfM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mNKT66/A2rlZv4CCmW/Z0OCgf3tpRbMpVbYdBTsIWoUZqJxggwBWwjRGFqjGpi3cj
	 AKkcVImTbohJT0FTobnEdv+cmMO3JacSmdtBQmBq9eXzhTerdTY4U5TiWEAEbpxdhB
	 zgCV9tRktqT4iQ2NzABYcdSS4dtj0j7OBvmF6qa0xHsunYrTrFXSedz+lKEbtL3dgp
	 yZM2ExZFHBO/+wdI7Ai9PzdlPlT73HRXuqkhx57kqcTVNNA8ySAKk8u4pCO8zJNCBX
	 iJRFPOKHHqDPj54cCKDyY8VZMLu0n5P9ZNgc/D2TQsjkvZH1lyHiHScSgFI/bKxbQ8
	 d+TDh7rTe4jyw==
Date: Tue, 1 Jul 2025 16:56:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Abeni <pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>, John Stultz
 <jstultz@google.com>, Frederic Weisbecker <frederic@kernel.org>, Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>, David Woodhouse
 <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, Thomas
 =?UTF-8?B?V2Vpw59zY2h1aA==?= <thomas.weissschuh@linutronix.de>, Kurt
 Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, Antoine
 Tenart <atenart@kernel.org>
Subject: Re: [patch 0/3] ptp: Provide support for auxiliary clocks for
 PTP_SYS_OFFSET_EXTENDED
Message-ID: <20250701165610.6e2b9af2@kernel.org>
In-Reply-To: <871pr0m75g.ffs@tglx>
References: <20250626124327.667087805@linutronix.de>
	<852d45b4-d53d-42b6-bcd9-62d95aa1f39d@redhat.com>
	<871pr0m75g.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 01 Jul 2025 14:23:39 +0200 Thomas Gleixner wrote:
> On Tue, Jul 01 2025 at 12:16, Paolo Abeni wrote:
> > On 6/26/25 3:27 PM, Thomas Gleixner wrote:  
> >> It is also available via git with all prerequisite patches:
> >> 
> >>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git timers/ptp/driver-auxclock
> >> 
> >> Miroslav: This branch should enable you to test the actual steering via a
> >> 	  PTP device which has PTP_SYS_OFFSET_EXTENDED support in the driver.  
> >
> > I have some dumb issues merging this on net-next.
> >
> > It looks like we should pull from the above URL, but it looks like the
> > prereq series there has different hashes WRT the tip tree. Pulling from
> > there will cause good bunch of duplicate commits - the pre-req series vs
> > the tip tree and the ptp cleanup series vs already merge commits on
> > net-next.
> >
> > I guess we want to avoid such duplicates, but I don't see how to avoid
> > all of them. A stable branch on top of current net-next will avoid the
> > ptp cleanup series duplicates, but will not avoid duplicates for
> > prereqs. Am I missing something obvious?  
> 
> No. I messed that up by not telling that the PTP series should be
> applied as a seperate branch, which is merged into net-next. That way I
> could have merged that branch back into tip and apply this pile on top.
> 
> Let me think about an elegant way to make this work without creating an
> utter mess in either of the trees (or both).

Sorry about that, I read the previous cover letter as the branch being
provided for convenience, not that I _should_ pull from it. I should
have asked..

