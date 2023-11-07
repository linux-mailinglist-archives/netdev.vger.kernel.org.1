Return-Path: <netdev+bounces-46542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AFD7E4D03
	for <lists+netdev@lfdr.de>; Wed,  8 Nov 2023 00:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D8CB213A4
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 23:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A73E34564;
	Tue,  7 Nov 2023 23:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SUnM+vDY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D1B34546;
	Tue,  7 Nov 2023 23:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66E7BC43391;
	Tue,  7 Nov 2023 23:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699399481;
	bh=cXP1tE/Z8LPZSMzChOd9nya7wE7QRtTo20Hi8CLiGQo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SUnM+vDYf8OWZavIYPlvIMfw/Kbxdy4k7WFfxUphcnq0rZfhYp5EnieN9Bkm4XQ2r
	 iV7m7VA5W5oRYMT+E+j00ZxWHUaw3+mdDurQB2f2GJz3pqoJX29KKwg+LQV1cf4Tkx
	 sv+S4FZlP88cx5kk8PjxDo3B1DqiD4VnzHgx7EnAcYxhkKdqugCSj7VWtlSMrXg6mI
	 VaQW9UNkd8JC1hoQq66yfIv5ipldwSsKqWRjLOs0CJS5oKFT18sU1dlNs/8xo6ALcy
	 MCuVhlBuTn+FDQ8onc8+IPHPdElZ8570t5PcmlqYrfSVe1ISh7NBrM2giZVsNVHTVZ
	 qwo/IrI9fxZTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Su Hui <suhui@nfschina.com>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Sasha Levin <sashal@kernel.org>,
	ericvh@kernel.org,
	lucho@ionkov.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	v9fs@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 11/11] 9p: v9fs_listxattr: fix %s null argument warning
Date: Tue,  7 Nov 2023 18:24:12 -0500
Message-ID: <20231107232420.3776419-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107232420.3776419-1-sashal@kernel.org>
References: <20231107232420.3776419-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
Content-Transfer-Encoding: 8bit

From: Dominique Martinet <asmadeus@codewreck.org>

[ Upstream commit 9b5c6281838fc84683dd99b47302d81fce399918 ]

W=1 warns about null argument to kprintf:
In file included from fs/9p/xattr.c:12:
In function ‘v9fs_xattr_get’,
    inlined from ‘v9fs_listxattr’ at fs/9p/xattr.c:142:9:
include/net/9p/9p.h:55:2: error: ‘%s’ directive argument is null
[-Werror=format-overflow=]
   55 |  _p9_debug(level, __func__, fmt, ##__VA_ARGS__)
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Use an empty string instead of :
 - this is ok 9p-wise because p9pdu_vwritef serializes a null string
and an empty string the same way (one '0' word for length)
 - since this degrades the print statements, add new single quotes for
xattr's name delimter (Old: "file = (null)", new: "file = ''")

Link: https://lore.kernel.org/r/20231008060138.517057-1-suhui@nfschina.com
Suggested-by: Su Hui <suhui@nfschina.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Acked-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Message-ID: <20231025103445.1248103-2-asmadeus@codewreck.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/xattr.c   | 5 +++--
 net/9p/client.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/9p/xattr.c b/fs/9p/xattr.c
index 2807bb63f7802..3b9aa61de8c2d 100644
--- a/fs/9p/xattr.c
+++ b/fs/9p/xattr.c
@@ -65,7 +65,7 @@ ssize_t v9fs_xattr_get(struct dentry *dentry, const char *name,
 	struct p9_fid *fid;
 	int ret;
 
-	p9_debug(P9_DEBUG_VFS, "name = %s value_len = %zu\n",
+	p9_debug(P9_DEBUG_VFS, "name = '%s' value_len = %zu\n",
 		 name, buffer_size);
 	fid = v9fs_fid_lookup(dentry);
 	if (IS_ERR(fid))
@@ -136,7 +136,8 @@ int v9fs_fid_xattr_set(struct p9_fid *fid, const char *name,
 
 ssize_t v9fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 {
-	return v9fs_xattr_get(dentry, NULL, buffer, buffer_size);
+	/* Txattrwalk with an empty string lists xattrs instead */
+	return v9fs_xattr_get(dentry, "", buffer, buffer_size);
 }
 
 static int v9fs_xattr_handler_get(const struct xattr_handler *handler,
diff --git a/net/9p/client.c b/net/9p/client.c
index af59c3f2ec2e7..b86629deea438 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -1985,7 +1985,7 @@ struct p9_fid *p9_client_xattrwalk(struct p9_fid *file_fid,
 		goto error;
 	}
 	p9_debug(P9_DEBUG_9P,
-		 ">>> TXATTRWALK file_fid %d, attr_fid %d name %s\n",
+		 ">>> TXATTRWALK file_fid %d, attr_fid %d name '%s'\n",
 		 file_fid->fid, attr_fid->fid, attr_name);
 
 	req = p9_client_rpc(clnt, P9_TXATTRWALK, "dds",
-- 
2.42.0


