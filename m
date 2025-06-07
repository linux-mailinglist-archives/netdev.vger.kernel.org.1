Return-Path: <netdev+bounces-195509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78BAAD0BBB
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 09:47:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6579C16FA92
	for <lists+netdev@lfdr.de>; Sat,  7 Jun 2025 07:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A0F1A239F;
	Sat,  7 Jun 2025 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="WjP30sZo"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE788F6B;
	Sat,  7 Jun 2025 07:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749282434; cv=none; b=Icf/03jSIbBNjEMrw+F/flfoQFVhOOYXh9v8WUvGgGwmCx/3YJ51Djsn306cSNIfuuGtRrPdOeZFzvpGnxIgj1WPS3D+6dQr38uVvXA9BiNd38sy1FhP2YLWJpS387mXv/XIX8K+63xzpJ7UU698YYITfCZDFCdDaOMKqkHNn/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749282434; c=relaxed/simple;
	bh=BhEu//HjSSy9oy4gAQ1HvEhhS5cNej+v8Q01W7auFkE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oOzUsSeYTNudM5reZl1mGsbFeeFl7QElUZISi6PooDgT2iIhUsuVG7wTh8sUMNu0EAJvEB1Ka4Nxl3g1pZsbSeoAVJOyihUSPvN2c8bZk4rzwtSt+8NaKaVc197XIGebVc5ecV9lySp/6Fl8biX/udqu7UtAftAwmM7fKn40zn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=WjP30sZo; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749282430;
	bh=Q91YpidFdwM4mQSmMBMrGl9Yf3DmrdsJj1A1DaEjwSQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WjP30sZoLV4DVEnREGBRhihGpVqrVVCSeuHriwsW9+1MdHlewWZ2xtHoonRP07mMK
	 ZoACszwrjHAdTAUsfvgen4o4aSAi/Ndt2WIn8ldUtgw64Bqp9Xigi761aYCrQH6kcq
	 3eyyxaILoNNoewPO8qFHPIFB/Ouv2nlYkUz867epbaGu/2Gix60FjVUbx5waWcK1PG
	 3J/ykZeT172qgXYD/8N982K/j/Jmn3Ln1gwIItaPVm70xKd2oSVz0IMBb4OfRt1j9v
	 AXYOs1wO8mdTYyVzqvxeib/+EAEQi3Zgk+y/gskXmpZWq33Stwmww0d0NeD+CHXO4/
	 9c7T+eludvoPA==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 89C1E640B5;
	Sat,  7 Jun 2025 15:47:09 +0800 (AWST)
Message-ID: <575fa12e699f6f65b47f5b776ec91ef9c350644a.camel@codeconstruct.com.au>
Subject: Re: [PATCH] net: mctp: fix infinite data from mctp_dump_addrinfo
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Patrick Williams <patrick@stwcx.xyz>, Matt Johnston
 <matt@codeconstruct.com.au>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>, Kuniyuki
 Iwashima <kuniyu@amazon.com>, Peter Yin <peteryin.openbmc@gmail.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 07 Jun 2025 15:47:09 +0800
In-Reply-To: <0ee86d6d80c08f6dce6422503b247a253fa75874.camel@codeconstruct.com.au>
References: <20250606111117.3892625-1-patrick@stwcx.xyz>
	 <0ee86d6d80c08f6dce6422503b247a253fa75874.camel@codeconstruct.com.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Patrick,

[+CC Andrew, for openbmc kernel reasons]

> So, it seems like there's something more subtle happening here - or I
> have misunderstood something about the fix (I'm unsure of the
> reference to xa_for_each_start; for_each_netdev_dump only calls xa_start?=
).

Ah! Are you on the openbmc 6.6 backport perhaps?

It look the xa_for_each_start()-implementation of netdev_for_each_dump()
would not be compatible with a direct backport of 2d20773aec14 ("mctp: no
longer rely on net->dev_index_head[]").

This was the update for the for_each_netdev_dump() macro:

commit f22b4b55edb507a2b30981e133b66b642be4d13f
Author: Jakub Kicinski <kuba@kernel.org>
Date:   Thu Jun 13 14:33:16 2024 -0700

    net: make for_each_netdev_dump() a little more bug-proof
   =20
    I find the behavior of xa_for_each_start() slightly counter-intuitive.
    It doesn't end the iteration by making the index point after the last
    element. IOW calling xa_for_each_start() again after it "finished"
    will run the body of the loop for the last valid element, instead
    of doing nothing.

... which sounds like what's happening here.

Cheers,


Jeremy

