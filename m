Return-Path: <netdev+bounces-138440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B089AD988
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 04:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89D528253F
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 02:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C2174040;
	Thu, 24 Oct 2024 02:04:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5E7156CA
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729735441; cv=none; b=Zbp7ittKVnK6eUAe1wwtSeGfLjLGhB3yPTeOzAFH/hHz+Bd2EK3OQJaHiGrFJPAEiSlBcUkbTtiqQbJcavBLfs1ZosReOJCGkjClzcZc6FeCSvrJ90FSDZ4LLZ+UZ+YTy2AhrvxaFFtXKpiINenCLKt1ofcvL5cpdA5GJ71gX9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729735441; c=relaxed/simple;
	bh=PPyq2AsRP0lLlUEzlnZwVNStp6HOoNZowmdlQAzhf9E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b2toIu4fx9InBtcWXV9jGg24tyS8a9afPlp1c3JCiQ48bieW85o+toICktI422qXqKmNvuKb7ZKAXwt90ubHfaVVeMFtLJJDgXcYciXULvcxUTplKuCq7QGxM8uI6jshDQB74JfdHOyKly4wpdVdeM8jYb2qnEKZNqTiuWQWTcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XYq063f6TzdkNL;
	Thu, 24 Oct 2024 10:01:26 +0800 (CST)
Received: from kwepemf500003.china.huawei.com (unknown [7.202.181.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 2301F1401F0;
	Thu, 24 Oct 2024 10:03:57 +0800 (CST)
Received: from huawei.com (10.175.112.208) by kwepemf500003.china.huawei.com
 (7.202.181.241) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 24 Oct
 2024 10:03:56 +0800
From: Zhang Zekun <zhangzekun11@huawei.com>
To: <justin.chen@broadcom.com>, <florian.fainelli@broadcom.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <o.rempel@pengutronix.de>,
	<kory.maincent@bootlin.com>, <horms@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: <chenjun102@huawei.com>, <zhangzekun11@huawei.com>
Subject: [PATCH net 0/2] Get the device_node before calling of_find_node_by_name()
Date: Thu, 24 Oct 2024 09:59:07 +0800
Message-ID: <20241024015909.58654-1-zhangzekun11@huawei.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf500003.china.huawei.com (7.202.181.241)

of_find_node_by_name() will decrease the refount of the device node.
Get the device_node before call to it.

Zhang Zekun (2):
  net: bcmasp: Add missing of_node_get() before of_find_node_by_name()
  net: pse-pd: Add missing of_node_get() before of_find_node_by_name()

 drivers/net/ethernet/broadcom/asp2/bcmasp.c | 1 +
 drivers/net/pse-pd/tps23881.c               | 1 +
 2 files changed, 2 insertions(+)

-- 
2.17.1


