Return-Path: <netdev+bounces-229039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B71CBD766E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 07:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26F013A548D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 05:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A60328EA72;
	Tue, 14 Oct 2025 05:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qdkbjjxh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83650286415
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 05:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760419147; cv=none; b=KH9OLm8SgtLiv4f+Ba3IOt2qNbfYTz38ozzzudPeNhiZ6yKxUmYuan5Vqxd3Si+TGUowOCX1PWbDSkrTmd957uQOP47p5FLIB9YUC2XEkJU/+0Z8apFpacErew6B/DE02tZwgdEcy680lzkEd8TrY4Cx37X+5ZWNGkjg7Ulbnkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760419147; c=relaxed/simple;
	bh=0891Evs5lqD54TbgKetbZhn/3ldOwvcF7ftrNN99I78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sQCGKbDyWiQhx5O9RIo5S84sXnW3Jn+YTuTfLJT9XfBZRDwEs2QccqJSVkLL7/ZzcM24X7AaDk0LjRM8dNui0smXrnotoh9Ubjbodyl6cDVDxzqqhVaUKwwUUwryYcjDaIBkn+i+9C9kz/JVoKlcNtOJTDVZqViQoiPGpA93Xa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qdkbjjxh; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-27ee41e074dso56928245ad.1
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 22:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760419144; x=1761023944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MS5ghyNqywnKYwR1bU0C0clme92ktuteU3RH8OfSvOI=;
        b=QdkbjjxhdW4ZmN8gxnQQbO/cQj4D0WY4LXASd61YIkENfjTXuSUAO8QghELRXDU1hz
         kR3FlzWIc1q5NY01QC9QpJ5G/NPih3QJe+AhCHj/jq5zER2bdJw0nAjW2I6A/6xuKrn9
         DFQIaWLBR3HqTHpYxTmOvangy+LecEfkssa6eXPIeBkFwP3GL+5csLMimZeSQCbR6tsM
         rd19r8vW00odjbdD4yed1yQobrtzgdGqe39BjjqQ6+d2Z06uARSY+Y/Oxwu0vzsmIxiH
         UWxMh4gaValILSG4DaNEpgfwkpFZOTkFWTdwKmnTsH2fQXaRyzsRVS8VQGQn9xRkEZ/f
         5RAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760419144; x=1761023944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MS5ghyNqywnKYwR1bU0C0clme92ktuteU3RH8OfSvOI=;
        b=bmys/34PGJQe2HEhVM/BK5k5iQYL7PcwVXjge4mFBd7/M0/NPTZq7niop9mNuJuZhd
         /qvnVWDUIfXe/HIGjeL94Qp3RPTHfBL1BInapd2P/tTMu/Tq5YpYk44hH4LfBzG9+1LP
         Vc4bYv0xOuSbDHOkkx5JC2FSwSfBdz8asl35a4YCLQVGn5YS1Ho8Kf2H1+JRYdifM0ha
         nAdMcATnSHQJABPIlNNNmfOadrMZLXS2du+/j1JBXEEUly1Xm4UPOAHQEnkJdjAZDZ1w
         coKQbnjxgCEblM5EYkrPHlhSe+yrqVjwDrkyV3y/Nq1aK9h2EOEkQ93niGX1oDTTmZXk
         e82g==
X-Forwarded-Encrypted: i=1; AJvYcCX/emlE4o3OlZaiVSmgVLVnc6PxR4LFev+kGYRmdAZQrc/hVoGhZ/w6D3Tkudh+8NQ+XuFbwlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS6m6zPvwPdCzzgZP7BG23lG3bbvlSoDWiBQWNFsGL3b2Sac/6
	gsPzIyRDEXzLJD+TSk6tQTH3NPfbV9B+ndsmeuIot4OyFYTWmQ+b3xjY
X-Gm-Gg: ASbGncsafPkbeHpJ5QjCV58FNX7OBdfEetImqLZne7vGCvPRoeURSbIOrk1UQzh3o52
	O++F2VwH9MSjiqyDpus3k+GBFejGDkyA+9Nlc9Di/k7DZ10A68JS/MAxojnl0sGXCr66CncO17v
	h34eO1R5ObSpHdBm9AnlRLaAi8PnoeZtbB68jLhfF8xYa+vFjYBHKq6p4RliSith/ISAdpRs8Jq
	XL+MW0yuVpR6EE4DCtZXKWH67Zmca8RLGIU2QXIgPBYIMjCOsCucFb121b8Wj2kyRx009xKespf
	N7TAlKJaUL2434Ukut3Bk5DLviJPKKU1eHDxao/fERdtroVQjCi/K38phVMEnuTygGsfkLywXLD
	RXPBVI5ciFT+KiB7zKWZ09tv6A7VcF69PukVbFa2q46lv1XaLLg==
X-Google-Smtp-Source: AGHT+IHpU6mGXZfoT5qQhUchdAk9g8Q+a7l0nInuSHiJEbwP4Nc8pJjP1AfMYRqiNiWA/AF+l9MMYg==
X-Received: by 2002:a17:902:ef11:b0:251:5900:9803 with SMTP id d9443c01a7336-2902723b876mr300456215ad.21.1760419143758;
        Mon, 13 Oct 2025 22:19:03 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f08d0fsm151575385ad.63.2025.10.13.22.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 22:19:03 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH net-next v5 2/2] selftests: tls: add tls record_size_limit test
Date: Tue, 14 Oct 2025 15:18:27 +1000
Message-ID: <20251014051825.1084403-4-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014051825.1084403-2-wilfred.opensource@gmail.com>
References: <20251014051825.1084403-2-wilfred.opensource@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Test that outgoing plaintext records respect the tls TLS_TX_MAX_PAYLOAD_LEN
set using setsockopt(). The limit is set to be 128, thus, in all received
records, the plaintext must not exceed this amount.

Also test that setting a new record size limit whilst a pending open
record exists is handled correctly by discarding the request.

Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
Changes V4 -> V5:
	- Cleanup unused variables
	- Use ASSERT_EQ more aptly

V4: https://lore.kernel.org/netdev/20250923053207.113938-2-wilfred.opensource@gmail.com/
---
 tools/testing/selftests/net/tls.c | 141 ++++++++++++++++++++++++++++++
 1 file changed, 141 insertions(+)

diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index e788b84551ca..158dec851176 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -2791,6 +2791,147 @@ TEST_F(tls_err, oob_pressure)
 		EXPECT_EQ(send(self->fd2, buf, 5, MSG_OOB), 5);
 }
 
+/*
+ * Parse a stream of TLS records and ensure that each record respects
+ * the specified @max_payload_len.
+ */
+static size_t parse_tls_records(struct __test_metadata *_metadata,
+				const __u8 *rx_buf, int rx_len, int overhead,
+				__u16 max_payload_len)
+{
+	const __u8 *rec = rx_buf;
+	size_t total_plaintext_rx = 0;
+	const __u8 rec_header_len = 5;
+
+	while (rec < rx_buf + rx_len) {
+		__u16 record_payload_len;
+		__u16 plaintext_len;
+
+		/* Sanity check that it's a TLS header for application data */
+		ASSERT_EQ(rec[0], 23);
+		ASSERT_EQ(rec[1], 0x3);
+		ASSERT_EQ(rec[2], 0x3);
+
+		memcpy(&record_payload_len, rec + 3, 2);
+		record_payload_len = ntohs(record_payload_len);
+		ASSERT_GE(record_payload_len, overhead);
+
+		plaintext_len = record_payload_len - overhead;
+		total_plaintext_rx += plaintext_len;
+
+		/* Plaintext must not exceed the specified limit */
+		ASSERT_LE(plaintext_len, max_payload_len);
+		rec += rec_header_len + record_payload_len;
+	}
+
+	return total_plaintext_rx;
+}
+
+TEST(tx_max_payload_len)
+{
+	struct tls_crypto_info_keys tls12;
+	int cfd, ret, fd, overhead;
+	size_t total_plaintext_rx = 0;
+	__u8 tx[1024], rx[2000];
+	__u16 limit = 128;
+	__u16 opt = 0;
+	unsigned int optlen = sizeof(opt);
+	bool notls;
+
+	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_CCM_128,
+			     &tls12, 0);
+
+	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
+
+	if (notls)
+		exit(KSFT_SKIP);
+
+	/* Don't install keys on fd, we'll parse raw records */
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX, &tls12, tls12.len);
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, &limit,
+			 sizeof(limit));
+	ASSERT_EQ(ret, 0);
+
+	ret = getsockopt(cfd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, &opt, &optlen);
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(limit, opt);
+	EXPECT_EQ(optlen, sizeof(limit));
+
+	memset(tx, 0, sizeof(tx));
+	ASSERT_EQ(send(cfd, tx, sizeof(tx), 0), sizeof(tx));
+	close(cfd);
+
+	ret = recv(fd, rx, sizeof(rx), 0);
+
+	/*
+	 * 16B tag + 8B IV -- record header (5B) is not counted but we'll
+	 * need it to walk the record stream
+	 */
+	overhead = 16 + 8;
+	total_plaintext_rx = parse_tls_records(_metadata, rx, ret, overhead,
+					       limit);
+
+	ASSERT_EQ(total_plaintext_rx, sizeof(tx));
+	close(fd);
+}
+
+TEST(tx_max_payload_len_open_rec)
+{
+	struct tls_crypto_info_keys tls12;
+	int cfd, ret, fd, overhead;
+	size_t total_plaintext_rx = 0;
+	__u8 tx[1024], rx[2000];
+	__u16 tx_partial = 256;
+	__u16 og_limit = 512, limit = 128;
+	bool notls;
+
+	tls_crypto_info_init(TLS_1_2_VERSION, TLS_CIPHER_AES_CCM_128,
+			     &tls12, 0);
+
+	ulp_sock_pair(_metadata, &fd, &cfd, &notls);
+
+	if (notls)
+		exit(KSFT_SKIP);
+
+	/* Don't install keys on fd, we'll parse raw records */
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX, &tls12, tls12.len);
+	ASSERT_EQ(ret, 0);
+
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, &og_limit,
+			 sizeof(og_limit));
+	ASSERT_EQ(ret, 0);
+
+	memset(tx, 0, sizeof(tx));
+	ASSERT_EQ(send(cfd, tx, tx_partial, MSG_MORE), tx_partial);
+
+	/*
+	 * Changing the payload limit with a pending open record should
+	 * not be allowed.
+	 */
+	ret = setsockopt(cfd, SOL_TLS, TLS_TX_MAX_PAYLOAD_LEN, &limit,
+			 sizeof(limit));
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EBUSY);
+
+	ASSERT_EQ(send(cfd, tx + tx_partial, sizeof(tx) - tx_partial, MSG_EOR),
+		  sizeof(tx) - tx_partial);
+	close(cfd);
+
+	ret = recv(fd, rx, sizeof(rx), 0);
+
+	/*
+	 * 16B tag + 8B IV -- record header (5B) is not counted but we'll
+	 * need it to walk the record stream
+	 */
+	overhead = 16 + 8;
+	total_plaintext_rx = parse_tls_records(_metadata, rx, ret, overhead,
+					       og_limit);
+	ASSERT_EQ(total_plaintext_rx, sizeof(tx));
+	close(fd);
+}
+
 TEST(non_established) {
 	struct tls12_crypto_info_aes_gcm_256 tls12;
 	struct sockaddr_in addr;
-- 
2.51.0


