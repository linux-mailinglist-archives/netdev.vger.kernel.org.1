Return-Path: <netdev+bounces-30397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEF27871E4
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 16:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC49E1C20EB9
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 14:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61AA10979;
	Thu, 24 Aug 2023 14:39:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A439288EC
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 14:39:29 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CDC1BC6
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 07:39:28 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id B2184224EE;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1692887966; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJedWcfmoMMiDpU3S5/ZkLEN/lbkR52H+V7ZHgteZ9k=;
	b=mgTbI3jJHdabzKLiUL3Z8Qvb58ltzddM68FjRnDMXJxIGlRIMoGiaX7wK9KQ6jnqBj8jOW
	jstPfAk1T5wBTVFQJUM2iFFjk6E2dLMCFioef7w0gGke2z+BjD2PijcWszMOOShSIBoE54
	Kf0l7xRPhK2oSZcmlnnve3R5Uw1hXyU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1692887966;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dJedWcfmoMMiDpU3S5/ZkLEN/lbkR52H+V7ZHgteZ9k=;
	b=pk+cnWuUATOIDrZBdmXpnFTAvv5UFjAjYDfd+YnsDKbzw6DlRAbV1rd9xN1tORxzc3W2r7
	1UZPxR5q/Jj6oUDQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id A81F02C146;
	Thu, 24 Aug 2023 14:39:26 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 9D98651CB8BB; Thu, 24 Aug 2023 16:39:26 +0200 (CEST)
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
Subject: [PATCH 02/18] nvme-keyring: define a 'psk' keytype
Date: Thu, 24 Aug 2023 16:39:09 +0200
Message-Id: <20230824143925.9098-3-hare@suse.de>
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

Define a 'psk' keytype to hold the NVMe TLS PSKs.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/common/keyring.c | 94 +++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index 5cf64b278119..494dd365052e 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -8,6 +8,8 @@
 #include <linux/key-type.h>
 #include <keys/user-type.h>
 #include <linux/nvme.h>
+#include <linux/nvme-tcp.h>
+#include <linux/nvme-keyring.h>
 
 static struct key *nvme_keyring;
 
@@ -17,8 +19,94 @@ key_serial_t nvme_keyring_id(void)
 }
 EXPORT_SYMBOL_GPL(nvme_keyring_id);
 
+static void nvme_tls_psk_describe(const struct key *key, struct seq_file *m)
+{
+	seq_puts(m, key->description);
+	seq_printf(m, ": %u", key->datalen);
+}
+
+static bool nvme_tls_psk_match(const struct key *key,
+			       const struct key_match_data *match_data)
+{
+	const char *match_id;
+	size_t match_len;
+
+	if (!key->description) {
+		pr_debug("%s: no key description\n", __func__);
+		return false;
+	}
+	match_len = strlen(key->description);
+	pr_debug("%s: id %s len %zd\n", __func__, key->description, match_len);
+
+	if (!match_data->raw_data) {
+		pr_debug("%s: no match data\n", __func__);
+		return false;
+	}
+	match_id = match_data->raw_data;
+	pr_debug("%s: match '%s' '%s' len %zd\n",
+		 __func__, match_id, key->description, match_len);
+	return !memcmp(key->description, match_id, match_len);
+}
+
+static int nvme_tls_psk_match_preparse(struct key_match_data *match_data)
+{
+	match_data->lookup_type = KEYRING_SEARCH_LOOKUP_ITERATE;
+	match_data->cmp = nvme_tls_psk_match;
+	return 0;
+}
+
+static struct key_type nvme_tls_psk_key_type = {
+	.name           = "psk",
+	.flags          = KEY_TYPE_NET_DOMAIN,
+	.preparse       = user_preparse,
+	.free_preparse  = user_free_preparse,
+	.match_preparse = nvme_tls_psk_match_preparse,
+	.instantiate    = generic_key_instantiate,
+	.revoke         = user_revoke,
+	.destroy        = user_destroy,
+	.describe       = nvme_tls_psk_describe,
+	.read           = user_read,
+};
+
+static struct key *nvme_tls_psk_lookup(struct key *keyring,
+		const char *hostnqn, const char *subnqn,
+		int hmac, bool generated)
+{
+	char *identity;
+	size_t identity_len = (NVMF_NQN_SIZE) * 2 + 11;
+	key_ref_t keyref;
+	key_serial_t keyring_id;
+
+	identity = kzalloc(identity_len, GFP_KERNEL);
+	if (!identity)
+		return ERR_PTR(-ENOMEM);
+
+	snprintf(identity, identity_len, "NVMe0%c%02d %s %s",
+		 generated ? 'G' : 'R', hmac, hostnqn, subnqn);
+
+	if (!keyring)
+		keyring = nvme_keyring;
+	keyring_id = key_serial(keyring);
+	pr_debug("keyring %x lookup tls psk '%s'\n",
+		 keyring_id, identity);
+	keyref = keyring_search(make_key_ref(keyring, true),
+				&nvme_tls_psk_key_type,
+				identity, false);
+	if (IS_ERR(keyref)) {
+		pr_debug("lookup tls psk '%s' failed, error %ld\n",
+			 identity, PTR_ERR(keyref));
+		kfree(identity);
+		return ERR_PTR(-ENOKEY);
+	}
+	kfree(identity);
+
+	return key_ref_to_ptr(keyref);
+}
+
 int nvme_keyring_init(void)
 {
+	int err;
+
 	nvme_keyring = keyring_alloc(".nvme",
 				     GLOBAL_ROOT_UID, GLOBAL_ROOT_GID,
 				     current_cred(),
@@ -28,12 +116,18 @@ int nvme_keyring_init(void)
 	if (IS_ERR(nvme_keyring))
 		return PTR_ERR(nvme_keyring);
 
+	err = register_key_type(&nvme_tls_psk_key_type);
+	if (err) {
+		key_put(nvme_keyring);
+		return err;
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(nvme_keyring_init);
 
 void nvme_keyring_exit(void)
 {
+	unregister_key_type(&nvme_tls_psk_key_type);
 	key_revoke(nvme_keyring);
 	key_put(nvme_keyring);
 }
-- 
2.35.3


