Return-Path: <netdev+bounces-20517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 264A775FDF6
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 19:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090F91C20BA8
	for <lists+netdev@lfdr.de>; Mon, 24 Jul 2023 17:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEDEF9F1;
	Mon, 24 Jul 2023 17:41:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB9C9466
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 17:41:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66096188
	for <netdev@vger.kernel.org>; Mon, 24 Jul 2023 10:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690220490;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j48/9P37CpBRGRsqJBOd0KCivq5UbeFFAqfa49yRMBk=;
	b=BItzssYRKgb2PptzNRUJIehA0S7BaiM0EZvK/QbfaLuvaxV33LQuEGP7UGXBgoFxp2kBQ1
	iUMCPnoDYcNsC/x3dvvOCFSGe2iUpDvFKh5kudFFhO1CAT7VVCxaH7ziPaAuEF7cWkhiy5
	Prut5ghbIE3tcCgMEpS21N5grJkFyjs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-4f5zd9PFNOuws8Q3x83PtA-1; Mon, 24 Jul 2023 13:41:25 -0400
X-MC-Unique: 4f5zd9PFNOuws8Q3x83PtA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C61062A5957E;
	Mon, 24 Jul 2023 17:41:24 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.224.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5B673400F1F;
	Mon, 24 Jul 2023 17:41:23 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: dhowells@redhat.com,
	kuba@kernel.org,
	netdev@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brauner@kernel.org,
	viro@zeniv.linux.org.uk,
	jstancek@redhat.com
Subject: [PATCH v2] splice, net: Fix splice_to_socket() for O_NONBLOCK socket
Date: Mon, 24 Jul 2023 19:39:04 +0200
Message-Id: <023c0e21e595e00b93903a813bc0bfb9a5d7e368.1690219914.git.jstancek@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

LTP sendfile07 [1], which expects sendfile() to return EAGAIN when
transferring data from regular file to a "full" O_NONBLOCK socket,
started failing after commit 2dc334f1a63a ("splice, net: Use
sendmsg(MSG_SPLICE_PAGES) rather than ->sendpage()").
sendfile() no longer immediately returns, but now blocks.

Removed sock_sendpage() handled this case by setting a MSG_DONTWAIT
flag, fix new splice_to_socket() to do the same for O_NONBLOCK sockets.

[1] https://github.com/linux-test-project/ltp/blob/master/testcases/kernel/syscalls/sendfile/sendfile07.c

Fixes: 2dc334f1a63a ("splice, net: Use sendmsg(MSG_SPLICE_PAGES) rather than ->sendpage()")
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
Changes in v2:
- add David's Acked-by
- add netdev list

 fs/splice.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/splice.c b/fs/splice.c
index 004eb1c4ce31..3e2a31e1ce6a 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -876,6 +876,8 @@ ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
 			msg.msg_flags |= MSG_MORE;
 		if (remain && pipe_occupancy(pipe->head, tail) > 0)
 			msg.msg_flags |= MSG_MORE;
+		if (out->f_flags & O_NONBLOCK)
+			msg.msg_flags |= MSG_DONTWAIT;
 
 		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, bvec, bc,
 			      len - remain);
-- 
2.31.1


