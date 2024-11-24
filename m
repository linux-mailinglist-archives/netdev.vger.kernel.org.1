Return-Path: <netdev+bounces-146935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 291409D6CC8
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 07:24:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9F0C1617CA
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 06:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B77938DE5;
	Sun, 24 Nov 2024 06:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="YN/GfTVJ"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A711D8837
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 06:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732429447; cv=none; b=d519vYPFTwfrTglVgsO+VrC9I4hHmjsxahacok6OHKfaf3GdldKVvkiS7gVGDZ7Uw90QUfhhNapDWbQBSrunraft6tL8W5LXKNZXNjK32x2pmf63elljU8jsJ5Xi+xJRhqizfpx5dHXOE6/8KlLQNWxijthl1/nUubYz/1iINKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732429447; c=relaxed/simple;
	bh=zsijepgLl1giBVIER08R8TeqEr54rs2ff9phquU81Q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aY4FSMq+CWkFZ+Q7HbqYqjl2jyNFq3vqL/OiiTYkYUOFu1diMNjRZNik2iTdoAnpZXwR7J9cmgIiC5VHO9DiCTPzV6pTCrsRH+GsZzi09mzSch/uiYRFWooe5Nu3bSdxsaguzF7MiyH/l/urmBGbMk8V/Ab02pj+1yb570Kt8a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=YN/GfTVJ; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Rb2nPv6awpcmvRRpDjXI4vlv3rrhYl8bviyqlbHlFUg=; b=YN/GfTVJNKHcHUsfW8WLcTg2hG
	ZyYzjaHCt6mx39fcCQ/CJyaMb8N5XrOw0pghAIGfHUxbl4jQ1gJwiCAFL/se+OEMdzANLmRIkhyNz
	QgFRddcUAkcFhmIduN28R8KAaQHpGfqsUPJITruHfNrtRVMVnpWsaa5MV+tj21tNGQQ8YbV41UyIK
	GBc+ytuvNBDIsICEv3pkCYJmvIzfdq4a+TNoJGeenwO6lRxJJyOcFBMLelXzgA4lD1QVIL0DbXdeS
	gkwiHII5LwBsbJXH5nC/1xNhbDvlYoAMT6XaVLBuDvc2IfHzVmPSoZRfzkfoIfdOBnu/GuV0c2nyX
	odit6udA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tF62F-001GNC-1D;
	Sun, 24 Nov 2024 14:23:56 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 24 Nov 2024 14:23:55 +0800
Date: Sun, 24 Nov 2024 14:23:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org,
	Neil Brown <neilb@suse.de>
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <Z0LGe85TyhHrFICR@gondor.apana.org.au>
References: <i3vf5e63aqbfvoywuftt7h3qd4abdzomdeuvp3ygmzgza4xjdt@qx36kyyxxkfi>
 <Z0KaexOJM1phuJKS@gondor.apana.org.au>
 <3a2uv6dsl3xqw2bpeob7tq6e52ezjrpuvcqqvttb5goltdzpsd@dsj6fxwqi32g>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a2uv6dsl3xqw2bpeob7tq6e52ezjrpuvcqqvttb5goltdzpsd@dsj6fxwqi32g>

On Sat, Nov 23, 2024 at 10:30:46PM -0500, Kent Overstreet wrote:
>
> Well, reading the code that would appear to be -EEXIST, that's entirely
> separate from the path you describe below.

I don't think I explained myself properly.  I'm not talking
about inserting the same pointer/object into the rhashtable,
but two different pointer/objects that have identical keys.

IOW they will always hash to the same value regardless of how
you tweak the hash function.  This is not allowed with rhashtable
and will lead to exactly what you're seeing.  If you need to
do this, then you should use rhltable.

> With the default hash function (jhash), I suspect this isn't so
> impossible as you think - I had issues with jhash when doing cuckoo
> hashing, and I had to switch to siphash there....

Unless you have a hashtable that is terabytes in size, I really
doubt this is what you're seeing.

But do prove me wrong please, just add some debug code that stops
the whole machine when this happens and then dumps out the hash
table keys + hashes in the chain that exceeds 16 while the whole
table is less than 75% full.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

