Return-Path: <netdev+bounces-30728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E046E788B4C
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 16:12:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0233A1C2109F
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 14:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070AD101DE;
	Fri, 25 Aug 2023 14:11:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE048101D2
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 14:11:49 +0000 (UTC)
Received: from out-242.mta1.migadu.com (out-242.mta1.migadu.com [IPv6:2001:41d0:203:375::f2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435572D64;
	Fri, 25 Aug 2023 07:11:31 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1692972337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mjhC+caj2gJRQH+sSsUlDYCC/6KksdCJUKl454sdMkA=;
	b=O2I4LuIVYgSn+nmzJUq/UHofHubEntakWSPFjqloiwwujETAFgWOGN3xteSPe9gSVMqAFq
	d8hRn0Wa7uhhjg2GTvasuKf8CHjMi2bI9Lkmg+s4bspXsO5Xaxy412PPH/FB0SLGDG9CfT
	9ayHr7HUCratE15Bg5Ihc+obof/8RuQ=
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
Subject: [PATCH 26/29] xfs: return -EAGAIN when nowait meets sync in transaction commit
Date: Fri, 25 Aug 2023 21:54:28 +0800
Message-Id: <20230825135431.1317785-27-hao.xu@linux.dev>
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

if the log transaction is a sync one, let's fail the nowait try and
return -EAGAIN directly since sync transaction means blocked by IO.

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 fs/xfs/xfs_trans.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 7988b4c7f36e..f1f84a3dd456 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -968,12 +968,24 @@ __xfs_trans_commit(
 	xfs_csn_t		commit_seq = 0;
 	int			error = 0;
 	int			sync = tp->t_flags & XFS_TRANS_SYNC;
+	bool			nowait = tp->t_flags & XFS_TRANS_NOWAIT;
+	bool			perm_log = tp->t_flags & XFS_TRANS_PERM_LOG_RES;
 
 	trace_xfs_trans_commit(tp, _RET_IP_);
 
+	if (nowait && sync) {
+		/*
+		 * Currently nowait is only from xfs_vn_update_time()
+		 * so perm_log is always false here, but let's make
+		 * code general.
+		 */
+		if (perm_log)
+			xfs_defer_cancel(tp);
+		goto out_unreserve;
+	}
 	error = xfs_trans_run_precommits(tp);
 	if (error) {
-		if (tp->t_flags & XFS_TRANS_PERM_LOG_RES)
+		if (perm_log)
 			xfs_defer_cancel(tp);
 		goto out_unreserve;
 	}
-- 
2.25.1


