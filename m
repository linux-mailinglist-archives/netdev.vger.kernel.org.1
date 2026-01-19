Return-Path: <netdev+bounces-251089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAA7D3AA63
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBAF9303C9EB
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 13:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1704736A002;
	Mon, 19 Jan 2026 13:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="wvQZAKDu"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05E431D36B;
	Mon, 19 Jan 2026 13:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768829403; cv=none; b=aUIKee6Wd7/BSimx9A3UcncesKEh1TPY8RFfLIhUn14Whe1s/5fZYB0pyzsHJvJf64VVedDgZqU1chbpNbmrPTsHdhfMXKBwXlQyTi+mR2Su/S1acqirJjFoO5l/gy0Ogj6VMtu7pZZLujs657Tir3nEjqf9FNV0kVhUGL1DTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768829403; c=relaxed/simple;
	bh=h/CC9HWMOIDsFD0u9B6mALqPebPtT7mc1dP7/lwsHJo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=t15Wc8ut7YqbuYx42wuZTcmXFEcvnzVYzS+MIjPOowzP8HYHBK5hUDLrl9Fe1tdhv8i2V8zQMvDBgdC2UkkhlGxRwWHRkiJYr9tMKZudbnp+4K81tuJD3qG6Xr1SbATnRl4wjVpt6EdDT4XwgGgJHHQbwlsB5jx0n7MQpq2zvxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=wvQZAKDu; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gnrVLVp+aVLEKLl7rJNzeXLKXHd+DFWnez0mcmQmzmI=;
	b=wvQZAKDuAiHIXmVwWHtx9WvAYIJBU9/uwVFiHsQGV7wcVWLsg6ENePzBu6o8S9snpXjM0YTj/
	w5lPJp0paJrcfuGeJXcKPl+ubPMc30PkMxcl3my7OIlv/bu+kj3H0LemrRyjni+3bENRv9csG7s
	pSole/U/WslD05fawKjRxuI=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dvrng3wCKzpStW;
	Mon, 19 Jan 2026 21:26:15 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 35B2E405A8;
	Mon, 19 Jan 2026 21:29:58 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 19 Jan 2026 21:29:57 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net 0/2] fix some bugs in the flow director of HNS3 driver
Date: Mon, 19 Jan 2026 21:28:38 +0800
Message-ID: <20260119132840.410513-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemk100013.china.huawei.com (7.202.194.61)

This patchset fixes two bugs in the flow director:
1. Incorrect definition of HCLGE_FD_AD_COUNTER_NUM_M
2. Incorrect assignment of HCLGE_FD_AD_NXT_KEY

Jijie Shao (2):
  net: hns3: fix wrong GENMASK() for HCLGE_FD_AD_COUNTER_NUM_M
  net: hns3: fix the HCLGE_FD_AD_NXT_KEY error setting issue

 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_cmd.h  | 2 +-
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.33.0


