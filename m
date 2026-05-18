Return-Path: <netdev+bounces-288965-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO+qGujdCmpV8wQAu9opvQ
	(envelope-from <netdev+bounces-288965-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:37:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBBC569D79
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 11:37:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E34D33007A62
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 09:36:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E663E8321;
	Mon, 18 May 2026 09:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="q/AdxH7R"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EAC3E7161;
	Mon, 18 May 2026 09:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779096961; cv=none; b=J/SA/DGTRc2Wvy6e3TQ1t4H2VrEnGaYRZnk4QOAoHlSVwEhzhjI2iFjWUOwph+BdvXt8U4BT/Y2ExHtru6cU0liOaKVFDiT/DaxMmhgn76sWjuFZv5bOBJSq4kYB58twtPJVoLpeUAOPEUGdlm86FfqBc8ILwfpbbN6c2r/ptxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779096961; c=relaxed/simple;
	bh=4Onn0sQyJM0SkahyM7CpLk1wp6+Pirbqgvun4khgw6s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nuOHYI3cYvk47N8WEQOyF0EezdlXj+bLs4CX2ezBkLunNIR5CPXbYtVuuz752s4bZr3gu9HkSOCNTd/d+b+CRgtYAwflOxsIETkuTwiscuwmFuic4ODEBhcdWxuwP1tkaopMtJvMpPTCYnGEkSf4fLdG0J8/giOtCngsmNuRi4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=q/AdxH7R; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=PHwOsPsNj12dJbcoZ6RPtBiFJb/GwIz/iIPtX7BZGPM=;
	b=q/AdxH7RRrvlbWbPO2oSSM6mmm52I5AfNRpOu+3EdcC4k4IdUCgCt8cx2wcWRD3Ue/9qG9sP4
	7r/xzGkqfoVs1Va8kn4DMR5cdlIoytacjqQYqOBsHvXT3FTUBnc3KEY8iIS9D56DYbmVJpTHYp5
	VeEfNTayUSpD6+p3XCST7A4=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4gJssz34TnzmV6S;
	Mon, 18 May 2026 17:28:07 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id C1DD040572;
	Mon, 18 May 2026 17:35:48 +0800 (CST)
Received: from
 deployment-s00611957-4ii0-20260331111539-78d5c5cfbb-9s2bv.default.svc.cluster.local
 (7.197.8.232) by kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 18 May 2026 17:35:48 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net-next 0/6] net: hns3: enhance tc flow offload support
Date: Mon, 18 May 2026 17:35:20 +0800
Message-ID: <20260518093526.1109595-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
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
X-Rspamd-Queue-Id: 4EBBC569D79
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288965-lists,netdev=lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

This patchset enhances the tc flow offload support for hns3 driver:

- Patch 1: Refactor hclge_add_cls_flower() to support more actions
- Patch 2: Improve unused_tuple parameter setting for separate src/dst configuration
- Patch 3: Add support for HCLGE_FD_ACTION_SELECT_QUEUE and HCLGE_FD_ACTION_DROP_PACKET actions
- Patch 4: Add support for FLOW_DISSECTOR_KEY_IP and FLOW_DISSECTOR_KEY_ENC_KEYID dissectors
- Patch 5: Add debugfs support for dumping FD rules
- Patch 6: Move FD code to a separate file (hclge_fd.c) for better code organization

Jijie Shao (6):
  net: hns3: adjust add_cls_flower() for support more action
  net: hns3: improve the unused_tuple parameter setting
  net: hns3: support two more actions for tc flow
  net: hns3: support IP and tunnel VNI dissectors for tc flow
  net: hns3: debugfs support for dumping fd rules
  net: hns3: move fd code to a separate file

 drivers/net/ethernet/hisilicon/hns3/Makefile  |    1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |    3 +-
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |    6 +
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |    3 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     |  156 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_fd.c | 2574 +++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_fd.h |   33 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 2514 +---------------
 .../hisilicon/hns3/hns3pf/hclge_main.h        |    6 +
 9 files changed, 2822 insertions(+), 2474 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.h

--
2.33.0


