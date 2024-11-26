Return-Path: <netdev+bounces-147311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 436E09D90AE
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 04:15:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B71AFB2654A
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 03:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3712C433AD;
	Tue, 26 Nov 2024 03:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="ihUj+ZDF"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F107E42AA2
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 03:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732590895; cv=none; b=XOPLvhXMNUEFRiCsV4lh1jAmScWtQmhS2++Eo3vnMnhM2onDAuWQpjTNS1J/vcX0/jiHHW0em0lx5TAFZg4i/+YDWr8eVL9f+nE4rqRtQCBIV3mhzD/iZIlhTOuEmq+Y3K5oyMFluqoA8ZIjC7SnQlGFNg2JlaKEE4cG6Sd2nY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732590895; c=relaxed/simple;
	bh=vaGeh27o0jtZeHmi4gfu2+YVTcR4eo0DKTVQyV/jmH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VCDtRdlXMwtawOn8qjq6F4ikNDFyI44vzorecLft9HrPPCTfWXH455bTdGBBvMHbWQld9avxJBfN/eG7QnGuGUnH60P38kx+wXZYsC/eU3TewbSIW8iQYXaPq28SXD4T5qKqsY3I6Z2i3shwvpuoSPGfsGCFD6b3YS38cDKCRz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=ihUj+ZDF; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Reo+zWQ8AG/ykcKyCZUCx0SIkINBsg74weDdRCMTPGE=; b=ihUj+ZDFN+EFa2/oW0V77JujUX
	vdC2F3nVuiRpzZuImX+4IcsNEHacHMnywQMowjkuIBfOlIOruhluxzGdmOve64MUIZ+NMy9nZNIBR
	o9j5UQicbZF8GH1iGhTKLqb3nOrz/JDNua32SPkuUarngQlnBIlxuip7z+ZxdTHqz+tceoQ820P65
	YbZXgS13eKaxBxnz+UEIKQqLLh+lGngUgm2CBf49S8AWgsP4O4n82nUfToa7jbFarGYPPS7uwyy5l
	EIHvRXbpQtohwHmrClZRMV2OPaKU1k3ok+ruFhyuPTU7jmC36w9l5B9urFReCYsVSqpZgcaUL4XvU
	Ow2ujUPQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tFm2D-001gZH-0H;
	Tue, 26 Nov 2024 11:14:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 26 Nov 2024 11:14:41 +0800
Date: Tue, 26 Nov 2024 11:14:41 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: NeilBrown <neilb@suse.de>, Thomas Graf <tgraf@suug.ch>,
	netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <Z0U9IW12JklBfuBv@gondor.apana.org.au>
References: <>
 <Z0QQnLNJn1jhMErP@gondor.apana.org.au>
 <173257789029.1734440.16216135574521669815@noble.neil.brown.name>
 <yaxjp5k4o37vh2bl2ecuj3qoyz6x3lwau2kf7zevq5v3krcmtu@idoh3wd4zyqu>
 <Z0U4bfbBoooHIZVB@gondor.apana.org.au>
 <t3a3ggvcvnle6dnnmzf3ehlgcxhgpnn2mbpyukjv3g67iqxlah@spqeyovloafo>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <t3a3ggvcvnle6dnnmzf3ehlgcxhgpnn2mbpyukjv3g67iqxlah@spqeyovloafo>

On Mon, Nov 25, 2024 at 10:12:44PM -0500, Kent Overstreet wrote:
>
> Does the knob have to be insecure_elasticity? Neal's idea of just
> blocking instead of returning -EBUSY seems perfectly viable to me, most
> uses I'm aware of don't need insertions to be strictly nonblocking.

Well having a knob is not negotiable because we must have this
defence for networking users where hostile actors are a fact of
life.

And no you cannot block in networking.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

