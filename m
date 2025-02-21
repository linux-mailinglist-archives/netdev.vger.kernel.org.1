Return-Path: <netdev+bounces-168574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD08A3F617
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 14:35:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CAD77A7054
	for <lists+netdev@lfdr.de>; Fri, 21 Feb 2025 13:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C667D18E025;
	Fri, 21 Feb 2025 13:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="JZuKjmo6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f227.google.com (mail-lj1-f227.google.com [209.85.208.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF86220C49F
	for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 13:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144707; cv=none; b=OOf1ZRH0csaGhKp8FIJLzL+8eTemjvUnf2FP2cFDS2BLPiIRYWAJWP9R+dvBCLgDZyDepoJaG+/PjD0rSgarAuMWPfBlhjF6L4mCH38Qb2Vb9ArPzqAkdvYTi3E0+z8zeBXtI0P48JK6Egl5YJ1QLXNmDG9qVoTVw0O5uzRGIxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144707; c=relaxed/simple;
	bh=EndM1Sefxs2C8nwasd7sg3A2POhZrpENZDIQmJJjdic=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iawGv6o7GWEQHSTzu8mGLxBmS2f3Jmt2NoUaKYt4KLrYMzOYcrxl6P2lhmg3On8Vs8pmty+fV7Cl6Dx6bdq2enJXd33tfRHZypMRrATrIUA8vSIEOSY3FG01tbxBsw3KsS9ZIMPIl4nNy5H422o/fR5AhLCQxwSrVesCyT7eYRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=JZuKjmo6; arc=none smtp.client-ip=209.85.208.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-lj1-f227.google.com with SMTP id 38308e7fff4ca-30a3a13a712so1915561fa.2
        for <netdev@vger.kernel.org>; Fri, 21 Feb 2025 05:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740144704; x=1740749504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Lo5WVHAvtZExylTbklzRA6G2Fe8wYaZaimyOHHUtG0E=;
        b=JZuKjmo6AcTllCWc7pYwyE6M3VFqhk2P8xjDuFRkBw9TfrSLc3t7Rrp9bACddzlnKG
         t7Mllh+8qqlq2kqtRkLRJn+KPqqbHYY3IiJyKOeZXD4XQvtvoN/I6rpR9s4H0XwruT2O
         LDbJNBNnoHVetxCXVQNoAOCkaTWK+IRujXsZnHfk0EBsMf+1UfJlWoVZERpW5/0YsJ7m
         2kQrxuSgdhfSngyN8P57IO/HP85Tscf5P8OeXUeiAuvPrTJyfut5/GdAIn/zF/ZUcjSc
         mnXveMbmpoIQt5gyTKggU36FHTdrXpcmMVkcJLpbUubUhY1YU5K5oUbs9ekFi1ZEGnrJ
         NKgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740144704; x=1740749504;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lo5WVHAvtZExylTbklzRA6G2Fe8wYaZaimyOHHUtG0E=;
        b=amWWLgAZFup+mhKTlONx1p7tM7tkqiFAdbiwoBJrdJpQxwUlqYftYiOwq4J0E1dgd+
         QdLuNG0gZGWSUMYvpsXxNZ4O3bWN2WB0InNYtp5zkScgbIJwPtTlVjAyQVHn2OMkpysU
         qVeQqHEEeQEpwr65ENNfZSfJ2YqAZSNHTjxZMKYhqYza1P0NHelFPJH4Xf/FTPoS4IFO
         sMZVF+bsFXk6TJ43m9fRTnR4N0lZmgts3dvextJxP550Hw83+IrWaHqyyK5Fa/dCHxcu
         JRQClAWAF7x/uyknHXMeDef1b+zKKNK6McYjYzRxqul+ElisW6lkSpfGxRbpQKHP/wsQ
         xi4w==
X-Forwarded-Encrypted: i=1; AJvYcCWNxjr1sq25E8t8CrbuLzXSqAZBwnV+lgnFq7+QKo0QhtgGfz96m8WTZQykdS3heilinzjz51s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6qVu71GzNwEuIn13S37hpHfkAI23SQ6zO7m5i9X7szBBwKrRM
	yZxfLNGSC8Qq/JxLPU6TyaUl9u0BawMGH7Wpb8xPk2jbsnVOG4G7SP1WGgfxsflYMjxglDVV1NF
	VYzUQ2/P6HNisvpLhMCDLKEFs9A73V+HN
X-Gm-Gg: ASbGnctXuGqoWvNm5g3OPFKG7mZbBnG0TJFqnY1EqwXV7RK02OwXf2l6bxPJAIWCKYA
	OOozy6yFH34a8hA6rDw1ag1W7kNZXe3EK+5+wzdzA11kJGkDb+7sEWP/gm3S37ElcNwqom8ct5o
	sXc6qq8e1D8zcFf4UleQDMqm119/W19EtQMpNTPifIdQnsy0HIL2CJ/sc5CN8KnONB1Fz3iHEWC
	Q9qgGYS2G5FGIpsHH7w1B0nqXyPae5rwsVJqEFoIFBjWsdvjEceJxpzKwW0TXzZRJSmBOe97cQN
	LqFuS7skvM5kTHCdwf6mLd62gbeNHEiT8Ll/uZoC0AtZ6kcm8+3plwEe2YjGcUMmhUa108E=
X-Google-Smtp-Source: AGHT+IFEHHbNSAjVyR/P1lkS+Ds2/A4BHCXBMGr2qSZ3ybPu3NbIU3qhqTE9oKJ6E/llgxGTWG9r4nr37YBx
X-Received: by 2002:a2e:bd09:0:b0:308:e46e:e62c with SMTP id 38308e7fff4ca-30a59962366mr5104261fa.7.1740144703604;
        Fri, 21 Feb 2025 05:31:43 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-546214dd214sm399683e87.93.2025.02.21.05.31.43;
        Fri, 21 Feb 2025 05:31:43 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id 3597113E98;
	Fri, 21 Feb 2025 14:31:43 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tlT82-008b6Z-V6; Fri, 21 Feb 2025 14:31:42 +0100
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
Subject: [PATCH net-next v4 0/3] net: notify users when an iface cannot change its netns
Date: Fri, 21 Feb 2025 14:30:25 +0100
Message-ID: <20250221133136.2049165-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a way to see if an interface cannot be moved to another netns.

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
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  4 +--
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c     |  2 +-
 drivers/net/ethernet/rocker/rocker_main.c          |  2 +-
 drivers/net/ethernet/ti/cpsw_new.c                 |  2 +-
 drivers/net/loopback.c                             |  2 +-
 drivers/net/net_failover.c                         |  2 +-
 drivers/net/team/team_core.c                       |  2 +-
 drivers/net/vrf.c                                  |  2 +-
 include/linux/netdevice.h                          |  9 ++---
 include/uapi/linux/if_link.h                       |  1 +
 net/batman-adv/soft-interface.c                    |  2 +-
 net/bridge/br_device.c                             |  2 +-
 net/core/dev.c                                     | 42 +++++++++++++++++-----
 net/core/rtnetlink.c                               |  5 ++-
 net/hsr/hsr_device.c                               |  2 +-
 net/ieee802154/6lowpan/core.c                      |  2 +-
 net/ieee802154/core.c                              | 10 +++---
 net/ipv4/ip_tunnel.c                               |  2 +-
 net/ipv4/ipmr.c                                    |  2 +-
 net/ipv6/ip6_gre.c                                 |  2 +-
 net/ipv6/ip6_tunnel.c                              |  2 +-
 net/ipv6/ip6mr.c                                   |  2 +-
 net/ipv6/sit.c                                     |  2 +-
 net/openvswitch/vport-internal_dev.c               |  2 +-
 net/wireless/core.c                                | 10 +++---
 tools/testing/selftests/net/forwarding/README      |  2 +-
 34 files changed, 84 insertions(+), 52 deletions(-)

Comments are welcome.

Regards,
Nicolas

