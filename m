Return-Path: <netdev+bounces-38958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3117BD46E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 09:36:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D8EE1C208C1
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 07:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111CDD312;
	Mon,  9 Oct 2023 07:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuorHarb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D1F5CB0
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16153C433C8;
	Mon,  9 Oct 2023 07:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696837010;
	bh=cyOr9wKSZbKTmoYhGi29W/BehcsluNpyqFhmV/79LkU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cuorHarbeq5vdYq06nmPq8nGX2pDzlhYY2aIguVOKLx86qrspW9qfoRixSiD2oG1N
	 BX1bPZiKVWe177iMU3qJ145/6+2QVdLkcYwZxGa8AO5oMtIqJfoIk3nVEGqVXjIFOK
	 veC1rvqC5QOFNQ1rskp5a1QGWowZeU/MLKC+k7IX27yaqQPwaC/2E0+1aTIIPnF7Zi
	 jRQ0blTp93aKHoihZBYvcrr6adET4DoQoSOx+8sYbZ4o9kQCrjGdrCzmS/dXLNJkwz
	 3hZTLiNv/d324k7T+CNsBKZE4Ai4/PYv3wZJOz/fGp/BoLGTd6qJlk9ik3kuHHAfUA
	 f5I0X9VQZ9jOA==
Date: Mon, 9 Oct 2023 09:36:43 +0200
From: Christian Brauner <brauner@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Hugh Dickins <hughd@google.com>, Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
	Christian Brauner <christian@brauner.io>,
	David Laight <David.Laight@aculab.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] iov_iter: fix copy_page_from_iter_atomic()
Message-ID: <20231009-bannen-hochwasser-3f0268372b80@brauner>
References: <356ef449-44bf-539f-76c0-7fe9c6e713bb@google.com>
 <20230925120309.1731676-9-dhowells@redhat.com>
 <20230925120309.1731676-1-dhowells@redhat.com>
 <1809398.1696238751@warthog.procyon.org.uk>
 <231155.1696663754@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <231155.1696663754@warthog.procyon.org.uk>

On Sat, Oct 07, 2023 at 08:29:14AM +0100, David Howells wrote:
> Hugh Dickins <hughd@google.com> wrote:
> 
> > -		__copy_from_iter(p, n, i);
> > +		n = __copy_from_iter(p, n, i);
> 
> Yeah, that looks right.  Can you fold it in, Christian?

Of course. Folded into
c9eec08bac96 ("iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()")
on vfs.iov_iter.

