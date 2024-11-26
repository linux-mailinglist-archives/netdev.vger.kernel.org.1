Return-Path: <netdev+bounces-147320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9D69D9111
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 05:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 411FB2887F4
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 04:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C421869D31;
	Tue, 26 Nov 2024 04:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Llr9zKVW"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF4D146D40
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 04:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732595825; cv=none; b=RACiFd4fvGxz8uLfKzZgDklZ3ccOE0j6BT23zYR4/PDCoO4DkG8V1QMr32cjJAaRD8FyasmcM/ORjsvKSobXmxe6q3givrfpID9CyvcjZ8p3ru1evdhXc5E/2KRtCGv5Sm6ay+gmOrYg7KELFuikQFvzY98SvKWL2HZJF29+QJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732595825; c=relaxed/simple;
	bh=MHaXTcL6laKFSgSuGmmknXkQOI1R/5X3O/8X74W9TVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RuH2LHwrENvrGpV74Ru08AfwlkAYgDjZEqFIuyvpAOHpppY5xEpQ/is6RBkQFKVP2aIKL14dswZMSyyhk6MZ1emYmEy9SQ7CMu9MLihCn1tFuwVYkewA4s4WQfZO582ZJmMbgsJi3kdQdBkIq6vsR7iujOKtMQeufOV3flSqSis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Llr9zKVW; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3piqzS6+rOpwRYRTFm2skaWPpuxkLCSDxSbZ+I0U9i0=; b=Llr9zKVWv9VCFjHpO8P1WMJebW
	5Gzw118HuC2lEZ1c4vtHeRcPlV4SHkOPXswQODNdZgeyUNsJst6gCbcRzSnkJbKg6cnaH9lZt/qMG
	SbuFPIq4Bfks5nCVB5V+pqkowo/OqdWBw6cCnu1uA1c1Sj6wfbhEZciTG37lxellqizhc+ph+UD5x
	+AVDhhkiBeyEE8/w7PdosffStrY3eFFnPAApqExK0Ij957kHPjJ2P9z1T8tt9sOTjWBNHy5u6YUwP
	Eg4x1/2/OAumy6N2rw3NU8pCSJDDy/NTCHVZ60Ajt9xE69oE62EH/xHK3BSTAbMOcpugbAuVEBFTr
	6h1EnNTg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tFnJm-001h4G-1v;
	Tue, 26 Nov 2024 12:36:55 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 26 Nov 2024 12:36:54 +0800
Date: Tue, 26 Nov 2024 12:36:54 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: NeilBrown <neilb@suse.de>, Thomas Graf <tgraf@suug.ch>,
	netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <Z0VQZnLaYpjziend@gondor.apana.org.au>
References: <>
 <Z0QQnLNJn1jhMErP@gondor.apana.org.au>
 <173257789029.1734440.16216135574521669815@noble.neil.brown.name>
 <yaxjp5k4o37vh2bl2ecuj3qoyz6x3lwau2kf7zevq5v3krcmtu@idoh3wd4zyqu>
 <Z0U4bfbBoooHIZVB@gondor.apana.org.au>
 <t3a3ggvcvnle6dnnmzf3ehlgcxhgpnn2mbpyukjv3g67iqxlah@spqeyovloafo>
 <Z0U9IW12JklBfuBv@gondor.apana.org.au>
 <dhgvxsvugfqrowuypzwizy5psdfm4fy5xveq2fuepqfmhdlv5e@pj5kt4pmansq>
 <Z0VHwWe8x9RrhKGp@gondor.apana.org.au>
 <bdnyshk47krppnfczkn3tgdfslylof3pxhxu7nt2xq4oawyio4@ktfab5bu7lis>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdnyshk47krppnfczkn3tgdfslylof3pxhxu7nt2xq4oawyio4@ktfab5bu7lis>

On Mon, Nov 25, 2024 at 11:35:48PM -0500, Kent Overstreet wrote:
>
> That knob was. That's not what I'm suggesting. Can you go back and
> re-read my, and Neal's, suggestion?

That's exactly what the knob used to do.  Let you add entries
without any limit.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

