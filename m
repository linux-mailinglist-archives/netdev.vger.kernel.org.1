Return-Path: <netdev+bounces-105816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E4D191305F
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 00:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD534B26AEC
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 22:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9259516E872;
	Fri, 21 Jun 2024 22:36:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from norbury.hmeau.com (helcar.hmeau.com [216.24.177.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670C208C4;
	Fri, 21 Jun 2024 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.24.177.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719009392; cv=none; b=HxLZ1RohlEW49LIgY0aIOGnYFkQSlEcswEi7yk9//AvI6YJ4RUld6O4ej14d6sAkFofpyUMCXT6QfvMIsXefkKsEHa+qpzX7jNz11MqhPVtOlB+sPPt154UYhQpmxV3sMCyLHmBM1BXgIQjpGajlb/CENK1LVhq5U1nADh9Mqwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719009392; c=relaxed/simple;
	bh=9JkM/dcM2JYYr7ezKHy6/xOt0tnRt1I9sK4BeYdaC1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SPt7t3zNaUt91+SC3sHYjF7S8MTe0iTBC2hwQB0NXZFV0httMNXF2ir8zSepyDJyDSB58rR6orr4PaTKUiYNRX0UwJ/parwYyWB8lTdRJKCllR0eSPXs2jQeSeQ3YRbkC4jRxutRyhrECvg/ymr7/CO2YM4J9lJNI3h1Pts6b3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=216.24.177.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by norbury.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sKmrB-002lkq-2l;
	Sat, 22 Jun 2024 08:35:46 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 22 Jun 2024 08:35:46 +1000
Date: Sat, 22 Jun 2024 08:35:46 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Yabin Cui <yabinc@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] Fix initializing a static union variable
Message-ID: <ZnYAQhNjVEvFlkdY@gondor.apana.org.au>
References: <20240621211819.1690234-1-yabinc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621211819.1690234-1-yabinc@google.com>

On Fri, Jun 21, 2024 at 02:18:19PM -0700, Yabin Cui wrote:
> saddr_wildcard is a static union variable initialized with {}.
> 
> Empty brace initialization of union types is unspecified prior to C23,
> and even in C23, it doesn't guarantee zero initialization of all fields
> (see sections 4.5 and 6.2 in
> https://www.open-std.org/jtc1/sc22/wg14/www/docs/n2900.htm).

What about all the other places in the kernel that use the same
idiom? A grep shows that there are more than a hundred spots in
the kernel where {} is used to initialise a union.

$ git grep '=[[:blank:]]*{}' | grep union | wc -l
123
$

Also what if the union is embedded into a struct.  Does it get
initialised fully or not? If not then you've got over 5000 {}
initialisations to work through.

$ git grep '=[[:blank:]]*{}' | wc -l
5102
$

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

