Return-Path: <netdev+bounces-208569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9721AB0C30F
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C82D77A40F6
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3652BCF5B;
	Mon, 21 Jul 2025 11:34:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816C8288C39;
	Mon, 21 Jul 2025 11:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097646; cv=none; b=O0N3Rv5IidPHzJTOnn4G5rnf+Sdh5Up06w0CERRIOT3sDftJolrzsa+iLou3jybtsHrC7HuH5Si5qw6MLqTrF24IDVeSTOYBrv3ANx6gz/F86BETjRjxntNgVkNrCQ1m4L+dwOrptklviSiZhzARbd8MAwlErxHedEd7rmP6GLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097646; c=relaxed/simple;
	bh=j8aY/HBVyMKEbAghmMkHagyrNS3Jy8oKX+FgGydDVp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Awxg3LGX6PNP0Q6NCQ3mbBTJz2V31yjsg4jg/lojVC8f+LAQQwDslVq/7tfMcpHf4qOjIp8UlNeTqdBRpS6MQseGmbZ6iviyngM6833ut5cJNaX1KBxx5sK5qswpdx4TdHvlcmz51iYZKeg5An+rKsrAd70Caragpr/dEssJtuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz18t1753097566tdcc2b135
X-QQ-Originating-IP: EHBGWkQh/64FOUdl32kETefme0DkHinNY03bd1hqlU4=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 21 Jul 2025 19:32:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13591894588143972826
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
Subject: [PATCH v2 00/15] Add driver for 1Gbe network chips from MUCSE
Date: Mon, 21 Jul 2025 19:32:23 +0800
Message-Id: <20250721113238.18615-1-dong100@mucse.com>
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
X-QQ-XMAILINFO: M/pyXQiX8GHdj2F4Iuks4wDMVbrgsifgprzT/uPKyJJVIVcpaJ87O/Lh
	wWfBnHY6D/kKWqoyvDjUGgkqFQa0BQ5Pyc1OVoeGuTpgd27rqyQJKQQH9OIspFtPJe495y8
	mnvd6HWMR0TfCuibUYlnqXE9GulfuoH8cvruMBxPF31r8QkCk90An1huzjkGN68p7iRvZbW
	w23IX9dEU8cHoOUQQueqdHCBFXktzVmDC+wUk5ZefLH8ZI7k6qkqos+ZY6umVCBGI8PTgzK
	rM5trOElWEeuy/24RW2RpxaJIeAVn9h3jK+O2i0bWWB4TgRD9xZnXvVHjXcFlCGZMxLKGIf
	sAYhAwc3zMUwdHfOSnbRHLV7FTgsM9DtgxHf19fmGClcCbwUidJzO8yifKKcnAGicsUdmsW
	SciYvyf//Jb4faqKbdGmCwSLvhfqWONeFoVLl7XA90t/AXykxFMXsFbLaED6mM4GfPeL6BK
	9KRutoh8i+O7dq3WOxeLx9cK0UWtPYb/X91+QN58oYVQKEipvje4ajNfwoR6U15WAcbK0Kn
	L6XHXuvVDAheBvtfyRNzenLokxsFrHPAHxnORybIxOhwp/dgznsay6duIY8u4qC9gAik+UX
	18HpDBb77dRU8VPeXXk3+OBnsiVEpNJxAWMBhDErF+6q+EKKwsO4jVldu0r+9EPLwfsBVs3
	isrEXtdlJUcPHSS9dAKP8fIBNRiKKvpH0YcwR3masRZ6qcd/nLyLDr+oToOMiUKtoBRHW4g
	fMoAEpKlJXGXkrwjbHFzw5+xbl2uc5lWfLDXdebPjoAFx3kthDb9anA2PsF7Ch5l/qtjSPm
	XRIG4gaTd+28eYxY7OAepvc0YNRVQA+6EV8X6FLn5AQfTC4xBVRsso0bEA5B4yIY9UVnx3e
	aashTl3uJKwMgyk9kYWXG+fQyOGC1Qn23JQFL7pbgBDZErS8eC6k79IJx2SKbXBE/XE+2Fy
	GrlH2LfVldc+UoGRiouYpyxdhU/T7EpQKN6OEQZT7m3H9Khamdc8a+BhuNyUwSfgFh6Skwl
	elHtKf6iQAfDBdMUYYl0EuXrQdl1v6ALpJc50IGxMEZOFnBl5Vkoi5kEaVO7c=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series introduces support for MUCSE N500/N210 1Gbps Ethernet
controllers. Only basic tx/rx is included, more features can be added in
the future.

The driver has been tested on the following platform:
   - Kernel version: 6.16.0-rc3
   - Intel Xeon Processor

Changelog:
v1 -> v2: 
  [patch 01/15]:
  1. Fix changed section in MAINTAINERs file by mistake.
  2. Fix odd indentaition in 'drivers/net/ethernet/mucse/Kconfig'.
  3. Drop pointless driver version.
  4. Remove pr_info prints.
  5. Remove no need 'memset' for priv after alloc_etherdev_mq.
  6. Fix __ function names.
  7. Fix description errors from 'kdoc summry'.
  [patch 02/15]:
  1. Fix define by using the BIT() macro.
  2. Remove wrong 'void *' cast.
  3. Fix 'reverse Christmas tree' format for local variables.
  4. Fix description errors from 'kdoc summry'.
  [patch 03/15]:
  1. Remove inline functions in C files.
  2. Remove use s32, use int.
  3. Use iopoll to instead rolling own.
  4. Fix description errors from 'kdoc summry'.
  [patch 04/15]:
  1. Using __le32/__le16 in little endian define.
  2. Remove all defensive code.
  3. Remove pcie hotplug relative code.
  4. Fix 'replace one error code with another' error.
  5. Turn 'fw error code' to 'linux/POSIX error code'.
  6. Fix description errors from 'kdoc summry'.
  [patch 05/15]:
  1. Use iopoll to instead rolling own.
  2. Use 'linux/POSIX error code'.
  3. Use devlink to download flash.
  4. Fix description errors from 'kdoc summry'.
  [patch 06/15] - [patch 15/15]:
  1. Check errors similar to the patches [1-5].
  2. Fix description errors from 'kdoc summry'.

v1: Initial submission
  https://lore.kernel.org/netdev/20250703014859.210110-1-dong100@mucse.com/T/#t


Dong Yibo (15):
  net: rnpgbe: Add build support for rnpgbe
  net: rnpgbe: Add n500/n210 chip support
  net: rnpgbe: Add basic mbx ops support
  net: rnpgbe: Add get_capability mbx_fw ops support
  net: rnpgbe: Add download firmware for n210 chip
  net: rnpgbe: Add some functions for hw->ops
  net: rnpgbe: Add get mac from hw
  net: rnpgbe: Add irq support
  net: rnpgbe: Add netdev register and init tx/rx memory
  net: rnpgbe: Add netdev irq in open
  net: rnpgbe: Add setup hw ring-vector, true up/down hw
  net: rnpgbe: Add link up handler
  net: rnpgbe: Add base tx functions
  net: rnpgbe: Add base rx function
  net: rnpgbe: Add ITR for rx

 .../device_drivers/ethernet/index.rst         |    1 +
 .../device_drivers/ethernet/mucse/rnpgbe.rst  |   21 +
 MAINTAINERS                                   |    8 +
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/mucse/Kconfig            |   35 +
 drivers/net/ethernet/mucse/Makefile           |    7 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |   13 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  733 ++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   |  593 +++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |   66 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.c    | 2320 +++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_lib.h    |  175 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  901 +++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    |  623 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |   49 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c |  753 ++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h |  695 +++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c    |  476 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h    |   30 +
 20 files changed, 7501 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/ethernet/mucse/rnpgbe.rst
 create mode 100644 drivers/net/ethernet/mucse/Kconfig
 create mode 100644 drivers/net/ethernet/mucse/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/Makefile
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_lib.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.c
 create mode 100644 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_sfc.h

-- 
2.25.1


