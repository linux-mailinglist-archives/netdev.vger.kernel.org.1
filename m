Return-Path: <netdev+bounces-146939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4886F9D6D37
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 10:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEFA1B210F0
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 09:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511AD34545;
	Sun, 24 Nov 2024 09:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="g1YLZP2k"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4CA1F95A
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732440521; cv=none; b=XADmm9yxJSwJ6SFEPgFYBJzdnIhmmYWljkv0XM7TOSH9IsN+Cv34crfueMwpxhf9ydR33SbJz288PzGYm8Zchk42Egg4Wn2KkMYxfewMIdsrlE3MuL7rK2Nwb1R1vyZIIj9N3tSM9UIGKCZn6QCLvoS95mULUHYY+JCgCt+BKsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732440521; c=relaxed/simple;
	bh=ndhNdwQ2HwAEZ1FFE1NZ7eo4ZCMr0awradjsikWWsds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fYy1v71o9y94NkD/WE2vcWdTllPFZf4c95FSsfJVG6tyZsMd+y7NWyq8HOGQQLS/v++ryanxtIXTi4KzjPjn3j1kev9JdFKBlMxZWmyA3M69sc+O6bYij4rNMR/zgle2keLrI1AQ6xpvRbmdekWBWKMJgU4Bz5oKmuRFofjwnYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=g1YLZP2k; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LrYnHePOzUMKbVrRwZ1CerroLzIhLuhEYm6vQunVJHk=; b=g1YLZP2kPulxMRFeh/li4W2h/b
	iRkwgo4+zVFbfftb/FVpGhu9UjuYKhW+7xiTsPL8In3gDOvyQue6NfXmSKybKDXTObIp7ZSx4+im0
	tRM8EjvGnVtCj6ldkXIW4auoqOz5OXBO2pn10L2LCeFqNRjcN42xUiJrlGdiHXhPnal3xDv4JXW0U
	Vjhcml7p4iRmB2kIgfLbOUF0bj9C+YX/83Z0SvEiAw8zxjBK+R1EWGlUnQVtWCqaf3G222m/RuClh
	J2XOwur5aTSOiPvhPNyM8waojPmyZwSJl6KwGBqnPARD09UNSCxtdHmVoQOBi/RVO47pm1jBXWbA3
	V+vtPadg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tF8ui-001HUr-1P;
	Sun, 24 Nov 2024 17:28:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 24 Nov 2024 17:28:20 +0800
Date: Sun, 24 Nov 2024 17:28:20 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <Z0LxtPp1b-jy2Klg@gondor.apana.org.au>
References: <i3vf5e63aqbfvoywuftt7h3qd4abdzomdeuvp3ygmzgza4xjdt@qx36kyyxxkfi>
 <Z0KaexOJM1phuJKS@gondor.apana.org.au>
 <173244033805.1734440.12627345429438896757@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173244033805.1734440.12627345429438896757@noble.neil.brown.name>

On Sun, Nov 24, 2024 at 08:25:38PM +1100, NeilBrown wrote:
>
> Failure should not just be extremely unlikely.  It should be
> mathematically impossible. 

Please define mathematically impossible.  If you mean zero then
it's pointless since modern computers are known to have non-zero
failure rates.

If you have a definite value in mind, then we could certainly
tailor the maximum elasticity to achieve that goal.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

