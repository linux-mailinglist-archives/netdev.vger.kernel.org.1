Return-Path: <netdev+bounces-212428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6363EB203DE
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 11:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F13C4248CF
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 09:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5DF421D3E6;
	Mon, 11 Aug 2025 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QmOrpa72"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4017219A9B
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754904934; cv=none; b=Gn+0AkD2FOavkJopHu93hTK4eu1qmfJ47mp9Gk8fiObv00uvcrKdEor7pixVjNsF+k6nByjSmi84KNKGjR9DvmZP2v3XwisYIkQwE0cDQPFgB6ri81A38WdFxiL+OS1NropbpQl4YZO/s5kyeZod7tuOiYrRSGDIwDPASKhl/uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754904934; c=relaxed/simple;
	bh=N5OBK83I6BMc5+G4FWzZ69mcWguLo+tCMMtgMyyBQuw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rzWmxF77BTGZDLwJYHkQBdibpVoRK983aggCqSCDwGA2nWvNC2z7+v5wY9IWHTRlzlx+UzLG1DRxv2vc2LOBeHR8QR4GMbwhLMoWJbiYfGKJ2j4eWzaca04yBPdQR6b4lHXtkjpA42F0Z7psTiWSZP+iBRXN+YUmANp0QwqgYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QmOrpa72; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754904918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yTqGLRCADO0VrcQ5UXFXw61pDkrPUQFqQTnjcLtaKTE=;
	b=QmOrpa72t06MF56gnq/SF/qj5ZPu0xxy2ibfwIXBtV3lc2LuNj3MsUciBkfDZJBwoCxflZ
	ch78fpo8G8pQAk9EorPnsPH+rEWj77qQAcgET+/KHmErmKVtBq6Ik3VFQNCGG70ep7fDq4
	rJ8WWWVoLe0iz2uvmnPJHAN56LwrxAk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] caif: Replace memset(0) + strscpy() with strscpy_pad()
Date: Mon, 11 Aug 2025 11:34:40 +0200
Message-ID: <20250811093442.5075-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace memset(0) followed by strscpy() with strscpy_pad() to improve
cfctrl_linkup_request(). This avoids zeroing the memory before copying
the string and ensures the destination buffer is only written to once,
simplifying the code and improving efficiency.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/caif/cfctrl.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
index 06b604cf9d58..2aa1e7d46eb2 100644
--- a/net/caif/cfctrl.c
+++ b/net/caif/cfctrl.c
@@ -257,9 +257,7 @@ int cfctrl_linkup_request(struct cflayer *layer,
 		cfpkt_add_body(pkt, &tmp16, 2);
 		tmp16 = cpu_to_le16(param->u.utility.fifosize_bufs);
 		cfpkt_add_body(pkt, &tmp16, 2);
-		memset(utility_name, 0, sizeof(utility_name));
-		strscpy(utility_name, param->u.utility.name,
-			UTILITY_NAME_LENGTH);
+		strscpy_pad(utility_name, param->u.utility.name);
 		cfpkt_add_body(pkt, utility_name, UTILITY_NAME_LENGTH);
 		tmp8 = param->u.utility.paramlen;
 		cfpkt_add_body(pkt, &tmp8, 1);
-- 
2.50.1


