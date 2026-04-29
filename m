Return-Path: <netdev+bounces-282466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ2wJ+9K8mnNpQEAu9opvQ
	(envelope-from <netdev+bounces-282466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:16:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 134E0498DFC
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 20:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CAFCE306015F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 18:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0230D41C2F8;
	Wed, 29 Apr 2026 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Img5+6kD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC35D41C2E8
	for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 18:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777486333; cv=none; b=NaVc9y6gLfobuC1fzDZ/o9MHkvRWydvB3fLkj5F9Vb/PYQvSep8SHUxDXyDKLKAWGRiQVsGB8SULZqkvG9f7zK+Hl8LC4bNy85UK6WjBLrakIoynYEqKAyPxYipe1WDVocQroug0KURX/9UO8/N4xBUVvsznNNdo1DKj157bPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777486333; c=relaxed/simple;
	bh=7zaOt/R/e6APb1Q/0KckD6NSBTRDUkkzEE5eTa+m7nA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=luxXYI8+/TEFmyyTXc7Mez2gUTjkXaxAT3meGNCuNAH6hUh1WI6apPDzcgzt5tQAEjkpxtOcAVnssJE9arcQMLPPpuxfze1HP6Tp7QF3es3XKlv2yoh37bUR97rqM6/6E5icFHHhdj/MhSa1SMRWUc/WJXYcJLHFteF1GmEyMiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Img5+6kD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b150559bso339525e9.1
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 11:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1777486329; x=1778091129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nd26rloY+UzEU8baIVPQY5sP6ZdmKcjfGikmN4rCM3A=;
        b=Img5+6kDdZqlu45Lpkw8YTe1hX5bb5sg1bqjGPqgWvxhEWhcVQFKcTriYZtiL/az6G
         V9DZXRCZza2pKzuc4f/UpagBB+bORrBDeF8IIMfQmsLSGkRkTvCfsfgWtl9GD2FhPnJJ
         R/2vgfbxpB2R80XkfFm7VXSwiRHUgw9zWeW8bq8Gdnowp2aRaJnpcY0uIDPwp1k2gn35
         6Ier0q+N5UiDKx5FNGK2anFUcfYb575BevUE08f7KNtKSl3tysQvRQrPVEDZrlxlhNaM
         nKd/nMoKR76/1oirLwdQvwGWVsoMeK/i7Hl38udiTRNzukBJkYMSyFE9heKHumX4KQhJ
         dz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777486329; x=1778091129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nd26rloY+UzEU8baIVPQY5sP6ZdmKcjfGikmN4rCM3A=;
        b=eFwePwQ3zLBkzhhv6qr+KsUEiMTMjFxFSAPDlelasSRfTpLR6n1yD5g2zy+Ez2sD+H
         jpT7a9RnkZDJBHDvMjJONLpNyIwRoo0R+v56RbWik9VJrXaEX+JrWP7RGfNTPKhElayV
         7QQ+WSKmIKVMnb0Cdq5l/RU3y+JSdZPqa5CPXy8KWZ6Xp3oyRVZek4efYnM3ZVSIB2Nw
         lvzR658ITAgUlyWR70TOCu7DVzUHz5V1AkPSXPMMba+CQEWpLODdY23+Gli4UyNUg4tz
         oHv8L+f6kK+1umrZKngHOm38Sb3ABVy6Hq7GgJL2IIKuMy+JWvKZ4PurCF1S1oPraBlA
         dkAA==
X-Gm-Message-State: AOJu0Yy/TtTvsT2sARd1GwQpzM5XANbAUrHr3IADLBHSAUmUYinVml1W
	N2eIUQoAeAKk4ukVN3X3YT0G/Jx6VMOh4ZkbmI7o54YgcD0btayXch/FUwm1xm3wshtpynWub+1
	99pWCKnpurC+0lC8goxspYDhUdScrofO22f5UN26HJq5sn4QX5hTTHopKiSBMBefeJvFhy9qlLh
	uN/p5VEmNhRCkwrBc2CNY35KKveJ6nJUeAwDmD2NBatWe+dnk=
X-Gm-Gg: AeBDieuCSUjB3Tmj3qdQZFge4hVmwKy0ghWVjnI/wo5XQhMioqGzJYpPqrtCcxB3YvL
	7mZWmbfKYI7eZGzpucKkQRfOOntBBduiPmedyW+mJ7Pvdo6jBfAv4Sjs1efl1bNG1/7qBqModtB
	3cTm2idL2jCNRsd1jstl7F+kyt9GAsYK4oB8qnFHUd8nxRRYZjICQ3+0xN2pH2Ss0vMeWBLTP5X
	u/zRHS0XBM+rkGsR5fsXske6AMU1aQZ/bmp1cL2QzzPGS6y/rgyXUQtLCHbnvlpZu7JS6fTAT8h
	NKWzD9n/71TCpXMIpTKLf/Rci6KS+Rqc81sMa1J7vA7Cj/z1GjhS7w3oEYPYnUtLVRcx/B2Z2ea
	cx4vx/8FeCW1neupXTIGPi5ifQGltIVPI/+lAizP4urxCbtGTE79MRl5fcEg/OuPiUgzCYll6FL
	nW9zEu13Ahk6mN69l1yuLIZJOA//3vNgD5zA229isiUl+R33cQNeFbPpoahoKzWXpgBNc=
X-Received: by 2002:a05:600c:1d20:b0:48a:7676:30bc with SMTP id 5b1f17b1804b1-48a77b0a3d6mr162735485e9.14.1777486328541;
        Wed, 29 Apr 2026 11:12:08 -0700 (PDT)
Received: from dev-rjethwani.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48a82308d77sm7525285e9.14.2026.04.29.11.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 11:12:08 -0700 (PDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	leon@kernel.org,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH v13 6/6] selftests: net: add TLS hardware offload test
Date: Wed, 29 Apr 2026 12:10:16 -0600
Message-Id: <20260429181016.3164935-7-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260429181016.3164935-1-rjethwani@purestorage.com>
References: <20260429181016.3164935-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 134E0498DFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-282466-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.986];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,purestorage.com:email,purestorage.com:dkim,purestorage.com:mid,tls_hw_offload.py:url,lib.py:url]

Two-node kTLS hardware offload test using NetDrvEpEnv. Tests TLS
1.2/1.3 with AES-GCM-128/256, rekey operations, and various buffer
sizes.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 MAINTAINERS                                   |   2 +
 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c | 887 ++++++++++++++++++
 .../drivers/net/hw/tls_hw_offload.py          | 256 +++++
 5 files changed, 1148 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 2fb1c75afd16..aedf42890094 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18776,6 +18776,8 @@ F:	Documentation/networking/tls*
 F:	include/net/tls.h
 F:	include/uapi/linux/tls.h
 F:	net/tls/
+F:	tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
+F:	tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
 F:	tools/testing/selftests/net/tls.c
 
 NETWORKING [SOCKETS]
diff --git a/tools/testing/selftests/drivers/net/hw/.gitignore b/tools/testing/selftests/drivers/net/hw/.gitignore
index 46540468a775..f0a5d15b469b 100644
--- a/tools/testing/selftests/drivers/net/hw/.gitignore
+++ b/tools/testing/selftests/drivers/net/hw/.gitignore
@@ -2,3 +2,4 @@
 iou-zcrx
 ncdevmem
 toeplitz
+tls_hw_offload
diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 85ca4d1ecf9e..2dd633619f40 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -15,6 +15,7 @@ endif
 
 TEST_GEN_FILES := \
 	$(COND_GEN_FILES) \
+	tls_hw_offload \
 # end of TEST_GEN_FILES
 
 TEST_PROGS = \
@@ -43,6 +44,7 @@ TEST_PROGS = \
 	rss_drv.py \
 	rss_flow_label.py \
 	rss_input_xfrm.py \
+	tls_hw_offload.py \
 	toeplitz.py \
 	tso.py \
 	uso.py \
diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
new file mode 100644
index 000000000000..db7c61d8b4e7
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
@@ -0,0 +1,887 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TLS Hardware Offload Two-Node Test
+ *
+ * Tests kTLS hardware offload between two physical nodes using
+ * hardcoded keys. Supports TLS 1.2/1.3, AES-GCM-128/256, and rekey.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <time.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netinet/in.h>
+#include <netinet/tcp.h>
+#include <arpa/inet.h>
+#include <linux/tls.h>
+
+#define TLS_RECORD_TYPE_HANDSHAKE		22
+#define TLS_HANDSHAKE_KEY_UPDATE		0x18
+
+#define MIN_BUF_SIZE   16
+
+/* Initial key material */
+static struct tls12_crypto_info_aes_gcm_128 tls_info_key0_128 = {
+	.info = {
+		.version = TLS_1_3_VERSION,
+		.cipher_type = TLS_CIPHER_AES_GCM_128,
+	},
+	.iv = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 },
+	.key = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+		 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10 },
+	.salt = { 0x01, 0x02, 0x03, 0x04 },
+	.rec_seq = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
+};
+
+static struct tls12_crypto_info_aes_gcm_256 tls_info_key0_256 = {
+	.info = {
+		.version = TLS_1_3_VERSION,
+		.cipher_type = TLS_CIPHER_AES_GCM_256,
+	},
+	.iv = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08 },
+	.key = { 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08,
+		 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e, 0x0f, 0x10,
+		 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17, 0x18,
+		 0x19, 0x1a, 0x1b, 0x1c, 0x1d, 0x1e, 0x1f, 0x20 },
+	.salt = { 0x01, 0x02, 0x03, 0x04 },
+	.rec_seq = { 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00 },
+};
+
+static int num_rekeys;
+static int num_iterations = 100;
+static int cipher_type = TLS_CIPHER_AES_GCM_128;
+static int tls_version = TLS_1_3_VERSION;
+static int server_port = 4433;
+static char *server_ip;
+
+static int send_size = 16384;
+static int random_size_max;
+/* Burst mode: sender keeps pushing records without reading from the peer;
+ * receiver drains without echoing back. Only the client initiates rekey.
+ */
+static int burst_mode;
+static int zc_rx;
+
+/* XOR each byte with the generation so both endpoints derive the
+ * same per-generation key without a real KDF. Generation 0 leaves
+ * the base key unchanged.
+ */
+static void derive_key_fields(unsigned char *key, int key_size,
+			      unsigned char *iv, int iv_size,
+			      unsigned char *salt, int salt_size,
+			      unsigned char *rec_seq, int rec_seq_size,
+			      int generation)
+{
+	int i;
+
+	for (i = 0; i < key_size; i++)
+		key[i] ^= generation;
+	for (i = 0; i < iv_size; i++)
+		iv[i] ^= generation;
+	for (i = 0; i < salt_size; i++)
+		salt[i] ^= generation;
+	memset(rec_seq, 0, rec_seq_size);
+}
+
+static void derive_key_128(struct tls12_crypto_info_aes_gcm_128 *key,
+			   int generation)
+{
+	memcpy(key, &tls_info_key0_128, sizeof(*key));
+	key->info.version = tls_version;
+	derive_key_fields(key->key, TLS_CIPHER_AES_GCM_128_KEY_SIZE,
+			  key->iv, TLS_CIPHER_AES_GCM_128_IV_SIZE,
+			  key->salt, TLS_CIPHER_AES_GCM_128_SALT_SIZE,
+			  key->rec_seq, TLS_CIPHER_AES_GCM_128_REC_SEQ_SIZE,
+			  generation);
+}
+
+static void derive_key_256(struct tls12_crypto_info_aes_gcm_256 *key,
+			   int generation)
+{
+	memcpy(key, &tls_info_key0_256, sizeof(*key));
+	key->info.version = tls_version;
+	derive_key_fields(key->key, TLS_CIPHER_AES_GCM_256_KEY_SIZE,
+			  key->iv, TLS_CIPHER_AES_GCM_256_IV_SIZE,
+			  key->salt, TLS_CIPHER_AES_GCM_256_SALT_SIZE,
+			  key->rec_seq, TLS_CIPHER_AES_GCM_256_REC_SEQ_SIZE,
+			  generation);
+}
+
+static const char *cipher_name(int cipher)
+{
+	switch (cipher) {
+	case TLS_CIPHER_AES_GCM_128: return "AES-GCM-128";
+	case TLS_CIPHER_AES_GCM_256: return "AES-GCM-256";
+	default: return "unknown";
+	}
+}
+
+static const char *version_name(int version)
+{
+	switch (version) {
+	case TLS_1_2_VERSION: return "TLS 1.2";
+	case TLS_1_3_VERSION: return "TLS 1.3";
+	default: return "unknown";
+	}
+}
+
+static int setup_tls_ulp(int fd)
+{
+	int ret;
+
+	ret = setsockopt(fd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
+	if (ret < 0) {
+		printf("SETUP ERROR: TCP_ULP failed: %s\n", strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
+static int set_zc_rx(int fd)
+{
+	int val = 1;
+
+	if (setsockopt(fd, SOL_TLS, TLS_RX_EXPECT_NO_PAD, &val,
+		       sizeof(val)) < 0) {
+		printf("SETUP ERROR: TLS_RX_EXPECT_NO_PAD failed: %s\n",
+		       strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
+/* Send a TLS 1.3 KeyUpdate handshake record. The kernel only
+ * inspects the HandshakeType byte to detect KeyUpdate, so don't
+ * bother with the 3-byte length or request_update fields.
+ */
+static int send_tls_key_update(int fd)
+{
+	char cmsg_buf[CMSG_SPACE(sizeof(unsigned char))];
+	unsigned char key_update_msg = TLS_HANDSHAKE_KEY_UPDATE;
+	struct msghdr msg = {0};
+	struct cmsghdr *cmsg;
+	struct iovec iov;
+
+	iov.iov_base = &key_update_msg;
+	iov.iov_len = sizeof(key_update_msg);
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = cmsg_buf;
+	msg.msg_controllen = sizeof(cmsg_buf);
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_TLS;
+	cmsg->cmsg_type = TLS_SET_RECORD_TYPE;
+	cmsg->cmsg_len = CMSG_LEN(sizeof(unsigned char));
+	*CMSG_DATA(cmsg) = TLS_RECORD_TYPE_HANDSHAKE;
+	msg.msg_controllen = cmsg->cmsg_len;
+
+	if (sendmsg(fd, &msg, 0) < 0) {
+		printf("sendmsg KeyUpdate failed: %s\n", strerror(errno));
+		return -1;
+	}
+
+	printf("Sent TLS KeyUpdate handshake message\n");
+	return 0;
+}
+
+static int recv_tls_message(int fd, char *buf, size_t buflen, int *record_type)
+{
+	char cmsg_buf[CMSG_SPACE(sizeof(unsigned char))];
+	struct msghdr msg = {0};
+	struct cmsghdr *cmsg;
+	struct iovec iov;
+	int ret;
+
+	iov.iov_base = buf;
+	iov.iov_len = buflen;
+
+	msg.msg_iov = &iov;
+	msg.msg_iovlen = 1;
+	msg.msg_control = cmsg_buf;
+	msg.msg_controllen = sizeof(cmsg_buf);
+
+	ret = recvmsg(fd, &msg, 0);
+	if (ret <= 0)
+		return ret;
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	if (cmsg && cmsg->cmsg_level == SOL_TLS &&
+	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE)
+		*record_type = *((unsigned char *)CMSG_DATA(cmsg));
+
+	return ret;
+}
+
+/* Confirm a handshake record starting with HandshakeType KeyUpdate. */
+static int check_keyupdate(const char *buf, int len, int record_type)
+{
+	if (record_type != TLS_RECORD_TYPE_HANDSHAKE) {
+		printf("Expected handshake record (0x%02x), got 0x%02x\n",
+		       TLS_RECORD_TYPE_HANDSHAKE, record_type);
+		return -1;
+	}
+	if (len < 1 || (unsigned char)buf[0] != TLS_HANDSHAKE_KEY_UPDATE) {
+		printf("Expected KeyUpdate (0x%02x), got 0x%02x\n",
+		       TLS_HANDSHAKE_KEY_UPDATE,
+		       len ? (unsigned char)buf[0] : 0);
+		return -1;
+	}
+	printf("Received TLS KeyUpdate\n");
+	return 0;
+}
+
+static int recv_tls_keyupdate(int fd)
+{
+	char buf[MIN_BUF_SIZE];
+	int record_type = 0;
+	int ret;
+
+	ret = recv_tls_message(fd, buf, sizeof(buf), &record_type);
+	if (ret < 0) {
+		printf("recv_tls_message failed: %s\n", strerror(errno));
+		return -1;
+	}
+
+	return check_keyupdate(buf, ret, record_type);
+}
+
+static int check_ekeyexpired(int fd)
+{
+	char buf[MIN_BUF_SIZE];
+	int ret;
+
+	ret = recv(fd, buf, sizeof(buf), MSG_DONTWAIT);
+	if (ret == -1 && errno == EKEYEXPIRED) {
+		printf("recv() returned EKEYEXPIRED as expected\n");
+		return 0;
+	} else if (ret == -1 && errno == EAGAIN) {
+		printf("recv() returned EAGAIN (no pending data)\n");
+		return 0;
+	} else if (ret > 0) {
+		printf("FAIL: recv() returned %d bytes, expected EKEYEXPIRED\n",
+		       ret);
+		return -1;
+	} else {
+		printf("FAIL: recv() returned unexpected error: %s\n",
+		       strerror(errno));
+		return -1;
+	}
+}
+
+static int do_tls_rekey(int fd, int direction, int generation, int cipher)
+{
+	const char *dir = direction == TLS_TX ? "TX" : "RX";
+	int ret;
+
+	printf("%s TLS_%s %s gen %d...\n",
+	       generation ? "Rekeying" : "Installing",
+	       dir, cipher_name(cipher), generation);
+
+	if (cipher == TLS_CIPHER_AES_GCM_256) {
+		struct tls12_crypto_info_aes_gcm_256 key;
+
+		derive_key_256(&key, generation);
+		ret = setsockopt(fd, SOL_TLS, direction, &key, sizeof(key));
+	} else {
+		struct tls12_crypto_info_aes_gcm_128 key;
+
+		derive_key_128(&key, generation);
+		ret = setsockopt(fd, SOL_TLS, direction, &key, sizeof(key));
+	}
+
+	if (ret < 0) {
+		printf("%sTLS_%s %s gen %d failed: %s\n",
+		       generation ? "" : "SETUP ERROR: ", dir,
+		       cipher_name(cipher), generation, strerror(errno));
+		return -1;
+	}
+	printf("TLS_%s %s gen %d installed\n",
+	       dir, cipher_name(cipher), generation);
+	return 0;
+}
+
+static int do_client(void)
+{
+	char *buf = NULL, *echo_buf = NULL;
+	int max_size, rekey_interval;
+	ssize_t echo_total, echo_n;
+	int csk = -1, ret, i, j;
+	struct sockaddr_in sa;
+	int test_result = -1;
+	int current_gen = 0;
+	int next_rekey_at;
+	ssize_t n;
+
+	max_size = random_size_max > 0 ? random_size_max : send_size;
+	if (max_size < MIN_BUF_SIZE)
+		max_size = MIN_BUF_SIZE;
+	buf = malloc(max_size);
+	if (!burst_mode)
+		echo_buf = malloc(max_size);
+	if (!buf || (!burst_mode && !echo_buf)) {
+		printf("SETUP ERROR: failed to allocate buffers\n");
+		goto out;
+	}
+
+	csk = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	if (csk < 0) {
+		printf("SETUP ERROR: failed to create socket: %s\n",
+		       strerror(errno));
+		goto out;
+	}
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sin_family = AF_INET;
+	sa.sin_addr.s_addr = inet_addr(server_ip);
+	sa.sin_port = htons(server_port);
+	printf("Connecting to %s:%d...\n", server_ip, server_port);
+
+	ret = connect(csk, (struct sockaddr *)&sa, sizeof(sa));
+	if (ret < 0) {
+		printf("SETUP ERROR: connect failed: %s\n", strerror(errno));
+		goto out;
+	}
+	printf("Connected!\n");
+
+	if (setup_tls_ulp(csk) < 0)
+		goto out;
+
+	if (do_tls_rekey(csk, TLS_TX, 0, cipher_type) < 0 ||
+	    do_tls_rekey(csk, TLS_RX, 0, cipher_type) < 0)
+		goto out;
+
+	if (num_rekeys)
+		printf("TLS %s setup complete. Will perform %d rekey(s).\n",
+		       cipher_name(cipher_type), num_rekeys);
+	else
+		printf("TLS setup complete.\n");
+
+	if (random_size_max > 0)
+		printf("Sending %d messages of random size (1..%d bytes)...\n",
+		       num_iterations, random_size_max);
+	else
+		printf("Sending %d messages of %d bytes...\n",
+		       num_iterations, send_size);
+
+	rekey_interval = num_iterations / (num_rekeys + 1);
+	next_rekey_at = rekey_interval;
+
+	for (i = 1; i <= num_iterations; i++) {
+		int this_size;
+
+		if (random_size_max > 0)
+			this_size = (rand() % random_size_max) + 1;
+		else
+			this_size = send_size;
+
+		/* In burst mode, use a per-iteration fill pattern so the
+		 * receiver can detect any plaintext corruption without a
+		 * round-trip echo.
+		 */
+		if (burst_mode) {
+			memset(buf, i & 0xFF, this_size);
+		} else {
+			for (j = 0; j < this_size; j++)
+				buf[j] = rand() & 0xFF;
+		}
+
+		n = send(csk, buf, this_size, 0);
+		if (n != this_size) {
+			printf("FAIL: send failed: %s\n", strerror(errno));
+			goto out;
+		}
+		/* Throttle per-iteration progress lines on long burst runs so
+		 * stdout over ssh doesn't become the bottleneck.
+		 */
+		if (!burst_mode || num_iterations <= 1000 || (i % 1000) == 0 ||
+		    i == num_iterations)
+			printf("Sent %zd bytes (iteration %d)\n", n, i);
+
+		if (!burst_mode) {
+			echo_total = 0;
+			while (echo_total < n) {
+				echo_n = recv(csk, echo_buf + echo_total,
+					      n - echo_total, 0);
+				if (echo_n < 0) {
+					printf("FAIL: Echo recv failed: %s\n",
+					       strerror(errno));
+					goto out;
+				}
+				if (echo_n == 0) {
+					printf("FAIL: Connection closed during echo\n");
+					goto out;
+				}
+				echo_total += echo_n;
+			}
+
+			if (memcmp(buf, echo_buf, n) != 0) {
+				printf("FAIL: Echo data mismatch!\n");
+				goto out;
+			}
+			printf("Received echo %zd bytes (ok)\n", echo_total);
+		}
+
+		/* Rekey at intervals. In echo mode this is a full bidirectional
+		 * exchange; in burst mode the client only rotates its TX key
+		 * and sends KeyUpdate - the peer is expected to follow.
+		 */
+		if (num_rekeys && current_gen < num_rekeys &&
+		    i == next_rekey_at) {
+			current_gen++;
+			printf("\n=== Client Rekey gen %d ===\n", current_gen);
+
+			ret = send_tls_key_update(csk);
+			if (ret < 0) {
+				printf("FAIL: send KeyUpdate\n");
+				goto out;
+			}
+
+			ret = do_tls_rekey(csk, TLS_TX, current_gen, cipher_type);
+			if (ret < 0)
+				goto out;
+
+			if (!burst_mode) {
+				if (recv_tls_keyupdate(csk) < 0) {
+					printf("FAIL: recv KeyUpdate from server\n");
+					goto out;
+				}
+
+				if (check_ekeyexpired(csk) < 0)
+					goto out;
+
+				ret = do_tls_rekey(csk, TLS_RX, current_gen,
+						   cipher_type);
+				if (ret < 0)
+					goto out;
+			}
+
+			next_rekey_at += rekey_interval;
+			printf("=== Client Rekey gen %d Complete ===\n\n",
+			       current_gen);
+		}
+	}
+
+	test_result = 0;
+out:
+	if (num_rekeys)
+		printf("Rekeys completed: %d/%d\n", current_gen, num_rekeys);
+	if (csk >= 0)
+		close(csk);
+	free(buf);
+	free(echo_buf);
+	return test_result;
+}
+
+static int do_server(void)
+{
+	int lsk = -1, csk = -1, ret;
+	ssize_t n, total = 0, sent;
+	/* Burst-mode data verification state: client fills each iteration's
+	 * send_size-byte block with (send_iter & 0xff). A single recv may
+	 * return part of a block or span iterations, so track position as
+	 * (send_iter, remaining) - bytes left in the current block.
+	 */
+	int send_iter = 1;
+	int remaining = send_size;
+	struct sockaddr_in sa;
+	int test_result = -1;
+	int current_gen = 0;
+	int recv_count = 0;
+	char *buf = NULL;
+	int record_type;
+	int buf_size;
+	int one = 1;
+
+	buf_size = send_size;
+	if (buf_size < MIN_BUF_SIZE)
+		buf_size = MIN_BUF_SIZE;
+	buf = malloc(buf_size);
+	if (!buf) {
+		printf("SETUP ERROR: failed to allocate buffer\n");
+		goto out;
+	}
+
+	lsk = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	if (lsk < 0) {
+		printf("SETUP ERROR: failed to create socket: %s\n",
+		       strerror(errno));
+		goto out;
+	}
+
+	setsockopt(lsk, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
+
+	memset(&sa, 0, sizeof(sa));
+	sa.sin_family = AF_INET;
+	sa.sin_addr.s_addr = INADDR_ANY;
+	sa.sin_port = htons(server_port);
+
+	ret = bind(lsk, (struct sockaddr *)&sa, sizeof(sa));
+	if (ret < 0) {
+		printf("SETUP ERROR: bind failed: %s\n", strerror(errno));
+		goto out;
+	}
+
+	ret = listen(lsk, 1);
+	if (ret < 0) {
+		printf("SETUP ERROR: listen failed: %s\n", strerror(errno));
+		goto out;
+	}
+
+	printf("Server listening on 0.0.0.0:%d\n", server_port);
+	printf("Waiting for client connection...\n");
+
+	csk = accept(lsk, (struct sockaddr *)NULL, (socklen_t *)NULL);
+	if (csk < 0) {
+		printf("SETUP ERROR: accept failed: %s\n", strerror(errno));
+		goto out;
+	}
+	printf("Client connected!\n");
+
+	if (setup_tls_ulp(csk) < 0)
+		goto out;
+
+	if (do_tls_rekey(csk, TLS_TX, 0, cipher_type) < 0 ||
+	    do_tls_rekey(csk, TLS_RX, 0, cipher_type) < 0)
+		goto out;
+
+	if (zc_rx && set_zc_rx(csk) < 0)
+		goto out;
+
+	printf("TLS %s setup complete. Receiving...\n",
+	       cipher_name(cipher_type));
+
+	/* Main receive loop */
+	while (1) {
+		n = recv_tls_message(csk, buf, buf_size, &record_type);
+		if (n == 0) {
+			printf("Connection closed by client\n");
+			break;
+		}
+		if (n < 0) {
+			printf("FAIL: recv failed: %s\n", strerror(errno));
+			goto out;
+		}
+
+		/* Handle KeyUpdate. In echo mode the server mirrors the
+		 * rekey back to the peer; in burst mode it only rotates
+		 * its RX key and keeps draining.
+		 */
+		if (record_type == TLS_RECORD_TYPE_HANDSHAKE) {
+			if (check_keyupdate(buf, n, record_type) < 0)
+				goto out;
+			current_gen++;
+			printf("\n=== Server Rekey gen %d ===\n", current_gen);
+
+			if (check_ekeyexpired(csk) < 0)
+				goto out;
+
+			ret = do_tls_rekey(csk, TLS_RX, current_gen, cipher_type);
+			if (ret < 0)
+				goto out;
+
+			if (!burst_mode) {
+				ret = send_tls_key_update(csk);
+				if (ret < 0) {
+					printf("FAIL: send KeyUpdate\n");
+					goto out;
+				}
+
+				ret = do_tls_rekey(csk, TLS_TX, current_gen,
+						   cipher_type);
+				if (ret < 0)
+					goto out;
+			}
+
+			printf("=== Server Rekey gen %d Complete ===\n\n",
+			       current_gen);
+			continue;
+		}
+
+		total += n;
+		recv_count++;
+		/* Throttle per-record progress lines on long burst runs. */
+		if (!burst_mode || (recv_count % 1000) == 0)
+			printf("Received %zd bytes (total: %zd, count: %d)\n",
+			       n, total, recv_count);
+
+		/* Burst mode: verify payload matches the client's fill
+		 * pattern. TLS record boundaries may differ from send()
+		 * boundaries, so walk the received buffer in chunks that
+		 * fit within the current iteration's remaining bytes.
+		 * Catches decrypt-succeeded-but-plaintext-corrupt bugs
+		 * that AEAD counters alone would miss.
+		 */
+		if (burst_mode) {
+			int off = 0;
+
+			while (off < n) {
+				unsigned char expect = send_iter & 0xFF;
+				int chunk = n - off;
+				int j;
+
+				if (chunk > remaining)
+					chunk = remaining;
+
+				for (j = 0; j < chunk; j++) {
+					if ((unsigned char)buf[off + j] != expect) {
+						printf("FAIL: data mismatch recv #%d offset %d:"
+						       " expected 0x%02x got 0x%02x"
+						       " (iter %d, remaining %d)\n",
+						       recv_count, off + j,
+						       expect,
+						       (unsigned char)buf[off + j],
+						       send_iter, remaining);
+						goto out;
+					}
+				}
+
+				off += chunk;
+				remaining -= chunk;
+				if (remaining == 0) {
+					send_iter++;
+					remaining = send_size;
+				}
+			}
+			continue;
+		}
+
+		for (sent = 0; sent < n; sent += ret) {
+			ret = send(csk, buf + sent, n - sent, 0);
+			if (ret < 0) {
+				printf("FAIL: Echo send failed: %s\n",
+				       strerror(errno));
+				goto out;
+			}
+		}
+		printf("Echoed %zd bytes back to client\n", n);
+	}
+
+	test_result = 0;
+out:
+	printf("Connection closed. Total received: %zd bytes\n", total);
+	if (num_rekeys)
+		printf("Rekeys completed: %d\n", current_gen);
+
+	if (csk >= 0)
+		close(csk);
+	if (lsk >= 0)
+		close(lsk);
+	free(buf);
+	return test_result;
+}
+
+static int parse_cipher_option(const char *arg)
+{
+	if (strcmp(arg, "128") == 0) {
+		cipher_type = TLS_CIPHER_AES_GCM_128;
+		return 0;
+	} else if (strcmp(arg, "256") == 0) {
+		cipher_type = TLS_CIPHER_AES_GCM_256;
+		return 0;
+	}
+	printf("ERROR: Invalid cipher '%s'. Must be 128 or 256.\n", arg);
+	return -1;
+}
+
+static int parse_version_option(const char *arg)
+{
+	if (strcmp(arg, "1.2") == 0) {
+		tls_version = TLS_1_2_VERSION;
+		return 0;
+	} else if (strcmp(arg, "1.3") == 0) {
+		tls_version = TLS_1_3_VERSION;
+		return 0;
+	}
+	printf("ERROR: Invalid TLS version '%s'. Must be 1.2 or 1.3.\n", arg);
+	return -1;
+}
+
+static void print_usage(const char *prog)
+{
+	printf("TLS Hardware Offload Two-Node Test\n\n");
+	printf("Usage:\n");
+	printf("  %s server [OPTIONS]\n", prog);
+	printf("  %s client -s <ip> [OPTIONS]\n", prog);
+	printf("\nOptions:\n");
+	printf("  -s <ip>       Server IPv4 address (client, required)\n");
+	printf("  -p <port>     Server port (default: 4433)\n");
+	printf("  -b <size>     Send buffer size in bytes (default: 16384)\n");
+	printf("  -r <max>      Use random send buffer sizes (1..<max>)\n");
+	printf("  -v <version>  TLS version: 1.2 or 1.3 (default: 1.3)\n");
+	printf("  -c <cipher>   Cipher: 128 or 256 (default: 128)\n");
+	printf("  -n <N>        Number of send/echo iterations (default: 100)\n");
+	printf("  -k <N>        Perform N rekeys (client only, TLS 1.3; N < iterations)\n");
+	printf("  -B            Burst mode: client sends continuously without echo;\n");
+	printf("                server drains and handles KeyUpdate without responding.\n");
+	printf("  -Z            Enable zero-copy RX (TLS_RX_EXPECT_NO_PAD);\n");
+	printf("                server only, TLS 1.3 only.\n");
+	printf("  -h            Show this help message\n");
+	printf("\nExample:\n");
+	printf("  Node A: %s server\n", prog);
+	printf("  Node B: %s client -s 192.168.20.2\n", prog);
+	printf("\nRekey Example (3 rekeys, TLS 1.3 only):\n");
+	printf("  Node A: %s server\n", prog);
+	printf("  Node B: %s client -s 192.168.20.2 -k 3\n", prog);
+	printf("\nBurst Mode Example (client stresses TX rekey under load):\n");
+	printf("  Node A: %s server -B\n", prog);
+	printf("  Node B: %s client -s 192.168.20.2 -B -k 3\n", prog);
+}
+
+int main(int argc, char *argv[])
+{
+	int send_size_set = 0;
+	int is_server;
+	int opt;
+
+	if (argc < 2 ||
+	    (strcmp(argv[1], "server") && strcmp(argv[1], "client"))) {
+		print_usage(argv[0]);
+		return 1;
+	}
+	is_server = !strcmp(argv[1], "server");
+
+	optind = 2; /* skip subcommand */
+	while ((opt = getopt(argc, argv, "s:p:b:r:c:v:k:n:BZh")) != -1) {
+		switch (opt) {
+		case 's':
+			server_ip = optarg;
+			break;
+		case 'B':
+			burst_mode = 1;
+			break;
+		case 'Z':
+			zc_rx = 1;
+			break;
+		case 'p':
+			server_port = atoi(optarg);
+			if (server_port < 1 || server_port > 65535) {
+				printf("ERROR: Invalid port '%s'. Must be 1..65535.\n",
+				       optarg);
+				return 1;
+			}
+			break;
+		case 'b':
+			send_size = atoi(optarg);
+			if (send_size < 1) {
+				printf("ERROR: Invalid buffer size '%s'. Must be >= 1.\n",
+				       optarg);
+				return 1;
+			}
+			send_size_set = 1;
+			break;
+		case 'r':
+			random_size_max = atoi(optarg);
+			if (random_size_max < 1) {
+				printf("ERROR: Invalid random size '%s'. Must be >= 1.\n",
+				       optarg);
+				return 1;
+			}
+			break;
+		case 'c':
+			if (parse_cipher_option(optarg) < 0)
+				return 1;
+			break;
+		case 'v':
+			if (parse_version_option(optarg) < 0)
+				return 1;
+			break;
+		case 'k':
+			num_rekeys = atoi(optarg);
+			if (num_rekeys < 1) {
+				printf("ERROR: Invalid rekey count '%s'. Must be >= 1.\n",
+				       optarg);
+				return 1;
+			}
+			break;
+		case 'n':
+			num_iterations = atoi(optarg);
+			if (num_iterations < 1) {
+				printf("ERROR: Invalid iteration count '%s'. Must be >= 1.\n",
+				       optarg);
+				return 1;
+			}
+			break;
+		case 'h':
+			print_usage(argv[0]);
+			return 0;
+		default:
+			print_usage(argv[0]);
+			return 1;
+		}
+	}
+
+	if (send_size_set && random_size_max > 0) {
+		printf("ERROR: -b and -r are mutually exclusive\n");
+		return 1;
+	}
+
+	if (zc_rx && tls_version != TLS_1_3_VERSION) {
+		printf("ERROR: -Z (TLS_RX_EXPECT_NO_PAD) requires TLS 1.3\n");
+		return 1;
+	}
+
+	if (burst_mode && random_size_max > 0) {
+		printf("ERROR: -B and -r are mutually exclusive\n");
+		return 1;
+	}
+
+	if (is_server) {
+		if (server_ip) {
+			printf("warning: -s is ignored in server mode\n");
+			server_ip = NULL;
+		}
+		if (random_size_max > 0) {
+			printf("warning: -r is ignored in server mode\n");
+			random_size_max = 0;
+		}
+		if (num_rekeys) {
+			printf("warning: -k is ignored in server mode\n");
+			num_rekeys = 0;
+		}
+	} else {
+		if (!server_ip) {
+			printf("ERROR: Client requires -s <ip> option\n");
+			return 1;
+		}
+		if (tls_version == TLS_1_2_VERSION && num_rekeys) {
+			printf("ERROR: TLS 1.2 does not support rekey\n");
+			return 1;
+		}
+		if (num_rekeys >= num_iterations) {
+			printf("ERROR: num_rekeys (%d) must be < num_iterations (%d)\n",
+			       num_rekeys, num_iterations);
+			return 1;
+		}
+		if (zc_rx) {
+			printf("ERROR: -Z applies to the server (receiver) only\n");
+			return 1;
+		}
+	}
+
+	printf("TLS Version: %s\n", version_name(tls_version));
+	printf("Cipher: %s\n", cipher_name(cipher_type));
+	if (random_size_max > 0)
+		printf("Buffer size: random (1..%d)\n", random_size_max);
+	else
+		printf("Buffer size: %d\n", send_size);
+
+	if (num_rekeys)
+		printf("Rekey testing ENABLED: %d rekey(s)\n", num_rekeys);
+	if (burst_mode)
+		printf("Burst mode ENABLED\n");
+	if (zc_rx)
+		printf("Zero-copy RX ENABLED\n");
+
+	srand(time(NULL));
+
+	if (is_server)
+		return do_server() ? 1 : 0;
+
+	return do_client() ? 1 : 0;
+}
diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
new file mode 100755
index 000000000000..f12da0e66afd
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
@@ -0,0 +1,256 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Test kTLS hardware offload using a C helper binary."""
+
+from collections import defaultdict
+
+from lib.py import ksft_run, ksft_exit, ksft_pr, KsftSkipEx, ksft_true
+from lib.py import ksft_variants, KsftNamedVariant
+from lib.py import NetDrvEpEnv
+from lib.py import cmd, bkg, wait_port_listen, rand_port
+
+
+def check_tls_support(cfg):
+    try:
+        cmd("test -f /proc/net/tls_stat")
+        cmd("test -f /proc/net/tls_stat", host=cfg.remote)
+    except Exception as e:
+        raise KsftSkipEx(f"kTLS not supported: {e}")
+
+
+def read_tls_stats(host=None):
+    stats = defaultdict(int)
+    output = cmd("cat /proc/net/tls_stat", host=host)
+    for line in output.stdout.strip().split('\n'):
+        parts = line.split()
+        if len(parts) == 2:
+            stats[parts[0]] = int(parts[1])
+    return stats
+
+
+def stat_diff(before, after, key):
+    return after[key] - before[key]
+
+
+def check_path(before, after, direction, role, require_hw):
+    """On the DUT, require HW offload; on the remote, HW or SW is fine."""
+    dev = stat_diff(before, after, f'Tls{direction}Device')
+    sw = stat_diff(before, after, f'Tls{direction}Sw')
+    if require_hw:
+        if dev < 1:
+            ksft_pr(f"FAIL: {role} {direction}: HW offload not engaged "
+                    f"(Device={dev}, Sw={sw})")
+            return 1
+    elif dev < 1 and sw < 1:
+        ksft_pr(f"FAIL: {role} {direction}: no TLS activity "
+                f"(Device={dev}, Sw={sw})")
+        return 1
+    return 0
+
+
+def check_min(before, after, key, minimum, role):
+    diff = stat_diff(before, after, key)
+    if diff < minimum:
+        ksft_pr(f"FAIL: {role} {key}: expected >= {minimum}, got {diff}")
+        return 1
+    return 0
+
+
+def check_zero(before, after, key, role):
+    diff = stat_diff(before, after, key)
+    if diff > 0:
+        ksft_pr(f"FAIL: {role} {key} increased by {diff}")
+        return 1
+    return 0
+
+
+def verify_tls_counters(stats_before, stats_after, expected_rekeys,
+                        tls_role, is_dut, burst=False):
+    """Verify TLS counters on one side of the connection.
+
+    tls_role: 'client' or 'server' (TLS role this side played).
+    is_dut: True for the local DUT; requires HW offload counters.
+    burst: burst mode - only the TLS client rotates its TX key; the TLS
+           server only follows with an RX rotation on KeyUpdate receipt.
+    """
+    errors = 0
+    role = 'DUT' if is_dut else 'Peer'
+
+    # In burst mode only one direction carries TLS traffic per side
+    # (TLS client sends, TLS server receives). Check HW offload only on
+    # the active direction(s); require HW on the DUT's active direction.
+    if burst:
+        if tls_role == 'client':
+            errors += check_path(stats_before, stats_after, 'Tx', role,
+                                 require_hw=is_dut)
+        else:
+            errors += check_path(stats_before, stats_after, 'Rx', role,
+                                 require_hw=is_dut)
+    else:
+        errors += check_path(stats_before, stats_after, 'Tx', role,
+                             require_hw=is_dut)
+        errors += check_path(stats_before, stats_after, 'Rx', role,
+                             require_hw=is_dut)
+
+    if expected_rekeys > 0:
+        if burst:
+            if tls_role == 'client':
+                errors += check_min(stats_before, stats_after,
+                                    'TlsTxRekeyOk', expected_rekeys, role)
+                errors += check_zero(stats_before, stats_after,
+                                     'TlsTxRekeyError', role)
+            else:
+                errors += check_min(stats_before, stats_after,
+                                    'TlsRxRekeyOk', expected_rekeys, role)
+                errors += check_min(stats_before, stats_after,
+                                    'TlsRxRekeyReceived', expected_rekeys,
+                                    role)
+                errors += check_zero(stats_before, stats_after,
+                                     'TlsRxRekeyError', role)
+        else:
+            errors += check_min(stats_before, stats_after,
+                                'TlsTxRekeyOk', expected_rekeys, role)
+            errors += check_min(stats_before, stats_after,
+                                'TlsRxRekeyOk', expected_rekeys, role)
+            if tls_role == 'server':
+                errors += check_min(stats_before, stats_after,
+                                    'TlsRxRekeyReceived', expected_rekeys,
+                                    role)
+            errors += check_zero(stats_before, stats_after,
+                                 'TlsTxRekeyError', role)
+            errors += check_zero(stats_before, stats_after,
+                                 'TlsRxRekeyError', role)
+
+    errors += check_zero(stats_before, stats_after, 'TlsDecryptError', role)
+
+    return errors == 0
+
+
+def run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=0,
+                 buffer_size=None, random_max=None, burst=False, zc=False,
+                 dut_role="client", num_iterations=None):
+    """Run the TLS offload test.
+
+    dut_role: 'client' (default) - DUT runs the TLS client, remote the server.
+              'server' - swap: DUT listens, remote connects. Used for burst_rx
+              so the DUT's RX path is the one under rekey pressure.
+
+    The DUT (local) is the kernel under test; the remote is just a traffic
+    source/sink and may run any kernel without HW offload. Both sides run
+    kTLS because TLS is pairwise, but verify_tls_counters() requires HW
+    offload only on the DUT (is_dut=True); the peer may use SW kTLS.
+    """
+    port = rand_port()
+    send_size = random_max or buffer_size
+
+    if dut_role == "client":
+        server_bin, server_host = cfg.bin_remote, cfg.remote
+        client_bin, client_host = cfg.bin_local, None
+        client_target = cfg.remote_addr_v['4']
+    else:
+        server_bin, server_host = cfg.bin_local, None
+        client_bin, client_host = cfg.bin_remote, cfg.remote
+        client_target = cfg.addr_v['4']
+
+    server_cmd = f"{server_bin} server -p {port} -c {cipher} -v {tls_version}"
+    if burst:
+        server_cmd += " -B"
+    if zc:
+        server_cmd += " -Z"
+    if send_size:
+        server_cmd += f" -b {send_size}"
+
+    client_cmd = (f"{client_bin} client -s {client_target} "
+                  f"-p {port} -c {cipher} -v {tls_version}")
+    if rekey:
+        client_cmd += f" -k {rekey}"
+    if burst:
+        client_cmd += " -B"
+    if num_iterations:
+        client_cmd += f" -n {num_iterations}"
+    if random_max:
+        client_cmd += f" -r {random_max}"
+    elif buffer_size:
+        client_cmd += f" -b {buffer_size}"
+
+    # Burst variants push hundreds of MB and perform many rekeys; the
+    # default cmd() timeout (5s) is too short.
+    cmd_timeout = 180 if burst else 5
+
+    stats_before_local = read_tls_stats()
+    stats_before_remote = read_tls_stats(host=cfg.remote)
+
+    with bkg(server_cmd, host=server_host, exit_wait=True):
+        wait_port_listen(port, host=server_host)
+        cmd(client_cmd, host=client_host, timeout=cmd_timeout)
+
+    stats_after_local = read_tls_stats()
+    stats_after_remote = read_tls_stats(host=cfg.remote)
+
+    dut_tls_role = dut_role
+    peer_tls_role = 'server' if dut_role == 'client' else 'client'
+
+    dut_ok = verify_tls_counters(stats_before_local, stats_after_local,
+                                 rekey, dut_tls_role, is_dut=True,
+                                 burst=burst)
+    peer_ok = verify_tls_counters(stats_before_remote, stats_after_remote,
+                                  rekey, peer_tls_role, is_dut=False,
+                                  burst=burst)
+
+    ksft_true(dut_ok, "DUT TLS counters verified")
+    ksft_true(peer_ok, "Peer TLS counters verified")
+
+
+@ksft_variants([
+    KsftNamedVariant("tls13_aes128", "128", "1.3"),
+    KsftNamedVariant("tls13_aes256", "256", "1.3"),
+    KsftNamedVariant("tls12_aes128", "128", "1.2"),
+    KsftNamedVariant("tls12_aes256", "256", "1.2"),
+])
+def test_tls_offload(cfg, cipher, tls_version):
+    run_tls_test(cfg, cipher=cipher, tls_version=tls_version)
+
+
+@ksft_variants([
+    KsftNamedVariant("single", 1),
+    KsftNamedVariant("multiple", 99),
+    KsftNamedVariant("small_buf", 30, 512),
+    KsftNamedVariant("large_buf", 10, 2097152),
+    KsftNamedVariant("random_buf", 20, None, 8192),
+])
+def test_tls_offload_rekey(cfg, rekey, buffer_size=None, random_max=None):
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=rekey,
+                 buffer_size=buffer_size, random_max=random_max)
+
+
+@ksft_variants([
+    KsftNamedVariant("burst_tx_rekey_every_1",        "client", False, 1,     50, 65536),
+    KsftNamedVariant("burst_tx_rekey_every_1000",     "client", False, 1000,  3,  65536),
+    KsftNamedVariant("burst_rx_rekey_every_10",       "server", False, 10,    20, 65536),
+    KsftNamedVariant("burst_rx_rekey_every_10000",    "server", False, 10000, 1,  32768),
+    KsftNamedVariant("burst_rx_zc_rekey_every_100",   "server", True,  100,   10, 65536),
+    KsftNamedVariant("burst_rx_zc_rekey_every_20000", "server", True,  20000, 1,  16384),
+])
+def test_tls_offload_burst(cfg, dut_role, zc, interval, rekeys, buffer_size):
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=rekeys,
+                 buffer_size=buffer_size, burst=True, zc=zc, dut_role=dut_role,
+                 num_iterations=interval * (rekeys + 1))
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        cfg.bin_local = cfg.test_dir / "tls_hw_offload"
+        if not cfg.bin_local.exists():
+            raise KsftSkipEx(f"tls_hw_offload binary not found at {cfg.bin_local}")
+        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
+        cfg.require_ipver("4")
+        check_tls_support(cfg)
+
+        ksft_run([test_tls_offload, test_tls_offload_rekey,
+                  test_tls_offload_burst], args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.25.1


