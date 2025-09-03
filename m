Return-Path: <netdev+bounces-219409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 105E9B41295
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 04:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9513F3AF7D4
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 02:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593A7221FB6;
	Wed,  3 Sep 2025 02:55:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A831DED53;
	Wed,  3 Sep 2025 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868102; cv=none; b=paMYIxODAs16h/RasP9KOPZPyaMyH/F1Twc0R6lnCexJIPKuR8WFIahUjPreINOWwMRP59uCyqAfhfux4tZTDFnmjaFpnfsxOT6ZXLJ7caMBIf+6CGxO1DPYrnshzlCWC6Th0fzlgePABUsuaMqiPVJiZDq7/klkK+oLFXSTthc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868102; c=relaxed/simple;
	bh=7o3W8P2ojYUVJ0fsJWPPz/O+GKIXRReI+kCkt8+HLTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e7odnoyRqrGjpwA3Upy8lFSP1FWyZvvv5wg3RDwITas+1cfsXjU9WimDFzlHQrfGraB5MRyQNtWwy3n9zMAFl+E/ouTgWBhNJGo1J+RmtTkIB6xuhagTXmHzCUYy2tUhMy4BkGGLstVfpx2l+TNE050hLFvO1/BRAGbaNvBSSyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz11t1756868078tecfa8ca1
X-QQ-Originating-IP: bCx5FCFmzv9pp9MzqXj82PbMCHvLGw2luRJIppU3GC4=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 03 Sep 2025 10:54:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5429709690827777819
EX-QQ-RecipientCnt: 28
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	gur.stavi@huawei.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	danishanwar@ti.com,
	lee@trager.us,
	gongfan1@huawei.com,
	lorenzo@kernel.org,
	geert+renesas@glider.be,
	Parthiban.Veerasooran@microchip.com,
	lukas.bulwahn@redhat.com,
	alexanderduyck@fb.com,
	richardcochran@gmail.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	rdunlap@infradead.org,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v10 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Wed,  3 Sep 2025 10:54:25 +0800
Message-Id: <20250903025430.864836-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Mf2c2cXG8XEiQPz1OujGSlUS5cgahaZ3mQMT5guSiQ98wCnKEQwcF5b6
	cdywTG6AmcwHyZMog6hDUmMZFGDtgTwsSbk2JDBk76HgQILdZ0EUgCFwH/IpqbDd06pf1e4
	847cyG6FX9yBrspc952A7qBhkPkS1Ou6lx05PguzCIQ3t7yd+QbithUOBjt58Alg4+GWxiJ
	MISy6IChaUGk1OcvY7/NqTrWFM5biIuTYvOqnuAebcW43IhXECJRxGkTtLYF0YgOvGOD5yi
	WZXi4yUso5lv62+AsRoKhw+evxhZzga0t4q08jIq7abDk7f0NXycMPFOGw5xN6GEwygrKfx
	3CLe6IvznFfrJUKdtpkho7r2T0+KX69FvmzlzPA7qxJIkqUiRh8RQFR3p82/JeC5pN4JrBU
	w9kxH+njiQAIIkFTQ8QFL90D1EY8nJ/FUIwmEqgm9MKh3KjPNALHfFYL4PVcVzaTkmKNPyF
	0JwsSZbhgVoV1SZx7X/yv5gKitSGGInZsntLUw7DgpttQIGvqOTrNDMY+8gGDH2VGeBXq3d
	Hu58q3YfvNxR9ZHBPnemMKgwKvHSqqUd7tw2cP9qrtF80KzTan3hGP04BlLnywZ2Eb0C8vQ
	jSbXF3IG/dO6nTKOsFlwmFTvNg0kt5XzfqpCnF6ngHtQqWKlWM/lCxIe0SP+FZIczCp3lmi
	zdBJHkhca4Vsd7pBInmdBPEJlapmOpInCFiqw1yu9jt88wnCWnJfV6nS0XQki+gn5tRnyd4
	nC98u+gmNv2odKNxiG3GSu3fCGK7l5u4a7fx8/0v12C0gXHJmK0m9fCuNQ1APdhrZY7Alkc
	YMSSAx5+0f56n+kBMQnVC2sELzePxdOGqC2kUcQ1I8DhMyzrFmhDC95yV9wWKV8ltTItKVH
	CUVj03Ki9+oQBfVdjzoddJBeAI6Lp6O29iml4M2D1+foCn3Uw6sCwToBXXQnUWNSpmIKNev
	zAuuDx4UBg2NxWsIaNy8aQf8/rJY6M5dfTMuKJd+o2w9NRRZDr88TmuV2dnN2xaqlEXIs95
	vMRMKqEeMWsiPQp22qmeTFydJ8ooc=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series is v10 to introduce support for MUCSE N500/N210 1Gbps
Ethernet controllers. I divide codes into multiple series, this is the
first one which only register netdev without true tx/rx functions.

Changelog:
v9 -> v10:
  [patch 4/5]:
   1. update mucse_mbx_get_capability and rename to mucse_mbx_get_info, along
      with relative capability struct.
   2. Separte get_perm from reset_hw_ops.
   3. Rename ifinmosd to powerup.
   4. Rename mucse_fw_get_macaddr to mucse_mbx_get_macaddr.
   5. Rename mucse_mbx_fw_reset_phy to mucse_mbx_reset_hw.
   6. Add mucse_mbx_sync_fw.
  [patch 5/5]:
   1. Use 'mutex_lock', not 'mutex_lock_interruptible'.
   2. Rename 'driver_status' to 'echo_fw_status'.

links:
v9: https://lore.kernel.org/netdev/20250828025547.568563-1-dong100@mucse.com/
v8: https://lore.kernel.org/netdev/20250827034509.501980-1-dong100@mucse.com/
v7: https://lore.kernel.org/netdev/20250822023453.1910972-1-dong100@mucse.com
v6: https://lore.kernel.org/netdev/20250820092154.1643120-1-dong100@mucse.com/
v5: https://lore.kernel.org/netdev/20250818112856.1446278-1-dong100@mucse.com/
v4: https://lore.kernel.org/netdev/20250814073855.1060601-1-dong100@mucse.com/
v3: https://lore.kernel.org/netdev/20250812093937.882045-1-dong100@mucse.com/
v2: https://lore.kernel.org/netdev/20250721113238.18615-1-dong100@mucse.com/
v1: https://lore.kernel.org/netdev/20250703014859.210110-1-dong100@mucse.com/

Dong Yibo (5):
  net: rnpgbe: Add build support for rnpgbe
  net: rnpgbe: Add n500/n210 chip support
  net: rnpgbe: Add basic mbx ops support
  net: rnpgbe: Add basic mbx_fw support
  net: rnpgbe: Add register_netdev

 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 +
 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/mucse/Kconfig            |  34 ++
 drivers/net/ethernet/mucse/Makefile           |   7 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |  11 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  99 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 157 +++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  18 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 300 +++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 393 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  25 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 250 +++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 126 ++++++
 16 files changed, 1452 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
 create mode 100644 drivers/net/ethernet/mucse/Kconfig
 create mode 100644 drivers/net/ethernet/mucse/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h

-- 
2.25.1


