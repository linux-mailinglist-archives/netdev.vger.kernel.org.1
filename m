Return-Path: <netdev+bounces-147310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 223829D90A8
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 04:13:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD8B9169B85
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 03:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26BE840C03;
	Tue, 26 Nov 2024 03:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wbtkh9DC"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90782F85C
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 03:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732590777; cv=none; b=b0uWDf/A85hfZoNeNZbEhMXviXr82p64XNYOTaelcZ7P6idj8bOr5FGqIwJR4a4/IPoz7olAj3AgHtCVaqAMDzKKVI7blv/6UvFy9y1rHkA2JhaSyvq1Ym8EDN9aNkGdqtNUcU//kgQgADvpWhFHrv+rWPoLIH+lNHnq6JukFpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732590777; c=relaxed/simple;
	bh=hwzXCIdTjGVp4vBY4mT50Yf9dobIx/6YLm9M3LTcjds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMnom/QNYc8tjbCg2f8NoW7plKV1arWHrDm21kCko/7ZpgwC5d/ICwUj45zZNWhJm8OXC0rETR5r4nJNyGsiXcFOS71ywgvYYR+sDiBIbnon7zs0TSPbq/ldAyzaj3+/0IwW7SJxG07rtG6P+JeShKxro2XwHg6p+gquy6MGF6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wbtkh9DC; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 25 Nov 2024 22:12:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732590771;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7ZFCvigxc+f+OmEHcbTlilY3nILuy+938VPUfRa7aRw=;
	b=wbtkh9DCqRmiK2a6LPcnLAWLqDwFtbBTpyxG9r30PTnOqczyMWRCQR8rFN54IOM+HfmiKj
	9AqO/86hC3R0LfKcBJtUpBE4dTRi7vWCliiOLhvbSY7wqjtxxGzlzxA1kAnkHJCtV3AvUD
	yb99i5iTCQBlebQUdi9l78M60+4cj6A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: NeilBrown <neilb@suse.de>, Thomas Graf <tgraf@suug.ch>, 
	netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <t3a3ggvcvnle6dnnmzf3ehlgcxhgpnn2mbpyukjv3g67iqxlah@spqeyovloafo>
References: <>
 <Z0QQnLNJn1jhMErP@gondor.apana.org.au>
 <173257789029.1734440.16216135574521669815@noble.neil.brown.name>
 <yaxjp5k4o37vh2bl2ecuj3qoyz6x3lwau2kf7zevq5v3krcmtu@idoh3wd4zyqu>
 <Z0U4bfbBoooHIZVB@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0U4bfbBoooHIZVB@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 26, 2024 at 10:54:37AM +0800, Herbert Xu wrote:
> On Mon, Nov 25, 2024 at 07:38:57PM -0500, Kent Overstreet wrote:
> >
> > Networking and storage people seem to have quite different perspectives
> > on these issues; in filesystem and storage land in general, randomly
> > failing is flatly unacceptable.
> > 
> > We do need these issues fixed.
> > 
> > I don't think the -EBUSY is being taken seriously enough either,
> > especially given that the default hash is jhash. I've seen jhash produce
> > bad statistical behaviour before, and while rehashing with a different seen
> > may make jhash acceptable, I'm not an all confident that we won't ever
> > see -EBUSY show up in production.
> > 
> > That's the sort of issue that won't ever show up in testing, but it will
> > show up in production as users start coming up with all sorts of weird
> > workloads - and good luck debugging those...
> 
> I actually added a knob to disable EBUSY but it was removed
> without my review:
> 
> commit ccd57b1bd32460d27bbb9c599e795628a3c66983
> Author: Herbert Xu <herbert@gondor.apana.org.au>
> Date:   Tue Mar 24 00:50:28 2015 +1100
> 
>     rhashtable: Add immediate rehash during insertion
> 
> commit 5f8ddeab10ce45d3d3de8ae7ea8811512845c497
> Author: Florian Westphal <fw@strlen.de>
> Date:   Sun Apr 16 02:55:09 2017 +0200
> 
>     rhashtable: remove insecure_elasticity
> 
> I could reintroduce this knob.  It should obviously also disable
> the last-ditch hash table resize that should make ENOMEM impossible
> to hit.

How odd...

Does the knob have to be insecure_elasticity? Neal's idea of just
blocking instead of returning -EBUSY seems perfectly viable to me, most
uses I'm aware of don't need insertions to be strictly nonblocking.

