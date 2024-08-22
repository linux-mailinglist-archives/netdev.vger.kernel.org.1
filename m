Return-Path: <netdev+bounces-120796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6974195AC83
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 06:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25FD52824C1
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 04:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E8B3B79C;
	Thu, 22 Aug 2024 04:25:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D8B364A4
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 04:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724300723; cv=none; b=nDynRBLspjVpzjhtYJBMgbDpQcvSBeebW39OiokwKcLgirXzsKhh+m5lhWub6ogFY2ivIiOElsEGkIqm2tbvTCXVN5nLxdsbNazAZFK8HWECnGJ39fN8XQYsEn+tWKECv/4AT5XAuFnOFE79ATQ8ja0wUBxw1zC6i0GcOozb6o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724300723; c=relaxed/simple;
	bh=fk3HI2c3sBAsaEwEg/cSRpFvKIAoHs0iBFgoXAi75Cg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pLKdR3hW6qFH5wr+TNeWdIzqEU9g0QcO2YmwQIno5XOE8XSDNMfF9L8nu4b8XxO1cYCkqcQwMVS9qt049f6WXS+16GXqe3/j0YQ5MyDIHKnzREoOr+tx90dzzOLzRKuPcTsezUPX7pb+LhdodnfIe+AFefZiCgJSdtBBCGqaaMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Wq95R3CNWz1HFpc;
	Thu, 22 Aug 2024 12:22:03 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D7CE180019;
	Thu, 22 Aug 2024 12:25:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemd500012.china.huawei.com
 (7.221.188.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 22 Aug
 2024 12:25:15 +0800
From: Li Zetao <lizetao1@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <dsahern@kernel.org>, <idosch@nvidia.com>,
	<amcohen@nvidia.com>, <petrm@nvidia.com>, <gnault@redhat.com>,
	<b.galvani@gmail.com>, <alce@lafranque.net>, <shaozhengchao@huawei.com>,
	<horms@kernel.org>, <lizetao1@huawei.com>, <j.granados@samsung.com>,
	<linux@weissschuh.net>, <judyhsiao@chromium.org>, <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>
Subject: [PATCH net-next 00/10] net: Delete some redundant judgments
Date: Thu, 22 Aug 2024 12:32:42 +0800
Message-ID: <20240822043252.3488749-1-lizetao1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemd500012.china.huawei.com (7.221.188.25)

This patchset aims to remove some unnecessary judgments and make the
code more concise. In some network modules, rtnl_set_sk_err is used to
record error information, but the err is repeatedly judged to be less
than 0 on the error path. Deleted these redundant judgments.

No functional change intended.

Li Zetao (10):
  net: vxlan: delete redundant judgment statements
  fib: rules: delete redundant judgment statements
  neighbour: delete redundant judgment statements
  rtnetlink: delete redundant judgment statements
  ipv4: delete redundant judgment statements
  ipmr: delete redundant judgment statements
  net: nexthop: delete redundant judgment statements
  ip6mr: delete redundant judgment statements
  net/ipv6: delete redundant judgment statements
  net: mpls: delete redundant judgment statements

 drivers/net/vxlan/vxlan_core.c | 3 +--
 net/core/fib_rules.c           | 3 +--
 net/core/neighbour.c           | 3 +--
 net/core/rtnetlink.c           | 3 +--
 net/ipv4/devinet.c             | 6 ++----
 net/ipv4/fib_semantics.c       | 3 +--
 net/ipv4/ipmr.c                | 3 +--
 net/ipv4/nexthop.c             | 6 ++----
 net/ipv6/ip6mr.c               | 3 +--
 net/ipv6/route.c               | 6 ++----
 net/mpls/af_mpls.c             | 6 ++----
 11 files changed, 15 insertions(+), 30 deletions(-)

-- 
2.34.1


