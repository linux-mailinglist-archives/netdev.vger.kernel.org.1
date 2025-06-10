Return-Path: <netdev+bounces-196030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48705AD32DB
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 11:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4891E3A2D28
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D35D28B7F0;
	Tue, 10 Jun 2025 09:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JbhND1dQ"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADB528B7CC;
	Tue, 10 Jun 2025 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749549366; cv=none; b=OfEdoBPaDL9WjzJMw68+MzsNkqzDTOLWk9YkggVy4Gs5HLrrzYcYBz99JIc3bUgE+BzNIVyVBm7s9sU8BzPj7xiamb3hc6HUrpHta3TzhpWwicAcsdeAWiBFix3au1o/fHOosEgie0e2riLt9ouc3WJPLjuRnl9IQkVHO1GhQSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749549366; c=relaxed/simple;
	bh=0q1ktw7qbknJvvv/nfcfl4BooLobcwr9kcQ2Be+XVyc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dimkBatPLvC4lCcPbxdn1kefzm+oXKFV8vmhDuzJSs0H95PDQdGw64MyKtqIvAz1SEENIxRVXlsYLhV9PyctRz5abLt9J2W2/eOVvyRQaULyVBjQ/hVbuKRhES8Vzvzw//K8DHFeMir6FrBK6fcKl28mZwrDTtavUNC2qwLQnfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JbhND1dQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55A9tR2i92612669, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1749549327; bh=O+63X+TPXlermj3mzhPv5J76m80xbz8M1MdxAzrI/xs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=JbhND1dQc6uAST53Trx1G2vH1npz419p0hWOrD2zTrrPchUbBZ0gx9/PUzvAlbssG
	 RFUTHfzIFk8tQukTcOkuL6AnBWLefbr/YWXMRNI/Gg20s+9jyT1bHLau/GyOOa5YZD
	 4V3yXl0aA9aiSqPddqALWvF2dy5Jtog0/J44QctcxV+VUpEJaAtHG9nStITa0rSXZa
	 iKOgljEzwpxmNdGlnr8IM+S5awcvioWWmbRFZ+JVMesWs0JkVxUkcq7NJzy47FAv1g
	 nVmQz8Ea+pWlSFC4Ut8HvNPE0p9Fd/yVykoRAjAu+FiLTSJtorbvV6NcwijfAombGQ
	 7BALRFN2tjUZw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55A9tR2i92612669
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 17:55:27 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Jun 2025 17:55:27 +0800
Received: from RTDOMAIN (172.21.210.109) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 10 Jun
 2025 17:55:27 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net-next] rtase: Refine the flexibility of Rx queue allocation
Date: Tue, 10 Jun 2025 17:55:18 +0800
Message-ID: <20250610095518.6585-1-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Refine the flexibility of Rx queue allocation by using alloc_etherdev_mqs.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 4d37217e9a14..c22dd573418a 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -2080,8 +2080,8 @@ static int rtase_init_board(struct pci_dev *pdev, struct net_device **dev_out,
 	int ret = -ENOMEM;
 
 	/* dev zeroed in alloc_etherdev */
-	dev = alloc_etherdev_mq(sizeof(struct rtase_private),
-				RTASE_FUNC_TXQ_NUM);
+	dev = alloc_etherdev_mqs(sizeof(struct rtase_private),
+				 RTASE_FUNC_TXQ_NUM, RTASE_FUNC_RXQ_NUM);
 	if (!dev)
 		goto err_out;
 
-- 
2.34.1


