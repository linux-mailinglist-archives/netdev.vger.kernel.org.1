Return-Path: <netdev+bounces-116823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D4994BD45
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD7F32879DE
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F3918C341;
	Thu,  8 Aug 2024 12:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Me5mvLTU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158C018C33A
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119647; cv=none; b=XleIKIK3fgSTog1WZ7HsDVj29U42q9Zi5sCiHzJlnBc2LIK9QN3qWq3yXsfo7EHbDd5MbQspsHsOYcTWtx0OQwgQ3Z4WS3fYnGhL8fbfOm1E9DbuwJ9Fg2EzgbliGYSQgxxpXkaXSBFvmnNtuObMDShXxRjJCcP8CVz+clE4gi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119647; c=relaxed/simple;
	bh=TMYEpsiSUQkIQJz1rXgA0XuEwvSPiDd4qzqv+3H5PDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSBPu9r+S/+NzORqCW3zcVnS7cA2yt/VgVOR3M8myKi4CwJkeYVsPOg25MK08z46LWW/eFxLfnpsPnV2CQbnwBBqIg02iT0OSQS6Y7CqpRciwXw6cUjXkFg0m83ep7uaqQSOY+duZMNS7QIO2jkj7alH3LSdneR0Yo50xKSnmng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Me5mvLTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E32AC32782;
	Thu,  8 Aug 2024 12:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723119646;
	bh=TMYEpsiSUQkIQJz1rXgA0XuEwvSPiDd4qzqv+3H5PDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Me5mvLTUR8gzgXRhfLRHfS9FxU/QGfCwB/ISUlgKA7laTK5b6GYMqThfkFVQTOjTu
	 zNdJcD4EYpRkoj/KALZPueY6R/GLIdoRlCdQDoVoP/FRFHsLTTbWYS3Fs8rDBT2T2l
	 trN0v2fCCePZNffzVeo94Euh2fSJQDYGFWz3ErNRMoIE/hA4RdjC4n8dOCMYJ9OTkK
	 0iNEdtCgvARBytQK2pNuJ65DgBbvfqiiT11nzJdyU8CI8z3hNf4ZdR8TZ8zov/ZHK5
	 SzovMQqe1/3PwQELtuFCiDMmjHLjJWogrBDxO+x6LCjXhUm5m2DvXpHwvjcVQEbMBr
	 1REyh4PLOC5Cg==
Date: Thu, 8 Aug 2024 13:20:42 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 08/12] testing: net-drv: add basic shaper test
Message-ID: <20240808122042.GA3067851@kernel.org>
References: <cover.1722357745.git.pabeni@redhat.com>
 <75fbd18f79badee2ba4303e48ce0e7922e5421d1.1722357745.git.pabeni@redhat.com>
 <29a85a62-439c-4716-abd8-a9dd8ed9e60c@redhat.com>
 <20240731185511.672d15ae@kernel.org>
 <20240805142253.GG2636630@kernel.org>
 <20240805123655.50588fa7@kernel.org>
 <20240806152158.GZ2636630@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806152158.GZ2636630@kernel.org>

On Tue, Aug 06, 2024 at 04:22:03PM +0100, Simon Horman wrote:
> On Mon, Aug 05, 2024 at 12:36:55PM -0700, Jakub Kicinski wrote:
> > On Mon, 5 Aug 2024 15:22:53 +0100 Simon Horman wrote:
> > > On Wed, Jul 31, 2024 at 06:55:11PM -0700, Jakub Kicinski wrote:
> > > > On Wed, 31 Jul 2024 09:52:38 +0200 Paolo Abeni wrote:  
> > > > > FTR, it looks like the CI build went wild around this patch, but the 
> > > > > failures look unrelated to the actual changes here. i.e.:
> > > > > 
> > > > > https://netdev.bots.linux.dev/static/nipa/875223/13747883/build_clang/stderr  
> > > > 
> > > > Could you dig deeper?
> > > > 
> > > > The scripts are doing incremental builds, and changes to Kconfig
> > > > confuse them. You should be able to run the build script as a normal
> > > > bash script, directly, it only needs a small handful of exported
> > > > env variables.
> > > > 
> > > > I have been trying to massage this for a while, my last change is:
> > > > https://github.com/linux-netdev/nipa/commit/5bcb890cbfecd3c1727cec2f026360646a4afc62
> > > >   
> > > 
> > > Thanks Jakub,
> > > 
> > > I am looking into this.
> > > So far I believe it relate to a Kconfig change activating new code.
> > > But reproducing the problem is proving a little tricky.
> > 
> > Have you tried twiddling / exporting FIRST_IN_SERIES ?
> > 
> > See here for the 4 possible exports the test will look at:
> > 
> > https://github.com/linux-netdev/nipa/blob/6112db7d472660450c69457c98ab37b431063301/core/test.py#L124
> 
> Thanks, I will look into that.

Hi Jakub,

Thanks again for the information.

I have now taken another look at this problem.

Firstly, my analysis is that the cause of the problem is a combination of
the way the patchset is constricted, and the way that the build tests (I
have focussed on build_allmodconfig_warn.sh [1]).

[1] https://github.com/linux-netdev/nipa/blob/main/tests/patch/build_allmodconfig_warn/build_allmodconfig.sh

What I believe happens is this: The patches 01/12 - 07/12 modify some
header files, adds a new Kconfig entry, and does a bunch of other normal
stuff. Each of those patches is tested in turn, and everything seems fine.

Then we get to patch 08/12. The key thing about this patch is that it
enables the CONFIG_NET_SHAPER Kconfig option, in the context of an
allmodconfig build. That in turn modifies the headers
include/linux/netdevice.h and net/core/dev.h (and net/Makefile). Not in the
in terms of their on-disk contents changing, but rather in the case of the
header files, in terms of preprocessor output. And this is, I believe,
where everything goes wrong.

NIPA arrives at running build_allmodconfig_warn.sh for patch 08/12 with the tree
built for the previous patch, 07/12. It then:

* touches $output_dir/include/generated/utsrelease.h
* checks out HEAD~ (patch 07/12)
* prepares the kernel config
* builds kernel and records incumbent errors (49)

The thing to note here is that the tree has been little perturbed since build
tests were run for patch 07/12, and thus few files are rebuilt.

Moving on, simplifying things, the following then runs:

* touches $output_dir/include/generated/utsrelease.h
* checks out $HEAD (patch 08/12)
* prepares the kernel config
* builds kernel and records current errors (4219)

The key to understanding why the large delta between 49 and 4219 is
that vastly more files have been rebuilt. Because the preprocessor output
of netdevice.h and dev.h have changes since the last build, and those
headers are included, directly or indirectly, by a lot of files (and
compilation results in warnings for many of those files).


I was able to reproduce the result by running build_allmodconfig_warn.sh
over patch 07/12 and then 07/12 with FIRST_IN_SERIES=0.

I was able to get the desired result no new compiler warnings
by doing the same again, but with FIRST_IN_SERIES=1 for the
invocation of build_allmodconfig_warn.sh for 08/12.

I believe this is entirely due to a baseline rebuild being run due to the
FIRST_IN_SERIES=1 parameter. And, FWIIW, I believe the invocation of
build_allmodconfig_warn.sh for 07/12 ensures reproducibility.

My suggestion is that while we may consider reorganising the patch-set,
that is really only a work around. And it would be best to make the CI more
robust in the presence of such constructions.

It may be a bit heavy handed, but my tested solution is to invoke a
baseline rebuild if a Kconfig change is made. At the very last it does
address the problem at hand. (In precisely the same way as manually setting
FIRST_IN_SERIES=1.)

The patch implementing this for build_allmodconfig.sh which I tested is
below. If we want to go ahead with this approach then I expect it is best
to add it to other build tests too. But this seems to be a good point
to report my findings, so here we are.

--- build_allmodconfig.sh.orig  2024-08-08 07:30:56.599372164 +0000
+++ build_allmodconfig.sh       2024-08-08 09:58:22.692206313 +0000
@@ -34,8 +34,10 @@
 echo "Tree base:"
 git log -1 --pretty='%h ("%s")' HEAD~

-if [ x$FIRST_IN_SERIES == x0 ]; then
-    echo "Skip baseline build, not the first patch"
+if [ x$FIRST_IN_SERIES == x0 ] && \
+   ! git diff --name-only HEAD~ | grep -q -E "Kconfig$"
+then
+    echo "Skip baseline build, not the first patch and no Kconfig updates"
 else
     echo "Baseline building the tree"


