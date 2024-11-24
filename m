Return-Path: <netdev+bounces-147118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A2C9D794B
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A14162FBA
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 23:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A1013A1B5;
	Sun, 24 Nov 2024 23:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FyCQSkaw"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221936F06D
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 23:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492705; cv=none; b=mhs5rejWLvT3GEtQcx8aH/9d7g4GHioq3nwnQ5j147qG+wSX/p4/u9uZsWxBrHm4iSLFSll79Vw960tWh+UwZvQDhKn+MRooO1lR4H92RsJOtbCA1WBvM73NOK5e23NBJTPkBQDwxrEuVI8bix8W3KzbJxdPm3k7ihJRqz+SXRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492705; c=relaxed/simple;
	bh=1+EoHm5WvPxbK47qV2OprXG5Je0bUj++7PmmwbhuyKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0SvUpx/iN1lHCLNSktiejB44KFbm2L/TD+Z6tK/N53OOrfpsbKGK2bbTukFP9jid8QF3fF1+JsZT97arUMISkYqJ07iPuArcw5MHo/rI9xTnMzoYjzFAl3KZjKA968wlrszTbpxi7oBOvfaXwmZ7hqZOMK3ZcWHNPZFZjwauU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FyCQSkaw; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Sun, 24 Nov 2024 18:58:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732492699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZN8h3plEKrcOpOBZv6ANPkL/ziEb9w8b8bIQl6/vP0M=;
	b=FyCQSkawjh3R3Fj+QKNgT/tRoTe2e2cJ0qj8kBzBviTFz4k/11japaX9jGeS1xt/uGNtew
	4Jgyyy7uvZXynnTspyytQ50DwOddDpEfzxpIdfcwDhYaKMAI+bo5EWRRlRXdZYSMvNQZcv
	t4wX8wmvuULMmsFeaUVjcD1Iil+rdKI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: NeilBrown <neilb@suse.de>, Thomas Graf <tgraf@suug.ch>, 
	netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <pq73vur4sgec4hxjugk5abgpqiftpkkdyvmtcq246jv2vuseok@qn2x6xzfqii7>
References: <>
 <Z0LxtPp1b-jy2Klg@gondor.apana.org.au>
 <173244248654.1734440.17446111766467452028@noble.neil.brown.name>
 <Z0L8LQeZwtvhJ2Ft@gondor.apana.org.au>
 <qderkhvtvsoje5ro5evohboirlysp7oqtczbix2eoklb4mrbvn@inrf23xnuujv>
 <Z0O0BV6v4x3mq-Uw@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0O0BV6v4x3mq-Uw@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 25, 2024 at 07:17:25AM +0800, Herbert Xu wrote:
> On Sun, Nov 24, 2024 at 05:35:56PM -0500, Kent Overstreet wrote:
> >
> > That's what I've been describing, but you keep insisting that this must
> > be misuse, even though I'm telling you I've got the error code that
> > shows what is going on.
> 
> Well, please do as I suggested and dump the chain with over 16
> entries when this happens.  If you can prove to me that you've
> got 16 entries with non-identical keys that hashed to the same
> bucket then I will fix this.  Please also dump the table size
> and the total number of entries currently hashed.
> 
> As I said, every single report in the past has turned out to be
> because people were adding multiple entries with identical keys
> to the same hash table, which will obviously breach the limit of
> 16.
> 
> But I think there is one thing that I will do, the rehash check
> is a bit too loose.  It should only fail if the outstanding rehash
> was caused by insertion failure, and not if it was a growth or
> shrink operation.

Hang on, I see what's going on :) It's not duplicate keys, we're doing
something exceptionally weird here.

We're not hashing the full key, because we require that inodes in
different subvolumes hash to the same bucket - we need to be able to
iterate over cached inodes with the same inode number in all subvolumes
so that fsck can check if deleted inodes are still open, and that
requires iterating over all the subvolumes to look for descendents.

(Yes, it's a bit gross, but I've been trying to avoid a two-level lookup
structure.)

But - your rhltable gives me an idea for a better solution, which would
be to use two different hash tables for this (one indexed by
subvol:inum, for primary lookups, and an rhltable for indexing by inum
for fsck).

Sorry for claiming this was your bug - I do agree with Neal that the
rhastable code could handle this situation better though, so as to avoid
crazy bughunts.

