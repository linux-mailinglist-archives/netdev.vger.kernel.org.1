Return-Path: <netdev+bounces-273043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cI1hMmjNyWm62gUAu9opvQ
	(envelope-from <netdev+bounces-273043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 03:10:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B3E35488F
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 03:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E99A30580A8
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 01:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAE02638BC;
	Mon, 30 Mar 2026 01:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="k3C6yJOQ"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCB6280A20;
	Mon, 30 Mar 2026 01:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774832632; cv=none; b=Bb42xCKVqjxyCz/2eSvWApcscUxJw2vwgVt5xSQ8MWNlMd1uqqCeQ5+PbrV9wBQsfEFM6K+mV1T1EB458qc7XgQBv9Zy9Nl7FsmpvvKCHBtEyD/mdP3tgTtz3H3KltaCiAOKnLNboFG0mHWzeoL9aGGVxlIHBAh0C8cqGlPlVJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774832632; c=relaxed/simple;
	bh=WHtFJ2WfWzNoEFlaOGsliw2COgU7dl5m738goI0pwRo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YfBad9m9oMUB0nVgWFmzwbjrUCEzxgi8PkybRRzuZwYzcl+gxAcqKiF27Asp4CmgPQsxz8QP4pjrIrTfCGaUsPQwRK1yfrgYrbXHbEO+GhjSRk0OD/FrBZCrQJGL0YhPnezxStoqnve6riaCXRLz/r+JMsmCS36lmppwYV0f9kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=k3C6yJOQ; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YwfSrPCHCl+uJGc2fx+OVzAn8fZBKv6wc0veh7li0Cg=;
	b=k3C6yJOQ9VUKOOdtt9pjSre9qLUx5WA2B/nNGS8YRgzSVjNwhvXTTErqf7PMuKdpfoVOflzrU
	VgfT28SICU+fG+ri/sqLahCbfnUM9tPU1F5eh63tkS6I6WG5EFUowRqsSQWFWzXiCx013f/go61
	/TYBtCOMFZb3Z0YVxCk3UQ8=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4fkXt24WFSz1T4Hs;
	Mon, 30 Mar 2026 08:58:02 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 3AE424056E;
	Mon, 30 Mar 2026 09:03:40 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.124) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 30 Mar 2026 09:03:38 +0800
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
Subject: [PATCH net-next v02 6/6] hinic3: Remove unneed coalesce parameters
Date: Mon, 30 Mar 2026 09:03:23 +0800
Message-ID: <651938818c0401ce51b8fae3e3129fe25842d1dc.1774684571.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
In-Reply-To: <cover.1774684571.git.zhuyikai1@h-partners.com>
References: <cover.1774684571.git.zhuyikai1@h-partners.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100013.china.huawei.com (7.202.181.12)
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273043-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gongfan1@huawei.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:dkim,huawei.com:email,h-partners.com:email,h-partners.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 74B3E35488F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

  Remove unneed coalesce parameters in irq handling.

Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
Signed-off-by: Fan Gong <gongfan1@huawei.com>
---
 drivers/net/ethernet/huawei/hinic3/hinic3_irq.c | 6 +-----
 drivers/net/ethernet/huawei/hinic3/hinic3_rx.h  | 3 ---
 2 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
index d3b3927b5408..42464c007174 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_irq.c
@@ -156,13 +156,9 @@ static int hinic3_set_interrupt_moder(struct net_device *netdev, u16 q_id,
 	spin_unlock_irqrestore(&nic_dev->channel_res_lock, flags);
 
 	err = hinic3_set_interrupt_cfg(nic_dev->hwdev, info);
-	if (err) {
+	if (err)
 		netdev_err(netdev,
 			   "Failed to modify moderation for Queue: %u\n", q_id);
-	} else {
-		nic_dev->rxqs[q_id].last_coalesc_timer_cfg = coalesc_timer_cfg;
-		nic_dev->rxqs[q_id].last_pending_limit = pending_limit;
-	}
 
 	return err;
 }
diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
index cd2dcaab6cf7..a64a51d766c5 100644
--- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
+++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.h
@@ -112,9 +112,6 @@ struct hinic3_rxq {
 	dma_addr_t             cqe_start_paddr;
 
 	struct dim             dim;
-
-	u8                     last_coalesc_timer_cfg;
-	u8                     last_pending_limit;
 } ____cacheline_aligned;
 
 struct hinic3_dyna_rxq_res {
-- 
2.43.0


