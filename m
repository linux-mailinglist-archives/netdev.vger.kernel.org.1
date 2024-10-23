Return-Path: <netdev+bounces-138126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EA09AC11A
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 10:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A3D3284C4B
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 08:11:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B6A158553;
	Wed, 23 Oct 2024 08:10:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34C8158534
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 08:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671045; cv=none; b=f/2oo4OGoRX6QPOFGb3wFBgb0AbuXHu1r248B9ZV/szbbDAvdGUJTJ5GioWRI0r8XBAD94WkaHYLswftZKdQd68AqJfRd/4hw9ITaxfL/LNVLxvJrPNySGlW1jxmlGVcXQhSAm2Kk+lAwQjDzP/IvKNeW1U/Jdt3qVit91NcVak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671045; c=relaxed/simple;
	bh=Mg0VM8AwN7w0oZv57aFFWUNCfralhAI6YrgpGVyjGHw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F8XhMUYIJHBqAqxx+KClD5Wtt7bb0q32PHK8pTo3HurRy7aIcw+4T0A5YdlfWn5V4LBZuSC3lOUfdV3kdtK14QLgwjJSdEr8+YULOUT/Xi5qJZ8NPo02PENr0q7EydzAdxf71NZe4u81QEtjViC8g4vHe8jxy9SFHxTIeY8W+q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XYM7W0P0Jz1HLSh;
	Wed, 23 Oct 2024 16:06:15 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id DA9011402CD;
	Wed, 23 Oct 2024 16:10:35 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Oct 2024 16:10:35 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 0/2] bna: Fix return value check for debugfs create APIs
Date: Wed, 23 Oct 2024 16:09:19 +0800
Message-ID: <20241023080921.326-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf100006.china.huawei.com (7.185.36.228)

1. Fix the incorrect return value check for debugfs_create_dir() and
   debugfs_create_file(), which returns ERR_PTR(-ERROR) instead of NULL
   when it fails.
2. Remove field bnad_dentry_files[] in struct bnad. When a directory is
   deleted, files in the directory are automatically deleted. Therefore,
   there is need to record these files.

Zhen Lei (2):
  bna: Fix return value check for debugfs create APIs
  bna: Remove field bnad_dentry_files[] in struct bnad

 drivers/net/ethernet/brocade/bna/bnad.h       |  1 -
 .../net/ethernet/brocade/bna/bnad_debugfs.c   | 34 ++++++++-----------
 2 files changed, 14 insertions(+), 21 deletions(-)

-- 
2.34.1


