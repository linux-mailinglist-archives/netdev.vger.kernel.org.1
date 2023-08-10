Return-Path: <netdev+bounces-26433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82040777BCD
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B460B1C21672
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A797A21D5E;
	Thu, 10 Aug 2023 15:06:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E8321D38
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:06:46 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0393D270A
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:06:45 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 2A1DD1F892;
	Thu, 10 Aug 2023 15:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691680001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqBwO+J3t2qylfSRQkB5FK/tZ2zNypcUL7n1uVdZoNc=;
	b=hVIa6uec6LeNivn12lnM+F/8xLLfFiXf+xL6G2xS6bm9An9cbDT+fRzje/Pq+H8cqK4sqQ
	JimHdHqEjMiFxWu4T9LSfqlu2SzNh7WD+zSoiC4OV4FagMfowLCnctEezMhu1B2ERNI0TB
	4xSdT7/xil4G74CT/wcAvRd0q7/+34Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691680001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TqBwO+J3t2qylfSRQkB5FK/tZ2zNypcUL7n1uVdZoNc=;
	b=QIypjNr5be56voYmiWcxXgsPdboltcJgrQMsY9CE834sxHeC8EWP3so0XQWUm0eld6x7m3
	cp2vE36P3HhQHlAA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 03B3A2C15F;
	Thu, 10 Aug 2023 15:06:41 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 30CFC51CAE54; Thu, 10 Aug 2023 17:06:40 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 12/17] nvmet-tcp: make nvmet_tcp_alloc_queue() a void function
Date: Thu, 10 Aug 2023 17:06:25 +0200
Message-Id: <20230810150630.134991-13-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810150630.134991-1-hare@suse.de>
References: <20230810150630.134991-1-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The return value from nvmet_tcp_alloc_queue() are just used to
figure out if sock_release() need to be called. So this patch
moves sock_release() into nvmet_tcp_alloc_queue() and make it
a void function.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/tcp.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 97d07488072d..4d573c3bbd62 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1621,7 +1621,7 @@ static int nvmet_tcp_set_queue_sock(struct nvmet_tcp_queue *queue)
 	return ret;
 }
 
-static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
+static void nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 		struct socket *newsock)
 {
 	struct nvmet_tcp_queue *queue;
@@ -1629,7 +1629,7 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 
 	queue = kzalloc(sizeof(*queue), GFP_KERNEL);
 	if (!queue)
-		return -ENOMEM;
+		goto out_release;
 
 	INIT_WORK(&queue->release_work, nvmet_tcp_release_queue_work);
 	INIT_WORK(&queue->io_work, nvmet_tcp_io_work);
@@ -1666,7 +1666,7 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	if (ret)
 		goto out_destroy_sq;
 
-	return 0;
+	return;
 out_destroy_sq:
 	mutex_lock(&nvmet_tcp_queue_mutex);
 	list_del_init(&queue->queue_list);
@@ -1678,7 +1678,9 @@ static int nvmet_tcp_alloc_queue(struct nvmet_tcp_port *port,
 	ida_free(&nvmet_tcp_queue_ida, queue->idx);
 out_free_queue:
 	kfree(queue);
-	return ret;
+out_release:
+	pr_err("failed to allocate queue\n");
+	sock_release(newsock);
 }
 
 static void nvmet_tcp_accept_work(struct work_struct *w)
@@ -1695,11 +1697,7 @@ static void nvmet_tcp_accept_work(struct work_struct *w)
 				pr_warn("failed to accept err=%d\n", ret);
 			return;
 		}
-		ret = nvmet_tcp_alloc_queue(port, newsock);
-		if (ret) {
-			pr_err("failed to allocate queue\n");
-			sock_release(newsock);
-		}
+		nvmet_tcp_alloc_queue(port, newsock);
 	}
 }
 
-- 
2.35.3


