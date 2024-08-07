Return-Path: <netdev+bounces-116301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A71949E4C
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 05:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D796F286391
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 03:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F59E82863;
	Wed,  7 Aug 2024 03:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="l/8qvnLy"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8531023D7;
	Wed,  7 Aug 2024 03:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723001896; cv=none; b=CB0N6WtZ+0lWTFHc98Sr84q7qWF/x9IJo+hRz2djKJrdQKWN3NVWBaFSxL18giMkLLxNnbUIUUhcYOUuwwQe06YIP+hcAbZD3CJlwTZ67EDwenJod+8XZ4N03/BXdJTZMufVA0v9MoT2ZP72NkTuSufMSWgsz/ITSQsqXIL19VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723001896; c=relaxed/simple;
	bh=hp5BcmolYSlGtl/ypt0jpCMjzDEIyAQmL5v/ycDhoGw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hLLH/LLwvsGCE6v65X8ELBxpQTAYcqkqks9gWD8V3ZS1CQKFBvHfoEJDFx8FOFS4klcctleXly3gqPll+PrKjzXtrKn4VEUZBnd1N+H1Z6jbCB3EqCtXnmrFs7eYZOYFo5McxDEwk4ehVQlFPnhN4MrH42dnpoN/cw4nYWnl/R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=l/8qvnLy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4773bWuI51919193, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723001852; bh=hp5BcmolYSlGtl/ypt0jpCMjzDEIyAQmL5v/ycDhoGw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=l/8qvnLyCZL1ndVY3/o2BOtXUY2jfuqq98aJOVwIjoRtFhNb3jjWJWrxuxTCpLlf1
	 aIsY02wGqA2lT+EdFcEHSkEa1NNE3aWnrdpvaM8ZZAqPhltFiUBsYB85DdYuDMy70P
	 CuXKjf7SE31FSVJQzeiD/DGvAYqsgEBwPXBYOWjlRRF4a7ULuaQt4HtmyvilrEBQTR
	 hQ4lP3wjI1DiIvU78ZycXZJ34t+t7GSYq3W/SOp91KKdTb02OT7F08PCRifajlDUJa
	 1lItSKB2e9YzFHG0FtRWQyupBJaz3p99HPRoPDXJZyWV/bK94RRThrVPAtrn8wlwgq
	 RW/OuWpQqBcvA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4773bWuI51919193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 7 Aug 2024 11:37:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 7 Aug 2024 11:37:32 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 7 Aug
 2024 11:37:32 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <andrew@lunn.ch>, <jiri@resnulli.us>, <horms@kernel.org>,
        <rkannoth@marvell.com>, <jdamato@fastly.com>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, "Justin
 Lai" <justinlai0215@realtek.com>
Subject: [PATCH net-next v26 00/13] Add Realtek automotive PCIe driver
Date: Wed, 7 Aug 2024 11:37:10 +0800
Message-ID: <20240807033723.485207-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
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

v21 -> v22:
- Fix the warning when building the driver.

v22 -> v23:
- Remove the execute bit setting.

v23 -> v24:
- Remove netpoll handler.

v24 -> v25:
- Re-upload v24 patch set

v25 -> v26:
- rtase_start_xmit(): don't increment tx_dropped in case of
NETDEV_TX_BUSY.
- Modify the rx allocate flow, build_skb() should be rx_handler().
- Remove leading underscores in the macro name.

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
 drivers/net/ethernet/realtek/rtase/rtase.h    |  339 +++
 .../net/ethernet/realtek/rtase/rtase_main.c   | 2309 +++++++++++++++++
 6 files changed, 2685 insertions(+)
 create mode 100644 drivers/net/ethernet/realtek/rtase/Makefile
 create mode 100644 drivers/net/ethernet/realtek/rtase/rtase.h
 create mode 100644 drivers/net/ethernet/realtek/rtase/rtase_main.c

-- 
2.34.1


