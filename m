Return-Path: <netdev+bounces-77780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B72B5872FB2
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 08:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8FD91C24F07
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 07:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29F21CD1E;
	Wed,  6 Mar 2024 07:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Bnf+pGBR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [185.125.25.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F7835881
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 07:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710349; cv=none; b=o05IGgJ+OupxL5esB2AiiJ1MkX2XCNHQvld0A87P4XovoCQmKo2do55Gq1Vkw+lViqnc1uQgbUn0C42esVfNWhuuEREVQeWYdXvYPW4IXRWhHJ0PmlUdRRyNdAj/vtkE/BeH3vYyPeB8u/USsNsgPaJkEqzWps8PIrxtfx6QpiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710349; c=relaxed/simple;
	bh=jHtL5/BM5lZdwyQNewndmLOTlA78bq8Zp6YPa9Nivys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BG1XYeTM1xAZq67u1S5DFdyZ6t08JdBFp5rtwOjyOmdPxNbqiEqmq21VdyR/NmAxzFiV8JxB2XeXgEzDsMh0JMxzRyHKyoeo2Y4bqHuKgK/THBepC9sL/HDRwLwC5vm8XKkaetRSxLQtETKeC+9iSId5N9+YgIb/bG3wxWtCe8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Bnf+pGBR; arc=none smtp.client-ip=185.125.25.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4TqPK35KvxzMqCRH;
	Wed,  6 Mar 2024 08:32:23 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4TqPK31Q2Wz3Y;
	Wed,  6 Mar 2024 08:32:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1709710343;
	bh=jHtL5/BM5lZdwyQNewndmLOTlA78bq8Zp6YPa9Nivys=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bnf+pGBRCM2oQmZ/Ndmfz09ggrMuO8bVAMRpw82pfQYm8+aSp6GxqB3TSue3nay+W
	 LbcPAM0SW5uwFHuS0amH3R74dYgRrxfTViUtVTsZd3NdniYaJK/CPwjk2X9uYeWxKv
	 gpBSk7PtlovH39NeEzG8AX8N8Y6VhBfyq7mLTF1o=
Date: Wed, 6 Mar 2024 08:32:13 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, 
	Kees Cook <keescook@chromium.org>, Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, Will Drewry <wad@chromium.org>, edumazet@google.com, 
	jakub@cloudflare.com, pabeni@redhat.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-security-module@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] selftests/harness: Fix TEST_F()'s vfork handling
Message-ID: <20240306.aepaGah0tie2@digikod.net>
References: <20240305.sheeF9yain1O@digikod.net>
 <20240305201029.1331333-1-mic@digikod.net>
 <20240305122554.1e42c423@kernel.org>
 <20240306.Hei7aekahvaj@digikod.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240306.Hei7aekahvaj@digikod.net>
X-Infomaniak-Routing: alpha

On Wed, Mar 06, 2024 at 08:25:45AM +0100, Mickaël Salaün wrote:
> On Tue, Mar 05, 2024 at 12:25:54PM -0800, Jakub Kicinski wrote:
> > On Tue,  5 Mar 2024 21:10:29 +0100 Mickaël Salaün wrote:
> > > Always run fixture setup in the grandchild process, and by default also
> > > run the teardown in the same process.  However, this change makes it
> > > possible to run the teardown in a parent process when
> > > _metadata->teardown_parent is set to true (e.g. in fixture setup).
> > > 
> > > Fix TEST_SIGNAL() by forwarding grandchild's signal to its parent.  Fix
> > > seccomp tests by running the test setup in the parent of the test
> > > thread, as expected by the related test code.  Fix Landlock tests by
> > > waiting for the grandchild before processing _metadata.
> > > 
> > > Use of exit(3) in tests should be OK because the environment in which
> > > the vfork(2) call happen is already dedicated to the running test (with
> > > flushed stdio, setpgrp() call), see __run_test() and the call to fork(2)
> > > just before running the setup/test/teardown.  Even if the test
> > > configures its own exit handlers, they will not be run by the parent
> > > because it never calls exit(3), and the test function either ends with a
> > > call to _exit(2) or a signal.
> > > 
> > > Cc: David S. Miller <davem@davemloft.net>
> > > Cc: Günther Noack <gnoack@google.com>
> > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > Cc: Kees Cook <keescook@chromium.org>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Shuah Khan <shuah@kernel.org>
> > > Cc: Will Drewry <wad@chromium.org>
> > > Fixes: 0710a1a73fb4 ("selftests/harness: Merge TEST_F_FORK() into TEST_F()")
> > > Link: https://lore.kernel.org/r/20240305201029.1331333-1-mic@digikod.net
> 
> Signed-off-by: Mickaël Salaün <mic@digikod.net>

Reported-by: Mark Brown <broonie@kernel.org>

> 
> > 
> > Your S-o-b is missing. Should be enough if you responded with it.
> > 
> > Code LGTM, thanks!
> > 

