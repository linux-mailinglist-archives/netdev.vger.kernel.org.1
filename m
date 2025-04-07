Return-Path: <netdev+bounces-179759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE12A7E74B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 18:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8F0217BA50
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 16:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96557211A0C;
	Mon,  7 Apr 2025 16:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IXY3YbYZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46992116F7
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744044502; cv=none; b=QBE9QnjjRgssukAC2a68yy5a+Gnl+FadukF24cI2pv26SQLeULcYkGCzA7Ti4jjz0gYggyuqXGhW93pQHkdprd/x+P3R6Euy3Vgjrz4/Q3r1ZxAPgYGY7WQrZgE0FVftxhFAAi/+pHP+sMeIZuXFwrHI/wtS7I4QZLP0t7ASfX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744044502; c=relaxed/simple;
	bh=5NmCBrHYCADbtQr5zl3Q6uaVUzhq3d/J8U2gZ/o4TYQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=j+TEYkEAjCQrV7cM9gBH0x5frg/+HkWw8TuPbGN2s1wRZSk2Rx5GN9DTYPZIHEqk7qHnM+d65jzl0HYzbVPZNGGshP/2aQWiiRhqCdDPsRAM32Ku2SJO2HDVctxlbe/XHUvqzq9sfq2RmwiQPseik72C+eqwZ1G23EcPj+RIsKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IXY3YbYZ; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744044501; x=1775580501;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Jn+phQ5mdvA/AdKrkD9ueKBndxBbS2xCerlBXBzEcYc=;
  b=IXY3YbYZkqJIOb7v8Ulj/kv8ZhRMLEU28tRwlBMxk2rX32sQWni6riX1
   8XSsLU6LQfPAQ0kY+PmwVCsgcOQM/ZA5oOt0+48CKxzNF5ZovjD5fsrsU
   SNkB5IiIvdzenU/SLBxTcnfZg7ahgfJs9kt4839+30spgjj5zX+rADAYa
   8=;
X-IronPort-AV: E=Sophos;i="6.15,194,1739836800"; 
   d="scan'208";a="487325289"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 16:48:17 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:4994]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.147:2525] with esmtp (Farcaster)
 id c77d0eb4-0f1b-4e03-9867-26eee827eac1; Mon, 7 Apr 2025 16:48:16 +0000 (UTC)
X-Farcaster-Flow-ID: c77d0eb4-0f1b-4e03-9867-26eee827eac1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 16:48:16 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 16:48:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski
	<akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Saeed Bishara
	<saeedb@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Joe Damato <jdamato@fastly.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next] net: ena: Support persistent per-NAPI config.
Date: Mon, 7 Apr 2025 09:47:59 -0700
Message-ID: <20250407164802.25184-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC004.ant.amazon.com (10.13.139.205) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Let's pass the queue index to netif_napi_add_config() to preserve
per-NAPI config.

Test:

Set 100 to defer-hard-irqs (default is 0) and check the value after
link down & up.

  $ cat /sys/class/net/enp39s0/napi_defer_hard_irqs
  0

  $ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
    --dump napi-get --json='{"ifindex": 2}'
  [{'defer-hard-irqs': 0,
    'gro-flush-timeout': 0,
    'id': 65,
    'ifindex': 2,
    'irq': 29,
    'irq-suspend-timeout': 0}]

  $ sudo ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
    --do napi-set --json='{"id": 65, "defer-hard-irqs": 100}'

  $ sudo ip link set enp39s0 down && sudo ip link set enp39s0 up

Without patch:

  $ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
    --dump napi-get --json='{"ifindex": 2}'
  [{'defer-hard-irqs': 0,  <------------------- Reset to 0
    'gro-flush-timeout': 0,
    'id': 66,  <------------------------------- New ID
    'ifindex': 2,
    'irq': 29,
    'irq-suspend-timeout': 0}]

With patch:

  $ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
    --dump napi-get --json='{"ifindex": 2}'
  [{'defer-hard-irqs': 100,  <--------------+-- Preserved
    'gro-flush-timeout': 0,                 |
    'id': 65,  <----------------------------'
    'ifindex': 2,
    'irq': 29,
    'irq-suspend-timeout': 0}]

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/net/ethernet/amazon/ena/ena_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
index 70fa3adb4934..aa4a17edd98f 100644
--- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
+++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
@@ -1777,7 +1777,7 @@ static void ena_init_napi_in_range(struct ena_adapter *adapter,
 		if (ENA_IS_XDP_INDEX(adapter, i))
 			napi_handler = ena_xdp_io_poll;
 
-		netif_napi_add(adapter->netdev, &napi->napi, napi_handler);
+		netif_napi_add_config(adapter->netdev, &napi->napi, napi_handler, i);
 
 		if (!ENA_IS_XDP_INDEX(adapter, i))
 			napi->rx_ring = rx_ring;
-- 
2.48.1


