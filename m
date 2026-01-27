Return-Path: <netdev+bounces-253921-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OOPpCQPZeGmwtgEAu9opvQ
	(envelope-from <netdev+bounces-253921-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:25:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3540F96A62
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 054AE3066935
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC54366055;
	Tue, 27 Jan 2026 15:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="Iq7OlBM2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72382364E89;
	Tue, 27 Jan 2026 15:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526782; cv=none; b=CcYWi1CYt4lY99ZlLSwRhInW1/2ICts1Qw9YpTvvCfTOsscyBwxvKFvy9iu90YuyDK82/pcQMlKPapqigU7kRWQMQA5D2j/Xyha6h6VrdpeBrQDngnV0YSl8BFyZvGr7uABsNJ1vOTYMfUokG0rZKF+Vb0Tl63y7lAl3ezq4f+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526782; c=relaxed/simple;
	bh=GScpE5X4WSCtkNfJghc+nlOFRzvsz8znYxwPNi0Lu3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ut0Rmss2yDwvLybnpAtlwMjNG4RpQ3SdOqCoolvi3O0eLQfbGbkQKR4NoTWhRnancjuwnk0o8H0YhJk58wD5tN9kYChH/XNcDYW0OJAnnVVMo+95gJAp5Kjf8bZA5ZYnG2LO+0LnmwzVZCycqp8UIp95MNTaWpJKhRG5gj7J2sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=Iq7OlBM2; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 32272e8f2;
	Tue, 27 Jan 2026 23:12:55 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: horms@kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	jianhao.xu@seu.edu.cn,
	kory.maincent@bootlin.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	marco.crivellari@suse.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net v3 3/3] net: liquidio: Initialize netdev pointer before queue setup
Date: Tue, 27 Jan 2026 15:12:41 +0000
Message-Id: <20260127151241.1144039-4-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260127151241.1144039-1-zilin@seu.edu.cn>
References: <20260127151241.1144039-1-zilin@seu.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9c0003ce7f03a1kunmaea0ca6058cec
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZThpLVksfQkpOSUkeGB0YTFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=Iq7OlBM2BDpBqRiyTrqm3m4Gb3pwPCjjaO/KqWjSa/pnLJB5mxdWkUjjmOhvHZEzh0AsiVFlWlx0mUdPAlXOqxcXoVj2YPd6OVmYtM5l7hUgrB848t/L5iNeK1Q30o5xzCABBm4LVViLErMAbvhUFK4c9WcpnOKHphv5rJ0Tyqw=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=7a1FD7qC5YrmC7wGvX/av9a2xAd5jgzjymv1/iYwGRw=;
	h=date:mime-version:subject:message-id:from;
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[seu.edu.cn,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[seu.edu.cn:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-253921-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,seu.edu.cn:dkim,seu.edu.cn:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3540F96A62
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
 .../net/ethernet/cavium/liquidio/lio_main.c   | 34 +++++++++----------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
index e9a728997689..6c954f740073 100644
--- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
+++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
@@ -3505,6 +3505,23 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
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
+		/* Point to the  properties for octeon device to which this
+		 * interface belongs.
+		 */
+		lio->oct_dev = octeon_dev;
+		lio->octprops = props;
+		lio->netdev = netdev;
+
 		retval = netif_set_real_num_rx_queues(netdev, num_oqueues);
 		if (retval) {
 			dev_err(&octeon_dev->pci_dev->dev,
@@ -3521,16 +3538,6 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
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
@@ -3596,13 +3603,6 @@ static int setup_nic_devices(struct octeon_device *octeon_dev)
 		netdev->min_mtu = LIO_MIN_MTU_SIZE;
 		netdev->max_mtu = LIO_MAX_MTU_SIZE;
 
-		/* Point to the  properties for octeon device to which this
-		 * interface belongs.
-		 */
-		lio->oct_dev = octeon_dev;
-		lio->octprops = props;
-		lio->netdev = netdev;
-
 		dev_dbg(&octeon_dev->pci_dev->dev,
 			"if%d gmx: %d hw_addr: 0x%llx\n", i,
 			lio->linfo.gmxport, CVM_CAST64(lio->linfo.hw_addr));
-- 
2.34.1


