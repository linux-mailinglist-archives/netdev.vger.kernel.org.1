Return-Path: <netdev+bounces-267317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMtNI8XCs2mEagAAu9opvQ
	(envelope-from <netdev+bounces-267317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:54:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7617627F0B9
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 08:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 43D2C303B913
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 07:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F5F36EAAB;
	Fri, 13 Mar 2026 07:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="DEd2F7T6"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA42D36D510;
	Fri, 13 Mar 2026 07:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773388475; cv=none; b=oDMDuDQY9Juheb1fmQaVwK2XASnRmv8FgmjykR/en4qRQmH/vb18MBESeXBUwpKs8zfEufrnZ2oWVX+8X2Sgv0w6en78gMyePSD2JubicvxCarfxfb7Bw9F4FqM/ZbeXYXk2f7JlEv7hjwEla46nftOPnd+3YhIU6qXLW5+Ylf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773388475; c=relaxed/simple;
	bh=uHOqNzvcP9QD1tepmN9ksz0SlAxPfdXVJel5SsIX00Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d7C61YAYXKKrZ2LGW3hwnxDpzQ5tvNgxln2/H/XMVChuNmbntQsHUjrnmmrKL2t/8rlfcEV/1IsDsD9UagXhC+uLQ4H/JpJMGz8eMZGiq/5O8qfm9yeWzvQKENX7MOhrIHJnYkHl8zrph0dNNguKykVbWULIp+yzzSlhN6n6Mpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=DEd2F7T6; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=C3opMo0gBrkg9mjWXYEFQnBJeBIJ8E7IPTWkSnJI6Bg=;
	b=DEd2F7T6hvNSKdH1/LZxwm0Jd39C8wKblLlJaBYKZHteNDXJsnDmNBMmFlvzlavc/pXtz6bw7
	lG8ume6z4PG6oLCWOoXZASBEYaSXxn+rSJyJVBwUXXXq5M5m26qp2Li9dhC7j8/gsGzr0Zbb4hH
	0aW6hOPUljL6wRqStsB0DGE=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fXGpD3P3gzpT03;
	Fri, 13 Mar 2026 15:49:08 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F9F640567;
	Fri, 13 Mar 2026 15:54:23 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 13 Mar 2026 15:54:22 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Zhou Shuai
	<zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Zheng Jiezhen <zhengjiezhen@h-partners.com>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v01 0/7] net: hinic3: PF initialization
Date: Fri, 13 Mar 2026 15:54:07 +0800
Message-ID: <cover.1773387649.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267317-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,huawei.com:dkim]
X-Rspamd-Queue-Id: 7617627F0B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is [3/3] part of hinic3 Ethernet driver second submission.
With this patch hinic3 becomes a complete Ethernet driver with
pf and vf.

Add 20 ethtool ops for information of queue, rss, coalesce and eth data.
Add MTU size validation
Config netdev watchdog timeout.
Remove unneed coalesce parameters.

Changes:

PATCH 03 V01:
* Add rmon/pause/phy/mac/ctrl stats (Ioana Ciornei)

Fan Gong (7):
  hinic3: Add ethtool queue ops
  hinic3: Add ethtool statistic ops
  hinic3: Add ethtool coalesce ops
  hinic3: Add ethtool rss ops
  hinic3: Add MTU size validation
  hinic3: Configure netdev->watchdog_timeo to set nic tx timeout
  hinic3: Remove unneed coalesce parameters

 .../ethernet/huawei/hinic3/hinic3_ethtool.c   | 927 +++++++++++++++++-
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  13 +-
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |   9 +-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |   7 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  39 +
 .../huawei/hinic3/hinic3_netdev_ops.c         |  61 ++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   |  77 ++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   | 109 ++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  20 +
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |   4 +
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   | 487 ++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_rss.h   |  19 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    |  57 +-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  17 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |  79 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |   2 +
 16 files changed, 1905 insertions(+), 22 deletions(-)


base-commit: 8e7adcf81564a3fe886a6270eea7558f063e5538
-- 
2.43.0


