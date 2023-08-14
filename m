Return-Path: <netdev+bounces-27317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE31577B777
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 13:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119121C209EA
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 11:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EF4BE7C;
	Mon, 14 Aug 2023 11:19:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0CEBE77
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 11:19:57 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B5710C1
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 04:19:53 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 18A241FD65;
	Mon, 14 Aug 2023 11:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692011992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oa36kjhIvJTxwAHm0GK8Afk1tL9+tuRbCuSsAg+bQ6g=;
	b=xWzjE64x1yNNPA6D3RKCnEvKBPenZCqqwGs1ZU6nuLv/s7kzotSKGaXngd1SDi/9SVIUPj
	PLYLBuAJbQiAI8CEZv3VFeJxDceS4xCVKw8c26a+1Z/9Rx77qLXkDtS56SQMmufpCWx5sy
	Y8ievU/LOs/7XUICYpQmZk9dtcBHOpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692011992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oa36kjhIvJTxwAHm0GK8Afk1tL9+tuRbCuSsAg+bQ6g=;
	b=i261aYXta3BXMVFOqu7A9Q2WkmreVfKSGL0Pl35BHMH2lttkjxKA2DrhHi1P4r0FJEpmes
	1EUISDuH01r5brCg==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 05AEC2C15B;
	Mon, 14 Aug 2023 11:19:52 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id E9CDC51CB0C9; Mon, 14 Aug 2023 13:19:51 +0200 (CEST)
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
Subject: [PATCH 05/17] nvme-keyring: implement nvme_tls_psk_default()
Date: Mon, 14 Aug 2023 13:19:31 +0200
Message-Id: <20230814111943.68325-6-hare@suse.de>
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
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Implement a function to select the preferred PSK for TLS.
A 'retained' PSK should be preferred over a 'generated' PSK,
and SHA-384 should be preferred to SHA-256.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/keyring.c | 48 +++++++++++++++++++++++++++++++++++
 include/linux/nvme-keyring.h  |  8 ++++++
 2 files changed, 56 insertions(+)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 494dd365052e..f8d9a208397b 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -5,6 +5,7 @@
 
 #include <linux/module.h>
 #include <linux/seq_file.h>
+#include <linux/key.h>
 #include <linux/key-type.h>
 #include <keys/user-type.h>
 #include <linux/nvme.h>
@@ -103,6 +104,53 @@ static struct key *nvme_tls_psk_lookup(struct key *keyring,
 	return key_ref_to_ptr(keyref);
 }
 
+/*
+ * NVMe PSK priority list
+ *
+ * 'Retained' PSKs (ie 'generated == false')
+ * should be preferred to 'generated' PSKs,
+ * and SHA-384 should be preferred to SHA-256.
+ */
+struct nvme_tls_psk_priority_list {
+	bool generated;
+	enum nvme_tcp_tls_cipher cipher;
+} nvme_tls_psk_prio[] = {
+	{ .generated = false,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
+	{ .generated = false,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
+	{ .generated = true,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA384, },
+	{ .generated = true,
+	  .cipher = NVME_TCP_TLS_CIPHER_SHA256, },
+};
+
+/*
+ * nvme_tls_psk_default - Return the preferred PSK to use for TLS ClientHello
+ */
+key_serial_t nvme_tls_psk_default(struct key *keyring,
+		      const char *hostnqn, const char *subnqn)
+{
+	struct key *tls_key;
+	key_serial_t tls_key_id;
+	int prio;
+
+	for (prio = 0; prio < ARRAY_SIZE(nvme_tls_psk_prio); prio++) {
+		bool generated = nvme_tls_psk_prio[prio].generated;
+		enum nvme_tcp_tls_cipher cipher = nvme_tls_psk_prio[prio].cipher;
+
+		tls_key = nvme_tls_psk_lookup(keyring, hostnqn, subnqn,
+					      cipher, generated);
+		if (!IS_ERR(tls_key)) {
+			tls_key_id = tls_key->serial;
+			key_put(tls_key);
+			return tls_key_id;
+		}
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_tls_psk_default);
+
 int nvme_keyring_init(void)
 {
 	int err;
diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index 32bd264a71e6..4efea9dd967c 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -8,12 +8,20 @@
 
 #ifdef CONFIG_NVME_KEYRING
 
+key_serial_t nvme_tls_psk_default(struct key *keyring,
+		const char *hostnqn, const char *subnqn);
+
 key_serial_t nvme_keyring_id(void);
 int nvme_keyring_init(void);
 void nvme_keyring_exit(void);
 
 #else
 
+static inline key_serial_t nvme_tls_psk_default(struct key *keyring,
+		const char *hostnqn, const char *subnqn)
+{
+	return 0;
+}
 static inline key_serial_t nvme_keyring_id(void)
 {
 	return 0;
-- 
2.35.3


