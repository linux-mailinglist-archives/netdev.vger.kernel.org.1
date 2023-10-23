Return-Path: <netdev+bounces-43493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E3877D3A12
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 16:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E6DFB20E8F
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 14:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8334C1B290;
	Mon, 23 Oct 2023 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZRhpWcw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A1B1B27C;
	Mon, 23 Oct 2023 14:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEE9C433C8;
	Mon, 23 Oct 2023 14:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698072742;
	bh=N+mEvsUn9hb5dl2kkVXdV0pJt+j0xGfTKcLa/eilMjc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BZRhpWcw6usXSKAvf6kpfwitdS3qwOLDsOErhlYiw9+HZnLSCwvg12IG0EmtVbPgP
	 aV/0LUxRAOOLKXCwecMM4bOQ5BmEa4wHELcH+MCQezcNWCK3AURXYfhWlKdcxZ7aQG
	 +I+uwVDZT1NJYVFTGPH3qJ5eazLqNz7airCst+ZGuDGraEM92TBFJ3UZPBoNY9DBlC
	 XkVGI+NR+W8TKxuUg+/odCs7tbsg6Xo/mIS4CqOy7U3rPk4zGG44Gf9CI71Y0n4GyE
	 GfIxdBggJdXj0z94ngJvmypzf1YXF84FJjJh11Z4HjRtF6NHkciGgy0ycwhNlcZOq2
	 CAFfp+byz7Rew==
Date: Mon, 23 Oct 2023 07:52:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Philip Li <philip.li@intel.com>
Cc: "Nambiar, Amritha" <amritha.nambiar@intel.com>,
 <oe-kbuild-all@lists.linux.dev>, kernel test robot <lkp@intel.com>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [net-next PATCH v5 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
Message-ID: <20231023075221.0b873800@kernel.org>
In-Reply-To: <ZTMu/3okW8ZVKYHM@rli9-mobl>
References: <169767396671.6692.9945461089943525792.stgit@anambiarhost.jf.intel.com>
	<202310190900.9Dzgkbev-lkp@intel.com>
	<b499663e-1982-4043-9242-39a661009c71@intel.com>
	<20231020150557.00af950d@kernel.org>
	<ZTMu/3okW8ZVKYHM@rli9-mobl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 21 Oct 2023 09:53:03 +0800 Philip Li wrote:
> > Some of them are bogus. TBH I'm not sure how much value running
> > checkpatch in the bot adds. It's really trivial to run for the  
> 
> It is found there're quite some checkpatch related fix commits on
> mainline.

Those changes are mostly for old code, aren't they?
It'd be useful to do some analysis of how long ago the mis-formatted
code has been introduced. Because if new code doesn't get fixes
there's no point testing new patches..

> Thus the bot wants to extend the coverage and do shift
> left testing on developer repos and mailing list patches.

I understand and appreciate the effort. 

I think that false positive has about a 100x the negative effect of a
true positive. If more than 1% of checkpatch warnings are ignored, we
should *not* report them to the list. Currently in networking we fully
trust the build bot and as soon as a patch set gets a reply from you it
gets auto-dropped from our review queue.
It'd be quite bad if we have to double check the reports.

Speaking of false positive rate - we disabled some checks in our own
use of checkpatch:
https://github.com/kuba-moo/nipa/blob/master/tests/patch/checkpatch/checkpatch.sh#L6-L12
and we still get about 26% false positive rate! (Count by looking at
checks that failed and were ignored, because patch was merged anyway).
A lot of those may be line length related (we still prefer 80 char
limit) but even without that - checkpatch false positives a lot.

And the maintainer is not very receptive to improvements for false
positives:
https://lore.kernel.org/all/20231013172739.1113964-1-kuba@kernel.org/

> But as you mentioned above, we will take furture care to the output
> of checkpatch to be conservative for the reporting.

FWIW the most issues that "get through" in networking are issues 
in documentation (warnings for make htmldocs) :(

