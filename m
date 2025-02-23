Return-Path: <netdev+bounces-168822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86A51A40F19
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 14:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A16D1690B0
	for <lists+netdev@lfdr.de>; Sun, 23 Feb 2025 13:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A28C204F7A;
	Sun, 23 Feb 2025 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="7fBF7+Bl"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7179638DC8
	for <netdev@vger.kernel.org>; Sun, 23 Feb 2025 13:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740316575; cv=none; b=VtqXI/HKQruNnZTl7ycLGkBO02DYJtDyONQkJsGA5KxwON8RWMHrAMEwWUSphlzHObGBsdL7LoLkZ7yk524ZjMBHQ1vzSW4yFO1jUGvyFfWCAHRFuC3GMpA5BCFtPV6WH8epKnGyrcCwcQLGDdJ/8uDnQEqfp/pnKwU+47p7E6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740316575; c=relaxed/simple;
	bh=qmkq5PdbzeRDY1ZpreJU4e+m37OlLvNhdKhx8x2GbRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjkfvEoOjqUCMIey5U4C1+CvPuyHlRJxE2hbe/MZ1ZI2QurH0JCYgrBMgrB4ZKF2lWRQaQ5eRqiVO9XqGW5M+C+hILuxtioWAz0dF4P/yDicqEGqe1VEPfUI7HOhYR9BSz60E3HJbu4Mrq4uu1q3iyZsQ8ICOUx+6bEzKao5FKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=7fBF7+Bl; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1BA5B2540121;
	Sun, 23 Feb 2025 08:16:12 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Sun, 23 Feb 2025 08:16:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1740316571; x=1740402971; bh=CVEz9ZlaQECaI1Oc/Jr8q5AMWOxP9cZbMEx
	toC7jxFA=; b=7fBF7+Bl+Ral6HRAyZgg5O+BjbB06nB/wMWscA4QGth0I8YqXiM
	jngP1OC1rgRtvHvP9O+YvPO5YxqEZJp/bhPSNvPkgEax9mwMphX9oxDIQFTi4pmp
	+88BNCnLITZ66+qElKHc8ztIOBeC9tS0xpvGteYskqtNq/2oAptXLhFtVw/+0FML
	GgrTmY8kokBIMS6MaorL4FHEeU8PAfIDUeHkrE84TUL+wkpcKoeBJJ/YIWJqnc/n
	q/JMqGHeZanAgqq4geUSZvZtwZDO3PBozAGonJJoncvooGxporzL41ii8+NWRVIU
	YCOrr/Rw0LeSx+1LXAX08wnex/jy7ms/1iw==
X-ME-Sender: <xms:mx-7Z3sRAxlao4yd08ucMPmnQHr9TDRAYuCpWNCw8uNc3ZPIXJisAA>
    <xme:mx-7Z4cPXXcHqJ1yvYP9V-fOcZ0Pxw_7yPsrDrTC9ya_sZJswPg9p-hpb1qSkqwE1
    6NcX7lcU0ohn3g>
X-ME-Received: <xmr:mx-7Z6w-Z8jmBdV-NreIqSZV_GPuir4y7DSL46R059QWYKiEb_2A2o18hahS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejheelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddv
    necuhfhrohhmpefkughoucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrd
    horhhgqeenucggtffrrghtthgvrhhnpedvudefveekheeugeeftddvveefgfduieefudei
    fefgleekheegleegjeejgeeghfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhgpdhnsggprhgtphht
    thhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgnhgruhhlthesrhgvug
    hhrghtrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdp
    rhgtphhtthhopehkuhgsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnh
    hisehrvgguhhgrthdrtghomhdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgv
    rdgtohhmpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohephhhorhhmsheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepughsrghh
    vghrnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghnthhonhhiohesmhgrnhguvg
    hlsghithdrtghomh
X-ME-Proxy: <xmx:mx-7Z2Ojt0m3PAvSSXF2MIR1NzHUmPPDeB1J4V2KcX4pdd8MagziiQ>
    <xmx:mx-7Z39HgxWgBfGyisASuzIxqlLVnl4bYhhtj-CfF6iv3c8H6KATkg>
    <xmx:mx-7Z2UnHKcqIKVledy1rdL-DepOqxvm2z7_ZCHjTJOCH2_EE5RuRQ>
    <xmx:mx-7Z4cVG8xc2uALq1B1q74-RFwX7zWMkNo7YnX2XDMvcvpX3-dWSw>
    <xmx:mx-7ZzQqU85CCsl2pRbYNkva74t1P6E5UWKzKOY6ZQT4_G51afH12Umi>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 23 Feb 2025 08:16:10 -0500 (EST)
Date: Sun, 23 Feb 2025 15:16:08 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Guillaume Nault <gnault@redhat.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>
Subject: Re: [PATCH net v2 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <Z7sfmLG4V_kHKRfy@shredder>
References: <cover.1740129498.git.gnault@redhat.com>
 <942aa62423e0d7721abd99a5ca1069f4e4901a6d.1740129498.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <942aa62423e0d7721abd99a5ca1069f4e4901a6d.1740129498.git.gnault@redhat.com>

On Fri, Feb 21, 2025 at 10:24:04AM +0100, Guillaume Nault wrote:
> Use addrconf_addr_gen() to generate IPv6 link-local addresses on GRE
> devices in most cases and fall back to using add_v4_addrs() only in
> case the GRE configuration is incompatible with addrconf_addr_gen().
> 
> GRE used to use addrconf_addr_gen() until commit e5dd729460ca
> ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL
> address") restricted this use to gretap devices and created

It's not always clear throughout the commit message to which devices you
are referring to. For example, here, by "gretap" you mean both "gretap"
and "ip6gretap", no?

BTW, I believe the check against 'ARPHRD_ETHER' in addrconf_gre_config()
is dead code. addrconf_gre_config() is only called for ARPHRD_IP{,6}GRE
devices.

> add_v4_addrs() (borrowed from SIT) for non-Ethernet GRE ones.
> 
> The original problem came when commit 9af28511be10 ("addrconf: refuse
> isatap eui64 for INADDR_ANY") made __ipv6_isatap_ifid() fail when its
> addr parameter was 0. The commit says that this would create an invalid
> address, however, I couldn't find any RFC saying that the generated
> interface identifier would be wrong. Anyway, since plain gre devices
> pass their local tunnel address to __ipv6_isatap_ifid(), that commit
> broke their IPv6 link-local address generation when the local address
> was unspecified.

By "plain gre devices" you mean "ipgre"? Because addrconf_ifid_ip6tnl()
is called for "ip6gre" and it doesn't fail, unlike __ipv6_isatap_ifid().

> 
> Then commit e5dd729460ca ("ip/ip6_gre: use the same logic as SIT
> interfaces when computing v6LL address") tried to fix that case by
> defining add_v4_addrs() and calling it to generated the IPv6 link-local

s/generated/generate/

> address instead of using addrconf_addr_gen() (appart for gretap devices

s/appart/apart/

> which would still use the regular addrconf_addr_gen(), since they have
> a MAC address).

Assuming what I wrote is correct, I'm not sure why e5dd729460ca didn't
restrict the fix to "ipgre" and applied it to "ip6gre" as well.

> 
> That broke several use cases because add_v4_addrs() isn't properly
> integrated into the rest of IPv6 Neighbor Discovery code. Several of
> these shortcomings have been fixed over time, but add_v4_addrs()
> remains broken on several aspects. In particular, it doesn't send any
> Router Sollicitations, so the SLAAC process doesn't start until the
> interface receives a Router Advertisement. Also, add_v4_addrs() mostly
> ignores the address generation mode of the interface
> (/proc/sys/net/ipv6/conf/*/addr_gen_mode), thus breaking the
> IN6_ADDR_GEN_MODE_RANDOM and IN6_ADDR_GEN_MODE_STABLE_PRIVACY cases.
> 
> Fix all this by reverting to addrconf_addr_gen() in all cases but the
> very specific one that remains incompatible.
> 
> Fix the situation by using add_v4_addrs() only in the specific scenario
> where normal method would fail. That is, for interfaces that have all
> of the following characteristics:
> 
>   * transport IP packets directly, not Ethernet (that is, not gretap),
>   * run over IPv4,
>   * tunnel endpoint is INADDR_ANY (that is, 0),
>   * device address generation mode is EUI64.
> 
> In all other cases, revert back to the regular addrconf_addr_gen().
> 
> Also, remove the special case for ip6gre interfaces in add_v4_addrs(),
> since ip6gre devices now always use addrconf_addr_gen() instead.
> 
> Fixes: e5dd729460ca ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL address")
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>  net/ipv6/addrconf.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index ac8cc1076536..8b6258819dad 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -3209,16 +3209,13 @@ static void add_v4_addrs(struct inet6_dev *idev)
>  	struct in6_addr addr;
>  	struct net_device *dev;
>  	struct net *net = dev_net(idev->dev);
> -	int scope, plen, offset = 0;
> +	int scope, plen;
>  	u32 pflags = 0;
>  
>  	ASSERT_RTNL();
>  
>  	memset(&addr, 0, sizeof(struct in6_addr));
> -	/* in case of IP6GRE the dev_addr is an IPv6 and therefore we use only the last 4 bytes */
> -	if (idev->dev->addr_len == sizeof(struct in6_addr))
> -		offset = sizeof(struct in6_addr) - 4;
> -	memcpy(&addr.s6_addr32[3], idev->dev->dev_addr + offset, 4);
> +	memcpy(&addr.s6_addr32[3], idev->dev->dev_addr, 4);
>  
>  	if (!(idev->dev->flags & IFF_POINTOPOINT) && idev->dev->type == ARPHRD_SIT) {
>  		scope = IPV6_ADDR_COMPATv4;
> @@ -3529,7 +3526,13 @@ static void addrconf_gre_config(struct net_device *dev)
>  		return;
>  	}
>  
> -	if (dev->type == ARPHRD_ETHER) {
> +	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
> +	 * unless we have an IPv4 GRE device not bound to an IP address and
> +	 * which is in EUI64 mode (as __ipv6_isatap_ifid() would fail in this
> +	 * case). Such devices fall back to add_v4_addrs() instead.
> +	 */
> +	if (!(dev->type == ARPHRD_IPGRE && *(__be32 *)dev->dev_addr == 0 &&

Doesn't this mean that the 'ARPHRD_IP6GRE' case (and the
'CONFIG_IPV6_GRE' checks) can be removed from
addrconf_init_auto_addrs()? That is, only call addrconf_gre_config() for
"ipgre", but not for "ip6gre".

> +	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64)) {
>  		addrconf_addr_gen(idev, true);
>  		return;
>  	}
> -- 
> 2.39.2
> 
> 

