Return-Path: <netdev+bounces-194442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE342AC972D
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 23:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEC72A44087
	for <lists+netdev@lfdr.de>; Fri, 30 May 2025 21:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028452853EA;
	Fri, 30 May 2025 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="j0BMhmeA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99947284663
	for <netdev@vger.kernel.org>; Fri, 30 May 2025 21:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748640726; cv=none; b=Xm2FAPjBK9s6mDJynRTmngX4P/7wNvkTkEAiqcHw8y2f7ebvHJWAofdSfuS1fAQKjgVeV4rBeJr/xxxNYm4pPNqckHl+iqQIf9vePEk58+DYBb4vjtR3Xz7xeqSSFywqF7Ni872pXHySXfNLQ6DTbcaTRigbpIKRKnvrhUYg7ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748640726; c=relaxed/simple;
	bh=8znAfQ1IP5+4ZLJ0094gbfhffGuzbrK/6tpSUK5ZSgI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNSFlYMY/F8OGLvqAPM77gy4/lGMLJAjb0DiBkbyhwPcGFBOYSkMo53qJRaiEDyT9J1KOhyziZVtTA/xtl16NV5q+omD2QTK4pV8NEpRDqtiV5KITpNy4NhEvfZK9A2sZVbYXQRyqtiZjthc9ua1OszpeSb3OlFUyU7jqKbQbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=j0BMhmeA; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b2c43cbce41so333886a12.2
        for <netdev@vger.kernel.org>; Fri, 30 May 2025 14:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1748640725; x=1749245525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hEMTgxL0uwtqGX7Eiy7dFlITzxO3HjkYHcIu9b6MYOw=;
        b=j0BMhmeACaovhSHnRmrlhbmZuvGwiLyRb6V/6zG6m6niyCuFt4haeEEZQSZOe+Gb5Q
         w/UCKs7pNPH3eu+r5Tp5IpjGSOwE6fbMDRdYfay+igQuTxL/3L2397TDB+iutg5a6id6
         BWT4VmZp9xjJcaH71HWXnKmCcCZdIpAl4NLiIk/pFMzh3PCk6fUuJ7EIjd2XEmiqrGMn
         5wQci6pW/UwWYJG2bGSOIMT5X1pPSvijIakF8W+Cf3jagm92n8XhPEr3FXWugWdvFJRg
         U3Dk/RdxKPJoDLXaXvFuOqCM7+f316H6ONuFXeJ/cDapvdzlDHhTsFwWHG9rwd26nXjq
         aHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748640725; x=1749245525;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hEMTgxL0uwtqGX7Eiy7dFlITzxO3HjkYHcIu9b6MYOw=;
        b=vIUWyVu7jrVQygGoj8qY93AlqGoM/sugHqdlg7DgMWfZtaXWolPN1vXM3ER57QxxC6
         DqMANHaP7NL6UM90LPSeHjz3lFSJWpzcEUsJrXQJar6i6q4IEHP/hTyWpqEzhg4UpSvB
         ZXVOV4AF+H9YwwzDnfLEGRAOj7rxQFgH4F/P2oKUUAu0R4dDCj1FoqcGIOicKSpthGik
         vdbGC7bAcyVpxJGeSVFHaAQk5kBHyVHyYq6srY7KfSfkbqdbJaWaXr/ohMl4ILRl5Wve
         pTxA/o3cQH/jUg4ZeaUgHOhsG78vGULhDu/xaJI0pYjQ+AfkwgpQjcCFMFYIa8+KEAZh
         bxCw==
X-Gm-Message-State: AOJu0YyDc1JCtHNMrFYvdNmVAJFzOZtswZEZlDR6ualmOeBm0xBA9jSt
	Hq/9vsKfhH3RWlQsPa1Q+NiqMyJ0HZ+cqjOubf+MqzU3yw/DUJagaMzUNPUfyNbaHjJmgO5PHMD
	4sUJmRVg=
X-Gm-Gg: ASbGncs64OGXqQYek1W92skI5FH4uYIAgN53KwdVFqZ0G7DEmWRXe9uYufL2yhJ0MkZ
	hgODIYNECaXGQFFQISfu/IxrB034fxv/CmfWEU20MYXOaVDp4Rbe5hJJlpxImfNCwgymN7eYD7i
	Mi1Qo4fkUjcPzaAiN44oWTWUJQooqG89a036s3+P+axbaYxIBMBCsjN67Nob/NUimrRGHifrTNu
	2vXHLIH3P8L9CFzdbGEsZINiy+VpPBwLaq6LHG075TFbAL8qVSvZa/oZbJ04hvaZwNJRXeUv+1i
	EGJsEUrjyJoAYewDhJrZpHjZygZ8MS9naPJNzmRx
X-Google-Smtp-Source: AGHT+IFRr6kWv73nIIKqhWtxcI6qzNy5I59JUHol5KovT+cyGsJaiowfCcFBvLQHyZpsJF4XF2yzjg==
X-Received: by 2002:a05:6a00:3a21:b0:730:9a85:c931 with SMTP id d2e1a72fcca58-747c0efa956mr2097838b3a.7.1748640724818;
        Fri, 30 May 2025 14:32:04 -0700 (PDT)
Received: from t14.. ([2607:fb91:20c7:44b2:2a24:2057:271e:f269])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed4399sm3496763b3a.77.2025.05.30.14.32.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 14:32:04 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [PATCH v2 bpf-next 11/12] selftests/bpf: Create iter_tcp_destroy test program
Date: Fri, 30 May 2025 14:30:53 -0700
Message-ID: <20250530213059.3156216-12-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530213059.3156216-1-jordan@jrife.io>
References: <20250530213059.3156216-1-jordan@jrife.io>
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


