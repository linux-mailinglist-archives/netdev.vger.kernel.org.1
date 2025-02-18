Return-Path: <netdev+bounces-167385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7DCA3A102
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 113CD165D64
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A09526B96A;
	Tue, 18 Feb 2025 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BjcBlLn2"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAA026D5C8
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892106; cv=none; b=BaRnoeLE/Lc9CYT2P0AL8feV3AgBF/7mTl2JRBhe8ozbziSNpbs1NGS3Iv0hQabMy6Kv4gdfOMrzHKxNOBF8dwfsMtP4n26530Ug4WlVT0IVegYOeuEy1Rt+prinXU5KMFoxCU98UuZssPctj1RZ+/3agsvC56MdXJWbiR2swKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892106; c=relaxed/simple;
	bh=6WtVAfAhOQBhmPNF3eva73UYC/Wsc3+i+rBcWuwzoCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cv1LqTFDb3teyDaIpW4mTg/9Z3r9bUDgcCpYrBlkWMLRi4jggUbnhOO7gxM9vAd5Q9L8SKUhtJhW77EkiXJ4utYDqolW5H6yFvkxxwXlMKeNdh6CyikL97yyQfw9ylP9fzMK2a/IrY8yx3JbISRZUOrK3g0kZqTXWopXby28rEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BjcBlLn2; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4E935114023B;
	Tue, 18 Feb 2025 10:21:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 18 Feb 2025 10:21:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739892103; x=
	1739978503; bh=ESiXGQA7LoMCz2qROe4jft1yBdvs96YNdMTAzY4Vrik=; b=B
	jcBlLn2TJVPo+XQ7fTaCQStL19HdyoB3szzpWCNW0MKZqdEYt4ANamBmIj6W2H+2
	T30RXAI8ei/d/YbyzLvF5VOrJnvDA9IRPQYyrEu/lOodfsXiBKo50opDo9SP0EBR
	3ix8Lkj0JEx+Grr5VdDVzpLeqS6MhX0iBzsDvYv8+OJScNpZuxMGQdxkeUAbjczL
	v9lQdG0/RyIfasREMWD/aYlrvzC1DuJuft581Zwpbe49+Wdscjxy/IVpT5fUWQvq
	2iJeo522ocGQJsoJ17f8hJS+0h2Qr9kE6vTARMLXdeHrXo4W9KrS/0R0KjE83dSt
	m2ZD3blIFCeIWX2mF35nw==
X-ME-Sender: <xms:hqW0Z9XJ8yK-gEuMzMwSyb6AAE5FQvQJ1GJQVmwsXnPG3UOSFv7bzA>
    <xme:hqW0Z9lpdPex8avMuqrOTfoIKWjJjnYxgJp_hZTSWYwe_abMEc4Dg9AT_u5Lskki6
    GcBD_64O0F0hsE>
X-ME-Received: <xmr:hqW0Z5ZfFq2Jts5hD_2JV5rpIOgj-IbtY7NzvQ8hMO8_KcXdDYGWsy29On8a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeiudeiiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepkeeggfeghfeuvdegtedtgedvuedvhfdujedv
    vdejteelvdeutdehheellefhhfdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtghp
    thhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhutghivghnrdigih
    hnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhtvghphhgvnhesnhgvthifohhrkhhp
    lhhumhgsvghrrdhorhhgpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtg
    homhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehfmhgvihesshhfshdrtghomhdprhgtphhtthhopeifvghifigrnhesghhooh
    hglhgvrdgtohhm
X-ME-Proxy: <xmx:hqW0ZwXjkkMtkBYbZoS70YDt25QjPY_KOjKj8yANSrNOarUBn8t4-w>
    <xmx:hqW0Z3nrYJhnS64RbhZCFgQFWKTVqLUnLxZBRj6AOktLDmKfMtzMOQ>
    <xmx:hqW0Z9eURXd8IArSrqalY5nMyzH--WcoZyRbjbzpx_1Dc17kEiePgg>
    <xmx:hqW0ZxEbK2c-MlWGpAnXmgNfxHYsGSoaLqw3GZuN0LjXlLtBInDMcA>
    <xmx:h6W0Zyv1QAKFOBT2vcBJxXKALynNSx-ZVMcwAD316kJHJAHm9iJCbHfO>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 10:21:41 -0500 (EST)
Date: Tue, 18 Feb 2025 17:21:38 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Xin Long <lucien.xin@gmail.com>
Cc: Stephen Hemminger <stephen@networkplumber.org>, edumazet@google.com,
	netdev@vger.kernel.org, fmei@sfs.com, Wei Wang <weiwan@google.com>
Subject: Re: Fw: [Bug 219766] New: Garbage Ethernet Frames
Message-ID: <Z7SlggSKBDk2wDj-@shredder>
References: <20250210084931.23a5c2e4@hermes.local>
 <Z7D9cR22BDPN7WSJ@shredder>
 <CADvbK_eZp5ikahxH4wvPm5_PuK1khvVKpGnY5LUd9nwHgS96Cw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADvbK_eZp5ikahxH4wvPm5_PuK1khvVKpGnY5LUd9nwHgS96Cw@mail.gmail.com>

On Mon, Feb 17, 2025 at 05:31:16PM -0500, Xin Long wrote:
> On Sat, Feb 15, 2025 at 3:47 PM Ido Schimmel <idosch@idosch.org> wrote:
> > Another possible solution is to have the blackhole device consume the
> > packets instead of letting them go out without an Ethernet header [4].
> > Doesn't seem great as the packets disappear without telling anyone
> > (before 22600596b675 an error was returned).
> This looks fine to me. The fix in commit 22600596b675 was specifically
> intended to prevent an error from being returned in these cases, as it
> would break userspace UDP applications.

Yes, I later realized that this is fine as well. Packets are already
discarded today via dst_discard_out() if dst_dev_put() was called on a
dst entry before calling dst_output():

# bpftrace -e 'k:dst_discard_out { @[kstack()] = count(); }'
Attaching 1 probe...
^C

@[
    dst_discard_out+5
    ip_send_skb+25
    udp_send_skb+376
    udp_sendmsg+2516
    sock_write_iter+365
    vfs_write+937
    ksys_write+200
    do_syscall_64+158
    entry_SYSCALL_64_after_hwframe+119
]: 2034

While running the reproducer I shared earlier.

> If you prefer to avoid silent drops, you could add a warning like:
> 
>   net_warn_ratelimited("%s(): Dropping skb.\n", __func__);
> 
> similar to how blackhole_netdev_xmit() handles it.

I would like to avoid spamming the kernel log with these messages. I
checked and we see these messages on a few machines while running the
IPv6 torture tests in fib_nexthops.sh. Maybe in net-next I will add a
new drop reason for these scenarios.

> Thanks.

Thanks. I will run this patch through regression and post later this
week if everything is fine.

