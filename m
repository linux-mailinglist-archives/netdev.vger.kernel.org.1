Return-Path: <netdev+bounces-175116-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E140A635BE
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 14:09:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04FC3AE766
	for <lists+netdev@lfdr.de>; Sun, 16 Mar 2025 13:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9749A1A707A;
	Sun, 16 Mar 2025 13:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="omtB+wXL"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603EC1A3166
	for <netdev@vger.kernel.org>; Sun, 16 Mar 2025 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742130536; cv=none; b=JRQ3f9hXKhGX8kQChYKgOIVtkESu3DNwwJgwaBasSrSfKhkcTCNL4Xyc3olb5CNBFLxblXwq/5wizDQ98k7+WscVitgWNuwbX260pZ1WIT4sd7LqY3iySu47sP7M9XEptAWU15cvb5PBuqYZVmXFk8g34A1RVlGir+TEOZSWhtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742130536; c=relaxed/simple;
	bh=rxj0diw1B841smjEb/DANNeBVwseMaNIPY7B4twTOgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=biwO9qEhEDOuEl1wnKktOtHCr6JADsbyONQ6xRdqrX0BI+tqCKycIxwYOff4ZxkfsZOZIykxCUQzYFvU7ciKJMeo6ObVSix6glKUgcWKetuZLjA3pCTIlhF7W802Up5C/aLcgrUFSsf950Nqbou9Gbx+SYO06mq+Wevfbnvsd7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=omtB+wXL; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1972925400D6;
	Sun, 16 Mar 2025 09:08:52 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sun, 16 Mar 2025 09:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742130531; x=1742216931; bh=9oIHof2UKFkGdZAYbh0BMZx08aWEh0WLEeT
	yzpSOs3Y=; b=omtB+wXLuGOknz7k43WPSRUxAuQWSGOSRufjo1h8gY/dRo9J27c
	SvL+pEfAMhgu7YK7FnX1t3FxNQdAmt8cgiZNRiNmUSi6Oi/NG+WKBrTUnRmqnbjO
	A4wvMGqC351Vg3vRzc8KkjR2c9HuY7jF+PEmrdRcXSit6HHFP0Y83Z+oXqLomgmN
	UoTYSLQ+lrS5kpFtA9tuMko+bhCtnI2KVzJ4i3ifB7pFD+0KO3IOYA/0BfV2LnDb
	xwNo/0/lgwPhj8apntZ37fhvPoso041Eq3cEN0vhAWS+dbAI7DBgujeE3G5kbqXO
	zcg2+ogVmwHEIts0st9+PvM56nz+2Knh1lw==
X-ME-Sender: <xms:Y83WZ3FEfTLswJzoILf18xmQdzYF_HNGrlAEvYiwswpGe5JzTG4zRQ>
    <xme:Y83WZ0XG9WhrVkEk5sYKEm92ChVxsUfYDeE7OucapqP1DDFYepDT3ne62hywiQLzF
    uRkiYejXkAYgOA>
X-ME-Received: <xmr:Y83WZ5LBwxU5EUF_et-8P9bqqSia357g47rcTThqH6zJjBe9_VWqJ9VW9ucl>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeeiieekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgthh
    drohhrgheqnecuggftrfgrthhtvghrnhepieehffeivddtheejjeffkefftdeiheeujeev
    gfetieeugeekleelfefgleetudeinecuffhomhgrihhnpehlihhnuhigrdguvghvnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghh
    sehiughoshgthhdrohhrghdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehsthhfohhmihgthhgvvhesghhmrghilhdrtghomhdprhgtphht
    thhopehgnhgruhhlthesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggrvhgvmhesug
    grvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopegvug
    humhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepughsrghhvghrnheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Y83WZ1EDvncMfiX13XVV7t7PPHrexdZZ8ShzRjSmXDAeHZ-sJyLVzQ>
    <xmx:Y83WZ9Xz0TtHxUGOxXiJcVRdIdYlPOiN0n0fgXthJzDI-2XGBs3Q2g>
    <xmx:Y83WZwPMuBj7wdpFYWzITtwJeEryQeIQxrJPZHqPpn4uyWE6Qz8Xcw>
    <xmx:Y83WZ80gW62VjpHrBnABZoCkQ3nCDAliiJe5H_tn1MfAXmkTpaeS0w>
    <xmx:Y83WZ2MlIcEol2ThWpQ_tUMTcHD_X3VRsKhT8EMZkzAOiFJyg4aJMKdC>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Mar 2025 09:08:50 -0400 (EDT)
Date: Sun, 16 Mar 2025 15:08:48 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Petr Machata <petrm@nvidia.com>
Subject: Re: [PATCH net v4 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <Z9bNYPX165yxdoId@shredder>
References: <cover.1741375285.git.gnault@redhat.com>
 <559c32ce5c9976b269e6337ac9abb6a96abe5096.1741375285.git.gnault@redhat.com>
 <Z9RIyKZDNoka53EO@mini-arch>
 <Z9SB87QzBbod1t7R@debian>
 <Z9SPDT9_M_nH9JiM@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9SPDT9_M_nH9JiM@mini-arch>

On Fri, Mar 14, 2025 at 01:18:21PM -0700, Stanislav Fomichev wrote:
> On 03/14, Guillaume Nault wrote:
> > On Fri, Mar 14, 2025 at 08:18:32AM -0700, Stanislav Fomichev wrote:
> > > On 03/07, Guillaume Nault wrote:
> > > > Use addrconf_addr_gen() to generate IPv6 link-local addresses on GRE
> > > > devices in most cases and fall back to using add_v4_addrs() only in
> > > > case the GRE configuration is incompatible with addrconf_addr_gen().
> > > > 
> > > > GRE used to use addrconf_addr_gen() until commit e5dd729460ca
> > > > ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL
> > > > address") restricted this use to gretap and ip6gretap devices, and
> > > > created add_v4_addrs() (borrowed from SIT) for non-Ethernet GRE ones.
> > > > 
> > > > The original problem came when commit 9af28511be10 ("addrconf: refuse
> > > > isatap eui64 for INADDR_ANY") made __ipv6_isatap_ifid() fail when its
> > > > addr parameter was 0. The commit says that this would create an invalid
> > > > address, however, I couldn't find any RFC saying that the generated
> > > > interface identifier would be wrong. Anyway, since gre over IPv4
> > > > devices pass their local tunnel address to __ipv6_isatap_ifid(), that
> > > > commit broke their IPv6 link-local address generation when the local
> > > > address was unspecified.
> > > > 
> > > > Then commit e5dd729460ca ("ip/ip6_gre: use the same logic as SIT
> > > > interfaces when computing v6LL address") tried to fix that case by
> > > > defining add_v4_addrs() and calling it to generate the IPv6 link-local
> > > > address instead of using addrconf_addr_gen() (apart for gretap and
> > > > ip6gretap devices, which would still use the regular
> > > > addrconf_addr_gen(), since they have a MAC address).
> > > > 
> > > > That broke several use cases because add_v4_addrs() isn't properly
> > > > integrated into the rest of IPv6 Neighbor Discovery code. Several of
> > > > these shortcomings have been fixed over time, but add_v4_addrs()
> > > > remains broken on several aspects. In particular, it doesn't send any
> > > > Router Sollicitations, so the SLAAC process doesn't start until the
> > > > interface receives a Router Advertisement. Also, add_v4_addrs() mostly
> > > > ignores the address generation mode of the interface
> > > > (/proc/sys/net/ipv6/conf/*/addr_gen_mode), thus breaking the
> > > > IN6_ADDR_GEN_MODE_RANDOM and IN6_ADDR_GEN_MODE_STABLE_PRIVACY cases.
> > > > 
> > > > Fix the situation by using add_v4_addrs() only in the specific scenario
> > > > where the normal method would fail. That is, for interfaces that have
> > > > all of the following characteristics:
> > > > 
> > > >   * run over IPv4,
> > > >   * transport IP packets directly, not Ethernet (that is, not gretap
> > > >     interfaces),
> > > >   * tunnel endpoint is INADDR_ANY (that is, 0),
> > > >   * device address generation mode is EUI64.
> > > 
> > > Could you please double check net/forwarding/ip6gre_custom_multipath_hash.sh ?
> > > It seems like it started falling after this series has been pulled:
> > > https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/31301/2-ip6gre-custom-multipath-hash-sh/stdout
> > 
> > Hum, net/forwarding/ip6gre_custom_multipath_hash.sh works for me on the
> > current net tree (I'm at commit 4003c9e78778). I have only one failure,
> > but it already happened before 183185a18ff9 ("gre: Fix IPv6 link-local
> > address generation.") was applied.
> 
> On my side I see the following (ignore ping6 FAILs):
> 
> bfc6c67ec2d6 - (net-next/main, net-next/HEAD) net/smc: use the correct ndev to find pnetid by pnetid table (7 hours ago) <Guangguan Wang>
> 
> TAP version 13
> 1..1
> # timeout set to 0
> # selftests: net/forwarding: ip6gre_custom_multipath_hash.sh
> [    9.275735][  T167] ip (167) used greatest stack depth: 23536 bytes left
> [   13.769300][  T255] gre: GRE over IPv4 demultiplexor driver
> [   13.838185][  T255] ip6_gre: GRE over IPv6 tunneling driver
> [   13.951780][   T12] ip6_tunnel: g1 xmit: Local address not yet configured!
> [   14.038101][   T12] ip6_tunnel: g1 xmit: Local address not yet configured!
> [   15.148469][  T281] 8021q: 802.1Q VLAN Support v1.8
> [   17.559477][  T321] GACT probability NOT on
> [   18.551876][   T12] ip6_tunnel: g2 xmit: Local address not yet configured!
> [   18.633656][   T12] ip6_tunnel: g2 xmit: Local address not yet configured!
> # TEST: ping                                                          [ OK ]
> # TEST: ping6                                                         [FAIL]
> # INFO: Running IPv4 overlay custom multipath hash tests
> # TEST: Multipath hash field: Inner source IP (balanced)              [FAIL]
> #       Expected traffic to be balanced, but it is not
> # INFO: Packets sent on path1 / path2: 1 / 12602
> # TEST: Multipath hash field: Inner source IP (unbalanced)            [ OK ]
> # INFO: Packets sent on path1 / path2: 0 / 12601
> # TEST: Multipath hash field: Inner destination IP (balanced)         [FAIL]
> #       Expected traffic to be balanced, but it is not
> # INFO: Packets sent on path1 / path2: 1 / 12600
> # TEST: Multipath hash field: Inner destination IP (unbalanced)       [ OK ]
> # INFO: Packets sent on path1 / path2: 0 / 12600
> ...
> 
> 8ecea691e844 - (HEAD -> upstream/net-next/main) Revert "gre: Fix IPv6 link-local address generation." (2 minutes ago) <Stanislav Fomichev>
> 
> TAP version 13
> 1..1
> # timeout set to 0
> # selftests: net/forwarding: ip6gre_custom_multipath_hash.sh
> [   13.863060][  T252] gre: GRE over IPv4 demultiplexor driver
> [   13.911551][  T252] ip6_gre: GRE over IPv6 tunneling driver
> [   15.226124][  T277] 8021q: 802.1Q VLAN Support v1.8
> [   17.629460][  T317] GACT probability NOT on
> [   17.645781][  T315] tc (315) used greatest stack depth: 23040 bytes left
> # TEST: ping                                                          [ OK ]
> # TEST: ping6                                                         [FAIL]
> # INFO: Running IPv4 overlay custom multipath hash tests
> # TEST: Multipath hash field: Inner source IP (balanced)              [ OK ]
> # INFO: Packets sent on path1 / path2: 5552 / 7052
> # TEST: Multipath hash field: Inner source IP (unbalanced)            [ OK ]
> # INFO: Packets sent on path1 / path2: 12600 / 2
> [   36.278056][    C2] clocksource: Long readout interval, skipping watchdog check: cs_nsec: 1078005296 wd_nsec: 1078004682
> # TEST: Multipath hash field: Inner destination IP (balanced)         [ OK ]
> # INFO: Packets sent on path1 / path2: 6650 / 5950
> # TEST: Multipath hash field: Inner destination IP (unbalanced)       [ OK ]
> # INFO: Packets sent on path1 / path2: 0 / 12600
> ...
> 
> And I also see the failures on 4003c9e78778. Not sure why we see
> different results. And the NIPAs fails as well:
> 
> https://netdev-3.bots.linux.dev/vmksft-forwarding-dbg/results/32922/1-ip6gre-custom-multipath-hash-sh/stdout

I can reproduce this locally and I'm getting the exact same result as
the CI. All the balanced tests fail because the traffic is forwarded via
a single nexthop. No failures after reverting 183185a18ff9.

I'm still not sure what happens, but for some reason a neighbour is not
created on one of the nexthop devices which causes rt6_check_neigh() to
skip over this path (returning RT6_NUD_FAIL_DO_RR). Enabling
CONFIG_IPV6_ROUTER_PREF fixes the issue because then RT6_NUD_SUCCEED is
returned.

I can continue looking into this on Tuesday (mostly AFK tomorrow).

