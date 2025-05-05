Return-Path: <netdev+bounces-187836-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C328AA9D0D
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 22:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25D385A0132
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 20:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7722326E146;
	Mon,  5 May 2025 20:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e4omUzoL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5216826C3AC
	for <netdev@vger.kernel.org>; Mon,  5 May 2025 20:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746476089; cv=none; b=Z8h0w7TWit6MsTRxjVncjSR0j2I00uVcsyxIZin0jZklVmxm8Fej/GzCF0QPcJTEw+M0CJAKhmtIt/4p7EtVeC4EyfL+4IZKjH2z0FklEXlYVGdX0P+n/Xd6zoUb78/CkVSohSD47+TA8X34+wzW1mDgyacu/jRpLFxEzfTNwHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746476089; c=relaxed/simple;
	bh=/hG7G6MUd0jlZa6G16QYvMWjPpUh8hoYkDnJ0sfdLIA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bvEwWJn/IR4Ut215Up1KH99PhPZU1rlceHB1cMiv/CMqEZ1Xm7LiKlmC+RSIMyr3Xz6ciUwEYsJ4OFNwhwQc4K92+rMGSfYZr9Enr6jap3y19NkPcJXrpTfIgYYsnniKIocM78XwrkeYsPGzMtD+n/01cpDEiDNzgAEdg6Dn+6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e4omUzoL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8F4C4CEE4;
	Mon,  5 May 2025 20:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746476088;
	bh=/hG7G6MUd0jlZa6G16QYvMWjPpUh8hoYkDnJ0sfdLIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e4omUzoLZZRbglU9ceiv/HMXWD+6iOS3qpPJDl+bOBbaftyXQNbMrlFZKU6SJigu8
	 PkvHlc0LB51f4jwe689iGj79bPBQdpD/nRyKCZgyF0NYtZPShgoTqWOe/7w4q8S7PW
	 f0totyxBZlBUC4788rTnLR9mQMgvCa9kOhpzizV7IzQDBGtzPAvmiwAWbulvI2Gde4
	 Y2ocBHFc5s8XM1GhZXI3m1Aj8RjAJ8eHwew4lyDWAtPYgHwe6UPkyUoARovY3JVbLT
	 YACxX1jTSfORNzXpcv7BgL2IzJx93WeqCLTx4YonIv957hRm0JmOyp3VAviYLKM59S
	 Dwlf8AvnEMyhQ==
Date: Mon, 5 May 2025 13:14:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, "David
 S. Miller" <davem@davemloft.net>, David Hildenbrand <david@redhat.com>,
 John Hubbard <jhubbard@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 willy@infradead.org, netdev@vger.kernel.org, linux-mm@kvack.org, Willem de
 Bruijn <willemb@google.com>
Subject: Re: Reorganising how the networking layer handles memory
Message-ID: <20250505131446.7448e9bf@kernel.org>
In-Reply-To: <1069540.1746202908@warthog.procyon.org.uk>
References: <165f5d5b-34f2-40de-b0ec-8c1ca36babe8@lunn.ch>
	<0aa1b4a2-47b2-40a4-ae14-ce2dd457a1f7@lunn.ch>
	<1015189.1746187621@warthog.procyon.org.uk>
	<1021352.1746193306@warthog.procyon.org.uk>
	<1069540.1746202908@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 02 May 2025 17:21:48 +0100 David Howells wrote:
> Okay, perhaps I should start at the beginning :-).

Thanks :) Looks like Eric is CCed, also adding Willem.
The direction of using ubuf_info makes sense to me.
Random comments below on the little I know.

> There a number of things that are going to mandate an overhaul of how the
> networking layer handles memory:
> 
>  (1) The sk_buff code assumes it can take refs on pages it is given, but the
>      page ref counter is going to go away in the relatively near term.
> 
>      Indeed, you're already not allowed to take a ref on, say, slab memory,
>      because the page ref doesn't control the lifetime of the object.
> 
>      Even pages are going to kind of go away.  Willy haz planz...

I think the part NVMe folks run into is the BPF integration layer
called skmsg. It's supposed to be a BPF-based "data router", at
the socket layer, before any protocol processing, so it tries
to do its own page ref accounting..

>  (2) sendmsg(MSG_ZEROCOPY) suffers from the O_DIRECT vs fork() bug because it
>      doesn't use page pinning.  It needs to use the GUP routines.

We end up calling iov_iter_get_pages2(). Is it not setting
FOLL_PIN is a conscious choice, or nobody cared until now?

>  (3) sendmsg(MSG_SPLICE_PAGES) isn't entirely satisfactory because it can't be
>      used with certain memory types (e.g. slab).  It takes a ref on whatever
>      it is given - which is wrong if it should pin this instead.

s/takes a ref/requires a ref/ ? I mean - the caller implicitly grants 
a ref  to the stack, right? But yes, the networking stack will try to
release it.

>  (4) iov_iter extraction will probably change to dispensing {physaddr,len}
>      tuples rather than {page,off,len} tuples.  The socket layer won't then
>      see pages at all.
>
>  (5) Memory segments splice()'d into a socket may have who-knows-what weird
>      lifetime requirements.
> 
> So after discussions at LSF/MM, what I'm proposing is this:
> 
>  (1) If we want to use zerocopy we (the kernel) have to pass a cleanup
>      function to sendmsg() along with the data.  If you don't care about
>      zerocopy, it will copy the data.

TAL at struct ubuf_info

>  (2) For each message sent with sendmsg, the cleanup function is called
>      progressively as parts of the data it included are completed.  I would do
>      it progressively so that big messages can be handled.
> 
>  (3) We also pass an optional 'refill' function to sendmsg.  As data is sent,
>      the code that extracts the data will call this to pin more user bufs (we
>      don't necessarily want to pin everything up front).  The refill function
>      is permitted to sleep to allow the amount of pinned memory to subside.

Why not feed the data as you get the notifications for completion?

>  (4) We move a lot the zerocopy wrangling code out of the basement of the
>      networking code and put it at the system call level, above the call to
>      ->sendmsg() and the basement code then calls the appropriate functions to  
>      extract, refill and clean up.  It may be usable in other contexts too -
>      DIO to regular files, for example.
> 
>  (5) The SO_EE_ORIGIN_ZEROCOPY completion notifications are then generated by
>      the cleanup function.

Already the case? :)

>  (6) The sk_buff struct does not retain *any* refs/pins on memory fragments it
>      refers to.  This is done for it by the zerocopy layer.

