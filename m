Return-Path: <netdev+bounces-246294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB91CE8E14
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 08:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 097C230141E0
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 07:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749792701D1;
	Tue, 30 Dec 2025 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="afkB0R8Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m49198.qiye.163.com (mail-m49198.qiye.163.com [45.254.49.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F056257435;
	Tue, 30 Dec 2025 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767079148; cv=none; b=b2y2KBHVjD4xOvufOx24rYONRq/seAM7oarHBlbGEb/ENrdkTpPC0OBVZmGDycLdpb6uHn6VnNXvFQE5ZoOvYQUOl/wcog8PDnuWH13+6N4N/jSV8FRiLKlMuBoxN15BKnRw4STu8uFca268GIWBDWez6bghtueXFSB3wfR20T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767079148; c=relaxed/simple;
	bh=i60Ac1aPkX2wFDohSTgrI72SpNoeWqWB74CHa1tt1fo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jyc17b8gywzw/r83WpAvZV4PlM+QLIMuiZmUG8H4hgBSJFMXmDwZdPmfY8OW7vMJ4aFnwHEqexvmf3bFtwLlsSAdUbbx3kKYLz92t8GDhqelJpFnULE4OlCK5WuKWqeG8r2lS5irHrqUOYYPu6klqCQc3MuxCpA30ZAXbBAwNB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=afkB0R8Q; arc=none smtp.client-ip=45.254.49.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Received: from LAPTOP-N070L597.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2eff75e43;
	Tue, 30 Dec 2025 15:18:56 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: loic.poulain@oss.qualcomm.com
Cc: ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zilin Guan <zilin@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH net] net: wwan: iosm: Fix memory leak in ipc_mux_deinit()
Date: Tue, 30 Dec 2025 07:18:53 +0000
Message-Id: <20251230071853.1062223-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9b6e1fcb4603a1kunm2c55fe0c1501f9
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTRofVk0aTU4fT0lDTR9DHVYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSUJDQ0xVSktLVUtZBg
	++
DKIM-Signature: a=rsa-sha256;
	b=afkB0R8QsozxuXZVDQK7R6rceTlF53t9ETjFSwLV9Vpg/TgzoWTJZ1yMlEZVwGYMMJOdTJXndpFg9cCiyyYFyYYlXViMu5B13V2EMxqAzKiIiYp1nA1tSHeflCEbFlw3AZJEjk5bUUgz5vwvItUCYu6WQmlejDKvo/dedVFUXPo=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=TN/3at7UanWd+5vS1dqDPNMWUzmg4PCweMDxZj9ZeI0=;
	h=date:mime-version:subject:message-id:from;

Commit 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
allocated memory for pp_qlt in ipc_mux_init() but did not free it in
ipc_mux_deinit(). This results in a memory leak when the driver is
unloaded.

Free the allocated memory in ipc_mux_deinit() to fix the leak.

Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
Co-developed-by: Jianhao Xu <jianhao.xu@seu.edu.cn>
Signed-off-by: Jianhao Xu <jianhao.xu@seu.edu.cn>
Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 drivers/net/wwan/iosm/iosm_ipc_mux.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wwan/iosm/iosm_ipc_mux.c b/drivers/net/wwan/iosm/iosm_ipc_mux.c
index fc928b298a98..b846889fcb09 100644
--- a/drivers/net/wwan/iosm/iosm_ipc_mux.c
+++ b/drivers/net/wwan/iosm/iosm_ipc_mux.c
@@ -456,6 +456,7 @@ void ipc_mux_deinit(struct iosm_mux *ipc_mux)
 	struct sk_buff_head *free_list;
 	union mux_msg mux_msg;
 	struct sk_buff *skb;
+	int i;
 
 	if (!ipc_mux->initialized)
 		return;
@@ -479,5 +480,10 @@ void ipc_mux_deinit(struct iosm_mux *ipc_mux)
 		ipc_mux->channel->dl_pipe.is_open = false;
 	}
 
+	if (ipc_mux->protocol != MUX_LITE) {
+		for (i = 0; i < IPC_MEM_MUX_IP_SESSION_ENTRIES; i++)
+			kfree(ipc_mux->ul_adb.pp_qlt[i]);
+	}
+
 	kfree(ipc_mux);
 }
-- 
2.34.1


