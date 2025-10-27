Return-Path: <netdev+bounces-233070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B304C0BC09
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 04:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9670B34A9EE
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 03:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7360F2D6E4D;
	Mon, 27 Oct 2025 03:29:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9ACD2D5C9B;
	Mon, 27 Oct 2025 03:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761535795; cv=none; b=O0nYOdXsUlXHBRRvgigf5eJzdH9WDobkgA1bbRF+1QjRhuAJFMwTdb4V+H//KrdWqonq37u8mrHwQmRmV/Ju+OP2vnl0MiBxT6llNvRdDshXdyBBAypdIAICsq8hQtcosPkA54ffIH1IiZiCEnxX1j85ZXR88bPz0FH848KC3QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761535795; c=relaxed/simple;
	bh=lRA8n0TGjHPZcdwnpDWKyoO9RVo48D9SjUt589DFzpA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bOkSFmx3DH8ofUx+/pArYfab2YCQcMb8XcW5niHpfPI7Vzc2EctA8lYbf+cz6gG1uNM4CqGMFchUHfqoXj20qC0RO39AG5DxWtxJcsORZys+h/O6gWb+GJxiVoIU8CSPbwjni0w5ixaRDIP9rHESCpA6zuanQb+CYt0V/1ntNgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz2t1761535756tf0b452a9
X-QQ-Originating-IP: licCKsMsUoauo/qqyG2xiHHmoO/xjMzrMjf1VtSh09w=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Oct 2025 11:29:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15893421315603861346
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
Subject: [PATCH net-next v16 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Mon, 27 Oct 2025 11:29:00 +0800
Message-Id: <20251027032905.94147-1-dong100@mucse.com>
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
X-QQ-XMAILINFO: Nj/x19RzgDOAfKfVhBIh2V6tyS9Hbt9vBpFAfLJuiKBwII3+FWUMh3AF
	ovpg+RInuyEQO1Ik6JoK7r1wI9f+U9RxpDOpacNQNgkDIcOyhQhXL2cj9O7cyA8YHqSAjoK
	F31lXWD3pwpPCDoy9PBrmEWkNn7emkhzMP0awIFFuocBPsgcBI2DkjhmWn9oWeoCUXgYseJ
	FJFBL3zQ7dgh1bihISkHYE3xWCdD107GX+2gA+N9ojTmQroakOtThzp2/NoIexFVWf5SEWg
	Wpc0EufxF8UWvr+sf5BFu+Ji4BmSZ98fbl3U95P08seeQ7kIfIlusl/mIKAMrqlA3c9UtOZ
	6MKiGzsSSpillkn23VGxyRtl5MioRljYsr7j877P2Kmk46uyrFbK+iKghDJXcIXhiSIAXK0
	CPvJWboqTKasBNp8rjMf9t26Ni9W44ZR9tiVWO6jQfuSNHVIM7+CaFbbsvCan9ns/QewNjb
	DqWNzU24VfL2yau15pRUOBW8hEroz99XYXhr1ZJu5QOca2Xpe0G1cpS1khRKLHwOwUpPbPp
	mLGEmto4oxcSuNIvCo+3o9+KKF2bgEmkBF2da9GJ7y/ZNu3+NdUB09dWMrHF2Reu4G/Twtt
	NnULn9ySUGmXLIIQyQJHONONjQ9dWqy0BLMrK0y6IRv1VniTP1tJ2OXjoJxPLBdPYN20gs2
	fmPynuvmWHzZol8uaskBjgjHRfKBcsYvZQDT+lCVKHsse6Duy7zBBZU+14jOav6Q8I6asn1
	REllJKR6BynlG3LnFM7T8U2isMaWsFuuMZKsb51hZQ3hsSEKm7LiJLiWbiSk4wYwPuCjuTn
	MtKQHNsmq4RlKw+YLSmRAx1DFz7dmuDQHPFl5c17NGYtC1NsY4OECohO+iqBmBG00UXkgbY
	/2gOuv4YSwQnFO1FBFze1UMxSU2if10H/Euc90+2WpOekQwekKR1NwvmassZMCHuAkF2IH6
	UA+cFbxGQ3SV5q9ZoNZcsZy88L2Uru5DFfqretuVRXhHmv+yGqMmWxkE4NONdUqpET3x1Zb
	XYWszrZ5eoeUacK5zIIziy+FhDAa0=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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
v15 -> v16:
  [patch 4/5]:
  1. Remove local variable 'info' in mucse_mbx_get_info. (Vadim Fedorenko)

links:
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
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  73 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 143 ++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  17 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 318 ++++++++++++++
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


