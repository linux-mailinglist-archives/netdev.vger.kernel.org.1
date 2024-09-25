Return-Path: <netdev+bounces-129816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 179F498663C
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1091F26C83
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 18:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA35884A31;
	Wed, 25 Sep 2024 18:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="oSHJXD1l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F899145B10
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 18:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727288649; cv=none; b=YI0YeogJRqBzRh2XWZZ+X41rKFi5dkv6oGHjCEx1yzTVZYJ6BJV8fxkRiJO7TED9oi64pGbov2jZ8L+6kVCAGZaN9uXIDkHaTyMMN1cAoPE45/kBjHZmknd3Xdx6wXdvvrFR+mX7J/hyW1MHd6umGG6k/Ev1ugYWpBpSah+UP4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727288649; c=relaxed/simple;
	bh=wUfT8JQPcaC3O5sS55KyFO0YTZKXsAyN57SSE9I3TKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jXSQ6/g33JWP8IU3ktl4NzX+iS2GbhAmlXBFjCI8Gz1W2GcvyoegJczoVhxyvyJ98s8gHFShoLsS1Q2P6HfHyaMxbNC3jw4E/vGAozR+/qMmywbOwHb1v6pfbKIqar6QJVpw43FI0e6Qa0wxUHdMOuId+KhMYfr/E+klqbQj8mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=oSHJXD1l; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2e07d85e956so183888a91.3
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 11:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1727288647; x=1727893447; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rky4FbPvV+g5Q7OrWB3+3ivDS4vGBIzdm++uvNxOKGw=;
        b=oSHJXD1lGlX8PyG81kSW6CJuZ5dSEPYQXXgviAX4fPihvOIMyio4iM5e+RrmTbJbtt
         2jwc4LIVU8weyXCoLHl8qWooEGBa4Q6PEJJGd27H11jy68sElur/fKuEmfsRv2J1jYPr
         V2tbF+Dihj5i/NUpKdUTrdMVxfCBe9HCPmvFs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727288647; x=1727893447;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rky4FbPvV+g5Q7OrWB3+3ivDS4vGBIzdm++uvNxOKGw=;
        b=Da9Qf66BmRVDALYKOF36oznMqAd0tWQIjdwGmF4mexPs7CQ6c7GJzVEtRrV9SDZMo1
         fxwZMPRHjcG45OPg9Xh/N1CsLZKVMYhegbEpS4t5jyc2EAuIghfop6+3uy4cfNsIFCTL
         TzRshH3vM4NqrZUxH0UUIgc2rtZATiWrF7Mwvpez81VSosUgvB4fMuWpp5GxsH8ENAA+
         KCoRYXl4jigYU3kXwUhnLR3VH2wnEHomh7mquFdwTOifMucDhSCzioKX013VRN9T2Grq
         7zkc5oD3Pv29/YvOzkpt/gjknGeAlSjdXP5STMf5daLLUzgILW/b0DXGVnUuA5EEXLq+
         JN/g==
X-Forwarded-Encrypted: i=1; AJvYcCW8ofAoDGSWLqAJwJSJVUgSnXgTN7qz4WzHE1Hjlq7H3CEvnI0CcMRWFXdTNIazBmc6wEh/AHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxINfTpsuIGec6swn9tOzhUeizNTWjIEqaTsJBPXZxQaCX01OST
	f8iaL7nZkSg6mYuIPtDpB14/5oHCh57wyuAx9NHlKa2zcWEjk3wrkKEwOuXezFY=
X-Google-Smtp-Source: AGHT+IH+HJ8M/1CEHS9gytOGEvbrIWz4l+ypUT8AiGSXAr3c32UvL+BVDcfFiPIsdM0tWEBHrvAEPQ==
X-Received: by 2002:a17:90b:438b:b0:2d8:d254:6cda with SMTP id 98e67ed59e1d1-2e06ae7be07mr4384329a91.20.1727288647434;
        Wed, 25 Sep 2024 11:24:07 -0700 (PDT)
Received: from LQ3V64L9R2 (c-24-6-151-244.hsd1.ca.comcast.net. [24.6.151.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e19bdfasm1817110a91.11.2024.09.25.11.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 11:24:06 -0700 (PDT)
Date: Wed, 25 Sep 2024 11:24:04 -0700
From: Joe Damato <jdamato@fastly.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Jonathan Davies <jonathan.davies@nutanix.com>,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net 2/2] net: add more sanity checks to
 qdisc_pkt_len_init()
Message-ID: <ZvRVRL6xCTIbfnAe@LQ3V64L9R2>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Jonathan Davies <jonathan.davies@nutanix.com>,
	eric.dumazet@gmail.com
References: <20240924150257.1059524-1-edumazet@google.com>
 <20240924150257.1059524-3-edumazet@google.com>
 <ZvRNvTdnCxzeXmse@LQ3V64L9R2>
 <CANn89iKnOEoH8hUd==FVi=P58q=Y6PG1Busc1E=GPiBTyZg1Jw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iKnOEoH8hUd==FVi=P58q=Y6PG1Busc1E=GPiBTyZg1Jw@mail.gmail.com>

On Wed, Sep 25, 2024 at 08:00:08PM +0200, Eric Dumazet wrote:
> On Wed, Sep 25, 2024 at 7:52 PM Joe Damato <jdamato@fastly.com> wrote:
> >
> > On Tue, Sep 24, 2024 at 03:02:57PM +0000, Eric Dumazet wrote:
> > > One path takes care of SKB_GSO_DODGY, assuming
> > > skb->len is bigger than hdr_len.
> >
> > My only comment, which you may feel free to ignore, is that we've
> > recently merged a change to replace the term 'sanity check' in the
> > code [1].
> >
> > Given that work is being done to replace terminology in the source
> > code, I am wondering if that same ruling applies to commit messages.
> >
> > If so, perhaps the title of this commit can be adjusted?
> >
> > [1]: https://lore.kernel.org/netdev/20240912171446.12854-1-stephen@networkplumber.org/
> 
> I guess I could write the changelog in French, to make sure it is all good.

You could, but then I'd probably email you and remind you that the
documentation explicitly says "It’s important to describe the change
in plain English" [1].

> git log --oneline --grep "sanity check" | wc -l
> 3397

I don't know what this means. We've done it in the past and so
should continue to do it in the future? OK.

> I dunno...

Me either, but if code is being merged as recently as a few days ago
to remove this term...

[1]: https://www.kernel.org/doc/html/v6.11/process/submitting-patches.html#describe-your-changes

