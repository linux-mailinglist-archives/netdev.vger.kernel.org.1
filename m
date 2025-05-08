Return-Path: <netdev+bounces-188997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB18AAAFCBF
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1F31BA61FF
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF5F26FA6C;
	Thu,  8 May 2025 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MX40ca2o"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913F726E15A
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 14:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746714034; cv=none; b=nfZ6JtXQl1W2aMPzA2U59WVYA4oeYPzGJdXRKTbxlqZyw+/k0FqSOAAfhjQEtkEetEvjRF86UcR8/sbXwaqUbmDVX39TK3KHw16sVkZyt8c8X4b4BLeVvMCapZoxsHh23QbratZ9YgsBcwAlZHsmWdU0dpR05kzTUyE4Xkrjjv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746714034; c=relaxed/simple;
	bh=7YG192ZsD3WUn3drwZlMqsrENOopUzB5dGEgYOknoQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d4XPwHKnM1MfIkpfUtvBQtzBXZZU/pUxauyAPGSuGP57qNAGN5zV2rZR7QHTp2xDkNiSM+r2EWE394of1Ta9NHW9gjfWL59bQZXXd6NYQtsFE0Ak42giZ6Bnjfc+FvbLWLkT+mgDxZ2KLlZiMHCaeRqaOsdB1qwd2SWoj4sNcWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MX40ca2o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746714031;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Egj0FQy/riyQmvL5sll8nVIB9OlbYijgnbiGu15AMX0=;
	b=MX40ca2ooU4dW+VGU8okDD/5KC6dtIcqTdi/3lD4SPd6r9+GvCvg7Rrc09Pg6A3mZ8QSUH
	aAphQJGufRGOk/XlpjQCf6wZV2tKYDLfwNBR/49WaH1aMIWzWXqQJeBwx7rAQvmha3H0Ea
	oav4rQK9ZUKmW3iUi8r+z9IYTGsjuSk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-QxHcO0MyPKSEKJjKbtpLZg-1; Thu, 08 May 2025 10:20:30 -0400
X-MC-Unique: QxHcO0MyPKSEKJjKbtpLZg-1
X-Mimecast-MFC-AGG-ID: QxHcO0MyPKSEKJjKbtpLZg_1746714029
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-acb94dbd01fso121408966b.1
        for <netdev@vger.kernel.org>; Thu, 08 May 2025 07:20:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746714029; x=1747318829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Egj0FQy/riyQmvL5sll8nVIB9OlbYijgnbiGu15AMX0=;
        b=iF1zxfAInsQYB6tdhw8QJOX8jji5PambW3l1LcVfy1/vYA0OHL2aA0PTcvZCbehoGq
         FI98MWbwa+YWD2x3w9plDHKQWM8ZEzeOdSbPaQl37CSTYr3/Jeyh9Jso9jJWx3sq5EyP
         re2JVXI0ohz9eJ8UTpScfcbIwxDXMI3KIgtHwKLUMG4+5cELRiXzr+nta97WBhRpkBnb
         A4tBfd6OYI3ZTrnIMXVE80Ttt4AiUOjXOlHuxpHIkWZ3P8NokIu13RwnaUfd5xTH3RqF
         vMxr5esTcj9GrfEO20Iw+IL3jns4Ug3wSm63GxX1MXGrJw+5u4h7Rfb3eIkVCi8TKpVk
         yW0w==
X-Gm-Message-State: AOJu0Yz5Hityc+XEMz+PZ+hjlhFYOkjDHk5XrZUXHhOwy9AaFlv0k5tJ
	CClz0tpcBVjmrfweSLiE3K1OBbDmqUQrHA1VqkJH1Fvts4MXrQjNUHwEkWWV61LPw4t/K0KaHfc
	RaHtvyEtQAiI6llUpFu5zQ+tkjAJcMSz6RGM8njoaQ6Vo9x4qN5Jhv53uHiUpawbmBELayxV+o8
	fNPN1G8J4C0w2AVGQTm+QvagoSyxEB1FD4+SHwDA==
X-Gm-Gg: ASbGncvkWw8t5zLZu1lB6TzJBbAak5NXlYa5tBlQAkt4Sq9WNaUXXnbRNASUk3sJoEX
	41nnMcSC4hyAQcHEFA5ZBbm0ukslK4gyFiPnyywPfU36jeDfy6+anDWtaSnCtmLpBopnGIzZIwU
	1cQnCaT4MbA51PbJUvXlOhP4/Qxbn/9wbOXZurp2bTb1NdS7jh/LGqnHwxOwwrUBueFaAoMDC/c
	7Unqxg9/pwv8I17m01Zxhl7Ohy+DNO/njkCFGI8diSN45HtWpuFSWlHNstSj1fNliR/0RAOq6Ka
	FP9/BBgV4RcIku+ba+hBr39L2Q==
X-Received: by 2002:a17:906:f10a:b0:ad2:15c9:9c73 with SMTP id a640c23a62f3a-ad215c9ade0mr24419766b.34.1746714029003;
        Thu, 08 May 2025 07:20:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/Oe8HK04stKuYdcastU9b8FffLyMB1PLqflqnugfQTg8McvY43KaFdQo960fI2h3cqw+r9g==
X-Received: by 2002:a17:906:f10a:b0:ad2:15c9:9c73 with SMTP id a640c23a62f3a-ad215c9ade0mr24416866b.34.1746714028437;
        Thu, 08 May 2025 07:20:28 -0700 (PDT)
Received: from localhost.localdomain ([193.207.221.155])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad1891a3f1asm1103005766b.64.2025.05.08.07.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 07:20:27 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev
Subject: [PATCH net-next 2/2] vsock/test: check also expected errno on sigpipe test
Date: Thu,  8 May 2025 16:20:05 +0200
Message-ID: <20250508142005.135857-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508142005.135857-1-sgarzare@redhat.com>
References: <20250508142005.135857-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

In the sigpipe test, we expect send() to fail, but we do not check if
send() fails with the errno we expect (EPIPE).

Add this check and repeat the send() in case of EINTR as we do in other
tests.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/vsock_test.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
index 7de870dee1cf..533d9463a297 100644
--- a/tools/testing/vsock/vsock_test.c
+++ b/tools/testing/vsock/vsock_test.c
@@ -1074,9 +1074,13 @@ static void test_stream_check_sigpipe(int fd)
 	do {
 		res = send(fd, "A", 1, 0);
 		timeout_check("send");
-	} while (res != -1);
+	} while (res != -1 && errno == EINTR);
 	timeout_end();
 
+	if (errno != EPIPE) {
+		fprintf(stderr, "unexpected send(2) errno %d\n", errno);
+		exit(EXIT_FAILURE);
+	}
 	if (!have_sigpipe) {
 		fprintf(stderr, "SIGPIPE expected\n");
 		exit(EXIT_FAILURE);
@@ -1088,9 +1092,13 @@ static void test_stream_check_sigpipe(int fd)
 	do {
 		res = send(fd, "A", 1, MSG_NOSIGNAL);
 		timeout_check("send");
-	} while (res != -1);
+	} while (res != -1 && errno == EINTR);
 	timeout_end();
 
+	if (errno != EPIPE) {
+		fprintf(stderr, "unexpected send(2) errno %d\n", errno);
+		exit(EXIT_FAILURE);
+	}
 	if (have_sigpipe) {
 		fprintf(stderr, "SIGPIPE not expected\n");
 		exit(EXIT_FAILURE);
-- 
2.49.0


