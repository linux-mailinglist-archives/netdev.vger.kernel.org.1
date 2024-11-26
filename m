Return-Path: <netdev+bounces-147315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6A39D90E3
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 05:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C551216A79A
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 04:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540026A33F;
	Tue, 26 Nov 2024 04:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="Ac2RX0cW"
X-Original-To: netdev@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2936F27452
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 04:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732593616; cv=none; b=VWCLevoLf1juYOhhvKoMn3Znf26HXxIKMsW3EUJ1unJOlS9OL0aW5w7NHf1sSu4MnYJWvM+qVBoAFUbSBj/ZkR3DwPIFs3DDAFBHVqkPTgt3XIXU1ITwz1TXOt9I0CWiucCdhg6ihp20jDB47K2qpnaBCHqCoy6tyFE2Ai9RtdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732593616; c=relaxed/simple;
	bh=/9zL6OEpmqanjMgS8wS0QU6IAIodw2C5LDrAXIs6B1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WfKUeNa1ERuXyiBeiLfnNpzYTlmUZCjTL3NiIwQV3SKetj6d8zk+gfW21Kxq4wrI50GonFwLrKZnsWGcnvjrfnuM3eCqpPMzzvFB7cI6lqvW7V2x5q3MrKrFZk+NsHMIjc/GB2CdOuS1l06I7Yc61xpdUN1lPHOu2AccPJDd3Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=Ac2RX0cW; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GP+ngI8RdR5CpyOuxiAL5s4xVFqr0UtCPUHhVauLliY=; b=Ac2RX0cWqpu9JEmqGQnapuGEya
	Yu61yT/uI562WrQRd8tWjosVaWHTS1yUoFwATlt/2Lbpv9+MmKG66pyYA10WRLjGZaK+3uQH2phIk
	0zSbUIaFSkO2QlX0KeRxp/qfA5SFUdkVDRjjbP7k9QJSA3THIoOUbsEQeEGsA+AJLLoax9gqxt7p8
	WvVoCdZuEc6sSbZAmg63Fo9vv0XHPcc3vSUNnl5uZPAJxnw5XCNl0qlqD3cAp0E6ISQOfZP0v8QWL
	swCpYnxIRHbOYmutJimZgYcbVLHNjWk70fl3kTK6vsy2PQRhbVBlb3oPgmBiED1YfqluJSIHPb4wy
	tG/3fP1A==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1tFmk5-001gse-2q;
	Tue, 26 Nov 2024 12:00:03 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 26 Nov 2024 12:00:01 +0800
Date: Tue, 26 Nov 2024 12:00:01 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: NeilBrown <neilb@suse.de>, Thomas Graf <tgraf@suug.ch>,
	netdev@vger.kernel.org
Subject: Re: rhashtable issue - -EBUSY
Message-ID: <Z0VHwWe8x9RrhKGp@gondor.apana.org.au>
References: <>
 <Z0QQnLNJn1jhMErP@gondor.apana.org.au>
 <173257789029.1734440.16216135574521669815@noble.neil.brown.name>
 <yaxjp5k4o37vh2bl2ecuj3qoyz6x3lwau2kf7zevq5v3krcmtu@idoh3wd4zyqu>
 <Z0U4bfbBoooHIZVB@gondor.apana.org.au>
 <t3a3ggvcvnle6dnnmzf3ehlgcxhgpnn2mbpyukjv3g67iqxlah@spqeyovloafo>
 <Z0U9IW12JklBfuBv@gondor.apana.org.au>
 <dhgvxsvugfqrowuypzwizy5psdfm4fy5xveq2fuepqfmhdlv5e@pj5kt4pmansq>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dhgvxsvugfqrowuypzwizy5psdfm4fy5xveq2fuepqfmhdlv5e@pj5kt4pmansq>

On Mon, Nov 25, 2024 at 10:51:04PM -0500, Kent Overstreet wrote:
>
> I just meant having a knob that's called "insecure". Why not a knob
> that selects nonblocking vs. reliable?

Because it is *insecure*.  If a hostile actor gains the ability
to insert into your hash table, then by disabling this defence
you're giving them the ability to turn your hash table into a
linked list.

So as long as you acknowledge and are willing to undertake this
risk, I'm happy for you to do that.  But I'm not going to hide
this under the rug.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

