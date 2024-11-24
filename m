Return-Path: <netdev+bounces-147094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2679D789C
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 23:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70FD1280E9D
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 22:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDF316DEB3;
	Sun, 24 Nov 2024 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Cn1Cshvn"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681A2500BB
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732487764; cv=none; b=OcjfQT1ExTDhG60/VQjCNjGmzcOSuKkM6daPoH4mBOAx9ZTULy9aE0hevVp7K07IZl/mZW0/I+n9W6Rr0x7Tx9SZAP3TjQfoDVhZe00F3kQHS5+NWNx6YLfh2R/D8IsgSKc07LA33WI6nN5BWMldAOrzmKAl6ddAXScSe4EhPFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732487764; c=relaxed/simple;
	bh=gRXWBbwQaey9rjvZWPHDKNihdBOe8FCKmMS8kDGZaKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkYkkI03BEh0QHx35lZHShM9jGE6UQP0pZe0k9VpaAp41dQG8YYTn3Pf7e6AmJ+resFa4Yw53+INpcukkZCNSsvpCfxQ/XcSq8d+j9XXHJZPFl1OHHSpfxmvajUbYx2+Tg20Zgq1MRLYdvWD+bLOSGVBaAXvn5ksnh7Z4ZeB/6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Cn1Cshvn; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 24 Nov 2024 17:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732487760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UJiix5CoSPF54iS+kZCPPFASrOQHwVk5cNDHTs71w+A=;
	b=Cn1Cshvn9er28pxNdxu+hxm3Gile1R2+atfQu3oa1D3Z3FxidXK7/h41ZAm05gWO0doNa3
	wjkG/m8WCx3acFGNYuiw75vvZtgdbfki4Wqnqh4q03wYigMfz6R2Mv6+P5TFvDTSzUm3r1
	8o6BV8kWym/RlO7+OLiVDLuf5Snm6Qs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: NeilBrown <neilb@suse.de>, Thomas Graf <tgraf@suug.ch>, 
	netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <qderkhvtvsoje5ro5evohboirlysp7oqtczbix2eoklb4mrbvn@inrf23xnuujv>
References: <>
 <Z0LxtPp1b-jy2Klg@gondor.apana.org.au>
 <173244248654.1734440.17446111766467452028@noble.neil.brown.name>
 <Z0L8LQeZwtvhJ2Ft@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0L8LQeZwtvhJ2Ft@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT

On Sun, Nov 24, 2024 at 06:13:01PM +0800, Herbert Xu wrote:
> On Sun, Nov 24, 2024 at 09:01:26PM +1100, NeilBrown wrote:
> >
> > But I don't see any justification for refusing an insertion because we
> > haven't achieved the short chains yet.  Certainly a WARN_ON_ONCE or a
> > rate-limited WARN_ON might be appropriate.  Developers should be told
> > when their hash function isn't good enough.
> > But requiring developers to test for errors and to come up with some way
> > to manage them (sleep and try again is all I can think of) doesn't help anyone.
> 
> If someone can show me this occurring in a situation other than
> that where multiple entries with identical keys are being added
> to the hash table, then I'm certainly happy to change this.

That's what I've been describing, but you keep insisting that this must
be misuse, even though I'm telling you I've got the error code that
shows what is going on.

