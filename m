Return-Path: <netdev+bounces-294223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id EmxHO/3dHmoKWwAAu9opvQ
	(envelope-from <netdev+bounces-294223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:43:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5933962E99C
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:43:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=KvqT5XE2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294223-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-294223-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A8C0301DED7
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF4D3E7BB6;
	Tue,  2 Jun 2026 13:33:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E913E277E;
	Tue,  2 Jun 2026 13:33:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780407239; cv=none; b=TPRoS9Eq+s4VTpYNi5puUEgxJKspV7WAlcKcSaf7393A+XPW97IQ0rPPIeRCiVZk8WysV1kfmLSqApIjO6uCra+P+iqWhBeWh6e3w8n4vV41qDgSrFe5oq5wHm5PoDKYMEvf6HVDCuHNTFDLF//gtKPUnj/nlTYvxDy2EA/yL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780407239; c=relaxed/simple;
	bh=V9rHbpKmGlZVGvCMOxmAL2Rrhd5pVMlynYwIF7QRRHc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eWJk5JinvyugTshhJ4OSQJKb8fiBbw4WN2TafBum9+HyWlSJYhadsoMH6XTzO5cOSAYT6QV4UrzjAIJLi6QG0QyDda3dyLA5WumSs0fA0SQVevrHhGPVPUhmCOlJGcoooWhgPPnLwVx2wS3O7cZTXiRkzzIQAcwP0emjBoxUWe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KvqT5XE2; arc=none smtp.client-ip=113.46.200.216
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=3k4sjC0y1MVeL6AbWoLHR3nIKzBfgPsbVHt5JCPsmQA=;
	b=KvqT5XE2WggeMMQaj3kjuufRi6/85Ej9fvBzehm7nMZlwevph4p6FBzwzY3VQaUTav92jJRiT
	SSAwJk7PJ3CuHnUsWjMDFipI/UMFWG5xW1rofhZnf8M8R+giP33Qn/+0djIAJ5o+oJ9nk52wfOZ
	LVW2B9xAE7QU6g7fgIkyiME=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4gVBR65d5hz1T4Fw;
	Tue,  2 Jun 2026 21:25:38 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id A8C3440576;
	Tue,  2 Jun 2026 21:33:48 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 2 Jun 2026 21:33:47 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V3 net-next 0/6] net: hns3: enhance tc flow offload support
Date: Tue, 2 Jun 2026 21:33:31 +0800
Message-ID: <20260602133337.2216918-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294223-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shaojijie@huawei.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:mid,huawei.com:from_mime,huawei.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5933962E99C

This patchset enhances the tc flow offload support for hns3 driver:

- Patch 1: Refactor hclge_add_cls_flower() to support more actions
- Patch 2: Improve unused_tuple parameter setting for separate src/dst configuration
- Patch 3: Add support for HCLGE_FD_ACTION_SELECT_QUEUE and HCLGE_FD_ACTION_DROP_PACKET actions
- Patch 4: Add support for FLOW_DISSECTOR_KEY_IP and FLOW_DISSECTOR_KEY_ENC_KEYID dissectors
- Patch 5: Add debugfs support for dumping FD rules
- Patch 6: Move FD code to a separate file (hclge_fd.c) for better code organization

---
ChangeLog:
v2 -> v3:
  - Fix some issues found by AI, pointed out by Simon and Paolo
    a) Fix the incorrect judgment condition for unused tuples with all-zero IP and MAC addresses but non-zero mask
    b) Fix unreasonable log output in abnormal path
    c) Fix the issue where tc flow support_key does not distinguish between different fd_modes
    d) Fix the unreasonable distinction between IPv4 and IPv6 in debugfs
  v2: https://lore.kernel.org/all/20260523105449.661848-1-shaojijie@huawei.com/
  AI report: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260523105449.661848-1-shaojijie%40huawei.com
v1 -> v2:
  - Fixed warnings similar to "warning: restricted __le32 degrades to integer",
    pointed out by Jakub
  - Fixed warnings related to
    "warning: diagnostic behavior may be improved by adding the 'format(printf, 5, 7)'",
    pointed out by Jakub
  v1: https://lore.kernel.org/all/20260518093526.1109595-1-shaojijie@huawei.com/
---

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
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     |  145 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_fd.c | 2579 +++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_fd.h |   33 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 2514 +---------------
 .../hisilicon/hns3/hns3pf/hclge_main.h        |    6 +
 9 files changed, 2816 insertions(+), 2474 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.h

-- 
2.33.0


