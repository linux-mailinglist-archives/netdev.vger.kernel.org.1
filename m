Return-Path: <netdev+bounces-222138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF271B533F4
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 15:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9DD67BDD74
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 13:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 532B932F746;
	Thu, 11 Sep 2025 13:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7BZeaXG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0368332C33A
	for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 13:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597997; cv=none; b=f7qHY6N2XPgc8jCYQsHTlaHc6ZeCdjJohdDAjbuNmPxLYlac6T7ArJ1GC6/Kat7SvEvql3GKP3SDNYCTOGMY8NG9aUOWluAoJtgcVcrKvoqpdJFPEEZpIt1vaEuBrR/wtLvPJX8++H5O2HdKqKlPITQW+6TIeva31jt9uf6T5Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597997; c=relaxed/simple;
	bh=o00R7KPt67YG+IeL8YF07Q0KyAdgfFlRBWPaztmshi4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=cgYURTDTJE6L24dwftV5HOB1b3TBtng2QmT+HardIyQMtxyWBUSmobrI7yNHKFk4jUsqwWJZcOoUMON8h3EbSaa1HT35Kh00eWf+UWvhlRCf0Qa+WqdeQK5ZOss7ki0BHOCgJZHgcU69JefAK/DB0BJtuCNZIjvtN3AWa6yhbX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7BZeaXG; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-45ed646b656so1448095e9.3
        for <netdev@vger.kernel.org>; Thu, 11 Sep 2025 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757597992; x=1758202792; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq8nlQWPhjI/hl0Eqe8pojWsWK+lvTRUAMXWp5mx9rI=;
        b=b7BZeaXGLw7WmInqw31gRy+mKrc5wLkFgilg1dAhudUXYylbo1nEMlwgXoSxIuHpy8
         /g7jZrz3KAv7UJfaZUob3OiAWDV67IdXUM7Rh/aE9vjmyPm6gOzj0rXVcD/2A4vp6Vpq
         wvx9T5zlW33kt5RzVw8XvfocIp+fCdv+2GzWXFCYHJrNAx3o8K51OdjzxNX4sVfOV8Pr
         UFCAwlSOyBOfD/R7PLAxjdoB/OdolQZAbcJGPEpuDjhOvBLES5WxbEIcAZ1Yrzx0MlOX
         tElK9Wshfrw2D1PrYfDQQjOsSIbKDC09C+c4ouNkqu70ThqlKRZA9/tIltIX1lRzQqVs
         smIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757597992; x=1758202792;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fq8nlQWPhjI/hl0Eqe8pojWsWK+lvTRUAMXWp5mx9rI=;
        b=iXpbR1/EigeX2tks2qnOV7zWcP+r/pMmMdaTCR7lZ45taOh8uCpn8ADeXPp5RVQPjW
         k/wsvhWJEGjTmgnVq85b1Fj0IGDOoB/h5rG1Zxw7qRLsW2d7NjBkjlVUyog+x2yQ5VE2
         35SAZPh17bLQuYJYNER6SJnmJS146iH3Wgxou3fBpGzffEO5Sb9rBdNxTZ6sUEQvskQU
         oasCujiFTyt7xw6T2q407i5i6wXF9HaQbcf96w2onXnn2dfCTwRbHEIUeuQfajl0iFJu
         B4ynqsdDcRq0M4zQ8zxTV0vbUUV5IdG1uxhrgYxG4O9NcxBjoRS4x4dXC4R+Vhhc46S+
         PIhw==
X-Forwarded-Encrypted: i=1; AJvYcCVGZHuzb/17DD+KOaj/PyvjcWbv05/dQpCcFOu7737KzrLtfInIGz36mD6RcgFDygExpckY9yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU7deBWAkyAcaJxsVAcIk8doMurO17WYK0VsbS1YrhRlNbt5W/
	hpz0dHCYyCDQ73E17Ra6cP+X+yfDy0vK1MDCdOvlimCe8pKzq/ankbfW
X-Gm-Gg: ASbGncuFvFXr+iB1d8L3fuyvpkORF2Fu52hbb0CtExdpAf1Oxp+uzHa2HNhfeXgqwhr
	MWNgUQHvwEgj5GTkAEqRv86e0YD78/ptx5LWy7IuyEGUHka+wfdYz1zzPveZMsZWeZS74aulgZN
	np2FCDwlq5n5V9MGzKjk6+ew54G6UznBb0g6/NAZiD694/Nt+S6Kv1mYspID1OVL4IUPptjrOUo
	hFU4bsBLZqbFjy2TWPUU/tLLSkhs769iOVhg9phjZ3GrxSwZOshBSqACkUNqUTgCz4ntzO1BAK6
	eQHBrIXn0Yjf3EK1KDEulDSnaDDu03vQabQaE2ws+TwazUaJYJgHywWCnKmfVeyNxfGLCEz0kd2
	WU6969BDUhFX6PI7OyhTnf9u5dxwvzjfpQB3UM7d/QRZ4MPrNygB9NMRYHk4jOOt5VOs1BWY=
X-Google-Smtp-Source: AGHT+IFoCaquALFhoTq9n6AnFTWs6scx9ttP/mcuJwbGRDsAs0sEHpe8kddlSfOpvhlsez0knTiaLQ==
X-Received: by 2002:a05:600c:1d26:b0:45b:90fc:1ede with SMTP id 5b1f17b1804b1-45ddde6a436mr190899295e9.6.1757597991891;
        Thu, 11 Sep 2025 06:39:51 -0700 (PDT)
Received: from Ansuel-XPS24 (host-95-249-236-54.retail.telecomitalia.it. [95.249.236.54])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-45e037d741asm23413475e9.23.2025.09.11.06.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 06:39:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next PATCH v17 0/8] net: dsa: Add Airoha AN8855 support
Date: Thu, 11 Sep 2025 15:39:15 +0200
Message-ID: <20250911133929.30874-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series add the initial support for the Airoha AN8855 Switch.

It's a 5 port Gigabit Switch with SGMII/HSGMII upstream port.

This is starting to get in the wild and there are already some router
having this switch chip.

It's conceptually similar to mediatek switch but register and bits
are different. And there is massive list of register for the PCS
configuration.
Saddly for that part we have absolutely NO documentation currently.

There is this special thing where PHY needs to be calibrated with values
from the switch efuse. (the thing have a whole cpu timer and MCU)

Given the double usage of PHY and Switch accessor, a special handling
is used with registering a mdio-regmap bus for each internal PHY.

From v8 Driver is now evaluated with Kernel selftest scripts for DSA:

Additional info about the test bridge_vlan_aware.sh.

It was discovered that the Airoha Switch (and probably the Mediatek one
that produce the same test results) hardcode checking for 802.1ad when
the port is configured in VLAN-Aware mode (aka Security mode).

In such mode, both 802.1q and 802.1ad TPID are checked, hence the
bridge_vlan_aware.sh test fails as packets with 802.1ad TPID are rejected
(in the case where a wrong VLAN ID is forwarded)

This was confirmed by Airoha and multiple try were done to try to
workaround this problem. No solution were found to this as ACL mechanism
can't work on receiving packets and the Switch doesn't support turning off
this.

The current driver is in use from 4 month on OpenWrt with all kind of
scenario confirming working in VLAN bridge. By tweaking the
bridge_vlan_aware.sh test with setting the TPID to 0x9100, the test
correctly pass as packets gets classified as untagged and the default PVID
applied. It's also confirmed that switch correctly parse the 802.1ad tag
and make the packet pass only when allowed by VLAN table rules.

Output local_termination.sh
TEST: lan2: Unicast IPv4 to primary MAC address                     [ OK ]
TEST: lan2: Unicast IPv4 to macvlan MAC address                     [ OK ]
TEST: lan2: Unicast IPv4 to unknown MAC address                     [ OK ]
TEST: lan2: Unicast IPv4 to unknown MAC address, promisc            [ OK ]
TEST: lan2: Unicast IPv4 to unknown MAC address, allmulti           [ OK ]
TEST: lan2: Multicast IPv4 to joined group                          [ OK ]
TEST: lan2: Multicast IPv4 to unknown group                         [XFAIL]
        reception succeeded, but should have failed
TEST: lan2: Multicast IPv4 to unknown group, promisc                [ OK ]
TEST: lan2: Multicast IPv4 to unknown group, allmulti               [ OK ]
TEST: lan2: Multicast IPv6 to joined group                          [ OK ]
TEST: lan2: Multicast IPv6 to unknown group                         [XFAIL]
        reception succeeded, but should have failed
TEST: lan2: Multicast IPv6 to unknown group, promisc                [ OK ]
TEST: lan2: Multicast IPv6 to unknown group, allmulti               [ OK ]
TEST: lan2: 1588v2 over L2 transport, Sync                          [ OK ]
TEST: lan2: 1588v2 over L2 transport, Follow-Up                     [ OK ]
TEST: lan2: 1588v2 over L2 transport, Peer Delay Request            [ OK ]
TEST: lan2: 1588v2 over IPv4, Sync                                  [FAIL]
        reception failed
TEST: lan2: 1588v2 over IPv4, Follow-Up                             [FAIL]
        reception failed
TEST: lan2: 1588v2 over IPv4, Peer Delay Request                    [FAIL]
        reception failed
TEST: lan2: 1588v2 over IPv6, Sync                                  [FAIL]
        reception failed
TEST: lan2: 1588v2 over IPv6, Follow-Up                             [FAIL]
        reception failed
TEST: lan2: 1588v2 over IPv6, Peer Delay Request                    [FAIL]
        reception failed
TEST: vlan_filtering=0 bridge: Unicast IPv4 to primary MAC address   [ OK ]
TEST: vlan_filtering=0 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv4 to joined group       [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv4 to unknown group      [XFAIL]
        reception succeeded, but should have failed
TEST: vlan_filtering=0 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv6 to joined group       [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv6 to unknown group      [XFAIL]
        reception succeeded, but should have failed
TEST: vlan_filtering=0 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: vlan_filtering=0 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to primary MAC address   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv4 to joined group       [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv4 to unknown group      [XFAIL]
        reception succeeded, but should have failed
TEST: vlan_filtering=1 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv6 to joined group       [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group      [XFAIL]
        reception succeeded, but should have failed
TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: vlan_filtering=1 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
TEST: VLAN upper: Unicast IPv4 to primary MAC address               [ OK ]
TEST: VLAN upper: Unicast IPv4 to macvlan MAC address               [ OK ]
TEST: VLAN upper: Unicast IPv4 to unknown MAC address               [ OK ]
TEST: VLAN upper: Unicast IPv4 to unknown MAC address, promisc      [ OK ]
TEST: VLAN upper: Unicast IPv4 to unknown MAC address, allmulti     [ OK ]
TEST: VLAN upper: Multicast IPv4 to joined group                    [ OK ]
TEST: VLAN upper: Multicast IPv4 to unknown group                   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN upper: Multicast IPv4 to unknown group, promisc          [ OK ]
TEST: VLAN upper: Multicast IPv4 to unknown group, allmulti         [ OK ]
TEST: VLAN upper: Multicast IPv6 to joined group                    [ OK ]
TEST: VLAN upper: Multicast IPv6 to unknown group                   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN upper: Multicast IPv6 to unknown group, promisc          [ OK ]
TEST: VLAN upper: Multicast IPv6 to unknown group, allmulti         [ OK ]
TEST: VLAN upper: 1588v2 over L2 transport, Sync                    [ OK ]
TEST: VLAN upper: 1588v2 over L2 transport, Follow-Up               [FAIL]
        reception failed
TEST: VLAN upper: 1588v2 over L2 transport, Peer Delay Request      [ OK ]
TEST: VLAN upper: 1588v2 over IPv4, Sync                            [FAIL]
        reception failed
;TEST: VLAN upper: 1588v2 over IPv4, Follow-Up                       [FAIL]
        reception failed
TEST: VLAN upper: 1588v2 over IPv4, Peer Delay Request              [FAIL]
        reception failed
TEST: VLAN upper: 1588v2 over IPv6, Sync                            [FAIL]
        reception failed
TEST: VLAN upper: 1588v2 over IPv6, Follow-Up                       [FAIL]
        reception failed
TEST: VLAN upper: 1588v2 over IPv6, Peer Delay Request              [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to primary MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Sync   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Follow-Up   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv4, Peer Delay Request   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Sync   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Follow-Up   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=0 bridged port: 1588v2 over IPv6, Peer Delay Request   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to primary MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address   [FAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Unicast IPv4 to unknown MAC address, allmulti   [FAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: Multicast IPv6 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Sync   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Follow-Up   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over L2 transport, Peer Delay Request   [ OK ]
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Sync   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Follow-Up   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv4, Peer Delay Request   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Sync   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Follow-Up   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=1 bridged port: 1588v2 over IPv6, Peer Delay Request   [FAIL]
        reception failed
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to primary MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to unknown group   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to unknown group   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=0 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to primary MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to macvlan MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Unicast IPv4 to unknown MAC address, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to unknown group   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv4 to unknown group, allmulti   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to joined group   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to unknown group   [XFAIL]
        reception succeeded, but should have failed
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to unknown group, promisc   [ OK ]
TEST: VLAN over vlan_filtering=1 bridge: Multicast IPv6 to unknown group, allmulti   [ OK ]

Output bridge_vlan_unaware.sh
TEST: ping                                                          [ OK ]
TEST: ping6                                                         [ OK ]
TEST: FDB learning                                                  [ OK ]
TEST: Unknown unicast flood                                         [ OK ]
TEST: Unregistered multicast flood                                  [ OK ]

Output bridge_vlan_aware.sh
TEST: ping                                                          [ OK ]
TEST: ping6                                                         [ OK ]
TEST: FDB learning                                                  [ OK ]
TEST: Unknown unicast flood                                         [ OK ]
TEST: Unregistered multicast flood                                  [ OK ]
INFO: Add and delete a VLAN on bridge port lan2
TEST: ping                                                          [ OK ]
TEST: ping6                                                         [ OK ]
TEST: Externally learned FDB entry - ageing & roaming               [ OK ]
TEST: FDB entry in PVID for VLAN-tagged with other TPID             [FAIL]
        FDB entry was not learned when it should
TEST: Reception of VLAN with other TPID as untagged                 [FAIL]
        Packet was not forwarded when it should
TEST: Reception of VLAN with other TPID as untagged (no PVID)       [FAIL]
        Packet was forwarded when should not

Changes v17:
- Drop nvmem patch (subset merged and present in linux-next)
- Fix wrong Documentation patch for MFD
- Address reviews for MFD driver
- Rework MTK tag to slipt for Airoha name
Changes v16:
- Rebase on top of net-next
- Drop PBUS implementation (Airoha said that it's not OK to use it)
- Convert to simple mdio-regmap and split regmap
- Fix typo for some define (AND8855 -> AN8855)
Changes v15:
- Rebase on top of net-next
- Drop regmap MDIO patch (in favor of PBUS)
- Implement MDIO PBUS and rework MDIO driver/MFD
- Reimplement EEE support
- Add some check for regmap from MFD
- Move to single regmap and add comments with all findings
Changes v14:
- Move MAITAINERS entry to dedicated commit (make it easier for cross
  subsystem merge)
- Pack variables in trap function
- Add additional patch for reported difference from MTK tag
Changes v13:
- Reimplement tx_lpi OPs
- Rework mdio-regmap to internally encode/decode address
- Fix error in Documentation
- Drop ext-surge property (assume calibration with declared nvmem cell)
- Fix comments from Lee on MFD driver
- Improve print error and drop extra space in DSA driver
Changes v12:
- Update on top of net-next
- Add additional info on conver-letter about slefttests and HW limitation
- Introduce mdio-regmap generalization for multiple address
- Drop dev flags and define PHY calibration in PHY node directly
Changes v11:
- Address reviews from Christophe (spell mistake + dev_err_probe)
- Fix kconfig dependency for MFD driver (depends on MDIO_DEVICE instead of MDIO)
  (indirectly fix link error for mdio APIs)
- Fix copy-paste error for MFD driver of_table
- Fix compilation error for PHY (move NVMEM to .config)
- Drop unneeded NVMEM node from MDIO example schema (from Andrew)
- Adapt MFD example schema to MDIO reg property restrictions
Changes v10:
- Entire rework to MFD + split to MDIO, EFUSE, SWITCH separate drivers
- Drop EEE OPs (while Russell finish RFC for EEE changes)
- Use new pcs_inpand OPs
- Drop AN restart function and move to pcs_config
- Enable assisted_learning and disable CPU learn (preparation for fdb_isolation)
- Move EFUSE read in Internal PHY driver to .config to handle EPROBE_DEFER
  (needed now that NVMEM driver is register externally instead of internally to switch
   node)
Changes v9:
- Error out on using 5G speed as currently not supported
- Add missing MAC_2500FD in phylink mac_capabilities
- Add comment and improve if condition for an8855_phylink_mac_config
Changes v8:
- Add port Fast Age support
- Add support for Port Isolation
- Use correct register for Learning Disable
- Add support for Ageing Time OP
- Set default PVID to 0 by default
- Add mdb OPs
- Add port change MTU
- Fix support for Upper VLAN
Changes v7:
- Fix devm_dsa_register_switch wrong export symbol
Changes v6:
- Drop standard MIB and handle with ethtool OPs (as requested by Jakub)
- Cosmetic: use bool instead of 0 or 1
Changes v5:
- Add devm_dsa_register_switch() patch
- Add Reviewed-by tag for DT patch
Changes v4:
- Set regmap readable_table static (mute compilation warning)
- Add support for port_bridge flags (LEARNING, FLOOD)
- Reset fdb struct in fdb_dump
- Drop support_asym_pause in port_enable
- Add define for get_phy_flags
- Fix bug for port not inititially part of a bridge
  (in an8855_setup the port matrix was always cleared but
   the CPU port was never initially added)
- Disable learning and flood for user port by default
- Set CPU port to flood and learning by default
- Correctly AND force duplex and flow control in an8855_phylink_mac_link_up
- Drop RGMII from pcs_config
- Check ret in "Disable AN if not in autoneg"
- Use devm_mutex_init
- Fix typo for AN8855_PORT_CHECK_MODE
- Better define AN8855_STP_LISTENING = AN8855_STP_BLOCKING
- Fix typo in AN8855_PHY_EN_DOWN_SHIFT
- Use paged helper for PHY
- Skip calibration in config_init if priv not defined
Changes v3:
- Out of RFC
- Switch PHY code to select_page API
- Better describe masks and bits in PHY driver for ADC register
- Drop raw values and use define for mii read/write
- Switch to absolute PHY address
- Replace raw values with mask and bits for pcs_config
- Fix typo for ext-surge property name
- Drop support for relocating Switch base PHY address on the bus
Changes v2:
- Drop mutex guard patch
- Drop guard usage in DSA driver
- Use __mdiobus_write/read
- Check return condition and return errors for mii read/write
- Fix wrong logic for EEE
- Fix link_down (don't force link down with autoneg)
- Fix forcing speed on sgmii autoneg
- Better document link speed for sgmii reg
- Use standard define for sgmii reg
- Imlement nvmem support to expose switch EFUSE
- Rework PHY calibration with the use of NVMEM producer/consumer
- Update DT with new NVMEM property
- Move aneg validation for 2500-basex in pcs_config
- Move r50Ohm table and function to PHY driver

Christian Marangi (8):
  dt-bindings: net: dsa: Document support for Airoha AN8855 DSA Switch
  dt-bindings: net: Document support for AN8855 Switch Internal PHY
  dt-bindings: mfd: Document support for Airoha AN8855 Switch SoC
  net: dsa: tag_mtk: add Airoha variant usage of this TAG
  net: dsa: Add Airoha AN8855 5-Port Gigabit DSA Switch driver
  mfd: an8855: Add support for Airoha AN8855 Switch MFD
  net: phy: Add Airoha AN8855 Internal Switch Gigabit PHY
  MAINTAINERS: add myself as maintainer for AN8855

 .../bindings/mfd/airoha,an8855.yaml           |  173 ++
 .../bindings/net/airoha,an8855-phy.yaml       |   83 +
 .../net/dsa/airoha,an8855-switch.yaml         |   86 +
 MAINTAINERS                                   |   16 +
 drivers/mfd/Kconfig                           |   13 +
 drivers/mfd/Makefile                          |    1 +
 drivers/mfd/airoha-an8855.c                   |  517 ++++
 drivers/net/dsa/Kconfig                       |    9 +
 drivers/net/dsa/Makefile                      |    1 +
 drivers/net/dsa/an8855.c                      | 2393 +++++++++++++++++
 drivers/net/dsa/an8855.h                      |  773 ++++++
 drivers/net/phy/Kconfig                       |    5 +
 drivers/net/phy/Makefile                      |    1 +
 drivers/net/phy/air_an8855.c                  |  261 ++
 include/net/dsa.h                             |    2 +
 net/dsa/Kconfig                               |   11 +
 net/dsa/Makefile                              |    2 +-
 net/dsa/tag_mtk.c                             |   36 +-
 18 files changed, 4379 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
 create mode 100644 Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
 create mode 100644 drivers/mfd/airoha-an8855.c
 create mode 100644 drivers/net/dsa/an8855.c
 create mode 100644 drivers/net/dsa/an8855.h
 create mode 100644 drivers/net/phy/air_an8855.c

-- 
2.51.0


