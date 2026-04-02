Return-Path: <netdev+bounces-274780-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB3XJngCz2mBsQYAu9opvQ
	(envelope-from <netdev+bounces-274780-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:57:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9400B38F592
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 01:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C5556302423E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 23:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721713B8BC1;
	Thu,  2 Apr 2026 23:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="COunOTDn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166713B6C13
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 23:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775174201; cv=none; b=DJRtex0JWHNwdrD9lWDtxbD+gSMD5RWuwWQI9topvypajIlc0DPSxb8BSauvt5rEBXtSqS2KzMSKfzZE8pGKYd5F3dg5htEjwzk9NZ2jnbfCzYVJ2fkFDGuflTwsBGABtn6NYLkfSDXyK8GfuzpoXPO2ldiLLqSZ7iyh90/6G/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775174201; c=relaxed/simple;
	bh=quOgAJFZTfPJcVwi5yHfjHqMTCqNtfWR6xNs6yKqZoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g4geK0uNuLDGgFjUabNYmyxeXPgMT9ishMdaDANUH6BjmvYs5qt/FhNNm1SEfdXvvgiXfRsUroGmpBCcrSnherXTD3rG4XWfbJsMa3fiD9wKuITW6FruhH4mTFosgHdJnH+vt67u4QAnKTgLRtyusaxx/beCrahFjGfRaBswesc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=COunOTDn; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-46704177543so898475b6e.2
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 16:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775174198; x=1775778998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7PbwRv1jfVB6h6Qo5VQ2RMPLWfDoQrgvTxxkdQgSnbc=;
        b=COunOTDnluwrEmjwnT3tHifmOWE4zkbFjjIPfIHv3a+ShTb46ejgqdDV6LQCOrZBmh
         AjXCSJqZ61LhjjZ4/9TmqQuBuVGK1KLag3VZFbfmcsuIeeZ95747bMVFjAh5Kgfr2tJ/
         PbWya3eVVVe9PfW8JQtoG3V7H+XsBRg37DLfiFG18OIXqLpyuWoJC1BxmnxseglDx0XC
         eEpTPlgnBjsL9UEXpUA8lJl3Z8ALCHQMpY5RiIWouXc22o9jWBAI6WC9xXxDX9Ns8nmM
         vojQD1rFarwaMFH2bD7D1jF4SAe+H3tFbAHUsmnGgL4QqkmeAgvueFzSXah7lV/QNUhz
         ScsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775174198; x=1775778998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7PbwRv1jfVB6h6Qo5VQ2RMPLWfDoQrgvTxxkdQgSnbc=;
        b=L+VBdnGwM2JfGkNCzNj7aNsnAAfu7sc0oCQOAmASYUDgLe0teqzM52+5t3WUnyJY8b
         8jroZ9NvdM9e8TPYHNEVr+s6hPkBnl0oymftNtExMcSqaqGkHhhZwHtIPK3pZaZpLLxi
         ejRv6RBG8NDnQu2ZGDFDo3XEkxJTqohk/BuFpd62q6Z6HVkPWV7vIogXJ25ox3EWIqxi
         g6guIcwwk4VYzJZgslwAY8gxEgKf27034wgE1AzhmiKD7/Bh3SvwVdJcz2Kc/Jw22FQJ
         n9naVeZ9W+T1TxsrzHZQn72Aks+vsMe2022amMc0gfBCRuW35PCOCjHS2IDVV7EXfvB1
         ZtMQ==
X-Gm-Message-State: AOJu0YyTDrEaWImlQyuQL1oGW3jXcLH7p5jfqm0QBifHqQuATwxAHe0+
	hq09A+4Dv4CcVGkNq9Vq8TTwyBbMBBWjnpKY7lk8aCVyDKKETggHOh0U2hNBOre1zn/VwxSl+44
	rGSPecqdZL985o3zkO4J4/3rx6Gjt4VL4YKs76chIoo4rKc2o/XTDcJBigCiJdF1Fz92DY3JNbn
	P0DGrTskZKuHKMRPV5Fp13LcmeKN2jdRx2/Cn+TJiZvQJUfMg=
X-Gm-Gg: ATEYQzxaGbLMgyPK7IxyfSflavXRY3kBs4nvnBO7mseAJTaZKW6RQwP/bEck9RhPzC+
	e7Sn0+tw9I4G6iXgmCs3yqdwI0vGg4LNPiJH1/IW/AMhTJVNI8eSNvRB6zCQZHr5J4ul6FQgtxr
	BdsZZ5hJMSxycytoO04Y1+keBG7Wv0CkYb1dr/9gprOWD/EGGhlaO9NDRfBpFFuedfBA7LbxEhr
	VTlJtZgPhiYDmy2OSn6KzbvgGC5IrZRKOXOfYxjXsO8MFfo7ztzag/Jyfkl/mV57KErRe0tObac
	8wwrjtUxIR5at1nHCl1MMtnewc9WXS4ev7/SPEBKTWHQfz/Aov6dAA65YXxkMsqe4KP+2xCpHHi
	Xen8Ytd67a2+2deU+WEAkCxvXdPA+/xZgpQjPuY8Cnv/CN/laSQPf8mI4UUtbXwlUhin5HNzqNp
	9jjWWqd/UN1eKxJZrXNQON3l+3SOgNknTYGcyRD73mJ5pCSi7CmabfkG19okAUgNCCwnkRIW3FY
	oQ=
X-Received: by 2002:a05:6808:2387:b0:467:7c9:a9ac with SMTP id 5614622812f47-46ef8d4cc10mr827635b6e.54.1775174197267;
        Thu, 02 Apr 2026 16:56:37 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-46d8f9609bfsm2394775b6e.3.2026.04.02.16.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 16:56:36 -0700 (PDT)
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
Subject: [PATCH v12 6/6] selftests: net: add TLS hardware offload test
Date: Thu,  2 Apr 2026 17:55:11 -0600
Message-Id: <20260402235511.664801-7-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260402235511.664801-1-rjethwani@purestorage.com>
References: <20260402235511.664801-1-rjethwani@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-274780-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,purestorage.com:dkim,purestorage.com:email,purestorage.com:mid,tls_hw_offload.py:url]
X-Rspamd-Queue-Id: 9400B38F592
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two-node kTLS hardware offload test using NetDrvEpEnv. Tests TLS
1.2/1.3 with AES-GCM-128/256, rekey operations, and various buffer
sizes.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c | 767 ++++++++++++++++++
 .../drivers/net/hw/tls_hw_offload.py          | 171 ++++
 4 files changed, 941 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
 create mode 100755 tools/testing/selftests/drivers/net/hw/tls_hw_offload.py

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
index deeca3f8d080..261ee453610f 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -15,6 +15,7 @@ endif
 
 TEST_GEN_FILES := \
 	$(COND_GEN_FILES) \
+	tls_hw_offload \
 # end of TEST_GEN_FILES
 
 TEST_PROGS = \
@@ -41,6 +42,7 @@ TEST_PROGS = \
 	rss_drv.py \
 	rss_flow_label.py \
 	rss_input_xfrm.py \
+	tls_hw_offload.py \
 	toeplitz.py \
 	tso.py \
 	xdp_metadata.py \
diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
new file mode 100644
index 000000000000..788891890ec8
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
@@ -0,0 +1,767 @@
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
+#define KEY_UPDATE_NOT_REQUESTED		0
+#define KEY_UPDATE_REQUESTED			1
+
+#define TEST_ITERATIONS	100
+#define MAX_REKEYS	99
+#define MIN_BUF_SIZE   16  /* must fit TLS handshake msg (KeyUpdate = 5 B) */
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
+static int cipher_type = TLS_CIPHER_AES_GCM_128;
+static int tls_version = TLS_1_3_VERSION;
+static int server_port = 4433;
+static char *server_ip;
+
+static int send_size = 16384;
+static int random_size_max;
+
+/*
+ * Scramble key material fields for a given rekey generation.
+ * Generation 0 uses the base key unchanged; generation N XORs a
+ * deterministic pattern into each field so both endpoints derive
+ * identical keys without a real KDF.
+ */
+static void derive_key_fields(unsigned char *key, int key_size,
+			      unsigned char *iv, int iv_size,
+			      unsigned char *salt, int salt_size,
+			      unsigned char *rec_seq, int rec_seq_size,
+			      int generation)
+{
+	unsigned char pattern;
+	int i;
+
+	if (generation == 0)
+		return;
+
+	pattern = (unsigned char)((generation * 0x1B) ^ 0x63);
+	for (i = 0; i < key_size; i++) {
+		key[i] ^= pattern;
+		pattern = (pattern << 1) | (pattern >> 7);
+	}
+
+	pattern = (unsigned char)((generation * 0x2D) ^ 0x7C);
+	for (i = 0; i < iv_size; i++) {
+		iv[i] ^= pattern;
+		pattern = (pattern << 1) | (pattern >> 7);
+	}
+
+	for (i = 0; i < salt_size; i++)
+		salt[i] ^= (unsigned char)(generation & 0xFF);
+
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
+		printf("TCP_ULP failed: %s\n", strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
+/* Send TLS 1.3 KeyUpdate handshake message */
+static int send_tls_key_update(int fd, int request_update)
+{
+	char cmsg_buf[CMSG_SPACE(sizeof(unsigned char))];
+	unsigned char key_update_msg[5];
+	struct msghdr msg = {0};
+	struct cmsghdr *cmsg;
+	struct iovec iov;
+
+	key_update_msg[0] = TLS_HANDSHAKE_KEY_UPDATE;
+	key_update_msg[1] = 0;
+	key_update_msg[2] = 0;
+	key_update_msg[3] = 1;
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
+/*
+ * Validate a KeyUpdate handshake message per RFC 8446:
+ *   HandshakeType (1) = 0x18, Length (3) = 0x000001,
+ *   KeyUpdateRequest (1) = 0 or 1.
+ */
+static int validate_keyupdate(const char *buf, int len)
+{
+	if (len != 5) {
+		printf("KeyUpdate: expected 5 bytes, got %d\n", len);
+		return -1;
+	}
+
+	if ((unsigned char)buf[0] != TLS_HANDSHAKE_KEY_UPDATE) {
+		printf("Expected KeyUpdate (0x%02x), got 0x%02x\n",
+		       TLS_HANDSHAKE_KEY_UPDATE, (unsigned char)buf[0]);
+		return -1;
+	}
+
+	if (buf[1] != 0 || buf[2] != 0 || buf[3] != 1) {
+		printf("KeyUpdate: bad length field %02x%02x%02x\n",
+		       (unsigned char)buf[1], (unsigned char)buf[2],
+		       (unsigned char)buf[3]);
+		return -1;
+	}
+
+	if ((unsigned char)buf[4] != KEY_UPDATE_NOT_REQUESTED &&
+	    (unsigned char)buf[4] != KEY_UPDATE_REQUESTED) {
+		printf("KeyUpdate: invalid request_update value %u\n",
+		       (unsigned char)buf[4]);
+		return -1;
+	}
+
+	printf("Received TLS KeyUpdate (request_update=%u)\n",
+	       (unsigned char)buf[4]);
+	return 0;
+}
+
+static int recv_tls_keyupdate(int fd)
+{
+	char buf[MIN_BUF_SIZE];
+	int record_type;
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
+	return validate_keyupdate(buf, ret);
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
+		printf("TLS_%s %s gen %d failed: %s\n", dir,
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
+	if (!server_ip) {
+		printf("ERROR: Client requires -s <ip> option\n");
+		return -1;
+	}
+
+	max_size = random_size_max > 0 ? random_size_max : send_size;
+	if (max_size < MIN_BUF_SIZE)
+		max_size = MIN_BUF_SIZE;
+	buf = malloc(max_size);
+	echo_buf = malloc(max_size);
+	if (!buf || !echo_buf) {
+		printf("failed to allocate buffers\n");
+		goto out;
+	}
+
+	csk = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	if (csk < 0) {
+		printf("failed to create socket: %s\n", strerror(errno));
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
+		       TEST_ITERATIONS, random_size_max);
+	else
+		printf("Sending %d messages of %d bytes...\n",
+		       TEST_ITERATIONS, send_size);
+
+	rekey_interval = TEST_ITERATIONS / (num_rekeys + 1);
+	if (rekey_interval < 1)
+		rekey_interval = 1;
+	next_rekey_at = rekey_interval;
+
+	for (i = 0; i < TEST_ITERATIONS; i++) {
+		int this_size;
+
+		if (random_size_max > 0)
+			this_size = (rand() % random_size_max) + 1;
+		else
+			this_size = send_size;
+
+		for (j = 0; j < this_size; j++)
+			buf[j] = rand() & 0xFF;
+
+		n = send(csk, buf, this_size, 0);
+		if (n != this_size) {
+			printf("FAIL: send failed: %s\n", strerror(errno));
+			goto out;
+		}
+		printf("Sent %zd bytes (iteration %d)\n", n, i + 1);
+
+		echo_total = 0;
+		while (echo_total < n) {
+			echo_n = recv(csk, echo_buf + echo_total,
+				      n - echo_total, 0);
+			if (echo_n < 0) {
+				printf("FAIL: Echo recv failed: %s\n",
+				       strerror(errno));
+				goto out;
+			}
+			if (echo_n == 0) {
+				printf("FAIL: Connection closed during echo\n");
+				goto out;
+			}
+			echo_total += echo_n;
+		}
+
+		if (memcmp(buf, echo_buf, n) != 0) {
+			printf("FAIL: Echo data mismatch!\n");
+			goto out;
+		}
+		printf("Received echo %zd bytes (ok)\n", echo_total);
+
+		/* Rekey at intervals: send KeyUpdate, update TX, recv KeyUpdate, update RX */
+		if (num_rekeys && current_gen < num_rekeys &&
+		    (i + 1) == next_rekey_at) {
+			current_gen++;
+			printf("\n=== Client Rekey gen %d ===\n", current_gen);
+
+			ret = send_tls_key_update(csk, KEY_UPDATE_REQUESTED);
+			if (ret < 0) {
+				printf("FAIL: send KeyUpdate\n");
+				goto out;
+			}
+
+			ret = do_tls_rekey(csk, TLS_TX, current_gen, cipher_type);
+			if (ret < 0)
+				goto out;
+
+			if (recv_tls_keyupdate(csk) < 0) {
+				printf("FAIL: recv KeyUpdate from server\n");
+				goto out;
+			}
+
+			if (check_ekeyexpired(csk) < 0)
+				goto out;
+
+			ret = do_tls_rekey(csk, TLS_RX, current_gen, cipher_type);
+			if (ret < 0)
+				goto out;
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
+		printf("failed to allocate buffer\n");
+		goto out;
+	}
+
+	lsk = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	if (lsk < 0) {
+		printf("failed to create socket: %s\n", strerror(errno));
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
+		printf("bind failed: %s\n", strerror(errno));
+		goto out;
+	}
+
+	ret = listen(lsk, 1);
+	if (ret < 0) {
+		printf("listen failed: %s\n", strerror(errno));
+		goto out;
+	}
+
+	printf("Server listening on 0.0.0.0:%d\n", server_port);
+	printf("Waiting for client connection...\n");
+
+	csk = accept(lsk, (struct sockaddr *)NULL, (socklen_t *)NULL);
+	if (csk < 0) {
+		printf("accept failed: %s\n", strerror(errno));
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
+			printf("recv failed: %s\n", strerror(errno));
+			break;
+		}
+
+		/* Handle KeyUpdate: validate, update RX, respond, update TX */
+		if (record_type == TLS_RECORD_TYPE_HANDSHAKE) {
+			if (validate_keyupdate(buf, n) < 0)
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
+			ret = send_tls_key_update(csk,
+						  KEY_UPDATE_NOT_REQUESTED);
+			if (ret < 0) {
+				printf("Failed to send KeyUpdate\n");
+				goto out;
+			}
+
+			ret = do_tls_rekey(csk, TLS_TX, current_gen, cipher_type);
+			if (ret < 0)
+				goto out;
+
+			printf("=== Server Rekey gen %d Complete ===\n\n",
+			       current_gen);
+			continue;
+		}
+
+		total += n;
+		recv_count++;
+		printf("Received %zd bytes (total: %zd, count: %d)\n",
+		       n, total, recv_count);
+
+		for (sent = 0; sent < n; sent += ret) {
+			ret = send(csk, buf + sent, n - sent, 0);
+			if (ret < 0) {
+				printf("Echo send failed: %s\n",
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
+	printf("  -k <N>        Perform N rekeys (client only, TLS 1.3)\n");
+	printf("  -h            Show this help message\n");
+	printf("\nExample:\n");
+	printf("  Node A: %s server\n", prog);
+	printf("  Node B: %s client -s 192.168.20.2\n", prog);
+	printf("\nRekey Example (3 rekeys, TLS 1.3 only):\n");
+	printf("  Node A: %s server\n", prog);
+	printf("  Node B: %s client -s 192.168.20.2 -k 3\n", prog);
+}
+
+int main(int argc, char *argv[])
+{
+	int opt;
+
+	if (argc < 2 ||
+	    (strcmp(argv[1], "server") && strcmp(argv[1], "client"))) {
+		print_usage(argv[0]);
+		return -1;
+	}
+
+	optind = 2; /* skip subcommand */
+	while ((opt = getopt(argc, argv, "s:p:b:r:c:v:k:h")) != -1) {
+		switch (opt) {
+		case 's':
+			server_ip = optarg;
+			break;
+		case 'p':
+			server_port = atoi(optarg);
+			if (server_port < 1 || server_port > 65535) {
+				printf("ERROR: Invalid port '%s'. Must be 1..65535.\n",
+				       optarg);
+				return -1;
+			}
+			break;
+		case 'b':
+			send_size = atoi(optarg);
+			if (send_size < 1) {
+				printf("ERROR: Invalid buffer size '%s'. Must be >= 1.\n",
+				       optarg);
+				return -1;
+			}
+			break;
+		case 'r':
+			random_size_max = atoi(optarg);
+			if (random_size_max < 1) {
+				printf("ERROR: Invalid random size '%s'. Must be >= 1.\n",
+				       optarg);
+				return -1;
+			}
+			break;
+		case 'c':
+			if (parse_cipher_option(optarg) < 0)
+				return -1;
+			break;
+		case 'v':
+			if (parse_version_option(optarg) < 0)
+				return -1;
+			break;
+		case 'k':
+			num_rekeys = atoi(optarg);
+			if (num_rekeys < 1 || num_rekeys > MAX_REKEYS) {
+				printf("ERROR: Invalid rekey count '%s'. Must be 1..%d.\n",
+				       optarg, MAX_REKEYS);
+				return -1;
+			}
+			break;
+		case 'h':
+			print_usage(argv[0]);
+			return 0;
+		default:
+			print_usage(argv[0]);
+			return -1;
+		}
+	}
+
+	if (tls_version == TLS_1_2_VERSION && num_rekeys) {
+		printf("ERROR: TLS 1.2 does not support rekey\n");
+		return -1;
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
+
+	srand(time(NULL));
+
+	if (!strcmp(argv[1], "client"))
+		return do_client();
+
+	return do_server();
+}
diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
new file mode 100755
index 000000000000..66c5ddfd8125
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
@@ -0,0 +1,171 @@
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
+    """Print counter before/after and return the diff."""
+    before_val, after_val = before[key], after[key]
+    diff = after_val - before_val
+    ksft_pr(f"{key}: {before_val} -> {after_val} (diff: {diff})")
+    return diff
+
+
+def check_path(before, after, direction):
+    """Check that HW or SW offload was used for a given direction."""
+    dev = stat_diff(before, after, f'Tls{direction}Device')
+    sw = stat_diff(before, after, f'Tls{direction}Sw')
+    if dev >= 1:
+        ksft_pr(f"{direction} Path: HARDWARE OFFLOAD")
+        return 0
+    if sw >= 1:
+        ksft_pr(f"{direction} Path: SOFTWARE")
+        return 0
+    ksft_pr(f"{direction} Path: FAIL (no TLS {direction} activity detected)")
+    return 1
+
+
+def check_min(before, after, key, minimum, label):
+    """Check that a counter increased by at least minimum."""
+    diff = stat_diff(before, after, key)
+    if diff < minimum:
+        ksft_pr(f"FAIL: Expected >= {minimum} {label}")
+        return 1
+    return 0
+
+
+def check_zero(before, after, key):
+    """Check that an error counter did not increase."""
+    diff = stat_diff(before, after, key)
+    if diff > 0:
+        ksft_pr(f"ERROR: {key} increased by {diff}")
+        return 1
+    return 0
+
+
+def verify_tls_counters(stats_before, stats_after, expected_rekeys, is_server):
+    errors = 0
+    role = 'Server' if is_server else 'Client'
+    ksft_pr(f"=== Counter Verification ({role}) ===")
+
+    errors += check_path(stats_before, stats_after, 'Tx')
+    errors += check_path(stats_before, stats_after, 'Rx')
+
+    if expected_rekeys > 0:
+        errors += check_min(stats_before, stats_after,
+                            'TlsTxRekeyOk', expected_rekeys, "TX rekeys")
+        errors += check_min(stats_before, stats_after,
+                            'TlsRxRekeyOk', expected_rekeys, "RX rekeys")
+        if is_server:
+            errors += check_min(stats_before, stats_after,
+                                'TlsRxRekeyReceived', expected_rekeys,
+                                "KeyUpdate messages")
+        errors += check_zero(stats_before, stats_after, 'TlsTxRekeyError')
+        errors += check_zero(stats_before, stats_after, 'TlsRxRekeyError')
+
+    errors += check_zero(stats_before, stats_after, 'TlsDecryptError')
+
+    ksft_pr(f"=== Verification {'PASSED' if errors == 0 else 'FAILED'} ===\n")
+    return errors == 0
+
+
+def run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=0, buffer_size=None, random_max=None):
+    port = rand_port()
+    send_size = random_max or buffer_size
+
+    server_args = f"{cfg.bin_remote} server -p {port} -c {cipher} -v {tls_version}"
+    if send_size:
+        server_args += f" -b {send_size}"
+
+    client_args = (f"{cfg.bin_local} client -s {cfg.remote_addr_v['4']} "
+                   f"-p {port} -c {cipher} -v {tls_version}")
+    if rekey:
+        client_args += f" -k {rekey}"
+    if random_max:
+        client_args += f" -r {random_max}"
+    elif send_size:
+        client_args += f" -b {send_size}"
+
+    stats_before_local = read_tls_stats()
+    stats_before_remote = read_tls_stats(host=cfg.remote)
+
+    with bkg(server_args, host=cfg.remote, exit_wait=True):
+        wait_port_listen(port, host=cfg.remote)
+        result = cmd(client_args, fail=False)
+
+    stats_after_local = read_tls_stats()
+    stats_after_remote = read_tls_stats(host=cfg.remote)
+
+    client_ok = verify_tls_counters(stats_before_local, stats_after_local,
+                                    rekey, False)
+    server_ok = verify_tls_counters(stats_before_remote, stats_after_remote,
+                                    rekey, True)
+
+    ksft_true(result.ret == 0, "Client completed successfully")
+    ksft_true(client_ok, "Client TLS counters verified")
+    ksft_true(server_ok, "Server TLS counters verified")
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
+    KsftNamedVariant("random_sizes", 20, None, 8192),
+])
+def test_tls_offload_rekey(cfg, rekey, buffer_size=None, random_max=None):
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=rekey,
+                 buffer_size=buffer_size, random_max=random_max)
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
+        ksft_run([test_tls_offload, test_tls_offload_rekey], args=(cfg, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.25.1


