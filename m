Return-Path: <netdev+bounces-257364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDTbAYwlhWlV9AMAu9opvQ
	(envelope-from <netdev+bounces-257364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 00:19:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32D35F8507
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 00:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0740300FECB
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 23:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C152933ADAD;
	Thu,  5 Feb 2026 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="MBGEGL8j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3930033A712
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770333500; cv=none; b=kbqbyDFB5FHzth5fc8WVaIeEBi2OfQCxPOWMK/zQWhQOQHHqmZ46/ZlE2e/4ilUbki5VC+ymrkQlz/INlQ5iXonfMQP2h5DoJSmcNBk30sFX63Jrp4ZfucjDB58XfzBk2x3yX7550GUFVCAkrOfTuGS573jqYi3Npd7B+d7u58c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770333500; c=relaxed/simple;
	bh=B84rtw2/7Uzj9jrv6kzF5GHZ/l7EZybUEntUB74CG4s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wax20bbnexPCXKz8LT3GPJNr939tF2iIy4Rs0aHxsf5C+E9yqMy8lnUDZ/qMelZWjDMv6yQTrayCkF4YwTF9r3nnoEA50t9ew/XrxT0QjYaAmihycj8/evhcxP0JErQDSBP1j7eknppCh2GaHnpjyZ9/Wabnxg9O5qvPlKvvTYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=MBGEGL8j; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b8e526081ceso404085066b.1
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 15:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1770333498; x=1770938298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCwee1CIsaoXh6ldYYhunKg6+Tp3W1eNA/yh/ksM8jc=;
        b=MBGEGL8jYnblaL35wwYskwqXzsDuguMvHF4FBM82Uv+Wokvj7eaj6Q80IMZtrhvusS
         DebY8vSdW/UL3YQdDHQcsKJLaCPyDRWesRcloqBLWHAewYrAPux6WEQonIrYZDipLAZN
         KwBkUQ1O6qcjUsX4UJ/QD/94NZXC93TyhcnuAAP9uXEK6+1N5IHEVNI6TPVYFOoDhdb+
         km7i85SDBraMe0nZx83AS0ni2+zXfbtfjxNtlID6gidhoJJFu1/iXuMx4svg1jVOv6/+
         qgBHYKkZnji14wAxha1Bos0hJYY+Ui2eNGKg3M8eoMIxm+JaJaB4abUxC5/pbxJoLrGL
         72cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770333498; x=1770938298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCwee1CIsaoXh6ldYYhunKg6+Tp3W1eNA/yh/ksM8jc=;
        b=KQen8E4HKI19PNlqym88xHPrZd6my9NV1iFGZl/wBHNDWp7Im7J6QyNg3iNiNsFqLE
         q1RRRno0/eSoDp4RIy+KulNp96v3BBw0UNPx1qgpp+6Myb+uN2rbDoiPY6AkURLqo4Zs
         fb61tgAMnY5WhXt6f5fzFtEDtBd414RGtbITw24PHbAv3uVMqwbF7X7iQZ1dOJZwY/4L
         yUs7g43u3jmQbsVlzRQleN4Jb9a1sh4adE0B6okebiRynaNG4Jbm507b69A3mnWCQnUr
         hcOIIlLol9oGyHklgdDbAc+jkH6J4W3DyC78ObvQ/MhY/xG2oMl31mXKaCVkgoOcEmkf
         rp3Q==
X-Gm-Message-State: AOJu0YwBlk2W6K8ZRNqSJOi6gNcRjJTh97Y1MgW8IJD3eeeXkjLJXABd
	l3NFIz0VDEVW8dznv6IaVMM72wRwmopfDJ2TCmyJs/IL/XAWUHPLaQpf9ewoKpC6Z3Jr0xW3Wv4
	m9cciGRLOL0jRufk4L6ntb5+nU/WcSatBkfxYNF4Ssol5xmEMkyNqWIUexkpgJly+dg+2KZ+ccF
	Iv57CccxhnT+D47YDZXAVml7m2ZBw1wHYWCp6EoIocnjgClp/USA==
X-Gm-Gg: AZuq6aL5xlJJTPpcEcOVXHkta0tIlOIODosAZEbpsH3Ar+LGCQHyYtu0YOUE3/jhZ98
	dXsxtT7Q7Rr8jhGo72Jccba0VCbZyxXnb5IF6FUtw4qfnH2DRJ8lNXzRwxxAwMYXc419mBFAyC1
	+HPcSElpMMQZqS3WSsD/W6h8b/qVbAkSKcVd9+K/IBYWk5P+nAGk3Zwt1Qmx1BP55Wvhk178O/o
	mdIz2YknUvYExrlXiELgFSVYx1/nFJUm9S5jk/UhPuV9SPChN9/zakCGh5UPLPEpno34Dvjzmks
	odzEZnK06jtXgfH6MdAhLsl8EMzC5voUGf991C+iLJ6ZbpCkzqKZcmNwUBgEVj1MhXXDpY+hJc6
	DeCkkDcEePjm9bu8/LRRIFaINm+c3otIf9ovcX+PJYNrPkBnv/P76WXWbeR6bGlbwEcwH514tvL
	Qtljn0XbfBAFvUWSa9PefhGvhBkTFJ2iNE17Go3JiO2IT5aPAdOK50YjZu32JclMp5nVV/hn53R
	A==
X-Received: by 2002:a17:906:d54e:b0:b87:2abc:4a2a with SMTP id a640c23a62f3a-b8edb7e7fefmr52966766b.1.1770333497971;
        Thu, 05 Feb 2026 15:18:17 -0800 (PST)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b8eda74c415sm26649166b.7.2026.02.05.15.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 15:18:17 -0800 (PST)
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
Subject: [RFC PATCH v7 4/4] selftests: drivers: net: hw: add TLS hardware offload test
Date: Thu,  5 Feb 2026 16:15:58 -0700
Message-Id: <20260205231558.139818-5-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260205231558.139818-1-rjethwani@purestorage.com>
References: <20260205231558.139818-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,reject];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257364-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[purestorage.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 32D35F8507
X-Rspamd-Action: no action

Add TLS hardware offload test using the NetDrvEpEnv framework. The test
requires two physical endpoints to trigger actual NIC hardware offload.

The test consists of:
  - Python wrapper (tls_hw_offload.py): orchestrates tests, reads and
    verifies /proc/net/tls_stat counters on both endpoints
  - C binary (tls_hw_offload.c): performs TLS operations using kTLS
    with hardcoded keys

Test coverage (9 tests):
  - TLS 1.2/1.3 with AES-GCM-128/256
  - TLS 1.3 rekey (1x and 3x)
  - Buffer sizes: 512B, 16KB, 32KB, random (1-8KB)

Validates hardware offload via TlsTxDevice/TlsRxDevice counters and
rekey operations via TlsTxRekeyOk/TlsRxRekeyOk counters.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 .../testing/selftests/drivers/net/hw/Makefile |    2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c | 1009 +++++++++++++++++
 .../drivers/net/hw/tls_hw_offload.py          |  353 ++++++
 3 files changed, 1364 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

diff --git a/tools/testing/selftests/drivers/net/hw/Makefile b/tools/testing/selftests/drivers/net/hw/Makefile
index 9c163ba6feee..0d12e26bc665 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -15,6 +15,7 @@ endif
 
 TEST_GEN_FILES := \
 	$(COND_GEN_FILES) \
+	tls_hw_offload \
 # end of TEST_GEN_FILES
 
 TEST_PROGS = \
@@ -37,6 +38,7 @@ TEST_PROGS = \
 	rss_ctx.py \
 	rss_flow_label.py \
 	rss_input_xfrm.py \
+	tls_hw_offload.py \
 	toeplitz.py \
 	tso.py \
 	xsk_reconfig.py \
diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
new file mode 100644
index 000000000000..fa19af2b79c8
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
@@ -0,0 +1,1009 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TLS Hardware Offload Two-Node Test
+ *
+ * This test uses hardcoded keys (no TLS handshake) to test kTLS
+ * hardware offload between two physical nodes. Both nodes must
+ * use the same key material.
+ *
+ * For rekey testing, proper TLS KeyUpdate handshake messages are
+ * sent via sendmsg/recvmsg with TLS_SET_RECORD_TYPE/TLS_GET_RECORD_TYPE.
+ *
+ * This binary performs TLS operations only. Counter verification is
+ * handled by the Python test wrapper (tls_hw_offload.py) which reads
+ * /proc/net/tls_stat before and after the test.
+ *
+ * Usage:
+ *   Server: ./tls_hw_offload server [OPTIONS]
+ *   Client: ./tls_hw_offload client -s <ip> [OPTIONS]
+ *
+ * Options:
+ *   -s <ip>    Server IP (client only, required)
+ *   -p <port>  Port number (default: 4433)
+ *   -c <128|256>  Cipher (default: 128)
+ *   -v <1.2|1.3>  TLS version (default: 1.3)
+ *   -b <size>  Fixed buffer size (default: 16384)
+ *   -r <max>   Random buffer sizes from 1 to max
+ *   --rekey[=N]   Enable rekey testing (default: 1, max: 4)
+ *
+ * Example:
+ *   Node A: ./tls_hw_offload server
+ *   Node B: ./tls_hw_offload client -s 192.168.20.2
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
+#include <sys/ioctl.h>
+#include <netinet/in.h>
+#include <netinet/tcp.h>
+#include <arpa/inet.h>
+#include <linux/tls.h>
+
+/* TLS record types for sendmsg/recvmsg with kTLS */
+#define TLS_RECORD_TYPE_HANDSHAKE		22
+#define TLS_RECORD_TYPE_APPLICATION_DATA	23
+
+/* TLS 1.3 KeyUpdate handshake message type (RFC 8446) */
+#define TLS_HANDSHAKE_KEY_UPDATE	0x18
+#define KEY_UPDATE_NOT_REQUESTED	0
+#define KEY_UPDATE_REQUESTED		1
+
+/* Number of messages to send in the test loop */
+#define TEST_ITERATIONS	10
+
+/*
+ * Maximum number of rekeys allowed per test run.
+ * With TEST_ITERATIONS=10, this ensures at least 2 messages between rekeys.
+ */
+#define MAX_REKEYS	4
+
+/* TLS 1.3 AES-GCM-128 key material - initial key (generation 0) */
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
+/* TLS 1.3 AES-GCM-256 key material - initial key (generation 0) */
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
+static int do_rekey;           /* Set via command line */
+static int num_rekeys = 1;     /* Number of rekeys to perform */
+static int rekeys_done;        /* Counter for completed rekeys */
+
+/* Cipher selection: 128 or 256 */
+static int cipher_type = 128;
+
+/* TLS version: 12 for TLS 1.2, 13 for TLS 1.3 (default) */
+static int tls_version = 13;
+
+/* Server port (default: 4433) */
+static int server_port = 4433;
+
+/* Server IP for client to connect to */
+static char *server_ip;
+
+/* Send buffer size (default: 16384) */
+static int send_size = 16384;
+
+/* Random send size max (0 = disabled, use fixed send_size) */
+static int random_size_max;
+
+/*
+ * Derive AES-GCM-128 key for a given generation number.
+ * Both sides use the same derivation so keys match.
+ * Generation 0 = initial key, Generation N = Nth rekey.
+ */
+static void derive_key_128(struct tls12_crypto_info_aes_gcm_128 *key,
+			   int generation)
+{
+	unsigned char pattern;
+	int i;
+
+	/* Start with initial key */
+	memcpy(key, &tls_info_key0_128, sizeof(*key));
+
+	/* Set TLS version based on global setting */
+	if (tls_version == 12)
+		key->info.version = TLS_1_2_VERSION;
+	else
+		key->info.version = TLS_1_3_VERSION;
+
+	if (generation == 0)
+		return;
+
+	/* Derive new key by XORing with generation-based pattern */
+	pattern = (unsigned char)((generation * 0x1B) ^ 0x63);
+
+	for (i = 0; i < TLS_CIPHER_AES_GCM_128_KEY_SIZE; i++) {
+		key->key[i] ^= pattern;
+		pattern = (pattern << 1) | (pattern >> 7);  /* Rotate */
+	}
+
+	pattern = (unsigned char)((generation * 0x2D) ^ 0x7C);
+	for (i = 0; i < TLS_CIPHER_AES_GCM_128_IV_SIZE; i++) {
+		key->iv[i] ^= pattern;
+		pattern = (pattern << 1) | (pattern >> 7);
+	}
+
+	for (i = 0; i < TLS_CIPHER_AES_GCM_128_SALT_SIZE; i++)
+		key->salt[i] ^= (unsigned char)(generation & 0xFF);
+
+	/* Reset record sequence for new key */
+	memset(key->rec_seq, 0, TLS_CIPHER_AES_GCM_128_REC_SEQ_SIZE);
+}
+
+/*
+ * Derive AES-GCM-256 key for a given generation number.
+ */
+static void derive_key_256(struct tls12_crypto_info_aes_gcm_256 *key,
+			   int generation)
+{
+	unsigned char pattern;
+	int i;
+
+	/* Start with initial key */
+	memcpy(key, &tls_info_key0_256, sizeof(*key));
+
+	/* Set TLS version based on global setting */
+	if (tls_version == 12)
+		key->info.version = TLS_1_2_VERSION;
+	else
+		key->info.version = TLS_1_3_VERSION;
+
+	if (generation == 0)
+		return;
+
+	/* Derive new key by XORing with generation-based pattern */
+	pattern = (unsigned char)((generation * 0x1B) ^ 0x63);
+
+	for (i = 0; i < TLS_CIPHER_AES_GCM_256_KEY_SIZE; i++) {
+		key->key[i] ^= pattern;
+		pattern = (pattern << 1) | (pattern >> 7);  /* Rotate */
+	}
+
+	pattern = (unsigned char)((generation * 0x2D) ^ 0x7C);
+	for (i = 0; i < TLS_CIPHER_AES_GCM_256_IV_SIZE; i++) {
+		key->iv[i] ^= pattern;
+		pattern = (pattern << 1) | (pattern >> 7);
+	}
+
+	for (i = 0; i < TLS_CIPHER_AES_GCM_256_SALT_SIZE; i++)
+		key->salt[i] ^= (unsigned char)(generation & 0xFF);
+
+	/* Reset record sequence for new key */
+	memset(key->rec_seq, 0, TLS_CIPHER_AES_GCM_256_REC_SEQ_SIZE);
+}
+
+/* Return human-readable cipher name for logging */
+static const char *cipher_name(int cipher)
+{
+	switch (cipher) {
+	case 128: return "AES-GCM-128";
+	case 256: return "AES-GCM-256";
+	default: return "unknown";
+	}
+}
+
+/* Return human-readable TLS version name for logging */
+static const char *version_name(int version)
+{
+	switch (version) {
+	case 12: return "TLS 1.2";
+	case 13: return "TLS 1.3";
+	default: return "unknown";
+	}
+}
+
+/* Enable kTLS by setting TCP Upper Layer Protocol to "tls" */
+static int setup_tls_ulp(int fd)
+{
+	int ret;
+
+	ret = setsockopt(fd, IPPROTO_TCP, TCP_ULP, "tls", sizeof("tls"));
+	if (ret < 0) {
+		printf("TCP_ULP failed: %s\n", strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
+/*
+ * Install TLS key for TX or RX direction.
+ * Derives key material for the given generation and installs it via setsockopt.
+ */
+static int setup_tls_key(int fd, int is_tx, int generation, int cipher)
+{
+	int ret;
+
+	if (cipher == 256) {
+		struct tls12_crypto_info_aes_gcm_256 key;
+
+		derive_key_256(&key, generation);
+		ret = setsockopt(fd, SOL_TLS, is_tx ? TLS_TX : TLS_RX,
+				 &key, sizeof(key));
+	} else {
+		struct tls12_crypto_info_aes_gcm_128 key;
+
+		derive_key_128(&key, generation);
+		ret = setsockopt(fd, SOL_TLS, is_tx ? TLS_TX : TLS_RX,
+				 &key, sizeof(key));
+	}
+
+	if (ret < 0) {
+		printf("TLS_%s %s (gen %d) failed: %s\n",
+		       is_tx ? "TX" : "RX", cipher_name(cipher),
+		       generation, strerror(errno));
+		return -1;
+	}
+
+	printf("TLS_%s %s gen %d installed\n",
+	       is_tx ? "TX" : "RX", cipher_name(cipher), generation);
+	return 0;
+}
+
+/*
+ * Send a TLS 1.3 KeyUpdate handshake message via kTLS.
+ *
+ * This signals to the peer's kernel kTLS layer that we are updating
+ * our TX key. The peer must receive this before updating their RX key.
+ *
+ * KeyUpdate message format (RFC 8446):
+ *   HandshakeType: key_update (24/0x18)  - 1 byte
+ *   Length: 1                            - 3 bytes (24-bit)
+ *   KeyUpdateRequest: 0 or 1             - 1 byte
+ * Total: 5 bytes
+ */
+static int send_tls_key_update(int fd, int request_update)
+{
+	char cmsg_buf[CMSG_SPACE(sizeof(unsigned char))];
+	unsigned char key_update_msg[5];
+	struct msghdr msg = {0};
+	struct cmsghdr *cmsg;
+	struct iovec iov;
+
+	/* Build TLS 1.3 KeyUpdate handshake message */
+	key_update_msg[0] = TLS_HANDSHAKE_KEY_UPDATE;  /* HandshakeType */
+	key_update_msg[1] = 0;                         /* Length (24-bit) */
+	key_update_msg[2] = 0;
+	key_update_msg[3] = 1;                         /* Length = 1 */
+	key_update_msg[4] = request_update ? KEY_UPDATE_REQUESTED
+					   : KEY_UPDATE_NOT_REQUESTED;
+
+	iov.iov_base = key_update_msg;
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
+/*
+ * Receive a TLS message and get its record type via cmsg.
+ * Returns bytes received, or -1 on error.
+ */
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
+	*record_type = TLS_RECORD_TYPE_APPLICATION_DATA;  /* default */
+
+	cmsg = CMSG_FIRSTHDR(&msg);
+	if (cmsg && cmsg->cmsg_level == SOL_TLS &&
+	    cmsg->cmsg_type == TLS_GET_RECORD_TYPE)
+		*record_type = *((unsigned char *)CMSG_DATA(cmsg));
+
+	return ret;
+}
+
+/*
+ * Receive and verify a TLS KeyUpdate handshake message.
+ * Returns 0 on success, -1 on error.
+ */
+static int recv_tls_keyupdate(int fd)
+{
+	int record_type;
+	char buf[16];
+	int ret;
+
+	ret = recv_tls_message(fd, buf, sizeof(buf), &record_type);
+	if (ret < 0) {
+		printf("recv_tls_message failed: %s\n", strerror(errno));
+		return -1;
+	}
+
+	if (record_type != TLS_RECORD_TYPE_HANDSHAKE) {
+		printf("Expected handshake record (0x%02x), got 0x%02x\n",
+		       TLS_RECORD_TYPE_HANDSHAKE, record_type);
+		return -1;
+	}
+
+	if (ret >= 1 && buf[0] == TLS_HANDSHAKE_KEY_UPDATE) {
+		printf("Received TLS KeyUpdate handshake (%d bytes)\n", ret);
+		return 0;
+	}
+
+	printf("Expected KeyUpdate (0x%02x), got 0x%02x\n",
+	       TLS_HANDSHAKE_KEY_UPDATE, (unsigned char)buf[0]);
+	return -1;
+}
+
+/*
+ * Check for EKEYEXPIRED after receiving KeyUpdate.
+ * The kernel returns this to signal it's waiting for RX key update.
+ */
+static void check_ekeyexpired(int fd)
+{
+	char buf[16];
+	int ret;
+
+	ret = recv(fd, buf, sizeof(buf), MSG_DONTWAIT);
+	if (ret == -1 && errno == EKEYEXPIRED)
+		printf("recv() returned EKEYEXPIRED as expected\n");
+	else if (ret == -1 && errno == EAGAIN)
+		printf("recv() returned EAGAIN (no pending data)\n");
+	else if (ret == -1)
+		printf("recv() returned error: %s\n", strerror(errno));
+}
+
+/*
+ * Update kTLS key (TX or RX direction) for a given generation.
+ */
+static int do_tls_rekey(int fd, int is_tx, int generation, int cipher)
+{
+	int ret;
+
+	printf("Performing TLS_%s %s rekey to generation %d...\n",
+	       is_tx ? "TX" : "RX", cipher_name(cipher), generation);
+
+	if (cipher == 256) {
+		struct tls12_crypto_info_aes_gcm_256 key;
+
+		derive_key_256(&key, generation);
+		ret = setsockopt(fd, SOL_TLS, is_tx ? TLS_TX : TLS_RX,
+				 &key, sizeof(key));
+	} else {
+		struct tls12_crypto_info_aes_gcm_128 key;
+
+		derive_key_128(&key, generation);
+		ret = setsockopt(fd, SOL_TLS, is_tx ? TLS_TX : TLS_RX,
+				 &key, sizeof(key));
+	}
+
+	if (ret < 0) {
+		printf("TLS_%s %s rekey failed: %s\n", is_tx ? "TX" : "RX",
+		       cipher_name(cipher), strerror(errno));
+		return -1;
+	}
+	printf("TLS_%s %s rekey to gen %d successful!\n",
+	       is_tx ? "TX" : "RX", cipher_name(cipher), generation);
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
+	int test_result = 0;
+	int current_gen = 0;
+	int next_rekey_at;
+	ssize_t n;
+
+	if (!server_ip) {
+		printf("ERROR: Client requires -s <ip> option\n");
+		return -1;
+	}
+
+	/* Allocate buffers based on max possible size */
+	max_size = random_size_max > 0 ? random_size_max : send_size;
+	buf = malloc(max_size);
+	echo_buf = malloc(max_size);
+	if (!buf || !echo_buf) {
+		printf("failed to allocate buffers\n");
+		test_result = -1;
+		goto out;
+	}
+
+	csk = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	if (csk < 0) {
+		printf("failed to create socket: %s\n", strerror(errno));
+		test_result = -1;
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
+		printf("connect failed: %s\n", strerror(errno));
+		test_result = -1;
+		goto out;
+	}
+	printf("Connected!\n");
+
+	/* Setup TLS ULP first */
+	if (setup_tls_ulp(csk) < 0) {
+		test_result = -1;
+		goto out;
+	}
+
+	/* Setup TLS TX and RX with initial key (generation 0) */
+	if (setup_tls_key(csk, 1, 0, cipher_type) < 0) {  /* TLS_TX, key0 */
+		test_result = -1;
+		goto out;
+	}
+	if (setup_tls_key(csk, 0, 0, cipher_type) < 0) {  /* TLS_RX, key0 */
+		test_result = -1;
+		goto out;
+	}
+
+	if (do_rekey)
+		printf("TLS %s setup complete. Will perform %d rekey(s).\n",
+		       cipher_name(cipher_type), num_rekeys);
+	else
+		printf("TLS setup complete.\n");
+
+	if (random_size_max > 0)
+		printf("Sending %d messages of random size (1..%d bytes)...\n",
+		       TEST_ITERATIONS, random_size_max);
+	else
+		printf("Sending %d messages of %d bytes...\n",
+		       TEST_ITERATIONS, send_size);
+
+	/*
+	 * Calculate rekey interval to spread rekeys evenly across messages.
+	 * With N rekeys and M messages, rekey every M/(N+1) messages.
+	 */
+	rekey_interval = TEST_ITERATIONS / (num_rekeys + 1);
+	if (rekey_interval < 1)
+		rekey_interval = 1;
+	next_rekey_at = rekey_interval;
+
+	/* Send test data */
+	for (i = 0; i < TEST_ITERATIONS; i++) {
+		int this_size;
+
+		/* Determine size for this message */
+		if (random_size_max > 0)
+			this_size = (rand() % random_size_max) + 1;
+		else
+			this_size = send_size;
+
+		/* Fill buffer with random data */
+		for (j = 0; j < this_size; j++)
+			buf[j] = rand() & 0xFF;
+
+		n = send(csk, buf, this_size, 0);
+		if (n != this_size) {
+			printf("FAIL: send failed: %s\n", strerror(errno));
+			test_result = -1;
+			break;
+		}
+		printf("Sent %zd bytes (iteration %d)\n", n, i + 1);
+
+		/* Wait for echo from server - may need multiple recv() calls */
+		echo_total = 0;
+		while (echo_total < n) {
+			echo_n = recv(csk, echo_buf + echo_total,
+				      n - echo_total, 0);
+			if (echo_n < 0) {
+				printf("FAIL: Echo recv failed: %s\n",
+				       strerror(errno));
+				test_result = -1;
+				break;
+			}
+			if (echo_n == 0) {
+				printf("FAIL: Connection closed during echo\n");
+				test_result = -1;
+				break;
+			}
+			echo_total += echo_n;
+		}
+		if (test_result != 0)
+			break;
+		/* Verify echo data matches what we sent */
+		if (memcmp(buf, echo_buf, n) != 0) {
+			printf("FAIL: Echo data mismatch!\n");
+			test_result = -1;
+			break;
+		}
+		printf("Received echo %zd bytes (ok)\n", echo_total);
+
+		/*
+		 * Perform rekey at intervals if enabled.
+		 *
+		 * kTLS Rekey Protocol (client side):
+		 * 1. Send TLS KeyUpdate handshake message (with OLD TX key)
+		 * 2. Update TX key via setsockopt
+		 * 3. Wait for server's KeyUpdate response
+		 * 4. Update RX key via setsockopt
+		 */
+		if (do_rekey && rekeys_done < num_rekeys &&
+		    (i + 1) == next_rekey_at) {
+			current_gen++;
+			printf("\n=== Client Rekey #%d (gen %d) ===\n",
+			       rekeys_done + 1, current_gen);
+
+			/* Step 1: Send KeyUpdate to server */
+			printf("Step 1: Sending TLS KeyUpdate to server\n");
+			ret = send_tls_key_update(csk, KEY_UPDATE_REQUESTED);
+			if (ret < 0) {
+				printf("FAIL: send KeyUpdate\n");
+				test_result = -1;
+				break;
+			}
+
+			/* Step 2: Update client TX key */
+			printf("Step 2: Updating client TX key\n");
+			ret = do_tls_rekey(csk, 1, current_gen, cipher_type);
+			if (ret < 0) {
+				test_result = -1;
+				break;
+			}
+
+			/* Step 3: Wait for server's KeyUpdate */
+			printf("Step 3: Waiting for server's KeyUpdate\n");
+			if (recv_tls_keyupdate(csk) < 0) {
+				printf("FAIL: recv KeyUpdate from server\n");
+				test_result = -1;
+				break;
+			}
+
+			/* Check for EKEYEXPIRED */
+			check_ekeyexpired(csk);
+
+			/* Step 4: Update client RX key */
+			printf("Step 4: Updating client RX key\n");
+			ret = do_tls_rekey(csk, 0, current_gen, cipher_type);
+			if (ret < 0) {
+				test_result = -1;
+				break;
+			}
+
+			rekeys_done++;
+			next_rekey_at += rekey_interval;
+			printf("=== Client Rekey #%d Complete ===\n\n",
+			       rekeys_done);
+		}
+	}
+
+	/* Check that all iterations completed */
+	if (i < TEST_ITERATIONS && test_result == 0) {
+		printf("FAIL: Only %d of %d iterations\n", i, TEST_ITERATIONS);
+		test_result = -1;
+	}
+
+	close(csk);
+	csk = -1;
+	if (do_rekey)
+		printf("Rekeys completed: %d/%d\n", rekeys_done, num_rekeys);
+
+out:
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
+	struct sockaddr_in sa;
+	int current_gen = 0;
+	int test_result = 0;
+	int recv_count = 0;
+	char *buf = NULL;
+	int record_type;
+	int max_size;
+	int one = 1;
+
+	/* Allocate buffer based on max possible size */
+	max_size = random_size_max > 0 ? random_size_max : send_size;
+	buf = malloc(max_size);
+	if (!buf) {
+		printf("failed to allocate buffer\n");
+		test_result = -1;
+		goto out;
+	}
+
+	lsk = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	if (lsk < 0) {
+		printf("failed to create socket: %s\n", strerror(errno));
+		test_result = -1;
+		goto out;
+	}
+
+	setsockopt(lsk, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
+
+	/* Bind to INADDR_ANY:PORT */
+	memset(&sa, 0, sizeof(sa));
+	sa.sin_family = AF_INET;
+	sa.sin_addr.s_addr = INADDR_ANY;
+	sa.sin_port = htons(server_port);
+
+	ret = bind(lsk, (struct sockaddr *)&sa, sizeof(sa));
+	if (ret < 0) {
+		printf("bind failed: %s\n", strerror(errno));
+		test_result = -1;
+		goto out;
+	}
+
+	ret = listen(lsk, 5);
+	if (ret < 0) {
+		printf("listen failed: %s\n", strerror(errno));
+		test_result = -1;
+		goto out;
+	}
+
+	printf("Server listening on port %d\n", server_port);
+	printf("Waiting for client connection...\n");
+
+	csk = accept(lsk, (struct sockaddr *)NULL, (socklen_t *)NULL);
+	if (csk < 0) {
+		printf("accept failed: %s\n", strerror(errno));
+		test_result = -1;
+		goto out;
+	}
+	printf("Client connected!\n");
+
+	/* Setup TLS ULP first */
+	if (setup_tls_ulp(csk) < 0) {
+		test_result = -1;
+		goto out;
+	}
+
+	/* Setup TLS TX and RX with initial key (generation 0) */
+	if (setup_tls_key(csk, 1, 0, cipher_type) < 0) {  /* TLS_TX, key0 */
+		test_result = -1;
+		goto out;
+	}
+	if (setup_tls_key(csk, 0, 0, cipher_type) < 0) {  /* TLS_RX, key0 */
+		test_result = -1;
+		goto out;
+	}
+
+	printf("TLS %s setup complete. Receiving...\n",
+	       cipher_name(cipher_type));
+
+	/*
+	 * Main receive loop using recvmsg to detect KeyUpdate messages.
+	 *
+	 * kTLS Rekey Protocol (server side):
+	 * 1. Receive TLS KeyUpdate handshake from client
+	 * 2. Check for EKEYEXPIRED
+	 * 3. Update RX key via setsockopt
+	 * 4. Send TLS KeyUpdate back to client
+	 * 5. Update TX key via setsockopt
+	 *
+	 * Per kernel kTLS test pattern (from selftests/net/tls.c):
+	 * - First try plain recv with MSG_PEEK | MSG_DONTWAIT
+	 * - If it fails with EIO/ENOMSG, a handshake record is pending
+	 * - Use recvmsg with cmsg to get the actual record type
+	 */
+	while (1) {
+		/*
+		 * First try plain recv - this fails for non-data records.
+		 * This pattern is from tls_keyupdate_test.c which works.
+		 */
+		n = recv(csk, buf, max_size, MSG_PEEK | MSG_DONTWAIT);
+		if (n < 0 &&
+		    (errno == EIO || errno == ENOMSG || errno == EAGAIN)) {
+			/* Handshake record or no data - use recvmsg */
+			if (errno != EAGAIN)
+				printf("DEBUG: recv -1 (errno=%d: %s)\n",
+				       errno, strerror(errno));
+			n = recv_tls_message(csk, buf, max_size, &record_type);
+		} else if (n > 0) {
+			/* Application data - receive it properly */
+			n = recv_tls_message(csk, buf, max_size, &record_type);
+		} else if (n == 0) {
+			printf("Connection closed by client\n");
+			break;
+		}
+
+		/* Other error from MSG_PEEK recv */
+		if (n < 0) {
+			printf("recv failed: %s\n", strerror(errno));
+			break;
+		}
+
+		if (n <= 0) {
+			if (n == 0)
+				printf("Connection closed by client\n");
+			else
+				printf("recv_tls_message: %s\n",
+				       strerror(errno));
+			break;
+		}
+
+		/* Check if we received a TLS KeyUpdate handshake message */
+		if (record_type == TLS_RECORD_TYPE_HANDSHAKE &&
+		    n >= 1 && buf[0] == TLS_HANDSHAKE_KEY_UPDATE) {
+			current_gen++;
+			printf("\n=== Server Rekey #%d (gen %d) ===\n",
+			       rekeys_done + 1, current_gen);
+			printf("Received KeyUpdate from client (%zd bytes)\n",
+			       n);
+
+			/* Step 1: Check for EKEYEXPIRED */
+			printf("Step 1: Checking for EKEYEXPIRED\n");
+			check_ekeyexpired(csk);
+
+			/* Step 2: Update server RX key */
+			printf("Step 2: Updating server RX key\n");
+			ret = do_tls_rekey(csk, 0, current_gen, cipher_type);
+			if (ret < 0) {
+				test_result = -1;
+				break;
+			}
+
+			/* Step 3: Send KeyUpdate back to client */
+			printf("Step 3: Sending TLS KeyUpdate to client\n");
+			ret = send_tls_key_update(csk,
+						  KEY_UPDATE_NOT_REQUESTED);
+			if (ret < 0) {
+				printf("Failed to send KeyUpdate\n");
+				test_result = -1;
+				break;
+			}
+
+			/* Step 4: Update server TX key */
+			printf("Step 4: Updating server TX key\n");
+			ret = do_tls_rekey(csk, 1, current_gen, cipher_type);
+			if (ret < 0) {
+				test_result = -1;
+				break;
+			}
+
+			rekeys_done++;
+			printf("=== Server Rekey #%d Complete ===\n\n",
+			       rekeys_done);
+			continue;
+		}
+
+		/* Application data */
+		total += n;
+		recv_count++;
+		printf("Received %zd bytes (total: %zd, count: %d)\n",
+		       n, total, recv_count);
+
+		/* Echo data back to client */
+		sent = send(csk, buf, n, 0);
+		if (sent < 0) {
+			printf("Echo send failed: %s\n", strerror(errno));
+			break;
+		}
+		if (sent != n)
+			printf("Echo partial: %zd of %zd bytes\n", sent, n);
+		printf("Echoed %zd bytes back to client\n", sent);
+	}
+
+	printf("Connection closed. Total received: %zd bytes\n", total);
+	if (do_rekey)
+		printf("Rekeys completed: %d\n", rekeys_done);
+
+	close(csk);
+	csk = -1;
+	close(lsk);
+	lsk = -1;
+
+out:
+	if (csk >= 0)
+		close(csk);
+	if (lsk >= 0)
+		close(lsk);
+	free(buf);
+	return test_result;
+}
+
+static void parse_rekey_option(const char *arg)
+{
+	int requested;
+
+	/* Parse --rekey or --rekey=N */
+	if (strncmp(arg, "--rekey=", 8) == 0) {
+		requested = atoi(arg + 8);
+		if (requested < 1) {
+			printf("WARNING: Invalid rekey count, using 1\n");
+			num_rekeys = 1;
+		} else if (requested > MAX_REKEYS) {
+			printf("WARNING: Rekey count %d > max %d, using %d\n",
+			       requested, MAX_REKEYS, MAX_REKEYS);
+			num_rekeys = MAX_REKEYS;
+		} else {
+			num_rekeys = requested;
+		}
+		do_rekey = 1;
+	} else if (strcmp(arg, "--rekey") == 0) {
+		do_rekey = 1;
+		num_rekeys = 1;
+	}
+}
+
+static int parse_cipher_option(const char *arg)
+{
+	/* Parse -c <cipher> where cipher is 128 or 256 */
+	if (strcmp(arg, "128") == 0) {
+		cipher_type = 128;
+		return 0;
+	} else if (strcmp(arg, "256") == 0) {
+		cipher_type = 256;
+		return 0;
+	}
+	printf("ERROR: Invalid cipher '%s'. Must be 128 or 256.\n", arg);
+	return -1;
+}
+
+static int parse_version_option(const char *arg)
+{
+	/* Parse -v <version> where version is 1.2 or 1.3 */
+	if (strcmp(arg, "1.2") == 0) {
+		tls_version = 12;
+		return 0;
+	} else if (strcmp(arg, "1.3") == 0) {
+		tls_version = 13;
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
+	printf("  -s <ip>       Server IP to connect (client, required)\n");
+	printf("  -p <port>     Server port (default: 4433)\n");
+	printf("  -b <size>     Send buffer (record) size (default: 16384)\n");
+	printf("  -r <max>      Use random send buffer sizes (1..<max>)\n");
+	printf("  -v <version>  TLS version: 1.2 or 1.3 (default: 1.3)\n");
+	printf("  -c <cipher>   Cipher: 128 or 256 (default: 128)\n");
+	printf("  --rekey[=N]   Enable rekey (default: 1, TLS 1.3 only)\n");
+	printf("  --help        Show this help message\n");
+	printf("\nExample:\n");
+	printf("  Node A: %s server\n", prog);
+	printf("  Node B: %s client -s 192.168.20.2\n", prog);
+	printf("\nRekey Example (3 rekeys, TLS 1.3 only):\n");
+	printf("  Node A: %s server --rekey=3\n", prog);
+	printf("  Node B: %s client -s 192.168.20.2 --rekey=3\n", prog);
+}
+
+int main(int argc, char *argv[])
+{
+	int i;
+
+	/* Check for --help first */
+	for (i = 1; i < argc; i++) {
+		if (strcmp(argv[i], "--help") == 0 ||
+		    strcmp(argv[i], "-h") == 0) {
+			print_usage(argv[0]);
+			return 0;
+		}
+	}
+
+	/* Parse options anywhere in args */
+	for (i = 1; i < argc; i++) {
+		parse_rekey_option(argv[i]);
+		if (strcmp(argv[i], "-s") == 0 && i + 1 < argc)
+			server_ip = argv[i + 1];
+		if (strcmp(argv[i], "-p") == 0 && i + 1 < argc)
+			server_port = atoi(argv[i + 1]);
+		if (strcmp(argv[i], "-b") == 0 && i + 1 < argc) {
+			send_size = atoi(argv[i + 1]);
+			if (send_size < 1)
+				send_size = 1;
+		}
+		if (strcmp(argv[i], "-r") == 0 && i + 1 < argc) {
+			random_size_max = atoi(argv[i + 1]);
+			if (random_size_max < 1)
+				random_size_max = 1;
+		}
+		if (strcmp(argv[i], "-c") == 0 && i + 1 < argc) {
+			if (parse_cipher_option(argv[i + 1]) < 0)
+				return -1;
+		}
+		if (strcmp(argv[i], "-v") == 0 && i + 1 < argc) {
+			if (parse_version_option(argv[i + 1]) < 0)
+				return -1;
+		}
+	}
+
+	/* TLS 1.2 does not support rekey - warn and disable */
+	if (tls_version == 12 && do_rekey) {
+		printf("WARNING: TLS 1.2 does not support rekey\n");
+		printf("         (KeyUpdate is TLS 1.3 only)\n");
+		do_rekey = 0;
+	}
+
+	printf("TLS Version: %s\n", version_name(tls_version));
+	printf("Cipher: %s\n", cipher_name(cipher_type));
+	if (random_size_max > 0)
+		printf("Buffer size: random (1..%d)\n", random_size_max);
+	else
+		printf("Buffer size: %d\n", send_size);
+
+	if (do_rekey)
+		printf("Rekey testing ENABLED: %d rekey(s)\n", num_rekeys);
+
+	/* Initialize random seed for random data and buffer sizes */
+	srand(time(NULL));
+
+	if (argc < 2 ||
+	    (strcmp(argv[1], "server") && strcmp(argv[1], "client"))) {
+		print_usage(argv[0]);
+		return -1;
+	}
+
+	if (!strcmp(argv[1], "client"))
+		return do_client();
+
+	return do_server();
+}
diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
new file mode 100755
index 000000000000..48e01903d17b
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
@@ -0,0 +1,353 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+TLS Hardware Offload Test
+
+This test verifies kTLS hardware offload functionality between two endpoints
+using the existing driver test framework (NetDrvEpEnv).
+
+The test uses a C helper binary (tls_hw_offload)
+to perform the actual TLS operations with hardcoded keys (no TLS handshake).
+
+For rekey testing, proper TLS KeyUpdate handshake messages are sent via
+sendmsg/recvmsg with TLS_SET_RECORD_TYPE/TLS_GET_RECORD_TYPE.
+
+The test verifies TLS counters from /proc/net/tls_stat:
+  - TlsTxDevice/TlsRxDevice: HW offload was used
+  - TlsTxRekeyOk/TlsRxRekeyOk: Rekey operations succeeded (TLS 1.3 only)
+  - TlsRxRekeyReceived: KeyUpdate messages received (server)
+  - TlsDecryptError: No decryption errors occurred
+
+Note: This test requires actual hardware with TLS offload support when run
+in HW mode. It will not trigger hardware offload on loopback or veth pairs.
+"""
+
+from lib.py import ksft_run, ksft_exit, ksft_pr, KsftSkipEx, ksft_true
+from lib.py import NetDrvEpEnv
+from lib.py import cmd, bkg, wait_port_listen, rand_port
+import time
+
+
+def check_tls_support(cfg):
+    """Check if kTLS is supported on both local and remote."""
+    # Check if /proc/net/tls_stat exists
+    try:
+        cmd("test -f /proc/net/tls_stat")
+        cmd("test -f /proc/net/tls_stat", host=cfg.remote)
+    except Exception as e:
+        raise KsftSkipEx(f"kTLS not supported: {e}")
+
+
+def read_tls_stats():
+    """Read TLS statistics from /proc/net/tls_stat."""
+    stats = {}
+    output = cmd("cat /proc/net/tls_stat")
+    for line in output.stdout.strip().split('\n'):
+        parts = line.split()
+        if len(parts) == 2:
+            stats[parts[0]] = int(parts[1])
+    return stats
+
+
+def verify_tls_counters(stats_before, stats_after, expected_rekeys, is_server):
+    """
+    Verify TLS counters after test completion.
+    Returns True on success, False on failure.
+    """
+    tx_device_diff = (stats_after.get('TlsTxDevice', 0) -
+                      stats_before.get('TlsTxDevice', 0))
+    rx_device_diff = (stats_after.get('TlsRxDevice', 0) -
+                      stats_before.get('TlsRxDevice', 0))
+    tx_sw_diff = (stats_after.get('TlsTxSw', 0) -
+                  stats_before.get('TlsTxSw', 0))
+    rx_sw_diff = (stats_after.get('TlsRxSw', 0) -
+                  stats_before.get('TlsRxSw', 0))
+    decrypt_err_diff = (stats_after.get('TlsDecryptError', 0) -
+                        stats_before.get('TlsDecryptError', 0))
+
+    used_tx_hw = tx_device_diff >= 1
+    used_rx_hw = rx_device_diff >= 1
+    used_tx_sw = tx_sw_diff >= 1
+    used_rx_sw = rx_sw_diff >= 1
+
+    errors = 0
+
+    role = 'Server' if is_server else 'Client'
+    ksft_pr(f"=== Counter Verification ({role}) ===")
+
+    tx_dev_before = stats_before.get('TlsTxDevice', 0)
+    tx_dev_after = stats_after.get('TlsTxDevice', 0)
+    ksft_pr(f"TlsTxDevice: {tx_dev_before} -> {tx_dev_after} "
+            f"(diff: {tx_device_diff})")
+
+    tx_sw_before = stats_before.get('TlsTxSw', 0)
+    tx_sw_after = stats_after.get('TlsTxSw', 0)
+    ksft_pr(f"TlsTxSw: {tx_sw_before} -> {tx_sw_after} "
+            f"(diff: {tx_sw_diff})")
+
+    if used_tx_hw:
+        ksft_pr("TX Path: HARDWARE OFFLOAD")
+    elif used_tx_sw:
+        ksft_pr("TX Path: SOFTWARE")
+    else:
+        ksft_pr("TX Path: FAIL (no TLS TX activity detected)")
+        errors += 1
+
+    rx_dev_before = stats_before.get('TlsRxDevice', 0)
+    rx_dev_after = stats_after.get('TlsRxDevice', 0)
+    ksft_pr(f"TlsRxDevice: {rx_dev_before} -> {rx_dev_after} "
+            f"(diff: {rx_device_diff})")
+
+    rx_sw_before = stats_before.get('TlsRxSw', 0)
+    rx_sw_after = stats_after.get('TlsRxSw', 0)
+    ksft_pr(f"TlsRxSw: {rx_sw_before} -> {rx_sw_after} "
+            f"(diff: {rx_sw_diff})")
+    
+    if used_rx_hw:
+        ksft_pr("RX Path: HARDWARE OFFLOAD")
+    elif used_rx_sw:
+        ksft_pr("RX Path: SOFTWARE")
+    else:
+        ksft_pr("RX Path: FAIL (no TLS RX activity detected)")
+        errors += 1
+
+    # Check rekey counters if rekeys were expected
+    if expected_rekeys > 0:
+        tx_rekey_diff = (stats_after.get('TlsTxRekeyOk', 0) -
+                         stats_before.get('TlsTxRekeyOk', 0))
+        rx_rekey_diff = (stats_after.get('TlsRxRekeyOk', 0) -
+                         stats_before.get('TlsRxRekeyOk', 0))
+        rx_rekey_recv_diff = (stats_after.get('TlsRxRekeyReceived', 0) -
+                              stats_before.get('TlsRxRekeyReceived', 0))
+        tx_rekey_err_diff = (stats_after.get('TlsTxRekeyError', 0) -
+                             stats_before.get('TlsTxRekeyError', 0))
+        rx_rekey_err_diff = (stats_after.get('TlsRxRekeyError', 0) -
+                             stats_before.get('TlsRxRekeyError', 0))
+
+        tx_rekey_before = stats_before.get('TlsTxRekeyOk', 0)
+        tx_rekey_after = stats_after.get('TlsTxRekeyOk', 0)
+        ksft_pr(f"TlsTxRekeyOk: {tx_rekey_before} -> {tx_rekey_after} "
+                f"(diff: {tx_rekey_diff})")
+        if tx_rekey_diff < expected_rekeys:
+            ksft_pr(f"FAIL: Expected >= {expected_rekeys} TX rekeys")
+            errors += 1
+
+        rx_rekey_before = stats_before.get('TlsRxRekeyOk', 0)
+        rx_rekey_after = stats_after.get('TlsRxRekeyOk', 0)
+        ksft_pr(f"TlsRxRekeyOk: {rx_rekey_before} -> {rx_rekey_after} "
+                f"(diff: {rx_rekey_diff})")
+        if rx_rekey_diff < expected_rekeys:
+            ksft_pr(f"FAIL: Expected >= {expected_rekeys} RX rekeys")
+            errors += 1
+
+        if is_server:
+            rx_recv_before = stats_before.get('TlsRxRekeyReceived', 0)
+            rx_recv_after = stats_after.get('TlsRxRekeyReceived', 0)
+            ksft_pr(f"TlsRxRekeyReceived: {rx_recv_before} -> "
+                    f"{rx_recv_after} (diff: {rx_rekey_recv_diff})")
+            if rx_rekey_recv_diff < expected_rekeys:
+                ksft_pr(f"FAIL: Expected >= {expected_rekeys} "
+                        f"KeyUpdate messages")
+                errors += 1
+
+        if tx_rekey_err_diff > 0:
+            ksft_pr(f"ERROR: TlsTxRekeyError increased by "
+                    f"{tx_rekey_err_diff}")
+            errors += 1
+        if rx_rekey_err_diff > 0:
+            ksft_pr(f"ERROR: TlsRxRekeyError increased by "
+                    f"{rx_rekey_err_diff}")
+            errors += 1
+
+    # Check for decrypt errors
+    if decrypt_err_diff > 0:
+        ksft_pr(f"ERROR: TlsDecryptError increased by {decrypt_err_diff}")
+        errors += 1
+
+    ksft_pr(f"=== Verification {'PASSED' if errors == 0 else 'FAILED'} ===\n")
+    return errors == 0
+
+
+def run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=0, buffer_size=None, random_max=None):
+    """
+    Run TLS hardware offload test using the C binary.
+
+    Args:
+        cfg: NetDrvEpEnv configuration
+        cipher: "128" or "256" for AES-GCM key size
+        tls_version: "1.2" or "1.3"
+        rekey: Number of rekeys to perform (0 = no rekey, TLS 1.3 only)
+        buffer_size: Fixed buffer size in bytes (default: 16384)
+        random_max: Use random buffer sizes from 1 to random_max (overrides buffer_size)
+    """
+    port = rand_port()
+
+    # Build server command
+    server_cmd = f"{cfg.bin_remote} server -p {port} -c {cipher} -v {tls_version}"
+    if rekey > 0:
+        server_cmd += f" --rekey={rekey}"
+    if random_max:
+        server_cmd += f" -r {random_max}"
+    elif buffer_size:
+        server_cmd += f" -b {buffer_size}"
+
+    # Build client command
+    client_cmd = (f"{cfg.bin_local} client -s {cfg.remote_addr_v['4']} "
+                  f"-p {port} -c {cipher} -v {tls_version}")
+    if rekey > 0:
+        client_cmd += f" --rekey={rekey}"
+    if random_max:
+        client_cmd += f" -r {random_max}"
+    elif buffer_size:
+        client_cmd += f" -b {buffer_size}"
+
+    # Build test description
+    test_desc = f"cipher={cipher}, version={tls_version}, rekey={rekey}"
+    if random_max:
+        test_desc += f", random_size=1-{random_max}"
+    elif buffer_size:
+        test_desc += f", buffer={buffer_size}"
+    ksft_pr(f"Starting TLS test: {test_desc}")
+
+    # Read stats before test
+    stats_before_local = read_tls_stats()
+    stats_before_remote = read_tls_stats_remote(cfg)
+
+    # Run server in background on remote
+    with bkg(server_cmd, host=cfg.remote, exit_wait=True):
+        # Wait for server to be ready
+        wait_port_listen(port, host=cfg.remote)
+        time.sleep(0.5)  # Extra time for server setup
+
+        # Run client
+        ksft_pr("Running client...")
+        result = cmd(client_cmd, fail=False)
+
+        # Give server time to finish
+        time.sleep(1)
+
+    # Read stats after test
+    stats_after_local = read_tls_stats()
+    stats_after_remote = read_tls_stats_remote(cfg)
+
+    # Verify client side (local)
+    ksft_pr("\n=== Client Side Verification ===")
+    client_ok = verify_tls_counters(stats_before_local, stats_after_local, rekey, False)
+
+    # Verify server side (remote)
+    ksft_pr("\n=== Server Side Verification ===")
+    server_ok = verify_tls_counters(stats_before_remote, stats_after_remote, rekey, True)
+
+    # Check that client exited successfully
+    ksft_true(result.ret == 0, "Client completed successfully")
+    ksft_true(client_ok, "Client TLS counters verified")
+    ksft_true(server_ok, "Server TLS counters verified")
+
+
+def read_tls_stats_remote(cfg):
+    """Read TLS statistics from remote endpoint."""
+    stats = {}
+    output = cmd("cat /proc/net/tls_stat", host=cfg.remote)
+    for line in output.stdout.strip().split('\n'):
+        parts = line.split()
+        if len(parts) == 2:
+            stats[parts[0]] = int(parts[1])
+    return stats
+
+
+def test_tls_offload_basic(cfg):
+    """Test basic TLS 1.3 hardware offload with AES-GCM-128 (no rekey)."""
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=0)
+
+
+def test_tls_offload_aes256(cfg):
+    """Test TLS 1.3 hardware offload with AES-GCM-256 (no rekey)."""
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="256", tls_version="1.3", rekey=0)
+
+
+def test_tls_offload_tls12(cfg):
+    """Test TLS 1.2 hardware offload with AES-GCM-128 (no rekey)."""
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="128", tls_version="1.2", rekey=0)
+
+
+def test_tls_offload_tls12_aes256(cfg):
+    """Test TLS 1.2 hardware offload with AES-GCM-256 (no rekey)."""
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="256", tls_version="1.2", rekey=0)
+
+
+def test_tls_offload_rekey(cfg):
+    """Test TLS 1.3 hardware offload with rekey."""
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=1)
+
+
+def test_tls_offload_rekey_multiple(cfg):
+    """Test TLS 1.3 hardware offload with multiple rekeys."""
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=3)
+
+
+def test_tls_offload_small_records(cfg):
+    """Test TLS 1.3 with small record size (512 bytes)."""
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=0, buffer_size=512)
+
+
+def test_tls_offload_large_records(cfg):
+    """Test TLS 1.3 with large record size (32KB)."""
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=0, buffer_size=32768)
+
+
+def test_tls_offload_random_sizes(cfg):
+    """Test TLS 1.3 with random record sizes (1-8192 bytes)."""
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=0, random_max=8192)
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        # Deploy the C binary to both local and remote
+        # The binary is built in the same directory as this test
+        cfg.bin_local = cfg.test_dir / "tls_hw_offload"
+
+        # Check if binary exists
+        if not cfg.bin_local.exists():
+            raise KsftSkipEx(
+                f"tls_hw_offload binary not found at {cfg.bin_local}. "
+                "Please build it first: make -C "
+                "tools/testing/selftests/drivers/net/hw tls_hw_offload")
+
+        cfg.bin_remote = cfg.remote.deploy(cfg.bin_local)
+
+        ksft_run([
+            test_tls_offload_basic,
+            test_tls_offload_aes256,
+            test_tls_offload_tls12,
+            test_tls_offload_tls12_aes256,
+            test_tls_offload_rekey,
+            test_tls_offload_rekey_multiple,
+            test_tls_offload_small_records,
+            test_tls_offload_large_records,
+            test_tls_offload_random_sizes,
+        ], args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
+
-- 
2.25.1


