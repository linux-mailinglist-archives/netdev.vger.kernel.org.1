Return-Path: <netdev+bounces-147509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 811329D9E66
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 028B1B225FB
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292CD1DE8AC;
	Tue, 26 Nov 2024 20:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="scmzLXD4"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5D8193419
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 20:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732652949; cv=none; b=UILLRo6LkY6TWjGQ1hVoQQKHd0c7bbB2RXnn4KdjiNQrNtt+BXn8+O5RpR8vKoYvZkDQJSlD73sOVdR15kiO1EzwnkIwIFkDg9IcCvfH6PSsOfADj/vrXZJaVsqIyTEcEZ6XJuwHn03nMnr+ZUfW5KsGxUM044ITajMdBZlOUNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732652949; c=relaxed/simple;
	bh=Uz7eIx3re9cahTsbdwoumLnRg2dzXhrhF8c0Rxne3bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RpDCMhG5I8xOqgCJcVThCzJRqoOYHBHZw8YWkLaqSiEmC6OBg6890JeLA6pDAqm2tRHDy07QEO/iYMOMzv8AiWjSI3dlUD5yAmiefJB3Bs3YMKLKzXpVrRL0XiN8YddLdurmAjVL9YJjBv3wX58HXAjixc5uMM3CpFei9/4X9Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=scmzLXD4; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 26 Nov 2024 15:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1732652942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NwfM069PaYAZ8JK6l2yXmilcWv01Jc1Ee7vp3Vtazjw=;
	b=scmzLXD4Sf4W9NFdTHLALGtVQlreEMTqnKnVrjjIVXocYvqOCXnv+9qQKrrCyD4MzLxYzH
	gtw1ktL8aq1OcAW4bEcJlku+f+FpTZWBOct1IG0/IxoHnoN5iO2T76FK1Fgk85DxSnxdXx
	HCwg/JyItVvKFEbpyr2sWT9LJdPNTi8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: NeilBrown <neilb@suse.de>, Thomas Graf <tgraf@suug.ch>, 
	netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <4mnlqfprxh5zuvhjxqrqvqr2btaqggcuy5ofgvdlsxpwi3gljt@rd3pfavturcx>
References: <Z0QQnLNJn1jhMErP@gondor.apana.org.au>
 <173257789029.1734440.16216135574521669815@noble.neil.brown.name>
 <yaxjp5k4o37vh2bl2ecuj3qoyz6x3lwau2kf7zevq5v3krcmtu@idoh3wd4zyqu>
 <Z0U4bfbBoooHIZVB@gondor.apana.org.au>
 <t3a3ggvcvnle6dnnmzf3ehlgcxhgpnn2mbpyukjv3g67iqxlah@spqeyovloafo>
 <Z0U9IW12JklBfuBv@gondor.apana.org.au>
 <dhgvxsvugfqrowuypzwizy5psdfm4fy5xveq2fuepqfmhdlv5e@pj5kt4pmansq>
 <Z0VHwWe8x9RrhKGp@gondor.apana.org.au>
 <bdnyshk47krppnfczkn3tgdfslylof3pxhxu7nt2xq4oawyio4@ktfab5bu7lis>
 <Z0VQZnLaYpjziend@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z0VQZnLaYpjziend@gondor.apana.org.au>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 26, 2024 at 12:36:54PM +0800, Herbert Xu wrote:
> On Mon, Nov 25, 2024 at 11:35:48PM -0500, Kent Overstreet wrote:
> >
> > That knob was. That's not what I'm suggesting. Can you go back and
> > re-read my, and Neal's, suggestion?
> 
> That's exactly what the knob used to do.  Let you add entries
> without any limit.

No, the other option would be to add a knob to block until the rehash is
finished instead of returning -EBUSY - that wouldn't be insecure.

If allocating a bigger table is failing, that would require the limit on
chain length to increase in order to guarantee that inserts won't fail,
but that wouldn't be a security issue.

