Return-Path: <netdev+bounces-241286-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 209B0C8252C
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 20:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37C70349696
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 19:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F4A3271F4;
	Mon, 24 Nov 2025 19:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pevEc7Nu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F14F325483
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 19:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764013471; cv=none; b=ZKiUSjn2UCkk2GkPhcw973nitv311x+woXwfYCLJqigSh26GN6KtoI1n9AtLaxJ1dMwr8vRaS897tw61LELkUdbxcsNXI1pA9F4nPMHTGQoNCTedbxPUlLd/JU5QsGkm6UzAemLpiTzDbVDGsM2Eaz49xYjykLVluaGkefAkVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764013471; c=relaxed/simple;
	bh=LBbpFGRx25U3EjboDytduBUqzcGkLL9Zfgq4YEVNSDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=RN54k+RSbVV9gjxft8QBiFEm9k99xTLEwTC21dR+xf79zGz2JSBB8X/cyzO6s3BYkNU9ogUO1gIFi7l8237ZNXi0pD7vmT4wg/UjPcT2W/IAx8h3Fm+ClnKoaoEvMmrD3dmeMeVeVSIfRfhYk+HxzRV/DQit57uCCLNu8tKLnuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pevEc7Nu; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3436d81a532so9245392a91.3
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 11:44:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764013469; x=1764618269; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UM/52Ll1lDwXA45TXkg/Z20IxHr9hxPwTnKe9jkP/Qg=;
        b=pevEc7NuxDtnF+ski0Kws3OIhWgJNgBnOMpGfMUyqx36MiyLhdaL9ZVCAKOgTDRC+o
         MU5JzxHwL2tD+PG9EYB5ydbYCXdhGj1l1N/LVW+635VWHnmivhn2al9M4GVFOZ7QxJ9U
         LJiYtovP/Iek0DPM08iWmIKK4Y2co0BA0VKj8KGeMKXpa+WBw0MhyGb3UPlr3oKhGy6s
         LkQDNXGK5WKMJW+it1GQKUgy3Yw6Kj+ykdUkz/b70xsBv9Hy+Er/yDhtsU3C4nGHmMod
         gOSV5QEaaU9hXi6upHhyuDYo/1Qsw0LbaypdMr99U2xiR3WP+KwPiBfC/7iwjxW7Gj7U
         IPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764013469; x=1764618269;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UM/52Ll1lDwXA45TXkg/Z20IxHr9hxPwTnKe9jkP/Qg=;
        b=lhKq3B1Uz3t9daAR0w3v+aDmRLJ0ZlZ2yv2rC4ahZfbuM6bui9VlLwEokM/XmhKH0R
         fpuQ4PcXQ6uy7oQT1gTg3NIDS11lfNOCJ7OZujrygwz3zNr5vzsG8o+7aAq2k8BTqcjv
         HitMbvG7SWUomTtVIrvyKhysJLSfAL1yOPlWswrLGkjAscseCilJTNTLb5PbmnQInrwq
         7qtTOSxuT8QlgkwAZeKi38k5tmHIshxxYxZfhXUeMEejz1GexgJyLTREE4nQPDQ7PU5K
         /fr4Dq3qRTHbCKauw1/sSAuCa5bg0USkWBGFB+9TmWWvebl71zkYl2r+9JYcgQ/b2zhj
         lXCw==
X-Forwarded-Encrypted: i=1; AJvYcCXlg43CT4ZWdh1GoeUMbG/otW6Rlkkm6RuK+Dp4Vaddh+rASDcRixcnrxPJFMBwad8sPBnCVhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNGVlvy9WVYXsVlGvkrHjdB9qGe5WT6JoKLpeycWJLzXqHH92K
	hq/LE6J4y24pRGzRwzGb9jbYgt6KnxC4C+iIRLLqqFe4rN7ecxLayFowvQp3jp7ZjHaqpjZ5bXX
	6DBEGsA==
X-Google-Smtp-Source: AGHT+IHYRiMMViMg1TNnHV695x58qWaiVXeMD84tcptS+PCLQZVc/tPkj9IbvIpInrAQ66WeK/Ot31VkHMw=
X-Received: from pjboj12.prod.google.com ([2002:a17:90b:4d8c:b0:33f:e888:4aad])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:35cc:b0:33b:cfac:d5c6
 with SMTP id 98e67ed59e1d1-34733f487f1mr11536198a91.29.1764013469325; Mon, 24
 Nov 2025 11:44:29 -0800 (PST)
Date: Mon, 24 Nov 2025 19:43:34 +0000
In-Reply-To: <20251124194424.86160-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251124194424.86160-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251124194424.86160-3-kuniyu@google.com>
Subject: [PATCH v1 net-next 2/2] selftest: af_unix: Extend recv() timeout in so_peek_off.c.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

so_peek_off.c is reported to be flaky on NIPA:

  # # so_peek_off.c:149:two_chunks_overlap_blocking:Expected -1 (-1) != bytes (-1)
  # # two_chunks_overlap_blocking: Test terminated by assertion
  # #          FAIL  so_peek_off.stream.two_chunks_overlap_blocking

The test fork()s a child process to send() data after 1ms to
wake up the parent process being blocked (up to 3ms) on recv().

But, from the log, the parent woke up after 3ms timeout, so it
could be too short when the host is overloaded.

Let's extend it to 5s.

Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20251124070722.1e828c53@kernel.org/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 tools/testing/selftests/net/af_unix/so_peek_off.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/af_unix/so_peek_off.c b/tools/testing/selftests/net/af_unix/so_peek_off.c
index 1a77728128e5..86e7b0fb522d 100644
--- a/tools/testing/selftests/net/af_unix/so_peek_off.c
+++ b/tools/testing/selftests/net/af_unix/so_peek_off.c
@@ -36,8 +36,8 @@ FIXTURE_VARIANT_ADD(so_peek_off, seqpacket)
 FIXTURE_SETUP(so_peek_off)
 {
 	struct timeval timeout = {
-		.tv_sec = 0,
-		.tv_usec = 3000,
+		.tv_sec = 5,
+		.tv_usec = 0,
 	};
 	int ret;
 
-- 
2.52.0.460.gd25c4c69ec-goog


