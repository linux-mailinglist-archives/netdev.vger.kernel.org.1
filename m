Return-Path: <netdev+bounces-214023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7518B27E0A
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 12:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BD7B1BC5FCB
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E1E2FD1CD;
	Fri, 15 Aug 2025 10:11:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA45E2FCC16;
	Fri, 15 Aug 2025 10:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252697; cv=none; b=s33KczAbGyh2eFTNdFMdHWzaBvI7sRxz2pnriGQurqAzgn2Dcu1oOKrfc7kvaEZ/UI6glxdHj2aWMsI/tLuTwlG2IqeSzpgavcrUEEDP0JP8xfP5MMaRL6T9pMZ+7eokZi3YVWDiSdNeLIrHWDYLzOEqBG4YkPjej0+2g/PCee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252697; c=relaxed/simple;
	bh=1FdSpzjGk7jUfkm9YRIdW+Ca6XFoPP21nP/dOpm2oqo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i7sy8UUhpPeakZ767uFoz5Fnfrj136cak0D+4r3GE0YudiSgHcIkONSF1fmcmCxHFOJwLHTU7KFILQqvdZdu2eqtUCSru/B3jL0ptz8OdegKPQBiB3+bJrumjb5jNkmhV9NVVeHahcbXRPqVGxycHblZSQaEwJLJ/VxFFhwcLvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c3HpQ3MxfzdcFB;
	Fri, 15 Aug 2025 18:07:10 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 389A1180486;
	Fri, 15 Aug 2025 18:11:31 +0800 (CST)
Received: from localhost.localdomain (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 15 Aug 2025 18:11:30 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <jonathan.cameron@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 0/2] There are a cleancode and a parameter check for hns3 driver
Date: Fri, 15 Aug 2025 18:04:12 +0800
Message-ID: <20250815100414.949752-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemk100013.china.huawei.com (7.202.194.61)

This patchset includes:
 1. a parameter check omitted from fix code in net branch
   https://lore.kernel.org/all/20250723072900.GV2459@horms.kernel.org/
 2. a small clean code

Jijie Shao (2):
  net: hns3: add parameter check for tx_copybreak and tx_spare_buf_size
  net: hns3: change the function return type from int to bool

 .../ethernet/hisilicon/hns3/hns3_ethtool.c    | 33 +++++++++++++++++++
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  4 +--
 2 files changed, 35 insertions(+), 2 deletions(-)

-- 
2.33.0


