Return-Path: <netdev+bounces-244317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 836B4CB490F
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 03:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 734463019343
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 02:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5992BE7D1;
	Thu, 11 Dec 2025 02:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kcSkgsaJ";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kcSkgsaJ"
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00CE28C84D;
	Thu, 11 Dec 2025 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765420750; cv=none; b=bD+6Fhg006ejuVPGWyG6KyYxiontv3HRdwyB9yrFP6kw8qjhj52hJxG5TrsxkUdn8/Df+2wS1dlpZHsB2ZE/LWk7GqOjHnjDo7WXbJ50IPSBrBmoNY6FdWMXz6iupOnVNW6t7tXni1uKGMc3ys9K6iGB/Qzhmlyuf1U5dBIuuCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765420750; c=relaxed/simple;
	bh=Zp0Pr4N/37r/YAgWiAT6epd+gmIdHQmJw9AvGx4czCI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XNjLnKE31rXog9c6xXMAqLUYlS7QjIXKbIJkvHKuuyOLxc5c5F8IyUMcjyMg36q97XfxzwGm0jIDASNlsBFMtwFtItrix0rU061+1SJ4my1awMxsIkoW4yKs6zZrdMi/J4pQekw+1AhHBEerrpv6ALXvA2wNBvE0rPKo2fAztxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kcSkgsaJ; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kcSkgsaJ; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rJrtuABW4FVkqAMHKhBPK/0KROz+PdPZF4hhgxrlpWg=;
	b=kcSkgsaJf+gMDy+ygCDwSmjVhTwmioBZE+uXB9HXUm06IvmTiS5KHfNk3NCAg41lExCFKSDYf
	nkOZCbTdUP0Ry+mx+go3XyL7GtziAoq27zpQXiWgRlZtOB257hlsv82m6JZcLrdZPDqXHln9Kqv
	ygAsS7T4H6GFK2I+DLzEsjw=
Received: from canpmsgout09.his.huawei.com (unknown [172.19.92.135])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dRcGc3sCrz1BG4v;
	Thu, 11 Dec 2025 10:38:48 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rJrtuABW4FVkqAMHKhBPK/0KROz+PdPZF4hhgxrlpWg=;
	b=kcSkgsaJf+gMDy+ygCDwSmjVhTwmioBZE+uXB9HXUm06IvmTiS5KHfNk3NCAg41lExCFKSDYf
	nkOZCbTdUP0Ry+mx+go3XyL7GtziAoq27zpQXiWgRlZtOB257hlsv82m6JZcLrdZPDqXHln9Kqv
	ygAsS7T4H6GFK2I+DLzEsjw=
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dRcDW603wz1cyPb;
	Thu, 11 Dec 2025 10:36:59 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 0BEF51A016C;
	Thu, 11 Dec 2025 10:38:57 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 11 Dec 2025 10:38:56 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH V2 net 0/3] There are some bugfix for the HNS3 ethernet driver
Date: Thu, 11 Dec 2025 10:37:34 +0800
Message-ID: <20251211023737.2327018-1-shaojijie@huawei.com>
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

There are some bugfix for the HNS3 ethernet driver

Jian Shen (3):
  net: hns3: using the num_tqps in the vf driver to apply for resources
  net: hns3: using the num_tqps to check whether tqp_index is out of
    range when vf get ring info from mbx
  net: hns3: add VLAN id validation before using

 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 3 +++
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c    | 4 ++--
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 ++--
 3 files changed, 7 insertions(+), 4 deletions(-)

-- 
2.33.0


