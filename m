Return-Path: <netdev+bounces-34845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 677827A5766
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 04:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 897E1281A56
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 02:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396CE6FBF;
	Tue, 19 Sep 2023 02:27:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32639450F6
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 02:27:23 +0000 (UTC)
X-Greylist: delayed 49991 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 19:27:22 PDT
Received: from out-220.mta1.migadu.com (out-220.mta1.migadu.com [95.215.58.220])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204C510D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 19:27:22 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695090440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GldjsjLN9+yIG261E0aNo5eTT0aAfea0jQrrQue5u00=;
	b=mkZMkq7B3bUpxEPYmu2MMcafJg4hXDsOyrfwPXWWPuo23kQP5p5h2a7nbOPpddUEXUDmhf
	3/dEV+SIuCGVpJMz0JvI/8VFF/lfB5lkXgdH/kllhkpg9ctUeoKO0voCtwe8OJ0D4beMvl
	QehRcZutZVMEFLVcDtA8HLkEmZ4GjXA=
From: Cai Huoqing <cai.huoqing@linux.dev>
To: vadim.fedorenko@linux.dev
Cc: Cai Huoqing <cai.huoqing@linux.dev>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: hinic: Fix warning-hinic_set_vlan_fliter() warn: variable dereferenced before check 'hwdev'
Date: Tue, 19 Sep 2023 10:27:15 +0800
Message-Id: <20230919022715.6424-1-cai.huoqing@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

'hwdev' is checked too late and hwdev will not be NULL, so remove the check

Fixes: 2acf960e3be6 ("net: hinic: Add support for configuration of rx-vlan-filter by ethtool")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202309112354.pikZCmyk-lkp@intel.com/
Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
v1->v2: Remove 'hwdev' check directly 
v1 link: https://lore.kernel.org/lkml/20230918123401.6951-1-cai.huoqing@linux.dev/

 drivers/net/ethernet/huawei/hinic/hinic_port.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic/hinic_port.c b/drivers/net/ethernet/huawei/hinic/hinic_port.c
index 9406237c461e..f81a43d2cdfc 100644
--- a/drivers/net/ethernet/huawei/hinic/hinic_port.c
+++ b/drivers/net/ethernet/huawei/hinic/hinic_port.c
@@ -456,9 +456,6 @@ int hinic_set_vlan_fliter(struct hinic_dev *nic_dev, u32 en)
 	u16 out_size = sizeof(vlan_filter);
 	int err;
 
-	if (!hwdev)
-		return -EINVAL;
-
 	vlan_filter.func_idx = HINIC_HWIF_FUNC_IDX(hwif);
 	vlan_filter.enable = en;
 
-- 
2.34.1


