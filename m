Return-Path: <netdev+bounces-245965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 324BECDC3D5
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 13:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DCF5302818C
	for <lists+netdev@lfdr.de>; Wed, 24 Dec 2025 12:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E09327C17;
	Wed, 24 Dec 2025 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="MHQKE/c/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49197.qiye.163.com (mail-m49197.qiye.163.com [45.254.49.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214142F84F;
	Wed, 24 Dec 2025 12:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766579735; cv=none; b=jzqFInfHeLKfRS8qCZXogkSlbedjQErHnMTrRDmowumdoGUefrCsO/3EzA/6NfKmK6/E/v031m1f/nzAXhnSQa8A2WJhFQCO7XIjwshmPCo10VJ3/hw2PUzHdmEatpSO0/pCb4PY64v6wcaJzaAUR4kyE78qTM2hDSP313xm4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766579735; c=relaxed/simple;
	bh=n0TUyQ88t2zEDFDRo7TSNXzoURYOgo8bDbBhrr4v0FU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GlsFCP4a6iAfWIYHGZR/Y4L4MyuLtdUiO9Z3DiXVtOlHjWTmxpKZW7pGRTokUxGihL0hRCaTO02iYVJTUuNMPuEDuLZGo41g11u9pGEMOnxqpjCMLNy5fPHFn+Ule/kLw0Jn6AAx7gJ/Qraw1XpV7Mbqezv36+k4PQhaKmXrsqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=MHQKE/c/; arc=none smtp.client-ip=45.254.49.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2e6db1bad;
	Wed, 24 Dec 2025 20:35:20 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: dhowells@redhat.com
Cc: marc.dionne@auristor.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-afs@lists.infradead.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH net] rxrpc: Fix memory leak in rxkad_verify_response()
Date: Wed, 24 Dec 2025 12:35:13 +0000
Message-Id: <20251224123513.180257-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b505b4efd03a1kunmffb979a84781c6
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDHR9PVk5JGElDQkMdHRpISlYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=MHQKE/c/ligzkyzx+YcbeOq5vbcUxNdtbxd2wNtEp91JvBWDOpoqiQDDJjqJC7B99x4Z5lciZLuE/WGJ4jPDlq1FUXvZ4xigVdPsBW6q7W+DLA7FuRHnUxsT/Ugz+uvROMLKHdlTVEjcUDDLFeEPNuz7EdRR0Zv+06cF4mtmOSM=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=xZNEwq1Bk/l6495LwNjU02FdOYUnjs4H6Csp8gztHYo=;
	h=date:mime-version:subject:message-id:from;

In rxkad_verify_response(), if skb_copy_bits() fails, the function jumps to
the protocol_error label without freeing the allocated ticket, leading to
a memory leak.

Fix this by jumping to the protocol_error_free label to ensure the ticket
is freed.

Fixes: 57af281e5389b ("rxrpc: Tidy up abort generation infrastructure")
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 net/rxrpc/rxkad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 3657c0661cdc..4679c2be4235 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -1184,7 +1184,7 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 			  ticket, ticket_len) < 0) {
 		rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
 				 rxkad_abort_resp_short_tkt);
-		goto protocol_error;
+		goto protocol_error_free;
 	}
 
 	ret = rxkad_decrypt_ticket(conn, server_key, skb, ticket, ticket_len,
-- 
2.34.1


