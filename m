Return-Path: <netdev+bounces-201516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90920AE9A74
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DE151C213BB
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 09:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484DB29614F;
	Thu, 26 Jun 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="YC7oo4FO"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39377239E79
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750931604; cv=none; b=cxwHjYUt7Bh+OjeBIuAxY+q4bripVUeRFX5QYb12LAuGuFK+FR/sQZkPs7wGkX1unA0EYN3Oq65irIt12Rc/iuADafewKYuorg2cfRO0FCyh77lkVs4K0OaTX7jP+nMiRWRJmWSV4PHW1CPUtu64aC7h7neRld4PYKUqY4Ap7Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750931604; c=relaxed/simple;
	bh=6xt2LoZ7um35rNritE2Wf/QwH+8ilLcVf1tM7PmYNrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FqUhEcUficyXaAUipt6vln4FDARQjZBrCFsMt6jCiVv4cHrTk+KC0nF9T0T24d2xT5gCRSB0bQnQXtFUtJDMhFGMo6xv0uY5UDUmt0rDjiE37QPJSTp5HZYcfpgLlQ0I5NJg7xHXKpqxR8SrmzAv9TLRUNqCDZ3AxlGnANYa13g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=YC7oo4FO; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=v/q6IdJG8Uymm/aG7hvNeaBvQ6/NVz2xUiJSURPH0ew=; b=YC7oo4FOJnk4o1w/qIJfPvWDfK
	1PWyXJCQutSel9kN1vFJ3s0ajl5M4FLCcwYajNDAE/pL1pABCDbdiOfTftvX0+aZ1XUw5PvGi6dmp
	wF6B1xeVnQcVYp1delMvT9SsCv/P7RTGwDPYI71AxUgt9DS2j/GPq4LfSdJBEHzvDkB03K30OCB+J
	G32znKSZ37xyXWGG5DkuFtXrVHFGLR3/hQ3dXnex/BL2lDmMCAvlnPJqOFDOZp2nnJisQsZI3HUhY
	sh+rMoLxU3KiqD2vMxqaOof5UhibvIHCG9+uJ1GAsQQaF64V9Gpl3oLzId1RboUuR5Ecoome4B7Qc
	F/tRDXhQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uUj2d-001A8z-0S;
	Thu, 26 Jun 2025 17:53:08 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 26 Jun 2025 17:53:07 +0800
Date: Thu, 26 Jun 2025 17:53:07 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Aakash Kumar S <saakashkumar@marvell.com>
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, akamaluddin@marvell.com,
	antony@phenome.org
Subject: Re: [PATCH] xfrm: Duplicate SPI Handling
Message-ID: <aF0Yg4CMeG3y74gh@gondor.apana.org.au>
References: <20250624181054.1502835-1-saakashkumar@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624181054.1502835-1-saakashkumar@marvell.com>

On Tue, Jun 24, 2025 at 11:40:54PM +0530, Aakash Kumar S wrote:
> The issue originates when Strongswan initiates an XFRM_MSG_ALLOCSPI
> Netlink message, which triggers the kernel function xfrm_alloc_spi().
> This function is expected to ensure uniqueness of the Security Parameter
> Index (SPI) for inbound Security Associations (SAs). However, it can
> return success even when the requested SPI is already in use, leading
> to duplicate SPIs assigned to multiple inbound SAs, differentiated
> only by their destination addresses.
> 
> This behavior causes inconsistencies during SPI lookups for inbound packets.
> Since the lookup may return an arbitrary SA among those with the same SPI,
> packet processing can fail, resulting in packet drops.
> 
> According to RFC 4301 section 4.4.2 , for inbound processing a unicast SA
> is uniquely identified by the SPI and optionally protocol.
> 
> Reproducing the Issue Reliably:
> To consistently reproduce the problem, restrict the available SPI range in
> charon.conf : spi_min = 0x10000000 spi_max = 0x10000002
> This limits the system to only 2 usable SPI values.
> Next, create more than 2 Child SA. each using unique pair of src/dst address.
> As soon as the 3rd Child SA is initiated, it will be assigned a duplicate
> SPI, since the SPI pool is already exhausted.
> With a narrow SPI range, the issue is consistently reproducible.
> With a broader/default range, it becomes rare and unpredictable.
> 
> Current implementation:
> xfrm_spi_hash() lookup function computes hash using daddr, proto, and family.
> So if two SAs have the same SPI but different destination addresses, then
> they will:
> a. Hash into different buckets
> b. Be stored in different linked lists (byspi + h)
> c. Not be seen in the same hlist_for_each_entry_rcu() iteration.
> As a result, the lookup will result in NULL and kernel allows that Duplicate SPI
> 
> Proposed Change:
> xfrm_state_lookup_spi_proto() does a truly global search - across all states,
> regardless of hash bucket and matches SPI and proto.
> 
> Signed-off-by: Aakash Kumar S <saakashkumar@marvell.com>
> ---
>  net/xfrm/xfrm_state.c | 78 ++++++++++++++++++++++++++-----------------
>  1 file changed, 47 insertions(+), 31 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

