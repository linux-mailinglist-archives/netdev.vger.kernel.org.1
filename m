Return-Path: <netdev+bounces-146932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1FAF9D6C8A
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 04:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D1028138D
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 03:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C7C1E53A;
	Sun, 24 Nov 2024 03:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="S2ntX+mY"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DB92C80
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 03:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732418193; cv=none; b=SZ2hFzk23dQKT64x8EEatUIHQc1+roGrIZM45u4r32Nid9a2HESt7KHkBrlZP8R0gQzpxotL/L6zFUdhh2FwwHqQumPE5v8Pa564xUlfeAleXAA4clHN+5UZchh26W/mMXEUD49TZv1bvjasTfy6ppH3NADtgm+UZQmuWatkcHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732418193; c=relaxed/simple;
	bh=A16WUpJ6Z78K1pmiFJF3jZUrvnNKAeZIzwsD+SMXhvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSTJQ05Au1AF0d6qLU09OZ+rpYONvY0BK0rQtXmRT8H65LrJwselX3DyUSCNWyCRLBBrS7ZBs5C/RtIlLXQSjN5m+kD2C3YvoN1y5UA/o6Qo54+bLctxzg9bfhAsvonL4Kto1V8xpWKGsCbonj9YV94jrsHqzVjmqAQ4I6aj8uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=S2ntX+mY; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=41ezGZ81i8JhGWwdlU03SBndHTWaq6qcxpqr9rMyCNU=; b=S2ntX+mYYGDIjTDVlSo7M/PTah
	yBR3TiJh1nUpbtWO2A4c9pIU15yyfhztgrdGsZzIcCmO/Zs6FBKbo1EyhbKfNlBXgsmS9ZpdWAueJ
	csgwVw8yZqX44Jtef7k7RzMDd/mPyn3M42x6I6IfLBYMNKqij4woVYIceKDWR3X1jBQFRoDdxY2r4
	n79v9hwD5bKxrYDS38aSc2BrxLCrccJ+8ucHa/8kLzNa/VBt1ZLeYW1WhxI/SavHE35iR9hyQ9N1Y
	qO72gqudXynfJM5wAhE2NxdZivhJepGcsL18RM+3TilVxAnErLdnVmZIwz8r2kGPQq+shbDRlbj9m
	LBoS7d3g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tF36Z-001FSp-30;
	Sun, 24 Nov 2024 11:16:13 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 24 Nov 2024 11:16:11 +0800
Date: Sun, 24 Nov 2024 11:16:11 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
	Neil Brown <neilb@suse.de>
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <Z0KaexOJM1phuJKS@gondor.apana.org.au>
References: <i3vf5e63aqbfvoywuftt7h3qd4abdzomdeuvp3ygmzgza4xjdt@qx36kyyxxkfi>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <i3vf5e63aqbfvoywuftt7h3qd4abdzomdeuvp3ygmzgza4xjdt@qx36kyyxxkfi>

On Sat, Nov 23, 2024 at 12:21:21PM -0500, Kent Overstreet wrote:
> I'm seeing an issue where rhashtable inserts sporadically return -EBUSY,
> thrown from rhashtable_insert_rehash() when there's already a rehash in
> progress, i.e. rehashes aren't keeping up.

EBUSY should never happen *if* you're using the hash table correctly.
It is expected to happen if you insert multiple identical entries
into the same hash table (the correct thing to do in that case is
to use rhltable which is designed to accomodate multiple entries
with the same key).

Now assuming that is not the case and you are using rhashtable
correctly, this is when an EBUSY will occur during an insert:

1) The hash table elasticity has been violated, meaning that
more than 16 entries are in a single chain.

2) The hash table is below 50% capacity (meaning that statistically
we do not expect 1) to be true).

3) An existing rehash is already taking place.

The reason we have the EBUSY mechanism in place is to prevent
the case where we are being actively attacked by a hostile
actor, who has somehow compromised our hash function.

The first line of defence is to change our hash function and
conduct a rehash.  This is what would have occured if 3) is
false.

Once a rehash is in place, if we hit 1) + 2) again, then it
means that our defence was futile and the hostile actor is
still able to create arbitrarily long hash chains (possibly
by compromising our RNG since we use that for the rehash),
and as we do not have any defence mechanism for that, it is
better to just fail.

Of course this is meant to be impossible to hit in practice.
Whenever it has occurred in the past, it's always been because
people were tring to insert identical keyed entries into the
same table (Use rhltable instead).

Theoretically it is also possible to hit this if your hash
table was immense (expected worst-case hash chain length is
log N / log log N), but it has never been hit in the past
with our default elasticity of 16.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

