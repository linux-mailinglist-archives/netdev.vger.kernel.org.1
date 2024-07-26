Return-Path: <netdev+bounces-113262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA8993D652
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 17:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64BA1F24E10
	for <lists+netdev@lfdr.de>; Fri, 26 Jul 2024 15:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F8017A5AD;
	Fri, 26 Jul 2024 15:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UYvmBpRO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E39A17838E
	for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 15:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722008456; cv=none; b=d0arFq8gx86UOmFsKNcbATPupBuKfu3rITLzl1APR5w0R6aq2/XmGh5iBQJDi5nwjYD6FgBlFG9bMNLxQ9RDUcRAAeijj52U0cncSgirskIU3JmKSG1kPjvQq34lX0xaHsFGJAbSo3KGK3WwQxSdGM9pSXHX0Vh0pMQq71KLlYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722008456; c=relaxed/simple;
	bh=Bm8yzhTz1w1ezTbv26TxQIGp6hnrL2kL8FOi3oT4/JI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HA4bavdxQv0EtdFEcgwD49pkSVGgSlHJroX2iwB3VZoiwg3ekdav6NyIr83Maqt5pLKCAPL+r30AmEt7eU50VJwdvBk5K7hM7yxpA05Q+ORiNsflQbTbTlwUU7hiFMWB3GWL2C6LmmOT89Ssy+w3g6vTPwxdpx3ITh8VHqFQXwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UYvmBpRO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722008453;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lSqWN3jNFsx72kH3y+ST3WOVydYSi/qMl+4qIb+/cnw=;
	b=UYvmBpRO1IqZUyx32CzwtwJQcKrXhIc9ZTodf31SEpECwRj0W/iQgyevbaqrCzEK2IA3Nb
	QSl5wlx3TRaQPwQJrLR+7thNxJRMAcUWD4YhsxzB/ZaM77PmB1DM9NWLegOekRzTCsUVpb
	sq2BBRROEMKBruvVtV9Dz7zAg4h62Xg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-631-vGnxC-dpP_WhkIk4G0OQOg-1; Fri, 26 Jul 2024 11:40:52 -0400
X-MC-Unique: vGnxC-dpP_WhkIk4G0OQOg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3679ab94cdbso1253235f8f.3
        for <netdev@vger.kernel.org>; Fri, 26 Jul 2024 08:40:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722008451; x=1722613251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSqWN3jNFsx72kH3y+ST3WOVydYSi/qMl+4qIb+/cnw=;
        b=l1JdTabxqwQ/mB2zTnysm5nWzwktYJjzV5KcyZ0vjQhUiv6tUvfQLECamUcdf5LndR
         iPrcOPL9PpWeQRKLjTDCldFzkHPlSo0mRT1Maha0jNhQpOcqoBtsfXSJDnuMPlncSCM9
         JP/z7pKCPV5+599NqkKcoKnToJEkcGaCwGgmUNPhFkUZscBV6pRwqhwIHhgmYTALkLsM
         0JZwgbmS4FvYbbEoILxaXzOYLXUAMXdgfTHCxNUhdPi3JntmQqGEKMAA+t0RdCQaXPcE
         inQ9anG1oBsi9Ei26D+fD+3OsJKA2s7TwJZrV3FomI2zks7aYN/v7LtYpG4F13NC578y
         mwjg==
X-Forwarded-Encrypted: i=1; AJvYcCXL+XkWKieTRFkAuDOYjhitRxRjslV0TfkdQ/gN/irZ9HRESqXlBdUy24tbZ3WcgaMtKuOXsMofLXmIACt/lev+B/GtJ/4S
X-Gm-Message-State: AOJu0YxiI37+/QEbyO4Yr0E1ogLST26Z9bT9v9M0RihQNhRIZhlFDZPW
	AntcUGpH6uuJ7VfSSecSNFu2xSaxtezlZmzsHKk44llqaCkgKsEIpqVsLJ9tQilOc7wXFBxUFbs
	TE9oqZNJ90ei+VoY9HACvRXsMxktS82KuyK/ycxqmtKrXuNr6SvphaA==
X-Received: by 2002:adf:f845:0:b0:367:9522:5e70 with SMTP id ffacd0b85a97d-36b5d08a21bmr50784f8f.52.1722008451155;
        Fri, 26 Jul 2024 08:40:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2ifAhPfu9FFnitDhFyuHy9MZxvX9eLv0CF2voHRwf4z6SvAD16PMUVKXlb5p6bMlk9X1BUw==
X-Received: by 2002:adf:f845:0:b0:367:9522:5e70 with SMTP id ffacd0b85a97d-36b5d08a21bmr50754f8f.52.1722008450501;
        Fri, 26 Jul 2024 08:40:50 -0700 (PDT)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36857ec5sm5460659f8f.74.2024.07.26.08.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jul 2024 08:40:50 -0700 (PDT)
Date: Fri, 26 Jul 2024 17:40:47 +0200
From: Guillaume Nault <gnault@redhat.com>
To: Florian Westphal <fw@strlen.de>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	dsahern@kernel.org, pablo@netfilter.org, kadlec@netfilter.org
Subject: Re: [RFC PATCH net-next 2/3] netfilter: nft_fib: Mask upper DSCP
 bits before FIB lookup
Message-ID: <ZqPDf00MuoI677T/@debian>
References: <20240725131729.1729103-1-idosch@nvidia.com>
 <20240725131729.1729103-3-idosch@nvidia.com>
 <20240726133248.GA5302@breakpoint.cc>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240726133248.GA5302@breakpoint.cc>

On Fri, Jul 26, 2024 at 03:32:48PM +0200, Florian Westphal wrote:
> Ido Schimmel <idosch@nvidia.com> wrote:
> > @@ -110,7 +108,7 @@ void nft_fib4_eval(const struct nft_expr *expr, struct nft_regs *regs,
> >  	if (priv->flags & NFTA_FIB_F_MARK)
> >  		fl4.flowi4_mark = pkt->skb->mark;
> >  
> > -	fl4.flowi4_tos = iph->tos & DSCP_BITS;
> > +	fl4.flowi4_tos = iph->tos & IPTOS_RT_MASK;
> 
> If this is supposed to get centralised, wouldn't it
> make more sense to not mask it, or will that happen later?

I think Ido prefers to have this behaviour introduced in a dedicated
patch, rather than as a side effect of the centralisation done in
patch 3/3.

Once patch 3/3 is applied, the next step would be to remove all those
redundant masks (including this new nft_fib4_eval() one), so that
fib4_rule_match(), fib_table_lookup() and fib_select_default() could
see the full DSCP.

This will allow the final step of allowing IPv4 routes and fib-rules to
be configured for matching either the DSCP bits or only the old TOS ones.

> I thought plan was to ditch RT_MASK...

That was my preference too. But Ido's affraid of potential users who
may depend on fib-rules with tos=0x1c matching packets with
dsfield=0xfc. Centralising the mask would allow us to configure this
behaviour upon route or fib-rule creation.

Here's the original thread that lead to this RFC, if anyone wants more
details on the current plan:
https://lore.kernel.org/netdev/ZnwCWejSuOTqriJc@shredder.mtl.com/


