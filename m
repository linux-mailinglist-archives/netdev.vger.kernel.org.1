Return-Path: <netdev+bounces-27326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA8477B784
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 13:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E0031C20A88
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 11:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA88C2F1;
	Mon, 14 Aug 2023 11:19:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506E0C2E8
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 11:19:59 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E4AE63
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 04:19:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 562381FD6C;
	Mon, 14 Aug 2023 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692011992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHLSrazHAERG/p1kG7eIVU0W7U8ljX+ejdLZ56VMxkQ=;
	b=AnBb7NXapDUlPCTgJvNA8KWsakKeJ3Pdi1ET1v01MZxPpr4G1MT7du6CFeyxUswgbKoxNN
	g9t6PccbEShOhf4gab1eeV1YLNkkmPgU0oebu0T4SzBDnfmdq1l363Ni4eyR8HUXJpWh75
	N8LXVgehL/F/ubmhPDE3M/PLNIeISj8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692011992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gHLSrazHAERG/p1kG7eIVU0W7U8ljX+ejdLZ56VMxkQ=;
	b=dbjVBoytG4GxENh0xxAmWyhAnhVqUwR8yIG1JEBIOStVrWbQuO7JnhqOLRLzm0culWKnhm
	CtPlbusudwdCqeBA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 439422C166;
	Mon, 14 Aug 2023 11:19:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 3FE2F51CB0DB; Mon, 14 Aug 2023 13:19:52 +0200 (CEST)
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
Subject: [PATCH 14/17] nvmet: Set 'TREQ' to 'required' when TLS is enabled
Date: Mon, 14 Aug 2023 13:19:40 +0200
Message-Id: <20230814111943.68325-15-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230814111943.68325-1-hare@suse.de>
References: <20230814111943.68325-1-hare@suse.de>
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

The current implementation does not support secure concatenation,
so 'TREQ' is always set to 'required' when TLS is enabled.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/configfs.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 53862f2c6cd1..efbfed310370 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -376,6 +376,7 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
+	u8 treq = nvmet_port_disc_addr_treq_mask(port);
 	u8 sectype;
 	int i;
 
@@ -397,6 +398,17 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 
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
 
-- 
2.35.3


