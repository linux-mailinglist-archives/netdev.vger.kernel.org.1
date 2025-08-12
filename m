Return-Path: <netdev+bounces-213059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C7EB23112
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 19:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2138D188DE56
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 17:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739A42FF14C;
	Tue, 12 Aug 2025 17:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IpZc98Qq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C4F2FE59F
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 17:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021540; cv=none; b=GimePulTUigcPNXDeJpPLUX3W3Wf8LnXykVMqK69OEcmrHz8C8Lnsm0VZUqQ+ruv2E6YYcto8regJJNkTWUFYWGlEfBb7HeBIA44LmYPrU87miaMJ5pnds3x0gWKXX6wQj/GKDOL06iSUZNYVgW56AKpccFjzMI+TOYhTor7ZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021540; c=relaxed/simple;
	bh=gUdtY93TVXd8U7THwQpainuRObH4njplELc5maxDEW8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dBXAcj2k+bVI+jVMxnEmHDzOPQy7hWaWMmLygmzPUkBBSFVPm5chYcrSUSlxD4rnN5SXpWUlM9D+bdijtr1vyAEwVfgIi+DaMAQqXZ8vC/2NO0KWHuyBdlPggWD8c25eoUBdaqqAbcpnQQcg6fwE4sgvRv1aD/05bahYbbykww4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IpZc98Qq; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-75e28bcec3bso11059047b3a.1
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 10:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755021538; x=1755626338; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nBs0EYqfbWl9UFV+H52iOxDMUVB4Qqo6amOw5/a/xOY=;
        b=IpZc98QqWiAJSbc2AyHFttQybGnmwYxAJ8c816Ja0ZCwTnBDoOElHfyHHw/zhlRgxi
         RAioMPhPXhhZxYucIItdqtiVtYzKD4oZatX9QnGKoWdzg0pm7/Qj+KyH3aGdAF0Jo2wY
         zWab/BFoxzvMtWL1L+NewL1AW57IvHqH2NS30b++jQs6S1kTcH56xTbmgj6jFVJzkq5U
         F4AuInZFOswXPlqGJeMDDjiXOR4zLrE0RBNWhahTQ63TEjSsRaahePTkH07nm2+5SZdS
         tCXeO6bAZt5INoZGvnpN2YG3l0nL7Nv/rmQ8nws2nojYRLt5gBvL89X9+9j9FvUUA0+I
         e62w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755021538; x=1755626338;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBs0EYqfbWl9UFV+H52iOxDMUVB4Qqo6amOw5/a/xOY=;
        b=keRibq3F45V4hSHKUPcug2FDg/bxQM4MzgL+akQHIJLzNqSA/CzovYtoLxDN/Immzb
         fQr14NB0DjvPixVbbYv9QpBeK0Jhsp4dTQdduaPR5lyEObM8dRg//IjPCu8f+dAiR9Oj
         dkSwjvJ2LsJ7VXSExirsv1ePQRObHqLzBf337DIV2NMNcCCxbg6rPji1cTE2JVJstRHW
         aW/oROGjakXRwPGfZzqvwCAGwdaYCX5HIlmtPgmffihUa2X8Xoblni0D2niFsDeeqrpX
         FrcStaRYWJ5JrlWsYVK/ssMjuK5y8Y9PCNMZJHhmmFwQm6FLIIU/HOK6Y/HWCP+o6oq4
         pm6g==
X-Forwarded-Encrypted: i=1; AJvYcCWT45t3zmOOc5PDyA82uu8xqd9IE8MHFi0UB4bPrY8OJcjXw32MuFi6DL6y0xhNizHbqOaCOdA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCm/tK3zMlaEzErQTaUb6+ZPBE1zNGzXEjsfyAi37WwuL5Xs1s
	iIzISN3eJ0a+KspvvlYhwENfmN6miTRJcNVUeBALEdBcjWF+ldGGAxQZhX/WiYivAnfbcmPFeHg
	64fa6Pw==
X-Google-Smtp-Source: AGHT+IFYsGjbaobi8vNz9wbDh44fnvU9qpjmhcBJj3ep2W5xNnuwjJPdvlexzH+8pKUpV2yp3JlpFVyM3a8=
X-Received: from pfblu20.prod.google.com ([2002:a05:6a00:7494:b0:746:18ec:d11a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:9985:b0:23d:d612:3dfa
 with SMTP id adf61e73a8af0-240a8bc1fe5mr267608637.40.1755021538144; Tue, 12
 Aug 2025 10:58:58 -0700 (PDT)
Date: Tue, 12 Aug 2025 17:58:20 +0000
In-Reply-To: <20250812175848.512446-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250812175848.512446-1-kuniyu@google.com>
X-Mailer: git-send-email 2.51.0.rc0.205.g4a044479a3-goog
Message-ID: <20250812175848.512446-3-kuniyu@google.com>
Subject: [PATCH v3 net-next 02/12] mptcp: Use tcp_under_memory_pressure() in mptcp_epollin_ready().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	"=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>, Tejun Heo <tj@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Geliang Tang <geliang@kernel.org>, 
	Muchun Song <muchun.song@linux.dev>, Mina Almasry <almasrymina@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	mptcp@lists.linux.dev, cgroups@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"

Some conditions used in mptcp_epollin_ready() are the same as
tcp_under_memory_pressure().

We will modify tcp_under_memory_pressure() in the later patch.

Let's use tcp_under_memory_pressure() instead.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 net/mptcp/protocol.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index b15d7fab5c4b..a1787a1344ac 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -788,9 +788,7 @@ static inline bool mptcp_epollin_ready(const struct sock *sk)
 	 * as it can always coalesce them
 	 */
 	return (data_avail >= sk->sk_rcvlowat) ||
-	       (mem_cgroup_sockets_enabled && sk->sk_memcg &&
-		mem_cgroup_under_socket_pressure(sk->sk_memcg)) ||
-	       READ_ONCE(tcp_memory_pressure);
+		tcp_under_memory_pressure(sk);
 }
 
 int mptcp_set_rcvlowat(struct sock *sk, int val);
-- 
2.51.0.rc0.205.g4a044479a3-goog


