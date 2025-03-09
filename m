Return-Path: <netdev+bounces-173359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773B6A586CD
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 19:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34E507A2593
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:04:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288281F4CA8;
	Sun,  9 Mar 2025 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ud2wBDEw"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691BE1EF39A
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543503; cv=none; b=rB/CYRmMSgiIGFcoIR8vDK1ExBSYEmFAV9FV3sl5ZHOupErMw4Ggw9sM3bWFnOKQdNSWBW0z+fbUlStwR5sCxlpjD+sMDnsHEnLvOzBj8uqj6+C45pt3mr0ZvyTlnK32y/TaQtJdNHei+IkP0FaMOdSiNxUpikK9QrMY+9MjDQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543503; c=relaxed/simple;
	bh=rc177gYKEhSPYmc9p8R8pgv/bbfxJCcR7BnsQNfVy0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfSrMvDxTRhWzb8EN9YxO5t2iwxG8Rt1RRVU86Pdl0qQigbWldECAxMD7EG8lq9ntjVMGOWhInOzYHCD1BFG0weBc7AeLmKfkxSvVtxAFCGVkN+DV6xlzNr6yk+gO68w7KuyKzPvqW8pS/cxqpdrbHZP7w2N5NwwNfmJN/KnChQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ud2wBDEw; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 6E2D81382CF3;
	Sun,  9 Mar 2025 14:05:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 09 Mar 2025 14:05:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741543500; x=1741629900; bh=N/DXyqXmB+YgplThYeckqWv0PI3OGrR7axL
	epcJ3ZJU=; b=Ud2wBDEwdVSzHR79j/IX7ZIqoFTIAR13DOrv6GWuuamtMlEoG01
	NsLS2BHdN9AiyM6CnGVGV6Jx8OIkNBaUpItfr8IRMj8JAhnRniGc7av6NozD/ZJC
	fFu6ZwT1p1325BqAUajACHTWkpsPDiUwqk+ioQBjZH10rki3uFmXpeIC8QyB6geA
	HZj16z+ajgfbHxjz6saEpx1cFrddr/xantj5F51H99gMPeq3UwGDaxZyb1On++tI
	I4pr5nNRxW4TZgXBuudEpZSHATze2DQRcYZGFXQzs/se42BC6ArONAbZN4eJLTpY
	dTXdmAxne7yvhF6fvwyZ4N83s0hsGIl6Bpw==
X-ME-Sender: <xms:TNjNZ1Qxsoxr0p1bV5Qv6UMgaeriZf5c4tiQPyJ1SGzEXdq39GfilQ>
    <xme:TNjNZ-yUlpmnzuOSm0jehVxiA-w7RsFKBzxgYVJ3T3QqF0XwA8fKdeuV_SY1jwwLd
    P336p7i6brH58M>
X-ME-Received: <xmr:TNjNZ63I2Zcw7hwlcSffa0JaM97m-gNIkIudQJdHiJvgLLst8NczK3TmhPhn>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudejudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepjeegjefhffeigffgheevfeffteekveekudeu
    heeiieduleegtdelleetkedvfeeknecuffhomhgrihhnpegtohhnfhdruggvvhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhes
    ihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouh
    htpdhrtghpthhtohepghhnrghulhhtsehrvgguhhgrthdrtghomhdprhgtphhtthhopegu
    rghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehnvghtug
    gvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrnhhtohhnihhosehmrghnuggvlhgsihhtrdgtohhm
X-ME-Proxy: <xmx:TNjNZ9BLZZzRZchWukFhK8CiVkEq20Iy2UbgMn3r6vn5MuZGu4erVA>
    <xmx:TNjNZ-jrQRk5Z5fW4DZeTmasSsIxOraYm5VEQbA7mn62D5vs7O0IGg>
    <xmx:TNjNZxp-yiXQ7EsM8_uLwlO8F5zx1vSCLtTUKVeP4vcWzdEAz9p_xw>
    <xmx:TNjNZ5ieGENgFozuCDZmbh3O1OyaH35CN6uNFY2To4DBWal9hNeahw>
    <xmx:TNjNZ5MApfcTyn5yibuk43TrC1XUar0dJ9aIAkuqpiMLZ8dEeeledMWw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 9 Mar 2025 14:04:59 -0400 (EDT)
Date: Sun, 9 Mar 2025 20:04:57 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v4 2/2] selftests: Add IPv6 link-local address
 generation tests for GRE devices.
Message-ID: <Z83YSXVB4P90LFQp@shredder>
References: <cover.1741375285.git.gnault@redhat.com>
 <2d6772af8e1da9016b2180ec3f8d9ee99f470c77.1741375285.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2d6772af8e1da9016b2180ec3f8d9ee99f470c77.1741375285.git.gnault@redhat.com>

On Fri, Mar 07, 2025 at 08:28:58PM +0100, Guillaume Nault wrote:
> GRE devices have their special code for IPv6 link-local address
> generation that has been the source of several regressions in the past.
> 
> Add selftest to check that all gre, ip6gre, gretap and ip6gretap get an
> IPv6 link-link local address in accordance with the
> net.ipv6.conf.<dev>.addr_gen_mode sysctl.
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

