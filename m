Return-Path: <netdev+bounces-147530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 885809DA04A
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 02:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 358E3B23B62
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 01:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0838F66;
	Wed, 27 Nov 2024 01:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Tt0ly7XA"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AA2367
	for <netdev@vger.kernel.org>; Wed, 27 Nov 2024 01:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732671137; cv=none; b=AmDSVwbT9/Tc/Dti8LtYJuPp5r2NZzcuv9b3Vcr/lGhmP33fNzSTvN94Wr/96dz9rjVBrvlaVWqGA9FsxJ2fVumsEIaXe457iE8UY6AYdJFACHf2xTfeO5IsVy3fwr9VboAp324vFd8gWUWdxsX9t9e9EIW7ekPxpw67QoLG8hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732671137; c=relaxed/simple;
	bh=9SlPD0wWB9jY/k9s/t+9kvr5zOYJj/IG3jJoy9z7XiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kiq9J5FRxTrOcuKWVd73TSLii+bQNPxknjZwpUm10/0nddzb0DmZOQLApIIfepMeph8s6n+1xC9XfxkmGBnVPlaqkaidY4O3Zn2qvviqkxWG0hLc5ym0fnzSYIMqS4v3R8S9C5WdKufdOYv31ML0pswfDwUxlHpxuynYhN8BkJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Tt0ly7XA; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 26 Nov 2024 20:32:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732671126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jBHsHLik0/Gy67wiyfO5xUhnLuCAK1iILzJXzADIQSU=;
	b=Tt0ly7XAjhwNbqGbL4T2TzRdxyYprhXtd3B8A1b8omyqOA6o9cMvSPWTrd6Qmc0vXOd0dA
	V3/kndy7klax8KwjBgOR1W0PfXXrKM/kJ9w4OLH2kjCqnBqeehWFJoarPWLnWsEsB4uWAE
	oVbVO0pIa5OGODkSdt8c1YgL6Tqv8Gg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: NeilBrown <neilb@suse.de>, Thomas Graf <tgraf@suug.ch>, 
	netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <vktksfdmraua3wj5zxilaawkgthyia4lrnzkbljcmj76erspuo@aqvun3mnwnsg>
References: <>
 <Z0LxtPp1b-jy2Klg@gondor.apana.org.au>
 <173244248654.1734440.17446111766467452028@noble.neil.brown.name>
 <Z0L8LQeZwtvhJ2Ft@gondor.apana.org.au>
 <qderkhvtvsoje5ro5evohboirlysp7oqtczbix2eoklb4mrbvn@inrf23xnuujv>
 <Z0O0BV6v4x3mq-Uw@gondor.apana.org.au>
 <pq73vur4sgec4hxjugk5abgpqiftpkkdyvmtcq246jv2vuseok@qn2x6xzfqii7>
 <Z0PKQGcuT43tbbT8@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0PKQGcuT43tbbT8@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT

On Mon, Nov 25, 2024 at 08:52:16AM +0800, Herbert Xu wrote:
> On Sun, Nov 24, 2024 at 06:58:12PM -0500, Kent Overstreet wrote:
> >
> > Sorry for claiming this was your bug - I do agree with Neal that the
> > rhastable code could handle this situation better though, so as to avoid
> > crazy bughunts.
> 
> Yes it could certainly make this more obvious.  How about a
> WARN_ON_ONCE if we detect two identical keys? That should have
> made this more obvious.

The keys aren't identical - and if they were, that would be -EEXIST;
it's the hash function that was bad (in an intentional way).

The way to detect and possibly handle this would be when rehash (perhaps
two or three rehashes in a loop) fails to reduce the longest chain
length

