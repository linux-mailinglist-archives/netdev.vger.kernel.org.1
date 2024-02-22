Return-Path: <netdev+bounces-73931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6F785F611
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 11:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2C81F25C87
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 10:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16DC640BEA;
	Thu, 22 Feb 2024 10:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yf6YNEMR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717583FB2E
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599026; cv=none; b=a/8H4Ft7JsNLeFNEZ1ZJvCUcMxZ9H+X6ZZ76l99hb//kV13cwjNMiEEWWu2/0DRnBk1QqSkt6DjKjVr1HydPwbj/3/jQj2V25FAHn4RfIeS+wVok7Q9UZRd17M+raMVdclNXi6KU7vuWMUbu85qOr1fpBbOTTXUNlErZ8licv40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599026; c=relaxed/simple;
	bh=wbrG0QT4aXp7xUnKeM8twR1WKmTe/6sfzfRf36QYyvA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mHZROfAjMV6dJsBGZQlTlcbehv/MScO+lhdN2eApT2xV7ZeTsd9sJyqdl51p6mDXuqH6lm8PwnlmPrzMyyr5tF6vqolGbLuRn0R6kzvZBDt0B9ZEMbUzXjYB8jX+PeYJdwNP1ZnKNCgot7ve0psoZewxy+1wSKsJx331KqW+gz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yf6YNEMR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcd94cc48a1so13524813276.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 02:50:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708599023; x=1709203823; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xYm3V2Z4GOBVSKCpv9wKIBpXwW0wEyBg3yOVPQbP2C0=;
        b=yf6YNEMRsuszdReDDNY2ukzEgqV2yYybIFJBXHzKsGaTSSy7Djo3PN5VXmG0jWygPc
         gAqx5iNS+yHSYw0aLdfYNWhxSjh72tAC6Bb+02FlAxRCX4PozLX6VD/GgMAK1CMm+p1T
         Vt0um6Gz9b4ZKnVecwOpnykMotBUzmx0GMDaZOHNxVar2zrlSLIsGWoTNeYHIuJ0G1ks
         QlH7mad9G738tIeylsEViSF0d1X3A29pYDSmAubiWOLX0io9KMJ7Gs0v19z61yFhW89P
         sUb/s0tF4IklJaQm03HABwMZ2dLN5KwJVdva4AJIqnc5gATx1nmNcH82AGuvLrhYNdVS
         JltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599023; x=1709203823;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xYm3V2Z4GOBVSKCpv9wKIBpXwW0wEyBg3yOVPQbP2C0=;
        b=Jkufazbx3a9x4FJ11ujp/CWYe14rC0GAkOU9qXoyfX9CSlq+eTdEMcWlhyIeeRa8n+
         ofrwAtBTWE21FZ0DAlXrXoZVS5yf2fTg9Fl62I8mJ0oVfkVMfwgBiSOuG8zQgV7g2jdZ
         xe5XgcxzPwKNBQvdlAu9CR4rRl6/mxbVWjpp758hhq22+DXv1GeEZmeMXsrQiVVJzc4K
         G0WI3jjrFrKCacjs8h0BKXH9LI5FBd4/niMdo/48j52d9+oto48gvPde2McpaED3w0Ch
         pzRvUQUZ3ezmNqBVgGHjvXEX82a8jpja0MBhudNhvZsOA1WDVc0VwoXpR048mZPSt8sc
         lHhw==
X-Gm-Message-State: AOJu0YzI6z7LKf0a6oNB3VMnEXL8m1t3Y6DT6M4f/UP374OtiZR7r04U
	THV6+UH6yBrCpiRhtGaLkjVMVIYPCewPOhwHQYO/0QjcNCgV91TQPe/RdmZ9fhfK1M81eyl9J23
	4OrmGEUVMBQ==
X-Google-Smtp-Source: AGHT+IHCNedpPnRctZxlXtZ+3JyvRmQtXFvGHrLqrfQlFna7+TtOR8E5K5clCmeI65nrneiB/R8q9z++5c44bg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:70b:b0:dcd:3172:7265 with SMTP
 id k11-20020a056902070b00b00dcd31727265mr511407ybt.8.1708599023469; Thu, 22
 Feb 2024 02:50:23 -0800 (PST)
Date: Thu, 22 Feb 2024 10:50:07 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240222105021.1943116-1-edumazet@google.com>
Subject: [PATCH v2 net-next 00/14] rtnetlink: reduce RTNL pressure for dumps
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series restarts the conversion of rtnl dump operations
to RCU protection, instead of requiring RTNL.

In this new attempt (prior one failed in 2011), I chose to
allow a gradual conversion of selected operations.

After this series, "ip -6 addr" and "ip -4 ro" no longer
need to acquire RTNL.

I refrained from changing inet_dump_ifaddr() and inet6_dump_addr()
to avoid merge conflicts because of two fixes in net tree.

I also started the work for "ip link" future conversion.

v2: rtnl_fill_link_ifmap() always emit IFLA_MAP (Jiri Pirko)
    Added "nexthop: allow nexthop_mpath_fill_node()
           to be called without RTNL" to avoid a lockdep splat (Ido Schimmel)

Eric Dumazet (14):
  rtnetlink: prepare nla_put_iflink() to run under RCU
  ipv6: prepare inet6_fill_ifla6_attrs() for RCU
  ipv6: prepare inet6_fill_ifinfo() for RCU protection
  ipv6: use xarray iterator to implement inet6_dump_ifinfo()
  netlink: fix netlink_diag_dump() return value
  netlink: hold nlk->cb_mutex longer in __netlink_dump_start()
  rtnetlink: change nlk->cb_mutex role
  rtnetlink: add RTNL_FLAG_DUMP_UNLOCKED flag
  ipv6: switch inet6_dump_ifinfo() to RCU protection
  inet: allow ip_valid_fib_dump_req() to be called with RTNL or RCU
  nexthop: allow nexthop_mpath_fill_node() to be called without RTNL
  inet: switch inet_dump_fib() to RCU protection
  rtnetlink: make rtnl_fill_link_ifmap() RCU ready
  rtnetlink: provide RCU protection to rtnl_fill_prop_list()

 drivers/infiniband/ulp/ipoib/ipoib_main.c     |   4 +-
 drivers/net/can/vxcan.c                       |   2 +-
 .../net/ethernet/qualcomm/rmnet/rmnet_vnd.c   |   2 +-
 drivers/net/ipvlan/ipvlan_main.c              |   2 +-
 drivers/net/macsec.c                          |   2 +-
 drivers/net/macvlan.c                         |   2 +-
 drivers/net/netkit.c                          |   2 +-
 drivers/net/veth.c                            |   2 +-
 drivers/net/wireless/virtual/virt_wifi.c      |   2 +-
 include/linux/netdevice.h                     |   6 +-
 include/linux/netlink.h                       |   2 +
 include/net/ip_fib.h                          |   1 +
 include/net/nexthop.h                         |   2 +-
 include/net/rtnetlink.h                       |   1 +
 net/8021q/vlan_dev.c                          |   4 +-
 net/core/dev.c                                |   6 +-
 net/core/rtnetlink.c                          |  36 +--
 net/dsa/user.c                                |   2 +-
 net/ieee802154/6lowpan/core.c                 |   2 +-
 net/ipv4/fib_frontend.c                       |  50 ++--
 net/ipv4/fib_trie.c                           |   4 +-
 net/ipv4/ipmr.c                               |   4 +-
 net/ipv6/addrconf.c                           | 222 +++++++++---------
 net/ipv6/ip6_fib.c                            |   7 +-
 net/ipv6/ip6_tunnel.c                         |   2 +-
 net/ipv6/ip6mr.c                              |   4 +-
 net/ipv6/ndisc.c                              |   2 +-
 net/mpls/af_mpls.c                            |   4 +-
 net/netlink/af_netlink.c                      |  46 ++--
 net/netlink/af_netlink.h                      |   5 +-
 net/netlink/diag.c                            |   2 +-
 net/xfrm/xfrm_interface_core.c                |   2 +-
 32 files changed, 238 insertions(+), 198 deletions(-)

-- 
2.44.0.rc1.240.g4c46232300-goog


