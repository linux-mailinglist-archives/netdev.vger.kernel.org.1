Return-Path: <netdev+bounces-187541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0C3AA7C8E
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 00:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1770B1C005BD
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 22:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E32215795;
	Fri,  2 May 2025 22:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AjATEnH8"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CA421C9F6
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 22:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746226682; cv=none; b=NmxY2Nj1XDn9eVxNRps++JUk1dZIx1/wFgfKlBwyeHiU+WTiRBDdUS07qriP1NrQAfCfFkJQHOAtIFV1sKqRSsonxEfC0iLdI16W+w9byrjuyfZeGCXEbKXYnFxywtO+6jzfhFzdmPjHVcxbbCFDKJ+g0QL8DcTx/p0yLuVroZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746226682; c=relaxed/simple;
	bh=Vn9evJuoDwHtrjoasodbCvVS34ChztIbJX4RL0uFDi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q5XwiOd3g07V1z9nZyjJLAvbu0rRRdAB8/FDBGjx1U2HKv1Xfm+l8h5UTeWBNoJFpQ7jab5Mu6MAE8Z+5yo0tAlDHgZYFk9CnWp7V625HEyM+CpmKZDPXTfgM5Og3lWivDEEXIsWub5189H9sYhXqx5rb7m8lxd/j7d2P8UTDXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AjATEnH8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746226679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yap2iyEJZKzsJHYVFNexo1WNo5CEdfj8YrlgDf9dgF4=;
	b=AjATEnH8f1lc35hQ1wshbdpG9Ps6r1OfGajnWYPEBc7HxvsVNaR+ovntLZvJiG3VaD/C4x
	mILoXCDK9yiPgcW9xCnqfqFb9ruTQghMDo2ycbrJK8jdmMF/hAS1M2JAHUYvg30vvJtO1+
	rYKSMSHD39bOgvVH08cyjFxtBTt090w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-1z_5o946NUCsdwQfA_4AeQ-1; Fri, 02 May 2025 18:57:56 -0400
X-MC-Unique: 1z_5o946NUCsdwQfA_4AeQ-1
X-Mimecast-MFC-AGG-ID: 1z_5o946NUCsdwQfA_4AeQ_1746226676
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d3b211d0eso14723515e9.1
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 15:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746226675; x=1746831475;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yap2iyEJZKzsJHYVFNexo1WNo5CEdfj8YrlgDf9dgF4=;
        b=GZZkbVdTIVRpY8hpOkQV1wG/vLQ0+QMz6sOpRG5ZRoiin680Y8zJOrrZijOq9CuDXt
         TtjNIE+dHCBM26mq9BSBhHm9j6B+cyF5vfhWZAj+AiyKAvIug+V7mE4vPKtSjyP4RfqM
         GTskz/dKOHGNMCVH4ww+5oKEkpWZ50cuApb+viNLR0TtIz9IPfVsBrt0a7/NhUj3IlxR
         PpqOfHh8L3hzCyx5I18R35ctzL24CVscIqZUTcje3p5iFTTqsR57ipKfexhy8AcB8yXD
         TwTCylEyoh7NF5eOxA4UFddk7OZMPPqlAzDNuUEBePHWFzY0qc1lQOmFE1AbLNWpKmFt
         4l4A==
X-Gm-Message-State: AOJu0Yz5r8BMsWBMSDsaQ4gT5BZQvLWhx1PYRWAwZwOZZQ+TDVtdXN1B
	Bu1t4gtVNJcUdtzHHDfX8Ntx0N4LY+KbgtVfdcG6xQ2SOZDw9/wUL9xla77laLya1eXEs0CE9yZ
	1tVP/o/rFerB0NZITdMk3rebDHchX7Px0L4nPN95ix95MWQbVD35dHQ==
X-Gm-Gg: ASbGnctJ1lDxtYHYgxDB66+3WWGSX0lIyzt3Lll7MHsL/R6NIPozWRFAaq4nYdIHra0
	rEDCNN8f4N8hB1DjXwKFt+CyOSSol2vjL0navGN+6Rpx+6s8Hw2uYqSWo5THBJ1ruwSjEq5wyjN
	lsHmxGTGzKUPrP9/9yswStLZfWV/bs1g1Vwh7/hPR1+upnN3Qsn2PDaZdS9xKgjo+o7aUxvcwgu
	UxIBh+mCHwNqk7RACk3qwVg7NkPeDR0NWDnelOFTqLg6v9ctIZmgtEZpk1HP9qTS8QcdYDptGTR
	pN0pVtDqmfwXcyRnVOgWUsPe5wwrU44NnpGPXDdwo4wqFho/KN2WG4guxPPEJzsUBQ==
X-Received: by 2002:a05:600c:1986:b0:43b:4829:8067 with SMTP id 5b1f17b1804b1-441b72b9595mr66849045e9.6.1746226675557;
        Fri, 02 May 2025 15:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuECNd4OSaArsLq/F6M8W8R7YP/l23+F1CmLEYYJ+KxAkW4oRml3h+Uh5ZS+rirMfDc5ZiLA==
X-Received: by 2002:a05:600c:1986:b0:43b:4829:8067 with SMTP id 5b1f17b1804b1-441b72b9595mr66848955e9.6.1746226675110;
        Fri, 02 May 2025 15:57:55 -0700 (PDT)
Received: from debian (2a01cb058918ce003eb206d926357af7.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:3eb2:6d9:2635:7af7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b2b28796sm102152605e9.33.2025.05.02.15.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 15:57:54 -0700 (PDT)
Date: Sat, 3 May 2025 00:57:52 +0200
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>,
	Stanislav Fomichev <stfomichev@gmail.com>,
	Petr Machata <petrm@nvidia.com>
Subject: [PATCH net 1/2] gre: Fix again IPv6 link-local address generation.
Message-ID: <a88cc5c4811af36007645d610c95102dccb360a6.1746225214.git.gnault@redhat.com>
References: <cover.1746225213.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1746225213.git.gnault@redhat.com>

Use addrconf_addr_gen() to generate IPv6 link-local addresses on GRE
devices in most cases and fall back to using add_v4_addrs() only in
case the GRE configuration is incompatible with addrconf_addr_gen().

GRE used to use addrconf_addr_gen() until commit e5dd729460ca ("ip/ip6_gre:
use the same logic as SIT interfaces when computing v6LL address")
restricted this use to gretap and ip6gretap devices, and created
add_v4_addrs() (borrowed from SIT) for non-Ethernet GRE ones.

The original problem came when commit 9af28511be10 ("addrconf: refuse
isatap eui64 for INADDR_ANY") made __ipv6_isatap_ifid() fail when its
addr parameter was 0. The commit says that this would create an invalid
address, however, I couldn't find any RFC saying that the generated
interface identifier would be wrong. Anyway, since gre over IPv4
devices pass their local tunnel address to __ipv6_isatap_ifid(), that
commit broke their IPv6 link-local address generation when the local
address was unspecified.

Then commit e5dd729460ca ("ip/ip6_gre: use the same logic as SIT
interfaces when computing v6LL address") tried to fix that case by
defining add_v4_addrs() and calling it to generate the IPv6 link-local
address instead of using addrconf_addr_gen() (apart for gretap and
ip6gretap devices, which would still use the regular
addrconf_addr_gen(), since they have a MAC address).

That broke several use cases because add_v4_addrs() isn't properly
integrated into the rest of IPv6 Neighbor Discovery code. Several of
these shortcomings have been fixed over time, but add_v4_addrs()
remains broken on several aspects. In particular, it doesn't send any
Router Sollicitations, so the SLAAC process doesn't start until the
interface receives a Router Advertisement. Also, add_v4_addrs() mostly
ignores the address generation mode of the interface
(/proc/sys/net/ipv6/conf/*/addr_gen_mode), thus breaking the
IN6_ADDR_GEN_MODE_RANDOM and IN6_ADDR_GEN_MODE_STABLE_PRIVACY cases.

Fix the situation by using add_v4_addrs() only in the specific scenario
where the normal method would fail. That is, for interfaces that have
all of the following characteristics:

  * run over IPv4,
  * transport IP packets directly, not Ethernet (that is, not gretap
    interfaces),
  * tunnel endpoint is INADDR_ANY (that is, 0),
  * device address generation mode is EUI64.

In all other cases, revert back to the regular addrconf_addr_gen().

Also, remove the special case for ip6gre interfaces in add_v4_addrs(),
since ip6gre devices now always use addrconf_addr_gen() instead.

Note:
  This patch was originally applied as commit 183185a18ff9 ("gre: Fix
  IPv6 link-local address generation."). However, it was then reverted
  by commit fc486c2d060f ("Revert "gre: Fix IPv6 link-local address
  generation."") because it uncovered another bug that ended up
  breaking net/forwarding/ip6gre_custom_multipath_hash.sh. That other
  bug has now been fixed by commit 4d0ab3a6885e ("ipv6: Start path
  selection from the first nexthop"). Therefore we can now revive this
  GRE patch (no changes since original commit 183185a18ff9 ("gre: Fix
  IPv6 link-local address generation.").

Fixes: e5dd729460ca ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL address")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 net/ipv6/addrconf.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 9ba83f0c9928..c6b22170dc49 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3214,16 +3214,13 @@ static void add_v4_addrs(struct inet6_dev *idev)
 	struct in6_addr addr;
 	struct net_device *dev;
 	struct net *net = dev_net(idev->dev);
-	int scope, plen, offset = 0;
+	int scope, plen;
 	u32 pflags = 0;
 
 	ASSERT_RTNL();
 
 	memset(&addr, 0, sizeof(struct in6_addr));
-	/* in case of IP6GRE the dev_addr is an IPv6 and therefore we use only the last 4 bytes */
-	if (idev->dev->addr_len == sizeof(struct in6_addr))
-		offset = sizeof(struct in6_addr) - 4;
-	memcpy(&addr.s6_addr32[3], idev->dev->dev_addr + offset, 4);
+	memcpy(&addr.s6_addr32[3], idev->dev->dev_addr, 4);
 
 	if (!(idev->dev->flags & IFF_POINTOPOINT) && idev->dev->type == ARPHRD_SIT) {
 		scope = IPV6_ADDR_COMPATv4;
@@ -3534,7 +3531,13 @@ static void addrconf_gre_config(struct net_device *dev)
 		return;
 	}
 
-	if (dev->type == ARPHRD_ETHER) {
+	/* Generate the IPv6 link-local address using addrconf_addr_gen(),
+	 * unless we have an IPv4 GRE device not bound to an IP address and
+	 * which is in EUI64 mode (as __ipv6_isatap_ifid() would fail in this
+	 * case). Such devices fall back to add_v4_addrs() instead.
+	 */
+	if (!(dev->type == ARPHRD_IPGRE && *(__be32 *)dev->dev_addr == 0 &&
+	      idev->cnf.addr_gen_mode == IN6_ADDR_GEN_MODE_EUI64)) {
 		addrconf_addr_gen(idev, true);
 		return;
 	}
-- 
2.39.2


