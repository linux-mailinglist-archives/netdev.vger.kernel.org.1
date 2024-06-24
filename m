Return-Path: <netdev+bounces-105989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD96F9142B5
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 08:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BAD8B2109B
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 06:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D332024B2F;
	Mon, 24 Jun 2024 06:29:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED7F1CFBC;
	Mon, 24 Jun 2024 06:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719210577; cv=none; b=NVrau8llXhq3N9a527w9AF9kLYAntojoPNnNM3v4LoIn40CYBcRCEARvku2XNDvJFzJHDAlP6jAv3QJXo72HWcGKug9WPtWzMwUpOqaAEV1W4PtbUyc+iOhrqjnGv4kGABEz3gdxrP1WXU5uCD8cKFO3P7g5qCwc0CW6AC08Ccw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719210577; c=relaxed/simple;
	bh=Wj7s7zfmFxK7++lk1T6C/GJQLSOXJZewLf/UDy0a6jg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iPx7sXPbVUEPie+0+7K+GQJf9JWwQyBKxf7vMyAQ/GnUGbzuVNDiGzmMD+3ZTc0CsDpQql+rAzr7L4cqNNR7WHp4N/iO1QvT9eZpHflvjvEUVUGBV7WJqK0gcgH0B2twe5XuasNOcYuacetEPi2uu7kiQ/KEa3Ml0l7Mf7Bcga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45O6SnNN22835550, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45O6SnNN22835550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 14:28:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 14:28:49 +0800
Received: from RTDOMAIN (172.21.210.106) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 24 Jun
 2024 14:28:48 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <pkshih@realtek.com>, <larry.chiu@realtek.com>,
        Justin Lai
	<justinlai0215@realtek.com>
Subject: [PATCH net-next v21 00/13] Add Realtek automotive PCIe driver
Date: Mon, 24 Jun 2024 14:28:08 +0800
Message-ID: <20240624062821.6840-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

This series includes adding realtek automotive ethernet driver
and adding rtase ethernet driver entry in MAINTAINERS file.

This ethernet device driver for the PCIe interface of 
Realtek Automotive Ethernet Switch,applicable to 
RTL9054, RTL9068, RTL9072, RTL9075, RTL9068, RTL9071.

v1 -> v2:
- Remove redundent debug message.
- Modify coding rule.
- Remove other function codes not related to netdev.

v2 -> v3:
- Remove SR-IOV function - We will add the SR-IOV function together when
uploading the vf driver in the future.
- Remove other unnecessary code and macro.

v3 -> v4:
- Remove function prototype - Our driver does not use recursion, so we
have reordered the code and removed the function prototypes.
- Define macro precisely - Improve macro code readability to make the
source code cleaner.

v4 -> v5:
- Modify ethtool function - Remove some unnecessary code.
- Don't use inline function - Let the compiler decide.

v5 -> v6:
- Some old macro definitions have been removed and replaced with the
lastest usage.
- Replace s32 with int to ensure consistency.
- Clearly point out the objects of the service and remove unnecessary
struct.

v6 -> v7:
- Split this driver into multiple patches.
- Reorganize this driver code and remove redundant code to make this
driver more concise.

v7 -> v8:
- Add the function to calculate time mitigation and the function to
calculate packet number mitigation. Users can use these two functions
to calculate the reg value that needs to be set for the mitigation value
they want to set.
- This device is usually used in automotive embedded systems. The page
pool api will use more memory in receiving packets and requires more
verification, so we currently do not plan to use it in this patch.

v8 -> v9:
- Declare functions that are not extern as static functions and increase
the size of the character array named name in the rtase_int_vector struct
to correct the build warning noticed by the kernel test robot.

v9 -> v10:
- Currently we change to use the page pool api. However, when we allocate
more than one page to an rx buffer, it will cause system errors
in some cases. Therefore, we set the rx buffer to fixed size with 3776
(PAGE_SIZE - SKB_DATA_ALIGN(sizeof(skb_shared_info) )), and the maximum
value of mtu is set to 3754(rx buffer size - VLAN_ETH_HLEN - ETH_FCS_LEN).
- When ndo_tx_timeout is called, it will dump some device information,
which can be used for debugging.
- When the mtu is greater than 1500, the device supports checksums
but not TSO.
- Fix compiler warnning.

v10 -> v11:
- Added error handling of rtase_init_ring().
- Modify the error related to asymmetric pause in rtase_get_settings.
- Fix compiler error.

v11 -> v12:
- Use pm_sleep_ptr and related macros.
- Remove multicast filter limit.
- Remove VLAN support and CBS offload functions.
- Remove redundent code.
- Fix compiler warnning.

v12 -> v13:
- Fixed the compiler warning of unuse rtase_suspend() and rtase_resume()
when there is no define CONFIG_PM_SLEEP.

v13 -> v14:
- Remove unuse include.
- call eth_hw_addr_random() to generate random MAC and set device flag
- use pci_enable_msix_exact() instead of pci_enable_msix_range()
- If dev->dma_mask is non-NULL, dma_set_mask_and_coherent with a 64-bit
mask will never fail, so remove the part that determines the 32-bit mask.
- set dev->pcpu_stat_type before register_netdev() and core will allocate
stats.
- call NAPI instance at the right location

v14 -> v15:
- In rtase_open, when the request interrupt fails, all request interrupts
are freed.
- When calling netif_device_detach, there is no need to call
netif_stop_queue.
- Call netif_tx_disable() instead of stop_queue(), it takes the tx lock so
there is no need to worry about the packets being transmitted.
- In rtase_tx_handler, napi budget is no longer used, but a customized
tx budget is used.
- Use the start / stop macros from include/net/netdev_queues.h.
- Remove redundent code.

v15 -> v16:
- Re-upload v15 patch set

v16 -> v17:
- Prefix the names of some rtase-specific macros, structs, and enums.
- Fix the abnormal problem when returning page_pool resources.

v17 -> v18:
- Limit the width of each line to 80 colums.
- Use reverse xmas tree order.
- Modify the error handling of rtase_alloc_msix and rtase_alloc_interrupt.

v18 -> v19:
- Use dma_wmb() instead of wmb() to ensure the order of access
instructions for a memory shared by DMA and CPU.
- Add error message when allocate dma memory fails.
- Add .get_eth_mac_stats function to report hardware information.
- Remove .get_ethtool_stats function.
- In rtase_tx_csum, when the packet is not ipv6 or ipv4, a warning will
no longer be issued.

v19 -> v20:
- Modify the description of switch architecture.

v20 -> v21:
- Remove the 16b packet statistics and 32b byte statistics report.
- Remove all parts that use struct net_device_stats stats, and instead
store the necessary counter fields in struct rtase_private.
- Modify the handling method of allocation failure in rtase_alloc_desc().
- Remove redundant conditionals and parentheses.
- Keep the message in the single line.
- Assign the required feature to dev->feature and dev->hw_feature at once.
- Single statement does not need to use braces.

Justin Lai (13):
  rtase: Add support for a pci table in this module
  rtase: Implement the .ndo_open function
  rtase: Implement the rtase_down function
  rtase: Implement the interrupt routine and rtase_poll
  rtase: Implement hardware configuration function
  rtase: Implement .ndo_start_xmit function
  rtase: Implement a function to receive packets
  rtase: Implement net_device_ops
  rtase: Implement pci_driver suspend and resume function
  rtase: Implement ethtool function
  rtase: Add a Makefile in the rtase folder
  realtek: Update the Makefile and Kconfig in the realtek folder
  MAINTAINERS: Add the rtase ethernet driver entry

 MAINTAINERS                                   |    7 +
 drivers/net/ethernet/realtek/Kconfig          |   19 +
 drivers/net/ethernet/realtek/Makefile         |    1 +
 drivers/net/ethernet/realtek/rtase/Makefile   |   10 +
 drivers/net/ethernet/realtek/rtase/rtase.h    |  338 +++
 .../net/ethernet/realtek/rtase/rtase_main.c   | 2341 +++++++++++++++++
 6 files changed, 2716 insertions(+)
 create mode 100644 drivers/net/ethernet/realtek/rtase/Makefile
 create mode 100755 drivers/net/ethernet/realtek/rtase/rtase.h
 create mode 100755 drivers/net/ethernet/realtek/rtase/rtase_main.c

-- 
2.34.1


