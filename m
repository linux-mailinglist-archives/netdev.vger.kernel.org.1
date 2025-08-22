Return-Path: <netdev+bounces-215878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BC7B30BD5
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 04:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2DDC684974
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 02:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C014126C1E;
	Fri, 22 Aug 2025 02:35:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FEE2F5B;
	Fri, 22 Aug 2025 02:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755830120; cv=none; b=JGQKOAH1Et2GEdOIxAx7DUivB6ibvKVV1CiSu3vg3gorFFwEn3oyNFW9DR1syVSnPFGPcF2yNvQTGgU0PGsSboaav2AK9wc2i/7A9yc2jL9qum4vUev/z55LABt/gQutwcyKrun3Ad1R/25bzpMCy7rJWJoEWEM0UhJvKytnb4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755830120; c=relaxed/simple;
	bh=wwGyWdIK50SWbagIxSxLZMJ6FDsAB7Iq2+T8A8L/TJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PZhCXITlyZn8D1MMFdWoKT8T1lKSKU0goeHH8Oanm0n4XQjbXJa3Dnsa3+qltTDkPVSKWmhexwfUbPYiK9cmar92lLiARLzGjYP+H577yZwCUAZzDP7bizff216pB5OwtuKPs8biT2xjXxe4tH7kVFm7RLx23Q+3vLQbQMO1WUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz14t1755830103t98a9c31d
X-QQ-Originating-IP: m9IEAcTsEl58MHXimhfd+ED7bwkpmxqoK/WkVKrg1q8=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 22 Aug 2025 10:35:00 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15671151008578251327
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
Subject: [PATCH net-next v7 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Fri, 22 Aug 2025 10:34:48 +0800
Message-Id: <20250822023453.1910972-1-dong100@mucse.com>
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
X-QQ-XMAILINFO: OXGhtQv6wXy4Gw9V1k1xdiDBsI4q6ByXzT0R0VM3WyfRExF1PZGGByaw
	bXM7uoF6kQRlAA5JuOonZ4EW5azEIN1RsmPMuwiIKVrzzmgFyOHAhdINGGoxwZSjqJqFsia
	Z43PQhschmufCON1HFURljZjouUsczTzgCmUtm10MTXQzstkvQqc6dGrFlq4Muzxj+32XNc
	Plm+wLT+NGAz65/auksjmQV/fwZw3JPqyJa+bZvzwZQYQcTio6HyGYA93DWFnZT4FyhXVPQ
	+YT5orHs8ewONptp2Qh6mEjcvb7Qz5OJpFmCtyB9S0W4IMYw2WtO1tXjEBTo2SjLviIvAGr
	hNEBa1ccNyC53lRChIFphgHM6tCllKOnGiAhZfocajoAb2ExGNUMIWHUTB7PA7mNJTu9yTK
	mRMSY5FFd17lztJqZIvPcbdpjHzI/loDfGoPuEflTil+mfdz/WLY8muwYMtsS5QbMhnu9wN
	hqpIY2IdXrY3pmlSoINx5WjbiEguby/6qUWb8sVRrxNGddvtC92HhYXozC986icWjw12BrV
	6DpxhkQRygA8kr1oKKQmXRFhsuTw56716pcYyMlbPkgi9gBacuVG6kdRmU51dKaMqhvsNl5
	Ztdgdln8O5VavlyOG8gqOEWjUXlpI6YklbEILhZq3CtV9Kr41BCoGq3T9WAT3fvq3AFz31E
	j0VOhKKQHa6nMrC67lC+8/tnyHhtEzhzAFS1invPOzXSUmsgufbdrTBBBD3yLy+dVokayJz
	z8enerq/b8wkQnoRcDKebish/sqByN2V549chtQkRwOuz8ra7kZ9euptCBlhXMBM9vcow5H
	8t83FOgsfzY5O7Mrir/u+vGBhPgpeTmkIsGFAsrltmu3lu7HZ0D8xVZ/qfkuu/LzmKPGqYS
	OyYx4bmqQai38hxxKdIDSBBqGj5W/HNAMlmdHITfgM0J/Mmisqysiw6nYnlqungP8JCvpoP
	8Ii87DHy17irJrEhnU6yn6Ipj+QAfnUuLrOB6G0aneojcDT4TYK6XjkopCstJlxabtQIFAG
	FhsD8qLyJJ/DbIM6Y5gWgmapfrhTeKphyaSZ305Xq5lVSu7HCffwXaJoHpnCYswE4W9fT+B
	nBLcOV9fxy5Po+x8GNAxtKJvkAPnDYADQ==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
X-QQ-RECHKSPAM: 0

Hi maintainers,

This patch series is v7 to introduce support for MUCSE N500/N210 1Gbps
Ethernet controllers. I divide codes into multiple series, this is the
first one which only register netdev without true tx/rx functions.

Changelog:
v6 -> v7:
  [patch 1/5]:
  1. Use module_pci_driver instead 'module_init' and 'module_exit'.
  [patch 2/5]:
  1. Remove total_queue_pair_cnts in struct rnpgbe_info.
  2. Remove no-used functions in this patch series.
  [patch 3/5]:
  1. Move 'MBX_FW2PF_COUNTER' to 'mucse_mbx_get_ack'.
  2. Call 'mucse_write_mbx_pf' directly.
  [patch 4/5]:
  1. Add comment for 'wait_event_timeout'.
  [patch 5/5]:
  1. Rewrite function 'rnpgbe_get_permanent_mac'.

links:
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
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 153 +++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  18 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 282 +++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 395 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  25 ++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 333 +++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 152 +++++++
 16 files changed, 1541 insertions(+)
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


