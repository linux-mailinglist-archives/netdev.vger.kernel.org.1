Return-Path: <netdev+bounces-229427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B5CBDC0F8
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 03:53:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073D919A25F6
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 01:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CAAA30BF5A;
	Wed, 15 Oct 2025 01:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AnOhyz93"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7B425A35D
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760493204; cv=none; b=cRQ2mEWRuYbDbZO6VS9oFa9GrHc4qo+0sglL0jUjt6EBsXnSQ1su8gGL/ucgg7w04kdsatTKpIZT3WbOEpHq9YEnhjYw63i/gnmGH7DMUymx4531VuMuDQS3TsAk3G5zs8kcLDyAnTXVUWSg0lbdlUEj9lylUr7f6REcVtDNwho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760493204; c=relaxed/simple;
	bh=9RRIxNvkdJzZEHQcDLQmeYeLTnGKYUa3WGMGZiJeAKY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JT94qMQUXLWmVFnBqCw7+B2F0lqoU8fq2p/rADEFzlcCIIzZXw2qJvBW1VDpJxFn5uFul6zVsHwYBFwgnIxFurq43JDZU4SRShNaENoErAt9UDo8v8bHk4N3Z8ykCGzhKa5tlKdfsOc+/E32mkX/ngQD12aDipcZGFi+JuN6jwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AnOhyz93; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-789fb76b466so5534378b3a.0
        for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 18:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760493197; x=1761097997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4jaCd/1DWbgn+CA8tzmONaNbKtsGtABNKa+v5VGOeQ=;
        b=AnOhyz936MVwprfv8AfzeB8rgqXUFnCesu+hA/7GHZip2quvOBMstkonHszmwxEo8e
         h7S6q6qtDqpCFVU+50dw+BeIQyhJbJ+2IzrpG24OenoJp2Bv6slhYhLJU8JID/Ia4d5F
         Xxu3hYvLSieJ8LRh5uxVPFQJnj3SJLzpmyaJ6o4C9SvNK8tomcDp/XMkc/VM5xrLKIfe
         pjeHTHMDL6o51U8pua3sCXPnV1qMo7eWeNzPFndNvqH3IIYiYmGhdw5t+BserYu7S/qU
         vulvyw/hYTL4+8Rr1qE0oMqgviypMyBau9iLfPG0jJZCZnG6m/AEnqpjKO+BK3YJY61A
         o4Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760493197; x=1761097997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H4jaCd/1DWbgn+CA8tzmONaNbKtsGtABNKa+v5VGOeQ=;
        b=vB6S+l6pdRsYgI8Yz7V1gUULTMExLam4L0mchSVN/QckQLEwUzCHiQK3CMJpb+tAJv
         vZ1/809LW2ziPJ93tkDgwur7Ao5t8PHQZpuBU+BsjI5/OkHjreyq2IoIYStvT2Egd7fq
         xNukTQwbC13aeOpI2itqz1A7bzo15qgJqovUGDhXrR9F47V2EP5xZIqyMwAzU/qTJ7jU
         0ntUqs+8Xo5GrXM7N1YtbYGWg9+fZHG1TGh6J+F3zOZGsx0murSbtk6n7aj1qtPc5jrG
         Uk0TB34ZFVwCEDYlDOKoGZfjhgZfUaZn+Tk9BwBySrRYaLmMfDAjtk1uakKbn8+s5Pdp
         qJRg==
X-Forwarded-Encrypted: i=1; AJvYcCVdZWHiqjAnRx9qMTHpLHaIk1BP94rXAWGrcV/gF9nYZMC1RMhwcF/GAKFGSGC00TiNkCzMcB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkkfY4jXzudge/7rUd/S3PmZpyDe3yXaWHwSX0kLLO8mENF72U
	GrmMlZmhPqaz3/za/7kpOqCTxgoDm6b8YX3tqm0CNv3v+vAib6JzXZPw
X-Gm-Gg: ASbGncs5cZ3W/iCCk72PxExnjJQug945VzPTi1uXvALMEbBWLTQ8Xgv1fyoCxumZLQn
	kBU2bvLO97QUXc5AF+1OdRMoZFVHCRFxMIDoadnqeW3BGRHWh1kfzWkG4RFEtupj9otWMjuRWW4
	l9GH+oQ/l8pxDvWcyHexksV9u5kjP3MEvJd0ehjZeFMrsbxd6XZ11OLL45o2bozezIR39BPxA+6
	bL82jD5NDSsSYucuvSZeYuO6p5VnaI5ibLyq6hyHdCeprDTKSTDmroFDQh6TBdAjYumFq4Oh+ix
	dyfbOpBfrUNpc7P3xb47ZsNK1a7V+vvSBTZPosPzDDi8EopBgA758jndOZ9BxX0TLh0ndIOuzRF
	0Vj1V5ERy/6IfXgwk0fsUfdHw25k/YN9vDz+k455EEr4HCpYGjapAnOmy
X-Google-Smtp-Source: AGHT+IEta6vNkL2qYn4xecoYbGeGh0tvTz8Mzn2/SVZLfq79W+xm/83cjsbfvmppODKW/1L9yy+I2g==
X-Received: by 2002:a17:902:ef0f:b0:27c:56af:88ea with SMTP id d9443c01a7336-290273a5f20mr271822745ad.60.1760493197148;
        Tue, 14 Oct 2025 18:53:17 -0700 (PDT)
Received: from fedora ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29055badc54sm111789325ad.37.2025.10.14.18.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 18:53:16 -0700 (PDT)
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
Subject: [PATCH net-next v6 2/2] selftests: tls: add tls record_size_limit test
Date: Wed, 15 Oct 2025 11:52:44 +1000
Message-ID: <20251015015243.72259-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015015243.72259-2-wilfred.opensource@gmail.com>
References: <20251015015243.72259-2-wilfred.opensource@gmail.com>
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


