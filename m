Return-Path: <netdev+bounces-213608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD966B25DB8
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 09:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2C281B686F6
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 07:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ADD2701D1;
	Thu, 14 Aug 2025 07:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A59D26CE0E;
	Thu, 14 Aug 2025 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157223; cv=none; b=SYliC71tD4fSigV1Fg8/wlQR+PA2ut5KInGP0fKOZRAo8mPX6yuIbWdBArMK9YT8kDcPHDFek716b9FS30K//yCU90mhM8Yv/pfecYXsZDc89opZW/crwvzmfuOZS2GLzjZo5K/RGyybOTRXKGE/tCoWLhnTXy3ZmFmOx0WwCXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157223; c=relaxed/simple;
	bh=I8wL8Bije0sj19c4wegVxWNIvq5gd4gFzUnw71IjeNc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TjusmwmyjWqneg/BX0hKuuvTKWxOypZ+Hm+8RiJ1cI3eIYAe5fw5OI/q1/08kUcD0em0SZDyW8M4ee4L7se+ZpT0RVqzZ5CaHpLh7/ED+nmDucVxwhVcWifsEUSXeZMv/62BzPJccl+YsZpDlZF/Zc5cFFSXV+PrtTg/lF+dJ4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpgz8t1755157144tba28a6ad
X-QQ-Originating-IP: rUxkcWEOBOc2GCBlXoflVIntl0nBg1T2I/TUM5RkhQk=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 14 Aug 2025 15:39:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13568056976583856875
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
Subject: [PATCH v4 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Thu, 14 Aug 2025 15:38:50 +0800
Message-Id: <20250814073855.1060601-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: N7JaPSsNCN5wPIAAE6c4mIrmc3ZCmZtH2K5NIiNWQ1s6cae/VJUwZnsO
	gTrHWo6JpDTz3ORhlJ1TuHs8NTRG+sgpFgB8gte01sdvZ+BJHK27YfPUuWqPadd9dm/wqGk
	yWXtF/SWWrxJMM3RWBrpW5ZpMWLIaYFkG7Nf7InkoYu3egtMgZlYJ+wiZv+904CE+pwd/xA
	YqFxqPaWUMtouHPh3UgYrpRxIHxhzhTLqP0oJBz+RX4uBN4G1ixRruftM9ugK8wsdMd84BB
	Hejs4kNSUf4Q4iohPkgztjsWE139iWVh1sPUZjuWzvkglX9gY1PVUMlzT7wUqVikV9zJyLZ
	vc/6QudS0NhF9iHXmzMLLPxYDiCyh1mXfxbOYGtMSOAiIvui8uj0BgraAwuz0mtG9hn03ck
	ZWT6slcWcmKAQb3ojKuFo3rK7iJD9Asg/AJX7uHAEregY7wQjHzMt95U38qXmAav66N+Bd7
	d63GwwAE5BHimAu0jdbPnJaf03AvZaphzdwMrx8NecLN3s/sbIm+CI0WH2lwO28UIUo0StA
	lTLyKa+DFuFJ5nu5bg8oYc0pwwK0pvHIrHigFiyh/kfWvdvDNNLDJmfjWBlrHvGxxP7a5AK
	L+EdKl6yfjmhjTzWwXi7Xz+ewcJ9YUFiFXRJL6WpXbYh7IVGiA/uIIMHtWPJRBglC7BI7C7
	HNDwRPmON+G7v+06AJE01yrkPkJlS96aQI7C8liMsQZCmrzWlIjeR2gQlUZyOiJEBpxJkSa
	/i1R0JyhEwnPEeibB0zEnaxWQGhrSs0zrLz1LT3kRx5LvqfcASD8BKDNbd/WVV2Bi43aBPx
	/hSpg07ABd1zvZvQ9PHQ6uAZcF2Cz5Hx5S8o10Rp042IW5IOCKGRsrcP/0b7dXEGFI0bGiM
	1oSBZaUnw/H/YvX5du3GAInYYdX9Ibudxq8jWqerMUiFPKVK+nAq6DvmTXyIG4pTxy5+keo
	s8r2W4ruYuioXv+42pT1WXsv4NHYjtFORgMqQcKc44doVwb6qob4lNs7VqwlS6d1R5s5NAn
	IxcgEsByRaUA87PYE6ERgcYZdOnOVKRiC1KJhu+w==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series is v4 to introduce support for MUCSE N500/N210 1Gbps
Ethernet controllers. I divide codes into multiple series, this is the
first one which only register netdev without true tx/rx functions.

The driver has been tested on the following platform:
   - Kernel version: 6.16.0
   - Intel Xeon Processor

Changelog:
v3 -> v4:
  [patch 1/5]:
  1. Remove redundant label.
  2. Simplify 'rnpgbe_init_module' function.
  [patch 2/5]:
  1. Remove 'back' define in structure define.
  2. Remove no-use 'static int bd_number'.
  3. Remove no-use 'pf2fw_mbox_mask' define in 'struct mucse_mbx_info'.  
  [patch 3/5]:
  1. Fix min() is not assigned bug in 'mucse_read_mbx'.
  2. Fix v define to u32 in 'mucse_mbx_reset'.
  3. Use USEC_PER_SEC instead of hardcode.
  [patch 4/5]:
  1. Optimize 'mucse_fw_send_cmd_wait'
  2. Optimize 'struct mbx_fw_cmd_reply' variable declaration.
  3. Fix missing initialization of err in 'mucse_mbx_get_capability'.
  [patch 5/5]:
  1. Optimize 'rnpgbe_get_permanent_mac'.
  2. Remove no-need init netdev->perm_addr.
  3. Remove addr in structure 'mucse_hw'.
  4. Add 'netdev->stats.tx_dropped++' in 'rnpgbe_xmit_frame'.

links:
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
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    | 138 ++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 163 +++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  15 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 341 ++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 443 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  31 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 264 +++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 201 ++++++++
 16 files changed, 1680 insertions(+)
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


