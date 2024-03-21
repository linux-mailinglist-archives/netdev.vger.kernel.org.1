Return-Path: <netdev+bounces-81063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A369C885A20
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 14:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41C351F21A6D
	for <lists+netdev@lfdr.de>; Thu, 21 Mar 2024 13:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85DEE84A51;
	Thu, 21 Mar 2024 13:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jCqrKtyt"
X-Original-To: netdev@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A3A84A28
	for <netdev@vger.kernel.org>; Thu, 21 Mar 2024 13:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711029097; cv=none; b=SNKG4bGAy9I/ljm7MVaLbpxHCw3tg7MzT3+e+GQlXW4gl60uAOSIWYjEIzf7tAoqmg43NgZ4uhKOHBHWbnuhIAG18wqSW4A0OI3caaUMKoRWiro7UPKBO/sU2dlnmWsWeU+g0jg1CiXbnc5mrEMVQ9t1WmXzs+vSYoPaBg2npxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711029097; c=relaxed/simple;
	bh=iQmfCEkYNsDXM43M1WhkvRfuLvbTP/S8SyUeyV2z1r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fuLrZcjxdlhKPe1wfg9YIQlGz7qeocTjnBQ76StFbAaYr2b7zkvZw/A4WDif11FXbvpZIIUmOAXUWddnK1ABcX2cvdwzlVHPKsCPi9N6i36d4aPChCwidND+N6UAB3u4CP2DKQltczTpgoUo/ftsE0ANT8P3O+ibGNf9FEXPEa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jCqrKtyt; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailout.west.internal (Postfix) with ESMTP id B3D373200922;
	Thu, 21 Mar 2024 09:51:33 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Thu, 21 Mar 2024 09:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711029093; x=1711115493; bh=znwXkMhz/twz/h+ZDwtCjJ335fDk
	XEhDNHt1IuYnmp8=; b=jCqrKtytas25CqcYtpx9RMOnu3JXwgwSAOMsEc/NR4Hv
	sEMfYMDeN1iTDTNiGBtvGaO94WPQoZIYnnhx5R616kgUzuUyNIZgfeyDtD6nWjOj
	nAs2aWb6V0D+tvgzhsd3Z0eo/vfJeNph1gK14bxT9mEuH4D6RNmIHrP4WmoxRrng
	nfHeWwAkRNLuz3TmJtMTHuStk9WoNq5hRuH3UBzq6vSe/JhW+coN0fMT7463MZwd
	5gkhqdAq6vikEKqvZ9oZXEY0D3jbm+rhRXXCwN8Fe6Td5Cn1QTqpmPPz3RcqbA9c
	hyDXhM/NIXWmn5ILqSGzH8V5aTzA463TGsD1guD8Rg==
X-ME-Sender: <xms:ZDv8ZYLh3fppW_GHIOqkmG9cCInlJLVqI13h36tMX5tNJQ1agqws8g>
    <xme:ZDv8ZYLs4RAphTQ89kB91z9NTHDSYOJbXP0RYiEzV5oeDJOVytWiUEQXPppeVxABB
    lu1vkyqG83Kpl4>
X-ME-Received: <xmr:ZDv8ZYvX5uV_yFnSVXqULa7w87i43mzj5rdjyENvTJCPWisJBXIC4h7jzMGC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrleeigdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:ZDv8ZVYU-Ms74gTqJHidWd-KtNumCkXVMWWZLoGIwhMQFvazAqWxnw>
    <xmx:ZDv8ZfawcUqTJIM6M-zWHdtA3yfVgrtBy_5bfSYoWOyB_d-XxNcaOA>
    <xmx:ZDv8ZRD5E89EbT-cE7oyoLR8P5zITXmmZlRvNVdmAhE7-V5-JzLhXw>
    <xmx:ZDv8ZVb9ogr582BBjzcPAn9Iu0uETGo-KRXXPjtyWFplte98GpXXCg>
    <xmx:ZTv8ZTT_AKsVoU737LYz1f15nmlVuF2GApYRNCZVLSkGSHjyxUAxMw>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Mar 2024 09:51:30 -0400 (EDT)
Date: Thu, 21 Mar 2024 15:51:28 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Gal Pressman <gal.pressman@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	Stefano Brivio <sbrivio@redhat.com>, davem@davemloft.net,
	netdev@vger.kernel.org, pabeni@redhat.com, jiri@resnulli.us,
	johannes@sipsolutions.net, fw@strlen.de, pablo@netfilter.org,
	Martin Pitt <mpitt@redhat.com>,
	Paul Holzinger <pholzing@redhat.com>,
	David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH net-next v2 3/3] genetlink: fit NLMSG_DONE into same
 read() as families
Message-ID: <Zfw7YB4nZrquW4Bo@shredder>
References: <20240303052408.310064-1-kuba@kernel.org>
 <20240303052408.310064-4-kuba@kernel.org>
 <20240315124808.033ff58d@elisabeth>
 <20240319085545.76445a1e@kernel.org>
 <CANn89i+afBvqP564v6TuL3OGeRxfDNMuwe=EdH_3N4UuHsvfuA@mail.gmail.com>
 <20240319104046.203df045@kernel.org>
 <7e261328-42eb-411d-b1b4-ad884eeaae4d@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e261328-42eb-411d-b1b4-ad884eeaae4d@linux.dev>

On Thu, Mar 21, 2024 at 02:56:41PM +0200, Gal Pressman wrote:
> We've encountered a new issue recently which I believe is related to
> this discussion.
> 
> Following Eric's patch:
> 9cc4cc329d30 ("ipv6: use xa_array iterator to implement inet6_dump_addr()")
> 
> Setting the interface mtu to < 1280 results in 'ip addr show eth2'
> returning an error, because the ipv6 dump fails. This is a degradation
> from the user's perspective.
> 
> # ip addr show eth2
> 4: eth2: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN group
> default qlen 1000
>     link/ether 24:42:53:21:52:44 brd ff:ff:ff:ff:ff:ff
>     altname enp6s0f0np0
> # ip link set dev eth2 mtu 1000
> # ip addr show eth2
> RTNETLINK answers: No such device
> Dump terminated

I don't think it's the same issue. Original issue was about user space
not knowing how to handle NLMSG_DONE being sent together with dump
responses. The issue you reported seems to be related to an
unintentional change in the return code when IPv6 is disabled on an
interface. Can you please test the following patch?

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 247bd4d8ee45..92db9b474f2b 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -5416,10 +5416,11 @@ static int inet6_dump_addr(struct sk_buff *skb, struct netlink_callback *cb,
 
                err = 0;
                if (fillargs.ifindex) {
-                       err = -ENODEV;
                        dev = dev_get_by_index_rcu(tgt_net, fillargs.ifindex);
-                       if (!dev)
+                       if (!dev) {
+                               err = -ENODEV;
                                goto done;
+                       }
                        idev = __in6_dev_get(dev);
                        if (idev)
                                err = in6_dump_addrs(idev, skb, cb,

