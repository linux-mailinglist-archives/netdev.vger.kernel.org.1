Return-Path: <netdev+bounces-108554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E69E4924332
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 18:06:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595C1B20F00
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218B21BD503;
	Tue,  2 Jul 2024 16:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Um5YQS4H"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDEF14D42C
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719936376; cv=none; b=ckiBmsW+5iFsjE+ZRqrAcxdGNxeeyBza+PMFI4LXnxmDgV0L1jJvibBw5r8Y4Wp26ct8xF+cSSuXnZkSN0SLaCfeO0Qpztzclp63RKh0IDeX+8mWSwvi8oVFFzu4PtNNX45Kk1oyFfGHznFFjKSzheI7MOB4FwX25HZ1U7Tz8kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719936376; c=relaxed/simple;
	bh=6bfthXh+z3FlLnjiFbGZ9DImdUQg6HnLJ/s7QzPwJlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gDlKFYFNwVfuXuIXU/NPQxqOxZLpea1t0Auj9xtyXFzBBQr17fEI1+OI+Tbci+vsfE+zEjnEbo7+q5lJxN4He83b3WGKY1nB4AVw+sXsVvnNAV9BceU4Cro51I4Fp9txRT1DxEVmzHkGns+dxhLccvH0eCphHgRBcMS2+9VQz88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Um5YQS4H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719936372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fhomTckPXydN9WWs1SvlxsuDB1WwN1ndD9L0d+zK7Ww=;
	b=Um5YQS4HWhYrMZ5ouy+mHg2XX6Bz5eXfXF3bA7Sz87zh1EYMdTT3pyLkYY35sx5Qt5aLJt
	J96iIwsdIWTSX38ulnVdcCLZZ3O+Q+s4Ypi/qFes776km1JuHYboEwfBbfI1PI9hTJnhWt
	iGrFE4Rwksf7JmeLZUWoaiZUDBz4Cu0=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-_5QD0MF9M3WS45qh75iWkw-1; Tue, 02 Jul 2024 12:06:10 -0400
X-MC-Unique: _5QD0MF9M3WS45qh75iWkw-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1f6174d0421so17636235ad.2
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 09:06:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719936370; x=1720541170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fhomTckPXydN9WWs1SvlxsuDB1WwN1ndD9L0d+zK7Ww=;
        b=KePKZ1ou2ZPSO1Ze3qDH5YY9bzdwCFVjwL47oqUAf92R9qTLF5zSvHYAo2jr75HSpJ
         QdgGhQ0l8zGnxY0EqLDr73Zy5QI1WJ3Pf7df74xcxgvMUFk+5gN2VDG22p2XC5XvG3O2
         7tXCZv22sfctwWuPONRk25yetXbip2iGBK5Zwd8ycMqZY3CHiTlwF+degbEoIdnqZ0Kc
         JB/IDsvktbV6B6hV3WOPa1+R5qy/42v3qapXl23Ya7LKTqmkx/3GPhFTSHwFhowHFnuO
         xrSp8dPWrC+hGMKadBZAxLFTumKiwowWCbKzreTbu3yuh+0GaT061DJ2w4+7f0GR/ivU
         esSw==
X-Forwarded-Encrypted: i=1; AJvYcCUc3KAouZJ7Bga9y7rTf9E+qxHHin+7MydpUp0DAY6id8n6pFzrAUMbTIElnGwphYabOk+bERJpAwIz7Ak/FPh2hXdL+zlJ
X-Gm-Message-State: AOJu0Yyk6Ec1sET9EYqhUH/1Mpt1May06Huaxlv7mtNqupHgWoViPx8E
	qlLqrcw01WyNMPMOYg2kjwaVfhsqMkbcyZeKsvAu2c0nDoLcmvMtwPrCQ1YFykvcP3Q9ehgyqhr
	D6Kswc8Drcgx+hAbnOkWb0hLXSM4TZE4tGEzp5qkoU7bWOYocOBno7w==
X-Received: by 2002:a17:902:cec2:b0:1fa:ab4a:faea with SMTP id d9443c01a7336-1fadbce9d6fmr65165375ad.43.1719936369828;
        Tue, 02 Jul 2024 09:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEotUuIOqN777VHgCHNLN6WhtC1Qu3pqhNm81uCxVDmVMCvhU4/9Nmd7+85UBA5eY+UeYtrPg==
X-Received: by 2002:a17:902:cec2:b0:1fa:ab4a:faea with SMTP id d9443c01a7336-1fadbce9d6fmr65165115ad.43.1719936369422;
        Tue, 02 Jul 2024 09:06:09 -0700 (PDT)
Received: from ryzen.. ([240d:1a:c0d:9f00:ca7f:54ff:fe01:979d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac156903bsm85565195ad.208.2024.07.02.09.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 09:06:09 -0700 (PDT)
From: Shigeru Yoshida <syoshida@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kuniyu@amazon.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH net 2/2] selftest: af_unix: Add test case for backtrack after finalising SCC.
Date: Wed,  3 Jul 2024 01:04:28 +0900
Message-ID: <20240702160428.10153-2-syoshida@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240702160428.10153-1-syoshida@redhat.com>
References: <20240702160428.10153-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@amazon.com>

syzkaller reported a KMSAN splat in __unix_walk_scc() while backtracking
edge_stack after finalising SCC.

Let's add a test case exercising the path.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>

diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
index 2bfed46e0b19..d66336256580 100644
--- a/tools/testing/selftests/net/af_unix/scm_rights.c
+++ b/tools/testing/selftests/net/af_unix/scm_rights.c
@@ -14,12 +14,12 @@
 
 FIXTURE(scm_rights)
 {
-	int fd[16];
+	int fd[32];
 };
 
 FIXTURE_VARIANT(scm_rights)
 {
-	char name[16];
+	char name[32];
 	int type;
 	int flags;
 	bool test_listener;
@@ -172,6 +172,8 @@ static void __create_sockets(struct __test_metadata *_metadata,
 			     const FIXTURE_VARIANT(scm_rights) *variant,
 			     int n)
 {
+	ASSERT_LE(n * 2, sizeof(self->fd) / sizeof(self->fd[0]));
+
 	if (variant->test_listener)
 		create_listeners(_metadata, self, n);
 	else
@@ -283,4 +285,23 @@ TEST_F(scm_rights, cross_edge)
 	close_sockets(8);
 }
 
+TEST_F(scm_rights, backtrack_from_scc)
+{
+	create_sockets(10);
+
+	send_fd(0, 1);
+	send_fd(0, 4);
+	send_fd(1, 2);
+	send_fd(2, 3);
+	send_fd(3, 1);
+
+	send_fd(5, 6);
+	send_fd(5, 9);
+	send_fd(6, 7);
+	send_fd(7, 8);
+	send_fd(8, 6);
+
+	close_sockets(10);
+}
+
 TEST_HARNESS_MAIN


