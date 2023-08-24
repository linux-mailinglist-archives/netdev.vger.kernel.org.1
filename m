Return-Path: <netdev+bounces-30398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFCE27871EA
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A5092815C4
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 14:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E032011C86;
	Thu, 24 Aug 2023 14:39:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D71119E
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 14:39:29 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE301BC8
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:39:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id B78A51F388;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692887966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmdxDCqYzaVvw6/Q74bXrhYczR1nHD6qwmiJWKu4mPQ=;
	b=RZhNtnlwGCU8fBlO9dvSAU5miIAGD7Ynfg26OIvNR4OnwtvPT1ltgQHWuUaTwfxN/xWSz+
	n+1ImkYTRgIkdWIj9XNkYDdWZShS6EWnSQtabxiYbr/+WEomPjP8AMWAEVs0U6dBKw/EvU
	2BIeeIdtMbVNXCmaI1EMj0D4/9mu2w0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692887966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmdxDCqYzaVvw6/Q74bXrhYczR1nHD6qwmiJWKu4mPQ=;
	b=achOudVfpMdAqxgdXxjA0QvxUuqdYc97hdvlYVi2BrJOOQlEGo2NdeM1oS89KeCuvctkwf
	hux2cYKpjvPop0Dg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id AC2332C149;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id A23A251CB8BD; Thu, 24 Aug 2023 16:39:26 +0200 (CEST)
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
Subject: [PATCH 03/18] nvme: add TCP TSAS definitions
Date: Thu, 24 Aug 2023 16:39:10 +0200
Message-Id: <20230824143925.9098-4-hare@suse.de>
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

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/linux/nvme.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 26dd3f859d9d..a7ba74babad7 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -108,6 +108,13 @@ enum {
 	NVMF_RDMA_CMS_RDMA_CM	= 1, /* Sockets based endpoint addressing */
 };
 
+/* TSAS SECTYPE for TCP transport */
+enum {
+	NVMF_TCP_SECTYPE_NONE = 0, /* No Security */
+	NVMF_TCP_SECTYPE_TLS12 = 1, /* TLSv1.2, NVMe-oF 1.1 and NVMe-TCP 3.6.1.1 */
+	NVMF_TCP_SECTYPE_TLS13 = 2, /* TLSv1.3, NVMe-oF 1.1 and NVMe-TCP 3.6.1.1 */
+};
+
 #define NVME_AQ_DEPTH		32
 #define NVME_NR_AEN_COMMANDS	1
 #define NVME_AQ_BLK_MQ_DEPTH	(NVME_AQ_DEPTH - NVME_NR_AEN_COMMANDS)
@@ -1493,6 +1500,9 @@ struct nvmf_disc_rsp_page_entry {
 			__u16	pkey;
 			__u8	resv10[246];
 		} rdma;
+		struct tcp {
+			__u8	sectype;
+		} tcp;
 	} tsas;
 };
 
-- 
2.35.3


