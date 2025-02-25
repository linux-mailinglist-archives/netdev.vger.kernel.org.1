Return-Path: <netdev+bounces-169494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED40BA4436D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 15:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5075B421A4C
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 14:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A288A26981F;
	Tue, 25 Feb 2025 14:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNv0+FgK"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12F626A0DE
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 14:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494611; cv=none; b=EMqNSw1F1p+tYKWONnHHLvnZFCwsJsNvlZMWpjA5eCp36oIbXCX5abq4LSHeB0Kse6zaOPsNBBoeH7tqDVQSGB+EaWZIGBDeqP1NVnADtmX1iGXENMtQBNt0Czb/k2UhQyGT+nNHpAHJPd+eBRBREFFNGoMTvKGE1lb/JOABGQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494611; c=relaxed/simple;
	bh=rNfPY9Ec1gT7srURrjS6mHAUkg45nkUtkR/r2lnjrL4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z79E4aCkxBwhrrFWvKeJuZROOBwd0x5KRXUIion/DISGrm7kW2x9fc0rIS/7tYAApVxNVTON7l2PaQwJ8yEzd+CzoQ5zaTWQdoX0/dDLIELnNKr9ly8TZDHhn1/xYbxp9svQg9UuVkT2nf7vn1645Xzz039gvGGruZmmJPbZQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SNv0+FgK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740494608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=R8ApZ46Ch4DdgH21/XYslEC5J5a4Yj/5VMi4/FxXMzM=;
	b=SNv0+FgKqbVe84e27MqZJsm8SmYqp4mZ3eFYLQpKYuY0O0whgwMhiCvSfXiguvongGW8LU
	mc4eWyQs3jX70cq6G+V08Ou6VPv8WZ0kkXIlwtSCZgePutuEGq2JWktgVP9mgqqfO4XTIJ
	JO2V/tWmaPWHlg+6zFeB5nepCwiZQ+s=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-aZJeE26MO5KccrUs65rUBQ-1; Tue, 25 Feb 2025 09:43:26 -0500
X-MC-Unique: aZJeE26MO5KccrUs65rUBQ-1
X-Mimecast-MFC-AGG-ID: aZJeE26MO5KccrUs65rUBQ_1740494604
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4394c0a58e7so45749245e9.0
        for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 06:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740494604; x=1741099404;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8ApZ46Ch4DdgH21/XYslEC5J5a4Yj/5VMi4/FxXMzM=;
        b=g85JjhcAOBo1fxXjAUScxEoxiRX9VJZwYoN5QS35C6Z99+qxZru4PoyumnCrqHrmW7
         ly83E0RjuUsCVlJ8QLq4/qSjRCMl+AZ2gTGlsl0zPQsWiIiE/IWQSca1YnLktBxnfooH
         3Du1veY9esgu/rkIWFPZpncTNI2ftSvC1QruRnrpoMJiwb9NvIlNfSNgH04ToZ4RoEtT
         1JsROeM5JsK6lPnhz5KSjSZ+pO+wtUKHQo28t+Y5qG5h7AnvnshA9bb86cdCTCgnXiOl
         x8MrCHhU5zt/iUL1iZgdmjde6YBYzOz9Gx62P/iTLTgOOVvJVp1bFIF66GdHSMpWtuiz
         qa9g==
X-Gm-Message-State: AOJu0YxnYZGBVIV4txuTuyYzMbQ6fGk2X/7gm6htDTIpzIJAUHglLO9A
	nNBHF5mmEI6W7BSJkwasBVACqXG6z+txzzcYATJPYdL3wku+Lo2SRHZeVOFbOHbsbiT7VbWnNHp
	4bvXZAb1A82vTzlGdtCHfwDkxhyg2aTju+uFz0K1K803HBi8O+Yux2g==
X-Gm-Gg: ASbGncuRd9p8nKIGjJcP+Lg57ijyDn/6sUBT1SWvGDkDwp9bdPWEbJddNVrlTc67b5S
	hedOobfk2GKHQsG32jUd/CgIhdOC6ZcV1VcXF3E378E1cfE2+aq7JnCEFWGQAq2ZZGC7vtKA31Q
	ywuy3+hnER4nCY/rZC+cwkbLWmPcY6vqtPc2jOSWakBZonWCtAdZX3OGLf063rPyoGMqYnM9CM4
	L4lDZZM2q51rJDKDJqHxtTdeVo4mUgaJBDFXKNzGFMFF2DiXdH+GqCh85OPvcbGYH/Fl/6uzpHe
	1Qc=
X-Received: by 2002:a05:600c:4592:b0:439:94ef:3780 with SMTP id 5b1f17b1804b1-439aebe4a26mr175804365e9.30.1740494603616;
        Tue, 25 Feb 2025 06:43:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEi411SxDgUCiueJgxAGdbZdpqKptcF/TYXshtxRyzxqkaEmxz+p4b7thx0G0OxWNTyDNpSJA==
X-Received: by 2002:a05:600c:4592:b0:439:94ef:3780 with SMTP id 5b1f17b1804b1-439aebe4a26mr175804145e9.30.1740494603276;
        Tue, 25 Feb 2025 06:43:23 -0800 (PST)
Received: from debian ([2001:4649:f075:0:a45e:6b9:73fc:f9aa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ab155ebbfsm27937545e9.28.2025.02.25.06.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:43:22 -0800 (PST)
Date: Tue, 25 Feb 2025 15:43:20 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ido Schimmel <idosch@idosch.org>
Subject: [PATCH net v3 1/2] gre: Fix IPv6 link-local address generation.
Message-ID: <dd92b7f4b6bb81ce64e304381bedaf0d15ff5613.1740493813.git.gnault@redhat.com>
References: <cover.1740493813.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1740493813.git.gnault@redhat.com>

Use addrconf_addr_gen() to generate IPv6 link-local addresses on GRE
devices in most cases and fall back to using add_v4_addrs() only in
case the GRE configuration is incompatible with addrconf_addr_gen().

GRE used to use addrconf_addr_gen() until commit e5dd729460ca
("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL
address") restricted this use to gretap and ip6gretap devices, and
created add_v4_addrs() (borrowed from SIT) for non-Ethernet GRE ones.

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

Fixes: e5dd729460ca ("ip/ip6_gre: use the same logic as SIT interfaces when computing v6LL address")
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
v3: Rework commit message to make it clearer which types of GRE devices
    we're talking about (Ido).
v2: No changes.

 net/ipv6/addrconf.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index ac8cc1076536..8b6258819dad 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3209,16 +3209,13 @@ static void add_v4_addrs(struct inet6_dev *idev)
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
@@ -3529,7 +3526,13 @@ static void addrconf_gre_config(struct net_device *dev)
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


