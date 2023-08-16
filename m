Return-Path: <netdev+bounces-28042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A41677E119
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B80602819DA
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 12:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3740411190;
	Wed, 16 Aug 2023 12:06:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21C331097D
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 12:06:28 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB1A269F
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 05:06:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 035461F8D6;
	Wed, 16 Aug 2023 12:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692187584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WhusatABSHNLPd4E/4jricI/gtUKlyK2XFGYryjo8Ic=;
	b=j7vaSkRHx3VxTEoI851cDyaoAPqQVleYqrq2R0vMqawjjZyLfYebVldP/WRiAUjJ8KiP7O
	NbXlHGUkQ9Vc5GZFPc5VDJLwv0v+FoGrxHIKyPpU+vMGTmi7PjkuCUxeK0Epjdmo/5bBUE
	UgE3hYe1PYmrYGyy3Eoqch/u6T7S5jA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692187584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WhusatABSHNLPd4E/4jricI/gtUKlyK2XFGYryjo8Ic=;
	b=EsXAqqjv17Kcdm5nJKEvy3nelivOUxr+BXX42cdeZOb6fp1VTWoEThyOtRR99MHUSymszA
	LfpotJkIHnARavBQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id D3F6D2C169;
	Wed, 16 Aug 2023 12:06:23 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id C648451CB230; Wed, 16 Aug 2023 14:06:23 +0200 (CEST)
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
Date: Wed, 16 Aug 2023 14:06:00 +0200
Message-Id: <20230816120608.37135-11-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230816120608.37135-1-hare@suse.de>
References: <20230816120608.37135-1-hare@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When icreq/icresp fails we should be printing out a warning to
inform the user that the connection could not be established;
without it there won't be anything in the kernel message log,
just an error code returned to nvme-cli.

Signed-off-by: Hannes Reinecke <hare@suse.de>
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


