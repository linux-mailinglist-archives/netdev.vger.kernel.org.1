Return-Path: <netdev+bounces-254539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKAEFpvbemlE/AEAu9opvQ
	(envelope-from <netdev+bounces-254539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:01:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5017CAB8EF
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 05:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9D03C3004D9B
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 04:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95B9A2586FE;
	Thu, 29 Jan 2026 04:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="HJUkb+E5"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960C221FF30;
	Thu, 29 Jan 2026 04:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769659284; cv=none; b=n49gWFZ6zyT7dBoR7wUykz4Q66qIWjDJ0/6ghRtsfXKzCQpaHydQITt5bJtKR/E2/ZV7pwZUpdeklXW/1iew9Z6WFVJRIk9i1zrsSeCSC4irCN2WFlpKy5GD04ADCO/LaCMOUgvnz9fApycqodq80q72PBWR968FPwuxFRfubC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769659284; c=relaxed/simple;
	bh=YPUthqdqYHlue6WIjSC+96mvscDSeanHoU+8GYzn5U4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=F23D4+mkqDc09qnSGOkbXNgaKxTbhTTg5c7Kg6p2c5HKLOz/9uSSMnxpGIvTtztHlR6xUPfBFPb4XDbKk8AlQ2nbLgHb/5lIAmZby55bDkZ+gIT98Q1gfCUJcihBHLXrv4XvkfZHIm+Uzw/HmfRl8wDyhxbcENZHOQv4uVD9uFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=HJUkb+E5; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lPG/YinSjGaf1SyiYjFmXtWQ8RiaSt0GdcbYKlLfYmA=;
	b=HJUkb+E5ZA82cnPf9+t6n4E2aPrtBkR9Bw9HWDJpniNQZly9RLCoYGAHx82CtcIuhvYoM9JMR
	nrTEjADFYg0uN4xbEWHtrDc+QN2E7Up2nXPiY5lS92qB6uz5r2Ha9I1lPs32XVs8Slg/MnsDrWM
	1aElkPiWZsrnLqM/dA8eMjI=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4f1lhZ3JpszpStk;
	Thu, 29 Jan 2026 11:57:18 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 13F194056A;
	Thu, 29 Jan 2026 12:01:18 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 29 Jan 2026 12:01:16 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>
Subject: [PATCH net-next v03 0/4] net: hinic3: Fix code styles
Date: Thu, 29 Jan 2026 12:01:07 +0800
Message-ID: <cover.1769656467.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254539-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,h-partners.com:mid]
X-Rspamd-Queue-Id: 5017CAB8EF
X-Rspamd-Action: no action

This patchset provides 4 code styles fixes:

Remove empty lines between error handling.
Remove defensive txq_num check.
Use array_size instead of multiplying.
SQ use SQ_CTXT_PREF_CI_HI to improve readability.

Changes:

PATCH V01: https://lore.kernel.org/netdev/cover.1768915707.git.zhuyikai1@h-partners.com/

PATCH V02: https://lore.kernel.org/netdev/cover.1769142701.git.zhuyikai1@h-partners.com/
* Send "Fix netif_queue_set_napi queue_index parameter passing error" to net (Jakub Kicinski)

PATCH V03:
* Modify commit description to be more accurate and clear (Simon Horman)

Fan Gong (4):
  hinic3: Fix code Style(remove empty lines between error handling)
  hinic3: Remove defensive txq_num check
  hinic3: Use array_size instead of multiplying
  hinic3: RQ use RQ_CTXT_PREF_CI_HI instead of SQ_CTXT_PREF_CI_HI

 drivers/net/ethernet/huawei/hinic3/hinic3_cmdq.c    | 3 ---
 drivers/net/ethernet/huawei/hinic3/hinic3_eqs.c     | 1 -
 drivers/net/ethernet/huawei/hinic3/hinic3_lld.c     | 5 -----
 drivers/net/ethernet/huawei/hinic3/hinic3_main.c    | 4 ----
 drivers/net/ethernet/huawei/hinic3/hinic3_mbox.c    | 2 --
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_cfg.c | 6 ++++--
 drivers/net/ethernet/huawei/hinic3/hinic3_nic_io.c  | 6 +++++-
 drivers/net/ethernet/huawei/hinic3/hinic3_tx.c      | 7 -------
 8 files changed, 9 insertions(+), 25 deletions(-)


base-commit: 4515ec4ad58a37e70a9e1256c0b993958c9b7497
-- 
2.43.0


