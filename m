Return-Path: <netdev+bounces-105680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EB39123BC
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:33:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B7341F2635B
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D893F175543;
	Fri, 21 Jun 2024 11:32:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from norbury.hmeau.com (helcar.hmeau.com [216.24.177.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8B0173321;
	Fri, 21 Jun 2024 11:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.24.177.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969530; cv=none; b=H3ypqoBBsT/H/TNrSrd2tFvE/A+HuNB2J6mME8vMf5oHDR3w79Lz8910m7pjh5hAYgKZeS7Q0DkteC73LTxqACIBpJL8kJXA4AABk3US1I5sojoH4pixEu2jEwbcKnfbBxUIByvndok2yOs7dOAzDI4HePjdU0YzPMM4xcsvx4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969530; c=relaxed/simple;
	bh=IFn0xI/FU94BtSpvj/fHU7p0Jdyham+E3Hxv3IwEHok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iq93ZV6UjA6z4HoNSpugRG0X2ll58wST1DNIwSLHIMkXRjMd5QCw+jbWYGfh382fSLdSoXVtKI6PhHGESJMCjhoUiZXg3Okin7JiYMRR56qLzVhAjYFw0QxjENSwyqkjmENFiYijK4iCt3O1ILziizLyhd045C+ZN1mw+O+C9mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=216.24.177.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
	by norbury.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sKc6u-002dUc-26;
	Fri, 21 Jun 2024 21:07:17 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Jun 2024 21:07:16 +1000
Date: Fri, 21 Jun 2024 21:07:16 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Nick Desaulniers <ndesaulniers@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Cc: Yabin Cui <yabinc@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] Fix initializing a static union variable
Message-ID: <ZnVe5JBIBGoOrk5w@gondor.apana.org.au>
References: <20240620181736.1270455-1-yabinc@google.com>
 <CAKwvOd=ZKS9LbJExCp8vrV9kLDE_Ew+mRcFH5-sYRW_2=sBiig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=ZKS9LbJExCp8vrV9kLDE_Ew+mRcFH5-sYRW_2=sBiig@mail.gmail.com>

On Thu, Jun 20, 2024 at 12:31:46PM -0700, Nick Desaulniers wrote:
>
> Can you also please (find or) file a bug against clang about this? A
> compiler diagnostic would be very very helpful here, since `= {};` is
> such a common idiom.

This idiom is used throughout the kernel.  If we decide that it
isn't safe to use then we should change the kernel as a whole rather
than the one spot that happens to have been identified.

Alternatively the buggy compiler should be banned until it's fixed.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

