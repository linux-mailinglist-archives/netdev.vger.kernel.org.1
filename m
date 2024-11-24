Return-Path: <netdev+bounces-147115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1759D791E
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:21:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FC52281FB7
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 23:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3755A183CC2;
	Sun, 24 Nov 2024 23:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="OdBrT1K8"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201611632F1
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 23:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732490471; cv=none; b=Idu/i4343aPcBeIZdORM/JYx23kkiIFovTaMyz4xlxuSCMSzU6nWcfVEFRVrLWN6EcdSyse9f5FigKyj2yF9zNbU/gyUXuJmc/306PVLUJLN07Tc68C+gLeANEVLej7PRyqVUkZTi8QdaJvBQOOCwiDSEIT4hrmomPQi3ZodOZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732490471; c=relaxed/simple;
	bh=g8Gg7KoC1668g0Cc44xWKwYM/GErM+FSvWy4zaSlyXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ubpcmqrq8+nV5ABawRFzDocihxD4KeABkWGx+4MTuZzKf9fLvoLKegleJHxGntywWJBrC5yea+v6EgPGcgAQdyYF1djzsHj+Ps6Q0ASz+w51xFWR2A9W9q6YdwQvG2jCMtW6gXZVrlfQPmMKRnVczwLQjGstS7G2Won2+QEIcwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=OdBrT1K8; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7b3zEdAzBT9slW1FPib2Z5UTZBOCkOV5sUgpgXgSgRg=; b=OdBrT1K8LHsJhtLVZoKAStoglT
	YVr88yTPKuYqspoeC0AF99xNVycKXyBJQgSkmRRnHLN+x3dEmvSUSBJredpAXjG9jmGA+Kohp2Oxj
	vA3U9AYAH09mych9q6M+8mg5DB8ZvpKRhN4/cHLCaXbbxE3bP/IF3G/RMvXFTVV7Gxw8rW6o9dGkn
	s1TiDkaYV6z8yPwbgkegel2ys7RN/NHF+gkDDn+x0pas+trc2wDq8P/20eNSVoA4yHNOqIjyURqVl
	HH0/znO+6ujtWBBUPo25f2IRDrbKYLlY0FeTUkZCGoy5BBHN5NKPNl5slNfoV5Kj2mRUysWCF8DPe
	vrJcc2fA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tFLuS-001QUM-1E;
	Mon, 25 Nov 2024 07:20:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 25 Nov 2024 07:20:56 +0800
Date: Mon, 25 Nov 2024 07:20:56 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: NeilBrown <neilb@suse.de>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Thomas Graf <tgraf@suug.ch>, netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <Z0O02AvPs664hJAa@gondor.apana.org.au>
References: <>
 <Z0L8LQeZwtvhJ2Ft@gondor.apana.org.au>
 <173248978347.1734440.11538643613787576556@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173248978347.1734440.11538643613787576556@noble.neil.brown.name>

On Mon, Nov 25, 2024 at 10:09:43AM +1100, NeilBrown wrote:
>
> When writing code I don't only want to guard against problems that I can
> reproduce.  I want to guard against any problem that is theoretically
> possible.   Unless you can explain why -EBUSY is not possible, I have to
> write code to handle it.

I just explained to you that it's extremely unlikely (e.g., less
than the chance of a cosmic ray flipping your DRAM) for you to get
EBUSY.

Not only do you have to have an extremely long hash chain (> 16)
to get EBUSY, you also need to have a hash table that is less than
75% full, and that there is an outstanding rehash on the table.

Admittedly the last condition is a bit loose right now because it
also includes routine rehashes such as growing/shrinking and I will
fix that up.

So there is no reason why you should handle EBUSY, it chould be
turned into a WARN_ON_ONCE.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

