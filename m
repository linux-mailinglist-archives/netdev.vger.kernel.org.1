Return-Path: <netdev+bounces-169760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 597B4A45A27
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 10:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D14B6189288D
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 09:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B0A215189;
	Wed, 26 Feb 2025 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="aZBgMopO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AEF258CE2
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562357; cv=none; b=RmNFSiWNbsDcAkASe+JGfkFb0OwNmPkkLAbyN7TeU4XpuQKoPR7qmzDera7tG6x1lKQesXc9N/7a2aOQ9L7vkw1Vq73lDtl5EM90uGB9horPkAbaW77tTTv0fihk7YqfRHPbQ6U3f4La6tUic0NnyKzyOHFnQFGV7rxeDEnBbP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562357; c=relaxed/simple;
	bh=B/ySGKXHYIkOJUbnIdL/PPESL+ZbfJqIRXDVCTBS1lQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BouGhi5RIkUHhKrd2dRVjxqGxueU9O90pcqrgWMlMTxCVOIfzQejwHbaC0ENBeGXgErklAtkPY6FR7ZmwzuWz0nSEddDK6Np+5x8DCzJU+cD9F7z09w/RXxHgaH5uAQAtqMJ8TfIrCvLTBaXgZsZ2lxaFq9brzfL7KmPdsJKXs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=aZBgMopO; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-43980f4d969so10085885e9.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 01:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1740562354; x=1741167154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HQ8ky5jB4VAW4mGMDxpoutm8LtMQ2lQBbA81i2M+2Go=;
        b=aZBgMopOFZvMTW/mbLz3GuyqfhNSMU6A0gDJMo1P5bstZuIubqL9PJcUywSrbjMLGx
         Prmqr5ZFQgpcTHMtJdmam+DISMNc+xTmnDMFzuMeXWzQH7iLvOjFjNNqz/XsF6XbTniJ
         ZwVBKqTWea4/oW+hJaUT3Ykuf50fg5FJhAYEzqW1YRtj4WUzDpj1UFwsQPfu1DMxZJX+
         McxUyV/Di/W/31awKlKh9+2RDRTgWsxxnzcIvdWRxwxEIdkuFH9Cx9kskMuaQRyWhvKb
         xmv6G6H/3q0WUL4TM8WKC0waWOg9/7Vsmqz5dfd9bT2eLt8sVBfA3i5QJkPIcYoxxTh3
         fG9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740562354; x=1741167154;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQ8ky5jB4VAW4mGMDxpoutm8LtMQ2lQBbA81i2M+2Go=;
        b=R+rKAaHbvvfcxn5f3yZCbHAQfX5ikEHqyLKXz1gc7xotkaRLDXaA0ki7ibmrsGsNUm
         nOWsyZQI0+JBQFyddxNIwkxhCja9nz0cYGo+tn6xk167YIiJU9SWF0P4swfnZ3CoK3Yc
         9we4LwfOKzakh+r3/jLrJgvV/JUs9v74+Mc3rcmf4TaWm41G89U3dtMHByTJDDN9DCW4
         DuUJhe8uP4S12V0BRE7KeM1v3HTWABtoI6D1SXIAjzvrgMuwM4WLxIGU/E59tEAbbF0i
         exGhxsC0MpKWW7bFYdV1wmBltw6e4HrYgfjzMhGzb8z92MYPZRLenF29HfKjN3QydCtv
         1Mcw==
X-Forwarded-Encrypted: i=1; AJvYcCUyyXZBNPPxDs1ro7qF4lpF71A6WeR66Y9/W+3xCBJk4EoJIWtoQcj1GyQH/VPfCDx2yPS+CIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDL2QBV90vM77LbW5xaCyVQOBtDhi6yEnpvdrlvXaPgBttsyPN
	Q6O3GL82PTTZ7N5Dg7HYjPc7ztXAbrk9yi3SP/JBFoE93H3C69ORZphL8CTtTvw3w9eVUZzd2Qy
	LG7ryunLpOfZc9bL9wVETDE61NBFnE2QW
X-Gm-Gg: ASbGncvfJ9+z8JT7PKXfQQgGJuEumSo8aHBzdOz9lrlnl5iwy3GsEZMORQLyr/a6xQw
	OV0XGvfQztMfeH1JcqrxnVY/HGVaSpaHSQby1Te3akW3ck/XLzhJIktjRSwcEjCLt45VXRLVfoA
	q8549SavEsLdgDJX/uZEvAs/1v2zQcyUsSmHOktnuZB9+jyLmfYds1A1WIK/cfQTMS90haQxV8v
	qS48siIttsUJpKbVwnMOAZIsB/BLG6PXx7MDN1IPjfoE4EwHMM8a+9ria4rxiMqhiH9hHkr6rNC
	ZK6gCOTOd8PMLpxTDB6kGeYjlMmDZuikcC23Oif/sAryNcJSpNvqUFsvhYb+PoMmmZL6Hac=
X-Google-Smtp-Source: AGHT+IG/N7Z/bSv9161Gana3s8efsmhKoQUcSu2J1hY7mcKmfx1Kde9rxvtOOX980Do/UV5O9Z7UaTsIt/yO
X-Received: by 2002:a05:600c:468c:b0:439:9a40:aa0a with SMTP id 5b1f17b1804b1-439ae1d9811mr71796595e9.1.1740562353938;
        Wed, 26 Feb 2025 01:32:33 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-43aba52c090sm803915e9.17.2025.02.26.01.32.33;
        Wed, 26 Feb 2025 01:32:33 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from bretzel (bretzel.dev.6wind.com [10.17.1.57])
	by smtpservice.6wind.com (Postfix) with ESMTPS id BE0F31669A;
	Wed, 26 Feb 2025 10:32:33 +0100 (CET)
Received: from dichtel by bretzel with local (Exim 4.94.2)
	(envelope-from <nicolas.dichtel@6wind.com>)
	id 1tnDmL-002hma-Gk; Wed, 26 Feb 2025 10:32:33 +0100
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
Subject: [PATCH net-next v5 0/3] net: notify users when an iface cannot change its netns
Date: Wed, 26 Feb 2025 10:31:55 +0100
Message-ID: <20250226093232.644814-1-nicolas.dichtel@6wind.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a way to see if an interface cannot be moved to another netns.

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
 34 files changed, 84 insertions(+), 52 deletions(-)

Comments are welcome.

Regards,
Nicolas

