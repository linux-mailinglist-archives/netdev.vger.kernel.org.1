Return-Path: <netdev+bounces-205584-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E11AFF536
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 01:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16B3B1C86932
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 23:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBC425523C;
	Wed,  9 Jul 2025 23:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="K8UioUWt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4B0254846
	for <netdev@vger.kernel.org>; Wed,  9 Jul 2025 23:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752102233; cv=none; b=qsn2Wc83Y2XDsJyzyGoom6GIzTUJFIJsuqro6LfV5TtlX9n7t1AGntUkGszdPHwCwy1NWY4T75qI5EMeHfDa+Awi0A5wLSW7ygE5vxZflzw5c8Av4EdkQx6cjr/KD6BidYMfZnkCrlOjOQ9TWOcAamq6jqAuyoXghXiWrgnoHEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752102233; c=relaxed/simple;
	bh=JYYfuH+lTwaumMcaKIm1Mjx5EJTwz+NEYIR8eCVU6l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcrGrOiFznlt06w3pdcd2p2V3niYH5+0F6CkTGjS4JqTWOhKmRrHILICztWcLqgAyVqDh7FMFv1VSaC8k3Mkjc7GQNh0VlAT0uUsJtMsNarK45g9iYxVT84p8/ZWNtkSFGIqtAsd51SY1K5GITH3Wgss5MLLFXknUaTo8qNONIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=K8UioUWt; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2352b04c7c1so631505ad.3
        for <netdev@vger.kernel.org>; Wed, 09 Jul 2025 16:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1752102231; x=1752707031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZHS/Z25KEWrT/i7QYhSLdG7UbyfdoDPHvTom044B/E=;
        b=K8UioUWtZVJ39PKN7fq7ieqBqGM6ZP4gRXOfeVUqWE2+Kj1fzvNms+QrXBZV94zOEB
         CnbpYp5cMObzgyUow4+3RwKde56E8WkNL12BfkpfBftu0Zi4KgIXBWGOJ5mHBCi3rB3v
         mQzim7RYGVp8kQiW36f4TXE12ieaOANQotEUt2e1octDz22z3aVz6vKMFN9TNgOmysut
         kGTzYCy+EhOD4i2WaGcrXtaUqT366HsZoCy1gaXB6iDPEBymHbPCS3G6ApIGZ/r0JOUE
         ZLobzZlWaxaHbHzYrsZ9wDgh9uoLI6wGWs9DPz7q+w2Kr4zviEuJtxZKxUcVKnf7XNBw
         9Ahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752102231; x=1752707031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sZHS/Z25KEWrT/i7QYhSLdG7UbyfdoDPHvTom044B/E=;
        b=P3zs6Fw3VQgPorTVZxWc1IQxPeCfBdy6ux2lSMVR/vVv6kZilmJzYJw3m18/UAzFKy
         bfM6nWS8Roz1otKDZg3sgEFXCIG25uRr2yfXkIK+wRisJg4wRi3rUw2Lfa/UJeBTaljU
         rMh0IDf19eUiblOnRYKSb7N9yhCvDY2/wqsMoQ1V2XshvRK07Ft94ZzEfUsrNmeuPgex
         J7GJvHNnRTUIkVD4ZSiNs1Txl1pEuP/AHz/LqR8qja+ij7obIeFLkBJa8zV0IrxhvFVD
         J3Tyfj37cnLb2L+g/X16dtWgcSfYwKz8b2APJTnXk/fF8Yo6f0DIDVOFCX3aegk0KuT0
         SsEw==
X-Gm-Message-State: AOJu0YwoLZQ8DMldzeCk/U9WnwzOj4ASWDdevq8TmSSmrjFELk4rJZ0Z
	2CbNbEb4irVQmlcPjWjspAdFxn79IISlE2ATKDL9m6NzVVr7YyRuOkMtKm9+Yhj5dL6GOJyGy7b
	PKrtI
X-Gm-Gg: ASbGncuRgbCNRLkeMHqili4R5emP+J/8X4JzrwPAnDUevBch2d4hldE79NQ7F6TqEvV
	qWyLHTXVysez3Ut3w6oQ4jiQNsrShCXYX4nwtGh5757NWt5rMn66W5hxfCVpx/P8ixEpvgkgipQ
	9X+nd67BLCIlC7DrDnsTWKwdpZGi3Bwcn1Yj5TeAoMfa8GLsjC/TekX94TVGt9ZJw20P+14Wi1p
	az5qVN3jGGy/IYh8+c93Zkd4/VUJ9yMwhDBH3yjUW09t+DX1mEs7Rl0e1ho5DxpPMnqIZkX238W
	dRmTxmJub4RGkk09CdY7XWTu8OPyItwmIlxMxFy7zYmDwwm+lPs=
X-Google-Smtp-Source: AGHT+IHOiSjm84qj2GrVnLMMgJpFqnEWUaEvssOaWn174ZtElkUYs791Bz+7vIJ9pifxxhix7y4dPA==
X-Received: by 2002:a17:902:d2ca:b0:234:cb4a:bc1c with SMTP id d9443c01a7336-23ddb1a5cbemr23582025ad.6.1752102231194;
        Wed, 09 Jul 2025 16:03:51 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d121:1d56:91c1:bbff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de42ad212sm2679015ad.80.2025.07.09.16.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 16:03:50 -0700 (PDT)
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
Subject: [PATCH v5 bpf-next 11/12] selftests/bpf: Create iter_tcp_destroy test program
Date: Wed,  9 Jul 2025 16:03:31 -0700
Message-ID: <20250709230333.926222-12-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250709230333.926222-1-jordan@jrife.io>
References: <20250709230333.926222-1-jordan@jrife.io>
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
 .../selftests/bpf/progs/sock_iter_batch.c     | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/sock_iter_batch.c b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
index a36361e4a5de..77966ded5467 100644
--- a/tools/testing/selftests/bpf/progs/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/progs/sock_iter_batch.c
@@ -70,6 +70,27 @@ int iter_tcp_soreuse(struct bpf_iter__tcp *ctx)
 	return 0;
 }
 
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


