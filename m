Return-Path: <netdev+bounces-228207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BF8BC4B98
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 14:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 372A23AD823
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 12:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68CE729B8D0;
	Wed,  8 Oct 2025 12:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="TDMFBW9j"
X-Original-To: netdev@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D884A2F7AD0
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759925655; cv=none; b=UQlz3Jm3zsVikwSmQKwysxTBGFgzQt5X2LoNNBojVqV+Vljoyzl/o0s5bvdYUjgXf+rg45iMvcQ9CuzSajgmhMbdzLM2LTa2GnN8vP85j56moU10z02Vwe3BrA+sEb+/NN+w6gc0ZCaasHuDKUdH9n4Bsn5x+KbQ4XYt6zng+28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759925655; c=relaxed/simple;
	bh=/FJgVIhyEdN2o1Z6gxhSpN/SUCrOw+mDyn0/IXLBcvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sgbdEk51IVxDUHmSOlZFH52lh0+Xol2o1KUKVs8ycJjFfziIUgafvtN0TObO6whTJ0qkyn4Yuf0etN+lu5lqZ3wSTYrR7k+oH/pOLFe4RFBMp6uAopK8N5H+aYzSsBFPbqx6F1WhVPC4cUDeflvlGNAk/xycUcsqCDHdHaRfQfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=TDMFBW9j; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-102-192.bstnma.fios.verizon.net [173.48.102.192])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 598CDGF0026282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 08:13:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1759925615; bh=kwti+J23zAyIXFnhzpTdkk/4xOFi3nZKWO5T9JLhw6Q=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=TDMFBW9jTsNS5yFyaJQgzdFDDay8k+jhDgMmVCLoZBppHe68wgRLt1068J6N/+wi/
	 UhbE3Lwg3GJkFk0dOxpHTrojoyofUYgS2mnBufSQJbeb9oEmqnl2oZh7kLR//Mnphg
	 FvZbpMSqQ3foGKPVSccMCwejQLYSZ7JxEnPbZMG3RI5zyQpKKf1EAXMIEl5NJFI6O6
	 EIkj7qIoZdEVOiLK/7qifURmYmCs7FAK61n+ENsVDnhVXNZR8ZuHW8hNyy87dzIefu
	 BcoYZQZTfErKqNhJNPJY7X0vWvLAJ9eSNSD8ERP8WUsPEcf810vB3kIiRGJc4ehwAa
	 zLzn3vWM3LKDQ==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 9DFC02E00D9; Wed, 08 Oct 2025 08:13:16 -0400 (EDT)
Date: Wed, 8 Oct 2025 08:13:16 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Simo Sorce <simo@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "nstange@suse.de" <nstange@suse.de>, "Wang, Jay" <wanjay@amazon.com>
Subject: Re: 6.17 crashes in ipv6 code when booted fips=1 [was: [GIT PULL]
 Crypto Update for 6.17]
Message-ID: <20251008121316.GJ386127@mit.edu>
References: <1a71398e-637f-4aa5-b4c6-0d3502a62a0c@kernel.org>
 <f31dbb22-0add-481c-aee0-e337a7731f8e@oracle.com>
 <20251002172310.GC1697@sol>
 <2981dc1d-287f-44fc-9f6f-a9357fb62dbf@oracle.com>
 <CAHk-=wjcXn+uPu8h554YFyZqfkoF=K4+tFFtXHsWNzqftShdbQ@mail.gmail.com>
 <3b1ff093-2578-4186-969a-3c70530e57b7@oracle.com>
 <CAHk-=whzJ1Bcx5Yi5JC57pLsJYuApTwpC=WjNi28GLUv7HPCOQ@mail.gmail.com>
 <e1dc974a-eb36-4090-8d5f-debcb546ccb7@oracle.com>
 <20251006192622.GA1546808@google.com>
 <0acd44b257938b927515034dd3954e2d36fc65ac.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0acd44b257938b927515034dd3954e2d36fc65ac.camel@redhat.com>

On Mon, Oct 06, 2025 at 03:45:46PM -0400, Simo Sorce wrote:
> Note: this may change going forward, but I am confident that as issues
> arise people will propose upstream patches to keep it as close as
> possible within acceptable parameters for upstream behavior.

What I'm curious about is what falls within the acceptable parameters
of *distro* behavior.  If NIST-certified labs really insist that
certifying requires making the kernel completely unsupportable from a
commercial perspective, at what point will *distros* decide to give it
up as a bad idea, or to have a completely different binary kernel
package that only crazy customers would be willing to use?

If there is something beyond hard-disabling CONFIG_CRYPTO_SHA1 which
all distributions could agree with --- what would that set of patches
look like, and would it be evenly vaguely upstream acceptable.  It
could even hidden behind CONFIG_BROKEN.  :-)

						- Ted
						

