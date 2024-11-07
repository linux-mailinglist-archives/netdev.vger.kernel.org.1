Return-Path: <netdev+bounces-142862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F909C07B0
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:38:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7456A1F24182
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C32721315B;
	Thu,  7 Nov 2024 13:37:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9157220EA54;
	Thu,  7 Nov 2024 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730986628; cv=none; b=qgfLXvz7zdnzqFMRWZPqCl8Srwfhe5gANs97zLVJJaD2MNFAl2YelHtJjDKEJ6QVXnlThhWgwWZ9zVkNOQk3T6u1z4PKK6unaj5cmFOOku7ZXrtkJgJFGWCP85mmBgn98SsM5LLIdkPlZKdtHVSIqGuUXRNlv6Cv/xpJWGIrrZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730986628; c=relaxed/simple;
	bh=/FKUNwlWL1WGvcVYL2yNYLeoSAN3ms20kJ7TRd3Uo94=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lSaq5MIUqkNfiaAgEU7x94j7l929Hn4VqNkXYs7Q8ArwxqHv3Bmb7FP3HDCkWE68+PWcvtZtMA1tn2udBy0Ac1KfYExLk/m0i58BSPj1mRRFRO8uUSEbsCZxtAlePJMVCfvr/AUn+knUKJfosCc4LpemNb7eKQIyb+0Mko3nTzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XkjkK4j8Mz2Fbpd;
	Thu,  7 Nov 2024 21:35:21 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 280DB1A016C;
	Thu,  7 Nov 2024 21:37:04 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 21:37:03 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <salil.mehta@huawei.com>,
	<liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>, <shaojijie@huawei.com>,
	<chenhao418@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND net 7/7] net: hns3: fix kernel crash when 1588 is sent on HIP08 devices
Date: Thu, 7 Nov 2024 21:30:23 +0800
Message-ID: <20241107133023.3813095-8-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20241107133023.3813095-1-shaojijie@huawei.com>
References: <20241107133023.3813095-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemk100013.china.huawei.com (7.202.194.61)

From: Jie Wang <wangjie125@huawei.com>

Currently, HIP08 devices does not register the ptp devices, so the
hdev->ptp is NULL. But the tx process would still try to set hardware time
stamp info with SKBTX_HW_TSTAMP flag and cause a kernel crash.

[  128.087798] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000018
...
[  128.280251] pc : hclge_ptp_set_tx_info+0x2c/0x140 [hclge]
[  128.286600] lr : hclge_ptp_set_tx_info+0x20/0x140 [hclge]
[  128.292938] sp : ffff800059b93140
[  128.297200] x29: ffff800059b93140 x28: 0000000000003280
[  128.303455] x27: ffff800020d48280 x26: ffff0cb9dc814080
[  128.309715] x25: ffff0cb9cde93fa0 x24: 0000000000000001
[  128.315969] x23: 0000000000000000 x22: 0000000000000194
[  128.322219] x21: ffff0cd94f986000 x20: 0000000000000000
[  128.328462] x19: ffff0cb9d2a166c0 x18: 0000000000000000
[  128.334698] x17: 0000000000000000 x16: ffffcf1fc523ed24
[  128.340934] x15: 0000ffffd530a518 x14: 0000000000000000
[  128.347162] x13: ffff0cd6bdb31310 x12: 0000000000000368
[  128.353388] x11: ffff0cb9cfbc7070 x10: ffff2cf55dd11e02
[  128.359606] x9 : ffffcf1f85a212b4 x8 : ffff0cd7cf27dab0
[  128.365831] x7 : 0000000000000a20 x6 : ffff0cd7cf27d000
[  128.372040] x5 : 0000000000000000 x4 : 000000000000ffff
[  128.378243] x3 : 0000000000000400 x2 : ffffcf1f85a21294
[  128.384437] x1 : ffff0cb9db520080 x0 : ffff0cb9db500080
[  128.390626] Call trace:
[  128.393964]  hclge_ptp_set_tx_info+0x2c/0x140 [hclge]
[  128.399893]  hns3_nic_net_xmit+0x39c/0x4c4 [hns3]
[  128.405468]  xmit_one.constprop.0+0xc4/0x200
[  128.410600]  dev_hard_start_xmit+0x54/0xf0
[  128.415556]  sch_direct_xmit+0xe8/0x634
[  128.420246]  __dev_queue_xmit+0x224/0xc70
[  128.425101]  dev_queue_xmit+0x1c/0x40
[  128.429608]  ovs_vport_send+0xac/0x1a0 [openvswitch]
[  128.435409]  do_output+0x60/0x17c [openvswitch]
[  128.440770]  do_execute_actions+0x898/0x8c4 [openvswitch]
[  128.446993]  ovs_execute_actions+0x64/0xf0 [openvswitch]
[  128.453129]  ovs_dp_process_packet+0xa0/0x224 [openvswitch]
[  128.459530]  ovs_vport_receive+0x7c/0xfc [openvswitch]
[  128.465497]  internal_dev_xmit+0x34/0xb0 [openvswitch]
[  128.471460]  xmit_one.constprop.0+0xc4/0x200
[  128.476561]  dev_hard_start_xmit+0x54/0xf0
[  128.481489]  __dev_queue_xmit+0x968/0xc70
[  128.486330]  dev_queue_xmit+0x1c/0x40
[  128.490856]  ip_finish_output2+0x250/0x570
[  128.495810]  __ip_finish_output+0x170/0x1e0
[  128.500832]  ip_finish_output+0x3c/0xf0
[  128.505504]  ip_output+0xbc/0x160
[  128.509654]  ip_send_skb+0x58/0xd4
[  128.513892]  udp_send_skb+0x12c/0x354
[  128.518387]  udp_sendmsg+0x7a8/0x9c0
[  128.522793]  inet_sendmsg+0x4c/0x8c
[  128.527116]  __sock_sendmsg+0x48/0x80
[  128.531609]  __sys_sendto+0x124/0x164
[  128.536099]  __arm64_sys_sendto+0x30/0x5c
[  128.540935]  invoke_syscall+0x50/0x130
[  128.545508]  el0_svc_common.constprop.0+0x10c/0x124
[  128.551205]  do_el0_svc+0x34/0xdc
[  128.555347]  el0_svc+0x20/0x30
[  128.559227]  el0_sync_handler+0xb8/0xc0
[  128.563883]  el0_sync+0x160/0x180

Fixes: 0bf5eb788512 ("net: hns3: add support for PTP")
Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
index 5505caea88e9..bab16c2191b2 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_ptp.c
@@ -58,6 +58,9 @@ bool hclge_ptp_set_tx_info(struct hnae3_handle *handle, struct sk_buff *skb)
 	struct hclge_dev *hdev = vport->back;
 	struct hclge_ptp *ptp = hdev->ptp;
 
+	if (!ptp)
+		return false;
+
 	if (!test_bit(HCLGE_PTP_FLAG_TX_EN, &ptp->flags) ||
 	    test_and_set_bit(HCLGE_STATE_PTP_TX_HANDLING, &hdev->state)) {
 		ptp->tx_skipped++;
-- 
2.33.0


