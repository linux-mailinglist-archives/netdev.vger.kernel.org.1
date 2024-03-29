Return-Path: <netdev+bounces-83231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E00708916B8
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 11:26:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3231AB2338B
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 10:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59542535D2;
	Fri, 29 Mar 2024 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WZgRSXHK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA80535B4
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711707956; cv=none; b=PPyX+sJ0GspKsYHBb5rhldJ9dIg2GNwqKCvEw+hq1TT+Oz17w5kiMlakOm662kwo3Y6lHpmHCxPWv8hIw1l3dab4yRXyYf3FFbbg4+dY5VDJHZ8Yy7xbZW29G6BGydGyV4EPSsDNd1P6LoEpX8WYLxXBX61GUf51+WZEZJ9B1UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711707956; c=relaxed/simple;
	bh=aeLKErVvr4YSADjsNwV4Am4JYwsFoAGfSUFXEh5SdwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O9rWMp+4dXH6igeeK4/N6sgSLFOTJPP/+PzpeZAI1kx/i3C3+NB+5DQxzvjiQxV+2G0xF/kEixiAMyRFaTHdQxMHLG/QU4rZIo9HqI3oSKp4jfHUNSfgU6skaxWXKhGe6xbJeZBFKLSw+mu2uQYBi55xqEwwmA/b4dLWc92IhAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WZgRSXHK; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-6e703e0e5deso1570062b3a.3
        for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 03:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1711707954; x=1712312754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UfARX4cixMR5DHeiB+/xY+prDoGHCgK6LO36+b/JgkM=;
        b=WZgRSXHKcw5gGgf6VaDEUAizdwbDkedfk0c56Zg8Cqf9K/w2U9T2EU7cNCI0wi8OkU
         0sRdqxOsia6rAjPXnKs4X8wHpsiX110XKYawKPC+HHA5loZogKxpUuk66bp0hEQ3doco
         3aq4EDfV87GwBEqTjma57UszO32mcTGxbMV7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711707954; x=1712312754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UfARX4cixMR5DHeiB+/xY+prDoGHCgK6LO36+b/JgkM=;
        b=PNENNZfDZDdQuLAAy3KpH8OuFEGfkdqID5DZwpZTplxA1mFs7EdOJRvHS6wQedebR7
         rnsJt35Y8EgmfeckDtFF4GXSKjYQ1/W2saRQrnXaet2BCejrFda2QOE/ifDAxmeWeiFX
         KyEIdTHvL7Kz0/BdjyUv3k4qqGAHdc1rkZRzUJU08ypiUrYVykO1XHQh3qkhSoTVkr/M
         92h0xvpK7iSrhHceFO7mYL6nQ4nuUVIUJMVSwvfiWO+mmeKa+2zyRviKRJM92Cmy3jr+
         Od4ru6gpvUKugnI2YCKFZ1Fxq3gtkCSx48m8YXgGXUncW7Mkq6pMh9supe2utp9Mq+nM
         uxSQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9zl9I/Ns7h+nJsNcZ7Cf1psipJochts4RVQki/ynzHA57jdNTRLF6RBsXwLU+Sn7hDlAK9sWMSd3Xaw6xYyLtKfI7OZxF
X-Gm-Message-State: AOJu0YyMKe/AeH3IfR69mUT3+P2tpL7vfLSAJUoyji1Ra2vAkEt94Zzx
	wX9XZbGnsauooiTFWFeDt4nfz9WLSjWwnu/y8411q2xsJRChgubCz9VYQ0kEFw==
X-Google-Smtp-Source: AGHT+IFbDg4EvhOnsd7jNyxD3eJ6+MxiAseKoOLJwLRjMg/MtlPvCZTo8P+JY8xZO8NVHBLFDoCTAA==
X-Received: by 2002:a05:6a00:9086:b0:6e6:9f03:6a6d with SMTP id jo6-20020a056a00908600b006e69f036a6dmr2063520pfb.3.1711707953828;
        Fri, 29 Mar 2024 03:25:53 -0700 (PDT)
Received: from srish-ubuntu-desktop.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id fi27-20020a056a00399b00b006e5571be110sm1253679pfb.214.2024.03.29.03.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 03:25:53 -0700 (PDT)
From: Srish Srinivasan <srish.srinivasan@broadcom.com>
To: gregkh@linuxfoundation.org
Cc: ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	borisp@nvidia.com,
	davejwatson@fb.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sashal@kernel.org,
	sd@queasysnail.net,
	srish.srinivasan@broadcom.com,
	stable@vger.kernel.org,
	vakul.garg@nxp.com,
	vasavi.sirnapalli@broadcom.com
Subject: [PATCH v2 6.1.y] net: tls: handle backlogging of crypto requests
Date: Fri, 29 Mar 2024 15:55:40 +0530
Message-Id: <20240329102540.3888561-1-srish.srinivasan@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2024032945-unheated-evacuee-6e0a@gregkh>
References: <2024032945-unheated-evacuee-6e0a@gregkh>
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
[Srish: v2: fixed hunk failures
        fixed merge-conflict in stable branch linux-6.1.y,
        needs to go on top of https://lore.kernel.org/stable/20240307155930.913525-1-lee@kernel.org/]
Signed-off-by: Srish Srinivasan <srish.srinivasan@broadcom.com>
---
 net/tls/tls_sw.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index d53587ff9..e723584fc 100644
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
@@ -451,6 +466,9 @@ static void tls_encrypt_done(crypto_completion_data_t *data, int err)
 	struct tls_rec *rec;
 	struct sock *sk;
 
+	if (err == -EINPROGRESS) /* see the comment in tls_decrypt_done() */
+		return;
+
 	rec = container_of(aead_req, struct tls_rec, aead_req);
 	msg_en = &rec->msg_encrypted;
 
@@ -556,6 +574,10 @@ static int tls_do_encryption(struct sock *sk,
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
2.39.0

