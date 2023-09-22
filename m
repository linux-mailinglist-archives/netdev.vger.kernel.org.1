Return-Path: <netdev+bounces-35744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F227AAE2A
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 11:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 90DE01C20997
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 09:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A78A1DDEB;
	Fri, 22 Sep 2023 09:34:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AE51775C
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 09:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E5EC433C9;
	Fri, 22 Sep 2023 09:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695375248;
	bh=3sau3zGAqT64PlvL93L3t5WW9upTsJ7zh15tcnTdr5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hhaIBnCaAbuCpSxAopP2bOKGZnEbjsw1ElAoo3Zz7BnAv+l/F+pFaAiLxFA9ny7H4
	 9L3mO0A6LcrzntFIYgI89H2ltGDEBIp8buJfoqqX2Oket8WLh5QH4+7vA52PjIoXmF
	 zewHVEDJJ5s7nk3si4FZfbeiSKzOb+PQs0ixFTAuCpuG4a7+rn8HDBUBtzxA5Z7LmQ
	 9DxTufr/nkZ/j9CT/d7cv8Tjl14CVfZvwM5GTA2Jm9SOkAMYeEIgEsSi7Kk/Fh87yA
	 C7Y3P8pP44GUxZbrjNnO7rg1kLoKIIy5/7H2qkrSrshAyEnkdWKtxFpFjNqPVSTvqh
	 bwiFNK1GyFDMQ==
Date: Fri, 22 Sep 2023 10:34:01 +0100
From: Simon Horman <horms@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Christian Brauner <christian@brauner.io>,
	David Laight <David.Laight@aculab.com>,
	Matthew Wilcox <willy@infradead.org>,
	Jeff Layton <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/11] iov_iter: Add a kernel-type iterator-only
 iteration function
Message-ID: <20230922093401.GW224399@kernel.org>
References: <20230920222231.686275-1-dhowells@redhat.com>
 <20230920222231.686275-8-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920222231.686275-8-dhowells@redhat.com>

On Wed, Sep 20, 2023 at 11:22:27PM +0100, David Howells wrote:
> Add an iteration function that can only iterate over kernel internal-type
> iterators (ie. BVEC, KVEC, XARRAY) and not user-backed iterators (ie. UBUF
> and IOVEC).  This allows for smaller iterators to be built when it is known
> the caller won't have a user-backed iterator.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Alexander Viro <viro@zeniv.linux.org.uk>
> cc: Jens Axboe <axboe@kernel.dk>
> cc: Christoph Hellwig <hch@lst.de>
> cc: Christian Brauner <christian@brauner.io>
> cc: Matthew Wilcox <willy@infradead.org>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: David Laight <David.Laight@ACULAB.COM>
> cc: linux-block@vger.kernel.org
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  include/linux/iov_iter.h | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
> index 270454a6703d..a94d605d7386 100644
> --- a/include/linux/iov_iter.h
> +++ b/include/linux/iov_iter.h
> @@ -271,4 +271,35 @@ size_t iterate_and_advance(struct iov_iter *iter, size_t len, void *priv,
>  	return iterate_and_advance2(iter, len, priv, NULL, ustep, step);
>  }
>  
> +/**
> + * iterate_and_advance_kernel - Iterate over a kernel iterator
> + * @iter: The iterator to iterate over.
> + * @len: The amount to iterate over.
> + * @priv: Data for the step functions.

nit: an entry for @priv2 belongs here

> + * @step: Processing function; given kernel addresses.
> + *
> + * Like iterate_and_advance2(), but rejected UBUF and IOVEC iterators and does
> + * not take a user-step function.
> + */
> +static __always_inline
> +size_t iterate_and_advance_kernel(struct iov_iter *iter, size_t len, void *priv,
> +				  void *priv2, iov_step_f step)
> +{

...

