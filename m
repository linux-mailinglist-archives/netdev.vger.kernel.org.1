Return-Path: <netdev+bounces-193586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE73AC4A90
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 10:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50AA317C679
	for <lists+netdev@lfdr.de>; Tue, 27 May 2025 08:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2248A242D69;
	Tue, 27 May 2025 08:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b="m9p/pvEc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ST5X0ekP"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D320A3C01
	for <netdev@vger.kernel.org>; Tue, 27 May 2025 08:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335637; cv=none; b=es4xD6xNvqkkCqo6nXmn3fZ+KX92gWJyKP2GanLDFcL5fvVRQvYIIBhyd7jHyHWSYfgoLPnDSzmlm8x9rLbhw7CdneNEWctyijNb7DtSJMKYLkwunWxXo9ctqD/YiWx3TQAL+cqbkD5LsgwXmgDJSZujJK5F59NLSukVEZlUfM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335637; c=relaxed/simple;
	bh=VT8lDsxHrxx+XrfOYyQyg9/dVljBC++ItW+9YJ/LFk0=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=afJoVWfuGFoH9/9TYe3JeeElG6xjav+548Lj+0A26iwlTLyoZpNjBUbk6KuHQlopssIymstf1PD/VNinTwIdPgke2SpdSDg3X/gs/qWCssWNo1XE+1qDMEFGrlFp94f1EoRgFRdQV13PZAYAgTyNpx7Ru/TTMT925XEcpjMYo3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io; spf=pass smtp.mailfrom=bejarano.io; dkim=pass (2048-bit key) header.d=bejarano.io header.i=@bejarano.io header.b=m9p/pvEc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ST5X0ekP; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bejarano.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bejarano.io
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9B65225400B8;
	Tue, 27 May 2025 04:47:13 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 27 May 2025 04:47:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bejarano.io; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748335633;
	 x=1748422033; bh=qJb2MCmpbOX7KjTyCs+T69dUeLnIFk/UdggySdlXzCQ=; b=
	m9p/pvEcm24CEnVQiznA987nmWEfhZkELUW8wfFjo1c+kVuyXYEVGvd4YekBHOlx
	IEApiYEozBJH6DvP0fSw7NDM0MLJiVOz1pWE7Mqt9Wf4QNqh6X8LZjR8ZEROCLhU
	OHo/oEGEAh3svCJDYjKC0x88HGS9OZMlfXftgarikAr74tCyiP1K972pNaNrGRbQ
	X8DEUfcAWGmhZW5Uykug+Zg00rAdcT+VBiA7dr4zdhVR75jgZq4caOMD3agTjKqJ
	syRkIClTPnhDTuEJUZT6EDGYZF0pFmnJfk8mWlcJgCD1F/PjZX/kVLEL6YMxeHSa
	qHyAglgKGKaQiKgxZDWVSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748335633; x=
	1748422033; bh=qJb2MCmpbOX7KjTyCs+T69dUeLnIFk/UdggySdlXzCQ=; b=S
	T5X0ekPBdm+5I7JlXQ/SElkUTLmpwaxY8VfMDxKIGhOENISnCi+W7FIRsVVHiBJc
	5HeGzotvenu+/j56/KsTEFFOipPeDx4AQyKS3hfHzPBWGogkqElNPZOqxrWVCQie
	vY0ld9Ew2ePN0SQyTyY3hwcr1e9ouj4CUm1i1b/vBxQiF7e/L6+rl87/4dERh0PM
	cAfRwvOa6awmR7WU4G1KBKfIRkK9PvDb5fO9Zpw8U5C8HdceyS2NivV2ypvt6Tzm
	sjblsB9aALcsK83+hZBbCJGpgqK4Q/nKriUv+OAhT/099DImx+fU9iPzGBOUq04Z
	yTvdQZnHJlwAAu2gJzSPA==
X-ME-Sender: <xms:EHw1aCayY9z1mHFQ8wiWsdRd3rNgThT5I-Mr4QlT-BvEFYpT54cD2g>
    <xme:EHw1aFYaf9_6JSm_U41gH5zKaoR9nwL5mMO0nh-iUVqiza0zPwXKp1akx1O13Gkmb
    -WNLprH-D8X2CTYs1s>
X-ME-Received: <xmr:EHw1aM_Sby24yVQQltqdVWiGH4OpF9MZlHjHgobiulWpDpNBDr27A90jUw11hPkunzZmplpLhkh7RLVldn38WtHFz7SqM0n7UQseyCXtSe174Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduleelgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpegtggfuhfgjffev
    gffkfhfvofesthhqmhdthhdtvdenucfhrhhomheptfhitggrrhguuceuvghjrghrrghnoh
    cuoehrihgtrghrugessggvjhgrrhgrnhhordhioheqnecuggftrfgrthhtvghrnheptefh
    leekteffhedtgeekudeivefhgfevtedvgedtjefhffejteelgeethfevhfdunecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhhitggrrhgusegs
    vghjrghrrghnohdrihhopdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtoheprghnughrvgifsehluhhnnhdrtghhpdhrtghpthhtohepmhhikhgr
    rdifvghsthgvrhgsvghrgheslhhinhhugidrihhnthgvlhdrtghomhdprhgtphhtthhope
    hnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmihgthhgr
    vghlrdhjrghmvghtsehinhhtvghlrdgtohhmpdhrtghpthhtohephigvhhgviihkvghlsh
    hhsgesghhmrghilhdrtghomhdprhgtphhtthhopegrnhgurhgvfidonhgvthguvghvsehl
    uhhnnhdrtghhpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprh
    gtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepkhhu
    sggrsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:EHw1aEoouu3sUhgdd6mvJkYrSOuiIMJ05BqPDXBCgV62-jztKzaZ7g>
    <xmx:EHw1aNpn8QQVUAra4Kpj3rtO0syeVtuMY7_FpwjYl94M-MRXbcEm_Q>
    <xmx:EHw1aCSw9UeLUG_Xn8nKOi_qVj3GdM3tO-GMAG0cnhKRFfR0eHrLPw>
    <xmx:EHw1aNroqWuKLXBtrzQFL9sneVU7x1eqtS-GJCXcDgGBQbVDL1Df9A>
    <xmx:EXw1aEwr3apN0gZanAK7390sAQadp6huzBxttk61F6t1Ubedx2sNN5oL>
Feedback-ID: i583147b9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 04:47:11 -0400 (EDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: Poor thunderbolt-net interface performance when bridged
From: Ricard Bejarano <ricard@bejarano.io>
In-Reply-To: <9a5f7f4c-268f-4c7c-b033-d25afc76f81c@lunn.ch>
Date: Tue, 27 May 2025 10:47:09 +0200
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 netdev@vger.kernel.org,
 michael.jamet@intel.com,
 YehezkelShB@gmail.com,
 andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <63FE081D-44C9-47EC-BEDF-2965C023C43E@bejarano.io>
References: <C0407638-FD77-4D21-A262-A05AD7428012@bejarano.io>
 <20250523110743.GK88033@black.fi.intel.com>
 <353118D9-E9FF-4718-A33A-54155C170693@bejarano.io>
 <20250526045004.GL88033@black.fi.intel.com>
 <5DE64000-782A-492C-A653-7EB758D28283@bejarano.io>
 <20250526092220.GO88033@black.fi.intel.com>
 <4930C763-C75F-430A-B26C-60451E629B09@bejarano.io>
 <f2ca37ef-e5d0-4f3e-9299-0f1fc541fd03@lunn.ch>
 <29E840A2-D4DB-4A49-88FE-F97303952638@bejarano.io>
 <9a5f7f4c-268f-4c7c-b033-d25afc76f81c@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

> There are three devices in your chain, so three sets of numbers would
> be good.
>
> What is also interesting is not the absolute numbers, but the
> difference after sending a known amount of packets.
>
> So take a snapshot of all the numbers. Do a UDP stream. Take another
> snapshot of the numbers and then a subtractions. You can then see how
> many packets got launched into the chain, how many made it to the end
> of the first link, how many got sent into the second link and how many
> made it to the end of the chain. That should give you an idea where
> the packets are getting lost.

Right, here you go.

root@red:~# iperf3 -c 10.0.0.2 -u -b 1100M -t 5  # blue
Connecting to host 10.0.0.2, port 5201
[  5] local 10.0.0.1 port 46140 connected to 10.0.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Total Datagrams
[  5]   0.00-1.00   sec   131 MBytes  1.10 Gbits/sec  94897
[  5]   1.00-2.00   sec   131 MBytes  1.10 Gbits/sec  94959
[  5]   2.00-3.00   sec   131 MBytes  1.10 Gbits/sec  94959
[  5]   3.00-4.00   sec   131 MBytes  1.10 Gbits/sec  94959
[  5]   4.00-5.00   sec   131 MBytes  1.10 Gbits/sec  94951
- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Jitter    =
Lost/Total Datagrams
[  5]   0.00-5.00   sec   656 MBytes  1.10 Gbits/sec  0.000 ms  0/474725 =
(0%)  sender
[  5]   0.00-5.00   sec   597 MBytes  1.00 Gbits/sec  0.004 ms  =
42402/474725 (8.9%)  receiver
root@red:~#

Here are the stat diffs for each interface:

1) red's br0 (10.0.0.1)
    RX:    bytes  packets errors dropped  missed   mcast
           +1055      +14      -       -       -       -
    TX:    bytes  packets errors dropped carrier collsns
      +707341722  +474740      -       -       -       -

2) red's tb0
    RX:    bytes  packets errors dropped  missed   mcast
           +1251      +14      -       -       -       -
    TX:    bytes  packets errors dropped carrier collsns
      +707341722  +474740      -       -       -       -

3) blue's tb0
    RX:    bytes  packets errors dropped  missed   mcast
      +707028822  +474530     +5       -       -       -
    TX:    bytes  packets errors dropped carrier collsns
           +1251      +14      -       -       -       -

4) blue's br0 (10.0.0.2)
    RX:    bytes  packets errors dropped  missed   mcast
      +700385402  +474530      -       -       -       -
    TX:    bytes  packets errors dropped carrier collsns
           +1251      +14      -       -       -       -

So, if I'm reading this right, loss happens at blue tb0 RX.
We have 5 errors there and lost 210 packets.

Also, why does iperf3 report 42402 lost packets, though?

Thanks,
Ricard Bejarano


