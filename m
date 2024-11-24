Return-Path: <netdev+bounces-146948-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B17AE9D6D86
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 11:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 352FFB21017
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 10:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B419A15B0EF;
	Sun, 24 Nov 2024 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="EhzEZ+/F"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 264FD14287
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 10:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732443193; cv=none; b=juMUGXPblLxXjPIdA+eNgbZjv+U72AI64/dzXN+V8uNirbRS+ObhfS0TSULMheqYpKzdrcDajFJonPCnWckLHl2q4LSp2mMKXaTsI2sv7HIZwZ89swBBRYZMVRmvIuR9amcZI4g/Yzm3ocG0h++5RjXSnXop8TCMS+YWyMkSCc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732443193; c=relaxed/simple;
	bh=jIvcqDgnBZqGhX9bC/zKdVo6KduT/umLEdf3WKimz94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf6EKxaZJrKsMXEVQWoIRF/KmIQp7ZJB4aNVgnN+IxK/lOuirAseMZw4VpEKd2WOFoI3DrcoWUP5OUSywdwMNXgHP/pMKs/VZ8m9wSN+yx50AMZE7qzB7mzDHvaLV+p1+g6qfLqa6EQfGf8R40OZNIoSulgNgavV2twclfuRVT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=EhzEZ+/F; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AZWSspN3madywKKwCidDl7wLxqEiTNi9YFQ05JBRwcI=; b=EhzEZ+/FY3zEoPruYM9Cubts5I
	87ewscKpuV0PGnLtMqBu3RUEBWDxLXv9dTBq0syz5LpfOHjiYbtkakwAo+fJPQK7123c7f1V3gQk5
	4aZMgaiy4a0TuV5qWn9uLXePoaQO0dImyoUpBZBI7y9Ibx0SGFS7aOKIeYNQv0od3YckFgDG+L7Qb
	UZRijcB0b3wvVIrHih67MEKHvWXLSe5vPLeQ44V8EeOzdWd4SAYpwqe+fTqOG51aWLeKmKxA8fXEv
	tAzU37KcVyoppw30DHVbS8xVPRmovoe7OezyblKSdN1j+6UQXRZvSGFMaRitaahuD9YxVlte+gqj0
	2clPyUDw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tF9bx-001HpM-2Q;
	Sun, 24 Nov 2024 18:13:02 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 24 Nov 2024 18:13:01 +0800
Date: Sun, 24 Nov 2024 18:13:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <Z0L8LQeZwtvhJ2Ft@gondor.apana.org.au>
References: <>
 <Z0LxtPp1b-jy2Klg@gondor.apana.org.au>
 <173244248654.1734440.17446111766467452028@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173244248654.1734440.17446111766467452028@noble.neil.brown.name>

On Sun, Nov 24, 2024 at 09:01:26PM +1100, NeilBrown wrote:
>
> But I don't see any justification for refusing an insertion because we
> haven't achieved the short chains yet.  Certainly a WARN_ON_ONCE or a
> rate-limited WARN_ON might be appropriate.  Developers should be told
> when their hash function isn't good enough.
> But requiring developers to test for errors and to come up with some way
> to manage them (sleep and try again is all I can think of) doesn't help anyone.

If someone can show me this occurring in a situation other than
that where multiple entries with identical keys are being added
to the hash table, then I'm certainly happy to change this.

But so far every occurrence of EBUSY has turned out to be caused
by the insertion of duplicate keys into the hash table, which
is very much expected, and one where a solution has already been
provided (rhltable).

If this is genuine then it can be easily proved.  Just make the
EBUSY code-path dump the keys in the chain exceeding 16 entries,
plus the hash secret and the total number of entries in the hash
table plus capacity.  It should then be easy to verify.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

