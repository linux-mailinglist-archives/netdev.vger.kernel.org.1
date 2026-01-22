Return-Path: <netdev+bounces-252251-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kEZ+GefucWlKZwAAu9opvQ
	(envelope-from <netdev+bounces-252251-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:33:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D176497E
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 906DC6095EA
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE2331AA84;
	Thu, 22 Jan 2026 09:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="iChTCjh+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297AA342537;
	Thu, 22 Jan 2026 09:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769073995; cv=none; b=fcwL9db7XkmgzFzh8BqgosjE2kMzw5ev40JAMs1Rb1za8EUYPS2oziT5TaGpUlmdYxCUIUczow/UIbDSPDAhapd9U7SjrZuuMiBelrCrJkZyawqTIhlpda1q5I52BTpu97jAXAVWQjEGZH5augeZbmxo1Z9Oh4wHvYpkk0eDeFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769073995; c=relaxed/simple;
	bh=8CoplFPWGHa9Ibpkz8FM4I6FlBU+pqo7VlobVvIuMM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N6xolrPvgQJ3jBxjlWBrAEzXcHmMXgn5U/NFdbrLiIXI1zjU9JfIaEBMfVfAbPonx1Dyup4KbuqMxSBcKxPI1zLaMKERJO0VLI62nRHWQ5NqWl05jocwVbi3by39o/Ns9lXMY64r51ySblx+GRN+xVaACgpvCLfi3dtD0XOD+z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=iChTCjh+; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 31957d05f;
	Thu, 22 Jan 2026 17:26:28 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: michael.chan@broadcom.com
Cc: pavan.chebbi@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net] bnxt_en: Fix memory leak in bnxt_alloc_mem()
Date: Thu, 22 Jan 2026 09:26:23 +0000
Message-Id: <20260122092623.479177-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9be506d22103a1kunm201ec6a5355b3
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGRgYVkIYS0MYTU5JHR8aGlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhOQ0NVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=iChTCjh+VRJ8G99fSZAYhROl2W7UK5r/i/mOKmBXIz8q8IDBQzF+Dxbx6qfVNkM1v5/9HczhkeX93nRvaZwpMiVkfiw4ViMlRPYFutUU/BKo/ss0eTYBJL5byLYyYOJtm+kobNmTWN4cg3ywKyyaySlkDt6sDPjWLSCKoD5qxhU=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=X5P+fGLQFynwYj9S/luqWkDz4jW1q7UhUPj1Bwz0IhE=;
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
	TAGGED_FROM(0.00)[bounces-252251-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[zilin@seu.edu.cn,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[seu.edu.cn,none];
	DKIM_TRACE(0.00)[seu.edu.cn:+];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,seu.edu.cn:dkim,seu.edu.cn:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 24D176497E
X-Rspamd-Action: no action

In bnxt_alloc_mem(), the function allocates memory for bp->bnapi,
bp->rx_ring, bp->tx_ring, and bp->tx_ring_map.

However, if the allocation for rx_ring, tx_ring, or tx_ring_map fails, the
function currently returns -ENOMEM directly without freeing the previously
allocated memory. This leads to a memory leak.

Fix this by jumping to the alloc_mem_err label when allocation fails,
which ensures that bnxt_free_mem() is called to properly release all
allocated resources.

Compile tested only. Issue found using a prototype static analysis tool
and code review.

Fixes: a960dec98861 ("bnxt_en: Add tx ring mapping logic.")
Fixes: b6ab4b01f53b ("bnxt_en: Separate bnxt_{rx|tx}_ring_info structs from bnxt_napi struct.")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 8419d1eb4035..99dae75146b5 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -5491,8 +5491,10 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 		bp->rx_ring = kcalloc(bp->rx_nr_rings,
 				      sizeof(struct bnxt_rx_ring_info),
 				      GFP_KERNEL);
-		if (!bp->rx_ring)
-			return -ENOMEM;
+		if (!bp->rx_ring) {
+			rc = -ENOMEM;
+			goto alloc_mem_err;
+		}
 
 		for (i = 0; i < bp->rx_nr_rings; i++) {
 			struct bnxt_rx_ring_info *rxr = &bp->rx_ring[i];
@@ -5512,14 +5514,18 @@ static int bnxt_alloc_mem(struct bnxt *bp, bool irq_re_init)
 		bp->tx_ring = kcalloc(bp->tx_nr_rings,
 				      sizeof(struct bnxt_tx_ring_info),
 				      GFP_KERNEL);
-		if (!bp->tx_ring)
-			return -ENOMEM;
+		if (!bp->tx_ring) {
+			rc = -ENOMEM;
+			goto alloc_mem_err;
+		}
 
 		bp->tx_ring_map = kcalloc(bp->tx_nr_rings, sizeof(u16),
 					  GFP_KERNEL);
 
-		if (!bp->tx_ring_map)
-			return -ENOMEM;
+		if (!bp->tx_ring_map) {
+			rc = -ENOMEM;
+			goto alloc_mem_err;
+		}
 
 		if (bp->flags & BNXT_FLAG_SHARED_RINGS)
 			j = 0;
-- 
2.34.1


