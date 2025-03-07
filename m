Return-Path: <netdev+bounces-172911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F25E5A56733
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 12:56:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A05B1779AE
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 11:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13451217F42;
	Fri,  7 Mar 2025 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="LI8JjkJD"
X-Original-To: netdev@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7988120C00C;
	Fri,  7 Mar 2025 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741348580; cv=none; b=dlGQ90NuvZyNIxm/E+K7EhwIvS9lEDqKe5FpYq3OYPrwyUfUFns8yZLGncp7OgE2qZZRwbPpPlzxM2F2DeW/rd361pG5AzFULuFC0pD7Tnh7441teuIKsQouOM+3YAYrBCh32tn7LWrVoHG1Pupbhzi5FIoLaXJPGtdFa751Os8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741348580; c=relaxed/simple;
	bh=AEoHVhCtPqrNOpazoS/0UO4HDhnndTUwM9XyvDjaMPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIA0zhAlSA/4o85r0y9hrnwix8eTMqKho2xqATq34pz6vHh0dz3cvywb7b91UtbDHCvQNFDxonlNhiRKKxFQZ73+lr1IamVH8IPLLA0aWERmCfoVgUUhLfVWN0encR2aK0HfcRLhu6W2H1+eRFHPtohsv6/LRPPVqQAGSqaiLVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=LI8JjkJD; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6F4CE40E01A0;
	Fri,  7 Mar 2025 11:56:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qiag8fHRWfvs; Fri,  7 Mar 2025 11:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741348567; bh=skVMfj6F4q0eJCWKQfe1/WbSrZcERS0jUiqPGjIPHBY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LI8JjkJDVMf9Fqun0m6u9iIPesZtZGd6w+kl6L7HGZ0+tqKzX1OjJe0TKdJcp28XX
	 uKpa0wqQQhjoFeNp3Bw95WUsOWjMS3jCqp2nCEO9dpb5dXBAX6tMpEeuwjaSGHtNdI
	 Ad9zmvwJ6e7IRylQ3CWIXzopPSh1BTntpfv9vlkrAEMaBPpa+2MmUvnK5sTgu2wXiB
	 MvK9pWGtV9y2AMOdXd7w99+XQb4MlMtp544PfXsqIZb4ovkxTiTiWT5bAC2aP7czmD
	 0jkksBpg/S8I5ay4P+l9uD7qqFqHmkv1hZVpRcTVuCA7/1ZXOFQECeG6eaY5TSoj7d
	 b69zJQ0vwFhLre3V11HPqmMzbyMIc8Kv74HROwNxK8e60mM0w/bSrsx23r0tV41EAD
	 N2KLPNndkUFTwMv54cha8GTqt/i4Nlv9xIaVgMactqp7ffpBi5xb1zRTsIubUqaMq6
	 GfZg72FHnnyKX4l+XNWwNUwM7Re67WZhGd2LEUlDSW+4TibkTikAS8L+LGoja+VVZ2
	 BhTayYOo2m9wKTReY1UN9YeAQUqY35CeSgk9tunjR8hlbEOeX6C3tCckIhMn9VB9KP
	 PxwP4GnSZ2zVI/n3FwjJzc07ej7qMhV/m71FnRfpedBNLVeYG3nTkyCZHJlbqcINNp
	 8iFns/3oSoQ8MHJQnRrxwt8I=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0787140E0214;
	Fri,  7 Mar 2025 11:55:55 +0000 (UTC)
Date: Fri, 7 Mar 2025 12:55:50 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ryo Takakura <ryotkkr98@gmail.com>, Boqun Feng <boqun.feng@gmail.com>
Cc: Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, linux-kernel@vger.kernel.org,
	x86-ml <x86@kernel.org>
Subject: Re: request_irq() with local bh disabled
Message-ID: <20250307115550.GAZ8rexkba5ryV3zk0@fat_crate.local>
References: <20250306122413.GBZ8mT7Z61Tmgnh5Y9@fat_crate.local>
 <CANn89iJeHhGQaeRp01HP-KqA65aML+P5ppHjYT_oHSdXbcuzoQ@mail.gmail.com>
 <20250306161912.GFZ8nLAAVKdlx0s4xv@fat_crate.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250306161912.GFZ8nLAAVKdlx0s4xv@fat_crate.local>

On Thu, Mar 06, 2025 at 05:19:12PM +0100, Borislav Petkov wrote:
> On Thu, Mar 06, 2025 at 02:45:16PM +0100, Eric Dumazet wrote:
> > Hmmm.. not sure why local_bh is considered held..
> 
> Yeah, it looks like it is some crap in tip as current mainline is fine.
> 
> Lemme see what I can find there.
> 
> Thx and sorry for the noise.

As already mentioned by Mr. Z on the tip-bot message thread, below commit
breaks lockdep.

Reverting it fixes the issue, ofc.

$ git bisect start
# status: waiting for both good and bad commits
# good: [848e076317446f9c663771ddec142d7c2eb4cb43] Merge tag 'hid-for-linus-2025030501' of git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid
git bisect good 848e076317446f9c663771ddec142d7c2eb4cb43
# status: waiting for bad commit, 1 good commit known
# bad: [f4444d22a90c3fb0c825195b4154455d42986f21] Merge remote-tracking branch 'tip/master' into rc5+
git bisect bad f4444d22a90c3fb0c825195b4154455d42986f21
# bad: [6714630acf3cae8974e62a810389dcb191ac49af] Merge branch into tip/master: 'sched/core'
git bisect bad 6714630acf3cae8974e62a810389dcb191ac49af
# good: [156a8975430b127b5000b9018cb220fddf633164] Merge branch into tip/master: 'irq/core'
git bisect good 156a8975430b127b5000b9018cb220fddf633164
# bad: [468fad69db143874eaaeb472816f424e261df570] Merge branch into tip/master: 'locking/core'
git bisect bad 468fad69db143874eaaeb472816f424e261df570
# good: [f5de95438834a3bc3ad747f67c9da93cd08e5008] irqchip/renesas-rzv2h: Simplify rzv2h_icu_init()
git bisect good f5de95438834a3bc3ad747f67c9da93cd08e5008
# bad: [5fc1506d33db23894e74caf048ba5591f4986767] rust: lockdep: Remove support for dynamically allocated LockClassKeys
git bisect bad 5fc1506d33db23894e74caf048ba5591f4986767
# bad: [9b4070d36399ffcadc92c918bd80da036a16faed] locking/lock_events: Add locking events for rtmutex slow paths
git bisect bad 9b4070d36399ffcadc92c918bd80da036a16faed
# good: [337369f8ce9e20226402cf139c4f0d3ada7d1705] locking/mutex: Add MUTEX_WARN_ON() into fast path
git bisect good 337369f8ce9e20226402cf139c4f0d3ada7d1705
# bad: [8a9d677a395703ef9075c91dd04066be8a553405] lockdep: Fix wait context check on softirq for PREEMPT_RT
git bisect bad 8a9d677a395703ef9075c91dd04066be8a553405
# good: [5ddd09863c676935c18c8a13f5afb6d9992cbdeb] locking/rtmutex: Use struct keyword in kernel-doc comment
git bisect good 5ddd09863c676935c18c8a13f5afb6d9992cbdeb
# first bad commit: [8a9d677a395703ef9075c91dd04066be8a553405] lockdep: Fix wait context check on softirq for PREEMPT_RT

Author: Ryo Takakura <ryotkkr98@gmail.com>
Date:   Sat Jan 18 14:49:00 2025 +0900

    lockdep: Fix wait context check on softirq for PREEMPT_RT
    
    Since commit 0c1d7a2c2d32 ("lockdep: Remove softirq accounting on
    PREEMPT_RT."), the wait context test for mutex usage within
    "in softirq context" fails as it references @softirq_context.
    
    [    0.184549]   | wait context tests |
    [    0.184549]   --------------------------------------------------------------------------
    [    0.184549]                                  | rcu  | raw  | spin |mutex |
    [    0.184549]   --------------------------------------------------------------------------
    [    0.184550]                in hardirq context:  ok  |  ok  |  ok  |  ok  |
    [    0.185083] in hardirq context (not threaded):  ok  |  ok  |  ok  |  ok  |
    [    0.185606]                in softirq context:  ok  |  ok  |  ok  |FAILED|
    
    As a fix, add lockdep map for BH disabled section. This fixes the
    issue by letting us catch cases when local_bh_disable() gets called
    with preemption disabled where local_lock doesn't get acquired.
    In the case of "in softirq context" selftest, local_bh_disable() was
    being called with preemption disable as it's early in the boot.
    
    Signed-off-by: Ryo Takakura <ryotkkr98@gmail.com>
    Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
    Link: https://lore.kernel.org/r/20250118054900.18639-1-ryotkkr98@gmail.com


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

