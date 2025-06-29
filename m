Return-Path: <netdev+bounces-202245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF481AECE23
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 16:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 16AAF7A9CF4
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 14:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2DA22FE0F;
	Sun, 29 Jun 2025 14:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HaCM6e9e"
X-Original-To: netdev@vger.kernel.org
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB6122FE08
	for <netdev@vger.kernel.org>; Sun, 29 Jun 2025 14:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751208582; cv=none; b=WlepudJi8lpdGYeELn4rMSUx9XS9oyXZFek3LhIbutlilLDCQAkIjXb915vAoENwIvJzYgeBLT/1Kq24suRqUTgsJ6Zerg04/8DXvQ4nuS3Am2FUM84Yzahv3n6Fr/UCXtSUutD1M2FKV8E2sBj1mWvoxhmaGisRHfWmYzedvc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751208582; c=relaxed/simple;
	bh=BHVC8yjz55Ywp3jBcv+jABdLa4jCYjQuMYq6cS2AZMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pRfVpBjay3FeWqnUN7+f8N1q1pVTUG8oEILtGjBEPKrQ0YPBPeWg041R5pNGz8yisWNjgXj0T2kTAxW4bRdfM/6VWa2FvHhYSPQXfz6dwoCP07p4adCIpREeAvRFb4Bi7UMdHIcC+/Xzozw3kPRtVOx8ad9aGJiY4UU1CHZZ72M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HaCM6e9e; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 0E4C01D0019A;
	Sun, 29 Jun 2025 10:49:40 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 29 Jun 2025 10:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1751208579; x=1751294979; bh=y1az3t2hQw/fffxwjtVQiWBjYhlRLLVMY7f
	qHgj+gZ4=; b=HaCM6e9eg63omjlth7ialOPcukK5gA67OmeQrjeLKg6eKbtVoey
	JZJzEMZed2jeMIMmvlt8xFHbCBRyR06DtwxUSgpC1woIl9cOi+SEtHOJ94dk1LHW
	gNJpgifcTe9rxfbeOvQmQg28qWIx3cMmlwjBwOVaXSK/LnE08oUoxWK+Va5DhcCy
	GNqeU4y7uC4yfkqrF8VFX3MMSU3Vw/RNdt2K3WQ0kPb0oE+w7gUxxQ+IyT6jBPX2
	8afH29VRU9r3Xy0WmyYQ/6vUm7gN4Eu48eNoK0YF4oxEQVqCxAPhtbqeshVPnJRF
	pXyoHEUVS4f6sOEcmvUIvvW8bvWbAHD2A5g==
X-ME-Sender: <xms:g1JhaBrFnpnMsMupWYGbuI-7f6jzq76XEFVjdXg76W-xzJLrICkVUA>
    <xme:g1JhaDpknZVMJyLPXi4heRs5Ni4ZckQnQDNRlY1OZGAObKMhP7K5D7ZEni5kisRzf
    Cf3gdmqbJrdEGg>
X-ME-Received: <xmr:g1JhaOMg6MS7COPQFPvtpLIn_cwRDy5rifMoVbOirONNkbvCef29Mo8bxMRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeludduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttd
    dvnecuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghh
    rdhorhhgqeenucggtffrrghtthgvrhhnpeehudekfeetieekkeejveehhfdtveegheette
    ehgfekieeiffegvdekfeeglefggfenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpddu
    feelrdhithenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphhtthhopeejpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehlihhnghesmhhovgguohhvvgdrtghomhdprh
    gtphhtthhopehgnhgruhhlthesrhgvughhrghtrdgtohhmpdhrtghpthhtohepnhgvthgu
    vghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehprggsvghnihesrhgvughhrghtrdgtohhmpdhrtghp
    thhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehnohgtse
    hmohgvughovhgvrdgtohhm
X-ME-Proxy: <xmx:g1JhaM5eidTb-p0OmAz2jmYW-VdRJTClkQPU7j6QkpDMeHEZ64yr4w>
    <xmx:g1JhaA421i8EDufV9NFame_EdhpdXYUguhzmeRaxVToYtsWMqdFefA>
    <xmx:g1JhaEg0lEzl-2J0YdGUhj8QoXpBZSRtJuGcQ5GIk2lsccDGJwuuTA>
    <xmx:g1JhaC6EENd5Jm5BUBMMiMxVTD0mqowJxK1_Nc3TCgSwjS6K-q2NDw>
    <xmx:g1JhaD7j2vGtSZm2azFYRi-El-7MoYX89dXWtZ3XOgQ5Ul2epPDN7eSB>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 29 Jun 2025 10:49:38 -0400 (EDT)
Date: Sun, 29 Jun 2025 17:49:36 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Aiden Yang <ling@moedove.com>, gnault@redhat.com
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, MoeDove NOC <noc@moedove.com>
Subject: Re: [BUG] net: gre: IPv6 link-local multicast is silently dropped
 (Regression)
Message-ID: <aGFSgDRR8kLc1GxP@shredder>
References: <CANR=AhRM7YHHXVxJ4DmrTNMeuEOY87K2mLmo9KMed1JMr20p6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANR=AhRM7YHHXVxJ4DmrTNMeuEOY87K2mLmo9KMed1JMr20p6g@mail.gmail.com>

+ Guillaume

Report is here: https://lore.kernel.org/netdev/CANR=AhRM7YHHXVxJ4DmrTNMeuEOY87K2mLmo9KMed1JMr20p6g@mail.gmail.com/

On Sun, Jun 29, 2025 at 02:40:27PM +0800, Aiden Yang wrote:
> This report details a regression in the Linux kernel that prevents
> IPv6 link-local all-nodes multicast packets (ff02::1) from being
> transmitted over a GRE tunnel. The issue is confirmed to have been
> introduced between kernel versions 6.1.0-35-cloud-amd64 (working) and
> 6.1.0-37-cloud-amd64 (failing) on Debian 12 (Bookworm).

Apparently 6.1.0-35-cloud-amd64 is v6.1.137 and 6.1.0-37-cloud-amd64 is
v6.1.140. Probably started with:

a51dc9669ff8 gre: Fix again IPv6 link-local address generation.

In v6.1.139.

It skips creating an IPv6 multicast route for some ipgre devices. Can
you try the following diff?

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ba2ec7c870cc..d0a202d0d93e 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3537,12 +3537,10 @@ static void addrconf_gre_config(struct net_device *dev)
 	 * case). Such devices fall back to add_v4_addrs() instead.
 	 */
 	if (!(dev->type == ARPHRD_IPGRE && *(__be32 *)dev->dev_addr == 0 &&
-	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64)) {
+	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64))
 		addrconf_addr_gen(idev, true);
-		return;
-	}
-
-	add_v4_addrs(idev);
+	else
+		add_v4_addrs(idev);
 
 	if (dev->flags & IFF_POINTOPOINT)
 		addrconf_add_mroute(dev);

Guillaume, AFAICT, after commit d3623dd5bd4e ("ipv6: Simplify link-local
address generation for IPv6 GRE.") in net-next an IPv6 multicast route
will be created for every ip6gre device, regardless of IFF_POINTOPOINT.
It should restore the behavior before commit e5dd729460ca ("ip/ip6_gre:
use the same logic as SIT interfaces when computing v6LL address"). We
can extend gre_ipv6_lladdr.sh to test this once the fix is in net-next.

