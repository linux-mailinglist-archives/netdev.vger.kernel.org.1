Return-Path: <netdev+bounces-252229-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WOd4EPTRcWk+MgAAu9opvQ
	(envelope-from <netdev+bounces-252229-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:29:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C263B627F4
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 08:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A08B4E6136
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 07:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61588480947;
	Thu, 22 Jan 2026 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="ETs/iCXr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E80B34EF14;
	Thu, 22 Jan 2026 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769066989; cv=none; b=VY4DcBSoO/U1lhhgEjSCYzMPFt9JmidT0ru3zwN0wMeRl2aXAIDql3Hg0zGL/sNqQyLw9vSHjFDK6BkoDnL2jfGzYtuWc8Tle5W4LNnnkKAg2Xe0CtjZnEomuQwwuG7fNUstu0aPW9PRTujTQiuKewBITyMauChqdbgpWP1JfAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769066989; c=relaxed/simple;
	bh=lZnEwMkDpXPOBjCKBa0YDS76CghxfX0un/2o2oQTQY4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gKYS0fnH7CekoLWQyPWmedj/ek06ePeAfYvqYNOlIXsieb1VpNAv0sNTiyDCsWIcVJcGvlAQuxbQ78tyNWq3B3dNif7tKLBCCo7R5yHfvOxPd967ax45xoNavHLq5gyK+hfYNcdJ1LTS8LX6ge7alWGS99L75cVihkPuldPJUFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=ETs/iCXr; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 318fac9ea;
	Thu, 22 Jan 2026 15:29:38 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: andrew+netdev@lunn.ch
Cc: edumazet@google.com,
	kuba@kernel.org,
	davem@davemloft.net,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net] net: liquidio: Fix memory leak in setup_nic_devices()
Date: Thu, 22 Jan 2026 07:29:33 +0000
Message-Id: <20260122072933.328997-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be49bd94d03a1kunme911d8492fa1d
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTUgeVklCTENMTE1ITB9JGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktJSE5DQ1VKS0tVS1
	kG
DKIM-Signature: a=rsa-sha256;
	b=ETs/iCXrLTmi1lYlv/B6ukX2RfTuyCUHVdzpY/LzNoPrftBNGIxmXan328U2cd2az3hRZ8wmJDdaYKAaOxj1fvAva6ITIEt3gHIuZcFvjJDoLP8vJ955k6X13Mt8yvClqx8AiXnldZGBhcT4Szxy9SqLZfFyq9hQ8Unkdczj8Gk=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=m7758YjHP1z7JHrfqwXJej7jqfpSbjYnkbVlhiSSjK4=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252229-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[seu.edu.cn,none];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: C263B627F4
X-Rspamd-Action: no action

In setup_nic_devices(), the netdev is allocated using alloc_etherdev_mq().
However, the pointer to this structure is stored in oct->props[i].netdev
only after the calls to netif_set_real_num_rx_queues() and
netif_set_real_num_tx_queues().

If either of these functions fails, setup_nic_devices() returns an error
without freeing the allocated netdev. Since oct->props[i].netdev is still
NULL at this point, the cleanup function liquidio_destroy_nic_device()
will fail to find and free the netdev, resulting in a memory leak.

Fix this by initializing oct->props[i].netdev before calling the queue
setup functions. This ensures that the netdev is properly accessible for
cleanup in case of errors.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: c33c997346c3 ("liquidio: enhanced ethtool --set-channels feature")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 .../net/ethernet/cavium/liquidio/lio_main.c   | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index 0732440eeacd..efb11edb95d7 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -3505,6 +3505,16 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 		 */
 		netdev->netdev_ops = &lionetdevops;
 
+		lio = GET_LIO(netdev);
+
+		memset(lio, 0, sizeof(struct lio));
+
+		lio->ifidx = ifidx_or_pfnum;
+
+		props = &octeon_dev->props[i];
+		props->gmxport = resp->cfg_info.linfo.gmxport;
+		props->netdev = netdev;
+
 		retval = netif_set_real_num_rx_queues(netdev, num_oqueues);
 		if (retval) {
 			dev_err(&octeon_dev->pci_dev->dev,
@@ -3521,16 +3531,6 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 			goto setup_nic_dev_free;
 		}
 
-		lio = GET_LIO(netdev);
-
-		memset(lio, 0, sizeof(struct lio));
-
-		lio->ifidx = ifidx_or_pfnum;
-
-		props = &octeon_dev->props[i];
-		props->gmxport = resp->cfg_info.linfo.gmxport;
-		props->netdev = netdev;
-
 		lio->linfo.num_rxpciq = num_oqueues;
 		lio->linfo.num_txpciq = num_iqueues;
 		for (j = 0; j < num_oqueues; j++) {
-- 
2.34.1


