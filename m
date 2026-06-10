Return-Path: <netdev+bounces-297452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oIb7Gyj/KGp3OgMAu9opvQ
	(envelope-from <netdev+bounces-297452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:07:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 813A666615B
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:07:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=Zypc0XdB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297452-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297452-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B94E7301DBB9
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 06:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740E53438BD;
	Wed, 10 Jun 2026 06:06:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB49125B0B3;
	Wed, 10 Jun 2026 06:06:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071601; cv=none; b=oKrSuKdN6zxuie1YaUD+s0Yx0ZV1ZqDsTSKQHERcO9n2+4ab/1/oAG8GQ8u/oZ1c9PS7dEgMeU7xqJaGiMIV8PhOGWSeCRgxucy11EbspXBPjMgS4I86B0GxUJMExt1fPkC/ibtXlMpK9P9BcTY0g7Okph1tp+ZdBER0a3K+ao8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071601; c=relaxed/simple;
	bh=uAPz3u7FR97ImKZe49+xSl2+ebWGiEN63ft1iK99pZk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QDXXUjT5n0nHBWVEonFlAClKY2VV47EYgbEjDSCekRdhbStnu3Hw6w/uFJnbYFT0wZnuEmoCTmUTBDZfDuHHfc1qMCVBsdBr+A9yNwfLVjg5JXb9LGmunlS8cje543A/Vd3eHuPJ+g4wmCBNTuIhNq+5KbkYWAOfAJa7YGnXWbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Zypc0XdB; arc=none smtp.client-ip=113.46.200.225
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=OOt1/6axTY4K9Ez/wLDcMKt7dUwM/2HSAPJ0ngyJUJg=;
	b=Zypc0XdBYGKpyQ3PcpI8ppCNMd39i2DWiDSFmsZgXVnVcHnVyo9SPyhhylPaSOXHEKiagWcNp
	WElRzQB31sYKU8qzb6UHK6wWl6d8OyJHPjPktaiENHpDeURHEX4DUtV/QHidJpBewRUYxaIpRuE
	m+xLv7CVNoy40KU5s4Ec3IA=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gZw7j2dTjz1K990;
	Wed, 10 Jun 2026 13:58:41 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 32CFC4056E;
	Wed, 10 Jun 2026 14:06:34 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 10 Jun 2026 14:06:33 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <liuyonglong@huawei.com>,
	<chenhao418@huawei.com>, <huangdonghua3@h-partners.com>,
	<yangshuaisong@h-partners.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH V4 net-next 0/6] net: hns3: enhance tc flow offload support
Date: Wed, 10 Jun 2026 14:06:12 +0800
Message-ID: <20260610060618.834987-1-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk100013.china.huawei.com (7.202.194.61)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297452-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:shenjian15@huawei.com,m:liuyonglong@huawei.com,m:chenhao418@huawei.com,m:huangdonghua3@h-partners.com,m:yangshuaisong@h-partners.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:shaojijie@huawei.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[shaojijie@huawei.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[huawei.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,huawei.com:dkim,huawei.com:mid,huawei.com:from_mime,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 813A666615B

This patchset enhances the tc flow offload support for hns3 driver:

- Patch 1: Refactor hclge_add_cls_flower() to support more actions
- Patch 2: Improve unused_tuple parameter setting for separate src/dst configuration
- Patch 3: Add support for HCLGE_FD_ACTION_SELECT_QUEUE and HCLGE_FD_ACTION_DROP_PACKET actions
- Patch 4: Add support for FLOW_DISSECTOR_KEY_IP and FLOW_DISSECTOR_KEY_ENC_KEYID dissectors
- Patch 5: Add debugfs support for dumping FD rules
- Patch 6: Move FD code to a separate file (hclge_fd.c) for better code organization

---
v3 -> v4:
  - Fix issues pointed out by Jakub Kicinski:
    a) Fix byte order issue of KEY_OPT_VNI under big-endian architectures.
    b) Fix issue where match.mask->ttl was silently ignored in FLOW_DISSECTOR_KEY_IP.
  - Use NL_SET_ERR_MSG_MOD() and extack to return errors instead of dev_err(),
    as suggested by Jakub.
  - Links:
    v3: https://lore.kernel.org/all/20260602133337.2216918-1-shaojijie@huawei.com/
    AI report: https://sashiko.dev/#/patchset/20260602133337.2216918-1-shaojijie%40huawei.com

v2 -> v3:
  - Fix issues pointed out by Simon Horman and Paolo Abeni:
    a) Fix incorrect condition for identifying unused tuples when IP/MAC
       addresses are all-zero but masks are non-zero.
    b) Fix inappropriate log output in error paths.
    c) Fix issue where tc flower supported keys did not distinguish between
       different FD modes.
    d) Fix unnecessary distinction between IPv4 and IPv6 in debugfs.
  - Links:
    v2: https://lore.kernel.org/all/20260523105449.661848-1-shaojijie@huawei.com/
    AI report: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260523105449.661848-1-shaojijie%40huawei.com

v1 -> v2:
  - Fix "restricted __le32 degrades to integer" warnings, pointed out by Jakub.
  - Fix "diagnostic behavior may be improved by adding 'format(printf, 5, 7)'"
    warnings, pointed out by Jakub.
  - Link:
    v1: https://lore.kernel.org/all/20260518093526.1109595-1-shaojijie@huawei.com/
---

Jijie Shao (6):
  net: hns3: refactor add_cls_flower to prepare for multiple actions
  net: hns3: improve the unused_tuple parameter setting
  net: hns3: support two more actions for tc flow
  net: hns3: support IP and tunnel VNI dissectors for tc flow
  net: hns3: debugfs support for dumping fd rules
  net: hns3: move fd code to a separate file

 drivers/net/ethernet/hisilicon/hns3/Makefile  |    1 +
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |    3 +-
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    |    6 +
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |    3 +-
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     |  155 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_fd.c | 2593 +++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_fd.h |   33 +
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 2514 +---------------
 .../hisilicon/hns3/hns3pf/hclge_main.h        |    6 +
 9 files changed, 2840 insertions(+), 2474 deletions(-)
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.c
 create mode 100644 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_fd.h


base-commit: 61abe5db23f0799e602352c796de6fcf76d23b41
-- 
2.33.0


