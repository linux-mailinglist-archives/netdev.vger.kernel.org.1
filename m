Return-Path: <netdev+bounces-170647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B9A49716
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 11:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A7C1889C17
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 10:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C8225D91E;
	Fri, 28 Feb 2025 10:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="C1J18sQM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f97.google.com (mail-wm1-f97.google.com [209.85.128.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805225BADA
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 10:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740738109; cv=none; b=ABkmqRqico/mAMYtJ0yGL3qNQOnwI06r6toa5gnvhGazbAsU/7n+2dLILFsWcGBa7FFpbMBkB2VYNdhG22LvAPBH+U5IR5BwpHGpuBMaTbG1ptwr90js9HHxo4lt+/v+/eN3YcR5Y7k6Bo5aQCYRDDXLUapyOhbBLkVJtz3gwqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740738109; c=relaxed/simple;
	bh=FtxLKKr3JCDu5Dkn+Wn9XAL7khUZgkMRA1aX2KgsEJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k9OfJ35NCELqOJjAxUZMqd5v0Qx0bQTRvt2M1GCQ9MUbyIEHi8pgHigpKS+DCFUv10QiCt71J9mYitCtYei8PwbQwvHni1UJeVJXMN+Zhm2w7WoKIycmHC2uBncLGH8FsJqOzc75SubmlzrhCxpKHpseaLNu7brDl1tv9Yz63fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=C1J18sQM; arc=none smtp.client-ip=209.85.128.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f97.google.com with SMTP id 5b1f17b1804b1-4399509058dso1761175e9.3
        for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:21:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740738106; x=1741342906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DWNv3jt5ZvdG+5mgYr7jiCCLKqMBiCq/mFG2Mz/k7m0=;
        b=C1J18sQM36hQiy+bttxH5dkDRfmAsZbDc8384NxESz37dR9EoifZups2rwdkXZNBj+
         123RIpSkfhBOs4QGs2tfoOHGUQk/V2yHjTceF+rziNQibjGGlGT3hasgmxrorSKihVWG
         SXFokEvnNzpGnvwszIHTKtXe7D3EmfhyqCOMyX6tdmreN4DOeihjIyOZVYawNA+vta3s
         PzGXZg8TNQB6qii7mWoDj/LT5oLrWNQDVDFcYTbsElQeKQJRrj48vs+A2uknpmEn7sDv
         kUIWVijpoatqgg5ZQyBPEtMupPjRKkoBkQcgzB2uCAKDOrQA9dKvmfb05th9X3zyHifA
         lOYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740738106; x=1741342906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DWNv3jt5ZvdG+5mgYr7jiCCLKqMBiCq/mFG2Mz/k7m0=;
        b=ObkdBZ++jzQ9UHjbJ3Tr76mKWqx4jTokrzCH388Ow3JsptVKElmbIN/2KscrJ7fnOj
         dHQdgIhC5jpB+GC4ONQFclM4DiBrMonrf48JAt1L1mBGcArKdh3LZPf+X4QOPKBFKF96
         9rtYFwlfBz0GkfmxIWbx5zrUVAK5+HWn/Kdm7Za3jcGNxE+WBstQxSeAJcF0VWDx7MQs
         XX1qm8L+WmnNE//HHkUrShzb42XHTtTsKlIzfdO3yCQ/wvgKeNX82VkMbZBNjMP5Boe0
         qkOddpE8kRhNVY3LhK+oyXIzcHeoqyJZTi/3YcNn87SSvyX6lN2VSFsu3bKWUFNDS/8C
         cjLw==
X-Forwarded-Encrypted: i=1; AJvYcCXbUqy8jbNks/JmiFl0znTm3hfC1cd0nrV1CMj2kgpoeI81EqNoxwKXr7d6q1gb+HfzGo2W9tY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyybUl5Pt+0OIBk7W4bIfOD0T75sFOxZrIxpAdHmsaEXiqbzzt3
	Nf6xa+lXs/QZ/XCkubjJ6h1iLJNg2CU2cKsWZWdmvvWUMFCOQBObXPY9SrU9AIDxAhwpp9D+5kV
	z/q71yyPTjS9XvONkde1EO/Aoac1hyFlC
X-Gm-Gg: ASbGnctMC6vvfDevKDuNoNv8vqhhdw6t1SvLXq4Z6Gp2fKdMmDm1Uv97NXkJC+8bxq4
	q5BRvt3PZO1YcLi6QGVIT2LE7tSXCHPOJ9mrEowH6WPeEEw2YmD4vdTOj2Ymqx/31slvyki0fu8
	TDOtJQ5A77Dv4sc29DXAYXUWQCbxvcz7gGuxRFrHIkgBeRGta9Z1gQsnx8THFKgMxniDMZgCyTh
	2i48kV81AQY8aas0EHsDgiyUouuXuHCCOi/tyeK/2DmHu17ChHZs/uZ2h/wFS4J6IKLBr7k1hl/
	TdTE2vO8uyHTUbooVr3czJd14e41VOrKiI+bKiy2UwgMLtjWvmIaIqzT+wl57h9rTARO6ZY=
X-Google-Smtp-Source: AGHT+IHKlHqQ2vAy595M5/SeIfjjRqjbHgV3nT5FHquVPt316yxP0vQ47ecU0LGJXq9zIzmt/hrn2kMBijGO
X-Received: by 2002:a05:600c:4451:b0:439:94f8:fc74 with SMTP id 5b1f17b1804b1-43ba665f7dbmr8523445e9.0.1740738105683;
        Fri, 28 Feb 2025 02:21:45 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-43ba133ba5asm2572415e9.26.2025.02.28.02.21.45;
        Fri, 28 Feb 2025 02:21:45 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 77ED818600;
	Fri, 28 Feb 2025 11:21:45 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tnxV3-000eHs-7X; Fri, 28 Feb 2025 11:21:45 +0100
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Ido Schimmel <idosch@idosch.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 0/3] net: notify users when an iface cannot change its netns
Date: Fri, 28 Feb 2025 11:20:55 +0100
Message-ID: <20250228102144.154802-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a way to see if an interface cannot be moved to another netns.

v5 -> v6:
 - reword a nl ack comment in patch #1 (add "in the target netns")
 - add { } in the netdev_for_each_altname() loop in patch #1

v4 -> v5:
 - rebase on top of net-next

v3 -> v4:
 - add patch #1 to the series
 - update following patches accordingly

v2 -> v3:
 - don't copy patch #1 to stable@vger.kernel.org
 - remove the 'Fixes:' tag

v1 -> v2:
 - target the series to net-next
 - patch #1:
   + use NLA_REJECT for the nl policy
   + update the rt link spec
 - patch #2: plumb extack in __dev_change_net_namespace()

 Documentation/netlink/specs/rt_link.yaml           |  3 ++
 .../networking/net_cachelines/net_device.rst       |  2 +-
 Documentation/networking/switchdev.rst             |  2 +-
 drivers/net/amt.c                                  |  2 +-
 drivers/net/bonding/bond_main.c                    |  2 +-
 drivers/net/ethernet/adi/adin1110.c                |  2 +-
 .../net/ethernet/marvell/prestera/prestera_main.c  |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |  2 +-
 drivers/net/ethernet/rocker/rocker_main.c          |  2 +-
 drivers/net/ethernet/ti/cpsw_new.c                 |  2 +-
 drivers/net/loopback.c                             |  2 +-
 drivers/net/net_failover.c                         |  2 +-
 drivers/net/team/team_core.c                       |  2 +-
 drivers/net/vrf.c                                  |  2 +-
 include/linux/netdevice.h                          |  9 +++--
 include/uapi/linux/if_link.h                       |  1 +
 net/batman-adv/soft-interface.c                    |  2 +-
 net/bridge/br_device.c                             |  2 +-
 net/core/dev.c                                     | 45 +++++++++++++++++-----
 net/core/rtnetlink.c                               |  5 ++-
 net/hsr/hsr_device.c                               |  2 +-
 net/ieee802154/6lowpan/core.c                      |  2 +-
 net/ieee802154/core.c                              | 10 ++---
 net/ipv4/ip_tunnel.c                               |  2 +-
 net/ipv4/ipmr.c                                    |  2 +-
 net/ipv6/ip6_gre.c                                 |  2 +-
 net/ipv6/ip6_tunnel.c                              |  2 +-
 net/ipv6/ip6mr.c                                   |  2 +-
 net/ipv6/sit.c                                     |  2 +-
 net/openvswitch/vport-internal_dev.c               |  2 +-
 net/wireless/core.c                                | 10 ++---
 tools/testing/selftests/net/forwarding/README      |  2 +-
 34 files changed, 86 insertions(+), 53 deletions(-)

Comments are welcome.

Regards,
Nicolas

