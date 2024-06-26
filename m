Return-Path: <netdev+bounces-106995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB0AD9186F5
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 18:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EB141F22457
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841EC190068;
	Wed, 26 Jun 2024 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hw+GhaOQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C6D18EFCF
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 16:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719418162; cv=none; b=nSDs06UbZj5QOPuwOL9xU6vBYhndpGrLzjTmcw2PPBHCU1W65E0eQ6sehGIa48H1gI7KQ3Vaon6ht99fKrFasD7Cenc4EQ+JpA1Sm4zm85+AbTbntPH6+L1IzB88UexBQ0ByGB1Oes2tO7e370F3q4wj39JdHIAMiSt43YM09bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719418162; c=relaxed/simple;
	bh=/eTzHPCdVcL6hynUhBQmb9RYCNZoHtSAh1QaEu/+8/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwMxbm4l7F8eqBe5Qnu1DtODLtUGJ/hTS5/NN0c4Epnb7vOZIWh3ERHnGp47+uYKzi+0eGZVcyswpQTdLUDpDOAD2/WWTuMyPLIM/miQh/c0IqL7cnyu1E7MuuLC1mnFnto2YiUqA5QnrnWZxLo0Qs5HpQZ/P+N1aT4n7zqGJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hw+GhaOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F17C116B1;
	Wed, 26 Jun 2024 16:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719418161;
	bh=/eTzHPCdVcL6hynUhBQmb9RYCNZoHtSAh1QaEu/+8/g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hw+GhaOQYiyMBgXIPpXZToVkJfVYRu6f/PerMk0mAoVEPpmFVi/CSG1iDFIb3HDsP
	 P7ba/ChB1KQIc6bOjStaIbU+QZSiEu0I2I4Qxu5rpMgwlku+leAzHfaYE3Z3SeIXi+
	 0qcsIf/3CtEIv4cZuSfKZRWc3tOd5h1udrJlFnOV+lKOrSI6N7XW2N2Wskz7FCODuZ
	 DIuMJZ09YCU0ri+illQebFCZ3X4dKP0MnWeNztMBfGzx2RJ9bl4LXJZU4EvwSBTvUX
	 4EmgJnLDsjI3mNcdjICOhG8ctYODgWm+nuvxG3fl5/sPoU0eN6hnkKD/cc5H1kZuHE
	 ZUQlv5uVhrGvA==
Date: Wed, 26 Jun 2024 09:09:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <willemdebruijn.kernel@gmail.com>,
 <przemyslaw.kitszel@intel.com>, <leitao@debian.org>
Subject: Re: [RFC net-next 1/2] selftests: drv-net: add ability to schedule
 cleanup with defer()
Message-ID: <20240626090920.64b0a5c0@kernel.org>
In-Reply-To: <878qys9cqt.fsf@nvidia.com>
References: <20240626013611.2330979-1-kuba@kernel.org>
	<20240626013611.2330979-2-kuba@kernel.org>
	<878qys9cqt.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 12:18:58 +0200 Petr Machata wrote:
> Jakub Kicinski <kuba@kernel.org> writes:
> > +def ksft_flush_defer():
> > +    global KSFT_RESULT
> > +
> > +    while global_defer_queue:
> > +        entry = global_defer_queue[-1]
> > +        try:
> > +            entry.exec()  
> 
> I wonder if you added _exec() to invoke it here. Because then you could
> just do entry = global_defer_queue.pop() and entry._exec(), and in the
> except branch you would just have the test-related business, without the
> queue management.

Initially I had both _exec, and _dequeue as separate helpers, but then
_dequeue was identical to cancel, so I removed that one, but _exec
stayed.

As you point out _exec() would do nicely during "flush".. but linter was
angry at me for calling private functions. I couldn't quickly think of
a clean scheme of naming things. Or rather, I should say, I like that
the only non-private functions in class defer right now are
test-author-facing. At some point I considered renaming _exec() to
__call__() or run() but I was worried people will incorrectly
call it, instead of calling exec().

So I decided to stick to a bit of awkward handling in the internals for
the benefit of more obvious test-facing API. But no strong preference,
LMK if calling _exec() here is fine or I should rename it..

> > +        except Exception:  
> 
> I think this should be either an unqualified except: or except
> BaseException:.

SG


> >      print(
> >          f"# Totals: pass:{totals['pass']} fail:{totals['fail']} xfail:{totals['xfail']} xpass:0 skip:{totals['skip']} error:0"  
> 
> Majority of this hunk is just preparatory and should be in a patch of
> its own. Then in this patch it should just introduce the flush.

True, will split.

> > +    def cancel(self):  
> 
> This shouldn't dequeue if not self.queued.

I was wondering if we're better off throwing the exception from
remove() or silently ignoring (what is probably an error in the 
test code). I went with the former intentionally, but happy to
change.

> > +        self._queue.remove(self)
> > +        self.queued = False
> > +
> > +    def exec(self):  
> 
> This shouldn't exec if self.executed.
> 
> But I actually wonder if we need two flags at all. Whether the defer
> entry is resolved through exec(), cancel() or __exit__(), it's "done".
> It could be left in the queue, in which case the "done" flag is going to
> disable future exec requests. Or it can just be dropped from the queue
> when done, in which case we don't even need the "done" flag as such.

If you recall there's a rss_ctx test case which removes contexts out of
order. The flags are basically for that test. We run the .exec() to
remove a context, and then we can check 

	if thing.queued:
		.. code for context that's alive ..
	else:
		.. code for dead context ..

