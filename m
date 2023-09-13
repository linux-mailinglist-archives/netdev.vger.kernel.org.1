Return-Path: <netdev+bounces-33507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5965079E51B
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 12:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C3CE1C20D5C
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 10:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F2017755;
	Wed, 13 Sep 2023 10:42:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4662A17736
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 10:42:04 +0000 (UTC)
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B16119A0;
	Wed, 13 Sep 2023 03:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=AIyMv
	xxGP9p9iIM6Er7MAf6Bge5FuQgTctDUr2yM9GA=; b=Ee365Tgh7vq0LC2bAJEcw
	tzLDr84MJ6qcd/DY/lsuo1tEwv3yEqLlhnbWDGhVBi1+8ab8DlbspXZ/ow/qrOEi
	8MWuHI7TrPgJ9LXXBP1aL6J5HZisRLY6WxBFA79Yi4N2r00cEmKy+vqk16NgCXKj
	uMPf0XuJwF+3fxLVP8fKtg=
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wB3JXbRkQFlkrPhBw--.16168S4;
	Wed, 13 Sep 2023 18:41:39 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: shshaikh@marvell.com,
	manishc@marvell.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	GR-Linux-NIC-Dev@marvell.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ma Ke <make_ruc2021@163.com>
Subject: [PATCH] net/qlcnic: fix possible use-after-free bugs in qlcnic_alloc_rx_skb()
Date: Wed, 13 Sep 2023 18:41:19 +0800
Message-Id: <20230913104119.3344592-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.37.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3JXbRkQFlkrPhBw--.16168S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GFWxuw45AFyfGFWUWF4UJwb_yoWfWFb_GF
	4UZr18Za1DGr9Ikw42qr45A3429FyDXrZ3Aw4Fgay3JwnrAF4fGrW2kF95JryxW3yxZFyD
	G3Way3y5A342vjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRKJ5rDUUUUU==
X-Originating-IP: [183.174.60.14]
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/1tbiyAbpC1p7LvK8kAAAs9

In qlcnic_alloc_rx_skb(), when dma_map_single() fails, skb is freed
immediately. And skb could be freed again. This issue could allow a
local attacker to crash the system due to a use-after-free flaw.

Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
index 41894d154013..6501aaf2b5ce 100644
--- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
+++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_io.c
@@ -832,6 +832,7 @@ static int qlcnic_alloc_rx_skb(struct qlcnic_adapter *adapter,
 	if (dma_mapping_error(&pdev->dev, dma)) {
 		adapter->stats.rx_dma_map_error++;
 		dev_kfree_skb_any(skb);
+		skb = NULL;
 		return -ENOMEM;
 	}
 
-- 
2.37.2


