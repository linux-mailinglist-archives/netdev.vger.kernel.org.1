Return-Path: <netdev+bounces-42330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 469647CE4B9
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 19:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F9AB20FAC
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 17:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDB83FB12;
	Wed, 18 Oct 2023 17:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXJfEeKW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101CA2F531
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 17:37:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24585C433CA;
	Wed, 18 Oct 2023 17:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697650625;
	bh=geOBo95O/K4ooFlTQc6NiW8YW2+mC1AuPcK2r9RbM60=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SXJfEeKWIEFL037wd9Kx1uRUp4vBF0hK+5pVBFk/LlLMQnkZgzbXWX/0iVZCFJSyP
	 W7sTaRni2aOXaaP1bp9sZ/yR4HHmCvBAxxsNVcBx4OEsquhbG91/IikvmM+WTyW5l8
	 /+g/dDC6FOZ7erRdJLiMMIocyKhi2BnvQWip987zLwn9qZMEQhwPy4MCdbtuyr4/La
	 dtzuMIcwKRLG628usEnptkqlz5W1Y7Va6KsX563a6krV4cKmg5Gymp2yD/TUv6hywL
	 G2cEeyg745JJ5zm3X34im7j7hiII8pxpWtcf+A1YRvyaKEdwWh05DBow2Ke0mrWGT+
	 P3dyAc8SrFrFg==
Date: Wed, 18 Oct 2023 10:37:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: takeru hayasaka <hayatake396@gmail.com>
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Harald Welte <laforge@gnumonks.org>,
 Pablo Neira Ayuso <pablo@netfilter.org>, osmocom-net-gprs@lists.osmocom.org
Subject: Re: [PATCH net-next v2] ethtool: ice: Support for RSS settings to
 GTP from ethtool
Message-ID: <20231018103703.41fd4d9b@kernel.org>
In-Reply-To: <CADFiAc+OnpyNTXntZBkDAf+UfueRotqqWKg+BrApWcL=x_8vjQ@mail.gmail.com>
References: <20231012060115.107183-1-hayatake396@gmail.com>
	<20231016152343.1fc7c7be@kernel.org>
	<CADFiAcKOKiTXFXs-e=WotnQwhLB2ycbBovqS2YCk9hvK_RH2uQ@mail.gmail.com>
	<CADFiAcLiAcyqaOTsRZHex8g-wSBQjCzt_0SBtBaW3CJHz9afug@mail.gmail.com>
	<20231017164915.23757eed@kernel.org>
	<CADFiAc+OnpyNTXntZBkDAf+UfueRotqqWKg+BrApWcL=x_8vjQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Oct 2023 10:53:02 +0900 takeru hayasaka wrote:
> For instance, there are PGWs that have the capability to separate the
> termination of communication of 4G LTE users into Control and User
> planes (C/U).
> This is quite convenient from a scalability perspective. In fact, in
> 5G UPF, the communication is explicitly only on the User plane
> (Uplane).
> 
> Therefore, services are expected to receive only GTPU traffic (e.g.,
> PGW-U, UPF) or only GTPC traffic (e.g., PGW-C). Hence, there arises a
> necessity to use only GTPU.
> 
> If we do not distinguish packets into Control/User (C/U) with options
> like gtp4|6, I can conceive scenarios where performance tuning becomes
> challenging.
> For example, in cases where we want to process only the control
> communication (GTPC) using Flow Director on specific CPUs, while
> processing GTPU on the remaining cores.
> In scenarios like IoT, where user communication is minimal but the
> volume of devices is vast, the control traffic could substantially
> increase. Thus, this might also be possible in reverse.
> In short, this pertains to being mindful of CPU core affinity.
> 
> If we were to propose again, setting aside considerations specific to
> Intel, I believe, considering the users of ethtool, the smallest units
> should be gtpu4|6 and gtpc4|6.
> Regarding Extension Headers and such, I think it would be more
> straightforward to handle them implicitly.
> 
> What does everyone else think?

Harald went further and questioned use of the same IP addresses for 
-U and -C traffic, but even within one endpoint aren't these running
on a different port? Can someone reasonably use the same UDP port
for both types of traffic?

