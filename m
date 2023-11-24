Return-Path: <netdev+bounces-50976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB667F8691
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 00:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F55428118D
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 23:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD3F364C1;
	Fri, 24 Nov 2023 23:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from smtp.gentoo.org (mail.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0011733
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 15:08:19 -0800 (PST)
From: Sam James <sam@gentoo.org>
To: netdev@vger.kernel.org
Cc: Sam James <sam@gentoo.org>
Subject: [ethtool PATCH] netlink: fix -Walloc-size
Date: Fri, 24 Nov 2023 23:08:04 +0000
Message-ID: <20231124230810.1656050-1-sam@gentoo.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

GCC 14 introduces a new -Walloc-size included in -Wextra which gives:
```
netlink/strset.c: In function ‘get_perdev_by_ifindex’:
netlink/strset.c:121:16: warning: allocation of insufficient size ‘1’ for type ‘struct perdev_strings’ with size ‘648’ [-Walloc-size]
  121 |         perdev = calloc(sizeof(*perdev), 1);
      |                ^
```

The calloc prototype is:
```
void *calloc(size_t nmemb, size_t size);
```

So, just swap the number of members and size arguments to match the prototype, as
we're initialising 1 struct of size `sizeof(*perdev)`. GCC then sees we're not
doing anything wrong. This is consistent with other use in the codebase too.

Signed-off-by: Sam James <sam@gentoo.org>
---
 netlink/strset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/netlink/strset.c b/netlink/strset.c
index fbc9c17..949d597 100644
--- a/netlink/strset.c
+++ b/netlink/strset.c
@@ -118,7 +118,7 @@ static struct perdev_strings *get_perdev_by_ifindex(int ifindex)
 		return perdev;
 
 	/* not found, allocate and insert into list */
-	perdev = calloc(sizeof(*perdev), 1);
+	perdev = calloc(1, sizeof(*perdev));
 	if (!perdev)
 		return NULL;
 	perdev->ifindex = ifindex;
-- 
2.43.0


