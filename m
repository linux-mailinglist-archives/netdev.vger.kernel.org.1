Return-Path: <netdev+bounces-199144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3960ADF2A9
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 18:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 125DB3B4BA8
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915912F2C6B;
	Wed, 18 Jun 2025 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="2vmF2nTv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211EB2F273A
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263963; cv=none; b=OjNrXNDeiFm1MATqP49rFQ6u16+b8dj1XnEswJ1QZLaTzt02aGIbKMcQ/i/dklEiEF61s8vi1MeJoX9iegot394vSljRMqY2WK6s913qRDp5ptCp6YAEMBbusszsVHIBAJY2jlJaB30HlHo1LAYoKejYnFiERtCx04+8zZKd0Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263963; c=relaxed/simple;
	bh=8znAfQ1IP5+4ZLJ0094gbfhffGuzbrK/6tpSUK5ZSgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSFqRwQzhHr3JrW55qcAWtNvWGSLmrSxnyvLekpvkjW77DTPVYkfvWjU4KvRhEyzPpvxtiFF7H11zqrmG77JB2f3zOB/pdEtRoEp4fbZ1dUKwPTTHIoGTq/rZdG0K0Ry/MGyLmpvJLKfrW35gdQYDFL7LUnzzAz5DbN2eF9IBjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=2vmF2nTv; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-31306794b30so1214099a91.2
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263961; x=1750868761; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEMTgxL0uwtqGX7Eiy7dFlITzxO3HjkYHcIu9b6MYOw=;
        b=2vmF2nTvTcYmStbQRWU2QsBvesvT5puX04P6lP3k5vTgFxFTT7epEUHemLTVw+j/gn
         XwTrUe0qKj3WlXvDX6+uPNeQVfaVtKOQk46o7ep+finQmr1relfhFyeuE+DtmiPE16QK
         9ODUqGTtFAIk6mai/qtBdzcbJkeect0cFjgv9jUaKoL3aUg0eZHUGsJYUte3K7/3J30B
         YuOo8te4fDw8jVQBCqqXDNxJ+0t1ozatgZCmR8ycO70lvIC9wtxKahqgxt8aEuHGFKHN
         cqarHxr8xo0a4C4n6URMJt27nNr3AFendKp3cfVBH9v/0LJS9tkqXYTZLAUU5/EhDyUR
         X1qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263961; x=1750868761;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEMTgxL0uwtqGX7Eiy7dFlITzxO3HjkYHcIu9b6MYOw=;
        b=Z/tLCov31Qb6V7kwY2k6yABKGoz12u2uaQCyrqUDcNCaJzp8U2ywck9URP2PxxObEz
         CozmABJe/Y7pWF11uclDZziyGhky5rkKm3b1GvZNI3Rsf6ahqsLEGWagrrn91fwNjoRD
         GuK39WK+t1lpidOqrWU4AtS2zoR2P5uZmCu2lewDML6m90qDOAUccNbKTqIrWWxTwVI7
         qHVQnSmXvF5csFaKFYsPN/+/64873DIlnZLubJCEvD74Rx3hOJWm2VLWgU0PwC2Fs3NP
         +g3pJcOzYBHMK5HHtWTQrDhKhfHgZThGIRv4+h1o9IO7+WgmZwBMSYUL2ILMQ8m2OV4q
         qBbw==
X-Gm-Message-State: AOJu0YwOuDILsuCSm+68awBhibEBFqN68Okf8um6Jy8HyJmAHxYmtGT1
	Syt2zJv3RSaN8YdxAMij5hzw8o9mTHwbjTGRcNWVUtohjgu++ZDmiBOolO0y3ZZUEl52MtkrV0n
	3L+ya3zw=
X-Gm-Gg: ASbGncvMRqAM1Mp9+hF4h7xnxr1IoFB8Wigcu95P/VnzvlceNgeTvHMYrwgwkyXYnpQ
	irtMibO+Gq25gDIq2okcQsFNBUU0NnxSHihkICredXihV9VPLzon3gDjsdLk7O02hX8zulvUjAQ
	2Uc+U/1Naf8NyQv4PaDdLck85CMPIpqa3DSWWRR1Vkk+vg9AQ9wSLEOnEJuLgN3hsyMbUThonbC
	v+eQpx8d2C1i7HOppVz/msnnPbCZBI6v+Z75xxrVnHVPatZ4fhFg3tDbm1Fm2bUo+DuW+ffcb7N
	lbDOTL4zxC/Vnq2kiaoq1O/SovQ4bN5I4Sa1dJvUI4b8dMIFZA4=
X-Google-Smtp-Source: AGHT+IH/G5OFC/5QjcIcqVdSZjYPjbO5cB8wewYUnrAuiMBGclHnQwgLdX4VEHcpEv/vewBBbJddsg==
X-Received: by 2002:a17:90b:4d12:b0:310:8d79:dfe4 with SMTP id 98e67ed59e1d1-31425ae54f4mr4381052a91.4.1750263961332;
        Wed, 18 Jun 2025 09:26:01 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:26:00 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 11/12] selftests/bpf: Create iter_tcp_destroy test program
Date: Wed, 18 Jun 2025 09:25:42 -0700
Message-ID: <20250618162545.15633-12-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250618162545.15633-1-jordan@jrife.io>
References: <20250618162545.15633-1-jordan@jrife.io>
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


