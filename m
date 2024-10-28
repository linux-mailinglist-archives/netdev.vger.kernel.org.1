Return-Path: <netdev+bounces-139414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AA59B229C
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 03:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47251280C49
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 02:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3D317C22F;
	Mon, 28 Oct 2024 02:10:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5D41714AC
	for <netdev@vger.kernel.org>; Mon, 28 Oct 2024 02:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730081451; cv=none; b=OMW+OWQAzpqmYTC75eT3wzKzM7uXzMYmSBDb6d4KsmgKiTUsR0bpzgn5WEqTYeoa0tN1ZUEOp0htXFLbLLmWLdzKuXPYcoGBGiNKJp7sQFUYtOOv5NVhQFpIlHDFh3ci+Z69AyZ9NHS3fePqRq99ke54TRYRke8uN+LmO1JYvRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730081451; c=relaxed/simple;
	bh=8Uzj4I3jKpe89s8tgL+8KYN4iH9H7J5X5cU8gzza6Ow=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fr1Jv7SGmr3JYmNe3nX/5yB/rBLtOJB6YRb6icLm0AeQbk6UuSFSzH8AlEUaX+HWkX+Xo2ML5sXh39d37KFtLhib15enTlAPpOGBKa9Q6hXooLZk8gtuQtE13EwS813vZxbvVvxschx7v8DBOkNR9bLjzo8KOs1zdQBW3mwmZKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XcGzq6XRkzQsLF;
	Mon, 28 Oct 2024 10:09:43 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id E6990140135;
	Mon, 28 Oct 2024 10:10:40 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 28 Oct 2024 10:10:40 +0800
From: Zhen Lei <thunder.leizhen@huawei.com>
To: Rasesh Mody <rmody@marvell.com>, Sudarsana Kalluru <skalluru@marvell.com>,
	<GR-Linux-NIC-Dev@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>
CC: Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v3 0/2] bna: Remove error checking for debugfs create APIs
Date: Mon, 28 Oct 2024 10:09:41 +0800
Message-ID: <20241028020943.507-1-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.37.3.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100006.china.huawei.com (7.185.36.228)

v2 --> v3:
1. Keep line wrapping <= 80 columns wide.
2. Add Reviewed-by: Simon Horman <horms@kernel.org>

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
 .../net/ethernet/brocade/bna/bnad_debugfs.c   | 31 +++----------------
 2 files changed, 5 insertions(+), 27 deletions(-)

-- 
2.34.1


