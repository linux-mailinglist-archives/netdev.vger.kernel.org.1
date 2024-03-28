Return-Path: <netdev+bounces-82852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5599B88FF2E
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 13:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770E11C26F75
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 12:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B3B7F49C;
	Thu, 28 Mar 2024 12:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HAvDne/M"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445537FBA9
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 12:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711629547; cv=none; b=DmzJNj8gDK851JVuD3wCfNPphQt5RqYK8q1lNenWkTytXH0bS6bof7di6i3nNMWrwcf6BTStzK5IPj0ZVI5Q3yMGsH2x08bYDxAtqj1INZgLQL2YQBTrVxgOLZzmxbyBrcN5cvPRMwX/E0Q6/uzDwuJGtGirYCjSjnb6NLMom1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711629547; c=relaxed/simple;
	bh=LhEmO1/QpTYLcqhWQ1oIVDE/05mjh3QmxpGCsp1Ngzo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VzXcKROnFI/hbCFOnVqhVIY+4HCmhqfO+65aOZF2IFgJ52K/B0uoUEbjtxLzs0vR6/VgorzIuI/h+j1Nzl0fw/gFBjAeWjjeL6auINpdF6TafjbIpCVMHTvTADAuq3yLNZA0mDwwoJXhpp4u12MX0lJdna3bdItcJuVhs9FbkXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HAvDne/M; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-6ea838bf357so816882b3a.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 05:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711629545; x=1712234345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GCsDnnNASp8ef4/b0tg4ZDvexLdNUsjbgwDUzBJT2lQ=;
        b=HAvDne/MDmGSAYZBrDfHRu/Kn/pLEFK6X80QT/QD0YpYWHGN+03mXUsrbNL3IarUwu
         c3we2EfpxQbtFgpKt8hiIauzNjpqRL1M6YZRCSi95lbk8uyAZF0e2sj75BxZ5HW7jkLg
         l7KMF0+v75RHLwz9dCqd3HFjKbgMPN/7JR7Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711629545; x=1712234345;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCsDnnNASp8ef4/b0tg4ZDvexLdNUsjbgwDUzBJT2lQ=;
        b=thtkNhzRrqHDPxiDzZ9kPk21W5XKzzg5S60VFZUFOJOLvMQYB7EaR37ylXCF5SFYp/
         Jdl+aD88s6xS5k1FlY4raEUjPVty/nMcc3FnmNl2FeUUNLM4xrcPAAjcMb2BgWSQaEg3
         InW4QMruwhDRCX1mq5E0mvJJsbhuwu9Jd3c4F7TwnWU9DbSY7ZasemayCQMpRm/6OQcP
         2nyfS63wNSiKWqZn8FPk6IkBN9hss/c/E4XMfy8WnCEY3WSesfRUM28iIMYrBVi2ruo8
         LHtW/9gyIHdc/re+kHwEg8hzw+m3no3CVG2hSxc9QldDb8rC/4yFZuU2B+1kXygLATuK
         w1Lg==
X-Forwarded-Encrypted: i=1; AJvYcCXr5c3VC0p9g3UbcgHtx95D4OGFLASLYiLodcw0D3Aaw/wsC29CB3q6jvS9cMwKy8vP+pVeXj80CZQmowAhoJmlKtVQTzND
X-Gm-Message-State: AOJu0YzOhrb7aS77MrzZW5jptRq642c5ghAprhUtPWyKbe9BxBuyvK93
	tXaYWOEzZaanhkOqyjYDD91/FadKEUfCudrZTCdUkLrR2mtTfKwS2Bq/oLe/Ig==
X-Google-Smtp-Source: AGHT+IGIRxGSrxYY3VCs5Jj9rn9qLfuCbkVocf3OMBUZsTxdS3k81sJrbt3PnRXofn/Pb2GTq6PCKA==
X-Received: by 2002:a05:6a20:7346:b0:1a5:6f7e:3b81 with SMTP id v6-20020a056a20734600b001a56f7e3b81mr1346855pzc.41.1711629545458;
        Thu, 28 Mar 2024 05:39:05 -0700 (PDT)
Received: from srish-ubuntu-desktop.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id a18-20020aa780d2000000b006e6cc93381esm1256685pfn.125.2024.03.28.05.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 05:39:05 -0700 (PDT)
From: Srish Srinivasan <srish.srinivasan@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: borisp@nvidia.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	vakul.garg@nxp.com,
	davejwatson@fb.com,
	netdev@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	Srish Srinivasan <srish.srinivasan@broadcom.com>
Subject: [PATCH 6.1.y] net: tls: handle backlogging of crypto requests
Date: Thu, 28 Mar 2024 18:08:05 +0530
Message-Id: <20240328123805.3886026-1-srish.srinivasan@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Kicinski <kuba@kernel.org>

commit 8590541473188741055d27b955db0777569438e3 upstream

Since we're setting the CRYPTO_TFM_REQ_MAY_BACKLOG flag on our
requests to the crypto API, crypto_aead_{encrypt,decrypt} can return
 -EBUSY instead of -EINPROGRESS in valid situations. For example, when
the cryptd queue for AESNI is full (easy to trigger with an
artificially low cryptd.cryptd_max_cpu_qlen), requests will be enqueued
to the backlog but still processed. In that case, the async callback
will also be called twice: first with err == -EINPROGRESS, which it
seems we can just ignore, then with err == 0.

Compared to Sabrina's original patch this version uses the new
tls_*crypt_async_wait() helpers and converts the EBUSY to
EINPROGRESS to avoid having to modify all the error handling
paths. The handling is identical.

Fixes: a54667f6728c ("tls: Add support for encryption using async offload accelerator")
Fixes: 94524d8fc965 ("net/tls: Add support for async decryption of tls records")
Co-developed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Link: https://lore.kernel.org/netdev/9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net/
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
[Srish: fixed merge-conflict in stable branch linux-6.1.y,
needs to go on top of https://lore.kernel.org/stable/20240307155930.913525-1-lee@kernel.org/]
Signed-off-by: Srish Srinivasan <srish.srinivasan@broadcom.com>
---
 net/tls/tls_sw.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 2bd27b777..61b01dfc6 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -195,6 +195,17 @@ static void tls_decrypt_done(crypto_completion_data_t *data, int err)
 	struct sock *sk;
 	int aead_size;
 
+	/* If requests get too backlogged crypto API returns -EBUSY and calls
+	 * ->complete(-EINPROGRESS) immediately followed by ->complete(0)
+	 * to make waiting for backlog to flush with crypto_wait_req() easier.
+	 * First wait converts -EBUSY -> -EINPROGRESS, and the second one
+	 * -EINPROGRESS -> 0.
+	 * We have a single struct crypto_async_request per direction, this
+	 * scheme doesn't help us, so just ignore the first ->complete().
+	 */
+	if (err == -EINPROGRESS)
+		return;
+
 	aead_size = sizeof(*aead_req) + crypto_aead_reqsize(aead);
 	aead_size = ALIGN(aead_size, __alignof__(*dctx));
 	dctx = (void *)((u8 *)aead_req + aead_size);
@@ -268,6 +279,10 @@ static int tls_do_decryption(struct sock *sk,
 	}
 
 	ret = crypto_aead_decrypt(aead_req);
+	if (ret == -EBUSY) {
+		ret = tls_decrypt_async_wait(ctx);
+		ret = ret ?: -EINPROGRESS;
+	}
 	if (ret == -EINPROGRESS) {
 		if (darg->async)
 			return 0;
@@ -452,6 +467,9 @@ static void tls_encrypt_done(crypto_completion_data_t *data, int err)
 	bool ready = false;
 	struct sock *sk;
 
+	if (err == -EINPROGRESS) /* see the comment in tls_decrypt_done() */
+		return;
+
 	rec = container_of(aead_req, struct tls_rec, aead_req);
 	msg_en = &rec->msg_encrypted;
 
@@ -560,6 +578,10 @@ static int tls_do_encryption(struct sock *sk,
 	atomic_inc(&ctx->encrypt_pending);
 
 	rc = crypto_aead_encrypt(aead_req);
+	if (rc == -EBUSY) {
+		rc = tls_encrypt_async_wait(ctx);
+		rc = rc ?: -EINPROGRESS;
+	}
 	if (!rc || rc != -EINPROGRESS) {
 		atomic_dec(&ctx->encrypt_pending);
 		sge->offset -= prot->prepend_size;
-- 
2.34.1

