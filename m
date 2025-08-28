Return-Path: <netdev+bounces-217710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32950B399E0
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2A5560BF2
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D0930F53A;
	Thu, 28 Aug 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3ep1gVsh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3430F530
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756376866; cv=none; b=CTt5E9MFzzqbY1XvwKp+5jFasuuu3lJ4NqQSAKNxtRQ695jwdOo/d0A5lOkYpbE6wIuOnxodY1oZnvzWVyKrtNhAsurRvZdwN1oehirttS3arzsc3+6KutS6sAhSW57e91pNG3BMx2VRivdijrXj0zqapBnQuUj1ydIh/v9Ft5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756376866; c=relaxed/simple;
	bh=bXlzDvpeDlMUI9VLXEebXVFEgxPcZnWsVc+GW0c9Uv8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MSGZUKy6VWbStevYvqEJrnw1QjNzCDjmPB8trZKbcWKzEr6OnAK0OAiifzhUja+bUe58vXSEYivtnOezS0OopXMFCbRjAIEsvkcXVSwDXNo1PzV7PbA5INLk0OrHJEYDth1PZt2TFnA5dksb+iruH7KMJllNINYurF2tygmSjIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3ep1gVsh; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7fa717ff667so86428785a.3
        for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756376864; x=1756981664; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R0XsmoVrDdx3iw823cv1D2YPWe5y6KMq7UTgP8JgcE0=;
        b=3ep1gVshF3Yq7/0dQiypXtUbbEFJlOgDyb5q8ra+S8SHIvxqW4mdj4ijFpTdZS2wYc
         /iBId0VOjdxEMakVSucbZqUF8AyrumZ8DnGYxhmIrQyzVnTKwu4vKeWX3lLzpKNYdIwh
         FR/Ha/B0aZ0hCg8VoN3IiFh11EdSxOsWGgnbocYRcrD1tLKeKqYhvzGV/oKbE04YVpDA
         PdRHabnuY5BgGf/NbqvvxD2KpNXgixMuICQqVk6Vb8Zwm510JC2g6mtuRGU4WznAqh9W
         rf3A29b42iddAnU8pvsrz3TnED51LKgTuiPFlj43CY9USgwEd3TyK2uZtSDhs0p4+1x3
         /qHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756376864; x=1756981664;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0XsmoVrDdx3iw823cv1D2YPWe5y6KMq7UTgP8JgcE0=;
        b=b4No/nphwF1HlvoRO61IM3LKkOjeLR3C8a/4S9Xteemctz8zTt/yjps74101B7MTRh
         5LU9AHUG/5C0N+p6xZOxPNkzbsNuCQayBGQlDS7vL3vWggC7SGV/Ki2142zheEHaGphL
         MS49P9XVtQyTYGVSPjExygqdptJhFS7a/YApwR+bE4Dqqk3fxO+sC2ksRueWpwNyzPRz
         +KTULjVXnQX/V17ldMO7kzy4UcnJvuXSS/vtK3+Z/gc0iEHupMzXzWHJWE5HEqeIZ6FT
         zBqYCx3dC8wyHBPKGTKEQVM4yEJZ4YEI5Ez1qv2PBJqHms6uy6XLlDitYgG9g9jUWJV6
         y4/A==
X-Forwarded-Encrypted: i=1; AJvYcCW9E11ZWTKuJZQtJAtyuy4VzIpcbR8fm9vOO5OZe1OER7crelfYpAzDz5SjXejgGFPny2WwFh4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyihS0w/oxg2uPXiZ9iakX7JAxqFLoUhSk81qj1qKFkb74vW8e3
	I0CP6ojL/zDYkCGsqdNCEfDOfcEGjgWG3pDbMHZdVNg/v7Wx3KbZrrcKvPBQaUBXq9s32NO8v0r
	YSYKWm8C5mHO5SQ==
X-Google-Smtp-Source: AGHT+IHu83rT5Prm1LNLzE8bwEOBps+XumGiIIfQAYx/cozdpCVtr4oZ+rE2vP94TS8yIzt8ieLWx0jojNOCkw==
X-Received: from qkntz8.prod.google.com ([2002:a05:620a:6908:b0:7e6:2365:6c9c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:700c:b0:7f9:44b0:8072 with SMTP id af79cd13be357-7f944b08764mr400064485a.4.1756376864014;
 Thu, 28 Aug 2025 03:27:44 -0700 (PDT)
Date: Thu, 28 Aug 2025 10:27:35 +0000
In-Reply-To: <20250828102738.2065992-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250828102738.2065992-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.268.g9569e192d0-goog
Message-ID: <20250828102738.2065992-3-edumazet@google.com>
Subject: [PATCH net-next 2/5] tcp: annotate data-races in tcp_req_diag_fill()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

req->num_retrans and rsk_timer.expires are read locklessly,
and can be changed from tcp_rtx_synack().

Add READ_ONCE()/WRITE_ONCE() annotations.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp_diag.c   | 4 ++--
 net/ipv4/tcp_output.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_diag.c b/net/ipv4/tcp_diag.c
index 2f3a779ce7a2da7d59c6a471c155c3e6d1563acd..4ed6b93527f4ad00f34cc732639c0c82d0feff08 100644
--- a/net/ipv4/tcp_diag.c
+++ b/net/ipv4/tcp_diag.c
@@ -248,12 +248,12 @@ static int tcp_req_diag_fill(struct sock *sk, struct sk_buff *skb,
 	inet_diag_msg_common_fill(r, sk);
 	r->idiag_state = TCP_SYN_RECV;
 	r->idiag_timer = 1;
-	r->idiag_retrans = reqsk->num_retrans;
+	r->idiag_retrans = READ_ONCE(reqsk->num_retrans);
 
 	BUILD_BUG_ON(offsetof(struct inet_request_sock, ir_cookie) !=
 		     offsetof(struct sock, sk_cookie));
 
-	tmo = inet_reqsk(sk)->rsk_timer.expires - jiffies;
+	tmo = READ_ONCE(inet_reqsk(sk)->rsk_timer.expires) - jiffies;
 	r->idiag_expires = jiffies_delta_to_msecs(tmo);
 	r->idiag_rqueue	= 0;
 	r->idiag_wqueue	= 0;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 06b26a6efd628e85f97bdb7253c344565b0ed56d..e180364b8ddad4baa9978418ffd9c8b871342cb9 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -4438,7 +4438,7 @@ int tcp_rtx_synack(const struct sock *sk, struct request_sock *req)
 			tcp_sk_rw(sk)->total_retrans++;
 		}
 		trace_tcp_retransmit_synack(sk, req);
-		req->num_retrans++;
+		WRITE_ONCE(req->num_retrans, req->num_retrans + 1);
 	}
 	return res;
 }
-- 
2.51.0.268.g9569e192d0-goog


