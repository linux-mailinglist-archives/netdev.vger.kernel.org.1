Return-Path: <netdev+bounces-86973-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A398A133F
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 13:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6061C20F5F
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 11:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71041149C46;
	Thu, 11 Apr 2024 11:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1zSjNBV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4581487E4
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 11:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835697; cv=none; b=F5iuu0QZ0izM90i98oEQ6V8q9W9DtcwedbQedbWxKoeo5xp2Cs77jeG0t4lYc/2I/eAk0ym3l/y03aZRm7bjdPDaktjQXtMgJXdTyYWMMYrcS3YwxyxFZnBK3vD8hUxt4b2gAh1RElCU1lz+hOEJDB083Dv0eqNTi7TMRk2kCIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835697; c=relaxed/simple;
	bh=53a90e5Qmt0Zp2T40BfQnYP6dAc7ADyIAlcLVAxAsUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GOSmE53pq8dyjrQOL3WQtpPA3ZsqAgpO3g0h1BSs2c0PInhmEJtvLhjSGhg4aIymNeVRaRFgoDXwZW8gJOyxKPj7NqkV9Uxzh36PYLcMGrBbgOjnl7SnIxQ+g0VYs69CwHB610+mG5yCRJ9nVzUuzRITQy7LZ+SuSqQvJovopWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1zSjNBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50966C433C7;
	Thu, 11 Apr 2024 11:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712835696;
	bh=53a90e5Qmt0Zp2T40BfQnYP6dAc7ADyIAlcLVAxAsUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K1zSjNBVVIFQkkg+cETOdIkQ4gWzi+oYd1McNdXAJfeVe/GpiuU7Zm8hjC6uZYf+Q
	 AYFHktgUTqHRUqS0BtMtp04nX50zJK7smvRDuo5rsrfPzmRSeDZzF5p6ah9+lCpgGU
	 boivveYmDD/50qusGXPBXKiOPXUGWyg3HC4GF07pWGw52Z4KklMYi3BazolGzjPsGN
	 PCdIvyh30NooB87Gbhk56OlyTTwQ4hNLQoHjNnFFPe/kuRIZffE5Lq/jnvt3TLpVvH
	 eyBFHcYdY0id9NWnUxWUEDiN0YTRZvHRn0pBEngbwegCq3Ug4wznw2yxH2+johJMus
	 orV3VOsImU3FA==
Date: Thu, 11 Apr 2024 14:41:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	devel@linux-ipsec.org, Eyal Birger <eyal.birger@gmail.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Sabrina Dubroca <sd@queasysnail.net>
Subject: Re: [PATCH ipsec-next v10 1/3] xfrm: Add Direction to the SA in or
 out
Message-ID: <20240411114132.GO4195@unreal>
References: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e0d997e634261fcdf16cf9f07c97d97af7370b6.1712828282.git.antony.antony@secunet.com>

On Thu, Apr 11, 2024 at 11:40:59AM +0200, Antony Antony wrote:
> This patch introduces the 'dir' attribute, 'in' or 'out', to the
> xfrm_state, SA, enhancing usability by delineating the scope of values
> based on direction. An input SA will now exclusively encompass values
> pertinent to input, effectively segregating them from output-related
> values. This change aims to streamline the configuration process and
> improve the overall clarity of SA attributes.
> 
> This feature sets the groundwork for future patches, including
> the upcoming IP-TFS patch.
> 
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> ---
> v9->v10:
>  - add more direction specific validations
> 	XFRM_STATE_NOPMTUDISC, XFRM_SA_XFLAG_DONT_ENCAP_DSCP
> 	XFRMA_MTIMER_THRESH
>  - refactor validations into a fuction.
>  - add dir to ALLOCSPI to support strongSwan updating SPI for "in" state
> v8->v9:
>  - add validation XFRM_STATE_ICMP not allowed on OUT SA.
> 
> v7->v8:
>  - add extra validation check on replay window and seq
>  - XFRM_MSG_UPDSA old and new SA should match "dir"

I asked it on one of the previous versions, but why do we need this limitation?
Update SA is actually add and delete, so if user wants to update
direction, it should be allowed.

Thanks

