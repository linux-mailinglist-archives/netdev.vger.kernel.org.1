Return-Path: <netdev+bounces-93595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE078BC605
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 05:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 301671F218AF
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 03:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19E94086A;
	Mon,  6 May 2024 03:04:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3413BBF5;
	Mon,  6 May 2024 03:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714964691; cv=none; b=RQOn3wzfZVkvi/QBOjnAf6Zrv2Dx60R/Z1oEgIp57pCwBJtlKxDW6GJBAfAUt2vW16uER8pcOuzdPAQp7gSQo1DBBQBW65R8trKCUGHbtJEU+oJLLmhVrm8dO2MvDJYWNRFbSq+Erc7iocYZXh6zEq/fUZPpkBCo+d+NWhob8W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714964691; c=relaxed/simple;
	bh=Di4Dr1jMevpF94ywNAsHk7BIbRL2RRmOjyRhvVLpJbs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SZyQ+WtChR7NVdDprYh47XhC0LrtM7FdHO66SfY1UiUt6DZ6Ie2dnEzIs11R2QJ8NYuUbJbm7bHfNGWr7H/iueOPpGGKfua+/35K81TsFZMprzUtzDi3olVIzlIwXptrmrZKwVbgvPTS13JRVrG2C5XE+UsE4NgN37orRqbmOs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4VXmPy52cCz1RCCh;
	Mon,  6 May 2024 11:01:10 +0800 (CST)
Received: from dggpeml500026.china.huawei.com (unknown [7.185.36.106])
	by mail.maildlp.com (Postfix) with ESMTPS id 799F218006B;
	Mon,  6 May 2024 11:04:27 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 6 May
 2024 11:04:26 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <stable@vger.kernel.org>
CC: <netdev@vger.kernel.org>, <gregkh@linuxfoundation.org>,
	<davem@davemloft.net>, <kuznet@ms2.inr.ac.ru>, <yoshfuji@linux-ipv6.org>,
	<kuba@kernel.org>, <edumazet@google.com>, <kuniyu@amazon.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH stable,5.10 0/2] Revert the patchset for fix CVE-2024-26865
Date: Mon, 6 May 2024 11:09:25 +0800
Message-ID: <20240506030927.3168586-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)

There's no "pernet" variable in the struct hashinfo. The "pernet" variable
is introduced from v6.1-rc1. Revert pre-patch and post-patch.

Zhengchao Shao (2):
  Revert "tcp: Fix NEW_SYN_RECV handling in inet_twsk_purge()"
  Revert "tcp: Clean up kernel listener's reqsk in inet_twsk_purge()"

 net/ipv4/inet_timewait_sock.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

-- 
2.34.1


