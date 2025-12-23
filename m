Return-Path: <netdev+bounces-245881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD030CD9ECB
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 17:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE72E30194F1
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 16:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA547327BE4;
	Tue, 23 Dec 2025 16:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKkfjva4";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="m6b9kBHM"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F93318151
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 16:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766506941; cv=none; b=n1/b6lWRFYfA+OFpruPfAi2VC4qu57EU2KHk/1sjgk0d+I+mXFehLEUVXeUPztmygDSk69Rhp1Jw/ibHYvD6gWKC6P7OnPDn0CctIYK4n8cuONmN90uU2jPHT07Kd7lG2jAuV5+sAefAMmaq/okQs1JhsUkBiUbPibES8AUb+vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766506941; c=relaxed/simple;
	bh=/0xYbPL616qbJH7DAEtPJytxbsCIUKJ6b4pgntLCSRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJ2ihZMZK4pJr04PI74HencIyJ+T3fgfJaO8GnMDzL/MiC6gvIN/JbQcmmWLrxGi/vNvWHR324jNN/nVxmahw/+tTaDRW5ex1d4nDh+HLwa1EdT/WoBPYJC9geR4t6Cx2sJpfmthwZulV7BR0qpavo6ohKmqU9V8IAH0/w56sOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKkfjva4; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=m6b9kBHM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766506938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=K4/UC+SmvFgSpwuzCxbdSjOFAReaxeGhgnIyBtkiDoY=;
	b=MKkfjva42wQWf0cTi4gynQdZYbZD2kDw4MXi3mmscq/Q9EPgdmu1kE74LA/ORqZ3Yqmxvk
	L3jlyGR6yqnKAtfi8ryQlTRszEAjj7sPZIxAv9gleDcoqGg07ROxgrF2752rsHCx4kqccg
	ouw2nA4tfyn3XebmJd+PO7NIcMfe1nc=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-389-ibUzQB4fNneU7bunOHle3Q-1; Tue, 23 Dec 2025 11:22:17 -0500
X-MC-Unique: ibUzQB4fNneU7bunOHle3Q-1
X-Mimecast-MFC-AGG-ID: ibUzQB4fNneU7bunOHle3Q_1766506936
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-64b4b64011dso726272a12.2
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 08:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1766506935; x=1767111735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K4/UC+SmvFgSpwuzCxbdSjOFAReaxeGhgnIyBtkiDoY=;
        b=m6b9kBHMYlyIZDwxBQRVYBjfUvCItBpwinS2MMpd3WKPrNhWEHLfqRoWAJu8sFTXwQ
         ihawGFSYHmRpl1WcTN5d67iAnNw1NqwZ/ZPW2d5AJJB7hofdw0Sy01DFAFqpxg0Cs6Cq
         uwLHJB75jf5JRwj0Vzbmn/7stH07efhupAEa16gt33JvlWzOB/qZ7TdoPB/ZSooU6vp4
         4xj6iRbdVPyp9yiWx97I9CcoQGdoPvVMTUaAIT4BtEYlbpPWNvhXw6AZBmSxr7bTirdm
         wsRR4uWP7Bwn63K38T47WNLjzvAmuBuoY5ooaLKUjiiuxjUScStS1rgX1qrnVxQtmEvR
         Ng3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766506935; x=1767111735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4/UC+SmvFgSpwuzCxbdSjOFAReaxeGhgnIyBtkiDoY=;
        b=DI9Sz/1Z8CVE+NGYzEI1Ja4PRiuXIbrcgLCpvBRPecaSsdjORajZBU241MunLyTlbK
         ViK83r0MD8d+/s+3aiQ9oXCcy3Y53D1LVEz8tBjgq8VpeFC2XmJS59/NHHd+tkAcw8SM
         +uPBjC0jPgioVul5Rw/Jhz7X02gr5DQu/9+5PvN1JscQburLsHv6J5kQNIw91bk59UaN
         +/CcRRLLq+YuNX9+X7qctoJ/H7VxYpB4WjHsTOtL4FLsS7F5AZGrDPOqc1hub9Yl2gl0
         UdRVrBOyR3BQsA+LV2TSl5dlUpsv0TcSGGR4Qz5CaUogBx70lioSkN7U3ZTxTNK7x3v+
         S9Jw==
X-Gm-Message-State: AOJu0YxkOtO4JNMejWmNOjJN4lLJnoPuzNNtlkHwBlJcmnngBrrhltau
	YgWKaWzdl6qjK0sRnmM2MQrTZ5Wm8gPbhuS1Pr6bqVnGJ8JKgSNcSdH1+M6jkvZmZGfAzWaRMCf
	96xvOCkKfYV+LPXYNg/xS5y8sz5+I3ontZPU7Kb3Ych9htnpB9cI6GFCRYi+U+//ACirwuIMZM8
	C45pxiTDcriDbf3B5kw/4Aw8+vIu0i5PXNDp4JIGVxzDMD+zM=
X-Gm-Gg: AY/fxX5Dtno30olEa8wpRnJbbxgdv8EJydCm3mjDDBZbhW9E9fX6xKLMwPZHL2Nxnbp
	XLB0SIZ5JEdMJEvZ2vHi2F+k6+a352R9jf44pmbXK5cfMOIxrGCWKkUX1+/xCPEJRkmkskrylW/
	YUHyAOUGzCp79e5MubJTmQ1wmMGHfiSEokdpvGWPrXxjFkHAxP56bKhxorREdwbWCBAATwVipv7
	RRSq24flbhNGOZW+iw+zt322is4YrKBCKp6hJxGwgZ6Aenz/kI5uaGtuXE7xXMNoCHW3kVZyQd5
	jS6kx+dZAXvrbHS+HMuSY6P/zh5vUFfq80VVrAjUFZt4/rAetEjA5x4Vu0STZPwr/3jpEe0aYrK
	NLUE=
X-Received: by 2002:a17:906:4fd0:b0:b73:7715:ac83 with SMTP id a640c23a62f3a-b80371d345bmr1471768866b.44.1766506935491;
        Tue, 23 Dec 2025 08:22:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDgtKwDEeqrVZ92+4oKCndyc9wVzJFED1Ykvg3bZfeGJ2owsbM3Hp1YtZvXRag/anoxgIQeQ==
X-Received: by 2002:a17:906:4fd0:b0:b73:7715:ac83 with SMTP id a640c23a62f3a-b80371d345bmr1471765766b.44.1766506934984;
        Tue, 23 Dec 2025 08:22:14 -0800 (PST)
Received: from stex1 ([193.207.129.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8037ab7f7bsm1449868866b.18.2025.12.23.08.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 08:22:14 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH net-next] vsock/test: add a final full barrier after run all tests
Date: Tue, 23 Dec 2025 17:22:10 +0100
Message-ID: <20251223162210.43976-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Garzarella <sgarzare@redhat.com>

If the last test fails, the other side still completes correctly,
which could lead to false positives.

Let's add a final barrier that ensures that the last test has finished
correctly on both sides, but also that the two sides agree on the
number of tests to be performed.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 tools/testing/vsock/util.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/testing/vsock/util.c b/tools/testing/vsock/util.c
index d843643ced6b..9430ef5b8bc3 100644
--- a/tools/testing/vsock/util.c
+++ b/tools/testing/vsock/util.c
@@ -511,6 +511,18 @@ void run_tests(const struct test_case *test_cases,
 
 		printf("ok\n");
 	}
+
+	printf("All tests have been executed. Waiting other peer...");
+	fflush(stdout);
+
+	/*
+	 * Final full barrier, to ensure that all tests have been run and
+	 * that even the last one has been successful on both sides.
+	 */
+	control_writeln("COMPLETED");
+	control_expectln("COMPLETED");
+
+	printf("ok\n");
 }
 
 void list_tests(const struct test_case *test_cases)
-- 
2.52.0


