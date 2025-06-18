Return-Path: <netdev+bounces-199139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D95C3ADF29C
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 18:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 440024A31B0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 16:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154362F2376;
	Wed, 18 Jun 2025 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="BEgpIJi1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954B02F235B
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263959; cv=none; b=HRuSU4SxOYMOx2mEYpKfSwDsUvRxn8vhHisvchhtJlZgHyVMSYovBUyBSeUSwqdJ9qbsYPClxFvGiUQmS9l6gw5rvKY5HjE6Eqm1otUDye0SVvO8DWj0SoYxaVlIacN5z0bVxIIe+l1nEbEFGnXhvZAkN9oWkkKs2KfaFBZx/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263959; c=relaxed/simple;
	bh=foepoQWthtqzAO/amSXmA+Ijs1+fWhMG2CBZ9t6Tz18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrroY33LQAhWTbjvDcx7hjZQhydDoO5U88NWEAMS+7TslaSljQOfWMk74g8+A5XmBIc1PZvwxAPjV0B42IjLs2uCVXIj74bqzCPVyR8/JVnfyldgkyX73NwAxIN4QjZug1MSInqfTDO856+cELFQzPdlNFhPt3oCMmvTEe+7NfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=BEgpIJi1; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-31384c8ba66so1290244a91.1
        for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 09:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1750263956; x=1750868756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=BEgpIJi1pXLsAmSLpbzCU7CrfxsfX7GL7WAD7bw3vC4mbFOy+GT6YSlFq6dt84ptRq
         D7pYpujzGOC5d8LpM8U7zYb8UrTcw1gmtpRgjwXO3a4NrLfaQ/sFhWyotuo+wTsqwGcU
         ZErsCg0aBnWh1BJQ0L98qE9r3vmb/bpqtRuVeL7ogY7jkC5pRBwgNr6v9bXlNetF2z5O
         tekqwiMOeP08WjD/8xQRpDjnzArxroKoH7gDVAr9XfDqOgEgtmZbHhOsT2KN4/BZzmMN
         8SUbPSojoxeMIRZX5QGVR5kftMpmS9ezmUTEQtC2VVNWMa6jE62cbLX/CNrZf3dytXLZ
         l5aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750263956; x=1750868756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=uK8If5qyx4WDQUQ8m+ee0wH90NKlfkZ/P1wkijUZ+fjCQvMkk62d1Thjx9/gWNkxRz
         6XK4vFdNdYZDet60o8cDFQks0fvhhxCSSEHoyCOU++wCeBecPzWZbFo18dtzZd7Hf1ER
         OUmxOtp+NeG/f97uHa88EQJ2VUP/PojOHOFMyBlfFLxNzFKCpmKxg2TkWkR7YshzvkpS
         mqHfSJR+TAeqpNeOSoWzXoBHn1HyZS0lez8IstN0EZEJEmDW3mQd5CTMh076FxK+j/8g
         tx2YyEZZpemas7e8XFLzPb9tueN1UO9NivBAvifoRfm7lZWv8GQlZnhP1zdas/t9dTU2
         yhnA==
X-Gm-Message-State: AOJu0YyPOBVgk3TiGYg8doe2yxmpJZFarWp9QHztBQYYz0tHSwrC/ezH
	V0yfC+/I7jnG6nF8NzwtFrNH69aCpmMYXcDovkZnx+g0WT3dh0HbJ3RC5GmKnUYn4jo7mCnEpbw
	T2+G7j1s=
X-Gm-Gg: ASbGncs8eXfQzv7Sp32Wowba21duDG/y+Lvc/C8Jy5/n+b9/tKYZgM/SyCn7HUJtOvu
	ATnacjxKuUXn4QjH8kylYQ3mhFifsgCBBo7hZoahMuvUrViAG9S66bKKBgSO9nQVIgOROmBPOsj
	JIAe/dfiSdphUMb7ZlY4qmu8gRdtWwIqktY/tDfitLzVMYSwOgvApYzt2ruRBxSEXUyy0397XoB
	ttURP25LgeV1zQf5YxZDPGO3s9ikpd0xjCMgfV/FDFoRXh+dSidJLyjLkKHuAldh4Hq3vvF44Y0
	WXoyNsbD6cDE7McNN3RgXfYSErxsFjPe+QaGZtneGiL0qLCeIg4=
X-Google-Smtp-Source: AGHT+IGbz3h94a2Lwn1H2A4xAcM8J1QY+/hoDYZgs7lDHaNtF0lwDrZFd4cnDMYaRZ8Di00wA+V6pw==
X-Received: by 2002:a17:90b:5825:b0:30a:80bc:ad4 with SMTP id 98e67ed59e1d1-31425261c29mr3883942a91.0.1750263955393;
        Wed, 18 Jun 2025 09:25:55 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:d683:8e90:dec5:4c47])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a2768c6sm137475a91.44.2025.06.18.09.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 09:25:55 -0700 (PDT)
From: Jordan Rife <jordan@jrife.io>
To: netdev@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: [RESEND PATCH v2 bpf-next 06/12] selftests/bpf: Add tests for bucket resume logic in listening sockets
Date: Wed, 18 Jun 2025 09:25:37 -0700
Message-ID: <20250618162545.15633-7-jordan@jrife.io>
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

Replicate the set of test cases used for UDP socket iterators to test
similar scenarios for TCP listening sockets.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/sock_iter_batch.c          | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
index a4517bee34d5..2adacd91fdf8 100644
--- a/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
+++ b/tools/testing/selftests/bpf/prog_tests/sock_iter_batch.c
@@ -358,6 +358,53 @@ static struct test_case resume_tests[] = {
 		.family = AF_INET6,
 		.test = force_realloc,
 	},
+	{
+		.description = "tcp: resume after removing a seen socket (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_seen,
+	},
+	{
+		.description = "tcp: resume after removing one unseen socket (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_unseen,
+	},
+	{
+		.description = "tcp: resume after removing all unseen sockets (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		.family = AF_INET6,
+		.test = remove_all,
+	},
+	{
+		.description = "tcp: resume after adding a few sockets (listening)",
+		.init_socks = nr_soreuse,
+		.max_socks = nr_soreuse,
+		.sock_type = SOCK_STREAM,
+		/* Use AF_INET so that new sockets are added to the head of the
+		 * bucket's list.
+		 */
+		.family = AF_INET,
+		.test = add_some,
+	},
+	{
+		.description = "tcp: force a realloc to occur (listening)",
+		.init_socks = init_batch_size,
+		.max_socks = init_batch_size * 2,
+		.sock_type = SOCK_STREAM,
+		/* Use AF_INET6 so that new sockets are added to the tail of the
+		 * bucket's list, needing to be added to the next batch to force
+		 * a realloc.
+		 */
+		.family = AF_INET6,
+		.test = force_realloc,
+	},
 };
 
 static void do_resume_test(struct test_case *tc)
-- 
2.43.0


