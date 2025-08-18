Return-Path: <netdev+bounces-214527-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC433B2A077
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 13:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172856207DA
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EDA3002DD;
	Mon, 18 Aug 2025 11:30:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0227266A7;
	Mon, 18 Aug 2025 11:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516619; cv=none; b=h5YaIkIR85JtSbYl/ZnP9j54QFEH8VV3n3FZmX0PZKIqKHYz7V2eOUtnjofr4eqytMO3T7x1TKwvIOc7ewvKskmXBPY7d7FcZlMeF7sFocBCoTdeQ78dxRgzAxGRAliFKnsEYZsUhZQmELcPNsv6w2ZkWj++9JKMWyUExC5wMQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516619; c=relaxed/simple;
	bh=+LPdqwhCnAO60h1rRJ4mU9PRwuJG4gT9+SyzZF6MgGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PYNJMsMu2RFX4+BDfEklUWTnTQM5NPeqOodK6ZMCX2KKn8Tp7MRCcZbJpUPgOZCHTxJyphXGelawW2fEHyUgBjnVhFaAxeaghViEel21q3cL6h/rMEZyXZWosw26IwNLThFnNB1NXNmj+yS/FXPyxxPGVO6sxJej2fmfRrYG/hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz2t1755516554tb16007fa
X-QQ-Originating-IP: iAa0o7aZGeg/JJqbr9ti+RkKGqaM92/kXXZgOgCBDtE=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 18 Aug 2025 19:29:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13453606116894291205
EX-QQ-RecipientCnt: 23
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
	richardcochran@gmail.com
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH v5 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Mon, 18 Aug 2025 19:28:51 +0800
Message-Id: <20250818112856.1446278-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Ob1RgLjHLyZvLqdkENgsxeYivp9Ri6KHEjeeDH6eL9dvaIFuePPlDltH
	28+HrBKwQf+88FuMgp6fOfHXxqnFTMKIXWgnKCwjJD7gvCFmBdq2j876n33QsM79x19o3TP
	Ldh5rewjZ1eHEZ4nhHU4O44dKiogpJWmIJUFer38fj/Dr1LqgE76iUPPsj4onjH3bbLJf4G
	TW2Vxav9FXLlEj2Agp2fBUpdxDAulyt8YL6QmIGRVfx5h24JZ6WnU3Z/qq7yn6gzFcw6XEV
	F5N+5ldIrjQS1EeLpoMw12+dyPk4FWwpBb53phOTZYJwA7sv3RXh9t+jDSS+Jtc3kACqbre
	vzH7qtW07gQ7YT2+nWF8FaML9xV134PQcfzLsnx+QzH+4P8a1eTJxkTC17RzO+k+eJNHkDZ
	WLr2r4IsBYVBuAX9gf0nYOpYUhWxU9K7ARWDddiOBNjVvwLY0SYgjgnNPBH/3DYTJRhkE9j
	QWVEIkbVj3q/+oXI0KvV+Yuap3E6xLsF4F34jXd15qqQRnqezfI3JoGYslzMLbujLl9Qox4
	kmgdkDu0ufdAltCEyNKaqujZYjqaxmFG0V79oslXotkxX5ywb4UchVqbsZNRN7LjM8u8Mg3
	HRBxj6yFicIceySz7ly/rjjtsdb42G6OBPieIbjB/jR3KQslTrei1RmfQVboR/SFF2QsIrA
	Od0A0845F/mE0yE/0zSAxqQyDKXOSbGlIvXT5YlAoEGmCQLu1Z8D40tgnObMe54VH176n07
	FBTOD1oLJEFrvHqA/Md1ZJrl546kzPFar+sBTsdUPIFazrZrjYh++hR9nApo4O3ighTcYgF
	PWhZ+rOcseKCteCOiuTHN6d0yBU4GifHvwyBoRo/vduHQPxM1Uo8UY5pZaDvG4dzktneWYW
	68o3vaj5bUwkYgGeLdZ3jyCIOZD1GcVY75HPI4Cdvg3IovZN4hukOVwbQtVYhX4XO7Ts+h3
	X+yt3cU78Ly7LVyepwmw3wbeV3xN/F4FIrzppHHx80kYFlAq0uP4fMPdSs5qcv14gWn3y1Y
	pNBGp7tMgijZXzYCpNkK+1IC29R2g6sVAviIyrvCblxI1AdBrroLbLuYa9Pvo=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series is v5 to introduce support for MUCSE N500/N210 1Gbps
Ethernet controllers. I divide codes into multiple series, this is the
first one which only register netdev without true tx/rx functions.

The driver has been tested on the following platform:
   - Kernel version: 6.16.0
   - Intel Xeon Processor

Changelog:
v4 -> v5:
  [patch 1/5]:
  1. Remove system state and Wol code.
  [patch 2/5]:
  1. Use define for mbx offset registers.
  2. Remove 'switch (hw->hw_type)' in rnpgbe_add_adapter. 
  3. Remove 'hw->driver_version' in hw structure.
  [patch 3/5]:
  1. Return -EINVAL if 'size > mbx->size' in mucse_read_mbx.
  2. Remove mbx->ops, call the functions directly.
  3. Rewrite mbx_wr32, mbx_rd32.
  [patch 4/5]:
  1. Change laber 'quit' to 'out' in mucse_fw_send_cmd_wait.
  2. Fix 'mucse_mbx_fw_post_req' to follow 'one lock statement and
  3. Use "timeout_jiffies" instead of "timeout_jiffes".
  4. Fix 'pfvfnum' in define structure to improve padding problem.
  5. Fix 'build_phy_abilities_req' pass the same parameter twice.
  6. Use wait_event_timeout, not wait_event_interruptible_timeout.
  7. Move 'build**' functions to .c.
  8. Remove L_WD, do it in the lowest layer.
  9. Add MBX_REQ_HDR_LEN in build**.
  [patch 5/5]:
  1. Remove no-use define dma_wr32.
  2. Rename dma_rd32 to rnpgbe_dma_rd32.
  3. Fix extra indentation in 'rnpgbe_xmit_frame'.
  4. Return -EINVAL if get perm_addr failed in 'rnpgbe_get_permanent_mac'.
  5. Remove flags 'M_FLAGS_INIT_MAC_ADDRESS'.
  6. Remove 'netdev->reg_state' in rnpgbe_rm_adapter.

links:
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
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 117 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 160 ++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  26 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 310 +++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 481 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  31 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 333 ++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 155 ++++++
 16 files changed, 1697 insertions(+)
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


