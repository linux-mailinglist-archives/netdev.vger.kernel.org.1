Return-Path: <netdev+bounces-229067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D65BD7E0F
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11799423CA0
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF74430E0E7;
	Tue, 14 Oct 2025 07:27:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E6F2C11DE;
	Tue, 14 Oct 2025 07:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426867; cv=none; b=oEtTKFuhtMhumPs/QtNvvlXe9r+CW5E6790BAHdvMfMgYDkaFXoLMhHxnTDbAday+8WnFNYeWaArjvQp2sKv35Y0nC2+njzRJCvPrcl77H8KS7s072wfZ7SyjxvzQo2aiV6uCgSl+r1gHi8haZzrBU1RHtpi36zCrNuLEjtYZ8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426867; c=relaxed/simple;
	bh=ercN3m/lbiVZJOB815AgAGUqHGfZdPa0EZwJQwSSQyE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ptHWAjYS4VHZ58zyoWEZ8egnWUE/F9gX6/qkNFSQIg87d/xu305EJs35B1hrF2a46kSZzLKCK2unQ+jD6s45QUDvCk0lLEx1HLx7+yRnbumLlyP+/fMzNcKbAxFw1UzcBwa/eEsCPIo56R1h+56k3/Zn35rrwlQg5tWCs49hFqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: zesmtpsz2t1760426847t5f145fa5
X-QQ-Originating-IP: P2rzOQ8Jqg5nbxg7tVaaQk/FzBrHBGNX/YnzTxqzzR0=
Received: from localhost.localdomain ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Oct 2025 15:27:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4723640594286060993
EX-QQ-RecipientCnt: 13
From: Dong Yibo <dong100@mucse.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	andrew+netdev@lunn.ch,
	danishanwar@ti.com,
	vadim.fedorenko@linux.dev
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dong100@mucse.com
Subject: [PATCH net-next v14 0/5] Add driver for 1Gbe network chips from MUCSE
Date: Tue, 14 Oct 2025 15:27:06 +0800
Message-Id: <20251014072711.13448-1-dong100@mucse.com>
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
X-QQ-XMAILINFO: MEbzWFWMGv8jFhncA/Bjp7Bdgm2BSQ/iZvF3814kjj1XpaCvRwz4i12m
	/JBLif+zyiquCtsnFpomdtE4K92oD3CUGJh4IRmMlX4wIrsxPGRh448iqEKCiPm8PZNL37+
	f95UeIp85oV2SOTundECrVMVZ/zl7JV8IrKDdHLk29PtD/9NJVWjLPFhL4g5T7jyLwjFRUl
	DhoK014W/hTfjPxR1KsucEoFe6TA7xIi1+VKrECn5Z4VpY4H9jUmhSqe4H60WOkp9nJlSbr
	iZ9yt0QaLXtcRDZZvYiBkmu9swReKetzYJEeqwA6EZPEI6FfIPAIul4lNbkD9OxCRfq3gY8
	WKD2RDMKlPacfKdoiFNfgifjr1kDKiUrU8Sl2GUUyiB08P00cjuAlJ8V8e0szc2b7kBhiRb
	G9Uzaxzb/mpHMN106XyhVx5edWv+KrZ/VaFq6g3C5RpjarAKbdinQ2CABceVsfvI0D2Ph23
	4kCqd4N5xr2iEVJwT/jQPMH8TQm3sSkeXFnnFQz4TC+ezpajcgrGRxgmPqwbs//1RMvjpYp
	iDfNZ0AkDKkSRn6o0GpmgANDXneT77rCXbhlKcbgpkvpSJKAeajpT4dF8FAGh4OK6MjL9rT
	TLMa5HPghpwVK9bl110aSIMqOROF2umd0XSU0FKEhDBBXb6yM1NPzIeVpyN+6gMigrD1fFm
	/uxsFvZ4PwoHxJlo5hXVyBy93RV0/HHgzBV0A8aIMyhAPDCPkiBaAq8Cmfi6vJGIA14WYqV
	VllflRYe2Al8/DtEAmb0D/J7FJ4w/OddrmY87Q/h5nCgwha0b0b75wtIa0EGfIKNN+zVVtf
	2qiEDN/T87TlFAfI5xYYO6su8JCAkOjrRkZYtsTqzWPnDVrXN4PDGzbF1pFUnu8hDku9DO4
	h8b1BiZjq0R1MgVBb+jzK06Rzj4yeczI8946QP551n81pFMyq4tKlr4z2cQCtMj8M5HpB1w
	7PP/A7vzC+1YuKU+r7uzg2wCJltCxK9tCjqocgYFT9vT1f/xI/QjgB4Neeo8AGB3MV1UVdR
	Cia7kxRiSSsU2Sty4R5I4sG9R1XGTHIztH4X8/s45js70gYsPw
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
v13 -> v14:
  [patch 1/5]:
  1. Update rnpgbe.rst (Remove copyright, fix out of order and remove
     support statements). (Jakub Kicinski)
  2. remove 'select PAGE_POOL' in Kconfig. (Jakub Kicinski)
  3. Fix MODULE_AUTHOR in rnpgbe_main.c. (Jakub Kicinski)
  [patch 5/5]:
  1. Remove mucse_hw_operations define, call func directly. (Jakub Kicinski)
  2. Add err_powerdown to handle erros after powerup. (Jakub Kicinski)
  3. Remove use deprecated netdev->stats.tx_dropped. (Jakub Kicinski)

links:
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
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  81 ++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 143 ++++++
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe_hw.h |  17 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   | 318 +++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.c    | 416 ++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx.h    |  20 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.c | 195 ++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_mbx_fw.h | 121 +++++
 16 files changed, 1390 insertions(+)
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


