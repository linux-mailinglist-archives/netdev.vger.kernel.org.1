Return-Path: <netdev+bounces-146744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B179D561F
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 00:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8895A283ED7
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 23:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8C21DDA32;
	Thu, 21 Nov 2024 23:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="LdRl9LHr"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D6F19F410;
	Thu, 21 Nov 2024 23:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732231165; cv=none; b=PXcTwu8iE8l5METy+eoLjSby38LFgSOOhWWTq+VddwQ2jrFnux4Fbl4sJ2aaLUZ7vDiGIFuEQ4f45wKMU0lZY0Hx6Y8yMWTgv2W2txK6+HMllcOrIRF8WT4+DuqCona2KqBklVoDVGaiB2lHs2BRfvYq5d3Ap0DSiJ7l0A8uhos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732231165; c=relaxed/simple;
	bh=lypCQLHdxHaBu432IbmR6/kD0jI5ZG968AuxFBOBcFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2A/7VlXO8pCQJFCnanQPBgb56EDp7IdQtx63Jjri/zccjX5SkUNgXknmP5nhD2GyFRn8oyyTTwEEmPoXGrxxwuYjw9SO32RMOIgg5hHk0GyI0EoWB8oK6VWzK86g1Qt7yWw0kcfip8MdIOL1jg21a+md+mvYPSl6J6QJJL9IZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=LdRl9LHr; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=96KNAgEZKYTBkhwHVr8dFUlI4/ybeiMP1elBVeu9dx4=; b=LdRl9LHrohGG6tMagH5yftvd5t
	lrNDEZNhszNp9qPHUxY76/gc3mi8rrgoqs21Sqb1/6tv7nnTbkSphe3wbSWiThQ8VQc+sQ7zStUAl
	K1zED3UAWiLARfGkJVlumGM4GV5oZaJk3S9U7Hw3WOGImCf8Q5mV5KwKQhneHnMxR5JwESWE9jZ+b
	OYO7393QsXfOPJ5tzbhDjd1r3rsbvmoaiCby3ti/f/hlx69tSZCPh0abzW4SWMBuUgCGdqVjV7Cv3
	ZVoRleybl0/CrP1jouCzxS0uFBx+sw1+68VDSuh8jrPEPieC6PQUcb0lFh0oSISlDc7A04hB1PBgg
	QaFu3I7A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tEGRj-000qOI-1b;
	Fri, 22 Nov 2024 07:18:48 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Nov 2024 07:18:47 +0800
Date: Fri, 22 Nov 2024 07:18:47 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michal Kubiak <michal.kubiak@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net] netpoll: Use rtnl_dereference() for npinfo pointer
 access
Message-ID: <Zz-_15xseWSPHLqg@gondor.apana.org.au>
References: <20241121-netpoll_rcu_herbet_fix-v1-1-457c5fee9dfd@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121-netpoll_rcu_herbet_fix-v1-1-457c5fee9dfd@debian.org>

On Thu, Nov 21, 2024 at 06:58:58AM -0800, Breno Leitao wrote:
> In the __netpoll_setup() function, when accessing the device's npinfo
> pointer, replace rcu_access_pointer() with rtnl_dereference(). This
> change is more appropriate, as suggested by Herbert Xu.
> 
> The function is called with the RTNL mutex held, and the pointer is
> being dereferenced later, so, dereference earlier and just reuse the
> pointer for the if/else.
> 
> The replacement ensures correct pointer access while maintaining
> the existing locking and RCU semantics of the netpoll subsystem.
> 
> Fixes: c75964e40e69 ("netpoll: Use rtnl_dereference() for npinfo pointer access")
> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/core/netpoll.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

