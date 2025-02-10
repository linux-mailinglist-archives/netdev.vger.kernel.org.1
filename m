Return-Path: <netdev+bounces-164563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4C2A2E3E0
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 06:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 194EB3A8644
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 05:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B9A19149F;
	Mon, 10 Feb 2025 05:59:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FB813AD3F;
	Mon, 10 Feb 2025 05:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739167168; cv=none; b=iX6yzVrQbM+bxI8TC+cWGUQMX/QgLivLM2PgVQUnEDSQae9WOVzGY1/MLZSLvLEqigMc1rpqGxx4xoMOubjkHPvtaH1JA7YBSGFQbdqV7KOAsvBYaIJtdYWgdFdeVwlOYy3m29YB27pgIdMdti8FMCZUWjreHPdEdKoKLmXB+K4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739167168; c=relaxed/simple;
	bh=+PGA/I/gqDY95kLnGVig5cIeoNC/OI7Zp8T8BhzqzCc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ex4ldmurbjGQPOVl20xTvyMeoDsEullmF3CBdgmgXUrmimeNi8Phg0DVVR8Pt1/+KiVywQv6fiuTFRdLWuNu8QmR58QcOYs4atvTx9Ib0EtUih9rMhyjkVUuWdKP/J/MKWieKGIaBJNJGZU2RSGi52UOQAWTIydPKTnlo9B9PNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Yrv256vJ2z1ltZW;
	Mon, 10 Feb 2025 13:55:41 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id D54C9140156;
	Mon, 10 Feb 2025 13:59:24 +0800 (CST)
Received: from kwepemn100009.china.huawei.com (7.202.194.112) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Feb 2025 13:59:24 +0800
Received: from localhost.localdomain (10.28.79.22) by
 kwepemn100009.china.huawei.com (7.202.194.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Feb 2025 13:59:23 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<oss-drivers@corigine.com>
CC: <irusskikh@marvell.com>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<louis.peens@corigine.com>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<kabel@kernel.org>, <zhanjie9@hisilicon.com>, <zhenglifeng1@huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 0/5] Use HWMON_CHANNEL_INFO macro to simplify code
Date: Mon, 10 Feb 2025 13:47:05 +0800
Message-ID: <20250210054710.12855-1-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemn100009.china.huawei.com (7.202.194.112)

The HWMON_CHANNEL_INFO macro is provided by hwmon.h and used widely by many
other drivers. This series use HWMON_CHANNEL_INFO macro to simplify code
in net subsystem.

Note: These patches do not depend on each other. Put them togeter just for
belonging to the same subsystem.

---
 -v2:
  * detach these patches from the series[1]

[1] https://lore.kernel.org/lkml/20250124022635.16647-3-lihuisong@huawei.com/T/

Huisong Li (5):
  net: aquantia: Use HWMON_CHANNEL_INFO macro to simplify code
  net: nfp: Use HWMON_CHANNEL_INFO macro to simplify code
  net: phy: marvell: Use HWMON_CHANNEL_INFO macro to simplify code
  net: phy: marvell10g: Use HWMON_CHANNEL_INFO macro to simplify code
  net: phy: aquantia: Use HWMON_CHANNEL_INFO macro to simplify code

 .../ethernet/aquantia/atlantic/aq_drvinfo.c   | 14 +------
 .../net/ethernet/netronome/nfp/nfp_hwmon.c    | 40 +++----------------
 drivers/net/phy/aquantia/aquantia_hwmon.c     | 32 +++------------
 drivers/net/phy/marvell.c                     | 24 +----------
 drivers/net/phy/marvell10g.c                  | 24 +----------
 5 files changed, 17 insertions(+), 117 deletions(-)

-- 
2.22.0


