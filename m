Return-Path: <netdev+bounces-215187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B21B2D82C
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 11:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 667E2A04932
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 09:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE5B220F20;
	Wed, 20 Aug 2025 09:22:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7916F2BEFE7;
	Wed, 20 Aug 2025 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681749; cv=none; b=C1OEPKRwAX4kag+xjafnfYv+Pdsxboi4oGbl0Jii+8N8Z/RMAoIl8pjl9sKeEB+fs9ij8OtDMg7L/i/gHw1by+80TYDIWsYOK4mROm/RBkqTou3laqO3TvxuQXiapwX/bxQxB/40DYPn5mI7fDZkz2v0ZGzlljQah4er82wNMcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681749; c=relaxed/simple;
	bh=ydSrj/nL0FBHtk7T7/wA6TN99t+B7MjLZwhk7LqyWOM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LL/BZrQsp1SjxUwil/1maZedjTsOpsuSEDd+ybj+UNjeIEzDIK7lDa/sQwxEoEc16KjzQdjm9zWRSnsraFutBOkQNkveebyBvrsnCw9/xXuc8z75cafqm6qNyLK/EZWyeGQXFJpfpDpHQu7kqBFWziItUXrBavdbkb3obd1+Ezk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz10t1755681728teda31363
X-QQ-Originating-IP: h+wSIsByCFLm9TreXoJ8BicfeWc3XlU3z5Zjs8MYZOU=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 20 Aug 2025 17:22:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2554484086682756889
EX-QQ-RecipientCnt: 26
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
	gustavoars@kernel.org
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v6 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Wed, 20 Aug 2025 17:21:49 +0800
Message-Id: <20250820092154.1643120-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OdImatYx1y6xyMwl7NmsIxGAku3mNTbIJ5oh4dmYkUbeKuOCPZKTmx0N
	NS7ataGsDLTNmTWRSQ8jzo3rkLwyHtKbERjLVr+p9VufBt5jlPgrggMinKY4devi1N3azhz
	94OVn6fKV4G39ZiPTTLNTm9BNA6xgGTYXhV7Ih+6aImcBM0jwTRAeFipjcvCmmjPYFAxfie
	V1aLj6/p2vfIDJuTJLBr9VJNkITtMFmGhV3UjAh1jF0xv/xb48uX0oQaQRKyFSCoyPp/KcN
	Y1Gbhm9nW2XyWsJZbb0Zr3kVefuCU2LEIyiEpTEMtBY3Vwf4XruHSjXNqD0mpVJFFQiQtRj
	q8qzlTq2GXHcxi8WiEhB3Sj3Ap/StNbcN+udUu9lGwu/5l7ffe8O4/Khoyx2kF0mZTE77f4
	z7NqbE3aZPAoeFHOB38csW37WE3HrjKt0+nLbUx9f+Fa/c7mRbSpWKK5Ig5QcXuvQCPAe7z
	3hIUlzLXX0Og4DM8/35p8+Cd4qK/xdjJ3FxCUZyTeoXn6Y1Teki/A9ig9oMqL4upEIhmzC8
	LYiJAF38aIsCmGAXv8L9eDQcV4swdpHsgL4KOjM+FoKiq82YKcrjMRUhbgRzUy2C9Lyfz7w
	dBSAA7LeVlMsDTRIOzxqq93T0xKidPspaaweL5ENm1jYlEOoS50izkKtvpi/d8plxcHef+J
	PKutm2+4x2HA1Jzig8htZjGiyXaFelcP8T237zEXTiFNY4KT8qS9XBzaLX6/PDJBebxWQTy
	+TLiR3jRHCK3WhR9p1yd5oa5YYhxnNoc2jYxOYoSjhTuwRAe5Qwx1MtXgN1jvc6YiP2fipH
	1FCUb6UoGHcISKf+tn/unyx4WrChTZ0AQHvpASFp1Qp0gRzjoyCK9fpEQ17gTU89kHzF4oZ
	tOh0ioAJCkVelStEcq8n0qie3KmrDGnvDDeZtM8XGqTq+cSdts+IXh9zq/ZEaI7zmaeTmmY
	ZwnmC0G9T/YuD3RHgIPGSlaHd81tWt4KWZs3hVcGI+d6sVGA+61q7oMrpmJ/VBvuI24vCIG
	I5yvexWJMWQsKW+TQRl8nm7hO/Ew6a5j5Aivr6oAn7mFRUVwV+gGILUPba8cLzbnz1UWgFG
	SLvpgF+PhyIGhAkxBMN8ynZRadzS63eDA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series is v6 to introduce support for MUCSE N500/N210 1Gbps
Ethernet controllers. I divide codes into multiple series, this is the
first one which only register netdev without true tx/rx functions.

Changelog:
v5 -> v6:
  [patch 2/5]:
  1. Remove no-used define 'usecstocount/eth/mac' in struct mucse_hw.
  [patch 3/5]:
  1. Remove no-used define 'rsts' in struct mucse_mbx_stats.
  [patch 4/5]:
  1. Remove no-used define 'fw_version, bd_uid' in struct mucse_hw.

links:
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
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 100 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 150 ++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  18 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 307 +++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 479 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  31 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 330 ++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 152 ++++++
 16 files changed, 1651 insertions(+)
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


