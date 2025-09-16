Return-Path: <netdev+bounces-223489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F84B59526
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 13:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D557A8476
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 11:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F6F2D8372;
	Tue, 16 Sep 2025 11:30:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A602C2C15A3;
	Tue, 16 Sep 2025 11:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758022242; cv=none; b=iKMKGe213UeytYnnST4n2x6yBhOB5FIHfO3vozqzurP5/GfDc0iMn0PuV/kSLx+EO485KIWy3pnOi56wjAwCwFnOwSgqG9+/3ha84hAi8ZTIaVyYuyTDNW3bkgAQX7xEdFytrWfH2UluuZVXjDIIE3wTbU4HOlRMv+fhh/FmyXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758022242; c=relaxed/simple;
	bh=R76IMJLguW9jEl/x6KjDzeHvljOVNXxID7Gge6OE1z8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WKyWLP+pUAY1aQTrcQeIbxgXQbAJCK7KRZMdGjfeK7PnZ5gcvJO3NFOylRH3BOFRNPSv4lO4Md6YZw4mYEEky83/fDgzaTKktAx0Rb+gOLm9WnbnuNUNuebbQMQk+8t+1QVlrviArD75kEJFt5grZQpawiCEdybGfAhKvtsWrAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz17t1758022206tc6521c11
X-QQ-Originating-IP: q9jwI2VI3r4VL+Xrm6HltrFEmT8gcCMxyZhOgQttr5o=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Sep 2025 19:30:02 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2406107247980798672
EX-QQ-RecipientCnt: 29
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
	vadim.fedorenko@linux.dev,
	joerg@jo-so.de
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v12 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Tue, 16 Sep 2025 19:29:47 +0800
Message-Id: <20250916112952.26032-1-dong100@mucse.com>
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
X-QQ-XMAILINFO: NVmy503YIpjOPeg7/iUtZ9JGGd5jcCxY6+I31a2+QSF4re1SUCUxzIPY
	CyxPyOkObyZpQGlgWdluPEDBkIMOlYFI0nXTthqVuvB/QbbxPUKOfi0qVRb+gVcKo5DWixQ
	INRK16oOUB8ap+tp1Nb6wy7akUnnPDQ0lLJqpUGiS8T7rSdlOSiRedXD9B/wuGhmGCfzQ3L
	sYL4N4I+OtWQFPORh/I+658hdyV2HfMvrx3coy4dS31Et3bKP2a07PsBAw1xsCKR8l3JK92
	SH5WtPK9fF9cSDHOBxfGe+BNxCtaj7ofZmnN8uOKBXE+ZJBqRm9BRqXxFo+log6Sf3pPQC+
	GzHNMhcsEvkqEqt2F6R+gkpQkUKNlCZyBh+H7Lt6cQkS1GSD9WZj9JQDB0mp3qXOLh7RUy3
	DBKpfrm3/y6JTF/DYO/aqHfcir0iXAPm8kmioqRDw7Mny8cdw2ifP09YzI1KemlyuTls0nH
	t2JQIb4FIssjQAeBGjuaq6NgoeU0nkcBrttNIUk98LY7hffz0d6Ukl3Rbd7GyLVns3pc1hz
	Y38jPt++BdSEFXGQuthZ9oFfNWLto2oL2da0woUBFvAqfFnmT0z7TjTfRkzN9u9qbLTVYhm
	0jSxg83g/P8L6H3OOjiVXF7ccB9xProygrOcpUw918Tu5qav2KR+iBzLZJ1YI+kn3cnKhn2
	xVt5l1XMN05UqSZjgEIxHfrAxsGP3I3Yc6pCDaXSlEck6BPkP0uhPBqCrGB5mB5nm0JzrSn
	rIL4kPjoYPG5cisIBnn1Jzrb+TZIYxGkYtDttwXb8+//ZCDcw1Y+hbJNh+JEfyamv0S9Hu0
	mNxA71BU3hFe9Vl5CuSVoo2pdk2JSecIgWqnYaKvVV5dwh3YQ4auDUh++h/SbL5xCn7N45K
	ZoVoaSwcrYM3pEd8pZDYPcCAMSQNhbdbRWupKFnj7CgEgD+52JxcAvWYb4AOn9Tq4fLmHD5
	jK/AbzJQLAGh+OwxzwbsEPTRuiRf8jAcbdkM1hoxOoLt3V2tCsKiblx7eoXbqVkMbBqhDdd
	1mvXE5c77VTtXueCxaYB6EO1nI5c66eV+TiBnlmA==
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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
v11 -> v12:
  [patch 3/5]:
  1. fix switch code style.
  2. rename mbx struct define 'timeout_cnt to timeout_us',
     'usec_delay to delay_us'.
  [patch 4/5]:
  1. update function mucse_mbx_sync_fw.
  [patch 5/5]:
  1. update commit for rnpgbe_xmit_frame.
  2. update define position for 'struct mucse_hw_operations'.
  3. remove struct dma.

links:
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
 .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 +
 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/mucse/Kconfig            |  34 ++
 drivers/net/ethernet/mucse/Makefile           |   7 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |  11 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  75 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 150 +++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  17 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 311 +++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 421 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  20 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 246 ++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 121 +++++
 16 files changed, 1445 insertions(+)
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


