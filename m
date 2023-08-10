Return-Path: <netdev+bounces-26418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D33E777BA9
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 17:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58DA82820FE
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D837D20CAC;
	Thu, 10 Aug 2023 15:06:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE04120CA5
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 15:06:43 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9784E26B5
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:06:42 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id F378D1F74B;
	Thu, 10 Aug 2023 15:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1691680001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Va1veEwDpJUEh5ATScwAqKgDyPffWib9gL4y5XoXAQc=;
	b=hjc/NwfHFX5OLMTWu2fiOwlz1r4uLUKELKTtVGSoP6Us1Kb/uP62H2jh/P2kl5ExrDK1iI
	9KuwzMHTZW8aTEs2UxV18jNT3M1qtod9yVEnFe7MZLM/ZsJFx1hBwoLXi57lN+NOKLOgMI
	HxoRnjwIOaRv08po9CQJIM2krQNjTj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1691680001;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Va1veEwDpJUEh5ATScwAqKgDyPffWib9gL4y5XoXAQc=;
	b=DrrRFv+lYo9sbGNsd2hAcdG0Q333613fcgoMcdC1h6DineVSr5TVRL1eMJpyPeZEjL0ZgP
	ve2waINLKso+9DDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 001512C152;
	Thu, 10 Aug 2023 15:06:39 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id E1E4251CAE44; Thu, 10 Aug 2023 17:06:39 +0200 (CEST)
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
Subject: [PATCH 04/17] nvme-tcp: add definitions for TLS cipher suites
Date: Thu, 10 Aug 2023 17:06:17 +0200
Message-Id: <20230810150630.134991-5-hare@suse.de>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 include/linux/nvme-tcp.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/nvme-tcp.h b/include/linux/nvme-tcp.h
index 57ebe1267f7f..e07e8978d691 100644
--- a/include/linux/nvme-tcp.h
+++ b/include/linux/nvme-tcp.h
@@ -18,6 +18,12 @@ enum nvme_tcp_pfv {
 	NVME_TCP_PFV_1_0 = 0x0,
 };
 
+enum nvme_tcp_tls_cipher {
+	NVME_TCP_TLS_CIPHER_INVALID     = 0,
+	NVME_TCP_TLS_CIPHER_SHA256      = 1,
+	NVME_TCP_TLS_CIPHER_SHA384      = 2,
+};
+
 enum nvme_tcp_fatal_error_status {
 	NVME_TCP_FES_INVALID_PDU_HDR		= 0x01,
 	NVME_TCP_FES_PDU_SEQ_ERR		= 0x02,
-- 
2.35.3


