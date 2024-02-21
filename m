Return-Path: <netdev+bounces-73615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A06085D639
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 12:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F12CF1F23EF6
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8C63F9D2;
	Wed, 21 Feb 2024 10:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vs0v/ZWL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96D3EA97
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 10:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513160; cv=none; b=r8Y/2CbinrWvE+HvLhYn1O4gm2aD7eGhcDfoZcPJiSevD7WMC8SnIvkLpONHSE2BLQpDtRY5dv9YsUgU+Bn2wTIYjmP7uB/JhG5b/A2Y57l+iEDr+zqGHUxOnwW50Z2Tqc/ofDgf2FVQzMWe0mZOFDIRLqQY20gI2C4qzRNJTDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513160; c=relaxed/simple;
	bh=jfxCV9rlwqaY7gMC4+CiNBtePqk5wM4pTmAs2nYjFMg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VhqML3gXFyi4oUw0yua9kOx6ma/6T7iDRD1ZdN3PRJIUU6WICTGJMl6fVtlOAU+7c7w8EKhEmZiJ4D/JB9llJp+Bad9BzBmyVzhnFut6SZwKXUD3MdlOYMdkPWBV7o18wxWtQQZJNne3avfxkwfsj0mZHRMjXmS+ZnWRxSMwBCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vs0v/ZWL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so6029709276.0
        for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 02:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708513158; x=1709117958; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rwpRKSDL7o4Mw1cMNq1xVS5ROjfzAbOrob+p4SO1Ah0=;
        b=vs0v/ZWLV7lCBXVhrgK1PnoHHnytqNZ6fEiZb9u0w2/QovQ7/zjxwG99jTT8CO6gfF
         FBv7q1f4soiKLHx/L5/RBb75U4880UDRmh8MUHJoam7J+PTh4A9Nv8VDfTAPNFr+Jo0a
         gOq02enXn6oPPgGGr0gycYACMI6Sq2n2M5Xtm/KHT7vgyndOhZdbr9FuhlPenBcwKT2G
         FUd1CdO+I51Loft8I9GQbcopgfUed2xBO4EgrMCOoqUQcJ+kW2EprN6mdLKDgsbfK/rc
         oY68AcKCTx5rXA5ZpbtI33x1EBWHbfYS6ZIkSyF+x5Q7Jwu3juDsLxM3TbBdo5l9ywl7
         vrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513158; x=1709117958;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rwpRKSDL7o4Mw1cMNq1xVS5ROjfzAbOrob+p4SO1Ah0=;
        b=junqNpn0QlpaGHFIBitzQoqxddROnR6vYJnwh5FJ4hVn/upwsesP0s/GFNq+bk7gK3
         i5Y+gF3AK8JCStNKSymarLW26EYcJ3MSX+VPyljblsFH1WiwATkA8/yS76NcqLC6ZCt3
         S4cABWxBbI3nQ+XzGmVOrjklL5JO3VaY8gnZBfwubAjY9F9HVkfOkl4EQdoR6601OZRb
         YX1SyQlSYqfGfJWcz1gViJ2ZGRhcG6VnKmgHiXYqSU37tsW1CPw4S/3Eeyz2OGqr8fQb
         bhZG5TCZVoPegfCs5a1LUVuAqmxR0L0wmw1eoRTYnGkLtkbIo2qYPXiPONgoqg31aiVL
         33UQ==
X-Gm-Message-State: AOJu0YxN4YXMMfPoa6n/B4RAjy/dpMtjqcWhmPBofhbnE4Ec/bFA/DMG
	dWNzDILmGA4BV19XWGJmi54Tx896NistTv3iR9V/MzfA+Gyvs6mqDqka/1n1wx7feja1dMqTqZ6
	1FWXSdDz6Rg==
X-Google-Smtp-Source: AGHT+IGH5H/9aPGbQcL1Po8cNESM5zvzEWKH2lrhDNCs4RKEJjwxXQLdrjS8JYm7w2aScpqABzXua1Ekw2SMUA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:100a:b0:dc6:c94e:fb85 with SMTP
 id w10-20020a056902100a00b00dc6c94efb85mr682685ybt.2.1708513157666; Wed, 21
 Feb 2024 02:59:17 -0800 (PST)
Date: Wed, 21 Feb 2024 10:59:02 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221105915.829140-1-edumazet@google.com>
Subject: [PATCH net-next 00/13] rtnetlink: reduce RTNL pressure for dumps
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This series restarts the conversion of rtnl dump operations
to RCU protection, instead of requiring RTNL.

In this new attempt (prior one failed in 2009), I chose to
allow a gradual conversion of selected operations.

After this series, "ip -6 addr" and "ip -4 ro" no longer
need to acquire RTNL.

I refrained from changing inet_dump_ifaddr() and inet6_dump_addr()
to avoid merge conflicts because of two fixes in net tree.

I also started the work for "ip link" future conversion.

Eric Dumazet (13):
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
 include/net/rtnetlink.h                       |   1 +
 net/8021q/vlan_dev.c                          |   4 +-
 net/core/dev.c                                |   6 +-
 net/core/rtnetlink.c                          |  41 ++--
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
 31 files changed, 240 insertions(+), 199 deletions(-)

-- 
2.44.0.rc0.258.g7320e95886-goog


