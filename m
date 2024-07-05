Return-Path: <netdev+bounces-109546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24633928B8D
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 17:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F915B22BE8
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBFE16C688;
	Fri,  5 Jul 2024 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mGstUTGf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA1014AA0
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720192902; cv=none; b=mSAsz7kd+BPELeLlFi/EdiKr/GADsJo9ajWBhZlrTvCpIYrENJN+uBcsv8IPOXsgEVMl/tGRsI5mSTPbGb5GReCSfZXaCS6AMkhmq5+OPekkRs4YoLcklPAx/kUL8l93BJP4GEJIbUsRoKoelzZC3o8hNEFM/SqmsBWe+2hPEC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720192902; c=relaxed/simple;
	bh=iU9YW4M4qVClrJ65RPjTEgtYq5wl0ooEWFamMJ6+c1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nw4hT5KfAdYF33Sd2M564D4v9YRC6DOjrxv45EtgbxNk+L5/VzH6/JIpnsndw5eUoXasoFVe+9/HY6GD9YdLaN8KUAxgLThp/Jzz47Kxx1Q94nZYEi5a/uD5NlMuljYhf0+XaYLHPjmnc2uNfeo80JvSfk4vNLq2Mqkt07p4EW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mGstUTGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD713C116B1;
	Fri,  5 Jul 2024 15:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720192902;
	bh=iU9YW4M4qVClrJ65RPjTEgtYq5wl0ooEWFamMJ6+c1U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mGstUTGff+7qIef+smpEPXj9NZfC+VjFkhK44hOM51iWNS0Zh2MXjAUFfukwy9Tu0
	 HjLIiGsDqlggV56hl2ncOiknuZ8nNyqHySQgQmBa1ubs65qt05HfmJABUA8N+1efPF
	 JW3aWY75DG5Z6uy9gR3g7ipDwZkQPvi+kiJ3djEh1AHsGviyv3f46QGei2wIG93jbg
	 0KpNZ5W4B1WQ0KDVySrhQ6yMB6JzJSk4hWvBJfplAQpI+fCdT2YOJ1vSc7jhG29I++
	 a+dsbR8j888kOYxN8GTTWurQcwp7HmpKMjfO7xYEkzkDgIJxDZCjn6wPXxUfgHrIB4
	 6F5I2KFjp5jZQ==
Date: Fri, 5 Jul 2024 16:21:38 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Boris Pismenny <borisp@nvidia.com>,
	John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net-next] net: tls: Pass union tls_crypto_context pointer
 to memzero_explicit
Message-ID: <20240705152138.GF1095183@kernel.org>
References: <20240705-tls-memzero-v1-1-0496871cfe9b@kernel.org>
 <bb960821-a67b-4d61-afeb-ead10ea2a4dc@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bb960821-a67b-4d61-afeb-ead10ea2a4dc@intel.com>

On Fri, Jul 05, 2024 at 03:54:59PM +0200, Przemek Kitszel wrote:
> On 7/5/24 15:41, Simon Horman wrote:
> > Pass union tls_crypto_context pointer, rather than struct
> > tls_crypto_info pointer, to memzero_explicit().
> > 
> > The address of the pointer is the same before and after.
> > But the new construct means that the size of the dereferenced pointer type
> > matches the size being zeroed. Which aids static analysis.
> > 
> > As reported by Smatch:
> > 
> >    .../tls_main.c:842 do_tls_setsockopt_conf() error: memzero_explicit() 'crypto_info' too small (4 vs 56)
> > 
> > No functional change intended.
> > Compile tested only.
> > 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> one small nitpick only

...

> > @@ -710,7 +713,7 @@ static int do_tls_setsockopt_conf(struct sock *sk, sockptr_t optval,
> >   	return 0;
> >   err_crypto_info:
> > -	memzero_explicit(crypto_info, sizeof(union tls_crypto_context));
> > +	memzero_explicit(crypto_ctx, sizeof(union tls_crypto_context));
> 
> nit: That's a good fix to aid static analyzers, and reviewers.
> Now it's also easy to follow the standard style and pass
> sizeof(*crypto_ctx) instead of the type.

Thanks, that is a good suggestion.
I'll incorporate it in a v2.

