Return-Path: <netdev+bounces-151991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5483C9F24B2
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 16:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BE7D1652FD
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 15:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF0918FC8F;
	Sun, 15 Dec 2024 15:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ksBGmsfz"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A53C1DDE9
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734277738; cv=none; b=thUyDSyXcwVYdk0mwLuvNB6RC4C+pO198ZCFUIMxou5Gv1ss0tkF0t5i/a0oCXXaB81ubetlSFFFr8Xq2h2Yl6xfTqSo4x37dJTQp0NebM7Hm2Iu8jWpOVX41iI0BnqGHpPp5zFFfhvLRzLVa8W1pKMe6h3aKMXXjvCKshM42hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734277738; c=relaxed/simple;
	bh=h8zg6PrYkQ+K7hoK0LOwred98j+NJg6nPG617RzZjOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RNyFWosKh8txXqYvHoCFqX9WI1yG1SLsRFhIS/ggThLDvnP/0xfOXFiRu1g8ml82zbUl7J7atrxcFYaCIZDXkDsuQ5uiBo1rPZTBYkqAtnGbok8D0aIi1Z5HYEV7BRaJSrRllMkqkQ+8HJKmTviQBIqzdRmebaGE05SyZyoQJ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ksBGmsfz; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D9CD6254010E;
	Sun, 15 Dec 2024 10:48:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 15 Dec 2024 10:48:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734277735; x=1734364135; bh=A1mEiDVHI56RqV28eZjvAxiMHN8YtMC/3y9
	i/6d65EY=; b=ksBGmsfztkweC8aoJ4JOBIj88aJlrQ7LgDJKrx6H18kCVgHD2XF
	qGf0lxVzEtsU+ZVcvfAf0nDEdWjWAkLoRQgYno+1SO4+Dj09lD5DHvzZoWQnuN3P
	Mm8FXYu2m3JlrA3UBByv9s/lDRzu8mpPM1WVlibx9RTY/ewXtUmlS2GpL3r4kGVl
	ffym1BzoLVex1ea0KxefNaHoLOULAqD4j2v/tCNbfOAZ6mZjWo06cZ+76k2vU472
	f5HKwf5UEafl7kJl54Ah6fFoQL1gs6De4spKa0BxJK2R8p4vsO/4K5GFUrbsiqES
	KU7RNEeOxv+68MXVcG/9mnxA7cLVI4+hP0g==
X-ME-Sender: <xms:Z_peZ0P9eM4j4X7Yf1Jy5-CsTIF0t-jDgaEkHbdHEDvZnEJnbSpDHg>
    <xme:Z_peZ68jyHiJ9LwpBOwrsG5QiBARzoIQ4aZepeqqIgOqglgbFBdfaH5SJA2g0D-3n
    cmO5ECu70fj1JQ>
X-ME-Received: <xmr:Z_peZ7TD-tttgidkKkwCy7s4uamWAxHo45603A_ZaOMKWacM4RritVU4ZCNv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrledugdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorh
    hgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefg
    leekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthho
    peelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegvughumhgriigvthesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdp
    rhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnh
    hisehrvgguhhgrthdrtghomhdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehhohhrmhhssehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuhhnihih
    uhesrghmrgiiohhnrdgtohhmpdhrtghpthhtohepvghrihgtrdguuhhmrgiivghtsehgmh
    grihhlrdgtohhm
X-ME-Proxy: <xmx:Z_peZ8t3bLwamVWt2dik8Q_J3o4HLg2LkjnlZu2qNP02TkqKWSSvsQ>
    <xmx:Z_peZ8cnN2OLCfCWkqVo8XD7ahpq4Op6pof8PeMAEZ7WMCh0NmhSPw>
    <xmx:Z_peZw1Wk4rfOrNjGzM7c0LsZyy7O-kaYC_C-IdTNg06xGpAf0zSwQ>
    <xmx:Z_peZw_jpGy02Aesq3VkEPF4EhQ8t03PZM91j3_H7Y7rWek5TuSQXQ>
    <xmx:Z_peZzwBcjVEHwnYFK_zwdLOeQyjlgXMZvtT36OddQTJo8KWNCyau7yH>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Dec 2024 10:48:54 -0500 (EST)
Date: Sun, 15 Dec 2024 17:48:53 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com
Subject: Re: [PATCH net-next 4/4] inetpeer: do not get a refcount in
 inet_getpeer()
Message-ID: <Z176ZdYvXpwm6bpa@shredder>
References: <20241213130212.1783302-1-edumazet@google.com>
 <20241213130212.1783302-5-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241213130212.1783302-5-edumazet@google.com>

On Fri, Dec 13, 2024 at 01:02:12PM +0000, Eric Dumazet wrote:
> diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
> index 5eeb9f569a706cf2766d74bcf1a667c8930804f2..7a1b1af2edcae0b0648ef3c3411b4ef36e6d9b14 100644
> --- a/net/ipv4/icmp.c
> +++ b/net/ipv4/icmp.c
> @@ -322,11 +322,11 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
>  		goto out;
>  
>  	vif = l3mdev_master_ifindex(dst->dev);
> +	rcu_read_lock();
>  	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr, vif);
>  	rc = inet_peer_xrlim_allow(peer,
>  				   READ_ONCE(net->ipv4.sysctl_icmp_ratelimit));
> -	if (peer)
> -		inet_putpeer(peer);
> +	rcu_read_unlock();
>  out:
>  	if (!rc)
>  		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);

Maybe convert l3mdev_master_ifindex() to l3mdev_master_ifindex_rcu() and
move it into the RCU critical section?

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 7a1b1af2edca..094084b61bff 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -312,7 +312,6 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
        struct dst_entry *dst = &rt->dst;
        struct inet_peer *peer;
        bool rc = true;
-       int vif;
 
        if (!apply_ratelimit)
                return true;
@@ -321,9 +320,9 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
        if (dst->dev && (dst->dev->flags&IFF_LOOPBACK))
                goto out;
 
-       vif = l3mdev_master_ifindex(dst->dev);
        rcu_read_lock();
-       peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr, vif);
+       peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr,
+                              l3mdev_master_ifindex_rcu(dst->dev));
        rc = inet_peer_xrlim_allow(peer,
                                   READ_ONCE(net->ipv4.sysctl_icmp_ratelimit));
        rcu_read_unlock();

[...]

> @@ -975,9 +975,9 @@ static int ip_error(struct sk_buff *skb)
>  		break;
>  	}
>  
> +	rcu_read_lock();
>  	peer = inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr,
>  			       l3mdev_master_ifindex(skb->dev));
> -
>  	send = true;
>  	if (peer) {
>  		now = jiffies;

And here?

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index d2086648dcf1..9f9d4e6ea1b9 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -977,7 +977,7 @@ static int ip_error(struct sk_buff *skb)
 
        rcu_read_lock();
        peer = inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr,
-                              l3mdev_master_ifindex(skb->dev));
+                              l3mdev_master_ifindex_rcu(skb->dev));
        send = true;
        if (peer) {
                now = jiffies;

