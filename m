Return-Path: <netdev+bounces-30407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEE17871FD
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:43:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2378F28160C
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 14:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62AE15AD5;
	Thu, 24 Aug 2023 14:39:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EC115AD1
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 14:39:31 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692F41BC6
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:39:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id E0F4C22BD7;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692887966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/cUsfbGAK24u6aiy2ih/4OYStzXQva115ZZrjcBLV0=;
	b=DBq8XLvrz91mh02VTNU9kbglsexZFvQwCiyYePHEvTpiVTTyKjYuLOZveo4i5NJ9IWhMfr
	D/pfOHzolEwOj8mh509MJ9iAM4hJQOn7aNqScJCXBHS1Pa6mw0uvWbDJyxAfwxWFAVBV3F
	j6P/fqj7h+Gb9yr8+Vi5b0t7mfhwm3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692887966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2/cUsfbGAK24u6aiy2ih/4OYStzXQva115ZZrjcBLV0=;
	b=KXwlqLfgH19iIFoT3MSgIRgqDADVAJfpSE0goCXmk9Yxu3MrqX1bGISYgMLh3kee2PDzdt
	A0rjb+0Us7teJXCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id DA6DE2C15D;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id D68D651CB8CF; Thu, 24 Aug 2023 16:39:26 +0200 (CEST)
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
Subject: [PATCH 12/18] nvmet: make TCP sectype settable via configfs
Date: Thu, 24 Aug 2023 16:39:19 +0200
Message-Id: <20230824143925.9098-13-hare@suse.de>
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

Add a new configfs attribute 'addr_tsas' to make the TCP sectype
settable via configfs.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/configfs.c | 75 +++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 907143870da5..27a0f9c768e8 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -159,6 +159,11 @@ static const struct nvmet_type_name_map nvmet_addr_treq[] = {
 	{ NVMF_TREQ_NOT_REQUIRED,	"not required" },
 };
 
+static inline u8 nvmet_port_disc_addr_treq_mask(struct nvmet_port *port)
+{
+	return (port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK);
+}
+
 static ssize_t nvmet_addr_treq_show(struct config_item *item, char *page)
 {
 	u8 treq = to_nvmet_port(item)->disc_addr.treq &
@@ -178,7 +183,7 @@ static ssize_t nvmet_addr_treq_store(struct config_item *item,
 		const char *page, size_t count)
 {
 	struct nvmet_port *port = to_nvmet_port(item);
-	u8 treq = port->disc_addr.treq & ~NVME_TREQ_SECURE_CHANNEL_MASK;
+	u8 treq = nvmet_port_disc_addr_treq_mask(port);
 	int i;
 
 	if (nvmet_is_port_enabled(port, __func__))
@@ -303,6 +308,11 @@ static void nvmet_port_init_tsas_rdma(struct nvmet_port *port)
 	port->disc_addr.tsas.rdma.cms = NVMF_RDMA_CMS_RDMA_CM;
 }
 
+static void nvmet_port_init_tsas_tcp(struct nvmet_port *port, int sectype)
+{
+	port->disc_addr.tsas.tcp.sectype = sectype;
+}
+
 static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 		const char *page, size_t count)
 {
@@ -325,11 +335,73 @@ static ssize_t nvmet_addr_trtype_store(struct config_item *item,
 	port->disc_addr.trtype = nvmet_transport[i].type;
 	if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA)
 		nvmet_port_init_tsas_rdma(port);
+	else if (port->disc_addr.trtype == NVMF_TRTYPE_TCP)
+		nvmet_port_init_tsas_tcp(port, NVMF_TCP_SECTYPE_NONE);
 	return count;
 }
 
 CONFIGFS_ATTR(nvmet_, addr_trtype);
 
+static const struct nvmet_type_name_map nvmet_addr_tsas_tcp[] = {
+	{ NVMF_TCP_SECTYPE_NONE,	"none" },
+	{ NVMF_TCP_SECTYPE_TLS13,	"tls1.3" },
+};
+
+static const struct nvmet_type_name_map nvmet_addr_tsas_rdma[] = {
+	{ NVMF_RDMA_QPTYPE_CONNECTED,	"connected" },
+	{ NVMF_RDMA_QPTYPE_DATAGRAM,	"datagram"  },
+};
+
+static ssize_t nvmet_addr_tsas_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	int i;
+
+	if (port->disc_addr.trtype == NVMF_TRTYPE_TCP) {
+		for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_tcp); i++) {
+			if (port->disc_addr.tsas.tcp.sectype == nvmet_addr_tsas_tcp[i].type)
+				return sprintf(page, "%s\n", nvmet_addr_tsas_tcp[i].name);
+		}
+	} else if (port->disc_addr.trtype == NVMF_TRTYPE_RDMA) {
+		for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_rdma); i++) {
+			if (port->disc_addr.tsas.rdma.qptype == nvmet_addr_tsas_rdma[i].type)
+				return sprintf(page, "%s\n", nvmet_addr_tsas_rdma[i].name);
+		}
+	}
+	return sprintf(page, "reserved\n");
+}
+
+static ssize_t nvmet_addr_tsas_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	u8 sectype;
+	int i;
+
+	if (nvmet_is_port_enabled(port, __func__))
+		return -EACCES;
+
+	if (port->disc_addr.trtype != NVMF_TRTYPE_TCP)
+		return -EINVAL;
+
+	for (i = 0; i < ARRAY_SIZE(nvmet_addr_tsas_tcp); i++) {
+		if (sysfs_streq(page, nvmet_addr_tsas_tcp[i].name)) {
+			sectype = nvmet_addr_tsas_tcp[i].type;
+			goto found;
+		}
+	}
+
+	pr_err("Invalid value '%s' for tsas\n", page);
+	return -EINVAL;
+
+found:
+	nvmet_port_init_tsas_tcp(port, sectype);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_, addr_tsas);
+
 /*
  * Namespace structures & file operation functions below
  */
@@ -1741,6 +1813,7 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_addr_traddr,
 	&nvmet_attr_addr_trsvcid,
 	&nvmet_attr_addr_trtype,
+	&nvmet_attr_addr_tsas,
 	&nvmet_attr_param_inline_data_size,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_attr_param_pi_enable,
-- 
2.35.3


