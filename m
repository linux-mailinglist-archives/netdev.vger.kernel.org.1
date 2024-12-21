Return-Path: <netdev+bounces-153897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA9FA9F9F66
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 10:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D45C1890F01
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 09:07:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CAF1EC4D1;
	Sat, 21 Dec 2024 09:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="FCtGZvS9"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EDECA5A;
	Sat, 21 Dec 2024 09:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734772039; cv=none; b=bgaLljQcfTp2TqZVQdmNP1V3Gibry8yordy8i/bRb7iTGq2wVKEM+dmaitI5JW2evs0FCrHX/34zz/MyzpRM15uHVCqqcJLIeFCG3U0t6mRhvAEq1fPYbR3MYV2Cvm5fUvBKS0nBQEymNEblzsuAfbOr7lQmX+ioOeQoJeDKIMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734772039; c=relaxed/simple;
	bh=WYH0na+ESOSGPKUfQK2wiYT9UF3AAcwfwCpYokRJ6tA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1Gn0kPt0KxJpbjsmDePSCP4SxJiTXfGnEbrQznc2qX2M3Pn0NM/cBDHQW+vohOnERflSNNQLjsv/oYBBPuBOCFXFlf+hyI5MuCdqR2csQnJgkSHi0gINJMb6/okkExtP/9iCpsdPKIn1Wlgg2D7h8yUVlu7mfxmTcwYxf9bfW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=FCtGZvS9; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SzB6uK94xo5/T0BXO1kM/kvir9oQYumj4tut2grbd/g=; b=FCtGZvS95oZ9iiPLt7x2QryztN
	qviPrHzbNRkP16c1SkkmKT7rW0JzmbZNniA+HmGI7nMzYwpMoAD79Rj7IvU1gQmW1HmAx2VIGsWrS
	0hKtrLYy6TlTmLnmIjif9FIZDmYJfx4j6MCi6K6hgZOBnMIclt0GmS80eAsnndapcgZKzxio8ChRs
	2ViMoV/XCcc0e7oWS91ET0M9Aus8uGND+MIhFVey28/HNlGenpbXGSZYGYiXt6V5stdrBvV/ISl6t
	3i2EihT+zwtVCzw3SGP2ioV4T7FAQwRH7fDt40LCOGEehC0h5IwYUFaDh2yzyqOdXPXHosDCoKSBR
	AMujarEg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tOvEs-002Q20-2S;
	Sat, 21 Dec 2024 17:06:56 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 21 Dec 2024 17:06:55 +0800
Date: Sat, 21 Dec 2024 17:06:55 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>,
	Tejun Heo <tj@kernel.org>, Hao Luo <haoluo@google.com>,
	Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rhashtable: Fix potential deadlock by moving
 schedule_work outside lock
Message-ID: <Z2aFL3dNLYOcmzH3@gondor.apana.org.au>
References: <20241128-scx_lockdep-v1-1-2315b813b36b@debian.org>
 <Z1rYGzEpMub4Fp6i@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1rYGzEpMub4Fp6i@gondor.apana.org.au>

On Thu, Dec 12, 2024 at 08:33:31PM +0800, Herbert Xu wrote:
>
> The growth check should stay with the atomic_inc.  Something like
> this should work:

OK I've applied your patch with the atomic_inc move.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

