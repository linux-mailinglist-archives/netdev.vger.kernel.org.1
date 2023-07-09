Return-Path: <netdev+bounces-16287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A11474C61C
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 17:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A217D1C20964
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 15:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3209F14261;
	Sun,  9 Jul 2023 15:16:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D800A14262
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 15:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3569AC433CA;
	Sun,  9 Jul 2023 15:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688915813;
	bh=+4OD2e+nUE3H3B/U6CcfTS29ZMGsdufMVRQ2jG7RYIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ExntHOyZ2yLTbF65JutdPuyKvBjAQ31069I28DhVd0i4IpIrxYvTfQMqWMaLfiaoc
	 DjoaHHCM1Bwak5CywyFtOg5DwrM6gYM3kn0QKqI3BPfJj+Dhle+mdU/dmIcSbYwKR+
	 qdI8ZGyBhKXL/4EaKxhaVuWNrN2tXzGvCuQgAkDeXMuWmOPRIjQjWNqYZ21c/p4r1Z
	 YOmV3VJNhx5BPpA38wjMEFm8JQ38JYIPKCVTdQ/JFUrmmrs13o887c9H4WjcLIFt8m
	 b6G/Vs9peTgeNWK0ryCb+c8ICFN11ogV15Kj/OV7gikQ72fvFdHtcYQkAEHGWbgzVZ
	 eN8TDB/0yhdtw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ying Hsu <yinghsu@chromium.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Simon Horman <simon.horman@corigine.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 4/4] igb: Fix igb_down hung on surprise removal
Date: Sun,  9 Jul 2023 11:16:44 -0400
Message-Id: <20230709151645.514172-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151645.514172-1-sashal@kernel.org>
References: <20230709151645.514172-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.320
Content-Transfer-Encoding: 8bit

From: Ying Hsu <yinghsu@chromium.org>

[ Upstream commit 004d25060c78fc31f66da0fa439c544dda1ac9d5 ]

In a setup where a Thunderbolt hub connects to Ethernet and a display
through USB Type-C, users may experience a hung task timeout when they
remove the cable between the PC and the Thunderbolt hub.
This is because the igb_down function is called multiple times when
the Thunderbolt hub is unplugged. For example, the igb_io_error_detected
triggers the first call, and the igb_remove triggers the second call.
The second call to igb_down will block at napi_synchronize.
Here's the call trace:
    __schedule+0x3b0/0xddb
    ? __mod_timer+0x164/0x5d3
    schedule+0x44/0xa8
    schedule_timeout+0xb2/0x2a4
    ? run_local_timers+0x4e/0x4e
    msleep+0x31/0x38
    igb_down+0x12c/0x22a [igb 6615058754948bfde0bf01429257eb59f13030d4]
    __igb_close+0x6f/0x9c [igb 6615058754948bfde0bf01429257eb59f13030d4]
    igb_close+0x23/0x2b [igb 6615058754948bfde0bf01429257eb59f13030d4]
    __dev_close_many+0x95/0xec
    dev_close_many+0x6e/0x103
    unregister_netdevice_many+0x105/0x5b1
    unregister_netdevice_queue+0xc2/0x10d
    unregister_netdev+0x1c/0x23
    igb_remove+0xa7/0x11c [igb 6615058754948bfde0bf01429257eb59f13030d4]
    pci_device_remove+0x3f/0x9c
    device_release_driver_internal+0xfe/0x1b4
    pci_stop_bus_device+0x5b/0x7f
    pci_stop_bus_device+0x30/0x7f
    pci_stop_bus_device+0x30/0x7f
    pci_stop_and_remove_bus_device+0x12/0x19
    pciehp_unconfigure_device+0x76/0xe9
    pciehp_disable_slot+0x6e/0x131
    pciehp_handle_presence_or_link_change+0x7a/0x3f7
    pciehp_ist+0xbe/0x194
    irq_thread_fn+0x22/0x4d
    ? irq_thread+0x1fd/0x1fd
    irq_thread+0x17b/0x1fd
    ? irq_forced_thread_fn+0x5f/0x5f
    kthread+0x142/0x153
    ? __irq_get_irqchip_state+0x46/0x46
    ? kthread_associate_blkcg+0x71/0x71
    ret_from_fork+0x1f/0x30

In this case, igb_io_error_detected detaches the network interface
and requests a PCIE slot reset, however, the PCIE reset callback is
not being invoked and thus the Ethernet connection breaks down.
As the PCIE error in this case is a non-fatal one, requesting a
slot reset can be avoided.
This patch fixes the task hung issue and preserves Ethernet
connection by ignoring non-fatal PCIE errors.

Signed-off-by: Ying Hsu <yinghsu@chromium.org>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230620174732.4145155-1-anthony.l.nguyen@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ab54362c0992e..d7b531eae8195 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -8257,6 +8257,11 @@ static pci_ers_result_t igb_io_error_detected(struct pci_dev *pdev,
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
 
+	if (state == pci_channel_io_normal) {
+		dev_warn(&pdev->dev, "Non-correctable non-fatal error reported.\n");
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	}
+
 	netif_device_detach(netdev);
 
 	if (state == pci_channel_io_perm_failure)
-- 
2.39.2


