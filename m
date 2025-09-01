Return-Path: <netdev+bounces-218738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B63BB3E277
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 14:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09ADE172075
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 12:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C522517AC;
	Mon,  1 Sep 2025 12:19:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B792F229B2A;
	Mon,  1 Sep 2025 12:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756729180; cv=none; b=lWSUzAiU+5xUoo411R8qpAch7Hf6jfYVAWFQZiht5E6mRHInhkOTFllGGHGja43chxoAgAPdDLq/fUhB9WnVimJAT08HlnF24XX2lxgdBsVegk4iiizI5tsSRNCqTtG6xJ69lew1t++pOlo6u5SWnr+X84iuIkPSgnOsHW308Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756729180; c=relaxed/simple;
	bh=LpNQ/s1opplax6drdPeuEwBm/1t8AKdOBTyOSayQJ1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BJTWR435Y5q9mCmmNn7+UwRYRfD3BOiJlhjcIf7OJTAwxqzEMFyXs2cW6sUlpm7bNxHa/a/EKGz7xEp1smS8UOG1tU/GSD6rLM3JqYr6k/N9r66l+h4toe03rr/+YICzNvJOpK3UpejTRhQjF1tJAQ5Vn9Y1YDRr2ZXlD0MwzSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4cFnrC27qvzdcBg;
	Mon,  1 Sep 2025 20:15:07 +0800 (CST)
Received: from dggpemf500002.china.huawei.com (unknown [7.185.36.57])
	by mail.maildlp.com (Postfix) with ESMTPS id ADE53180495;
	Mon,  1 Sep 2025 20:19:35 +0800 (CST)
Received: from huawei.com (10.50.159.234) by dggpemf500002.china.huawei.com
 (7.185.36.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 1 Sep
 2025 20:19:34 +0800
From: Yue Haibing <yuehaibing@huawei.com>
To: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<kuniyu@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<yuehaibing@huawei.com>
Subject: [PATCH v3 net-next 0/2] ipv6: improve rpl_seg_enabled sysctl handling
Date: Mon, 1 Sep 2025 20:37:24 +0800
Message-ID: <20250901123726.1972881-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 dggpemf500002.china.huawei.com (7.185.36.57)

First commit annotate data-races around it and second one add sanity check that
prevents unintentional misconfiguration.

Yue Haibing (2):
  ipv6: annotate data-races around devconf->rpl_seg_enabled
  ipv6: Add sanity checks on ipv6_devconf.rpl_seg_enabled

 net/ipv6/addrconf.c | 4 +++-
 net/ipv6/exthdrs.c  | 6 ++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
2.34.1


