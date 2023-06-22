Return-Path: <netdev+bounces-13200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1D5273A974
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 22:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98BE1C211C9
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 20:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C307A21098;
	Thu, 22 Jun 2023 20:28:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F007200C6
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 20:28:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28BA5C433C0;
	Thu, 22 Jun 2023 20:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687465716;
	bh=y/yWd5uVMRCaLK5FhZxHraUGBdV/mEzDKca+3yl4kns=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WxMN7ynzoeDIgKp9qigd+U7A+dKCvNZNhyw9863fmtMX3FKqJWn+0zNnaxc0UMlYo
	 pg5eLKEaUwtXcJ846Q6rTVD058OFrAkHSmXXIY/MNsZe7wZL6ivWyl2ySsoPT9Qrs9
	 aLBR6Ev6OzLVxLEn/6tLTRGJwuoZq+dbZlkp8MSvpfXXAEAtVn5FV5LXc8rhnwQo/k
	 IC+sfBPVYRsCJ8bJJEmFrUo4j8cAFOSk9Y3IFdxDok1bUE1kDnAekvwAnlBgAqxyQu
	 RvfVhnW7aIfE3tyGlGf6R3lJKP7Zfo48Sgw1UFO4Ma9VUlFJ5ZQSqdFE5I9t4IxrE9
	 O7BtuG0QmHmqA==
Date: Thu, 22 Jun 2023 13:28:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Alexander Duyck <alexander.duyck@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern
 <dsahern@kernel.org>, Matthew Wilcox <willy@infradead.org>, Jens Axboe
 <axboe@kernel.dk>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Menglong Dong <imagedong@tencent.com>
Subject: Re: [PATCH net-next v3 01/18] net: Copy slab data for
 sendmsg(MSG_SPLICE_PAGES)
Message-ID: <20230622132835.3c4e38ea@kernel.org>
In-Reply-To: <1952674.1687462843@warthog.procyon.org.uk>
References: <20230622111234.23aadd87@kernel.org>
	<20230620145338.1300897-1-dhowells@redhat.com>
	<20230620145338.1300897-2-dhowells@redhat.com>
	<1952674.1687462843@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jun 2023 20:40:43 +0100 David Howells wrote:
> > How did that happen? I thought MSG_SPLICE_PAGES comes from former
> > sendpage users and sendpage can't operate on slab pages.  
> 
> Some of my patches, take the siw one for example, now aggregate all the bits
> that make up a message into a single sendmsg() call, including any protocol
> header and trailer in the same bio_vec[] as the payload where before it would
> have to do, say, sendmsg+sendpage+sendpage+...+sendpage+sendmsg.

Maybe it's just me but I'd prefer to keep the clear rule that splice
operates on pages not slab objects. SIW is the software / fake
implementation of RDMA, right? You couldn't have picked a less
important user :(

Paolo indicated that he'll take a look tomorrow, we'll see what he
thinks.

> I'm trying to make it so that I make the minimum number of sendmsg calls
> (ie. 1 where possible) and the loop that processes the data is inside of that.

The in-kernel users can be fixed to not use slab, and user space can't
feed us slab objects.

> This offers the opportunity, at least in the future, to append slab data to an
> already-existing private fragment in the skbuff.

Maybe we can get Eric to comment. The ability to identify "frag type"
seems cool indeed, but I haven't thought about using it to attach
slab objects.

> > The locking is to local_bh_disable(). Does the milliont^w new frag
> > allocator have any additional benefits?  
> 
> It is shareable because it does locking.  Multiple sockets of multiple
> protocols can share the pages it has reserved.  It drops the lock around calls
> to the page allocator so that GFP_KERNEL/GFP_NOFS can be used with it.
> 
> Without this, the page fragment allocator would need to be per-socket, I
> think, or be done further up the stack where the higher level drivers would
> have to have a fragment bucket per whatever unit they use to deal with the
> lack of locking.

There's also the per task frag which can be used under normal conditions
(sk_use_task_frag).

> Doing it here makes cleanup simpler since I just transfer my ref on the
> fragment to the skbuff frag list and it will automatically be cleaned up with
> the skbuff.
> 
> Willy suggested that I just allocate a page for each thing I want to copy, but
> I would rather not do that for, say, an 8-byte bit of protocol data.

TBH my intuition would also be get a full page and let the callers who
care about performance fix themselves. Assuming we want to let slab
objects in in the first place.

