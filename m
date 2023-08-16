Return-Path: <netdev+bounces-28048-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D366677E12A
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE2B1C2037B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5FA14F88;
	Wed, 16 Aug 2023 12:06:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907D714A93
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 12:06:29 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5742F2133
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 05:06:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 1EF6321979;
	Wed, 16 Aug 2023 12:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692187584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUNSXIhjiSKp2ogissRH1lWVegNQ9weINYXrmPdcKjc=;
	b=eEr2EHLRChhUab8iCQuvobsNjWh2PWKZrE+ixKHDVNQoD/ZH3vS1z294OikeiZib0VlGe+
	TepFMVxjErtGtKsYEWrb57OrBZjL4dnPIStVeowu1pCJuEB9pgnY4zebgtNabKUDQvi0ha
	7xOo6FtxkYsHT4KQEFhvZ3OIq135f1Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692187584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CUNSXIhjiSKp2ogissRH1lWVegNQ9weINYXrmPdcKjc=;
	b=G2l1wwDdBBww6S1OpzUtIiXCRJPcBHghtrLkPdlW1bF22mqn1FuPn08ZRmWqtlEiJSdUKy
	OdAt/6eihsbl1/CA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 01CB82C172;
	Wed, 16 Aug 2023 12:06:23 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id F053951CB23A; Wed, 16 Aug 2023 14:06:23 +0200 (CEST)
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
Subject: [PATCH 15/18] nvmet: Set 'TREQ' to 'required' when TLS is enabled
Date: Wed, 16 Aug 2023 14:06:05 +0200
Message-Id: <20230816120608.37135-16-hare@suse.de>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The current implementation does not support secure concatenation,
so 'TREQ' is always set to 'required' when TLS is enabled.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/configfs.c | 15 +++++++++++++--
 drivers/nvme/target/nvmet.h    |  5 +++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 27a0f9c768e8..483569c3f622 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -166,8 +166,7 @@ static inline u8 nvmet_port_disc_addr_treq_mask(struct nvmet_port *port)
 
 static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
 {
-	u8 treq = to_nvmet_port(item)->disc_addr.treq &
-		NVME_TREQ_SECURE_CHANNEL_MASK;
+	u8 treq = nvmet_port_disc_addr_treq_secure_channel(to_nvmet_port(item));
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(nvmet_addr_treq); i++) {
@@ -376,6 +375,7 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	u8 treq = nvmet_port_disc_addr_treq_mask(port);
 	u8 sectype;
 	int i;
 
@@ -397,6 +397,17 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 
 found:
 	nvmet_port_init_tsas_tcp(port, sectype);
+	/*
+	 * The TLS implementation currently does not support
+	 * secure concatenation, so TREQ is always set to 'required'
+	 * if TLS is enabled.
+	 */
+	if (sectype == NVMF_TCP_SECTYPE_TLS13) {
+		treq |= NVMF_TREQ_REQUIRED;
+	} else {
+		treq |= NVMF_TREQ_NOT_SPECIFIED;
+	}
+	port->disc_addr.treq = treq;
 	return count;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8cfd60f3b564..87da62e4b743 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -178,6 +178,11 @@ static inline struct nvmet_port *ana_groups_to_port(
 			ana_groups_group);
 }
 
+static inline u8 nvmet_port_disc_addr_treq_secure_channel(struct nvmet_port *port)
+{
+	return (port->disc_addr.treq & NVME_TREQ_SECURE_CHANNEL_MASK);
+}
+
 struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
 	struct nvmet_sq		**sqs;
-- 
2.35.3


