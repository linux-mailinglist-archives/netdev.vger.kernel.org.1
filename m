Return-Path: <netdev+bounces-127785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 245CE97671D
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 13:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE741F23C6F
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 11:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1337E19E962;
	Thu, 12 Sep 2024 11:01:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.213])
	by smtp.subspace.kernel.org (Postfix) with SMTP id 4526F19C54C;
	Thu, 12 Sep 2024 11:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726138906; cv=none; b=IPh1WxG0RjXdt/1qBZb6NTQOaLZhRS/9d8d/npRWmNizkGBLJclFPjbrbP84R/9tCtrUuHQARbkucdjs+JZ7WLqMtBhN79JelQBhbOIFczLZcjacn0NfTdbTgksI6PKDdezDW3gfy0SXEYOeqL0hkFy9BpcSSqIhbooYwPVMVtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726138906; c=relaxed/simple;
	bh=DOwjT7TF12kMcyCuBjmBn894pvmkAHrK1vHq8KlIlTo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ly/ry/qqhW4I7aWaP3mlrLyIZT0iWPnlQyrB3XfdMoSJix2jSzR6i7+aXFewHiTdhB1LRXEiG2NOu7FbnLcKRjeqoHvxOQFddzpX4RUMVvRFYGnNeJsaNvOyfRT3gIYtsU/jqsNyOKoMSAi9KUJOv5IWPuC4xSo3kRf4Sfv8H2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [180.167.10.98])
	by mail.nfschina.com (MailData Gateway V2.8.8) with ESMTPSA id EB8F7609E6C40;
	Thu, 12 Sep 2024 19:01:27 +0800 (CST)
X-MD-Sfrom: suhui@nfschina.com
X-MD-SrcIP: 180.167.10.98
From: Su Hui <suhui@nfschina.com>
To: jmaloy@redhat.com,
	ying.xue@windriver.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com
Cc: Su Hui <suhui@nfschina.com>,
	tuong.t.lien@dektech.com.au,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: tipc: avoid possible garbage value
Date: Thu, 12 Sep 2024 19:01:20 +0800
Message-Id: <20240912110119.2025503-1-suhui@nfschina.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clang static checker (scan-build) warning:
net/tipc/bcast.c:305:4:
The expression is an uninitialized value. The computed value will also
be garbage [core.uninitialized.Assign]
  305 |                         (*cong_link_cnt)++;
      |                         ^~~~~~~~~~~~~~~~~~

tipc_rcast_xmit() will increase cong_link_cnt's value, but cong_link_cnt
is uninitialized. Although it won't really cause a problem, it's better
to fix it.

Fixes: dca4a17d24ee ("tipc: fix potential hanging after b/rcast changing")
Signed-off-by: Su Hui <suhui@nfschina.com>
---
 net/tipc/bcast.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c
index 593846d25214..a3699be6a634 100644
--- a/net/tipc/bcast.c
+++ b/net/tipc/bcast.c
@@ -321,7 +321,7 @@ static int tipc_mcast_send_sync(struct net *net, struct sk_buff *skb,
 	struct tipc_msg *hdr, *_hdr;
 	struct sk_buff_head tmpq;
 	struct sk_buff *_skb;
-	u16 cong_link_cnt;
+	u16 cong_link_cnt = 0;
 	int rc = 0;
 
 	/* Is a cluster supporting with new capabilities ? */
-- 
2.30.2


