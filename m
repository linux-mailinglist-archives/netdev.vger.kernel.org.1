Return-Path: <netdev+bounces-119527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D04C956137
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 04:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373301F214B2
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 02:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7068D24B2F;
	Mon, 19 Aug 2024 02:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aL/TXVwa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112AC634
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 02:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724035516; cv=none; b=hDcYy2bBJPRx5TeqGx57M2YbFFabkDtAI0KHSg9IpD6x6cYpadtUapDEnf4kQDdLnYMNQdYple3+rwXaBoM+z4mXR5u0pRlxlRuGcP3v/R/E7qh8i3JPEUpqsaCfKB11nr6q1AGCrtaNKxmj0VOHMLq8O0HyznFTX4pQ7r5IKlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724035516; c=relaxed/simple;
	bh=q68qlHO00MvhqppHvPtFFGmDM6TzCaqbgZs0osVwXCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DdRAkMOzmL1DUHQXYsUEvVZV3WVciNCRru+aatSbf05p/NXabCwqzQQYL+b3j+JYBf2PcsWzlRfd1bgs4Qi8fUbNt61WkNUycinjeAOr2/JzDKzzabsW+2YVQZftfWICTOiat9HBSj3wwoXn1mjBZ5pzhOAnab9fbDFJYqIHjqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aL/TXVwa; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3c08541cdso2811669a91.2
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 19:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724035514; x=1724640314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tv+IlKI5SH4rGxbqjK28SuRhkSc0o+NgcSe+c05OycU=;
        b=aL/TXVwaq8NCRnin7H8Na3BrVQt+DuA5pSlog4MiZ/+baEqOtUkyYNJTb1mdVsmhC9
         NyBqqUaowHdBo8kjW6tAa37X823CFCQisVXZMatft48NUjbUNj+21CAoD1REgdTT3D2t
         SRA95OsbTyBIVTmaziKyaK6m6OfrSBNS0AhAuHDJQaRqCO1GKYaaKj7CyVtlPLIwJveN
         M7KXlEm3mjSKKJ29ME1h7O++83/36X0KGepUm56MHjuGpsFRDjmo2B2TXEu16FhYyvZZ
         EL+5Hn9B1LXsgHTojzDMwkdNkBQGhwRBQpjpM2ZQroidPqkOo7x9zXKg6jttClqO/wra
         gkWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724035514; x=1724640314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tv+IlKI5SH4rGxbqjK28SuRhkSc0o+NgcSe+c05OycU=;
        b=klFCUqRlsZwhO+jfSPFUMUBiCN5gho+Mc99idREEHveE1JcXvYSs9XmuurhThu8A4P
         hobg7J2rM3ghUN6fWKYBOpATKMXFcXmEHcRug2R4veCih+NBbYFB799tdc5R6GAkRtT0
         6qgNsAo9ACQL6QesP8vtY5L03lOF1Q0ONi9L3VZfcGthKPMRB8d8+zA5FauZY5OYlBdp
         ukQ7BLMpx1Hz/vkkCaGYRTbGqK5UzYDYyR5VcCmprz4Dt5ddIi39VMh1WACKgLget2IN
         nuw5hkr5KzMCMO8kN+ch5wT30ySPOeOJiBZG75rwRDnd0JI8TPBh00tKjLamOiNMxRfe
         j1Fg==
X-Gm-Message-State: AOJu0YwwLPgn//UCqUkC5c95fZa+cHguHfxPfSAIzIWSrPa7EJi4ALEE
	gJhF6fR0n6gXFJ+nnfX/mEqXrwPkluIZsciyOMcn6XNU00Mf5D0p
X-Google-Smtp-Source: AGHT+IE0gDVlOZmI5Lkt+X3ZGL1hVU2VoD/UI3l88LaC/o0Bm4cmua3WEUoYPJSgK/wZQ15bZx772A==
X-Received: by 2002:a17:90b:3596:b0:2d3:cc16:826f with SMTP id 98e67ed59e1d1-2d404f242d0mr7155684a91.0.1724035514278;
        Sun, 18 Aug 2024 19:45:14 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d439711d6dsm1500130a91.15.2024.08.18.19.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 19:45:13 -0700 (PDT)
Date: Mon, 19 Aug 2024 10:45:04 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, Taehee Yoo <ap420073@gmail.com>,
	davem@davemloft.net, jv@jvosburgh.net, andy@greyhouse.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jarod@redhat.com
Subject: Re: [PATCH net 2/4] bonding: fix null pointer deref in
 bond_ipsec_offload_ok
Message-ID: <ZsKxsN5Mc3Yz6YyZ@Laptop-X1>
References: <20240816114813.326645-1-razor@blackwall.org>
 <20240816114813.326645-3-razor@blackwall.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816114813.326645-3-razor@blackwall.org>

On Fri, Aug 16, 2024 at 02:48:11PM +0300, Nikolay Aleksandrov wrote:
> We must check if there is an active slave before dereferencing the pointer.
> 
> Fixes: 18cb261afd7b ("bonding: support hardware encryption offload to slaves")
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> ---
>  drivers/net/bonding/bond_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
> index 85b5868deeea..65ddb71eebcd 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -604,6 +604,8 @@ static bool bond_ipsec_offload_ok(struct sk_buff *skb, struct xfrm_state *xs)
>  	bond = netdev_priv(bond_dev);
>  	rcu_read_lock();
>  	curr_active = rcu_dereference(bond->curr_active_slave);
> +	if (!curr_active)
> +		goto out;
>  	real_dev = curr_active->dev;
>  
>  	if (BOND_MODE(bond) != BOND_MODE_ACTIVEBACKUP)
> -- 
> 2.44.0
> 

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

