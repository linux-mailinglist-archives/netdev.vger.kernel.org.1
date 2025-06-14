Return-Path: <netdev+bounces-197689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A26ABAD9957
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 03:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE5D7A5E20
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2BB8836;
	Sat, 14 Jun 2025 01:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="u3sUm2a3";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="VY3kzkjM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 002A123DE
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 01:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749863268; cv=none; b=dkNkC2JRdCD5ifYdQ50ej78UqoUGVvlicDWlO0E70Zq+/+/RBJ7g3ZUVsX/mbZXLESaJSWavyF1vVVl3yFjUg4aBs4BsVmZN3Fj5+7Ux7m/0uRry16pdzyqljULZ1+mybHptWZW7jBDKtD/mQxjNFUhYuU/1rslV2v74T3tqbGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749863268; c=relaxed/simple;
	bh=bHwebXTXvtM5k1IGPleV+a+nC7E6PFvaI+nth/FpYYg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mNJtnQJNjn0E/fjnhbW93/XWrjgk8diBZI1jYrvrgFd/QypV34OnmZdiwaRa+J7CL0ELHZPN8nwECIeegT9EUWf7HI4XACG91+kXP6HWhE8Xk7G604MFk7rPpf9GLiq+wW/5iyXHOaSXsioFmBbu1I1twr5WvTNI5qoV90z4Icw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=u3sUm2a3; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=VY3kzkjM; arc=none smtp.client-ip=160.80.4.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 55E17D9C001782;
	Sat, 14 Jun 2025 03:07:18 +0200
Received: from lubuntu-18.04 (unknown [160.80.103.126])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id B2353120589;
	Sat, 14 Jun 2025 03:07:08 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1749863229; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsRAdizTB5hPteuxNm7A1c/ilUnWdKIZGDXEYvaRU9k=;
	b=u3sUm2a3gIYi9VXzCHXW29titq80drEOyvX2ff+eyGA+mOAE/FMVc0fFrw4syE5l9nf1KG
	Gr40q3HC7rL1wfDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1749863229; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NsRAdizTB5hPteuxNm7A1c/ilUnWdKIZGDXEYvaRU9k=;
	b=VY3kzkjM79D9Xq/q4gIxe2t3tm1ADiATT6Z9CruG575ZNyk1bH1cZra3myDgIvFNTAQ54D
	PqOz8U8GuBqrDEiW7MkO2ThDJLzYDoxhkc7xKss50AeYfcNwoLYSgBgksQVI/ypqY6pcXq
	Kmlw8mMOJvv5KddNVweX6c9HAqUGkueGsteQpO9q/aizpV+MzAX1SP8teH1Fz23qGThrL6
	xmCcEV7Iau6BxIlL1aWrNbL8Aj/Ou+569DQ8Yoh/Dk0kwf2Y1hxDhGC0Bz38qSead1Bt8B
	kwPy/pX32NuM+8qgLF9cEq/2Q4upfUWUMh6yFEV9aW6lfRSBxV/K6EHU4p/ALA==
Date: Sat, 14 Jun 2025 03:07:08 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: Ido Schimmel <idosch@nvidia.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <edumazet@google.com>, <dsahern@kernel.org>,
        <horms@kernel.org>, <petrm@nvidia.com>,
        Andrea Mayer
 <andrea.mayer@uniroma2.it>, stefano.salsano@uniroma2.it,
        <paolo.lungaroni@uniroma2.it>
Subject: Re: [PATCH net-next 4/4] selftests: seg6: Add test cases for End.X
 with link-local nexthop
Message-Id: <20250614030708.e08c2b4a6044b6a010cffb4d@uniroma2.it>
In-Reply-To: <20250612122323.584113-5-idosch@nvidia.com>
References: <20250612122323.584113-1-idosch@nvidia.com>
	<20250612122323.584113-5-idosch@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Thu, 12 Jun 2025 15:23:23 +0300
Ido Schimmel <idosch@nvidia.com> wrote:

> In the current test topology, all the routers are connected to each
> other via dedicated links with addresses of the form fcf0:0:x:y::/64.
> 
> The test configures rt-3 with an adjacency with rt-4 and rt-4 with an
> adjacency with rt-1:
> 
>  # ip -n rt_3-IgWSBJ -6 route show tab 90 fcbb:0:300::/48
>  fcbb:0:300::/48  encap seg6local action End.X nh6 fcf0:0:3:4::4 flavors next-csid lblen 32 nflen 16 dev dum0 metric 1024 pref medium
>  # ip -n rt_4-JdCunK -6 route show tab 90 fcbb:0:400::/48
>  fcbb:0:400::/48  encap seg6local action End.X nh6 fcf0:0:1:4::1 flavors next-csid lblen 32 nflen 16 dev dum0 metric 1024 pref medium
> 
> The routes are used when pinging hs-2 from hs-1 and vice-versa.
> 
> Extend the test to also cover End.X behavior with an IPv6 link-local
> nexthop address and an output interface. Configure every router
> interface with an IPv6 link-local address of the form fe80::x:y/64 and
> before re-running the ping tests, replace the previous End.X routes with
> routes that use the new IPv6 link-local addresses:
> 
>  # ip -n rt_3-IgWSBJ -6 route show tab 90 fcbb:0:300::/48
>  fcbb:0:300::/48  encap seg6local action End.X nh6 fe80::4:3 oif veth-rt-3-4 flavors next-csid lblen 32 nflen 16 dev dum0 metric 1024 pref medium
>  # ip -n rt_4-JdCunK -6 route show tab 90 fcbb:0:400::/48
>  fcbb:0:400::/48  encap seg6local action End.X nh6 fe80::1:4 oif veth-rt-4-1 flavors next-csid lblen 32 nflen 16 dev dum0 metric 1024 pref medium
> 
> The new test cases fail without the previous patch ("seg6: Allow End.X
> behavior to accept an oif"):
> 
>  # ./srv6_end_x_next_csid_l3vpn_test.sh
>  [...]
>  ################################################################################
>  TEST SECTION: SRv6 VPN connectivity test hosts (h1 <-> h2, IPv6), link-local
>  ################################################################################
> 
>      TEST: IPv6 Hosts connectivity: hs-1 -> hs-2                         [FAIL]
> 
>      TEST: IPv6 Hosts connectivity: hs-2 -> hs-1                         [FAIL]
> 
>  ################################################################################
>  TEST SECTION: SRv6 VPN connectivity test hosts (h1 <-> h2, IPv4), link-local
>  ################################################################################
> 
>      TEST: IPv4 Hosts connectivity: hs-1 -> hs-2                         [FAIL]
> 
>      TEST: IPv4 Hosts connectivity: hs-2 -> hs-1                         [FAIL]
> 
>  Tests passed:  40
>  Tests failed:   4
> 
> And pass with it:
> 
>  # ./srv6_end_x_next_csid_l3vpn_test.sh
>  [...]
>  ################################################################################
>  TEST SECTION: SRv6 VPN connectivity test hosts (h1 <-> h2, IPv6), link-local
>  ################################################################################
> 
>      TEST: IPv6 Hosts connectivity: hs-1 -> hs-2                         [ OK ]
> 
>      TEST: IPv6 Hosts connectivity: hs-2 -> hs-1                         [ OK ]
> 
>  ################################################################################
>  TEST SECTION: SRv6 VPN connectivity test hosts (h1 <-> h2, IPv4), link-local
>  ################################################################################
> 
>      TEST: IPv4 Hosts connectivity: hs-1 -> hs-2                         [ OK ]
> 
>      TEST: IPv4 Hosts connectivity: hs-2 -> hs-1                         [ OK ]


Thank you for updating the self-test. The changes seem good to me. This way, we
can test both the legacy End.X and the new version with "oif" at the same time. This
also allows us to manage link-locals (through the use of oif).

In this regard, the only thing I would have added is a mention of the use of "oif"
in the description of the new tests, something like:

################################################################################
TEST SECTION: SRv6 VPN connectivity test hosts (h1 <-> h2, IPv4), link-local+oif
################################################################################

(However, I don't think this small change is enough to require a new version of
this patch.)

> 
>  Tests passed:  44
>  Tests failed:   0
> 
> Without the previous patch, rt-3 and rt-4 resolve the wrong routes for
> the link-local nexthops, with the output interface being the input
> interface:
> 
>  # perf script
>  [...]
>  ping    1067 [001]    37.554486: fib6:fib6_table_lookup: table 254 oif 0 iif 11 proto 41 cafe::254/0 -> fe80::4:3/0 flowlabel 0xb7973 tos 0 scope 0 flags 2 ==> dev veth-rt-3-1 gw :: err 0
>  [...]
>  ping    1069 [002]    41.573360: fib6:fib6_table_lookup: table 254 oif 0 iif 12 proto 41 cafe::254/0 -> fe80::1:4/0 flowlabel 0xb7973 tos 0 scope 0 flags 2 ==> dev veth-rt-4-2 gw :: err 0
> 
> But the correct routes are resolved with the patch:
> 
>  # perf script
>  [...]
>  ping    1066 [006]    30.672355: fib6:fib6_table_lookup: table 254 oif 13 iif 1 proto 41 cafe::254/0 -> fe80::4:3/0 flowlabel 0x85941 tos 0 scope 0 flags 6 ==> dev veth-rt-3-4 gw :: err 0
>  [...]
>  ping    1066 [006]    30.672411: fib6:fib6_table_lookup: table 254 oif 11 iif 1 proto 41 cafe::254/0 -> fe80::1:4/0 flowlabel 0x91de0 tos 0 scope 0 flags 6 ==> dev veth-rt-4-1 gw :: err 0
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  .../net/srv6_end_x_next_csid_l3vpn_test.sh    | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)

Reviewed-by: Andrea Mayer <andrea.mayer@uniroma2.it>

