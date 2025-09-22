Return-Path: <netdev+bounces-225117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC22B8EB4E
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 03:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98C03AB4C0
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 01:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92AED1917E3;
	Mon, 22 Sep 2025 01:41:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AC92556E;
	Mon, 22 Sep 2025 01:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758505315; cv=none; b=OZ7jc4+LHeXZ5NqazRWTO7W0gk9eVypXB4r4UxQCSsJbnxE6tX5AhR3B/RFmiEOSz+bCCljv4Tpdsuzb08crJvJi3aC65DPtoIfRjofmb7LX/grPDxzT2p026jiJcXQPU1o1UECkJihmOgCoRp09ykw1Z5O05+C5mTCHCvWMJ64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758505315; c=relaxed/simple;
	bh=jt3E/FQju5XqTNcX4Neabs4RgiDEwWw8cCFRhreUgg4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=irNBz8Gc21iPbO8d513TRkVt+2hKIXFOXasxYrRRlG2Dot8PZLdmWDOa6+1vPhbDz5mbgu/scS7xR8iNcGjbb8j+9h29pBICzjXh24fr2Jh+E2JNXWUOACKuS15XSj75zi6U0f5crwYk7UzJIxmCcxkz//WPge+acOHTYFQLICw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz16t1758505277t6c45a273
X-QQ-Originating-IP: EAYE/mq/Jbkc9QoGXHSJ22z4bzZUUJrOO7tdb4ZxpP8=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 22 Sep 2025 09:41:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15385940404890056032
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
Subject: [PATCH net-next v13 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Mon, 22 Sep 2025 09:41:06 +0800
Message-Id: <20250922014111.225155-1-dong100@mucse.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: Od5WFV7YIo+Kwjhf/9eQR156VKhboeOHBErN38hReNVCWk0N8bfOdvh8
	ygh21wVT2lKQONDmMhdM4SPRR3dQzkZ0bts48oy1SPYxxPUnad7Z05qR2wnGgACybmGGCmq
	gOqTywZwgdtcALlFI2sge+LRy7ONBoHexFqzti/3cQBc9oE33TuZzuVGYJF506H0ZvvTYPC
	iGUOzMOI87AYSuoq94pBKwpBfy51OEn3MDFR0CVFPTUM+GoAm6/naWRP3mbh1P8lmqYoVyI
	vTc0dRM+2kFw8vlJ98m3k5xaiTGgSIF64kPVYf9jpTZ+dGYb+a3WZXZf3mwG+sn+cXG97T3
	WS27YPa/8tf7PP6chG7DJsfX67z3BrGs3Jrt15ghTqx+6O6xK5kfKQvJuxduZ12xU42tCyN
	IbXp5LZA2ijKskLM3pcprPqIOxdl0KcIiccBlP4oi8JZ0+s6uzZZXGDP1JeszgQHeVNaQZA
	eLVMqehFgzsIn6jSZzL1ZUiePGCLFSKeE+LHV47+8d6Th8QwnVSWs6NdGFfoES1WrJuXtt0
	OKYL9Ql1aSVSStHjml+kNsN5hXm8Dsj98V1tuFrqsf9rqT/cP05Uj6ClT0MmA/Chp73v/ea
	9Hcvp7bubAyMt8xYL17kqaYIlzOVo9BtdViBduZ3mvU1+onMyqbsAoFZ39imSt2qpldcp7O
	AhcyVglZlOL8O74j+bgfWH65qK5eQgAwMSAlXgS7GEeMtw28zKTqgeIo0x2mnEgWCQc6Md4
	sXTWFqGXM5/xXRSkNe/1iSKpexrQ+EyJjhdRgSP1FHZZA+VNVnGbzUCcm0T2ZB5Jb0U3rhT
	v8XKtPqYGNw4lmWszyDjxvlYZ3xCa4zW0ZrdpmgIy7PYPArohXvBmeuTEgaeClTjJT/bFP/
	fS1IY+NokpEKyE9XLtDtDIH1rlzMmtHdmUVmFShPGx7AWs1NCpSVe30QB9VQ/hAtcDldvQt
	a8+NuGvZtsSzmMFzl/22FV5RPT8ZIbXkcWEYuL2MAGcNwxCx/zLfLzKUM2fvV5qREkLohHq
	nh75ykWfSks4AMFkAoKUnnGYbmi0yZf/8jjOxECw==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
v12 -> v13:
  [patch 1/5]:
  1. update code style (Jörg Sommer)
  2. Use PCI_VDEVICE in pci_device_id init.
  3. Rename PCI_DEVICE_ID_* to RNPGBE_DEVICE_ID_*
  [patch 2/5]:
  1. add blank line before 'err = rnpgbe_add_adapter'. (Jörg Sommer)
  [patch 3/5]:
  1. Update functions(rnpgbe_init_hw, mucse_write_mbx_pf) kdoc commit (Jörg Sommer)
  2. Update function mucse_release_mbx_lock_pf (Jörg Sommer)
  3. Use 'for (int i = 0;' in mucse_write_mbx_pf and mucse_read_mbx_pf (Jörg Sommer)
  4. Update mucse_check_for_ack_pf and mucse_check_for_msg_pf (Jörg Sommer)
  5. use 'int err' to instead 'int ret'. (Jörg Sommer)
  [patch 4/5]:
  1. Remove build**. (Vadim Fedorenko)
  [patch 5/5]:
  1. Add commit for one value in enum. (MD Danish Anwar)

links:
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
 .../device_drivers/ethernet/mucse/rnpgbe.rst  |  21 +
 MAINTAINERS                                   |   8 +
 drivers/net/ethernet/Kconfig                  |   1 +
 drivers/net/ethernet/Makefile                 |   1 +
 drivers/net/ethernet/mucse/Kconfig            |  34 ++
 drivers/net/ethernet/mucse/Makefile           |   7 +
 drivers/net/ethernet/mucse/rnpgbe/Makefile    |  11 +
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  78 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 150 +++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  17 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 308 +++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 416 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  20 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 195 ++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 121 +++++
 16 files changed, 1389 insertions(+)
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


