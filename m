Return-Path: <netdev+bounces-34556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E547A49F9
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 14:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1FB1C2106D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBBD91CF8D;
	Mon, 18 Sep 2023 12:42:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53E1F9D1
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 12:42:34 +0000 (UTC)
X-Greylist: delayed 502 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 05:42:31 PDT
Received: from out-229.mta1.migadu.com (out-229.mta1.migadu.com [IPv6:2001:41d0:203:375::e5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7CE10D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 05:42:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695040445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=tzdxyJL0ghA962IZMjb5yhiDtQvWieedpUo2tK/XcEU=;
	b=nQ7NV2ahM6CIzA3I5Z+4WcikmpCuETB9Mx5x/LMHaYRKce4ilfhUEjnANu0TqvP8hZJWsj
	ik8rjMj3RNb7UTDrOPwRIHxIEegG0dqomII6W85MT07xaGZVNRBoXYvdCIyFYvMjrFfrPa
	rJg+BPFJNnQfXJNN+oP4P4mO4P0VAq0=
From: Cai Huoqing <cai.huoqing@linux.dev>
To: cai.huoqing@linux.dev
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: hinic: Fix warning-hinic_set_vlan_fliter() warn: variable dereferenced before check 'hwdev'
Date: Mon, 18 Sep 2023 20:34:01 +0800
Message-Id: <20230918123401.6951-1-cai.huoqing@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix warning, 'hwdev' is checked too late

Fixes: 2acf960e3be6 ("net: hinic: Add support for configuration of rx-vlan-filter by ethtool")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202309112354.pikZCmyk-lkp@intel.com/
Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/net/ethernet/huawei/hinic/hinic_port.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_port.c b/drivers/net/ethernet/huawei/hinic/hinic_port.c
index 9406237c461e..bf920c709f82 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_port.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_port.c
@@ -450,8 +450,8 @@ int hinic_set_rx_vlan_offload(struct hinic_dev *nic_dev, u8 en)
 int hinic_set_vlan_fliter(struct hinic_dev *nic_dev, u32 en)
 {
 	struct hinic_hwdev *hwdev = nic_dev->hwdev;
-	struct hinic_hwif *hwif = hwdev->hwif;
-	struct pci_dev *pdev = hwif->pdev;
+	struct hinic_hwif *hwif;
+	struct pci_dev *pdev;
 	struct hinic_vlan_filter vlan_filter;
 	u16 out_size = sizeof(vlan_filter);
 	int err;
@@ -459,6 +459,9 @@ int hinic_set_vlan_fliter(struct hinic_dev *nic_dev, u32 en)
 	if (!hwdev)
 		return -EINVAL;
 
+	hwif = hwdev->hwif;
+	pdev = hwif->pdev;
+
 	vlan_filter.func_idx = HINIC_HWIF_FUNC_IDX(hwif);
 	vlan_filter.enable = en;
 
-- 
2.34.1


