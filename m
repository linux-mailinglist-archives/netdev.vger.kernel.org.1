Return-Path: <netdev+bounces-30408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526487871FF
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842651C20E83
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 14:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183FC15AFE;
	Thu, 24 Aug 2023 14:39:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB6A15AFA
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 14:39:32 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D091BC8
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:39:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id D561220A07;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692887966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08A8hlWC89zG8omiABy9KmRfOn3IR7aYNER3Jue5RuU=;
	b=cplWzFk6WN/mAOCTQ1EQjlwazYXOQCYuEwB5ZpNVslkvGx4H6cMQmEA1scPkqtvG/Wj+tk
	hXz67ZktiTkDLnnVq/xV1WtQSOsfsz7M05omE1Vm4pRjIi4R0kEk7KMZfDko0JDYsVfQJv
	FuL7cZQDFtL7e8GKspNYovq4ogA0Ueo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692887966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08A8hlWC89zG8omiABy9KmRfOn3IR7aYNER3Jue5RuU=;
	b=Gig+BsXdMcUv1xMxh68uzHuBlHnsFGRLlfKdog3Yh39rgvxGjoXvR3cyVDnTy4FLQiK46E
	wSP5tLlKaL4pcMDg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id CF13E2C15B;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id CB2BC51CB8CB; Thu, 24 Aug 2023 16:39:26 +0200 (CEST)
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
Subject: [PATCH 10/18] nvme-tcp: improve icreq/icresp logging
Date: Thu, 24 Aug 2023 16:39:17 +0200
Message-Id: <20230824143925.9098-11-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230824143925.9098-1-hare@suse.de>
References: <20230824143925.9098-1-hare@suse.de>
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

When icreq/icresp fails we should be printing out a warning to
inform the user that the connection could not be established;
without it there won't be anything in the kernel message log,
just an error code returned to nvme-cli.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/tcp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index e8e408dbb6ad..ef9cf8c7a113 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1403,8 +1403,11 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	iov.iov_base = icreq;
 	iov.iov_len = sizeof(*icreq);
 	ret = kernel_sendmsg(queue->sock, &msg, &iov, 1, iov.iov_len);
-	if (ret < 0)
+	if (ret < 0) {
+		pr_warn("queue %d: failed to send icreq, error %d\n",
+			nvme_tcp_queue_id(queue), ret);
 		goto free_icresp;
+	}
 
 	memset(&msg, 0, sizeof(msg));
 	iov.iov_base = icresp;
@@ -1415,8 +1418,11 @@ static int nvme_tcp_init_connection(struct nvme_tcp_queue *queue)
 	}
 	ret = kernel_recvmsg(queue->sock, &msg, &iov, 1,
 			iov.iov_len, msg.msg_flags);
-	if (ret < 0)
+	if (ret < 0) {
+		pr_warn("queue %d: failed to receive icresp, error %d\n",
+			nvme_tcp_queue_id(queue), ret);
 		goto free_icresp;
+	}
 	if (queue->ctrl->ctrl.opts->tls) {
 		ctype = tls_get_record_type(queue->sock->sk,
 					    (struct cmsghdr *)cbuf);
-- 
2.35.3


