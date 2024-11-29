Return-Path: <netdev+bounces-147806-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF199DBF36
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 06:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFF2FB21325
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 05:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25ABB14D6F6;
	Fri, 29 Nov 2024 05:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="RabZ1T+8"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5F72B2DA;
	Fri, 29 Nov 2024 05:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732859289; cv=none; b=PWeVVoZ9Ahac03VF6qY2jXjC16Sx52uNl4kJCQMBhajaDgK6moh838uOVOrVo5pi/lFDeTlVpri93T0F17GwLDfK9pNTxZ6AtH3Ns+Q2lYu1n5psqjvgIWXvL+d7101yCYuthJBG7I5lByQDl2XblN6qGEJ/f6nchYkgwc4dGxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732859289; c=relaxed/simple;
	bh=cmRn9M1qxrd4AfZ03Cxm6WUQlFfSFrrYHmEjmYoK9YI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jn8jsAeQZ8XIB7IAdFHTTUVYLxbhkO2/n3gWCDsF+JvcjUUuNhyzKvWF2tALm2HYY3xZpo/dyTusihYaiooE/glqX2QTjGndRY5jcTJG/i1Ol60j6vfi+afin1/3IBEaMWafFcGAf1rf9WjnVvodffNOB7612X6B0Fxcc3YD+7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=RabZ1T+8; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0WFqm03LASHMTyNt5a67Mk7JKchTI8bd3NQnsi8VLts=; b=RabZ1T+8UjCRgLHHXqz2Ng12E2
	UpQ8whlQdklzQS4BQmJ2r5AjliQUUjj5A+knrd6aK42mKJyLvK0lqxPM92ycXRRgRaofO3w/5sg5K
	vuJoQzaA6Wbive6Ht5fdxSrDBpd5tLN8vQ2T4nnf9jwdFJMstI22bT666xny88ee5mzcM1liXDnVh
	SfAn5aM/wzelfmGm6cYEVZHMkLASxjuEXSL4mncM0k8TL02yOlt1yuPyHDrkcZzpOHZ+/SIXI+kpm
	iD4nPYQrN9ESYzvzBA2Zprz6hfmWiRAc5NsRUvXFiO0dto35FDyjz2yDywFBYVvpUesihCwbp5vdg
	q2u0u6Mw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tGtqw-002KZu-0i;
	Fri, 29 Nov 2024 13:47:43 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 Nov 2024 13:47:42 +0800
Date: Fri, 29 Nov 2024 13:47:42 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>,
	Tejun Heo <tj@kernel.org>, Hao Luo <haoluo@google.com>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rhashtable: Fix potential deadlock by moving
 schedule_work outside lock
Message-ID: <Z0lVftsFRSSkPkld@gondor.apana.org.au>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>

On Thu, Nov 28, 2024 at 04:16:25AM -0800, Breno Leitao wrote:
> Move the hash table growth check and work scheduling outside the
> rht lock to prevent a possible circular locking dependency.
> 
> The original implementation could trigger a lockdep warning due to
> a potential deadlock scenario involving nested locks between
> rhashtable bucket, rq lock, and dsq lock. By relocating the
> growth check and work scheduling after releasing the rth lock, we break
> this potential deadlock chain.
> 
> This change expands the flexibility of rhashtable by removing
> restrictive locking that previously limited its use in scheduler
> and workqueue contexts.

Could you please explain the deadlock? Is the workqueue system actually
using rhashtable?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

