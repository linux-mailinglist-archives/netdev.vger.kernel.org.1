Return-Path: <netdev+bounces-139286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 440509B145C
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 05:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CD652834B2
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 03:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B242213D298;
	Sat, 26 Oct 2024 03:49:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA80138389
	for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 03:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729914546; cv=none; b=kM/eNjgiIODZ8Sq5oTj9jtrlIHUhSaqNNqDpTjPssOVw6+xMlGINQS4nXJ7cOSRe8r9elUmlCMDrP41Tp60X6bAj4otTOst9gGocVTjW8jgCkHRWZ/XWbCORx08S0K+pRnXHWPjVrzhryZDYtlUXk+C26p1kDjdwrTFJM/NVz1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729914546; c=relaxed/simple;
	bh=YS2I9Hq1fwbpWJod8TROLZjksPitzePoXcG5D/V1hl0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s3XDEiM3/U7fpUr/q4NbxSoPq9blUZk1aE6NwVmIUxyk4GCZWv6AHwPOzkTTONWlqfnm2WQdG0YDd7xH4efkNosnM3ob3IUGOcBeaT6ZvqvuRLsWLvXB/y/yKzHhGCqFiEBDJ1BVDQvVM2LdHsgi8RxFVn71+sJFN4vLyAr9nNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xb5Ff3Pxfz2Dc1W;
	Sat, 26 Oct 2024 11:47:34 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 214221A0188;
	Sat, 26 Oct 2024 11:49:01 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 26 Oct 2024 11:49:00 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 0/2] bna: Remove error checking for debugfs create APIs
Date: Sat, 26 Oct 2024 11:47:58 +0800
Message-ID: <20241026034800.450-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf100006.china.huawei.com (7.185.36.228)

v1 --> v2:
Remove error checking for debugfs_create_file() instead of fixing it.

v1:
1. Fix the incorrect return value check for debugfs_create_dir() and
   debugfs_create_file(), which returns ERR_PTR(-ERROR) instead of NULL
   when it fails.
2. Remove field bnad_dentry_files[] in struct bnad. When a directory is
   deleted, files in the directory are automatically deleted. Therefore,
   there is need to record these files.

Zhen Lei (2):
  bna: Remove error checking for debugfs create APIs
  bna: Remove field bnad_dentry_files[] in struct bnad

 drivers/net/ethernet/brocade/bna/bnad.h       |  1 -
 .../net/ethernet/brocade/bna/bnad_debugfs.c   | 32 ++-----------------
 2 files changed, 3 insertions(+), 30 deletions(-)

-- 
2.34.1


