Return-Path: <netdev+bounces-193362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 046F0AC39D9
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE91E7A170D
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 06:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198141D5CFB;
	Mon, 26 May 2025 06:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="mK/QDqi7"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930F31C3C18
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 06:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748240904; cv=none; b=HqsMi9STLwYcWMS1o0O3ykdenMzDWJ3TiF2U0lTH0FKOHonLD0ompJnu/dfw0J18/ExrxP95wVJptF8hamUBZs+LxJ7XMihfCGCmSSTUjDmwYCfBk7Aaf7oi9+PiXLxcrb1f9c8ov+KTq1UwMkMcaZ+2zp1P1TVq8iScWXe7egI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748240904; c=relaxed/simple;
	bh=0fEu2ww12B0cIwpXsUsdj4Q/dIfImQT955vEb70tZjc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trfR5CCaHjPJOtb9EaxuHi6wkEaK3b2tbQngJW1yY2xd5lDmWAjqhGu0//Z30wRDvEo8tz1ZOx6sbtMB5OnN3c6zRkStxlpmfZo+2IwCBdmtuqbSSsmiG4Rn0IVlUKaLBLKtpqzIR8QhCQempwvAC3jtgsyZqMZe4wck8lV+Q28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=mK/QDqi7; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 63FD02074F;
	Mon, 26 May 2025 08:28:12 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BphE7bhS4Qvg; Mon, 26 May 2025 08:28:11 +0200 (CEST)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id C83B8204D9;
	Mon, 26 May 2025 08:28:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com C83B8204D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1748240891;
	bh=6pZuzxL9PWxTEEOR/RvRN+eaUxydotYWWBCu+Lm5yCY=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=mK/QDqi75ygadtjhqvts1bRv8WRVbzKJisEPn6X1V2RTXIKXeWlGOhyHiOqAS3Bdt
	 IXIrsOQfFZO68j6y7XbJ+BP2PyyLd27p6NjO9A4rRk1xYHK/Zp5259aGRVh2IpdLqt
	 8FtRtp4qHIMSIz/TvUC47W1NI+HSeeGYefdNAgK8UNpKQb0jHYSd8SReUSHd0/QYZ2
	 Dhh4hxEYFoHSxrXQc5tzAAwJH3yNlJLIDGhYrm5EnTki/57VhA5Hejo2F1rkLe5E4Z
	 tCQJGvwTb8DZ4pklKm0VWOYkOcLR92h2o1Srx9k91e367oDgPJmLUNmOy2hKKXLUq7
	 1LaAif4JX0/Xw==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 26 May 2025 08:28:11 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 May
 2025 08:28:11 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 97BC6318174D; Mon, 26 May 2025 08:28:10 +0200 (CEST)
Date: Mon, 26 May 2025 08:28:10 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: <netdev@vger.kernel.org>, Antony Antony <antony.antony@secunet.com>,
	Tobias Brunner <tobias@strongswan.org>, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH ipsec 2/2] xfrm: state: use a consistent pcpu_id in
 xfrm_state_find
Message-ID: <aDQJ+kt5c0trlfo5@gauss3.secunet.de>
References: <cover.1748001837.git.sd@queasysnail.net>
 <6d0dd032450372755c629a68e6999c3b317c0188.1748001837.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6d0dd032450372755c629a68e6999c3b317c0188.1748001837.git.sd@queasysnail.net>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Fri, May 23, 2025 at 05:11:18PM +0200, Sabrina Dubroca wrote:
> If we get preempted during xfrm_state_find, we could run
> xfrm_state_look_at using a different pcpu_id than the one
> xfrm_state_find saw. This could lead to ignoring states that should
> have matched, and triggering acquires on a CPU that already has a pcpu
> state.
> 
>     xfrm_state_find starts on CPU1
>     pcpu_id = 1
>     lookup starts
>     <preemption, we're now on CPU2>
>     xfrm_state_look_at pcpu_id = 2
>        finds a state
> found:
>     best->pcpu_num != pcpu_id (2 != 1)
>     if (!x && !error && !acquire_in_progress) {
>         ...
>         xfrm_state_alloc
>         xfrm_init_tempstate
>         ...
> 
> This can be avoided by passing the original pcpu_id down to all
> xfrm_state_look_at() calls.
> 
> Also switch to raw_smp_processor_id, disabling preempting just to
> re-enable it immediately doesn't really make sense.
> 
> Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> ---
>  net/xfrm/xfrm_state.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index ff6813ecc6df..3dc78ef2bf7d 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1307,14 +1307,8 @@ static void xfrm_hash_grow_check(struct net *net, int have_hash_collision)
>  static void xfrm_state_look_at(struct xfrm_policy *pol, struct xfrm_state *x,
>  			       const struct flowi *fl, unsigned short family,
>  			       struct xfrm_state **best, int *acq_in_progress,
> -			       int *error)
> +			       int *error, unsigned int pcpu_id)
>  {
> -	/* We need the cpu id just as a lookup key,
> -	 * we don't require it to be stable.
> -	 */
> -	unsigned int pcpu_id = get_cpu();
> -	put_cpu();
> -
>  	/* Resolution logic:
>  	 * 1. There is a valid state with matching selector. Done.
>  	 * 2. Valid state with inappropriate selector. Skip.
> @@ -1381,8 +1375,7 @@ xfrm_state_find(const xfrm_address_t *daddr, const xfrm_address_t *saddr,
>  	/* We need the cpu id just as a lookup key,
>  	 * we don't require it to be stable.
>  	 */
> -	pcpu_id = get_cpu();
> -	put_cpu();
> +	pcpu_id = raw_smp_processor_id();

This codepath can be taken from the forwarding path with preemtion
disabled. raw_smp_processor_id will trigger a warning in that case,
maybe better to use raw_cpu_ptr?

Thanks!

