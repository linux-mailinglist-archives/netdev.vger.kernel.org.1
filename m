Return-Path: <netdev+bounces-228129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D8691BC2366
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 19:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 850C534F5A9
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 17:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E342E6CC9;
	Tue,  7 Oct 2025 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xh7gM6Q6"
X-Original-To: netdev@vger.kernel.org
Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751D22DF130;
	Tue,  7 Oct 2025 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759856648; cv=none; b=fufuZF68veXn5Fzi4zrZYgFGojFv0nY5TV4D3Kz/XG8sCGF9ppniADOcuTkxz8EOCIbMthV2bQe5vDQ/G+4INapfeu1UQQuyIpVi/LZCySmlCAYW6f8wqm3NBzGESHrs0paIj/u6KSINwCzGsJdszp7bI5GUdcJ95PufCQ34xdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759856648; c=relaxed/simple;
	bh=TmecqJ+5qwk2sM9mRz944u6sKOHgNyAjItlrrCFK1Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KDu06F276BsqLFOXtslBWg1gI56uFuosCpX/HUA8YT9w9dW+LnzBgxR9Xx6Lv4l04eU/h5W1IQzLFqPHGaibpRflvtsUjb1DxLhFtReWR6nxOM2dDbVVF+NqWUHQBqTFNo6O+xzPgA2pnyLBNxSMpxCfMfKZStwMRZS+EfArHk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xh7gM6Q6; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 65B74EC032F;
	Tue,  7 Oct 2025 13:04:05 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 07 Oct 2025 13:04:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759856645; x=1759943045; bh=yQkaBhKJ2SJ4QYCh3VzMHRHO23fODnHWxAa
	UeH65jcc=; b=xh7gM6Q6ZwfKs/4QtlLtvRHBRkX9F50eqQwvpqbq1CdFwevs5IM
	rRSEm5hgfrRLqjnpXUMNqi+yGtzb2DDDaDS88kIyMF4YYYEAE3/+JzN94CaSaDi1
	2bRPHZSc1ZOjyWNpZiOHqtSC96VN4FRQbvWtFptS/Y41dis663koel+cZgY3gNdN
	nCoHf6EQphA95trhDWDJ57pBN8pQYcdh98PQNIEsu6hvb21+SRuNhNcbkoQccb40
	EGiePpnoZ3k9OvLdv6ly8ZgSej34tVtrIu/w9qabgrYAg1f5xaW4/25IRBI5XBR0
	Vby+9+Ued1XbLZkaNQqKK3Vmp5N0LBUO4QQ==
X-ME-Sender: <xms:BUjlaDyagWRNFGGu3nDQpPtAbnAyk1sKH8hU6t1zR8FE-pAs8dgGQw>
    <xme:BUjlaOWUhaPrWPPu2XLYaO5qzeD30G9zKICfBCTHgnQp4pKqSYvMzZ1a4kKFkVIUI
    Abn-90s_-jomFFmQY9x7A7Hi-eBCwtBhEhYiz6NIB-7DL-uYw>
X-ME-Received: <xmr:BUjlaH_739i5izQvXBI8ccUefZMoTStMlZMmUpr4nS7sx6WuWJ2FplIAy-nVJvDqppg6k-6S6ykJiu6V2Jm9Y0Ru>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutddtleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcuufgt
    hhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrthhtvg
    hrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfhjeek
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhn
    sggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvmh
    gvthhrihhouhhsiiesphhrohhtohhnrdhmvgdprhgtphhtthhopeifihhllhgvmhguvggs
    rhhuihhjnhdrkhgvrhhnvghlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmh
    esuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgv
    lhdrohhrghdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihes
    rhgvughhrghtrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BUjlaJumaGeVRqaOnzlQnCz0WPrlwsNtNH9H4LCmA0PWawHhmyysjQ>
    <xmx:BUjlaP2a4qFbzTUghm0rgfQ6JOBXGHi6ZSje1y37GnBlGAg16vnldg>
    <xmx:BUjlaGRcaY75CuUivNPiEh67vXCgwBcMCJ3uSapErPpamCFkmSAACA>
    <xmx:BUjlaLfwiLm6XZFMXudeucZyZ4eYJS1e3OnLWoDojrH4I-yLcpb4JA>
    <xmx:BUjlaAabPBhwIDuUh4TsEPfRnyvEmWH2Fyj5JwdQDrPRl2LUvozNXM_o>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Oct 2025 13:04:04 -0400 (EDT)
Date: Tue, 7 Oct 2025 20:04:01 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Dmitry <demetriousz@proton.me>, willemdebruijn.kernel@gmail.com
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ipv6: respect route prfsrc and fill empty
 saddr before ECMP hash
Message-ID: <aOVIAWAxpWto8ETd@shredder>
References: <20251005-ipv6-set-saddr-to-prefsrc-before-hash-to-stabilize-ecmp-v1-1-d43b6ef00035@proton.me>
 <aOPEYwnyGnMQCp-f@shredder>
 <MZruGuax8jyrCcZTXAVhH0AaAMOZ-2Gcj5VeZO8xy8wS9FqwA3EMhPFpHLZs67FAKCu6z3GpEVeArSX2qGdSUqsysI-0o13dKK1ZmUhK_l0=@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MZruGuax8jyrCcZTXAVhH0AaAMOZ-2Gcj5VeZO8xy8wS9FqwA3EMhPFpHLZs67FAKCu6z3GpEVeArSX2qGdSUqsysI-0o13dKK1ZmUhK_l0=@proton.me>

On Mon, Oct 06, 2025 at 06:31:10PM +0000, Dmitry wrote:
> If the 5-tuple is not changed, then both the hash and the outgoing interface
> (OIF) should remain consistent, which is not the case. Only with the fix does it
> respect the configured SRC and produce a consistent, correct 5-tuple with the
> proper hash.
> 
> Therefore, in my opinion, this should be fixed.

Note that even if the hash is consistent throughout the lifetime of the
socket, it is still possible for packets to be routed out of different
interfaces. This can happen, for example, if one of the nexthop devices
loses its carrier. This will change the hash thresholds in the ECMP
group and can cause packets to egress a different interface even if the
current one is not the one that went down. Obviously packets can also
change paths due to changes in other routers between you and the
destination. A network design that results in connections being severed
every time a flow is routed differently seems fragile to me.

If you still want to address the issue, then I believe that the correct
way to do it would be to align tcp_v6_connect() with tcp_v4_connect().
I'm not sure why they differ, but the IPv4 version will first do a route
lookup to determine the source address, then allocate a source port and
only when all the parameters are known it will do a final route lookup
and cache the result in the socket. IPv6 on the other hand, does a
single route lookup with an unknown source address and an unknown source
port.

This is explained in the comment above ip_route_connect_init() and
Willem also explained it here:

https://lore.kernel.org/all/20250424143549.669426-2-willemdebruijn.kernel@gmail.com/

Willem, do you happen to know why tcp_v6_connect() only performs a
single route lookup?

Link to the original patch:

https://lore.kernel.org/netdev/20251005-ipv6-set-saddr-to-prefsrc-before-hash-to-stabilize-ecmp-v1-1-d43b6ef00035@proton.me/

Thanks

