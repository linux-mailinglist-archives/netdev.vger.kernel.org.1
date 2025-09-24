Return-Path: <netdev+bounces-225801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC741B9864F
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 08:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A83F4A060A
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 06:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4551917CD;
	Wed, 24 Sep 2025 06:31:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-m21468.qiye.163.com (mail-m21468.qiye.163.com [117.135.214.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118B424677F
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 06:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758695511; cv=none; b=XQte8R6HjTQeQQ0oPCaSTwR+vSqZm3HEaly9ML8oXoqPphRV7Due9YsJNsruP7sxUklFFmhiYx5oaeiA8yMDVGklBTd5b6lihDPfKF2H/PsNmrFGP2XFaJFP8m/SZYWWYcBFMawd6T/Nzy4uDaTcMC6uQQvvCmG1WZ7nS4ygPT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758695511; c=relaxed/simple;
	bh=FeI2Z8PYG3Q79RX93AO97K9R9VFYKdxcHpYSpE64Nrc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=SpOLo2kYQBSVwnAEhLYNMDeWf41a9lEYEYJsm4T8NyrJlnX1bIusjml3QcTzCDO2XifoLs6NguXscNg9CsezgMeD0vecpn175JFyRs4wR3mse5tUS55cS1gvtjqQbsXZ20ZBMRNAkwofpR8nHbW0uvnysDSdhGTDjyT0pJAlcB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=117.135.214.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id 10a847808;
	Wed, 24 Sep 2025 11:02:29 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: manishc@marvell.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] net: qed: Remove redundant NULL checks after list_first_entry()
Date: Wed, 24 Sep 2025 11:02:19 +0800
Message-Id: <20250924030219.1252773-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9979ac27520229kunm67902e9b181e88
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCS0hJVh5LHk9LSR5KHRpLGVYVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+

list_first_entry() never returns NULL — if the list is empty, it still
returns a pointer to an invalid object, leading to potential invalid
memory access when dereferenced.
The calls to list_first_entry() are always guarded by !list_empty(),
which guarantees a valid entry is returned. Therefore, the additional
`if (!p_buffer) break;` checks in qed_ooo_release_connection_isles(),
qed_ooo_release_all_isles(), and qed_ooo_free() are redundant and
unreachable.

Remove the dead code for clarity and consistency with common list
handling patterns in the kernel. No functional change intended.

Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 drivers/net/ethernet/qlogic/qed/qed_ooo.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_ooo.c b/drivers/net/ethernet/qlogic/qed/qed_ooo.c
index 5d725f59db24..8be567a6ad44 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_ooo.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_ooo.c
@@ -183,9 +183,6 @@ void qed_ooo_release_connection_isles(struct qed_hwfn *p_hwfn,
 						    struct qed_ooo_buffer,
 						    list_entry);
 
-			if (!p_buffer)
-				break;
-
 			list_move_tail(&p_buffer->list_entry,
 				       &p_ooo_info->free_buffers_list);
 		}
@@ -218,9 +215,6 @@ void qed_ooo_release_all_isles(struct qed_hwfn *p_hwfn,
 						     struct qed_ooo_buffer,
 						     list_entry);
 
-				if (!p_buffer)
-					break;
-
 				list_move_tail(&p_buffer->list_entry,
 					       &p_ooo_info->free_buffers_list);
 			}
@@ -255,9 +249,6 @@ void qed_ooo_free(struct qed_hwfn *p_hwfn)
 		p_buffer = list_first_entry(&p_ooo_info->free_buffers_list,
 					    struct qed_ooo_buffer, list_entry);
 
-		if (!p_buffer)
-			break;
-
 		list_del(&p_buffer->list_entry);
 		dma_free_coherent(&p_hwfn->cdev->pdev->dev,
 				  p_buffer->rx_buffer_size,
-- 
2.20.1


