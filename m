Return-Path: <netdev+bounces-207074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B36B0B05873
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1288F188481B
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E652F226D10;
	Tue, 15 Jul 2025 11:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="TT4BEHSy"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244C88633F
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 11:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752577695; cv=none; b=nSPH04qDZzxACCIvW9002DgGaChyghwfZMnLfQTojrOEDfysDc1ZzYyQVNuzVpkNpSup3WybT3YqzsgwuI+WoKWj6vclVGPnG0Q8xBapc+SyisqNDAbieTxVxLyrEtoG/3ngYST4ILN6fXjIZpNhAVwgc1yYGlRcjlgSmywhstQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752577695; c=relaxed/simple;
	bh=iMmZ00RlME9+Jst+KYDJa+MPxoCjsfDOAfj7Ruo/758=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U+nXdpjIek+/JOVHZRI+L5OK5SPdUqLOXpWQyse0RNxjv8R3oI05X3iAoz1bCpoEh4uIm0rAWrAUuY6kv1btHA3vqo2MyyEEyBkqpfuZ1NE55OX1TF7N5FTvbHR4bLvMU0Bwdxg5jqQKqVemIzNjvY7xGoH5y/4pjAY5qHnaPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=TT4BEHSy; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752577685;
	bh=IrShp1W1ZpWPv3FlCN4u913xV2CQZB37QmSltpT+A0Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=TT4BEHSy1LywqMqZVvXrt9K5loMfi4LNr8JesO2VppL7UK7EQIwYuvwhBA/fmOB7l
	 tFX3zIGeabG1Gf4Ah0O5KKa+Yp0F3NMNAjnIxdWIJbCdTQbKNdLWXqQaZHz11p8QPc
	 ezS3Ca+ZBG4dMujgH4sFih1Pdoljj/s76nN2xWLjLA5LC95U4AN7+ST73daZXVZJ9Q
	 iXp4pFu6c4xM2R6efrZHRKS7EoA9IaMYZ08uK7ItMi9LZzjMwJnreytr7KlKC93Oz6
	 tolPM9+vV1IrYBpBz8qUlpvEpma+iQmuCQIkgc7TP9q29cGVKMUcWO35Udk2qETD7k
	 knNLzF1Mryo/A==
Received: from [192.168.12.105] (unknown [159.196.94.230])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id DD8DE6B514;
	Tue, 15 Jul 2025 19:08:03 +0800 (AWST)
Message-ID: <cd1d3ba89ef2c038b82968dff3c9c3de9843c0e2.camel@codeconstruct.com.au>
Subject: Re: [PATCH net-next v4 5/8] net: mctp: Use hashtable for binds
From: Matt Johnston <matt@codeconstruct.com.au>
To: Paolo Abeni <pabeni@redhat.com>, Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
 <horms@kernel.org>
Cc: netdev@vger.kernel.org
Date: Tue, 15 Jul 2025 19:08:03 +0800
In-Reply-To: <151b85fe-72a2-4eb4-9aef-4e3b13b1c8ff@redhat.com>
References: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
	 <20250710-mctp-bind-v4-5-8ec2f6460c56@codeconstruct.com.au>
	 <151b85fe-72a2-4eb4-9aef-4e3b13b1c8ff@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Paolo,

Thanks for the review.

On Tue, 2025-07-15 at 12:05 +0200, Paolo Abeni wrote:
...
> >  	struct mutex bind_lock;
> > -	struct hlist_head binds;
> > +	DECLARE_HASHTABLE(binds, MCTP_BINDS_BITS);
>=20
> Note that I comment on patch 2/8 before actually looking at this patch.

I guess even with a hash table there's theoretical scope for someone
to fill a hash bucket (via clever timing measurement perhaps). Currently MC=
TP
requires CAP_NET_BIND_SERVICE for any binds, so the risk there is limited.

> As a possible follow-up I suggest a dynamically allocating the hash
> table at first bind time.

*nod* I'll take a look at that.


> > ...
> > +	/* Look for binds in order of widening scope. A given destination or
> > +	 * source address also implies matching on a particular network.
> > +	 *
> > +	 * - Matching destination and source
> > +	 * - Matching destination
> > +	 * - Matching source
> > +	 * - Matching network, any address
> > +	 * - Any network or address
> > +	 */
>=20
> Note for a possible follow-up: a more idiomatic approach uses a
> compute_score() function that respect the above priority and require a
> single hash traversal, see, i.e. net/ipv4/udp.c

Thanks for the pointer, I'll see if something like that would work.

Cheers,
Matt

