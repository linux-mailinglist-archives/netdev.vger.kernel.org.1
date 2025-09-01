Return-Path: <netdev+bounces-218895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CD7B3EF85
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 22:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FA0E485929
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 20:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB93270576;
	Mon,  1 Sep 2025 20:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D+ktl5iA"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DAE26B75C
	for <netdev@vger.kernel.org>; Mon,  1 Sep 2025 20:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756758067; cv=none; b=WDtY/pXHm7nNluJOghjNL5/22P0ub26sfzagW/N+Snnc7O1CXFVxoqBIfeWm4dPcQzsTjBZFY4+N9+QKgMfMqrjivL8nNXEmuh7kJgTR1hb2tkI4gbgLPiuZfYXZfbaJvauzs9jAL8VawFUcnpXq7fgfMrjyM6+Aj/zByZ4WfFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756758067; c=relaxed/simple;
	bh=gdTyleGqmzo5nbOs9zV1cHP1pAMzDdslCHVhO2GDCJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opM/jSFqsDfm2ZFxhqw0Fc5aJJq2w+q18m+5/ITaubR5/zFs6e44RjvHOy571ggLeGc7vwXIN73skhlyh4EFlZTwEYD7MGXCwYriMnHol3vr6OExqHcdExz0NOULzBaYHUOjy/BScxe9q4C6hnmrOZUqIaM5kBxgawRQu9v5lUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D+ktl5iA; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id CEDEB1D0032E;
	Mon,  1 Sep 2025 16:21:00 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 01 Sep 2025 16:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756758060; x=1756844460; bh=gdTyleGqmzo5nbOs9zV1cHP1pAMzDdslCHV
	hO2GDCJo=; b=D+ktl5iACIeQB4sR/ceRSMzvUleWZFw5ZW75YFnKfr10ZVEPMWr
	JkJDr4toZX0daA4c5KWdz95xAiAG1BUAsiz6XDCdWQ2LqqjmtsH63GyCi1Lpme1b
	CG5A3+2SEQyA8BUtRZ1w6LyC4ytXtU82e6SQ6ij+w/HPOIlf/eGTZEfzuxEInidL
	qf5Fi/vHlle0n4gqVfw8B1p0GhsBOn4AEXbGWDeTuFudsALPBms4bQ9Qp94GJUjE
	fNi4sGXQTaJIwRfgWU6Qb+hiufO8WDOJ9Tv7McFFVdYFN0ZHCo6Ew5ZwibU49wHX
	MmtawrZftB0iyUlK5MjgOzWK1b/iQeGjR9g==
X-ME-Sender: <xms:KwC2aOvf3r77DpyYcoxP3GgLEAl1HJ5BdltT9s6iXBWTwOy53HFtFw>
    <xme:KwC2aMG8BLB38DqXEedao_FoRES932NplRbNFTrelyA_yjIETlaZxcT4XUfFtnTOY
    3wD6QUuUz7ct08>
X-ME-Received: <xmr:KwC2aBOXaopspg_KC34VAacImd3HNhz3g1QJ3js_kanVVUBuUK295abFOHu7_JPvdbzMYuO_-tbMsfm4z_PxNI1vRRU3Rg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduleefuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeggefh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguoh
    hstghhsehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehrihgtrghrugessggvjhgrrhgrnhhordhiohdprhgtph
    htthhopegrnhgurhgvfieslhhunhhnrdgthhdprhgtphhtthhopehmihhkrgdrfigvshht
    vghrsggvrhhgsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepnhgvthguvg
    hvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhhitghhrggvlhdrjhgr
    mhgvthesihhnthgvlhdrtghomhdprhgtphhtthhopeihvghhvgiikhgvlhhshhgssehgmh
    grihhlrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgt
    hhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtoh
    epvgguuhhmrgiivghtsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:KwC2aDKAbEKB4HetBcSxovazf4xVa7VJrS3lgFLYbwr0BLIrMgJQAw>
    <xmx:KwC2aC_sqAqUtOY7eXZXtqARR8hVT-ItelT-8l4vQwLxIeRKa9Q8FQ>
    <xmx:KwC2aHEDxJMJBExya2a3ynw-Uc29syo_rvRHqjuABY_u88Lh-tQUpg>
    <xmx:KwC2aF46Z2JB36uaeGzDiBf93L0auy-BPb0D34l0DYZZtS5mt3k7xQ>
    <xmx:LAC2aFPliYkVk_rgPUwfa7vKlPtpaoZ7q40Piukcy7tfqlhvR_vMHqlv>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Sep 2025 16:20:59 -0400 (EDT)
Date: Mon, 1 Sep 2025 23:20:56 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Ricard Bejarano <ricard@bejarano.io>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	netdev@vger.kernel.org, michael.jamet@intel.com,
	YehezkelShB@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Subject: Re: Poor thunderbolt-net interface performance when bridged
Message-ID: <aLYAKG2Aw5t7GKtu@shredder>
References: <CD0896D8-941E-403E-9DA9-51B13604A449@bejarano.io>
 <78AA82DB-92BE-4CD5-8EC7-239E6A93A465@bejarano.io>
 <11d6270e-c4c9-4a3a-8d2b-d273031b9d4f@lunn.ch>
 <A206060D-C73B-49B9-9969-45BF15A500A1@bejarano.io>
 <71C2308A-0E9C-4AD3-837A-03CE8EA4CA1D@bejarano.io>
 <b033e79d-17bc-495d-959c-21ddc7f061e4@app.fastmail.com>
 <ae3d25c9-f548-44f3-916e-c9a5b4769f36@lunn.ch>
 <F42DF57F-114A-4250-8008-97933F9EE5D0@bejarano.io>
 <0925F705-A611-4897-9F62-1F565213FE24@bejarano.io>
 <75EA103A-A9B8-4924-938B-5F41DD4491CE@bejarano.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75EA103A-A9B8-4924-938B-5F41DD4491CE@bejarano.io>

On Thu, Aug 28, 2025 at 09:59:25AM +0200, Ricard Bejarano wrote:
> Anything we could further test?

Disclaimer:
I am not familiar with thunderbolt and tbnet.

tl;dr:
Can you try disabling TSO on your thunderbolt devices and see if it
helps? Like so:
# ethtool -K tb0 tcp-segmentation-offload off

Details:
The driver advertises support for TSO but admits that it's not
implementing it correctly:

"ThunderboltIP takes advantage of TSO packets but instead of segmenting
them we just split the packet into Thunderbolt frames (maximum payload
size of each frame is 4084 bytes) and calculate checksum over the whole
packet here.

The receiving side does the opposite if the host OS supports LRO,
otherwise it needs to split the large packet into MTU sized smaller
packets."

So, what I *think* ends up happening is that the receiver (blue)
receives large TCP packets from tbnet instead of MTU sized TCP packets.
This might be OK for locally received traffic, but not for forwarded
traffic.

The bridge/router/whatever on blue will try to forward the oversized
packets towards purple and drop them because they exceed the size of the
MTU of your Ethernet interface (1500).

The above can explain why you only see it with TCP and only when
forwarding from tbnet to regular Ethernet devices and not in the other
direction.

You can try to start recording packet drops on blue *before* running the
iperf3 test:

# perf record -a -g -e skb:kfree_skb

And then view the traces with "perf script". If the above theory is
correct (and it might not be), you should see the drops in
br_dev_queue_push_xmit().

