Return-Path: <netdev+bounces-202839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C38A3AEF4AE
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93BBC4A38F2
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B856726FA7B;
	Tue,  1 Jul 2025 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FVrEZznS"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D579C26F478
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 10:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751364809; cv=none; b=R0CtOXIfOGkI0/CTgBjDyWHxUoC26yEHL7v1LAV5Hpgi5QD70TV3i7hD4konCYDYhGyBmGvwpYVoN8RmlrM4uRirMbQeREdagTbhPEyMJrJmrbQqTXIo4WF10KhT4upswgloGet0GnJpRyj9L8+ROglMJX+lGFG8sBVGbR4WXoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751364809; c=relaxed/simple;
	bh=fzJjIzRNC5ZlE4xpeBAyKgQnKiPz+VkSrT8w7VE2fpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czHkUDufBUhVURVjPlsLFemCU1j22IAg8UfqzYyuHHI0fOeqSssSUI+BGaWgusK/HJwbgvhu9SL/qUcOmivh7Jtmy1vVRe9XKTYAvoqJ2l7ge/NMyY1tPX44oal8QHlmVkTnMVevOL9iNoMBseaMvzko3ABBrpHdkio64Isj5OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FVrEZznS; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id C09C71D0021D;
	Tue,  1 Jul 2025 06:13:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 01 Jul 2025 06:13:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751364806; x=1751451206; bh=TC15ZCyOpbfoe3LvQKTdVTUkTU0MfI3a99z
	G+q0/Goo=; b=FVrEZznSiMu15S4Cu862KjZCq1VFLecwi7qTkw9x7/d+N2++rVj
	psh3sUZaX+At2Cw0MguQS2rfeUYKyzhB9UQ0ocCzm8rGT3ksoExHjkcUuJFAIMXl
	tRMqZl8UJFmi8izIjKMdJRkHg+ALNh/KxQvhglQje5kTK03wV1x/K2HW5dJL9HxU
	Y0hQASmOrmyA5M59CdsjhOEJ6ExgT5NEC+6LbTRGKGqqKNr+zq4KHkSrQ7sqdxHH
	3xL4zkWkZOBchaBQtQixwpRu7sIBp5BLcHqwnDPrWP5kInL69eHPSNrCzDLLR43p
	sLcooVJ65adxgIdFwSWgZ4K3KGHcwjOTH6w==
X-ME-Sender: <xms:xbRjaJBcSaA2r1LHbg_GYSJDeZeOX2fvdyhc6YBXw1jmOQua94MJ2w>
    <xme:xbRjaHjlG6XUoQ_LvCeCEZDoUJuogA_SWE5fQ9qDlkkwMMVbZylqKZ4Kswl3ZTT3X
    4e_RAD9iOOEY2I>
X-ME-Received: <xmr:xbRjaEncCu9-TFhjYoxjnAl1auVnI-SeOsrIwwTrRuN64uvESKgxzuc_orWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugedvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfutghh
    ihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehudekfeetieekkeejveehhfdtveegheetteehgfekieeiffegvdekfeeglefggfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddufeelrdhithenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghh
    rdhorhhgpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopehgnhgruhhlthesrhgvughhrghtrdgtohhmpdhrtghpthhtoheplhhinhhgsehmohgv
    ughovhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    rggsvghnihesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmh
    hlohhfthdrnhgvthdprhgtphhtthhopehnohgtsehmohgvughovhgvrdgtohhm
X-ME-Proxy: <xmx:xbRjaDzNuC_2Nuk2oe3tbwNUZHerXDZQC7Lej5sEkzqq6VdUEKITGw>
    <xmx:xbRjaOQOp9G_LFqISgM4VW2H7xCVaqzu8V2mcz4uzHAwyGRRAaBA2Q>
    <xmx:xbRjaGbLmE7Isi9DpoI2Phw5KSd5FDrYbZXx7tkBtcc7Acwh4wtRDg>
    <xmx:xbRjaPTPcSb8wwRLsclzy5alXQ6pjhKyt8BkSFVb-kIdH9JDVzL-qQ>
    <xmx:xrRjaCQF4bP84NL97QFMJ858BMvcKczcyXc1b6eyz16x9gbwaP9lwsb_>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 06:13:25 -0400 (EDT)
Date: Tue, 1 Jul 2025 13:13:22 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: Aiden Yang <ling@moedove.com>, netdev@vger.kernel.org, kuba@kernel.org,
	pabeni@redhat.com, davem@davemloft.net,
	MoeDove NOC <noc@moedove.com>
Subject: Re: [BUG] net: gre: IPv6 link-local multicast is silently dropped
 (Regression)
Message-ID: <aGO0whOGhE4LmVo2@shredder>
References: <CANR=AhRM7YHHXVxJ4DmrTNMeuEOY87K2mLmo9KMed1JMr20p6g@mail.gmail.com>
 <aGFSgDRR8kLc1GxP@shredder>
 <aGJ7EvpKRWVzPm4Y@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGJ7EvpKRWVzPm4Y@debian>

On Mon, Jun 30, 2025 at 01:54:58PM +0200, Guillaume Nault wrote:
> On Sun, Jun 29, 2025 at 05:49:36PM +0300, Ido Schimmel wrote:
> > + Guillaume
> > 
> > Report is here: https://lore.kernel.org/netdev/CANR=AhRM7YHHXVxJ4DmrTNMeuEOY87K2mLmo9KMed1JMr20p6g@mail.gmail.com/
> > 
> > On Sun, Jun 29, 2025 at 02:40:27PM +0800, Aiden Yang wrote:
> > > This report details a regression in the Linux kernel that prevents
> > > IPv6 link-local all-nodes multicast packets (ff02::1) from being
> > > transmitted over a GRE tunnel. The issue is confirmed to have been
> > > introduced between kernel versions 6.1.0-35-cloud-amd64 (working) and
> > > 6.1.0-37-cloud-amd64 (failing) on Debian 12 (Bookworm).
> > 
> > Apparently 6.1.0-35-cloud-amd64 is v6.1.137 and 6.1.0-37-cloud-amd64 is
> > v6.1.140. Probably started with:
> > 
> > a51dc9669ff8 gre: Fix again IPv6 link-local address generation.
> > 
> > In v6.1.139.
> > 
> > It skips creating an IPv6 multicast route for some ipgre devices. Can
> > you try the following diff?
> > 
> > diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> > index ba2ec7c870cc..d0a202d0d93e 100644
> > --- a/net/ipv6/addrconf.c
> > +++ b/net/ipv6/addrconf.c
> > @@ -3537,12 +3537,10 @@ static void addrconf_gre_config(struct net_device *dev)
> >  	 * case). Such devices fall back to add_v4_addrs() instead.
> >  	 */
> >  	if (!(dev->type == ARPHRD_IPGRE && *(__be32 *)dev->dev_addr == 0 &&
> > -	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64)) {
> > +	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64))
> >  		addrconf_addr_gen(idev, true);
> > -		return;
> > -	}
> > -
> > -	add_v4_addrs(idev);
> > +	else
> > +		add_v4_addrs(idev);
> >  
> >  	if (dev->flags & IFF_POINTOPOINT)
> >  		addrconf_add_mroute(dev);
> 
> I believe that should fix the problem indeed. But, to me, the root
> cause is that addrconf_gre_config() doesn't call addrconf_add_dev().
> 
> Ido, What do you think of something like the following (untested,
> hand-written) diff:
> 
>  #if IS_ENABLED(CONFIG_NET_IPGRE)
>  static void addrconf_gre_config(struct net_device *dev)
>  {
>  	struct inet6_dev *idev;
>  
>  	ASSERT_RTNL();
>  
> -	idev = ipv6_find_idev(dev);
> -	if (IS_ERR(idev)) {
> -		pr_debug("%s: add_dev failed\n", __func__);
> -		return;
> -	}
> +	idev = addrconf_add_dev(dev);
> +	if (IS_ERR(idev))
> +		return;
>  
>  	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
>  	 * unless we have an IPv4 GRE device not bound to an IP address and
>  	 * which is in EUI64 mode (as __ipv6_isatap_ifid() would fail in this
>  	 * case). Such devices fall back to add_v4_addrs() instead.
>  	 */
>  	if (!(*(__be32 *)dev->dev_addr == 0 &&
>  	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64)) {
>  		addrconf_addr_gen(idev, true);
>  		return;
>  	}
>  
>  	add_v4_addrs(idev);
> -
> -	if (dev->flags & IFF_POINTOPOINT)
> -		addrconf_add_mroute(dev);
>  }
>  #endif
> 
> This way, we would create the multicast route and also respect
> disable_ipv6. That would bring GRE yet a bit closer to normal IPv6
> lladdr generation code.

Makes sense. So you will submit it to net and extend gre_ipv6_lladdr.sh
to test for the presence of a multicast route?

> 
> Note: this diff is based on net-next, but, without all the extra
> context lines, a real patch would probably apply to both net and
> next-next and could be backported to -stable.
> 
> > Guillaume, AFAICT, after commit d3623dd5bd4e ("ipv6: Simplify link-local
> > address generation for IPv6 GRE.") in net-next an IPv6 multicast route
> > will be created for every ip6gre device, regardless of IFF_POINTOPOINT.
> > It should restore the behavior before commit e5dd729460ca ("ip/ip6_gre:
> > use the same logic as SIT interfaces when computing v6LL address"). We
> > can extend gre_ipv6_lladdr.sh to test this once the fix is in net-next.
> 
> Yes, I fully agree.
> 
> Long term, I'd really like to remove these special GRE and SIT cases
> (SIT certainly has the same problems we're currently fixing on GRE).
> 

