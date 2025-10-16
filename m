Return-Path: <netdev+bounces-230184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD09BE50DF
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2EC31A680A0
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A95231826;
	Thu, 16 Oct 2025 18:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="luiJWRno"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C239223DD1
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 18:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760639151; cv=none; b=DqW3TPaC/j1HaYhFR6hsjE/TZdAr7PJnvDzbKp9XlzIzCMmc2QOaZUlu7rHyNt5u/PaYsnaIdFT3cj2qoeZhfYk4xH/UV+arpa0XmMgI32vWQ5MXym+ru8ZGZ72GELwRNanUf9T8INV8vY72sSjWSzTdjojhCNtvPPjMNqufo9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760639151; c=relaxed/simple;
	bh=V4rgg45EQlkMjgrqSVdh1uwAFbU6ZcVY09d4AEkeWxI=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=TIRijJS6i+cPerkR/CsKOtiyY483UL+JH8Eh6Xvq9vO3UjPQkstkzYnw7ydVkzBT2KBiwuHWrU8PTG/BtA4v5Y2HR81dJ/nqQd29K+OL97t+ScaguGYV1IlI/OrQ7zJwPhB4wGlb3iPCV9xgaJIIsIOzwI016Y2Ql2GhhY7I5eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=luiJWRno; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--cmllamas.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-3c96de7fe34so343255fac.0
        for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 11:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760639148; x=1761243948; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aTNTzsh8UwWq3gKAxJaQnoz8QnNDSoRjLqAKLOKrSJ4=;
        b=luiJWRnojfdkXN9/tOmB/7ICmBEvj80lfsx5SgR4yUOi/MUC37R0wx/oLmd4upAnYu
         ap8ouk1tsR6DnIBnqGGV2S5/2LQH3Dc/4NyPIjdlA5YL6Fr6/u2lfJiJJjkvIM1gvJKs
         yt/DMbY31QiMhwoc0nDY1J7pqS3jaKt3F0BQ6dsox3R8xMkiWPu1cUZ25Jn5jPkkbLkp
         oxGpIMbRog0A/VntLugJKHtfeuGD98oVdoHp8CVrF4iDC3dE82UNy/t+YYJBonMIKd6e
         bX7T17oI7T8q9ARTCLQ8bgDF1cROyiwcbedtpI2dNjj4y2zaaPlMbp4qajB6tVFMyWBV
         wacg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760639148; x=1761243948;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aTNTzsh8UwWq3gKAxJaQnoz8QnNDSoRjLqAKLOKrSJ4=;
        b=pAlSBGzRyL5LiZ+qRS6SOG6SqD4PzTHjmQvXd+/OEuqfsTo3VTYyl1cBVx7g1y10xp
         zglW7LyGfQ5lSAWwTiFmYbkatAFkW136Hv5QJtJpYRuv4frxDG1gLxJ5lo3Sc+XSUY2l
         DVSP+b01UNzaC2pICHvr4s1D9Xdnhn90eH1BM6NRuilhTkXRBRtxXjxEfiGvTKaxBvWl
         lF9PTxUGOWv6O1c2c9GMXTDbtO5n9KGb9OPOKQjVGzYT84Qdrztvzv/KZ4mcxzC4y1R7
         M0fxVFNF0LW14sZIAX1sSh/1j6OQCmmXwfeF4GVU/mF8YVwCLySL00pf2vAdtr30eZtF
         2cIA==
X-Forwarded-Encrypted: i=1; AJvYcCUkBRnA2ScjBOxD402UaPHuvoEJh/C6zuvCniyOeGO1K6u8kx9EnG42JLm1IcClij1h0aa18tI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKuVDHawaO3jvPZfIcl1TIA7+IeOf2CSsFE+yK2M//4JtY7u4X
	kxrL76QNAl7RnWn+aZyFNNcJZcp4ZUruT7VbMI0A6YTFLUKuDfjG8J7pt+iAS1hcYDtJr9sP+NJ
	xbrR7OmqiG4vydA==
X-Google-Smtp-Source: AGHT+IHORlKSlHZvzvt6CVNdFwUEZuO8mJlT1v1ETTjTT7HeBTJCEZWGKHssgZ7VVxf9i8WZAnDYnurNq1qOOg==
X-Received: from oane15.prod.google.com ([2002:a05:6870:506f:b0:3c9:810c:2ba])
 (user=cmllamas job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:64a5:b0:375:db59:20e4 with SMTP id 586e51a60fabf-3c98cf4364cmr380239fac.13.1760639147713;
 Thu, 16 Oct 2025 11:25:47 -0700 (PDT)
Date: Thu, 16 Oct 2025 18:25:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.869.ge66316f041-goog
Message-ID: <20251016182538.3790567-1-cmllamas@google.com>
Subject: [PATCH net-next] selftests/net: io_uring: fix unknown errnum values
From: Carlos Llamas <cmllamas@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Pavel Begunkov <asml.silence@gmail.com>, Carlos Llamas <cmllamas@google.com>, 
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The io_uring functions return negative error values, but error() expects
these to be positive to properly match them to an errno string. Fix this
to make sure the correct error descriptions are displayed upon failure.

Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 .../selftests/net/io_uring_zerocopy_tx.c      | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/net/io_uring_zerocopy_tx.c b/tools/testing/selftests/net/io_uring_zerocopy_tx.c
index 76e604e4810e..7bfeeb133705 100644
--- a/tools/testing/selftests/net/io_uring_zerocopy_tx.c
+++ b/tools/testing/selftests/net/io_uring_zerocopy_tx.c
@@ -106,14 +106,14 @@ static void do_tx(int domain, int type, int protocol)
 
 	ret = io_uring_queue_init(512, &ring, 0);
 	if (ret)
-		error(1, ret, "io_uring: queue init");
+		error(1, -ret, "io_uring: queue init");
 
 	iov.iov_base = payload;
 	iov.iov_len = cfg_payload_len;
 
 	ret = io_uring_register_buffers(&ring, &iov, 1);
 	if (ret)
-		error(1, ret, "io_uring: buffer registration");
+		error(1, -ret, "io_uring: buffer registration");
 
 	tstop = gettimeofday_ms() + cfg_runtime_ms;
 	do {
@@ -149,24 +149,24 @@ static void do_tx(int domain, int type, int protocol)
 
 		ret = io_uring_submit(&ring);
 		if (ret != cfg_nr_reqs)
-			error(1, ret, "submit");
+			error(1, -ret, "submit");
 
 		if (cfg_cork)
 			do_setsockopt(fd, IPPROTO_UDP, UDP_CORK, 0);
 		for (i = 0; i < cfg_nr_reqs; i++) {
 			ret = io_uring_wait_cqe(&ring, &cqe);
 			if (ret)
-				error(1, ret, "wait cqe");
+				error(1, -ret, "wait cqe");
 
 			if (cqe->user_data != NONZC_TAG &&
 			    cqe->user_data != ZC_TAG)
-				error(1, -EINVAL, "invalid cqe->user_data");
+				error(1, EINVAL, "invalid cqe->user_data");
 
 			if (cqe->flags & IORING_CQE_F_NOTIF) {
 				if (cqe->flags & IORING_CQE_F_MORE)
-					error(1, -EINVAL, "invalid notif flags");
+					error(1, EINVAL, "invalid notif flags");
 				if (compl_cqes <= 0)
-					error(1, -EINVAL, "notification mismatch");
+					error(1, EINVAL, "notification mismatch");
 				compl_cqes--;
 				i--;
 				io_uring_cqe_seen(&ring);
@@ -174,14 +174,14 @@ static void do_tx(int domain, int type, int protocol)
 			}
 			if (cqe->flags & IORING_CQE_F_MORE) {
 				if (cqe->user_data != ZC_TAG)
-					error(1, cqe->res, "unexpected F_MORE");
+					error(1, -cqe->res, "unexpected F_MORE");
 				compl_cqes++;
 			}
 			if (cqe->res >= 0) {
 				packets++;
 				bytes += cqe->res;
 			} else if (cqe->res != -EAGAIN) {
-				error(1, cqe->res, "send failed");
+				error(1, -cqe->res, "send failed");
 			}
 			io_uring_cqe_seen(&ring);
 		}
@@ -190,11 +190,11 @@ static void do_tx(int domain, int type, int protocol)
 	while (compl_cqes) {
 		ret = io_uring_wait_cqe(&ring, &cqe);
 		if (ret)
-			error(1, ret, "wait cqe");
+			error(1, -ret, "wait cqe");
 		if (cqe->flags & IORING_CQE_F_MORE)
-			error(1, -EINVAL, "invalid notif flags");
+			error(1, EINVAL, "invalid notif flags");
 		if (!(cqe->flags & IORING_CQE_F_NOTIF))
-			error(1, -EINVAL, "missing notif flag");
+			error(1, EINVAL, "missing notif flag");
 
 		io_uring_cqe_seen(&ring);
 		compl_cqes--;
-- 
2.51.0.869.ge66316f041-goog


