Return-Path: <netdev+bounces-20561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47F0760167
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 23:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3B328144D
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 21:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE42C11C90;
	Mon, 24 Jul 2023 21:42:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B39111B6
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 21:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA461C433CA;
	Mon, 24 Jul 2023 21:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690234972;
	bh=+GmntWw2wj4TAgoks2s8GydM/ic6gHJYyYw6iUJJN68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H+wLCg95ppWbEdS/gfrkBlRJL8GSzxc5pnGAfcOUfCqEN0jcAhWlrIkNXkEC3eP9V
	 4RA9E4lO3ZGF+hOfMegtSn23YCDhyojHCyNgkVXqFYk9eu+baxpHppJoOkrTr52jLn
	 ez+LUhhfunIyHZUIiw3NHW9jcuuqLDCACBzZCNJGtXGGY9z2S2sHMDkfPMfqRZw4LG
	 UHv0q4Dj0l+J20fH9caBNk9dZUPoclp8h7oqB/Iub1OtT9bbdKVnZY7de9Sj59rdqI
	 FJQRaJNZbicCz7Av3AIqmtyi+z9NHYB3g3pAXC07xvRXolW4cs3fNElExHqHWlZ568
	 g0B3u7NtW3weA==
Date: Mon, 24 Jul 2023 14:42:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jann Horn <jannh@google.com>, Suren Baghdasaryan <surenb@google.com>,
 linux-mm@kvack.org, Arjun Roy <arjunroy@google.com>, Eric Dumazet
 <edumazet@google.com>, linux-fsdevel@vger.kernel.org, Punit Agrawal
 <punit.agrawal@bytedance.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/9] Revert "tcp: Use per-vma locking for receive
 zerocopy"
Message-ID: <20230724144250.4cef3f4e@kernel.org>
In-Reply-To: <ZL6TWDCasQon3h4r@casper.infradead.org>
References: <20230711202047.3818697-1-willy@infradead.org>
	<20230711202047.3818697-2-willy@infradead.org>
	<CAJuCfpGTRZO121fD0_nXi534D45+eOSUkCO7dcZe13jhkdfnSQ@mail.gmail.com>
	<ZLDCQHO4W1G7qKqv@casper.infradead.org>
	<CAG48ez3bv2nWaVx7kGKcj2eQXRfq8LNOUXm8s1gNVDJJoLsprw@mail.gmail.com>
	<ZL6TWDCasQon3h4r@casper.infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Jul 2023 16:06:00 +0100 Matthew Wilcox wrote:
> > Are you saying you want them to revert it before it reaches mainline?
> > That commit landed in v6.5-rc1.  
> 
> ... what?  It was posted on June 16th.  How does it end up in rc1 on
> July 9th?  6.4 was June 25th.  9 days is long enough for something
> that's not an urgent fix to land in rc1?  Networking doesn't close
> development at rc5/6 like most subsystem trees?

We don't, and yeah this one was a bit risky. We close for the merge
window (the two weeks), we could definitely push back on risky changes
starting a week or two before the window... but we don't know how long
the release will last :( if we stop taking large changes at rc6 and
release goes until rc8 that's 5 out of 11 weeks of the cycle when we
can't apply substantial patches. It's way too long. The weeks after 
the merge window are already super stressful, if we shut down for longer
it'll only get worse. I'm typing all this because I was hoping we can
bring up making the release schedule even more predictable with Linus,
I'm curious if others feel the same way.

On the matter at hand - I thought the patches were just conflicting
with your upcoming work. Are they already broken in v6.5? No problem
with queuing the revert for v6.5 here if they are.

