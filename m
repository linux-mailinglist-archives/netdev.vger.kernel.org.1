Return-Path: <netdev+bounces-185756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C34AA9BAAE
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 00:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B01B466D07
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 22:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC911FA178;
	Thu, 24 Apr 2025 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzabDp4z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0621EA84
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 22:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745533452; cv=none; b=S3x5Hi0uvSaE2hG3DCL2WrBVN8i4p8kikwHWLKEuGs8DvHi8qhDrNduXkjZjTCBi4yUsPVUCPbgCLTa3I77zyTElFKAPH3NaxvQr57FSN+KwVUSizI9gLqhzYtu1pdnUfqXDHN8WkvFtWNEKBss9S/PYJdV4L0nLYlZYnJHfRKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745533452; c=relaxed/simple;
	bh=8jP6GyMdOOfmeJiX35FvsSI0ITIx8z2GDiVL2AG3AjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7LOR02xOAtXKMMMqylwm/YDizdAlDqaoKKAJbUduw89jROFhqaxmqyd4Q6SW7BDEK4mnQLido+6c6Fj0jS2VVVsCYG592I//hoCowVjOpk/jhB1wwSYLdgxrwUu+VorqM6X+sCMz739ObSW6lEf15YRGR2q3jo9y1uxeVFJHZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzabDp4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3199C4CEE3;
	Thu, 24 Apr 2025 22:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745533451;
	bh=8jP6GyMdOOfmeJiX35FvsSI0ITIx8z2GDiVL2AG3AjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WzabDp4zxfp2fS7hfUrbs9eXMcpB5vNPMFEo5Q1IlUjff7A+ynbNj2ZQOVGR03eK6
	 bOTpuVD6kYFdbYqRXy5naM+ffRmGzrcwspAgOd10kicVqzpqlQw08ACdIhKEZQK2Vf
	 kVHkMeoN2fiTUYuVuopmLf5HoBdsb6lVumOcxmqmqtFJM3oZZNNbJKu3QmphWKWZWT
	 29EmLjbjaKOurTbTSlq4UDuhAXLect/EGasBX9px2VE68dIbs+gL8TBYOQQhmwXItj
	 16aW21C/gO5Zv0H3vzW8LnNRf/wbPB/FBLXcwYfmD5r2sXRZLaD+wq2062tDAGQizN
	 F6JNBF4ghwZSQ==
Date: Thu, 24 Apr 2025 15:24:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
 <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 2/3] pfcp: Convert pfcp_net_exit() to
 ->exit_rtnl().
Message-ID: <20250424152410.011b4c9e@kernel.org>
In-Reply-To: <20250424022531.93945-1-kuniyu@amazon.com>
References: <20250423155233.33ac2bd3@kernel.org>
	<20250424022531.93945-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 23 Apr 2025 19:23:28 -0700 Kuniyuki Iwashima wrote:
> > > I guess it was broken recently ?  at least I didn't see null-deref
> > > while testing ffc90e9ca61b ("pfcp: Destroy device along with udp
> > > socket's netns dismantle.").  
> > 
> > Not sure, nothing seems to have changed since?  
> 
> It's been broken since the first commit of pfcp, but the bug seems
> to be exposed recently by the commit below, which changed the per-cpu
> variable section address from 0 to relative address.
> 
>   $ git bisect good
>   9d7de2aa8b41407bc96d89a80dc1fd637d389d42 is the first bad commit
>   commit 9d7de2aa8b41407bc96d89a80dc1fd637d389d42
>   Author: Brian Gerst <brgerst@gmail.com>
>   Date:   Thu Jan 23 14:07:40 2025 -0500
> 
>       x86/percpu/64: Use relative percpu offsets
> 
> Looks like before this commit 0 was a valid per-cpu variable address
> on x86, and that's why accessing per_cpu_ptr(NULL, cpu) was handled
> (im)properly.

Interesting! I guess in most cases, then, we'd access random data
and just show crazy interface stats prior to that commit?

> The fix is one-liner assigning pcpu_stat_type

Or remove the ndo, and re-add in net-next cause I don't see any actual
stats being counted.

> but no one have used > pfcp for the recent 3 months and haven't
> noticed the wrong stats nor used stats for a year.
> 
> Do we want to fix it or remove ? :)

That would be very pleasant indeed :) Let me answer in the other
sub-thread..

