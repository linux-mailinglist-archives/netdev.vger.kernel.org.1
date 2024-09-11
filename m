Return-Path: <netdev+bounces-127306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73498974EAE
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD461F219FF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82540185924;
	Wed, 11 Sep 2024 09:35:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44C7E110;
	Wed, 11 Sep 2024 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047350; cv=none; b=qgMCimO3fNYootIpnRMk2hqsva8TMzHK2YLL9wT9Kg1a624tABPVT5M6D3FKiOTwljJ1gEC2xWOY+7vhA8yvus00r7nfAzTVK036b9p44aLZfdMCreFSLx/BxxahCXDlhGPEwX0gSg7PiZKxI/Tz+wZPULxMQF+nsCWroUDtFo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047350; c=relaxed/simple;
	bh=YKTAzuTAPAhmNZkS9NdUoRHE9sIRTmRBUa9a9AcStcc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=a9LnvUwzSyZ5tPPiv+5kXY9SSflNXVQZ822Kt0E9rO5y48EHuilHoeb7/xdNNMpRuG6EFYQ+RIL9hFmqvX8faP/89kmNx0SI/vWjBpIg0r7B4vyHt8ofPifx5mt1KKt805vE2AwdkxcHE5BYSQZ40qansPK1pd33Mtc7B3kvEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4X3b4s6Z0czyQrp;
	Wed, 11 Sep 2024 17:34:37 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id B47B114038F;
	Wed, 11 Sep 2024 17:35:44 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemh500013.china.huawei.com
 (7.202.181.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 11 Sep
 2024 17:35:43 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
	<louis.peens@corigine.com>, <damien.lemoal@opensource.wdc.com>,
	<set_pte_at@outlook.com>, <mpe@ellerman.id.au>, <horms@kernel.org>,
	<yinjun.zhang@corigine.com>, <ryno.swart@corigine.com>,
	<johannes.berg@intel.com>, <fei.qin@corigine.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oss-drivers@corigine.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH net RESEND 0/3] net: Use IRQF_NO_AUTOEN flag in request_irq()
Date: Wed, 11 Sep 2024 17:44:42 +0800
Message-ID: <20240911094445.1922476-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemh500013.china.huawei.com (7.202.181.146)

As commit cbe16f35bee6 ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
said, reqeust_irq() and then disable_irq() is unsafe.

IRQF_NO_AUTOEN flag can be used by drivers to request_irq(). It prevents
the automatic enabling of the requested interrupt in the same safe way.
With that the usage can be simplified and corrected.

Only compile-tested.

v1 -> RESNED
- Add reviewed-by.
- Put wireless into another patch set.
- Update to net prefix subject.

Jinjie Ruan (3):
  net: apple: bmac: Use IRQF_NO_AUTOEN flag in request_irq()
  net: enetc: Use IRQF_NO_AUTOEN flag in request_irq()
  nfp: Use IRQF_NO_AUTOEN flag in request_irq()

 drivers/net/ethernet/apple/bmac.c                   | 3 +--
 drivers/net/ethernet/freescale/enetc/enetc.c        | 3 +--
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 5 ++---
 3 files changed, 4 insertions(+), 7 deletions(-)

-- 
2.34.1


