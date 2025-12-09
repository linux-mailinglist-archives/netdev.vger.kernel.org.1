Return-Path: <netdev+bounces-244131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82300CB0158
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 14:47:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33F9130A7301
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 13:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E5832E6B7;
	Tue,  9 Dec 2025 13:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kcSkgsaJ"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7D0328249;
	Tue,  9 Dec 2025 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765287579; cv=none; b=XT3IbzMwyIJ+ODwdi0tNFZbSjDc7aX3EeU6Ws9SnWiXkdIYvZwhGeqbsEGAnLUSIoo49vAwqn7xjjKM92gI4uwiS5YzaDRKRNbewdWwPzh5cPuLNfh2DYVbCMGAsJlFTJPECe0o3Tyyb3/5mqF/mJIgwqLv6WjzpDuLljvTXfzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765287579; c=relaxed/simple;
	bh=Zp0Pr4N/37r/YAgWiAT6epd+gmIdHQmJw9AvGx4czCI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UcDp1JbM7T/NzTtZSkiwtk8dDWCyM2yK46hohuvqrm50J40wKa5lB6WkjsNK6vkJbvCIeHx87VJMlCEE1im12TZn+s7/6CKM7RZYxu5BTQuMh3JWa0kAOh5gsEqTqnn1RmPBlSDAmZdwsDdNWB69tx/zhxPS0DKKE8/35fpgf3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kcSkgsaJ; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=rJrtuABW4FVkqAMHKhBPK/0KROz+PdPZF4hhgxrlpWg=;
	b=kcSkgsaJf+gMDy+ygCDwSmjVhTwmioBZE+uXB9HXUm06IvmTiS5KHfNk3NCAg41lExCFKSDYf
	nkOZCbTdUP0Ry+mx+go3XyL7GtziAoq27zpQXiWgRlZtOB257hlsv82m6JZcLrdZPDqXHln9Kqv
	ygAsS7T4H6GFK2I+DLzEsjw=
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dQfzj26ZYzLlTc;
	Tue,  9 Dec 2025 21:37:37 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id D67B814011F;
	Tue,  9 Dec 2025 21:39:32 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 9 Dec 2025 21:39:32 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <lantao5@huawei.com>,
	<huangdonghua3@h-partners.com>, <yangshuaisong@h-partners.com>,
	<jonathan.cameron@huawei.com>, <salil.mehta@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<shaojijie@huawei.com>
Subject: [PATCH net 0/3] There are some bugfix for the HNS3 ethernet driver
Date: Tue, 9 Dec 2025 21:38:22 +0800
Message-ID: <20251209133825.3577343-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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


