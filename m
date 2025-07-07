Return-Path: <netdev+bounces-204634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7966AFB809
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:54:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 866DF423875
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADAAF21ADCB;
	Mon,  7 Jul 2025 15:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="HX6GOhyH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B62721A440
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 15:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903484; cv=none; b=W9l7yxWvrCar5ZsHh29GMP3zl/DFgBazbrwLZ7oCQEy/gmEWJuFXLZwqkXh5OWsUhTIjU46KcVo6x/lYDAAqmjwcG9yt/82h4efgQnZaqrEYXzkErHJWfXzxdJOwtQKixf5rRbQgoImVEAJK8Pk49AWIqnOnxhmpTettQzizeag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903484; c=relaxed/simple;
	bh=8znAfQ1IP5+4ZLJ0094gbfhffGuzbrK/6tpSUK5ZSgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eu2/Ypro1wDTyh4qj/JSsj7/BVYGAJBixd+U1IUMCHnXOlU98zDjV8NSvsrQvZZro0YXvNojlsN4M+V9nuEcbEUrAsDBQgqqZoZYdO4Yp064cju6LCIle8z3hxAmipu8SLK8d0XSnV98l/qU5/mEGEB2A4VCCz39zSOTWOOjOfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=HX6GOhyH; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-234ae2bf851so3845145ad.1
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 08:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903482; x=1752508282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEMTgxL0uwtqGX7Eiy7dFlITzxO3HjkYHcIu9b6MYOw=;
        b=HX6GOhyH64Jnr0zAiPSqjeBJCh1YTgc9fX5Kl5IbKBY//AKzLJwsYOkFRIeUgvoxDx
         AfXRtHwQXHsImXmdztWBDRnC7qbR9pYJOgjoh4cEfb0StM8wQJJgNXowNu81lSQGRC/1
         jvv+d8uzsxdhYtfwp3ZDWDZhhUJFX+lYaHy3TglTUG+89SZnax76IbD99xHkksbNnXSF
         pynR8cTgHcgwqWNRVCD+VmKkQE2BQu7K7g3ZeRLrwaOwFniWFpRg5UkKUtYryOkmIJd+
         ypcLT2M2omCYCFXD9v+UFyqZ/zergGHl25YJJOaO6eRE8cW+XAcEICLJGmLnwoTPK+/h
         fzzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903482; x=1752508282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEMTgxL0uwtqGX7Eiy7dFlITzxO3HjkYHcIu9b6MYOw=;
        b=UJfvCQAdc8pMcO3nuxlG4XXuaMG5ZPj3XcusNCaK/PGW30O03CoCxAm7/DX+h8Ft4S
         1lXC4wDA46kLFkbQCLl6n9pOInYw0RGBn4M8kYNMatqdylBScf4AbMNNpCoLdn2vxxVt
         evO0X0X7nxzgDRykuboHL5EBMl17+sbMHRpztqRis/oPFnud8OvAhTBJ6o8KF3a/XIak
         OE6iBGQkrg1vlIljr5lLf42nZAPIlHb0dCiqjo8hXIWio6aHOXGvOKGQ0LOuywzEAYmH
         UWiZSBJYDD++joATCTIXL4+r86B3p4jvnmMgFPXTHCnH9PxSZ75SEo+hsraLVdvg+mNY
         5Czg==
X-Gm-Message-State: AOJu0YzpbUQ915toJjf687R61AnmmmThkmNrUR5Q5g7NNzgazqRQpf7G
	x1flcGokwvs9K1hiDul+iFDbqzrS8U8JVVk8jXyL34PeNHzIU7tuhuFhclL4txKaFb41LMt0r3J
	CdyCg
X-Gm-Gg: ASbGncvpHE0AnNrCPdugTsXBp4sJK4/1pu25ZSJDhue8KmeUiwmvDqa+PLu+eLD6XTr
	BveRrepuZezdEfpWznvyUqHV2JRUZZhWSPu3oR7jRHAfKVD8LiIM4jTRxKWViizxnsX1syckV5u
	jmZuPdZSKl/v9WOgQP9mOPXG+yNetLSvkE187YscD94x/moStW0HnC6+gDfK4nu7wN8a9O1n2Y3
	G9zrge9vFGnonUT50PEWz3lanr164OxUG/b2ssS61vcaHK1LWHV9+1o0yENA64aWpk3/Yt8uGBh
	Z5hV203Tl5pqlXCKGAO/OThn1q2VtBF4edGQ2hss9TpdIga9civ0kWrUgAfy1A==
X-Google-Smtp-Source: AGHT+IFVd7uda0SyHIewGgCtzJeVxXNo5Va6KpD3LRiYMxvxDTfWFeYtuWOownYStZPnBKm+7/Dh9g==
X-Received: by 2002:a17:903:1a6f:b0:234:8a16:d80c with SMTP id d9443c01a7336-23c8743bf06mr73245995ad.14.1751903481710;
        Mon, 07 Jul 2025 08:51:21 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:21 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 11/12] selftests/bpf: Create iter_tcp_destroy test program
Date: Mon,  7 Jul 2025 08:50:59 -0700
Message-ID: <20250707155102.672692-12-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250707155102.672692-1-jordan@jrife.io>
References: <20250707155102.672692-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prepare for bucket resume tests for established TCP sockets by creating
a program to immediately destroy and remove sockets from the TCP ehash
table, since close() is not deterministic.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../selftests/bpf/progs/sock_iter_batch.c     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
index a36361e4a5de..14513aa77800 100644
--- a/tools/testing/selftests/bpf/progs/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
@@ -70,6 +70,28 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
 	return 0;
 }
 
+int bpf_sock_destroy(struct sock_common *sk) __ksym;
+volatile const __u64 destroy_cookie;
+
+SEC("iter/tcp")
+int iter_tcp_destroy(struct bpf_iter__tcp *ctx)
+{
+	struct sock_common *sk_common = (struct sock_common *)ctx->sk_common;
+	__u64 sock_cookie;
+
+	if (!sk_common)
+		return 0;
+
+	sock_cookie = bpf_get_socket_cookie(sk_common);
+	if (sock_cookie != destroy_cookie)
+		return 0;
+
+	bpf_sock_destroy(sk_common);
+	bpf_seq_write(ctx->meta->seq, &sock_cookie, sizeof(sock_cookie));
+
+	return 0;
+}
+
 #define udp_sk(ptr) container_of(ptr, struct udp_sock, inet.sk)
 
 SEC("iter/udp")
-- 
2.43.0


