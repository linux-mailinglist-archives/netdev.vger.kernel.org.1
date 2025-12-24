Return-Path: <netdev+bounces-246020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B101CDCCD1
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 17:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 522D5300B803
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 16:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8532DCF70;
	Wed, 24 Dec 2025 16:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s+hYslji"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7951154425
	for <netdev@vger.kernel.org>; Wed, 24 Dec 2025 16:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766592534; cv=none; b=O+uLIV3eR8xP96vhvMveCnDnBYlybN9DDQJVK5ENBx+U7mW3WL22Ue/nDYa/8VDP6beHQuLinFiECW5ImEbmFaQflDm9jCyly+ZUZRZHDBSc3SmoIf7F9ok9Dih617c2aPDg9K4k4TxcnPqi1iqWLteapZAqjAA2w6Gmjgeg+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766592534; c=relaxed/simple;
	bh=VaYUc0AH+R9KAtKHxGsJuAATZukshLX1+qHvtOnTNC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pMRJRgpMP3vKvRHHtYQgMD/rfjNsB4uFAE5lU80klBfqIbRZZ//KNJ9lZT5/IU0rwTLYmrWWDhYsklurlqkE6ZVGNbBuFY2o0wJ2qnlOKTSb+xzCGQztjANFjAd2gpYHcMKk0Q553fdDO7IPUPttWQHG4Eo1bnWUl/a2IiTHeds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=s+hYslji; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id C4E351D0010D;
	Wed, 24 Dec 2025 11:08:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 24 Dec 2025 11:08:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1766592531; x=1766678931; bh=FVTKZLT88LtabKH0fFvp8DyaXv3XiqLXNQj
	Da9RdFjs=; b=s+hYsljiz53mvrEul29WuPrgjUe5Ne1tr9fo4bmJV02G9ugdVAf
	Up5AMfLcsCtyxwLKJVqNiMWxdDQbtkNRhC6LYT+nejpBoKiAnUVLMNUaG5U8aqwA
	2KLF/jIKWdD4C9NJRPXv8OCORvDKfDook4ZRjZDKjswYeRSn/xte3LBAwBHdpqnb
	fV04OWoezGZstp0bxw/l7/GYlPLQ2W09eqxY/rll/2sAnXA8P3Vr6WHXkDWGKMWv
	Yeit0gchOEOis2Fk7G+hPJND6zsr/M8VqF7b02jsHjRWbIc468V83YM5D8qkg463
	UyMzy0cickolsxFZD4XlIqpNOZFV7LHYZkQ==
X-ME-Sender: <xms:ExBMaV8ILkpEFcetFQszj_v0wbjhvRbILeiZ1dvK83bPyxyEAl1cHA>
    <xme:ExBMacTKZj1zZJxQv2FrfudtjaPacRTrb5OiUo3BsXI13p80qFaCoVuZWSzTY1EOM
    O8WADO1--UW1f6rBFSVXm6d3WCYZccG_EIeiB3qO0A8O6OsNg>
X-ME-Received: <xmr:ExBMaWpCvuqFSWLIqWpiAY5QEKrGF_01dNdONAEWTfQlh9X9jSUBKXXIm4DjsJYByF24BXdBcMswTzDrvrG6svsXHBnb1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeifedugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgt
    hhdrohhrgheqnecuggftrfgrthhtvghrnhephedtueeifeevgeegvdetvdeivdegtdduie
    eivdetkeejvdehgfeuudeukefffeffnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdp
    ihhpvhegrdhpihhnghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopeel
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeihuhgrnhdrghgrohesuhgtlhhouh
    gurdgtnhdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghp
    thhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvgguuhhmrg
    iivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsvghgohhonhesohhpvghn
    figrlhhlrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhg
X-ME-Proxy: <xmx:ExBMaZk48hU0O0lMqe1ZAc7jhewQAwhM8UTIRjpn8CkNqnNecqstJQ>
    <xmx:ExBMafe-h1PeC8tMglekg4a0IBJXV1S8HZ3ICBC3qjHOdxGGBTMrmw>
    <xmx:ExBMaVrvs9VvI9arJ9Kf0bSm15cjRPQu4NSgnZ41aKNi--aT_-lUqQ>
    <xmx:ExBMaZPBpiKVpuLX5U3H8__E5ZQQiHx3t_fjt1u_N8cprJTO2609iQ>
    <xmx:ExBMaVlIwz0MDqVCRrOCYa8s1bJWUxiWWlbFSsnB1gd8A2ktnStpRZ8a>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Dec 2025 11:08:50 -0500 (EST)
Date: Wed, 24 Dec 2025 18:08:47 +0200
From: Ido Schimmel <idosch@idosch.org>
To: yuan.gao@ucloud.cn
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	segoon@openwall.com, netdev@vger.kernel.org
Subject: Re: [PATCH] inet: ping: Fix icmp out counting
Message-ID: <aUwQDxibc1lw9mrG@shredder>
References: <20251224063145.3615282-1-yuan.gao@ucloud.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251224063145.3615282-1-yuan.gao@ucloud.cn>

Next time, please tag the patch as [PATCH net]. See:

https://docs.kernel.org/process/maintainer-netdev.html

On Wed, Dec 24, 2025 at 02:31:45PM +0800, yuan.gao@ucloud.cn wrote:
> From: "yuan.gao" <yuan.gao@ucloud.cn>
> 
> When the ping program uses an IPPROTO_ICMP socket to send ICMP_ECHO
> messages, ICMP_MIB_OUTMSGS is counted twice.
> 
>     ping_v4_sendmsg
>       ping_v4_push_pending_frames
>         ip_push_pending_frames
>           ip_finish_skb
>             __ip_make_skb
>               icmp_out_count(net, icmp_type); // first count
>       icmp_out_count(sock_net(sk), user_icmph.type); // second count
> 
> However, when the ping program uses an IPPROTO_RAW socket,
> ICMP_MIB_OUTMSGS is counted correctly only once.
> 
> Therefore, the first count should be removed.

Looks correct.

Before:

# sysctl -wq net.ipv4.ping_group_range="0 4294967294"
# nstat -z -j | jq '.[]["IcmpOutEchos"]'
0
# ping -c1 127.0.0.1 &> /dev/null
# nstat -z -j | jq '.[]["IcmpOutEchos"]'
2

After:

# sysctl -wq net.ipv4.ping_group_range="0 4294967294"
# nstat -z -j | jq '.[]["IcmpOutEchos"]'
0
# ping -c1 127.0.0.1 &> /dev/null
# nstat -z -j | jq '.[]["IcmpOutEchos"]'
1

And it's consistent with IPv6:

# sysctl -wq net.ipv4.ping_group_range="0 4294967294"
# nstat -z -j | jq '.[]["Icmp6OutEchos"]'
0
# ping -c1 ::1 &> /dev/null
# nstat -z -j | jq '.[]["Icmp6OutEchos"]'
1

> 
> Fixes: c319b4d76b9e ("net: ipv4: add IPPROTO_ICMP socket kind")
> Signed-off-by: yuan.gao <yuan.gao@ucloud.cn>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

