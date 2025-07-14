Return-Path: <netdev+bounces-206814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC548B04731
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 20:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1600A163F2C
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 18:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D85A26FD9B;
	Mon, 14 Jul 2025 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="E3Z18tPR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B567F26F477
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 18:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752516579; cv=none; b=Gy+bH0Q59ihamJjf6e7Fbs8MPNnzvDmQIn5ZWqgHOIsOhO000oyzKdefHJV8UT9G6DKqizujf2frZiT3Rw1dZGlqv04m+Ow42eFo5noytj+BdDpX6+BO/51JTMSYKM2uJA6bGl/LKxST0cPxWeH8hosizlWXTVk6i5mWvzSDBGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752516579; c=relaxed/simple;
	bh=KpaAZSzE0Xh8q3DSD6/TEtreQDWx77BOjF6mVkC0wDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfmiwWzc+w4wiWawmz/SWFzIc/uNJWyNwx2XEp1bOYWVdBrj5ZsZMqeLBOsZtf2kZxiHee2fNEVNH26AE99U6SRULc0sjbR9/1/6fqtLgfxcbcEjoPW7AI0mR4y5h0faDC97H4n4Hz7xw5+Ybwi7c6kmn7YlqlUK6OdzynHjVhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=E3Z18tPR; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-234d3103237so7592005ad.0
        for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752516577; x=1753121377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZKdoOQwlfR0KROJ2v6wBzEhaRvcP0creswUNdSHqGE=;
        b=E3Z18tPRczpQ2q8nZZircYlay9mZECUkpZ1KY85+iWGX0LtPxxp2lB+rcXU7BU40C6
         Ujyfl1Bg0lkMbWwGakPmaAbK6hFmMtdyaSSIcKYNEoLJ1va48iVRstgtChOupR06y1st
         gJp+Vh+ZzcnOtEAJdozBSa4EET3DGByUjXzHiB4VFr1aL5J2WbOzzmwmyC2gbHXJ2Al9
         C5r10K5JJoj7/s5ITtx9dTl8dZ62+QJkBHv5yDZHRav/wRh/2gXdmcLSJqSKJCwYcEXf
         dUr189jzHRWbGOXXD/w8vSoHeREoUioB7VostlTAY49zMTK/eCMqTsMbcxqHlca4TTHP
         wOlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752516577; x=1753121377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NZKdoOQwlfR0KROJ2v6wBzEhaRvcP0creswUNdSHqGE=;
        b=sbFGKWQp/AcQ+KsNhdVljylyeXMMLxJpWGxm/CARUXRKPipdiIfG3yHgDqvARFe42y
         ozD0v0ubjdhdwqhCQonEqnKw8GN/Hl7YbemMLBW1hbylNJZr5HmpslZAhmKiITLbsuRa
         rF9JOMzRodfpTLJhRL+RpRg2P3nA7/g3Q2kdwitALwDQjZirO5QIgjnFLJATWJGw0065
         oHUM9+mvdHutBVLPFE5PnD/vk4dB+Cn6nySaSarwZJkXcl8AOlaH0PA8J9fWXy4KENNU
         Ft+AAN0XLbkbmq34c2KmVuHtigI5P1Y/UGqpQ1cdRC7uF81+qi3bMSMbq7gYU8hcNer4
         N/Ig==
X-Gm-Message-State: AOJu0YwXEWfKHjpkinOUJXVXA3Nkh86NebjnpRB7++HDk9htv8mBQHaA
	Zk9CVW5/mQvg0goasaQK7h6MgvRbY1SuYBGWLALhUy1FJenrBNE5dBbjyC+8fUn8UauJuzqWA6c
	Q3pQu
X-Gm-Gg: ASbGncvScG9U6oSnMNd83M09XnprBbCTUmwL5DLw8G0At5Ie2lPud+6rl3nmeLLM9Gi
	lYz+2hPp4FtFoWG2ThSNO6rd4iFhZ9PWk9qCEenu1VX4+V7ylNmZZFXSDK2lwCqcwGDgD4+sti1
	8YvZCM6++xWQCmlzS2UARt0hJr6C/PHx+YeeYfIIxd10BByXxIo6lGp2f7fWNzPK6v+ltuxkrao
	b7Ckc1GvH10pC4kQti74pVpkYBto5xStTQy1uh0HNj/go81ne/WKDeMD+W3for4AXivfoSC1DFo
	Nrvsa3lbfnyCLMPBWHvxJdgp/c6Qxr2PGsWQp2Z8NBQEO89QDA8fcPdoD6NmVhg0B2Ghgd/2W48
	CQudFsAwyrA==
X-Google-Smtp-Source: AGHT+IGWw6dQkTQoHKTaZbxbWPI7jaTzb5aPPqpd4dt3vWuEPH3wBeaICXZXjyq6VIALU3LkEDkixA==
X-Received: by 2002:a17:903:1a70:b0:234:d7b2:2abe with SMTP id d9443c01a7336-23defb29ffdmr72647375ad.7.1752516576626;
        Mon, 14 Jul 2025 11:09:36 -0700 (PDT)
Received: from t14.. ([2a00:79e1:abc:133:84d3:3b84:b221:e691])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42aeadcsm98126405ad.78.2025.07.14.11.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 11:09:36 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH v6 bpf-next 08/12] selftests/bpf: Allow for iteration over multiple states
Date: Mon, 14 Jul 2025 11:09:12 -0700
Message-ID: <20250714180919.127192-9-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250714180919.127192-1-jordan@jrife.io>
References: <20250714180919.127192-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add parentheses around loopback address check to fix up logic and make
the socket state filter configurable for the TCP socket iterators.
Iterators can skip the socket state check by setting ss to 0.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../selftests/bpf/prog_tests/sock_iter_batch.c        |  3 +++
 tools/testing/selftests/bpf/progs/sock_iter_batch.c   | 11 ++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index 0d0f1b4debff..4e15a0c2f237 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -433,6 +433,7 @@ static void do_resume_test(struct test_case *tc)
 	skel->rodata->ports[0] = 0;
 	skel->rodata->ports[1] = 0;
 	skel->rodata->sf = tc->family;
+	skel->rodata->ss = 0;
 
 	err = sock_iter_batch__load(skel);
 	if (!ASSERT_OK(err, "sock_iter_batch__load"))
@@ -498,6 +499,8 @@ static void do_test(int sock_type, bool onebyone)
 		skel->rodata->ports[i] = ntohs(local_port);
 	}
 	skel->rodata->sf = AF_INET6;
+	if (sock_type == SOCK_STREAM)
+		skel->rodata->ss = TCP_LISTEN;
 
 	err = sock_iter_batch__load(skel);
 	if (!ASSERT_OK(err, "sock_iter_batch__load"))
diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
index 40dce6a38c30..a36361e4a5de 100644
--- a/tools/testing/selftests/bpf/progs/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
@@ -23,6 +23,7 @@ static bool ipv4_addr_loopback(__be32 a)
 }
 
 volatile const unsigned int sf;
+volatile const unsigned int ss;
 volatile const __u16 ports[2];
 unsigned int bucket[2];
 
@@ -42,10 +43,10 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
 	sock_cookie = bpf_get_socket_cookie(sk);
 	sk = bpf_core_cast(sk, struct sock);
 	if (sk->sk_family != sf ||
-	    sk->sk_state != TCP_LISTEN ||
-	    sk->sk_family == AF_INET6 ?
+	    (ss && sk->sk_state != ss) ||
+	    (sk->sk_family == AF_INET6 ?
 	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr) :
-	    !ipv4_addr_loopback(sk->sk_rcv_saddr))
+	    !ipv4_addr_loopback(sk->sk_rcv_saddr)))
 		return 0;
 
 	if (sk->sk_num == ports[0])
@@ -85,9 +86,9 @@ int iter_udp_soreuse(struct bpf_iter__udp *ctx)
 	sock_cookie = bpf_get_socket_cookie(sk);
 	sk = bpf_core_cast(sk, struct sock);
 	if (sk->sk_family != sf ||
-	    sk->sk_family == AF_INET6 ?
+	    (sk->sk_family == AF_INET6 ?
 	    !ipv6_addr_loopback(&sk->sk_v6_rcv_saddr) :
-	    !ipv4_addr_loopback(sk->sk_rcv_saddr))
+	    !ipv4_addr_loopback(sk->sk_rcv_saddr)))
 		return 0;
 
 	if (sk->sk_num == ports[0])
-- 
2.43.0


