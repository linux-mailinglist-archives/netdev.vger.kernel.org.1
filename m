Return-Path: <netdev+bounces-107013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29EFF9187E4
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 18:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C84161F21CB1
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 16:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5517518F2FB;
	Wed, 26 Jun 2024 16:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWHsa1Lq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D11618F2F0
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 16:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420574; cv=none; b=uEtgB2ZUcCpE6a/oAJwnuNtA4LvMqueYv0vnntTLDzRn9mUq6SqDOGEjex9gcoV/1rWQ1mxB0PfKvyan9t1lV7wCsXq99p2+Kh4vXzuPdUSaB3EFok0j5rpPUb5ytXazK+FJf0UTQ29Jr4YITQbJHf8XVSKeBIfnSWIs9Iw149k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420574; c=relaxed/simple;
	bh=IfDqbs5kA8ug+qgKy1fSQRn2ukYrOaMhZLfLMh0MT0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SjdQxvK4wn1x/+FmC/aCxwjUegUjbiksYM7HdQbZX441URyJG9N5/+NzxTgEyM6SCmv6Tp2MJZZu5jSk0bNB5VsUFsWvbO26P1h7iGU1k4A03aLjPrxZ8RqEP4EfUifmSwTepU6reN1V6YauL3BLx+M0ixb8KcZBc37rC4zBmmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWHsa1Lq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CBD5C116B1;
	Wed, 26 Jun 2024 16:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719420573;
	bh=IfDqbs5kA8ug+qgKy1fSQRn2ukYrOaMhZLfLMh0MT0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DWHsa1LqtGb1KQF4+G148HO9uYYqvNZJZRZE7jDItr74SGv4U8Qsc793jJBKz6wxw
	 UEARlwqUE/LJdMB9+mlXO3i2DDI96ZwzW2mTzgcYJ0NOoRruDG3JwY+RxQxE2Hn9bl
	 pyTsOAnOh+QnmEB0W5v+IklUTq9qPXZ3dEG2l5kkgZhSE/zVT2ZRQePAjJ/w5tdclY
	 QU6hR271XH4eM3fNrdtTteBU3f1rCrGAtjM4quQ2aRVQDsLKMzjDGacDnK3YiP/m6P
	 QC1DGLWlQYB59bdzPOKS6NUHy9JwblkT0s9hV4UHjZ6EdrLOHxFk85iGltKxgJhpOh
	 jbCzflcYcTcbQ==
Date: Wed, 26 Jun 2024 09:49:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
 <willemdebruijn.kernel@gmail.com>, <leitao@debian.org>, <petrm@nvidia.com>,
 <davem@davemloft.net>
Subject: Re: [RFC net-next 1/2] selftests: drv-net: add ability to schedule
 cleanup with defer()
Message-ID: <20240626094932.1495471b@kernel.org>
In-Reply-To: <d7a8b57d-0dea-4160-8aa3-24e18cf2490e@intel.com>
References: <20240626013611.2330979-1-kuba@kernel.org>
	<20240626013611.2330979-2-kuba@kernel.org>
	<d7a8b57d-0dea-4160-8aa3-24e18cf2490e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 09:43:54 +0200 Przemek Kitszel wrote:
> > As a nice safety all exceptions from defer()ed calls are captured,
> > printed, and ignored (they do make the test fail, however).
> > This addresses the common problem of exceptions in cleanup paths
> > often being unhandled, leading to potential leaks.  
> 
> Nice! Please only make it so that cleanup-failure does not overwrite
> happy-test-path-failure (IOW "ret = ret ? ret : cleanup_ret")

That should be what we end up doing. The ret is a boolean (pass / fail)
so we have:

	pass &= cleanup_pass

effectively.

> > +            ksft_pr("Exception while handling defer / cleanup!")  
> 
> please print current queue size, if only for convenience of test
> developer to be able tell if they are moving forward in 
> fix-rerun-observe cycle

Hm... not a bad point, defer() cycles are possible.
But then again, we don't guard against infinite loops 
in  tests either, and kselftest runner (the general one, 
outside our Python) has a timeout, so it will kill the script.

> > +            tb = traceback.format_exc()
> > +            for line in tb.strip().split('\n'):
> > +                ksft_pr("Defer Exception|", line)
> > +            KSFT_RESULT = False  
> 
> I have no idea if this could be other error than just False, if so,
> don't overwrite

Yup, just True / False. The other types (skip, xfail) are a pass
(True) plus a comment, per KTAP spec.

