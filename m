Return-Path: <netdev+bounces-35743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E81A67AAE11
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 11:32:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id CED0F1C20A3D
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 09:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D44041DDE9;
	Fri, 22 Sep 2023 09:32:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CD21DDC6
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 09:32:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B0F7C433C9;
	Fri, 22 Sep 2023 09:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695375155;
	bh=vwZUAYeEfWwnaGPU+f55fpprOAGYNnTdXdHwaC6Ti5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o9nXd2ERc/xNm7w0xvgZ+jg3uIJWBrEPTC/DuLDyeLQ2YVjNrOfjXaCb5QoLcXhOQ
	 s1yRC7V6cI8Gv0op5YlxFtha2SFI+Gs5PMt/+4yEo9dLmGjdlJbngdoYb/yDveICei
	 SL4Jf1YHttuw0WFbBVRKI1FjVXO1bHFaJ/dCTHA6NGz9mUe6PglwaVqVwjKWo97lEr
	 uGmtucbm6STBFJ37LXVZh9RAz7h3m0M6LsJ3X3hbbebUGAcM/q46hRo4yCB6F0Cml2
	 Q0jWXfW8jwWbgfYj8SCtNd5UhVXZL3ElDucO33i1B/6qbThCgKSjihp+5NfHv8K4Pl
	 ql2vtkPWxGuNg==
Date: Fri, 22 Sep 2023 10:32:27 +0100
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
Subject: Re: [PATCH v5 05/11] iov_iter: Convert iterate*() to inline funcs
Message-ID: <20230922093227.GV224399@kernel.org>
References: <20230920222231.686275-1-dhowells@redhat.com>
 <20230920222231.686275-6-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920222231.686275-6-dhowells@redhat.com>

On Wed, Sep 20, 2023 at 11:22:25PM +0100, David Howells wrote:

...

> @@ -312,23 +192,29 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
>  		return 0;
>  	if (user_backed_iter(i))
>  		might_fault();
> -	iterate_and_advance(i, bytes, base, len, off,
> -		copyout(base, addr + off, len),
> -		memcpy(base, addr + off, len)
> -	)
> -
> -	return bytes;
> +	return iterate_and_advance(i, bytes, (void *)addr,
> +				   copy_to_user_iter, memcpy_to_iter);
>  }
>  EXPORT_SYMBOL(_copy_to_iter);
>  
>  #ifdef CONFIG_ARCH_HAS_COPY_MC
> -static int copyout_mc(void __user *to, const void *from, size_t n)
> -{
> -	if (access_ok(to, n)) {
> -		instrument_copy_to_user(to, from, n);
> -		n = copy_mc_to_user((__force void *) to, from, n);
> +static __always_inline
> +size_t copy_to_user_iter_mc(void __user *iter_to, size_t progress,
> +			    size_t len, void *from, void *priv2)
> +{
> +	if (access_ok(iter_to, len)) {
> +		from += progress;
> +		instrument_copy_to_user(iter_to, from, len);
> +		len = copy_mc_to_user(iter_to, from, len);

Hi David,

Sparse complains a bit about the line above, perhaps the '(__force void *)'
should be retained from the old code?

 lib/iov_iter.c:208:39: warning: incorrect type in argument 1 (different address spaces)
 lib/iov_iter.c:208:39:    expected void *to
 lib/iov_iter.c:208:39:    got void [noderef] __user *iter_to

>  	}
> -	return n;
> +	return len;
> +}
> +
> +static __always_inline
> +size_t memcpy_to_iter_mc(void *iter_to, size_t progress,
> +			 size_t len, void *from, void *priv2)
> +{
> +	return copy_mc_to_kernel(iter_to, from + progress, len);
>  }
>  
>  /**

...

