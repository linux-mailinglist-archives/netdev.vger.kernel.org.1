Return-Path: <netdev+bounces-234113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAAFC1C914
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 18:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D02FF4E289F
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 17:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DF0354704;
	Wed, 29 Oct 2025 17:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIgaQFYq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962EB3546F1
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761759973; cv=none; b=H3Xyrtj6mHJJbMs/35VgWaYBzer035udH+6np8127tzLEVWDSqeK1oSXXWLcQBEk0w7zgyrbaaCzwa1/aS1MFsehJvB3Sigdm5+QFgGaLiN54TTGbw7xRkaPEQjRwRjn17/Yjf+agEbJAhHiHMOWmDqiCUJYXUQ/oJ8UOOyYjaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761759973; c=relaxed/simple;
	bh=wXBxpM5Cpm0B2MGpppxOJWRLNhJo3u7lt2LKE0ZIJZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B8ovJM9K35KjcOXPJSYqgaQvKerAYN8XWjyeDkAIEF+pOvXtqd2TNJ68+ZMnnE0C1kOHjPZWIwfgemslb228s/ndOdkFSGLciqurspVcAJQUBhpws+pojPWNNT1TdpvbqTS3BNhFp7n4Vr2JiW1KSeE5y355zzAopRLhgI8qf2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIgaQFYq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2510C4CEF7;
	Wed, 29 Oct 2025 17:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761759971;
	bh=wXBxpM5Cpm0B2MGpppxOJWRLNhJo3u7lt2LKE0ZIJZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aIgaQFYq8l9GbfIRsLWsxEMlwsutW9jqzZ0I38FNz5EJd36fNQF36rmSquJ+3lpZc
	 TCFEKt7AWs8XaQNrb8Y1CDCf9tjdgvgzrF/zQ0CS5FB+/m4mi+8wdDAvSVcHLcZ/Wr
	 myJj5MliH4pkNmdjmplKays4/n09pZG3k0c85RQtMsyEbKtaDHoVAH1x1Gld/4H4JC
	 V9uiiped0CpisyEegLeGJMwvjietY6jwd9jBkhWxR7GpFGDgPPwyrlhElumCEEXvDb
	 veCsoAGBgHSmCXUKN9ut2STSf/F/940niosAxuOlnVusBwmJ9q5snx9aFpmBaPNaYY
	 JdsBl0GL+fGug==
From: Allison Henderson <achender@kernel.org>
To: netdev@vger.kernel.org
Cc: allison.henderson@oracle.com
Subject: [PATCH net-next v1 2/2] net/rds: Give each connection its own workqueue
Date: Wed, 29 Oct 2025 10:46:09 -0700
Message-ID: <20251029174609.33778-3-achender@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251029174609.33778-1-achender@kernel.org>
References: <20251029174609.33778-1-achender@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Allison Henderson <allison.henderson@oracle.com>

RDS was written to require ordered workqueues for "cp->cp_wq":
Work is executed in the order scheduled, one item at a time.

If these workqueues are shared across connections,
then work executed on behalf of one connection blocks work
scheduled for a different and unrelated connection.

Luckily we don't need to share these workqueues.
While it obviously makes sense to limit the number of
workers (processes) that ought to be allocated on a system,
a workqueue that doesn't have a rescue worker attached,
has a tiny footprint compared to the connection as a whole:
A workqueue costs ~800 bytes, while an RDS/IB connection
totals ~5 MBytes.

So we're getting a signficant performance gain
(90% of connections fail over under 3 seconds vs. 40%)
for a less than 0.02% overhead.

RDS doesn't even benefit from the additional rescue workers:
of all the reasons that RDS blocks workers, allocation under
memory pressue is the least of our concerns.
And even if RDS was stalling due to the memory-reclaim process,
the work executed by the rescue workers are highly unlikely
to free up any memory.
If anything, they might try to allocate even more.

By giving each connection its own workqueues, we allow RDS
to better utilize the unbound workers that the system
has available.

Signed-off-by: Somasundaram Krishnasamy <somasundaram.krishnasamy@oracle.com>
Signed-off-by: Allison Henderson <allison.henderson@oracle.com>
---
 net/rds/connection.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/rds/connection.c b/net/rds/connection.c
index dc7323707f450..ac555f02c045e 100644
--- a/net/rds/connection.c
+++ b/net/rds/connection.c
@@ -269,7 +269,14 @@ static struct rds_connection *__rds_conn_create(struct net *net,
 		__rds_conn_path_init(conn, &conn->c_path[i],
 				     is_outgoing);
 		conn->c_path[i].cp_index = i;
-		conn->c_path[i].cp_wq = rds_wq;
+		conn->c_path[i].cp_wq = alloc_ordered_workqueue("krds_cp_wq#%lu/%d", 0,
+								rds_conn_count, i);
+		if (!conn->c_path[i].cp_wq) {
+			while (--i >= 0)
+				destroy_workqueue(conn->c_path[i].cp_wq);
+			conn = ERR_PTR(-ENOMEM);
+			goto out;
+		}
 	}
 	rcu_read_lock();
 	if (rds_destroy_pending(conn))
@@ -471,6 +478,9 @@ static void rds_conn_path_destroy(struct rds_conn_path *cp)
 	WARN_ON(work_pending(&cp->cp_down_w));
 
 	cp->cp_conn->c_trans->conn_free(cp->cp_transport_data);
+
+	destroy_workqueue(cp->cp_wq);
+	cp->cp_wq = NULL;
 }
 
 /*
-- 
2.43.0


