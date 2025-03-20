Return-Path: <netdev+bounces-176534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD88A6AAFE
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 17:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 771A97A2CCE
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 16:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B1C1EB1A8;
	Thu, 20 Mar 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UXlT7Uim"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2621EC01E
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 16:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488011; cv=none; b=gvSj3GK97lKI8RTQgmvj57XPoLwNxIEugbnkpowZV7vdWIdGz0Mx0HrQS/gJL3xJKSq8bJIJFNoilE1ZqL8AxqDrNh18XyXs2BIlsb/CatJkDWxeYuzA9LElsh+0A3a/32wE9g+b+V+GLpMV4yulArpgwBWlj934qBd+5dvFSxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488011; c=relaxed/simple;
	bh=tB4FjmDX422qR/WjfOPcfUAJGkQ6d5tL/RSTCNqydIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQXb5CUT6vbGy4hMUCOIcz//eyI0/p27eOkUNGBo837RUXOp8AYUmdoLP03eAOJeZRUvrioKBg9BXwONR08s5DS8Vc2ObX4+lKm+ic7dzVi3eyq2W1M1r+tvmSf0vY8FvxUXi9uKGiO0l2zTV52QwPY1KF/8SkR/vtRU3jN0XLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UXlT7Uim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA170C4CEDD;
	Thu, 20 Mar 2025 16:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742488010;
	bh=tB4FjmDX422qR/WjfOPcfUAJGkQ6d5tL/RSTCNqydIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXlT7UimKSBFoNra+/+iGfqMauGEefsiOgO3CQcptjiycKP5YVA45GDQclkUUSXhq
	 0pMQXN7UWCmnmKJoxpa4TEmpVpqgC8/ZYXefxugXbVLtwm2ImF13f7rcjzLJfjVGI3
	 60izLFv8/qp7VnIib4qcF5RhIt2MkTIXCgOxgEDx2IcZ2+9haScpNrMJ3okchagUxA
	 2/I0LNz14zDimCa7+0Xzne/CodHaTPAgS+ouCG8h8Z0zumMFQCNLv6Ffzgm/LmfuXO
	 Dv3uknMsmTh0yOH54IyjMTU0xj5oQFFycOBL7EaCHY9BS+mSiHVSRf4me6lxGV0fxF
	 /j3pCe9eCdnuw==
Date: Thu, 20 Mar 2025 16:26:46 +0000
From: Simon Horman <horms@kernel.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: Ido Schimmel <idosch@idosch.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v4 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <20250320162646.GC892515@horms.kernel.org>
References: <cover.1741375285.git.gnault@redhat.com>
 <559c32ce5c9976b269e6337ac9abb6a96abe5096.1741375285.git.gnault@redhat.com>
 <Z9RIyKZDNoka53EO@mini-arch>
 <Z9SB87QzBbod1t7R@debian>
 <Z9SPDT9_M_nH9JiM@mini-arch>
 <Z9bNYPX165yxdoId@shredder>
 <Z9iP1anwinOHhjjm@debian>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9iP1anwinOHhjjm@debian>

On Mon, Mar 17, 2025 at 10:10:45PM +0100, Guillaume Nault wrote:
> On Sun, Mar 16, 2025 at 03:08:48PM +0200, Ido Schimmel wrote:
> > On Fri, Mar 14, 2025 at 01:18:21PM -0700, Stanislav Fomichev wrote:
> > > On 03/14, Guillaume Nault wrote:
> > > > On Fri, Mar 14, 2025 at 08:18:32AM -0700, Stanislav Fomichev wrote:
> > > > > 
> > > > > Could you please double check net/forwarding/ip6gre_custom_multipath_hash.sh ?
> > > > > It seems like it started falling after this series has been pulled:
> > > > > https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/31301/2-ip6gre-custom-multipath-hash-sh/stdout
> > > > 
> > > > Hum, net/forwarding/ip6gre_custom_multipath_hash.sh works for me on the
> > > > current net tree (I'm at commit 4003c9e78778). I have only one failure,
> > > > but it already happened before 183185a18ff9 ("gre: Fix IPv6 link-local
> > > > address generation.") was applied.
> > > 
> > > On my side I see the following (ignore ping6 FAILs):
> > > 
> > > bfc6c67ec2d6 - (net-next/main, net-next/HEAD) net/smc: use the correct ndev to find pnetid by pnetid table (7 hours ago) <Guangguan Wang>
> > > 
> > > TAP version 13
> > > 1..1
> > > # timeout set to 0
> > > # selftests: net/forwarding: ip6gre_custom_multipath_hash.sh
> > > [    9.275735][  T167] ip (167) used greatest stack depth: 23536 bytes left
> > > [   13.769300][  T255] gre: GRE over IPv4 demultiplexor driver
> > > [   13.838185][  T255] ip6_gre: GRE over IPv6 tunneling driver
> > > [   13.951780][   T12] ip6_tunnel: g1 xmit: Local address not yet configured!
> > > [   14.038101][   T12] ip6_tunnel: g1 xmit: Local address not yet configured!
> > > [   15.148469][  T281] 8021q: 802.1Q VLAN Support v1.8
> > > [   17.559477][  T321] GACT probability NOT on
> > > [   18.551876][   T12] ip6_tunnel: g2 xmit: Local address not yet configured!
> > > [   18.633656][   T12] ip6_tunnel: g2 xmit: Local address not yet configured!
> > > # TEST: ping                                                          [ OK ]
> > > # TEST: ping6                                                         [FAIL]
> > > # INFO: Running IPv4 overlay custom multipath hash tests
> > > # TEST: Multipath hash field: Inner source IP (balanced)              [FAIL]
> > > #       Expected traffic to be balanced, but it is not
> > > # INFO: Packets sent on path1 / path2: 1 / 12602
> > > # TEST: Multipath hash field: Inner source IP (unbalanced)            [ OK ]
> > > # INFO: Packets sent on path1 / path2: 0 / 12601
> > > # TEST: Multipath hash field: Inner destination IP (balanced)         [FAIL]
> > > #       Expected traffic to be balanced, but it is not
> > > # INFO: Packets sent on path1 / path2: 1 / 12600
> > > # TEST: Multipath hash field: Inner destination IP (unbalanced)       [ OK ]
> > > # INFO: Packets sent on path1 / path2: 0 / 12600
> > > ...
> > > 
> > > 8ecea691e844 - (HEAD -> upstream/net-next/main) Revert "gre: Fix IPv6 link-local address generation." (2 minutes ago) <Stanislav Fomichev>
> > > 
> > > TAP version 13
> > > 1..1
> > > # timeout set to 0
> > > # selftests: net/forwarding: ip6gre_custom_multipath_hash.sh
> > > [   13.863060][  T252] gre: GRE over IPv4 demultiplexor driver
> > > [   13.911551][  T252] ip6_gre: GRE over IPv6 tunneling driver
> > > [   15.226124][  T277] 8021q: 802.1Q VLAN Support v1.8
> > > [   17.629460][  T317] GACT probability NOT on
> > > [   17.645781][  T315] tc (315) used greatest stack depth: 23040 bytes left
> > > # TEST: ping                                                          [ OK ]
> > > # TEST: ping6                                                         [FAIL]
> > > # INFO: Running IPv4 overlay custom multipath hash tests
> > > # TEST: Multipath hash field: Inner source IP (balanced)              [ OK ]
> > > # INFO: Packets sent on path1 / path2: 5552 / 7052
> > > # TEST: Multipath hash field: Inner source IP (unbalanced)            [ OK ]
> > > # INFO: Packets sent on path1 / path2: 12600 / 2
> > > [   36.278056][    C2] clocksource: Long readout interval, skipping watchdog check: cs_nsec: 1078005296 wd_nsec: 1078004682
> > > # TEST: Multipath hash field: Inner destination IP (balanced)         [ OK ]
> > > # INFO: Packets sent on path1 / path2: 6650 / 5950
> > > # TEST: Multipath hash field: Inner destination IP (unbalanced)       [ OK ]
> > > # INFO: Packets sent on path1 / path2: 0 / 12600
> > > ...
> > > 
> > > And I also see the failures on 4003c9e78778. Not sure why we see
> > > different results. And the NIPAs fails as well:
> > > 
> > > https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/32922/1-ip6gre-custom-multipath-hash-sh/stdout
> > 
> > I can reproduce this locally and I'm getting the exact same result as
> > the CI. All the balanced tests fail because the traffic is forwarded via
> > a single nexthop. No failures after reverting 183185a18ff9.
> > 
> > I'm still not sure what happens, but for some reason a neighbour is not
> > created on one of the nexthop devices which causes rt6_check_neigh() to
> > skip over this path (returning RT6_NUD_FAIL_DO_RR). Enabling
> > CONFIG_IPV6_ROUTER_PREF fixes the issue because then RT6_NUD_SUCCEED is
> > returned.
> > 
> > I can continue looking into this on Tuesday (mostly AFK tomorrow).
> 
> I finally managed to reproduce the problem using vng. Still no problem
> on my regular VM, no matter if I enable CONFIG_IPV6_ROUTER_PREF or not.
> I'll continue investigating this problem...

FWIIW, I have tried much, but am unable to _reliably_ reproduce this problem.

