Return-Path: <netdev+bounces-241303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E94C82891
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 22:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C1763AC05A
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 21:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B037232E746;
	Mon, 24 Nov 2025 21:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lNlXkVwX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388C732E68D
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764019694; cv=none; b=tUglMeu/R1dH7bkGkdRj2GQV0hnY+VF82VEwd1Vp0kWlw06Ftxzc6t5CftSCNAJq9xNRMi3wkw528v4ykMH5mFXCVv5YNXc7Ai3VA+OirhrQXq5ZW0KlCDRSU3agbpA4vdrZRN5GIMLYX9zPCWauh/szvXD0e3L/9bxN80pnUBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764019694; c=relaxed/simple;
	bh=LBbpFGRx25U3EjboDytduBUqzcGkLL9Zfgq4YEVNSDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FnL4vrlro+BezKRZdI/HTNZf/zg4xgOW8/W/zuk59yPDU4Ysc9GR2BsZKaJaryS5DlNmJ/bceue+NdIJTOs5mVUU2aZKCwYvLBQ1fYGiSxFKh4IekW/ZKLiTmwMfIfBcNyhgmycglK47BRghswz6cvG3GPzrPh1ozCpx0U6DHUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lNlXkVwX; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-297fbfb4e53so73504285ad.1
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 13:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764019692; x=1764624492; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UM/52Ll1lDwXA45TXkg/Z20IxHr9hxPwTnKe9jkP/Qg=;
        b=lNlXkVwXeZrCBHIG5DpZDGqB5I01vk3hqCnlOjnYoCEKYSIivvoJ0Htq23bB8kH890
         NiIK4voCNdYxc53YfNxlQbu0sg+0bmYBhzkgt1YjbYjZnIMyonK+DS8eOYZAD5upMChP
         SInzDTDErOiPFWU3WuDj1AHC+TmCJVZPFQ+ji65tabl3V/LSFd5XkP/zPyQBEUudJqdB
         foei2VkXCaJMZUt3+O+K/dok/3gG44dQd4/b/yAOhv/C5X13uyBDsi2xFzG/iGG7F3bD
         KDfVKFX9BGTeYVsDDaDT74cZsNirg3sPRjv7HYHTLv6ebA9IVRzN1YBogb7Bd6SA1o+w
         I7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764019692; x=1764624492;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UM/52Ll1lDwXA45TXkg/Z20IxHr9hxPwTnKe9jkP/Qg=;
        b=Gd4gxC6shcKFUmFzyowNtjn5PBpYucjg3a5kIcyl5Mk47pK5lfeOT98wt9BAw39UxK
         yoNG/utMtKurVqmutK39nLTTPJMN0A7kvP68t6X8dOBQy4DCMK3fnLw69+myneC2oUrW
         cv7TJvih5eKCxBbKu2ppbF+yrlY3UG0RkxA0bgJGkIUIP2LPVCgDpwPbLMIWjXMsGmjr
         m81gQ4A1C9E8km9NssDVyezjwP8bu+8/dLrUz6ApfBg1zmmx52VyPSlOmtKUaXGJVDwM
         6pJ7Juqqq041BjteN8M+C06ByZA43/QEsdawgeNkbem9kpMCu5/lWmiH8QGta/8qnLta
         kFYA==
X-Forwarded-Encrypted: i=1; AJvYcCWEfdabOImfHhqQfedsVxdnJDhkmBZykN4ZIYVDvPlmpA2pUoKLT3PVDkm49Ofj4zFVcxETDZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzX7MK7MCGo6ID8MzngaaV95l2b06QafdNBrv6sykz8J+vNWMfW
	9N4Be6b6IaMua6REWfYLRbjo81r6XehdlslcpLx2L1JUPbv2e99smPVxaf9HAuZfnqZwAXey6rV
	kMOhNrQ==
X-Google-Smtp-Source: AGHT+IEQu01RJH9TOnSIRypmmMUl63zES2j9oWPnLLzGYTWwrX/ul+yF+uxj5gJ7mdmE7DpjjYYfW527t2g=
X-Received: from plbbb6.prod.google.com ([2002:a17:902:bc86:b0:298:6adf:5ad])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:d491:b0:295:7f3f:b943
 with SMTP id d9443c01a7336-29bab149a85mr3515025ad.28.1764019692456; Mon, 24
 Nov 2025 13:28:12 -0800 (PST)
Date: Mon, 24 Nov 2025 21:26:40 +0000
In-Reply-To: <20251124212805.486235-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251124212805.486235-1-kuniyu@google.com>
X-Mailer: git-send-email 2.52.0.460.gd25c4c69ec-goog
Message-ID: <20251124212805.486235-3-kuniyu@google.com>
Subject: [PATCH v2 net-next 2/2] selftest: af_unix: Extend recv() timeout in so_peek_off.c.
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


