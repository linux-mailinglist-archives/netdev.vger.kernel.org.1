Return-Path: <netdev+bounces-273703-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK/DHlD8y2nDNAYAu9opvQ
	(envelope-from <netdev+bounces-273703-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:54:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A82C636D603
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 18:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA7ED322725A
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57A91426693;
	Tue, 31 Mar 2026 16:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="PVereVi+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C53428471
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975150; cv=none; b=l2pTRNlpJYjZ0oJRQunUg5zsqIRBSUjCQsiecBZnxQP2faa7R5vnbON4eNB2r0BU4UBsHJEDjazpxX5YZX6hnJB7ZTEUyjY7GsMej9+Ytd712jlt2to+1sYhkiiu3nt8N4v91HgVMFtjSJgv1uEvMxKYx1A9NhR84uLGn65JR/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975150; c=relaxed/simple;
	bh=4uRrR8SSct/rlGaBez1h42rovHx+vq/HALRTQlDJ3Gs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gOh/UuuocIQKj9PvdwiBKTt0D3Etd+d8sDLMFKRMnUkbd9aLN7YibIwjrosRDrqxzonwnqaDf1sWz7VGjq1BWqnhJgbCTWOng2dwybJSPHQHQfGiN/TS6ujubQwPEK5o+2idbNfhQRu6pBwcfVyzJysOaz5oXcQDBLY7BR5Y/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=PVereVi+; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4042fe53946so2323267fac.3
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 09:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774975146; x=1775579946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=75hafVFb6YmlxgltuaYxQFPkmYdsQfGud9l6EUN7ygU=;
        b=PVereVi+ZLJeatWfEadAgdsY+5PrbjbafYa2o/xxEuEYePJXrwCnDMl3iANnyFdXCb
         5ibl7mUx+LQZXbxEaMP3g5ehzc2d+akLDRNVdQjHecGAyTRhaZXq3LGzYpAvCceShCD/
         i5bYfaXbk0uMKLaBn2EiqyvfrGcjKIlLwmmpauL1x0SerNbvzbXFQODxDrvyNmLRn0m8
         kMmQUXG+Iph9AVO4GzvREKj+3SXpRv06c4Cut6YUCrSmbQHCHAld/n/1Wo8w0Q1QY0DC
         7ThOdQCkLeY2GzGdFUIQ1YnO4J/Eod07H2lxnLY23zWEpeu87exyVNFzxqRTjZNaPkD/
         099Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774975146; x=1775579946;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=75hafVFb6YmlxgltuaYxQFPkmYdsQfGud9l6EUN7ygU=;
        b=j5fr/tXGShfSsI7bD2/TPTeOq4cuXJOGecYSybPR6BgMhwlo1fZW8U6dGjapgNOSwj
         FEizr2WKs1LjMdNBrY2f/cBLWgDk5XDNc6rTmFcUJW7Q7b0jqyExSMtPIlA6zAcfSeF5
         DKZG3YFGxRUVPDncmEy9vaywHcu7Anvqm45eCukEwSRuwGF9qtGW7h0lfE/XZipT9QoX
         fIEurSfOs4hAvMhk9Myo+xCjJIO+gLhIXFVT7zqU5roVXxzuVDJe00LZQCMo353DNZcH
         +M3KXIeh0WCI7zt3kBAJRHCjUHwUQSdQZXk4u9xRgc0H11QWRXMxaNAbNYZXNXkB2bUK
         O48A==
X-Gm-Message-State: AOJu0Ywo6UtS4pFhUEYwf/gIQd0NLs/SXGfi/93CKyxR841SzVfxE2DI
	ZY5qJRJ3a8K/njHNBcjnsH2WQHkVhNQ+kRSQPDr7D2LdsOy+j9nSc2IUbHYbF+IMy2hPRvG8ZTx
	gFUWO4ZP65WuJHkKk+pl+2v5BVcTaM41VlqlLQwH7lo0P8FHa9t5v8fZBcLgkJ52qU1fHPQEoSO
	HsbfCxOVyV12dOBIARoLuz5cBVHeF9qakUiQ5Psw2dicR+RZg=
X-Gm-Gg: ATEYQzyrViLZD3ng3lwWyq9MY1iRFNCzQsEVzVq2qD61Oi9T6amUzOXpYQJZpExRCl7
	jOFR1oHTfjmcm+OM2g+ZsCtHtQVbkhfZGZARVuUAUUmoliVCsfusiitD1DNQUwuQu82UMgkc0rI
	9OVJBepCnytfexYo9VG+8yJJy3xWo5e5LSfvGZh0jJxdaGBna2ZF1ePxW95IR3I5vQCma83cPyD
	1BojZvFc1+m9uAMPjpA/qZIhJMBOaBUe6vyJdBE4LpvLD5GQJ3576m95pT/zUdasqNCEdE8mvVG
	zpLKyknhZnyR9iS4jjwuVCGg8sMVAfnF/ZIzXgqXY3zTRGwRE9Id9fjiCiMKneqD8HC9cM1Bt5D
	2/57G2ho3FzoWg7BXUZoxHhmXKFAJATdaa6CUBKnckyPFL9XF9eKh34FlBGZ7xxoMljHAH0X/BB
	WzMSurzVnczGdQX+/txbbDbGz4f8cuk2+KQgBheSOTwV8ea4HnwVrYtJjq9RRWpSzdT3Ml6hJ3R
	t0=
X-Received: by 2002:a05:6870:288c:b0:417:3a1e:eeb2 with SMTP id 586e51a60fabf-422cfebd24bmr196185fac.26.1774975145486;
        Tue, 31 Mar 2026 09:39:05 -0700 (PDT)
Received: from dev-rjethwani.tier4-kif-devvm.svc.slc-eng-prd2 ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-41d04d79c35sm7599651fac.18.2026.03.31.09.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 09:39:05 -0700 (PDT)
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
Subject: [PATCH v11 6/6] selftests: net: add TLS hardware offload test
Date: Tue, 31 Mar 2026 10:37:57 -0600
Message-Id: <20260331163757.149343-7-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260331163757.149343-1-rjethwani@purestorage.com>
References: <20260331163757.149343-1-rjethwani@purestorage.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com,purestorage.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-273703-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.998];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[purestorage.com:dkim,purestorage.com:email,purestorage.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,tls_hw_offload.py:url,lib.py:url]
X-Rspamd-Queue-Id: A82C636D603
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Two-node kTLS hardware offload test using NetDrvEpEnv. Tests TLS
1.2/1.3 with AES-GCM-128/256, rekey operations, and various buffer
sizes.

Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 .../selftests/drivers/net/hw/.gitignore       |   1 +
 .../testing/selftests/drivers/net/hw/Makefile |   2 +
 .../selftests/drivers/net/hw/tls_hw_offload.c | 907 ++++++++++++++++++
 .../drivers/net/hw/tls_hw_offload.py          | 281 ++++++
 4 files changed, 1191 insertions(+)
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
index a64140333a46..6b12b0920cae 100644
--- a/tools/testing/selftests/drivers/net/hw/Makefile
+++ b/tools/testing/selftests/drivers/net/hw/Makefile
@@ -15,6 +15,7 @@ endif
 
 TEST_GEN_FILES := \
 	$(COND_GEN_FILES) \
+	tls_hw_offload \
 # end of TEST_GEN_FILES
 
 TEST_PROGS = \
@@ -38,6 +39,7 @@ TEST_PROGS = \
 	rss_drv.py \
 	rss_flow_label.py \
 	rss_input_xfrm.py \
+	tls_hw_offload.py \
 	toeplitz.py \
 	tso.py \
 	xsk_reconfig.py \
diff --git a/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
new file mode 100644
index 000000000000..69ee834bfabd
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.c
@@ -0,0 +1,907 @@
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
+#include <net/if.h>
+#include <linux/tls.h>
+
+#define TLS_RECORD_TYPE_HANDSHAKE		22
+#define TLS_RECORD_TYPE_APPLICATION_DATA	23
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
+static int do_rekey;
+static int num_rekeys = 1;
+static int rekeys_done;
+static int cipher_type = 128;
+static int tls_version = 13;
+static int server_port = 4433;
+static char *server_ip;
+static int addr_family = AF_INET;
+
+static int send_size = 16384;
+static int random_size_max;
+
+static int detect_addr_family(const char *ip)
+{
+	char addr_buf[INET6_ADDRSTRLEN];
+	struct in_addr addr4;
+	struct in6_addr addr6;
+	char *scope_sep;
+
+	if (inet_pton(AF_INET, ip, &addr4) == 1)
+		return AF_INET;
+
+	strncpy(addr_buf, ip, sizeof(addr_buf) - 1);
+	addr_buf[sizeof(addr_buf) - 1] = '\0';
+	scope_sep = strchr(addr_buf, '%');
+	if (scope_sep)
+		*scope_sep = '\0';
+
+	if (inet_pton(AF_INET6, addr_buf, &addr6) == 1)
+		return AF_INET6;
+	return -1;
+}
+
+/* Derive key for given generation (0 = initial, N = Nth rekey) */
+static void derive_key_128(struct tls12_crypto_info_aes_gcm_128 *key,
+			   int generation)
+{
+	unsigned char pattern;
+	int i;
+
+	memcpy(key, &tls_info_key0_128, sizeof(*key));
+	key->info.version = (tls_version == 12) ?
+			    TLS_1_2_VERSION : TLS_1_3_VERSION;
+
+	if (generation == 0)
+		return;
+
+	pattern = (unsigned char)((generation * 0x1B) ^ 0x63);
+	for (i = 0; i < TLS_CIPHER_AES_GCM_128_KEY_SIZE; i++) {
+		key->key[i] ^= pattern;
+		pattern = (pattern << 1) | (pattern >> 7);
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
+	memset(key->rec_seq, 0, TLS_CIPHER_AES_GCM_128_REC_SEQ_SIZE);
+}
+
+static void derive_key_256(struct tls12_crypto_info_aes_gcm_256 *key,
+			   int generation)
+{
+	unsigned char pattern;
+	int i;
+
+	memcpy(key, &tls_info_key0_256, sizeof(*key));
+	key->info.version = (tls_version == 12) ?
+			    TLS_1_2_VERSION : TLS_1_3_VERSION;
+
+	if (generation == 0)
+		return;
+
+	pattern = (unsigned char)((generation * 0x1B) ^ 0x63);
+	for (i = 0; i < TLS_CIPHER_AES_GCM_256_KEY_SIZE; i++) {
+		key->key[i] ^= pattern;
+		pattern = (pattern << 1) | (pattern >> 7);
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
+	memset(key->rec_seq, 0, TLS_CIPHER_AES_GCM_256_REC_SEQ_SIZE);
+}
+
+static const char *cipher_name(int cipher)
+{
+	switch (cipher) {
+	case 128: return "AES-GCM-128";
+	case 256: return "AES-GCM-256";
+	default: return "unknown";
+	}
+}
+
+static const char *version_name(int version)
+{
+	switch (version) {
+	case 12: return "TLS 1.2";
+	case 13: return "TLS 1.3";
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
+	struct sockaddr_storage sa;
+	char *buf = NULL, *echo_buf = NULL;
+	int max_size, rekey_interval;
+	ssize_t echo_total, echo_n;
+	int csk = -1, ret, i, j;
+	int test_result = 0;
+	int current_gen = 0;
+	int next_rekey_at;
+	socklen_t sa_len;
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
+		test_result = -1;
+		goto out;
+	}
+
+	csk = socket(addr_family, SOCK_STREAM, IPPROTO_TCP);
+	if (csk < 0) {
+		printf("failed to create socket: %s\n", strerror(errno));
+		test_result = -1;
+		goto out;
+	}
+
+	memset(&sa, 0, sizeof(sa));
+	if (addr_family == AF_INET6) {
+		struct sockaddr_in6 *sa6 = (struct sockaddr_in6 *)&sa;
+		char addr_buf[INET6_ADDRSTRLEN];
+		unsigned int scope_id = 0;
+		char *scope_sep;
+
+		strncpy(addr_buf, server_ip, sizeof(addr_buf) - 1);
+		addr_buf[sizeof(addr_buf) - 1] = '\0';
+		scope_sep = strchr(addr_buf, '%');
+		if (scope_sep) {
+			*scope_sep = '\0';
+			scope_id = if_nametoindex(scope_sep + 1);
+			if (scope_id == 0) {
+				printf("Invalid interface: %s\n", scope_sep + 1);
+				test_result = -1;
+				goto out;
+			}
+		}
+
+		sa6->sin6_family = AF_INET6;
+		if (inet_pton(AF_INET6, addr_buf, &sa6->sin6_addr) != 1) {
+			printf("Invalid IPv6 address: %s\n", addr_buf);
+			test_result = -1;
+			goto out;
+		}
+		sa6->sin6_port = htons(server_port);
+		sa6->sin6_scope_id = scope_id;
+		sa_len = sizeof(*sa6);
+		printf("Connecting to [%s]:%d (scope_id=%u)...\n",
+		       server_ip, server_port, scope_id);
+	} else {
+		struct sockaddr_in *sa4 = (struct sockaddr_in *)&sa;
+
+		sa4->sin_family = AF_INET;
+		sa4->sin_addr.s_addr = inet_addr(server_ip);
+		sa4->sin_port = htons(server_port);
+		sa_len = sizeof(*sa4);
+		printf("Connecting to %s:%d...\n", server_ip, server_port);
+	}
+
+	ret = connect(csk, (struct sockaddr *)&sa, sa_len);
+	if (ret < 0) {
+		printf("connect failed: %s\n", strerror(errno));
+		test_result = -1;
+		goto out;
+	}
+	printf("Connected!\n");
+
+	if (setup_tls_ulp(csk) < 0) {
+		test_result = -1;
+		goto out;
+	}
+
+	if (setup_tls_key(csk, 1, 0, cipher_type) < 0 ||
+	    setup_tls_key(csk, 0, 0, cipher_type) < 0) {
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
+			test_result = -1;
+			break;
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
+
+		if (memcmp(buf, echo_buf, n) != 0) {
+			printf("FAIL: Echo data mismatch!\n");
+			test_result = -1;
+			break;
+		}
+		printf("Received echo %zd bytes (ok)\n", echo_total);
+
+		/* Rekey at intervals: send KeyUpdate, update TX, recv KeyUpdate, update RX */
+		if (do_rekey && rekeys_done < num_rekeys &&
+		    (i + 1) == next_rekey_at) {
+			current_gen++;
+			printf("\n=== Client Rekey #%d (gen %d) ===\n",
+			       rekeys_done + 1, current_gen);
+
+			ret = send_tls_key_update(csk, KEY_UPDATE_REQUESTED);
+			if (ret < 0) {
+				printf("FAIL: send KeyUpdate\n");
+				test_result = -1;
+				break;
+			}
+
+			ret = do_tls_rekey(csk, 1, current_gen, cipher_type);
+			if (ret < 0) {
+				test_result = -1;
+				break;
+			}
+
+			if (recv_tls_keyupdate(csk) < 0) {
+				printf("FAIL: recv KeyUpdate from server\n");
+				test_result = -1;
+				break;
+			}
+
+			check_ekeyexpired(csk);
+
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
+	struct sockaddr_storage sa;
+	int lsk = -1, csk = -1, ret;
+	ssize_t n, total = 0, sent;
+	int current_gen = 0;
+	int test_result = 0;
+	int recv_count = 0;
+	char *buf = NULL;
+	int record_type;
+	socklen_t sa_len;
+	int max_size;
+	int one = 1;
+
+	max_size = random_size_max > 0 ? random_size_max : send_size;
+	if (max_size < MIN_BUF_SIZE)
+		max_size = MIN_BUF_SIZE;
+	buf = malloc(max_size);
+	if (!buf) {
+		printf("failed to allocate buffer\n");
+		test_result = -1;
+		goto out;
+	}
+
+	lsk = socket(addr_family, SOCK_STREAM, IPPROTO_TCP);
+	if (lsk < 0) {
+		printf("failed to create socket: %s\n", strerror(errno));
+		test_result = -1;
+		goto out;
+	}
+
+	setsockopt(lsk, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one));
+
+	memset(&sa, 0, sizeof(sa));
+	if (addr_family == AF_INET6) {
+		struct sockaddr_in6 *sa6 = (struct sockaddr_in6 *)&sa;
+
+		sa6->sin6_family = AF_INET6;
+		sa6->sin6_addr = in6addr_any;
+		sa6->sin6_port = htons(server_port);
+		sa_len = sizeof(*sa6);
+	} else {
+		struct sockaddr_in *sa4 = (struct sockaddr_in *)&sa;
+
+		sa4->sin_family = AF_INET;
+		sa4->sin_addr.s_addr = INADDR_ANY;
+		sa4->sin_port = htons(server_port);
+		sa_len = sizeof(*sa4);
+	}
+
+	ret = bind(lsk, (struct sockaddr *)&sa, sa_len);
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
+	if (addr_family == AF_INET6)
+		printf("Server listening on [::]:%d (IPv6)\n", server_port);
+	else
+		printf("Server listening on 0.0.0.0:%d (IPv4)\n", server_port);
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
+	if (setup_tls_ulp(csk) < 0) {
+		test_result = -1;
+		goto out;
+	}
+
+	if (setup_tls_key(csk, 1, 0, cipher_type) < 0 ||
+	    setup_tls_key(csk, 0, 0, cipher_type) < 0) {
+		test_result = -1;
+		goto out;
+	}
+
+	printf("TLS %s setup complete. Receiving...\n",
+	       cipher_name(cipher_type));
+
+	/* Main receive loop - detect KeyUpdate via MSG_PEEK + recvmsg */
+	while (1) {
+		n = recv(csk, buf, max_size, MSG_PEEK | MSG_DONTWAIT);
+		if (n < 0 &&
+		    (errno == EIO || errno == ENOMSG || errno == EAGAIN)) {
+			n = recv_tls_message(csk, buf, max_size, &record_type);
+		} else if (n > 0) {
+			n = recv_tls_message(csk, buf, max_size, &record_type);
+		} else if (n == 0) {
+			printf("Connection closed by client\n");
+			break;
+		}
+
+		if (n <= 0) {
+			if (n < 0)
+				printf("recv failed: %s\n", strerror(errno));
+			break;
+		}
+
+		/* Handle KeyUpdate: update RX, send response, update TX */
+		if (record_type == TLS_RECORD_TYPE_HANDSHAKE &&
+		    n >= 1 && buf[0] == TLS_HANDSHAKE_KEY_UPDATE) {
+			current_gen++;
+			printf("\n=== Server Rekey #%d (gen %d) ===\n",
+			       rekeys_done + 1, current_gen);
+			printf("Received KeyUpdate from client (%zd bytes)\n",
+			       n);
+
+			check_ekeyexpired(csk);
+
+			ret = do_tls_rekey(csk, 0, current_gen, cipher_type);
+			if (ret < 0) {
+				test_result = -1;
+				break;
+			}
+
+			ret = send_tls_key_update(csk,
+						  KEY_UPDATE_NOT_REQUESTED);
+			if (ret < 0) {
+				printf("Failed to send KeyUpdate\n");
+				test_result = -1;
+				break;
+			}
+
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
+		total += n;
+		recv_count++;
+		printf("Received %zd bytes (total: %zd, count: %d)\n",
+		       n, total, recv_count);
+
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
+	printf("                Supports both IPv4 and IPv6 addresses\n");
+	printf("  -6            Use IPv6 (server only, default: IPv4)\n");
+	printf("  -p <port>     Server port (default: 4433)\n");
+	printf("  -b <size>     Send buffer (record) size (default: 16384)\n");
+	printf("  -r <max>      Use random send buffer sizes (1..<max>)\n");
+	printf("  -v <version>  TLS version: 1.2 or 1.3 (default: 1.3)\n");
+	printf("  -c <cipher>   Cipher: 128 or 256 (default: 128)\n");
+	printf("  --rekey[=N]   Enable rekey (default: 1, TLS 1.3 only)\n");
+	printf("  --help        Show this help message\n");
+	printf("\nExample (IPv4):\n");
+	printf("  Node A: %s server\n", prog);
+	printf("  Node B: %s client -s 192.168.20.2\n", prog);
+	printf("\nExample (IPv6):\n");
+	printf("  Node A: %s server -6\n", prog);
+	printf("  Node B: %s client -s 2001:db8::1\n", prog);
+	printf("\nRekey Example (3 rekeys, TLS 1.3 only):\n");
+	printf("  Node A: %s server --rekey=3\n", prog);
+	printf("  Node B: %s client -s 192.168.20.2 --rekey=3\n", prog);
+}
+
+int main(int argc, char *argv[])
+{
+	int i;
+
+
+	for (i = 1; i < argc; i++) {
+		if (strcmp(argv[i], "--help") == 0 ||
+		    strcmp(argv[i], "-h") == 0) {
+			print_usage(argv[0]);
+			return 0;
+		}
+	}
+
+	for (i = 1; i < argc; i++) {
+		parse_rekey_option(argv[i]);
+		if (strcmp(argv[i], "-s") == 0 && i + 1 < argc) {
+			server_ip = argv[i + 1];
+			addr_family = detect_addr_family(server_ip);
+			if (addr_family < 0) {
+				printf("ERROR: Invalid IP address '%s'\n",
+				       server_ip);
+				return -1;
+			}
+		}
+		if (strcmp(argv[i], "-p") == 0 && i + 1 < argc)
+			server_port = atoi(argv[i + 1]);
+		if (strcmp(argv[i], "-6") == 0)
+			addr_family = AF_INET6;
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
+	if (tls_version == 12 && do_rekey) {
+		printf("WARNING: TLS 1.2 does not support rekey\n");
+		do_rekey = 0;
+	}
+
+	printf("Address Family: %s\n", addr_family == AF_INET6 ? "IPv6" : "IPv4");
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
index 000000000000..5d14cb7d2e3c
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/tls_hw_offload.py
@@ -0,0 +1,281 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""Test kTLS hardware offload using a C helper binary."""
+
+from lib.py import ksft_run, ksft_exit, ksft_pr, KsftSkipEx, ksft_true
+from lib.py import NetDrvEpEnv
+from lib.py import cmd, bkg, wait_port_listen, rand_port
+import time
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
+def read_tls_stats():
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
+    if decrypt_err_diff > 0:
+        ksft_pr(f"ERROR: TlsDecryptError increased by {decrypt_err_diff}")
+        errors += 1
+
+    ksft_pr(f"=== Verification {'PASSED' if errors == 0 else 'FAILED'} ===\n")
+    return errors == 0
+
+
+def run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=0, buffer_size=None, random_max=None):
+    port = rand_port()
+
+    server_cmd = f"{cfg.bin_remote} server -p {port} -c {cipher} -v {tls_version}"
+    if rekey > 0:
+        server_cmd += f" --rekey={rekey}"
+    if random_max:
+        server_cmd += f" -r {random_max}"
+    elif buffer_size:
+        server_cmd += f" -b {buffer_size}"
+
+    client_cmd = (f"{cfg.bin_local} client -s {cfg.remote_addr_v['4']} "
+                  f"-p {port} -c {cipher} -v {tls_version}")
+    if rekey > 0:
+        client_cmd += f" --rekey={rekey}"
+    if random_max:
+        client_cmd += f" -r {random_max}"
+    elif buffer_size:
+        client_cmd += f" -b {buffer_size}"
+
+    test_desc = f"cipher={cipher}, version={tls_version}, rekey={rekey}"
+    if random_max:
+        test_desc += f", random_size=1-{random_max}"
+    elif buffer_size:
+        test_desc += f", buffer={buffer_size}"
+    ksft_pr(f"Starting TLS test: {test_desc}")
+
+    stats_before_local = read_tls_stats()
+    stats_before_remote = read_tls_stats_remote(cfg)
+
+    with bkg(server_cmd, host=cfg.remote, exit_wait=True):
+        wait_port_listen(port, host=cfg.remote)
+        time.sleep(0.5)
+
+        ksft_pr("Running client...")
+        result = cmd(client_cmd, fail=False)
+        time.sleep(1)
+
+    stats_after_local = read_tls_stats()
+    stats_after_remote = read_tls_stats_remote(cfg)
+
+    ksft_pr("\n=== Client Side Verification ===")
+    client_ok = verify_tls_counters(stats_before_local, stats_after_local, rekey, False)
+
+    ksft_pr("\n=== Server Side Verification ===")
+    server_ok = verify_tls_counters(stats_before_remote, stats_after_remote, rekey, True)
+
+    ksft_true(result.ret == 0, "Client completed successfully")
+    ksft_true(client_ok, "Client TLS counters verified")
+    ksft_true(server_ok, "Server TLS counters verified")
+
+
+def read_tls_stats_remote(cfg):
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
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=0)
+
+
+def test_tls_offload_aes256(cfg):
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="256", tls_version="1.3", rekey=0)
+
+
+def test_tls_offload_tls12(cfg):
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="128", tls_version="1.2", rekey=0)
+
+
+def test_tls_offload_tls12_aes256(cfg):
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="256", tls_version="1.2", rekey=0)
+
+
+def test_tls_offload_rekey(cfg):
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=1)
+
+
+def test_tls_offload_rekey_multiple(cfg):
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=99)
+
+
+def test_tls_offload_small_records(cfg):
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=30, buffer_size=512)
+
+
+def test_tls_offload_large_records(cfg):
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=10, buffer_size=2097152)
+
+
+def test_tls_offload_random_sizes(cfg):
+    cfg.require_ipver("4")
+    check_tls_support(cfg)
+    run_tls_test(cfg, cipher="128", tls_version="1.3", rekey=20, random_max=8192)
+
+
+def main() -> None:
+    with NetDrvEpEnv(__file__, nsim_test=False) as cfg:
+        cfg.bin_local = cfg.test_dir / "tls_hw_offload"
+        if not cfg.bin_local.exists():
+            raise KsftSkipEx(f"tls_hw_offload binary not found at {cfg.bin_local}")
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
-- 
2.25.1


