Return-Path: <netdev+bounces-161977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00861A24DCF
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 13:10:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 146FE3A56BD
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 12:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625611D6DA5;
	Sun,  2 Feb 2025 12:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VhN6v3gx"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A089B17C91
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738498169; cv=none; b=nA8IvBcNcTvikbs5w7V5vwGkW4OXk8E4TQYBouvKhuzxjFGMy54RhBXD1N+SSHL6ge4ENwi2f2uzs/fLoCgaqUtSKhUaWWegczCDR9+wrQjKZBmQB/Q8LpZkDyrzkECl+D2JyEg92yvmqem0WIOMgouFpKC8q1gBQqYwJz2Lqn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738498169; c=relaxed/simple;
	bh=tbJ0DkqNVUSQybkrUQj3uPVLz6xTHyYEVUSPuNPOH4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgOyDqlAKVGMBQmqtOvRJD9jDD4/deplN8nxsNbbHXBdHNUBZPDGZjiSDH5QiHNbtEfkPZYKqkPgTuHayTvPOofBGYdVQ+2whjm9xjXHx38V2jE3xiEQAkTvCZtbnveEqKvKHt0/Gnwosl9W5aWeQVwzlVrw4IoqrYCcUoZ9x4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VhN6v3gx; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 6F31B11400D1;
	Sun,  2 Feb 2025 07:09:26 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Sun, 02 Feb 2025 07:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738498166; x=1738584566; bh=p+o38//8rZPlhe+DHIsgFyV5+PJOKaPRoXX
	CKeKBBUs=; b=VhN6v3gx/LK7pfNw9hO+JA/BJoH4oL2fzt4k0AJDHZq1pEac7YY
	FmHBcFdVXNcGIsBBn3+dxM9RW3/6/6+SFvO7hHwPwU86CQ0uLFjQS16S8U1K2tCg
	EdELK8hrwXg62EqYremuWA3DGSdPF9zfcO34i3PkNqpLoJgPCIOoQIhQgbxJD/sn
	28e9+AnbnFrovsufpv/mNROQX32TSKcTI8LF8p7pBS71Ha1u0dV3pc/KCPEOsrP9
	DjG2OJCPtvdO6ehGN5SCufk75/tJzqEckAvK+mJzYtI+qvByr9dHiSrlV3iQ2EEo
	gVRPhVy4Fz9TX/YciOv2uIdhZ06efycAKxA==
X-ME-Sender: <xms:dWCfZxEzjLXCw0C55lovo9TOnJaTUvuSJNYGggMfQ9M582UmeP4GSw>
    <xme:dWCfZ2UgNVyHlVYkSNGic1BXuA2g-AXtB29Ai2UavenSjIico0y5xVwzQf4ociPOA
    gI7ekqn489LAQA>
X-ME-Received: <xmr:dWCfZzLhNWhUv11xZzUlAiIDUDKtUoUZtzXOS0qOkEk30i0kam68rB5UMXyWQolZ8zFJwNLBHsLiHGP0pF2kHGOXcnJrxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeigecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiinhhstghntghhvghnse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgv
    thdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughh
    rghtrdgtohhmpdhrtghpthhtoheprghnughrvgifodhnvghtuggvvheslhhunhhnrdgthh
    dprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:dWCfZ3E6PwKuy3IQTzweg7lArQPaoSx9c5xvoc4Nw9GOzzSJukWx6A>
    <xmx:dWCfZ3Us3d22pW4LF_WrkrnLjFo-qk_CWtgv3Egu2Z2CCxC1XVq2tA>
    <xmx:dWCfZyOo3x_5EpXv0LWa_Q0Bs4tfxgA4ZjBVQ_dI3Bd1sDdsQzivyQ>
    <xmx:dWCfZ22aK1Ct5SQdgnKH_GlpxCOYOUYV2x32fpOD789SPPbnE6YDNA>
    <xmx:dmCfZ5J-IGCnKCql6X-jjtEznirrFw78-UVCzWOZfxHafwVeXY_Z3rOc>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 2 Feb 2025 07:09:25 -0500 (EST)
Date: Sun, 2 Feb 2025 14:09:23 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Ted Chen <znscnchen@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 3/3] vxlan: vxlan_rcv(): Update comment to
 inlucde ipv6
Message-ID: <Z59gc6--yjT6nLCE@shredder>
References: <20250201113207.107798-1-znscnchen@gmail.com>
 <20250201113422.107849-1-znscnchen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250201113422.107849-1-znscnchen@gmail.com>

On Sat, Feb 01, 2025 at 07:34:22PM +0800, Ted Chen wrote:
> Update the comment to indicate that both ipv4/udp.c and ipv6/udp.c invoke

Nit: net/ipv4/udp.c and net/ipv6/udp.c

> vxlan_rcv() to process packets.
> 
> Signed-off-by: Ted Chen <znscnchen@gmail.com>
> ---
>  drivers/net/vxlan/vxlan_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
> index 5ef40ac816cc..8bdf91d1fdfe 100644
> --- a/drivers/net/vxlan/vxlan_core.c
> +++ b/drivers/net/vxlan/vxlan_core.c
> @@ -1684,7 +1684,7 @@ static bool vxlan_ecn_decapsulate(struct vxlan_sock *vs, void *oiph,
>  	return err <= 1;
>  }
>  
> -/* Callback from net/ipv4/udp.c to receive packets */
> +/* Callback from net/ipv{4,6}/udp.c to receive packets */

Maybe just remove the comment? I don't see how anyone can find it
useful.

Regardless, please submit this patch separately as it's not related to
the other patches in the series.

>  static int vxlan_rcv(struct sock *sk, struct sk_buff *skb)
>  {
>  	struct vxlan_vni_node *vninode = NULL;
> -- 
> 2.39.2
> 
> 

