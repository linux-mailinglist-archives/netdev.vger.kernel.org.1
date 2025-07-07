Return-Path: <netdev+bounces-204629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 240DFAFB800
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 17:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D13213B4B7D
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC01218AA3;
	Mon,  7 Jul 2025 15:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="giFO+u88"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0124F2185AC
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 15:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751903478; cv=none; b=Oph9dODZ4ov2JIh2hxMMwJPR3GtXopfpg56HCwaGqhe4TVlDUqWoHwOFLXWv+HNpo8oLIIaMa8TM2fmPovLrzGZoLX69fTm8Eb/T8JP9JGqKJvk0rzvxuwNxkf8ym34pinuu9f2JA6I/80S7DdKNFN1fKRGYwVJOBanqetyu+MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751903478; c=relaxed/simple;
	bh=foepoQWthtqzAO/amSXmA+Ijs1+fWhMG2CBZ9t6Tz18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClgtwqRUWecOjIi3C2aJdPpNrhTzEQY6XstXKhok+EytAQwK6RaRWHEoW0cUZKHwn35pp7zngxtOPtLGPcXm0TDYcF2bTwrjbdN5mDspk2MlCJUfXV8pObr+xkl6gXUpSfWvLDmG6GJzf2vX4pjKJR4paGtDD7cE9kbnMXwrESA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=giFO+u88; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-237f5c7f4d7so4625075ad.2
        for <netdev@vger.kernel.org>; Mon, 07 Jul 2025 08:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1751903475; x=1752508275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=giFO+u88Y7Hf7GXjkK0JY3IVOVYnSDUcL9U3AX8srcEiL/fvJ4YOM+z37eZ3/IxWSd
         y2ofPe0j+QfzGjr+fgj4zKAhpjftbhtuDnRLdEvdSjc46ERApY0eusDaGsn1CTxLk6td
         ElxqDWgAy6lZR04W87+m3ieqvs+X0vLCphmtDJAVcUoGpfZlIGFa4tD2diZNkDPPpfT+
         KNguFHb3jqAUCeEcwVhhC6Mer2yZ4CfmamzU1GZ7AUebVjrGYKPcfNc8lzn34RomROTv
         WhSpg6CFP3DVjFJC7iack+GBAoc1I9ZWzsYVrL1Ry503dYb+k/9TAk3FvLq2wfo+y6kK
         JBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751903475; x=1752508275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vKLGPM6fsUvefIfdoj5d/pH5CeVPkyRVwIbtrb7Q6Tw=;
        b=cxLDZhtcSaW4e6vZPDs4SvjyVC1/LLDfn2JvK+fEbpUrjw5LsyTcNiB4sVYCmKMRpl
         ddkSogW/fMEZrF+xTuLoSrKAR3/4CkI3fSug5p1G69yugWxjXqhWcU5dfAALP4dxQv3/
         RYYiO8PWEtHDsyzifdDvLrnNACnUFSsueSqCqixnUhwjflHFoBUomPuBEOatZR5AWUvo
         0NIlO/71U1gFf4Q6Cg6MWEcbigbsW9t/tgfXflRTVBiH6tYf5d8DCBdN17oGy9jvpeSA
         tIdrb1P/pnRTrgJX69rAavVHBSTLHQCh2+5HSAo8YLsT10kNxWgUCfSdS/Vwc9mLpr7p
         ZEQA==
X-Gm-Message-State: AOJu0Yz7mZFwP9ocBZF/mAk0LBYptBreyqF46N2x+K0y8TXfnVeqFbSy
	JxvbPQl8RLjTiF0GqKcf9+nxYzciLHnoJBkw+06BOpqsTM2/uCNo3JncyloboHhMIB4utYaXcla
	NG+nz
X-Gm-Gg: ASbGncv6VnwPdroMEKWTqmRGWC1zzqO/YURjITufbnYNBs8yRFtHAbaJ/VnBn6hyAAa
	XNLaS74MX0GJntr8CLtl9qlMp12nu5jX290W6OZSIpHBV6c81/vx+vagVRQCNFx6b2q1y63h9k7
	XayMImOJJRFmfCesZqxeCBbOm9Ekp111vXXWq8EUnoWaT/+17W6sseu+CSdm3NBLxtJ3hfJCrv6
	eScIcv7Dbt0hHr8aT7lDyNRoYIsTT/xEAvA2XfQI3n6jRoezzf1XJ0RWWvacty0cMftEZWy+XEZ
	2OjWUQD3ZMK1CmufCr3KiIsrfK7a3EuTQAks1Cg8+J6kXyvL5rQ=
X-Google-Smtp-Source: AGHT+IGhaVoioRrlut1mESqPdvOatp22KS6ApbAHvedQjoF0tvtLxJzI8k+NZUmMGjcsyzU+ev1FaQ==
X-Received: by 2002:a17:903:1c4:b0:234:a734:4abe with SMTP id d9443c01a7336-23c8722f4fbmr73864625ad.1.1751903475242;
        Mon, 07 Jul 2025 08:51:15 -0700 (PDT)
Received: from t14.. ([2001:5a8:4528:b100:e505:eb21:1277:21f5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eb3bsm95772065ad.115.2025.07.07.08.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 08:51:14 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 06/12] selftests/bpf: Add tests for bucket resume logic in listening sockets
Date: Mon,  7 Jul 2025 08:50:54 -0700
Message-ID: <20250707155102.672692-7-jordan@jrife.io>
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


