Return-Path: <netdev+bounces-30709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5FF6788A0A
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 16:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68101C21093
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 14:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F52FBFC;
	Fri, 25 Aug 2023 14:02:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49498101D4
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:02:25 +0000 (UTC)
Received: from out-242.mta1.migadu.com (out-242.mta1.migadu.com [95.215.58.242])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB31272D;
	Fri, 25 Aug 2023 07:02:02 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692972120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d4c4JLcaw2hXejiOrGnFBQPVU2RM5hO/J+/aXcCYNEw=;
	b=khe71NuAofqjJQcQBQh8qaSLQW5l+ABTZSFJ8Vvkem+VJ7Uz3lPnhsRbG1QiQpVIB0WzKu
	TWSkBSbRJUjuC3LbOfeO0WhIFxiibQKBlsbXK8GLa0a537NlmAJDnBgPGmvzDTS140+5t+
	gKh3+G5l/F0DpREKKRmtO+kz90FC86s=
From: Hao Xu <hao.xu@linux.dev>
To: io-uring@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Cc: Dominique Martinet <asmadeus@codewreck.org>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Stefan Roesch <shr@fb.com>,
	Clay Harris <bugs@claycon.org>,
	Dave Chinner <david@fromorbit.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-cachefs@redhat.com,
	ecryptfs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	codalist@coda.cs.cmu.edu,
	linux-f2fs-devel@lists.sourceforge.net,
	cluster-devel@redhat.com,
	linux-mm@kvack.org,
	linux-nilfs@vger.kernel.org,
	devel@lists.orangefs.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	linux-mtd@lists.infradead.org,
	Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH 15/29] xfs: don't wait for free space in xlog_grant_head_check() in nowait case
Date: Fri, 25 Aug 2023 21:54:17 +0800
Message-Id: <20230825135431.1317785-16-hao.xu@linux.dev>
In-Reply-To: <20230825135431.1317785-1-hao.xu@linux.dev>
References: <20230825135431.1317785-1-hao.xu@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Hao Xu <howeyxu@tencent.com>

Don't sleep and wait for more space for a log ticket in
xlog_grant_head_check() when it is in nowait case.

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 fs/xfs/xfs_log.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 90fbb1c0eca2..a2aabdd42a29 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -341,7 +341,8 @@ xlog_grant_head_check(
 	struct xlog		*log,
 	struct xlog_grant_head	*head,
 	struct xlog_ticket	*tic,
-	int			*need_bytes)
+	int			*need_bytes,
+	bool			nowait)
 {
 	int			free_bytes;
 	int			error = 0;
@@ -360,13 +361,15 @@ xlog_grant_head_check(
 		spin_lock(&head->lock);
 		if (!xlog_grant_head_wake(log, head, &free_bytes) ||
 		    free_bytes < *need_bytes) {
-			error = xlog_grant_head_wait(log, head, tic,
-						     *need_bytes);
+			error = nowait ?
+				-EAGAIN : xlog_grant_head_wait(log, head, tic,
+							       *need_bytes);
 		}
 		spin_unlock(&head->lock);
 	} else if (free_bytes < *need_bytes) {
 		spin_lock(&head->lock);
-		error = xlog_grant_head_wait(log, head, tic, *need_bytes);
+		error = nowait ? -EAGAIN : xlog_grant_head_wait(log, head, tic,
+								*need_bytes);
 		spin_unlock(&head->lock);
 	}
 
@@ -428,7 +431,7 @@ xfs_log_regrant(
 	trace_xfs_log_regrant(log, tic);
 
 	error = xlog_grant_head_check(log, &log->l_write_head, tic,
-				      &need_bytes);
+				      &need_bytes, false);
 	if (error)
 		goto out_error;
 
@@ -487,7 +490,7 @@ xfs_log_reserve(
 	trace_xfs_log_reserve(log, tic);
 
 	error = xlog_grant_head_check(log, &log->l_reserve_head, tic,
-				      &need_bytes);
+				      &need_bytes, nowait);
 	if (error)
 		goto out_error;
 
-- 
2.25.1


