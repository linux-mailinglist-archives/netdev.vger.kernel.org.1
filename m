Return-Path: <netdev+bounces-16286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEC074C61B
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 17:26:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A3A92812BE
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328EBFBF6;
	Sun,  9 Jul 2023 15:16:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E508413AEA
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 15:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83851C433CD;
	Sun,  9 Jul 2023 15:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688915811;
	bh=nTYRnmB0100wh1J1+ZWj878exMeOb0t/OxCjUY+Jk5g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aka/h7pr7kPKpthF9zvrvKm3vCmM9w32qI/6WB3FyzFNwQZRKW5kTC7O6mkEKcdRM
	 R4vYF4coGXq1gAiWi7DCjsuMkZKsWA3adxZuzYPCSVgOg7aL2ADRn348wJnvdSgZd1
	 oGMO59zHFftCvkEdKU4HIcO8MJKWXMK1YXAiPccIp5o6TEXovvuKAACvwXglB427GT
	 SLUKdj9XiFktz2TUvF9UVytMwYPzMIfjyO/Apsv1qE//HVUKNefZ2VpN+3kJqgy17f
	 q/NP9hF/Fv9Il5umI3pX6FIplAiieoeMe3hh59NsRvHuezpcV+ylP4qnc3H6UxCyiQ
	 RQYBzchMY9OiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Simon Horman <simon.horman@corigine.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 3/4] wifi: wext-core: Fix -Wstringop-overflow warning in ioctl_standard_iw_point()
Date: Sun,  9 Jul 2023 11:16:43 -0400
Message-Id: <20230709151645.514172-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230709151645.514172-1-sashal@kernel.org>
References: <20230709151645.514172-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.320
Content-Transfer-Encoding: 8bit

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

[ Upstream commit 71e7552c90db2a2767f5c17c7ec72296b0d92061 ]

-Wstringop-overflow is legitimately warning us about extra_size
pontentially being zero at some point, hence potenially ending
up _allocating_ zero bytes of memory for extra pointer and then
trying to access such object in a call to copy_from_user().

Fix this by adding a sanity check to ensure we never end up
trying to allocate zero bytes of data for extra pointer, before
continue executing the rest of the code in the function.

Address the following -Wstringop-overflow warning seen when built
m68k architecture with allyesconfig configuration:
                 from net/wireless/wext-core.c:11:
In function '_copy_from_user',
    inlined from 'copy_from_user' at include/linux/uaccess.h:183:7,
    inlined from 'ioctl_standard_iw_point' at net/wireless/wext-core.c:825:7:
arch/m68k/include/asm/string.h:48:25: warning: '__builtin_memset' writing 1 or more bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
   48 | #define memset(d, c, n) __builtin_memset(d, c, n)
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
include/linux/uaccess.h:153:17: note: in expansion of macro 'memset'
  153 |                 memset(to + (n - res), 0, res);
      |                 ^~~~~~
In function 'kmalloc',
    inlined from 'kzalloc' at include/linux/slab.h:694:9,
    inlined from 'ioctl_standard_iw_point' at net/wireless/wext-core.c:819:10:
include/linux/slab.h:577:16: note: at offset 1 into destination object of size 0 allocated by '__kmalloc'
  577 |         return __kmalloc(size, flags);
      |                ^~~~~~~~~~~~~~~~~~~~~~

This help with the ongoing efforts to globally enable
-Wstringop-overflow.

Link: https://github.com/KSPP/linux/issues/315
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/ZItSlzvIpjdjNfd8@work
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/wext-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index b6414c7bef556..4bf33f9b28870 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -798,6 +798,12 @@ static int ioctl_standard_iw_point(struct iw_point *iwp, unsigned int cmd,
 		}
 	}
 
+	/* Sanity-check to ensure we never end up _allocating_ zero
+	 * bytes of data for extra.
+	 */
+	if (extra_size <= 0)
+		return -EFAULT;
+
 	/* kzalloc() ensures NULL-termination for essid_compat. */
 	extra = kzalloc(extra_size, GFP_KERNEL);
 	if (!extra)
-- 
2.39.2


