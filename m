Return-Path: <netdev+bounces-234808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD273C2755B
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 02:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BE1474E1DF0
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 01:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E821324DD00;
	Sat,  1 Nov 2025 01:39:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD50241103;
	Sat,  1 Nov 2025 01:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761961185; cv=none; b=CHEIQRV6xCTgpgYidCUiKDX73n005dZEWfmU5BzyQrFu9soICBAaD6ASbdKxWMFVkKBeXhVaOjAWXxv4MEGcfSGMgkGh0ss24sIXFS84VRUsE8ZWbpg/O7Pq1DUNu5K6MNbt0/5TpDurpidf1lJvruwu+H02JF3KvEQCpxUWuIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761961185; c=relaxed/simple;
	bh=Ntitx045SOuBbR83b0R7QhiZ8vD4GS0odDafsf4OUNM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MXRuuCC1GbEl4eZUdJb2ptz8oXOYnXu0l+e8VcLDrGadSW7Cp1/3+dFS91q4J8XAWrx6PXdxJVUUJ1XKcEYYCFb7z5wROkvkJa1ma3JB6ZjAsrRLJJ0CLsDm7XIaC+3WCZO3yAnOat/DSMJ3tuE8sJjN71/HuvLHbcTTpeQwRZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz9t1761961141tbc37b387
X-QQ-Originating-IP: ylgEnAVed5sB36cFeIMaUMZjiyQfEuqtcD7ld4bWG/s=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 01 Nov 2025 09:38:58 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10405311281483584831
EX-QQ-RecipientCnt: 17
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	danishanwar@ti.com,
	vadim.fedorenko@linux.dev,
	geert+renesas@glider.be,
	mpe@ellerman.id.au,
	lorenzo@kernel.org,
	lukas.bulwahn@redhat.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v17 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Sat,  1 Nov 2025 09:38:44 +0800
Message-Id: <20251101013849.120565-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: OQNQM5UP8StMXU05C0AxZJW2+e6E2+XYUwQ7J339jQWGlcbMoOcZUqvz
	CnbI5li8lNqjM6QAQF8pEXgpOKH3uXTHFN9jZ4nzrQNBRe6aLusHZ5SFUUw/7j/zvlW+Hto
	xTQkrkcPFvvM1/FF35xFY0axVygVVaEYJdjJDCZwrUIpC8esRftIHI8dLBqlINCyhTNH7nU
	W3baCO4x2ZNalH27LAtDbIQft8andg8XXG2FPF7gu16qPYQHYdrOeHtjwN5GHzkD0WpVERC
	5fauAF64alkdgCpSrmWYRahyfzxmRvsKEhQRKRs57psv7UXZ/ViRnMLMmP7Uovv8zKK+41t
	KgGpPvZRrCCW+5gEaOaz6OaNV6ALccgUDM+Ub+f8D/qCbA32PtwuNRTOVSJyg9aBfYh5O90
	5LrdpTi7SSV/FDNyYRnzr3GTEfhZ4ZObQk5z2+3mFxMH2IOI22QZiD2/+5NAlTVM0xqHOuo
	b4veIQgSl/U2JdSd72D5C+VG94ZZGgmCcQUfK4FqFXUCI34SPxEihixYhJYNhdyr86tBQeL
	d7OHuGz2nCyuTVMCFu1IlxUdAzecMtfXCSE3jjuSXgU/RkePNH9mFbkqfYkc8zJ0dOdEG5P
	v5eA9CrMz9KSaRmi7qcw6wfOoZiKuwqxp7bp5R9Hj5uOpOv0mNTBNtSkyZu+K4r6MZKvXzI
	mXItOsbOi8qzoluIkHZ7VHDDmACkONAkTPfb/gBz0YTWyJOm5D/QhSfn+/wWzErnQNKmMu1
	kEAIvCE+rSI2AcKimN6Jn8XBwTxMXLyvR6vXXqB0t7P6vxG2fW3mB4CUq/zSw9fyefShPa2
	cxkjoJ8+e0VdDUgeu+XLy98vsPIcu5A7WGaY/zAwoFJSb1UGM39dnZybhQvb7Rl1REWyJB/
	wKnAp27xU872Srx8LwGzR189erqYHmuwV0kp928oseHDVX5lVUsfPs6g9F7OhIiVMvigpbZ
	j3VKozr0S0OJ/fvRIABTNl3LFGnZDiEME+8b+Q1azsJIIkAm0B/2/nM5NPopggKkwsr8Fm9
	K0hmgjEZT2sfRFLA92qXFBYs8ka+jw6blgDrMN2g==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series adds support for MUCSE RNPGBE 1Gbps PCIe Ethernet controllers
(N500/N210 series), including build infrastructure, hardware initialization,
mailbox (MBX) communication with firmware, and basic netdev registration
(Can show mac witch is got from firmware, and tx/rx will be added later).

Series breakdown (5 patches):
 01/05: net: ethernet/mucse: Add build support for rnpgbe
       - Kconfig/Makefile for MUCSE vendor, basic PCI probe (no netdev)
 02/05: net: ethernet/mucse: Add N500/N210 chip support
       - netdev allocation, BAR mapping
 03/05: net: ethernet/mucse: Add basic MBX ops for PF-FW communication
       - base read/write, write with poll ack, poll and read data
 04/05: net: ethernet/mucse: Add FW commands (sync, reset, MAC query)
       - FW sync retry logic, MAC address retrieval, reset hw with
         base mbx ops in patch4
 05/05: net: ethernet/mucse: Complete netdev registration
       - HW reset, MAC setup, netdev_ops registration

Changelog:
v16 -> v17:
  [patch 5/5]:
  1. Remove '#include <linux/netdevice.h>'. (Jakub Kicinski)
  2. Remove perm_addr define in 'struct mucse_hw'. (Jakub Kicinski)
  3. Update get perm_addr logic. (Jakub Kicinski).

links:
v16: https://lore.kernel.org/netdev/20251027032905.94147-1-dong100@mucse.com/
v15: https://lore.kernel.org/netdev/20251022081351.99446-6-dong100@mucse.com/
v14: https://lore.kernel.org/netdev/20251014072711.13448-1-dong100@mucse.com/
v13: https://lore.kernel.org/netdev/20250922014111.225155-1-dong100@mucse.com/
v12: https://lore.kernel.org/netdev/20250916112952.26032-1-dong100@mucse.com/
v11: https://lore.kernel.org/netdev/20250909120906.1781444-1-dong100@mucse.com/
v10: https://lore.kernel.org/netdev/20250903025430.864836-1-dong100@mucse.com/
v9 : https://lore.kernel.org/netdev/20250828025547.568563-1-dong100@mucse.com/
v8 : https://lore.kernel.org/netdev/20250827034509.501980-1-dong100@mucse.com/
v7 : https://lore.kernel.org/netdev/20250822023453.1910972-1-dong100@mucse.com
v6 : https://lore.kernel.org/netdev/20250820092154.1643120-1-dong100@mucse.com/
v5 : https://lore.kernel.org/netdev/20250818112856.1446278-1-dong100@mucse.com/
v4 : https://lore.kernel.org/netdev/20250814073855.1060601-1-dong100@mucse.com/
v3 : https://lore.kernel.org/netdev/20250812093937.882045-1-dong100@mucse.com/
v2 : https://lore.kernel.org/netdev/20250721113238.18615-1-dong100@mucse.com/
v1 : https://lore.kernel.org/netdev/20250703014859.210110-1-dong100@mucse.com/

Dong Yibo (5):
  net: rnpgbe: Add build support for rnpgbe
  net: rnpgbe: Add n500/n210 chip support with BAR2 mapping
  net: rnpgbe: Add basic mbx ops support
  net: rnpgbe: Add basic mbx_fw support
  net: rnpgbe: Add register_netdev

 .../device_drivers/ethernet/index.rst         |   1 +
 .../device_drivers/ethernet/mucse/rnpgbe.rst  |  17 +
 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/mucse/Kconfig            |  33 ++
 drivers/net/ethernet/mucse/Makefile           |   7 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |  11 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  71 +++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 143 ++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  17 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 320 ++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 406 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  20 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 191 ++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  88 ++++
 16 files changed, 1335 insertions(+)
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


