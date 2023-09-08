Return-Path: <netdev+bounces-32650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 818BD798E12
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 20:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B932280E38
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 18:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA7D1642B;
	Fri,  8 Sep 2023 18:19:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667FD16417
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 18:19:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F53C43395;
	Fri,  8 Sep 2023 18:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694197147;
	bh=liMbP5RMQjvARMjT61+20zvhPE+McbXIwRmdFix/leU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i6N89X5toUuB97pYw0PNV15tjpX78URPGyBsR63Kach3vARXAE9Oo9D9CPPeCIiAQ
	 NA85tsUyStoP55ijIFONhuS69vDelKLeRbrfUXV7SGPR0JrSCsu8vu3WQ31Ru7H290
	 XCSerQojIAWQLE7tbBfS1L6rmfy/tzFaXd/MFMTkdDS+S3jDBZ52RS8iKk6XFIpqXI
	 2lftNR386Fl9110t8+nnt35xXVgsjMxrRIqsDnqJlQ5D/LMlUPnsyUwOh4SIdgEcto
	 ZydZ6FOX77AVQrfVbAQSwFWsPzmiw5Zs5+zZY4mUwINNfjcqdrSjFhL2BioQFd5Q2c
	 dlvvShoXTf7GQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "GONG, Ruiqi" <gongruiqi1@huawei.com>, GONG@web.codeaurora.org,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	Kees Cook <keescook@chromium.org>, Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>, pablo@netfilter.org,
	kadlec@netfilter.org, roopa@nvidia.com, razor@blackwall.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, bridge@lists.linux-foundation.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 20/26] netfilter: ebtables: fix fortify warnings in size_entry_mwt()
Date: Fri,  8 Sep 2023 14:17:58 -0400
Message-Id: <20230908181806.3460164-20-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181806.3460164-1-sashal@kernel.org>
References: <20230908181806.3460164-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.52
Content-Transfer-Encoding: 8bit

From: "GONG, Ruiqi" <gongruiqi1@huawei.com>

[ Upstream commit a7ed3465daa240bdf01a5420f64336fee879c09d ]

When compiling with gcc 13 and CONFIG_FORTIFY_SOURCE=y, the following
warning appears:

In function ‘fortify_memcpy_chk’,
    inlined from ‘size_entry_mwt’ at net/bridge/netfilter/ebtables.c:2118:2:
./include/linux/fortify-string.h:592:25: error: call to ‘__read_overflow2_field’
declared with attribute warning: detected read beyond size of field (2nd parameter);
maybe use struct_group()? [-Werror=attribute-warning]
  592 |                         __read_overflow2_field(q_size_field, size);
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The compiler is complaining:

memcpy(&offsets[1], &entry->watchers_offset,
                       sizeof(offsets) - sizeof(offsets[0]));

where memcpy reads beyong &entry->watchers_offset to copy
{watchers,target,next}_offset altogether into offsets[]. Silence the
warning by wrapping these three up via struct_group().

Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/netfilter_bridge/ebtables.h | 14 ++++++++------
 net/bridge/netfilter/ebtables.c                |  3 +--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/netfilter_bridge/ebtables.h b/include/uapi/linux/netfilter_bridge/ebtables.h
index a494cf43a7552..b0caad82b6937 100644
--- a/include/uapi/linux/netfilter_bridge/ebtables.h
+++ b/include/uapi/linux/netfilter_bridge/ebtables.h
@@ -182,12 +182,14 @@ struct ebt_entry {
 	unsigned char sourcemsk[ETH_ALEN];
 	unsigned char destmac[ETH_ALEN];
 	unsigned char destmsk[ETH_ALEN];
-	/* sizeof ebt_entry + matches */
-	unsigned int watchers_offset;
-	/* sizeof ebt_entry + matches + watchers */
-	unsigned int target_offset;
-	/* sizeof ebt_entry + matches + watchers + target */
-	unsigned int next_offset;
+	__struct_group(/* no tag */, offsets, /* no attrs */,
+		/* sizeof ebt_entry + matches */
+		unsigned int watchers_offset;
+		/* sizeof ebt_entry + matches + watchers */
+		unsigned int target_offset;
+		/* sizeof ebt_entry + matches + watchers + target */
+		unsigned int next_offset;
+	);
 	unsigned char elems[0] __attribute__ ((aligned (__alignof__(struct ebt_replace))));
 };
 
diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 757ec46fc45a0..aa23479b20b2a 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -2115,8 +2115,7 @@ static int size_entry_mwt(const struct ebt_entry *entry, const unsigned char *ba
 		return ret;
 
 	offsets[0] = sizeof(struct ebt_entry); /* matches come first */
-	memcpy(&offsets[1], &entry->watchers_offset,
-			sizeof(offsets) - sizeof(offsets[0]));
+	memcpy(&offsets[1], &entry->offsets, sizeof(entry->offsets));
 
 	if (state->buf_kern_start) {
 		buf_start = state->buf_kern_start + state->buf_kern_offset;
-- 
2.40.1


